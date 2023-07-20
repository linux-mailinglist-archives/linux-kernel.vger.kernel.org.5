Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B262A75A81D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 09:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjGTHrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 03:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGTHrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:47:35 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3552122
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 00:47:32 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-668711086f4so358053b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 00:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689839251; x=1690444051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x57XYhU3kN/IVUYoEulD/81klEAIktkHi596Zb0HL4w=;
        b=Dp+qHW/nR6UCyhAZiGmDV/jQFfcnch4ZFcmudCUX1GQQipGCSa3yHQRF9+bDdLBOpR
         lnGq/jOwqQ5etszI0WueigyK937e3TjBX+9CNEMs/ffg5YH463p4JtnpJwEATwVAtxOz
         4ZhiSFw3R3//gXJvwcYzHrjiU4ntZVia03/nY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689839251; x=1690444051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x57XYhU3kN/IVUYoEulD/81klEAIktkHi596Zb0HL4w=;
        b=US1UWcc7CDeE0pc/uc0acbEXSK33WbjRjUHjVTtHvpxb/g3pv2Jd6uQcPj4KKK7uaD
         RR54WlHYpH43YblTjN4hO4fzPqUC2luVVm+Kf4TMaFlxzZdBYj1wEkVICGAx6kMUaYqD
         vYpyIHV5rYc3f+RBuAGZ7CR3JwFG/aEZemyhBCCj4N3/zINQI/EApfjgpBKzdjEw8C8r
         Eke73gOVoC37z3aqexgjoGh0xVHLeWvMooqulGQ9WAx9qY5I8CYzE47zcBBCVXSFrQHB
         jfclWE0guTREUpfGKZ5JEnI3f0MO6yva4Ek1Jnw7UI+WKZCXR0wX5M4k2XISj/a4GA08
         EMhA==
X-Gm-Message-State: ABy/qLb2Wf/Oy1YCIZc9BFPk+zB3eFFUpxLHOrNwkiHr1iXFvDiZwE7k
        dhuRwNDX9Mb3WkW2CsQWz0EAhA==
X-Google-Smtp-Source: APBJJlHEeCR/suWmud/i2PuYaTRpd4qLu3qy+qEXnULQ8doYLNXChb7SNJEq/Gsdf1q9XrGYY1uxWg==
X-Received: by 2002:a05:6a20:3943:b0:12f:d350:8a12 with SMTP id r3-20020a056a20394300b0012fd3508a12mr6583141pzg.21.1689839251288;
        Thu, 20 Jul 2023 00:47:31 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:648f:4ec7:23d9:d855])
        by smtp.gmail.com with ESMTPSA id n5-20020a62e505000000b0065da94fe921sm511229pff.50.2023.07.20.00.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 00:47:30 -0700 (PDT)
Date:   Thu, 20 Jul 2023 16:47:26 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [RFC PATCH v2 01/21] mm/zsmalloc: create new struct zsdesc
Message-ID: <20230720074726.GF955071@google.com>
References: <20230713042037.980211-1-42.hyeyoo@gmail.com>
 <20230713042037.980211-2-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713042037.980211-2-42.hyeyoo@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/07/13 13:20), Hyeonggon Yoo wrote:
>  /*
> @@ -264,6 +247,52 @@ struct mapping_area {
>  	enum zs_mapmode vm_mm; /* mapping mode */
>  };
>  

struct zspage already has a zsdesc member at this point, so I'd prefer
to move struct zsdesc definition before struct zspage.

> +/*
> + * struct zsdesc - memory descriptor for zsmalloc memory
> + *
> + * This struct overlays struct page for now. Do not modify without a
> + * good understanding of the issues.
> + *
> + * Usage of struct page flags on zsdesc:
> + *	PG_private: identifies the first component zsdesc
> + */
> +struct zsdesc {
> +	unsigned long flags;
> +
> +	/*
> +	 * Although not used by zsmalloc, this field is used by non-LRU page migration
> +	 * code. Leave it unused.
> +	 */
> +	struct list_head lru;
> +
> +	/* Always points to zsmalloc_mops with PAGE_MAPPING_MOVABLE set */
> +	struct movable_operations *mops;
> +
> +	union {
> +		/* linked list of all zsdescs in a zspage */
> +		struct zsdesc *next;
> +		/* for huge zspages */
> +		unsigned long handle;
> +	};
> +	struct zspage *zspage;
> +	unsigned int first_obj_offset;
> +	unsigned int _refcount;
> +};
> +
> +#define ZSDESC_MATCH(pg, zs) \
> +	static_assert(offsetof(struct page, pg) == offsetof(struct zsdesc, zs))
> +
> +ZSDESC_MATCH(flags, flags);
> +ZSDESC_MATCH(lru, lru);
> +ZSDESC_MATCH(mapping, mops);
> +ZSDESC_MATCH(index, next);
> +ZSDESC_MATCH(index, handle);
> +ZSDESC_MATCH(private, zspage);
> +ZSDESC_MATCH(page_type, first_obj_offset);
> +ZSDESC_MATCH(_refcount, _refcount);
> +#undef ZSDESC_MATCH
> +static_assert(sizeof(struct zsdesc) <= sizeof(struct page));
> +
>  /* huge object: pages_per_zspage == 1 && maxobj_per_zspage == 1 */
>  static void SetZsHugePage(struct zspage *zspage)
>  {
> -- 
> 2.41.0
> 

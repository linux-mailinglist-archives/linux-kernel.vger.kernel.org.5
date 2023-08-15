Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4527377D36F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 21:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239930AbjHOTic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 15:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239906AbjHOTiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 15:38:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9504CE3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 12:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692128256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4fz+6Me7clA1JL7z++8j9kYvOqyyaBNrhSmXYZ4wwQs=;
        b=H/+JxQYbtfpQ1uRXEnJhcvibK/JYhSQcoTcKsibYTQZwY+pejpAFr6SMyATZywjGW6cW1P
        c3yiQkKAavSGQkITNEdOv4pMXJkwmYpHEsSzKUWnIX5A6HuCQxlCcop1oim40J+H9XNl7O
        xCvWu9Zr4TFn8sE0voBb4h2n7YftMks=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-QFQxeQLaN06nPOIExflVxg-1; Tue, 15 Aug 2023 15:37:35 -0400
X-MC-Unique: QFQxeQLaN06nPOIExflVxg-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3a74dd0d560so1258121b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 12:37:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692128254; x=1692733054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4fz+6Me7clA1JL7z++8j9kYvOqyyaBNrhSmXYZ4wwQs=;
        b=L3dMRrSxcUK7wiG2olfbgecffCUCIP8XVk/hZFOsGkEo9vmwHazD0vdva+bz+slXcS
         9Q6TvHLCtSpm4TiYd0Lnghr6RIOcTtRNOkMGgaKtmanYdLRtC9rEN1ztUiCozGLBfWlJ
         zouy2rBO2ZOpANCxHU82bMJhjQfm5U5YTdk7QqnXy+YZgTDw3qspTDnsPsum3LvC0Yys
         6YmMtm2GyI85q+XSHX8sLL+McCzgRyhPyBSvhob26RPVJarHHwHnbwyQgxfJrWHOKLxV
         PhUMcWwcorAGtdWRhhkvWh3hDjbaip8lV88cFTHistEU2T9oUOVq/zn8sTwHLSphKJlN
         /yeg==
X-Gm-Message-State: AOJu0Ywet3PveyJcZLY9yG+3v6NGlDwcpamkhWcuohcbVdFi+8KB3H2m
        ScjGpbAsRsdgfEM8hi6OHxxD9ZfyQq93ZB5TclC04OlYSnA4QpAanjloFuojgTiVQ/SzBdsVa8g
        YFbuQ4FMZhB/DfwO4CMSdk6w76GQgvjul
X-Received: by 2002:a05:6808:17a6:b0:3a7:82e8:8fed with SMTP id bg38-20020a05680817a600b003a782e88fedmr13516259oib.1.1692128254692;
        Tue, 15 Aug 2023 12:37:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqBaNfXqzNmrGPWBR7QC9dKJXMnxeKT5YSYM81wzDBJfFq878CwVagZlkA2kk6PaRIxCBkvw==
X-Received: by 2002:a05:6808:17a6:b0:3a7:82e8:8fed with SMTP id bg38-20020a05680817a600b003a782e88fedmr13516241oib.1.1692128254457;
        Tue, 15 Aug 2023 12:37:34 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id a10-20020a0ce38a000000b00623839cba8csm4350840qvl.44.2023.08.15.12.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 12:37:34 -0700 (PDT)
Date:   Tue, 15 Aug 2023 15:37:21 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH RFC v2 0/3] mm: Properly document tail pages for a folio
Message-ID: <ZNvT8aFemCdtTpBo@x1n>
References: <20230814184411.330496-1-peterx@redhat.com>
 <ZNqHdIi8ySqwoswd@casper.infradead.org>
 <ZNqM43Y9Pa1S8N7D@x1n>
 <ZNr08E5bublfQI0J@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZNr08E5bublfQI0J@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 04:45:52AM +0100, Matthew Wilcox wrote:
> I always forget about THP_SWAP using tail->private.  That actually needs
> to be asserted by the compiler, not just documented.  Something along
> these lines.
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 659c7b84726c..3880b3f2e321 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -340,8 +340,11 @@ struct folio {
>  			atomic_t _pincount;
>  #ifdef CONFIG_64BIT
>  			unsigned int _folio_nr_pages;
> -#endif
> +			/* 4 byte gap here */
>  	/* private: the union with struct page is transitional */
> +			/* Fix THP_SWAP to not use tail->private */
> +			unsigned long _private_1;
> +#endif
>  		};
>  		struct page __page_1;
>  	};
> @@ -362,6 +365,9 @@ struct folio {
>  	/* public: */
>  			struct list_head _deferred_list;
>  	/* private: the union with struct page is transitional */
> +			unsigned long _avail_2a;
> +			/* Fix THP_SWAP to not use tail->private */
> +			unsigned long _private_2a;
>  		};
>  		struct page __page_2;
>  	};
> @@ -386,12 +392,18 @@ FOLIO_MATCH(memcg_data, memcg_data);
>  			offsetof(struct page, pg) + sizeof(struct page))
>  FOLIO_MATCH(flags, _flags_1);
>  FOLIO_MATCH(compound_head, _head_1);
> +#ifdef CONFIG_64BIT
> +FOLIO_MATCH(private, _private_1);
> +#endif
>  #undef FOLIO_MATCH
>  #define FOLIO_MATCH(pg, fl)						\
>  	static_assert(offsetof(struct folio, fl) ==			\
>  			offsetof(struct page, pg) + 2 * sizeof(struct page))
>  FOLIO_MATCH(flags, _flags_2);
>  FOLIO_MATCH(compound_head, _head_2);
> +FOLIO_MATCH(flags, _flags_2a);
> +FOLIO_MATCH(compound_head, _head_2a);
> +FOLIO_MATCH(private, _private_2a);
>  #undef FOLIO_MATCH
>  
>  /*
> 
> This is against the patchset I just posted which frees up a word in the
> first tail page.

Okay, I assume you meant to suggest leverage FOLIO_MATCH(), which I can
definitely try.  But then I'd hope it covers not only private field but all
the fields that the tail pages reuses; the goal is to document everything
no matter in what form.  I'll see what I can get..  Thanks.

-- 
Peter Xu


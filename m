Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD210780DBF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 16:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377674AbjHRONH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 10:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377661AbjHROMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 10:12:55 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E53170E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 07:12:53 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3a3efebcc24so668956b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 07:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1692367972; x=1692972772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BYbkuGWphKck53qhRSBFRHDgKey55imRkhHrLlN3Ku4=;
        b=ygscda0SW+DoI+xM1m+X6QVMZ/+48fNkg7e0BRDfdfImdu4JFmDY4BlU13bvWPz/Ln
         ol79wApAEOabboJA/jpajAN/GZQwdD/qjBEcFYVt2wDsTo8WxExhHLZvJOuge4GFg39m
         c67fBh4KCaMkZNwdber8FH60yLWAomgkRTf8Z7jzh4QXyg9iLA5A2oY9GoW6+I4nkxyT
         tuLjtVxdWCfqvFqDHn9Bz/9hLg0nptMwc67/KWKwxgMEbMhFssTgkvgEVTw05zeFQHoc
         UvMS79ntR9HqvKtXhzW7SlDVYK4fUCGUbPhIRiQNDajG3crsk5j/webmaBRmeX+6GgHV
         ncrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692367972; x=1692972772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BYbkuGWphKck53qhRSBFRHDgKey55imRkhHrLlN3Ku4=;
        b=kayCCCW1ktoKJ9cNlpylwDN9Zfj9TRhXaf1qLTf535pILyR5ebqdEgt/FOchFwB6/j
         m9apd/E+lnE1wM/OOhd6CHZE01niA2zEPMzFnCGZk5I8URDzp1/HFjLwUoRrJb7K6kh0
         2F8QttW+Y0YlPujuY7Ywp7K+RJDpDziw4KXr9X89ZeMFEWhfwVeKZmjdzr5dRq1/qPbO
         nJW4L7oO7Xi2oU5+ddMxY6cUVqa//gUhA3es7ZCgsB2M50CJvvLJXLsaqgRYhYn08JLu
         Jx3/c5UO1TNz+BX8ZGnm0zKR5XoSlWeIL3RbxzNz+v+6kI7zuYaJnJ8PBcHXmGwG51Mh
         rDSQ==
X-Gm-Message-State: AOJu0YzF0ck7foa5KTfswt5BH8vn9mbuYzAUD9Q+xzbHw0KOuYRQ6BIi
        fea5ii/beFu40CpIgzsUgL6anw==
X-Google-Smtp-Source: AGHT+IFhNH1W2ZLadujTkNccDtvX2b8TuH+H5bk+QLsoKGMdGEtgAoq4ItoEzN5ZlbCt7QVgOQ/N9A==
X-Received: by 2002:a05:6808:220d:b0:3a7:4889:79fe with SMTP id bd13-20020a056808220d00b003a7488979femr3920845oib.20.1692367972393;
        Fri, 18 Aug 2023 07:12:52 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:75e0])
        by smtp.gmail.com with ESMTPSA id c15-20020a0ca9cf000000b00637abbfaac9sm706117qvb.98.2023.08.18.07.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 07:12:51 -0700 (PDT)
Date:   Fri, 18 Aug 2023 10:12:51 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, kernel-team@meta.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, yosryahmed@google.com,
        Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v2] workingset: ensure memcg is valid for recency check
Message-ID: <20230818141251.GB138967@cmpxchg.org>
References: <20230817164733.2475092-1-nphamcs@gmail.com>
 <20230817190126.3155299-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817190126.3155299-1-nphamcs@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 12:01:26PM -0700, Nhat Pham wrote:
>  static bool lru_gen_test_recent(void *shadow, bool file, struct lruvec **lruvec,
>  				unsigned long *token, bool *workingset)
>  {
> -	int memcg_id;
>  	unsigned long min_seq;
>  	struct mem_cgroup *memcg;
>  	struct pglist_data *pgdat;
>  
> -	unpack_shadow(shadow, &memcg_id, &pgdat, token, workingset);
> +	unpack_shadow(shadow, &memcg, &pgdat, token, workingset);
> +	if (!mem_cgroup_disabled() && !memcg)
> +		return false;
>  
> -	memcg = mem_cgroup_from_id(memcg_id);
>  	*lruvec = mem_cgroup_lruvec(memcg, pgdat);
> +	mem_cgroup_put(memcg);
>  
>  	min_seq = READ_ONCE((*lruvec)->lrugen.min_seq[file]);
>  	return (*token >> LRU_REFS_WIDTH) == (min_seq & (EVICTION_MASK >> LRU_REFS_WIDTH));

This isn't quite right. lruvec's lifetime is bound to the memcg, so
the put has to happen after the code is done accessing it.

lru_gen_refault() is still using the eviction lruvec after the recency
test - but only if eviction_lruvec == refault_lruvec. This gives me
pause, because they're frequently different. This is a common setup:

root - slice - service 1
            `- service 2

where slice has the limit and will be the cause of evictions, whereas
the service groups have the actual pages and see the refaults.

workingset_eviction() and workingset_refault() will do recency
evaluation against slice, and refault accounting against service X.

MGLRU will use service X to determine recency, which 1) will not
properly activate when one service is thrashing while the other is
dominating the memory allowance of slice, and 2) will not detect
refaults of pages shared between the services.

Maybe it's time to fix this first and bring the two codebases in
unison. Then the recency test and eviction group lifetime can be
encapsulated in test_recent(), and _refault() can just use
folio_memcg() to do the activation and accounting against.

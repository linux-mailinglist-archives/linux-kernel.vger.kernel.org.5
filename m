Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F01E7D0769
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 06:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbjJTEss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 00:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjJTEsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 00:48:47 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AC1B0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 21:48:45 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a8ee23f043so4154717b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 21:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697777324; x=1698382124; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MuXc7Q2Jk4MNdQDQDTBuYE9+U+hZgbTmv6xP9Jj7WR4=;
        b=0bKLJLFzM549vqU+pnwPGuJAe7MKR+UUh1MUMtQgyefoEicld7TXQJvT5cvpKLtyUV
         40BuK7PYNYntg7Kf4IXdUF24artX+4wTEhNsVASR+8d2Nwl1tJfPSyCrrNnHD5jswM+s
         C0aEaapQSaidk8BoKujpEqzPJ7RyrD3FQWOgecEE+GAN3je1hXJHqW5psa3d4yyk0ixS
         0gUwl1b8VFWZrsw89yBPWixp1jYO0e6OEd89VWz8fHFZNJ2u3GPuT8TwmAHOANiM7r/p
         nbguh0Y+Hr/IaichvSwZs8fjCm6csEA1w9GH9DIeLlG3PJGNv9PzKAquRk6jDMpfvQhF
         A/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697777324; x=1698382124;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MuXc7Q2Jk4MNdQDQDTBuYE9+U+hZgbTmv6xP9Jj7WR4=;
        b=FVAAz21alGfLbmlK6oZOSVMLHxYJqT7Wy4e6fNhqvfy+hs5uG1You76mus5t9KfKvM
         KCenvnXONsd0R9zD9Ka+AFqx2b+OarRkkIncq51Ww80p55zhJN0oTITZzLKSBi7X9CYv
         eP12hqej96Gt7q30QG02wwAWyyraRHqBaN1ivkT4V05WeAaEWKlrqZOGUG9DpaD2BwVy
         8AlXoeVBGSVpj4JAIEBr+qHL2wNllc5nBYMaQcSN91o3wymGyiYwK2KiIuj1cEnRDFIK
         9UL5Z6ivPta71nKIwg9uvrUoIr4dN8xfV023cjy2sGexHf9pxWcVEdVeGUulS7iTCTLY
         +f+g==
X-Gm-Message-State: AOJu0YyZaqARuD7tk+6/CnleYyjdd5yrbHsMligG1CGEUM63n7nzUQQa
        9+w4ZqFgFQSORW987auu/K7LeQ==
X-Google-Smtp-Source: AGHT+IGMrFhifeFApRSzmFsxrFUtbTf5MSdzrLHSQeV80jPchA1ZgiSdLi9vV2A+G2Sl/AxTQrWwAw==
X-Received: by 2002:a05:690c:10c:b0:5a7:c1f1:24b with SMTP id bd12-20020a05690c010c00b005a7c1f1024bmr839645ywb.22.1697777324220;
        Thu, 19 Oct 2023 21:48:44 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id n8-20020a817208000000b005925c896bc3sm416914ywc.53.2023.10.19.21.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 21:48:43 -0700 (PDT)
Date:   Thu, 19 Oct 2023 21:48:32 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        hughd@google.com, vbabka@suse.cz, ying.huang@intel.com,
        ziy@nvidia.com, fengwei.yin@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: migrate: record the mlocked page status to remove
 unnecessary lru drain
In-Reply-To: <c960df0db27ae55b9e9babdcfe842e75fb44ccbc.1697703785.git.baolin.wang@linux.alibaba.com>
Message-ID: <163ce2c0-9c8a-3db3-26a7-4d115fb95802@google.com>
References: <c960df0db27ae55b9e9babdcfe842e75fb44ccbc.1697703785.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2023, Baolin Wang wrote:

> When doing compaction, I found the lru_add_drain() is an obvious hotspot
> when migrating pages. The distribution of this hotspot is as follows:
>    - 18.75% compact_zone
>       - 17.39% migrate_pages
>          - 13.79% migrate_pages_batch
>             - 11.66% migrate_folio_move
>                - 7.02% lru_add_drain
>                   + 7.02% lru_add_drain_cpu
>                + 3.00% move_to_new_folio
>                  1.23% rmap_walk
>             + 1.92% migrate_folio_unmap
>          + 3.20% migrate_pages_sync
>       + 0.90% isolate_migratepages
> 
> The lru_add_drain() was added by commit c3096e6782b7 ("mm/migrate:
> __unmap_and_move() push good newpage to LRU") to drain the newpage to LRU
> immediately, to help to build up the correct newpage->mlock_count in
> remove_migration_ptes() for mlocked pages. However, if there are no mlocked
> pages are migrating, then we can avoid this lru drain operation, especailly
> for the heavy concurrent scenarios.
> 
> So we can record the source pages' mlocked status in migrate_folio_unmap(),
> and only drain the lru list when the mlocked status is set in migrate_folio_move().
> In addition, the page was already isolated from lru when migrating, so checking
> the mlocked status is stable by folio_test_mlocked() in migrate_folio_unmap().
> 
> After this patch, I can see the hotpot of the lru_add_drain() is gone:
>    - 9.41% migrate_pages_batch
>       - 6.15% migrate_folio_move
>          - 3.64% move_to_new_folio
>             + 1.80% migrate_folio_extra
>             + 1.70% buffer_migrate_folio
>          + 1.41% rmap_walk
>          + 0.62% folio_add_lru
>       + 3.07% migrate_folio_unmap
> 
> Meanwhile, the compaction latency shows some improvements when running
> thpscale:
>                             base                   patched
> Amean     fault-both-1      1131.22 (   0.00%)     1112.55 *   1.65%*
> Amean     fault-both-3      2489.75 (   0.00%)     2324.15 *   6.65%*
> Amean     fault-both-5      3257.37 (   0.00%)     3183.18 *   2.28%*
> Amean     fault-both-7      4257.99 (   0.00%)     4079.04 *   4.20%*
> Amean     fault-both-12     6614.02 (   0.00%)     6075.60 *   8.14%*
> Amean     fault-both-18    10607.78 (   0.00%)     8978.86 *  15.36%*
> Amean     fault-both-24    14911.65 (   0.00%)    11619.55 *  22.08%*
> Amean     fault-both-30    14954.67 (   0.00%)    14925.66 *   0.19%*
> Amean     fault-both-32    16654.87 (   0.00%)    15580.31 *   6.45%*
> 

Seems a sensible change with good results (I'll conceal how little of
the stats I understand, I expect everyone else understands them: in my
naivety, I'm mainly curious why rmap_walk's 1.23% didn't get a + on it).

> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
> Chages from v1:
>  - Use separate flags in __migrate_folio_record() to avoid to pack flags
> in each call site per Ying.
> ---
>  mm/migrate.c | 47 +++++++++++++++++++++++++++++++++++------------
>  1 file changed, 35 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 125194f5af0f..fac96139dbba 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1027,22 +1027,39 @@ union migration_ptr {
>  	struct anon_vma *anon_vma;
>  	struct address_space *mapping;
>  };
> +
> +enum {
> +	PAGE_WAS_MAPPED = 1 << 0,
> +	PAGE_WAS_MLOCKED = 1 << 1,
> +};
> +

I was whispering to myself "I bet someone will suggest BIT()";
and indeed that someone has turned out to be Huang, Ying.

>  static void __migrate_folio_record(struct folio *dst,
> -				   unsigned long page_was_mapped,
> +				   unsigned int page_was_mapped,
> +				   unsigned int page_was_mlocked,
>  				   struct anon_vma *anon_vma)
>  {
>  	union migration_ptr ptr = { .anon_vma = anon_vma };
> +	unsigned long page_flags = 0;

Huang, Ying preferred a different name, me too: old_page_state?

> +
> +	if (page_was_mapped)
> +		page_flags |= PAGE_WAS_MAPPED;
> +	if (page_was_mlocked)
> +		page_flags |= PAGE_WAS_MLOCKED;

What's annoying me about the patch is all this mix of page_was_mapped and
page_was_mlocked variables, then the old_page_state bits.  Can't it be
done with PAGE_WAS_ bits in old_page_state throughout, without any
page_was_mapped and page_was_mlocked variables?

Hugh

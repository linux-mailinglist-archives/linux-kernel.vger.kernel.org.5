Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F6779B6A3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349557AbjIKVdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242620AbjIKP5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:57:35 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530831AE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:57:30 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-41479b9b4f1so32406901cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1694447849; x=1695052649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1zJewVgK4Q88dH7D9uHefrBaaN5ObYhd5seyknIRoWE=;
        b=13pNOlXKcseVGTibSn1eaweMoeOjlCOZnBzQn7PnAJscl+FoOaQUMyDbUXEIF7dK5i
         r0NCtIvLQZARleUH3cJAGHgP6kWlS4nNeXOjjHdxM8pOIx7qbSlqvw53wiJiYBG6Lukv
         MABOsb+Vx4P4TZut8luNO2AM+TSglXJoeeYEFWyST9FpLQR4JaDXuLCtq0feFD0/K8PB
         XMzq80vxQ9yjbpL6V8J8TqPO0SmNpjW/Rr2N6xxKpY+8jz2VqHTnVTDPkBh2wCSb0o7u
         vVc3Yz5FZoZhCsvwcH/bxmmh16dFaKSu65PMRL2TjGJ7VGifAN2o38yRXogQyl8GUrAB
         QPIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694447849; x=1695052649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1zJewVgK4Q88dH7D9uHefrBaaN5ObYhd5seyknIRoWE=;
        b=BpEWG+U37m4QpCEQjrZORhqNh/CiBaWJhykKwyZNwxWnHRNuy+bUVV4r5S52ab/9AW
         SFgacmONAGrWYFnDtcgM/FZAKbiOjKFoqLtSlNd/D0Zx4SssMN4dBTAUEIvM0it3lJuh
         S0MEFKTkmd/QPhVsWiil93l4NxnLa/Dy2CrzvU9DMv0r18/MvcAP7egc94NQrRTFqitU
         mYleWzQl5VlbaqKyiufaxkyn67eZ4qC+MpAbQZissZiLy35kU9yVdGT75y5Ra+m7KeSz
         vhNCHt+Ri1RGJHZ4QbPpI+sNyaYPt7Ofb7a+KJrjFNKAY92Pj1oNEf64mEAhS1GbkC2n
         Tlrw==
X-Gm-Message-State: AOJu0YyPQdUw0+mek80Jox3xbYniuAWXvgkl5y/LjbKNI3sawo9jP5/U
        C0DH8jYXsLGnHbNfMHikERTARA==
X-Google-Smtp-Source: AGHT+IH4gDeOyRQdXdjMFhQ2fneyWyjSA4r8Q4JRSJab2ZEdDVWDWGL4Ljnm6GKqFufO97u1r8SMCg==
X-Received: by 2002:a0c:f0d3:0:b0:655:e12d:d42d with SMTP id d19-20020a0cf0d3000000b00655e12dd42dmr5094050qvl.28.1694447849209;
        Mon, 11 Sep 2023 08:57:29 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-3012-16a2-6bc2-2937.res6.spectrum.com. [2603:7000:c01:2716:3012:16a2:6bc2:2937])
        by smtp.gmail.com with ESMTPSA id u19-20020a0cdd13000000b006485e76574csm2999934qvk.78.2023.09.11.08.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 08:57:28 -0700 (PDT)
Date:   Mon, 11 Sep 2023 11:57:27 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Lecopzer Chen <lecopzer.chen@mediatek.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz, nsaenzju@redhat.com,
        yj.chiang@mediatek.com, Mark-pk Tsai <mark-pk.tsai@mediatek.com>,
        Joe Liu <joe.liu@mediatek.com>
Subject: Re: [PATCH] mm: page_alloc: fix cma pageblock was stolen in rmqueue
 fallback
Message-ID: <20230911155727.GA102237@cmpxchg.org>
References: <20230830111332.7599-1-lecopzer.chen@mediatek.com>
 <20230905090922.zy7srh33rg5c3zao@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905090922.zy7srh33rg5c3zao@techsingularity.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 10:09:22AM +0100, Mel Gorman wrote:
> mm: page_alloc: Free pages to correct buddy list after PCP lock contention
> 
> Commit 4b23a68f9536 ("mm/page_alloc: protect PCP lists with a spinlock")
> returns pages to the buddy list on PCP lock contention. However, for
> migratetypes that are not MIGRATE_PCPTYPES, the migratetype may have
> been clobbered already for pages that are not being isolated. In
> practice, this means that CMA pages may be returned to the wrong
> buddy list. While this might be harmless in some cases as it is
> MIGRATE_MOVABLE, the pageblock could be reassigned in rmqueue_fallback
> and prevent a future CMA allocation. Lookup the PCP migratetype
> against unconditionally if the PCP lock is contended.
> 
> [lecopzer.chen@mediatek.com: CMA-specific fix]
> Fixes: 4b23a68f9536 ("mm/page_alloc: protect PCP lists with a spinlock")
> Reported-by: Joe Liu <joe.liu@mediatek.com>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  mm/page_alloc.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 452459836b71..4053c377fee8 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2428,7 +2428,13 @@ void free_unref_page(struct page *page, unsigned int order)
>  		free_unref_page_commit(zone, pcp, page, migratetype, order);
>  		pcp_spin_unlock(pcp);
>  	} else {
> -		free_one_page(zone, page, pfn, order, migratetype, FPI_NONE);
> +		/*
> +		 * The page migratetype may have been clobbered for types
> +		 * (type >= MIGRATE_PCPTYPES && !is_migrate_isolate) so
> +		 * must be rechecked.
> +		 */
> +		free_one_page(zone, page, pfn, order,
> +			      get_pcppage_migratetype(page), FPI_NONE);
>  	}
>  	pcp_trylock_finish(UP_flags);
>  }
> 

I had sent a (similar) fix for this here:

https://lore.kernel.org/lkml/20230821183733.106619-4-hannes@cmpxchg.org/

The context wasn't CMA, but HIGHATOMIC pages going to the movable
freelist. But the class of bug is the same: the migratetype tweaking
really only applies to the pcplist, not the buddy slowpath; I added a
local pcpmigratetype to make it more clear, and hopefully prevent bugs
of this nature down the line.

I'm just preparing v2 of the above series. Do you want me to break
this change out and send it separately?

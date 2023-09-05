Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5487925F2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346743AbjIEQV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354033AbjIEJXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 05:23:00 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91803E9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 02:22:50 -0700 (PDT)
X-UUID: c3a43efa4bcd11eea33bb35ae8d461a2-20230905
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=FkwHJ0Fq/ICSSUGGzXWyo4WE1Zcc8h+AuqS/BMVuwzY=;
        b=mMW6Ef/Z/DiQ2kFLsvoJ/FwtRg/sg1qEaRF64bwfObOxGkCOleC2RSZHTHmClu2ffxgD6tHBB21WMhSppYGpdMFkYpsY8ZGNdNwyJFWmAk50yjh7dhl0VVzx/ncTOmDcTn2s5q9lGf5Vv+6rBQRD13uVAZGMkRFEcJTwWI/HzTE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:43586146-a8e1-492c-a161-fd692e7df752,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:49fc2220-33fd-4aaa-bb43-d3fd68d9d5ae,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c3a43efa4bcd11eea33bb35ae8d461a2-20230905
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 556578256; Tue, 05 Sep 2023 17:22:41 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 5 Sep 2023 17:22:40 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 5 Sep 2023 17:22:40 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <mgorman@techsingularity.net>
CC:     <akpm@linux-foundation.org>, <joe.liu@mediatek.com>,
        <lecopzer.chen@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <mark-pk.tsai@mediatek.com>,
        <nsaenzju@redhat.com>, <vbabka@suse.cz>, <yj.chiang@mediatek.com>
Subject: Re: [PATCH] mm: page_alloc: fix cma pageblock was stolen in rmqueue fallback
Date:   Tue, 5 Sep 2023 17:22:40 +0800
Message-ID: <20230905092240.19132-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230905090922.zy7srh33rg5c3zao@techsingularity.net>
References: <20230905090922.zy7srh33rg5c3zao@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Mel,

Of course, because we only test for CMA and only make sure that
CMA part is wrong.
You patch is definitly better.
Please go ahead with your patch, thank you.

> On Wed, Aug 30, 2023 at 07:13:33PM +0800, Lecopzer Chen wrote:
> > commit 4b23a68f9536 ("mm/page_alloc: protect PCP lists with a
> > spinlock") fallback freeing page to free_one_page() if pcp trylock
> > failed. This make MIGRATE_CMA be able to fallback and be stolen
> > whole pageblock by MIGRATE_UNMOVABLE in the page allocation.
> > 
> > PCP free is fine because free_pcppages_bulk() will always get
> > migratetype again before freeing the page, thus this only happen when
> > someone tried to put CMA page in to other MIGRATE_TYPE's freelist.
> > 
> > Fixes: 4b23a68f9536 ("mm/page_alloc: protect PCP lists with a spinlock")
> > Reported-by: Joe Liu <joe.liu@mediatek.com>
> > Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> > Cc: Mark-pk Tsai <mark-pk.tsai@mediatek.com>
> > Cc: Joe Liu <joe.liu@mediatek.com>
> 
> Sorry for the long delay and thanks Lecopzer for the patch.
> 
> This changelog is difficult to parse but the fix may also me too specific
> and could be more robust against types other than CMA. It is true that
> a failed PCP acquire may return a !is_migrate_isolate page to the wrong
> list but it's more straight-forward to unconditionally lookup the PCP
> migratetype of the spinlock is not acquired.
> 
> How about this? It unconditionally looks up the PCP migratetype after
> spinlock contention. It's build tested only
> 
> --8<--
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

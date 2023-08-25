Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A754788124
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 09:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236086AbjHYHnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 03:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbjHYHmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 03:42:45 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BABE6A;
        Fri, 25 Aug 2023 00:42:36 -0700 (PDT)
X-UUID: f359327e431a11ee9cb5633481061a41-20230825
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=sU4/V6ndA5R7lvrGvDLIjLvlK6dyYIJGN/XjomZsBm8=;
        b=iHuxotYZaEKndvPVIOALXBfrOPCiYKuNU6N57Arg9zeoYavBHe1jq8d8AGZAxw4/eAYmlYlxk/BbhMslgQawjTfJwQesBN8H3MWMne+hsvwn+5+IDv3HWltCSEXRiGXoGRt0Fum3HQ1tUKJO+6IO94tQbEYebgEijJfLsgMzIgg=;
X-CID-CACHE: Type:Local,Time:202308251510+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:910c819d-5461-4904-ac5e-b6d885aad33c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:8c67bd1f-33fd-4aaa-bb43-d3fd68d9d5ae,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f359327e431a11ee9cb5633481061a41-20230825
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <sharp.xia@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1792325326; Fri, 25 Aug 2023 15:42:32 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 25 Aug 2023 15:42:31 +0800
Received: from mbjsdccf07.mediatek.inc (10.15.20.246) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 25 Aug 2023 15:42:30 +0800
From:   <Sharp.Xia@mediatek.com>
To:     <ulf.hansson@linaro.org>
CC:     <Sharp.Xia@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-mmc@vger.kernel.org>,
        <matthias.bgg@gmail.com>, <wsd_upstream@medaitek.com>
Subject: Re: [PATCH 1/1] mmc: Set optimal I/O size when mmc_setip_queue
Date:   Fri, 25 Aug 2023 15:25:36 +0800
Message-ID: <20230825072536.23602-1-Sharp.Xia@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <CAPDyKFqN0K=2e4rijUBz=9LXVfhEVvDzNgqXTyTgvaPRK-PBNQ@mail.gmail.com>
References: <CAPDyKFqN0K=2e4rijUBz=9LXVfhEVvDzNgqXTyTgvaPRK-PBNQ@mail.gmail.com>
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

On Thu, 2023-08-24 at 12:55 +0200, Ulf Hansson wrote:
>        
> External email : Please do not click links or open attachments until
> you have verified the sender or the content.
>  On Fri, 18 Aug 2023 at 04:45, <Sharp.Xia@mediatek.com> wrote:
> >
> > From: Sharp Xia <Sharp.Xia@mediatek.com>
> >
> > MMC does not set readahead and uses the default VM_READAHEAD_PAGES
> > resulting in slower reading speed.
> > Use the max_req_size reported by host driver to set the optimal
> > I/O size to improve performance.
> 
> This seems reasonable to me. However, it would be nice if you could
> share some performance numbers too - comparing before and after
> $subject patch.
> 
> Kind regards
> Uffe
> 
> >
> > Signed-off-by: Sharp Xia <Sharp.Xia@mediatek.com>
> > ---
> >  drivers/mmc/core/queue.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> > index b396e3900717..fc83c4917360 100644
> > --- a/drivers/mmc/core/queue.c
> > +++ b/drivers/mmc/core/queue.c
> > @@ -359,6 +359,7 @@ static void mmc_setup_queue(struct mmc_queue
> *mq, struct mmc_card *card)
> >                 blk_queue_bounce_limit(mq->queue, BLK_BOUNCE_HIGH);
> >         blk_queue_max_hw_sectors(mq->queue,
> >                 min(host->max_blk_count, host->max_req_size /
> 512));
> > +       blk_queue_io_opt(mq->queue, host->max_req_size);
> >         if (host->can_dma_map_merge)
> >                 WARN(!blk_queue_can_use_dma_map_merging(mq->queue,
> >                                                         mmc_dev(hos
> t)),
> > --
> > 2.18.0
> >

I test this patch on internal platform(kernel-5.15).

Before:
console:/ # echo 3 > /proc/sys/vm/drop_caches
console:/ # dd if=/mnt/media_rw/8031-130D/super.img of=/dev/null
4485393+1 records in
4485393+1 records out
2296521564 bytes (2.1 G) copied, 37.124446 s, 59 M/s
console:/ # cat /sys/block/mmcblk0/queue/read_ahead_kb
128

After:
console:/ # echo 3 > /proc/sys/vm/drop_caches
console:/ # dd if=/mnt/media_rw/8031-130D/super.img of=/dev/null
4485393+1 records in
4485393+1 records out
2296521564 bytes (2.1 G) copied, 28.956049 s, 76 M/s
console:/ # cat /sys/block/mmcblk0/queue/read_ahead_kb
1024


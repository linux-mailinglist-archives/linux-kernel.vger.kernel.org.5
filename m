Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B88878983E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 18:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjHZQnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 12:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjHZQnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 12:43:49 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6B21995;
        Sat, 26 Aug 2023 09:43:38 -0700 (PDT)
X-UUID: afba5c26442f11eeb20a276fd37b9834-20230827
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=run78isH9wzuv4qEeW4mY8FxhoAXSLzkLolztccpSzM=;
        b=PwjqMvbrBO/ZU7p57J5iqNeMWApmC5ERFmMRQbiFU0j57V1ghXhHEJ5LNZ7eUuEJat8Z93KfKbHbUUWMPY0goa0bLZ7DNntkleegp9xriEGptqvXUJyZDhf90Hk6N2/JYF9QcwqV0U4bRvNqfeZoRSKHFnXb7+LkLgzH4zm9X/g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:fe925674-a4eb-4fd3-8d3e-12e0b9b64a6a,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:48abf9ee-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: afba5c26442f11eeb20a276fd37b9834-20230827
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <sharp.xia@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1266044288; Sun, 27 Aug 2023 00:43:29 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 27 Aug 2023 00:43:28 +0800
Received: from mbjsdccf07.mediatek.inc (10.15.20.246) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sun, 27 Aug 2023 00:43:27 +0800
From:   <Sharp.Xia@mediatek.com>
To:     <shawn.lin@rock-chips.com>
CC:     <Sharp.Xia@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-mmc@vger.kernel.org>,
        <matthias.bgg@gmail.com>, <ulf.hansson@linaro.org>,
        <wsd_upstream@mediatek.com>
Subject: Re: [PATCH 1/1] mmc: Set optimal I/O size when mmc_setip_queue
Date:   Sun, 27 Aug 2023 00:26:35 +0800
Message-ID: <20230826162635.617-1-Sharp.Xia@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <769a67cb-1b32-fd4f-b37e-e3ec4dab5eb9@rock-chips.com>
References: <769a67cb-1b32-fd4f-b37e-e3ec4dab5eb9@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-08-25 at 17:17 +0800, Shawn Lin wrote:
>  	 
> 
>  On 2023/8/25 16:39, Sharp.Xia@mediatek.com wrote:
> > On Fri, 2023-08-25 at 16:11 +0800, Shawn Lin wrote:
> >>   
> >>   Hi Sharp,
> 
> ...
> 
> >>> 1024
> >>>
> > Hi Shawn,
> > 
> > What is your readahead value before and after applying this patch?
> > 
> 
> The original readahead is 128, and after applying the patch is 1024
> 
> 
> cat /d/mmc0/ios
> clock:          200000000 Hz
> actual clock:   200000000 Hz
> vdd:            18 (3.0 ~ 3.1 V)
> bus mode:       2 (push-pull)
> chip select:    0 (don't care)
> power mode:     2 (on)
> bus width:      3 (8 bits)
> timing spec:    10 (mmc HS400 enhanced strobe)
> signal voltage: 1 (1.80 V)
> driver type:    0 (driver type B)
> 
> The driver I used is sdhci-of-dwcmshc.c with a KLMBG2JETDB041 eMMC
> chip.

I tested with RK3568 and sdhci-of-dwcmshc.c driver, the performance improved by 2~3%.
 
Before:
root@OpenWrt:/mnt/mmcblk0p3# time dd if=test.img of=/dev/null
2097152+0 records in
2097152+0 records out
real    0m 6.01s
user    0m 0.84s
sys     0m 2.89s
root@OpenWrt:/mnt/mmcblk0p3# cat /sys/block/mmcblk0/queue/read_ahead_kb
128
 
After:
root@OpenWrt:/mnt/mmcblk0p3# echo 3 > /proc/sys/vm/drop_caches
root@OpenWrt:/mnt/mmcblk0p3# time dd if=test.img of=/dev/null
2097152+0 records in
2097152+0 records out
real    0m 5.86s
user    0m 1.04s
sys     0m 3.18s
root@OpenWrt:/mnt/mmcblk0p3# cat /sys/block/mmcblk0/queue/read_ahead_kb
1024
 
root@OpenWrt:/sys/kernel/debug/mmc0# cat ios
clock:          200000000 Hz
actual clock:   200000000 Hz
vdd:            18 (3.0 ~ 3.1 V)
bus mode:       2 (push-pull)
chip select:    0 (don't care)
power mode:     2 (on)
bus width:      3 (8 bits)
timing spec:    9 (mmc HS200)
signal voltage: 1 (1.80 V)
driver type:    0 (driver type B)


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C0C789857
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 19:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjHZRMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 13:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjHZRL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 13:11:57 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988B0E4E;
        Sat, 26 Aug 2023 10:11:54 -0700 (PDT)
X-UUID: a415f7b4443311eeb20a276fd37b9834-20230827
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=lW5JiU3OBo1fpU5FFkkuisIRL20Eimt0nkU4ubNxKCc=;
        b=XLidcVyErnKrwBnMcnBZ5X4A4asghx6tHcizZqkUI2tQ81nl87Ks8lTnOY62LS+bo4+SiuUgV4EgNNmRslWWK5Y+AfkH0Al4yEKvEpyvNvjozoIDUxXz4ezLG3dKLH96wIb+42CDskQ0lqnOr9E8eBIOBwVeYfHjpWzcX0eyZ3A=;
X-CID-CACHE: Type:Local,Time:202308270043+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:1a60ee05-a56e-45f2-93e0-f7fa5a4e5e55,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:48abf9ee-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a415f7b4443311eeb20a276fd37b9834-20230827
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <sharp.xia@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 96954622; Sun, 27 Aug 2023 01:11:48 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 27 Aug 2023 01:11:46 +0800
Received: from mbjsdccf07.mediatek.inc (10.15.20.246) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sun, 27 Aug 2023 01:11:46 +0800
From:   <Sharp.Xia@mediatek.com>
To:     <wenchao.chen666@gmail.com>
CC:     <Sharp.Xia@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-mmc@vger.kernel.org>,
        <matthias.bgg@gmail.com>, <shawn.lin@rock-chips.com>,
        <ulf.hansson@linaro.org>, <wsd_upstream@mediatek.com>
Subject: Re: [PATCH 1/1] mmc: Set optimal I/O size when mmc_setip_queue
Date:   Sun, 27 Aug 2023 00:54:54 +0800
Message-ID: <20230826165454.1196-1-Sharp.Xia@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <CA+Da2qxaCJwZhn0C7VxZzx8TB1VDR_xa2P0cDXUaNA9=YzSJYg@mail.gmail.com>
References: <CA+Da2qxaCJwZhn0C7VxZzx8TB1VDR_xa2P0cDXUaNA9=YzSJYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-08-25 at 20:23 +0800, Wenchao Chen wrote:
> 
> 
> Hi Sharp
> Use "echo 1024 > sys/block/mmcblk0/queue/read_ahead_kb" instead of
> "blk_queue_io_opt(mq->queue, host->max_req_size);"？

Hi Wenchao,

User space does not know the max_req_size of each mmc host.
And when the SD card is hot inserted,
it is complicated for the user space to modify this value.


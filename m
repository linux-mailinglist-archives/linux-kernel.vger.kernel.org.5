Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B817A4247
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240098AbjIRH0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240075AbjIRH0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:26:00 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A6DE6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 00:25:50 -0700 (PDT)
X-UUID: 961e5f3e55f411eea33bb35ae8d461a2-20230918
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=pmAQXDi1eFJFIz1BbU82J1+CnIbylJEmn229iHCJQIs=;
        b=iXQBjyY+RHy3WfgWsRoEQk9ClNi24G+J9sMkQbBwomqELi5Sc59HCFnuCrY217QGTtK0HQtbfE2ZrXZVrjcGPKrqVwRspTafgyhE/84ceszmRUVXQszV2++LCssmXe375Mw790g8n6d5VhcdE3VSrLbuNxPhzjxz7qbi4x7e9/4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:7d7382ba-4a4a-4e4a-9eb9-67af55be4359,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:31a6f5be-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:817|102,TC:nil,Content:0|-5,EDM:-3,I
        P:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
        SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 961e5f3e55f411eea33bb35ae8d461a2-20230918
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <haibo.li@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1752200225; Mon, 18 Sep 2023 15:25:47 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 18 Sep 2023 15:25:46 +0800
Received: from mszsdtlt102.gcn.mediatek.inc (10.16.4.142) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 18 Sep 2023 15:25:45 +0800
From:   Haibo Li <haibo.li@mediatek.com>
To:     <andreyknvl@gmail.com>
CC:     <akpm@linux-foundation.org>,
        <angelogioacchino.delregno@collabora.com>, <dvyukov@google.com>,
        <glider@google.com>, <haibo.li@mediatek.com>, <jannh@google.com>,
        <kasan-dev@googlegroups.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-mm@kvack.org>,
        <mark.rutland@arm.com>, <matthias.bgg@gmail.com>,
        <ryabinin.a.a@gmail.com>, <vincenzo.frascino@arm.com>,
        <xiaoming.yu@mediatek.com>
Subject: Re: [PATCH] kasan:fix access invalid shadow address when input is illegal
Date:   Mon, 18 Sep 2023 15:25:45 +0800
Message-ID: <20230918072545.87653-1-haibo.li@mediatek.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <CA+fCnZfuaovc4fk6Z+p1haLk7iemgtpF522sej3oWYARhBYYUQ@mail.gmail.com>
References: <CA+fCnZfuaovc4fk6Z+p1haLk7iemgtpF522sej3oWYARhBYYUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Sep 15, 2023 at 4:46 AM 'Haibo Li' via kasan-dev
> <kasan-dev@googlegroups.com> wrote:
> >
> > The patch checks each shadow address,so it introduces extra overhead.
>
> Ack. Could still be fine, depends on the overhead.
>
I do a simple test by reading memory.
Read 4096 memory by loop and the reading unit is 8 bytes.
__hwasan_load8_noabort is called 512(4096/8) times.
Measure the time of memory read.
Here is the result on ARM CA7X(repeat 100 times):
---------------min-------max-----avg----
before patch | 77.3ms | 80.6ms | 79.2ms|
after  patch | 77.2ms | 80.7ms | 79.2ms|
----------------------------------------

There is no obvious drop in this scenario.
It may differ in different arch.
just for information if you are intrested in it.

> But if the message printed by kasan_non_canonical_hook is good enough
> for your use case, I would rather stick to that.

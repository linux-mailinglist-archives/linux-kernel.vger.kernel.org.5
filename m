Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743887EE182
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 14:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345125AbjKPN0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 08:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjKPN0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 08:26:38 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BCD1A5;
        Thu, 16 Nov 2023 05:26:31 -0800 (PST)
X-UUID: bec66c48848311ee8051498923ad61e6-20231116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=y1Rm5jlVn5t0id/m/TPD/9lVjA4G13LLAk8j5q37gsw=;
        b=qwo0KZcqGzBreHoIaewzH3LX/RwJRuN7riv7yL2UvJlJGkEVTqgywAjt1GT2lySvGo+wb9VRVAJDA2MH0HeUFdpPm9FT0Sj+Q6hDe0wgdGsZWvhULoWAc/VgicTRrdOuYULJjC7KIDoknWs/hSOv/+vXAIBLL2eyB1h0NYnjrAQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:04cc521c-c76a-4815-a28f-b6e785132362,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:6d8c2360-c89d-4129-91cb-8ebfae4653fc,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: bec66c48848311ee8051498923ad61e6-20231116
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <bo.ye@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 413711698; Thu, 16 Nov 2023 21:26:27 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 16 Nov 2023 21:26:25 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 16 Nov 2023 21:26:24 +0800
From:   Bo Ye <bo.ye@mediatek.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     <yongdong.zhang@mediatek.com>, mtk24676 <C.Cheng@mediatek.com>,
        "bo . ye" <bo.ye@mediatek.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] cpuidle: idle exit_latency overflow
Date:   Thu, 16 Nov 2023 21:26:19 +0800
Message-ID: <20231116132619.69500-1-bo.ye@mediatek.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--2.336600-8.000000
X-TMASE-MatchedRID: q6Mcoqip180V3w3L8QuNEG3NvezwBrVmgRykyfrH1xlaW2Ktn+I8/hjt
        AEYMnZ1a+a6+c8HVVTTkY5jnILkv8QfOsX0b+fZzA9lly13c/gF9LQinZ4QefPcjNeVeWlqY+gt
        Hj7OwNO2mZ396Gt5HhbRDDFNIh3eVt7VBaHOUXTmiHbKhgq+wjecLkJ18YygSpmkWtXcgBB8O5f
        DUOrhTJDcG0AuzN2tmcPptgJdP32/rxtqtWRjZinZrUbEZipAEiWT09mQz7szw9kH8zAy44aOuV
        Lnx3A74
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.336600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 4E0647C9374209A165167659E1BEC95B48EA7C03306E9BBFA04062C7CE3E4B892000:8
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: mtk24676 <C.Cheng@mediatek.com>

In detail:
In kernel-6.1, in the __cpuidle_driver_init function in
driver/cpuidle/driver.c, there is a line of code that causes
an overflow. The line is s->exit_latency_ns = s->exit_latency
* NSEC_PER_USEC. The overflow occurs because the product of an
int type and a constant exceeds the range of the int type.

In C language, when you perform a multiplication operation, if
both operands are of int type, the multiplication operation is
performed on the int type, and then the result is converted to
the target type. This means that if the product of int type
multiplication exceeds the range that int type can represent,
an overflow will occur even if you store the result in a
variable of int64_t type.

Signed-off-by: mtk24676 <C.Cheng@mediatek.com>
Signed-off-by: bo.ye <bo.ye@mediatek.com>
---

diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
index d9cda7f..631ca16 100644
--- a/drivers/cpuidle/driver.c
+++ b/drivers/cpuidle/driver.c
@@ -187,7 +187,7 @@
 			s->target_residency = div_u64(s->target_residency_ns, NSEC_PER_USEC);
 
 		if (s->exit_latency > 0)
-			s->exit_latency_ns = s->exit_latency * NSEC_PER_USEC;
+			s->exit_latency_ns = (u64)s->exit_latency * NSEC_PER_USEC;
 		else if (s->exit_latency_ns < 0)
 			s->exit_latency_ns =  0;
 		else

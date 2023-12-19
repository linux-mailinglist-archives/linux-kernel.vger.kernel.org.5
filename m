Return-Path: <linux-kernel+bounces-4635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E7E818026
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D8E4285F24
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 03:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4006D5235;
	Tue, 19 Dec 2023 03:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="LUxd9qXz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD077468;
	Tue, 19 Dec 2023 03:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ceafe8529e1c11eea5db2bebc7c28f94-20231219
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Uc8TGbTWFJXJZhL7Yec5wz80/Sme6MVdPJeQBPGh5sA=;
	b=LUxd9qXzqm+t1GQlgRX9ahm9lfCO4kR2eQU2+yRgjDGb2ZvrHCtm07uBFgDVyObypGfqAAN/OeU9a50K7A7VU6TqBT+FNvj7Ipz1pVgA20HtnC2RD0j/4AM+WyO3lFWPd3zuuoFuWf3QNdKxlseItGXxjunctBl/Wt4KQ6ywqXM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:49605fb5-4545-4306-9122-95f4c2686844,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:597e5a61-c89d-4129-91cb-8ebfae4653fc,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: ceafe8529e1c11eea5db2bebc7c28f94-20231219
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <bo.ye@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 563580467; Tue, 19 Dec 2023 11:15:05 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 19 Dec 2023 11:15:03 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 19 Dec 2023 11:15:02 +0800
From: Bo Ye <bo.ye@mediatek.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: <yongdong.zhang@mediatek.com>, C Cheng <C.Cheng@mediatek.com>, Bo Ye
	<bo.ye@mediatek.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
Subject: [PATCH v2] fix overflow in idle exit_latency
Date: Tue, 19 Dec 2023 11:14:42 +0800
Message-ID: <20231219031444.91752-1-bo.ye@mediatek.com>
X-Mailer: git-send-email 2.17.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--0.581900-8.000000
X-TMASE-MatchedRID: Bn0z3T9b+WALj6umkFEndkKcYi5Qw/RVwW1rM+V9HtIf/28+P8WCgP6r
	IPjisOwVcto9nSFCcQUzAylM0q9+nMc7x4DEI6P2e7MO8jvmPSyAfODDLypXmvt592eq2xoTU7g
	EPucszGdOJB5wP1oqhO1oMOv2nr2NkfRhdidsajMURSScn+QSXt0H8LFZNFG76sBnwpOylLPAPI
	cR41PqunfVvfXf3EO2gRffnX50nm9u1jRmR2R6BTvyUDm8uVn3bYdPRFL+GVW7F+BBzr8amdrEU
	qFrRQ4GM/cJLu1mnTkXRoPmWO3jekxwdkPqCq7vDEyN+J8hd+jCS9WgDXVPCn7cGd19dSFd
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--0.581900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	11FAC9A90BC813C03769B41050A5049E53D6CBC065D06896E3C61187F7063FAB2000:8
X-MTK: N

From: C Cheng <C.Cheng@mediatek.com>

In detail:

In C language, when you perform a multiplication operation, if
both operands are of int type, the multiplication operation is
performed on the int type, and then the result is converted to
the target type. This means that if the product of int type
multiplication exceeds the range that int type can represent,
 an overflow will occur even if you store the result in a
variable of int64_t type.

For a multiplication of two int values, it is better to use
mul_u32_u32() rather than s->exit_latency_ns = s->exit_latency *
NSEC_PER_USEC to avoid potential overflow happenning.

Signed-off-by: C Cheng <C.Cheng@mediatek.com>
Signed-off-by: Bo Ye <bo.ye@mediatek.com>
---
Change in v2:
-remove Change-ID
-correct patch author name
-replace multiplication of two int values with mul_u32_u32
-refine commit message
---
 drivers/cpuidle/driver.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
index d9cda7f6ccb9..cf5873cc45dc 100644
--- a/drivers/cpuidle/driver.c
+++ b/drivers/cpuidle/driver.c
@@ -16,6 +16,7 @@
 #include <linux/cpumask.h>
 #include <linux/tick.h>
 #include <linux/cpu.h>
+#include <linux/math64.h>
 
 #include "cpuidle.h"
 
@@ -187,7 +188,7 @@ static void __cpuidle_driver_init(struct cpuidle_driver *drv)
 			s->target_residency = div_u64(s->target_residency_ns, NSEC_PER_USEC);
 
 		if (s->exit_latency > 0)
-			s->exit_latency_ns = s->exit_latency * NSEC_PER_USEC;
+			s->exit_latency_ns = mul_u32_u32(s->exit_latency, NSEC_PER_USEC);
 		else if (s->exit_latency_ns < 0)
 			s->exit_latency_ns =  0;
 		else
-- 
2.18.0



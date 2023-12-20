Return-Path: <linux-kernel+bounces-6304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C99128196FB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 03:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35F30B258A9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 02:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D188C06;
	Wed, 20 Dec 2023 02:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="jvYFrS5K"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67048489;
	Wed, 20 Dec 2023 02:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b1052ffc9ee311eea5db2bebc7c28f94-20231220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Rd3y8r7VxkTeyuncm++Him7JbEb+aE634mlmf0NY6yA=;
	b=jvYFrS5K55EoO5+wEXj8KHKgyAS2pA5VnqnNV0ya8cSY+M1mrF0dvEl6UZrjb7n2S6JfJu0URk+sUaQn/m67ilW7CNrW642xIS3r+IoCT2PY2oLby6vfjkI5xQmIML0iQSOPtO74zow2DoIkQf3C2a/9c/XB/4PLCVHGiZzZszU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:c6c3dbfe-deb1-4162-84e1-412fc9537862,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:5e5be117-1474-414b-9c9f-6d23a122e796,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: b1052ffc9ee311eea5db2bebc7c28f94-20231220
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <chunfeng.yun@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 589724999; Wed, 20 Dec 2023 10:58:45 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 20 Dec 2023 10:58:44 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 20 Dec 2023 10:58:43 +0800
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: Chunfeng Yun <chunfeng.yun@mediatek.com>, Conor Dooley
	<conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, "Mathias
 Nyman" <mathias.nyman@intel.com>, <linux-usb@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Eddie Hung
	<eddie.hung@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>
Subject: [PATCH v3 1/3] dt-bindings: usb: mtk-xhci: add a property for Gen1 isoc-in transfer issue
Date: Wed, 20 Dec 2023 10:58:40 +0800
Message-ID: <20231220025842.7082-1-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--6.009600-8.000000
X-TMASE-MatchedRID: eGdMcixj1WQ28LK855iUisp9Bgr5ONKhXxT5cg8K/td+YesuCgkiXKLs
	GdYIe0oEWB8Rur00SOpx/Hv6BudnAqB/4ZSHyd2lsyNb+yeIRApRnscLnNAC7Htd2pOTSxFkaUX
	s6FguVy2ByM1EGDQjGHSSJ37AbZpnpHn0l5P4rnWp4G6k2AuBh1pq//Jp4zBuDzgndGCfGZmYpu
	G7kpoKR74vrFmOaS1EoJY+2TrDFLUdpD3DKTh+QJ4CIKY/Hg3AaZGo0EeYG96m4/3ODjvukSq2r
	l3dzGQ1Riv8hIYWPEqszylmlmspjawfKGpwa3LoEIxU5uOgcNJVrvWgRz6oTw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--6.009600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	139357F67A1AC3DF979095D19572499B1A723477A91A23F2D28B428B5803F5332000:8
X-MTK: N

For Gen1 isoc-in endpoint on controller before about SSUSB IPM v1.6.0, it
still send out unexpected ACK after receiving a short packet in burst
transfer, this will cause an exception on connected device, specially for
a 4k camera.
Add a quirk property "rx-fifo-depth" to work around this hardware issue,
prefer to use 3k bytes;
The side-effect is that may cause performance drop about 10%, including
bulk transfer.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v3: add fifo depth unit, change the value range from 0-3 to 1-4
v2: change 'mediatek,rxfifo-depth' to 'rx-fifo-depth'
---
 .../devicetree/bindings/usb/mediatek,mtk-xhci.yaml   | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
index e9644e333d78..9478b7031796 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
@@ -124,6 +124,18 @@ properties:
       defined in the xHCI spec on MTK's controller.
     default: 5000
 
+  rx-fifo-depth:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      It is a quirk used to work around Gen1 isoc-in endpoint transfer issue
+      that still send out unexpected ACK after device finish the burst transfer
+      with a short packet and cause an exception, specially on a 4K camera
+      device, it happens on controller before about IPM v1.6.0; the side-effect
+      is that may cause performance drop about 10%, include bulk transfer,
+      prefer to use 3 here. The unit is 1K bytes.
+    minimum: 1
+    maximum: 4
+
   # the following properties are only used for case 1
   wakeup-source:
     description: enable USB remote wakeup, see power/wakeup-source.txt
-- 
2.18.0



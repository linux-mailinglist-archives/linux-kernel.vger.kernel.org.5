Return-Path: <linux-kernel+bounces-164761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DD78B822B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 23:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83FD51F236B8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1789F1BF6D6;
	Tue, 30 Apr 2024 21:54:17 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BAF1BED7A;
	Tue, 30 Apr 2024 21:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714514056; cv=none; b=dYCu1JIfK2xyX/Fj3oecFyyS4C1ZN0DprOZU3jHJQGSuMyRfC5jiy9sPhI+rZBUk4UfYZAsNMMKLd+a7j5YbCf9sK9rKLBtdJPvQ7qu37Ijs/h+JxGnjLPD/y3MLajEKLUI5mxA24JATe9PPQsheocVWMBAelZM9DTxW5F3COHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714514056; c=relaxed/simple;
	bh=zuO7Ws6HI2qfJ6Q89WdCK7XpUdWjT7P+8LS3uVnpW6E=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GjNWfN16li4hD1bIoMqRiCBZApJfL+9xAyWNl/ijACjFoUztosSFMT8L+oIZ/btKM0TqS+wkoRFoB9xT31nYhs26kHLt2/gz+6NMqY3lwgPz/MK60ECRanmWgS5T1mX49ZrSt2aVEdcyujhl1JlarmeO5GvMdS0ak6E7So2zar8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1s1vQI-0000000016x-33u8;
	Tue, 30 Apr 2024 21:54:02 +0000
Date: Tue, 30 Apr 2024 22:53:55 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] dt-bindings: net: mediatek: remove wrongly added clocks and
 SerDes
Message-ID: <ea2e786eda4561cb5d11b62a4edd7e75c0975f1f.1714513773.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Several clocks as well as both sgmiisys phandles were added by mistake
to the Ethernet bindings for MT7988.

This happened because the vendor driver which served as a reference uses
a high number of syscon phandles to access various parts of the SoC
which wasn't acceptable upstream. Hence several parts which have never
previously been supported (such SerDes PHY and USXGMII PCS) are going to
be implemented by separate drivers. As a result the device tree will
look much more sane.

Quickly align the bindings with the upcoming reality of the drivers
actually adding support for the remaining Ethernet-related features of
the MT7988 SoC.

Fixes: c94a9aabec36 ("dt-bindings: net: mediatek,net: add mt7988-eth binding")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 .../devicetree/bindings/net/mediatek,net.yaml | 32 ++++---------------
 1 file changed, 7 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/mediatek,net.yaml b/Documentation/devicetree/bindings/net/mediatek,net.yaml
index e74502a0afe8..030d106bc7d3 100644
--- a/Documentation/devicetree/bindings/net/mediatek,net.yaml
+++ b/Documentation/devicetree/bindings/net/mediatek,net.yaml
@@ -337,32 +337,23 @@ allOf:
           minItems: 4
 
         clocks:
-          minItems: 34
-          maxItems: 34
+          minItems: 24
+          maxItems: 24
 
         clock-names:
           items:
-            - const: crypto
+            - const: xgp1
+            - const: xgp2
+            - const: xgp3
             - const: fe
             - const: gp2
             - const: gp1
             - const: gp3
+            - const: esw
+            - const: crypto
             - const: ethwarp_wocpu2
             - const: ethwarp_wocpu1
             - const: ethwarp_wocpu0
-            - const: esw
-            - const: netsys0
-            - const: netsys1
-            - const: sgmii_tx250m
-            - const: sgmii_rx250m
-            - const: sgmii2_tx250m
-            - const: sgmii2_rx250m
-            - const: top_usxgmii0_sel
-            - const: top_usxgmii1_sel
-            - const: top_sgm0_sel
-            - const: top_sgm1_sel
-            - const: top_xfi_phy0_xtal_sel
-            - const: top_xfi_phy1_xtal_sel
             - const: top_eth_gmii_sel
             - const: top_eth_refck_50m_sel
             - const: top_eth_sys_200m_sel
@@ -375,15 +366,6 @@ allOf:
             - const: top_netsys_sync_250m_sel
             - const: top_netsys_ppefb_250m_sel
             - const: top_netsys_warp_sel
-            - const: wocpu1
-            - const: wocpu0
-            - const: xgp1
-            - const: xgp2
-            - const: xgp3
-
-        mediatek,sgmiisys:
-          minItems: 2
-          maxItems: 2
 
 patternProperties:
   "^mac@[0-1]$":
-- 
2.44.0



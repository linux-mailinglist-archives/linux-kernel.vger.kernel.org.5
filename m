Return-Path: <linux-kernel+bounces-154684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F30D98ADFBE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65A8AB215DA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A936351C5B;
	Tue, 23 Apr 2024 08:30:07 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C71B322A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 08:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713861007; cv=none; b=EWMoeaQeaaDCGTkueXQzocebS7kYJAvuiTfyFZhKnNQ2wX7VPcj4NaVFdX8Z0C9PthQhw2bM8n14u2LF1HzGcrErrcVHzRhvOuBrXWb6Tz/gV3QC+Pb+oYkVft3jTopTyliI/CjVqedI8foDHkyN6TqPri8ef5XGahEGmmvSVLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713861007; c=relaxed/simple;
	bh=Hm3JvyqagqmLLGSx2WW5svw6QHMUCM2+eLLz3xkAXNs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TDCrXMtz12pQTZ4Z1KB/h9Am6TPEwYSnl/xwnEPoeGTRyfnsjhkyc1piaUCNr0Q+R7IAcamf18COU0yY9HY6weVA+ZS5Xm4WSm6TwiJIGff0S73DIL5aDHOlXrfWcWh9Fex5sm1u2H7YRQs7sQXLcdAOojpoolAist2kYxqCnXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e861d9e.versanet.de ([94.134.29.158] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rzBXN-0003WW-M2; Tue, 23 Apr 2024 10:30:01 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: michael.riesch@wolfvision.net,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH] arm64: dts: rockchip: fix nodename warning on wolfvision-pf5-display
Date: Tue, 23 Apr 2024 10:29:41 +0200
Message-Id: <20240423082941.2626102-1-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dtbs check throws a warning about node naming with the recently
added pf5-display-overlay:
rockchip/rk3568-wolfvision-pf5-display.dtsi:113.6-121.3: Warning (graph_port): /fragment@4/__overlay__: graph port node name should be 'port'

This comes from the overlay just referencing the vp2-port-node via
its phandle and then adding an endpoint beneath it.

While this is possible something to handle inside the dtbs check,
carrying around the warning is not pretty, so change the description
to go around it.

Starting from the vop_out phandle and then referencing the port
via its generic port@2 nodename will satisfy the port<->endpoint
naming dependency while keeping the same structure once the overlay
is applied.

Reported-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../rockchip/rk3568-wolfvision-pf5-display.dtsi    | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-wolfvision-pf5-display.dtsi b/arch/arm64/boot/dts/rockchip/rk3568-wolfvision-pf5-display.dtsi
index b22bb543ecbb..18c807c39e56 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-wolfvision-pf5-display.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3568-wolfvision-pf5-display.dtsi
@@ -110,12 +110,14 @@ &pwm10 {
 	status = "okay";
 };
 
-&vp2 {
-	#address-cells = <1>;
-	#size-cells = <0>;
+&vop_out {
+	port@2 {
+		#address-cells = <1>;
+		#size-cells = <0>;
 
-	vp2_out_rgb: endpoint@ROCKCHIP_VOP2_EP_RGB0 {
-		reg = <ROCKCHIP_VOP2_EP_RGB0>;
-		remote-endpoint = <&panel_in_vp2>;
+		vp2_out_rgb: endpoint@ROCKCHIP_VOP2_EP_RGB0 {
+			reg = <ROCKCHIP_VOP2_EP_RGB0>;
+			remote-endpoint = <&panel_in_vp2>;
+		};
 	};
 };
-- 
2.39.2



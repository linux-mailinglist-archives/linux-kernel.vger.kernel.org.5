Return-Path: <linux-kernel+bounces-37536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA3783B162
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A8A81C2358B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F663131751;
	Wed, 24 Jan 2024 18:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RvdnlsKE"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DD213172E;
	Wed, 24 Jan 2024 18:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706122053; cv=none; b=h8X1FzZPC+BNjfCUg6YepEb3Dm2zLyk9B8JdX16mSpIs/ikij+glAo2/pxfmJsXaDHvNiZGcEhsDHMT/ykmU7ofco9ou+4WmKFiJH1n6pN0UVz5sQHtV5Xk5DvJXNWq5dwojN5f6V6nZLa8DwtLmaA6JZPjIPX20aTsYyAKhIn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706122053; c=relaxed/simple;
	bh=UTBCzGjmIkYUdiojLgJ4G6OrbN6lnfUqilvtljzIeWk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h/Pha1MsINm9KDz6/W0yytAw+3qtpFIEZV3gwjRtpZg27jOHei6WhA7uRFYa1N+2VmgsnloihAcYIhFebFeNjiD3DcXi1o35B3c1bRyysE1amAijVlUEdeKYqYgnn+BtwFfZiT82crTOOmbCOhu2MPVpz8H+GNE385GEpxK406Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RvdnlsKE; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40OIlO10002579;
	Wed, 24 Jan 2024 12:47:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706122044;
	bh=259lyjKwzzRUcgPI9qcYVw+5ylozXN1fiOKniGs4g0I=;
	h=From:To:CC:Subject:Date;
	b=RvdnlsKEZ2uV3omFLHUiuNG5TfU5PxrMCKU90zXHfMI336RsfQ1FPc1QKAMxisR/4
	 wkB+Efd7TaWKHcSSJPlhBusNd8Du0MAlTa1/Zd6dnFudWmlIF0sohjQHx++WIyC0E5
	 DOZU3FAi4/X8/MK/f1GQPrYVjNf4G0dGljU5uDR8=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40OIlORt052035
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 24 Jan 2024 12:47:24 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Jan 2024 12:47:24 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Jan 2024 12:47:23 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40OIlNaN119099;
	Wed, 24 Jan 2024 12:47:23 -0600
From: Andrew Davis <afd@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 01/11] arm64: dts: ti: k3-am64: Convert serdes_ln_ctrl node into reg-mux
Date: Wed, 24 Jan 2024 12:47:12 -0600
Message-ID: <20240124184722.150615-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This removes a dependency on the parent node being a syscon node.
Convert from mmio-mux to reg-mux adjusting node name and properties
as needed.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index e348114f42e01..34c45f83eb64d 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -51,10 +51,11 @@ chipid@14 {
 			reg = <0x00000014 0x4>;
 		};
 
-		serdes_ln_ctrl: mux-controller {
-			compatible = "mmio-mux";
+		serdes_ln_ctrl: mux-controller@4080 {
+			compatible = "reg-mux";
+			reg = <0x4080 0x4>;
 			#mux-control-cells = <1>;
-			mux-reg-masks = <0x4080 0x3>; /* SERDES0 lane0 select */
+			mux-reg-masks = <0x0 0x3>; /* SERDES0 lane0 select */
 		};
 
 		phy_gmii_sel: phy@4044 {
-- 
2.39.2



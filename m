Return-Path: <linux-kernel+bounces-37540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A0E83B16A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5B2828A9F5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C53C132C19;
	Wed, 24 Jan 2024 18:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WjIzXEcD"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49D0131752;
	Wed, 24 Jan 2024 18:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706122055; cv=none; b=rkdFzViCIDbvt4cEIfIpiaNkKUcgsgUVT1NrzyVf2cd4AnN99+gTvUFyk80eaTggdlRMNkgEXsybW6S0WzQVJIt/HVeRnX9mWvxZ3H1xATPy/aOwI05ilEFus1zpNVtyuBqMeSy43NnRlG4DzYhVrAnOCaMDyTDIhUX+OiF+/PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706122055; c=relaxed/simple;
	bh=b2qE7VDKsHvQGPNI3szdTHbuRPAp9MUbEgsgvUB7k50=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WVTJMXJZZx3WnFoLalv366CUxbI59s+UhDcPL2kzkN8M6Sxds0Rb3v1kjccuKxfTSHLDnwD9pxOd/vvYYJAVeqYJ+d6vc8feDIULrTEsoD/B8MkLdNil2y2dzYCVDSMn3LMUwHrb9YbrWKufRhctTWOAZ3kT5d4DffkoHVYllzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WjIzXEcD; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40OIlP9j109681;
	Wed, 24 Jan 2024 12:47:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706122045;
	bh=73/9jMiPQ8U4q0QWE9vK/xJuc9SMVQhJrK9fAR5DaTU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=WjIzXEcDueBXAMVmjCIwPsJhw7CIxL5LlaBHj/iEht0371dQ4NymGPJKKPzrJprNp
	 jKOzrSmhxX2uVvmwp+jdw3qV4p8A8UFGp1mFw8mgF2OB+YHVqAICK8rH7n1T5BcLau
	 rLJCtniIohJ+I6AZYuaCDBpKvGbkNIbLIkJYK3Wk=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40OIlPjd014145
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 24 Jan 2024 12:47:25 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Jan 2024 12:47:25 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Jan 2024 12:47:25 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40OIlNaQ119099;
	Wed, 24 Jan 2024 12:47:24 -0600
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
Subject: [PATCH 04/11] arm64: dts: ti: k3-j7200: Convert usb_serdes_mux node into reg-mux
Date: Wed, 24 Jan 2024 12:47:15 -0600
Message-ID: <20240124184722.150615-4-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240124184722.150615-1-afd@ti.com>
References: <20240124184722.150615-1-afd@ti.com>
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
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index 50d1f173bde31..e9898d52d83a7 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -48,9 +48,10 @@ cpsw0_phy_gmii_sel: phy@4044 {
 		};
 
 		usb_serdes_mux: mux-controller@4000 {
-			compatible = "mmio-mux";
+			compatible = "reg-mux";
+			reg = <0x4000 0x4>;
 			#mux-control-cells = <1>;
-			mux-reg-masks = <0x4000 0x8000000>; /* USB0 to SERDES0 lane 1/3 mux */
+			mux-reg-masks = <0x0 0x8000000>; /* USB0 to SERDES0 lane 1/3 mux */
 		};
 	};
 
-- 
2.39.2



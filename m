Return-Path: <linux-kernel+bounces-37541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D7183B16B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3D801F2351A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501D9132C25;
	Wed, 24 Jan 2024 18:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GCtKzcQ6"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9B6131E25;
	Wed, 24 Jan 2024 18:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706122055; cv=none; b=BVjr7sNrpnegH5rSQeUyRWOhUTEq9ELMqBzS1ePolDuew3Qf3nAN98gUmYXKUBsTxDBIUYghPmB1mtfMkRp2zj0Em1esg1NJcKILVrCvKxOckw3oYZFje0cPb5T/4SOXeI4xkUmSyuFktiGKOtLdFYr8kF+pyXaBVmfQi3d+ZaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706122055; c=relaxed/simple;
	bh=8nBXFuhUztEFB9n0j4paOy0b2N4h7+tpkHbKx1XCvUE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rv6AnpXNXp/x+HxJd584NSOBLe2JUdOc1QPjSn0Efa7G9zy+iMvzGdbITmw4mCGWUpwm1+Yerbe2t+2SjuOvGP97IMg/vsxP5Ek7n0b9E6pF9M/+iCju1C7qSrfxTRWvcPMJb/Jh1Ph1KVZqARb9AwvOWsE210CAwDP9zdDz/do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GCtKzcQ6; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40OIlQNc093964;
	Wed, 24 Jan 2024 12:47:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706122046;
	bh=64TzqFIU47CdeaXYnEfO5gKZVhsoSAcPvR2wWTO9VYM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=GCtKzcQ6hXnAiJjst5pWLn0Sstq9akSJE8pilE4ijnLhIxWSsP595CFJ4jXGwvDU1
	 zOFQN9sYI5+4W8efVMZ4dOSHE6D6wTgFeZiQxQXAMW5YGDnCW0TTukIK6Ovrg4IlfD
	 iVQLAUiqwkrpZf1WBtRMY6ntlDL05sT9rmFIhJPc=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40OIlQYS052079
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 24 Jan 2024 12:47:26 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Jan 2024 12:47:26 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Jan 2024 12:47:26 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40OIlNaS119099;
	Wed, 24 Jan 2024 12:47:25 -0600
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
Subject: [PATCH 06/11] arm64: dts: ti: k3-j721e: Convert usb_serdes_mux node into reg-mux
Date: Wed, 24 Jan 2024 12:47:17 -0600
Message-ID: <20240124184722.150615-6-afd@ti.com>
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
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index c168bfbd303da..db3855ae798a2 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -70,10 +70,11 @@ cpsw0_phy_gmii_sel: phy@4044 {
 		};
 
 		usb_serdes_mux: mux-controller@4000 {
-			compatible = "mmio-mux";
+			compatible = "reg-mux";
+			reg = <0x4000 0x20>;
 			#mux-control-cells = <1>;
-			mux-reg-masks = <0x4000 0x8000000>, /* USB0 to SERDES0/3 mux */
-					<0x4010 0x8000000>; /* USB1 to SERDES1/2 mux */
+			mux-reg-masks = <0x0 0x8000000>, /* USB0 to SERDES0/3 mux */
+					<0x10 0x8000000>; /* USB1 to SERDES1/2 mux */
 		};
 
 		ehrpwm_tbclk: clock-controller@4140 {
-- 
2.39.2



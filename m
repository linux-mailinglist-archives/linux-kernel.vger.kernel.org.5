Return-Path: <linux-kernel+bounces-45982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 545FC8438A4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E10228366E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408E258AA0;
	Wed, 31 Jan 2024 08:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MY5w9jDZ"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13CF50A63;
	Wed, 31 Jan 2024 08:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706689140; cv=none; b=XI9fLwcmVvdwM78zl1L7xYLJrgQP4mnSrgiv2QwHLdhcokepUKoJ9277JksETSErMBC+gjg4Uk1a+iTB5bccttppADOcogmVEaSsBcFniDYhYg84ktNYHXe0yMLGUraqJ+8x0548A0vwAscAq6ActElQYXYheMjsTyzVX1D6M74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706689140; c=relaxed/simple;
	bh=o5Lnmq0fWk5Eep/W7qO74NwPNkRIeb4zvL2icNl8iGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=NwwCoY+dfyTNTBxEdK4/xTFf0YaV/1eLCcVRjEA14x9SgpkRbWRAOAMPb7mVG77+bVNN7xIBnTixvQfjKjGUnRtuH2cuCvz+EqrXZtIjmv17Torb1t16gGJjbyJKCYkCUT0+IUyje/ro8Fg4oAVym2iTkdzz4/WJDM3x2FKKIAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MY5w9jDZ; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40V8IiSa022478;
	Wed, 31 Jan 2024 02:18:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706689124;
	bh=PYxfOXCNJnIon29E/e3F7R/L3Qp6QTCyA8kV/xxD3H4=;
	h=From:Date:Subject:To:CC;
	b=MY5w9jDZzcL7xbSozgVqygZO0WyZjOmAy/lV+IwOyar0HsOQYwKlzpuy+P1pOSy4d
	 6yIh5qozj0aHvdQhL+uQtkx/BnI20h/KqXqPZ2Qm+26HZy8Ibd9lVPZRQJRNQgwOVC
	 zgWqWXryuuc7wMiFE4javsBo0hJD/KLHA11e7xFc=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40V8Iiqi081849
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jan 2024 02:18:44 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 02:18:44 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 02:18:44 -0600
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40V8Iew4078299;
	Wed, 31 Jan 2024 02:18:40 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Wed, 31 Jan 2024 13:48:39 +0530
Subject: [PATCH] arm64: dts: ti: k3-j721s2: Fix power domain for VTM node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240131-b4-upstream-j721s2-fix-vtm-devid-v1-1-94c927bb9595@ti.com>
X-B4-Tracking: v=1; b=H4sIAF4CumUC/x2N0QrCMAxFf2XkeYE2rm7uV8SH2kbNYHM0cwhl/
 27w8cA991RQLsIKY1Oh8C4q78XAtw2kV1yejJKNgRx1ztMJ7x1+Vt0KxxmnnrwSPuSL+zZjNj/
 jcOYQ0hDDJUWwm7WwDf6J6+04fvzxPQJyAAAA
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Bryan Brattlof <bb@ti.com>,
        Keerthy <j-keerthy@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Udit Kumar <u-kumar1@ti.com>,
        Manorit
 Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706689120; l=1138;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=o5Lnmq0fWk5Eep/W7qO74NwPNkRIeb4zvL2icNl8iGM=;
 b=060yeBkDeRGOZ+KRb8BTBV5kbQoeSFGiimDCaeh0vtJAiRWD+FPMXcmY80ald9ATbkGR2L7n/
 6uuJX/EFFs6DFJ4AObY/smgi/5+JLB4vpnH7+xV7dQCe+DSTbQMUVZQ
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Fix the power domain device ID for wkup_vtm0 node.

Link: https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j721s2/devices.html
Fixes: d148e3fe52c8 ("arm64: dts: ti: j721s2: Add VTM node")
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
index 80aa33c58a45..a47cb557dd95 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
@@ -663,7 +663,7 @@ wkup_vtm0: temperature-sensor@42040000 {
 		compatible = "ti,j7200-vtm";
 		reg = <0x00 0x42040000 0x0 0x350>,
 		      <0x00 0x42050000 0x0 0x350>;
-		power-domains = <&k3_pds 154 TI_SCI_PD_SHARED>;
+		power-domains = <&k3_pds 180 TI_SCI_PD_SHARED>;
 		#thermal-sensor-cells = <1>;
 	};
 

---
base-commit: 774551425799cb5bbac94e1768fd69eec4f78dd4
change-id: 20240123-b4-upstream-j721s2-fix-vtm-devid-86e55c8a59ca

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>



Return-Path: <linux-kernel+bounces-47251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16971844AFE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94536B277AB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85833F8F4;
	Wed, 31 Jan 2024 22:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KIGUzHmY"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0E13B28F;
	Wed, 31 Jan 2024 22:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706739612; cv=none; b=uslnpBgMGdPrJRWfm8HP8m+6PsluCYZIHAXH+6t7ZsfjHwU9aVX98HM5vv3rA2Htva2ogfJKaoL0sPy9xX+c68bwLw9J5tWe/wikZ3jD8IrW0lw48J5RdT3d3xpjk9ai/TcnqZVM50EnF+u2Oxtit30IgT0Aq2kFij0yPPs8W2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706739612; c=relaxed/simple;
	bh=rXrPV1rX3EqBXdZa52TN75oeVdk6hxNfm8/LdtM6FIo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fDWbthBB3b65E4x6gbthp+5Zt2q6ssgje5pvfCNoXd0NTJMIK/AwHGEQtZA0wL8GTPgns/mFNx5OHGQipf+aqiG3WA9Webh+b+7QrxCbuTCcf66KD75/IenN7OLnDbvzY9Q+uLZ/FCs5SBk2WErUbfpNQHjqJoxh86fLhaJDvP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KIGUzHmY; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40VMK57e060846;
	Wed, 31 Jan 2024 16:20:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706739605;
	bh=aR2SBKT0vtJHfYIAGBIrORRoaDBuet+1jfTnks5284s=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=KIGUzHmYtbsMo+e0n0axWUsc8Lwyalx+7VOISM/jtBa/mHsKCbhTetQZEJqb7S/AV
	 WYfofe+NyGzP+p2hM2Gb6XwCBiH0Xx6vA9Ecz8vZOJ20xPOlMv1TiAkU2USG0Shte/
	 REW/v4MqUBd8xtoWsDyfsTePF3OU+OJLV8PEq0QE=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40VMK5YQ100801
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jan 2024 16:20:05 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 16:20:05 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 16:20:05 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40VMJwxE102504;
	Wed, 31 Jan 2024 16:20:05 -0600
From: Andrew Davis <afd@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh
 Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Vignesh
 Raghavendra <vigneshr@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH 12/12] arm64: dts: ti: k3-j784s4: Add reboot-controller node
Date: Wed, 31 Jan 2024 16:19:57 -0600
Message-ID: <20240131221957.213717-13-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240131221957.213717-1-afd@ti.com>
References: <20240131221957.213717-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

While PCSI normally handles reboot for K3, this is an available
fallback in case PCSI reboot fails. Add direct reboot TI-SCI
node to system-controller.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
index 3902a921d7e58..6a66de4f6e549 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
@@ -36,6 +36,11 @@ k3_reset: reset-controller {
 			compatible = "ti,sci-reset";
 			#reset-cells = <2>;
 		};
+
+		k3_reboot: reboot-controller {
+			bootph-all;
+			compatible = "ti,sci-reboot";
+		};
 	};
 
 	wkup_conf: bus@43000000 {
-- 
2.39.2



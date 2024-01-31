Return-Path: <linux-kernel+bounces-47248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD81844AFC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDDE41C22513
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B303F8CD;
	Wed, 31 Jan 2024 22:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EzB4WxSm"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBDC3A26E;
	Wed, 31 Jan 2024 22:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706739611; cv=none; b=eqTafBXueOqTDOeRjaB9U617Kl+eu5XQQ+oS9+3rLsZWE6MXT2DJ8LHwglcvAGcnerKlIGeyUHazfI8mTFPFcu9B/IHjGrS3WZKCudMlDf5pzV9Pkv5DawBS/Y/VLWWWNSN60nkklF25vrNVVU7lxNLK+GLev/cXgaqKF56wHVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706739611; c=relaxed/simple;
	bh=5U4/5qMrAvs4IdtfBNx90muP+svLi8zwsySBap8hLow=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KI6e4WJ5chGIXiq9Elw42gpRpYW2ltcE1Yf87VuAfQJJVWqX4EH8ifqMXY69FJ55ocATlybgoOMOYVGni3nalGFNj4kEZaXUN1GMMKGtr1pKtq1MVb+g7FXriJkqWgD8mBPPqHT3Qf7M4cS8CSpr83kUMoJ4ztJxQvfBzNF6LX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EzB4WxSm; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40VMK3sO004384;
	Wed, 31 Jan 2024 16:20:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706739603;
	bh=acmqRyO+tiR9fvXOE9Zst7bxxUMnJ43gc0m2FLXTr24=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=EzB4WxSmjJ0jR4T/P+1NrARX6NiKLyu+GlwS/snGftYSW9lygHBFEnhCBBeLudlOt
	 dQ3KsebUCDuorBG3Yw9Fo+2pPMuyo62GdmFk71gEfEir80HaEW6Oyhc4kT+JSKzi40
	 8tYT6t4ydwW1W8ADsPrL6gRTbOTmUypn0gq163+0=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40VMK3Y4021665
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jan 2024 16:20:03 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 16:20:03 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 16:20:03 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40VMJwxA102504;
	Wed, 31 Jan 2024 16:20:02 -0600
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
Subject: [PATCH 08/12] arm64: dts: ti: k3-am65: Add reboot-controller node
Date: Wed, 31 Jan 2024 16:19:53 -0600
Message-ID: <20240131221957.213717-9-afd@ti.com>
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
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
index f037b36243ced..986684b7a7c43 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
@@ -32,6 +32,10 @@ k3_reset: reset-controller {
 			compatible = "ti,sci-reset";
 			#reset-cells = <2>;
 		};
+
+		k3_reboot: reboot-controller {
+			compatible = "ti,sci-reboot";
+		};
 	};
 
 	wkup_conf: bus@43000000 {
-- 
2.39.2



Return-Path: <linux-kernel+bounces-47249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72034844AFB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 252D81F2AC5D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BCF3F8D0;
	Wed, 31 Jan 2024 22:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NtxkKmlh"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE4E3A8D0;
	Wed, 31 Jan 2024 22:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706739611; cv=none; b=PX8qMjiFZhB3cnEJWWuaOdbfaBC/qkKfA/Jho4pilt8SlEOOh+frrWOP+TjU778houyHhfQCsKzFO2zpJ8k2F3STf/Hn4h0KS8giHL4Ubxx3rzHGCznIRr6Hdn8eAf49xFMtLmExK2W+Zye93064YcySvYnFw8Y0tnajXCk1J3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706739611; c=relaxed/simple;
	bh=uPWhG/KtTJkWfWrszX+pevmCTyHmRbRSuQR2ghNMKo0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fP7jHg59N8z0v0yP226HwbDhBQmr8Is/udAcpl9jaCKcqjKl+JOUrjt6he84vKXFOuTtVeB2cllBGO62Y6M20ldpKsxpqEiCTH2l6Tx+8Rr6I0xtovFSiogIppeaz0drJJKKU6In/EW2XTHEoOedJdMHRLyI+PgZY+OCA3AN8I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NtxkKmlh; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40VMK47c009467;
	Wed, 31 Jan 2024 16:20:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706739604;
	bh=DeArmwL5A6ChLHjlxtBE6qbZsi59MzvYwmK1NjDWhTA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=NtxkKmlhGMmbrpM78+HLhEQN6VuQNMlVUDnq9meAOrC93CyxOkYuz5K65IRJPMUpE
	 hulFBTOlevwGyxOPaCCtwJ0XYjLkhdsLvXOj4h4gG/dbttv0aaLmdx5yPv1SBpxjd7
	 BYpnLOWy5jMdepgjGl7HHNQoIk1rY+oQLCdm6p3Y=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40VMK4P3100786
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jan 2024 16:20:04 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 16:20:04 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 16:20:04 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40VMJwxC102504;
	Wed, 31 Jan 2024 16:20:04 -0600
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
Subject: [PATCH 10/12] arm64: dts: ti: k3-j721e: Add reboot-controller node
Date: Wed, 31 Jan 2024 16:19:55 -0600
Message-ID: <20240131221957.213717-11-afd@ti.com>
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
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index a74912d9e4daf..a1512d9fbb92f 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -32,6 +32,10 @@ k3_reset: reset-controller {
 			compatible = "ti,sci-reset";
 			#reset-cells = <2>;
 		};
+
+		k3_reboot: reboot-controller {
+			compatible = "ti,sci-reboot";
+		};
 	};
 
 	mcu_conf: syscon@40f00000 {
-- 
2.39.2



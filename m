Return-Path: <linux-kernel+bounces-141986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8C18A25CB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9057B225BC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223FF1C29C;
	Fri, 12 Apr 2024 05:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tDpKFLRa"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B5318E1A;
	Fri, 12 Apr 2024 05:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712900233; cv=none; b=r4Y/0S56tB1m7sBWsTMSltacLo+xB7lKUs3QBTS5/i/GyDuRuTNeNgEJONdNwNgC8AwUuVntctwTHx5rEcCeNeKj6IVSuFTlVdDVVV9eErVQuxu9FBpWgSYsPf0nehzcbFtfQWdUegQ+npNpF+UAtVzGacblLBplgjY9CKwm3i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712900233; c=relaxed/simple;
	bh=6oazoK9h8u4QyPD308lPpaj+qMMaE7o6mRVIx7+utRo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pt9h8ymAL46g65XIKjgsIZCpKl33q/gVX80AjvyJeOu2sm5BqiF+r5tNRAx2dnuVsyBaQ6nPeS2UZzHACmbhph+0VcFFjKrGbZ3++tLIXjDOmvm2obRbX/VqSCMjTLXliqgAdRzfB0YPLk1iWiMj8AG1rT+UItIypyTgPg+I584=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tDpKFLRa; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43C5awwb127403;
	Fri, 12 Apr 2024 00:36:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712900218;
	bh=7vvuuLhzWMQA4S6tQ0HDx1Vnj2RKKlHTKCWQaIP/fwM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=tDpKFLRaxn61bRGDSvgLNrJaAxO3RxPtzgDtg0WroQ232E9bUWj27o2RhnCsts4Xz
	 kuFW3G9cZ43gM9P6a8Nd5+iN7OgX6UPa1HRANUlwGpJrhxZmZn/sfk7wGgxQYd/Lqb
	 PhWkIPAEiwKH0EOGInfmFXkb7s0L1bQ2fDEDgWkA=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43C5awfa054776
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 12 Apr 2024 00:36:58 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 12
 Apr 2024 00:36:58 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 12 Apr 2024 00:36:58 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43C5aofY085656;
	Fri, 12 Apr 2024 00:36:55 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <robh@kernel.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <vigneshr@ti.com>, <nm@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kristo@kernel.org>, <u-kumar1@ti.com>,
        <n-francis@ti.com>
Subject: [PATCH v3 1/5] arm64: dts: ti: k3-j721e-mcu: Add the WKUP ESM instance
Date: Fri, 12 Apr 2024 11:06:46 +0530
Message-ID: <20240412053650.703667-2-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412053650.703667-1-n-francis@ti.com>
References: <20240412053650.703667-1-n-francis@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add the WKUP ESM instance for J721E. It has three instances in total,
one in the MAIN domain (main_esm) and two in the MCU-WKUP domain
(mcu_esm and wkup_esm).

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
Reviewed-by: Udit Kumar <u-kumar1@ti.com> 
---
Changes since v2:
- no changes

 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index 4618b697fbc4..3044e08f6858 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -689,4 +689,10 @@ mcu_esm: esm@40800000 {
 		ti,esm-pins = <95>;
 		bootph-pre-ram;
 	};
+
+	wkup_esm: esm@42080000 {
+		compatible = "ti,j721e-esm";
+		reg = <0x00 0x42080000 0x00 0x1000>;
+		status = "disabled";
+	};
 };
-- 
2.34.1



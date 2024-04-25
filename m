Return-Path: <linux-kernel+bounces-159193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E89508B2A81
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 23:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88A411F217FB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F2A155A39;
	Thu, 25 Apr 2024 21:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hGZILYqc"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7583155748;
	Thu, 25 Apr 2024 21:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714079586; cv=none; b=GqekYk4qp6FPW/ARK/v/gA9J2V4rc9Sr0kJJfEwMqn/ag5kQDzpev4526d6GerejoomXn2zNCoTnQkUZEbtIGCY3qDH8KDes0YSp5+6wcFwBWf4TeD5wQQZ285k86Kc18moYEKVk7wFWNG50xcjEtJAY8xYuvHJuN21m4cYMdbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714079586; c=relaxed/simple;
	bh=6oazoK9h8u4QyPD308lPpaj+qMMaE7o6mRVIx7+utRo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q4/rkUtxl3gTdLlkZIONMBQEEjr81VCw9D1hdx9yDSwAhxDbgVcPC2QfuOahP71SO+3CTAx8QZvGYahISGTQoDWUb9QymlHjb8pwrPAmUOWy3G0bN0ovGijZ5TUi3GxqoFaP/ahfoIH4Aybo+x5xrczAc6PhIEHBsGkYFOMxH0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hGZILYqc; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43PLCfXm026528;
	Thu, 25 Apr 2024 16:12:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714079561;
	bh=7vvuuLhzWMQA4S6tQ0HDx1Vnj2RKKlHTKCWQaIP/fwM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=hGZILYqcLdhKDH0RGsh/pNoppd8Ve9TSwmTD1HszMNuILaT4vz8HNm5aZKPUX95Za
	 h4y9DpdMtkANEOYoRhbyNoTxjILOS7uqAJOuHeDIcDL42TyIX57Z6hM0BQs9y+JeBa
	 Q+Is1daMOH4x3tRMux4VX77mnp3WSm4hIYrNuhTQ=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43PLCfRf071321
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 25 Apr 2024 16:12:41 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Apr 2024 16:12:41 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Apr 2024 16:12:41 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43PLCYHD038718;
	Thu, 25 Apr 2024 16:12:38 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <robh@kernel.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <vigneshr@ti.com>, <nm@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kristo@kernel.org>, <u-kumar1@ti.com>,
        <n-francis@ti.com>
Subject: [PATCH v4 1/6] arm64: dts: ti: k3-j721e-mcu: Add the WKUP ESM instance
Date: Fri, 26 Apr 2024 02:42:28 +0530
Message-ID: <20240425211233.2006233-2-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425211233.2006233-1-n-francis@ti.com>
References: <20240425211233.2006233-1-n-francis@ti.com>
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



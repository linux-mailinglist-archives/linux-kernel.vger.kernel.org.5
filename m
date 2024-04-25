Return-Path: <linux-kernel+bounces-159197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF498B2A8B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 23:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60AD11C21B7D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5982A155740;
	Thu, 25 Apr 2024 21:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SkeZfCMz"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06572153821;
	Thu, 25 Apr 2024 21:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714079600; cv=none; b=r962CDKLMC2NASYRcNj1S/xDaGn1zLJx52CNXhOmEHnwiesfxGGCBTgvaUveFN3aJs2hg0gRebjErJEXQvA+JWl72RG+yq61dzJ1NOQqdP+4WoGQ6d5hFCvy8geTF/yGldlh859IDVgSXpkr++hBqdbZ/sc4upToNOUjp2DbUHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714079600; c=relaxed/simple;
	bh=yOKS8YZV/ybtzb2iS5zih1gwklhOMr+sQWecVjYkRXo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tjJWn8FZWhblGfwSdRzc0545xDjr4ZgpNI0pYs40YAqdcwQrM1BtQZJKmDXnsTUSpj+iTwIm4Hf0YsFjXIk28TCZcaLX6mB7I76lEqALsTy2VVNcXxGFQgyyzvfG3OObislrUOtMZzk81AVfDtIXeTmIbc29xC6bCdmpQ0KoT8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SkeZfCMz; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43PLCwLt047734;
	Thu, 25 Apr 2024 16:12:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714079578;
	bh=FBAmrRWmRQ6wUPzz5WQOYydNI4nfgOmhde5mQvluM/E=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=SkeZfCMzMvtJOEZAww70XLZMZ0di0a+IXruZPZ/eaOBEZq5KJm5189q4Sr9H10yM/
	 yY7m5aUeZOfyVzn5Op/oONjD9BKMba6Obm+eeZno99dWMotKxpSWmpXkK7serciGX/
	 sKAiepMxcOBuf4o9LIHjL8oP5Oj0U8ZVdwCGFsRI=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43PLCwPE031324
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 25 Apr 2024 16:12:58 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Apr 2024 16:12:58 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Apr 2024 16:12:58 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43PLCYHI038718;
	Thu, 25 Apr 2024 16:12:55 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <robh@kernel.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <vigneshr@ti.com>, <nm@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kristo@kernel.org>, <u-kumar1@ti.com>,
        <n-francis@ti.com>
Subject: [PATCH v4 6/6] arm64: dts: ti: k3-j7*-main: Add bootph-pre-ram to main_esm
Date: Fri, 26 Apr 2024 02:42:33 +0530
Message-ID: <20240425211233.2006233-7-n-francis@ti.com>
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

Add bootph-pre-ram to main_esm as R5 bootloader configures MAIN domain
watchdog interrupts to generate the ESM pin events.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 1 +
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index b24a6333563a..30ec36ce4ce7 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -1565,5 +1565,6 @@ main_esm: esm@700000 {
 		compatible = "ti,j721e-esm";
 		reg = <0x0 0x700000 0x0 0x1000>;
 		ti,esm-pins = <656>, <657>;
+		bootph-pre-ram;
 	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 0dd5005b34aa..a5dc1e1bc1a9 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -2957,5 +2957,6 @@ main_esm: esm@700000 {
 		compatible = "ti,j721e-esm";
 		reg = <0x0 0x700000 0x0 0x1000>;
 		ti,esm-pins = <344>, <345>;
+		bootph-pre-ram;
 	};
 };
-- 
2.34.1



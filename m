Return-Path: <linux-kernel+bounces-37527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AF583B14A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6115B286B75
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF85A131E3F;
	Wed, 24 Jan 2024 18:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pQEaLkpX"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8173813175B;
	Wed, 24 Jan 2024 18:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706121435; cv=none; b=M0v2qThV6NDpdZOP61hvpep4DVfdplp9Iiqo5KBghsPW0BKzZjeAuR17jcK3rdtZqtSAVD4UOjD5XPxtl1rq7CBHiraVK9IMfJSm4r92JT8YSBiTX/CwZT9OQ3I4LHC7OOXsh+DLD0LZubrqgLG8iHVMekROFESeQd4XTmxU9Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706121435; c=relaxed/simple;
	bh=iG57NcwKzxzsfvNL3nXLFfmGOl0sbfcz5pb2zB8p7UA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bggEn4VMW4XEek3nswrTAKEegnOQXr3BBxGyL1N1cQEIiAOw6UpVVYUKluDOmE9mPqn6ESTtDCNXNuWBW4DfYgJPhrMdyXSvQWG1J1OC6JdWbHOnB0OI/uuhmmkWLLFo83SNAmA14BgL5GsyFQ2x8yBrn1sdNgqhYII6ougBa4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pQEaLkpX; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40OIb1br128720;
	Wed, 24 Jan 2024 12:37:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706121421;
	bh=eMpEFn5T1KMfQWMTOUI/dvHdj9BaMlSxU8vJDfk3c+w=;
	h=From:To:CC:Subject:Date;
	b=pQEaLkpXlIi6Wap/GvGWidEfxxFo+9dMEFfhlLzKRNj63gHheWpO1wn+mzXfobvmx
	 9/9A/70zBWyjzep6TH3GowkmfZHSvPUwLSCslFuc072xc2hj4vFK1rB9Dxxz7JMcSG
	 00+S9yVHVr6qnXksF8RFBaRtfrtPTRQVUxtQqaWo=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40OIb1P7004186
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 24 Jan 2024 12:37:01 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Jan 2024 12:37:01 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Jan 2024 12:37:01 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40OIb0b9106485;
	Wed, 24 Jan 2024 12:37:00 -0600
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
Subject: [PATCH 1/4] arm64: dts: ti: k3-j7200: Enable PCIe nodes at the board level
Date: Wed, 24 Jan 2024 12:36:56 -0600
Message-ID: <20240124183659.149119-1-afd@ti.com>
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

PCIe node defined in the top-level J7200 SoC dtsi file is incomplete
and will not be functional unless it is extended with a SerDes PHY.

As the PHY and mode is only known at the board integration level, this
node should only be enabled when provided with this information.

Disable the PCIe node in the dtsi files and only enable when it is
actually pinned out on a given board.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts | 1 +
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi             | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index cee2b4b0eb87d..7e4fd7ab9750c 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
@@ -382,6 +382,7 @@ serdes0_qsgmii_link: phy@1 {
 };
 
 &pcie1_rc {
+	status = "okay";
 	reset-gpios = <&exp1 2 GPIO_ACTIVE_HIGH>;
 	phys = <&serdes0_pcie_link>;
 	phy-names = "pcie-phy";
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index da67bf8fe703e..1e2434caa7ffa 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -770,6 +770,7 @@ pcie1_rc: pcie@2910000 {
 		ranges = <0x01000000 0x0 0x18001000  0x00 0x18001000  0x0 0x0010000>,
 			 <0x02000000 0x0 0x18011000  0x00 0x18011000  0x0 0x7fef000>;
 		dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
+		status = "disabled";
 	};
 
 	pcie1_ep: pcie-ep@2910000 {
-- 
2.39.2



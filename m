Return-Path: <linux-kernel+bounces-47163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A74844A06
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30A641C23ECA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD64A3A269;
	Wed, 31 Jan 2024 21:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ILL9hilK"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95D53985A;
	Wed, 31 Jan 2024 21:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706736443; cv=none; b=IV9qz5oTKpUqfM8KDVTZwon/VpuZFNoFvH0Sgl+AHwMwWWrAuWUzgZC8ffPhAoEjcs8A37bwAJHDa3rCJNf7/gq+M2AGkk7C0alIMBMDKEQo/5Qy62m8KebUog2Got5+66SUQuoCjAugDCtC5rmvxUa8GKKEjHxtNsIWEbTGvps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706736443; c=relaxed/simple;
	bh=yt9psF5IRs81U5C+9xkN7K31Matcn+wnh8R/IVbMBZA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lSxV/6BnyTMLmOwmDn2h9wn31O8DY5dUHqc9egMBjVo+kdbFyFv1sHPVjj1aWxwsfOE7HxCx3UWTXOaMoDS1w+FPvkXRFLeuwbbxGlARIwtb7P4I0/4bTUikmEtW0KhL1e7wHnnSCf6GNc4y03IMNhse7TEEUkI7SAg+zn2a/5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ILL9hilK; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40VLR21w119715;
	Wed, 31 Jan 2024 15:27:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706736422;
	bh=1zKXhHjt+qBNFsrJT3Wquxk0cPsgwbFvGgLTNOPAbd4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ILL9hilKJ+qNTEpR+3GxaS+JR4wZk2qFp92ipCb+CCRAEJEz+XvGzMhpZCJ0zGMAE
	 kYJU8wyIoNSDHC+c1P3f2XOLbQw7zK4SIbbyZBljNRFUPFLGu9a4kJH+aRKkKlVbb4
	 DqntybRP5xD73MjfgoKCOAyVuJq+zlL0/JeecBvA=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40VLR27N040923
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jan 2024 15:27:02 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 15:27:01 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 15:27:02 -0600
Received: from udba0500997.dhcp.ti.com (udba0500997.dhcp.ti.com [128.247.81.249])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40VLQfKR028966;
	Wed, 31 Jan 2024 15:27:01 -0600
From: Brandon Brnich <b-brnich@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon
	<will@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Geert
 Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Konrad
 Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?=
	<nfraprado@collabora.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Darren Etheridge <detheridge@ti.com>
CC: Brandon Brnich <b-brnich@ti.com>
Subject: [PATCH v3 2/6] arm64: dts: ti: k3-am69-sk: Enable Wave5 Video Encoder/Decoder
Date: Wed, 31 Jan 2024 15:26:21 -0600
Message-ID: <20240131212625.1862775-3-b-brnich@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131212625.1862775-1-b-brnich@ti.com>
References: <20240131212625.1862775-1-b-brnich@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Update status for both Wave5 VPUs on AM69.

Signed-off-by: Brandon Brnich <b-brnich@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am69-sk.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
index 8da591579868..6abfc0630f7c 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
@@ -800,6 +800,14 @@ &main_gpio0 {
 	pinctrl-0 = <&rpi_header_gpio0_pins_default>;
 };
 
+&vpu0 {
+	status = "okay";
+};
+
+&vpu1 {
+	status = "okay";
+};
+
 &mcu_cpsw {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.34.1



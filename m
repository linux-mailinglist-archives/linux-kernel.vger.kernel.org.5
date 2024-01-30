Return-Path: <linux-kernel+bounces-45222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7438842D54
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39822B22EFA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F466F08E;
	Tue, 30 Jan 2024 19:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fFlEkusr"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC24D7B3F6;
	Tue, 30 Jan 2024 19:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706644301; cv=none; b=rT2QWZntfOC4V0a8IHfDGLYgB6v+WkUnCp+njRjztdtHhGcMXCBFeChHk7kQDx0d9TUnTT8Y1DjD6aZFisGEStFvaPAg16bNKCMXv4dNg7z39IbfIxFl38o2dQSsyPHG+90HRGYHvyuhbrY35xyQmzT1x0pLmIWyRPPXEiqgDxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706644301; c=relaxed/simple;
	bh=RO88XeQOTblJOni8gFGayt2JWJIos1QyjNoFHXD8EKY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kWQyAxSVZDhTPDZ6ZuVk6ukX5epDDABBTmJ6pvjHvANWjmajdPqzsoob7+aOR7yGrAPE8/5HCEJHDLELorTDE9scBMRQTPuBWxWnPLW13f1SFtuZ7+HZkga7noT49e95bjhsyVlZuyQIB+yzjD0OF4cBxQQyPEYItsfEYXs+96c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fFlEkusr; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40UJpUMT090050;
	Tue, 30 Jan 2024 13:51:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706644290;
	bh=Hz9x1qh2ZfSepIaUFBwFwX4XigsDM5yxW6ZItLlcZW0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=fFlEkusrvNzNvZN5Iy8KkwJ7mScbBxHJW3aGqW8UhalgdoLiAJyD7AJelvlUUv0AB
	 a6OMarGTdFS0se4nfIASTkPnaT+X1fdjVfjL2J0/EdpZgeAtWkFNxmcoCDs5gtbdA8
	 eNOQEOpg7oJ6euhpOwXkhmGYqt+T9+FulUoIMRtk=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40UJpU5s048575
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Jan 2024 13:51:30 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jan 2024 13:51:30 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jan 2024 13:51:30 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40UJpTKw005747;
	Tue, 30 Jan 2024 13:51:29 -0600
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
Subject: [PATCH 2/2] arm64: dts: ti: k3-am65: Add full compatible to SerDes control nodes
Date: Tue, 30 Jan 2024 13:51:28 -0600
Message-ID: <20240130195128.58748-2-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240130195128.58748-1-afd@ti.com>
References: <20240130195128.58748-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This matches the binding for this register region which fixes a couple
DTS check warnings.

While here trim the leading 0s from the "reg" definition.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index fcea544656360..62a68740dac6e 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -483,13 +483,13 @@ scm_conf: scm-conf@100000 {
 		ranges = <0x0 0x0 0x00100000 0x1c000>;
 
 		serdes0_clk: clock@4080 {
-			compatible = "syscon";
-			reg = <0x00004080 0x4>;
+			compatible = "ti,am654-serdes-ctrl", "syscon";
+			reg = <0x4080 0x4>;
 		};
 
 		serdes1_clk: clock@4090 {
-			compatible = "syscon";
-			reg = <0x00004090 0x4>;
+			compatible = "ti,am654-serdes-ctrl", "syscon";
+			reg = <0x4090 0x4>;
 		};
 
 		serdes_mux: mux-controller {
-- 
2.39.2



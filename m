Return-Path: <linux-kernel+bounces-119728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA1188CC78
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF3D8309715
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087C513C9D6;
	Tue, 26 Mar 2024 18:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gpEL67fg"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C069213C8E4;
	Tue, 26 Mar 2024 18:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711479398; cv=none; b=jp2UYTjO5KYt5lVOfn0MRKJ8j1ki/MY8M7Akg7B6lddclvLU+Pmh8eJNnNhIbHueNoROpCq+jZ3q6Z63fz9QTuFXq8x/XWAuiYgA0AIm8REUsW+Wg+6CKWsZJLd3+rGwJl08d22V242Y5iqRxnFO6iiYPH/yTh+EeYlYRoYnqgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711479398; c=relaxed/simple;
	bh=Z6UlkkledCU4/2smMKSjUnj+jm96rDpmadhXGOBwObU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CKRiMymlG3eP8oO2ZhigWV0yPu1rHMRv8x7uErU01qb2v+3jNvMOjvhdLJEd+5V6v2GVgESAgb2RKVs5ab6rrSLeAaL3sj/zbScxvSsNKvTiCvuiM2pi5L1ZdRmgkC+u+o/0rZgXFWuaDXFVSXrzCInE9gyOOnqaAMQM40M2rbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gpEL67fg; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42QIuTvw041209;
	Tue, 26 Mar 2024 13:56:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711479389;
	bh=2PvbqEDyejopBiHz9ZvkYFmBzkbgrJNY22MumI3wI9g=;
	h=From:To:CC:Subject:Date;
	b=gpEL67fg7ugUKZ2zqhQhoE711vMUibF70qZVFMSN+4e2PksuZjXr/3doRsINg6onQ
	 vPgbiMVfF0VUDsHAU2JjTf5sM0SA8cEC6KL8acbPV8aynrEl4DkORIg9SKwGoHtnLt
	 /YHoLYsXv25hUK5ajF4nsNU//zcBSRepHu0k4wWw=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42QIuTRI101909
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 26 Mar 2024 13:56:29 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Mar 2024 13:56:28 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Mar 2024 13:56:28 -0500
Received: from fllvsmtp7.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42QIuSZ5093125;
	Tue, 26 Mar 2024 13:56:28 -0500
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
Subject: [PATCH 1/2] arm64: dts: ti: k3-am65: Add full compatible to SerDes control nodes
Date: Tue, 26 Mar 2024 13:56:26 -0500
Message-ID: <20240326185627.29852-1-afd@ti.com>
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

This matches the binding for this register region which fixes a couple
DTS check warnings.

While here trim the leading 0s from the "reg" definition.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index ff857117d7193..738c5c4acbcd2 100644
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



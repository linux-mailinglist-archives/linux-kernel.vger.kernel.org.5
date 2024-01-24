Return-Path: <linux-kernel+bounces-37546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A9B83B174
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A59F7289130
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E14B134757;
	Wed, 24 Jan 2024 18:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tPYZguiw"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3BD132C0D;
	Wed, 24 Jan 2024 18:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706122058; cv=none; b=Q8Ttiz2vGmQpuAn9cEHBif3OZw/RjSysbTHBcP/mMaDFpxKGlUdo+SZyAKbDJYgElxYiJ5RjxqNXiMMLcGSVMB0TgRinrzrGfOrQt2GcbiDqggR0tdJfL/JT6cY3hscV4BAG5oK1jFtodHyVOiO3hKvBE3S0h7zqWl5bhFpau4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706122058; c=relaxed/simple;
	bh=DrTAZKF5736ObEIMtMzHc1o3LhiYd+ETBzd2tQLud9A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HPysbuABk9eqCIazwO3x5qKU/P3I/ARKJjnFYqc8v6FBAALws61bWCbUAnwTTUiS2tt4Op0djqRVdGR7DzZ7ugGxmCFzU5sUX8vReBo8Te594/TBjG/5cNjfm7Ql/Ej2ruEJTCANZ+HkqkPt3c8Pp+egf4olClH4vwN1qOvivDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tPYZguiw; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40OIlSgq093982;
	Wed, 24 Jan 2024 12:47:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706122048;
	bh=becmkEh0ceKIBX8EEyQgA6Nc9kWrrZwFLJkI8S54o3U=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=tPYZguiw8zI2LzB9qlmnnDvRZkInLDN9iiTnwQptz8CjiO5Xs2bB8ZImQqurKcWln
	 Y/plrmiHiZpPvDiXSA1Rltx+W4eo4Sh4tXKZWXR5V0NmUYHTtQMbwZ2mjG5mRSYuAQ
	 t+Ayrgshd8HBWWYJb96ZRDCFcUKkAATr+PQxS+Tk=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40OIlSvX127988
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 24 Jan 2024 12:47:28 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Jan 2024 12:47:28 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Jan 2024 12:47:28 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40OIlNaX119099;
	Wed, 24 Jan 2024 12:47:27 -0600
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
Subject: [PATCH 11/11] arm64: dts: ti: k3-am62a: Make the main_conf node a simple-bus
Date: Wed, 24 Jan 2024 12:47:22 -0600
Message-ID: <20240124184722.150615-11-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240124184722.150615-1-afd@ti.com>
References: <20240124184722.150615-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The main_conf node does not need to be a syscon, so change to
"simple-bus". This removes a DTS check warning.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
index f0b8c9ab14593..eb3b6679e612c 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
@@ -42,9 +42,8 @@ gic_its: msi-controller@1820000 {
 		};
 	};
 
-	main_conf: syscon@100000 {
-		compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
-		reg = <0x00 0x00100000 0x00 0x20000>;
+	main_conf: bus@100000 {
+		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x00 0x00 0x00100000 0x20000>;
-- 
2.39.2



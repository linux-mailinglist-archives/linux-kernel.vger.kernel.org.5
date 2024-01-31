Return-Path: <linux-kernel+bounces-47245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3DF844AF7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ED4D1C21DDB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A5A3CF40;
	Wed, 31 Jan 2024 22:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tb5eTch3"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A6A39FF4;
	Wed, 31 Jan 2024 22:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706739610; cv=none; b=dgU5kbulNOpzmHv7TuoCTq7K8h3B3K6VFuDVwO1quIx9ckSrY8SAivTV3T+As4gAsJq7Dcd6Bzo9eBMT95JcXprrh2mc9xZjRzQRJgK0Dcmm6QpJCM14NpWocglZOI6NSyxUOdMgD/eLONB9EBcQc5fGcuJC2xVZ0kod4W3BmGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706739610; c=relaxed/simple;
	bh=F/FnECU63FRq2A383Tk+QpslYnY6qNtU63SkL8HeUd8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XU4Yg+e8tUUzvhH7mj1VAYWYfGTbtj+ENaXKapWyzyh5K4HwAdGXaviV929zJwGoPKUmUiiImGVwEdszEQMuKqGcUGz2Kxc/4cCZOMETIDDydpRgwG+itrW4Is1m/Qps/4UnNYCedAmnv2LP8h1NvFZsoQvFU6YZadzXXp39DbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tb5eTch3; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40VMK3Bg010424;
	Wed, 31 Jan 2024 16:20:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706739603;
	bh=bJezzvZCS+PMZW3omJ3JmDnR/p5mY4rG5hJQxDz2DY8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=tb5eTch3dL02rBTSysLAjCjAfCpsgddGgxNUTKWCAQhU+CUw70UGtShWlnYviSXfF
	 gtp7K5muoQAORlFyZJtV6EmY81fTT5IwawYyQCqLXQkngaFZ4DFbrytxbk/40HdIF1
	 eqY78hbe5eiijznPO0JdHtQUm8BwXKzX/A6Zd3zY=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40VMK33U100619
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jan 2024 16:20:03 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 16:20:03 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 16:20:02 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40VMJwx9102504;
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
Subject: [PATCH 07/12] arm64: dts: ti: k3-am62p: Add reboot-controller node
Date: Wed, 31 Jan 2024 16:19:52 -0600
Message-ID: <20240131221957.213717-8-afd@ti.com>
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
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
index 4c51bae06b57e..7a10ed7a41a23 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
@@ -185,6 +185,11 @@ k3_reset: reset-controller {
 			#reset-cells = <2>;
 			bootph-all;
 		};
+
+		k3_reboot: reboot-controller {
+			compatible = "ti,sci-reboot";
+			bootph-all;
+		};
 	};
 
 	crypto: crypto@40900000 {
-- 
2.39.2



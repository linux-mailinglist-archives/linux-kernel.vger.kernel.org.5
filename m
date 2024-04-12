Return-Path: <linux-kernel+bounces-141921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D93EB8A2521
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F2D31F24AA7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B641B5AA;
	Fri, 12 Apr 2024 04:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QZunGuw9"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793B6182B1;
	Fri, 12 Apr 2024 04:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712895952; cv=none; b=j1o2tL/aDvGUThIVtwaVE6my9Wbn/df9iRa3UPonfzt3wqJKQpnX5Tl3FpugsH5B/RzXWY7dperPHoM+YybQ7wkO6CJ5ctkFxpOsEUrziaieANi0sZGvslKS26gB1Vv9RTfObOtETNc8iJT4Gj7dMI0lboCM9vG/CDkSRg1p6pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712895952; c=relaxed/simple;
	bh=z1shp2lDbGf9G99E7ExYumPRY1mwGImvju1nutqdpKM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NQgJOKAUmhwZTrvW5N4eb7K85JuJn35FfxeWeZ0I9nsWdF4y379gzlA4KNrQ0PWE9qCw0KyhgL88ouqSRZssT3Ol6UXThxl28buCKhWLp7SQ0ZHyb5fCSpr7b9yEgEBu0H7AMO49vhJUdwMEmL+QVkYlSiC2Mv8l9XuHpUYuDWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QZunGuw9; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43C4PjWx111642;
	Thu, 11 Apr 2024 23:25:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712895945;
	bh=h7pbpM3vg0J1IPqj55MU3l706aCm+pPTpUCVzh9YTbY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=QZunGuw9u1PxWk7yq9ZVN0l3UcLo/r8xi9mV6WOpi4vXxkoJZNCn3cco0+moZ/rew
	 GK1qKpyGE0mFJlDGH0MvtgJ/J/VhEeUEjPYdBly/Hws1DbcAoWdX86ayZo0JZDmC3n
	 MIzBcRpRMB7vC+PmUsGk3PPqQ90oVFkTsDmFwFAc=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43C4Pjhg122975
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 11 Apr 2024 23:25:45 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 11
 Apr 2024 23:25:45 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 11 Apr 2024 23:25:45 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43C4PbNb078207;
	Thu, 11 Apr 2024 23:25:42 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <robh@kernel.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <vigneshr@ti.com>, <nm@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kristo@kernel.org>, <u-kumar1@ti.com>,
        <n-francis@ti.com>
Subject: [PATCH v2 1/5] arm64: dts: ti: k3-j721e-mcu: Add the WKUP ESM instance
Date: Fri, 12 Apr 2024 09:55:33 +0530
Message-ID: <20240412042537.666137-2-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412042537.666137-1-n-francis@ti.com>
References: <20240412042537.666137-1-n-francis@ti.com>
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
---
Changes since v1:
- marked status as disabled

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



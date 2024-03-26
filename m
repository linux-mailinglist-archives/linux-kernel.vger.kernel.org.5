Return-Path: <linux-kernel+bounces-120065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3606088D11D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92982B23D1C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7772913E020;
	Tue, 26 Mar 2024 22:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ar7eF3BI"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCAC8664C;
	Tue, 26 Mar 2024 22:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711492661; cv=none; b=elIKYriezKlYjgOUSdIjrXaQ1cDwyxYTjqeWzElsyYYK9g6Bpzn+wD9BjM5ulLY1vWxuGNtqQ7FMOeG8UjYRRF7ctHSgV4VRDaYpw+ROeMcOANSQZy3+VxS0BP+cu2/s4fo3OyttanV8H6O1Wu9jbgI2cqiuJcg6Pe8OuYUKjqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711492661; c=relaxed/simple;
	bh=KfT2XIXDnVAIka3gI9AAhlkKtIbWqm728uwpBulIcXI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UIue3ULFeU3ZI7WzA7W+4CyzIC3cAuxkZbZIyJnFofdV4YA+ceYSHIFA94rdnrMtS4lIglnA2wDFZoC2XM3VYwHbtwMpkuebPZA/jiVKu1Xgchuj6cyuSVXlGUwrtwo7uVVEOdKz6F7jVR8O3iZNvwa26EpQgsCcEAPVIrXAsbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Ar7eF3BI; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42QMbX5P117999;
	Tue, 26 Mar 2024 17:37:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711492653;
	bh=WqdWf4g6YBQDgfjZS/u2rNlfM6pu58G4U7P0RsBUz0g=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Ar7eF3BI7MlZXytugsZ5b9P3qX7v52ROwJFjmHbS08qoTnhRjrQ/0da9ujjJAzXi3
	 3XNlJ/E/9m9lBPZFKvzw5Re/9Ky1PaUmzTAJAqh0Ld6C1kUWgQW/kkFa5Lc1niNUfT
	 ptuxHMuGdzXVQzrtOggsurEUJznLUspNzRKJCtFQ=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42QMbXpJ045392
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 26 Mar 2024 17:37:33 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Mar 2024 17:37:32 -0500
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Mar 2024 17:37:32 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
	by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42QMbVma109669;
	Tue, 26 Mar 2024 17:37:32 -0500
From: Andrew Davis <afd@ti.com>
To: Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 3/4] ARM: dts: ti: keystone: k2g: Remove ti,system-reboot-controller property
Date: Tue, 26 Mar 2024 17:37:29 -0500
Message-ID: <20240326223730.54639-4-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240326223730.54639-1-afd@ti.com>
References: <20240326223730.54639-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The property ti,system-reboot-controller is no longer needed as the reboot
handler is now always registered. Remove this property.

While here remove the comment about delete-property, all K2G platforms use
PMMC, and it wasn't good advice anyway.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/boot/dts/ti/keystone/keystone-k2g.dtsi | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/ti/keystone/keystone-k2g.dtsi b/arch/arm/boot/dts/ti/keystone/keystone-k2g.dtsi
index 790b29ab0fa2c..dafe485dfe197 100644
--- a/arch/arm/boot/dts/ti/keystone/keystone-k2g.dtsi
+++ b/arch/arm/boot/dts/ti/keystone/keystone-k2g.dtsi
@@ -256,11 +256,6 @@ msgmgr: mailbox@2a00000 {
 
 		pmmc: system-controller@2921c00 {
 			compatible = "ti,k2g-sci";
-			/*
-			 * In case of rare platforms that does not use k2g as
-			 * system master, use /delete-property/
-			 */
-			ti,system-reboot-controller;
 			mbox-names = "rx", "tx";
 			mboxes = <&msgmgr 5 2>,
 				<&msgmgr 0 0>;
-- 
2.39.2



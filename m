Return-Path: <linux-kernel+bounces-47243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3441A844AEB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97C47B23AC4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825D13A8F2;
	Wed, 31 Jan 2024 22:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RtmunIjO"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214E839FE3;
	Wed, 31 Jan 2024 22:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706739609; cv=none; b=XTYs5uP5hlbVvlfBls6WJOJ3smIzUkLf7B6v1v0PF5SGy9xaJ55QZnxTIs9RB8v8zq4idAWDlmKnHC102O5lRnewAkJg++eiVDADDqGVCw2gvfhbajdwIYT4oCQF7svUGv1e+dPyiltkOBU63TP5TTWHO5PD4Gq/ZpYTpwqCNF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706739609; c=relaxed/simple;
	bh=Ceku6KOeH22JGvzJEnc13AFmxOzjxHH5/T5neKtxgds=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WAfUSU7Dbb1TJ7NcUU6xzXfMINabuCDVLIEmb+7UO/99CYsd9JTtDO9s097ZzPEHItwMaRxvt7kvRRuAsXUrNiV9DzOx+A3XAwXErVAmYMBPWEu0hXX2727o10e5pTW5K/yxaSt2s7y9pIYf5oia8DZe7Q02k19jUjrBb3dxmz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RtmunIjO; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40VMK25X009452;
	Wed, 31 Jan 2024 16:20:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706739602;
	bh=8beJqyzumN9+CMCul7JvqwxP0DOUWWCHmJavY3XFYug=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=RtmunIjOWplS8pzTdSkBMjo/NrTviIck7Fc43LwA+pVc9eKuw5FMo2ldzeNQA4NHG
	 ECPBN8Q+nC7N6p+bv7sOD85jZCSWPkzl8/NoG9EwHiRT8+PVywkhzRlA2mgmiAX0as
	 pU2hhyqagA6Vui8dtg5kd9WfEj9N3LGZsGftWepA=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40VMK2ua021601
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jan 2024 16:20:02 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 16:20:01 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 16:20:01 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40VMJwx7102504;
	Wed, 31 Jan 2024 16:20:01 -0600
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
Subject: [PATCH 05/12] arm64: dts: ti: k3-am62: Add reboot-controller node
Date: Wed, 31 Jan 2024 16:19:50 -0600
Message-ID: <20240131221957.213717-6-afd@ti.com>
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
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 464b7565d085d..eb71523e85c36 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -203,6 +203,11 @@ k3_reset: reset-controller {
 			compatible = "ti,sci-reset";
 			#reset-cells = <2>;
 		};
+
+		k3_reboot: reboot-controller {
+			bootph-all;
+			compatible = "ti,sci-reboot";
+		};
 	};
 
 	crypto: crypto@40900000 {
-- 
2.39.2



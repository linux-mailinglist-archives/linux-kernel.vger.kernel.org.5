Return-Path: <linux-kernel+bounces-46126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79787843AF0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EE891F2B2AC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669AB60DCC;
	Wed, 31 Jan 2024 09:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GBo51MQk"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265F651004;
	Wed, 31 Jan 2024 09:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706692854; cv=none; b=SK16ozQLOO7teyuZ3Z00lTyPLw9uFFu4MOvcsA84D+wfbiGSISr7Xka8TICGLS21Mk7eZqZCUbPhrXMJr8E8K3zfSalLpWtMPViYdPkM2/6gFVtFIex4dt+J32xQm18qt4K3mBzpdFRON2Ts/HVjRTVrEkCbX13kHkVWtHyhZ1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706692854; c=relaxed/simple;
	bh=jIsmj/fajb8fLMrkt4vd3Va8zdtqD37LgPLYgc7tpSc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kcYcw2uBIinIblCLnmzZvclUf+QlU6gt7WraWuCGXYgwSPAB4gQkf6q5VGsKNcCiYAMaPN46twKcVESZXS/QDvMXxqwg0tjzw4GQA+LhlEAXTP74EDLL/JoBLqHxA+XP4fCCzH00ax4HJw+bT6eeYaoEKDHYK2MFoQ0tPZpmHag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GBo51MQk; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40V9KlHk050591;
	Wed, 31 Jan 2024 03:20:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706692847;
	bh=NdJG3JLfxJTk4/tJ2ziGMOaQE3dDkvwsm8Xe6fCQ6ZA=;
	h=From:To:CC:Subject:Date;
	b=GBo51MQk7VchxZ4VOqMiL/7K307iXcQVKAXY2kBwtC00PuGaVZ7e1e18BylcRd4QL
	 hmm9g2kWyhELxqv2W4iVmTB/lDe9+q58Gnrl9g/ih7FUTnYbRtc0aHaWFodhazuCp+
	 V7h+DpJMV2dkzcY+xZ9DCeI5B71uHFoL0s1CChZc=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40V9KlJt015283
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jan 2024 03:20:47 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 03:20:47 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 03:20:47 -0600
Received: from uda0500640.dal.design.ti.com (uda0500640.dhcp.ti.com [172.24.227.88])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40V9KhAq037487;
	Wed, 31 Jan 2024 03:20:44 -0600
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
To: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <brgl@bgdev.pl>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <nm@ti.com>,
        <vigneshr@ti.com>, <r-gunasekaran@ti.com>, <srk@ti.com>
Subject: [PATCH] dt-bindings: arm: ti: Update maintainers list
Date: Wed, 31 Jan 2024 14:50:43 +0530
Message-ID: <20240131092043.28829-1-r-gunasekaran@ti.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Update the list with current maintainer of TI's davinci
platforms.

Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
Acked-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
Added Acked-by after discussing with Bartosz over mail.

 Documentation/devicetree/bindings/arm/ti/ti,davinci.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/ti/ti,davinci.yaml b/Documentation/devicetree/bindings/arm/ti/ti,davinci.yaml
index 1656d1a4476f..1b64458fcadd 100644
--- a/Documentation/devicetree/bindings/arm/ti/ti,davinci.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/ti,davinci.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Texas Instruments DaVinci Platforms
 
 maintainers:
-  - Sekhar Nori <nsekhar@ti.com>
+  - Bartosz Golaszewski <brgl@bgdev.pl>
 
 description:
   DA850/OMAP-L138/AM18x based boards
-- 
2.17.1



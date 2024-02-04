Return-Path: <linux-kernel+bounces-51542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C8A848C59
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 10:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40176281C9A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 09:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E5414AA0;
	Sun,  4 Feb 2024 09:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pgjn5A/A"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C32171A4;
	Sun,  4 Feb 2024 09:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707037442; cv=none; b=uDb/phw0mBUrM+qMjksUJ3ESjaHaiolaKxlQeSeTtvubA47XlEyHz+rURPOo1eTr3BkYAecTdSLQx3WoMiaxwYkxKkLkzfafpWMQ61w1NgCHfNdvJBXAkh77AiZd40WO+QShkr7kr0cXgtiXqqzwCzRhK2CdppENtEB//vRc8Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707037442; c=relaxed/simple;
	bh=jF0w1R3K6lY6TNEDoBHEPF68k8xKzvT4f6kJeXJ6fbE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ux38d4C4dFb9J2bDhEtf0xE6M5U3QoYHLQARBpMTp5BRQ3IJulW0X6TBcTc3r4lMJIoGLcHzM5UOoOO5Z0bmvK5kbp5vbUp34NCJ98OvU4fwGqdagkI29N4semdo301XI7R62ddHfqrcrQfilDUQ9BJHdDy4Igk4cu+bRhwdpj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pgjn5A/A; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41493eVh075412;
	Sun, 4 Feb 2024 03:03:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707037420;
	bh=d7UPPrPOD40sPgSNdfcsyxepCid0SjSq84tpHp7IiJ8=;
	h=From:To:CC:Subject:Date;
	b=pgjn5A/AtQAEpw7f0PqQtCKLLwKjl/gHnRwDqsYnNm7lw+oO0W0WTgu6SlreuFudL
	 5rTPeA3nEGELzQbYOOkiBrQTDoDiOjceq9D8bHl5scB5EXX2rX/X7EN3VF+f3U5FMs
	 nwA6TCxOY47Sp95auTeFk/0H4Nidw+E3kwbTfows=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41493eXV005601
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 4 Feb 2024 03:03:40 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 4
 Feb 2024 03:03:40 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 4 Feb 2024 03:03:40 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41493a97125185;
	Sun, 4 Feb 2024 03:03:37 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <afd@ti.com>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v2] dt-bindings: mfd: syscon: Add ti,j784s4-pcie-ctrl compatible
Date: Sun, 4 Feb 2024 14:33:36 +0530
Message-ID: <20240204090336.3209063-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The PCIE_CTRL registers within the CTRL_MMR space of TI's J784S4 SoC
are used to configure the link speed, lane count and mode of operation
of the respective PCIe instance. Add compatible for allowing the PCIe
driver to obtain a regmap for the PCIE_CTRL register within the System
Controller device-tree node in order to configure the PCIe instance
accordingly.

The Technical Reference Manual for J784S4 SoC with details of the
PCIE_CTRL registers is available at: https://www.ti.com/lit/zip/spruj52

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
Hello,

This patch is based on linux-next tagged next-20240202.
v1:
https://lore.kernel.org/r/20240131112342.1300893-1-s-vadapalli@ti.com/
Changes since v1:
- Changed compatible to be SoC specific.
- Updated commit message to be SoC specific.

Regards,
Siddharth.

 Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 084b5c2a2a3c..2376b612f94e 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -73,6 +73,7 @@ properties:
               - rockchip,rv1126-qos
               - starfive,jh7100-sysmain
               - ti,am654-dss-oldi-io-ctrl
+              - ti,j784s4-pcie-ctrl
 
           - const: syscon
 
-- 
2.34.1



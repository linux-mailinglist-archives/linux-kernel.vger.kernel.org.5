Return-Path: <linux-kernel+bounces-46340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EEB843E3A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5529C1F283F6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9034F74E04;
	Wed, 31 Jan 2024 11:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hoEfERqh"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DFB6D1C3;
	Wed, 31 Jan 2024 11:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706700235; cv=none; b=hOtDdQ+1OXkc7tULcHtveqZsAcTgeNWTU4HOALZVjSWnJnYmzlDTb3w4hFycpOa4segDTzpRcOOZ+w07Brs5t3JHmca81X+UJThRdUuEzN/gpY8y07y5cMyHYfEMbwgbyOxAjo6PlJ3KJVqHvxPyk0rk8wfp9DiPJx2BitqPbuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706700235; c=relaxed/simple;
	bh=5P2zxSLURVbZ7HV4GWIOUHTQn5EE9g7rJ053+yGyBdI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CZlh5IIX/hdn1441+F/Ei7USsAX59MNRnnNwhAe+ObsmCkr4cZLeSRNwu1lHBBVadmyKkH4wa/PpqCKjPdCCrJETiqpErksFdxjyiu003sIwNvRRPpJZ4TRXr4d+PZtJ4jMdryzHUGlXsRw8LrT+yqmBe0nhrKPpGfGDLHqEGiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hoEfERqh; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40VBNkai084617;
	Wed, 31 Jan 2024 05:23:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706700226;
	bh=QHkI07X0GJZUyie1k7oMk2KLJoEEG+8fx6H0YqKqWqI=;
	h=From:To:CC:Subject:Date;
	b=hoEfERqhykt3Lls/Zt5JVcFdMdmwA14AHjntS+IAi4BtrT0o1+iNLG+5x+yDn7zjt
	 hI4CquO0gvbOc4LcsdI/9QY83oHsdgVlNQEjLDXZHeQiLBED5nlh/y6U19DFex6bfr
	 mhUOvof5aaHYTJTr6cvKt0mnyW0AIMLF3AuXkyCo=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40VBNkT9075512
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jan 2024 05:23:46 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 05:23:46 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 05:23:46 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40VBNh0F066660;
	Wed, 31 Jan 2024 05:23:43 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <afd@ti.com>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH] dt-bindings: mfd: syscon: Add ti,k3-pcie-ctrl compatible
Date: Wed, 31 Jan 2024 16:53:42 +0530
Message-ID: <20240131112342.1300893-1-s-vadapalli@ti.com>
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

The PCIE_CTRL registers within the CTRL_MMR space of TI's K3 SoCs are
used to configure the link speed, lane count and mode of operation of
the respective PCIe instance. Add compatible for allowing the PCIe
driver to obtain a regmap for the PCIE_CTRL register within the System
Controller device-tree node in order to configure the PCIe instance
accordingly.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

This patch is based on linux-next tagged next-20240131.

 Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 084b5c2a2a3c..da571a24e21f 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -73,6 +73,7 @@ properties:
               - rockchip,rv1126-qos
               - starfive,jh7100-sysmain
               - ti,am654-dss-oldi-io-ctrl
+              - ti,k3-pcie-ctrl
 
           - const: syscon
 
-- 
2.34.1



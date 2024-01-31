Return-Path: <linux-kernel+bounces-46083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA68843A0F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BEB51F2F578
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0690C67E6C;
	Wed, 31 Jan 2024 08:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YLJOYTQ3"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45159679E7;
	Wed, 31 Jan 2024 08:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706691247; cv=none; b=uDZoL3dRectHN40GqWu81fK8JO8fSMrHKxfy1c62okmi2gZGxVGU6ULR8V451vgYXmj6yTEf1LzmqH3E5JQW92NvIna8f9PxzfCdQrBMNZsWMAVIFkiyfgSqYGnWSVeyFZ6HxWNswYTOauQUZbSxUOAJ75b/u+kz5yuDj60UCO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706691247; c=relaxed/simple;
	bh=Yq2n/Sfh/d+tpcr27V4STsJGXvRFCM/Exbdl8+V33jQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sf/mKixq4NC1UjQ382qrPpNateuEhLVabTLJhH6P4vCXePt/yZTWF2KjTU9GBE7PKI9cwx8dJF9LqoDkimScbfEWMPoHPZ4K3WHmIiuZZaS836DLEfhztGTGGQ30sBNFuyEGltL1aZpzugr+FjzLXwLGsvnL228kW924P5euQZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YLJOYTQ3; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40V8ru5d119174;
	Wed, 31 Jan 2024 02:53:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706691236;
	bh=P3p6Pw+gRR2W4dVZvVjmTZdIBjEbZqZZnvgFeXT2zks=;
	h=From:To:CC:Subject:Date;
	b=YLJOYTQ3fcHfjlGDJEGWyputUKM0rXPVe/EvkocLIp+v68ctJnTU62d2oM8PCI6oI
	 AoBr8PrmuGwvsJPeD+8Kq8u3BdoZLBWOc7IB2RFr+ln3s8EWNgRWnoaqrWxFpZ5JlH
	 X9waIjEku/QjvPyBBNNTkylwbXWMTmM3EsxM0Y/s=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40V8ruds116100
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jan 2024 02:53:56 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 02:53:56 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 02:53:55 -0600
Received: from uda0500640.dal.design.ti.com (uda0500640.dhcp.ti.com [172.24.227.88])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40V8rpYG125241;
	Wed, 31 Jan 2024 02:53:52 -0600
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <s-vadapalli@ti.com>, <r-gunasekaran@ti.com>,
        <rogerq@kernel.org>, <srk@ti.com>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] dt-bindings: net: ti: Update maintainers list
Date: Wed, 31 Jan 2024 14:23:51 +0530
Message-ID: <20240131085351.25103-1-r-gunasekaran@ti.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Update the list with the current maintainers of TI's CPSW ethernet
peripheral.

Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
---
 Documentation/devicetree/bindings/net/ti,cpsw-switch.yaml    | 5 +++--
 .../devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml       | 5 +++--
 Documentation/devicetree/bindings/net/ti,k3-am654-cpts.yaml  | 5 +++--
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/ti,cpsw-switch.yaml b/Documentation/devicetree/bindings/net/ti,cpsw-switch.yaml
index f07ae3173b03..d5bd93ee4dbb 100644
--- a/Documentation/devicetree/bindings/net/ti,cpsw-switch.yaml
+++ b/Documentation/devicetree/bindings/net/ti,cpsw-switch.yaml
@@ -7,8 +7,9 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: TI SoC Ethernet Switch Controller (CPSW)
 
 maintainers:
-  - Grygorii Strashko <grygorii.strashko@ti.com>
-  - Sekhar Nori <nsekhar@ti.com>
+  - Siddharth Vadapalli <s-vadapalli@ti.com>
+  - Ravi Gunasekaran <r-gunasekaran@ti.com>
+  - Roger Quadros <rogerq@kernel.org>
 
 description:
   The 3-port switch gigabit ethernet subsystem provides ethernet packet
diff --git a/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml b/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml
index c9c25132d154..73ed5951d296 100644
--- a/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml
+++ b/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml
@@ -7,8 +7,9 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: The TI AM654x/J721E/AM642x SoC Gigabit Ethernet MAC (Media Access Controller)
 
 maintainers:
-  - Grygorii Strashko <grygorii.strashko@ti.com>
-  - Sekhar Nori <nsekhar@ti.com>
+  - Siddharth Vadapalli <s-vadapalli@ti.com>
+  - Ravi Gunasekaran <r-gunasekaran@ti.com>
+  - Roger Quadros <rogerq@kernel.org>
 
 description:
   The TI AM654x/J721E SoC Gigabit Ethernet MAC (CPSW2G NUSS) has two ports
diff --git a/Documentation/devicetree/bindings/net/ti,k3-am654-cpts.yaml b/Documentation/devicetree/bindings/net/ti,k3-am654-cpts.yaml
index 3e910d3b24a0..b1c875325776 100644
--- a/Documentation/devicetree/bindings/net/ti,k3-am654-cpts.yaml
+++ b/Documentation/devicetree/bindings/net/ti,k3-am654-cpts.yaml
@@ -7,8 +7,9 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: The TI AM654x/J721E Common Platform Time Sync (CPTS) module
 
 maintainers:
-  - Grygorii Strashko <grygorii.strashko@ti.com>
-  - Sekhar Nori <nsekhar@ti.com>
+  - Siddharth Vadapalli <s-vadapalli@ti.com>
+  - Ravi Gunasekaran <r-gunasekaran@ti.com>
+  - Roger Quadros <rogerq@kernel.org>
 
 description: |+
   The TI AM654x/J721E CPTS module is used to facilitate host control of time
-- 
2.17.1



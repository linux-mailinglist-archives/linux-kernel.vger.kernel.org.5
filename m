Return-Path: <linux-kernel+bounces-46968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E935844719
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 443111C22A54
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108EA130E58;
	Wed, 31 Jan 2024 18:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b="Rad0jWKm"
Received: from SG2PR03CU006.outbound.protection.outlook.com (mail-southeastasiaazrln10220000.outbound.protection.outlook.com [52.103.193.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C9812FF95;
	Wed, 31 Jan 2024 18:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.193.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706725638; cv=fail; b=tcbb+/KgbYgXC9PPZ0y1BcE3a3S54+C1tk3riL5J0pUV5xQbNRoigtB3zVYRy9mJ3iebs9srYhZHg5MhD51gJdGRo8uJSNXZzLtba9Zl6P49V6ONFu2adMgYuTViAye2xmvHrpKPM/ozGu4rw/o5Dz+Uq/3esZCHaEbOglh2sFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706725638; c=relaxed/simple;
	bh=4yqHzE8NTVZyfIbY2U90LcgnXMu0OFDa0gjYz9nolFI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A6w5Tkusc7MYsR42nTAtODlCF5X3G0UAR9XDfjkcP64/JqAsLQsP7uGiVhanQ5i29weglObpIanhQFpyEvRlMUKb+RQkUEnbVGMO+0FWHt4iBRSL4m0MoxCehZHcAzbBWb/Kwa8MCP7ZKk9HWpldvXme2aCbXPyUktgH3LC4u8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=none smtp.mailfrom=taln60.nuvoton.co.il; dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b=Rad0jWKm; arc=fail smtp.client-ip=52.103.193.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=taln60.nuvoton.co.il
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aO3k4jDZoRm6vFMSoFIpGADkTWWg2U75A6aEP0C64sT4I9RLCBhrLjux+3fT1c59AWsH2fRZAR3GwBG5LIowIQV95gktmbt6zLwBJ201AV4j1usO3j6JqlazLMedyE2ZBXprXnFRYdWlk4mAD+WBlncLRccxZBUCqrh8idR3HFhiAu1KyGCSp3pzYvYr5RWbAFr/FbqE581i1l2li5cyCYpJRkLLqVAjlACwAdW4y3ci50f7d/YM6ldBt6O3wxwJgrvx51wGTv1lS6cttBzHCHMIpKu0C/REuMXMpiNNpc0piGuWL7F7noYxAd0QHVfJ3yKB9NfHCu+V+icrW03KhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aezaJFMjWPhQLgahXxXg2tYBDeuo44a8pr063FnhpB4=;
 b=i3VFFko7eGercZ87LfvK41TPVAVqWFuEtkYE9DpYW5bNPMJk4BhBApBrC3olHpMn7XGvJwZvL2vND1s4xQuCIpIKHrkGffAk4PTqXKd/ZQXGcz3vmyYCsK6phs2tnkJrEs/b6ZFfKObODcDZuG2oDrIpW5f0dnYBi5p9Lm05lqvopaV6RzgegnQ+IBHvrVIaGozIUcKuRSS9KCmuHq8H8w7B76MBM+na6KO5YwVrjXPCc9yrwR/4h3JmW03vER9ERtBkal9TOcbT/N0IfoLNuEKKSbCTKCuUkkQEU9z1Kdtu2eJzX+Sk5E+QUFupMWQsnJhvDyurLm4uHFYWLNU8Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 211.75.126.7) smtp.rcpttodomain=baylibre.com
 smtp.mailfrom=taln60.nuvoton.co.il; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aezaJFMjWPhQLgahXxXg2tYBDeuo44a8pr063FnhpB4=;
 b=Rad0jWKmQTosNV/8PUb4olVEjQrAJoOFahyVC3ftnuAMos+aQrYc7irEBol9gDkEdyd+Jbdvnf/iuV1u8e0ObWM408W6eRqC/NY2gNqgD1uzorte7QFWkEAnJa5Kou+RBXoDGMOP+0BMtDCBbpGxg8RvMEF+S6t9s5059BybFoA=
Received: from PU1PR06CA0016.apcprd06.prod.outlook.com (2603:1096:803:2a::28)
 by JH0PR03MB7611.apcprd03.prod.outlook.com (2603:1096:990:b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Wed, 31 Jan
 2024 18:27:11 +0000
Received: from HK2PEPF00006FB0.apcprd02.prod.outlook.com
 (2603:1096:803:2a:cafe::a0) by PU1PR06CA0016.outlook.office365.com
 (2603:1096:803:2a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26 via Frontend
 Transport; Wed, 31 Jan 2024 18:27:11 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 211.75.126.7)
 smtp.mailfrom=taln60.nuvoton.co.il; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: None (protection.outlook.com: taln60.nuvoton.co.il does not
 designate permitted sender hosts)
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 HK2PEPF00006FB0.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 31 Jan 2024 18:27:10 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Feb
 2024 02:27:07 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 1 Feb 2024 02:27:07 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
	by taln58.nuvoton.co.il (Postfix) with ESMTP id EF7BF5F63F;
	Wed, 31 Jan 2024 20:27:06 +0200 (IST)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
	id EC000DC08DB; Wed, 31 Jan 2024 20:27:06 +0200 (IST)
From: Tomer Maimon <tmaimon77@gmail.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <tali.perry1@gmail.com>,
	<joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
	<benjaminfair@google.com>
CC: <openbmc@lists.ozlabs.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Tomer Maimon
	<tmaimon77@gmail.com>
Subject: [PATCH v23 1/3] dt-bindings: clock: npcm845: Add reference 25m clock property
Date: Wed, 31 Jan 2024 20:26:51 +0200
Message-ID: <20240131182653.2673554-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131182653.2673554-1-tmaimon77@gmail.com>
References: <20240131182653.2673554-1-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB0:EE_|JH0PR03MB7611:EE_
X-MS-Office365-Filtering-Correlation-Id: 66ead856-3dc2-45eb-9557-08dc228a3cf6
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	t1kWpqPTTp/GwVJwt8qKtfAoo11LtcIkyNEhvK4xBPG5m0bITISKVOcUDqT9QYnfm0AUxITlYmGtiyUrgI7f1Ff68aUNDOB8RzaRDtU85BCGigwmc+znOHv/iv3DMytrggsKu7VQzlldJxaWep4bfZKaYb+5kXMlVvaBLMqMjtDOoK+7HHebZH95X12ZxqleOyIUfaK8mXAknWuxCDqX+PY7MVfEsD14JIGQ512LaxGxznkm2Sw2fv73WOYZUO5EH0NoNUmmL1YMoSJRlCirDSwXzZbqbYyzJDbsliGtl3irdtiKsFjeS95QWMlj0O8ZRZuC/mcIcv+xi3FRL3wtu04Y+tD1IMD+1hSrausw8b+fsDhM2EUyUDhYzu/8XRYb3kKQn7XLufLji3/zZzPk5CFOxpDhD+c/Udbvu/MjSV8JcCgZ26TDCHlimWN0/jqYzLbC+pgMK6VQCXy+Z7Fw9m7rSIl6PECAtmw8t/gIYvfk4XK5y0XSf+A+2gVMPwkXynQE5FL7MA6XQX7W3YMpkYKqK1WcQ5RkczKsHy9FQw+60GOWOmNYX+pO7YfbZpUl4um4OhOgj+Kl6G6PBz9Fu6xz6jWsDp8fCEIz42BHtMY1akBfFGjHB5Kbr6WB+yE3lTmerIuxa+tjQMMi9QGgArJl57/VqpD3FMt14tAbE6JTuifGJbJ2Qibr3WQI5VDFvhVY22nlLcO8XNCizNIKqaKgnK65BXGOX+qIF5Z1+hpzyY5TehySuZmUBXKpXmNUhK9F1ZGfUN8zIMLLNV+YW4+L1mtb3DDc8WKJyEfS+adoRfGOgL09f3lJttuR0G+qYr5U5RMa6XMjhK+7BtkonA==
X-Forefront-Antispam-Report:
	CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39860400002)(396003)(376002)(84050400002)(230922051799003)(230173577357003)(230273577357003)(82310400011)(48200799006)(61400799012)(64100799003)(451199024)(40470700004)(46966006)(40480700001)(40460700003)(41300700001)(83380400001)(55446002)(81166007)(1076003)(36756003)(76482006)(47076005)(82740400003)(356005)(83170400001)(35950700001)(42882007)(26005)(82202003)(336012)(73392003)(6266002)(2616005)(2906002)(70586007)(110136005)(316002)(70206006)(42186006)(6666004)(54906003)(5660300002)(4326008)(498600001)(8676002)(8936002)(7416002)(45356006)(35450700002);DIR:OUT;SFP:1022;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 18:27:10.1517
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ead856-3dc2-45eb-9557-08dc228a3cf6
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB0.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7611

The NPCM8XX clock driver uses a 25Mhz external clock, therefore adding
clock property.

The new required clock property does not break the NPCM8XX clock ABI
since the NPCM8XX clock driver hasn't merged yet to the Linux vanilla.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 .../bindings/clock/nuvoton,npcm845-clk.yaml          | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml b/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
index b901ca13cd25..7060891d0c32 100644
--- a/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
+++ b/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
@@ -21,6 +21,14 @@ properties:
   reg:
     maxItems: 1
 
+  clocks:
+    items:
+      - description: 25Mhz reference clock
+
+  clock-names:
+    items:
+      - const: refclk
+
   '#clock-cells':
     const: 1
     description:
@@ -30,6 +38,8 @@ properties:
 required:
   - compatible
   - reg
+  - clocks
+  - clock-names
   - '#clock-cells'
 
 additionalProperties: false
@@ -44,6 +54,8 @@ examples:
             compatible = "nuvoton,npcm845-clk";
             reg = <0x0 0xf0801000 0x0 0x1000>;
             #clock-cells = <1>;
+            clocks = <&refclk>;
+            clock-names = "refclk";
         };
     };
 ...
-- 
2.34.1



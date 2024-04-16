Return-Path: <linux-kernel+bounces-146768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF3E8A6A9F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 228C7281EA0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B79912BE9E;
	Tue, 16 Apr 2024 12:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="Szfs6bPo"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2099.outbound.protection.outlook.com [40.107.7.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961DD12A15A;
	Tue, 16 Apr 2024 12:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713269918; cv=fail; b=AdGLt8j4LJNUyoGYPLugIOSQ0kq/p6Rw1Pm3EdVAFqOTqd1nJR+k9Z1P7Rc5rAN+/CPNN4CeeueGtZ4Q/NBL+GVhl01OcQk70mONlfvJeWxM/pPzAeB5jshFhSpaZyrxN41eEOwOGwGp0qb/icEygM+CxFDqMTK62LrNEgJBM6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713269918; c=relaxed/simple;
	bh=DbMIqFE48QPZGX3tHgZgmG8nnZPoAJxlzjCAIhzJTMg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version:
	 References; b=rsb2nDbODhMQa/H/h6j7wcQxfn+CdiWR7wv6osu0CUeo29Xzsg1m162KZ8Eno1ajoyRrkydPjX2ioq15UNFY0QkgsgevwteHfksv4BYz3eTC2DxGiBx7jSC/YOXOCM6M10qZCWNlKaZOPnzK2RYO9R1b2lgcpHOym1//eb0FnGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=Szfs6bPo; arc=fail smtp.client-ip=40.107.7.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZsPBSlu59/niNcmtBL3HZ9YkjSM+GQZ6NnB1I4K/p34IZrQymUZncyIh8BW+qON7ZJhyv7StX5Fp2VMTxsUkNjKJ48guAVJGHImQE58KTFZQDvdEznaAeKeMxGvg/L+mTUej0qChf0dgXvGYhVHFSrngnLSiPwUFlkCVM8HtD1q92wwYV3ZRFKcAgf7LrpsS+W7O6NqLbwBUSqSibuuZGDspIJgwjqsTLeu0u8lcV+AyC4bbKO7doiJZwUtRKVMg8GZ6tgy+fCON5XOYP2u5rvnTDzPEs2gUj8HHzo84+psPJHwHJiJkilIlWDAzWL/kW9Tbz0AsM4wfK0XgJIVuww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SM0GYnb+LCQZA1SJ1xN8BGBtGWYPC+YBaACg2JyuFQ0=;
 b=KfXUtN46cEcY2S0y7X/XQIQDyZzdkk7E29Kuxg7lIhd/WOzZfSNyZRscJk6hjRdcL7qVUcEXmz20Ge02XnCWCOeyS4KP6AgCdmj8SI1utWEyMLM73Vs1fIyFkDeVSb1wflI5AvEq0FDCxJZyzj21E2gmx0ZVsFTEe3bUo4xOZ+A8CLtnwLM+VUTup8Vt88wsR+x3T4sAXkHbsvmn1k1o9YNojdW2iXUINMgnjKYUDMcNW67oQRooBrbWaR3ozLJ0jxzDUDeDj7dve+F5Fs7vMXnVbob6FPl9scbeoUXPom3CT5teasW/74bAPHG6qPcrdHU1fJU/tMUtak4tzbiz8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.69.19.60) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SM0GYnb+LCQZA1SJ1xN8BGBtGWYPC+YBaACg2JyuFQ0=;
 b=Szfs6bPoHvsDuFWbRvZwkijHzYMO0NU40DuaAmIdTEU0DbqKUKcHseZ6E5BdwxTy+pehxuUQOVH/KngP/RiijczKATjmQp9mF4DgpzM4lGwr6uCfuffO4Yq4u8wkab9oaqHIBPUq4XONZRfR50t4nrGnNBs8nqgUcUTMGVbxrFcOj7C3CKy/60LoCbKkiTh3TneFb0dz9YzwsH8Z7Xk1B4QdJ82hnDXnLn+pg8nZbPtthxHKSg3BOmK4edv61ifAWliI+6JbZbzlBGqgnwee1REjmSCf1yCM5WCgDSHBJRwqvv8+cEohOdb5Pa+tv44nZn2X0wPkHOKwKYta6Y62Tw==
Received: from DUZPR01CA0285.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::23) by AM9PR04MB9013.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 12:18:32 +0000
Received: from DU6PEPF0000B620.eurprd02.prod.outlook.com
 (2603:10a6:10:4b7:cafe::45) by DUZPR01CA0285.outlook.office365.com
 (2603:10a6:10:4b7::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.32 via Frontend
 Transport; Tue, 16 Apr 2024 12:18:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.69.19.60)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 40.69.19.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.69.19.60; helo=westeu100-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu100-emailsignatures-cloud.codetwo.com (40.69.19.60) by
 DU6PEPF0000B620.mail.protection.outlook.com (10.167.8.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 16 Apr 2024 12:18:32 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (104.47.51.169) by westeu100-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 16 Apr 2024 12:18:30 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by VE1PR04MB7230.eurprd04.prod.outlook.com (2603:10a6:800:1ab::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 12:18:24 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 12:18:24 +0000
From: Mike Looijmans <mike.looijmans@topic.nl>
To: linux-pm@vger.kernel.org
CC: Mike Looijmans <mike.looijmans@topic.nl>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/5] dt-bindings: power: Extend battery chemistry with capacitor
Date: Tue, 16 Apr 2024 14:18:14 +0200
Message-ID: <20240416121818.543896-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0015.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::20) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|VE1PR04MB7230:EE_|DU6PEPF0000B620:EE_|AM9PR04MB9013:EE_
X-MS-Office365-Filtering-Correlation-Id: 63f61ead-601f-494b-d773-08dc5e0f54e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 7SFKj+nr678/bhjbcggr4nUXPOju4BpzSmR32s9EOzyGpTR2nTKy/jVjMdXlMK4edcg0Bey4TXZgKvKldEetsGfMkyd6ifu0QiH4oSbACmf3TnltX3CW6nL9oiCVRWWniyZE2FQRPcoKIaUh8GZRwKiAuC3AERHoxrOggWZhe9uLesBg3lwkBerpX4OCAPBhoHV8FjGIsUFHBJe7nsU8+1nClgj7sAxFbJKX7sB9qgn+sUqclllq5gMkLMxkpH58zcgifm4emPFO4oiTxQWm1zIDjd+MKDkiRGwOUDN7iZKmkRD8vYUqtpDoHoYa+gR5diuVIg7dRdQmPN0Y6ErT6qSegd/9hJU7S5Wv61DCFe7rvsfup307BTa4unKPkWsB7A5I51aLgQvUc+o6tVFaY5H68SHu4d9KgeDWHNCgHHXHu18FFFMTKV1sQDjHcEwZqnP7L01cSju7qC8GxZXk+7Q4fz9uTsizbP/X685C6ZyWmv8rCfMyHFcL1L2HowzRc80r+611ckW/GMmzmS7tzFbpwlkgVhpj2PdKxx5+Oc+C767OWWluMpPIRc7n02NdIF2siMJGFeGxXhQk+ild6SgnSmBFqG6T2CVsMDUyI7LDeODI1L30g8RoYjLpsx27HmKv+FksPBMQxEbuj+Bl02i3CUHWnIA8WC6azkGpQRpsDU2Ns5P4/nJWbI/Mz0/D+LryRBWxpfIKOcbDciN9qQ==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7230
X-CodeTwo-MessageID: 1b5ac8c7-b024-4cb2-a073-9c05ed1eb553.20240416121830@westeu100-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.e2aac3eb-919a-41c3-81e9-f9030f4f80eb@emailsignatures365.codetwo.com>
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000B620.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	eaff7fcb-be01-465e-3bbd-08dc5e0f500b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	w3WfWYCmkA4M+URVtOuVSQSZLZyQBUmmibN4tPYDqBMCahXS1arH9pNfd11WGCxGMPLaOExQuyBSvJZ2QOM9bk9RNlMqwjMwN9dbjsCX2EsJlXP5bD9WIInams3arWgMFTD5GM+OalTUFr1ofu7s8ZbaEuLrP+tcBxXTRdER0C66AalPqTZAxSRDlSkVIbeqLKRpK+MQoHyLCw1Vb3TvkH31vqXjikjsFaoQKP2aWrvjsBvfkBAVRMB9QX5NVsZIoiptNxTABsbrbczJABqR0TVoWgqzSL5BrKkn1sFbn/a3fq4qwoDqsVzyitU4+1U5g/vIT3TL4gbFtHDOH4yosqMGproFHepQn8SYMiDCoxQ9lXbKJkmJUQyc2E+IyinxdGrG4ZoP37BWOa46GguCZyYjy39zMXiBO1S44bI+0cRqKqKzBRx6oq3TPb0Wd2K736sCJFeTnmusAdUshPdf3f0x39Q6ezLr/S05coKG6zHgFQG9a6bPbFcQJGLjLklbEIEQ2zgzph0sj4ubF2LDD/HnhKrAdMO7vg/59M8oinplSGVcWxDFacmI3MEb4f6XHB0ctGx9WZnuz+/HlLWbmPVOs/56HEpruW+j5snCBVQoU2HbWrvaabSBEZnuhDd0jWMUlV5b3f21pN9/KqFmEX7HIfJsfQSp3JF/mRadnNTwfXJOfnv6ke9e0Emcc3DE3XM1g63W38Ktxky0HiJ2hw==
X-Forefront-Antispam-Report:
	CIP:40.69.19.60;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu100-emailsignatures-cloud.codetwo.com;PTR:westeu100-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 12:18:32.1062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63f61ead-601f-494b-d773-08dc5e0f54e1
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[40.69.19.60];Helo=[westeu100-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B620.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB9013

Another technology to store energy is a (super)capacitor.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---

(no changes since v1)

 Documentation/devicetree/bindings/power/supply/battery.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/supply/battery.yaml b/=
Documentation/devicetree/bindings/power/supply/battery.yaml
index 491488e7b970..a22c97dfad88 100644
--- a/Documentation/devicetree/bindings/power/supply/battery.yaml
+++ b/Documentation/devicetree/bindings/power/supply/battery.yaml
@@ -44,6 +44,7 @@ properties:
       - const: lithium-ion-polymer
       - const: lithium-ion-iron-phosphate
       - const: lithium-ion-manganese-oxide
+      - const: capacitor
=20
   over-voltage-threshold-microvolt:
     description: battery over-voltage limit
--=20
2.34.1


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topic.nl=0A=
W: www.topic.nl=0A=
=0A=
Please consider the environment before printing this e-mail=0A=


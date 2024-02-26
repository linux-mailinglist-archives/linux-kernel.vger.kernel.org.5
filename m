Return-Path: <linux-kernel+bounces-81416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2588675F7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28E53B2C653
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0C47FBAF;
	Mon, 26 Feb 2024 12:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Nl0hEbre"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2041.outbound.protection.outlook.com [40.107.21.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03B060860;
	Mon, 26 Feb 2024 12:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708952081; cv=fail; b=gJzowUelSbwur8hH7UxVzReXnA72+VZqGTmacUFYuKCb9DMwlEk1Y5zKgfxflBIixE+V/S+ytewtW6M1iiE1xTu0ZeRJ8A30ae54llcOxrnTrh3WW9XMA/D3Xb7EhtnxeTw5igsxEbonJNZLKv7XIqTb5j/1gxk5vfHqAfd89Fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708952081; c=relaxed/simple;
	bh=w9k/CRCtO0wGfaWLODPpDWdwXRq79FKfF1/JFlhXFRU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=tJhG/01y30zd5jQeVPP/2/iHmlqwycngnQ5604qAbpv5+OLMZYZoT6lmaQMmzwNM8PjD6X5dYp4kY9wfKNBVEC7MJErn/VDCuxJq+zg9Ey/GAc7ogt/s2MZbVa2pt4PJmQqLE2FfK5ctyzEowCuJQ7A3nsaRJPT0O8DM6OSDrpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Nl0hEbre; arc=fail smtp.client-ip=40.107.21.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YA0vq76v9m8vhWhdg6UA1UWiOujg2qMhX7Y6J8IJZBS+PMhNs6ajoI3JH5I1rQ/351WOgRmhsjVhK9Oo3w7itqNK5k0h1bTHDhakHNzovCTmfdeEWIPdtoskJpu0u3FIM3opK94IcnTuF7rQOlwOllfCutpZX2iuBkeHwbEbvZN7WE4ObcpOl6/NmyDo9McvJ2bBJ/gPOrNruhLQJyZAy2oJka7aOLEWxXFxSd4fo0Sgh04x3DX+UIslaQGglrUqcjzRRkmXyx6uAQ4Gq32hVEjA9/VbeMGm9DTkFDI5k4iwJhdA2x9utSEJRPNBEyIVlcP0pJ5u8qySmAK9/hi+8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJgiR8aXBy9nPkF3IQ3/B+17CQQRTW01aR1cUf+WXyU=;
 b=eWqLPYMoW82aGTjtZR7Cd4MZuvf8xrfLI4uhlJ1D7S9c+2BsRAQJ6y6HxO+jWj6ejeneNK1TeEQPBQq9yYFOJsjqGK4rfsQzO60F5jAhrrnCsR2ZDMrf8PFYHDw5RDVXLg/MpKyFw3VDKmuY+ywbTH0fvMBgrVkf2xwk9NF9Z5uuFxufgA/gcmtASNe7BZZZXJ+Z78RliElEEX6oRXucz85sJbDI5RQ5IBjGqo59hFtJfC/6K77UjrJ2l5pLt6HJwvuiXvvJjIRvGgMnIdRHF4WSYnaoqwxfuU6Zw6VOI4bAaZgah/8zVPlueZrjA7fMbpAIBELEW6/PXhWhADy1Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJgiR8aXBy9nPkF3IQ3/B+17CQQRTW01aR1cUf+WXyU=;
 b=Nl0hEbreo4pUgo1YAQGbfztiOStDZvH073tRhaq+kZJ+laFUUmncxY+RknopuxsyLEt+ChQo59G96BXkeJTvR0YDl9eVYAbFTHUfF+l7tsRXY1eay9RmT1SbIP2zLWW6C3wVeBBproXoRq2sqzq2+9jE0OXuHNMm6QWkzmCUjVE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8746.eurprd04.prod.outlook.com (2603:10a6:20b:43f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.33; Mon, 26 Feb
 2024 12:54:34 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd%4]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 12:54:34 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] dt-bindings: firmware: arm,scmi: support system power protocol
Date: Mon, 26 Feb 2024 21:02:43 +0800
Message-Id: <20240226130243.3820915-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::18)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8746:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fea141a-230e-4de2-ff4b-08dc36ca14b2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cCombyBoExf9q8H8IRLgg8/3PegNdQ2Fp1THz/N662ynbR2BSo6N4diaUkfIoywlFqwmdD9Hsi1uWPzGYY8gOaaMcDJ9ZaRTbJkJOfrOMiXIZIMvpzZxyZjHY1TBW1Uo/WGHBhHzW+cQsVz+ajugOLyX/L3OOybJ3HCcTysObPNJq9T/oykg7uLXdnDUtw8kx5J2GTwq5E3gG8Kd+b7UJ8xUIxJEu4I88sv5A+lnhghZ771payDBVFPsG5AIRSni/3jdjm03OGFYLaoivE1obrcH/swZ0FSVkE0WY4Lwk6XVY2KDfv1CvMzy/eOH9UeMtZmBWfTfv28Lz+XhG/Z+xGQpD4xeS3W7DuWjGEG2bk2J1zppagd40TxSO6BMLWb8EB4HLJSCOfekgNNZRFdhkJlIU9jHWHT528sTy8c3IJzeHv4sGNJgOdETg6hCyTe44wUqmPHq8ZamoIxXc5zz7rsw2C1rDd0/raZFvG7A0EkUKKccLQC5m01kouALQweZ27S3iiJ0rf+MLxdL6jfiiH2mjEByLW31hPGbVYPudBSdu7YMuWTDw4hod+5imTBaLCfth42hg++MrJmg1u3jQrBbB1wMpW1Fj3eT/jaAasiPeIXm/vYA4ZZ7Xv0Cs9KMjilel/Em6FgvZX5ESrmGhilE9q2LVgHdJNCi3y0OB4erC7PHCAbtTpnmSuzb08oU6q3jM/QwKXR2QoLCg7bFSEJBzX8fN8ZDYrCe7itFRuE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O4F5h3jITpdn31ggVUB8TRY878uO1TDu8BesfyQ1gwaqXn7gEqhK+sHvAB3l?=
 =?us-ascii?Q?JBfr3D0JfYikGwWcWqQWp29rPdvpNY4/Lzs+H8yFpyWPWuwXVivcrA6TtqbP?=
 =?us-ascii?Q?c0k1MgZ/irWUOOG774+31fnr57y/EQp5OGz6smtx2N/iuABax7kGgp5AH0M2?=
 =?us-ascii?Q?W5mI32lhTLJIHYYEbBV5o+xL4lO6pZDNdBWJos/YGZmvS99W1Zzd/ymLH930?=
 =?us-ascii?Q?UD247bw0QJYaIa+PApZgscAV0jCVa4RYlpNZKOn5jewxvxi+WZxRQIKAhk4y?=
 =?us-ascii?Q?MAQpwU4qzCxgRDqME/5PpErA4ZXbzpRrArVVqxq4S8HaTiEjaoJovxL5ZRrM?=
 =?us-ascii?Q?Junj2RIQvGSdc3M9n1gotmL8BPWJ2VMcfBbECoYmAE28aiZZv0I8N5kJkmcn?=
 =?us-ascii?Q?zlEDpWeGStnemMboRzOsnmhhS6BFuV8aVeM+B+lhG235xl0k9pbGx5BH64XY?=
 =?us-ascii?Q?KMYoHTR69S/6vR+U1YE/0Hlu5NSZ2ueHrht36ppLOV1eieRaA2bBWOdrm3lD?=
 =?us-ascii?Q?jiD5mg/+K/KXr38SYRqxOuZEDBIt3sXbMfmUS8lz6MJQ/COb7ZpmVqddpc6f?=
 =?us-ascii?Q?Jexjh6hZBT9otYfCUGkYlTGC/Wo2dsdz1PT2OMeGse5cO/a2rhl+6NtibSfV?=
 =?us-ascii?Q?UzbkxxlIaKE2+SvUdhSJKaAIN94y8KpkGTtnkDtsftRPnSc+YTotuSzew+nF?=
 =?us-ascii?Q?EdGhKCJEwJo/3u3YJF9GxzIrYtQYG+691FylyyKUc3ux0GXWavU+KEhOBdNA?=
 =?us-ascii?Q?kV5NGAAwO8E9j+5CrtXe53T90e6wteuuiw79OhTZqL8MMREZ70rDDELa5id8?=
 =?us-ascii?Q?EBv6pzVcLPSgduwGqTrZcR9TOmEyN6+RFBRmNsb0jdtA6vghtIto7lfRjOEf?=
 =?us-ascii?Q?EyBUe3+0wfNQK6WeZqlihotV8U8UbxEDt71WxdNTQthDXczh0jXdZROOC5Pg?=
 =?us-ascii?Q?eUGoZwWF772qaX6fKywvR2i41u6Cven331qhWTe5k9lEsvc5PC0JU96udfXa?=
 =?us-ascii?Q?O+UlJ/Wq9ZPCJyoiVE/RfquBB1W/a+R1BX2wa2P7nQL6fUG6ud36RtWptPFq?=
 =?us-ascii?Q?4WLZrEgURT4b43Y2dzK14xko6eJnVVrjIJbECxM/KJ+jjnGOwgiGryVBmLz0?=
 =?us-ascii?Q?PrEhNKaUbuJ2LWvCu+r0mc5bh/F0CpNz8uocluXjIlbR92eg1x/ip7+u44Vk?=
 =?us-ascii?Q?npUeRQ8PA8dtiRIGwh1bLrfZFyiWGsi33RuLXPN3za7Rrq6H+NLXCyKOTiUK?=
 =?us-ascii?Q?hISmzL09cp4gPlIQvdAVCr4Ug++q7Py7XNIOV0Lgntl+hJ5EiJkdTcGTJIyl?=
 =?us-ascii?Q?O0g+vWW47uEJPOeQCuHN5wM4aayS07wCF5xy2Cyv3mJ6OC94ALcTqgXMdPS/?=
 =?us-ascii?Q?FbpwJwVbc2tl+ujKCBeq2qGGWjogPS+4ttB7xjBD5pjkaKzmqJTpKU9yaqAS?=
 =?us-ascii?Q?5VBgCv9RgVANnSbUtW/ByGaXczhjS2uN0bd+W0eSuZvsRbXKZ7zPrCNiO1sG?=
 =?us-ascii?Q?PWpJ21cKdiRVBs3D7G2YVNVZrAScZ3LA2hqWPCGDFo2dT0kL5qT9A7wgGfgY?=
 =?us-ascii?Q?kSRmA+btHZIWsD0ceW75cFN8eVzjlOL7AnIFeg5j?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fea141a-230e-4de2-ff4b-08dc36ca14b2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 12:54:34.4173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i4MWidyUVUvTotFLheipB+3MPuv/u2Xd+SLZBc1P8wYrq18lYQYDNtVbavctj1aWNykOsnugYcqKVuxejO4XKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8746

From: Peng Fan <peng.fan@nxp.com>

Add SCMI System Power Protocol bindings, and the protocol id is 0x12.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index 4591523b51a0..d99f1577476e 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -141,6 +141,14 @@ properties:
     required:
       - '#power-domain-cells'
 
+  protocol@12:
+    $ref: '#/$defs/protocol-node'
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        const: 0x12
+
   protocol@13:
     $ref: '#/$defs/protocol-node'
     unevaluatedProperties: false
-- 
2.37.1



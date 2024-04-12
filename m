Return-Path: <linux-kernel+bounces-141752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 258C78A22EE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 02:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CCA81C233F8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 00:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0437B4C92;
	Fri, 12 Apr 2024 00:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MX9qQxlt"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2064.outbound.protection.outlook.com [40.107.104.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289F03D71;
	Fri, 12 Apr 2024 00:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712881292; cv=fail; b=T/2LGvjiL4Cb5NHXHT1xr9nLR0e9XGCYUCQqvDlgZzIFdFWf0lmElddV9feRncK0vF5lAm1YRkt1KZAvrQolTLBlS+EgzRsoSwHwbr4IO61nXavPOY9TcZcesZy7pLfEUn933Enadm3usKqX/rjDUApIkrHn7WTbVwRE2EvOBgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712881292; c=relaxed/simple;
	bh=xzKRrHZH4LepqNI3avoT3OHq6wx+Wc9vBF5rnP59ZJA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=fvC7QfRo9Qrlxp/TXgKGAj2qVfjCgbsHukd5Cktu2Ha7cMB71Pf5qRwbAjCmqa0mkvTMJvgzAgwN7eNdJri5wBqUpOHjdLZu6vl0Tfr6oFOtnbmRvE9IwJOBnSpo8lSXmyuqT5P3yv3a/ZkZvBIkHc8Q0oI1JLiCWIjklZLmU14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=MX9qQxlt; arc=fail smtp.client-ip=40.107.104.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGk4wdtMH73w3oUXjHt44mGO7Y7VHJ5KvOn1K7WRayTg7s/Dy+xBspBsXukkyV+5LjQoorg/SN/l2fSb1qnWBa6QgQGyO79pRRvjXQ2Xprn+XWHPRl/zeMnmA1y4zwcc89A9iVFCjnXOipM4oGUFWIa4tlfqWhZs7cqkPc+Ry3lWGOmOFnLF/pkdv0T9l3SpooQztw8jk6ne+eY/vv/xAmun4fl8ASuysl0oUgp1lcwI/yfFQIsor/og4m3/tcwQIqht3Ni/cH+WuoiytNUiLXvS+RrbCS5EOl4hks/so2NqIp+wLcUI0lIWCmrcp8SxDLIH4WLCWwRrDQjXAKw+6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vm5h9T2hkUY0DcHvY72yMOoaiclMP2KikmiNEJzpk5A=;
 b=UDJpl0WSs/PEj2IKYO5R2XSQpTtBh3fLOzXTr86AFDphCXv/GcGOWAJUOhRDYMBrrS7606d5458EOgFPfUpzBghX8faN5pqC5eVYfidn7TcZNKBB9b9B7k2HKNg9md+/AAdXGYdwrUYq+Ud8SXOaQPyyyunF+xMN0xRMC7O+WCELBWLyAy+Gb8KE6xJo5nr8lVbV7xq9BGDEvjgid9Q3Hxkuy/wNPutQe1Xu/DWWzPGDK82lDZcqj9xSdtViYrZrvWg8DpezwJCnyVzFdfL3gwr8jX8HNjOtMAB5sJHHDF4OyLSWanOXTPLQkNkEVie+vQNAX4vN0+kE/WLx9mVmQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vm5h9T2hkUY0DcHvY72yMOoaiclMP2KikmiNEJzpk5A=;
 b=MX9qQxltsZgTIWnrtxBGyEgugqRKHYvaZHrqGWSA9XUx+BJ4Ts2esisQQfL1fLRvn3CWCtAL70aTlIIPcFJp3oTWVJyn6P4xgQWlnE2Vzr7sL5yEdH0p9uBVKFz4i6+uUyGeNjA7bthH42yZJiy0/hIEx5rgmAzt5xBHt/naiMI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7970.eurprd04.prod.outlook.com (2603:10a6:20b:24f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 00:21:27 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Fri, 12 Apr 2024
 00:21:27 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 12 Apr 2024 08:29:25 +0800
Subject: [PATCH 1/3] dt-bindings: pinctrl: support i.MX95 SCMI pinctrl
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240412-pinctrl-scmi-oem-v1-v1-1-704f242544c1@nxp.com>
References: <20240412-pinctrl-scmi-oem-v1-v1-0-704f242544c1@nxp.com>
In-Reply-To: <20240412-pinctrl-scmi-oem-v1-v1-0-704f242544c1@nxp.com>
To: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@arm.com>, 
 Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712881775; l=1964;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=iQ5C8P2+nJngpEg/AqIqeTnK6q9nbUkwKAvc5cu1n/4=;
 b=VgjA22wruttJRv5+7OI5Po4ODCYDVYw0d3PFGY3skG5+6o/Kp8vDZBVvDWGEpiQCdnuVjBl2z
 vUSki43tqV0C3YlIsWMhm0vL3KwKyE4BcELbPIPwopulXuR5ynnX0lh
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2P153CA0030.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::15) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM8PR04MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: cf21b74f-28af-4f3d-9107-08dc5a867e88
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5QgTCi6/9wu6EMOsTOoRQ8V5iSVC18Oqx5O2Vh8ptbf4kZ1p0YxNEYkZwoV0oBKLUWDeXiS4JdMcDQOgfLp06nXbctk2L6EqMFFHj+oOZbFP9eDZPpjRnWTgVoIg3hyMxkiGhSFM4VT2QGPXUUFcCrH3No0a/hXF7z+4nc75hPI2LGPsTTa6pFYende07AkStoGZ5NaOtc9WUyaT2NuxtQyKlBXODx3pLVC1NLE1HFqb5sQAa4YGZ3oYC669Q350pEvRy5yDk/sR29cYXaBUTURdSV1ICQ3WDPc4Rl4Xrb3H5jopbEG1OniCODO/+Uzvl4DrsGXXiz3VVyWzBI/1ZYSsmMoTyO26U7eRTzOvHiUdaf0jBANHS3axxeDr6EHVhPZKZRnE+YXIpwSuethaHoDChZQJOxI7dFydBOnyvaQi0NAdG5MNGfpLigLWKEoorXhmv77LKuva1Nz/3MdZovH84WkitaSuwWukww8JTfG21a/nMQa2a8QOi24tUD038SWDydlOvv4ZT5GNbQEaFPDM2CbSjUZV1SAxNoVNnW3kcMX6+wNja+LEQg4xvkaL2kinTEz3s27A55o+yABfPl2tbTlErI98tl15DvMcTNAUy9w/laR7n4c1yXzfGNokrUI61Tg2mbSkSpmdXIVcfsxjiriFAYTlbSJUJOCBfvlplhXHE69kg42/4x0Rq7WJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(7416005)(376005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WE81S1A3YWNUdUNVbnZuSlg4d1BjOFIyNWNhVXJoUEVrQVQwVlpIVWppU0ZR?=
 =?utf-8?B?QzdxWS9tYlNvVFJ6NktqdXhzQlhTNWFCOXRhR1FoUXh5dGVWR2JlcWJzTTFU?=
 =?utf-8?B?TGFmYWVrZW01WXRwSW05NnpwcjV1QVltdFI4dnYzRE44WnhrVkc3UDc3OW5S?=
 =?utf-8?B?bWpya0c2REpEQ1grTEhiM0oxaHczdUVUanJVWG5SbDRFK0tZZ1ZVbE1kN1VH?=
 =?utf-8?B?WElqN0VYb1kzSUFFcENiMmZ3VGhqZWljN1gwblJNWnNiaE9EVmJmUGd2Q2hB?=
 =?utf-8?B?VzBpTGUwQ0pMdG12VUxjQWdJMGM2cWVGbjYyNm1wNUpwRkdMaGQ2Yk5POXRC?=
 =?utf-8?B?RDUzenRmaVpuMCt0K1FSemN5WlNYM1J6Zm5YN3pIMG5PNjJodHV2Z0JCS0VF?=
 =?utf-8?B?a2ViWFRLcWxzUE1nWmRIazJON0dJY1pURmxNT3FvL2dYM2dYdnR0TEVIVHJS?=
 =?utf-8?B?aG1POTByeUd2b2ZwL1dMZlpIc29jbzB0YTVzS1J1Zi92Mjg0cEdFdnFQMG5r?=
 =?utf-8?B?dW8vMnRVUncvT1ZiU09QcWh4WTMxUFRtRWFjWnhwUHgyeTdCSnZlT2syUEhY?=
 =?utf-8?B?YjNQWElsQ2lrbXh3NXJGR0loeEJQbXNPS1lBU3ZIQ1BNVmhHYUc0b1p5S3FT?=
 =?utf-8?B?L1ZaSDZtL0pGV1lQak9mUTJ1L2x6WjF1VHZtaTQyUzBrUjBGSlBGUEFjRFd0?=
 =?utf-8?B?aDZlcENScFY1RVU2SXU5a2tUKzc3RzdGczFmRU5wWEpzTGtkeE82SHduMWhW?=
 =?utf-8?B?Qmx4NmhHeWZNaEhKWGFZSEtTTG40cFU2OTYxMm42Y1ZnRERyN1pvMUUrVkVp?=
 =?utf-8?B?MVNhMUxjUFVkRkYzYm5jYUVZNnd0aWpQblN1V1ZQNHNNM21EcUVnTHNweHk3?=
 =?utf-8?B?d2FvMTZtRjlGUHVLQk0wUnBYNmM1MHNnWnM0dDY1cG5veUNOdmFDalBxdkRX?=
 =?utf-8?B?Y3JrbnJ4WjFNanEvN1lJRFJQWmVvMUEreTlveDNFNHk2bFYyenZFcEF0SGZp?=
 =?utf-8?B?R3MrS2RTUkdXU1RLcjZuSFFudE9odDdSRlRMWGFuSzdrdW9sZDMwUVlPYU80?=
 =?utf-8?B?ZTUvNFcrWDk1TzRsZTJNQWdnMGRoUUtxd2lEOVdZMy9QenViWnVzMmVDQVdy?=
 =?utf-8?B?V1hhMDZhNlZVS2VyOEIvbVlWYUpPZENkcnA5d3hjYkRsSW8rODZ5dEYvTmkv?=
 =?utf-8?B?TGNnZFN2ampFSEdlNlliNi9QaEswRmJaakdoNzhkbjlXY3N1S3EwQzRyNjlw?=
 =?utf-8?B?Uy85MklQSitWOVhMK3RFWnhGQlpPcUU1d0RqUktTenFyanFhSGlqTkhvck5W?=
 =?utf-8?B?bXB2UWtKa0dSZWh0ZXArUENaalZSVExGeG5FQ085dEJkbGVaQnJTN2E3QkpX?=
 =?utf-8?B?UkVROEdUU01nNmU3ZXV0RUJ6bnJpczc1Y294Ri9pVjU4cVlTV0ZkeERTM1FF?=
 =?utf-8?B?MEY3QlhVV2JPOVpacU5jOUFBY3FLMkZia3VISnJQSGJNR2FIQVA5RUhmbHpt?=
 =?utf-8?B?UE5kYUZuK3BldU9mL2R3ZzgzMXpkbTNiaUpzejU2b3ErZERwRURoa2YrSlB5?=
 =?utf-8?B?Zk8yM0ZQeGpraGFZcGZWdytBdkVPbVAzMTBKTCtENEUzN0hPMGVaQzRXOFRL?=
 =?utf-8?B?R1lvWXJzcG51bEhERVp6MGZudUh5UDVtZUlVeEVzTlJtVXN3cnpudVNURUw4?=
 =?utf-8?B?dGE0TEVKb2tpaFVtekx3dkVyY083dDZaUGVvV0tpNSt4K2hKbTAyelZVeGda?=
 =?utf-8?B?TUJYOU5aOGdhU3JmU2V5TUpCaEJicHc2YU56R0luL1NUMGg4UDlBWGhkWnFN?=
 =?utf-8?B?OW82NnJneFg0aUF5MHF2Mklmckw3MzM5ckloeUVoTS9TUTlYcEVHMmlROGpw?=
 =?utf-8?B?QnNQSXBkUEZKWHhQK24va3NQVERqeWpPb0lpc25uT05Id2RKU1l2alJVZGJk?=
 =?utf-8?B?SEFRZzM3alU1YWJkRnNhbDM4NFdVb0p2SVR5QytSTmRkam12eVlLa2NObEdI?=
 =?utf-8?B?NjhCZi93UVVzcVZrNUZmMWtWYjhSOHBPTDZ2RlRpSHhuWWZPcDkvRVlPUHRu?=
 =?utf-8?B?MEdvMHpRWVNpQ3pScTB2UjI0aTREa2gvc1ZyUjN1ZHd2TXM1bkJkdG1Nbkt4?=
 =?utf-8?Q?2aopV2SnBRdhhCEqd7GhnC4Ca?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf21b74f-28af-4f3d-9107-08dc5a867e88
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 00:21:27.5751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IgNo04dkrSCTA1/naVQY7lHLcQFNbeIQPCD5nVc5/4+NHJs0r65WyFGuHes1MpgoprHHrQ1g/Qfrs3ujqKSyIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7970

From: Peng Fan <peng.fan@nxp.com>

i.MX95 Pinctrl is managed by SCMI firmware using OEM extensions. This
patch is to add i.MX95 Pinctrl OEM extensions properties.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../bindings/pinctrl/nxp,imx95-pinctrl.yaml        | 44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/nxp,imx95-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/nxp,imx95-pinctrl.yaml
new file mode 100644
index 000000000000..4bf7a6192813
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/nxp,imx95-pinctrl.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2024 NXP
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/nxp,imx95-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX System Control and Management Interface (SCMI) Pinctrl Protocol
+
+maintainers:
+  - Peng Fan <peng.fan@arm.com>
+
+patternProperties:
+  '-pins$': false
+  'grp$':
+    type: object
+
+    properties:
+      $nodename:
+        pattern: "^[0-9a-f]+$"
+
+      pins:
+        $ref: /schemas/types.yaml#/definitions/string
+        description: name of the pin
+
+      nxp,func-id:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: high impedance mode ("third-state", "floating")
+
+      nxp,pin-conf:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: latch weakly
+
+      nxp,daisy-id:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: pull up the pin. Takes as optional argument on hardware
+          supporting it the pull strength in Ohm.
+
+      nxp,daisy-conf:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: pull down the pin. Takes as optional argument on hardware
+          supporting it the pull strength in Ohm.
+
+additionalProperties: true

-- 
2.37.1



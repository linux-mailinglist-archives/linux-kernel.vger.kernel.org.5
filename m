Return-Path: <linux-kernel+bounces-103287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8032587BD81
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CED03B22A15
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B72D6CDC9;
	Thu, 14 Mar 2024 13:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Q1P7MlvS"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B726FE39;
	Thu, 14 Mar 2024 13:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710422272; cv=fail; b=AkAlhNZqRH2B4odFFHNjHGNgj3Tdw+A0CjdRLWQ4bvUjeFy1m6Zq1SwEw+92Pm6pdjaGZevjOrU1y7AGpSKq0GfcDmxr4PNLna17yhPmcG7yX98W3+6gVfyMPyHXS3lUEuMxxVOQ0VdKs0JtP1ibOJZ5jG3HBQPj5LP7AAf6MHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710422272; c=relaxed/simple;
	bh=OeXtsqat6KQ1ASDv+S8KaZKv7eWjrTahnKJ1rmgiH+g=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=UaE9ityqnRja1c6tUKgXTmamTNshjcBT1cZz9JO9kJEoRoxwJhDKKoRplnMuEIY5toHsDxuEH+jOk8E9lYRkmTfEdGhNJNJiZ+ZdBidZpAQpZFAkpFBx8m5tKoWckS/CYGE1D9hpDc5JDvF6wB/OlxduJWQByEvvguaCPtSih/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Q1P7MlvS; arc=fail smtp.client-ip=40.107.21.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OK4onKoObw1o1f5x+fOFrmnhgzSyQNxTUL7ALn4wPKjIKN6hzXkvRFGDcaoKFRi8WwyjnQsJmaKLPI2DyFhJ+QyRQ8dboVCpKzeszCvKFJLjB306WD48+IcnUJk10pQkFZ22jmmWZf/IXcZbCvbsBucsOanxgKRSHBW0fh9D9mm6RlogiaWudgD2CnNeAz1+fW82mjHjaDTE5JGl5QTJ1EIKaTdThU3Z3kUiSyCnm+RWsxnX6/p4dpgq/EYYjxJXOGA1OBdDcn6nXIdHq74cAF6uPNWBKtAJTr+vpA2+oxlJtDknYpH3EZqKcFgWL0130OB4M4jt7n9XeekJmaizdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVkPVCx2uXoB1bpqiX0SUEO1xPAztNm13cFjuRACpl4=;
 b=dcRFUeKd/PirfOT6eFJZ+9eRERwkhduZr0c7Yrwrrfibd6d91YdlD75FsXOSdW2Y5PKdOA6zqTUXxofxuZlkZyJfvGkWd2j+O54vFFre3i5V4jpXodEgaubcyFwU0rO0mVqkavTZTcjFufDEvYmXgWh7b5UXx7Oan0Ey9/dAGJZC1nMefenGeWqKQyVjcFFavblIbrmVe+yEMkaAId4LPS35+pw6Wpmz+bymjjX6mILgeOt6CxhkYcIRv6szNvl53NynjzEWKT4O57nX0XEhtj3Rj0O2zdwQ9kkst6PGH7HkeIVAfCdyizQ9w2osxD0e0lBq2IxnDDi6KY9ImANHuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVkPVCx2uXoB1bpqiX0SUEO1xPAztNm13cFjuRACpl4=;
 b=Q1P7MlvSIKxpRne5HDxjllRoa8EstSkYKaXD3pS3NL3PfTCwIldHSoXZQ0CpqQ/gaav4WnOc7sZT7vYFuf834sCSkL3PDOxLT8hgjdZxV7Umpb5rs72Ky38nUlG8SRZlGnNZ7epRE5XyOI4GKBijvmhXWNvmyZ9cqNI3Xqjm++M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8806.eurprd04.prod.outlook.com (2603:10a6:10:2e1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Thu, 14 Mar
 2024 13:17:47 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 13:17:47 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 14 Mar 2024 21:25:13 +0800
Subject: [PATCH v4 4/6] dt-bindindgs: clock: nxp: support i.MX95 LVDS CSR
 module
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240314-imx95-blk-ctl-v4-4-d23de23b6ff2@nxp.com>
References: <20240314-imx95-blk-ctl-v4-0-d23de23b6ff2@nxp.com>
In-Reply-To: <20240314-imx95-blk-ctl-v4-0-d23de23b6ff2@nxp.com>
To: Abel Vesa <abelvesa@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710422742; l=2429;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=JX7CNjyl9cprSkviDE66rU7vOase6VqCPKB/81XgSX8=;
 b=rAcngb6LZm9q0Le4/zHwZFNoon47reDKh816q1P6eegU+kOXhwyXBctJ/64qj0OH1oousOosK
 ybPJsiF7DwyCpNQjukM9MJUq+gyC7s2oui8VjUYZw5EnihPAuUSAgXl
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR01CA0130.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::34) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB8806:EE_
X-MS-Office365-Filtering-Correlation-Id: 037a1d5e-52d9-4c5b-deac-08dc44292414
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VX6LBvSs138iTM28rRX/Q85rJkvBCTl0gxyZ/B+F07MoHrX1lUTv8pJIDZI+5zAh7X582WEnP+9aWAGqFUdp3FsBHlBQF+Q9oMrxgOdNI/UP2bZ8t3/1YaSSovkB13ViQYvmqKoauAKnkI6Jspzz4CghW0KAO5bt1f1ieWJLpMCfN85z1WtvrQYOZW2PJsXoAfCHAYgwkPeIOnMP91oNqqTWN+U/t5i3G0OgQN7cFon71TKCBycocbn1ByjK0YInnyAshlfqeT42VFTzWzeFACFLl39IKq5/iYgQYVG8BpZIOt3qDjrufLow/Okpa/3gH11BrETL6MAizceh1GxoBbsMPLejnJiZ3AL837pj2MQQ44HX3ixMUXUoMm1h3ZOGXopB+e/g2BfibyzM+Mew5Go5Yc6lmQzzzKKv9cBsFiFlPhPrntZYR1UumzBl99DE0Z79OoE5di6MsB5dKgfT/xuAl2spWZ4LiOi7c3th5acCoOZL7jc/hSz5QG2KtAK/wRvnNwdPJri98XDmLjGgYYOacG3JIyJoFB0+5JOCDyiXusFYz6LWL/148NMkoufIQl51/eIarE1NADuh0XZOoKchQYha5VwT61VH/Fx59VOzmgQh7iqzCnimDMnZYdePhmcg0bxszShdVxiO+wWbwiR1b38BfW8Rl1/3BS+gQntqDINZYNqZnVh5xCRuD2jw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(52116005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MnhDcWZWODl4ZVNDWW9ZT29HOGt0elN6eExRRU9UdTBIN05wem5uL2VVdmJK?=
 =?utf-8?B?UDZ4M3BZcDMxay9sYnFmWXJiYXVOckNLZDJJa1ErTURxSW1RbEpmQmNUT2RP?=
 =?utf-8?B?SmVwTDJsdEswZzMxL1hTTDlYWEZxRmQrZmNnZlI5VFB0ek1aM3h4dUZvWTRR?=
 =?utf-8?B?d2I4STdNV2ZmeDQxVk14U2lBUUtXVGYzU2tjWU1PYmphQmt0SnFndmRDSzR6?=
 =?utf-8?B?RksyWU1DR1BPMm9WWG5wSFR2VklkU1pNVVkrKzFNRjJ2MXM0RVpjNHE1eitC?=
 =?utf-8?B?QS83a2dSaERZZUVQbWk3SEZPYjRjZzlzWDErNWtrOE5DempjWGxTUlczSTlq?=
 =?utf-8?B?Ry9iYVYxcnEyWmlHNkxDNzJGbXkyQWFtZmo1UVNENFJzbi85S1FPNGZtVm1m?=
 =?utf-8?B?RW4yNUxTaTdQd3FnM2wzZTBlL01ZUC9nd0tNYjFaOGFCcXVKMHR4Y25KM1BD?=
 =?utf-8?B?ZFN0UDhmbjlMMXhlUnlCSzRXdHlVQmtDUzJTN3pOeFhPQ21WckFjMUpmL0h1?=
 =?utf-8?B?MWxSZkRpWUxoZjc1elNJWVYwbG5XYnpwRmZqUis0M3RLWmtjM21mbjRuSXhM?=
 =?utf-8?B?UEpaSDR5TVZhTldKL2JLcHlyOGsyTWxITzluNmJ4dnBJT1VuOUprQlVyeUJu?=
 =?utf-8?B?eHlWZ1BscCs4eWRXY0UvTTNCdWZWeVQvVVN3VkdoejZzMjg4MEMrYnFJbWNZ?=
 =?utf-8?B?NjBlMDlHNnpOaWRWMWdKOTR6Q0JuY2RuMFhwdFVYYUE4bWZSNWF4MDhQTGFj?=
 =?utf-8?B?K2owVDBqQ0Z2NU5uWlpYTTBKUFZ5TFNTdU1mNytuMG1PbUpiTlFwdHBqaUF4?=
 =?utf-8?B?TVJwbExXMlRtSnYrNURSb2tNRGdoa1p1aFhlSXV6b3IvOWdWblB0Um1nQWdI?=
 =?utf-8?B?aWwxSUhBRHZLOHdWOHBzR0N4S1J2bEs2N1JaU0x0TGxYZDNoeVoxSVh1VlJr?=
 =?utf-8?B?RFAzRk4wWG53emNNWndLcEpQRTRJTUZLekdaZldKZzNDdzJTd1dsMzVNMjJz?=
 =?utf-8?B?b3I4NG5kNDlQRkZBdVhVc2JPa0Yzc3hWSXMvM0dCdzhTNS9NR3h4TnNMNjZ5?=
 =?utf-8?B?S0k0OWtCMEI1d3VkMVF5Y0VqbFpiYmlhK29IRXlvUFU2SEkyL1dLK0xBd3Bj?=
 =?utf-8?B?Tmk4REhYQUF4SXRDVjR2bnQ3N0pSYlMxVVlLc2NreVFySS94aUtpamR3V1ly?=
 =?utf-8?B?dFF5aVF5NTJuUUlGTG13SkhnTXdFdzM2QUNKSEtNSGlnT2pDTUU4MHJFSkRp?=
 =?utf-8?B?M2UrNTF5UlFpL0lkajQ0a3BnVFhDdC9YY0tDam1CaExLMWZOT2dQK05FYlFF?=
 =?utf-8?B?bTBFQWZ6TFFhcUlsMTV4RjN3YSs5a1ZqYWpwVGpVWGtCdmMyTTVlczJjeTM4?=
 =?utf-8?B?amIxNlJCV29Md1Vrb0ZnbjdBajdMNi9UakUxSG9nMit2ekxMNHVSUVNlbDhP?=
 =?utf-8?B?ZXIrUEd1ZjNRWXFSb2wydlZvc2ZPRm5TQTRXbFhPWGNiS2xjN21EM0dQSUV0?=
 =?utf-8?B?Tmk3alFwc3hianNxckswYW1xUE1lNUV6S2cweXB3VW9DcklHVllGbVpOQ1hE?=
 =?utf-8?B?OE5QY0JyUUxXVHVLN3VLT3NkcFlhVUM0L1NSajU3SEN2SURaVW1RcmdxYXJI?=
 =?utf-8?B?aExaZkNFWHNrV25IZXRHT09XUlJ5cmh3SlMyNmlsMjYzZUJmc1dUQS9MRFB6?=
 =?utf-8?B?dGNZOE15YzZyNmo3Rml1aTJ4Y281Zk1SeHhVZ3N2SVZzWGJjWHBnNmFYeUVP?=
 =?utf-8?B?RGlpTWtveUdBVU1NR25TQUJHcW5KVUtwdm1CRHEyaE1RSk9zdXlBR2lnNVJM?=
 =?utf-8?B?Vmdwc1dMUzdLVmxiYm5MQ0p2REExWlFTY2tSTUtPcXp3MHExdndKYjFscEpU?=
 =?utf-8?B?SWlZTW9JeEl5MzQyVnlqMC96Rmx4dGdrUGxROHlDVi9jeFVIc3M0WE1YVlpU?=
 =?utf-8?B?bHVaSXVWbk1iRWN4eHJ2SEVoV1BXWEEzdHRxanNNNzc5NlpSemFrUUw4cmJJ?=
 =?utf-8?B?MmhlblhRL0srVVVPSWIvaFVYS3o1RlhraTl5SEFSR1ZqaDV0OVlyUTNUMUc1?=
 =?utf-8?B?Rkdmc011akpIVVk0YzRLdmRsYzd3andYeW1wWmc0eVFsWmY3c2xpcGNJWjBn?=
 =?utf-8?Q?/Gla+uoAvVm20BPuXAFjJGK9V?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 037a1d5e-52d9-4c5b-deac-08dc44292414
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 13:17:47.0596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 97AHEhONxjIGz3apNFePEC6P9syVQgoYYBt1Cp8QoLGAhhTZ0ExSmgWvUW5K51bs/S2ynTMSW700dZMMTKEQZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8806

From: Peng Fan <peng.fan@nxp.com>

The i.MX95 LVDS_CSR provides clock gate controls for the LVDS units, LVDS
PHY and Pixel Mapper blocks. Add dt-binding for it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../bindings/clock/nxp,imx95-lvds-csr.yaml         | 50 ++++++++++++++++++++++
 include/dt-bindings/clock/nxp,imx95-clock.h        |  7 +++
 2 files changed, 57 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/nxp,imx95-lvds-csr.yaml b/Documentation/devicetree/bindings/clock/nxp,imx95-lvds-csr.yaml
new file mode 100644
index 000000000000..e04f0ca4f588
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/nxp,imx95-lvds-csr.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/nxp,imx95-lvds-csr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX95 Display LVDS Block Control
+
+maintainers:
+  - Peng Fan <peng.fan@nxp.com>
+
+properties:
+  compatible:
+    items:
+      - const: nxp,imx95-lvds-csr
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+    description:
+      The clock consumer should specify the desired clock by having the clock
+      ID in its "clocks" phandle cell. See
+      include/dt-bindings/clock/nxp,imx95-clock.h
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    syscon@4c410000 {
+      compatible = "nxp,imx95-lvds-csr", "syscon";
+      reg = <0x4c410000 0x10000>;
+      #clock-cells = <1>;
+      clocks = <&scmi_clk 75>;
+      power-domains = <&scmi_devpd 13>;
+    };
+...
diff --git a/include/dt-bindings/clock/nxp,imx95-clock.h b/include/dt-bindings/clock/nxp,imx95-clock.h
index c671c4dbb4d5..e642a54c81a0 100644
--- a/include/dt-bindings/clock/nxp,imx95-clock.h
+++ b/include/dt-bindings/clock/nxp,imx95-clock.h
@@ -18,4 +18,11 @@
 #define IMX95_CLK_CAMBLK_ISP			4
 #define IMX95_CLK_CAMBLK_END			5
 
+#define IMX95_CLK_DISPMIX_LVDS_PHY_DIV		0
+#define IMX95_CLK_DISPMIX_LVDS_CH0_GATE		1
+#define IMX95_CLK_DISPMIX_LVDS_CH1_GATE		2
+#define IMX95_CLK_DISPMIX_PIX_DI0_GATE		3
+#define IMX95_CLK_DISPMIX_PIX_DI1_GATE		4
+#define IMX95_CLK_DISPMIX_LVDS_CSR_END		5
+
 #endif	/* __DT_BINDINGS_CLOCK_IMX95_H */

-- 
2.37.1



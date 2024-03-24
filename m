Return-Path: <linux-kernel+bounces-112611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D288C887BEF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 08:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CC451C21417
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 07:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FF314F68;
	Sun, 24 Mar 2024 07:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="klkBJ7LK"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2044.outbound.protection.outlook.com [40.107.20.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C27914AB0;
	Sun, 24 Mar 2024 07:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711266241; cv=fail; b=MHuZsSUh4Ckkx+od6rRqTN2RMTg9pI/lkRzZEXFwuzxfDoyIBKiKEophQG2c7X1o2WT8FEDqPFU2S9wXAwebn1IKNUCVYdBQwOkvnZ6ijn3mGbnVablCbsdKFEXaV30zqqUaN4ICuRQiqu0WZ5LE9tGuoTQdTZfShA8K2Z3IsoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711266241; c=relaxed/simple;
	bh=m+r5SUBL4v9ntlfw34ONh+x4EEDqaBnMWcDfcBb020c=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=hTJs4pWysgo6rU0pcWL8C5RNJBHTp+0jBvS+UN5XDCU9wc/yzXWQOYvvM80DqSlFVbV1GRHrPqkp0ZGPAO8qocw7vnzaTsAUgk1bwSMWgVTkuyXZvUKzauAI+fD2i6m/uDmz1BY7P3DPJMoRPx8a3sVNxmwnqiKs/fZ1TGScZLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=klkBJ7LK; arc=fail smtp.client-ip=40.107.20.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IdXLQ/J0TSycLLH1l8Nlwu8XpEmE4oqcf9kWBwZrcb+OiDYhp9oKXtK0ytHhcSdNiTwsJfrHtCzStuvI5il1yCmn6d8WTXCKzdHmIwXdNlb4vzXXwT2zbNdrtvS8WY3OvlaQhhslFkhpzuVUuxPgnx0plRuCFFRA2lkM6XvQpcA4tGHW8pB7WEkXM+uO/BQ+yj2WjCAOH8TOC+ADGiNbJ5aD8wGBD+X87It8wd5r5Nc+/f/gaAUKLgSDBUqhI705UZZmm4FfXIrVRD9PCOswuEKziePBBjN7QM/edLh0XlcHcMQaPzSaxqQ/lzSBSH92Dns1emS4ksPWaHxMIq++JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vJG7nyYLtXQbNZL4JHRaQLlGcrEr801+/wSHUrIZWc=;
 b=Xfg+aebyDtUsI82OeRc/pI00roM3pmSPF1QrisDpU3wRX/tOMEyVWfO41Dfr0OZW7JcqhYK38ZwmI6iLIwgVQqYN/z8bJsL88l+m2zn5xfYLEniUqwhMpcizpvQcDVg7KVKLpMqyzDj7KMGYuRwSIkE+2qrKVUxR8Wb8EPRYteJ0rhCWxNzIAMwtQTwmNNmfnIVP2vAYr0JduLpUailp4nDStYZMaU9el2UR+SdYLl+x8szSX5Hdlv/xNV3ZZKcphKuU28d55gj84GoP5LCuGk5vUJ3yUkKvtxS6ioe4nOT+Bpbiu/+GRWG6rXqJllbiAC2Fmk4wmeqsTfv4xxVfDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8vJG7nyYLtXQbNZL4JHRaQLlGcrEr801+/wSHUrIZWc=;
 b=klkBJ7LKyDY3A/RYQfI2j6y4uoVTrSSLZXomPR3xCZem03+aiweMzabvRAfWfnnXZ0ovoOZzr1Gxbfxf5nNuwfmCd73xlJ95Y9KTNaJpyAcq+WfM2feCkCHvj24H1g7+sofiMROdP6UJok4v2sCOTbNYGg5QtvTiGtxSrjU9xM4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8573.eurprd04.prod.outlook.com (2603:10a6:102:214::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Sun, 24 Mar
 2024 07:43:56 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Sun, 24 Mar 2024
 07:43:56 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 24 Mar 2024 15:52:00 +0800
Subject: [PATCH v5 1/4] dt-bindings: clock: support i.MX95 BLK CTL module
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240324-imx95-blk-ctl-v5-1-7a706174078a@nxp.com>
References: <20240324-imx95-blk-ctl-v5-0-7a706174078a@nxp.com>
In-Reply-To: <20240324-imx95-blk-ctl-v5-0-7a706174078a@nxp.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711266729; l=1998;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=Y4/LUiMlKLBfTGVdss+IGPH4VFaA9w7WVQalTBlF5Dw=;
 b=pwlm4dp0O9uVJj7nwzYvv+lQvtU/DgujDfy257RmZtQOvRKRUtXq7Z0ShvOrNoemUwRU702h3
 n/b1PA/1q+HC39XmvGs5Z/AXfb5VhNH/jxT8yCjh3TIhzUiq9+7UTNX
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR03CA0110.apcprd03.prod.outlook.com
 (2603:1096:4:91::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a522348-19c8-403e-af14-08dc4bd62947
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4fMMYCsTl5pHnzO7PaPfPQwy64uaSeBVHO64qLQPXc3+ojbAHG2HWytBQW+nYjgcR2vjmYnOnnXjoHaG5Xw+ZPs57CkQm5RBa435wBFmZZyDBE7lhxDc8nb2Bn0oArpLloo1x0PV4Pyd2CbCVIHhTKPfvyUDEf648IMZQlIT4wJnNE0YDL6tEvzDa+GPv8pkBOdZ8M9o/blopvJVG4jAFcgeY07cJOj/rs2vhHD2aC5RM1DsXjL6UeE9YfLWfmyQWACnCTbt53wq2NdnUDaZ3YbeEZd+U1Yz7RreFUf9huIjbDjPS8w+B1+BZLCCA/ivwkvS8tfY0Uo68A9RBSupmHvGtnSMcL9tSlfXHWcZq/AoQ66Y6YQ/VJ6p7zz8pcqx0Ax/M7tLVqEo56bfPMeqayilgi7bqvVRtZb1Ajj3i3lLXHrNnBW+ljkSvIJkjIw0Z8uelWlp7y1OHcHvOx9pX38JH8sfa9bvSRsk2PX9w1vw+Afn0NVA4LSvfY2ZakhbOwcoqlPAv61ZwEyvUdZvuMrGXPgEvguASBs1Sq8FkQcodmcDR/T4iCuuEtBppRMNt+Mde9i+8Zq4ImmAhgm0XfUaeEoZJJiLW1UaFFxu+cHWbWLNbF13TSHCx5877zG1ARXQQoIbt+1HK3njelLkdxacFM5pJ0nFdC7PrQXdvjkEvf3sNW4EniUqGocqvMU/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(52116005)(366007)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWtWaXhoSTduUXo3MksxSnNpc2VEZXBtNTdVNTRVNUlSWEd4clA5VVhIaVEw?=
 =?utf-8?B?WnJveVM0a1BrZEtJL1c4dW9GMTE5VStucUNMOG9kUmxuYVRnZk9RbE1aRTNy?=
 =?utf-8?B?a3VWY2pIWnN2eGpFYnlmSnoybW5pWm40ZStRSVA2MDNOdzVDNThHTXVzSjE2?=
 =?utf-8?B?VkwzczR0YXJJZWJiTlhkN1FCcHVxR0xvZ3JTQUI4YUJoRkEzWTBaK2hXV3lF?=
 =?utf-8?B?Y29UV3c4R05vYjBvd2V4bFdSTi84ZHRlZ01Xb0YwSDJDVG94cS9zRlhYYWp2?=
 =?utf-8?B?a0FRWUFYeDNLNThiaURhdjhPcUtMckRSU3VqYlRuZVNyTXZzalZMOThGUmo1?=
 =?utf-8?B?NEtIWk9INi9wNlkwcWVGaG1HRmFvL2VHTHVVZ2JIN3RRQ2dpQkdpN0g5RDV4?=
 =?utf-8?B?dktaK3JqaGh1WUphdW5JSmhDQ0NKa280NU5hTjBpNk9jYWdYL2lvbEV1SEVL?=
 =?utf-8?B?bkVwdERkVmdIaW03UHdEOTQvUEUyM3FpQ3BYR095bnJKVVdnYU1BKy9ZMkt4?=
 =?utf-8?B?MHJKYkdaUEdUbzhJaFN4SnkwMHhpKzhlWmV5anlTUlVJVVpid2VFRTZ1RnNm?=
 =?utf-8?B?NjhmQjB0UWpoNGFvWUREODNrSUszZ2psODJ2SjcrRHJ5VWhUNlNReTAzU3hh?=
 =?utf-8?B?dXlFSENiVkRiZFl6VUdFRzRxaDBkSld0YzB2MnBmems2UDAzOUN6U2JpenZo?=
 =?utf-8?B?QTdtK1hlSlNHUnRpOFpOaklJMy9RTlA4VGpaZVY2clhBZUY4OWZ5VWxnSXAv?=
 =?utf-8?B?WUFkdy8yY2hkMGJIb2lxOWdPTUk4TXFCUkRiZmhMZzNyOWMwejUzK2kzOEpM?=
 =?utf-8?B?M1hsWW9jNGJCT3plRytyc0pscDU1NzVXRmJFK3FXRTVQcWcwZ0JBKzh2cHRu?=
 =?utf-8?B?NmR4eElCZ2tLWU1KODFmbXV6UUJKMUJBdkhhWE16aHp2T1c5cWpQZXF0RkJ4?=
 =?utf-8?B?Qk1XMXY1VGpzQU92Y1FMdGtSUE1UM3ZlMGFQYzdWaW43amhkdjNrRjNXSmg1?=
 =?utf-8?B?ODlQL0dvMW9RYVh2bldrNG9ZUkMwejFRZXBkT20zRTFTQXRoSW9wU1QwWlNV?=
 =?utf-8?B?MHJpRlFXcnRzdmt4SWFQN3JxK2FsUS9sOVNCcTU5bWRvZnI5UjhGYU9IQUFE?=
 =?utf-8?B?M0JFdkFnNEFkUFNjUis0YVhJUGNtNksrYVVFZm5qK2doZmptczJ5bVM1UUwy?=
 =?utf-8?B?NVlhRUNHN1NYc0xVWFVxVlpEMGtzMUIxc05pb3gzdTZJNlo0Y2F5bkdiajhs?=
 =?utf-8?B?Nmt0WlhHeTJUZUFUeXdlbzNNOFdJenNabFN6M0lOZHFSeDhoVms1QlJGdGVo?=
 =?utf-8?B?d0ZkSHhLWFp5dUg0eHFrYVpaZGVVOWxiMUs4YWNMQ0NLMjFKWDJHRERjdEFO?=
 =?utf-8?B?VldLZEVNQk9xZnduYmFMUi9RYU9keXk2Mng2YTZEd09sbXp3VnFCdVczS1ly?=
 =?utf-8?B?OTg5TTRFbnNCOVp0ZHVkYklZMjUwZmdscjdpWktwckpONisralJUc0ZCejV4?=
 =?utf-8?B?RitqQzZLcW9scEh1UmNGRW02alpVWDNZdzBNQVcvOHBxelp0WkJZNWtBLzNl?=
 =?utf-8?B?NVJ6TWtscUZHR2hRdmpDTlJncVJVOTRRYVJxR1QzQkVHQmhZQTZJekkrV3pw?=
 =?utf-8?B?SU92cEVOR21YRmFveWpwMlp5SnVLK3RxMEdNZzF3UEZ2U3VVYm9xYUwvdmta?=
 =?utf-8?B?cWZrc0gyZ295M2RGV09sRXRaNThJQkd5cnBzaVVIS3RvWlArVjBvT2VKVnRt?=
 =?utf-8?B?Wm40MlZtZWVVVkhDUGZlWTROYm1sdEVQS1Z4eUtkNGNycWkxZitWU3l4Z05o?=
 =?utf-8?B?V2ZCTkZjZ0lqbEVJdEIrZEx1T0tMQjdVdndDWFR0TnVCMk1XMnB6MS9DT0l1?=
 =?utf-8?B?WDZMdVRuQ0FZVW4xZnpwRUc3aXNaUHVrRzB0d1U4cWpUMlJjVWVSY0J3MlZH?=
 =?utf-8?B?TjZURFZ6b3BReTQxTTN4bEVQbTVPVFJQU1ZISHpwWmUvTzNUbkRQWXNqNU9O?=
 =?utf-8?B?T1NObDRCZ1BOR29ZY3I0U0dDYUFzRzZsUTQ4cjlYY0NNTU5kWERMYzBPU3Zz?=
 =?utf-8?B?TjVUaGcvKzlMQmZrTi9IMGc2Z0R6QlpzcXpkdzlBUVJhZG9tMmorVVVHRUJ1?=
 =?utf-8?Q?7r2jf7lh/dv4+sM/49RizeNkL?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a522348-19c8-403e-af14-08dc4bd62947
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2024 07:43:56.8529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CkqbM7jlXl1zTx4lOmEMmSI9n7Sv6njt680DjZF0Hz7NMdsBLrmoCFtfzSfTjkDv8KYlsi+/KaWSAyyH03PFFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8573

From: Peng Fan <peng.fan@nxp.com>

i.MX95 includes BLK CTL module in several MIXes, such as VPU_CSR in
VPUMIX, CAMERA_CSR in CAMERAMIX and etc.

The BLK CTL module is used for various settings of a specific MIX, such
as clock, QoS and etc.

This patch is to add some BLK CTL modules that has clock features.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../bindings/clock/nxp,imx95-blk-ctl.yaml          | 56 ++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
new file mode 100644
index 000000000000..2dffc02dcd8b
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/nxp,imx95-blk-ctl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX95 Block Control
+
+maintainers:
+  - Peng Fan <peng.fan@nxp.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - nxp,imx95-lvds-csr
+          - nxp,imx95-display-csr
+          - nxp,imx95-camera-csr
+          - nxp,imx95-vpu-csr
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
+  - power-domains
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    syscon@4c410000 {
+      compatible = "nxp,imx95-vpu-csr", "syscon";
+      reg = <0x4c410000 0x10000>;
+      #clock-cells = <1>;
+      clocks = <&scmi_clk 114>;
+      power-domains = <&scmi_devpd 21>;
+    };
+...

-- 
2.37.1



Return-Path: <linux-kernel+bounces-141741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA04A8A22D6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 02:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC2921C21FA8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 00:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BDF8F5C;
	Fri, 12 Apr 2024 00:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PrVKTz6j"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2052.outbound.protection.outlook.com [40.107.15.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DF579F2;
	Fri, 12 Apr 2024 00:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712880811; cv=fail; b=RVJMDGXkH2QqvAB0hMuCP5CmVN9977BDtUWVbXwv0Ojr4sLjpCiSDRkYgUAGFaiYmmUbKZitt+S/H39l1QAccb9ffJHBP35MDi0ItezCRdtx1omINohq0qFPZJU3qzZ+NDtp1DRpIZC/oanUWdmvKg1VK92xpjONOff4senyTxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712880811; c=relaxed/simple;
	bh=E++RdVjEyJKaeRP3uQ6km4a3etsBjQNzluyId+6G+dQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=PJiupqma5suJVx20wgCTYxbhRtKt3D6GkzIgI1BkzXEgYgjcNbK8Ffwq5l2EEf7WJXyv3ip3fFZv1Tworzd/mpfBHHUYiyw5kmYhD0b9fZfmWnK4+4/x/k6fnznAPFME26cvbrewaDvtxmAOV+mOb4nlaoToxmr0mzEDaChdXMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=PrVKTz6j; arc=fail smtp.client-ip=40.107.15.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DjwUiOLxH4CtoMbI6XgJftxF3iEqFgg0KRVzi74lb6OPfQLxSfRD7XSRU9iUB8bYRrgdfaLhi43AIOI2qdDelwbH4rul8kY7SGF+HHnfw2JatWdMTP07jTu+X8/mvzeOmuBhVl60dm2y8rrFnoa5fnjcfctz0ZWMbwiQVM2n7avVcVqa8eCHgzao+50gN9BHI5TaJjC/G2cBzUS44nzeNUuk9zHAJJKZuKfdyNkQPzGZ/nzk/nUjsx7E1HFGehZolhCX/3Y5e/iMtLospD2IgOY98wWOeFhwmqFgBn/P5J0NtbOMiI+EF9xkAmU0gJSwzQuaHrcip3xhZp7XEHGzvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBQe0Od3+rHWfruV+PspmNFR5QiiEhNYWfshtcWJTzM=;
 b=QzbUBqXEp2iUUk3TxnL5vxTbt2Nu+ycGSZMGsmUFQ119q8BQfR+68dxQE5CgwOvbx1skecwrEA8XwqPK3bo+4ac8Of2C/aXsptHxAiwa1XbXuxGa9ZoqsZaf8d0za9i+kh8i19eVrpXtzZT2x4HsJfWF+bxDw3tLy4z/M4rjYfJdYe6Gx1Nk+F0e8RaN4/tnpZZR2iTX8TAxf7BR8CrSv2hwT9zC3w/fIM2/qe/JasKB4+0SuxE1zCZ3tqeNoImtzDHx99SQtnMzU1LX0pJQTR6N0slfwQlkuswLmXn7OghVTbcbkkdRE7QSlFAgDrTSz5CJeAcidWHCVox0DyCprA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBQe0Od3+rHWfruV+PspmNFR5QiiEhNYWfshtcWJTzM=;
 b=PrVKTz6jNTI4xU4jVVvyaOzVhzJw9nwiz1NbcnkZv5alwCFjoBGVJiEdG1Qe8usPj480RZLjS512y0grANR2cMXiHB093maazvJQ43Xe9FG4Cvyr3xTI+Qj6XM6CRjACwn2lC83BQaGqu3rvoUAwiHHcXexonH/rlUJsL9GeSs4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7970.eurprd04.prod.outlook.com (2603:10a6:20b:24f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 00:13:25 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Fri, 12 Apr 2024
 00:13:25 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 12 Apr 2024 08:21:20 +0800
Subject: [PATCH v9 2/4] dt-bindings: firmware: arm,scmi: support pinctrl
 protocol
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240412-pinctrl-scmi-v9-2-b817344d3a9a@nxp.com>
References: <20240412-pinctrl-scmi-v9-0-b817344d3a9a@nxp.com>
In-Reply-To: <20240412-pinctrl-scmi-v9-0-b817344d3a9a@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Dhruva Gole <d-gole@ti.com>, 
 Andy Shevchenko <andy.shevchenko@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712881290; l=2404;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=DFipHsGSFA9e8Nki9cC2yHmdVxAiRFl+Y09BDYDmlDA=;
 b=ereRO0xZDMytxw4d03hXxnLmm7SSi0K/35MXrbSAOfk/dXUHsZG6ra4Q1ouaKehZw4AyPQvoU
 C/0WSH7L5msAfTmTMgDAvJMvkzX9hGNRi/iebgirBEoHUrcjeJZt/Wo
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 02623f73-549f-438b-d0fb-08dc5a855f61
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3maq2RiSuXi0qYi4UTBkrOAQ44dvKiU6kSmjwXyIu+85vDMGfY00SUxejPT0ATBQQyO4MrqriKwSSOqpeU+08Eps67FqMkNSeGtY8QeUqRYWx8/A1iaA1O6gfJyKcs4RtmirRckySzmf1qCrhk6yBYUESlJ16hjrRFYzuTTY2WrWKldqTyadOSpAFNgS3wS/ijfFj3VY+O69WLVTqRHYT1SCA5fYEdyzjYgcfh8Gne2eg2MKS67xYv9F9Nt4HNYIYPtxx6OjanGP0qtbG1avYUjNWYTgkCDWPFkVRcmvuXJEaLYBE43X/qcmXoBPBDtbsh8T6G+Id+0JKjkzGvd5+k7OONlIigeTA9yYC0sbcbU8hUARjYz1IKjvZ9F3JtT2+lLQmh1apg+p+pGOeBbv87u60qZeX+TD+8E2g81PVadbenwq/Tb5imyrsVCso/TkBbbsq7YPH1okHHH6DEAIsM0P2dmjUWQz26soQNTCTXMuR6JCON1sZ3yN9QVFkEQU6laV4wDq+5Z5bYOERooOu3Ol+RUYvSqYVZSusaXJcI9rO+JPxcfmIxT6/wPj2OsuwnU6ZZ4JeBfQ5gsu007sqfg3nc+dFNJR82MiDHGtoUceh8truBOO3eFH+8QAmzFYRfS2l1KC44+M9iGJ9lcPlOXoKJFETsHu3gAuMBkGyXsblt57KHxjcnNBDVvlY+zg4nrLVShv24mZeWWmcEuPf3ci94SXS+Nb8vSvNT6/8TA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(7416005)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckNDc0w1UVgzSEdtUlp4Y0ZKanhlUVhmK3EweHppc2hKb1dlaG5uM1JsekhD?=
 =?utf-8?B?TVRCb0syeVAvOS9aeCtjWWFPNlVFdEpzWWE1TjJ4WU4venI0TllHbUtaUmsv?=
 =?utf-8?B?cmlQc0lMQkNoWEMvNmpZSXQ2eGVvUVJRUkwrYUlpeUpWeHpydXNlbmRNTnFt?=
 =?utf-8?B?SjF1TUhhWHFkNHZ6aFc0K3J4QlFaSjZmSUxURkpkVDdIWmpIUy8rUDR1enZK?=
 =?utf-8?B?T2c2M1MwbWp1ZGZTTWVRUHZvYTFLbXhXS3Y2b29HK25ZOXo3MjZNWVowbVd5?=
 =?utf-8?B?SDJiWWhaV2x4c1NwNjhuNjRZSTc1czJPcU9pdVg2Z2UzeUtzdHAyMW1RVUUw?=
 =?utf-8?B?d3JTeGRUNW1DckxZM0JlUWhId2NZckVnYjFXTlN1a3Nlcys4em5FcUd4d0pr?=
 =?utf-8?B?b0x5emFydlBCODFrZkFQZWFNTjFEcjBSS3ZHbW8rVW9WcG5QY3lMZjExUHVi?=
 =?utf-8?B?eXdDdjhYTmlKd1dYTnM4dEdTTXQwTkE0aWtiVEZGY0huV08xYk1GMXpOTGdl?=
 =?utf-8?B?L25GTktyNTZHeFg4RmFLbEJGZVJiMFd6MmRJVVpJMncxVjJWUWlQeGJNTUFS?=
 =?utf-8?B?TFhPK2VtZ2UzTUw4WUpiMURobWMrQ3RqalExN1dveGNsYlBuelhZQitzazlE?=
 =?utf-8?B?c010TFpQSnJJZUk2emhMZGRvY0VkSGtEREsveTdmRUlWb2tYSkkrUy94Qisy?=
 =?utf-8?B?Y0I3a2VYTEkrMXlXVjVHcWlzbDlQTDE1V2kyYnQ3N2ExT2U4cmRnRXZRRTVG?=
 =?utf-8?B?aHRtVTArTExCT1hwcWJEbHNZQjdNZDQ2K0JqVWNVR3hmQjd3UzhDMnM0VW1y?=
 =?utf-8?B?UVp2b0FZd3FhNEpyb3pwUDZvallMQ1JOK2dvU2VpSkdjK2llZ05uZFN1M0U3?=
 =?utf-8?B?RGI5WFRqc1E2SDZhdG40TVYwVGpiRWJOUnNxaXlNMUZhL2ZyakV1ZGxEUXRI?=
 =?utf-8?B?U2NhR3l2SUxyRC9kS09HZzFiZjhEa05FMFBmQWc5RE9NaHlaSjhpeVlkV2hR?=
 =?utf-8?B?WFoxWmJvWkpJY3dYeEZMRklQS0ozUVhlRDQ5WTFnMzRpWDNhS3hqajRSY0pD?=
 =?utf-8?B?VGlUREliZTlOdHN0M0dVTVN5UUlROW4rRW9lZmVST083djlTZUs0ZFUzNnBF?=
 =?utf-8?B?SnJrYmM0R1JFL2VqTlZZR3hMenlCWVVwY1FEUGNGczM5VlZrb0Z3c1pqVDdn?=
 =?utf-8?B?T0JTMEJzY3B1TUtselRVS0NuNzNSVDVIcGxJQk1TQXVPMUNlQUQxK09YR2M1?=
 =?utf-8?B?ZkNGYWFTQk1ZM0ZTaVpKSzJmUjNlSVJSU09uOGxXZGRyN04vQWJZK255dFBS?=
 =?utf-8?B?MDR3NFh0Qm1ndEVaMU53Q2NDN21wRjE0V01hV3E1VkhmN3BpTzlJRjlJVDB5?=
 =?utf-8?B?MEk0Sk5ET2lPNVJQZFd0SVZjdGlPSGk4VHlaWjBMWHQvWmN2MUxrTzFQcTN4?=
 =?utf-8?B?aG5NaVd0NU05SmMycnRiQ2xIMFkvSG5qVHJhQ0ZWL3dDamxYUDVuZXdGaUR1?=
 =?utf-8?B?UzlPRm9DN0lSa1lpSU4xRmk5d0k4OGszY2hYcGN3aDVGdnBiYzI5Tlo5bDgw?=
 =?utf-8?B?YmVybTdtdDFGYTJ4UFg4ckxQYkxwWEFnRDhycUl6K0kxUXRFMmkrUW9kUklR?=
 =?utf-8?B?TkFmb0dtcmV0OUdOSjVWbHFYZ2w3eWVlNWpEVFZYREhmQ1QvN3dCT051Tnhn?=
 =?utf-8?B?NW00OFBpdFRaMHVXSVpwYTc5RGdITkh1SFhPcjNYREQwMUZvQzRHVUF5d1ZV?=
 =?utf-8?B?OTArMi81ZlZtSWpuVFVoM0JtbEdZUjViRWkwQVpOVGpjZ1VQVzY3UFcrUXp0?=
 =?utf-8?B?WExranVjNHVXbGM0b2xxcGJkbTNucWE2REVFOXZFUDVqS3hUclA0ZVJuNGk2?=
 =?utf-8?B?cVNFRUJ2eVM1bUV3ZGtyN3pwOHRLTlRXYS9XQVVBcU1vOEVSRjljUHhidVIr?=
 =?utf-8?B?c2xJeXZ2WTE0clZvZzdaeEtLZDhDNXRxdGpZQ003N1pKN0thQWVLUWVQTWxC?=
 =?utf-8?B?SUwzQysxNGNlRzVWY05VdysxdlZZQm5lRlRWL24rbnU4UGZJN1Z6Vm1LL1Bz?=
 =?utf-8?B?OTdnT2VQK29NZ2RsZ1hxdUNjZldaektwMUZwMDI5SE1kcFNYcmQ3Y25hTjRK?=
 =?utf-8?Q?GI58acwydkULJa3D+odZVHEAD?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02623f73-549f-438b-d0fb-08dc5a855f61
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 00:13:25.8387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: abPGrTC/Q3g+j1Yt68FnRVXrEhTQTCXAcKt2oTzfyXsxxrgQtYx9cGvwbifKwtnD0ZnMBXv8j3AwN7t5JaBb7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7970

From: Peng Fan <peng.fan@nxp.com>

Add SCMI v3.2 pinctrl protocol bindings and example.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/firmware/arm,scmi.yaml     | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index 4591523b51a0..e9d3f043c4ed 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -247,6 +247,37 @@ properties:
       reg:
         const: 0x18
 
+  protocol@19:
+    type: object
+    allOf:
+      - $ref: '#/$defs/protocol-node'
+      - $ref: /schemas/pinctrl/pinctrl.yaml
+
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        const: 0x19
+
+    patternProperties:
+      '-pins$':
+        type: object
+        allOf:
+          - $ref: /schemas/pinctrl/pincfg-node.yaml#
+          - $ref: /schemas/pinctrl/pinmux-node.yaml#
+        unevaluatedProperties: false
+
+        description:
+          A pin multiplexing sub-node describes how to configure a
+          set of pins in some desired function.
+          A single sub-node may define several pin configurations.
+          This sub-node is using the default pinctrl bindings to configure
+          pin multiplexing and using SCMI protocol to apply a specified
+          configuration.
+
+    required:
+      - reg
+
 additionalProperties: false
 
 $defs:
@@ -401,6 +432,25 @@ examples:
             scmi_powercap: protocol@18 {
                 reg = <0x18>;
             };
+
+            scmi_pinctrl: protocol@19 {
+                reg = <0x19>;
+
+                i2c2-pins {
+                    groups = "g_i2c2_a", "g_i2c2_b";
+                    function = "f_i2c2";
+                };
+
+                mdio-pins {
+                    groups = "g_avb_mdio";
+                    drive-strength = <24>;
+                };
+
+                keys_pins: keys-pins {
+                    pins = "gpio_5_17", "gpio_5_20", "gpio_5_22", "gpio_2_1";
+                    bias-pull-up;
+                };
+            };
         };
     };
 

-- 
2.37.1



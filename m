Return-Path: <linux-kernel+bounces-149395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E5A8A9095
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 03:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E530D1C21881
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 01:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630D7433D6;
	Thu, 18 Apr 2024 01:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kjwTSg5V"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2064.outbound.protection.outlook.com [40.107.104.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806AC39ACD;
	Thu, 18 Apr 2024 01:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713403485; cv=fail; b=UJLTMiG+NuHbA7zM/mnBLKVm+WulXszjG/WPAcipSAsxnYvO6oYpsULUIOgdFoj4u8TsE43WxCCRotutAkwqIPgN1eXqhpFjCxqRuJd1EWp1WmbKT9eMhjPBCsRnmf0t81/hDLgsZQnUkM6odVwGsPCuST/fpdj3FckAgbzxXVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713403485; c=relaxed/simple;
	bh=1zPbtoCNbOl7ALpohlegcy1tsXoTHb4w9RVFmhetJ9Y=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=kLQqzIawRbOFItjKjynBTnpBWP0ePqMqK6bLQjPtFVkl1JOkh9PEJxrU24ojAIcsmoTUk6sj7Z0mQs6Yqnvf3nfM2y6C48Pmy2ECOT7h/590SgSZ7wrDmME5t/54kWqW295vgNWwHtX8qLsyir0q+lMzS5/KJoHeeoi8NVCxfR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=kjwTSg5V; arc=fail smtp.client-ip=40.107.104.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmx4M6DmYthWkAZTlgkqwiXBzig/AKPzSaxvzt+ItPRoXBr+nBGquQ3LmlddTVKON/4/B18jbg/ZkOsNxPUbi0sumOrN1POe+BEnEEWcYtaYKNaMDUjAUNBuancibyIeWu4heYcCqWeis1NJ01uta3yGiCdl5KJshGa0k9tqMycwUnPD0lEL+gegdgKNerJMC0x5Rf0rv2BVvCicB92TEAKHJFEol0rRJUWjCsCBBjxXOXMxbAEXhU+0QqQiAOt+MevGpkG3cisKcFrheu1QaWhfPXa8xMytxxm+52oKE4/ugiaiAtt6vInfGpqb7uSL+Yqu9nSN4S+U0NX2GKrmCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEk/KyCGYEIR0nJYohvLG9OMHTkixQzPWb3gCR+cLZs=;
 b=dE6qJoElMWNLsazEnC5CTq2Leqa+lQC8TRiHiDfDg9BF4THRhW8/qx/SXFAM5cg9oTFDNh1XWaR/hQX4IMU3oGpY1rSAtfUsiNnIkr3Ultw6TEE2oJTb2VN/BMaQcQyjU5C+lqwqMDxrDPWdT+SlmjO+D/3fMHRtbX21MgCSXH2BXSyhmHdCWjb4KoIdamgqkzgPWtho0L1xkgpF/hVcpIuwxtaS5/koi7KTDzGw90HL/IUMEucwzRBq8Pp2PAfq6ePSpOYglgGF4TpXv01Cgse/4qJuhpPpP5fVEDVvdNVs8X3xs8P4TEv8eUiCCYXLy99/gAMEUw0SKRXTK3Su3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEk/KyCGYEIR0nJYohvLG9OMHTkixQzPWb3gCR+cLZs=;
 b=kjwTSg5VxcNBkuY36fN5P4WfPaRW0UsTILdt9Qv2zUMU2Cg+AU2fPtB8xy/xSssOUAh5gCCl+QVoSYr7DYQkFAKtpv2ID2pTfHABRkWG48bKRjN3Qee7jQ9IjPLQJgslbXm7ixgxTJIs13Z3bttol018ySbSYTnyfK4J0eQEWp8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS1PR04MB9264.eurprd04.prod.outlook.com (2603:10a6:20b:4c4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 01:24:41 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.049; Thu, 18 Apr 2024
 01:24:40 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 18 Apr 2024 09:32:29 +0800
Subject: [PATCH v11 2/4] dt-bindings: firmware: arm,scmi: support pinctrl
 protocol
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-pinctrl-scmi-v11-2-499dca9864a7@nxp.com>
References: <20240418-pinctrl-scmi-v11-0-499dca9864a7@nxp.com>
In-Reply-To: <20240418-pinctrl-scmi-v11-0-499dca9864a7@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713403963; l=2404;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=VDmWstcwBhpk6d9BmY1+Svq0j29w4hdHyHMqV4zPF24=;
 b=AEFUHmUtjgaFBXU1c1XH+FePDq7n6ISgIkzc1WwUltmtdeZNhCpeNJ/whfAiuuNxdZI+SGXWv
 R8PyapOu6d1CK4vd6UzCpcVKAXMNc0+lwLF+u95R3efsw/rvp7BlzAC
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR03CA0116.apcprd03.prod.outlook.com
 (2603:1096:4:91::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS1PR04MB9264:EE_
X-MS-Office365-Filtering-Correlation-Id: 174c9a6d-00df-4393-907d-08dc5f4651cc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xGKZ4KM9RevLsFhaXgEoA3OjexNonP7J7fVUasU5EouuimIra4ZpSxkvWKfnvgotHbIBcIMg3+RZs+x0C+IhV+KRqUlu6Q/StXFuyCxbqsxpD9IsK10AGr+wATxYFTQ0+AdrnLFsZX0Af7fKv50mOuz5rz2JnjDjGOw48KBbJaPykQ6NSAhcgqehPKm2S0Pxr0qDcrepNy2Vx6pmVA/bQ0sbrsEt0n3gI0EW0IDTjDfnNBwBdJAHL7G5imWs4i3XolTrowB8v0r0eTvJ5qR45DR0rftUyOti7vFJBO104TN2uZvoBEYFhSZe/ewf7wOlAdlRVrGpZrO3E6qe5Wva2huJTynCD/gXErATKBegmEAzyLtF1AsOvSuAva+hUPRsjEpaUiTmLRxlqoJBL/W388oZg2nyUFHacO9Lq9XGdPmPv7ShPFdePJz+EiNpX+yqDVlT/9lG737EL2DHUzUDzPjEKToixn8BdHk9+fRuErE6esvRqfVu/MOKw1fEV7AvH8O015ORmppnOYT/1v5k6lFVUdRyoFXGZeCt31ATyVVxZw1w/erBcxDywE+FbqpjFz0ITUy/FQJclvtvYRLAbtI1F8LHyiCTAXce+G3jUPmCiHKhR9SaPido7DDBwfUel982Od9HK6lvtxBG6HcRFUOTTnbLRpjOMgDlcq2b0msFkPfNIKJut5G0ritoSi56YzE/CWyCq1WwrzNQznxsBaFtcjoMleHauxvsWSzdct4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(366007)(1800799015)(376005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0ovSmNBRHlHWkEzVmRDa0V1K01rZnRvQkY2RUxRTFppTFVoQlJFMGRMRm1Q?=
 =?utf-8?B?VzE4TGNxODNKekxjTjc2a2N2SkhBSU9CUEt0c0lab2tjY2hHUEFMUHcyQjZy?=
 =?utf-8?B?dnpEOWF5YitoYjBUWFRVaWNUZ1ZDSVRkVnBqTjQvaE9yUno3dEhPeDJFdTdi?=
 =?utf-8?B?aGJidENyTGdVbWlSdjZMcTREOHRmVGxia3lYRmgvWUxzcC9UQmdVUFlXdUt4?=
 =?utf-8?B?YUM2eTI2UTY5NTV6eWlkMk05UHVDQlN4Z1dwOWNKT3kydXVUQzJtZSs0cngx?=
 =?utf-8?B?cXQvaHowU1J2b3EwVmRXdHBqWU5tL0lCNFhqWmxueTV3aGNQTmpCNldOMDV1?=
 =?utf-8?B?WWtJWDRJczRJOEVUeC9DQ0h3cXo2QUREVVErRGFYaDBwaHBhYW5DSTJEK1Ix?=
 =?utf-8?B?K2VSaFBoc0JUdFplbU4wYzYzaGxuQTVFZndBcHozQTRCSE16dks5R0hObk1K?=
 =?utf-8?B?SGtkd2hHbnNCUWJDek9remQwaEdmVm45V3YvMGppbzRSa3IxY1lab1hYOU45?=
 =?utf-8?B?dW1NdVFjRHp5V2I2aTZLMXRzUEJIYWtNdHFlMnFCcmlUMDNGRUkvdHhFV1dm?=
 =?utf-8?B?VFYyWDU3MTdZaEpsWktuUEZQVDRSdVM3dTg5Nks1MFZMKytGUXlDRVpEbWFG?=
 =?utf-8?B?UUQzaVJaQTdJODJ5TUlyUmM3SFpHZ0lOWmRwVWN4dDRwQ2FVL0ZoMDJOUFpZ?=
 =?utf-8?B?TE9MUUtmTUk0RnBGeGYybkdvViszUXpNZWZJckJBMEJWWC9SVkd5VlBlczVF?=
 =?utf-8?B?d1lSMjI0SWw4eUpZUVRld0RDREhIV2hkK0NQVi84SlA3RWVDRm5XTHpIcm04?=
 =?utf-8?B?RHVHdEZwWG1sZFR1amptQ0RlRHp1Z0RoQno3YWdWM1FMdGVLY1BTcnllanlZ?=
 =?utf-8?B?VTZ6NmwvM1J2bVhtcVFtYVJ2c1gxMkNXNTF4QVYrWUYwZWtGZzZFMmpkTURL?=
 =?utf-8?B?bXd3b1BUbmRHeWI0WlVNRjZTVVUxQ0JVbGxTQWpDUFdtMzAwaTZmVk1NQ0Qz?=
 =?utf-8?B?WlhKVzBQQWprTGRDTXp0NUZNWXRJaDZYTDRaeGJESW52MW5QMHpXOEhpaG1X?=
 =?utf-8?B?UFFPWEhmbk91WFltVXl2WXBwYnBMcTBJTTBONEw5U0lVZ0lpeGxBeTB4b3Jo?=
 =?utf-8?B?cS9IWTNBeW96VVQxMXVCNEkvSzIwMmJ1KzVleE8vVlFyU0VBbENvZnpSajNa?=
 =?utf-8?B?RVBtQXhIMlUxMzc4WGtweDBjSmZ5YzVieEp0cWlMOUtMVGF5VnBSVmY1STZ1?=
 =?utf-8?B?R09laGhEWDcyUGRpblhZV0Z2OGRaWjBZeUIwNnB4cVdlTVFZK0xYRVpjVGly?=
 =?utf-8?B?UVcvc1VOOEZKL21SWlZzczF0MFpsdUtoNjMza1dZRjVSeHVvY3pIVWp0NmNH?=
 =?utf-8?B?YjZZQUFrek5icHlYSGh2M3ZPMzVrTjZMbDh2aFZFQW9OWnRtOVN4YWI5S2pV?=
 =?utf-8?B?S2E5TGhROVdnem15TE5CcU91TzdDS2pYeWFkVks3YXh4eno5bTJleGRZQmxw?=
 =?utf-8?B?aDAwdE1MZUR5NVMrYjlvRmV4SGN1OGxBS243ek9WZzY1OTJ1emt4M3NrUDNh?=
 =?utf-8?B?S0E1OGh1SE9SMnRWeXRyVXpTdkM4U0VIdzJPRkZUcG1tNXRXV3JkSE5aSzQr?=
 =?utf-8?B?ZS84enB2dEN2aEdGWmw5RG91R1RUaEZJRkQ0cTUrTDhvQkM4L0ZyOWZuL2NW?=
 =?utf-8?B?clErT1M0ektTbU5ISTc4M3hGd2loak11Q1g0cC9JVEtsT09ESVl5d2o0akZG?=
 =?utf-8?B?T2M1TXRCdGNSeXJUZGFzSm80VUo5UVZuVWd5MmxFTWFoMno5WGpDSm5GaklT?=
 =?utf-8?B?Ulh6UXlZR0QxNWUyRXlkMjB0R1loakR4cm1GMmVFZHpuWXJoZXhSVXFiQkJr?=
 =?utf-8?B?NEkwMWxkRXVVZnNoWFhCTTd3UElERDhpbGRWNWxUZmMzRHpibldUSU1OVHRY?=
 =?utf-8?B?OE03UnJEbUpUaFVmamJneW03ZTVaS0d6MzhZVlNnMXBWK05XNkg2RjliVWZJ?=
 =?utf-8?B?d2NkODVGOVV2VnY3R0R0YTVmWDlzY3RORWN2YnlhYnU5d2MxYWRWa2lSdXFY?=
 =?utf-8?B?dXQyZm9MMG5KdzdSWkF3dFlvcy9lS0hJTFZ5UFF2NWtaZUd6MjA4OFZkS1ox?=
 =?utf-8?Q?lNg4No8aLPYBTzU+POrMgYFCV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 174c9a6d-00df-4393-907d-08dc5f4651cc
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 01:24:40.5292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9HyyocxzqcSUBMmwP6qyQ/YMXKWX4mUj2gGFua1wyfnJNcwOR45aMmhJrvFQZa+51CRMScXRCDgvWtmaeMugBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9264

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
index 93fb7d05f849..7de2c29606e5 100644
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



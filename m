Return-Path: <linux-kernel+bounces-132991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8331D899CFB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 387812888A9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788F816D4DC;
	Fri,  5 Apr 2024 12:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="V6054nZt"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2123.outbound.protection.outlook.com [40.107.14.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681191E88D;
	Fri,  5 Apr 2024 12:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712320311; cv=fail; b=ez+aYa2/2Jkx5idJM81aC6SZ4m1ELb3tGV/g6Gw4R4zx0kIIRsvt6qvi7DFzj7xo4UjOU3YgwrYwudra3Mmt0Eji0Fzp1LNQCxtpco68SKfiyrU27Fum4dEHfB5fvBkVxvj8U/F+kGw5kbm/vk8bKJHH/jRo0yOrWvWfl0DI6lI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712320311; c=relaxed/simple;
	bh=njXEMiMpEtIfaZaIhvK6loNWL5RDpfROj9sYckAJ0PI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=edYwax0AHnM4kvopwsKfuqtC6CgxMAQ6OnUgQ6cQTINHu4le1zH69wM9xO0vTg8mkc8s26Z2cTTcHbg+OdFNaM3yYkAbcaVUIOS3MsPJUSq2EOuZvQd8RCNE/ACciwFDJ0tnbhu/bCC614QoDZR6GV4os+Nkoti4Oitb4ZmxgM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=V6054nZt; arc=fail smtp.client-ip=40.107.14.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDhVeKazmZnDfd8EG9twr2fJVhyBYLMaZ3XQNVHC88gQkyoLiTZbp+K3TeV+JRzifI/USQS5xxq6quJtXsxXf54ZYT+Nkn+jxB2hXBVNM5x6/sYz7e8ukrocTXTpqYZpSbPGJyAjD5Fh8X4MS3fDMDF3kQnsONI0g2gTkxEIqrmSVBYKzwTHVW2ITA3dk8t+xiQaP966w4bLVrTJVV2N2P6kVx/g2Bb5xIBrvAusUaJnxfg6LqgAEbkg4z6WPgWMHq7eEpv4JivWmftGff79hfz1RlU2IwlL97vutBQOPs2Tc55xJAzxDUORZFQySoxe1xnHgryW3U5zRZzFkzmh0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLhlRCiWVsLIeV7NVQXArw+BAOVRkiuO/QlS5Qa4hLw=;
 b=UgiEJ3Qz+FTCE17Ok3YiVqj82y4KcjdrSSl2+7M5bQAtxTEegnqy4PjK8Is5XY+rZSjFEcINm/VSOkuJHaSo+uOfwGwfwe+NMbk3ozjlLBC4VOi7AZU/bxfrHSoA9rvBq1O5TLvRSgunitl88q1yJXvj/lDqh+hWlngGWSmChOBNLmQV9h7t4uvoVGNi2sBtnkCd52Ulq2xhXbpOnVy8QXjdIjhtjWudwxqCgf8ehYjKNZyvks+ZtkqYb1YIH3P3dm0YIqjDIklPbFatU5h8cUHTOhj8XzwNYzH7TUjD1HY0t7UbQHyQqiVC8N+jKsimv5cr5lmdjG6OBHdr8P6M4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLhlRCiWVsLIeV7NVQXArw+BAOVRkiuO/QlS5Qa4hLw=;
 b=V6054nZt3ikgmb2xzQj0spH9G/gSR1uHoERObHSjUX565/nywiAMu75yvREONZJOa3UEeBijPH1wPhYC5J7JltmPbMqz4V5SnTlo0XdF/2EYuMOJ/DfWoK4KQuxGVENBEW6ajCH+u8tMdXhpeuuEYMIy09vU9+Lyqqcr6BiYkrk=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7744.eurprd04.prod.outlook.com (2603:10a6:102:c9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 12:31:46 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Fri, 5 Apr 2024
 12:31:46 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 05 Apr 2024 20:39:24 +0800
Subject: [PATCH v2 2/6] dt-bindings: firmware: add i.MX SCMI Extension
 protocol
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-imx95-bbm-misc-v2-v2-2-9fc9186856c2@nxp.com>
References: <20240405-imx95-bbm-misc-v2-v2-0-9fc9186856c2@nxp.com>
In-Reply-To: <20240405-imx95-bbm-misc-v2-v2-0-9fc9186856c2@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>
Cc: Peng Fan <peng.fan@nxp.com>, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712320792; l=2717;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=V2qEDgdGzTv/oSyf8SB67tGPyUyth0sA80L0w5qSmfA=;
 b=5QfGF7Twg0+Q1c/qsnnMpvQrEoNCxtcZcvFmHcbJTNudBBTyOC9jGDN4pLdmyvI7qil6RvinC
 W1eWz15oOzOB7ZoBQR4zIRQl6ZDc8JgIRIPGAuABUI1Oceo15ESS+IT
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB7744:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hVFlMhT1tmvR1DyaObPqn2D+EETYMbrT1B4s5shWl8Ute7f5JE58xDoLf2KgOJwPPGRD9vu3y4zrN1yMNswq0si31flg1NaRG1gsiVhpIH6gqusAJ412ZwThTh0eZ/pgJYiddlDtCXBQ0/xY4OX0gGFF/1QnI/UfB1TlwvaUi4Y1V3H4K8m8p9u/ltfOTyJ1E/ROvYrwPB3925cIy+5I4ub2fKwEjP6J0QaKSX1d75ZpxzYV6K41uCJ5F/9TAbQfj6JcIJcx0Wx1Mq+32Kromvs/qC1nBfVZKvegPLUTgphVh8DrayGqZY+1og/EvkqZaBmzySM+XX9wWPMTu4/ga8REkOMkQyPdlw1d2vL8AvRPPOkJS7FgfvADU4ysSI/m61bJ1DFBbw8G8g1hHJdbQ3xHXJArHjeEwUW8gstMtBa6e1Ga+mkDlHfRuyOPiihia2ilF9Wp2VL/52NFGjNdrK1e4hoDp22FHwBEo55C/cEeXAG2zMuQCuhxmJa9cKgNkfAAW+8aFd5kU66yecvdvonE39rRxA58P2sE9W/iS3yy8mgMvzF1X8CWX1ehzJJxvbHz39W3OSe//wLvR/tILzyf9sHr9BujyeSYiWFZmY93KdkOm4mXhfHZ9BGCYl5N5GNpnavtiewsvLbgTFhT7Fyc3wnpjJyIxhed9jaLk3o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(52116005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVZsOS9SaVdlWTdRQkViTzBYeHlWWlk3dnVDa1h1MlQ0TWl5YW4ranZTQmZu?=
 =?utf-8?B?WGZ3VktwZURwbFBqWHJ6TTZZdjZhZ3VIZEE4TVF6cjVWZk41T3ZWbFRxdDVi?=
 =?utf-8?B?R0lGdlBKWFZ6VWdxSWE0M3NidDRKUklzd0g2S2U1dFhhMlR5eElGbGNYTEhr?=
 =?utf-8?B?MVpWVzNURitPa1krUHJPQXE2ODB5a0dPeVpQNTlZSHRIV1RjRjR3bCtINTly?=
 =?utf-8?B?MTQya1M0dHZQRGV4aGRYai90VEx2VFJYSDdzdjNFSlZmdmE2NUFXZUsxZy9D?=
 =?utf-8?B?VWw3TklWcHFUTXBkTzZKWDlBMnA2RjUwUkEyQVBsSUJuTUxxMmw5T1RNR3g3?=
 =?utf-8?B?ajE5UGkvL0lYeEViaGEzYkRSVjhyelVEOTYzZ3VBVTgxc0gvUm5FRGhBZS9a?=
 =?utf-8?B?eUx4dk5WMHRTaVJkU1Z3ZUxUSW8zQVpMNllXSzFqaGpIQTR5cmZvQzdyVmNh?=
 =?utf-8?B?YjdiYjBRMjkxaGgxbUY4SCt6TjdpRDVmdE5OcENNMGFjQjhkZ3pTMDJ6Zzlr?=
 =?utf-8?B?SVpKeG5TMlYxbW04ekNPamhpNzhta3ZucDRhUTdMQXM0VzRPellLSDFZOGVR?=
 =?utf-8?B?QkVwd0o2VFZUbUl3MVczNHRmTlZjQjU3NHJ3Mm8xQk8wNEhoeTU3ZGdqNjlz?=
 =?utf-8?B?bys2REx2YnNOR2NQY1UzZmNXOGtRUWNVMHBIalBFZWRDWjJieHJsL1BkK2RB?=
 =?utf-8?B?M2Z1d3NUNk5SaFpreEltR0FHQ3VkblUvdUFPcjBEbnh6YURRcWF6SGhFTk1j?=
 =?utf-8?B?N01vN2YyN3l2NUo2ZTIwUjgxenFhVlZIaUNpQXUzRmRnSlE0ZXR4S20walpG?=
 =?utf-8?B?NnVnZmFicGQ5MVdpdXlubnJ6TnhtbkZnVG1weFF4dWFKSVduZWVVa0NNSm13?=
 =?utf-8?B?QUR4OUFvbFljNWFQdWMyTDE5YVppc0NvdjJhaFE1U1FIbVlMMENaT0lWQmhi?=
 =?utf-8?B?eTVaRGhDbmtIMU5xQmZKSXlVU2NKSlFyM2phRHlCcGp1YS9jQXQwK2VoeFI0?=
 =?utf-8?B?Wm5CR0lqcG1zMzVJMmRQa3crZFppd0VRWFJ6Z0xuMkZEekFqV0Yyd0kwdW8w?=
 =?utf-8?B?RWZiN2Izb0ZRM3NuT1pxS3NabFhkby9DNG8xQ3M1ZGgxWjEwWWtCRmJUcTBq?=
 =?utf-8?B?UzhZL2NpNCtSWWdhcGVtZHovY3MyT3ZKanF1Wno0TjltSHBiZ2Z2ZGorTzhT?=
 =?utf-8?B?ZnBJckhBWjl4MTQweEZScHNLdUN6eGZJcnA2OXI5eER4OFhvZFZPTkpXMGdo?=
 =?utf-8?B?am5RTHBiY2RFS0VRYVA3THNHVjkyNEpjQWI5dFJBbmRYMVZRbUlrazZucTF5?=
 =?utf-8?B?c28rWXB4ckJENnUrWTVWakpJS2NiVXkyb2xBOXJyTUxSWGZOWFJLSE9xblZD?=
 =?utf-8?B?dGRadk9kYWNpd2t3bmJpOERmdkhFelBGelRuSHdqRDJKSStacVJPZFB5Z1Fz?=
 =?utf-8?B?ajkvT3duVHNIU2FTRHBGZ200VkhqQTRHNW9IOU10YkFhSDlkeDcvZ3NvcWEr?=
 =?utf-8?B?RXhhM1BIN1ZvNThiUjMrUkJiaTlCNGFnbUplYzRvNWZFK3RBZDRMV1paVDV3?=
 =?utf-8?B?Z2VvcC85R0JqK2t5MGcwY2x2TWJ0aG9FWmJiVGZRRWdYVHNjVjl3VU1hZ2lE?=
 =?utf-8?B?U1NZTUJmcGduZWthSkN4K1FiMVdMSVBMY0NNcEtIK2dPSnduNW1NeXlrL0g2?=
 =?utf-8?B?OHFaTXFlcWJHOVpjaUdPVnVwMEFHZncydHNxZ0J4a3ZqNC9FcG5rZG5iaWF3?=
 =?utf-8?B?OHdJZlRBN3F5b1V6cDdlMDRacjdONlpialZYUmluMGwvcnJWUFVGUVRvaG53?=
 =?utf-8?B?QllwUTFGVlNEbkVuYnI3MFN0R1Nlc3F3WlcvWmx1Q281L0pkVW9UQ2JKWUMx?=
 =?utf-8?B?dEhiZVlmcUpCR1hyQmV0Z3c3MGcyS3lXdEVMYjN3M2VsemFyYjlQUEFHSlh5?=
 =?utf-8?B?MDdYUVV2Z2Q5STFXWTI3MHJMOW1lcVhsNDh2UFEwMll0dzZudGlNOHFGVVk4?=
 =?utf-8?B?K3BPMHVjUlJRY1A2NlkzNHp5QWdVZWpEMG4xWjkwOUFYNlE5ZlNraWs5TFov?=
 =?utf-8?B?QlRKUXVPUllOSG5IRGg2bFJWd1RoOEpkcFRPNkhUVWExYlh4N3M3YmpiMkdM?=
 =?utf-8?Q?J133Mor2bAsX4B/0bZVgrgcE2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efc710a7-cf80-4204-206b-08dc556c5b96
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 12:31:46.2833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +VwKrp1SZfiJx2a22SI3Rj9uxZna7RA9jswX62V/GV0BVg9NqKdV+4hJ1ugJm6pw7tdcISxijel2IgS+zuvhtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7744

From: Peng Fan <peng.fan@nxp.com>

Add i.MX SCMI Extension protocols bindings for:
 - Battery Backed Secure Module(BBSM)
 - MISC settings such as General Purpose Registers settings.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/firmware/imx,scmi.yaml     | 80 ++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/imx,scmi.yaml b/Documentation/devicetree/bindings/firmware/imx,scmi.yaml
new file mode 100644
index 000000000000..7ee19a661d83
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/imx,scmi.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2024 NXP
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/imx,scmi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX System Control and Management Interface(SCMI) Vendor Protocols Extension
+
+maintainers:
+  - Peng Fan <peng.fan@nxp.com>
+
+allOf:
+  - $ref: arm,scmi.yaml#
+
+properties:
+  protocol@81:
+    $ref: 'arm,scmi.yaml#/$defs/protocol-node'
+    unevaluatedProperties: false
+    description:
+      The BBM Protocol is for managing Battery Backed Secure Module (BBSM) RTC
+      and the ON/OFF Key
+
+    properties:
+      reg:
+        const: 0x81
+
+    required:
+      - reg
+
+  protocol@84:
+    $ref: 'arm,scmi.yaml#/$defs/protocol-node'
+    unevaluatedProperties: false
+    description:
+      The MISC Protocol is for managing SoC Misc settings, such as GPR settings
+
+    properties:
+      reg:
+        const: 0x84
+
+      wakeup-sources:
+        description:
+          Each entry consists of 2 integers, represents the source and electric signal edge
+        items:
+          items:
+            - description: the wakeup source
+            - description: the wakeup electric signal edge
+        $ref: /schemas/types.yaml#/definitions/uint32-matrix
+
+    required:
+      - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    firmware {
+        scmi {
+            compatible = "arm,scmi";
+            mboxes = <&mu2 5 0>, <&mu2 3 0>, <&mu2 3 1>;
+            shmem = <&scmi_buf0>, <&scmi_buf1>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            protocol@81 {
+                reg = <0x81>;
+            };
+
+            protocol@84 {
+                reg = <0x84>;
+                wakeup-sources = <0x8000 1
+                                  0x8001 1
+                                  0x8002 1
+                                  0x8003 1
+                                  0x8004 1>;
+            };
+         };
+    };
+...

-- 
2.37.1



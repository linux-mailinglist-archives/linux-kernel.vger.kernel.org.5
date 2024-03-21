Return-Path: <linux-kernel+bounces-110705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AE58862B2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A71AA1F22ADD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEF313699E;
	Thu, 21 Mar 2024 21:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="pgAQ+YGM"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2098.outbound.protection.outlook.com [40.107.7.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1461813667B;
	Thu, 21 Mar 2024 21:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711057652; cv=fail; b=Po8UhcWx6WJj5ifoxsNBARim5BWdzuqOwpG4k4DwRGwD/rqVqOdXn11ZBCNG3l68pAvALtKv3tQGlCBrgvnAoeQH84Ht7++/NePFZMNp8tMhnDVnRf4HOYI8AdLARmJ3fdNnimVL1FRirdvwDCpT3uiTaNELgPqIFNM1+WSsO1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711057652; c=relaxed/simple;
	bh=hWpfKB8BdY6lO3jBTSyIFGsL4zxx5DcREd7GPIWToZ0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=qWpOCMiH1H6gfSk7kMUXVxZECJGCzIK2+XGCR8ojm55tkz8KULXdnxJ4486T88Jfi1Da2kdnPrZJZGzYxaeXAsWDh+orSJF6atilCzl8am69pUJuduCLCfYFwOeF0f0EtmUdOAYGMmpoTktV71Zoth2Hw3RONKXU1izTbEGeicw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=pgAQ+YGM; arc=fail smtp.client-ip=40.107.7.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btGSBXPMwE2q5NVRGSOquqVRIOYbkXzugBoGQL+x8bNnCmicwYGvL9Qgt27eFfg11Na/IApi0UhadWofDrkZSO4E0e6usrKf2CtszEgxXGssG7vcb5j5I8eZX/Ou28xViM/TTPTKNJpHx5JrWI971ag1Pmqz/9P7PgW8y3fn2ld0yu/+W8Jr5m+kvyXfThvjYD+hvJ6e9Q76xlxHlfzZtGy7MVUBmIvaXpOGbLkYEjvwNDAyJNO6D3LSrHhoHIQ1t5ptnAd+Dm9r+rwo/JEVvn/y1JFMfM03rN8iEsaQqWQ/EXMw1iHEPiTjcfZnUgC8viEDyD5tvBq3yn9m6e5K3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSdLGMFR7pmXn6xASLyA7Kg+orWjEJa8Pv9LRsqTa94=;
 b=VG44emYuspiyseDdkkf8uXH7faL4vvEviM5UKbIP5jmaC8hkRhglF9V1cOAd8EQchYIxpCxHqGLjJc+ki2k/9KD/nEKCZuRV1v5IGDcP7iVEmylqWZrdw1Nj+2lM0cd46JzoTHSHX/ZUwQ9o//djokZlM9nzXiAz3jqkYiDL+8UMMtvY72Hf8DU6uUF4HrRlp8SUjgXOcS85yDdxh4l5X7sldz0+m0bDOwa8XcTkxNmZk+QDGSEfiBztC5aHESAUIBsszhQp0OZ8Kb7rLHzKpvnPcYxrnmLdIDm9uVFDzVZW/1LIOVRIkPnseEc0O42TNLpZT6UE5+dX62vwr0sUMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSdLGMFR7pmXn6xASLyA7Kg+orWjEJa8Pv9LRsqTa94=;
 b=pgAQ+YGM4ii/n1Rpb0e/XZqBcFLbHbN4oXZyokzFrixP9jmBSkuNd4fX914xuy8+Rwxk6G1IbeJyTgqK9PpUW3YBtqdJQLyz+6HGJkQCJHjlj4WZxYvLvHsjbqTmvN5oFJEbQnm5SWef7qdBadbEYZvJnXVvaL5hD0xKSl55EOU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by PA4PR04MB9413.eurprd04.prod.outlook.com (2603:10a6:102:2a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Thu, 21 Mar
 2024 21:47:21 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d%5]) with mapi id 15.20.7386.031; Thu, 21 Mar 2024
 21:47:21 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 21 Mar 2024 22:47:12 +0100
Subject: [PATCH 2/2] arm64: dts: add description for solidrun cn9130 som
 and clearfog boards
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240321-cn9130-som-v1-2-711127a409ae@solid-run.com>
References: <20240321-cn9130-som-v1-0-711127a409ae@solid-run.com>
In-Reply-To: <20240321-cn9130-som-v1-0-711127a409ae@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR4P281CA0142.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::6) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|PA4PR04MB9413:EE_
X-MS-Office365-Filtering-Correlation-Id: 2afe29f5-27a3-4fbc-764b-08dc49f07cf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	y8GDrTLe3lpKWfbvC/qA7mhVQcqG06d6ZGxI48xRlaY3Wgb3gnjCXDoYlDpAYQ2q/EAIYg6ceDiP9yjLxil+F0b6nUsD0Bww1P+xySyAPYOeYCowQO31wcXY8N7UmWdSDz3y+O3jSsl4YYxc0kWQlQH++d6266HS3pCBRxvO1K2wxp/TPsFBYaxxOIxYN9k2E+1PZ0Wq3flKiguPgRysdysJ/EEUaXB1isHZnAfvW5xMHVrSa05Gsb+Pt8jwiGDqF/O2IjcQ5hMDMpv0nweCyOmXzNBoCkjXlTygBLOyiJ8lOV6mAbjYMlimgkBBwnmA1bWjq2oSNWOM1SQFUv4xgj8J6ktp8i6yS8Dzv8YffWnAiFYIVSW/eVtoFMdT+1NVTz5RY2nZV5l5mj9Z/3Sgn9j7p0mZeoctFb2etkBrS8mPt7PhmBDE1RrgkatrFIsti1HC3qXk/luBBBuURlPVDXOtBsn6rb11RZ/aGCQkOm7hbaRo1iNcTPJqhJO3Z8h87jkxo0MBz6pNaQjVxqib4sDl3OXlPY4S9ZyFDwhmzNDlebMVg6tSXY8czoLIzlhVj15O0sHT4+Z1BKl5d6vUvQdwkR0qO3xv6ksj3m8BiPO2kJrfrWHCkUPPOreF1Gxqvk4EekncpsD7GFL1/awse+awgvNPQ4WNyFDkERohNM7i6x22cilknivmJXHGRul+p4fnyNNOMH3yURJek7MoCg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkdpbDlYaEpSTmtVeEtUU0NMaGt0b09TbnBwSU5UNjd4d3kzeU1aTmFxRUtN?=
 =?utf-8?B?bEdONlI2OUZlVmdwVmo2UGJ4M3BOUFZmeTlHRWpkTVplT3grOVlPM0ZxbTZB?=
 =?utf-8?B?bmpxd2VmWjM2TnRnSDlWQU9FNWtaUmRRS0pCRURKR0g3TVFISTNBQ0NMTk9z?=
 =?utf-8?B?bC9hcE1ndGZvRmdsanpjcHpzOERHR0NVNmxQc3FvWEFEQkw4T1A2a0NYcWY4?=
 =?utf-8?B?TkhWc1ZjSFV6dDJsTWUzUU9BenpreXQySnJURGVWNFd6VXkyUlVSWUxQbTJM?=
 =?utf-8?B?K2d1VXFWT3JHK0N0b0dwL2FBNjJPSkh1cVQwUmhBRm02MnVtLzdiajlMV0ov?=
 =?utf-8?B?RUZGYkN4RmhEMnFPOTJpaUE5VGhYZHFLOC9nMDR3aTBjRzJvTkN6MnNRbGth?=
 =?utf-8?B?Vk5PU1crZzF4cUthbVlRZDRUWnd4U3hZdGJZbStiVi9NalFhTlBHUG9TbVo0?=
 =?utf-8?B?U2JscllxOG9Jb09Ra2hMdXkwUnlZa25UVVlUZnlqWGJmLzhweVBZbFRPUFN4?=
 =?utf-8?B?U0hoV0xKUkZLejlJTXZYY01GS0FyV1pLS2hJRTk2Nm9MaHFhd2p2SU04M0pH?=
 =?utf-8?B?MjlNbHFDbFppcFlMVExWdnQ3VVB6NkF1ZWNTaTRVTkNab2NIWG8vcml2K2F3?=
 =?utf-8?B?ZktqWUljQzRuOFlEdThlR09VUFNrQmFoUmp0VnRtNDhkSUF5M3pNN3dsNm5o?=
 =?utf-8?B?Tng5bHdpT3FDV29pSVhUb2hINmk4bng2MzVYUSs1cVcwNWJBMWVQM0tkZXJT?=
 =?utf-8?B?NTc1MjZiRFhvZWZnVmtvbEdyc1JOUkJPZGZ5bGkyUmMwaExtd2xaWVNTOUdB?=
 =?utf-8?B?VUcwblF4NWcxY3NWeUdHZUlBSEZXcTJLSWNnenE5WjhqVlJNOWtNQ0ZtOVJv?=
 =?utf-8?B?RkRWeWpuN2FybCtBMmR2QXA0eWZoeGFEL003dnRHenBpQitQTjc4UnZTTG95?=
 =?utf-8?B?M21KTDN1cHhUY2xocUZFajlYWlZPdU1VN2Y4VmQxVVFUNVpUN3ptZ3B5c2t1?=
 =?utf-8?B?bFRwbnlmMDgrWnFodGwwRTJEcEJ6aENpVkpqendJbTFrbllqNDNOVmhTbmg4?=
 =?utf-8?B?NUE5MkVVQ3RRSmJNRkY2SmJnbUJJSHRjaFQ0SHp5MUNvQkRqQVVkekpPSFBy?=
 =?utf-8?B?WTdJaWFmR3BESytneE9LQU95Z3FXWG83cmpaOUNFd3dyemg1RVN4VjFXUHZD?=
 =?utf-8?B?aXpJWWlvUHhqOFVhN25abmdGL3E2MDU4ZzdLMmV0SVR3N00vaTBPV09UTXhv?=
 =?utf-8?B?ZWRtai9TakJTbjlwbmVjU3F1dlp1akFkQ3VZVU5qZlF6U1NFdmE1UWxCdjhF?=
 =?utf-8?B?TkJkcmt4NUdISDlRaEh0TVpxYnJpVVcyKzFncGl1VXFSSjl0STQvb05pRnlC?=
 =?utf-8?B?Z0tPbmttL1dlbG5uRzlhbWpuVS91UmUrdGJMUTNNZlh3aHFqQ1c5amQ4U3du?=
 =?utf-8?B?cjRBdWh4ZHIrR29WaDJkZW9mSTZFdzZFUkVDSXMvdnlmNlVOVUR0NTM2NG1u?=
 =?utf-8?B?dE00bXRkWFpJaHlBdE9WVjV5ZytzQ3NJSkhQdjlGWW9iM1dSVnNQajE5cloy?=
 =?utf-8?B?VHJ1ZDBQYXNTOS9ldzJnVU9uaitzcmF5YnpVeFRKSDBHWG1OZzFPZnZoTlpX?=
 =?utf-8?B?RjhXemcrNE51RFVudHMwaktmNTRvb2lHUXJTL0h0NzFCcEJEajQ1VnhKekVl?=
 =?utf-8?B?MDY3QWdTVmE3clhneERwU25HSUI5MnZub1ZLRUZMTU02NmFGU3lyVWk0YzUy?=
 =?utf-8?B?TEZQeG5LWW1lenFlL1ZaaVZyZmFiOHhMSGVSMEpYQThjejlEaE03YnJ6MUZh?=
 =?utf-8?B?V2Z0U2hzZGxKRFVkbmJLdmgxOUk3eFR2MElqMkhaWnRCL25Cc3lpaW9XZ0l2?=
 =?utf-8?B?eFZwZG5EeW1Rc2MyOVNvVmpXV1NyVGtXUjVoY0Nxd293azRvWHErdFdNL1Zw?=
 =?utf-8?B?NXF4dE5TVnZ0NUxmSm1NME5oTzhoM3ZvQ25vTWFVZnc1TGRoNEhUR1VKek44?=
 =?utf-8?B?SUxZVzcxV0c5aW13U0dnV0ZOTFdWNDhlYVRaYjRUZlVGaDZwNWNQUlVGeDlD?=
 =?utf-8?B?NWZNUFJFMis4Z2lyL2lVNUNVckF5Z1VlV1FweDR1VTZuMk93Q09sWkhmQVBO?=
 =?utf-8?Q?WpaA9fVPEyt21O+MqmKX6meYn?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2afe29f5-27a3-4fbc-764b-08dc49f07cf9
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 21:47:21.8440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QtZIX29Bf7sk5r320vkprTuQZKR6lN7BkRbH24k2SruS6fK3pfI/vLV0VBMvdxo2n/6IJnxxn1QFfWVYVDHbdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9413

Add description for the SolidRun CN9130 SoM, and Clearfog Base / Pro
reference boards.

The SoM has been designed as a pin-compatible replacement for the older
Armada 388 based SoM. Therefore it supports the same boards and a
similar feature set.

Most notable upgrades:
- 4x Cortex-A72
- 10Gbps SFP
- Both eMMC and SD supported at the same time

The developer first supporting this product at SolidRun decided to use
different filenames for the DTBs: Armada 388 uses the full
"clearfog" string while cn9130 uses the abbreviation "cf".
This name is already hard-coded in pre-installed vendor u-boot and can
not be changed easily.

NOTICE IN CASE ANYBODY WANTS TO SELF-UPGRADE:
CN9130 SoM has a different footprint from Armada 388 SoM.
Components on the carrier board below the SoM may collide causing
damage, such as on Clearfog Base.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm64/boot/dts/marvell/Makefile           |   2 +
 arch/arm64/boot/dts/marvell/cn9130-cf-base.dts | 138 ++++++++++++++
 arch/arm64/boot/dts/marvell/cn9130-cf-pro.dts  | 249 +++++++++++++++++++++++++
 arch/arm64/boot/dts/marvell/cn9130-cf.dtsi     | 198 ++++++++++++++++++++
 arch/arm64/boot/dts/marvell/cn9130-sr-som.dtsi | 160 ++++++++++++++++
 5 files changed, 747 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
index 99b8cb3c49e1..019f2251d696 100644
--- a/arch/arm64/boot/dts/marvell/Makefile
+++ b/arch/arm64/boot/dts/marvell/Makefile
@@ -28,3 +28,5 @@ dtb-$(CONFIG_ARCH_MVEBU) += cn9130-crb-A.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += cn9130-crb-B.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += ac5x-rd-carrier-cn9131.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += ac5-98dx35xx-rd.dtb
+dtb-$(CONFIG_ARCH_MVEBU) += cn9130-cf-base.dtb
+dtb-$(CONFIG_ARCH_MVEBU) += cn9130-cf-pro.dtb
diff --git a/arch/arm64/boot/dts/marvell/cn9130-cf-base.dts b/arch/arm64/boot/dts/marvell/cn9130-cf-base.dts
new file mode 100644
index 000000000000..b0067940d5e4
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/cn9130-cf-base.dts
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Josua Mayer <josua@solid-run.com>
+ *
+ * DTS for SolidRun CN9130 Clearfog Base.
+ *
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+
+#include "cn9130.dtsi"
+#include "cn9130-sr-som.dtsi"
+#include "cn9130-cf.dtsi"
+
+/ {
+	model = "SolidRun CN9130 Clearfog Base";
+	compatible = "solidrun,clearfog-base-a1", "solidrun,clearfog-a1",
+		     "solidrun,cn9130-sr-som","marvell,cn9130",
+		     "marvell,armada-ap807-quad", "marvell,armada-ap807";
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-0 = <&rear_button_pins>;
+		pinctrl-names = "default";
+
+		button-0 {
+			/* The rear SW3 button */
+			label = "Rear Button";
+			gpios = <&cp0_gpio1 31 GPIO_ACTIVE_LOW>;
+			linux,can-disable;
+			linux,code = <BTN_0>;
+		};
+	};
+
+	rfkill-m2-gnss {
+		compatible = "rfkill-gpio";
+		label = "m.2 GNSS";
+		radio-type = "gps";
+		/* rfkill-gpio inverts internally */
+		shutdown-gpios = <&expander0 9 GPIO_ACTIVE_HIGH>;
+	};
+
+	/* M.2 is B-keyed, so w-disable is for WWAN */
+	rfkill-m2-wwan {
+		compatible = "rfkill-gpio";
+		label = "m.2 WWAN";
+		radio-type = "wwan";
+		/* rfkill-gpio inverts internally */
+		shutdown-gpios = <&expander0 8 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+/* SRDS #3 - SGMII 1GE */
+&cp0_eth1 {
+	phy = <&phy1>;
+	phys = <&cp0_comphy3 1>;
+	phy-mode = "sgmii";
+	status = "okay";
+};
+
+&cp0_eth2_phy {
+	/*
+	 * Configure LEDs:
+	 * - LED[0]: link/activity: On/blink (green)
+	 * - LED[1]: link is 100/1000Mbps: On (yellow)
+	 * - LED[2]: high impedance (floating)
+	 */
+	marvell,reg-init = <3 16 0xf000 0x0a61>;
+};
+
+&cp0_gpio1 {
+	sim-select-hog {
+		gpio-hog;
+		gpios = <27 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "sim-select";
+	};
+};
+
+&cp0_mdio {
+	phy1: ethernet-phy@1 {
+		reg = <1>;
+		/*
+		 * Configure LEDs:
+		 * - LED[0]: link/activity: On/blink (green)
+		 * - LED[1]: link is 100/1000Mbps: On (yellow)
+		 * - LED[2]: high impedance (floating)
+		 *
+		 * Polarity: On = low, Off = high (not hi-z)
+		 */
+		marvell,reg-init = <3 16 0xf000 0x0a61>,
+				   <3 17 0x003f 0x000a>;
+	};
+};
+
+&cp0_pinctrl {
+	pinctrl-0 = <&sim_select_pins>;
+	pintrl-names = "default";
+
+	rear_button_pins: cp0-rear-button-pins {
+		marvell,pins = "mpp31";
+		marvell,function = "gpio";
+	};
+
+	sim_select_pins: cp0-sim-select-pins {
+		marvell,pins = "mpp27";
+		marvell,function = "gpio";
+	};
+};
+
+/*
+ * SRDS #4 - USB 3.0 host on M.2 connector
+ * USB-2.0 Host on Type-A connector
+ */
+&cp0_usb3_1 {
+	phys = <&cp0_comphy4 1>, <&cp0_utmi1>;
+	phy-names = "comphy", "utmi";
+	dr_mode = "host";
+	status = "okay";
+};
+
+&expander0 {
+	m2-full-card-power-off-hog {
+		gpio-hog;
+		gpios = <2 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "m2-full-card-power-off";
+	};
+
+	m2-reset-hog {
+		gpio-hog;
+		gpios = <10 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "m2-reset";
+	};
+};
diff --git a/arch/arm64/boot/dts/marvell/cn9130-cf-pro.dts b/arch/arm64/boot/dts/marvell/cn9130-cf-pro.dts
new file mode 100644
index 000000000000..f7733f6a89b8
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/cn9130-cf-pro.dts
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Josua Mayer <josua@solid-run.com>
+ *
+ * DTS for SolidRun CN9130 Clearfog Pro.
+ *
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+
+#include "cn9130.dtsi"
+#include "cn9130-sr-som.dtsi"
+#include "cn9130-cf.dtsi"
+
+/ {
+	model = "SolidRun CN9130 Clearfog Pro";
+	compatible = "solidrun,clearfog-pro-a1", "solidrun,clearfog-a1",
+		     "solidrun,cn9130-sr-som","marvell,cn9130",
+		     "marvell,armada-ap807-quad", "marvell,armada-ap807";
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-0 = <&rear_button_pins>;
+		pinctrl-names = "default";
+
+		button-0 {
+			/* The rear SW3 button */
+			label = "Rear Button";
+			gpios = <&cp0_gpio2 0 GPIO_ACTIVE_LOW>;
+			linux,can-disable;
+			linux,code = <BTN_0>;
+		};
+	};
+
+	/* mini-pcie w-disable could be either wlan or wwan */
+	rfkill-mpcie1-xxan {
+		compatible = "rfkill-gpio";
+		label = "mPCI-e WLAN (CON2)";
+		radio-type = "wlan";
+		/* rfkill-gpio inverts internally */
+		shutdown-gpios = <&expander0 7 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+/* SRDS #3 - SGMII 1GE to L2 switch */
+&cp0_eth1 {
+	phys = <&cp0_comphy3 1>;
+	phy-mode = "sgmii";
+	status = "okay";
+
+	fixed-link {
+		speed = <1000>;
+		full-duplex;
+	};
+};
+
+&cp0_eth2_phy {
+	/*
+	 * Configure LEDs similar to switch ports:
+	 * - LED[0]: link/activity: On/blink (green)
+	 * - LED[1]: link is 100/1000Mbps: On (red)
+	 * - LED[2]: high impedance (floating)
+	 *
+	 * Switch port defaults:
+	 * - LED0: link/activity: On/blink (green)
+	 * - LED1: link is 1000Mbps: On (red)
+	 *
+	 * Identical configuration is impossible.
+	 */
+	marvell,reg-init = <3 16 0xf000 0x0a61>;
+};
+
+&cp0_mdio {
+	ethernet-switch@4 {
+		compatible = "marvell,mv88e6085";
+		reg = <4>;
+		pinctrl-0 = <&dsa_clk_pins &dsa_pins>;
+		pinctrl-names = "default";
+		reset-gpios = <&cp0_gpio1 27 GPIO_ACTIVE_LOW>;
+		interrupt-parent = <&cp0_gpio1>;
+		interrupts = <29 IRQ_TYPE_EDGE_FALLING>;
+
+		ethernet-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			ethernet-port@0 {
+				reg = <0>;
+				label = "lan5";
+				phy = <&switch0phy0>;
+			};
+
+			ethernet-port@1 {
+				reg = <1>;
+				label = "lan4";
+				phy = <&switch0phy1>;
+			};
+
+			ethernet-port@2 {
+				reg = <2>;
+				label = "lan3";
+				phy = <&switch0phy2>;
+			};
+
+			ethernet-port@3 {
+				reg = <3>;
+				label = "lan2";
+				phy = <&switch0phy3>;
+			};
+
+			ethernet-port@4 {
+				reg = <4>;
+				label = "lan1";
+				phy = <&switch0phy4>;
+			};
+
+			ethernet-port@5 {
+				reg = <5>;
+				ethernet = <&cp0_eth1>;
+				phy-mode = "sgmii";
+
+				fixed-link {
+					speed = <1000>;
+					full-duplex;
+				};
+			};
+
+			ethernet-port@6 {
+				reg = <6>;
+				label = "lan6";
+				phy-mode = "rgmii";
+
+				/*
+				 * Because of mdio address conflict the
+				 * external phy is not readable.
+				 * Force a fixed link instead.
+				 */
+				fixed-link {
+					speed = <1000>;
+					full-duplex;
+				};
+			};
+		};
+
+		mdio {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			switch0phy0: ethernet-phy@0 {
+				reg = <0x0>;
+			};
+
+			switch0phy1: ethernet-phy@1 {
+				reg = <0x1>;
+				/*
+				 * Indirectly configure LEDs for port
+				 * lan6 using external phy.
+				 * Internal PHYs are not using page 3,
+				 * therefore writing to it is safe.
+				 */
+				marvell,reg-init = <3 16 0xf000 0x0a61>;
+			};
+
+			switch0phy2: ethernet-phy@2 {
+				reg = <0x2>;
+			};
+
+			switch0phy3: ethernet-phy@3 {
+				reg = <0x3>;
+			};
+
+			switch0phy4: ethernet-phy@4 {
+				reg = <0x4>;
+			};
+		};
+
+		/*
+		 * There is an external phy on the switch mdio bus.
+		 * Because its mdio address collides with internal phys,
+		 * it is not readable.
+		 *
+		 * mdio-external {
+		 *	compatible = "marvell,mv88e6xxx-mdio-external";
+		 *	#address-cells = <1>;
+		 *	#size-cells = <0>;
+		 *
+		 *	ethernet-phy@1 {
+		 *		reg = <0x1>;
+		 *	};
+		 * };
+		 */
+	};
+};
+
+/* SRDS #4 - miniPCIe (CON2) */
+&cp0_pcie1 {
+	num-lanes = <1>;
+	phys = <&cp0_comphy4 1>;
+	/* dw-pcie inverts internally */
+	reset-gpios = <&expander0 2 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&cp0_pinctrl {
+	dsa_clk_pins: cp0-dsa-clk-pins {
+		marvell,pins = "mpp40";
+		marvell,function = "synce1";
+	};
+
+	dsa_pins: cp0-dsa-pins {
+		marvell,pins = "mpp27", "mpp29";
+		marvell,function = "gpio";
+	};
+
+	rear_button_pins: cp0-rear-button-pins {
+		marvell,pins = "mpp32";
+		marvell,function = "gpio";
+	};
+};
+
+/*
+ * USB-2.0 Host on Type-A connector
+ */
+&cp0_usb3_1 {
+	phys = <&cp0_utmi1>;
+	phy-names = "utmi";
+	dr_mode = "host";
+	status = "okay";
+};
+
+&expander0 {
+	/* CON2 */
+	pcie1-0-clkreq-hog {
+		gpio-hog;
+		gpios = <4 GPIO_ACTIVE_LOW>;
+		input;
+		line-name = "pcie1.0-clkreq";
+	};
+
+	/* CON2 */
+	pcie1-0-w-disable-hog {
+		gpio-hog;
+		gpios = <7 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "pcie1.0-w-disable";
+	};
+};
diff --git a/arch/arm64/boot/dts/marvell/cn9130-cf.dtsi b/arch/arm64/boot/dts/marvell/cn9130-cf.dtsi
new file mode 100644
index 000000000000..1aaa0d916e75
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/cn9130-cf.dtsi
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Josua Mayer <josua@solid-run.com>
+ *
+ * DTS for common base of SolidRun CN9130 Clearfog Base and Pro.
+ *
+ */
+
+/ {
+	model = "SolidRun CN9130 Clearfog";
+	compatible = "solidrun,clearfog-a1",
+		     "solidrun,cn9130-sr-som","marvell,cn9130",
+		     "marvell,armada-ap807-quad", "marvell,armada-ap807";
+
+	aliases {
+		i2c1 = &cp0_i2c1;
+		mmc1 = &cp0_sdhci0;
+	};
+
+	reg_usb3_vbus0: regulator-usb3-vbus0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vbus0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&expander0 6 GPIO_ACTIVE_LOW>;
+	};
+
+	sfp: sfp {
+		compatible = "sff,sfp";
+		i2c-bus = <&cp0_i2c1>;
+		los-gpios = <&expander0 12 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpios = <&expander0 15 GPIO_ACTIVE_LOW>;
+		tx-disable-gpios = <&expander0 14 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpios = <&expander0 13 GPIO_ACTIVE_HIGH>;
+		maximum-power-milliwatt = <2000>;
+	};
+};
+
+/* SRDS #2 - SFP+ 10GE */
+&cp0_eth0 {
+	managed = "in-band-status";
+	phys = <&cp0_comphy2 0>;
+	phy-mode = "10gbase-r";
+	sfp = <&sfp>;
+	status = "okay";
+};
+
+&cp0_i2c0 {
+	expander0: gpio-expander@20 {
+		compatible = "nxp,pca9555";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		pinctrl-0 = <&expander0_pins>;
+		pinctrl-names = "default";
+		interrupt-parent = <&cp0_gpio1>;
+		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
+
+		/* CON3 */
+		pcie2-0-clkreq-hog {
+			gpio-hog;
+			gpios = <0 GPIO_ACTIVE_LOW>;
+			input;
+			line-name = "pcie2.0-clkreq";
+		};
+
+		/* CON3 */
+		pcie2-0-w-disable-hog {
+			gpio-hog;
+			gpios = <3 GPIO_ACTIVE_LOW>;
+			output-low;
+			line-name = "pcie2.0-w-disable";
+		};
+
+		usb3-ilimit-hog {
+			gpio-hog;
+			gpios = <5 GPIO_ACTIVE_LOW>;
+			input;
+			line-name = "usb3-current-limit";
+		};
+
+		m2-devslp-hog {
+			gpio-hog;
+			gpios = <11 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "m.2 devslp";
+		};
+	};
+
+	/* The MCP3021 supports standard and fast modes */
+	adc@4c {
+		compatible = "microchip,mcp3021";
+		reg = <0x4c>;
+	};
+
+	carrier_eeprom: eeprom@52 {
+		compatible = "atmel,24c02";
+		reg = <0x52>;
+		pagesize = <8>;
+	};
+};
+
+&cp0_i2c1 {
+	/*
+	 * Routed to SFP, M.2, mikrobus, and miniPCIe
+	 * SFP limits this to 100kHz, and requires an AT24C01A/02/04 with
+	 *  address pins tied low, which takes addresses 0x50 and 0x51.
+	 * Mikrobus doesn't specify beyond an I2C bus being present.
+	 * PCIe uses ARP to assign addresses, or 0x63-0x64.
+	 */
+	clock-frequency = <100000>;
+	pinctrl-0 = <&cp0_i2c1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+/* SRDS #5 - miniPCIe (CON3) */
+&cp0_pcie2 {
+	num-lanes = <1>;
+	phys = <&cp0_comphy5 2>;
+	/* dw-pcie inverts internally */
+	reset-gpios = <&expander0 1 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&cp0_pinctrl {
+	cp0_i2c1_pins: cp0-i2c1-pins {
+		marvell,pins = "mpp35", "mpp36";
+		marvell,function = "i2c1";
+	};
+
+	cp0_mmc0_pins: cp0-mmc0-pins {
+		marvell,pins = "mpp43", "mpp56", "mpp57", "mpp58",
+			       "mpp59", "mpp60", "mpp61";
+		marvell,function = "sdio";
+	};
+
+	mikro_spi_pins: cp0-spi1-cs1-pins {
+		marvell,pins = "mpp12";
+		marvell,function = "spi1";
+	};
+
+	mikro_uart_pins: cp0-uart-pins {
+		marvell,pins = "mpp2", "mpp3";
+		marvell,function = "uart1";
+	};
+
+	expander0_pins: cp0-expander0-pins {
+		marvell,pins = "mpp4";
+		marvell,function = "gpio";
+	};
+};
+
+/* SRDS #0 - SATA on M.2 connector */
+&cp0_sata0 {
+	phys = <&cp0_comphy0 1>;
+	status = "okay";
+
+	/* only port 1 is available */
+	/delete-node/ sata-port@0;
+};
+
+/* microSD */
+&cp0_sdhci0 {
+	pinctrl-0 = <&cp0_mmc0_pins>;
+	pinctrl-names = "default";
+	bus-width = <4>;
+	no-1-8-v;
+	status = "okay";
+};
+
+&cp0_spi1 {
+	/* CS1 for mikrobus */
+	pinctrl-0 = <&cp0_spi1_pins &mikro_spi_pins>;
+};
+
+/*
+ * SRDS #1 - 3.0 Host on Type-A connector
+ * USB-2.0 Host on mPCI-e connector (CON3)
+ */
+&cp0_usb3_0 {
+	phys = <&cp0_comphy1 0>, <&cp0_utmi0>;
+	phy-names = "comphy", "utmi";
+	vbus-supply = <&reg_usb3_vbus0>;
+	dr_mode = "host";
+	status = "okay";
+};
+
+&cp0_utmi {
+	status = "okay";
+};
+
+/* mikrobus uart */
+&cp0_uart0 {
+	pinctrl-0 = <&mikro_uart_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/marvell/cn9130-sr-som.dtsi b/arch/arm64/boot/dts/marvell/cn9130-sr-som.dtsi
new file mode 100644
index 000000000000..f151a2a399c1
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/cn9130-sr-som.dtsi
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2024 Josua Mayer <josua@solid-run.com>
+ *
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "SolidRun CN9130 SoM";
+	compatible = "solidrun,cn9130-sr-som", "marvell,cn9130",
+		     "marvell,armada-ap807-quad", "marvell,armada-ap807";
+
+	aliases {
+		/* label nics like armada-388 som */
+		ethernet0 = &cp0_eth2;
+		ethernet1 = &cp0_eth1;
+		ethernet2 = &cp0_eth0;
+		i2c0 = &cp0_i2c0;
+		mmc0 = &ap_sdhci0;
+		rtc0 = &cp0_rtc;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	v_1_8: regulator-1-8 {
+		compatible = "regulator-fixed";
+		regulator-name = "1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	/* requires assembly of R9307 */
+	vhv: regulator-vhv-1-8 {
+		compatible = "regulator-fixed";
+		regulator-name = "vhv-1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		pinctrl-0 = <&cp0_reg_vhv_pins>;
+		pinctrl-names = "default";
+		gpio = <&cp0_gpio2 9 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
+
+&ap_pinctrl {
+	ap_mmc0_pins: ap-mmc0-pins {
+		marvell,pins = "mpp0", "mpp1", "mpp2", "mpp3", "mpp4", "mpp5",
+					   "mpp6", "mpp7", "mpp8", "mpp9", "mpp10", "mpp12";
+		marvell,function = "sdio";
+		/*
+		 * mpp12 is emmc reset, function should be sdio (hw_rst),
+		 * but pinctrl-mvebu does not support this.
+		 *
+		 * From pinctrl-mvebu.h:
+		 * "The name will be used to switch to this setting in DT description, e.g.
+		 * marvell,function = "uart2". subname is only for debugging purposes."
+		 */
+	};
+};
+
+&ap_sdhci0 {
+	bus-width = <8>;
+	pinctrl-0 = <&ap_mmc0_pins>;
+	pinctrl-names = "default";
+	vqmmc-supply = <&v_1_8>;
+	status = "okay";
+};
+
+&cp0_ethernet {
+	status = "okay";
+};
+
+/* for assembly with phy */
+&cp0_eth2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_eth2_pins>;
+	phy-mode = "rgmii-id";
+	phy = <&cp0_eth2_phy>;
+	status = "okay";
+};
+
+&cp0_i2c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_i2c0_pins>;
+	clock-frequency = <100000>;
+	status = "okay";
+
+	som_eeprom: eeprom@53 {
+		compatible = "atmel,24c02";
+		reg = <0x53>;
+		pagesize = <8>;
+	};
+};
+
+&cp0_mdio {
+	status = "okay";
+	pinctrl-0 = <&cp0_mdio_pins>;
+
+	/* assembly option */
+	cp0_eth2_phy: ethernet-phy@0 {
+		reg = <0>;
+	};
+};
+
+&cp0_spi1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_spi1_pins>;
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <10000000>;
+	};
+};
+
+&cp0_syscon0 {
+	cp0_pinctrl: pinctrl {
+		compatible = "marvell,cp115-standalone-pinctrl";
+
+		cp0_eth2_pins: cp0-ge2-rgmii-pins {
+			marvell,pins = "mpp44", "mpp45", "mpp46", "mpp47",
+				       "mpp48", "mpp49", "mpp50", "mpp51",
+				       "mpp52", "mpp53", "mpp54", "mpp55";
+			/* docs call it "ge2", but cp110-pinctrl "ge1" */
+			marvell,function = "ge1";
+		};
+
+		cp0_i2c0_pins: cp0-i2c0-pins {
+			marvell,pins = "mpp37", "mpp38";
+			marvell,function = "i2c0";
+		};
+
+		cp0_mdio_pins: cp0-mdio-pins {
+			marvell,pins = "mpp40", "mpp41";
+			marvell,function = "ge";
+		};
+
+		cp0_spi1_pins: cp0-spi1-pins {
+			marvell,pins = "mpp13", "mpp14", "mpp15", "mpp16";
+			marvell,function = "spi1";
+		};
+
+		cp0_reg_vhv_pins: cp0-reg-vhv-pins {
+			marvell,pins = "mpp41";
+			marvell,function = "gpio";
+		};
+	};
+};
+
+/* AP default console */
+&uart0 {
+	pinctrl-0 = <&uart0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};

-- 
2.35.3



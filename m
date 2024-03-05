Return-Path: <linux-kernel+bounces-92637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8161E872342
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4F491C23289
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0221D128394;
	Tue,  5 Mar 2024 15:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="f0CiHFDY"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2054.outbound.protection.outlook.com [40.107.8.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2780F127B7A;
	Tue,  5 Mar 2024 15:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709654113; cv=fail; b=BvcSOT8l86v7IvBI3pPZDt2fEr4+pmCNDq37a3Sfb0j3qfjrJoXqHmMOhRhO1zXM9BAdR+0qCquM5Ek/wQkzlC5NzmLwgGdbdECbBEn1IqWNMxyK8+y6vJg/yt+u7+enQAgQxnReyyhXZpYEkQsNVqA4HDUjul0fgEM0Cw4tYwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709654113; c=relaxed/simple;
	bh=VSWLLl6viIpXkqqZJs1xVoCq8PzjD0eRDsyCZKRcg54=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=W4dC2VPz+O+CI8hIeNJ+Ri57gckaAFRFaGe+ftMdiuufhoo3JJDEjHdhgJT8ZUDVL27g5bNBPA7IMMGum1yMSIRG0EujboGMg0Uxfbntjs8eA1GHF3yConDPGnE33QxVNnu4fFBS2ThqtBR9yB3qio5Zg1wU7uKO7xa+2+Go5rM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=f0CiHFDY; arc=fail smtp.client-ip=40.107.8.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZtrCtdkLbAsbWkVf26KfqPRP8+7mYzziI5oHEsz//QPMNQDLNAiPQhCeVRO/kKBc0CvuQsOGWGwAKhbU0cMSUlpPNuYV1Z1cRcq1UdrwoNUETu5b6FCRR6d3g9LGIBB+3JF106LYvqdoJdP+dkwcUaAJhg8Aq88Dakf9az84DjmYLAx7mq5u2Q0aV4Bzao3gSEFrmrhSDF4eaV2EyY06xHfWMZ95CzWKHTsnFoFEt0cZbxJeeuLr2qvXCE74A2qCuq0NelM3zQMzgprZY2pL8uLJF2ITDmarUt5vzxZaDx6SWOkUGqK9qtJ8q2GWgpJIQfJUo/6k9bG/FBltL5d8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Nhhqhzf+JEtcWi6fIntUwDEUqPGSHeB/8wcTJtIfPM=;
 b=S+Y9UJHqW7Zen+aERn4MlPfneDLHRCm8T3SVze9F37jjXjTLQZqaWUusTL8yZ0fY4ToYXnVAASqT8IeMBfK/+zNlWFwoYWIm+LGHNZIWVaZU2mV1uwYjEZe//AKv6pzNsUx3SzD6ed2Mllj5Wvs5lUfEP7Q0InClcajBo2e6MykCXBvEYRQv7iNak2OSQWPOSAsa+78LTlANl4gpNVYvVZ0oR88XI4urJ5XH70G1e7k9tf1N0VlxdeUaiEi9v1Xt14C5jbuEFZ9+JGmoBVXB4UMiUR4mG2PaPtgZScMoe3qeoHJ84FJxAirvBfYrLAbRBElU71ACk4zDQqOXCCIrnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Nhhqhzf+JEtcWi6fIntUwDEUqPGSHeB/8wcTJtIfPM=;
 b=f0CiHFDYCB4SfowwFIR1aNwvNzSIW9vsK3bXTrr7eYGMTmAQ2Si+Fl7wLn3rVE9/wTBWzItOOalxjEyuOWzxCIqbrjc+4xy/KnWhk3YIJnzvgVITQ4kOP7wJM1O3vhPeMkEjs/AHqASQ1swXKyuHHFPSzXinq6jSccCrfe3+foI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7780.eurprd04.prod.outlook.com (2603:10a6:20b:24c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 15:55:08 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 15:55:08 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v3 0/4] arm64: dts: imx8: add cm40 and cm40_uart
Date: Tue, 05 Mar 2024 10:54:54 -0500
Message-Id: <20240305-m4_lpuart-v3-0-592463ef1d22@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE5A52UC/22Myw6CMBBFf4XM2pp2Wh5l5X8YYwoO0kQeabHBE
 P7dwgYXLs/NPWcBT86ShzJZwFGw3g59BHlKoG5N/yRmH5EBOSqOWLBO3V/j27iJSZ5rUXOJDRq
 I/9FRY+e9db1Fbq2fBvfZ00Fs679KEIwzTZlWeUUipfzSz+O5HjrYGgEPT3L89TB6hTapTpErW
 WWHt67rF/aPJ4TYAAAA
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709654104; l=1394;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=VSWLLl6viIpXkqqZJs1xVoCq8PzjD0eRDsyCZKRcg54=;
 b=VKtjnY2fGBk0eK27nj7RMI7a6UUwj0eaF5ZgdloiV554/UPpsAhVCV9FgVwAIv+7wKIbI7LV1
 qtwxPN5wzSeCYjyPYxqb1ANzCSE9EbA6qcKVsV0IPXAwVKok33K+Ubt
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR08CA0020.namprd08.prod.outlook.com
 (2603:10b6:a03:100::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7780:EE_
X-MS-Office365-Filtering-Correlation-Id: b64eecd0-313e-4a5e-215b-08dc3d2ca18c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bl93vXON8cG4skQ36h11qfORV/ovifBvlAk6/JtqbSHBMlOElwvAhw2KNHt8O6xEcPSIQjqzm23Be8b6vOYJ0CvM1FWgQVkbX0o0J7X1WWMRdfva8Qr9jBtKXoZD38YSMXABUuOv1FabKUhvhk0akgas7rLbJEMee/DRtrGamiFxOH82jHBrdHKKX95ExVTX3/jiNkKPjwE8J78RGEZM09TpmDv8zm9qe6p5CSDaZrXilZyqWqkC1NHZyzRb+GiFvN9de+QI/IQzgIqgoqn2x1Xtb1omkIoxWjLF/Zdn3uIUz737/06/DQrWC8sEK1u8lp5jdned1T/pO20OnlQkg1j1ph539vzlya96XQnmiSQyKRVXU6XqYwM6HOIp/SuDuaqYaHByiNdB12ep8quD2Ja88pRjIs872nhn1SgaCAdO2Mcg6ciYScpR/hMk+NLBHGDZjDx50JFYp8dR3tDIwym7FOtZ1+ZWxndb5ZNIj/SbSjAohBwv4nTdG85jitR92G5NeDtF6oRI6uXlHfWtg0oLmjKPlNoUHfwaunxWHd9VYjIyED6oLJthSoQ7wbKvlvcdmuDhJE1Qb2m42ecpxhiit4kIzEVkd2lv1IsJ9XoR3onAROg3wvTV8E92wc7ICDGf/xFEMYndlsSHVu7yAcXDHKNhZBxF+/BNhcPwyyk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXhiUXlEMnIyb05TOTZaSjZSbmpWUzVLZ2UwWWZiU3BEK1loOTJXSXR3YjNW?=
 =?utf-8?B?Nlk3V3FkelVrajBDRmx2R29Wd3MvM1N5cXovc0NVMEtyc3FuYkh5Zk1UdDUz?=
 =?utf-8?B?aTFmdm44L0NQd1B2R1hzZDk1ZVU1dmYvRUlnbUNZT2xkSUpDNnIwQUtBcENT?=
 =?utf-8?B?UTErN0VZU2JDUGJMcTBnNFVGK0J5eHRWQjZwL2Z4UGp2UFN2ZFEvcVBCY3J3?=
 =?utf-8?B?eEh5UDc2eDVxWE1uQXFDb0dDT09RWld1Z25hT2RWS2dnbXJMTnNkM0kva3ZT?=
 =?utf-8?B?b0dmVTczdG5NS01OTDQzbmJoZEtkdisxOGhXM1dDWU00MkZxckN3SksvMmg3?=
 =?utf-8?B?aXJyeFU2WjFWeEJnWlFJZnNpY25TN0Y4Z1VMeG42UzIyOVhpazNRdkdXeWg0?=
 =?utf-8?B?d045ZGdBdHl1RnhzOG1XVkN6RlhKeEhBbnd0ZStGMDJhRWNUSHJjL0wwYWxK?=
 =?utf-8?B?TG1uSXlick1RaUhnUXE1enlsdkdxdDlvWlhJdy85N2hrSWROZzhqZ1RSaDl4?=
 =?utf-8?B?d2pUdTJCMm00Sy9tU3AzZWd5emgzVlMwMFp0U2lPVnhyOS9JWE1JTllCb2hy?=
 =?utf-8?B?Ris2Mi8xdHZ4SG1hTS9xTUlZTnBRcmhXL0ptZ2E1NXVmSjFJcVNpTVBXdURB?=
 =?utf-8?B?ZUZmK3VxTzFIakEzUVllMkVRMEpjb256NG13MTNVNVlLZXlCR0F3eHA0UnZm?=
 =?utf-8?B?ejM3NENKS2xiRU1EbjIrSmZaWFp1aWM4UTEvSEZRaEs1cE9lZnpqbmtLRTJr?=
 =?utf-8?B?M1ZMV0RXMWN6cmd4RXlPcjdrSi9taDRsWWVrQ1lWZktiRS9EZE9SSzcrV0NY?=
 =?utf-8?B?WTNLRlNyQmxsaDEveWRZWjRBLzdNZVRUbm1aVElXQ1hmU0t2aFRJY0NoUkNJ?=
 =?utf-8?B?N0VRYUtuOU94SmZTQVpBNytmUGp6d2tiZVo2UG9WbkQyQ3I1TGk4VmFmSm03?=
 =?utf-8?B?ckNmRGdnSjZya3RsamlMTlc3M2pZeUtRbU1vRXVSRSt0a2p4N1RzSHJqa0U4?=
 =?utf-8?B?TmFMbnVyTlRQeWdpTm1FbnphT3dueXhDL29lUnNsQ24wNU9uWjBBYVlkbEkr?=
 =?utf-8?B?WFovejhVVm5oOWJ5L0RsSndReC9keXUybkNrYlNIcEQxcGQ0WlpwSGZydElU?=
 =?utf-8?B?OXR1OXl6NGQwdG5WUC9RRm9jQWZmazFaM2ZOUnBwdHBaa3FtZUFOblVuMnBa?=
 =?utf-8?B?cHhmMjl4TGd2Q3g2aU9GUCsyWTBwRUtqUGhQRXV5ZmlEZDNWcGZjaWtORnh3?=
 =?utf-8?B?eGUzZXJ0NE5La0lKTytpY2lkUTh3RzVNRlU1RU5LYi8vVmlIMytVRm00b1ZR?=
 =?utf-8?B?UmRpcENTTjgwQitna1dVYlNTcnFMNGo3OEZLNzRsWlA1dUdod0QrSE5mU25a?=
 =?utf-8?B?a1hKeCtTWVVkeExRS1ZFTDdOYXhZeDhpNys5WTZKZ3QrTFpNRFl3V3BSS1dX?=
 =?utf-8?B?dHRaVTFKeGZIUnA1a0E1UG14K2lXOHAxRVNESjd2aDhvcFFRMjkzM0t0SlpZ?=
 =?utf-8?B?amNtaFFQWkx6QjlOY0tsQ3NCSnhIVXNoeHpXR0lBcUVZWEMvbVJrcXdYMTVQ?=
 =?utf-8?B?QXNTOWNBckJMU1d6WS80VXhzZmR0Z2V5dE1adEtGMHg5b2lQZ0dYU2dlR3RJ?=
 =?utf-8?B?b251eHZUSTIzWFBNY3VQeHBLeXNKdHRDeVpURWF4eWVxOUhIejA3bDFuaG15?=
 =?utf-8?B?ZXF0eFMrOHlqRE14dGU1MDJRL0pTNVUvQUNMS3hmdEZGRzBwVis1N282eUVk?=
 =?utf-8?B?eGhEdy8rZ1NCMFZWa0tHM2hvWnExRXFaTkdUVnlmN09iMk9Ja09NTjZmbFNk?=
 =?utf-8?B?N2tZSE42OXJkODRmUkVlcjNNNmRYbjVNNFNtUHlaejk3ZW11TkUwWGhCTGdT?=
 =?utf-8?B?bk03SkhzY3FQRVNYWFF3cXQ3L2RwSnNZWnpCNEdjWi92V0pYV0dGaUFmWmJt?=
 =?utf-8?B?ZG1rMnREZFRneWFnV2RsM1NyckU3cVhjdU1pVlI1N3FtVWRYb3lPMUV0aDh1?=
 =?utf-8?B?OXI5YldmQ3k0RUpwaXhGSkpHN0duY0czOHpSMTRObDRsQXRoeUxKMjg4Yk1w?=
 =?utf-8?B?QjY4eERpaGl5eGF6YTNhOW1jRWJFRFQ4Z3lOOS9jQjNxdGpFK0Q3MG1TNDJZ?=
 =?utf-8?Q?jEurQwV7Lom0dWCU/jUOcoYmz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b64eecd0-313e-4a5e-215b-08dc3d2ca18c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 15:55:07.8854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8gj+saG8fWThUM3j3sHa2RFjoHHLvDs0GnC93LvvjHMtAlKvG4Kfu/t8eDBScb+yheQrRFWDNVeiQTJjTYGAoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7780

Add cm40 subsystem.
Add cm40_lpuart and lpurt1 for 8dxl evk boards.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v3:
- Add Alexander review tags
- move interrupt-parent below range.
- move interrupt-parent before interrutps at intmux node
- Link to v2: https://lore.kernel.org/r/20240302-m4_lpuart-v2-0-89a5952043b6@nxp.com

Changes in v2:
- commit message "Adding" to Add
- fixed regulator@101 warning
- remove 'modem reset'
- order nodes by access
- move interrupt-parent under top bus
- clean up other dtb check warning
- Link to v1: https://lore.kernel.org/r/20240228-m4_lpuart-v1-0-9e6947be15e7@nxp.com

---
Alice Guo (1):
      arm64: dts: imx8dxl: add lpuart device in cm40 subsystem

Dong Aisheng (1):
      arm64: dts: imx8: add cm40 subsystem dtsi

Frank Li (2):
      arm64: dts: imx8dxl: update cm40 irq number informaiton
      dts: arm64: imx8dxl-evk: add lpuart1 and cm40 uart

 arch/arm64/boot/dts/freescale/imx8-ss-cm40.dtsi | 91 +++++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts   | 37 ++++++++++
 arch/arm64/boot/dts/freescale/imx8dxl.dtsi      | 13 ++++
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi      |  1 +
 4 files changed, 142 insertions(+)
---
base-commit: 9acc053fc8f256959e849cb6588a054074daebcd
change-id: 20240228-m4_lpuart-30791c032f2a

Best regards,
-- 
Frank Li <Frank.Li@nxp.com>



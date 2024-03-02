Return-Path: <linux-kernel+bounces-89503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A202286F149
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 17:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADE9F1C20AE6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 16:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B993B1BDE5;
	Sat,  2 Mar 2024 16:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UDDNQyCR"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2042.outbound.protection.outlook.com [40.107.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72981B277;
	Sat,  2 Mar 2024 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709396893; cv=fail; b=GLD0H3HuoxkxjzlKTlJ2hrLCRwh8HPu271YeKN7GDuz0uXiqAwBlWKuLLXHF9GQzTe20LN/lhBaeuGULnz9ex+Ndq96NlrFPyGBqxOn3DqoBWLoxxilA0fhhDnLztCGkjDAIKEDwQ6kCQEFFUzddQ6dpUwl9XJz82WlKuUyLaKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709396893; c=relaxed/simple;
	bh=S5Vs2tPPh7cbxPnMmeW8tMVf7qckabUKAPNmDpT74T8=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=YyYFanmkQT0vBaJjH4a27Qa31J46zholtp96kj4vVD1ewJupQqrHS7U6xUJXYep/9+74PGcKH5+9E0XhsgZqVy6IGH+jTLs5DfJKNLUuf8gSwiLYt52IBvWdcmyWul9Afbf6Xpk1X3q7lQGG2go8RJcexv4WO4Lb2jJHEurdYiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=UDDNQyCR; arc=fail smtp.client-ip=40.107.6.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gjQZN/eN69otKZw+QXurB++rzxAFwKaGUvVUdcgTdhmiCbGWUoyWU4EOYpNWuLxcusPH9nTTtu5M9eiCV9r3CN+7bUqNspUW+pRPkuc0Gi0u9LgWsACij1gWSM3StYhZoPfwrsVOQ+lhEJfrCrfYI6nNJqkru0ddTvmMB4/jWYeRIQyXJLnHVO2RGKTiB2nNdWX3zXnjxh58axFTmsEEWPLvlDcwtVcmhnavEIshe/pkpg/XqpDCO4x42COjNTNSgrWkJY1uHEzFQkgX1YK7u5A16Pc1cV5bDPe9xQPWgdmNjlNoP4RRz2v7flNppfFrYzOWb4nX4f5rPqDAyPd2cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+hPQraROyEX19Zsh0tIBb6cy4EFlc2bIasxJHm7u84=;
 b=NCXGlV5cfK64tBhR2ThYbQm0nCizFXZIgM/zi19G4SlFsr8NqoR7O6VCspa3rcGxdF12l8DstkXqyIY7fe5lCmF4WjlxckvL6FxjAqEYDbTS/bmqlsxUOD5CMkXjz9PXB/kFIDHq2U2T1snvtT5+IzBXgx2t7KIPXsFCmnA/9EMdygEs789YKsE0IzU+/fMLgYtKgVPoQLWxiuJCKLQkF0f277biqGnHx8+W+AqdV8RWy7rfEKcctyXD6n+spSTaKRX1ttm26KCD/WZ1WByP1NfPaYevEMF9S55pQhZb7E0FT4UjE0dCt0u4nBzXWXGBNn2Ey7e+VmLOk5AIvy95bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+hPQraROyEX19Zsh0tIBb6cy4EFlc2bIasxJHm7u84=;
 b=UDDNQyCRFhOAt8DFEPZN7UVWhmYcsd7zCv2Wv3SQAzMspr32Tayq4AOTaM5gnbFByjjzwL9SDnUqMUB+gHEivkvpnBeWf1iFT75RNzuorPn3+FxpFJi2TUpUyEe5AjM1i2gFUxAHUmmZ2Ax2o2Awg4ddVtC96u6geErgGcYmPsE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8385.eurprd04.prod.outlook.com (2603:10a6:20b:3f3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.36; Sat, 2 Mar
 2024 16:28:09 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7339.033; Sat, 2 Mar 2024
 16:28:08 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 0/4] arm64: dts: imx8: add cm40 and cm40_uart
Date: Sat, 02 Mar 2024 11:27:43 -0500
Message-Id: <20240302-m4_lpuart-v2-0-89a5952043b6@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIBT42UC/23MQQ7CIBCF4as0sxYDUxRx5T1MYxCnlsRSApXUN
 Nxd7Nrl//LyrZAoOkpwblaIlF1yk6+BuwbsYPyTmHvUBuQoOeKJjfL2Cm8TZ9ZypYXlLfZooP5
 DpN4tm3Xtag8uzVP8bHQWv/WfkgXjTNNRS3UncSB18UvY22mErpTyBUrrG3SgAAAA
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709396885; l=1165;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=S5Vs2tPPh7cbxPnMmeW8tMVf7qckabUKAPNmDpT74T8=;
 b=kNdH4eqgLXwRcO5l3T0/S5/0jTxCj3y6/ovSkx37w1wPM9WSXmwS6fwTHsH8n3ozjNEDeNt9+
 dBpqj4c6/ujAhcLenD27mS9xtP6zvSOlUr/7b8kxK/IT9EzXGhY9jNt
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR21CA0016.namprd21.prod.outlook.com
 (2603:10b6:a03:114::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8385:EE_
X-MS-Office365-Filtering-Correlation-Id: e9735ba6-5fb5-43b3-9de0-08dc3ad5bf14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iB1XINWAg3TBsirGaR6L8/0zFZI1SxLyZlHmK0MIM4mwEoIwJ/oxwhUyOb5T1yqjNlz29cHe8CsK9ED4dg7Efe6OuUbBN1SlR0SnUghU5IuRNCYjcT8R6PLhUgWXfl0Y1+1JZwL3N3EhqYEzXCUlDvGH8ETwVs6422Lp+z8pIDYXNaFVbfFUy7AAiQgfTdGWZ9M9YHzE9LQvaCO2lXjrRpq8WpY9ayV7TydARl/fic6S3Wu67+f3ZmcqoHo+zYpwAz4dokSb1ZqqKf13LGlJ9SRelRxQcNab7TR7VqNLGnyheKWnafe9oIo044UJOH7nUYAgRAenNBqY1mV1Yy6KbmJJfosgmLoLhJ8Nsz7hAswCW4jSdAKPWV/fJA66INIPm/CY3QE1VHU/B/mVizBL3q7mjxFJ8rJK3gqT3XhoF0DuULaSkE7grOE1eWUimz4zxx/qLNbFZGVEUb9WyLKL5RsdiLcIXXKbI6Pl8bL9FNfcEZeKlDORBJfh2kJElphuV7yKqDbidRboWFlR8qFj1hmSWuDqiy9pYV/eAVbvLG1VtHEm/MmNhX1zcAuCQCdsOc74byPThOmox0c77XO56/cDepGQhPXY/gzJGuBTUbpdbeYA9bXyEVVHqmpxg8lgpAOA0IHQKmLjWsw3ReAd/Qo3T06Fqv2bb3l6mjVf8zg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzZrL3JsTkNzNWFxYjByVS9DWmpFSUQ0b1FESTRYMXBuMjIyRGk3YStnVC8z?=
 =?utf-8?B?RWE4SElKMnBScmpLNUF6WXg0em1tQ3d5R3F5SUlMWS9qMFVFZDltUTlTUURT?=
 =?utf-8?B?OTQ5U2ZwTmUya3BITEJOODNuTnZ3NTd4UCtEK3NDK045SXdPTTR1M3FmQm1C?=
 =?utf-8?B?L1VKZGFGSUdjQ0lFakw5ZUF5MDg4U0RMeEdBcHdRNjdGa1F0L3RVb3hTU1Vt?=
 =?utf-8?B?KzRtbjVxbGFDU3NCemJBTDBwakE0eVJvanpUMkl4TERxWTVvbEJYUG85TjMx?=
 =?utf-8?B?eTNwOFR1aWVyeTBmRFRvOWpzbjFuanlya0NpYkMyZXNEZVVmV3I3Rm9LNmcw?=
 =?utf-8?B?N1pBb2YrL3dTbUdFVkgxTzRFKytNdXJtekVzNG1tS2ZUWDZJdU92MDVIWXAz?=
 =?utf-8?B?OEhLY0lhU1hUK0VuUmlzUmJCa1hxMnFVcHczSVJQZTFScndVcDZ1K3UxRWxT?=
 =?utf-8?B?TXRpVHo4Ui9XeUtzUHk5MGZ2VmQ2N0RWbFVaVTAyb2oxWlkraGZFa1VXU2k3?=
 =?utf-8?B?WXdFUkJScWtoV2lDT1JSU0w4T2s2aFdMUS8rdE1kN2ZiUFRyZmc0UlA4UHFo?=
 =?utf-8?B?TE5jcEZJSXVneVc1VE1manc5VjVlaDIxWkFCNTF4cktDV0hnV0dXVDg3R3hU?=
 =?utf-8?B?M0djS2wxdGdFUElTYjJ3bmRzVXNNMkNIVWk2Z0Y3aThCRTRhUSswbHpYMEVt?=
 =?utf-8?B?TlZ2MXg4dHQvb2dXKytUSXhoMWFLcDIrTjE4REFtRlhOU3Q2KzB2QzVrSDJM?=
 =?utf-8?B?a2o0a2Vud0Z1ZlMrMENFOFRUaFZ6cmFaWDZaaTJaRjZyZ3FFWkZ6QXc0NGEx?=
 =?utf-8?B?TldCSUUrbFdvVlBDMVBmQlFxTHRRTTI5MXdSa2wxUGlrU2FLUjVZUDRkK3F5?=
 =?utf-8?B?R25PQmRjcE1JMzlSQ0EyUkIzZXllWldQTzY4NlB2WHhZUU94S3d0T25Ca0Zn?=
 =?utf-8?B?eURJQ1VFdkh2NU5LY0crMlNWK1JvRGljTk5Xdko0QnZMVEFmenFKR3RKWCtX?=
 =?utf-8?B?VnNxeStvbDI5RUFHMS9La0l2cTVMREVCWUVwYlc0VWJXZ29VTDZ2ZTBkaHZu?=
 =?utf-8?B?NjhwQXRGenQrR2l2c2JORmkrUStxaUU3TnE0d1NPeHA1UGdVeWozT2VEa2dH?=
 =?utf-8?B?b3R4VGNYL3BFaElmMDVrUks5eElxRTJVdmwrUlBNNjF4SWNtTlRjUmJOajBp?=
 =?utf-8?B?a3FTc2cxT1RIWEsrTGpHMytjTFp0NlNaZGcycThsVGQ1K0VVM3dreGVYZDNj?=
 =?utf-8?B?SWoxdUZoL2xpMko0OUlFRHViMVFmaXNhVjN5TVcvSGZDWS94dkM0NEY5NVR0?=
 =?utf-8?B?blFVeXBxakorWTBZWTFPeWx2OXpEZmkzNGJNbTJXN3NTK3YyVFBFOEpYU0Nx?=
 =?utf-8?B?YzdZOHFzUGV5dU9PejgyZ0o1SFlmaWRwSFlkYzZKa3lGR3lvM0F4NVIrK0dD?=
 =?utf-8?B?cmxiR1NLTk1uRlYzTm1kTEJ2YUIrZVlyRkQ5TTErRFQxWDBta1VwS2UyOGJC?=
 =?utf-8?B?cVM4SG1ydStVRUJOZnpjVngxRVBLZUJOK1NRUmMzK0RLN2loU0VkOTlGczVj?=
 =?utf-8?B?M2pJcHhkeFBhNk1IZzRETTZFS2RnU0JqS01tcktxL2NtbStVU1BKMFVtTVBR?=
 =?utf-8?B?eXNGaVBKdWowRlVhY3JXaHkwQ280akN4bVVoeGhVR014MVF4NE1scW1ISXQ1?=
 =?utf-8?B?Ui80UWRURXhxOGlCamRzNkdsY0tyWDVsZzhLRElLTjFFZkdyMnU3VTYxWURO?=
 =?utf-8?B?a3FwVHBmSHZMbTFxRUh1Tjg5VkpFaWZONUhja0xiUnErRVBzc2xiMG1KTGg0?=
 =?utf-8?B?NlYrUHhEVmxGZEVha1Z5QzducWFveDZmaTdrVGoyc3VqUlFYalU0NlZJYm1E?=
 =?utf-8?B?Y0d0cGRKUTBEemRtcjR0eE5MS085b1YvUWUzenNkTzhhZUZhNVNhbmd3N0Ju?=
 =?utf-8?B?QlRDNkYrNEFweXcvc0h0aXpYNEhJN0RyekdQT2lycDNRVzZFYXk4Mm9Fc0s0?=
 =?utf-8?B?czM0UEhnWFh6UUtJUEZXS2oxRFdWTnVJSFdPMGtIY3haTG1Obis4bWxLU3po?=
 =?utf-8?B?Q2NJSU9KUlZyRXdaT1RVOUR1bWtKTHE4aDNjRGZmQ3dUakZuMVIvWldLRm9T?=
 =?utf-8?Q?j9m0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9735ba6-5fb5-43b3-9de0-08dc3ad5bf14
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2024 16:28:08.8836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vGnFOFbzZKuiVcRcqqxSAWZpKcEFJqx0G8IQfM8MYREk9Q73P+HID6ezstMXJtf3Ylul0CwYhJVVyZudEovpaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8385

Add cm40 subsystem.
Add cm40_lpuart and lpurt1 for 8dxl evk boards.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
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



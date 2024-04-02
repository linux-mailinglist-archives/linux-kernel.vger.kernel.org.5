Return-Path: <linux-kernel+bounces-128186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DA389574F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1060284A5B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33335135A48;
	Tue,  2 Apr 2024 14:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TxklelEp"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2123.outbound.protection.outlook.com [40.107.8.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7378612BE86;
	Tue,  2 Apr 2024 14:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068909; cv=fail; b=TFFXIgOSDUeJWXyn5PL5Xx9vVtAtJtYyBoMGGBlq9zzPAbiFCKcw2E7IUNrz0+NO883Eh+hUaC6PjWY5tX1Z//5i15oFQIFW98+dIsS44FMCbzFEPI6Fu+2nclz07yZ5YZStN6lsMm8paJPefo+y/B1PqWdGeDaB+Ugj1ytbT/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068909; c=relaxed/simple;
	bh=drLE6tpkXLsDhmu5fKM5iZ0VFmxcl8YopO5r7UDXTnk=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=NAfo6rwiFPm+6IgRiOl+/mfqRfn4YgykXHwyTXQESyNN1uVnEjgMLKaElbx3c2TAWhCIMwBphCawcH7iNKiEYIdQ3lv6lOQVxxpmMFdakbPEWNusMaoC/kqctOAchispqIfdYXEQlH0J50lmre1u28tu6Y7bpmrCDzlqCHvG7O4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=TxklelEp; arc=fail smtp.client-ip=40.107.8.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BECXLMKKsm5xfT5A1lGAlXeNDkZOkDDR6FS2GGLrXtWYRN2cScOHWbdbLGB0XycmVsN7+GwI7P/h4xwbcZa8aTR4k/sE6QSe+bWUb49+kx7PkdFscRdFH+mZ1bvJO3/pnQKfDizp9+rDrZcHwSFgKV5utexO2d85DJ0eK+jOBIU8NtqmAb6MhuqAys08jIBbZPljkMmBW07+Wtv33gE91LaYCZF7WyDjORufuqb/nl1iS76Dl0ROp5U8qE+tQTWzu0QyQ6tLAp9TckEe34Puaf98XvzKYE2YEPJm53jtYUK6vqqZXQG6D4ESkv0FSh6exivlMVqhurpFwn3h86/YPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0NAJXYUGvNdq3zU1vF88WbjqzcnAZnNEoQO+PYvsjo=;
 b=Kul5tqbj/FEv81tEDdJLu7G/BOs0Dd3+ISCHcbETBUDRtf+4X6K4AKZo9vMoUaunXH5vRvF2g7l7jY+UQ0IfXlHusjx9mBQ999GaPTgiRhBNtS448hDrba6ZqKm/L6wjDnxxqAXiQobFjWkpusP2r3Lf2Ix2kwY4VVwB0GJMr0r1hKJwwlJRWaQOtBTVxbuDY6mZ5AsSPJXnhcbiFpAkTHAYhxpy66H33ADaL+mvoX1vYa26763H01uGuMNHbZxx48nh2Xv9JqIOr3Cis3EGSV94D+zoh3bkxQwuiuMDsH14cKnkFXuMKo0ki2i8DjpSdRGTOFms2MalHVcEUjk52g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0NAJXYUGvNdq3zU1vF88WbjqzcnAZnNEoQO+PYvsjo=;
 b=TxklelEpjPP91L4njtmylpVp5ddhhesmQ2+2L4egqLoCWZsW4T4+N1Chr4olwO9uDM5Yf7r1VS434b1QhPAL9eECddc/e9bLpVGG75hALIU93o70vKpd85uaI/39Q7e67bVN5kw0S/vqRBDuW7Dxaep/AE3xMjrseE8Azr66f64=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7933.eurprd04.prod.outlook.com (2603:10a6:102:b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 14:41:44 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 14:41:44 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v5 0/4] arm64: dts: imx8: add cm40 and cm40_uart
Date: Tue, 02 Apr 2024 10:41:27 -0400
Message-Id: <20240402-m4_lpuart-v5-0-3292629ba808@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABcZDGYC/23O3wqDIBTH8VcJr+fQo1buau8xxjA7LWH9wVo0o
 nefdTODXf4Ofr64kAG9w4FckoV4nNzgujYMdUqIrU37ROrKsAkwkAwgp418vPq38SMVLNPcMgE
 VGBLe9x4rN++t2z3s2g1j5z97euLb9V9l4pRRjamWWYFcYXZt5/5su4ZsjQl+TjCIHQSXa6O0A
 iZFkR6diJ2KnQhOaZCpwIqXAEcnIwc6djI4y3mprQEjePTPdV2/aTCBHkgBAAA=
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712068900; l=1712;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=drLE6tpkXLsDhmu5fKM5iZ0VFmxcl8YopO5r7UDXTnk=;
 b=hkEFsVSME3ni02cikIMAQV0FgSWfzSlpstWyT6Y5WMGeOmaJqgGBQAh29YzjeHJRpNO3hxH2d
 5/LlHUo6R+SDRkbvlnM4NFRRZ6/6EdVjqv7Yj0cH0ZJI4KBPlnGbkLQ
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7PR17CA0002.namprd17.prod.outlook.com
 (2603:10b6:510:324::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7933:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/EsxYOHFV4xj+sNma/QH15aJM0pcdPD32W9l2Bu3HaeYrSRR4O3ULW3tbdtL5t0F9UtVNd+OWCZmFVyGNfztfFEUl9dc/eelqpJidwnmZpLTQdlonz+dSLFeQ+XfevL1PpTjSqkqZdumQ5dpVJu4Atvn5PKUkBfDzGON/hnS7TB5hzoYwv0uVvZ/E0sE4CxbTul7eo1WjcdLdNZYXEEQGu7Wwne/6A2s4D4zIQ7AQMrv5WItVKXsjo624V5TaMOqv0LgB03Dt/VaLUhpRn8++7I4tWzysJRKu6/U7kZf4ma8HLwFKdr/qT38XIzOI7fIc9/7w1wH0utQ5dX7y7qBcsdqd68ZO+XANAHy2sjW+QSHO/qNTc5jU5g8XoMQ5ABhaQnoTPcnRi5u0SPyiLLvhkF/uuCRkV/ScRBRbX4mJREdjiwyKk33XVkRxDvbknL4t9F59bRGNw2VMZRLXQ1i1JyW93IAUlsk8pDqqpFPFmXMFUSdMItmbojxL0Cd15rDw7pj6bkEVZaWeU8PvGT7c3rFlVhBRZLxlGlitHI1zr3VTG2lkibXfZtAYHyHrbOwh/TwlPV2GtWiCjAHrBd23qJXjYVwkHYS6YR9yS5/G1z546R69FhtW+V3mW5YiKhQRt5q5XTyMsIk2uRxDWqHtUnes/ythp95eaNdPEaY41Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(52116005)(376005)(7416005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmRpRzk3VlF4OU5EdTU5Ym13RlVQb0NLWGRLbWFQZDlwVExoRGhUZU9ZWTRp?=
 =?utf-8?B?YUEvZjlTNVFwN05kWEtUOUFCNlgvY0NKUVFMWWZWVGd1MUh0ZFBKMExPckVh?=
 =?utf-8?B?QldUbmZQNEU5MTlqeWlURXFpVDU3YXdzSGVETGQ0ZlBEbWNmaHk2cm52MmMr?=
 =?utf-8?B?RXpyQjdKUXlKRzBpWWpDb0xzbUlIR2toVGZIMVI5bk9zNkRCaTMwTVZtUzI4?=
 =?utf-8?B?bDIyUEthOVVtYXJ5VFdRNkdHMkcya0xpajlmUURlOVUzSlVWaFdBdFBvbENk?=
 =?utf-8?B?K0sxVnVudmkwOW5vcnpGUlFJR0ZJSFBsNDUvZ2VmbE1BNkhBa0JvMVp4Rmdq?=
 =?utf-8?B?aTBCRWJ1MTNsTFl0OXNvcis1RHZiNVZzelZMeCtoZVk1VUxYdVNJZjFDRkE4?=
 =?utf-8?B?dzR6MkVUeU14MFBJenpUSFhpckl6RmVBVi9CTTh4VFQ5dVZ2WlZMU3Z4cFNB?=
 =?utf-8?B?dlpid1RsalYvdExZeHJ0SDY5MnU0cCtOVnkxQk9UWlp6aHllTEozbDZ2WnZ1?=
 =?utf-8?B?VUVsMUhNZHBLd0lpUGJFTVp3YkJQRmp1Qk9mRXI2dEl6U3Q0YmdKa1F2WnRR?=
 =?utf-8?B?K215bGpjbk5NbEJqcHZ4ZVUvVkZBOXp3Vk5uZ2JmUzBXVlNodU85N2pBdzVq?=
 =?utf-8?B?RmhqSzlaRHRLUGFMdlZyN2NFMDh3dXkrUGxuQXV5WTFNK2pNTXMyY2VBMUVk?=
 =?utf-8?B?aUVsTFNXVUsyRzlkU1hoUVVxckFGclR0UGVKMUlMUmdPTHZDc3pSMkp5eEZR?=
 =?utf-8?B?N1BnQ2Qwcm0vaDY0TVUyUEtOWWRlbFpVa05vVXdxeWlJTmMwTDBmcVpVVUpT?=
 =?utf-8?B?U3p5dzlJRk93WGlZN0w4amduUzNHay9DR0ZFV2h6bWF1VHRFWVMxaG12eE53?=
 =?utf-8?B?eEtscGFtM3NFRnhUenVyT2I4TXFNaUNmellaT2dka2hTaTdLRTVPNlQvODNk?=
 =?utf-8?B?dVpZamgyWXZXQzk1alk5VmlYVm1MV0t2K3Y3Rlo3QXlMWXpnV3dKMnpUZGta?=
 =?utf-8?B?ZURWd3REVy9lb2VrM0Rqc0t6ZUZJZ21GUExTN1phTHJaU1h3a2diVnd2eVhQ?=
 =?utf-8?B?aG5rN1BiWjl1Ny80ek5aT04xdUVuaitpTzB4WW5tR3d3U25LVDZ1b3k0RVU2?=
 =?utf-8?B?TkRHOUdVRkRFYU9KM093ZXcrUjVrK001a09KdWdpV29HSUZjSCtLZENIQTYr?=
 =?utf-8?B?djF6VXZ5U1dEdnlJSFpwenNxUWwwazNZVXJYeElNSzV3Si8rWWcxZERwaita?=
 =?utf-8?B?WG1BWWVEclNLVTlKZWpFenJBQUxTL3AvcnB2ZGNORlZ3QzB6OWNnVVBOQTlx?=
 =?utf-8?B?Vy9TemRiaWUzVUpsdGUyeFpMUVVBbFNzMFcrV1Q2V3kzdzgySFF6ZHF0aDY4?=
 =?utf-8?B?cGo2V01ld2FrTkIxcENBVXNQM25IMXpNem5zT1JVdmlldUNnMDVVNHhXT25D?=
 =?utf-8?B?aDJKWXZkWTNFZEkwdlRPVm5Zczl6T0VFblVtaHpwaitJMUwrZ1VPRTVTcE1q?=
 =?utf-8?B?UStQcTFadGRNbjdBVjJYQ1RvV3k0blZyZnQ1bE1md2lsU0tRT2ZkUkptSmJT?=
 =?utf-8?B?VGdBOFNoOXpPVmdpVGJvT055bjZrSE9ubmxkVDVUVkVYa3dheTYwL29zUklj?=
 =?utf-8?B?K1JxNEFHTlRQMmhLczJBMVdFNmxqTnBHK0pnK1ExalZab0w4eU9RNXhybWRL?=
 =?utf-8?B?UklaVTBlMytEemE5MXBSdFNZSjd0Yk0wcVQ5Uy9lUDlLNjRTL2hwNzJUZ3Rj?=
 =?utf-8?B?VERTeXdGL3pPcktsbGp3VkZGLy8zZ0FobXYvVFArMDdMOWdlUmZ5YnpvS3VH?=
 =?utf-8?B?bnJoanJiVzJidTdpcUkvd0V3Y3RoL2dOSkJDSnJ1OUhkTXROUjVyWGVnTzNa?=
 =?utf-8?B?UkNtRkFXSHgvUHEzdVRmWUl0UVlrbjZ4ZzBVTGdDYUxuYmxzQVRQMWJqWnBN?=
 =?utf-8?B?YXQrNmVuKytXeHlDMEs0NThWQ1VRcGpsZXVaUDVZd0RLQldPMmV2MU55cjl5?=
 =?utf-8?B?UDMwNVVFdjhZL3kxZm1nZENIS0ppUlJtK3F2bmVIKzJJU0FwdUQzUDg4OWdo?=
 =?utf-8?B?VStBVzd2VURzb0c1b1RIT2FGYVl4L3ZPeUV0ZjF2QWFLZVFxUytXRzhnSWxj?=
 =?utf-8?Q?0ovVjkX5+OgDKDzsn16iNZUUx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed98c124-2232-45ce-71ce-08dc53230441
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 14:41:44.2592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 58UPNaJLkSCGID7Xyt4eXNq4x9+OO8w0hxpU3pbYbE/DLxu22Gr/KgjdhrF8xktukx2yOPYm1QQFSuDeXh7uYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7933

Add cm40 subsystem.
Add cm40_lpuart and lpurt1 for 8dxl evk boards.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v5:
- update copyright year to 2024
- Link to v4: https://lore.kernel.org/r/20240329-m4_lpuart-v4-0-c11d9ca2a317@nxp.com

Changes in v4:
- fixed lpcg index.
- fixed typo 'informaiton'.
- fixed fixregulator name
- Link to v3: https://lore.kernel.org/r/20240305-m4_lpuart-v3-0-592463ef1d22@nxp.com

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
      arm64: dts: imx8dxl: update cm40 irq number information
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
---
Frank Li <Frank.Li@nxp.com>



Return-Path: <linux-kernel+bounces-125178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0CE8921B3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B91371C262D8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04CC4EB46;
	Fri, 29 Mar 2024 16:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OFEC+6Gk"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2099.outbound.protection.outlook.com [40.107.20.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77203130AD4;
	Fri, 29 Mar 2024 16:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711730254; cv=fail; b=t9/QTonURNB9g7mvCGLz57OYHwtseqTZ2SEhD+zzYHPWQwpHImYQKN9NxBunthydusB50HUcdTuAJQ0nwpp3caTLIC+pNiSLpmRnQzFmKSrCT80XqJGplKX7Qhi0pgAJ+Cf45VZTfZ2y+xsMYStWZa8wRPNLkwF8n0Q5XWBcSIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711730254; c=relaxed/simple;
	bh=XDD6z5YkiufYBOOnE4NWCJDp6EnGkMNgflhetVZIkUs=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=gbqaoejpCnjl2aHCfme0hEY89ucKRLgIpdmlm3SBF6LKWyRPSx2iN1dfcbS3ehV/696muBlBlO0jQOXiQaQ9o+IIaRmTcoxfR1tS7pGYi+8CfW8Aak4Pf+bR7WFmOrV2yDezzMv7vuDP7SOMKnkv6FuZF+WZItMba43uZsdEyO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=OFEC+6Gk; arc=fail smtp.client-ip=40.107.20.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/+zTO3qg/CqM1JHZih+Smd5TRx1+j62WMEARyj9pNhchErzKGAJJwfcRgYeUWWKGdkWG7J0byA1uuUoeJ6WT9mgaaYwfhX+OciNhzoQhXyY2znwG6Go4j30KXjWaJ0AMvMJs+s2fS2JolnWh88ocQ3dVjgyLutP2BX8mH6Ub9FQHg2jybEEN/CDK6TH1W/lawJUIQQVFOrENWQ2NBzQSz2CWdR5Vbx4o4ddIa1plvbZGZ7BkdByVlVRILka0qnGxeIMt/H9BL4GRaN+cHfmglgQcqqYWsY/d2wlrcounTdCE6qH15flo0z7VBCdNWyNCjVnf9HO8cfajTZrH1xJiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smi2INGDHl3HdyjfZ9kUbhwBMsoC4NH0qj3a1IXRqdk=;
 b=i/4r2jzBvt4RJy4KU4Byt/WTM2kbAsUYvktdVhHlkWg6ZmpK/brzVlWc24zLSEtvhUdYoqU/7f63f13tlNYldgZmvyjDibugvX6dlQH3NcdyjsRv0MUt3NluIgLaNi+H/ta/y9+oMz2dGccYGsR07dDxSunvtrsU/+ftJeEARBtQySmX2S8+DIMWjlKAD8MxZ3I2qkiMCzLseiEBnVm7QD/pUtUjEm7x3Xm5ugx6YueGafLPHoBMDMTuIOgOofGCul4vl+xM8XlNU8KMrHRghodTM/wFt7N7l0swc+4XJInlp3e4GZTPuNiWiA5/Tf8k5NRu2zHzPguo7QmYzwWrvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smi2INGDHl3HdyjfZ9kUbhwBMsoC4NH0qj3a1IXRqdk=;
 b=OFEC+6Gka651TtPsQT9FOev4mns7oe0iTZYX14JOfnUThjz7HMhlUuAirfzdem81OkseaEzvCt/stdKwY6OLvMd26Fgqo3ixgRyUuRoCuaJlhVxuuVCkzNqtwRPeV8xdxPTLnXMTqRL2FxHHQwW+TDN2kI1LL0cY5WS+bgcbUNE=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7577.eurprd04.prod.outlook.com (2603:10a6:10:206::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.26; Fri, 29 Mar
 2024 16:37:28 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.039; Fri, 29 Mar 2024
 16:37:27 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 0/4] arm64: dts: imx8: add cm40 and cm40_uart
Date: Fri, 29 Mar 2024 12:37:04 -0400
Message-Id: <20240329-m4_lpuart-v4-0-c11d9ca2a317@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADDuBmYC/23MTQ6CMBCG4auQrq1ppy1QV97DGFNgkCbykxYbD
 OHuFjZg4vKbzPPOxKOz6MklmYnDYL3tuzjkKSFlY7onUlvFTYCBZAA5beXjNbyNG6lgmeYlE1C
 DIfF/cFjbaWvd7nE31o+9+2zpwNfrv0rglFGNqZZZgVxhdu2m4Vz2LVkbAXYnGBwdRJdro7QCJ
 kWR/jpxdOroRHRKg0wF1rwC2N2yLF9znnIBEAEAAA==
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
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711730244; l=1575;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=XDD6z5YkiufYBOOnE4NWCJDp6EnGkMNgflhetVZIkUs=;
 b=wadA35W3zB2bxHsq1OTDQEkjBsy2n+miNdExOrLXNq4zQB+bPePD3m/73MaDgfXXzdnkfwYTw
 zi8RAD/s63lCOaMYjPYmqRE9XRCrQGXtwsyKzIYnR0RB9XjkwI25apd
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR11CA0056.namprd11.prod.outlook.com
 (2603:10b6:a03:80::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7577:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/oOkkp2ckuJ6A9VRhvpqOhg3yC8cIcHv0TLiFOd6XcVuVFMjuvH3AMfnR5PRr+N/o66+OKvtKN5fsqEBltSwG9/ueYBkxMsW43O03jucQcVb/bfzzTe0MXy3muIVqcuGjKBrqvSQDUQ7vkps6pcjCsUQc6ny7BaPb3rVojPD0WVkSDphdjiRjoDaPut869eYF2pvrLO79KdrIQvWD0ljJYAdJviEBQyo7G9CUFasAIK1vewN/8Ix97hbBFh5ffiEpgYfUEJeIceJoya/JeXyNLPazgk13camrdMRO9mB+PD+9NbqyzabxCzmbztwWdEksL3CKWxflACDXdBdphv1fPuqoogQnwJEW7bNLxmWL+Wi0vMwnSfl7IUgnasdCzEkwVeHOGHdQpqUnKbMhgAZveDapw7yDWwKh875AW89tG45DMWJHLGbGW9ajbLrjaEicezad9KBYCLg9U+hDImMVDmX1qRr5eF7CgLFlPJPZqEA7w0+ghgJEefxTpRDLj3HwD7uYmaQOKB8vUaqxRzcaWmYZBciRJmndZ/o2qsagSB8ZuTOY7ESr5lnhp6zSAxIPpdK0n7BkzhlRzxBkRCh9Pfw3sOdP/pqkCbHFKKrontKPy9eC8Ad+ylPgh3G6H26qB/ncEYkDbTfQf7x0GlEer2AIKSBgxOy1wgnt2ZSy60=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(1800799015)(376005)(7416005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NU1FZ2NyNkJ4aHFiY1BNTzIzdEJtTi9sVDF5R0k0MitBLzJLU3B5a3FRbTRw?=
 =?utf-8?B?cXdKT0VwYUNBQ0JOQVFNU1REOWg5UW1BYkNIcm54YWllUXU5UTZDQXUxeXNo?=
 =?utf-8?B?SUNzRFlBM2V2WWkwaGJWVmQ2L3F1di9xUStGdXlLb1Q5TWRkcDlhTUxkZCsw?=
 =?utf-8?B?R1VpVXpWMitxVzRNV0grQTJveTBUMVNFWHNEaWdCWTVZN0kwS2JVeEdLbWhu?=
 =?utf-8?B?SDl1ejYyczF4SFZKMUlGVk4wZGgweTZSUlFoeGVmK2xMd3lMTWFIR1grdGI0?=
 =?utf-8?B?Y2VHTHJ2NGpZUnRWeU1xelZ0TUxLS3RJeDl1UlNJd2VKTGNwc2JzWlFqcThJ?=
 =?utf-8?B?WTBoaXk0OWFhSDdpS1h2RktvTnE1eTl6c0l3ZEdsUFNHR3ZOSmo3TTR2VCsv?=
 =?utf-8?B?ZkdqTjFEQ09mazljMk0vckhWclY2NVovS1JHZ1QvRTh5VzcvUlFydStuSkFu?=
 =?utf-8?B?a00rSUI3MUxpUE5tbzhMZk84WUFZTnVPVFliQXZtc05Wa2lFcGh4ODRDUW5p?=
 =?utf-8?B?YUQ5MXBkeHQrQTlkZGFjUE5OSEE4a25pb3k2QUtMd0srU3cvV3laRTdCUmxT?=
 =?utf-8?B?TTRWL242TCtwVnQ3SXhTTS8yS2hpS3pUeUR0ajJRS2twSFh0ZFRrb0huMHd2?=
 =?utf-8?B?T3hFQXJnY09BODZKL1dMTi9ibUhITjlrSmVienRaTWxmUVdQVEcrWEVtdWlD?=
 =?utf-8?B?ZFUwamg1YVJLTmR1MDBGbnNxT0VmMXBUUldqd01XQnIwVnIrcEFvOFNQakIy?=
 =?utf-8?B?anZpVk5SZVlhSGpETWJYdUcxdzRLSThObXNMMytsTXlRSGs3ZzQra1ZQRHNT?=
 =?utf-8?B?bGhEV3p5ckJwS3JKRzFOQ00xcHJmOUtPQnNuZ0todEljV29vT3ZySDJpMmdi?=
 =?utf-8?B?bEMvam0vZjJtc1BKV2lXVG03d25oeThwTmtqNll5OTBybDN6eWUwTE5LWU5k?=
 =?utf-8?B?bVo0RVE0aHByOHNzL1JwOFJjWTI5U040dUhjTHM2WndLTkVkbkw4cDlvS2hm?=
 =?utf-8?B?d1JXY3Z1TURFSUhDWkZHNXNYQTBGYW80MVQ3SiszamVMaVB2d1FTOFpZUHNw?=
 =?utf-8?B?Zy9uUStCUkx3K0EvVnlPaHFYVHQ1UkpsMFRDeEgxbU5RRVhXY1I0a21pUnBO?=
 =?utf-8?B?YmtTYkpqM0RKOWNkUW9STFlUeGxPbUxycHRCSHlKeW54TkNrSlh0SmxQa0hP?=
 =?utf-8?B?b3ZFT1NQbnMwUmpzd1daUDdlekVBNEtPSkloNjV6dDk5Z01HYzVwOG1oUUNm?=
 =?utf-8?B?SEJmTjhpUjI0Nmw5TGJsSGx2NXVoNzhMYytXc2ZlOFk0ZEl2R2prK2ZxVmRZ?=
 =?utf-8?B?bTQvNFN5QUM4OFYvOEhLVVhsejdhNGN5YVp1ZGRSNEhhZjlVWUlwajVWT2Vk?=
 =?utf-8?B?YjVKb09yNCtrazFmMkRXdTJ1ZGtUaWQrb1VYcGdXNVhxM2xabmV1S1dybm5D?=
 =?utf-8?B?Q0c3SzczeFBkNTBYNmNoaDQwQlVpbzdqNmU0LzJpU1daUmR0cGNGS1l0VXI0?=
 =?utf-8?B?UkFTd3BPb01KS2RXc2lZdzE4TXArRHZ6eUw1NFYyYWFaRXR5dzNrQjF6MjVn?=
 =?utf-8?B?NEdUakR3TnM5dFZEZkY4NlEvZGkxUTA4TFdWd2hocFF2L2xISVYyZjQ3UkZW?=
 =?utf-8?B?UnQ2bWR3eVF5M3F5dThTcUptNzdwdWtNSkRRMWdKZVNLSnlSUzc1VzJraFd0?=
 =?utf-8?B?d2dYVTFkMEs5ZmtKdWxpNldPOWxiZzlpRUpOS3BwbjFaZ2M0TWxpMDlGUzZx?=
 =?utf-8?B?MUd5SUJrRzBJTCsvb1ZHTEZtdWgxcjB4VTNpazVlS1g3QlQzQlZmZmtlcUVq?=
 =?utf-8?B?dDZ2NlZJc3BxRTRubi9jWWxtamZMNjBtamlJR3NFRzhXdmpuVHM3SDRYUFhO?=
 =?utf-8?B?N216NUUxcS93cHE3OGRJMjdXa1FGZ2dza3NkYjB3OXJ0Y2FFMVpZOGtsMWlI?=
 =?utf-8?B?QW40dG1SZlZ0T0Z1bHlvUlFVaThxSUhJOThVelp1a3hiMHVsMDJhdndpYUFr?=
 =?utf-8?B?N3hVbFlSQnowaVpjdWREbVk5UUp3emxVRHNRUEFtdXJmM1M4K3N3QjYxaVhl?=
 =?utf-8?B?MnErdkV5Ti9rN1hHaEhDQVVyOVJwRGpnN0hnN08zbzZqRTMyQjRKeXhWWU51?=
 =?utf-8?Q?nOeoYaDnIy/lko5BrqlNj87hg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 379de647-aa9f-4c9c-47de-08dc500e8564
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 16:37:27.8505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sLGEHu43ifEWCxprzwnsTLy/5EeW9Mwr8MMufQMHpPt8n1MdsGmoraP+lISYwDk1ALiBUJcji70SOllv3jADRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7577

Add cm40 subsystem.
Add cm40_lpuart and lpurt1 for 8dxl evk boards.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
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



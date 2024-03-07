Return-Path: <linux-kernel+bounces-96087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F3E8756F0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D0CD1C2133D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3E013665A;
	Thu,  7 Mar 2024 19:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KtMUHfTB"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2065.outbound.protection.outlook.com [40.107.22.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352401CABF;
	Thu,  7 Mar 2024 19:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709839177; cv=fail; b=cANbL+Hqy9ZX0tkuTHDncYzdMaq6JDhzZbyXDggUjWbQmUGT6OkBoV33edMye/K8P4QZsuK45dzLsJT11up4d4pl+Jowyn4qt2Pmy025ECWGwJ+D8Y7kOVfHLsaEEhI+MssD2Z5RawRJoyAvhDatuj1KeGSkkxvV0Ffcak7Gtlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709839177; c=relaxed/simple;
	bh=gdKNYY41INJp/ZNcMkEbrJSELycmTzaLonoIWy6y3Ow=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=IsQh1E/FlRbHQmwf+u2bQoqRrv8fPdiFLDMueaCIwJRqi1GSOERDtan9LNYtAOJIn4QBXBWDeczX420KcyWpeayFqGA/RHxIzj6uX/XnIGORpGh51YdYHTX7I7zEXcuo7L3A/ymMIckn3QT23Z9zm+1RHnBdk/7Yqsi6bT7g0Ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=KtMUHfTB; arc=fail smtp.client-ip=40.107.22.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TG+fpSHMNrfHdl0wqTtwCFmx1P8p0Cm7daiQFPv/gDr4/RmfLyp8eIxNc1LA76aW1y1zfXVzU51r3KBpYNs/e9PxOShAGTQ6i0Cz+BQENTpL4Ok7GJ4iBZSpAulrcmjDzx9TiHF5Zd9Blfk5RZjkd+S6v0YgR4QtpXwLT/FvFLzk3lQKfKt/gLqc1gHnSnSlqPzW4CgeLIr7dpo4HrdzggCEgkiTQZJuFvzE6cElNBN2I3fltxJ76gZAiqsoGQQEuiLOSS+fXURQhqjt1/QvueaNvPXDQJ4RAoYmUvHP0h2fUBOaOZySBpWJXxbtBHCnIu0LNdXtMyDaMjWp7cVZJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oAAjPy2q+8qq7INS/8mNGXjdajB8H3IW9gRYIW7RpMo=;
 b=UzNG/FVCGEwt4qW+GRSRd+MoBgKIdizzmEVw17vdWv+AuXLLE0AyIiBBbe/xRbQZ11tEbDgBzkVZwMInoBt8dG+qIaAit2XhEIK4Rvgn5fHjcDu9pwBO/garsHKymSBBIbymObFJA37oZ5VDAdcQSOJEZElZyGe/gF6elNsYUgcP2TyWJZ0f5Y6I0+CQylw/6LvS/30ynNV0yq+K0sPe/p9vqCv6UwHQy0kDpp4ZHwuODihrfz3A+EQBq+I0a3dJf7TnVGn0jc+R1j8p0WaU4Az44irKLLa+hyoKCAWGBfxOSxoDewa4PAxKUzxa2PPp3pTEf+TRPVyRVvsI7bifPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oAAjPy2q+8qq7INS/8mNGXjdajB8H3IW9gRYIW7RpMo=;
 b=KtMUHfTBUFZCoOIEn3Ik4tO98gmUoCnkWrEc9aO+nt6ZxfotFARk3SHTGmkSJOgQIOyxuIEX5syUddnQwHyy8DIbx/AjDDKx9TGdz2CRiv3w+2BMDhgued9+VhJGtaFRGQ0ibSQ3OM+yfwtNPw/H3DJF5HvcCwiYjNEVvTmqLlY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB6992.eurprd04.prod.outlook.com (2603:10a6:803:139::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 19:19:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 19:19:29 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v5 0/4] arm64: dts: imx8qxp add asrc and sai
Date: Thu, 07 Mar 2024 14:19:07 -0500
Message-Id: <20240307-asrc_8qxp-v5-0-db363740368d@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACsT6mUC/23M0Q6CIBTG8VdpXEc7HECxq96jtYaAyUVq0JjN+
 e6hN9rW5Xd2fv+JRBe8i+R8mEhwyUffd3nI44GYVncPR73NmyCgAMSS6hjMXb3GgaLUuigVVwI
 akv+H4Bo/rq3rLe/Wx3cfPms64XL9V0lIgUpktTGlq5mBSzcOJ9M/ydJIfO/U3vHsrLCy4rKxX
 OtfJzbHQe6dyM4UrK4UiEJWbHPzPH8BW4QurxABAAA=
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709839165; l=2160;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=gdKNYY41INJp/ZNcMkEbrJSELycmTzaLonoIWy6y3Ow=;
 b=hu1VhB9fbnLuUPsoVdXvo9rEDzJy0tYxfLUSUR5RAsIpjaWcFyKiYTi9Tzxw8c4c59UFlkHgV
 1eJonB/+JRSCswIsg4mDGETUwDI7mYlvv7nfZc8P27sdDbMrZEHL8Wv
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: 976d228d-7ac2-45b7-c784-08dc3edb82b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Fjvnd1HsljJ9ayh+ihHUjArb2TkfvziOdJNzP6lPtCL4Pj6EtLCBTytYccPyGQdDVfL1WoAgWGw+0CZyEwfH15QuC/IaGKse4nJF4lNVvyuQ5MncXxZdst8GITc6y4Mgg72vT6JxxxAYWt57jES7LvHvMgFH5aiAdoi34rMI81cF7m56eXp6EkJH6DZuzgkWXRZ6rouD9aIeH4Jd12aBDRNquA5XO/d7C+SvmjNB5Ss64ITDvWq+/Pdq6I2V+ay/ut9WMf/q9wNMn+2QuRUSV7TdKMAPvLgoiL7L3FdZVz67lqcuaucY29hZIZ9VQd7Jc6RRf2WVeyJ/pOUkLLTMcxnMwQem1a7OZuORXmU7Dq9bDGc1P5pLdhmRYFpOd2eexzkP8dFqQT/1q3syhN7TXZmvLp49yz9/ccJBzOQCw07QXzDriRILHutjsOhXdQoXMy5oYR+iz+sMHw9Xl1NYdVAS3yNTZ49nS/IBzok0MUkkKgKA+hCg243gYzYD0l1xTOKKZeXZOhsxcvdwZIOl3GH13K7Rm6TEIBSmBcu1Y9tMmsqDkFNNYLx1ZlpQXUPkWvtqFo8kyl8EWFr7eeWkhbu4p+qgSvKm/Dx9CupJsEZVXQ5/p+wr9LZ9KJc0dDwYEMla5Yj9W9SKIfU97g9qdReVvmUkQ5XSTOuyM93yxsSdXhlRq1fevJMoyvOcxIQN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWJYMGkxRzJxVmU0RlZXQ2ZKQm9wOWJCK2VhMzFBWkJ1SVM0Tkt3Qk5LWVR0?=
 =?utf-8?B?Q1pnaXdTODRtbjBXMWFjN0NmNTdnbEdPTDkwcCt2N0JPZXN4SjZ6RjNhdEZw?=
 =?utf-8?B?bGdoYkVDSWd5aVJnSUtsRlA5UEFaeWd1c0JFQTYvOUxHSGlKY0JDQWhrUVRi?=
 =?utf-8?B?bTU1QVBwU0ZKNFVpUk9HVi8xYllScWNsZ1ovZ25RU1dhQ2hBNmZSN2VZMi9D?=
 =?utf-8?B?WXJOVElwTHBoV042VjllTk95aWxrSk4xTW5XWk5hUUxBOW82UGM2ZFcyUEdW?=
 =?utf-8?B?TTV2L2ZRT0d1azJCWXd2TVArVXVOSFp2RW12NWhhMVlWTTJTemlhdTR0NEVy?=
 =?utf-8?B?Wkl1MUZ6TjFTT29vMG1wN0V6VFQ3NU9pUjVDbWpXODZwUDYxK1hySm4vK0RM?=
 =?utf-8?B?L2d1QWxXNVdxNUI2NjJFaVNIMXZITC9JdUxYM3hvWDYzOXM3QmJXQnM2WmFU?=
 =?utf-8?B?WVNQZmEzWVZ0WTV3VVp6TkdJbVpYZGw4QSs2RTJOR2RXdTJKUkNKZmt6Qldh?=
 =?utf-8?B?YkVFdjBPQTFMQVVMclVMVjY1c1Q1ekpOR2RxL09Wd0N3TDViQ1V2VHBPSVFS?=
 =?utf-8?B?dkdKUTN6RmxCQkZiU0dJcVA4ME9nL2RnYUptbzA1aVdTU0w0czUvUEgrK0tW?=
 =?utf-8?B?Qk9JVmZPbmJoSHFkU1dYRWJzcG9OT1dzRjFEdDVMa2lRMFJOM0l5YWJBVVFU?=
 =?utf-8?B?c1NUWFhwcHBiNkhud3c4cW1HVWpDZmdJR2ZSTXNEbUFJK2QwWkV2cHpXM0NI?=
 =?utf-8?B?cUNVd0pCbldnU2JHUEVRUlJpd21aWkh6ZUtSdlVsblZzUWZDK3hyUUhlT3Rn?=
 =?utf-8?B?N3pVWFpaSHl6Zk5WcVg1dkJ2RU8wOHc0QnlkK1lZTjk1aFBMVFBtNjFVazVs?=
 =?utf-8?B?REM2WEIzdGhRY0Zyc3pKTEVlTHZBV1Ztb1BGbG5wN2pKZkJPS05mZmg0U2hw?=
 =?utf-8?B?SHovSzBRR3R3aHhkV0c3Nmk4NXQ5bjdoZHdFMzNSU0NuUlUxM3ZSeUtmRjdE?=
 =?utf-8?B?THdwNDczSUlxVSt6WnRJU3FwTHZrMkErcEgxTVJHMU53ekp4bkZ2UWh1OHVT?=
 =?utf-8?B?ZWVPTDRWZjZEUGdEWTVhS0E3V3ZOanNZZ2E1NjIvdmVHbmZhcktYR1p2QXpQ?=
 =?utf-8?B?c1JudEhNOEJveE9ldjBxZGMzYzVnc0FRamtRUW1DYjhvbjMyUmY1THdQVTJS?=
 =?utf-8?B?citKRVlnVks2UVNKSlEyMUFzVEhUSUJUQ1RTTTdYVXFJYkwrZ2daTmwyYlFN?=
 =?utf-8?B?N3hsTVd4czNvOWQwam1mNzJEZmdGNnVzWGpkSEhNQWticSs2dTQ3N2FGTDl4?=
 =?utf-8?B?Mmd5R0RWQkc2SDhvNSsvc0tzdDZ6cjVmcVNjSUUyajVvYmR0SzYvUW1MTWpB?=
 =?utf-8?B?RS9iRUljKzRTL0x0S3oyak5UYWJwVml5Qy9CeUxPaUhEdnpvRWdiSEJGZ3pz?=
 =?utf-8?B?b0E1YzBubVp3cHdJdTFkVjFDamdpdXp1KzZYaFZRS25rL0FvbmxpQzd2c3N0?=
 =?utf-8?B?REgvVkMvYnBGZythY0pOeDRVV3I2eDhFQm5rZjlZOTBqaEk1dkZHUmV2cERq?=
 =?utf-8?B?MGZGV0FjVUljZHFQWG9RdXhkWmVWZ1JjSWxQWUdzclhaMmtRY1pKUGFBT2w1?=
 =?utf-8?B?SStHL3U2OUZqYU5HQ25mbFBxMGJQTlhDY3o5OG5MS2hFOUhjYVNEclVJb0Q0?=
 =?utf-8?B?aXJaZmtXUUtmWVVLRWw5Mk1NbTRKc3BnNExlUXVYdHp6WW04TVpoU3RDeVE4?=
 =?utf-8?B?ekM2TkxQdHhIdU92VUpTVVhjMk81SXYzWW9qd1d4b3hrZ2FieG1zNlBYRzh2?=
 =?utf-8?B?Z00ya28xZHVGVExsSldRK0I5bGRoZ21YUzg3RTJsL0d4WTBPRC9Lb2YxSXRz?=
 =?utf-8?B?QW9BWDdSaHdIUUtLMG9tYWp2Y1U3TkVxLzkzbXV4NFBvUUdjOUwzYkxicWxL?=
 =?utf-8?B?VTloMDBuckpwU3M1alRSNDdtNXYyVzlZOHFpV0Q1MGRhczlJMnA0dHBNU0Zt?=
 =?utf-8?B?L2FiWG1nTm1Xd2E3eHlESkZ5MHJTV2V0ZWFYZVJJN0pUc2hrTVRNeS9mL2VN?=
 =?utf-8?B?SXRZdC8yLzA5K1R2aHF3SGhTbFdjRGF1cWo3ZHF6RGZralJXMlR1WTYwYk9U?=
 =?utf-8?Q?EALE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 976d228d-7ac2-45b7-c784-08dc3edb82b9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 19:19:29.2957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fV4DHtCox2PakNkn3nHppPbhpNkaIsnizXczpvg9mB8bLmpCa5MMQNGsEDABxJfG/RbI+6yJWE75wxQi0o77fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6992

Update binding doc to avoid warning.
Change from v1 to v2
- Fixed dts DTB_CHECK warning

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v5:
- using rob's suggest logic after fix maxItems.
- sort dts nodes.
- remove spdif1. Add later when do 8qm upstream
- Link to v4: https://lore.kernel.org/r/20240305-asrc_8qxp-v4-0-c61b98046591@nxp.com

Changes in v4:
Combine comments' from v2 and v3. I hope I address everythings.

- Krzysztof's comments
  - add reson about why change

- rob's comments
  using rob's suggest logic to restrict interrupt number
  but for dma-names, still need use oneOf to cover 3 case
  - [rx, tx]
  - [rx]
  - [tx]

  oneOf
    - items:
        - tx
        - rx
    - enums: [rx, tx]

- Conor's comments
  - add power-domains required for imx8qxp and imx8qm
  - remove dmas descript, not allow use index to get dma-channel. Current
no user using this method.

- Link to v3: https://lore.kernel.org/r/20240228-asrc_8qxp-v3-0-d4d5935fd3aa@nxp.com

Changes in v3:
- Fixed dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/fsl,spdif.example.dtb: spdif@2004000: interrupts: [[0, 52, 4]] is too short
	from schema $id: http://devicetree.org/schemas/sound/fsl,spdif.yaml#

- Link to v2: https://lore.kernel.org/r/20240227-asrc_8qxp-v2-0-521bcc7eb1c0@nxp.com

---
Frank Li (4):
      ASoC: dt-bindings: fsl,imx-asrc/spdif: Add power-domains property
      ASoC: dt-bindings: fsl,imx-asrc: update max interrupt numbers
      ASoC: dt-bindings: fsl-sai: allow only one dma-names
      arm64: dts: imx8qxp: add asrc[0,1], esai0, spdif0 and sai[4,5]

 .../devicetree/bindings/sound/fsl,imx-asrc.yaml    |  14 ++
 .../devicetree/bindings/sound/fsl,sai.yaml         |   8 +-
 .../devicetree/bindings/sound/fsl,spdif.yaml       |  33 ++-
 arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi   | 267 +++++++++++++++++++++
 4 files changed, 316 insertions(+), 6 deletions(-)
---
base-commit: ca301cf599a4eeafed8e3dd87bf8d2fe810e075e
change-id: 20240227-asrc_8qxp-25aa6783840f

Best regards,
-- 
Frank Li <Frank.Li@nxp.com>



Return-Path: <linux-kernel+bounces-128700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5898E895E5D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C72B1C227B6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE0215ECC4;
	Tue,  2 Apr 2024 21:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cVaP2EZ2"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2123.outbound.protection.outlook.com [40.107.6.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA0879DD4;
	Tue,  2 Apr 2024 21:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712091815; cv=fail; b=RS9vSNbGBkkL3nnygw/ZXbXAEZC1V86BsBXkAPFHkQoJsfoLuTX5AbQNKSDwXwspkim5eh8ywgSp3PYYLbZduaIfoX8CeEeSfdnfglHkUtoOzbrjl7hNyZx+FVA88qBKQmnOaGB5Us9jrwf9+B/cpm+zGqEOjvjJGb/RnI4i4R4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712091815; c=relaxed/simple;
	bh=6EzLhbi6fJjnWXOgqAJg6Ww1frl14zBM6XLR20QIV8A=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=gW2jEh6s8+hN+tvWnnige9v2NiI1WGq4DAFLjPXD1Xkg7AzK25oMh7IuGP2PC7I6HkkZ2+ly5+Mpzg3O3HFYzO8HUquw8ogALuCf5tBH6mKWibq9gV+mr/Vj8mD9SOs4UhpIxcPww+rYuDnjo9WHpGCOSYljku2DhSctZtiUSRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=cVaP2EZ2; arc=fail smtp.client-ip=40.107.6.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KB0P8ADZWGLmNjFFg3/6LUClZI7DAiWUblVM8iaaVIDae86xe86rXbI680X9f/5WSsZJbuwyrzcoK3tEUTkd6miEANZKz7kfCWFjGL9SpULb5KqOlZHM3KuyWQlfceEofTdJDwT+dMdG+1qZ69ray0d68nvFiCGsJx0oUfLeNpFdHvi6VJUiTjSJZiLz8ki0hDPbYxwaJu3RcrqOnFjpKI0lghdtIjs0VOT99WWINrq3H3BslWqIDeggONP8MvmHpIaQ/lUNKE4DpKv8Gl3lPXwe0nQIn7mM2i0jizubqDPVygzFgK0rsvsM+VcO23snvMVqcEu5FXxEemSfVJ5tKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBq1pdX7Xvppgo1/88zar2lC5ihojOPbImqkbX0OloM=;
 b=DqeGPaPf+QqSO9N347LZ0WUcHHOqbE9BHMi2k/5Ti+BDzdhNqy5N76GQpc50dy/K1gcPRqVU5dsP1//ej2H7ZIz676jEcwTAifG1Gc4hmFTcYov8m3nLZ0GO56212HkAWj4VtREO2MT7Tfsng7Vlg5hoR90orydmw2Pqw3IKlrHmNswKXJ9voKyDKvIvKvA1t0BWjvVCA+vhKMSwa888SD2cZx2Ngco93slRnqXNrkWlStl33X4FdhbCD6ZFJCqa/2Ky/i2V69Mf28sfCUIV/G84lv/NOs+8n1riPRBsHi2oJd2QhNstDzBLqmaP0mW+EqNNvqqL4ZBGA+AQX8vLnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBq1pdX7Xvppgo1/88zar2lC5ihojOPbImqkbX0OloM=;
 b=cVaP2EZ2CTndEEGI3QLui4r6E/bFa4tssA85JexjQdkaer+dIcoat4YxK4XHuT0bC6rWJDsyv97rzRQDqzNnjYKYiANCfFn12T+dUW12cuhfQ3uRJEx7VWwCRKCInv4Yu/Pn0MX1PwvHiRt8aSZ5LT2bltKsmLPMQMME6Srz1ZM=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8648.eurprd04.prod.outlook.com (2603:10a6:10:2df::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 21:03:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 21:03:30 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/3] arm64: dts: imx8dxl: add audio support for imx8dxl
Date: Tue, 02 Apr 2024 17:02:27 -0400
Message-Id: <20240402-b4-dts_dxl_audio-v1-0-d26d25b84a08@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGNyDGYC/x3MQQqAIBBA0avErBOmSQi6SkRoTjUQGlohRHdPW
 r7F/w8kjsIJ+uqByLckCb6gqSuYN+NXVuKKgZA0aiRltXJnmlzeJ3M5CarT1iBhi6YjKNkReZH
 8L4fxfT+lij7oYgAAAA==
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712091807; l=716;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=6EzLhbi6fJjnWXOgqAJg6Ww1frl14zBM6XLR20QIV8A=;
 b=n+in6f6s38g3diqA0/XR4E/UAwS3o6MXQtMgMs5xzihaACuGECIFBkBaOr4KwaHBa4Sh65QQ0
 WDtjrjMPYovDIG14wYu9+8DNxbgOZdHorUh9fFYEFQfsNtOlJ6QhA3R
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8648:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wLSGV8vIILiHBQJRWO74zXr6e4753aAfL4seBQ2osC9FLK5DqqzYJ5Vv8PN8BuwnFRNlAfp3QIpcZm9YsEna8PXTFTTFxMU3k3z5nWpkCGNv2ls6Hy+isM6TBl68fO9XzKtS6RrXRMZfmXzkjewGY1E+Y0MDbWrj9/5O3g138XdouoUci9Rw4x5Nh5WJxDIe13mUSzjnZ21crqaD4/rk3F4y7lxmIqlCjd+WCf2nnPU4jffod+mWfB5bjlTrdbY6na1ChfqUNza7gf7cc22CZ63WDj3J8ZCg2Cz36H0y3mJt/KZlutBtjP8TsgkIHyfR6e3SeGPE/NDf3d1W7wWcK+CK3ytt47hUNywH83qZX2nFMLZIAxa8QhEg/HuoxTxLf4DEk7KlXZwNTtR/72JVu29qDStqW6u0ytthHvtqxzeLqeMjXbC6h2DXS5nBnpG7xiIuDe4PK1aeuawLjY0NRvsr/ya8ksFunXTsG94FJgazXyfKkiSZbuvkbGNHzYgKc1EZJdUlfslhsEkSsxx/fpECGIhecLjUEZcKvJjELJQHRPY+Ino5kzR6UqPUVnP5Tvq2kSxA+7nEy0nw9tUSMfyuhsM/etAgnT8YIqvSKpxZ4UGuEXY0XZBtNK1e3QfmYQor9jcBvJprimhJ6xAXmy2CeoztBMoz2fYP5KnDZAU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(7416005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emFOV24vdTU3cE9PcFVFUlhZSmM1RUlmb0kxZEUrL3FXbzhST0pWQ0pPTnZR?=
 =?utf-8?B?UVJkOVFvUjV6VGlYM0hqcmpWSUZZYkhYTUhlM3AzSjNyQkFPMTlCWlFFcVhw?=
 =?utf-8?B?RWpFc2tMQzRROTVOdFJORFpOb2xtSzVpazFlVDU5eWJmcHBmV3k1akR5dG1X?=
 =?utf-8?B?eVl1TkVSTm51dUE4NDlSekI5NUV3aXJzbEgwZEpyeUd0b1pkL0QyKzA0VjVj?=
 =?utf-8?B?cWRBWVNOQkVsdDVEWDVXZVd6cWU0SmZuZHVESUVaNU9YbGxuTWdyL1lsaXJa?=
 =?utf-8?B?YmpwQkZsY2ZJNmlXYThaOWtMdWV5YWwwQUM2ckNNSFdTOTBSNTZFMmdKTXJ3?=
 =?utf-8?B?cm1oN2dLVWFMaUdxTG5wN2Z6b3Z3c3FsZkowUHdVbGJ0QVFkRW9VK3BKaDJD?=
 =?utf-8?B?Z2JnTWt6R2kzc0dnZ3cxQ2JIZmZkVkNQS01KM2RkTWQzZVFHaFh0K2I0cU9J?=
 =?utf-8?B?N3EydkhTdEk3WVJhbDllMW5acUV3Y2xFaHVQbHlnWk9UQWxtMy9mTVFJUlFp?=
 =?utf-8?B?ZzA1VDV2Ym9zRjFMUmVIdFRic3RuUnlQdXJpdzBjckRxSEIyVnc3WDRyQWh1?=
 =?utf-8?B?UGx0YWdKSEdYMGVrRWpyV1cxNFBhenFWdkZOSEM2aU9GMVdGSmlGUEZEQVhQ?=
 =?utf-8?B?c0twVnFjeHBtY1NLTkFBanhMbGsrOS9yWCs1QktXc0tjdDFpSnlZOURwMGEz?=
 =?utf-8?B?RGNCRlNWdTR3aWptb0ZTY2EzS01EY3JSV3NFSzNZcnJEWitQZVlrUjB0Q05j?=
 =?utf-8?B?VzBIY2dyV1pjcWJ6bCs3VGJMOC9VRDl0QmVYNStEQ3hRYWJLS2pMd2Jqbk1v?=
 =?utf-8?B?MCtNVGZSNk9PMkZiNDE4MmxJSCtVVHJtc2haQnpVTzA1SVI3YVYwcVN1MDFz?=
 =?utf-8?B?RU9UdjcrOFg2WEdiQjNwbG9EUkdBYVJxSWdHQjZ3amhmVVVQTnBRTXFpNnB2?=
 =?utf-8?B?aG5MaWxvUlBzbTFqNFFudVJlVFYvRjJIdndOMkNIS29qTHh3cjRob1paNG9m?=
 =?utf-8?B?cUhHc0U3bVUzZUE4WXVEamRNWlVRTUFrUzJqRTFPQjBjUXQ2S2VCUVJPTTJW?=
 =?utf-8?B?MmxVbnZNUjZHR1VYdjE5bzRobkVoTWpwcnVtb2ZCcGtjWjN1RGRTK0pFdndR?=
 =?utf-8?B?YUh4YUNjNmdubzA1TWJ5TnFVY2tGTklsYW1WVGVReG1sWkxIRE8wcU1ZNVU0?=
 =?utf-8?B?cC95dnNzdjdDK3dDajhYMXdZN0hUV3g1bGpZL0pnMTZISXpwK2RySHJzdS9Y?=
 =?utf-8?B?RUphMTlmTnE2b0FhM2I1THMvdzJ6WWlMSVh0T3ZtMWE5Sm9sOVhlVG0vY1Bz?=
 =?utf-8?B?ME9Cc3ZhTXVhd053UnBxMm5ZZzhKTWQ1alBMQjZ2dkdFbitpdVpuM1hZSVlh?=
 =?utf-8?B?SHlIZ2JHUXBrQlMzUEo4TEZBM3Z0VnU2LzQyWURMeEE0WDZqcW4yWkw2YU1T?=
 =?utf-8?B?RGQ0WWpoN3cyVG9VVTN3NFFlYjZlZHdrYmMrNnFxb25NZkhUVVdUMDZqRmR4?=
 =?utf-8?B?RVJlVXdqK2RDNWlsbUo2VWFNQTdyRGg4YkVHZUE2cUgvR01tUFRUdmlNYUhC?=
 =?utf-8?B?Mnc2MWtuOHZrcmhPWXBEYjhFQ3ZkTlhkM3VUUGk3YkdxaGV1QVBEY2ViMGFV?=
 =?utf-8?B?MVFMeDYwQ3Bjci9kVklOU2E0RXRWUkhKZDJhYzZ1cERrWmpYTW5UZkYrd1ha?=
 =?utf-8?B?NjhZMERkRW02bDZmdmxmZU5qMFZLMnNUOCtTcDVJak9PTHdRVjhoeEZURmJP?=
 =?utf-8?B?MWxrTUdHWC9HaEljYUZsWG5JZWh4YS9zbm9pYmpoTzdwZnNzcnJ5S1dDY3Nj?=
 =?utf-8?B?RkpKQVRQVzRlUm1QNWNncWV2T3R1K2tMaDF3QXdXRU5UTFh6RjcyWnNFbkQ0?=
 =?utf-8?B?eGRYZk4wVXhVUUJON21tRUlwV2lEVUsrZHFkZCtUVGFhVFdyQ3lENlpaQ2ls?=
 =?utf-8?B?WE1DSklyMlpkNzZlQk04eC9ZSjBDMks0R3U4dFFVUkdzOEJmbDNRdWJKR2px?=
 =?utf-8?B?NStpUGIzYWt3SmRtUGZ0bE9waTBBREhFT1hnU3RkREIvTTRFb2V6ZzVGQThr?=
 =?utf-8?B?TWZBY2pCdThQbVpYOFV1Um1XcjVVRFhkaXV4UFVuVEhGOWFmdmxYWUZqWTJn?=
 =?utf-8?Q?wwGs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c07390-5549-4ef0-f429-08dc53585982
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 21:03:30.5303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ce5PBu7JkWFa0EbBqGxhgjxLnsNI+dm18rXhWIwhY9IRChjiT7ni10nlmKY5lNFv9+vmxAGfAEUmfRIpVLqTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8648

This patches depend on dts part in
https://lore.kernel.org/imx/20240328-asrc_8qxp-v8-0-801cd6bb5be2@nxp.com/T/#t

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (3):
      arm64: dts: imx8dxl-ss-adma: delete unused node
      arm64: dts: imx8dxl-ss-adma: update audio node power domains and IRQ number
      arm64: dts: imx8dxl-evk: add audio nodes

 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts      | 234 +++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi |  78 +++++++
 2 files changed, 312 insertions(+)
---
base-commit: 2d13a7797c3970a4eea160844d8905c93065634f
change-id: 20240402-b4-dts_dxl_audio-74ba02030a72

Best regards,
---
Frank Li <Frank.Li@nxp.com>



Return-Path: <linux-kernel+bounces-149393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A969F8A908F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 03:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DADFCB2210D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 01:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A14F8C1F;
	Thu, 18 Apr 2024 01:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jITcc3K6"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2064.outbound.protection.outlook.com [40.107.104.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776216138;
	Thu, 18 Apr 2024 01:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713403477; cv=fail; b=VdbQGsX6TUhBllnnBn0nd9UA0Wyn+umzY+rJzELTVaAc3BvrUSdh/V64GoDG7Vx66FMANpbZ7CX+nTHhQKKOMex6vng8OTGCVey21zPK9GWbCD1OwVg2O0zxZxCnL5f2i/8WRS5zI+kAp1X4C+g9kp7o8AHkMbdZuycdjmRgmqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713403477; c=relaxed/simple;
	bh=TRw0dfhK1hayMDFD1zxJgF7iuVtcqnFj8orxVs+mKtE=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=qYfLebVcZ6fJLcvvh6x+AUzoEiWuiq077uERijxBGpxgYKDdMyZIqZzTIEH/AakwcF3wEO2qHj83aX0v/SrUw1xATPhCeKiIexRN4s02Tp3OHj/OHdbD9yDmEY4pZaMzFANW12NIU6GzIuEWokRydoPsqkXpzG4nK/Q8PyRxOaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=jITcc3K6; arc=fail smtp.client-ip=40.107.104.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i48oqdfMqPUH4kV8wE3r2e4+QNYCqBsFNp3ZsPZ6N4qmSJIy5vqU/HxaJaVVbWGWlZrItoNQG6aZ1HGKELrBfAe73F/OOdMdVuDI7zVsU+4xdp+/xCONMv7rwSrq6x91iY0FeiK4gCzdMvK5MPEcd/qhuFeAJwGJzNBLU5O9O3PLH7TZWf0xMO2ynYFb1HrUJPnNwjixHfTJSO27tZN8t6811TU+4/cwS5+Bq9ADoEcQxniHncOsQgwyamZ6c2o0zDDedpagsO2x3uWt7bp/WShAgAx3LvtiQQHbn7H9S5ZH0A3d5vcNrH0xUAMDzYd3qkoXQvDCQ7wPUYZ2AbEqBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gr8Hu/MZcM3cpyVos2BG4Zh4awRnkXAc9ok+ARh//H4=;
 b=Xl3SObNl1emsYQcsPFvBbmtC0XQqcdppd/hlOB2KXPAYwgnUI1vu4ihIqKXNnLzSfCBtXR51zzQ4U/GoXMSOMfwtPgldNWrey6emFXTb/cRUOcHosMm8FOXffKeomkgvvbD95t249NyS9oir8IJ3F8Eq/Uhe/eLoT+7qXESTqi8AW1LyfDkfHRF2xqt/RQ6h6bJmogOL17qHzyn49zgKkNP9qt4ITKNywhasuxtftDPiOdNfMpdATsGwuzBf1fVe7QMSo5GR4mN7UjKRLof0/xCSguF6N9G8TDlkNP8N6gpS99aRyZdf4eJ/P72b5q0gHjAAkcBSw+bUnwAU7XFe0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gr8Hu/MZcM3cpyVos2BG4Zh4awRnkXAc9ok+ARh//H4=;
 b=jITcc3K6W/x2LcnBdyLE+gF4qEEGBWrstXQfI14ZRHzrFXiTdn33Q03OiiIudniGA10csl0zaXwFYVDcj4AOjWpr4RA7Fv66DZgXobUCOUByAOAA2kvVrBl3XRs6Uswg9SyVp2nsF2mvfGZX0VA6glGotJqwQKN32ASeR0I80Ns=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS1PR04MB9264.eurprd04.prod.outlook.com (2603:10a6:20b:4c4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 01:24:32 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.049; Thu, 18 Apr 2024
 01:24:31 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v11 0/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Date: Thu, 18 Apr 2024 09:32:27 +0800
Message-Id: <20240418-pinctrl-scmi-v11-0-499dca9864a7@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACx4IGYC/3XS22rDMAwG4Fcpvl6GZVk+7GrvMXbhOPJqWJOSl
 NBR+u5zCiOJyy4l+PTLh5uYeMw8ibfDTYw85ykPfSkAXg4iHkP/xU3uSkMoqRAUUHPOfbyM380
 UT7nRkVqJVicdjSjkPHLK18e8j89SH/N0Gcafx/gZlu4/g2ZoZCMTI7E2AMm+99fzaxxOYhkzq
 z+qJUhdUVVo8G3nTGgpOL2nuKEKKoqFus7rNljfxeD2VK9UKayoLhQkl0S0XtkqlVaKUC9Mhbb
 gyRomskntqdnQp1SznNV5UhoV2Sj31K60rFxRWyhyIPAdqFjfsNvS+nFcoZSiY0RnoU176jcU6
 lS/nNWBRa07DD7sKcitffoTcsn10bAN5Azziu/3+y/ZKhpxvAIAAA==
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
 Peng Fan <peng.fan@nxp.com>, Oleksii Moisieiev <oleksii_moisieiev@epam.com>, 
 Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713403963; l=8207;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=TRw0dfhK1hayMDFD1zxJgF7iuVtcqnFj8orxVs+mKtE=;
 b=uZJK7Ww9s8nzzRNRr6wGAV55H7SWDaLJ2Luc5qm2hFX1yatC+PCOorP2Kx1KmjbdMl/8+r0NK
 xl+TNLoacP9BSBX2FA8FZ6TubsBfrj6xkCMMB3bp177o/O03V9cAjav
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
X-MS-Office365-Filtering-Correlation-Id: 3b7b917e-2f17-4e3f-9d28-08dc5f464c4a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XxbDiEOmzqyF+K7sgmzzO6t9Va6vSArt6WW82n9bFu/x30zrsP49rTQ0C2Kt1pJT7cpEDndvjOZEl3RRDIZ611EcfFVEiY9IXSF//R5Bx5zYxgWk5yELjnpEIGAmKh7Oz296xvhqL6LmiRNCQYQISpbSHr4ZczNhg6U6gwgPWKqut3wiy3HfVqosyCCpGg3LH5mzazBwZWt3ZRSR2F76phaYGZtwb7RIZDRXweNM+zEsl60eSXgOm4G9gCr+VFpXNDFrfNFWtK5ZA8x8sAyrtoHKDEmcT6pN11/LUthDo5Z+tIk5nJP8pAX3qC590T3up3/kkgHcQGBH0vC+78m5KX9y2wYuexMryjWB29cjoupKV6mOQmQqedej3DS7RhfJcJDj/znCJivFeezoQR6ysjQlzyv0rjkGMcLosVWvIZoVuonVZcyOtau1qP0S9Gmgme7DePQII2jD+RU5wHjo8K8/U2Q525cgpDdHjr2H1nfhaw1mlMkiA1EiADj9eJzSM4claH+1mzg81uMMEYFduul2BNbZPtkKxOU4mmMtSdsK07J8UCAuIvVIimp2OGf+nrZFLX1ytyMuJhO5WkWdXyCb5OFVdR2YLq/0t1WyaCauEBuAXrp1WHdksd6XfFFQIRGqbyKs6ZOSjzPU7o/3pwCFWJnwKmXinjQ2mQtYew0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(366007)(1800799015)(376005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eitJY21FS3ZiTm13bmJ3cXNxdzZXd3ZYUGsyQXJuV0MvS1NOcm9lL2V2QzQ5?=
 =?utf-8?B?djZrNjA4WmZuYi9yRmNlTVFvdGdDUExiZ00rRnJLU1dkZUJ1SHBvK1B4MjZV?=
 =?utf-8?B?a0dnUHNkY09DejhiUE1tcStsZDgvZ1pxTXBMTUNnMHZmZ1Rrc1RKTzNOeEZw?=
 =?utf-8?B?QkZmVy9TcFdnYzdBSFN5QVpiVkhLRURtcXRxU2xZSFhiU3poWjhkMVRCVFNk?=
 =?utf-8?B?dkxqUG9wYzRNWTZTWlJBa2VEcW5jampIVlJJNEJoWE9iNEN0Z3NqMVQ0alVI?=
 =?utf-8?B?elBaYi9YeDdObEtkWEtvaWZuSGprUTljT2dpYjFYdFRRQVhLY2p3MHNUNHp0?=
 =?utf-8?B?RHlnKzBwRUV4b3hYajBIVUdlbW1jQ2hCNmRYeUI5SkZWK2RrWlIvUnlYbGdX?=
 =?utf-8?B?d29mQkVyTnBKd0tiWlZaZDVpY1hVVVNJUXkxcmp2TWVsaFBmWC8vYmc4UkNj?=
 =?utf-8?B?THp6UVBOeTE3bitMZ2p2SjZhdDNxYkg2Q2FpcDZQTDhxQjBrT2hBSDRDZVlC?=
 =?utf-8?B?bWRidGEycmNlM1R0dVk0d0hqcm83V2doVytBcGhNQTlJSllncThNUDlTVTBu?=
 =?utf-8?B?RzlMdlNDVDhZaGd1bFFVQnJFYTRMTjRhbmJJaENDRmdoYVBQQWFzeXVvMCtI?=
 =?utf-8?B?Umxyc1l3azRCQzdWRFFmcnRWTlVnOGZaUFdyQTVWTWZ6MTlhaDBlem55VUlE?=
 =?utf-8?B?eEtSUEFSUGJsMmNtV0ViSzFnS3pOcWtVWjBGbE1MM1VrOVVML1c0M2h3ZkZE?=
 =?utf-8?B?ZHdOSkJPNWNMdU1KcWFLTTNGcTF1UE1LTGF1b2orbWthQ3BwZnhXS01WaDd6?=
 =?utf-8?B?VmtvSGwzY1ZYNGI1MXh3ZktsUkhseEthdXFpMzJBUUZwbFVEdGtEY2VQSXpX?=
 =?utf-8?B?akp1Z0NoS1BUMFFxZkNNekNwQmczT0dieUZWcXYvbXRub3huci94aGs5b3J1?=
 =?utf-8?B?czI0T3JXY1NhUC9iQkFYTlY3WTROK3dOaElJRjU5UGF3cUliWGd4S1hiTmNi?=
 =?utf-8?B?eXpXb1ZSNldWUlBXUUhNcUZBamxXZzhjVlhPaFNOc2xNcXJYUEJqdmVIYjhn?=
 =?utf-8?B?UWFISzNBeVhUS2lsdjA5bnE4TFB5dWVpV2d4aFpCK0tVL0V0RGlselg1aGhQ?=
 =?utf-8?B?WFBRNXR3K1A4SDVkemJPd3k1SDBndEU4SmpxcE1UV0JiM20wT3Bscnp6UU10?=
 =?utf-8?B?YjBEWDdTY1Jhd3Y0elVBTDNUdVQzdS9PMG9zV08zV1IrZjRBZXhwZ29kV0pR?=
 =?utf-8?B?ZXlUUHVJYndKWkhHd29nZndHamVRQ3dneGVxOEh3b2pveWk4dG4rNzNYd3Jn?=
 =?utf-8?B?aG9zMStCbWtyZWNYb1RpUVg2TFRyTmpJeDhCRllBTVVnbUMzQTM0V1A0WnJF?=
 =?utf-8?B?Q0hCaFI1azhUQmVDQ3BzYmtINk1HQVZsQm5WRjNCWklvblJrU09rSU5DejhY?=
 =?utf-8?B?M3V6SWJhUmZoMGF3NDVZb0RPS25Rd3pHVm45QXpadkNCS3F6ZWFyQzB5MmMv?=
 =?utf-8?B?bkxlNEpjMVphenNXc3pFU3dxWGxZeGRWK2djb25DVEp2ekFuWU1mMURIV0Ey?=
 =?utf-8?B?T2M3YWpITEg2cCtpR0hzSUw2QWErQU1IWEdyTE1uNmpaUmJhenl2ZEtZT1d2?=
 =?utf-8?B?Y0ZtMFdCK2xmbGVDc1FPd1JMR29KdUxudFErTit6K0tUNWYyWXVOY2Q2QUVn?=
 =?utf-8?B?NU5kcDRQSnBDVEVPbWJTS2g0WGo0SnB5cm12V21ocHBMMVE1eWtqQXRpbE1U?=
 =?utf-8?B?TTRzTXNseG9VYlduakxtSVNoU0R2dnluS2hPemQ2OU55TitEWUdvOTJ2V2dC?=
 =?utf-8?B?OFBabE5PNnZ6QTdwTnZBaHA0VDFJaWJ4R3NLZWlTOGxuOUhrZ0VqbDNield4?=
 =?utf-8?B?THkrVjFSODRPblEwc2F4aWlQaHhpZEdZWTIwbUpFcEVtcnlkQ05GRVRYRTJt?=
 =?utf-8?B?MFcrbXkxbGZXZlozM0lHTUhnYUtOY3Y2alMvUWpwZ3BidWpCQ0k4RTJHRWtF?=
 =?utf-8?B?ZUJBZnRPdHlqT0hWb2NyanBXUGNPV1V5a2VBWWRDYnQrMU43b0dTVkNZTUFq?=
 =?utf-8?B?VzlUR09MaVNBcHE0VG9WcGpDMUcyY2dlOFlWci9Na3oyTVV6bnpjTE14RzJV?=
 =?utf-8?Q?vW/mJj8VgIbyMLAD+OXbEXlJS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b7b917e-2f17-4e3f-9d28-08dc5f464c4a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 01:24:31.6751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C/bzHGrZn0repgqxzSJuGrAiQvnOPk6ajfOoM1u327iNpYn/a3FdoxHNBgyQ7hQWTiw7gMdeQ05c9bOG3UJHQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9264

Per Sudeep's reply in v10, 
"This series looks good overall. Since it has pinctrl driver, I need Linus
to ack/agree to pick the whole series up or I can ack them so that Linus
can take the whole series. Either way it is fine for me."

v11 is just minor update per Andy to patch 4 and Andy's R-b applied.

Hope v11 is good for you to pick up.

Linus, would you ack or this patchset go through your tree?

Thanks.

This patchset is a rework from Oleksii's RFC v5 patchset
https://lore.kernel.org/all/cover.1698353854.git.oleksii_moisieiev@epam.com/

This patchset introduces some changes based on RFC v5:
- introduce helper get_max_msg_size
- support compatible string
- iterate the id_table
- Support multiple configs in one command
- Added i.MX support
- Patch 5 firmware: arm_scmi: Add SCMI v3.2 pincontrol protocol basic support
  is almost same as RFCv5 expect multiple configs support.
- Patch 4 the dt-bindings includes compatible string to support i.MX
- Rebased on 2023-12-15 linux-next/master

If any comments from RFC v5 are missed, I am sorry in advance.

This PINCTRL Protocol is following Version 3.2 SCMI Spec Beta release.

On ARM-based systems, a separate Cortex-M based System Control Processor
(SCP) provides control on pins, as well as with power, clocks, reset
controllers. So implement the driver to support such cases.

The i.MX95 Example as below:

Configuration:
The scmi-pinctrl driver can be configured using DT bindings.
For example:
/ {
	sram0: sram@445b1000 {
		compatible = "mmio-sram";
		reg = <0x0 0x445b1000 0x0 0x400>;

		#address-cells = <1>;
		#size-cells = <1>;
		ranges = <0x0 0x0 0x445b1000 0x400>;

		scmi_buf0: scmi-sram-section@0 {
			compatible = "arm,scmi-shmem";
			reg = <0x0 0x80>;
		};

		scmi_buf1: scmi-sram-section@80 {
			compatible = "arm,scmi-shmem";
			reg = <0x80 0x80>;
		};
	};

	firmware {
		scmi {
			compatible = "arm,scmi";
			mboxes = <&mu2 5 0>, <&mu2 3 0>, <&mu2 3 1>;
			shmem = <&scmi_buf0>, <&scmi_buf1>;
			#address-cells = <1>;
			#size-cells = <0>;

			scmi_iomuxc: protocol@19 {
				compatible = "fsl,imx95-scmi-pinctrl";
				reg = <0x19>;
			};
		};
	};
};

&scmi_iomuxc {
	pinctrl_tpm3: tpm3grp {
		fsl,pins = <
			IMX95_PAD_GPIO_IO12__TPM3_CH2(0x51e)
		>;
	};
};

This patchset has been tested on i.MX95-19x19-EVK board.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v11:
- Add Andy's R-b in patch 4, with minor updates per Andy's comments
- Link to v10: https://lore.kernel.org/r/20240415-pinctrl-scmi-v10-0-59c6e7a586ee@nxp.com

Changes in v10:
- Convert the SCMI -EOPNOTSUPP to pinctrl expected -ENOTSUPP, see:
  https://lore.kernel.org/all/CAHp75Vch7TzevZQK4CE_WSVOgUdzODkJXiv0=OuqrmDfgevV+A@mail.gmail.com/
- Link to v9: https://lore.kernel.org/r/20240412-pinctrl-scmi-v9-0-b817344d3a9a@nxp.com

Changes in v9:
- Rebased to next-20240410
- Because "pinctrl: pinconf-generic: check error value EOPNOTSUPP" was
  applied, so pinctrl-scmi.c not convert to err return value for
  'pinctrl_ops->settings_get_one()'.
- Add R-b for patch [1,2,4]/4 from Dhruva Gole
- Link to v8: https://lore.kernel.org/r/20240405-pinctrl-scmi-v8-0-5fc8e33871bf@nxp.com

Changes in v8:
- For the devm_x, I still keep as it is to follow current SCMI style. In
future we may follow cleanup.h, but it is not this patchset's goal.
- Apply Cristian's change, and add tag
- _pin -> pin to drop underscore
- Add headers per Andy's comments
- Drop casting for func->groups
- Minor update for coding style
- Link to v7: https://lore.kernel.org/r/20240402-pinctrl-scmi-v7-0-3ea519d12cf7@nxp.com

Changes in v7:
- Hope I not miss any comments. If any missed, please forgive. Since
  i.MX95 SCMI firmware not support all the pinctrl features, I could only
  do limited test.
- Version set to 0x10000
- Drop scmi_msg_func_set
- Use get_all to replace flag[0,1], not support flag 2 as of now.
- Add settings_get_one and settings_get_all ops to support get_all[false, true]
- PINCTRL_SET_PERMISSIONS is not included in this patchset
- Bail out if nr_pins is 0
- Add check nr_functions and nr_groups if they are 0.
- ext_name_flag changed to bool type
- Drop unrelated comment
- Use a central function for pin request and free
- Coding style optimization
- Use pinfunction to replace scmi_pinctrl_funcs
- For the devm_x APIs comments from Andy, I not update in the x/arm_scmi/pinctrl.c,
  because it is correct usage.
- For included headers, I keep not change. I try to follow 80 max chars
  for scmi driver, but with a few lines still exceed.
- Link to v6: https://lore.kernel.org/r/20240323-pinctrl-scmi-v6-0-a895243257c0@nxp.com

Changes in v6:
- Update pinctrl driver following ARM SCMI 3.2 public release
- Addressed Dan's comments, and followed Dan's suggestions, thanks.
- Dropped R-b/T-b in patch 3/4 and patch 4/4,
- Link to v5: https://lore.kernel.org/r/20240314-pinctrl-scmi-v5-0-b19576e557f2@nxp.com

Changes in v5:
- Rebased to linux-next next-20240313
- Link to v4: https://lore.kernel.org/r/20240223-pinctrl-scmi-v4-0-10eb5a379274@nxp.com

Changes in v4:
- Rebased to next-20240222
- Drop pinctrl-scmi-imx and compatible patches in V3
- Add T-b and R-b collected from v3
- Link to v3: https://lore.kernel.org/r/20240121-pinctrl-scmi-v3-0-8d94ba79dca8@nxp.com

Changes in v3:
- Add R-b for dt-binding patch
- Use 80 chars per line to align with other scmi drivers
- Add pinctrl_scmi_alloc_configs pinctrl_scmi_free_configs to replace
  driver global config_value and config_type array to avoid in parrell
  access issue. When num_configs is larger than 4, use alloc, else use
  stack.
- Drop the separate MAITAINERS entry for firmware scmi pinctrl
- Use enum type, not u8 when referring the scmi or generic pin conf type
- Drop scmi_pinctrl_config_get_all which is not used at all for now.
- Update copyright year to 2024
- Move the enum scmi_pinctrl_conf_type above pinctrl_proto_ops for consistency
- Link to v2: https://lore.kernel.org/r/20240104-pinctrl-scmi-v2-0-a9bd86ab5a84@nxp.com

Changes in v2:
 Added comments, and added R-b for Patch 1
 Moved the compatile string and i.MX patch to the end, marked NOT APPLY
 Patchset based on lore.kernel.org/all/20231221151129.325749-1-cristian.marussi@arm.com/
 Addressed the binding doc issue, dropped i.MX content.
 For the firmware pinctrl scmi driver, addressed the comments from Cristian
 For the pinctrl scmi driver, addressed comments from Cristian

 For the i.MX95 OEM stuff, I not have good idea, expect using compatbile
 string. Maybe the firmware public an protocol attribute to indicate it is
 VENDOR stuff or NXP use a new protocol id, not 0x19. But I think
 current pinctrl-scmi.c not able to support OEM config, should we extend
 it with some method? Anyway if patch 1-4 is good enough, they could
 be picked up first.

 Since I am only able to test the patch on i.MX95 which not support
 geneirc pinconf, only OEM configs are tested in my side.

---
Peng Fan (4):
      firmware: arm_scmi: introduce helper get_max_msg_size
      dt-bindings: firmware: arm,scmi: support pinctrl protocol
      firmware: arm_scmi: Add SCMI v3.2 pincontrol protocol basic support
      pinctrl: Implementation of the generic scmi-pinctrl driver

 .../devicetree/bindings/firmware/arm,scmi.yaml     |  50 ++
 MAINTAINERS                                        |   1 +
 drivers/firmware/arm_scmi/Makefile                 |   3 +-
 drivers/firmware/arm_scmi/driver.c                 |  17 +
 drivers/firmware/arm_scmi/pinctrl.c                | 916 +++++++++++++++++++++
 drivers/firmware/arm_scmi/protocols.h              |   3 +
 drivers/pinctrl/Kconfig                            |  11 +
 drivers/pinctrl/Makefile                           |   1 +
 drivers/pinctrl/pinctrl-scmi.c                     | 571 +++++++++++++
 include/linux/scmi_protocol.h                      |  84 ++
 10 files changed, 1656 insertions(+), 1 deletion(-)
---
base-commit: ec3243f13db334437b5ce253be2fb23bcf35b490
change-id: 20231215-pinctrl-scmi-4c5b0374f4c6

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>



Return-Path: <linux-kernel+bounces-154426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECD78ADBF6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 04:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECE95B2198E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC291B96E;
	Tue, 23 Apr 2024 02:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="k30EU/Y4"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2052.outbound.protection.outlook.com [40.107.15.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43021B962;
	Tue, 23 Apr 2024 02:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713839391; cv=fail; b=WEIUigDkECFWjJ+LiAWh/Dzy7h/vZusMqZJzdERGWgyJOjdwvooLuDWbPdLsgSddCNwWFT7vKsfFqp24EvqEtSLiAYUX1hZCYtIAXkVv1of/8yg3+N2L7ppcShMPGIPB66TKF+cFevhTGbAOcjhl8agpsrlT9WO5Ha/rg8I3xcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713839391; c=relaxed/simple;
	bh=NW7IFkBv6VkP5jKrsh7JttsEucP8U3rJ280cjRpHDc4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JDFOms1Wk2ac9Hi36ukRAOViVqFfLXLz/ovoX130kokL8GEDGC3SHr1NLYw9UfVaBu1q4bLDY/8en0PYp2FxG/m2eLO4GWNIzAOlPvXasxJqqRH/1Bm0eIMue1ZZVGqM6ZW1Ajn4FuJfU5bwuhMnjlQrxu0FqN8zzwcoAn12OPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=k30EU/Y4; arc=fail smtp.client-ip=40.107.15.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HPiEP3V6cQaYnn1O3tqLQ0fNXszHAROo1lQzl3vAP7XmO4uAs/jExfEssPoIk4Q+WyjJvnU22k9YSdOAQSa7Y4p30s0IzT5CKgNjOzgmGPaBdiboWfJVrJf2l0ajmCgMe4u1T2SGQOPmaXcE7KMktIGjvRMm/c7lcaDvK5DN95hwgECSEDe7YJL6GRVFY38QrQvOxpHmyrZlntBNAxI6iUlPgORwnGTdty+OWB/cdbmui4zNx2HpVYDOtAQytQn4JBOHhaKNmj0CUN9bfXgCjaNeIqU2V0HqWHQFL86qO3nLIutrQxN9GEg5/2idbjEKyhWeEln7HCmTxTLfDUX95w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ap1p5grG5Ax2dToarEeofYR5wa/E+EEpzEYxfkIEeGs=;
 b=ZlBPUdQV6XB7Y0UJVZ3/JxdxgNpQrE29r9opoBNA1n/MDHerVGJK7GGOuEdNMtD3KjdxDz9vy0J0d0q4BwUDPdM+BJXsAd5e/oCXXO/FxE78KyTYvm3IpH4Ji3gjJzNpvhVG1/cTEi3b+XJKlgQjZGO/c4mxF49wBqKl/BfZQO6H6otTVXYqFDKoL0wg+yzvrgXkmmwVPAxaybVYf0yKLDOQvOHssLiIyGJ3Ofm+gcW+apzszlGJ6KhGUmHXbLMxOTLfy/4VDTmF1AL9MAMwhqhtkW3/95K5kP5nl+t9cdqMpmsLlGhp3yP+5ErY0DG+z6mau46hEACtw5fzLf4BFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ap1p5grG5Ax2dToarEeofYR5wa/E+EEpzEYxfkIEeGs=;
 b=k30EU/Y4GYXC5Jo4mxTZiSWPcNgPqqQ8Qesxg0ifUVzXBrKznr7Suuqq9RWZtfUwy0GlMm7zBD+wLTp893PSNDJSUa103Kx2I2j5zw/yE4q2MaThILBsYNgYigXXmRtpF7uANRI1aMZDmY4ZlLWnus1jYgmym7UdnZtbA3ODBoY=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by VI2PR04MB10265.eurprd04.prod.outlook.com (2603:10a6:800:221::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 23 Apr
 2024 02:29:47 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::2274:2bca:7778:b464]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::2274:2bca:7778:b464%7]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 02:29:46 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Brian Norris <briannorris@chromium.org>
CC: Marcel Holtmann <marcel@holtmann.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Kalle
 Valo <kvalo@kernel.org>, "francesco@dolcini.it" <francesco@dolcini.it>, Pete
 Hsieh <tsung-hsien.hsieh@nxp.com>, rafael.beims <rafael.beims@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>, David Lin
	<yu-hao.lin@nxp.com>
Subject: RE: [EXT] [PATCH v10 0/2] wifi: mwifiex: add code to support host
 mlme
Thread-Topic: [EXT] [PATCH v10 0/2] wifi: mwifiex: add code to support host
 mlme
Thread-Index: AQHakXD8ZSzvjLENHE+cjdiIi3WD9LFu+PhwgAEpDwCAA9ThQIABL2MA
Date: Tue, 23 Apr 2024 02:29:46 +0000
Message-ID:
 <PA4PR04MB96389E67F826216C44FE19FFD1112@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240418060626.431202-1-yu-hao.lin@nxp.com>
 <0ED16BAB-6E7D-487C-BBCA-E63FEF37C60D@holtmann.org>
 <PA4PR04MB963815B9FDA6119683A28CADD10E2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <6CB59E09-F34E-4986-AA88-8EC4EE5E71DF@holtmann.org>
 <PA4PR04MB9638B62BC25F773C6922A4BCD10D2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZiLlPOvKlfCySZwF@google.com>
 <PA4PR04MB96383D46C1187C237DFC7988D1122@PA4PR04MB9638.eurprd04.prod.outlook.com>
In-Reply-To:
 <PA4PR04MB96383D46C1187C237DFC7988D1122@PA4PR04MB9638.eurprd04.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|VI2PR04MB10265:EE_
x-ms-office365-filtering-correlation-id: 6086229c-47bc-42ba-c057-08dc633d3e30
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?TPvyPXGtJ6W7Rco3f+jMp0luMb6yseODjGQLOEAXuHbKQJtqna9TaQ+olMtt?=
 =?us-ascii?Q?xdWkslwID2kpKDp49QWIh0VNVfqkrjkKlPZ4I7gqbo0StaImIKMwD2rKyIL6?=
 =?us-ascii?Q?qozo9e/VlQ77xn/3N3IjaKBpyRv7rqhEf1JhjeEtrn62NtrIAPo9wZgsNmbt?=
 =?us-ascii?Q?NkkPfP00v3S0Nf38wc9r5Yux/jWcdYshLLvU3htqsN20XB7fADnJn37JvkID?=
 =?us-ascii?Q?oxLo3p/T9j0KXkd299y6fzrY2umShCmX/jGxH1Dp07O8aJmSUaDrIP5Jpr+6?=
 =?us-ascii?Q?awqIfeeHwE91du2mH0WmV7ZRrH4hdV7wJ/x+Ef6tWy2CgVWiCsEMxUa1GhpV?=
 =?us-ascii?Q?kBc18k5YwrpY8TxbyYYGcQv5bpCrGkvxx+ZHJI22qECgKmGNaB4e44zQ0b0J?=
 =?us-ascii?Q?aWdMwtJiir2scTnbQDwj5llWkXClcQOoYMRsXeNDUjUuRM2PgfzKKypP23O2?=
 =?us-ascii?Q?ko9tAz7m52XVYhFGh2ZaozbulaLjSQF+e4dE6cce2X+ibdEZ/1TkUJUw1XTT?=
 =?us-ascii?Q?FOJehsm3STYQN8GgFQjoNNf9ZZD3328OJb2MZAAWBx2GwroMIXu4KabFVgKP?=
 =?us-ascii?Q?i+wPHXI/UV9ORGaP6ZPYglbUeqSKyPxfHS4WmCtJzeP+yG5F4yu7C4NHnEPT?=
 =?us-ascii?Q?MCSjPGr6uS2IV0JdSZG85y4r8gILPQCxgYW9x7OniazMD0uGaDDbwktNF8sy?=
 =?us-ascii?Q?FJ6cXrU9YM8wHqoLcd8a2EeTeN+82RzIloxZH3GaMLGyBqH7N/WspCowkZT5?=
 =?us-ascii?Q?9pzdtm8Qz3n4UKUhW88sd4D0pgTCpI2Z/+y4OLld9EMfGRhhFueNaaBwhLHZ?=
 =?us-ascii?Q?ZZpbrvX8qfvyq0KL5WiKiHWaChi6WtlafGEGwtJRo/RIBSK0HfYUnJnMtN14?=
 =?us-ascii?Q?2LQERJG2gNdFuy/VI3IBRE/jF/Bl+ulnKinzgYqScGnBIyI7XBPwRQ1g76aZ?=
 =?us-ascii?Q?PvZN3cZEfnkbKh2t8axvUvuIz/Ew6uYDMAIhsZDI0ZWrxTXXFlC8A+N7tuTH?=
 =?us-ascii?Q?eFDI9jp0UThuoAX6IxcIP+qZy2a6XmVIFd7r05FOwCWvhRgANKJv0VKPWag/?=
 =?us-ascii?Q?87kXvhaFXObbYvaPdkbao9rRq+dEf00JLCwSWaguGLf0X6HDbwGxm81pzKrJ?=
 =?us-ascii?Q?6rDGhkIvJVDIv58D1aK97hxWHyluchMsvI8KlMcTOF77avaoAdPsFz71mtrt?=
 =?us-ascii?Q?ytPvek71SRAMRKANZ37MaREmAe/nvbFl+KQjzTTLMXum5K9wjOILAY86Tp8p?=
 =?us-ascii?Q?HDV3tqMlZj9pL6hWiQ2PYa60p89ozVlNj/zCdHucj1BwWMI8MqwO6ZnjiEXF?=
 =?us-ascii?Q?H8MmaxNgyRl6DC+MSXLI9LbhdTv8a8fYkBsPBEqp3obfpw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1G5lV4Gif2Gd2HJVVLXbjfKQrnJ0smOLnOAEZcw5KGRodmLBCFspi8QR/s3Z?=
 =?us-ascii?Q?2NexoN+59DRvxuJFpmrdXHVikz0Pe1wolvlES+UxiLF/Hjvj8XbPCp+FTT9j?=
 =?us-ascii?Q?Lit5ysJzw5kDxBDTsp4Ls9N0emG5cj/rBoEJ8Py6NzC5BfWjWCOI+acaAi+7?=
 =?us-ascii?Q?AArKnkRabHjyLimGfCeTEdbmB6mbByuV1wqJ+dBEmB3Q37u7a+D5wT8Y/EYB?=
 =?us-ascii?Q?E6LztLaPlWqTSMW9lLjkNo7BygNdlegNsz74SPVXujMUsYSCyVNDI7/R5rgL?=
 =?us-ascii?Q?951rW/rULSOxejulfPXnBIBj44WkNs5Bkbl+YeYzM/BpORwocTQs4IQJTUAg?=
 =?us-ascii?Q?CsYn4bgt9ZatJmn9Fq8LlO5negmXUF972Tog0bDuDSTeo8adRZgugPenp9yU?=
 =?us-ascii?Q?81w22ziDCTA/lEdWd++UVdeTy4nHe8SWgR6L86mzmWAlwWAwrHMS2SjfDI4k?=
 =?us-ascii?Q?11/CyTbALmWMtcvyN+QS7+tsfPi4RpJy2Rf8GbiM/JiQVbKlYC7/fbk43XxU?=
 =?us-ascii?Q?QqJ5NwihOVvlN1EajVPTE0gNLXlUIlrMAm9YOu5dFBvnqqOZl59T5+LCClkd?=
 =?us-ascii?Q?xf0ICJQ16KkzCiqpUJplYBJWyWY8+XFtUywMIF7gb5eAnMp7UIziBIkQ37nL?=
 =?us-ascii?Q?Y7dUBlaJwn/goDNqBlPSGzEVpnTTWOh38a8MS2O6yTkwD33LXylmUpHxGTzl?=
 =?us-ascii?Q?5SNz9eM0qpy8/93xY+hW50lfgQnVV6aKGzAbolD7KXivzZMVzMn4kf3dz2qq?=
 =?us-ascii?Q?sHTPtTxO4UEFrLFU/cc97jGE0LUCXy+tCUDG9VMK/3kZvDXRavSl6v9aNUNX?=
 =?us-ascii?Q?A6BF4CEaqOYXTg+8Ll5t5eI0exH7R4rC5mSIfVA5oR2BwC8gEoZAZuK348bG?=
 =?us-ascii?Q?kun7yKf5o14Awc8yNs1ZeAXjo0oekT2ti2FOMdzEndbMiJ/Rw9rrS0SZFQQN?=
 =?us-ascii?Q?BLNpCK9crjbUN0f65KDcts2CleM7VQO826a7jbQnePNI9Le1cG1m/o+hmDxh?=
 =?us-ascii?Q?KnHGOtZOAUKzlOgFEpokXFRTbrFOD2h4aHVgdwD6dVue3JfqKWXdIwlWKGAX?=
 =?us-ascii?Q?FdA2oFS0cvpwm5MBSx+TT8VbZQQycZukqBHHJ4M4HbqzB1d/K82cE2C+o+md?=
 =?us-ascii?Q?/XlUk0khLexKYbKhyarO2BOD5DEIwZln4miipHNsu36T42cHIR+s8dPEQGJa?=
 =?us-ascii?Q?9qWmtX8zsm6DaEsNylQtu5BqNEIP32v7P3M6fcce2iEXtchsaF5ihGDEdAMM?=
 =?us-ascii?Q?hylgfODtc80k8en4uuj4qYv9l1ESeBmrq6XI6zEi/+FT8PMrDmH6rdfGskG+?=
 =?us-ascii?Q?8gX3qxzZmCh6QyCfWxoNIW1G1XvaXS0Hk+z9H3h1cGfaKz5tLjhpXDyrzFqo?=
 =?us-ascii?Q?9WSt1sMi39pQ/cGI3Sy9+dH6P+HCIRclVTX1Q4hsL1/vqaDryUlsULc9ooNo?=
 =?us-ascii?Q?z7b3K/cHC9Y+aL8JNzEl8t4ASRqKpM86ZBtu5cTGEFnYRJUbEODaziLN1Q2O?=
 =?us-ascii?Q?CbDyFmz04V3lrE4kLst/eMvF8t3SDXI2wk5mhhQpOwg0zK1s0QNRVZgr8M2s?=
 =?us-ascii?Q?cbs6oR0GPEWPGXlbUKpwlQeYZyxLdWYzDrbDFH/0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6086229c-47bc-42ba-c057-08dc633d3e30
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 02:29:46.6738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UT4JQegTx6JbhIfst9Vc8ZB3cdkOMLLCgAHYcq42bUsv3U0WI3Q5QHcgqlRV3SiYXGM7vZMc8dSklY2cnAkxTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10265

Hi Brian and Kalle,

	Johannes agreed that cfg80211 is the correct way for the development of mw=
ifiex
	(mac80211 can't offload association process to driver/FW).
	This patch is used to fully leverage SME of wpa_supplicant and hostapd whi=
ch can complete the missing WPA3 feature of mwifiex.
	The patch series had been reviewed and discussed. It looks like there is n=
o more comments for patch v10.
	I wonder can patch v10 be accepted by you?

David


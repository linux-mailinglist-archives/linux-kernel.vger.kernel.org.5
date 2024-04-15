Return-Path: <linux-kernel+bounces-145832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D468A5B98
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB2EE1C23352
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F251E15E1F2;
	Mon, 15 Apr 2024 19:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="N5XX48oT"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2076.outbound.protection.outlook.com [40.107.105.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7CB15D5A3;
	Mon, 15 Apr 2024 19:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713210430; cv=fail; b=QN3EF8aiOnrJ9h+ErOPwnCZWoHIcZ8T5UPBFSGP78ba9sdfeEi+zT3uzqy5wJ24HbSByYmQpe3whSiRdXjwseEUaY3d4N7e07gSS9+EIpSIvEcyIIccPWg6WSzKVupaHWQk/YHCiHm2ENl0BmyDuGs4BhSfu4g7aC5jELu7Dp/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713210430; c=relaxed/simple;
	bh=Anf5/cBCqL2nH+zYCUD3DObM7bD8CDoVdBveSiz8u0s=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=OIrcc89I/xjLIznUrAFvWUxwg6TyRUr79r1XuMFGoPxKe5hlqCl7dQ9MygCoWh7nOqkl1O/GMRafnp4lNn416vbS6tu/qexBopHCUi/cdMhzztHIQyczxypLxx+pJ7Gp03JBUrfJJ8epW6d1Sxi1VJ+Nklmvua6iaTSamNrj64k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=N5XX48oT; arc=fail smtp.client-ip=40.107.105.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKbFjr8YHenCPn/hQkjDbORtnPGQOjxywc40/j6JxtgPQUpptvUN3HPnwWgzP0E3/8EYAwhknuNiKA1vnjTy0dV2dEhE61K5bF1JzYfXeG4joR7ROcAQZHoQHBVf+sDcPNpgx3OpHhqeJAIF3kLvs4Trvr02BF2xfHfc0X+Ho4UCaQbrSVqh6OCbVMpCrBk4AQ25zw2pzi/9OVUqnJwg9oAt/v+QNs0dRr1SJBNvlwLni+y2Rby+qxeYeoy3Mf8+bnR19jDE6lISonWQejkhLk96OHfKS+oFvAwr/ZD/AWzNozq4aCjV5VNsneQ1ASUTCmq+ADMCaY6GeGfAQWoTkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSjCqqd+Vrp4x4jUtklycv3HmWHkcAADRrDv+UEVxvQ=;
 b=CSf2AiYBczUOVkTmbA9olu4X4mQJtrNICGTOBRtR2erQnvWOQMQxh0fU961AzemZ6SCxtHTeHGVN84/AWCEEIUSZf+uIVKwWCsBImaxcEck15gl6hi5+v3DZLXrX2JO/Tk0qmXdsQkLDvABQu/RqPyuA8HcohcbljytpV0aGOj4lplpxWDafwHbNX+NGeqfDpOnJUS5G7OSfwmk51O3WfTDA/pVhBUfSymEaDyv6lK2+qygBr7iQhSim5z4UZVNeV0sS01fgq1Q2ZZf7vcSJcP8Gok1D9dhac3LwgGnD4XVgj2x9AO9NSWqh5y54Zz++dyE+1bHUakEhV6Oc+JQGzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSjCqqd+Vrp4x4jUtklycv3HmWHkcAADRrDv+UEVxvQ=;
 b=N5XX48oT4DqYQBEj+RAOPgxfS0R1amm43uHquoBeUs8LiHMyINDA7haMwdAl0Rdp80Pw3xN6E/ax8sduBTzpsj/Zlejdx7n/zTUKZlHatmKtYK4i5EiD2ivzM5y4Pgbd0Y8vhpzYdd9/p4mYmJLD66uHDGhsWxR08igNTyLnS68=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7290.eurprd04.prod.outlook.com (2603:10a6:102:82::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 19:47:06 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 19:47:06 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 15 Apr 2024 15:46:37 -0400
Subject: [PATCH 01/10] arm64: dts: imx8-ss-audio: remove memory-region =
 <&dsp_reserved>;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240415-dts_8qm_audio-v1-1-2976c35a0c52@nxp.com>
References: <20240415-dts_8qm_audio-v1-0-2976c35a0c52@nxp.com>
In-Reply-To: <20240415-dts_8qm_audio-v1-0-2976c35a0c52@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713210420; l=757;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Anf5/cBCqL2nH+zYCUD3DObM7bD8CDoVdBveSiz8u0s=;
 b=S7CXjgH8mrqqkHseHYg9A92vTWFO8v1VRfX/bIHWjUSNeO9OsjFOMxeTgcp/JRUmZ2fIj/HbB
 /z4t8zyW17gBU/iptMWVUOERbP4H/WdPqLUR40wo0kCdwnOCCQs0//v
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR05CA0061.namprd05.prod.outlook.com
 (2603:10b6:a03:74::38) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7290:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cc412d9-181e-4321-8a1d-08dc5d84d4cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	e4w4AVxoibd7gA3wFwxtdhdcYERiKvleS+LpM5iWUiaXaqrlftL8Ioozi/0YvE9ZnOQa1P5Tvw/QuHwZjs0d7rnQxW7AxRnObXmEWNNLiow+IKgmgzbewdJimdLGK9zUouRLbUcmWv01+jHjKCplUa3aUWmf99l1nab8EeGYdHYhCR0oPbl3nRrZHfwvrszSnqxSVdszFfnvBpJbb15nwefI5qKgFJj8Rre6rWQJrv5H4fk7Hnp/NckZFqZsKXoT5tgJGrMF3AkmhQzBP6mT749GcB5FtI4902bkVJ8JCwzXp6WVO4bVMIyczf0bZ9+f0hNhqUQFDMdImZRswOjWja7MZfjDUbdgs+gRVD/snZkk5Fho7sRgGncNYDsTqugP9EdA7Mj0FkXiam2B5IoRXGz9PDjkS2UA/7gHoxuNv2iihcL+0vJsHYN5OqzAksZV04la3qQWXIJllc47vIyzf5NmyRYhmAFQ/hb21dHk4GCJWytInzRlKTwIqofMBULE3yLAz9SBdWqDrugCHU406my+pQur5U7Wp9hlx6nNndkl5Tqxm23JxaUpuuCRzrJ8SKlDSCGo6jNWZHgYzsliy96oRDRoWEhkp78mNVzcceoYJHJvgDjBq4oTWGwisMUdPG0BiQIOhjx8ML7pLODSiRysxN7dG8Oe4Xyqm8WL0YbYvyJ6pHfWbuRhdf+OXkzmbulNHlYvhdcwxAzCnOTokBf1vICsGNtqyshOt2MkK54=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2hQOWg3VWdoYlFPZnYwV1pYbU9XdjR4MzUxcDU0bXczNTVOZVJUcG1ldWxD?=
 =?utf-8?B?QlFTUnhmTW9QSTR2WmpOeXl5MTFqNTAzZm94ckpQUmZMcW9YdC8xTXlhMmNh?=
 =?utf-8?B?b2RTZ1NwMktTby9iYjlSSU44N2duemZQYkFwcStYUTlrRUh0OWpZOGs0cllD?=
 =?utf-8?B?RHZLWnZiQk9VbTVHSHE5V0NJa3NrNXhvNWFvS2JjNmI5Zy9wcU1DRG1mc3JZ?=
 =?utf-8?B?MHdSdGt5ZTJRZ0ViQmdnUGdEY2ZmTlY0ZWJIbjVFWGJYdUErR3BSd2krS0Iw?=
 =?utf-8?B?N3FQakhTTktoWUNqa3lxRW5NakRuTjJlZ2N5cjFYQlg0UmFLYkRVYjBhSjJR?=
 =?utf-8?B?WnFIUk9WVlNlQWx4bUV3S0U2aDA0YUxPTUFlOC96TFozSDhVYUV0MTg3RWMy?=
 =?utf-8?B?S0F3YWsrblIyc3pJVWY0bzJYUGZCTmpaclFNS2dtYUV6VHhrMGRpZjIvUG5r?=
 =?utf-8?B?ZG5ZaW9ibVZvclhXOXJoeVhqcFZveFA5S2pJNk1sWmNaUVhpSFI4NUVVV2ti?=
 =?utf-8?B?NUh6bEw4UTdaU0puQ0dOMysyc3JsMk1lZnBNTW11blJPc2xIYU9KTWZDTVlq?=
 =?utf-8?B?UTZ3YXhsK2dOVXp1S1ordUlTNDZVUHJVTlBWdlNUTjhpcmJFemUwdWs5ZTNs?=
 =?utf-8?B?ejg0OTIzT2lTRkV6S2tGTkJSTW91VCtPSjVkRnhCMUFYWkJoZmJCdEx6SWdD?=
 =?utf-8?B?ZWVGSHEzdHVYQ3paK0tuZWJSWGNhS3JDUUtidGl2c3NzQ2d1eTRveU9GZDVr?=
 =?utf-8?B?NUJHcHUwR3JlTlk1V1p1TU8zenJnOTZZWlhUVFY0aktEb3dNbGtXYXNnemVy?=
 =?utf-8?B?VmQ0VEltOU1TRW1FSnFKNm90UG1CVC9Jejd0ZGxvbGNQeWRCTzk1ZC91S09V?=
 =?utf-8?B?QkxQSHBVbDEwKzNTamRHWURuTE5QQmd3d0puUFU1Qm90dElaUnZaSmxSUzFX?=
 =?utf-8?B?c0FxVnpPek5vdlB3S2luY2ZReHlaK0FKZWpZUzFObVV0SE1JT21rM0ZrOWpB?=
 =?utf-8?B?VGhEMzc4VWM1RTZPM0MwczNVYU1jZUVWbk41MnRMb0xPYXJJUXh2dlBralBC?=
 =?utf-8?B?cVlud2xDbitiWnhTWVdFYThDSWRUOUJRenRUTXlaNnY0UVJSaU9JL1F6K1p2?=
 =?utf-8?B?STZWT2RsZjA0ODNmUEx5T1ExZzBHTG96NnFvRCs2aDR1TzBZamxnaCtOaUNC?=
 =?utf-8?B?MmZVUEpQOXFNUnludlBSRVhWbjJzenRzMllTNFdlekF6VHE2MzRkV1NDM09L?=
 =?utf-8?B?SndsRllkVzF6RVVpVjljM2tobnp5U3kyUFpjaFNLVCtVTzZLZXU4N0p5b1Mr?=
 =?utf-8?B?VjJ2MFFrOFNxUzFxUGhJMEpjcmIzTStwcElaaFNMa0FiaDc2YkpLeEFQUFow?=
 =?utf-8?B?UDNKeHBKbTdmYjJKOVNBV2tlQkpweUpSV3FIMWJEd0w1c1Fyb1o2VlcyWjFZ?=
 =?utf-8?B?NzFjb2VCQXQzL2oveHg3Ym1PWWVPTE1ZS1hRNjQzeis5eE5WRHhLRnBZZS9V?=
 =?utf-8?B?aXUyUGhrUDZsaFd1VTRCZWpreWJUN2FOWFpsL05KQnhQa1VFTzBCK2E5RzBk?=
 =?utf-8?B?OWZIemdXQ3F4UjlZN1ZaY3pZQXR2eXdpOFJQL1ZjNnZnU3lja01JUkVFOGs5?=
 =?utf-8?B?dUMrUC9Sd0xRbk9GWGdYSlJqcG9UYktNRUZBVVV0VTZVM2dBQ2kwQ3MyQVVy?=
 =?utf-8?B?ckxhdVVKN2JyR0Z1YUVnZXN1RW9KN0xtcHBTOG1ybnAwZlM5cUZJWWlhcVJv?=
 =?utf-8?B?WnpwdE0rdk1oMk0xTlVuVGlxNXdsYmNTbzJwNUE2dTFraGJWUDlxdUJXS0tW?=
 =?utf-8?B?TSsyejBnSHNZTVhHRk0zaFAvUkNHL0pNVGNoRENjdXVkSlhzMVB6UTRyNWhw?=
 =?utf-8?B?cmNqQzREMkROd1U2SU9mcG1jalpzaGRhS2xnUVl0TWtRbmhJZS81ZHFYTitq?=
 =?utf-8?B?SFJCZ1NMZmtiSm54SVIrZHRjbWNkOGxEOHA4cTlkcjNWdlZ6OWF4bWhDOEx1?=
 =?utf-8?B?eitZYVJyYngxTnMvMnZTbWtWL0ZCQlltMTRzSFFsVU55VmRGbWJKeC95S1Qy?=
 =?utf-8?B?ZHUyM0VWQmVURnZmazZDbE9GQmN5OHQ3UXh1Rm15b2loUnRhbU8vQ0JqNmJ5?=
 =?utf-8?Q?WkmFAZpPOCmer2Vp7HyeBkNwN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc412d9-181e-4321-8a1d-08dc5d84d4cd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 19:47:06.7927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j4GRjbzvIj+avhifx3lXFilZZytC4LgixgVgWSpyfw64auzvUhbJWgFU7PCHhCYsmftERt/5zpDIQJ5Fl4sBYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7290

Different boards have different DDR memory sizes and layouts for reserved
memory. This change reduces future dependencies to add 'imx8qm-ss-audio'.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
index 897cbb7b67422..ff5df0fed9e96 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
@@ -447,7 +447,6 @@ dsp: dsp@596e8000 {
 			<&lsio_mu13 2 1>,
 			<&lsio_mu13 3 0>,
 			<&lsio_mu13 3 1>;
-		memory-region = <&dsp_reserved>;
 		status = "disabled";
 	};
 

-- 
2.34.1



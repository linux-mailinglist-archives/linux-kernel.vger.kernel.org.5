Return-Path: <linux-kernel+bounces-116621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7FA88A152
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76A5B1F3AA46
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DFE17ADF0;
	Mon, 25 Mar 2024 09:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JEPdr06M"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2045.outbound.protection.outlook.com [40.107.249.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A928E3BAA7C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 03:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711337619; cv=fail; b=ShCk4hhCajDtXeZruGqUNFSDo9rNarmdSUfVTHQQifW0+5c/a0xEJCGuSnOTFJkibA8C69JCwrJWebJjZwTtQtBWNuR+XQ3VES4oVvMSlZEZ9mQFoE9RdJWEOf8QRHmSTp4RQy8l3X/YeanNG3L6vSaFTDRmgS4Ly4V7heeQBuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711337619; c=relaxed/simple;
	bh=vydb+hUdnMRAIkfM1c9K2xCrRg18psGomgxz1Ov+CGU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j68hNyBA053IPouimaymJe8qNt4eZdliExEGF2xwT3/IIguQJD4vN4a0anzN7Hf7kDGDZnrCdck1mf3qmWYkFhUY4wGIuXN3ZCHjhlqOLQ5EoWAt6pUsqySGcmuU33ppmIm1fw9ZeUWVGvnaFQ9+bxkbHNFnvVRhrwivg+JICpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=JEPdr06M; arc=fail smtp.client-ip=40.107.249.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YaWgCPDLa5pf5itE8P29jSFL46HGwleS9eT2ERdezpE/xTN2jHmdx1+VS+V3wYTnimVe9fEyEBh8vC/oRCaH0SeE+eNBJDd41xkJzOPW3asBJdw9cAjo9r4G/djoTRehmFiyxl+1lWTPGhByGK9GZMg73C9C+B8XyM0ed4t2dmbDtKC6+LBH8+LHssO7toSdL0DWewkJfd11BGxly7aiumIhP48XRxOaKoXoQoavWxmaCb81oUOYt17PvdtQHOrb/66Y+bAfBeKoFp7LzNMjEawQfkoEX2jlxQyrf0Yu+9WBo3jFPFDnris7JZ+TKmc6vMunA5teDp/Q8gi6gbrKRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vydb+hUdnMRAIkfM1c9K2xCrRg18psGomgxz1Ov+CGU=;
 b=mxPqqHUqEqwUmD05xj+JQhtNQw2smWIrq8bZ4PPzNw4t1+LposZTeKRI4wjcF/DujSzjJJzVmaKrlJylvnsdvt9PSC7mE0RzluqGwHgsY5r/B8jft/Prc3G54engN3xxWlOjcMARIY4Q1If5WKmxAOKmDRptLAVFnvAdwGxHcTwrHkk8ltBBBSJEvvhUPE5uMF4HxYpvgNNOgJTdz0xepy0oF3+p1JkCseP0nG+jfRiq9wiseG5+G4TW7JKmkrcJHFvXmKBbWtxiBNRoMLwVCS5wa38gATouPVZDzQR5+A5MjPE243ht45ynU3rAuxRm6k6pS1IA1fAJrhsy96zCLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vydb+hUdnMRAIkfM1c9K2xCrRg18psGomgxz1Ov+CGU=;
 b=JEPdr06MiOWHg9LCUeYNN7jog2I3Eo4HB+JLR7gbsouMgFbV3xEmVjaKEDalTCOG3JBr/UDqZwbjgOaOE5SHRjTjOh13sDOVXwP6ZKQzc4MAVHauTCroFj8X23YtjVVUge06qSPgb0mrKdO2RBL9iov0hQzKA+Vrod/1ygMVJk8=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8053.eurprd04.prod.outlook.com (2603:10a6:20b:2ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 03:33:32 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::5dad:f991:ed59:3123]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::5dad:f991:ed59:3123%5]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 03:33:32 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Marcel Ziswiler <marcel@ziswiler.com>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>
CC: dl-linux-imx <linux-imx@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Marcel Ziswiler
	<marcel.ziswiler@toradex.com>, Fabio Estevam <festevam@gmail.com>, Heiko
 Stuebner <heiko@sntech.de>, Kishon Vijay Abraham I <kishon@kernel.org>, Marc
 Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
	"tharvey@gateworks.com" <tharvey@gateworks.com>, Vinod Koul
	<vkoul@kernel.org>, Yang Li <yang.lee@linux.alibaba.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v1 1/1] phy: freescale: imx8m-pcie: fix pcie link-up
 instability
Thread-Topic: [PATCH v1 1/1] phy: freescale: imx8m-pcie: fix pcie link-up
 instability
Thread-Index: AQHafFndGJkvVvGyi0u49HQ33NvFt7FHz35g
Date: Mon, 25 Mar 2024 03:33:32 +0000
Message-ID:
 <AS8PR04MB867661386FEA07649771FBE18C362@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20240322130646.1016630-1-marcel@ziswiler.com>
 <20240322130646.1016630-2-marcel@ziswiler.com>
In-Reply-To: <20240322130646.1016630-2-marcel@ziswiler.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|AS8PR04MB8053:EE_
x-ms-office365-filtering-correlation-id: 9eebaeb6-f19c-4743-bcd1-08dc4c7c58bc
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 qq/yEimHLXhDS5jvKlRzv4iz99SOdq0dfIxMKmJZTshlL6OOG4FOQaPeePPI1MlxY5sj09RGP0Ho3+W7cmJIGe44zUWzpBx/r06UwzC6tAAK+Op8mdyPFw2mICH+zoND/7VrGYI76Z2NyILwVoFjIw658FfftqR2TjIxsRVNEyzlt5PaD+IpcIugMHvLd5bWsU5VT3WdvPs2la98TCmIjxuXcQGQiqTm1OUX+LlPpEAx7mm10aDK+BoEdi7Ck0O+Eg8vIX1QIggRAciZac4fIxUa1F7xCSREmtFxxkKRdU6IttjHT29i1jvmZvmLFdYNhT5A7yZSOse9/MmK4BDoWrahl/hZE48sesaouKpO5ZxC04UslhaRtuJVr36y+bWYUaAkDpquKyHD0I0QSm/VA5fMZyQXVLBQE9nE1Y725rzpNzBQiLkFolB7hwU+2unPV4i33Ze0w8dpFah2YDALrGdd2blRXPf8v9w+mg3hFybI1JwtAx+Qe2fm54HL1fVhjJts/YAphIlQ9Mw7Ug2RaLQZoJmyAt/CVng+HvvGZM3Z71cYbuqk3WkZV8VXM/ilNjRWpK3B/ARb+247apFPBw2KwCBliyRoOOATZvwSAmR2zsBYZm2OvBMqmDqs057LiPQB7omsRLbq5+1DyNIc4iuP420MJ4yJZB0OLyhWdsdufH6u74Bd7QP116/jkCicWrSxVOMG+uKshdB6ifShlA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?RDlVYks3SGZoWHd0ZUZkWG44UnQzUSs0VmxEREFTTlB1emRZT2JiUmthMHla?=
 =?gb2312?B?aytwdlJhd0U4RFVPNkxMNk9YNFZWQW1xZW8zWk1CaWZja3NEZDgrNXpFcmFu?=
 =?gb2312?B?eDVLaGk4cHo1anpkbWNCa0NoLzIxSGdubkY0SUlGVjRaK0hjYWpaM3NSbWVZ?=
 =?gb2312?B?bkF4WkFTaDF2QTlhRFFrSzhjd3krV1RTM01qdzVWb3BEbm5wWW1HZDZvdWQ0?=
 =?gb2312?B?bGtFdm1hVUhPemN4bWtzR1NYNmF4N0ZiM3YzZUpUQW9MS1JjeVVCbWo1c0Nt?=
 =?gb2312?B?Mm1kclNyakJwcDNBbGpDNDFDUk5nc281bExXa1hIc0xFV2hOb25ZQUFsSWlC?=
 =?gb2312?B?anRkTnFGd0Z4MWRKMWhtNHBRZVJzdXMyM0RzZ0lGVVJMeTdWVzFLbzRBTmFt?=
 =?gb2312?B?S2xkaWloWnZvekdiSS9waklSRDhkTnp1dGpuL0FhQkw2bmdGSHd6WTY1V00v?=
 =?gb2312?B?SWJOaHdGS2pXdGgybTBzN2NiSTdJTzVTeWhZZysyb0pKQlZTR1BnWVVjZTRN?=
 =?gb2312?B?RnZqVi9xUUh3VHVkSEhVREZYd3Q2QUxTcjdVUXEyc1QrSGc5SFFVcE8wb0xR?=
 =?gb2312?B?S2hSVER6QkdqOUlBZjBWZ2JuODZab1Zkd2d0VWE3VC9LTTRTYlBoQy9Hc0Fr?=
 =?gb2312?B?Ly8xazBua3pscEJGNGFKK2g0SDFPMUozTGJxVlFaOFB0a0xPakFlVWQ3V1gx?=
 =?gb2312?B?WlVsQnBkVnRsWmF3WnUxbUNvOU1mS3U2cTZ4YWozRW4xUGlnYTlqTWNqYWtz?=
 =?gb2312?B?UmtudWwrVyszSHJUNWU3YVNOd2ZzQnQxMlI4VEpSVGtPU1BybDd6c0RGK3VL?=
 =?gb2312?B?ay9NeGV6TmdCMDJlQWZwaWtpcnhwQklSRWNjN2dkUHVFRHJQaUFDcmcxUStX?=
 =?gb2312?B?L2FTNXFNMkRjTGJQTVRLc3FXT3NLV25MakFyeTVwallxaVZCbVk1VXlRMmxy?=
 =?gb2312?B?ZFhBbzFURGloNVVsYWxsK0o0aW5BdzhVUlFOS2FiTjd3SmpBUjBsS1hPL1ZI?=
 =?gb2312?B?M0l3MWZCUGY5SnNoMmtjaHZoRmc4WE8vUjR5T3hQWUFIUGdOVU9jeFRsOTRI?=
 =?gb2312?B?RjVUZ3ZSQzJnVFdWZGxEUnpMYjhkUmhUS2RDNDJsVktjb0hsWGRCM3RRWU9u?=
 =?gb2312?B?ZVNrVWpDSUxha2dwRHI4TDBWWk5uWTVPZWhXc2s3MTVmWDRaYXRTVlVZMFRp?=
 =?gb2312?B?aGtFN01rNDZHQlRNVE54dkx1SmwrVTJjbzRZd2c2UXNyM3R5VVFxbE0xS3Ji?=
 =?gb2312?B?NmdsUXc3bXdSRXB5WWFuOE9GdFZqWmVWWFFPSnU0SDJIVk9qYTVWSjRFWWZz?=
 =?gb2312?B?anA1QlFtWFBaemxCQm5JQmlNc29lL3BJL1VXUEdlUFlRaFp6M1ZmUmtXMGIz?=
 =?gb2312?B?VjZtNkFQcUJ1bEhIb1Y1VWtwTklIczR2NUoxQWJleGZpWkFOTC9JVjUvYktu?=
 =?gb2312?B?YUxTMStDb05RRmY2bjZiV3IzUGRxVldDVHdQdDQ1SE9sYlltMjg5TWswZHkw?=
 =?gb2312?B?KzFFNDl1VXM2UWVXRlA0aEoxYUxDVi9wRTU4Y1hBNUwxS0VPOE9DdnF3MjFZ?=
 =?gb2312?B?UGpFbmc5NUpDb2dIUm1kc2t1M1I1SE9scDVHUHg1dTdGS2VOdjZLcnVJbHlD?=
 =?gb2312?B?cDhMZjVsN2NGandPU3FSL1hDcGhoMEhwZGNNbkxSanNMUy82L3NhcTQwY2lH?=
 =?gb2312?B?UjBoKzA2VG1zeVUxVjlYc0ZBU0VFUWE3RWJNVjVXM0JxMEJIUE4yZFFCMkgw?=
 =?gb2312?B?YktVL0ozSENzdVZWbUF2UlU5QnJYUE8rRzlhN1Q2YWd2TUJRRUhKYnltdnVl?=
 =?gb2312?B?WXRRV1QvNWRMWit4bDArbndHYU5ZVXBUWkx2bE5hNldkWDJ4WDBROW5lZmg2?=
 =?gb2312?B?TUxJMHVnbnFPeDJUV3RMREQ3Q0VSYjg4RFdNTGFFRkg0YndLMUR3aG9zMXRJ?=
 =?gb2312?B?anhPYU5mcmRJUGVSQ2Z6M3NuN0pXT2dWcWF1V3VEV1JQZUoyZ1RTZEozeG5M?=
 =?gb2312?B?QThWQnpGb1ZTNitjK3VFblBYeEc0cHkyN1lkNXZuV3hGRmVPS3VsdEJEbHFI?=
 =?gb2312?B?YlNudW1Ob2M3U3duUTdTRENxMEFrNG81YktLeWNSeEg1cGRjVFppQm5OeG5Q?=
 =?gb2312?Q?h0UPQSLoiwRFHAB9MLfTcK0px?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eebaeb6-f19c-4743-bcd1-08dc4c7c58bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 03:33:32.8049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P1YgQX7vwtZigxyBeqljnB8j1gBLKT1z1uYtPpcfzidy0GTeX6gh3XbrfEHPg+GZkUohpObrGf4VAgwkU5yh6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8053

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJjZWwgWmlzd2lsZXIgPG1h
cmNlbEB6aXN3aWxlci5jb20+DQo+IFNlbnQ6IDIwMjTE6jPUwjIyyNUgMjE6MDcNCj4gVG86IGxp
bnV4LXBoeUBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IENjOiBkbC1saW51eC1pbXggPGxpbnV4LWlt
eEBueHAuY29tPjsgTHVjYXMgU3RhY2ggPGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU+Ow0KPiBsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsg
SG9uZ3hpbmcgWmh1DQo+IDxob25neGluZy56aHVAbnhwLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7IE1hcmNlbCBaaXN3aWxlcg0KPiA8bWFyY2VsLnppc3dpbGVyQHRvcmFkZXgu
Y29tPjsgRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPjsgSGVpa28NCj4gU3R1ZWJu
ZXIgPGhlaWtvQHNudGVjaC5kZT47IEtpc2hvbiBWaWpheSBBYnJhaGFtIEkgPGtpc2hvbkBrZXJu
ZWwub3JnPjsNCj4gTWFyYyBLbGVpbmUtQnVkZGUgPG1rbEBwZW5ndXRyb25peC5kZT47IFJvYiBI
ZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+Ow0KPiBTYXNjaGEgSGF1ZXIgPHMuaGF1ZXJAcGVuZ3V0
cm9uaXguZGU+OyBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+Ow0KPiB0aGFydmV5QGdh
dGV3b3Jrcy5jb207IFZpbm9kIEtvdWwgPHZrb3VsQGtlcm5lbC5vcmc+OyBZYW5nIExpDQo+IDx5
YW5nLmxlZUBsaW51eC5hbGliYWJhLmNvbT47IGlteEBsaXN0cy5saW51eC5kZXYNCj4gU3ViamVj
dDogW1BBVENIIHYxIDEvMV0gcGh5OiBmcmVlc2NhbGU6IGlteDhtLXBjaWU6IGZpeCBwY2llIGxp
bmstdXAgaW5zdGFiaWxpdHkNCj4gDQo+IEZyb206IE1hcmNlbCBaaXN3aWxlciA8bWFyY2VsLnpp
c3dpbGVyQHRvcmFkZXguY29tPg0KPiANCj4gTGVhdmluZyBBVVhfUExMX1JFRkNMS19TRUwgYXQg
aXRzIHJlc2V0IGRlZmF1bHQgb2YgQVVYX0lOIChQTEwgY2xvY2spIHByb3ZlcyB0bw0KPiBiZSBt
b3JlIHN0YWJsZSBvbiB0aGUgaS5NWCA4TSBNaW5pLg0KPiANCj4gRml4ZXM6IDFhYTk3YjAwMjI1
OCAoInBoeTogZnJlZXNjYWxlOiBwY2llOiBJbml0aWFsaXplIHRoZSBpbXg4IHBjaWUgc3RhbmRh
bG9uZQ0KPiBwaHkgZHJpdmVyIikNCj4gDQpIaSBNYXJjZWwNCkkgdG9vayBsb29rIGJhY2sgYXQg
dGhlIHZhbGlkYXRpb24gY29kZXMuDQppLk1YOE1NIFBDSWUgZG9lc24ndCBjb25maWd1cmUgY21u
X3JlZzA2MyAob2Zmc2V0OiAweDE4QykgaW5kZWVkLg0KDQpJdCdzIG15IGJhZCB0byB0cmVhdCBp
Lk1YOE1NIHNhbWUgYXMgaS5NWDhNUCByZWZlciB0byBteSBhc3N1bXB0aW9uIG9uIHRoZQ0KIGxp
dGVyYWwgbWVhbmluZyBvZiB0aGVzZSBiaXQgZGVmaW5pdGlvbnMuDQoNClJldmlld2VkLWJ5OiBS
aWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQoNCkJlc3QgUmVnYXJkcw0KUmljaGFy
ZCBaaHUNCg0KPiBTaWduZWQtb2ZmLWJ5OiBNYXJjZWwgWmlzd2lsZXIgPG1hcmNlbC56aXN3aWxl
ckB0b3JhZGV4LmNvbT4NCj4gLS0tDQo+IA0KPiAgZHJpdmVycy9waHkvZnJlZXNjYWxlL3BoeS1m
c2wtaW14OG0tcGNpZS5jIHwgNiArKysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9waHkvZnJl
ZXNjYWxlL3BoeS1mc2wtaW14OG0tcGNpZS5jDQo+IGIvZHJpdmVycy9waHkvZnJlZXNjYWxlL3Bo
eS1mc2wtaW14OG0tcGNpZS5jDQo+IGluZGV4IGI3MDBmNTJiN2I2Ny4uMTFmY2IxODY3MTE4IDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BoeS9mcmVlc2NhbGUvcGh5LWZzbC1pbXg4bS1wY2llLmMN
Cj4gKysrIGIvZHJpdmVycy9waHkvZnJlZXNjYWxlL3BoeS1mc2wtaW14OG0tcGNpZS5jDQo+IEBA
IC0xMTAsOCArMTEwLDEwIEBAIHN0YXRpYyBpbnQgaW14OF9wY2llX3BoeV9wb3dlcl9vbihzdHJ1
Y3QgcGh5ICpwaHkpDQo+ICAJCS8qIFNvdXJjZSBjbG9jayBmcm9tIFNvQyBpbnRlcm5hbCBQTEwg
Ki8NCj4gIAkJd3JpdGVsKEFOQV9QTExfQ0xLX09VVF9UT19FWFRfSU9fU0VMLA0KPiAgCQkgICAg
ICAgaW14OF9waHktPmJhc2UgKyBJTVg4TU1fUENJRV9QSFlfQ01OX1JFRzA2Mik7DQo+IC0JCXdy
aXRlbChBVVhfUExMX1JFRkNMS19TRUxfU1lTX1BMTCwNCj4gLQkJICAgICAgIGlteDhfcGh5LT5i
YXNlICsgSU1YOE1NX1BDSUVfUEhZX0NNTl9SRUcwNjMpOw0KPiArCQlpZiAoaW14OF9waHktPmRy
dmRhdGEtPnZhcmlhbnQgIT0gSU1YOE1NKSB7DQo+ICsJCQl3cml0ZWwoQVVYX1BMTF9SRUZDTEtf
U0VMX1NZU19QTEwsDQo+ICsJCQkgICAgICAgaW14OF9waHktPmJhc2UgKyBJTVg4TU1fUENJRV9Q
SFlfQ01OX1JFRzA2Myk7DQo+ICsJCX0NCj4gIAkJdmFsID0gQU5BX0FVWF9SWF9UWF9TRUxfVFgg
fCBBTkFfQVVYX1RYX1RFUk07DQo+ICAJCXdyaXRlbCh2YWwgfCBBTkFfQVVYX1JYX1RFUk1fR05E
X0VOLA0KPiAgCQkgICAgICAgaW14OF9waHktPmJhc2UgKyBJTVg4TU1fUENJRV9QSFlfQ01OX1JF
RzA2NCk7DQo+IC0tDQo+IDIuNDQuMA0KDQo=


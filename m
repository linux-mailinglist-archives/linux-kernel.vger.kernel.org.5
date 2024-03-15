Return-Path: <linux-kernel+bounces-103938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E25B87C6C8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 01:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FBC41C213E4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4338B15BF;
	Fri, 15 Mar 2024 00:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GKGBcv93"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2071.outbound.protection.outlook.com [40.107.7.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C5110E4;
	Fri, 15 Mar 2024 00:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710462717; cv=fail; b=Fd8ey7JsM77wziuo7N7F98/P3NzeDHeW9+XlAmNFMDMuw+TkZnalOMI3bzal+CU2ew3W5pf9Ov+bkzr5kiQLpwyxwVc4UgsZgmvjYSItCABAwnSV6+Iou8NW3Qy2k8MoQRukSL6TU9fKKYToydvRIzl3usN0G9yn0ZPeq2j7Dzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710462717; c=relaxed/simple;
	bh=cppvwl10qKdRCFtppMJcp+UREa6CmnqsLPk535QU8rA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D2gW8QZg04eZEvGgPyRUOB7huK0RsBiMInEcQgikEG/xnjAjkQpbSXgnxvzlPUwi4m7eHfKGFCds7xrylN7A1BC5pq5F2xKIStwCiPVfBOJ22eCIz5nsKy6FY9K9I5p4nvKMOt4yO7SxPFSJikSJv8ZoE63jUgQF53fcKNwY5EA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=GKGBcv93; arc=fail smtp.client-ip=40.107.7.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EtuJaderqHykRPjPoGwlc6kO1IrruqvG3pRMwJjuLfqYezm6pEU1mty1hvucIOAKZ/vHXCbwFKSbAWkG2MswTFLZpmLOdyzdH02buc7f8SierwQD5OSOSifjTzX1GDrrUTrFqMiFQfAe827x7tZFtiLwiyyKrrybmA5k0Xh/5peppoIO4blVxgtKP4i14PWUIGjzZl30MnIqTp3n7l8QLhdrGP17+XjZ9qGGDtkG8Nw4s3Go/rbYFZnIP+SpEz4ZE/2CiG6B+eex9GfBTYJhBZHjP5DVpjt5k5hIYoDUqj6Cshnvva0HiFdBrx5PMXcBMhUidAOzHHkjVKF1M7p8nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cppvwl10qKdRCFtppMJcp+UREa6CmnqsLPk535QU8rA=;
 b=gbrA+woPnQ/P+7grpQYt/NZN7xiMktmCRmpmbz7326wl4TPH2j4pfOEha39K0/Qnv0hSvQPNv6BeV0b1m7BOVr8obLPqzsxm7lCZdXSFvt7HQeLOLph6ljqh9Dz6pAS/W2rnrAXc0VDwzYNmsomJ42C5rzL1dvxql++fbHyJic5an+za6s2KjYhym8nU9vhGe+mhBEIf740sELSdC5+Qi0yEo7uS8vQ+4kmPIaLgGF3CMWMLd+faLGcInhE4tJv6Des+yTlNNnhXKEahS68fZkchhCuhuuRkBKGbeLMqi06TD5mBMeST+QamEKFgBombgvLbEMjaWrsEBF71oNEwbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cppvwl10qKdRCFtppMJcp+UREa6CmnqsLPk535QU8rA=;
 b=GKGBcv93mbOZY9z2ctWeJrr3PFHvHVfrmgUfWXuxRje7G2MdVzHLWMXnl5mt7fSasuIfOoPCWgHy4LIne1IRhyPWBpi2gGXvvH/AD71CXqTy025bRIcj7aUfQ0nBjvdtjbuwFA75COUVtQSA/9KZ9sPMTo6kpfOl66+LXEFIEKo=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB9017.eurprd04.prod.outlook.com (2603:10a6:10:2d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Fri, 15 Mar
 2024 00:31:51 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.017; Fri, 15 Mar 2024
 00:31:51 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Oleksii Moisieiev <oleksii_moisieiev@epam.com>, Linus
 Walleij <linus.walleij@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, dl-linux-imx
	<linux-imx@nxp.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Rob Herring <robh@kernel.org>
Subject: RE: [PATCH v5 0/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Thread-Topic: [PATCH v5 0/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Thread-Index: AQHadhNQAq3ztPnC+06ZIaeZ1qof0rE3crUAgACA3vA=
Date: Fri, 15 Mar 2024 00:31:51 +0000
Message-ID:
 <DU0PR04MB9417056FD84405898F1B007B88282@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240314-pinctrl-scmi-v5-0-b19576e557f2@nxp.com>
 <ZfMqWP-t39SCvkA2@pluto>
In-Reply-To: <ZfMqWP-t39SCvkA2@pluto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DU2PR04MB9017:EE_
x-ms-office365-filtering-correlation-id: f14dca5b-020b-4716-9f57-08dc44874ec6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 AsDnWkMq6uNOUGEFIc7kQ/ZLr7MuY7SGANxob7i+dEsVxM152RCam/ZzEnAgeU5TBvb4ogT27p84aYm/vQUHEEw0gPBA/UhxEt/BQ2w6stiD3jpNxnWV2zfy2ardGjZHrT4YnOky7yQZ5ct/2axefcQ91ya4TdBj389owJ78oAiyLDAK2eK1Y3kb2sJqKR21+seFlWDZRw9aeamNrFBC1bMD1CUCcWpa+BEbU2r8k0z6tTZrUbnNQisj3pXN6d+HRIF4IfB8AhNpqUieNywr/z4Ex0qY37S8jPb0bUIF/8Kx2qzWtht639osaip/LJZS1N8ZCnSJ3xt8+MnatjsuqlajCp8lPRM4KKWDFRbF7ipV0BNtsh2TOOm02x1g9fMmZyPMvxl9n+fx6Au53Dg8W4vpoID2jkLvChyhWwlnevLtdgVPgLAiy/0RUJOnxUHRv8ujJf2SFG0AFEGfiD602A5c58pVE28ghW9EVvQJuC1ZLLoXDwEMIFflHnA5+nK7pHsKbABaUsto1BhAiPdNK5jyXrYPQn0aMX2vHIw9US1aBf5fOyZb6OOtis9EExaZCRuhY7yht+1S4nla6c9LHwOitaKbEZL5dzyhlJAEK1avQ2aS2tucEKzYLEtDO4IWKDOe2A8Ag8D/wEUe3eaJthD49NpOkOLco+ei+NYta5k9GPQQooAVbfwTwdW0L3JwTLcUPJXtG+D3wQr/QTBaFzCU9sBnh7W4IhoI84a2oEA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1xHKOL+uo8g9w7CwyCnU7G2OROnYbhxcl5yw3P6Algm9EXlVLa+1SdwH5cFr?=
 =?us-ascii?Q?baRfTv6DeOLGBNs0nlQCl5f3Isd02zE3MDi6CUaG8FVT4k62Ce9tFygA8d86?=
 =?us-ascii?Q?tXhU5x/OcxjCn7YcPZNEor9H/1CiA7FKw7M29PVdWlZWM3YNaPHadwsayI+f?=
 =?us-ascii?Q?b+tobjmrZpuwcE3kRBDoEx3iLROTRGO2J96JWo/xX0y2fxLWsmTLWh/1MlQy?=
 =?us-ascii?Q?4OJs4uA8DaCcUN9PgBnb4sP/nrOp4pEBQqo8Pqx1MrxFnXM0OytlFY/3/qL1?=
 =?us-ascii?Q?lYqNU2nHnEZnSqocnoT1mcGLnvgpXwXcaMNIQ/ow7/47EVCiVDB+b3xpPFwn?=
 =?us-ascii?Q?skzRvTVrxcGoQhrVfzsHoI3Avbcp2pWAQoGrwsMQeLB/AOGHUkTILjctwHW3?=
 =?us-ascii?Q?FUMYP1739BbQ7Xv4rN03joj7j7TfWM2ZScSU26BOER1DvrYhSdw0Ov457o8E?=
 =?us-ascii?Q?1r8BIkazYo/LOUQbJ3NmNfjKNbbHNgdXa8KqbYdWpG/mcpArOX0AeqqysKn2?=
 =?us-ascii?Q?HroZF+PdorJls+kx590TZ5BAq2kO7DfgrGVwfkhgPwJzV01wyiZPdmoWIz6h?=
 =?us-ascii?Q?vpV4nerW9K5hvcUQRHbtZC6Zz6AOrKe6+TtXzwj73gkXkeF6D5K28vaaWnpz?=
 =?us-ascii?Q?k3YH021sdqqz7QzOouMgo7Omx6hcVVWgsI5FVuvIke2C1E7yT4cd/QZZKo6w?=
 =?us-ascii?Q?QPhfQfgTzNWmdltNzbILMrPYCJzUPcp16jao7VJ34wC690fx7KWS3pe4+nyW?=
 =?us-ascii?Q?9EZtPJjVXX30Jzu4As1s5WUS24cjWUCz7bd8wc5MV4GH+Zi8uK0yFh/gaLU+?=
 =?us-ascii?Q?VLmZQjqGUJH6BpSfDiYVYvCMRig7DljwU5NvP3QpNWIsuVGFutL4urXfNyQ0?=
 =?us-ascii?Q?zIsSTwh4zgAzXdgaFUw4GqxjPSvmMStErGOQuDWdnf58c7V94JA3ARSGS4pi?=
 =?us-ascii?Q?EUjd0UQzf2Cnq/GF+6rcekmDc7cUmg/RvGOv62/UfzJWivcgB27+ZTmSQVKh?=
 =?us-ascii?Q?na+t0uUtCU2vPgjazZP/Wii2LuPBdLIRGYdyUYmiEB13Lqc+ty8lO1bH33kS?=
 =?us-ascii?Q?kLrAaJNmu4SSVEUJzuRhsONbeZyeaPPOl8D/jSfCbGRaPY0qBX5jsCY6fs56?=
 =?us-ascii?Q?q+jsyYxlgMLOOQNQ5Fn/bLHZFiPLGIHaZoHM3xYB1pg+2yw9RQkjGCOhuxMH?=
 =?us-ascii?Q?E7K7H0sLKpYs6+1bjVKz4+mD2zLWEqHmrHUhSLrfa3RuI+EOgQhr35Iss9Iq?=
 =?us-ascii?Q?7sKEQCrTKjXko8mDlyBQ3zxzxDsqv0sSzQOnWxw9NxoyEWhUfN/vJ3SYtLPw?=
 =?us-ascii?Q?aKJdAbB+aa5nSKR4rASR03YH8t84kAklDExox+VxLaG8NhYTNl3vRmoGLv4z?=
 =?us-ascii?Q?bILVwXvRd/TlrbyJiCXVOzJZS1XJnv7MamXWFI0ObrXapHAEWyztHPYpMXlB?=
 =?us-ascii?Q?wHmIAOmdaCcKqFUF+7k1wtrKmnAiXy2H9HgmgL+ovquFO9zWYP+9AG+et6uR?=
 =?us-ascii?Q?cH+LpzUeeNOHtO6X6WNK/wpQRWLBxdxKb5q5NoYwRSazpi9v/5NLuGs37lLE?=
 =?us-ascii?Q?SR48AcftULrOq34KbNg=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f14dca5b-020b-4716-9f57-08dc44874ec6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2024 00:31:51.2267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qwCjkuTt7snK7tfZ+oaED1s2NWcoBaSrmiG+2nRrXEBmVbm3YG4vb8JJ/0VDpt46i0S/HY576CdX+2Z8IMfMsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9017

> Subject: Re: [PATCH v5 0/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
> protocol basic support
>=20
> On Thu, Mar 14, 2024 at 09:35:17PM +0800, Peng Fan (OSS) wrote:
> > Since SCMI 3.2 Spec is released, and this patchset has got R-b/T-b, is
> > it ok to land this patchset?
> >
>=20
> I'll have a look at this last version and a spin on my test setup.
>=20
> ...but has this V5 change at all since the Reviewed-by tags due to the la=
test
> spec changes ?

The tags are same as V4. I only did a rebase, no more changes.
>=20
> ...IOW does this V5 include the latest small bits spec-changes or those l=
atest
> gpio-related spec-changes are just not needed at the level of the Linux p=
inctrl
> support as of now and can be added later on when a Linux gpio driver will=
 be
> built on top of this ?

In my current test, I no need the gpio related changes, so I would add that=
 later
if you are ok.

Thanks,
Peng.

>=20
> Thanks,
> Cristian


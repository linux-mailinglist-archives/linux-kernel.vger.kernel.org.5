Return-Path: <linux-kernel+bounces-86553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C84086C6F1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 820191F23532
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA4367C6E;
	Thu, 29 Feb 2024 10:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pMVAd7yB"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2063.outbound.protection.outlook.com [40.107.20.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CE267A1F;
	Thu, 29 Feb 2024 10:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709202630; cv=fail; b=dwTk/kHoO84WISQjA35xMcyZumRLS8gNi/Yui5iEKmg9Eo/zU4b+cRb53hmwrg/VXec5W0HlWwVJ5i59Xj4KDBujfIThM2H7VdAcWkbacBSKKRbZtflbj7snU9aRcd37keA9OrpJ+jIrBBbBEd+5f3SrWSSAYB2q5ZFHqE/bygA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709202630; c=relaxed/simple;
	bh=k88Ue6TeyheEKxlu53GHnX4Bz5XEViz0Va/+xqoo57U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eY5kib+BufsihPoD9tT9ZbUyTBAAGrZ+kGJcc/xLcj+NGGgHmGpD78UOAmFZ0huSP1a8qxC8nW3mDbVJOzKY4yIwdNjAEL5oBuhpr7eDqekDg4yn/g5gqXAduCFEN6LFDL1K+gmCCUOKMBgCtl3CWd4TM8UP6qybgGus2sS8HXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=pMVAd7yB; arc=fail smtp.client-ip=40.107.20.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aj/RdzpZgnXLH79sQDpkMG4AczfhAV5XqHRX0zdr9fAHo7C2jyqvmaepxPSpu5A05NjkxLpQft1ySBB+jEM4qBuWIqISnJQciE3nFPRFNUhtVKap26+q5TooW8hvMeslCWoBUmw5ld6t23asxeEd751a2Sd8SdUhlU2Bif082J7DCrd+4svgpC1ac6lEtcc19dkPJGVfRg3hg47EDFZIAFgeVbGKuAjJfaRQpGgCyPSnAQOzqDs4nJAsfeEGPSA4mMd2rEegAWxvpA+dtzH7O9LcBVEwVIuvxaoMtSV24Po77DkMKL7q/89gSnpbih+zhKnQOvzis15CNFXUbbS+tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k88Ue6TeyheEKxlu53GHnX4Bz5XEViz0Va/+xqoo57U=;
 b=SQ8RndkAZNLdrs+4vI/SYAInoBDwRTjMO1ynR8AGInKHz51rm+nYNUE+dM3X8u/Jey8HWFF7aMDx5xrQcDahKBk5tOznHcNbtrhiKOJnA71SPdAUllPc9cra5YQhKYJYQZXYSX0ogRecErLmF51SJRw9oaPnjeCzbhPnBatEGd6Y3Kl4Hl0Eo19yP3DOqN93SkWr1b6Gw4wM0nTmfYrMQFeSnGgpLQ8pvxrlgBfcSVbJ7iOKuc3keFj/SrMq+pc5P0uxKJ0/bWEkuhkViI6DiO3/ynfuvshJouPkK/CArqRWbKOOZBsB1CMmbTa2+D1C/pcIR/5u9cge94rJMcg9Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k88Ue6TeyheEKxlu53GHnX4Bz5XEViz0Va/+xqoo57U=;
 b=pMVAd7yBTUdqqHaxgnAaKy9HiJJymZCX5pewMbTR8qp7tGgh45YE3YF5CPNGbdXf9naWzw730jZ6q8YfB1fLzrl0jR8xt17PWYrUhqcPag6B5nFdlD205+33PAvBmPRo1cSaU78LPksYxsxDXaHQQzNNB3lkg6PYYr3iakIkNXM=
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS4PR04MB9361.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Thu, 29 Feb
 2024 10:30:25 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 10:30:25 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: Will Deacon <will@kernel.org>
CC: Frank Li <frank.li@nxp.com>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "john.g.garry@oracle.com" <john.g.garry@oracle.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "namhyung@kernel.org"
	<namhyung@kernel.org>, "irogers@google.com" <irogers@google.com>,
	dl-linux-imx <linux-imx@nxp.com>, "mike.leach@linaro.org"
	<mike.leach@linaro.org>, "leo.yan@linaro.org" <leo.yan@linaro.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "acme@kernel.org" <acme@kernel.org>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>
Subject: RE: [EXT] Re: [PATCH v4 6/6] perf vendor events arm64:: Add i.MX95
 DDR Performane Monitor metrics
Thread-Topic: [EXT] Re: [PATCH v4 6/6] perf vendor events arm64:: Add i.MX95
 DDR Performane Monitor metrics
Thread-Index: AQHaVAmpfH+wU+TeN02q4eZ9P4uLMrEWbGKAgArf/wA=
Date: Thu, 29 Feb 2024 10:30:25 +0000
Message-ID:
 <DU2PR04MB882237E2A26F535348F5090F8C5F2@DU2PR04MB8822.eurprd04.prod.outlook.com>
References: <20240131055811.3035741-1-xu.yang_2@nxp.com>
 <20240131055811.3035741-6-xu.yang_2@nxp.com>
 <20240222122533.GE8308@willie-the-truck>
In-Reply-To: <20240222122533.GE8308@willie-the-truck>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8822:EE_|AS4PR04MB9361:EE_
x-ms-office365-filtering-correlation-id: fcf7c31a-5477-414e-1802-08dc39117151
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 JsH8uvxLLwQODPwcdlXvsnV+/rR5u4u31Ai0mnO6Oomv4QKQTdLUCXa/ahc8RKJQ3iJC1HJmdHxBrwLhYKq9Fp82n4/FAZTw7OSor5g5irqLvyugOpq2P1uhGHyOXds0CLQBCEeJTixzVrwHkX19k16kkasfygWB5Gjr2DE5I3Bm2G9ilxxYhI0nnqOZLUUpdAOa9jGDMGELZT+Wl3EEJwp8r5LnWEiW7B178VG+daceCyCR3N1hTifyzpO2wBbCEd/01PlAlp4G09uIWbOtzExQeBtUSmm5zmLez0dqWZumV8Pl3zRY11AxkY18G6fypQthPk3QXJfP07Dld7v/kjtVVO0w4BJCG8Qx/9s7YRJi4p0tWEYoQ7xFRzIVOV2mPZ/UmZxerLgpNi4EzbPZY+BCwamU9NeguS/QYgBTTHfn7i8RfsT4589jEOVQlzHDo7BsKfAsynqhIdvoxVB8YE3aI43e3B/Xz1m8ZL4+GBxQE27VlON7oCLfT/pGBkhmABa0ksZYMznuPGU+8/Zt4bzGdOSVzVvvGXYM5YeIYh2HP0Bw4uyfC1flaOeg4d6Q1oHwjEJ2dzfROde2/erFAiboEj3r207fRW5HE+YuZXulTpE68nzxf8xzLdm+0JD4bdTEkHMrdT4z1h3mFMfzTTRUqYIsfiMDXfD5uzY2lRj89P3sjYwJlV2d5EyEwAbo0f9jWSqgu0SFnMLu7go32lluuQIA1Fc0TD/WteWEoa4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SIASYxbS4jSeV526RYgbeDNq+pSDpxzhE3K3TAOatYeqPiPJMPQDLRUFPeSh?=
 =?us-ascii?Q?6NqXveW7W2caIXqXD53zUriJ0Rlsjw6Ug4gLmNJOlPWlUhWLqeBLyT8Ym9Gs?=
 =?us-ascii?Q?nY8sZ/iuQXUjd0CfxaMbNPFIUAOpKgwqFTR2gI7ay67HzBkx7m5sCHPBz9Qx?=
 =?us-ascii?Q?7Ifi/mMTUGGhWwAtcgKfcDB+oDJ4KE6oyPzH0LewX0gxgZxb98j0u8yyWV5I?=
 =?us-ascii?Q?T/sAWZ3xtj+mfQy6YOv4ehFPr2cQKR9UjGMPorwh+SgdrhOCsxmYeClxBeIg?=
 =?us-ascii?Q?R4Mn/TPSEX3eu1uMB7gxIxebXHnsVr7JCRYYdW37wcJdsjfFCbqzOny9yGY4?=
 =?us-ascii?Q?CWvN2dfrb6mbx5MOTGWJLeri4qOxxgJBVeGpwmUT8azb+2zcQXICDqTRHamS?=
 =?us-ascii?Q?D/SkWtoXMXwpC3o2H3IAKRM6M6soj4EsZiYFq2zYzrrYf4igomaqQkRkdywk?=
 =?us-ascii?Q?iHt8LqTa5rUvdrzDlBacnF0cpHKc3cgydd+ILO4emiq5IQONIoEvTedEpLWO?=
 =?us-ascii?Q?uy98whPQmegAAMXa/Szxp9b8USZqBY0FGC/HnTzv4mWAMzxOdjE51o1HU/79?=
 =?us-ascii?Q?8RPSo0aLOFuKZTJy6BnmzAFqkOHNoEfhZMcms7gm2+M2wgEWs/NAJU+94xSm?=
 =?us-ascii?Q?dIfVki7NqsfMwPocaspJ3bRk8H+C+SXb5bTLq4rJJZV530JqaNXBn4YGZpwU?=
 =?us-ascii?Q?oRRZbC6kthgRTjIBty9A/jTHZ6sJGH/GwKeDyYwB777UR1sHZUYx/YcnBoaz?=
 =?us-ascii?Q?RSM3UsQWyV+3IyZjzOTtdTOiFNO2uwR9nmF4OtvBSbVUXfy25YsSw/SfblJE?=
 =?us-ascii?Q?tzj4EKL6yLwz5HJmd5GoK4rDrKL0Bq7VyYG0pyk3W6Ty/hG/kp3lk6fm4dYk?=
 =?us-ascii?Q?WfVGFDOUhRsalT5xvia7r7ByASDRrdKrJEg/CwWrz5h0WZmC/VeVqr5Jqlkq?=
 =?us-ascii?Q?OIUVNaQhwzZDy90lt7aPCd5mNSfD3yYHXgh5b1/wiZxYkZyvMZdMzIDWUlGO?=
 =?us-ascii?Q?NCvcfbtnt73C1+hyGmpKt1QChWEgtqw93SoLobjgj0P1/MvXs54EDbhZDVQo?=
 =?us-ascii?Q?kD5eRYbdr0X0J2G2ILpPv72CstJUr7z+ZazAsqI8b4BWpDzdZGgjBvGCNHJT?=
 =?us-ascii?Q?mZSuDGcp9YQK3x7vhEDM26ulamFrl+W3xoOuw1uLIBurIAUX02Tbqhv5nXe2?=
 =?us-ascii?Q?wfHc3QzHodCu+/Nb2QechmDq+suFm802X5CJv0a8volLWY5DHqo+WJd5lYCT?=
 =?us-ascii?Q?dSF5fsY73xWchzzbJhSzGAKBpz76SZ4uRrm4DDDXdH0FORch7UNabpxXPWuy?=
 =?us-ascii?Q?p7y+D54YeLTfZarybhZi7Fp2TxBVe+Xx3M/Nv/JdogguiLC8ApItsF1avkXh?=
 =?us-ascii?Q?EPF5I2bzPtNuVvmuecqjlFkgN2A/ab3EkuPCme3ydlZzsa0EmxDyuPhWAvaf?=
 =?us-ascii?Q?I5U08GNekRN01oykbfby85hpD6V+j6sRqTdZPDkyPKJ9fGJRc3qtsfWtWbHA?=
 =?us-ascii?Q?C2+dYpVYkq+f2mQ44UbnTrLolLQ6itHO6H1nR2vZNzV6sv8AJ429kpN90U1t?=
 =?us-ascii?Q?DmfPO9f4w71YmtmQvCY=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf7c31a-5477-414e-1802-08dc39117151
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 10:30:25.7529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WahJIwrTHT/tAdsOH0QzDjCid0Me/j8xma+neQKmknH31ICtXMQ8b7bGpmE8ymPHdmMqb4BOtSkbm2kRGOA6uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9361


>=20
> On Wed, Jan 31, 2024 at 01:58:11PM +0800, Xu Yang wrote:
> > Add JSON metrics for i.MX95 DDR Performane Monitor.
>=20
> (nit: "Performane" =3D> "Performance" here and in the subject)

Okay.

Thanks,
Xu Yang

>=20
> Will


Return-Path: <linux-kernel+bounces-146785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBF28A6AE0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 718D51C2111F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F0A12AAE2;
	Tue, 16 Apr 2024 12:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cTnW0QIw"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2061.outbound.protection.outlook.com [40.107.21.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9ADF1292D7
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 12:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713270389; cv=fail; b=S9q8EnCnXCjDlLuY+fU4FU7iXCThZi1MIk92EOXM2X0d2s9clRcLZW4vxEjskcf04lM7oEnPirVteUHTAqgFZPhb6CSP/A2+2cwxLyGmdJNk3K+RBDVyZY6L7xcmWhSNLjnK0/z95LcxVYTRrbMEQVlSkGFn/6QUUMqELHRrA+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713270389; c=relaxed/simple;
	bh=nNnrQkNCCfasp/iWtQlB/ELGcGTHH6Qby7qseu7Jqh4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fQpLrOaXwFSUZprrBdRFP0KXuWpys3Vhb6Z3p+Go2gzPgeVkd/KeSyIRFNdiYtiNQoF42RivttltmhIAZtUPrf7BmZNTOqw/C5s3iskA7jhV36js1xJ15dHmt9D/zfNmFH6laf/n8ZXhOyE1hJdW1HXoH16sHBcxukQAn17U7SM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=cTnW0QIw; arc=fail smtp.client-ip=40.107.21.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fx2NVOFX68yCmS0smUw953xSfcH7NDTpddXX/2VfJ8InzyX1QJ7rWKp9S8i6xZt545K1Dd4qJn0ts2ozfL3bQJ0YLpk8cuJ/0479D5PK9ePsAgfiRLvaMc7HVP7Kr5fbIRTMm7yqHkU2lMvn544NbRQd3j8po+y3oea26xDFwt+/atS4RKANZ4/b3XaORVdn8qMFhWDCH0m9x+V1JHcQ7DSLFpkYDW5uBWK1ruWeNylOMT291g87iotIPQEB3EcrrNsud+IUKb4H2gLcFDz8g7zT0IOXpsnkAEY5MFTEfPY4aiBepfGQT01Cb5KWUJH2WJek/rUnuNYdNVm58VwvTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfUsnv6vKf1lqu2op45kb5QkFjiGUpy8n3gtPmcbTeU=;
 b=TrIp60SZN4LDneM+K0cHxcG0Kou/e/xwLPZhbmApL6rinCQtaRDFmXbT9dKVcG7PQAwDN9pmcLfET5+bZ43GugdcegVfHe69w8LJPL80YGFF/5nomaFeqfJPsGMDLu1J0M9yzdSVLesqK3AAfTiboJU871uJLtsD0fbmJzbvC+niubuM3ue9xL/flVxORNbWZTdNOtd5XXf6nvaXk/vSK6A95PzqHMHJCyYQN8jBeY1iPBzp699jUjAHE+acZq/CtTSSBM/mHfDfRtauUKpmCczyRxDQA4BxprS0dfUlauMrh4LkgEXopZ/IycUOeyXkR+L9lINt2DBBPimx8kW7sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfUsnv6vKf1lqu2op45kb5QkFjiGUpy8n3gtPmcbTeU=;
 b=cTnW0QIwtPsHx5qkCn5jo8ID9LVhGcSu3YzzVQEi8rUbJEwNgj0ewhvl79pdSQoAY/2nKQ4+xG+Hvp3kOTksx5MDL1pA/FjDhXw9dOYsN7O5GVeRve+wEOmX78EBbRyfJTZEnLxwueRXCQEngtnhT+Fhhm35gKGrMbkNJkqdpSM=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB9836.eurprd04.prod.outlook.com (2603:10a6:800:1d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 12:26:24 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 12:26:24 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: "cristian.marussi@arm.com" <cristian.marussi@arm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] firmware: arm_scmi: power_control: support suspend
 command
Thread-Topic: [PATCH] firmware: arm_scmi: power_control: support suspend
 command
Thread-Index: AQHajxwygJMjjnYsXEamYB79VvBL0LFqnqIAgAA1LnA=
Date: Tue, 16 Apr 2024 12:26:24 +0000
Message-ID:
 <DU0PR04MB9417549489A54D23D0F6F57E88082@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240415101141.1591112-1-peng.fan@oss.nxp.com>
 <Zh5BXAuLKM1uUOyD@bogus>
In-Reply-To: <Zh5BXAuLKM1uUOyD@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|VI1PR04MB9836:EE_
x-ms-office365-filtering-correlation-id: 8f210e39-a3a7-44a4-af3d-08dc5e106e6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 CEg8EX2aeBmXRXeF6vjfeHRokLabPkIBxRLuR+sxwRgdyRmkm01xgutASVq700YFsHqnQHOVsQDn3jTlMqa+UQBFt/BoZV57t1VeOvF+GC5b0ztZvELb4TtQU39OuSMZNy1Aj63jh2uSymhgGZp3zMqgZNh3x8Egy4bMqHPPfshneVmpcVEbuGUDgJzqMFy4AdHfe0T+JjJLMcePkxvp1+zjS7TGeMHW19Zy69728SSFOPSpsQx7gN6wondDM8Z2m2rOGLTBOOvnqwqjosksXf1APe59Y3yJO7DOcwN2yzk0fZ49Xai/TrKMOtHFAlRN3nfRcCdQ6J2+3VPukhlcaTjnXpCFwscL/VFauZPvpL5xLQkYe77HJD/Kobuw5GGpF6iLBo12eNkZubjitfNqUWtvCMG0F5zAezh5Sddc8qWiII+pads9jIvrIyuNJCyGrLPCdThpAd7guiKM5L4XpqZdRQaEGIzqOtLgE+DQ9acvDZiYq8qUMKaD5zWDu4+nKpof9C4qQywY/iaFBhc9LVTPaBanLmEh1EsFv51J6v/Op7caWsRQzLau+NJfitC8ECaGEvjBxtD+S4qstW9X80nsuagLGUEeI5XN/QR9ShM8Hlgsc/h5AWMFWig3vyESC5Zdrha09lr1iLJPpEkj0F97By0nWtsXuHB8rWVShaq9agZYcM1IRqr1FqZEaaWvRZT8sfjen0qepFaVpC/CaHJkjLWuYLa27ipQq92Hht4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QG6tRSI3CRntCUHTU/JzZ37vlETTB65ovyu4ndTHHQprPpL2ba67cOLiQ1v6?=
 =?us-ascii?Q?4VVKa9+ecFuPjOgaBF97bph/MiRWtjr/cbGFTqj8oGoPAtlCcK23/n8y3bRD?=
 =?us-ascii?Q?pv/0p62G9l5Gq1YswUvDHTv99kZm8z91o87g8ClFeBCqIEXzvPw6uC8Dfifc?=
 =?us-ascii?Q?CmNJD++oe9N3Zffpas5kfSyAtKJmoZykf4pzNKg71hri6XqYWrwD9Wk7jO1F?=
 =?us-ascii?Q?tt2d9swBklDWh7nT90iA3iMXEXQNV0pXxz40F75BCp1v5BvFZYDJlQSzRV64?=
 =?us-ascii?Q?VH6/O/yCwllq6Oc9jCnmZhyH8wx59CauRXdlWT0zeRMTg69YExr8jzpAxkfT?=
 =?us-ascii?Q?Xa87fQGfnfSEKRilFBg1bLMgnlZyVv/rP8TdRVcJ869ZJdUjR9/x/3pN+A+l?=
 =?us-ascii?Q?9DiPDJWhc3jGjr7zyQBxqEFXLOmEE9VjDT7H4w4ojg9aqEtReTyYNg35cXYE?=
 =?us-ascii?Q?1KzwXdw3dLoXr++qr2mJ+msixl2hnmgz/qGqhkGexHBRreXxnUwVK6aRK0U9?=
 =?us-ascii?Q?o+1ctKwbcsWUEv/8rA1uIbubIvaqE0SjqpnyOWygASOPx04J0gu0m6Md20kj?=
 =?us-ascii?Q?unZdjr/9UirGL0TcfVizoTdHmKkgJnb+vSW8no5AIcmgU3orG6mRmHXJA9C4?=
 =?us-ascii?Q?0HiPMXCj6lt72TD7prKxbYA4cpoj/XanZ2FM0a6VnK0fCgzB5wq2Dk0Ouy2b?=
 =?us-ascii?Q?JXILgVQJurVgRxDDXtt+WUxZtDUc4Nz4qN31HGm0DS5WiqnSxCXqhm3hLfuI?=
 =?us-ascii?Q?aDpf23WCezEbv0XShUeMApcVHdCMABw1JnkjKmBrEiZJcjrRaavIHWupDzcS?=
 =?us-ascii?Q?SNYatNQeH8UY42/DqZ8JS1Njl0yZbRwZalM3kxaB8eVkewEog7y/WNXwFV7w?=
 =?us-ascii?Q?ILYC/DcrIqibFiMLMWnK2iObSeF51DHK/pBDX+E3FqdpOVz8Kp9WU56+dOmI?=
 =?us-ascii?Q?ZAsKzw5bPyVrqlX362SW9JfhbKb3ungMjNslHEYVbIWXnvMEzpPQE1qD36R0?=
 =?us-ascii?Q?HovzOjRceRD8BsKygiOGqOOrRfW8dCQ3irI9k5dJaYKB8to5sQWRc82mTXci?=
 =?us-ascii?Q?L/cHh+uAsmA4G5oIY4V54Bh0myH1lQCeh0w6wdPgx1K4OkOTnE5hmTJcuvGO?=
 =?us-ascii?Q?RbXfcwKniT3IXkULcBlFF/iEQLi7pIZnsG0aVHDHZibdWAWtyQlZdrpkHBvd?=
 =?us-ascii?Q?WKRIK2NmUeXS5lK3SWzLoD3S0nein0YI7NcSqz2zNbVkP0hVIxI8QfvAngHy?=
 =?us-ascii?Q?q+7zMe2+rOkpOl8fBaKjdVGGPiiMpquOwAz3uuKUaV/rx2C8/djNhfaTMb1W?=
 =?us-ascii?Q?ajG4tXcmtEDIypEKqbVc6wdRreNbTHA19YJKAHm11Fi1dG26BIm9oHJsM/y3?=
 =?us-ascii?Q?hM/9Fq/fLJlR/WqARIh1sVXu4Wkop1tPso6TChrvlisCeYq2CYP+m1oU3qQ9?=
 =?us-ascii?Q?DWe0KvCrnl9NevOq18ncenizzH8Onvk1dQiOzonqZSot9heZZ010rq7l0aul?=
 =?us-ascii?Q?mUAsqdTKZvTCAW+ytnz6zblOBKKQW9RBQSAE2XTG8sHxtchaAONAAFWjaLgj?=
 =?us-ascii?Q?oFs1LYXuOidm8GPBKtw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f210e39-a3a7-44a4-af3d-08dc5e106e6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 12:26:24.4670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UcDaWscOrCGZZmdaQhOg4+p0sD9ndpRDbbv2/N7K5s+QZTDcALYzsgrP1t7Dwxu9koHHPXdI6wwHDciMZwDXhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9836

Hi Sudeep,

> Subject: Re: [PATCH] firmware: arm_scmi: power_control: support suspend
> command
>=20
> On Mon, Apr 15, 2024 at 06:11:41PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Support System suspend notification. Using a work struct to call
> > pm_suspend. There is no way to pass suspend level to pm_suspend, so
> > use MEM as of now.
> >
>=20
> While the change itself is simple and no-controversial, I am bit worried
> about:
>=20
> 1. The choice of S2R(MEM) by default - not sure if different system
>    prefer different things. The userspace can configure whatever default
>    behaviour expected as S2R IIUC, so should be OK. I need to check thoug=
h.
>=20
> 2. The userspace needs to keep the wakeup source enabled always which
>    I need to check if it is feasible on all the platforms. If wakeups
>    are not configured properly and suspend is triggered, the system can
>    never resume back.
>=20
> We may need to mention above points at-least as part of commit log.=20

ok, I will add the info you listed in V2 commit log.

I would
> wait for some feedback from SCMI users.

Agree.

Thanks,
Peng.
>=20
> --
> Regards,
> Sudeep


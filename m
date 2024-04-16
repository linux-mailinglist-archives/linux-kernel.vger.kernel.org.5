Return-Path: <linux-kernel+bounces-146793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AEA8A6B05
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E4BF1F22330
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C024207A;
	Tue, 16 Apr 2024 12:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dh6bi7v4"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2040.outbound.protection.outlook.com [40.107.14.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798AC1D530
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 12:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713270859; cv=fail; b=SqRbQDaXxC1jkUDaCtItKYW0OjeCdOGCGLKd37AMSohhbMKmM1dWGYydvM1yx/o+uIpx3zxS5RM8QYmt2ygQy9bO9oaTOVU+lWcghmwHVW3/nki3rUlywNsbV8efQ0svX+KX+D/6ewAJp7ezxLiD0CD4eY4BWBF1WXW3cTKeCGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713270859; c=relaxed/simple;
	bh=/lgrneu6a4PIb7s5qmgySta5FPBoZt4AP5sIBPDVpqk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KFiDT0iqfBSvFD5hxhOSXWB60kjQ4GIw4XSGPfsFjQNpduPP5RsbG45JJDJwqBg/28375Sa3pUQDfDqGt97CRsRMs3vGxfvKs+o4JplbrgZcmjDGd0kBsztWTwRXrNQtno3IFUHcdxB2XaG79ieZPHBRFG9ckj07KfoYlOzVgIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=dh6bi7v4; arc=fail smtp.client-ip=40.107.14.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OuceRR3SHvN5yYXQOEpSpSowy/c2FYLcIY1LOB5hl6T3Yz0NVNA4I2rpNLxDWmqcr8bi+CYMgHBcxFWWte3IHUVcFuGzDQrQV+o9vGaYrlZC8wvRDfC4lUul29s+fM81RPJE41Xpz+y6fTTJi7BBGsuhLimjotCrgYNCTLUmbpu9hVrKSzc9XkzmM2YZ7r0bq+4Sw3YmJdWM8hFgHPDy7PJGFeuw6rNwA5tQry3aZONf1nP5FddDr8FjOS1YTNnMHStnh6CCDvlt6umVnO5sO9umHuRB8IhdBmRPHSjhxnVXR0pvIg6UJsZmi8w99L3todmkZWV16hYLsrRdu+9Qeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFEhv24W0AhlFk6wQRyiBK2MXNcd93ZSJDEJVZeGE9Q=;
 b=YkKC3MmlYKmou/O5lvzrT0mOgnnyr6MVQTKibH42k0jNGLM26+7Z1Tt9K4EYkiWZ/ytjZJxAoxswN0s6k39qzysOoKV5+m/QPfa8TCJOmBcyi/zN5kqY059HWFUI1JA2JkMg41r0Ddcgag05gzw/g0DR66EUR6b6We4+qAHQmYERkP7eV0UZST5/VrTVwDvr1uuNx1dklsteNR8Qu2m1AbD2/qcmdawV1VwA4SL/6uhngBwd3n4hqoLqtulo4qF9jAhwbNSKad76yfGulVOIAn1g6EvX50MX/ZPPjWyLmoI7QJ2NxeAZLg4tGC4rU/nMadFyCA+lB/Xn2FpzNF92fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFEhv24W0AhlFk6wQRyiBK2MXNcd93ZSJDEJVZeGE9Q=;
 b=dh6bi7v4cgW3TokODoaMtgIHmmMeyznx/VOLNHS+68Sm84I4psOD8BWgH+eT4RunJXaB9HAr8X7iq9eVcyD2GYohBM1u3l5y6gcPBWnsj21JcQBdQRNkNQVowJ2fIyW0PlbJVu99m6zNH9wzeuyNXLivN6m+s30Q9Icef4OKGS4=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8812.eurprd04.prod.outlook.com (2603:10a6:20b:40b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 12:34:14 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 12:34:14 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, "sudeep.holla@arm.com"
	<sudeep.holla@arm.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] firmware: arm_scmi: power_control: support suspend
 command
Thread-Topic: [PATCH] firmware: arm_scmi: power_control: support suspend
 command
Thread-Index: AQHajxwygJMjjnYsXEamYB79VvBL0LFpzXAAgACrohCAADbUAIAAJIBg
Date: Tue, 16 Apr 2024 12:34:14 +0000
Message-ID:
 <DU0PR04MB9417FFF8A9FB5018125C524688082@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240415101141.1591112-1-peng.fan@oss.nxp.com>
 <Zh2R4FZPmVOigfT9@pluto>
 <DU0PR04MB9417AC020C28AD5847CAB24088082@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <Zh5P2EtruMmTrgXM@pluto>
In-Reply-To: <Zh5P2EtruMmTrgXM@pluto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM9PR04MB8812:EE_
x-ms-office365-filtering-correlation-id: 989c9a9b-e4ab-4202-3bf3-08dc5e118680
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 3l5ke3NARA+QOLKHWdcizLrn+xlTVXVV2fRHuYOgNiVa6dKujHeNb+RqCSx9qUmBwS2LtQ0gfsgNweqX4I75pZ33aD6QqT9tKICUBLHkgIOs8u6/fcXT+cPyYF78xXC7rNfhsvmrT9VfaurzTIP9BahHlfnHSbXarngvhhDmUNYZZsy/bQelnuCOi5iY7i5UZajVjWURkDJDySdbNVC++aYoO7CB5rUxlw9nRsSocinbe5VGzgLIhD+GMo+L5y0+xjNPjzP+lMWKW7pKCjJJxdjL2hpNHwN7Uxi2/TqrO9639Eg3YqwrBEmWHZcXAnsJezopg/VSyypr6ykffEaO8aREwvUap26YcgNL3uMnV2R/9IisKHX69Pbw3JMdRxhHeWg6FCF114fn4F89vgt1MEmDpb7GHkknfL3THzKduUUcBhBY4hzhgSfmTzAMDzgzUnofgCDzGXw8EEYvfKmhr1+Dg5peQh8o/r+vQxf6DAed7D25OVJZzZXs6HTH22EF+3RTS8NotJ/3kUiVWGKFn3wByDcy8oTnfn9vvUVZ1QgRvYNVVNVk0a/z3L7cIZifiAh7sQUrcASlMRjj0UGtlgXx0bPPgwT8BQ/Fb+cAhWzRWFLphR0wYRDDg+fYHmGfE3tVniEUKEcS/LvlhWlwNtNW9lAuMzP5j7EoGKgQ5ViZlPHTHUwgUjDxO1QVybQ+PXaNFkN0O+THQqXHVJNArqA7ga3yI+wfEjnyOKLQZ7I=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dJ96POSyIuXZ1SeRMcLc+hQG1XoxTuH2RgUGUSsiwUJZy71tqqLEZkGNMEHS?=
 =?us-ascii?Q?z79vZ1Epq9aJViCW5TgWMM24VV9J0qNi29FL5aJ2G6K39rftVRN8Bvywj8Yu?=
 =?us-ascii?Q?zGYkua5v8a7/sl389y046ReZGMcdYzbibZwlSqsWnLRTkD7yhryWStV2oBI9?=
 =?us-ascii?Q?wAX8Ry6m8lk1AnR0YVNRO5vG9jid2PmzykpoZ4rihP7n3wJkLAIDLlmNYWhB?=
 =?us-ascii?Q?uHeUKu3+MkfYy1+vq+pF2JlqlhjpndgrmWeFH71mXTZ4tYNL6rd9y2c216UU?=
 =?us-ascii?Q?qLU3Pxb+CbZ+A9pzuzZjDvSDb2D+GSeSp/mnqJ/N/Mtm3LLZgwOvxP2L6Rpn?=
 =?us-ascii?Q?9dY82yeOTvyo0OzfuX+RilBAGHazYTnByEw1Td6EPIurNHXHBJ5jqvyttNfE?=
 =?us-ascii?Q?3a0aKtrbY7W0f2BtWyZsjvEyx4WgZMRXSrsve9oroLyPTYhLrPYfz0fU6RBh?=
 =?us-ascii?Q?ztnCJpaX+UXFI4AEjl/zNAv2o9bsvcuw5R0e+Mgca/vmluaewDTLPq1C9SMG?=
 =?us-ascii?Q?3oXlxN31ffrJOV7vvOd7hoi7sYdvJ0R1PAt1HIoljNXXO5xNOS4P7P4m7fvt?=
 =?us-ascii?Q?Bt8JDdKkGa2ZnM9vaoZnuc7JbGkG6ym139vlQQ67o40F8zTnkclXLxp3Qbq7?=
 =?us-ascii?Q?1b22BlRxSUMHliTk46ei5hsts4mCku5RbWwl5RP5HQqqOk8Ok+c8Q1KxOqf/?=
 =?us-ascii?Q?vTlb8chlGcLR9n6/fUiJgsWacl+twx2IS1Nit32sODqf/qTZ6eFc8iwZmSKI?=
 =?us-ascii?Q?RtzYKqhUT4R4vFFmjMiaRklu3v75ckXdIFe7idSr6aZjZjwZKFz5N+Ovvm5r?=
 =?us-ascii?Q?yrykplINzv9Rvscjo0nnpX6NwwNgSLGmbcT9mKLvpDhuMW+v2CtzNPwoKix5?=
 =?us-ascii?Q?xGnCn08UMkpn3yoHUBSRrxJMC5CoEIMoQ6IVelbIpEQHErWMqjILCjC/5reb?=
 =?us-ascii?Q?b6uJH0uD5kg5tj417+gfBzYm8lHrLHOYe7Cysjo/w2C4WN9A1SpHhNJkobAJ?=
 =?us-ascii?Q?vpIeUQ5Isk0yijT4Y/d1xtk/nAWQEeUN4zQWMsCoj91cdLy4pM7PnRg9/2rR?=
 =?us-ascii?Q?VlCxCpBizINJAHZyIN8l0un5HokWL5tZ6LLsjDFHg3AIy8LkYbdFLv+u6z6Q?=
 =?us-ascii?Q?QErRmoAYrE88zGOgzJqp5Wr5GpJ5A8IeLdG4Wj/voBaDTQ9dK/SK+tRUIpAL?=
 =?us-ascii?Q?+177RqXU0v+42OeaBRKhx4anEUK8MsU6WWMBGkhIZIWRe7Uv6pZ2EP1PpLbm?=
 =?us-ascii?Q?eLzUayfwKX38TgbnUWuFljTGs4r4TNPSx/Wr+LE5xbcJbtfNFf9p8mDdSmEg?=
 =?us-ascii?Q?oOeps7fv3qA2xbYLSoDMeZn3re2X9glAaGdRAZO/L8m/nxa7EzTxvbbZ4Uzb?=
 =?us-ascii?Q?NvbWbnxGDPQ4DwS9wrn0qDFz9mCyqWn4nqYtLDrpMsnzgivnGiKFmUFK6M2J?=
 =?us-ascii?Q?I9cgO0oTwEgpH0djTQlFpOOVtbPeqtRN9Q8WEJCF44wOcvS1/HvUg1c85r2R?=
 =?us-ascii?Q?KziJTRzF7jNvCm6Il/+5SP2E5j5LWjwvCkKUkt2jhlGq4ikQpMNvZf1M2Mxy?=
 =?us-ascii?Q?3xrzXaFYH/OwKrgpKug=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 989c9a9b-e4ab-4202-3bf3-08dc5e118680
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 12:34:14.3556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MJzuuUmO4Q6YToUmMLjhLYHCXjkbQ5mhNmdWL45pgoDtXK+v7qJSjQxXx3h9uN0LHt+daGoctVAsF00eGumJkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8812

> Subject: Re: [PATCH] firmware: arm_scmi: power_control: support suspend
> command
>=20
> On Tue, Apr 16, 2024 at 07:01:42AM +0000, Peng Fan wrote:
> > Hi Cristian,
> >
>=20
> Hi,
>=20
> > > Subject: Re: [PATCH] firmware: arm_scmi: power_control: support
> > > suspend command
> > >
> > > On Mon, Apr 15, 2024 at 06:11:41PM +0800, Peng Fan (OSS) wrote:
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > Support System suspend notification. Using a work struct to call
> > > > pm_suspend. There is no way to pass suspend level to pm_suspend,
> > > > so use MEM as of now.
> > > >
> > >
> > > Hi Peng,
> > >
> > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > ---
> > > >  .../firmware/arm_scmi/scmi_power_control.c    | 20
> ++++++++++++++++++-
> > > >  1 file changed, 19 insertions(+), 1 deletion(-)
> > > >
> > >
> > > This LGTM in general, the only obsservation here is that while on
> > > shutdown by issuing a orderly_reboot() we in fact ask PID_1 to start
> > > a shutdown from
> >
> > Would you please share why PID_1 is involved here? orderly_reboot is
> > just schedule a work.
>=20
> For the shutdown case, orderly_reboot related scheduled work ends up in a
> call to /sbin/reboot via usermodehelper kernel facilities, so that, depen=
ding
> on what PID_1 you have and how it is configured, PID_1 does have a chance
> to perform some additional task (if configured) before triggering the rea=
l final
> shutdown....this is done because the SCMI Notification is supposed to be =
a
> graceful request, so we dont just kernel_poweroff or similar.
>=20
> As an example with SystemD PID_1 /sbin/reboot is just a link to systemctl
> and you can place whatever you want in
>=20
> /usr/lib/systemd/system-shutdown/
>=20
> and that it will executed by systemctl before kernel shutdown is really
> triggered.

Thanks for explaining the details. I see that in kernel/reboot.c

>=20
> > > userspace, when triggering a system suspend with pm_suspend() we do
> > > not involve userspace in the process, but I dont think there is anoth=
er way
> indeed.
> >
> > Userspace process should not be involved, otherwise the freezing
> > process will never finish, and suspend will abort.
> >
>=20
> Similarly in the suspend case when you initiate it from userspace (system=
cl
> suspend) you can place something in /usr/lib/systemd/system-sleep/ and
> have it executed before suspend is passwed on to the kernel, BUT in our c=
ase
> we are not passing through userspace and it seems there is no way to do i=
t,
> indeed, like we do for shutdown with orderly_reboot(). Moreover userspace=
,
> as Sudeep mentioned in the other thread, could be configured to trigger a
> different type of suspend, it it was involved at all in this process.
>=20
> But, as said, I dont think there is a way to trigger a userspace suspennd=
 from
> jernel like we do for shutdown/reboot...I'll try to investigate a bit mor=
e.

Thanks for helping.

>=20
> Anyway the change seems good to me as I said.

ok, I will post v2 with commit log updated later, waiting some feedback fro=
m
others.

Thanks
Peng.
>=20
> Thanks,
> Cristian


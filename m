Return-Path: <linux-kernel+bounces-71765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1486785AA20
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B190728395A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805C945957;
	Mon, 19 Feb 2024 17:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="GHYyjgm6"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2061.outbound.protection.outlook.com [40.107.114.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9388440BE3;
	Mon, 19 Feb 2024 17:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708364355; cv=fail; b=bbddDQ8+5Jg7K3/e4eL/iWjTPYnAGkjTc3LzXsRudnHcu4cp/EGaQkUyuZu24ki9BmYxleB14ZzG4aR1Eo/OGHBt62MU177WHQIUJLlqnH3gVN3TQtFFSUGt6Ql017jtFgucGQoWr+H3Dd3IEl851klBxXwUQRByLw6eSt0Yc6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708364355; c=relaxed/simple;
	bh=8zXarDRvCjiaJAoL1Etew9W8e5k3ZG2CrKnuNcsvZGk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TaPqavD1ZeZJp/verm4gCJ4GMJjQQofh1Pc+SoOfZv2OhvIMWMBFaTr318lsZlL2rskTTOrMLwqx0SP3twJMLdcR2RMzQfiMb9OOXkpR/A3vGwwMKfT6iFE0xgGhKvGsPxGyLDDMitogASMKE0FgbtIyp2s52J+mPtvwiMM/brs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=GHYyjgm6; arc=fail smtp.client-ip=40.107.114.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIVY3AbFTCIQcWtqb72aybqLDHEcmJfpJOWeRaUuTuGJeymb+R10KvO9+NVUW90dBFveT5y8D30v0NOHX+nHea4hCI2WymEC7vwNbWZbB3AVGPpI4heOE7oxZBZSKcnYdSR8Ty/FPNKpZP8QQnfZou3KF634xJXXW090fpZHkkMQuFNlJwXfKh0PlI7eFReC+4QBZ4y/3UJ2Fb9bAdFa0IePon9WarIYHoIuI/gkmmvVNWlMxWMm5U4I4Ki+ZyIMwp4w44N9ej3sKz2iztt3u/fZGxDEZ55mTPPXt9CKihyIMXlflkpMnOtQjLK4rVU+T6na8elXcWYEVaeinBga3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFl1G7hT+0nyoFXZX6aZUZ/ne8YbtlBGKQ9n2Lu3L9E=;
 b=R8WM73xaxiNB0f4Nvho0ACqnvO9EXswFIVZGRfxwqtQ7LlutKCJYs5xSbsid8reeAH34J5xRExGRluoOc0pGsXPPdt7Alh2jifh0WC4dyAF87v/5BUiq2gy8aIjC+raFHfm0mfgbxzPnJ52pkKOLHuuGny2RHDgGU0y46M1uKPD/WtaV7OIlbR3i/qj24+p9Y409A4ptn+hpJIipVbOkyx9oxzix4pZgM/IOsAe2Jxd1Hqb6IMdBKkxLsZzQQJhXayhhlu9fEpi/O707eM6HbZDzh/z8rvEMzUmVZ9eELun1L2URE0wxH522exytOeNJEsV3PcTS7vjweIthsun4jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFl1G7hT+0nyoFXZX6aZUZ/ne8YbtlBGKQ9n2Lu3L9E=;
 b=GHYyjgm6ssArDgTrLO4OXXZsYBnJVS86zKFAvNZQ4MecAwIcnkHbqUPMDPYjeH2GixraVs7Ht6fjhHAqNjXzA9LZp/Nx5WrV2pRjJMm1Q7Ldy2ehxmCJJj9fksSrB+gGN59cTpM9BVH0kNdoJJxkfgEw17kRTqshPt6GHNh9hHc=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by TYVPR01MB11099.jpnprd01.prod.outlook.com
 (2603:1096:400:364::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Mon, 19 Feb
 2024 17:39:09 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6719:535a:7217:9f0]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6719:535a:7217:9f0%3]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 17:39:09 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Marc Zyngier <maz@kernel.org>, Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>
CC: "tip-bot2@linutronix.de" <tip-bot2@linutronix.de>,
	"apatel@ventanamicro.com" <apatel@ventanamicro.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-tip-commits@vger.kernel.org" <linux-tip-commits@vger.kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "geert@linux-m68k.org"
	<geert@linux-m68k.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Subject: RE: [tip: irq/msi] genirq/irqdomain: Remove the param count
 restriction from select()
Thread-Topic: [tip: irq/msi] genirq/irqdomain: Remove the param count
 restriction from select()
Thread-Index: AQHaY0xEHQLbVUfX4UK7vyFU3LSMSrER3V2QgAAQb8A=
Date: Mon, 19 Feb 2024 17:39:09 +0000
Message-ID:
 <TYCPR01MB112692A2801DFD822EF124BE486512@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <170802702416.398.14922976721740218856.tip-bot2@tip-bot2>
	<20240127161753.114685-3-apatel@ventanamicro.com>
 <867cj04fcl.wl-maz@kernel.org>
 <TYCPR01MB1126923108E3966F53FF479F286512@TYCPR01MB11269.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TYCPR01MB1126923108E3966F53FF479F286512@TYCPR01MB11269.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|TYVPR01MB11099:EE_
x-ms-office365-filtering-correlation-id: ae4eff75-b10d-467e-ce04-08dc3171ad6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 AINxzDi/V8r5UBPaIYD0Lu9hQlj/QTiBzFZ2UTQtgUowJJQ4Zc1SI49QHCpdlQisNcMhT3Y0k3+2LYiKc37SoUmCDsE5kcnloA8NbOniEFPS0l4bYKnPt6B6XF6J3iURW/fEt9ZhLKBznaVsCKvDbgNG5Wrxpfta6Y7Rw89l7jEU3lNo5U+E197elcXOJ2OjAEkcdzcs7l6gxxD1xVBDs1Q0KAD8fkLhrw1LywUSCiBM/vtsM21tSjI1KbkhoxoYV6yLKW41LAfZKPwcgL9mbtvf0xPzk7iOBfX6KjC7+nM4aOX7ABW5SUDWHsYXhcmfLpS8c5P/eE1t4hWwaPwVNxrV2+4AntfgmMYqoo7GmtDGFPGidiI32XT2l3zD4JX08VRuQnhql8BwEMzQDurtXA4x/YM6wcC4Rhs7C7ghX3FXtiGZM5fY0wmyaiYo6xgSoCU4myIKW1WZLu0dINdLsD7YaULhnqSFGjnltCKkbfmUIbbAtL5bIGPyZDoA8GVBnxFRfyZd/vqV0gZxUVw7cSzelO+BdnifVVGKJ41LgSWGa9nJz588Du7i+3CujQNnwfN1MvWpfbDf29yB/x9BL+Z8hqo3H2MIQpaWMEk3eghc51c7VEuhJfPpL2kDfBxX
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lW8xjWhQO1jeD7bY5sYqvUgjnGNU2s1YdKgI4jJDZiHcCsbNtyhtE6oQhPYH?=
 =?us-ascii?Q?Lb5GCBjirWIztyWX+UaJU6xpmPwuYOTYHfCSf1GCvBHFOLVe6kZOEpMf2Mh4?=
 =?us-ascii?Q?CF3RSUUeVJZ6ZnIOhvGcdvWdWlp5Vuals8Te2jHskmbs96DyZOZ9AhJltqX5?=
 =?us-ascii?Q?N5GUtiovykHL/IucBVXB+AMMUbFFMCm5Ed83qTc5aowBLoqIlUO/jwMhCyta?=
 =?us-ascii?Q?ulxTR3Vpfq2eAc4V7hoAXP1jbbpBnM83OhT39XMD6MLW+ujF5Uow4b2aRF23?=
 =?us-ascii?Q?eWN6tp66ewtYU5EMHJgzXPzgWDDD8Vr2eEWKjz5a5rKOhiKpdkmDnlXsAsMa?=
 =?us-ascii?Q?CjhXgrfNWeYcByQj11F7Ag2HI7EdggC5b7qzKiSWoFwHyaB5GX63q1QwspZC?=
 =?us-ascii?Q?05js3vMrX4pcCuP1Emj0OKBAiHkOv6iqbnKyiumJrSPUH2xKL1RU/CsPm3su?=
 =?us-ascii?Q?CiG+r1eGE+rt3GtCpNbmwtNzoOk9KwkSq9y3SjB5bqmdywfK0GNWd/0MRQCw?=
 =?us-ascii?Q?IS8Rixo7ksnWakmD+LWuZv6HjMcaSRa0etgRsghWTqUxf8loZtPWNxoHxZI4?=
 =?us-ascii?Q?KxkAK2kdcersM3uor0+inKYyEMp1+5O8wrXEt6CEC6wFMKxv0Wuisf+bsd6u?=
 =?us-ascii?Q?W2Xy7SLVDMYqg+wOSoXCJPrT22QxC0zHMPQeQfYSLm6z62GsgUrcB+zOXs3J?=
 =?us-ascii?Q?RXlU9hD0aFExRAe5zw5vsTsmFoTcvXbu9mSdcL++/6e3UKxs5e0xTh3nQEOM?=
 =?us-ascii?Q?ypFXCHx3fI6CtPmW96kauz9abYdne01+1COz5I1gUESqryVpGQ8vFKWnTg+V?=
 =?us-ascii?Q?cQy/TH3GbuGardJaYcOb6dOZDBuKcNldoXtDU4YYtMEcsuCsgQEnBQrwh5FF?=
 =?us-ascii?Q?yOi6x7qUZAaefJzUyH/lPternyhJ0u5piOoD250obXzauS0OHnsOOLwBitpk?=
 =?us-ascii?Q?7oa5CqOp+HPB57RWzf8fohMOTZbZ7kfcsI/ldCV89DVx18s3B5JMVthXFZmU?=
 =?us-ascii?Q?7+ZG7rkn8JC578q9TbYeYQeGZIpVG70bgRDBramTPwh7Kz9vQNCtFr+M7r7q?=
 =?us-ascii?Q?I8wuXUCD1RZRIKzn0vxZTXRUOeWj0/xtwRBDBnXjpLC1Tb2rcGBUHwTwu0yL?=
 =?us-ascii?Q?DoWuNBnkAO3nBPtzz00EBsYB2NdI1uIvQ7PX+8yJ9VSLqq7/PUY7+VoheynG?=
 =?us-ascii?Q?JWz3cxtHBXu4QGP7VG8Ux+6HlSjUp1yRVD3cJ7sIZ3xzp/omPmQeTlUFVZBB?=
 =?us-ascii?Q?XFjLa9al7shZNn+JEqZqWkuh7Ip3OSHwQcf3btYJi+ApN2PXdEGI1rPnFkqh?=
 =?us-ascii?Q?19SsBUN1vocg7pBV7hGFHEZJfCxhhLqt38XbC7DSadBdx7G1JDH0kx39bJGx?=
 =?us-ascii?Q?DjWb+6lMvthdnpYoNbzrDK5qMbeCiDrxPIOJ+ZVzJNqqOB+DCiSgWiRTIo83?=
 =?us-ascii?Q?tlNHU2c651smfTiKPy1PqFPgbH13lY8o7vzvXUxLY7viGSfR7Ir7a0j//tH+?=
 =?us-ascii?Q?DkbXlSjZNpPXqNNO6neWevYvIvntXYZopHi1tK4c5PgvA3En8lsDXoDYIEOm?=
 =?us-ascii?Q?F6HVkEdND3A5fOUGtL6X/2IrSDQkFcw4xoFl6uzuBUXLJjJgumCIKGQHk9H/?=
 =?us-ascii?Q?Mg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11269.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae4eff75-b10d-467e-ce04-08dc3171ad6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2024 17:39:09.0186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UpiFmq7Z8wsE9zKSIitbwuZ1qAOVHe6vgs27ZiGsh/n4tibQLorbN7QwOERK+BT3OCRKMYVuuTFjBPuSVPN8xTObzdW3l7DPaGlmw290hgk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11099

Hi Marc and Dmitry,

> -----Original Message-----
> From: Biju Das
> Sent: Monday, February 19, 2024 4:39 PM
> Subject: RE: [tip: irq/msi] genirq/irqdomain: Remove the param count
> restriction from select()
>=20
> Hi Marc Zyngier,
>=20
> Thanks for the feedback.
>=20
> > -----Original Message-----
> > From: Marc Zyngier <maz@kernel.org>
> > Sent: Monday, February 19, 2024 3:57 PM
> > Subject: Re: [tip: irq/msi] genirq/irqdomain: Remove the param count
> > restriction from select()
> >
> > On Mon, 19 Feb 2024 15:50:36 +0000,
> > Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > >
> > > > Now that the GIC-v3 callback can handle invocation with a fwspec
> > > > parameter count of 0 lift the restriction in the core code and
> > > > invoke select() unconditionally when the domain provides it.
> > >
> > > This patch breaks on RZ/G2L SMARC EVK as of_phandle_args_to_fwspec
> > > count() is called after irq_find_matching_fwspec() is causing
> > > fwspec->param_count=3D0 and this results in boot failure as the patch
> > removes the check.
> > >
> > > Maybe we need to revert this patch or fix the fundamental issue.
> > >
> > > Cheers,
> > > Biju
> > > ---
> > >  kernel/irq/irqdomain.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c index
> > > 0bdef4f..8fee379 100644
> > > --- a/kernel/irq/irqdomain.c
> > > +++ b/kernel/irq/irqdomain.c
> > > @@ -448,7 +448,7 @@ struct irq_domain
> > > *irq_find_matching_fwspec(struct
> > irq_fwspec *fwspec,
> > >  	 */
> > >  	mutex_lock(&irq_domain_mutex);
> > >  	list_for_each_entry(h, &irq_domain_list, link) {
> > > -		if (h->ops->select && fwspec->param_count)
> > > +		if (h->ops->select)
> > >  			rc =3D h->ops->select(h, fwspec, bus_token);
> > >  		else if (h->ops->match)
> > >  			rc =3D h->ops->match(h, to_of_node(fwnode), bus_token);
> > >
> > >
> >
> > Dmitry posted his take on this at [1], and I have suggested another
> > possible fix in my reply.
> >
> > Could you please give both patches a go?
>=20
> I tested and confirm both the patches looks good.

Please let me know the details of the final patch, so that I can test and=20
add tested-by tag for Renesas RZ/G2L platforms.

Cheers,
Biju


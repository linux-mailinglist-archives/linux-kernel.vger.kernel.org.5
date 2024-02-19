Return-Path: <linux-kernel+bounces-71694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC31285A915
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31B451F24A85
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421D3405D3;
	Mon, 19 Feb 2024 16:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="LF32fE3b"
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2063.outbound.protection.outlook.com [40.107.113.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69047BA4D;
	Mon, 19 Feb 2024 16:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708360764; cv=fail; b=na85DeOFQhuu111HES3AEgC86EEE3TdglR/oXxLgx2AOcaJ9vXsIKA1CM7ruENheoEMK9nQW2Fxe9mN7Xn8ZWOlJP+DCnPHTzMIyUvcP6olK6LS9Szk/Hd674HbqNeCujtyHiO0+YU7/pZFjvwRZwJtY1LRrIEPmbJMcT4uf7xQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708360764; c=relaxed/simple;
	bh=PsxM3i5YkLIiyMUQTdfH4SV57N9AMTO/VuZZOai8HY4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y0b5PcxZqeedK5/0lwYMeM/LtaMiMByZulrJlwJIllm5n4kY516uK3R95cRTTTDpRWNOhEEwezfcUfNRU4b/3/UTxE5GkYHdXkB7J1Tc8uJlhDKRWLNuyFSlrM2udRJ8MRrGv5CVQjiaqzKsVmEHmNAfTFSAkup/QiM7Y3Azmzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=LF32fE3b; arc=fail smtp.client-ip=40.107.113.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/mj53K+O6cyitRJJDrAgXeAc9x9ENm12pd8RCgZZByFXIaGtVXLwGm0fx6JLdFuErGCSU5AH33ksH7H8lIB7W5/L7Ti3bpP9esnqFqfLod9XTLNmDXGiOoq/gEv74OBqIfoFBC5k3oE1a8KxNGKYx81+PvzhHZ2eX11534qI6jRdJqA5T0BgsrEbSvDd3vsDeyHCTYSUQvXpHaqDU4hZSPqPnaNT5tjBwAM8rGGov4LOa3J8eAhPNNddDrEGu4rW5iNB3+9n/LsyIPOcQR8HdNiL0lX8NjKPE0DYdNbJrW54rpymzFaULjjWUM2yFkeL/hKBrkHhi+AVsA4cIDefQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qwd9pzNbURRLcpR2SdIP6TnvdArF7ZwUdW722siwo0o=;
 b=U5GRHuq95591ufVnniA/uUCLKOWEDzgBQYX6WaBjKShY2V3ZyALygJMZM/swA9kQtZSNonqNMFcO2FBn+BD7K8cKe7cqpU79dIxnTuIN2uNmGyaZbFoBCoN2nGPuO5qD2gv3hS+afI1p6fwgb5on4u4PQPu0tqLZ59E+w8bLcK549ktcQ6o3+0H/IPHpToSyKFcUfOyiLkimOUvHuHvcEgQfz1xQ0Uesk3N8J3ImzdjrkA05x1F4rLxEn/0e2MrsWWfmiY01M0y5JUMGybPr3DLS8pvAdnd5bxg06Q66p/5phV6j1d1iHfle1Lq2Hk0pTKkR4jjnf8cKeTJRirvzbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qwd9pzNbURRLcpR2SdIP6TnvdArF7ZwUdW722siwo0o=;
 b=LF32fE3bNCTbPxY76CGYnx5fNLkwqkqcbrRjYS2GsyDfD8p8xPMgmMNrciz12Fvb5ovcCBcGfnUSPpn/hM160tajsMNuJWPdjXusD9iGo0tiJB0Dpw0bClTkygIoNW8LlOt53mgbr/MGKJpd41GPY8yhXXjhuK9qh0E0d7PANT4=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by TY3PR01MB10906.jpnprd01.prod.outlook.com
 (2603:1096:400:3af::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Mon, 19 Feb
 2024 16:39:16 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6719:535a:7217:9f0]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6719:535a:7217:9f0%3]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 16:39:12 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Marc Zyngier <maz@kernel.org>
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
Thread-Index: AQHaY0xEHQLbVUfX4UK7vyFU3LSMSrER3V2Q
Date: Mon, 19 Feb 2024 16:39:12 +0000
Message-ID:
 <TYCPR01MB1126923108E3966F53FF479F286512@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <170802702416.398.14922976721740218856.tip-bot2@tip-bot2>
	<20240127161753.114685-3-apatel@ventanamicro.com>
 <867cj04fcl.wl-maz@kernel.org>
In-Reply-To: <867cj04fcl.wl-maz@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|TY3PR01MB10906:EE_
x-ms-office365-filtering-correlation-id: 78a47f1d-f770-48a3-07bf-08dc31694dc1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 DBILgGjTWK7wGAXj2qmuIZ53XgVZZYJWh/319qPP/+hMkL4s9R0b3oU1JLQ/TCLAZNXzow9jNdwgxzHWDztM0Bex7qNF6hpixrdn1+tzc8k/69+2mvhfoRavQCNOIzKWr003MU6fJPwLrJcFUAvcECeKIw47I9FFoWVndqME8dZ31cC0o5O1mZgRLq2xsiOgrwaHWF0mWDkY/+K0OEXI+F0fX48hbSrFuBpIHr0HhVR5WF9xOUGgsciaEXaiiA688Lt+Kbycrz4tt7cRCYgEPLQ3wTJC9mRFM+YHyoVR+Hvzb3IKii42W7BhdfI72DPafrPGthTr+BuBwzT06SSgU/dCATS9DCl/XQsD+FYIZNTAj2+hPfL3tZzfnzAzwqcBsLplvZ37wP0+1ZfRtp1/Kq8r2ZoTaCsyu18ZnYc2hcGIjMXfr/zJf0b2JAVScIPEp7tIUszcKjRpQfn209Gr4NmJtGQCFLZ6cqXw4qWCNZjwJhFAgFrH7mJuAEAdOBnpXzAFm4NA8CmBq9q1giq1fwOn7RX6aeJInpXfVztNlbfpjYGuL+X4UDCOG5uaF+SWAtPPxS+wCZyQLksW3vtpvSUt7qmJV5C2bzGlMVjIoX1m1ryaVLrO16pZxcrahQbL
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MoKbUD0i/Rwup+VwL2VcTB8/2YoYqbxZOqkMxAMkmU2MYjt2xLxIvTnwaiZJ?=
 =?us-ascii?Q?yQEUHLnQEIB4VKLIH2y6RE3Afu1+AwlPwENM5fMj/liGZJJTC9kyW6z1TGVZ?=
 =?us-ascii?Q?k4hYkWOVnR2cmIZd+VG+rqCBg5Dj12TGcIiKXuV0L3TVeAxeYuadBATfFBbZ?=
 =?us-ascii?Q?7Mr3F8W7MFL4/nARluUHEAK1CWApJOaPfBqEXcExHKGhvcxcUHXzM69PfNf7?=
 =?us-ascii?Q?n5YQvdhQx+u6fv3E8YAlW1G4mwWrSsVGClv5ji/MIGhVRyr8XqNbnl5oZkZr?=
 =?us-ascii?Q?+qruLYva6M9rxV9sLZclIhX8qQQ4Ionki3qkmTTfr/APnFe29IWVcphcNrvK?=
 =?us-ascii?Q?XcxmvnbveWYQE9N9v4F9MIq0Le6ORx48q6PK9I+3/XyVSV7gZ7c/5qxmbv2w?=
 =?us-ascii?Q?0CFs9jQkdTsypCHbgX9xfvTAUfhwsQdWOFu0kVOQdFPMw4gZau5mfB7QFmnJ?=
 =?us-ascii?Q?tHB40tzcvjW/ohTMmh74nuLCYvL+JQBnmzeyDbdu3WZfviaiuofLcy66brEj?=
 =?us-ascii?Q?VA07C5fRa5ac7MsZbN9/KaVNTkGLER2YaB8FlCA5fvdkSaj9Uj+1rYWayX0i?=
 =?us-ascii?Q?GLyihBQWR4ayHnhLcX7M1kavik64RNiBE20cM9XVunOsYHjNdWrOwz1fx1tK?=
 =?us-ascii?Q?4clQUbJIlrKrsNVW9f63EHZozlYdeQozJzOI54T4ANknS/XdAPOcRBXvqhOE?=
 =?us-ascii?Q?vq2HnLVS47/qwRyOatfHC1izCHgs67ERVGboCSZ5voyICwqGSpztMmSTRy1M?=
 =?us-ascii?Q?W+Ce+IAJNuBG9jKmRtH0DGGTKDW62bgb/8WpvKviUFAbsqTHHGEK+ndr5cZJ?=
 =?us-ascii?Q?7umfj1VC9UJpE79d/VptQTUYTuZ774FSHNCzKUocOip3sGmI1LkD26T4P0Id?=
 =?us-ascii?Q?Af79nJ5nLPxIkvJL8YIpOkjyVH/lL0UYQYrT6GHp8COKxh2JUTRpDf3V1fer?=
 =?us-ascii?Q?PHw63KU+fOueW7XioTJfVgIecxYgo7ftBhnQ11c+GqgTZEGgaHwvfVrwfczi?=
 =?us-ascii?Q?1ktnmlH5cKVvk9z+a0861dbo7A9REWRUoVS6Mj7wpwmwR/+4rkr5tb8DGPDe?=
 =?us-ascii?Q?7DntsjSbP+o6Y6PUtOrPvROCsqi57WuqUgvsGoe4yL/luXFZm1jCU5Hg0HzL?=
 =?us-ascii?Q?J2F0QQLK08hJ/xNdXdoPnS/3mPAERGS9nmeK3h9MreDJqYzqcp2Msrc+1emi?=
 =?us-ascii?Q?ugTdwKl7Yq/g2fm7paOaxrw9EqLVtRZ1m2nZYDkWq1EiVva6KvaBvzjjrbX9?=
 =?us-ascii?Q?TfqN0QdkAy9vl0CwDgha3CHpN5EmTwZnGTqeMKHsSi2uW0b/lAF6ROLJ9e14?=
 =?us-ascii?Q?WZ/qJmt2puCqe6q0YPRpsQ2Gl6DovNbBBeV8aKHXPOjzIHVLZoSvQ7te+f+i?=
 =?us-ascii?Q?vgVkg18Q9loJXNdc5YOe1UQW7P8LlnLRNY4hvNZ35qdf0vGyE75H5+pmWODA?=
 =?us-ascii?Q?OsZAQ1P06p1D6I1zCslramlAcl85hEp5FHufnpp6c7eefYKSNn9+twvSaV1K?=
 =?us-ascii?Q?od+vE6YoZBmk7LAlEp1ZyOIKLbwRAIW7pfRVy1uB3EnlMU8PPUihIm139OVB?=
 =?us-ascii?Q?Be+zwho7s7qyzHOIXrLrY5Duy27oL72PTB0WWTA0BIvlI0GC3iZxc9gcn5jM?=
 =?us-ascii?Q?Jw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a47f1d-f770-48a3-07bf-08dc31694dc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2024 16:39:12.5483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DUys9nRVtyXNMoPgopRBF5fX6sqcC5Vayw0e2B0MQ9MdF0BcRpEMOLPOwOQ9zE2Ua9eTRIzJhgM3mepONQHkCgqSS3mQx1NAGZ5gou8mbEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10906

Hi Marc Zyngier,

Thanks for the feedback.

> -----Original Message-----
> From: Marc Zyngier <maz@kernel.org>
> Sent: Monday, February 19, 2024 3:57 PM
> Subject: Re: [tip: irq/msi] genirq/irqdomain: Remove the param count
> restriction from select()
>=20
> On Mon, 19 Feb 2024 15:50:36 +0000,
> Biju Das <biju.das.jz@bp.renesas.com> wrote:
> >
> > > Now that the GIC-v3 callback can handle invocation with a fwspec
> > > parameter count of 0 lift the restriction in the core code and
> > > invoke select() unconditionally when the domain provides it.
> >
> > This patch breaks on RZ/G2L SMARC EVK as of_phandle_args_to_fwspec
> > count() is called after irq_find_matching_fwspec() is causing
> > fwspec->param_count=3D0 and this results in boot failure as the patch
> removes the check.
> >
> > Maybe we need to revert this patch or fix the fundamental issue.
> >
> > Cheers,
> > Biju
> > ---
> >  kernel/irq/irqdomain.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c index
> > 0bdef4f..8fee379 100644
> > --- a/kernel/irq/irqdomain.c
> > +++ b/kernel/irq/irqdomain.c
> > @@ -448,7 +448,7 @@ struct irq_domain *irq_find_matching_fwspec(struct
> irq_fwspec *fwspec,
> >  	 */
> >  	mutex_lock(&irq_domain_mutex);
> >  	list_for_each_entry(h, &irq_domain_list, link) {
> > -		if (h->ops->select && fwspec->param_count)
> > +		if (h->ops->select)
> >  			rc =3D h->ops->select(h, fwspec, bus_token);
> >  		else if (h->ops->match)
> >  			rc =3D h->ops->match(h, to_of_node(fwnode), bus_token);
> >
> >
>=20
> Dmitry posted his take on this at [1], and I have suggested another
> possible fix in my reply.
>=20
> Could you please give both patches a go?

I tested and confirm both the patches looks good.

Cheers,
Biju


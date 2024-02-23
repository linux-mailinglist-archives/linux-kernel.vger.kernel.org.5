Return-Path: <linux-kernel+bounces-78191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3DD860FFC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D04B0282486
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D3C2E417;
	Fri, 23 Feb 2024 11:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="QeBeL3Bp"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2040.outbound.protection.outlook.com [40.107.114.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3D6241F9;
	Fri, 23 Feb 2024 11:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708686084; cv=fail; b=mjF6UXWWXFwAMzwvTRv30UDssAaz29PAlRqBu6nDk2aNZLsKRP3bLgBozXzXkSSJSysH7EIiDneSI4p1x73eSjJfAoqnlv+73UpHYZnqpRjH1LMrwmWbXMR/lNetEONU83ZjQzf2McsXtKPYoR2v16r2YkBfq4ywG1ht/lbQfa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708686084; c=relaxed/simple;
	bh=/57f/DFonL3GVbiWCToBgDcMCv0QxUP7Hq8s7SFnWz8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pFyow1nIc4g9ee3m53otTFeEI9bFBNhTNfFaaL8jp3q079rvqEGdieLLEsNfiuLFwujRGiLHjrlI9VZDL7vWLjNdFJvR2tHuIr5XLwkxjPF9Ak2ZwYu3vZE2/s2sSB7fed0w+4+1e/9/nRWCvR5b/bbd1CxsJP7fHlg75sXgn3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=QeBeL3Bp; arc=fail smtp.client-ip=40.107.114.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBu1dZutIsI5Bp7YUkCuBbZEFshc6ovOhIiR/hmNaoIVqzuIJIwhjJiTwuDdfPEs8AVbvAyrCiv2LCELtI9tUaeZYq25v/PCc1YabuVhm3PIVDwCNNeOdJk05uyhFsCtHF0dgadChv/aIEA7xD/WqMnFPyxeD6azqktT8/CT49B+Lz7EpnU4XfPsBxnfOXA0hFrtAiNWc9GMsh9k4DQ+fnkhXh0lAwosIR1uFO3lE5q8dlFrUgWPcyIK3L3B0D6bM9Nbg0mrRDq7GwGgl9ebjbRM1ZnkVriH9WnhM7qYcJvY6ta5ZjKJ8M/D8PqyIgxMTFtWBQ0AwurmDUZKoVtg7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q614cY1iCuMg131Uqrgkpu94aKn4lGgmM3cnkgIwHVk=;
 b=CTFA09kCF/d9ocktvefhdk75RL2An31rYUaELcYQWLJjvZl1d2jwz6Fj9CM5Ryfg+MfdjijtSe8Pvs3nqWyZ4DPzj/khYFFHyuxfbxbgxSVu2kFbcD4Nf32bvxROjNewAEBgRUVPCRk6Bpb+f+I7GfB1CQRLWc6W9Zy3Qx4ArBP10SXzEVy6RBOn0q7pp0p1duDWk4Z79CrNCiC92SLi+kGJ/9GUbEJhj90HpEQgsRCFHiIcOOFPVAW9FZdIYtqspf48y/sd+wH4lrgV6SokEkm8sLMNI7HGveN7xKRJcfSwaAnlNQVLB5CYmjelxWYOjFFRCBzXdaDnTPQ0xRQpkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q614cY1iCuMg131Uqrgkpu94aKn4lGgmM3cnkgIwHVk=;
 b=QeBeL3BphQeFJkaNn5JDvEDTGJw9uxwKnhVZK++V4NhLwAS6D6CVB3AUKKO+BiujsgsCXetrAFkngMObg0bd0KirEaiSKzJNwnETKck/Av+yRqDq4CgR0sLXhpPxOkHF8LRmwUqh3b/cmG26S3OqMB6Ps5ixoYGxnFAvomfbyFY=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by TYWPR01MB8283.jpnprd01.prod.outlook.com
 (2603:1096:400:164::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 11:01:18 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6719:535a:7217:9f0]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6719:535a:7217:9f0%3]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 11:01:18 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>, Anup Patel
	<apatel@ventanamicro.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
	<paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Frank Rowand <frowand.list@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>
CC: Marc Zyngier <maz@kernel.org>, =?iso-8859-1?Q?Bj=F6rn_T=F6pel?=
	<bjorn@kernel.org>, Atish Patra <atishp@atishpatra.org>, Andrew Jones
	<ajones@ventanamicro.com>, Sunil V L <sunilvl@ventanamicro.com>, Saravana
 Kannan <saravanak@google.com>, Anup Patel <anup@brainfault.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH v12 02/25] genirq/irqdomain: Remove the param count
 restriction from select()
Thread-Topic: [PATCH v12 02/25] genirq/irqdomain: Remove the param count
 restriction from select()
Thread-Index: AQHaZkJDw9NLoYRbNkuhzQYScggLGrEXvPCAgAAEdwCAAABXsA==
Date: Fri, 23 Feb 2024 11:01:18 +0000
Message-ID:
 <TYCPR01MB11269D56CFF46F731F932245886552@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20240127161753.114685-1-apatel@ventanamicro.com>
	<20240127161753.114685-3-apatel@ventanamicro.com>
	<CGME20240223102258eucas1p119f38e40f769c883c0a502e9e26be888@eucas1p1.samsung.com>
	<481aa3b9-55c2-4ccb-bb4a-58b924d77ad7@samsung.com>
	<TYCPR01MB112692BF27640D12CEF5987BE86552@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <870534fc-eaa6-4da6-9180-a051443fbaa6@samsung.com>
In-Reply-To: <870534fc-eaa6-4da6-9180-a051443fbaa6@samsung.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|TYWPR01MB8283:EE_
x-ms-office365-filtering-correlation-id: 2ed49418-a8d1-4a61-8974-08dc345ec327
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 dvphegWgH/64zNP3HzOhTqMU12IgRXmpXF7PAX+wVDbK+IVNpG3yet+hFbiSp0XuuIsIC6dME0jIadNZJXk78KkkMXRqlcTVtWgtdASlvi3utCht3o4NzJTK8Xhgn1KE/zwZL0EgXHxX8oSmVacAdB6Ef7kyNurZyv71K6Y7jY2cuUUfAD/LNiNWUwlLCMeFtlYdhrgEbYxydPZmUFx3vSRdE32MFDYuVYEGpOAgN3LriHbd45dtO0rWxElXxXiczLcoBWxiHLZgsKYpjpYXwfwOfJcoVCJh08HCPUqUCUZaX9ATyW0sMkPYIk+wocPUMP5auGMSbAXlJM+QaL7tncQFCn+PxxXHOXkJbLU6rrQIFvarhvQX7F31fJIRTtWX4YLeu1agQ4KXYE591DZeAL3appMRjhUYiuGTSZKBlz7seVmE5VtEURZHA/spRU9BDfARULup6KOZ2gGuvAySt56dnBr0hUmDTmCpY//XhVv6S0OVS4l5ZCPF303Hxne0iZn1ZLrpvSY3vlKtAfF1iQKg3PqsFXklvCr4oZZ6I7G1e4tq7i0AMV+h6mh9J2oAFYYbZXi5JR1jSkig/BBOsHP1NreCL59aG5JPJJrjoKYCyD6ppDRD2nEVd1RbWHb7
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Ry55aUs23CCfCLFHXwGIJyv3daKvuf5/apKqzRCldti9oI5EuoIUFbYzxU?=
 =?iso-8859-1?Q?aRQyb8cS893c3K65FfIx46Fgrs0NmyWjkZ3aYEsNwvetCt45aJ4zRtuKNM?=
 =?iso-8859-1?Q?xpn/5lmlfq0AvHnmSRiuuTqDjmFykM3Vxe7JM451Pxi6UheMYG2lAWJ6iX?=
 =?iso-8859-1?Q?vhOqJRyjdFmkBpaUym3jhqiLcoyN5MVwmBfmE8LGVaEuueMy8563stnKyO?=
 =?iso-8859-1?Q?nMZm/b87PVd8ugcRoTibo6quErNzBCVBxNIySM+Ec6vnN0i+6ZgAGDXH89?=
 =?iso-8859-1?Q?whIfiIUWwNth0OLV0bnx5Cqb5vu85X6xfr9paMIl15gxjO1Cm0YniI5xoV?=
 =?iso-8859-1?Q?FXwadRmjXBnEkZIoeef+2VcOBs0ebPaYGDfqL44XcEgoW6JTWNDdjBamUO?=
 =?iso-8859-1?Q?DUPiiWjhA+w9Ln+uVYlJSZpwtN8ckZDUEDNe9MNiO5Qn1YHMLPmj1o0RHR?=
 =?iso-8859-1?Q?20mRxJI06tjT+sr/13Uv2vLo/BWcOC+6SEuRA+zQLAq6lvuGo2Ad/R0S5e?=
 =?iso-8859-1?Q?1pxWFYTK5A7+d/rj4n2FOnfTiZXS19U+o5Uu9uWgIbNpiwZlVgjBWizT6T?=
 =?iso-8859-1?Q?O0FSBoSQ2vO4clyHxMxDVRe/8BH69Ig4ixz4HU5vr4myoGGop+rFrhojJL?=
 =?iso-8859-1?Q?GlttCf1VS5Cq+szp9pgOi9CE0XxeHOhTcS401FA3vCLr4sm5rmZmh7Rnck?=
 =?iso-8859-1?Q?yFSmVu3Yi87K4Sq5733tFrROLHP+wMNmH4SoVxl+NDNzFkDv+9R9woPthq?=
 =?iso-8859-1?Q?VMvW5dWzNFpXGSVmabcr/x8nym6YRXRxmVOanA4zUt/KZPQyGq4MftbZ+n?=
 =?iso-8859-1?Q?8DRKmkKaezMYhXQKTCQmley5+yyBj6zNsNTfKtomtiXUPa3WbQAgpQReFp?=
 =?iso-8859-1?Q?ebPjkRTjBjabRd86Lm2z1DnaW3iSDfrgfyZmd97rwSyq73+ct3vc7PWdOB?=
 =?iso-8859-1?Q?U4n3Rc/oV4DVFEg07gYzrdcwo4qFmIFgjQHzqPr64wt2+0g0Ly2TXF02uz?=
 =?iso-8859-1?Q?5bL1ak98TWjwmQUXZhS8e5SACuDbi9PJkqCu3XEtpuI32yJRt7KGmSgjIu?=
 =?iso-8859-1?Q?f6OudMaAM9Hh0rdvV4ly7/C0Q2SLe3kijFf3Sn7Ymi8vOlfC2GTSLCjeEG?=
 =?iso-8859-1?Q?Jn0wh1Qs1JEztokXeCq2hD5c9F0C9Dvxaeow9GGhZjQBHPcz386MF2OM7n?=
 =?iso-8859-1?Q?oj2jzpWM3yB4UQrfNoMbNXtsKL1VZ7IR4ZrKXauiHoXltocc0jXpB3MFo3?=
 =?iso-8859-1?Q?T5gdnjwKvd9WVDx6xgI4cvt2whUy7A+YMjkBKFMD3cmoTz7AdD3R/2xijN?=
 =?iso-8859-1?Q?yoVRJHRtWU8BoG+L4hZ4t8XZ2q27jjNKXHfxkl8eQNvXkAIguRJLAnlfkK?=
 =?iso-8859-1?Q?mlA6GaWJna46qDnPBeS/ktRPND2xZRtjRQuTcupTL5Mrgn/4sYHmzR5pVr?=
 =?iso-8859-1?Q?wzwE7VzGcgY1zcZ7m34kDrMTz7qO7IiC1xdWeNMkoKWVeAjYkHSjRrUPXf?=
 =?iso-8859-1?Q?8pzZBKkHykuzL6euPtm3w9nPbYv46vkAwV1uRkH5DC8zpNHNnKBYFY0Uuz?=
 =?iso-8859-1?Q?mXrvmfYCFKIyD2B/hpU7Na4OgBfrNfwXKwlv+sCrAf1/1h7JCpkChDGtv6?=
 =?iso-8859-1?Q?Ok8x14F4jrx0G6wmsxwGQqeZ5dgewuqGv03Z3coKLKyNsapMPID3Tplw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed49418-a8d1-4a61-8974-08dc345ec327
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2024 11:01:18.4890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8yQMKd+Nc9rLcGm3SUYZzNLSDT2qqE3gjN8RhWJEtMCMGKQBkT5yiVH/vL5byqtufPz/a37GOkxJLWmdc9AoGwqNWhxLIv86dUE75OSB4uE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8283

Hi Marek Szyprowski,

> -----Original Message-----
> From: Marek Szyprowski <m.szyprowski@samsung.com>
> Sent: Friday, February 23, 2024 10:57 AM
> Subject: Re: [PATCH v12 02/25] genirq/irqdomain: Remove the param count
> restriction from select()
>=20
> On 23.02.2024 11:45, Biju Das wrote:
> >> On 27.01.2024 17:17, Anup Patel wrote:
> >>> From: Thomas Gleixner <tglx@linutronix.de>
> >>>
> >>> Now that the GIC-v3 callback can handle invocation with a fwspec
> >>> parameter count of 0 lift the restriction in the core code and
> >>> invoke
> >>> select() unconditionally when the domain provides it.
> >>>
> >>> Preparatory change for per device MSI domains.
> >>>
> >>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> >>> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> >>
> >> This patch landed recently in linux-next (next-20240221) as commit
> >> de1ff306dcf4 ("genirq/irqdomain: Remove the param count restriction
> >> from select()"). I've noticed that it breaks booting of Qualcomm's
> >> Robotics
> >> RB5 ARM64 board (arch/arm64/boot/dts/qcom/qrb5165-rb5.dts). Booting
> >> freezes after "clk: Disabling unused clocks", but this is probably a
> >> consequence of some earlier failure. Reverting $subject on top of
> >> next-20240221 fixes this problem. Let me know how can I help
> >> debugging this issue.
> >>
> >>
> >>> ---
> >>>    kernel/irq/irqdomain.c | 2 +-
> >>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c index
> >>> 0bdef4fe925b..8fee37918195 100644
> >>> --- a/kernel/irq/irqdomain.c
> >>> +++ b/kernel/irq/irqdomain.c
> >>> @@ -448,7 +448,7 @@ struct irq_domain
> >>> *irq_find_matching_fwspec(struct
> >> irq_fwspec *fwspec,
> >>>    	 */
> >>>    	mutex_lock(&irq_domain_mutex);
> >>>    	list_for_each_entry(h, &irq_domain_list, link) {
> >>> -		if (h->ops->select && fwspec->param_count)
> >>> +		if (h->ops->select)
> >>>    			rc =3D h->ops->select(h, fwspec, bus_token);
> >>>    		else if (h->ops->match)
> >>>    			rc =3D h->ops->match(h, to_of_node(fwnode),
> bus_token);
> > This patch looks reverted on todays's next. But there was a fix for
> > fixing the issue you mentioned [1]
> >
> > [1]
> > https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e
> > .kernel.org%2Fall%2F170844679345.398.17551290253758129895.tip-bot2%40t
> > ip-bot2%2F&data=3D05%7C02%7Cbiju.das.jz%40bp.renesas.com%7Cffce754120ba=
4
> > ff0f8d708dc345e1c1a%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C63844
> > 2825998732581%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2lu
> > MzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DlYLVpa4tz2fEU1J=
c
> > DDGUF6eigi2YJuGDouMXrJSlibo%3D&reserved=3D0
>=20
> Thanks! Today's next seems to be broken on ARM64 (doesn't compile here),
> so I've missed it.

FYI, ARM64 defconfig works for me.
Linux smarc-rzg2l 6.8.0-rc5-next-20240223-gfebe82167ab7 #1430 SMP PREEMPT F=
ri Feb 23 07:41:52 GMT 2024 aarch64 GNU/Linux

Cheers,
Biju




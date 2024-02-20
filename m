Return-Path: <linux-kernel+bounces-72984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F8C85BB76
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45242285ADD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B3667C75;
	Tue, 20 Feb 2024 12:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="OXbdesIX"
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2050.outbound.protection.outlook.com [40.107.113.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E7967C6A
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 12:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708431011; cv=fail; b=nKQta9qNXwtSd2LOhg9HIea2CqXa0bV8Idc9c5mUyQ/2NDgC+kK+DBmqRqz9qqyubcQCix1CAPR/EHYQc9Mj8z69duF/mr/pyxDekn1ARS8PJjoNX0R9pQbRN2M6leloqrs4WzWSKMMIEpskgqHG5uMOIeG2YraIDlJcKwWjW1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708431011; c=relaxed/simple;
	bh=pF8tMd1q3xrsBKCdljHVLWqVR7ZnjcTB+GGhtWR9WIE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jzfHMKB7HwHTjAMRVHXDdxKaG3lhJK8na1AdSlZxbsRlBCmNeMZ7/0vZ1ijrvTH3409EE422cDAlb13coohbAqbeg3LT9Hg9RJ1exiIc3YkQCcHcEWhkAGxYqzZ/U4/ury22yVGxh2A3qp43qSs1KWk/xnXpr+vidvsxs5CEY8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=OXbdesIX; arc=fail smtp.client-ip=40.107.113.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wjnu0xtkZXScs6wuSpibY2xVTRUIRaqxExzmx5vdTTSCN5SiXWsN52T8vZA9KTvxkme7ellGWGPxlLwdi1GemAVxuummHeVLvrC62g4Ui1+o2gv7kHYIrU0rFi/TfNqysCKUrxzqfe8x96FKAJSs/NCWd6htcWtfBTfJ48aVPtcvLfI/kTU1ZQC3gRrRHbA+7pvoB66L1tFAXSZ9cFFOgb1EwioL5WNeB3liDqqA/oEqeQ+Al6t9jxotBk8BxJRJ3rNK+89cCSUuCegPAFkPX47pp6tF5Fo+TZQD5Qk1U4BOUDoVGhDcaUilFxqxbVXqqoKMyslUTkz4mI8UkDN1nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxBNaVLTkJMCGBAy1YItVVwlsa+YjYJCx/5/jFsMpD0=;
 b=Rg8OVz2C2UtsrmYmb6MzPkuEtDEnMTJEEF7UruaE2+LRcg+gpI+zco5oFcTQzpbkFoo6NxOsdT8cew2YzTaKzwobyo/IkVxCtz45eEag5TlQxMzQH4eeXFlcbD/GXfUX4E04cyyKuIeKIyD7oDWWjRtOo/Wrf3gSWnf//RFitBGuEg4FNbHsOVwQF2Vg8sbI8qGb0/rBsn8j2tADiOfHA6CrujKJVzSQKKhiglidSw9oJhkUKbaO0FcZrzUiZOqZMYpsjFaqUp8pjyprGd7vMtYHt387zB1x+8jzmz7LRReYl2cl+bBGpI4KRu3EVzpGlgDTypxxurxOhIO8qA1wWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxBNaVLTkJMCGBAy1YItVVwlsa+YjYJCx/5/jFsMpD0=;
 b=OXbdesIX9ES7tDGPr8zq3BRyIv/ITflZhkSdefkXJtuPT0iNzMTywA51n6P0BPB/5s9krgbvmsf7UoNPQqg9HSbNgoC+9fTttJjMhc7SjEI9koOMCGbYPfUEaJX/qVZCDv6FrAL6MEJmX+FsGL2mQseqLHhNNDd/nO3wjjJxuG8=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by OSYPR01MB5367.jpnprd01.prod.outlook.com
 (2603:1096:604:8b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 12:10:02 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6719:535a:7217:9f0]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6719:535a:7217:9f0%3]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 12:10:02 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Marc Zyngier <maz@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>
Subject: RE: [PATCH] genirq/irqdomain: Don't call ops->select for
 DOMAIN_BUS_ANY tokens
Thread-Topic: [PATCH] genirq/irqdomain: Don't call ops->select for
 DOMAIN_BUS_ANY tokens
Thread-Index: AQHaY/KbOjxL2AVUs065o+G9f6K8uLETI0WQ
Date: Tue, 20 Feb 2024 12:10:02 +0000
Message-ID:
 <TYCPR01MB112691814D4D444C0CFB51C5186502@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20240220114731.1898534-1-maz@kernel.org>
In-Reply-To: <20240220114731.1898534-1-maz@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|OSYPR01MB5367:EE_
x-ms-office365-filtering-correlation-id: a5a094c1-b765-44b6-de91-08dc320cddb3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 mzbYJfMkCvEIaVIih+4GgJOYKmP1jLW4oKv1PcEv3s6wd7de57Q5oC6dEUpiK+qX6axdditcfkq2A3jr00roxiXTFaVZTe0i/pt9PmGzYLQ6Tm5rWnnQoaVWxWMNIk+D1HX6NCisjzewdHXi1GD5Y5KfVigDtdpPpcqE4zqi+nRBWlJZs746WCZ4xpRJ1+/GSVhJ2XRlH4cpYIrwZ1ej248Y4w1JsRhDG4wmW88zbB8OLYYwZJS2KsEruljlAAmDXF4FBh7YBM4nJ5+ap4AW+xwnRVMdbFsJ0eeXW+ckWQplpGDSWojEELKXuB5p0cgUC4VPUfZMB4aAeiznhX68+pHmF/UGzqNmY1r0dW5yNMihDXodKs4jtb4DAuNkRxBCPFoc8o3Qu9/hGsZ1E4l+DK4WlVHzD6tmsSzodDepONG3dAhpVwCrJJrxXKAtvon1lD6Sp/McUWs9j8jDN4RpnykbWrr9aJyR+VTHAwuUmKE1iIsjAi9fq+PqxxEFelbXoBN4nuDPm01Ny6vtpLhZkq+rde2ju7UL7gboxVCLs8PvOBpTWvTaz6mKJ9vl1+dLMDgmE6XCB7KIiAuOpyPv4CpSzEVtRjpoTRHVVFIWjnfZE1k8gklqi3eiRjxEYH21
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?p4WDOQ6PeMVVZLRzid7OOL9yxTV9J09ooZMpZlbP75PaYak5XXM5b4ythpYq?=
 =?us-ascii?Q?p8zheqht1HdJ96hmzL2F8xSFdsgPpH1L1UEB9N6KpPKKr7Og3o6Pu92o0VbO?=
 =?us-ascii?Q?+62EkAmU2CAowadxPtGLc/3NqeVdFhJo+d8ckjgIRCqEGkS9X+NsZ8sZSTIj?=
 =?us-ascii?Q?+Xv5CiJ6fjSDBG1ES/xg4R7JOdhdxkH6BjQzIkIDiCWlP+L0yg2aU+P+mG2u?=
 =?us-ascii?Q?1wPV7Dd9MkKUVfaBDas3DRA5ASJ3aQ96HNcW9VdGXgckJOnPHJbMJHpnuN3O?=
 =?us-ascii?Q?TS6vDhli4X0fisWSxZGPBAzi7N/hKeQNJCWg2PsWCCQ5mP86MXdcHE7dVqF2?=
 =?us-ascii?Q?XODG4UeQxMHhLxbTwmF69VKDLQzZQibWvT3hV04q8g25KWR5Nhg6Em6e4T4m?=
 =?us-ascii?Q?ouW3NDZ/NE0bJdHWNF6yXYBZuzlR1phM1T4at2z2QsapNwo4MA/DycVC4Vzg?=
 =?us-ascii?Q?QStAi/U+P04V1jJrN3/S9NrAgDXDCal/sR8MGWmLm4qpQ9zafx8CrKY7Wqhk?=
 =?us-ascii?Q?AHTWUiGXMsDhmgUiL9VpvxrMi/LtuQFirh4ZmgooGYcvnYHjUzrhWYYorY4d?=
 =?us-ascii?Q?VCKwaqEDrqJJn49/edx0jgdJrSRHDxvbRTnYgwul0OfxyG9b5FliM2mqryMk?=
 =?us-ascii?Q?3WFuWabhC/uDHmiamX5o6zNFoa84YlHdr2UbhAs/ZvdsD9cB/5D2RvFBICqw?=
 =?us-ascii?Q?Xnn/kvN8jTEfS8eNb/lAWFXyWungomDHLXyqA+AVlGeygvGp8i7eVr3Ov0su?=
 =?us-ascii?Q?ETEXITOibhxYGzs5xhlox6hHeaON9sUowZfHkz1yYsoMm2ZVWaCR9drOdRFA?=
 =?us-ascii?Q?lhrgr0uqpk1K4etxuAvMRbatJk0KMHzyAy4/h5Xn73I2mgfSHxDjzS+sZ2ye?=
 =?us-ascii?Q?pWleGYa3U8m6Snh6hoaKwkNseyFbVTGLVrKmBufA3bRjI/8xo3u6H4vFJZb7?=
 =?us-ascii?Q?obZaOP7Lsn3eC/g5sT2KfOeKa9Hfv+1876IziqD7Nybb3IZbGWBL9fGxpFZH?=
 =?us-ascii?Q?Exrbn1l1sgI/FEPs69lt7dIFr3dTK14GQqWGPFXrFmAba7l+7Hvk6n176FaN?=
 =?us-ascii?Q?mtNY+luWVyVZqZHcD5rppgH72VeMDYWH3YJ02EB/zSBnmlrFpWnCAW+G6jnd?=
 =?us-ascii?Q?VfEyiWv3HkfuFwNrHQNba0MlmN3LdNF8ThhNsamNrtkdVlkHCz/mqDhQz6me?=
 =?us-ascii?Q?is1LsWP9pf0x5oz4JupBH8RqZKgqIuP2SDgaxnRgqlaTp4Ol0vFGJJeruJ/b?=
 =?us-ascii?Q?iBPnVGZIfFfuJweJA0CytKZbCtsZU5Kvr2n/fJUe/5Aw+l4+DNQQ1BgKuwJf?=
 =?us-ascii?Q?eOxN6l2RADu+uWzn3ytKqi8U03T0iU8VVJ/fI/FlVRrmA6vcHcRpGsAZFl0p?=
 =?us-ascii?Q?H9KJsxGawT99QhTPG7Q7CMdtrmfbfLpU7e7SMvGafxCOB1lBnHQ7GbUrc0Ai?=
 =?us-ascii?Q?u3rpVFzIHrN3Ynqx6Ozr0mT8AKskIGR0Tazke7pw60OTNwP9GydDXX8PGt9Y?=
 =?us-ascii?Q?ExMgqMtCaEmt/fcU0Fcce0HZpMcSxLUI3SaxNFCoGeDjnrbgpDXcORGnw5oC?=
 =?us-ascii?Q?aqvla81SfOUdlIZpQlOx7ElfP275Wd/ym7KBJbto7LeABxkX4k0SClPoyk/1?=
 =?us-ascii?Q?QA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a094c1-b765-44b6-de91-08dc320cddb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2024 12:10:02.0195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JtRkMEzMplqpoCUEPCiZsSIqwP9Jw7i0He7CwLvHFm+vyXvS/aWSwfYMQaqNAmggy5PChulmAV7C1z44AehMMc0VDWGFTwk/UBVKMktmO8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5367

Hi Marc Zyngier,

> -----Original Message-----
> From: Marc Zyngier <maz@kernel.org>
> Sent: Tuesday, February 20, 2024 11:48 AM
> Subject: [PATCH] genirq/irqdomain: Don't call ops->select for
> DOMAIN_BUS_ANY tokens
>=20
> Users of the IRQCHIP_PLATFORM_DRIVER_{BEGIN,END} helpers rely on a fwspec
> containing only the fwnode (and crucially a number of parameters set to 0=
)
> together with a DOMAIN_BUS_ANY token to check whether a parent irqchip ha=
s
> probed and registered a domain.
>=20
> Since de1ff306dcf4 ("genirq/irqdomain: Remove the param count restriction
> from select()"), we call ops->select unconditionally, meaning that
> irqchips implementing select now need to handle ANY as a match.
>=20
> Instead of adding more esoteric checks to the individual drivers, add tha=
t
> condition to irq_find_matching_fwspec(), and let it handle the corner
> case, as per the comment in the function.
>=20
> This restores the functionnality of the above helpers.
>=20
> Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reported-by: Biju Das <biju.das.jz@bp.renesas.com>

Tested-by: Biju Das <biju.das.jz@bp.renesas.com>

Cheers,
Biju

> Fixes: de1ff306dcf4 ("genirq/irqdomain: Remove the param count restrictio=
n
> from select()")
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Link:
> ---
>  kernel/irq/irqdomain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c index
> aeb41655d6de..3dd1c871e091 100644
> --- a/kernel/irq/irqdomain.c
> +++ b/kernel/irq/irqdomain.c
> @@ -449,7 +449,7 @@ struct irq_domain *irq_find_matching_fwspec(struct
> irq_fwspec *fwspec,
>  	 */
>  	mutex_lock(&irq_domain_mutex);
>  	list_for_each_entry(h, &irq_domain_list, link) {
> -		if (h->ops->select)
> +		if (h->ops->select && bus_token !=3D DOMAIN_BUS_ANY)
>  			rc =3D h->ops->select(h, fwspec, bus_token);
>  		else if (h->ops->match)
>  			rc =3D h->ops->match(h, to_of_node(fwnode), bus_token);
> --
> 2.39.2



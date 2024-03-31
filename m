Return-Path: <linux-kernel+bounces-126075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 385C38931C1
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 15:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A071DB215E0
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 13:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C95144D29;
	Sun, 31 Mar 2024 13:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="H0PPdfqQ"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2099.outbound.protection.outlook.com [40.107.22.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDEE286AC;
	Sun, 31 Mar 2024 13:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711892673; cv=fail; b=qlLoUyJwglyOMgGiJtsR5qdxDf2B5gh79BJ+abtRvDVVpx9AsN1JgnMDjQWCINhTWziw7xOqER+LBIEodKJlEnNFHYf9j71tN238V/BSGvjT62LU9NnWKEADRGE1CrTup6SwJMiDAETFyEW+UapmRFdqdF538Q4QvAboACmX/+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711892673; c=relaxed/simple;
	bh=Q1DHDdx5vluvwImauN6LYvK4qYianDhzvXq+AiwifKI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TLMLZVetkYpmmNb4j2QZaHH9U2yehjXsvYBCsn3wLtw+xFEWPI2DaoRGx4L9xIzsey6FDYhInDdFdoHL7Gyd2SI8qczIT+0d8C+35WLn1Hvx4ny0wkM94LCKwtsE9MpFnCyDoylu8xs6hu2m+IbwlDAMDsBP/MOaGK1k7VBdd8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=H0PPdfqQ; arc=fail smtp.client-ip=40.107.22.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ReD1rEEEZ7upoJBUSplzFbaBoBmQ3q64OuUXYeCkpJKBvBVkr+B/9kEo3EirA67NcrAr+YMRlz2+CmrdgD3apEwBaKWfXwvLVqqxpz1kcIaYgOnm5csXMRGVfgVSajxKK29Kd/AGqo0epf00ZqBqqQyQDIRZ3noFm83wzcdYmVQptFmq7dV/ALzsdHFKj3IUhP2uq1IsUlgcUE2AByppJC4jHL5i2eSJLTfw/jg00E52qg4WpqP7lApgAzKvoUFs/jJFYNa0pfXN6dmBtx29f7GhHeHFhsPcsx1lWBuJFQCzROfgFjlR66oY2NI2wlYdsA3TvMpFqFFQBeXsrmlqJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sk9WFYoGdpwP0Nqbn5XHYROgGtrwNg6qfD0OEth9fes=;
 b=iLPevZCw7Ah14WAm0UDD6i8xFUI76XbSXJOjcm4LKzPTcpctv75QGLwmB/HIaw02aoHQL8voBsrp9S7lEIFP3RIw8MZiTb77LoNUYsM60qZx5eNQLf8KQzMgtB+6Ay6OOahtUFnoTNb8CfUC6xNsS2reg/HLdwfseymRsv7Vk23yHkOpXNqbIvSWaPTDCB6pNUZQWcYbKHlu3qkCMO/tUwPq6DOySDfoiAR52Jpn87T1NlnP/EpdT27utDaLE8pAA1sUAPFAydVEigN1E25BgXgRbkx79F8e7IJxO1H7+0tj5p8CuGPvLbg1WCyPMThFdYlrGM6Jd9q7gb4Mwoq+Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sk9WFYoGdpwP0Nqbn5XHYROgGtrwNg6qfD0OEth9fes=;
 b=H0PPdfqQr90tVwRw3vBUnJQVjR3+YIt2v6PSrKNqZ9b3RmuJaz/juDIavtGnTt0qPIOX/aVQ+sIHAmkwul1YH7szGdzLy0CQYZP/mN7/iC+fXLCIx0rcDXidtK56cUGyfvw8AUCrm7RuKsZWLfcXt3HGwccYNB4k808k7oiZFYE=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8961.eurprd04.prod.outlook.com (2603:10a6:20b:42c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.45; Sun, 31 Mar
 2024 13:44:28 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Sun, 31 Mar 2024
 13:44:28 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: Sudeep Holla <sudeep.holla@arm.com>, Cristian Marussi
	<cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Dan
 Carpenter <dan.carpenter@linaro.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Subject: RE: [PATCH v6 3/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Thread-Topic: [PATCH v6 3/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Thread-Index: AQHafRqyofu9Mu9OLUiaociI+9q/i7FPHJwAgALIoZA=
Date: Sun, 31 Mar 2024 13:44:28 +0000
Message-ID:
 <DU0PR04MB9417E797F4E0F7BB6154B3BE88382@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240323-pinctrl-scmi-v6-0-a895243257c0@nxp.com>
 <20240323-pinctrl-scmi-v6-3-a895243257c0@nxp.com>
 <ZgcP4IkTQGks9ehH@surfacebook.localdomain>
In-Reply-To: <ZgcP4IkTQGks9ehH@surfacebook.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB8961:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 qHWCnRJeFMZQRJW735zC/zwOTNEIi0HCswbIQuFAZj6j8Ejgm10RgJbzRrA8UpAD/yToiabCBq1hCFiY7ohIxSsO2KnK7WHDZ5YXpn74O/tL4AmavVRG8OnhjflITXg+c5/VaEGH1HlGL8aMoEC6PBdwWC+xTGJ7J5B9/gjJqTF5vWLIbwL2oD3UeF9ERw5NbrMuN6HQEKfzxoJeVAjaUGb8wl0k0d687eJfULhp4JlkgLdl0pguVyn9Qvf45DUJmd02nfPVywYNFfOBEvQXoWiR7hF1W+XVBrIV6K88G4rPJZ2YU/xSrsqtdWB/ctsfTFmbV8IbWvZAYo6rGWD8ZHR6A+G0RC0XmOMFsXHwa/EOaSb9/aaw6PO+8c+6Von+Bhhe5D9sffZvgLBAT1/vsZkVYpu6BfImEYrsZ1J2C/2pjbJHA2ccrkgTKZkeAU5JQS5yLYmr+oDv4nu9aOhLjoZOlt8WWa/D5Z57kNTSJbtF0v+DGp2+VFHhRwWGvtb6J4XNkaOoev1fNl7YK3eG5fazrYx5c55+AviLCDIbVvxy0aWFX/v5f875xs/XdGazl+gpIjEdwKtvgi+XMjfuVy6RZJHnGvsVov8tpfPB6ZN6YhaWPXx05R3z7zfPX6W2r4SkfQDOcqaUdslvOX2L36Rl4wur/xX+8vPfdAP1kwM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3tJmb9uuw/kAwHnATHfVL2uBTujZIn32XOZMdY5/NjjHY5VS9/r6qDEuh9S5?=
 =?us-ascii?Q?T9Je8bVkXUXuZfA4pf/ONLNTgzDczlxyKx3em/rVHJCYp7nQFCwr1zcnspcx?=
 =?us-ascii?Q?utrvIOJpmI1pF+za+MX5oDioGJT9zXZhqYmV3tSzoc8DuQZbR+ynsmxWeOg9?=
 =?us-ascii?Q?egf63+rjmAxEN4jH/YqkhilNCpwsLDwG5gyiNEq4s2Uk8C/7T19uArPBOZei?=
 =?us-ascii?Q?H2tT9SdS5OIyt/d9lV2BOTAx6QU3HTDUEAUq1PPfGgi5tG4Uam4nDhGxWDE9?=
 =?us-ascii?Q?o7xWkXCcci8w3yuJVdBw+pXGKdt3W8ZZDApYmZuboXSxwZWEIGyTwzRCB/rK?=
 =?us-ascii?Q?pTbPPWoxoOA8DaUUp23DSonf85GOJSurJyhVl/0fWmwhyrBNotlDpDzJnG9Z?=
 =?us-ascii?Q?JV1o+Hw334OnYcuGxp2tnZi3/7u3CqyrhBdwitI4Fjs589lkd4XJek/+2irs?=
 =?us-ascii?Q?gxHoCTVBO1x+DoRX1x5dE+BCE+LM4qtprYVCExHA903JGZewyyWmZqBJkGdR?=
 =?us-ascii?Q?r/yce+j8pxhhIXozwUpvSVk+quhFThraCv9xXDR87GKfKIpnancIb4mFdyx3?=
 =?us-ascii?Q?1PwQiKkOL8S6o0xML3AehMSHPR1wh8esyB3M24g4ZZP8AfCZrC4DsTfIsaaZ?=
 =?us-ascii?Q?SQlAo2FBH4II1bSX0NK0tM+LH0PiCk6TYNbGEKwmpmWNANPtDKqFYVnMjcJp?=
 =?us-ascii?Q?AilpwKC9UFoaq3ISJkmBWJFNUAcFEVIB21d6fz9Iimn+l5AbSYHaKFZaxiu3?=
 =?us-ascii?Q?B8YOU0c3qs9hTi/a52oJM+4rMbjNDkj8twPRDufwlI0TMAnMYRFRaCYJ3tNk?=
 =?us-ascii?Q?WujUU0VOdOamFJfG4TBB2YOk8vKrAI5wGpzjucncWlWoRj9EIRV7Xwak+UwQ?=
 =?us-ascii?Q?gxdXt+wTMmUg70qoE0R8OmlVDKYwEYXXuu2i+SybJBuqxirSdlcB6xJTZZrT?=
 =?us-ascii?Q?6jE2YR63bEXPe6L+Fw6oH7djvlRyS1YJVMNYFBIdnmI5+YxG122uQ7kT6Zx4?=
 =?us-ascii?Q?SBHdw3Xtihuk9sRnj+5AHZ8A4VFqKNLSWwiaUVK5gic0b7/szT8+QynxMCe5?=
 =?us-ascii?Q?CbX53PuWwPDFFYD7oNP4BFWb/oj+BGMn4MOC9TywXPxO24xBymhSMLcMzze1?=
 =?us-ascii?Q?6dEtfg8ynLO4hiI+erna9y1TebOtL1VgEeeEUvn9mYeiTjyv9cXpL+YrwAfG?=
 =?us-ascii?Q?bCcOxW09qTYKD7TuWSD2lliXw6eI/aKbfcRCwmv7MTEm6ph1dKeytqF5D+gj?=
 =?us-ascii?Q?57tqd3nCia/KEUu7qfdFm28lHU/XCTo6LCLJuQHUrH1wH8h5uIPnB06h0xEg?=
 =?us-ascii?Q?aD94dzV11oE80TXtdGy5StJWh6Ks3lRVmJRY5cPF6efmNWQlZEuAUwRfs+Y6?=
 =?us-ascii?Q?vIrMl4Z33Jeb/OooejhXYzSdK5ogZ3GFk8TWt3C0nG6hRQ5UTLbOIrjVy8Nx?=
 =?us-ascii?Q?GGnVcyx47NlSSPm1MTvjtTBlre2ebJG1CuZU5em2vp7yIug2zEc8DvHQGLDN?=
 =?us-ascii?Q?MjC7oVDoTbBM50zCq9fm/4HojHj/Bf9GRsdBmtutZOWPgfmct0eBxqyvbqCU?=
 =?us-ascii?Q?ysr+fq1KnEQXTGCqY3I=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: da8e3ba2-5182-4654-4ee5-08dc5188afce
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2024 13:44:28.6260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SWiSltzjuYFb0YxiirFaf0n4m6Wz9O0as9oNQt0X/aH8idUaAlZAzfv0XLB86MNabddtIcn9zda1jQXFioClEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8961

Hi Andy,

> Subject: Re: [PATCH v6 3/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
> protocol basic support
>=20
> Sat, Mar 23, 2024 at 08:15:16PM +0800, Peng Fan (OSS) kirjoitti:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Add basic implementation of the SCMI v3.2 pincontrol protocol.
>=20
> ...
>=20
> >  scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO) +=3D virtio.o
> >  scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_OPTEE) +=3D optee.o
> > scmi-protocols-y =3D base.o clock.o perf.o power.o reset.o sensors.o
> > system.o voltage.o powercap.o
>=20
> Actually you want to have :=3D here.
>=20
> > +scmi-protocols-y +=3D pinctrl.o
>=20
>=20
>=20
> >  scmi-module-objs :=3D $(scmi-driver-y) $(scmi-protocols-y)
> > $(scmi-transport-y)
>=20
> Side note: The -objs has to be -y
>=20
> ...
>=20
> > +#include <linux/module.h>
> > +#include <linux/scmi_protocol.h>
> > +#include <linux/slab.h>
>=20
> This is semi-random list of headers. Please, follow IWYU principle (inclu=
de
> what you use). There are a lot of inclusions I see missing (just in the c=
ontext of
> this page I see bits.h, types.h, and  asm/byteorder.h).

Is there any documentation about this requirement?
Some headers are already included by others.

>=20
> ...
>=20
> > +enum scmi_pinctrl_protocol_cmd {
> > +	PINCTRL_ATTRIBUTES =3D 0x3,
> > +	PINCTRL_LIST_ASSOCIATIONS =3D 0x4,
> > +	PINCTRL_SETTINGS_GET =3D 0x5,
> > +	PINCTRL_SETTINGS_CONFIGURE =3D 0x6,
> > +	PINCTRL_REQUEST =3D 0x7,
> > +	PINCTRL_RELEASE =3D 0x8,
> > +	PINCTRL_NAME_GET =3D 0x9,
> > +	PINCTRL_SET_PERMISSIONS =3D 0xa
>=20
> Leave trailing comma as it's not a termination.
>=20
> > +};
>=20
> ...
>=20
> > +static int scmi_pinctrl_attributes_get(const struct scmi_protocol_hand=
le
> *ph,
> > +				       struct scmi_pinctrl_info *pi) {
> > +	int ret;
> > +	struct scmi_xfer *t;
> > +	struct scmi_msg_pinctrl_protocol_attributes *attr;
> > +
> > +	ret =3D ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES, 0,
> sizeof(*attr),
> > +				      &t);
>=20
> This looks much better on a single line.

Per Cristian, scmi drivers keep 80 max chars.

>=20
> > +	if (ret)
> > +		return ret;
> > +
> > +	attr =3D t->rx.buf;
> > +
> > +	ret =3D ph->xops->do_xfer(ph, t);
> > +	if (!ret) {
> > +		pi->nr_functions =3D GET_FUNCTIONS_NR(attr-
> >attributes_high);
> > +		pi->nr_groups =3D GET_GROUPS_NR(attr->attributes_low);
> > +		pi->nr_pins =3D GET_PINS_NR(attr->attributes_low);
> > +	}
> > +
> > +	ph->xops->xfer_put(ph, t);
> > +	return ret;
> > +}
>=20
> ...
>=20
> > +	ret =3D ph->xops->xfer_get_init(ph, PINCTRL_ATTRIBUTES, sizeof(*tx),
> > +				      sizeof(*rx), &t);
>=20
> Possible to have on a single line (if you use relaxed 100 limit).
> Or (re)split it more logically:
>=20
> 	ret =3D ph->xops->xfer_get_init(ph, PINCTRL_ATTRIBUTES,
> 				      sizeof(*tx), sizeof(*rx), &t);
>=20
> > +	if (ret)
> > +		return ret;
>=20
> ...
>=20
> > +	/*
> > +	 * If supported overwrite short name with the extended one;
> > +	 * on error just carry on and use already provided short name.
> > +	 */
> > +	if (!ret && ext_name_flag)
>=20
> Please, use standard pattern, i.e.
>=20
> 	if (ret)
> 		return ret;
>=20
> > +		ph->hops->extended_name_get(ph, PINCTRL_NAME_GET,
> selector,
> > +					    (u32 *)&type, name,
>=20
> Why is an explicit casting needed?

The type is enum, not u32.

>=20
> > +					    SCMI_MAX_STR_SIZE);
> > +	return ret;
>=20
> ...
>=20
> > +	iter =3D ph->hops->iter_response_init(ph, &ops, size,
> > +					    PINCTRL_LIST_ASSOCIATIONS,
> > +					    sizeof(struct
> scmi_msg_pinctrl_list_assoc),
> > +					    &ipriv);
>=20
> > +
>=20
> Redundant blank line.
>=20
> > +	if (IS_ERR(iter))
> > +		return PTR_ERR(iter);
>=20
> ...
>=20
> > +	if (p->flag =3D=3D 1)
> > +		attributes |=3D FIELD_PREP(SKIP_CONFIGS_MASK, desc_index);
> > +	else if (!p->flag)
>=20
> Be consistent, i.e. if (p->flag =3D=3D 0)
>=20
> > +		attributes |=3D FIELD_PREP(CONFIG_TYPE_MASK, p-
> >config_types[0]);
>=20
> ...
>=20
> > +		st->num_remaining =3D le32_get_bits(r->num_configs,
> > +						  GENMASK(31, 24));
>=20
> One line?

Scmi drivers use 80 max drivers.
>=20
> ...
>=20
> > +	if (!p->flag) {
> > +		if (p->config_types[0] !=3D
> > +		    le32_get_bits(r->configs[st->loop_idx * 2], GENMASK(7, 0)))
> > +			return -EINVAL;
> > +	} else if (p->flag =3D=3D 1) {
> > +		p->config_types[st->desc_index + st->loop_idx] =3D
> > +			le32_get_bits(r->configs[st->loop_idx * 2],
> > +				      GENMASK(7, 0));
>=20
> With a temporary variable for r->configs[st->loop_idx * 2] the above can =
be
> written in much better way.

ok. Fix in v7.
>=20
> > +	} else if (p->flag =3D=3D 2) {
> > +		return 0;
> > +	}
>=20
> > +	p->config_values[st->desc_index + st->loop_idx] =3D
> > +		le32_to_cpu(r->configs[st->loop_idx * 2 + 1]);
>=20
> For the sake of consistency with the above suggestion also temporary for =
next
> config value.
>=20
> ...
>=20
> > +	iter =3D ph->hops->iter_response_init(ph, &ops, 1,
> PINCTRL_SETTINGS_GET,
> > +					    sizeof(struct
> scmi_msg_settings_get),
> > +					    &ipriv);
>=20
> > +
>=20
> Redundant blank line.
>=20
> > +	if (IS_ERR(iter))
> > +		return PTR_ERR(iter);
>=20
> ...
>=20
> > +static int scmi_pinctrl_get_group_info(const struct scmi_protocol_hand=
le
> *ph,
> > +				       u32 selector,
> > +				       struct scmi_group_info *group) {
> > +	int ret;
>=20
> > +	if (!group)
> > +		return -EINVAL;
>=20
> When the above is not a dead code?

It could be removed.

>=20
> > +	ret =3D scmi_pinctrl_attributes(ph, GROUP_TYPE, selector,
> > +				      group->name,
> > +				      &group->nr_pins);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (!group->nr_pins) {
> > +		dev_err(ph->dev, "Group %d has 0 elements", selector);
> > +		return -ENODATA;
> > +	}
> > +
> > +	group->group_pins =3D kmalloc_array(group->nr_pins,
> > +					  sizeof(*group->group_pins),
> > +					  GFP_KERNEL);
> > +	if (!group->group_pins)
> > +		return -ENOMEM;
> > +
> > +	ret =3D scmi_pinctrl_list_associations(ph, selector, GROUP_TYPE,
> > +					     group->nr_pins, group-
> >group_pins);
> > +	if (ret) {
> > +		kfree(group->group_pins);
> > +		return ret;
> > +	}
> > +
> > +	group->present =3D true;
> > +	return 0;
> > +}
>=20
> ...
>=20
> > +		ret =3D scmi_pinctrl_get_group_info(ph, selector,
> > +						  &pi->groups[selector]);
>=20
> One line?
>=20
> > +		if (ret)
> > +			return ret;
>=20
> ...
>=20
> > +	ret =3D scmi_pinctrl_attributes(ph, FUNCTION_TYPE, selector,
> > +				      func->name,
> > +				      &func->nr_groups);
>=20
> At least last two lines can be joined.
>=20
> > +	if (ret)
> > +		return ret;
>=20
> ...
>=20
> > +	ret =3D scmi_pinctrl_attributes(ph, PIN_TYPE, selector,
> > +				      pin->name, NULL);
>=20
> It's pleany of room on the previous line.
>=20
> > +	if (ret)
> > +		return ret;
>=20
> ...
>=20
> > +		ret =3D scmi_pinctrl_get_pin_info(ph, selector,
> > +						&pi->pins[selector]);
>=20
> Ditto.
>=20
> > +		if (ret)
> > +			return ret;
>=20
> ...
>=20
> > +static int scmi_pinctrl_protocol_init(const struct
> > +scmi_protocol_handle *ph) {
> > +	int ret;
> > +	u32 version;
> > +	struct scmi_pinctrl_info *pinfo;
> > +
> > +	ret =3D ph->xops->version_get(ph, &version);
> > +	if (ret)
> > +		return ret;
> > +
> > +	dev_dbg(ph->dev, "Pinctrl Version %d.%d\n",
> > +		PROTOCOL_REV_MAJOR(version),
> PROTOCOL_REV_MINOR(version));
> > +
> > +	pinfo =3D devm_kzalloc(ph->dev, sizeof(*pinfo), GFP_KERNEL);
>=20
> Huh?!
>=20
> Please, get yourself familiar with the scope of devm APIs.

Please teach me if this is wrong.

>=20
> > +	if (!pinfo)
> > +		return -ENOMEM;
> > +
> > +	ret =3D scmi_pinctrl_attributes_get(ph, pinfo);
> > +	if (ret)
> > +		return ret;
> > +
> > +	pinfo->pins =3D devm_kcalloc(ph->dev, pinfo->nr_pins,
> > +				   sizeof(*pinfo->pins),
> > +				   GFP_KERNEL);
> > +	if (!pinfo->pins)
> > +		return -ENOMEM;
> > +
> > +	pinfo->groups =3D devm_kcalloc(ph->dev, pinfo->nr_groups,
> > +				     sizeof(*pinfo->groups),
> > +				     GFP_KERNEL);
> > +	if (!pinfo->groups)
> > +		return -ENOMEM;
> > +
> > +	pinfo->functions =3D devm_kcalloc(ph->dev, pinfo->nr_functions,
> > +					sizeof(*pinfo->functions),
> > +					GFP_KERNEL);
> > +	if (!pinfo->functions)
> > +		return -ENOMEM;
> > +
> > +	pinfo->version =3D version;
> > +
> > +	return ph->set_priv(ph, pinfo, version); }
> > +
> > +static int scmi_pinctrl_protocol_deinit(const struct
> > +scmi_protocol_handle *ph) {
> > +	int i;
> > +	struct scmi_pinctrl_info *pi =3D ph->get_priv(ph);
> > +
> > +	for (i =3D 0; i < pi->nr_groups; i++) {
> > +		if (pi->groups[i].present) {
> > +			kfree(pi->groups[i].group_pins);
> > +			pi->groups[i].present =3D false;
> > +		}
> > +	}
> > +
> > +	for (i =3D 0; i < pi->nr_functions; i++) {
> > +		if (pi->functions[i].present) {
> > +			kfree(pi->functions[i].groups);
>=20
> This is wrong in conjunction with the above.

Yeah.

>=20
> > +			pi->functions[i].present =3D false;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
>=20
> ...
>=20
> > +static const struct scmi_protocol scmi_pinctrl =3D {
> > +	.id =3D SCMI_PROTOCOL_PINCTRL,
> > +	.owner =3D THIS_MODULE,
> > +	.instance_init =3D &scmi_pinctrl_protocol_init,
> > +	.instance_deinit =3D &scmi_pinctrl_protocol_deinit,
> > +	.ops =3D &pinctrl_proto_ops,
> > +	.supported_version =3D SCMI_PROTOCOL_SUPPORTED_VERSION, };
>=20
> > +
>=20
> Redundant blank line.

Fix in v7

Thanks,
Peng.
>=20
> > +DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(pinctrl, scmi_pinctrl)
>=20
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20



Return-Path: <linux-kernel+bounces-128088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BFB8955F7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D1C61F22BEC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6108593F;
	Tue,  2 Apr 2024 13:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="q4xmUEuM"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2126.outbound.protection.outlook.com [40.107.21.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631EC9463;
	Tue,  2 Apr 2024 13:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712066371; cv=fail; b=AGndOAuxNugLiQKIACJiNthscCcIhQ6yxC6Bu/GLACI14Vt6ix3PBeZwMGu/4PxkQi3IduLa6BOBtrIuwVSmQo+Vzf0t5lCSo7qfPXZ973QT//YSxTLdw60ph1y1HVfOPRq6oWolRQ3cCCI3kygJk1xmJS1SZoKkuT2FFlUnImc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712066371; c=relaxed/simple;
	bh=DwzUSuZuHYMYoYKlqZgteWlGADdZ5TC76MCKvfiU2/M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W6JEsX4GjlEsTkPVub+Wfa1Ew0/cxSOgyesxueMfNAjNYUXpF+DGw+kmNfqsUCDmupW4WQJDqN5STqCMm74m4x4SC2D9ST3fk69LMQm2euS4m97ufW5lt+YeIFixlkdb0ehNRMCaXyiZjkye8nmNxbyYnrQtu+F8vg9ub8DFa84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=q4xmUEuM; arc=fail smtp.client-ip=40.107.21.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHevks7X3o7Z1IK+K2204G26WEJjGoNjdcsnWOjKXh2oHSK67mQs7qcnpuoQG1mYlL6+NzTYem9bo8HX+xJp/4+Ph8sShr7PHmHiadyLPVYSarFhvvVA5/Vmw+7Om6317hU0AZb4c2QwiIgaIbJmrLxh8EVSY7sjhEh+OizyGXcKrIQuixfbPsD/+YgrELXPgfEq38ITgjx9xmEurudIiMJUbp8ajXYxNEl44iXt6JNfQtyL4jZRd2iiGTkPp8wTWRV4z9RIOXnnIKTsft5tvwivj1cfO1ZGvKZCP4g+rMKGJXpthXAPEHDmof3AJSY6Rf6ST9HmtwbrFu1dXXA4dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=guk9ZBYGuGdMw5f3ry/U0qp1r7254g0Q5cQrgV0Xs64=;
 b=YFU9etwg58aRRVzmpimUfqlAry3e2iupLZ/o829uY9Cd3KXtEgPNyhlmeTUn5wy7UQMRXog9H9f/V8sV8iHaWKXUbmZN1mw0SjyIP7C6eoh2VadejjNW9G6bF2mkzbR2j09i//NbHSbdcdMxtqVJEMjSLKn0Ox0yBKCT0R8HUU4D56aD/TVTpkGs3R97QHLNqv38OcSGg1iAa+42lw2bfc0Q30ENpPwFbdZfmxm6WMJgZGyobQhWIFTxIHhM+F6Q40TOHT05Qgs1EjPG3NGkh9Pm4OwOQ75zcfPtwqfFHb5JWk1pQVCvy7q9jZX8/Z+wLP1Ax4n4QhyRdmApya/uVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=guk9ZBYGuGdMw5f3ry/U0qp1r7254g0Q5cQrgV0Xs64=;
 b=q4xmUEuMPCwMUaNd9qCSHKO4ULJDkM6SZWgWCtHY4nV7kLZgcXs+F8NTAQ37utFqeIGf8EKXL4PTXgnMRlS8GYSybgjwG6Bj6QDGqoKE90g/lnbd2xZ7EeQJbNj9DEBp+jSh5ZUnw77rclCLmuGnssfBXVO/ouULazJ0/hh/Jsc=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB9145.eurprd04.prod.outlook.com (2603:10a6:10:2f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 13:59:23 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Tue, 2 Apr 2024
 13:59:19 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>, "Peng Fan (OSS)"
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
Subject: RE: [PATCH v7 4/4] pinctrl: Implementation of the generic
 scmi-pinctrl driver
Thread-Topic: [PATCH v7 4/4] pinctrl: Implementation of the generic
 scmi-pinctrl driver
Thread-Index: AQHahKODsF690b6vNUGQv4jxirY7Z7FU+GuAgAADvqA=
Date: Tue, 2 Apr 2024 13:59:19 +0000
Message-ID:
 <DU0PR04MB9417D0D33573E99D440D7BD7883E2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240402-pinctrl-scmi-v7-0-3ea519d12cf7@nxp.com>
 <20240402-pinctrl-scmi-v7-4-3ea519d12cf7@nxp.com>
 <ZgwGpZ6S13vjk8jh@smile.fi.intel.com>
In-Reply-To: <ZgwGpZ6S13vjk8jh@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DU2PR04MB9145:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 nuTKNI4i0z+OVMuMXNa19EBz1kfDVoZgUFY9e+2VxGWdHA8gHcmP/C7L6GuR00DBi4ccb4IwWJ5/t9cQhzUXTGw2eGCmnhvZEAHkq1yoWpSsG5yDqKkDb8HYnjqhtBqJcFEw9W2Njqf8EFjZb1E0zAhecodiLLsUsKR37LeJSD3tGg360fPwweYISxenQGB2e5CXxbhu/RN27PHQF01lYyx2N7oPm7u5RuEgDzN5P8NT+nViD2Bl4khHALQgd7faziyvaFh2eVBpGevvjGlQDkFP5Yk9ittY1A3sSwYqgydq8z2NC1Yjcv0l1KJ4NWUkDh7jPU2ks5Y94u70h9QK4riyrlOoJ62t2MoBo4AQPRtI+P88Q7NBK8ZDfEwrDt58LGx5yCND1L3T3pL13gtjU+K9aby1BxuCF2F0ugLCGLmxA6C3LNlhYZ+5bUYQRS4quiVo9kGxDpB145KjnzHGIiOvTjtmNQ5zXCOE8MfroG1ZhGJBKyt/yw/ExDv/5Yy0ohA6MTVPzVr4aOhV2ld7wFpM/4tdpcySc66FAHnkmDv2IG5zWB8JqbtrBVzL1Kuqo1c6MHSfCmjirIRn0T6pxxxXq7a2ogJPrEbAw//WlFYLwoFZMqGrdcZGiXgyS3PJeImekQvHykqS48QfwXFUXIaqHZlc3lbyJGO7HViRoug=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Cden5xeGZS3NHXDPnmHQFMNpw3HAI1Kj+nLcPm2XtALWLYQMDsJfPG8YqVoL?=
 =?us-ascii?Q?n5qAXvmUYTcGJCth/M/Vus/tSO+tgARvw81Ag/Zu5jLbnaMsynIup50Bulx5?=
 =?us-ascii?Q?tK8+AgIjbvp/rmvCvASx7VWeVm/vAzVcv+YSoeY0k+Df6DeD1pCz42pdWyXn?=
 =?us-ascii?Q?0PAfAL6EG/JDtw1uhFIkOulpsd4D7nB33+FysXWdL+KKIYV6AbeUBbiPKcZ4?=
 =?us-ascii?Q?BdgqXTdoQWLYO0BnJdpRsRE39+0SJuKX6/N6vI6R3eiAniMt4KEafReZQSv7?=
 =?us-ascii?Q?wskE1CE6bCSJoIUuSy6fCYj1XIra2xtGsPij1CfKxn7HZtDI1kApwQJyqssF?=
 =?us-ascii?Q?MznoogE+WWmY2fo9dlumGPDtHfTxj8hwmihUxs/qYW6xQtw33EIgJ0MN/kmV?=
 =?us-ascii?Q?sE1u7KyYIGq1N0zUL0tpvkhsg51ClwR2S/S4l2zKF3c2BcQrDXJhRR/T4cJL?=
 =?us-ascii?Q?fh36io0BZubTC7NBrlldP7crJEtdSRbe11G1IAkLWHGiU+VYYwZrqpNfLnrR?=
 =?us-ascii?Q?XK3FY8QUhR19/w7O0EIWpN9ozXIAS3cxHpLfK9Qw939FRt7qF3H74sy0HOma?=
 =?us-ascii?Q?5zt5rJT9GlJnq2LFSnSmnIWOJYfOsl77G78d7X9YAG1N9ne8wY0XJ92U+jvn?=
 =?us-ascii?Q?/jz3YIS2FdaP1bEMmiaJSdp6PQADNIJPirZlhEzCRLhwKt6y/Zc6OANZlbX8?=
 =?us-ascii?Q?pOXzjGqL4zq7asU0P0SZlDigajyF+XEaxQ299Hn+KEeBb2o1e5GGkj/CiQE5?=
 =?us-ascii?Q?SMSogzOr8/e2YPwqMZo+63m4MKNgGKp5/h0/Jj/qlthEyan0noYGVcbMeZOb?=
 =?us-ascii?Q?uiaNUvTriHr542DUA2KtRUYeqHesfuvTA4e4vmkGotCmE37waJ/8vkz9+ckR?=
 =?us-ascii?Q?w2oBEeuCxjRWzH3uhHna4sJFlfNgUC9hFWwjcLIJ85itupdRBdvCtleAghkh?=
 =?us-ascii?Q?IhqTcwUin56Ftl/DEI43747Y9ZAtFChoN8gq1BWsDihwODl1knptFsiGRZsT?=
 =?us-ascii?Q?dwJ2qsi7Aw6GiGFZU/DyXsPxgvuKkf9DZZZ3qgpnq88qhAnsR/hFDjQzfJxm?=
 =?us-ascii?Q?o5v93VTXNRVeT5vAm4xDgUqo/ClUHDai2qrHkY4hXLuLLXTNE8ytzsU286a5?=
 =?us-ascii?Q?Tx8D9MxtvEOZfh+b/8hgnbb/uW1cSX78WgClx9/4B+ybSdq7I114jT+mK1NL?=
 =?us-ascii?Q?X7rdS0Ou605rwXhvZ1ZIDtTRShlVMhjAUl2CkSxO2FShxbTDtB5RYCB/Lou8?=
 =?us-ascii?Q?JxZ5EQhrJGobGP9vOIdzc955zUIvrq53nk2V14iBroXTLT5V0FaTkYFacQSa?=
 =?us-ascii?Q?YT0cDMLixuTMwQ+00VH+HrplEBntqPDukjskj+gRqQvsLOxb6Hj6fgW60TKW?=
 =?us-ascii?Q?CGr6VPQ8fccMVppXDmaYybEkqcwkrGr3+/PrPPi1fOsWOdvecsjHsYx/HqsX?=
 =?us-ascii?Q?egl3YdhYn1diozYJBSdZOHVArJChHHGU+v1gmEeICXSgcER+hzmsbk90xfuM?=
 =?us-ascii?Q?2lA5LGl574SByrZ8TuQ7o0Rut9gMRraLw2jskqxNSQyUdQYck23mqvV+/OBR?=
 =?us-ascii?Q?rMDWbjC8WKy4etBR/Mw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f9f9579-a1ba-4926-3c76-08dc531d17d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 13:59:19.8427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qNoKrkfvjORxmn7U0JbRSEUG5obA9V+Wdx7qMg49bQ0IIn3zDbWC5klntBYkqrDpGBkwyM0wViaSU3wtqjrm3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9145

> Subject: Re: [PATCH v7 4/4] pinctrl: Implementation of the generic scmi-
> pinctrl driver
>=20
> On Tue, Apr 02, 2024 at 10:22:24AM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > scmi-pinctrl driver implements pinctrl driver interface and using SCMI
> > protocol to redirect messages from pinctrl subsystem SDK to SCMI
> > platform firmware, which does the changes in HW.
>=20
> ...
>=20
> > +#include <linux/device.h>
> > +#include <linux/err.h>
> > +#include <linux/module.h>
> > +#include <linux/seq_file.h>
> > +#include <linux/scmi_protocol.h>
> > +#include <linux/slab.h>
>=20
> Missing headers.

Not sure there is an easy way to filter out what is missed.

>=20
> ...
>=20
> > +	*p_groups =3D (const char * const *)func->groups;
>=20
> Is this casting needed?

This is no needed.

>=20
> ...
>=20
> > +static int pinctrl_scmi_pinconf_get(struct pinctrl_dev *pctldev,
> > +				    unsigned int _pin, unsigned long *config)
>=20
> Why underscored parameter name?

Underscore could be dropped.

>=20
> ...
>=20
> > +static int pinctrl_scmi_get_pins(struct scmi_pinctrl *pmx,
> > +				 struct pinctrl_desc *desc)
> > +{
> > +	struct pinctrl_pin_desc *pins;
> > +	unsigned int npins;
> > +	int ret, i;
> > +
> > +	npins =3D pinctrl_ops->count_get(pmx->ph, PIN_TYPE);
> > +	/*
> > +	 * npins will never be zero, the scmi pinctrl driver has bailed out
> > +	 * if npins is zero.
> > +	 */
>=20
> This is fragile, but at least it is documented.
>=20
> > +	pins =3D devm_kmalloc_array(pmx->dev, npins, sizeof(*pins),
> GFP_KERNEL);
> > +	if (!pins)
> > +		return -ENOMEM;
> > +
> > +	for (i =3D 0; i < npins; i++) {
> > +		pins[i].number =3D i;
> > +		ret =3D pinctrl_ops->name_get(pmx->ph, i, PIN_TYPE,
> &pins[i].name);
> > +		if (ret)
>=20
> How does the cleanup work for the previously assigned pin names? Is it
> needed?

No need. The "name" memory region is allocated in firmware pinctrl
Protocol init phase.

> Maybe a comment?

ok.  As below.
/*
 * The region for name is handled by the scmi firmware driver,=20
 * no need free here
*/

>=20
> > +			return dev_err_probe(pmx->dev, ret,
> > +					     "Can't get name for pin %d", i);
> > +	}
> > +
> > +	desc->npins =3D npins;
> > +	desc->pins =3D pins;
> > +	dev_dbg(pmx->dev, "got pins %u", npins);
> > +
> > +	return 0;
> > +}
>=20
> ...
>=20
> > +static const struct scmi_device_id scmi_id_table[] =3D {
> > +	{ SCMI_PROTOCOL_PINCTRL, "pinctrl" },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(scmi, scmi_id_table);
>=20
> Move this closer to the user.

ok. Fix in v8.

Thanks,
Peng.
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20



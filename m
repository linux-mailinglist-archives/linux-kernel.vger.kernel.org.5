Return-Path: <linux-kernel+bounces-128048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD3589555F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 591E81F21151
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5B9126F10;
	Tue,  2 Apr 2024 13:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bdy2tBsN"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2121.outbound.protection.outlook.com [40.107.22.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B588593F;
	Tue,  2 Apr 2024 13:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712064445; cv=fail; b=aebcBwzNHkmrj//GYAY5KcHINfqQCu8ELWHbI29U7IzTwlDO+KeV+mWpDYstBydovOmscTB9iXF8AjPSfUIMu3fedDHdGZPtjBxgFiQqX0ztSmpOPU1b9FER2HdYVkwkryWOsj44WF/Cgqh6d/R3KkHjemxXBjH3jgmhcwcHfJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712064445; c=relaxed/simple;
	bh=KG/NLtQEO2PxpCeWJC+6m436ugeUk7JMWwJY5os1ohs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BJ0oUkbYgtl7cL8nMVlzMuhfGeKTVDklE/1Q8/65Tv9hpYru3fQCziHjEL3nTW+vBhEAclvwYbsS1I36hrRMgZ1K2gBWUKx50sKxRmsVfU2m8rj1+tMZ7WCBHU1pbnSweyNSjPkudBskOBNnECOLw4ifoPPkA5yxR6nIbfkf+gY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=bdy2tBsN; arc=fail smtp.client-ip=40.107.22.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RbvWpQIxt1oc5jpGYSxYatrKnG1hZGBU33VrRN5u9kZ8qsHbDht7vGC6WvAr0UYTf/wFtNePxwkRBbC4+ErnlxHQbKEfct7z7EwDbVk66pe49ub0qqqoTXqgq+gob/AVt4O6j/hLRLvHLO1gqVrSD4bgRndDrm/vKOP7v4zHKxAPtJWVpQ8/X9VITWWtqlp0eUn1bNETn5ab1Y/ne2v0ui3Onstcpoxuomu8rszw65Dgm6ySshG70ymbXutTxrk6lSHG5+FjoJSoq1dQGZ9SG7DJAanOUxPsH6Paq09Bsm/3nA+092LD5JoZyU6ATIK5FV80VLzA1qxUPGAFCHc2cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RV7THYemy5hvntRIZCYocas0C6dkPEYCi1+INXXRZ44=;
 b=PXMa1nHdz/t/YsGD+q+hh9pvXijA/QzXFSUhKi0Ch7i1IQO7rS1lsaYzum40jIXa8wvWlpVN2BWrQXX6gdZC7TlK/CnyseGMuUCcydCfB3FJMn5BGzuAGlTcF+TupIQwdf1Lf7gRtWIMmyAZuHK9julvNHbphUsP85GwEU2M35BXkI/H6RvWSj3i0loBM4YrRCprLV++UyzKMu9EhGGxs71YinBKvayTDFbFJVyuNfMOX4svQ1Vw9ApLero24w4YOmqfm1LNhEAxi9+hmKg4BxsMIn0isg2fc6CheN42MUeHurwwXrI0KcwwkksSLx/nO+iSRCnNiEOb8uDhjZC8Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RV7THYemy5hvntRIZCYocas0C6dkPEYCi1+INXXRZ44=;
 b=bdy2tBsNGxr1D0r+DyGK/iEl17xjJlz677t9N+LfF4epbN80CQrR67OUpWb7HgdclNjbgjiBfugKylm3pvAEz7eeyLIYHmH/tVyQI+d2JZgL6PtoOXx11pIclVTYcgJQc7jTCGTqmRNp6xN8cIn4pKtPSubv83M4Ix9DEn4BOYk=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB8058.eurprd04.prod.outlook.com (2603:10a6:10:1e7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 13:27:19 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Tue, 2 Apr 2024
 13:27:19 +0000
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
Subject: RE: [PATCH v7 3/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Thread-Topic: [PATCH v7 3/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Thread-Index: AQHahKOBYTQv1KoiVkioSbRA3lNLQLFU9h6AgAACEtA=
Date: Tue, 2 Apr 2024 13:27:19 +0000
Message-ID:
 <DU0PR04MB941780B4C28DB353C64966F8883E2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240402-pinctrl-scmi-v7-0-3ea519d12cf7@nxp.com>
 <20240402-pinctrl-scmi-v7-3-3ea519d12cf7@nxp.com>
 <ZgwEtxj-qi6uy_m2@smile.fi.intel.com>
In-Reply-To: <ZgwEtxj-qi6uy_m2@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DBBPR04MB8058:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 TfoIOAel3JNtqCCcY/R3sdkh4bneSDq41cPVRp4JbOIjCfQ563C1L2S+xHgYtTFj46Y5Dfyno8/lcWxZdCMZOZsDUWfUyr76+TdD1tMDUhnVKJJ5+7CwOgnGYstTRVwGExst/wlwm5b/JhrbnDIJ28RC5B29hCbAIRgRCUeD+/Ygqh4X6liMZTSbUOmIsSRkC7YvEoZUpEG3topPJkA8ypN7B9FMy2lLIr5DJ9qaU1FV/29NWrf07RY5YEEBDdJGkqW1YxWgHGn+xONONO5sSpePlpkHO1mpiRghKF8oxKGxKEMVe7WSqTWfW8t5ZJ/3iH8BACfySrF/CWvgSUXUDUXwEnFHk8yXdVmtnRsHjaa392oURzFkKWRofc6rsl/+vaIo6rEdd3r1vKG1yidJILIhF5JK2Gq31nR7zZiZrcL9OTOqnXs21aY/bhYacjj0cfXD1M57PaAIqdyi4iN490riOh8FrvImjuQkgCh0L6D/BcxuOYbbU5+8DijIYZD3ul/4i/dDUAGRWOOvYPYGN5jJZI5iFGN2ijObNxbt4F9MWDFv9Vv1oYqlYAyBOG2ivlYb2mZXHYZHylDe3f/qYfBx6sW17HjR1jS+DVsZtLE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?AkLa5wqYT/teBhPzwEHU+RZAwCFunnM9ZyBelP2irwUo07feuiJjiY6mbqzI?=
 =?us-ascii?Q?Cyq9LxKhp3EozGtOAHy5qwDSejhKKSk7Z5IWMT5RAdCGUz9xUC/+aOtOIZ5+?=
 =?us-ascii?Q?dKjOpbXwa2EgNSpR1SXkvmvoPz+onfz7kBwO/a7fyn/9PEBNR7qyHTQMHQhU?=
 =?us-ascii?Q?7etiFJe9hLrIud1y6PBgysSBAYxUaqKdpbAJQzojEKvjSUr7rSlInqshtGCH?=
 =?us-ascii?Q?WR4XBQWH7SQZoBeOD4/HzsCmYU8HteS35K7ailra/6boT5jhbBOEDtOoaEXC?=
 =?us-ascii?Q?7UxIHac2VbsUUYyrcmTCc767F4136NCZboYRX1ZRauxoSFK1do2JkO35SJxd?=
 =?us-ascii?Q?TlgWb6X+tQm0bjKMIn397XAK9wvAsLStg8slOTTMyuB6TEhMJv7+liJgx7eV?=
 =?us-ascii?Q?hSUeoFXtv93atsnIe3RvQi7qFp8BPs4Bcp3mgub6Tfn5RtwlXP5RyO3VXnyd?=
 =?us-ascii?Q?H0RAdxeuRy+MOobWDcYES1PXS3wyjwlx93P1qXV5yOKCoEyU70uo1dpu38p8?=
 =?us-ascii?Q?doYk40kjtVL8+SE8vP/S1gBUcHEynUQtArbJ9oz97+q0LdY7SJv6w6o1czAO?=
 =?us-ascii?Q?x2aimLS52RYVRH2/aQajMMRViYIkDdXmNfe4hjiAaDT0viEraenlTniwL/Dy?=
 =?us-ascii?Q?Ly+Ia4ZVqjflaYQ6FaYo3hWEhGPDgcrzO6n19TVSJQ1WHpG/FtCwGsLT3oWw?=
 =?us-ascii?Q?0vtll85botpLqGNWt9oHr+cT4o2/3LuuaA9FKRSo+fQzXzd3hfCImv6nZbxd?=
 =?us-ascii?Q?281wHummW4eScygZQnp8ORWX9PIxaXsCyQbLUXEJbj3Hsyzo0qkXx84kzA3V?=
 =?us-ascii?Q?S09J4opPqwaBWIVq4tb4NnFAM8gtcSWOYzfXScJTELr1ju6C7Pc5j9P+PCIm?=
 =?us-ascii?Q?ZYVD0PpMjDBEEBBrRbN9vAWHDM1Z458PU4LngV2+kV4L7mvKboUa0ZGNnb5P?=
 =?us-ascii?Q?56O3JpegCOiVfXpiSOVBSdAttruVo8zjMfJaul2iSDKwh5F4vQNu3Zcd6qdn?=
 =?us-ascii?Q?9M6DFRkf2mlRvioLtwPN5CvXbOw64yGHDdMO99RFHSzl0YPHFyHT3/EJjGCC?=
 =?us-ascii?Q?/NyBbRrsglpm1YnrWYfpbJZN4ppyWZAwopWiNvwCMh9aRsze8dyp0YgAgZJQ?=
 =?us-ascii?Q?KXRPlfDz3ceDJJrOIVdvJuPjKdnkIBGo774xPqcA22G0RoNbBUwiS81iIoIL?=
 =?us-ascii?Q?KBhcT20Mka/HhdlRXeoNsCeNgSHDL8VvI7PDc59WOL0oBznJVaxroW2CvZyK?=
 =?us-ascii?Q?sS4DcbsEDp/7aO7V2pVnY3PEHLQLVbcrJQm0F8GZ0/Vh2zSFo4RzO2ZwDTV6?=
 =?us-ascii?Q?US6FR+K0wzYtugtR5NwhZiT6JS2lqCmo0hrg2HCsRYywJ0Vj3MHZe6aDbROr?=
 =?us-ascii?Q?XDn+jRc/1nnJBblGgQVx+fgeFQrdz0Kjw0R2Ryu1iXlPcpfkQ+UuaScx1vFL?=
 =?us-ascii?Q?hJlCFq+adPezHrzOAG19GgSFXGC/Uz5yXLS7fyxlDfYEYKMWGJjK0eEF8+5U?=
 =?us-ascii?Q?sfHGNlAKsVBKdqolSCYv0DGBIRJIq3Un4YzY8LKQ81wQ2Se3l/N6++9Yi7Q7?=
 =?us-ascii?Q?4p3BkbJMLqaD2J2tf+4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b22decdf-2976-4316-a3c3-08dc53189f38
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 13:27:19.4818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oSdtxMQGh5WF7HJKP/Jz4Mva37F+h/8kv1FENt0OeL8ndYmwCAiYyNQCJkjp9+vsUDJv1VgXEOTrGfS/8mlcjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8058

Hi Andy

> Subject: Re: [PATCH v7 3/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
> protocol basic support
>=20
> On Tue, Apr 02, 2024 at 10:22:23AM +0800, Peng Fan (OSS) wrote:
>=20
> ...
>=20
> > +#include <linux/module.h>
> > +#include <linux/scmi_protocol.h>
> > +#include <linux/slab.h>
>=20
> Please, follow IWYU principle, a lot of headers are missed.

ok. I will try to figure out. BTW, is there an easy way to filter
out what is missed?

>=20
> > +#include "common.h"
> > +#include "protocols.h"
>=20
> ...
>=20
> > +		ret =3D scmi_pinctrl_get_pin_info(ph, selector,
> > +						&pi->pins[selector]);
>=20
> It's netter as a single line.

I try to follow 80 max chars per SCMI coding style. If Sudeep and Cristian
is ok, I could use a single line.

>=20
> > +		if (ret)
> > +			return ret;
> > +	}
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
> > +	if (!pinfo)
> > +		return -ENOMEM;
> > +
> > +	ret =3D scmi_pinctrl_attributes_get(ph, pinfo);
> > +	if (ret)
> > +		return ret;
> > +
> > +	pinfo->pins =3D devm_kcalloc(ph->dev, pinfo->nr_pins,
> > +				   sizeof(*pinfo->pins), GFP_KERNEL);
> > +	if (!pinfo->pins)
> > +		return -ENOMEM;
> > +
> > +	pinfo->groups =3D devm_kcalloc(ph->dev, pinfo->nr_groups,
> > +				     sizeof(*pinfo->groups), GFP_KERNEL);
> > +	if (!pinfo->groups)
> > +		return -ENOMEM;
> > +
> > +	pinfo->functions =3D devm_kcalloc(ph->dev, pinfo->nr_functions,
> > +					sizeof(*pinfo->functions),
> GFP_KERNEL);
> > +	if (!pinfo->functions)
> > +		return -ENOMEM;
> > +
> > +	pinfo->version =3D version;
> > +
> > +	return ph->set_priv(ph, pinfo, version);
>=20
> Same comments as per previous version. devm_ here is simply wrong.
> It breaks the order of freeing resources.
>=20
> I.o.w. I see *no guarantee* that these init-deinit functions will be prop=
erly
> called from the respective probe-remove. Moreover the latter one may also
> have its own devm allocations (which are rightfully placed) and you get
> completely out of control the resource management.

I see an old thread.
https://lore.kernel.org/linux-arm-kernel/ZJ78hBcjAhiU+ZBO@e120937-lin/#t

The free in deinit is not to free the ones alloced in init, it is to free t=
he ones
alloced such as in scmi_pinctrl_get_function_info

Thanks,
Peng.

>=20
> > +}
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20



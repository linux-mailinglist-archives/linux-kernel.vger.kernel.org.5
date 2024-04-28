Return-Path: <linux-kernel+bounces-161418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9798B4BB8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 14:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 017E4281B35
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 12:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7666A8AE;
	Sun, 28 Apr 2024 12:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="itz3NXWO"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2052.outbound.protection.outlook.com [40.107.105.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08865B693;
	Sun, 28 Apr 2024 12:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714306900; cv=fail; b=keqHlfY1NN9hiLJKYsZ61p0AtzRN/H6szIXwYc4VcGOFUOIW0XBMlJSPmRk0A8ZGJ245VGkU4CkszGARmJXIB8AVup5pNXc0RDAWT0+aVbVWjKV64mpE/377XnG6Gn5FW8j256mc2J65h1+v1x28wKmr+lLta0fWy4zpxDVmyUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714306900; c=relaxed/simple;
	bh=onK/hv4SWokGinhb+2LBa37YvFPzR+wogzrXFIobPlU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lw8GMeI1HbBQAu5pLq8Urmc5dSm55GkdUyYnTN8t4s2/ivBDJdh6dpE4S9F5kZbqTl9yOh9dpwtKRDx1MOtzJdaO/IvCAPzzKC227Z4K+cM9iv/7Zuoh65R3uTQ8WqQJi6ak+Vias2mJStkLpIk06ykeMy6Bn6R+H3cb8zG2G0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=itz3NXWO; arc=fail smtp.client-ip=40.107.105.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDYMj2UHwbGlgcRWFFA7S9tgvRxyjsYJ/1dbkGk1PVXy7qLlAKa81pumnXQOG6GKryM+2vBfjd+1Xx5Cr2GgHMJhkOzpc7B865ulmjpZinXk+WcnO+o6R41nNTIshLE0a282tZ0S1uVTpZBHAYmzPvpiNsPay9vC2MrUqUne2O07ves4X9nCDQGlSLiX+gDfHPovWvjKrPo638WiZETExsTFdtpJYc0Gl3aPSk0cKO43rDiqQl/T4dNEwWDL6USSbpXVupAySyJarFGMUwrwk7BargAAl3y1zekBKTFWr8ImfcvpAcvtOkDZ+mGLRdHxjURMi3FtrL4uQEL14mLTaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=muiDBUq0aSoSbtywZP/m8i83ko/IUsL+oP7W8MiJCIQ=;
 b=CwmFWMuTfJWDR/ABB3zfdHxU1kc9VcdRZtn5owO/IZTD4w5NM27vfEQoZimE5DYJ0bdtAOHb/L6IIeT28cy66EFjdA+CzMg1Ewg/nSw0o7Z48sWOJVnV2yXpWaq8Xopn0lJgyUNqTEMjuF/SGFmzHa+n12OuiWtWcwEBE7CeygibmBDLzqVFBNTao+GJTih+DDZkjuW5aeZLAcAXDsIa+V51gJs2XAB9b8iBUO6Veq3LGJ0hyTd88Gu+APeC/5NEWDaHAFouLv5ccOjX0iCcscA+vtDsiKDFxHoNTz1Fjoobnz140dcS/MpfCAME+c2nyuC/GocGTD48RI++esBZmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=muiDBUq0aSoSbtywZP/m8i83ko/IUsL+oP7W8MiJCIQ=;
 b=itz3NXWOrWBPtTPsvvfeBRronf0iYbLYVgPwqWZepifYkzurtPOv43E7uTTAi+U9no/hh8Wv+P95ucEfYvOwKHTfe0fzfQEdenA2b125N5XkOWYQq8V/Txub3wYiuJ205Vd5OmuHSjdzjICe6Ri0OBwBYNnjAbhM3gRd2skMMaw=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB7018.eurprd04.prod.outlook.com (2603:10a6:10:121::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Sun, 28 Apr
 2024 12:21:35 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7519.031; Sun, 28 Apr 2024
 12:21:35 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: Sudeep Holla <sudeep.holla@arm.com>, Cristian Marussi
	<cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>, Aisheng Dong
	<aisheng.dong@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: RE: [PATCH v3 6/6] pinctrl: imx: support SCMI pinctrl protocol for
 i.MX95
Thread-Topic: [PATCH v3 6/6] pinctrl: imx: support SCMI pinctrl protocol for
 i.MX95
Thread-Index: AQHamSj/KWNiz3mJO0CVZfKqQ8uNkbF9l/eAgAAAZuA=
Date: Sun, 28 Apr 2024 12:21:35 +0000
Message-ID:
 <DU0PR04MB94171C7DE932EB8EFE0CDCA488142@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240428-pinctrl-scmi-oem-v3-v3-0-eda341eb47ed@nxp.com>
 <20240428-pinctrl-scmi-oem-v3-v3-6-eda341eb47ed@nxp.com>
 <1bc4d494-f4c0-4bec-a2de-e9971ef4be49@moroto.mountain>
In-Reply-To: <1bc4d494-f4c0-4bec-a2de-e9971ef4be49@moroto.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DB8PR04MB7018:EE_
x-ms-office365-filtering-correlation-id: 68dd09e5-8f03-495d-a738-08dc677dbf58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|1800799015|376005|7416005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?9vS5KpBIFnJ4bOjbyo+qnVWoY0qMrCZyl9dbX87yJF7l7ob6bCXOVDf2F3dy?=
 =?us-ascii?Q?K8UyA+HsRgEabDq1EIChk1HYEtsYaUNT6sFG9ebQfsASDL0YiwzUHHZKx9mK?=
 =?us-ascii?Q?7dBJCOmgGhT3U43B/tPWqIvfn2tc7MJBRzrx/rzYqBrDbzTcW3fAIJ/2baMa?=
 =?us-ascii?Q?U36+mjqhh2/p+AjI9W6gw/XeUnv8LdTjnDSw7WeJkUqpyJzTLu6fz01XGPsR?=
 =?us-ascii?Q?9CM+qoYbTXnJcYwuepAvpdh4vU7AxQNghgUJLKnuiak1RomNAl95CL8cKriN?=
 =?us-ascii?Q?XDtI92UGeu/ty+Ej1eiJAvwA8eilJoiDKgnWUjJSZyREuk2icMPWviLp2evT?=
 =?us-ascii?Q?6u9bazr9dBKFg6dCabTEIUkrYtIzXykUuBsCPq5kXXSSw7zEx/KS1ug9PfgE?=
 =?us-ascii?Q?HuGAABFXVS6rqyrdHReGXUJeZ2HN1GqAt9MpTEuVJRiVx0cHmKyCm6j4RM/k?=
 =?us-ascii?Q?U5qZnTMp/gijdlWjzBNYQdYkHZnJ1MGiOxXvj+E9Eav1fxfWfA07GGm72PCc?=
 =?us-ascii?Q?CXJD4erTpmcjG3c1h2y051wBlom6SFPui5iDHdKmX6MC7W+RaY8P8sMkuR0g?=
 =?us-ascii?Q?xS+FJpxeZLy/bE394mzsyhrG0tsPQCGcliGMsHYsaZahPbqtPsMM4BlW0ayM?=
 =?us-ascii?Q?Z6spXmpVSxlcnoISS3DtVflKzpP4T0Qha6qpIrKHvyd8EiNF8tE3HmfdODNx?=
 =?us-ascii?Q?7CMULOfJhauHWohz97+S9f8kKGBIkzeG2FBZWQipn7xSRWQs/QPSK/52GBQu?=
 =?us-ascii?Q?7Fya+2hNyujJfF5BCCaxmJ2rJ/q3cGVgj7LVQk28onWRmZ0hQRtkEu/7cR2S?=
 =?us-ascii?Q?bdyDfxbVm8pQzFjdqo7OPnHz8WAyIpGL31z5VBKiCMyMOQ0FP4qWZXVj35mo?=
 =?us-ascii?Q?KF3isWUH0BHtJN6kYl9lCDZDLXvmVfb2m6Kw4WYdRK+Sva6u7FFoQZhtpgEh?=
 =?us-ascii?Q?mp8C6VVcteRLQj82woezFy5oibudnvoBwHtb+DroOhTNouMLyETMIdU/PD63?=
 =?us-ascii?Q?U1AHMLtCUor3kD7zGMXL40wmQ6kpR4oQKn8Y2NQBgGBtZ57LdoRVS0OpyOsl?=
 =?us-ascii?Q?xNmWuxEnV+2AZ/Mgw+PS71z7YLo+LfCV6VL10rvUWgpBP0jFXrx7GgmkTVgw?=
 =?us-ascii?Q?ytTGTuOenJyJAkHUJQDGQtCS8IcCUDIwf91hQsz5sV57lbaeqp3Wgs6gCFTE?=
 =?us-ascii?Q?D7VpHP0WpVdygzEJoqjJZmodtJGx9HfhYrv9o5vjM4CAr46w8YQ26tDczR47?=
 =?us-ascii?Q?U5pvTX6L4k9TsrNSnvJc8S2ml+AkeD0neM5oGXnI/nrbhVXG5WsU4dXL3ZO5?=
 =?us-ascii?Q?nhPrV+T9G2dAD6pFFgdUzEDTgXfz6SfiznHeX5dzujBdSw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?d/tEm2nWPivtxwKA9lUeX+kpk4VNlyiBVux+oyUfOjm8QgDbQxhOcUFmv2UX?=
 =?us-ascii?Q?/NTLRL562+sMFQEB/4WKbEuCzfL0SkGIfG+OuU2SSS56nxs48XzkQ2hCipzB?=
 =?us-ascii?Q?PEUVA3RSNid+TNBnvuFDvFuPjK5qwrrOnijuMZuRfGgfNSzu1iY5vE23Dglw?=
 =?us-ascii?Q?mTSosrbL51wkeDVhP/HOXZ9qPh02MSEJO3TDJoPuYi3sloAfOZfCZGx2WCje?=
 =?us-ascii?Q?hYv9YkOC8UmKMRDB9Vd2rRaPJH/GnsspLtdG8RopS650wd01YOkfUduODLWG?=
 =?us-ascii?Q?Qnhb3soR4mF96Xbpfy3KqVoXnttS5D64XGBwRRkEcrWLOEuW4hjqhYyMcRjY?=
 =?us-ascii?Q?SIAr3IN5pRzQfdkgMy5YompABh1dBAqbIZOT7kwxQ1xmIHDOI2bMSn7BlWLL?=
 =?us-ascii?Q?NWSFBZ1MS9LMmZDAJgOjNCY81k84rDWbhXooboT9PRI4nzH+gi18JFTFU6qj?=
 =?us-ascii?Q?1pgrEsjMlbqq7p7kNgWgE28TLEi28CFh5bfji4H2fCI1jHZGG9Gvkou4dulR?=
 =?us-ascii?Q?svorCE4cAng3M4H3C89P5pfDoPKy07K+gBMhJKmX1jKBfyQwKjGWzDZY3mVV?=
 =?us-ascii?Q?aMhFMIbZHxN+h0KylH+EkUWUAa7xwMrjvE4FOHqClUKT224EKZu69s7JuX3c?=
 =?us-ascii?Q?TPEpe1WFoLbsyj8ufcy0W5CETrMpGpi4w7h+0pH4EyyIapLhCdufUMpT3cex?=
 =?us-ascii?Q?IHX6aNNFZxinm+lssmZ69DUY7weUy+B36o3rfOv9Ee0smveVKFxzwmLGoIG4?=
 =?us-ascii?Q?fCkm5fQjDQb6arrNPEXib0k2EOKpcTbwEXLtVD32jSwRsPw1u7/mtD6L2/wR?=
 =?us-ascii?Q?xntqb5PK88TPRGPhL6JQiFQKL4tImHfXffylVOeKO0v+5KonklhoagrMVtH4?=
 =?us-ascii?Q?YactwfzQRlK+L237WQSt2P6CE50PIwnldh2H8uGAGrR38bEX3ePvtk6RiVBo?=
 =?us-ascii?Q?FGDRj9TVKoDr8wj17ycxmDp8o/gztYrK9V15JuuPRKNMTWcMcopM36onlzkz?=
 =?us-ascii?Q?IVUXjVJOeQTmPx2ecmOBOXewfNrOZjQNVVFo0DU0OIVYwFzVGPbZvEGY/+5l?=
 =?us-ascii?Q?D1Atxsxw+2ymWBnxSOZBqwp/rU7mK/1USQBTIxMVdAVnXk7LbXrHc9AAHn0E?=
 =?us-ascii?Q?Y8NhDi6DUhjxfzF/b9Lubep7te232E+1wb+J0Lx6VEJdjp4YzO5jaLZTrWp5?=
 =?us-ascii?Q?ZiXBL4irsxusvKDBssXJ34FcdYn7IYfMEwvR1pIdK8AvVmEpHmUhPNB4blfi?=
 =?us-ascii?Q?gv+lpXtskyx9UdRTqfWjO7zU1Y9aHFao/A9NpMNzSkRZSKJZGDqkz6+jOp0Y?=
 =?us-ascii?Q?HXC6PNp98Ne1WvenELrMKHJhEbPmrsjU99l7yHMWdIgzFkEFNP2YGIARYsDx?=
 =?us-ascii?Q?1tKgffvtL0QbJPIu40AH4D/CG7BZ/OxJw3mkjEGd1dbhVHLFBd9sVov9zsit?=
 =?us-ascii?Q?PPG2JhaJsaPOISowOrxcbFtQsWmBTDnUbE5HVLWV8TF0LKyCXcm4YuUIpibv?=
 =?us-ascii?Q?7huQriXmQYR26jFvSTz5NdIFvfqIgjkP7wWQaa7lxpmt+Sgs4bwmG7fHk4mI?=
 =?us-ascii?Q?tGA09UzXs0w+oCetMEs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 68dd09e5-8f03-495d-a738-08dc677dbf58
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2024 12:21:35.8446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9R5CM3MshYwxt2NZJpzs27bxfvQ4J1JRTIpGRfd+zEd0XMQnF73zhuYBK+tRnxe7gUoS9w0lOszc9csy3zOvcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7018

Hi Dan,

> Subject: Re: [PATCH v3 6/6] pinctrl: imx: support SCMI pinctrl protocol f=
or
> i.MX95
>=20
> On Sun, Apr 28, 2024 at 01:07:52PM +0800, Peng Fan (OSS) wrote:
> > +static int pinctrl_scmi_imx_dt_group_node_to_map(struct pinctrl_dev
> *pctldev,
> > +						 struct device_node *np,
> > +						 struct pinctrl_map **map,
> > +						 unsigned int
> *reserved_maps,
> > +						 unsigned int *num_maps,
> > +						 const char *func_name)
> > +{
> > +	struct device *dev =3D pctldev->dev;
> > +	unsigned long *cfgs =3D NULL;
> > +	unsigned int n_cfgs, reserve =3D 1;
> > +	int i, n_pins, ret;
> > +	u32 ncfg, val, mask, shift, pin_conf, pinmux_group;
> > +	unsigned long cfg[IMX_SCMI_NUM_CFG];
> > +	enum pin_config_param param;
> > +	struct property *prop;
> > +	const __be32 *p;
> > +
> > +	n_pins =3D of_property_count_u32_elems(np, "pinmux");
> > +	if (n_pins < 0) {
> > +		dev_warn(dev, "Can't find 'pinmux' property in
> node %pOFn\n", np);
> > +		return -EINVAL;
>=20
> 	return n_pins;

Yeah.  Fix in v4.

>=20
> > +	} else if (!n_pins) {
> > +		return -EINVAL;
> > +	}
> > +
> > +	ret =3D pinconf_generic_parse_dt_config(np, pctldev, &cfgs, &n_cfgs);
> > +	if (ret) {
> > +		dev_err(dev, "%pOF: could not parse node property\n", np);
> > +		return ret;
> > +	}
> > +
> > +	pin_conf =3D 0;
> > +	for (i =3D 0; i < n_cfgs; i++) {
> > +		param =3D pinconf_to_config_param(cfgs[i]);
> > +		ret =3D pinctrl_scmi_imx_map_pinconf_type(param, &mask,
> &shift);
> > +		if (ret) {
> > +			dev_err(dev, "Error map pinconf_type %d\n", ret);
> > +			return ret;
>=20
> This should be goto free_cfgs.

Good catch. Fix in v4.

>=20
> > +		}
> > +
> > +		val =3D pinconf_to_config_argument(cfgs[i]);
> > +

..
> > +
> > +{
> > +	unsigned int reserved_maps;
> > +	struct device_node *np;
> > +	int ret =3D 0;
> > +
> > +	reserved_maps =3D 0;
> > +	*map =3D NULL;
> > +	*num_maps =3D 0;
> > +
> > +	for_each_available_child_of_node(np_config, np) {
>=20
> Btw, if you used the scoped version of these loops such as
> for_each_available_child_of_node_scoped(), then

Yeah, it will simply code.

>=20
> > +		ret =3D pinctrl_scmi_imx_dt_group_node_to_map(pctldev, np,
> map,
> > +
> &reserved_maps,
> > +							    num_maps,
> > +							    np_config-
> >name);
> > +		if (ret < 0) {
> > +			of_node_put(np);
>=20
> You could get rid of the calls to of_node_put().  I would move the call t=
o
> pinctrl_utils_free_map() here.

ok. Update in v4.

>=20
> 		if (ret) {
> 			pinctrl_utils_free_map(pctldev, *map, *num_maps);
> 			return ret;
> 		}
>=20
> > +			break;
> > +		}
> > +	}
> > +
> > +	if (ret)
> > +		pinctrl_utils_free_map(pctldev, *map, *num_maps);
> > +
> > +	return ret;
>=20
> 	return 0;

Thanks for your quick response, I will wait for more reviews, then post v4.

Thanks,
Peng.

>=20
> > +}
>=20
> regards,
> dan carpenter



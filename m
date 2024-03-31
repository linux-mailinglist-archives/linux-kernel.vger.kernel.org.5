Return-Path: <linux-kernel+bounces-126062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D0D893196
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 14:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CAFC2822D8
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 12:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA8B1448EA;
	Sun, 31 Mar 2024 12:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="seHIEUu0"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2097.outbound.protection.outlook.com [40.107.6.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763541C0DF1;
	Sun, 31 Mar 2024 12:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711889233; cv=fail; b=cP42rVIzFxA7tYV1DadZhXifhdBmOu2R/zqr3kdrrqgjvokMYMHTBetsTkpRxSaSz+2cJfBYNu4Fvj8oULv7JArGo9UljjO+9uoY5thWCO2y5MT6G/eVQAzbbbPrgmhNVspKcZ240S5uxfn86+4e0f5wCHj/G92/JxepYu7n3RI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711889233; c=relaxed/simple;
	bh=51WNL5hovF5lNn12ghNulTG893hEDw1AOKrC58wHWQs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ABN5KyQmTh03/s7T9iroy2Bg3+PnxKav6hR5lQJ5v5ZUbKstT7c2ALl8NQETeHdYS7ZB3ywAVuBdp3g6HPkO/bS0HO2DxNn4kR4/I60ecyGVT+MTxh7oPiS+Q6FswX8QzXGt0CX9JbzocnQ6E7USX6xzYS2vxivsEwsg1T1hP3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=seHIEUu0; arc=fail smtp.client-ip=40.107.6.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZCYLr64BJXTlrYf0RjClnT2qXvpiKcSbaaVbdgCZ/j6EKa+dsq3LZ4FRAAFwcloGsFzVNYe6SNJaMyrcc+EFfIVyH8nTtipHwsjXj4idFJVpQguvXF6KRcjgHvM2dt87Psx2r2MaZ5+o3Yuj5f+8nO/wqXyNqd5fV7upsT7/CkMYHNTVVfrvJf9NU8hsktTH3+hNM1D2Ka7h2auPOsq40VN9sob5vqUpSgSipORp6qaGUpEy7IAfLceoqYJ9WWdDuWouNIFiUPxKOcEQe40KyeE9MEIuTWLswr2vow5bk+HwTL51VYuuximh7lC2NLKbNwG3SoA0l50oG521wGsng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMPPTj8+ku+xFg3h1OA9sKhlB+vQ3TzdCiuFXhVe76M=;
 b=I/wRO04erWTpyXWPPT71+zmMZANVfC0ilV5hv+RwxTyVifXo4tObnuBE14lDjU+VgkHPzsOmIbAYo9rjXkwdPbXHSehupYCno22hciY3xXNCD1lUEsC44HbUbPXVkiAWYcthxK19GBTW8u4HCSfVzzkVzfUIJmZCFvSTaD0cLhRC1OrzvS10NhpuThWLSO790VHHqps5QA+ANs9SiFf29HXhKKlb0kAGt/uoZ6YcteT8hZV0CQuRFgTeYbUgUq3DhOnETNCcHyrOn/innSaWbT5gVuJhKaHQCItmLUWgIjGYfmyl7ljcwty2miDo4dafb7DGO1Wptq5+S2XBoXZGhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMPPTj8+ku+xFg3h1OA9sKhlB+vQ3TzdCiuFXhVe76M=;
 b=seHIEUu0P2Wumt5/r5jXrkK1YzN3mackmQKPf/umtMWAF5PZchj4owy7oLQLsF3dvW9lPa6FmQMXzkWr06FSw3HM9+lIAsFusrQ84HuNNRgQLLmA9wz6DPy6w3E6kzfuCP/yw9xphJX9qUDnQMksNUPfp6sXnEdosI61mnKcRLY=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB7022.eurprd04.prod.outlook.com (2603:10a6:800:126::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.45; Sun, 31 Mar
 2024 12:47:08 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Sun, 31 Mar 2024
 12:47:07 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: Sudeep Holla <sudeep.holla@arm.com>, Cristian Marussi
	<cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Subject: RE: [PATCH v6 3/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Thread-Topic: [PATCH v6 3/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Thread-Index: AQHafRqyofu9Mu9OLUiaociI+9q/i7FLbcGAgAZqduA=
Date: Sun, 31 Mar 2024 12:47:07 +0000
Message-ID:
 <DU0PR04MB94170E50A016CA5AAB971D4488382@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240323-pinctrl-scmi-v6-0-a895243257c0@nxp.com>
 <20240323-pinctrl-scmi-v6-3-a895243257c0@nxp.com>
 <4879ad5d-165c-4118-81f7-8f6348a5a5d4@moroto.mountain>
In-Reply-To: <4879ad5d-165c-4118-81f7-8f6348a5a5d4@moroto.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|VI1PR04MB7022:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Ub/i1u4m9bEAv0xP8yRFIHpd5IrGNR5SswEuQ7OuxzUqStBlcuPHkybi6pcT3+3B741CN3IAq0c6o1rNwzAfDQ7xPaceL2eOIfAVDhHuZ34hJ8ad0L6t1fjnFf8kLDYiSGAGwSFvZ1Na+VkcfpMfDLodbmxI9widCj0oNkWW/hmlt+piFbvNtFqDuS4PHTojJ1QJVhVHBnd3o0P+rG9WhR/eIqPjQKA7v7n5JpfmSSb+gJAd8KJzJT0yrfWQsvw3+nhDOZ3ijwqXxBWo/rAID62p8AlWhdFAXXvAQEhHfjPilxox0r8HfmzG+eGzIbHpNXHztA446R+cZX68432p5psA8FWJI3sHeEim/47Gt8S8XTRfSIWOg8wOHA9I/359daY/WvocEwPBV/KiusfaHOCTwUb2L6aL9PL94Qvn8aslh41dhJqjSoKnpKLRRrKw0p2Rddz4VwG2kOAJ0EzLR/aggWGwtalRP+XaMPDJOunCF+6cfo5vJGPWYu6P7McvXvA9GeV1GLlagBveV811CRzoOu36bQ/rspMipaE8XVOYuV5LGmbvtFk7uJAzAPJdUVaTynNxyQML5vacuanqR7Bauh6AcvYpr4P6mFw3jibRznoyxQRXHC9pDf6dZ+8keWJLoYk59zgIE6/3aJIYtkDIGoXicnhTjDrIunX7U08=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?C3fK37y0jjJm8xFudvuad+swbeR2izsJFXYLp/bFKst+zdEdk5Ughco7YeYq?=
 =?us-ascii?Q?oZUXG1Mf5Bmy6Y+5BCdnOoAGU/fR6e/cr9H3BKv70X/eVakkBqzZVQO04At0?=
 =?us-ascii?Q?RmpJ3lvPxJ4OybPbx2bcrst76l6ecAdlnUzT+diKCVQMasZ8FPoVTBIHMNig?=
 =?us-ascii?Q?tRzx37DsVNVJ/wp/laYYBjRApR3TJ8BZx2VkbVBxzl3+n56q+Zt3myO1TN9r?=
 =?us-ascii?Q?uhAZL7jhkMLLp7q/fahXT9pzq8X30SMHPlko8rYkB8emZHFbKaTqexNXobxR?=
 =?us-ascii?Q?syXEmvqRwKxLnc8dRXPqZiLKKMLhH7mnQFVuL9anLHlEFcbFNyXLHSE2fMOj?=
 =?us-ascii?Q?b9A+74eyAGp5gEFg9XoIq2EDXxiIVPwpAfh8FAvrWTyJxygYfts/GoM9wQCV?=
 =?us-ascii?Q?NQIMbbQ+hfQkHxidYKO7bb1cLYK8ctM2gI2U6lWXsUZOK0/OvbCae2Q6rEes?=
 =?us-ascii?Q?hWdG0XqkOnrjOSzlWcZtFUs9gqMJT7oimA5pzCtzxKnQ/99SUkyHT/r7/E3a?=
 =?us-ascii?Q?K2wLaths2Phr9EWHwr/yarNrjWS04f/In2gJuhZZ+JGiQqqk+F8vEmKEMG4t?=
 =?us-ascii?Q?BANStxt2V+pXHt7DG/WaO1GMtZdWexkT66JBCF4z+3aiffQiAKhWEAzAO0pQ?=
 =?us-ascii?Q?F9a5kzGRQHkrhE71hI9Cb1p2mJumjB6lFYhs4rQDAJ+c6VAtAiXtRIzUSrYa?=
 =?us-ascii?Q?IPFzt3iHhBQwzUjGeENdpYIqa4VQ18Q/uh7Ow1o6ZmMA9cE6wIpPuAp96XZn?=
 =?us-ascii?Q?evNmoshkRy6zHBHeyUtClF0GvW53hcA7+jYdZ+xr6XVEh8YNd0GsC48sNWod?=
 =?us-ascii?Q?4L/HZ14epthdUDAc5lM1npDX1Bww8CuZ61MYKc8QPqaq6WqUBYNOscy8Z/6T?=
 =?us-ascii?Q?/Z2jOLLk95WwSUa8NWhoidE2g0nAoXBv1NYmHzLdfh78Vj375R1oMR6XStOi?=
 =?us-ascii?Q?XixQ9C6oCzIFooDFn5jpgy6AvQJiSJcgcXbpOLXalVdQco0l8WiGRx07D4HX?=
 =?us-ascii?Q?i5X51iYWysdsDPRJ9Eyn9usXvR+u3bBGisRThB7clJ6x9xS0ipb+wcTIRkIP?=
 =?us-ascii?Q?0OtIodKh3ywfoPp14/F3z83hUU35hEKZZZi/8+3FaCjZQN4dlvDYTCeZYFly?=
 =?us-ascii?Q?EzVsRI0aJig1wxqtketALOeXOGhMYyTZIZY9VUx0MRU5PTlEIeA7zq6wpu+s?=
 =?us-ascii?Q?hBIzclXiJr0N//kYrvk4W7TRh6bRNFazkGLFu1qy7niG6+ouKYVNSTmYH3af?=
 =?us-ascii?Q?pyqV+/gr7YFwQRztmkkD8QFmnrE5rqd2G31xgoEyM3ClYXnGO9J6h1MnNI0z?=
 =?us-ascii?Q?jMNGxydkS9T5ZJ4is+xk+rVFZObdU7aL5Uyq0CPLL3IReYB71Kckc7VpHzE6?=
 =?us-ascii?Q?Hk9/BCARue2st1ii9uZ7cGqIH7++J1VU8CeoEi8wQ4n5cXHnpyFDNZYHF4Kb?=
 =?us-ascii?Q?XuXYvx56FFQZ8zB6p5fVKn+j9lsfOANDSNRt8GbiNmwivQBHsI68IRCsc0BW?=
 =?us-ascii?Q?e+2SmBvnF9Blya35FwqBEkVpefZ0avxQJsu9GXJeqt+7G3QmkoLnMoPQku8Y?=
 =?us-ascii?Q?JfIZID1zw6YeWUmDmNY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5272c5d8-3a0f-47fe-e81a-08dc5180acf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2024 12:47:07.8723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W8l9Sy9cb2boJAptqa39bWARx9ZdcpkQwxMfwuNlIv4SEZF//TVdmmx6QW4zY6SuLB2a9glc5P0X55K8ZC1mFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7022

Hi Dan,

> Subject: Re: [PATCH v6 3/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
> protocol basic support
>=20
> Looks really nice.  Just a few small comments below.
>=20
> On Sat, Mar 23, 2024 at 08:15:16PM +0800, Peng Fan (OSS) wrote:
> > +
> > +struct scmi_msg_func_set {
> > +	__le32 identifier;
> > +	__le32 function_id;
> > +	__le32 flags;
> > +};
>=20
> This scmi_msg_func_set struct is unused.  Delete.
>=20
> > +static void
> > +iter_pinctrl_settings_get_prepare_message(void *message, u32 desc_inde=
x,
> > +					  const void *priv)
> > +{
> > +	struct scmi_msg_settings_get *msg =3D message;
> > +	const struct scmi_settings_get_ipriv *p =3D priv;
> > +	u32 attributes;
> > +
> > +	attributes =3D FIELD_PREP(CONFIG_FLAG_MASK, p->flag) |
> > +		     FIELD_PREP(SELECTOR_MASK, p->type);
> > +
> > +	if (p->flag =3D=3D 1)
> > +		attributes |=3D FIELD_PREP(SKIP_CONFIGS_MASK, desc_index);
> > +	else if (!p->flag)
>=20
> This is a nit-pick but could you change these !p->flag conditions to
> p->flag =3D=3D 0?  It's a number zero, not a bool.
>=20
> > +		attributes |=3D FIELD_PREP(CONFIG_TYPE_MASK, p-
> >config_types[0]);
> > +
> > +	msg->attributes =3D cpu_to_le32(attributes);
> > +	msg->identifier =3D cpu_to_le32(p->selector); }
> > +
> > +static int
> > +iter_pinctrl_settings_get_update_state(struct scmi_iterator_state *st,
> > +				       const void *response, void *priv) {
> > +	const struct scmi_resp_settings_get *r =3D response;
> > +	struct scmi_settings_get_ipriv *p =3D priv;
> > +
> > +	if (p->flag =3D=3D 1) {
> > +		st->num_returned =3D le32_get_bits(r->num_configs,
> GENMASK(7, 0));
> > +		st->num_remaining =3D le32_get_bits(r->num_configs,
> > +						  GENMASK(31, 24));
> > +	} else {
> > +		st->num_returned =3D 1;
> > +		st->num_remaining =3D 0;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int
> > +iter_pinctrl_settings_get_process_response(const struct
> scmi_protocol_handle *ph,
> > +				       const void *response,
> > +				       struct scmi_iterator_state *st,
> > +				       void *priv)
> > +{
> > +	const struct scmi_resp_settings_get *r =3D response;
> > +	struct scmi_settings_get_ipriv *p =3D priv;
> > +
> > +	if (!p->flag) {
>=20
>=20
> if (p->flag =3D=3D 0) {
>=20
> > +		if (p->config_types[0] !=3D
> > +		    le32_get_bits(r->configs[st->loop_idx * 2], GENMASK(7, 0)))
> > +			return -EINVAL;
> > +	} else if (p->flag =3D=3D 1) {
> > +		p->config_types[st->desc_index + st->loop_idx] =3D
> > +			le32_get_bits(r->configs[st->loop_idx * 2],
> > +				      GENMASK(7, 0));
> > +	} else if (p->flag =3D=3D 2) {
> > +		return 0;
> > +	}
> > +
> > +	p->config_values[st->desc_index + st->loop_idx] =3D
> > +		le32_to_cpu(r->configs[st->loop_idx * 2 + 1]);
> > +
> > +	return 0;
> > +}
> > +
> > +static int
> > +scmi_pinctrl_settings_get(const struct scmi_protocol_handle *ph, u32
> selector,
> > +			  enum scmi_pinctrl_selector_type type,
> > +			  enum scmi_pinctrl_conf_type config_type,
> > +			  u32 *config_value)
> > +{
> > +	int ret;
> > +	void *iter;
> > +	struct scmi_iterator_ops ops =3D {
> > +		.prepare_message =3D
> iter_pinctrl_settings_get_prepare_message,
> > +		.update_state =3D iter_pinctrl_settings_get_update_state,
> > +		.process_response =3D
> iter_pinctrl_settings_get_process_response,
> > +	};
> > +	struct scmi_settings_get_ipriv ipriv =3D {
> > +		.selector =3D selector,
> > +		.type =3D type,
> > +		.flag =3D 0,
>=20
> ->flag should be 0-2.
>=20
> > +		.config_types =3D &config_type,
> > +		.config_values =3D config_value,
> > +	};
> > +
> > +	if (!config_value || type =3D=3D FUNCTION_TYPE)
>              ^^^^^^^^^^^^
> config_value should be optional for flag =3D=3D 2.

As Cristian replied, I would keep it as is until we have a case in
linux that need flag =3D=3D 2.

Thanks,
Peng

>=20
> regards,
> dan carpenter
>=20
> > +		return -EINVAL;
> > +
> > +	ret =3D scmi_pinctrl_validate_id(ph, selector, type);
> > +	if (ret)
> > +		return ret;
> > +
> > +	iter =3D ph->hops->iter_response_init(ph, &ops, 1,
> PINCTRL_SETTINGS_GET,
> > +					    sizeof(struct
> scmi_msg_settings_get),
> > +					    &ipriv);
> > +
> > +	if (IS_ERR(iter))
> > +		return PTR_ERR(iter);
> > +
> > +	return ph->hops->iter_response_run(iter);
> > +}
> > +



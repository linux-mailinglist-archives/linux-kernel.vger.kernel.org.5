Return-Path: <linux-kernel+bounces-128099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06316895617
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF93D285859
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CCC8594C;
	Tue,  2 Apr 2024 14:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Rc6xvA6C"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2102.outbound.protection.outlook.com [40.107.104.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959A284FA5;
	Tue,  2 Apr 2024 14:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712066668; cv=fail; b=IRbve1lu96tX6hgwkG/gLf8W8k4bsqGmY5DB5UKvXnUG0OlQpS46dyojmAQnZc/YGJLPhvIAy5AKLeCFU68RFuSWCdraCedprNgz+ewE2vb9LxjouAVONyO/kxWPpwjqos4RNp5K2OVuBHUorERrOHInoz98CHJJ4hbBdUFnIEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712066668; c=relaxed/simple;
	bh=KVdvfxPs8KDUHrwpzAKY8oElAorkwAZ/w1+DOHS1iEc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mQMaTjwa4EjqQxmBeWFHawIyDpoFNPsXaXtnBTZwgrODnlPPAn7HIY3sgfEhlHK4UnXdCWkbL/fVCoqmv+HJTjqX3zsPEJalRX0C441HX7rFEGc66KFtvK5qXW7CCLSHwsscvm2VG0w9583zxdmUKBNBhvXqKMXqkqI+hOnC5Fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Rc6xvA6C; arc=fail smtp.client-ip=40.107.104.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kzuo3ERRrxqM/3Y9/j7aqX0cPJ4uef3N6nRfn/59KEzVE8lTGTttiI+JDVtVJOuqW/RvwDmmqpFK+qnFkZt7o7kvGjhblCr3Hm181c4ew004d82uY4dAktSDZwNULcskfFbrcMojYSKSI84DVG/UNMKKX5h0osI4PbmjW1ATcF5AZ0jfGJbp7OHFMRoOYRCe62DgxyRRndffEH0+hwbimOaKuZuRhriLTTyFLMNUY68NrjkrVb4EJZm9gGwjET0ZL2hfD6/Gou33To9XNZ6X37X2tu5VxeQG4GABFw3qD5gynUgL4F2X2ewdtQRRrsLNCvvmSQAm1IeTPCmG7Da3MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDwyO0IhlYqqrKMF3YIlp3jFUaq70ex1y70tRoPjgFs=;
 b=a0Sa9lMZL74geWB5vjiiTjcaIx6Qw+CaWs35FJ1wDfA+TdqWDZqHuYlHATotFy7+rO10cJkMgkrH+hMtSnXqFnI+i/6sGdVeuiTVrCPqb/C+S9UJ6Z0w7EEFoaAQAvZJbaMF/JUYOf6CtRyBBCsXt17dGn0k9D87idaO4t3Vva1cv6uOUnLdJkYLL0QtY2t1Lt098zzG/QlZEZ/dA2CK6QdZ62k+9Oxze3N797UZAeG4Pr2Htp5qDmm9Jh2YNpRH8J4stpEogvaM7L4ekKOzTFdrlcvnApvCOII8Opk0gQqULolsf1l1oq3kDEwMgqEhMCiGAspRNzYP/1okYYRNbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDwyO0IhlYqqrKMF3YIlp3jFUaq70ex1y70tRoPjgFs=;
 b=Rc6xvA6CHkpWJV9ZzH8QEGpQKNzX3G1sYr/IUOw8uutttxyjtupwM0Gpew/0os2cp6EI4Hi46OrY+LN+6yowb+ALII5gok/WXEg5sU3rqr2j+1/jqlPACcvKEb5qxTB1J8ovph6jPaE0D6D/u5UoKwthV3BiGYrl/eCv5+bfN38=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8411.eurprd04.prod.outlook.com (2603:10a6:10:24c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 14:04:23 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Tue, 2 Apr 2024
 14:04:23 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
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
Thread-Index: AQHahKOBYTQv1KoiVkioSbRA3lNLQLFUx+IAgAA7aVA=
Date: Tue, 2 Apr 2024 14:04:23 +0000
Message-ID:
 <DU0PR04MB941718594983D668A418879C883E2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240402-pinctrl-scmi-v7-0-3ea519d12cf7@nxp.com>
 <20240402-pinctrl-scmi-v7-3-3ea519d12cf7@nxp.com> <Zgvd7npz1jdJSu-b@pluto>
In-Reply-To: <Zgvd7npz1jdJSu-b@pluto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DB9PR04MB8411:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 iFgpgjmol2Caljo9kaUzuMBV3EW3IToj0CKp432EempKOuCs5igKflhhqielwPS0gbqimquNI5AUuoXVBom50crqDH/hPPtBkK0HxkGfOzaQA/2+q06D83D01ih3O9zAIKn7jmzsDRm6ox/+Sd1OJrb8RM8jV4udDDx0oDUDzjqoBGZglseVqeN52hC31fReL2Yyp0kkvi0Y4DzJX5YrHcSAaUdqrsC0A13dZoRxCdu0dBLml14GFfdRiMhZV0l26R7gzxfdEo9QujoQT7t9rd1r/OT/La9JI+F0ucNbSuZolN8JXXkRWHRiqIyiQ9+bCITbxkoRJeEcNbncyFyL7KBJcwRmAKqVFpU8mgwzKYfcEROOelWDYtmKDaed4f8Ihz0i9UbSUHZfWSPzRXznbjUBURDDgc7vTSUWG2OyFqsbtapEVOXsc6UEmIMD+eTgr2vYJw8+vgn580eS5KuxaWsQp2t/aUR1s9rpXMphgzEoMTsICnQSPl8WxNDAG1mCyMxHhQyd0Wmdxyq/FaZq7Ac42eN1WRtR7c5PxPoyhkAnjnauAfDDpbQ3vhdIWj5Igt75Tt1KGaRtRZlq8qWSIUTrA+WSU3PcgwPF4P2PIX8IOPTjHAwRAIPDeyVIQcXBsXYCFF3cJwViRCZIggJ9HREVuGtGmXwKBVPx8sGLMR4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uL40QnGqWlu3WJqw5BwZxf88IdCrp3CsV4LWJ0ysFxaWxDENjSJJpbbliYF2?=
 =?us-ascii?Q?Crq1HMp5SJ9eWRqikyqA0A/9B1qBWvJQduxeGQ4Qj5b/I9GbcvjIE8revKvr?=
 =?us-ascii?Q?Ip/mQBJX4xvv6raGs1+LbGBxWArIEb/r5kzat1wQsv/H89blmgjA9uBGVty4?=
 =?us-ascii?Q?m/6Q6X40E1VNKEWC3TRhOI0tPv4EFBJ0RtlND/SpNvp7+u6T5ghFbvkKB+Mn?=
 =?us-ascii?Q?1/az4dMlfazYSMEcnFk4nqy8bQy+gZfmk+yRAnZSgxR5c9vtW19jus69BZDc?=
 =?us-ascii?Q?OJQmKZRonwa0vqffBVwzbozih2djnrhUW0rNqhXu1ghWN6l2B6WmdZ7AtJOB?=
 =?us-ascii?Q?08l5g8jFkTh9BDWkW7T5DZkm5ZkM9eHLSXOm9suUueQEapudyRAdIN8UkQbF?=
 =?us-ascii?Q?G0RjygVcI4YeBW8OljOzEBzGlZOsD+4pOcCeNFqLqvNHjtqJjucsvs/5UyCy?=
 =?us-ascii?Q?TJ9Bp4OI8LoVrFX0f/PPYVXXZQh3AsZRh+LFiLgDG/7ktK0akQZdkLIbRsNl?=
 =?us-ascii?Q?Hp0SeQ8KmoEyT56/DwJ90Jw7uGnt49l+K7WryaeQXuUUyZ9w5hHnoCDUD9Eo?=
 =?us-ascii?Q?yn4mfnq80jo7q+d7OQvSu1bwHn/TWuScIiOz/4nRx8sTf9vUSvWGGY5z2/tb?=
 =?us-ascii?Q?AuFsG9hf6p8zfE8jc/ekx2MmSPLlSQq4kT+MF5ZpqPdsOnrIaNxhsNZEEz96?=
 =?us-ascii?Q?1oltPAU3M05mg+94qI/Rn/jp47UvTVkGk4gUAx6DqHlH6xTwXHmyhBrcc2be?=
 =?us-ascii?Q?h32TjvxSzE1oslyVJqqeEqllK3xh53vRnuuBgBegPM/fS6wdudUcU1czjDly?=
 =?us-ascii?Q?baaeOYZHRpuBL+6I9XW8C9Ug4/fBN4W8EMKbjHlCjIP4Jy6ir/7zesXKdjTY?=
 =?us-ascii?Q?YOZELrBQKAn/NbIJtFMOSXLDbzycE3qmSSWg4D2zj5aonMHniQYGTKGNBNSz?=
 =?us-ascii?Q?/TXfQEvxTidOPknoZ5dZTBLOV9uzKSEAABATPjJr/YGH1eLmNxnul9cifjpg?=
 =?us-ascii?Q?m8BqAcgtUjGKInv+CuyFRjOAXb5FcRguQ2hzi7yktzDZ0nYvsYu5ay0SEWrJ?=
 =?us-ascii?Q?8SjKWMYBLcAQlXak9PbTXCRCkB1mXqM0W5bRnxVms592Q40fSzrVJOufpOgI?=
 =?us-ascii?Q?G7BQi8txb/c6TvjjSYCVp1Dn8xZackXPHDctQ/c/nvtRwxb6cmwQflQ2D9Xa?=
 =?us-ascii?Q?Ez9lfsKW53t4TxoZ9rqKe+qByrxNGDzl8NiYumAJHEI/ipZ+v++RnwjlxP0b?=
 =?us-ascii?Q?IfFhIH8L2MANs1pY8xA2qGweA3M3A2C7G2KVAADgF7XA4fB2EutPMSRCZpU8?=
 =?us-ascii?Q?huWOdZHqj96I92q28xxdYaaAAb6ZnTUye2CZlKvEzhGNvc8JitR2uEJ55RLB?=
 =?us-ascii?Q?DTTIlejIsCn+x+VkLqSMZZ+ghLiodAt12kKO4nf0wD12UzQssGC2mWdjqyeA?=
 =?us-ascii?Q?z85TkaEzq8vco+AR35HDCUIae7gKP9SZOZGAnOZqAeEoxmCiQErmaxAIVITy?=
 =?us-ascii?Q?p4phSsK+6cDgjB/fty3kZjqYTQonT1tqZLwDcZpZA9xXoh6N6Qk2G01Rpmf3?=
 =?us-ascii?Q?+maIVjEx0J01MYOh7Ng=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 17fa617d-1e0a-451f-6c49-08dc531dcc8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 14:04:23.0661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BRKUYE6luq8zWsamHjz94bLBmQSrtFOJc6glD3DaVJ8OSvN3cqCBvuylbqB+H7OtwzpDIB1Jp+YxV+9+cnwDCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8411

> Subject: Re: [PATCH v7 3/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
> protocol basic support
>=20
> On Tue, Apr 02, 2024 at 10:22:23AM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Add basic implementation of the SCMI v3.2 pincontrol protocol.
> >
>=20
> Hi,
>=20
>=20
> > Co-developed-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> > Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
>=20
> [snip]
>=20
>=20
> > +struct scmi_settings_get_ipriv {
> > +	u32 selector;
> > +	enum scmi_pinctrl_selector_type type;
> > +	bool get_all;
> > +	enum scmi_pinctrl_conf_type *config_types;
> > +	u32 *config_values;
> > +};
> > +
> > +static void
> > +iter_pinctrl_settings_get_prepare_message(void *message, u32 desc_inde=
x,
> > +					  const void *priv)
> > +{
> > +	struct scmi_msg_settings_get *msg =3D message;
> > +	const struct scmi_settings_get_ipriv *p =3D priv;
> > +	u32 attributes;
> > +
> > +	attributes =3D FIELD_PREP(SELECTOR_MASK, p->type);
> > +
> > +	if (p->get_all) {
> > +		attributes |=3D FIELD_PREP(CONFIG_FLAG_MASK, 1) |
> > +			FIELD_PREP(SKIP_CONFIGS_MASK, desc_index);
> > +	} else {
> > +		attributes |=3D FIELD_PREP(CONFIG_TYPE_MASK, p-
> >config_types[0]);
> > +	}
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
> > +	if (p->get_all) {
> > +		st->num_returned =3D le32_get_bits(r->num_configs,
> GENMASK(7, 0));
> > +		st->num_remaining =3D le32_get_bits(r->num_configs,
> GENMASK(31, 24));
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
> > +					   const void *response,
> > +					   struct scmi_iterator_state *st,
> > +					   void *priv)
> > +{
> > +	const struct scmi_resp_settings_get *r =3D response;
> > +	struct scmi_settings_get_ipriv *p =3D priv;
> > +	u32 type =3D le32_get_bits(r->configs[st->loop_idx * 2], GENMASK(7,
> 0));
> > +	u32 val =3D le32_to_cpu(r->configs[st->loop_idx * 2 + 1]);
> > +
> > +	if (p->get_all) {
> > +		p->config_types[st->desc_index + st->loop_idx] =3D type;
> > +	} else {
> > +		if (p->config_types[0] !=3D type)
> > +			return -EINVAL;
> > +	}
> > +
> > +	p->config_values[st->desc_index + st->loop_idx] =3D val;
> > +
> > +	return 0;
> > +}
> > +
> > +static int
> > +scmi_pinctrl_settings_get(const struct scmi_protocol_handle *ph, u32
> selector,
> > +			  enum scmi_pinctrl_selector_type type,
> > +			  enum scmi_pinctrl_conf_type config_type,
> > +			  u32 *config_value, bool get_all) {
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
> > +		.get_all =3D get_all,
> > +		.config_types =3D &config_type,
> > +		.config_values =3D config_value,
> > +	};
> > +
> > +	if (!config_value || type =3D=3D FUNCTION_TYPE)
> > +		return -EINVAL;
> > +
> > +	ret =3D scmi_pinctrl_validate_id(ph, selector, type);
> > +	if (ret)
> > +		return ret;
> > +
> > +	iter =3D ph->hops->iter_response_init(ph, &ops, SCMI_PIN_OEM_END,
> > +					    PINCTRL_SETTINGS_GET,
> > +					    sizeof(struct
> scmi_msg_settings_get),
> > +					    &ipriv);
> > +	if (IS_ERR(iter))
> > +		return PTR_ERR(iter);
> > +
> > +	return ph->hops->iter_response_run(iter);
> > +}
> > +
> > +static int scmi_pinctrl_settings_get_one(const struct scmi_protocol_ha=
ndle
> *ph,
> > +					 u32 selector,
> > +					 enum scmi_pinctrl_selector_type
> type,
> > +					 enum scmi_pinctrl_conf_type
> config_type,
> > +					 u32 *config_value)
> > +{
> > +	return scmi_pinctrl_settings_get(ph, selector, type, config_type,
> > +					 config_value, false);
> > +}
> > +
> > +static int scmi_pinctrl_settings_get_all(const struct scmi_protocol_ha=
ndle
> *ph,
> > +					 u32 selector,
> > +					 enum scmi_pinctrl_selector_type
> type,
> > +					 enum scmi_pinctrl_conf_type
> config_type,
> > +					 u32 *config_value)
> > +{
> > +	return scmi_pinctrl_settings_get(ph, selector, type, config_type,
> > +					 config_value, true);
> > +}
> > +
>=20
> If you generalize the scmi_pinctrl_settings_get() and reintroduce a
> .settings_get_all() ops (even though unused by pinctrl driver, I am fine =
with
> this..), you should take care to pass as an input parameter NOT only the =
array
> of config_values BUT also an array of config_types since you could get ba=
ck
> up to 256 OEM types: for this reason you will need also to pass to
> scmi_pinctrl_settings_get() an input param that specifies the sizes of th=
e
> 2 array input params (in order to avoid oveflows) AND use that same inout
> param also as an output param to report at the end how many OEM types
> were effectively found and returned....
>=20
> IOW, I did this on top of your V7 to make the settings_get_all work:
>=20
> ---8<---
> diff --git a/drivers/firmware/arm_scmi/pinctrl.c
> b/drivers/firmware/arm_scmi/pinctrl.c
> index b75af1dd75fa..f4937af66c4d 100644
> --- a/drivers/firmware/arm_scmi/pinctrl.c
> +++ b/drivers/firmware/arm_scmi/pinctrl.c
> @@ -317,6 +317,7 @@ struct scmi_settings_get_ipriv {
>  	u32 selector;
>  	enum scmi_pinctrl_selector_type type;
>  	bool get_all;
> +	unsigned int *nr_configs;
>  	enum scmi_pinctrl_conf_type *config_types;
>  	u32 *config_values;
>  };
> @@ -379,6 +380,7 @@ iter_pinctrl_settings_get_process_response(const
> struct scmi_protocol_handle *ph
>  	}
>=20
>  	p->config_values[st->desc_index + st->loop_idx] =3D val;
> +	++*p->nr_configs;
>=20
>  	return 0;
>  }
> @@ -386,11 +388,13 @@ iter_pinctrl_settings_get_process_response(const
> struct scmi_protocol_handle *ph  static int  scmi_pinctrl_settings_get(co=
nst
> struct scmi_protocol_handle *ph, u32 selector,
>  			  enum scmi_pinctrl_selector_type type,
> -			  enum scmi_pinctrl_conf_type config_type,
> -			  u32 *config_value, bool get_all)
> +			  unsigned int *nr_configs,
> +			  enum scmi_pinctrl_conf_type *config_types,
> +			  u32 *config_values)
>  {
>  	int ret;
>  	void *iter;
> +	unsigned int max_configs =3D *nr_configs;
>  	struct scmi_iterator_ops ops =3D {
>  		.prepare_message =3D
> iter_pinctrl_settings_get_prepare_message,
>  		.update_state =3D iter_pinctrl_settings_get_update_state,
> @@ -399,19 +403,22 @@ scmi_pinctrl_settings_get(const struct
> scmi_protocol_handle *ph, u32 selector,
>  	struct scmi_settings_get_ipriv ipriv =3D {
>  		.selector =3D selector,
>  		.type =3D type,
> -		.get_all =3D get_all,
> -		.config_types =3D &config_type,
> -		.config_values =3D config_value,
> +		.get_all =3D (max_configs > 1),
> +		.nr_configs =3D nr_configs,
> +		.config_types =3D config_types,
> +		.config_values =3D config_values,
>  	};
>=20
> -	if (!config_value || type =3D=3D FUNCTION_TYPE)
> +	if (!config_types || !config_values || type =3D=3D FUNCTION_TYPE)
>  		return -EINVAL;
>=20
>  	ret =3D scmi_pinctrl_validate_id(ph, selector, type);
>  	if (ret)
>  		return ret;
>=20
> -	iter =3D ph->hops->iter_response_init(ph, &ops, SCMI_PIN_OEM_END,
> +	/* Prepare to count returned configs */
> +	*nr_configs =3D 0;
> +	iter =3D ph->hops->iter_response_init(ph, &ops, max_configs,
>  					    PINCTRL_SETTINGS_GET,
>  					    sizeof(struct
> scmi_msg_settings_get),
>  					    &ipriv);
> @@ -427,18 +434,24 @@ static int scmi_pinctrl_settings_get_one(const
> struct scmi_protocol_handle *ph,
>  					 enum scmi_pinctrl_conf_type
> config_type,
>  					 u32 *config_value)
>  {
> -	return scmi_pinctrl_settings_get(ph, selector, type, config_type,
> -					 config_value, false);
> +	unsigned int nr_configs =3D 1;
> +
> +	return scmi_pinctrl_settings_get(ph, selector, type, &nr_configs,
> +					 &config_type, config_value);
>  }
>=20
>  static int scmi_pinctrl_settings_get_all(const struct scmi_protocol_hand=
le
> *ph,
>  					 u32 selector,
>  					 enum scmi_pinctrl_selector_type
> type,
> -					 enum scmi_pinctrl_conf_type
> config_type,
> -					 u32 *config_value)
> +					 unsigned int *nr_configs,
> +					 enum scmi_pinctrl_conf_type
> *config_types,
> +					 u32 *config_values)
>  {
> -	return scmi_pinctrl_settings_get(ph, selector, type, config_type,
> -					 config_value, true);
> +	if (!nr_configs || *nr_configs =3D=3D 0)
> +		return -EINVAL;
> +
> +	return scmi_pinctrl_settings_get(ph, selector, type, nr_configs,
> +					 config_types, config_values);
>  }
>=20
>  static int
> diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.=
h
> index abaf6122ea37..7915792efd81 100644
> --- a/include/linux/scmi_protocol.h
> +++ b/include/linux/scmi_protocol.h
> @@ -882,8 +882,9 @@ struct scmi_pinctrl_proto_ops {
>  	int (*settings_get_all)(const struct scmi_protocol_handle *ph,
>  				u32 selector,
>  				enum scmi_pinctrl_selector_type type,
> -				enum scmi_pinctrl_conf_type config_type,
> -				u32 *config_value);
> +				unsigned int *nr_configs,
> +				enum scmi_pinctrl_conf_type *config_types,
> +				u32 *config_values);
>  	int (*settings_conf)(const struct scmi_protocol_handle *ph,
>  			     u32 selector, enum scmi_pinctrl_selector_type
> type,
>  			     unsigned int nr_configs,
> --->8-----
>=20
> Please check if this addition sounds good to you and integrate into v8
> eventually...

Thanks for helping on this, I will included your changes, and your
Co-developed-by tag if you not mind.

Thanks,
Peng.

>=20
> Thanks,
> Cristian


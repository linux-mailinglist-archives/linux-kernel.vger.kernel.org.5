Return-Path: <linux-kernel+bounces-127822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 552C089516B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B1BD28754A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D064C6217D;
	Tue,  2 Apr 2024 11:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GiU2g7fZ"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2092.outbound.protection.outlook.com [40.107.105.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD93664C6;
	Tue,  2 Apr 2024 11:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055992; cv=fail; b=riW6BWVsfK7eaBDFvYa0fLrZqbZ0kcZc42OVnKXHITsS5YwYEIS8hHkek7aW9RnFE6dmmpZbofvJ7qU+2EVeKDjChMKO7xV5ZTLTTFmV4fUrFlt29qFW5++UmzqYpqVeIy9J+4AZxNEzvF+qTptOdUZMIlKJDb2zdn1Kk59ouDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055992; c=relaxed/simple;
	bh=INXyNDpuNLaHfPEttijol1ejzinZ8U37j35EzvnQu0o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XfVKxG4flwgqSXcWZZLcVWr/atpBrAhElUNeVzYpLPh50PHant3hzMwOr1deFMZkcVWRdfcfza8VLnW6OUDkwFugXwzs3v6rZMat9NDjJZJYcsI1tvQ9JxqrIGsGzkW47p6mMHb8NeX67+vcSovXbk9unFr57UlFf3eUaNg4Eaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=GiU2g7fZ; arc=fail smtp.client-ip=40.107.105.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqleq/Q94Dnsmoz902XPGkWv2MwA82d3/ZaLlgmOdtiRRH+XalRS9Rn492bAaRr1NhJNb77MT3tzLpCgUgKuTPV4Z5qWbx4bF7q7tqCrNzuwvQJyoH9sarixReKeOgYYjWYVdiOEiXIaBl80ta92JX4tKbZCS3GbGnpezqqFUS5BPGuJObxZCqqYKVaVxL6ZboEEXbOs9NJX80dRkVdImPceM8vTY8MaGcy+ZGxROCK4mgB23IBA1VqVmjj8cRoiAdNnMD8uLDCitaMhBXX7VP7OWDBf4bvWUph19DfifiWcJVifIHjxuruQckBU6TgOpdTQYP+eEMdENvKW7Esa1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DlUfwGer0rQSQhN81yEWBvk8YIxxF51fWqI0SkFcghU=;
 b=Pj3+0W3sfRbuYugutzQ/sMuWc5p1riCkPOhe8ILRt+dUnvTQGaD0rWPmHlstDtqXaq6qhyXnQHJSzs9VjL0THIswQ4McB9sjyrzK8Th16QlOhCbiPHag2E+7ZEhCb90oiFMOXKnVaSGVqIZMg1tm+IfUU+qmt+ShNNZGDD9eo7CxjMvRcp/sIRNXAqh8ks1gi9pI4i6vJdtTMAX5hRPWUMJvI8IEq8ERx0Ehr4XbRIyoX8atmuW8iiD6EWQeYPPkrZ75zkm9sVFixUFERpHc5fZKoWgdy8GJTLaWG0s8qjLN5bjiUr83jzpbMG8JFGYYg6vFLhAojNhScJeTi5Wd7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DlUfwGer0rQSQhN81yEWBvk8YIxxF51fWqI0SkFcghU=;
 b=GiU2g7fZaewe3jRrBcfeBnJ8n5q5LnCmgkrbV4i6lsGzptOTT3OIPB2wgF/kvWAzldL8IHOAQuNbpc47iqQtwkWt0TM+GcqxtmkzcB6Va+5s+xJo0xytlJdUDxrpGxAas4kzvxU91/9kuXX16ER018dUkAQnDk1J1Zu5sWUuURY=
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by PAXPR04MB9253.eurprd04.prod.outlook.com (2603:10a6:102:2bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Tue, 2 Apr
 2024 11:06:26 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f%5]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 11:06:26 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: Shawn Guo <shawnguo2@yeah.net>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>,
	"peter.chen@kernel.org" <peter.chen@kernel.org>, Jun Li <jun.li@nxp.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v10 03/11] arm64: dts: imx8ulp-evk: enable usb
 nodes and add ptn5150 nodes
Thread-Topic: [EXT] Re: [PATCH v10 03/11] arm64: dts: imx8ulp-evk: enable usb
 nodes and add ptn5150 nodes
Thread-Index: AQHae2fPbeVGy74CDUG/al6WTudLvLFUupkAgAAp8YA=
Date: Tue, 2 Apr 2024 11:06:26 +0000
Message-ID:
 <DU2PR04MB8822308A80FDCBB9547DB9208C3E2@DU2PR04MB8822.eurprd04.prod.outlook.com>
References: <20240321081439.541799-1-xu.yang_2@nxp.com>
 <20240321081439.541799-3-xu.yang_2@nxp.com> <ZgvDTPiBM65l3F+U@dragon>
In-Reply-To: <ZgvDTPiBM65l3F+U@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8822:EE_|PAXPR04MB9253:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 eaaxNxt/T9O+18MQSjSpHcXuxVQJqejFIXlMmqEOit0jSe4G8FuwMtoIJ1ASCfyO78KObCvKoGGpP0Ni6t44GqDUTY5z7UWwMShW6j6h82DrEUsuqHmJhERFd+kJSoaDPpgSI9fgGztN1IMLqwc+M925zcFn0HAbLqQtlOZOgoCwFDUGpHgoeBOl+5uP22aLULd4kOh74P+bRV4N0h0XFEZ9HvYvSHXuSyxPL6yxvJjVf3i+G587dkKb5Kt44iAgBPbny+b3+S08+flRU+ZksaJS9tJTHKKGbF/82JqxEVet3zfDIUdHbNImQsltNTx5oTPKnOBOuF85fZbUh0nqISX6lRvavAuTkGMQ2yC5V4LyAYgknG3kMm1/s7umOTPR9S4iyi6zN5gyQwteBy7jrUoLDT4GuOPwfkVU8tos5qYR8CIjQljY37vLBA6Wl4tc7hLgcmQQZ7cclDwssNFsXj0mhzuQGMi0nngmI1MUl/yKw3sz3YyZlvR8Fql8tlqPZnZq62n6k8x4zI8kZnCHZUzhSz4kbE5JDL7CKTVNkARp+umxmAyBaC+IAlktf6eaIUc8GnJHPneq419o4Ai15r4yPC3HPdJHBPuKHtnvSTyi076q9gwjTa0ok+0veguN8OFceHz4i2PjBteVJ7D3iqglNOrg4TVPyMQmmZ06zOA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?krS/Ipl6YNZhv9gXncoTtjvK8/haNN4wFYM5EuxaQWI7lbDl+ppHjZL/FDTW?=
 =?us-ascii?Q?5eN8pwptvBjYGng2DcvR/zd+navFuFU9XB7+TdWJlaR1X3ZAL+zcptb//IRa?=
 =?us-ascii?Q?s54IRpIC9c8ABGa9ZAvSBKw8eMCv5PKV4JzcWHLnKqvIEkaQc7OhYFMQRQsf?=
 =?us-ascii?Q?Yi+BOcONdNVwv2u+df/Gb0iqNJYhM4SSjhXkpZJPkKtR5jp3JLE1weQXep80?=
 =?us-ascii?Q?vO5BCLHdRamJyq4ZqN6U0fpGxsllBnh5C6G3aITfeZ83oPXaIPoSYIpUNPFT?=
 =?us-ascii?Q?Pyy7POTSu9oy1LXYGtyIgSz6TuWmm99srzpqRbv0xzJn4QHz6OhcATnzYoSF?=
 =?us-ascii?Q?dpfjfpJotQZaxK/SflHC46TxVRRwB1XL9SOzzMogXeYrVs2ThJG7dZh+WZcq?=
 =?us-ascii?Q?etvM8bm0TnNVml/7IoFc2tKW6GKD7xkLN5o7nvJECbeIphOYcW++OW7gg2uq?=
 =?us-ascii?Q?mV/E6rQYl+FvnTGbr97/HK3hzDRytderWk9LUGHQe9Qob+89U82ePpJx0jKR?=
 =?us-ascii?Q?oU1q0r+DCv18z8j2Ggh9C3wTYkQJlngL2VstkEk3AgOctAUiAyGqK7YgIoJ4?=
 =?us-ascii?Q?Nj1CSMHwezWb2w+xWBCGiowxaLySwZdoFygzZjF0JqPAetLsRyrY+xtIG8Pf?=
 =?us-ascii?Q?/vvLcuPqfqCW4ew49z2Saeuso3f9emfixKD/NhZLHUgKhsXgo6KLsl8gY0b8?=
 =?us-ascii?Q?xDHsXC9bIjwEqezd3x9yxtlHREbO0NSUJB3CQZJDYWR7VpGXr7ONfd5JwHpH?=
 =?us-ascii?Q?mxM8UE0Lr8TRZvuQJClnpiFDWKPs9r5AreQw1PgWfmb8PRh+4n6vO4SWt729?=
 =?us-ascii?Q?ykWDJCkbVMbUZKFB9MvTcL1jEXgOhMmUCzLBMGpkrwZk9VgygqLuUK6fL/WN?=
 =?us-ascii?Q?rVaTfoDYGSta/36I4RstWrijX0z0tLk0tdFy5atEIn0hOdCcP6sNMuRBEGZN?=
 =?us-ascii?Q?GSThJ758RH04Tls8S1meW2hkUeHryR1IHTroBESELfPgYsMlTUmEX+RZPhJZ?=
 =?us-ascii?Q?9U8ikxwtkrKYC9bL3XeQscPOjDSEemEgwgZgfwyakScdQwr/b9FQVJmv5ovJ?=
 =?us-ascii?Q?JyoylP2SHYbOtAUPsrXuhZ7+1/CFYAolAaAa5IUcwVzx4pD2lGJ3od47bjZH?=
 =?us-ascii?Q?IVeUKfkHyJgORBCx/6yjGdUOqG59+M4wrOkJjrXbTwcnCH2CzYuAG3V9QW3/?=
 =?us-ascii?Q?GhlqUwjK0wE3lAX2/jqWQnW2ilaaTjEDVQPqCz6mOqT3G8AXXqMchHANRi+w?=
 =?us-ascii?Q?MsVdnRZQdObKDXeNlqlg3t2Q7tEeOV4lfJwHFAGW0lob9wq879Zy5x4/hc+Q?=
 =?us-ascii?Q?gzzNpJW4tdoo3g/ruecjGKDpBxglIQWM0Sb/zHtVcYukdS6ZueZVApOiaiQW?=
 =?us-ascii?Q?xFqjlCWVDIVdTGFL9l6JhtY7KuWy8oRZdQXRELYZJe8xmH1uhXvPlCpIOdfi?=
 =?us-ascii?Q?OOOPw4YYovSNqMJ7KAozZIIMwkNzMBhNysQCFAZUWwkpKck2CZUlI03Bs+wp?=
 =?us-ascii?Q?kbUdIAii/YMTNNMF+vwpLnivQzcPg3OFhGLS884qqNNJh7QpevVk+0AxsipA?=
 =?us-ascii?Q?1mrSQzcfYV+xTs95cHk=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c9e8080-411b-4d81-7462-08dc5304f0a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 11:06:26.1790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6ZRhAYzqqtpU297QQYg/VAnOTxW/QruQ6agFGHKkZEIAXBj74vl1SCffQIbJKHP+bCB7zzdcvxk1iE5Ze+ABag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9253


>=20
> On Thu, Mar 21, 2024 at 04:14:31PM +0800, Xu Yang wrote:
> > Enable 2 USB nodes and add 2 PTN5150 nodes on i.MX8ULP evk board.
> >
> > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> >
> > ---
> > Changes in v2:
> >  - fix format as suggusted by Fabio
> >  - add PTN5150 nodes
> > Changes in v3:
> >  - no changes
> > Changes in v4:
> >  - no changes
> > Changes in v5:
> >  - no changes
> > Changes in v6:
> >  - no changes
> > Changes in v7:
> >  - no changes
> > Changes in v8:
> >  - no changes
> > Changes in v9:
> >  - no changes
> > Changes in v10:
> >  - no changes
> > ---
> >  arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 84 +++++++++++++++++++
> >  1 file changed, 84 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts b/arch/arm64=
/boot/dts/freescale/imx8ulp-evk.dts
> > index 69dd8e31027c..bf418af31039 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
> > @@ -133,6 +133,64 @@ pcal6408: gpio@21 {
> >               gpio-controller;
> >               #gpio-cells =3D <2>;
> >       };
> > +
> > +     ptn5150_1: typec@1d {
>=20
> Could you sort devices in unit-address?

Okay.

>=20
> > +             compatible =3D "nxp,ptn5150";
> > +             reg =3D <0x1d>;
> > +             int-gpios =3D <&gpiof 3 IRQ_TYPE_EDGE_FALLING>;
> > +             pinctrl-names =3D "default";
> > +             pinctrl-0 =3D <&pinctrl_typec1>;
> > +             status =3D "disabled";
> > +     };
> > +
> > +     ptn5150_2: typec@3d {
> > +             compatible =3D "nxp,ptn5150";
> > +             reg =3D <0x3d>;
> > +             int-gpios =3D <&gpiof 5 IRQ_TYPE_EDGE_FALLING>;
> > +                     pinctrl-names =3D "default";
>=20
> Broken indent?

Yes, will fix it.

Thanks,
Xu Yang

>=20
> Shawn
>=20
> > +             pinctrl-0 =3D <&pinctrl_typec2>;
> > +             status =3D "disabled";
> > +     };
> > +};
> > +
> > +&usbotg1 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&pinctrl_usb1>;
> > +     dr_mode =3D "otg";
> > +     hnp-disable;
> > +     srp-disable;
> > +     adp-disable;
> > +     over-current-active-low;
> > +     status =3D "okay";
> > +};
> > +
> > +&usbphy1 {
> > +     fsl,tx-d-cal =3D <110>;
> > +     status =3D "okay";
> > +};
> > +
> > +&usbmisc1 {
> > +     status =3D "okay";
> > +};
> > +
> > +&usbotg2 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&pinctrl_usb2>;
> > +     dr_mode =3D "otg";
> > +     hnp-disable;
> > +     srp-disable;
> > +     adp-disable;
> > +     over-current-active-low;
> > +     status =3D "okay";
> > +};
> > +
> > +&usbphy2 {
> > +     fsl,tx-d-cal =3D <110>;
> > +     status =3D "okay";
> > +};
> > +
> > +&usbmisc2 {
> > +     status =3D "okay";
> >  };
> >
> >  &usdhc0 {
> > @@ -224,6 +282,32 @@ MX8ULP_PAD_PTE13__LPI2C7_SDA     0x20
> >               >;
> >       };
> >
> > +     pinctrl_typec1: typec1grp {
> > +             fsl,pins =3D <
> > +                     MX8ULP_PAD_PTF3__PTF3           0x3
> > +             >;
> > +     };
> > +
> > +     pinctrl_typec2: typec2grp {
> > +             fsl,pins =3D <
> > +                     MX8ULP_PAD_PTF5__PTF5           0x3
> > +             >;
> > +     };
> > +
> > +     pinctrl_usb1: usb1grp {
> > +             fsl,pins =3D <
> > +                     MX8ULP_PAD_PTF2__USB0_ID        0x10003
> > +                     MX8ULP_PAD_PTF4__USB0_OC        0x10003
> > +             >;
> > +     };
> > +
> > +     pinctrl_usb2: usb2grp {
> > +             fsl,pins =3D <
> > +                     MX8ULP_PAD_PTD23__USB1_ID       0x10003
> > +                     MX8ULP_PAD_PTF6__USB1_OC        0x10003
> > +             >;
> > +     };
> > +
> >       pinctrl_usdhc0: usdhc0grp {
> >               fsl,pins =3D <
> >                       MX8ULP_PAD_PTD1__SDHC0_CMD      0x3
> > --
> > 2.34.1
> >



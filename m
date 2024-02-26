Return-Path: <linux-kernel+bounces-80470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2D88668C5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FB9CB2138B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797FB15AC4;
	Mon, 26 Feb 2024 03:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dXPmiXFf"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2065.outbound.protection.outlook.com [40.107.6.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E6B101C4;
	Mon, 26 Feb 2024 03:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708918222; cv=fail; b=boBV8Hi0umH9kFpt7b9sC7l7Ere2yNBxd271ihlPKXtrL642wvAyacDQZTTtuDUzZ50UD6Tk+rNrm9/L7UwnepUEm0Lqq5EGdcf+03qiUBQzXn7Sp3Naer1nqX5buhWJAHyKCYnVd45HmJ5nbwRxQFZ/KHKWOxEG5InhokcmTvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708918222; c=relaxed/simple;
	bh=7OF+o+vMsiGFxbixwaDDl0Lu9LN455Ek6NCkSsx97mI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r8HA4OWh3sGOWilcATMkn3ZfVrLfpHdazqgMBJgKindYz6d5b43CT86YKFfLlnIzeDOnM2pBEqE80tq4jRN9wHjJ5YQecGzPzimgJ7/wmXjEZ/JkyG0GcR6YFUJ/9DfS1n+U1EKOIveqz4qzP7dhP213GWtHmbqMMZ694etlTz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=dXPmiXFf; arc=fail smtp.client-ip=40.107.6.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXLGi8357JmF/nxvzzzkXgCLyuaDGbyYLUZXfyI9ncCiOYjSg9u4WkCmoFr4YYjl9PrVZu46JR5YBRLmZ0R+3eyX3o+85JBlSJITfas3px8WDhgXKjr134/6EJLTMHDg8BYw42x9q/w2zSlcpPkt1wztSTLy840zO+ZVGuvS0SrMA/pXNhPpsKuhWi5KPcKMvMaP/AcAEf9imcnD2Gl6wxZ+4GvGvQrDvR7O1JkZtwGGz6HB00eY+Mvw7zKLR1QK32pkhqI+P72/hBD/XypQjbwfWFwQ0ie4KH2ioX1cFa8UYQTAKv6VXfqkRIq8jFd8NyMa7jDkoAp8IyZgzzCKpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRhX05xHvBkM6MBpyZMT8+ECS754BEN/aW499H5+DRI=;
 b=Tez+cpa+knO8PZ+J96oceb8WbELe+s4uU1CBtGbgrNQyjlKSeFlKh0E/x9t0f/+4O2xZqEV+DhPcaNqM1DcwmgFYrKczJcvFvc2POlFVJiEeaY/yse5KBvNWPsbjYB2vIeLnWQG5qJSiPn2sym188AVAZlmI6miu72NPPx7iCWFcSmJL3IaVocfz2KvgiPNYLMubqznYaOJYNpGWzm0PbXxCeZ885QFnxNU1iG3JjjT950HcXAX0BWkfmr16uR8yGOT8u2Dq19iBHBqhs/4uIjnpLcM+s+20ZcMNAKbpe+SAMdvbghh4r94+ynX6G4Xnf4ReBgVNXRA+NYeHZ2BCNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRhX05xHvBkM6MBpyZMT8+ECS754BEN/aW499H5+DRI=;
 b=dXPmiXFfRlIPQWm0gWFSiUvQgkuk1AIlssHRfgqUOyvyddED0DOsv3NsuGa/iWHdS2XTMGrSiXQzg1VyZFgDxFxIQVIBmo0jUhGHe6DRGLuGF1lOI/wNbHb7YR9ViRMElu0GGnNbstmSzP5gslznLjz4jI4qr/5j3O2YDQLomWc=
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DBBPR04MB7562.eurprd04.prod.outlook.com (2603:10a6:10:1f6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.33; Mon, 26 Feb
 2024 03:30:17 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 03:30:16 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Rob Herring
	<robh@kernel.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>,
	"peter.chen@kernel.org" <peter.chen@kernel.org>, Jun Li <jun.li@nxp.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v6 4/9] dt-bindings: usb: add NXP ChipIdea USB2
 Controller schema
Thread-Topic: [EXT] Re: [PATCH v6 4/9] dt-bindings: usb: add NXP ChipIdea USB2
 Controller schema
Thread-Index: AQHaZJJxwpJRCpYUm0K+YwxPJkmdNbEX+NsAgAAEwLCAAWvdgIACkzrA
Date: Mon, 26 Feb 2024 03:30:16 +0000
Message-ID:
 <DU2PR04MB8822BF43FA0CF416EB72F19A8C5A2@DU2PR04MB8822.eurprd04.prod.outlook.com>
References: <20240221145846.1611627-1-xu.yang_2@nxp.com>
 <20240221145846.1611627-4-xu.yang_2@nxp.com>
 <20240223140256.GA1768266-robh@kernel.org>
 <DU2PR04MB882234D1A9D5718D8355928B8C552@DU2PR04MB8822.eurprd04.prod.outlook.com>
 <6c5c0233-dab8-4bd1-9f08-0b609d01defd@linaro.org>
In-Reply-To: <6c5c0233-dab8-4bd1-9f08-0b609d01defd@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8822:EE_|DBBPR04MB7562:EE_
x-ms-office365-filtering-correlation-id: 0398ddff-7f19-4a23-239f-08dc367b4066
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 e/rfulu3sH6NfcWqN1H6OiggdCarj6pYEyCboRRuqteB4dp3fvQgNaVcCvSO99iZhHfcrlcjv8XT4/vhi41ho35DeibawL1lAiIcL9QGRhZke+VSkXJZO6z68R+1QjsIkxnUbDNKqgTpcWI/FNVs1gcD3EUW/oCEoU5Kkam+3Plho8cs6+PozONmRDFFXJ5NxnJjmgx1SZMBWQxYDH64omWRaNR+ODKeDRr8TtPPIW74coSe3l36JbKdtcpBvmbuHXqmx5BuEPhr83PMHRNQVnboS9hTrd6QTzzPfs8/13jV0OST57fzB9yDrrgQZGntB/BJIIDi1fi2UmwY12vsyGLFzTmLkUT53j5EgFM+b8j0KgU5Lmb4K/JgUATm6rI4XWwwVJos+YqdpMLh3StvwI2nq1T3hV5QwJbUkdNmkHD2pjjDwm8w7GE4vmJ/HQ0msc6oZ9j3ZcmOGWixTwCzZfpTWkN85HTQmXIC39FpHCrdwJb7LnfGkDryZjgwJcAq+lhEZWQtSTXoVytFHeZVUowz9xwPMfo67v/wnM1pMaHxzet6YOrBU8xEzqwU5BppKfefmcB4yFTTTheIiSYdSAPjZHhHljXHhBgGzw+cYhvpu1zM64p0cksShG5eRmzZBmMiN732ViVmhnqO7ZgGTJMHnX41PxxivOplDMYumPCwaLA65nAbUqpW89EkLRTkcfLb8wOxN/9eXVdQMc5NLDJ2174/+45SkhZbaGPnqyU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?32OWii7duQLMigDwrGO8ixY5OtAXJpSw1BGernbEKBBvT7Q09aNebrY7kO4J?=
 =?us-ascii?Q?O0HPVRIbqpnUjEKTdr81dNXOrv+m76BG9gp2YFe4slaqVk7K3aVTaaZLzxpH?=
 =?us-ascii?Q?b5XYeEoHFcaXm3tcPx8uTcp3sXQDF3DTI4Rr0brVxAghqrS66eKSDVEKuTSC?=
 =?us-ascii?Q?1Ol4VbwNjd2nZ/kTteDoujaJBhe3SQ3/O6k6qPv7aewO4wbvUPJIeqarjReo?=
 =?us-ascii?Q?fLZtHlEbyX3/DJNRi6A79+ycL4ljga+DDQoP5r0WlfONCknq/8NKkh2iUI2z?=
 =?us-ascii?Q?ILILnu08k2lKSt2SKgQxEAp9+n0Coi91ljc1xYAla1jmz6fXBNC+hNJjFA/Z?=
 =?us-ascii?Q?6BFvx7+8dS7TAone1dZuKEaNNwULUEtxN1xtK/KZbdf5/3yTTReQVV+F3tHO?=
 =?us-ascii?Q?iaEJz5nZGL/o81zfMdszSefYDhbsiippYQJLtX+5jUkvnI41Bgfvq4Kds9LV?=
 =?us-ascii?Q?5RkZ/n+BM8fKdonadoLPekI7gAiyepCdrlNvlj1huJ56ypZhcmmZmk6hCglL?=
 =?us-ascii?Q?QEgeTI/PuMSUaQCToJhqS0fBSlNyh4qRWbpNsubJpOX/N6JyZRTfENXwgrGf?=
 =?us-ascii?Q?4Eibzncu1DPyff4cChr+mYrVwwWI1V6JOacWwmwE441oFrRS27tLr8yzMYhB?=
 =?us-ascii?Q?wKFUD4gXHmmcDneDTSsQc5+UcgncYe8SDraRC7P4Oxs05oMbG9PljMlfBaLK?=
 =?us-ascii?Q?0vWIuv0rHjpENi3lq2iSy/sBNVu5ZxWfbJexP+AvU46EOsfqMv5H9V5GlICl?=
 =?us-ascii?Q?wbODkLHr3bnj+7My2TlU4UQEqG0ZNIU4WM3b13Rs7olDkASXpIsHjxlXKVu4?=
 =?us-ascii?Q?bJVwePcT+IBOrB8GsfsLh6EVGmLXVAjSo14VTVuWi8t/8O+gY7Njp6q3gfuY?=
 =?us-ascii?Q?EifwjhRNRNMcgD3lmEGoHPRy98SmUOhHnmt/4yJnp28c3D7BfQIPQhOmdDFh?=
 =?us-ascii?Q?3D+jteWSCphnS0/OXYZt+PMBVbIHDPombyMejK3z8/dStDFdq+mwZnrH5iF5?=
 =?us-ascii?Q?avoUH9cCAjn1jRn0iiagwKDgCMNOaljephjhKt6L3JKT04RXhcIaHCFPUZo1?=
 =?us-ascii?Q?rRfAcrB96KAOy0zVhrUXoPa8GUFjNtcBqsCHb+RhJpBMYbMZXfiYVI+4DQ4N?=
 =?us-ascii?Q?DJZEnTGvIck4X59cBMcc5ueqiC94xuTR1e/tnavTRjy83N3qgW9GSs8svU+h?=
 =?us-ascii?Q?nzq70gNq7YufSetVMeQB0bHeRYu+twuDT2E+sww7pESqkSnNB6sXj6MSNC88?=
 =?us-ascii?Q?voRpTho6XipB99lBvLPaKRbkaIl6e062jcRFFIcuJCPnOr9fmege6owm0TlE?=
 =?us-ascii?Q?S6G5gyIKuK1sr0KaTQ8T76Y1tPPPErxY8sJYLa4SoxM9k4aZcIKTBYlXoQfy?=
 =?us-ascii?Q?wxCMujI1SRUSdKQ9soH4EiH06AwIQoL9zeLb0t/UH42ZsCBP6QdyTa7XAABC?=
 =?us-ascii?Q?AB49ulqlsiBogOI3BuzoQYs3ljIotAlhSZ1SrpVjs998+WHdlo5nWSGUZYq3?=
 =?us-ascii?Q?IVC6DlNMvbGNUvmsffdFkH6L3Gn3d21D2HShEg9sPI+PuoAEz8OZopbsapqR?=
 =?us-ascii?Q?zhs6qf9//NmaVEcop1g=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0398ddff-7f19-4a23-239f-08dc367b4066
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2024 03:30:16.8575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dyxv7P3DZviGqxz7RwUEMLDpgzbuwV2rgvlqk0imhGVBV9Xr2HMQJcBwWpAQFtqak75Bt2Hnuw4RXoZVToroHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7562


>=20
> On 23/02/2024 15:56, Xu Yang wrote:
> > Hi Rob,
> >
> >>
> >> On Wed, Feb 21, 2024 at 10:58:41PM +0800, Xu Yang wrote:
> >>> As more and more NXP i.MX chips come out, it becomes harder to mainta=
in
> >>> ci-hdrc-usb2.yaml if more stuffs like property restrictions are added=
 to
> >>> this file. This will separate i.MX parts out of ci-hdrc-usb2.yaml and=
 add
> >>> a new schema for NXP ChipIdea USB2 Controller.
> >>>
> >>> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> >>>
> >>> ---
> >>> Changes in v6:
> >>>  - new patch
> >>> ---
> >>>  .../bindings/usb/ci-hdrc-usb2-imx.yaml        | 75 +++++++++++++++++=
++
> >>>  1 file changed, 75 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/usb/ci-hdrc-usb=
2-imx.yaml
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.y=
aml
> b/Documentation/devicetree/bindings/usb/ci-
> >> hdrc-usb2-imx.yaml
> >>> new file mode 100644
> >>> index 000000000000..2ec62f564bf5
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml
> >>> @@ -0,0 +1,75 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>> +%YAML 1.2

[...]

>=20
> > If I only create imx specific yaml file and remove all compatilbles fro=
m common
>=20
> Why would you remove ALL of others? What is the point of this.

I originally thought ci-hdrc-usb2.yaml should be removed and only
ci-hdrc-usb2-comm.yaml is kept. So I'm not sure where other compatibles
should go. I looked though your Qualcomm PCI dt-bindings series and now
I know how to do.

Thanks,
Xu Yang



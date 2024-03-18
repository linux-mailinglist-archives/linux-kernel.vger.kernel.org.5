Return-Path: <linux-kernel+bounces-105689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C0287E2A9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 04:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E1EBB215A0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 03:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E11208A4;
	Mon, 18 Mar 2024 03:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bImWTj85"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2043.outbound.protection.outlook.com [40.107.247.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37321E866;
	Mon, 18 Mar 2024 03:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710733295; cv=fail; b=V757ahXIzmPF0bM6l7XV1BVJCzSNIfn6HQ3r5LIZ+4n/ZtAknAGSpuNvGYVPcepGVRYISSpqfFgEnQGctnDlEoviXjxMwTKazrO2FFuLeJ9FC+AFi+6ydJ8sKtWeA01CbPiqNEd5PnXR4Zdg2U5OafS49UyNTWgc2Ux2roxuOU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710733295; c=relaxed/simple;
	bh=y/AF53/2tcJJNQNlDtKdxiKXj5qlc9WPBa1ebuW7mS0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D++zQ6kZxy/1ke/QtL1IoH0v816FOOAmY93m2gZOwc6xPohv26a29zl7tTw7tr8uLH+Mw9BrzWLhLs4LP1IQ+V9jSLGqpTavX7EpMco92VN5E6jsnF8IDSaUFuEfNssFmpdHEWVYm7mWHoToMO2VJCxCt1i/mSGB+oGfhyW+8r8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=bImWTj85; arc=fail smtp.client-ip=40.107.247.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNwBmBd+1j/UVoJ3OSlN0a17MVKgCfDLhFf96WfRAGunD+6LU+FKZQZq/fbi6ivpcd/PXUU3yuu3bm6QEbLbwzFMSIxYeat6iBHHqzy0ij7vyM8Hd/28FHz1lIMIX+uWIlWb9o0uVyvkM/ULiVTNhI/e7wqVrzvtAETGLrEVO4i09e/gjeBc/WnNEXJjwlOd58RVaRbT0F0CSjFP+hVHVHh5qYu+uckQgoHZoVNa7wv5J8V73YgrYHchU1eGphULIfJerdiRDx5dJ3s1sMHVqzhGK8is+SWXjWjKz9T6STL2fBaYSOrBKi9uxOhdIATBPm7f5Weuu8z2B01f3tckpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kwZ42fMHEro8l8wnIEHFqYe0BZz7Jo3Af8i8j7Hmt1w=;
 b=UuTDeCOfUIIDSDrKu2qYSxGK1sFu5kylwNal6vJYvnj3Wb5d6HcZB3m6iZk8VlzWiX/8ncCzqi7ptEgoGOktovvtthXXnB9t/ImKKHxKganNSg6dfuN6W8qGYIhypwyj82EkKQdFKRxKObQjVO/4UR8a+kwyQ10Jzi06+7oVeverTbnHz7qtj7V+K7GZB7gwNWT1Z8V4/fAg4l5HK7XV9ekay+6ARCAdqmSLcR7OzGAQxOcsWF8YYaBVgxDNZcWMs65SkfLFYb70RSTSxcskmdSgPiYC/vWaK0oLI/a8AElvDWaNq/7wayHDOvkxwZS/8P8HJkSQpMZTWn9y6ONN0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwZ42fMHEro8l8wnIEHFqYe0BZz7Jo3Af8i8j7Hmt1w=;
 b=bImWTj85kIWi04BiID9mQxcMpJc/wmPAgkfNxM6h42sdIVfLbgBl/NUQPCUXur1jdRxS7r77ejQXFQZQLGmtkmM1hQa4v5leA3FXIawacVEFoAAUVdKBBb3Fc/9gYANW4h4BckT8bk/PsfGpefs+1KgpoNR958fbKCsL6Wsy8mQ=
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AM9PR04MB8179.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 03:41:29 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7386.023; Mon, 18 Mar 2024
 03:41:29 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: Rob Herring <robh@kernel.org>
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
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v9 05/11] dt-bindings: usb: ci-hdrc-usb2-imx:
 add restrictions for reg, interrupts, clock and clock-names properties
Thread-Topic: [EXT] Re: [PATCH v9 05/11] dt-bindings: usb: ci-hdrc-usb2-imx:
 add restrictions for reg, interrupts, clock and clock-names properties
Thread-Index: AQHadqnlkxnusB+sL02CNAeG3TUcubE8XMUAgAB+19A=
Date: Mon, 18 Mar 2024 03:41:29 +0000
Message-ID:
 <DU2PR04MB88222B5B241454120EE6B5A58C2D2@DU2PR04MB8822.eurprd04.prod.outlook.com>
References: <20240315072455.2481613-1-xu.yang_2@nxp.com>
 <20240315072455.2481613-5-xu.yang_2@nxp.com>
 <20240317195524.GA2109053-robh@kernel.org>
In-Reply-To: <20240317195524.GA2109053-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8822:EE_|AM9PR04MB8179:EE_
x-ms-office365-filtering-correlation-id: e89e105f-9d95-4d4f-755d-08dc46fd4c05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 bJLMRmGQWg76WujxHZtbburzpG+UbG/Y8BJ8alIvC+OGFuuBfAJnb9XiAZMF0cH+DuBZpzoQ/A5Hf7XsgVQ+Tjk/E4Qi/bpKnh7DWPZ19zBSYOsSxcRTbDSnOuB/rW2z+i6YwtH2eK67GPX2RWtZq8e4JiVy+hRkRYd9g7W7jDzzcQ2PS6FVVH3+sGS2XxOrEyPC0GTao428u8+XoV6VqvwOxhZ4c1cYMbaUGeIgYq1a801zQ8KOESGRvnYUPDcnxwkiuAhSNGnlo5+4HIEU7lhvmPk1kz2BmyjapqwIb6yt37bGWkuYo62D1FFULjekMsncA3EifUFtTXQWiwLyiJtil+c4xDSuK/knWfNDrarlSFMVveUi8unUPLuUyYurDPb92iQQ7uJfvbykGWD3+j2QTYk4rTrzrZkLgLJTkhggbG3R7Go0n8RFXETwoP/SuVVeuzSqxKsGY/zJ1Lo6pc7bBUFNPrO+fWkvCs8sldpQ1/aO7ccGfgxnNBJHId8hlY/Fh2dVTHlwE86R3RPPlodU2EYLemdBandtPC+c0ygbGQW+ulaFL9hjEZm3ffUcqD187xfE5VYM1B6nTL1LZy0lVmczK4Wz46pqsoH8tQIehVJHqbh2Ez9OEr4ecDGDm5cAIl0PLGPcP5XOHtVqpcjLkeUNMDpbMLkm8HRhMMeCyphf9uBIoGMa0OSC/ga6a3j4wcykekvGGft7ILhMflXu6Wqu890/lSL8MLfhKjY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PGNqQb33/Va64ErTWL+X3x+ThvfkFf7lu2n2Ovd79B4dD1ZvTYpapvvijJEr?=
 =?us-ascii?Q?CFpv9kY4JXInsJ3j1Bbx7IIkGKDMV/n/gBd9VWYBta3Fio+Mkli7TbtZEWNA?=
 =?us-ascii?Q?Dbe0++VbOBKQGFdGLuKywtRK57NVzgtL4tbFgNRCvSOYKafGAqWonAHV2ckU?=
 =?us-ascii?Q?qPzES5YJM/QzXeQRv7EMiCZCBHmtMAY7YzweYXqEHLCHEySwbu3ofOnzAX43?=
 =?us-ascii?Q?gFe4EzpsSYzsXxucdsfO8rOnu06GJopo+XWIHxJWbgyVkiq5N7FuENNUGWBe?=
 =?us-ascii?Q?au62XZgoCqA5KsmO2Dxrk59zRFjRul+QrESMmM49RmJVDCpWEDJ3OkgIhK7N?=
 =?us-ascii?Q?O1mpO1uOsyOiH+9BnCRnlsP4z2Cmmx0fa29tfRpxAJcbaMQhSDUN/CADZKBz?=
 =?us-ascii?Q?qQtJdL9C6rawYNhhn5zCP9qwPHtMqEkiWEm7+uRyVGXAhTXtHTlQf+8nAcLU?=
 =?us-ascii?Q?TVAXYUPnU6eV2pXGbLCa7U0EXNOhvzKtcATHVvCQlR79NR5CK4r1D8npP40m?=
 =?us-ascii?Q?8IbVoQRffrKk2+g6pgpSnObp4f0/IZEkZ7gHDndL0EVzgXbdrvrG3GAlR55u?=
 =?us-ascii?Q?bRGD900pYuWLt3AA1SFZWtwPFqLc+URAtdP88KQBzOWtlgxIGahUyEvX16hv?=
 =?us-ascii?Q?vPa5BSBYomm8WE/LI5F+RPj7SwWAOgPFvQuYorCq9xYPuBVjmYS6WOm2rxAX?=
 =?us-ascii?Q?xOiyE+Col04WCGuiNMBaaL8WreKZyw7N4ldcqM2h1HKQZHQkCv74qP02mqjX?=
 =?us-ascii?Q?aggya/nLgrgy16dNlHuUaZC23osum0l38XkuoKDUZ+zYj2hLAIKx1/S4JeHV?=
 =?us-ascii?Q?z54ec512ZPlaCZaDP2yIe0vicXDONTFsGzB/jNFdL0ZJ3w9FVm4ZngnU6985?=
 =?us-ascii?Q?pcIv881dbRqkSmFqoOz3ATE9t/pnWXCEsoEMVjDPrb4Jq61M9KEA8qV4c2hP?=
 =?us-ascii?Q?maNY8zjqL03BMOfGaVm8lEQyDIuPgJoTpxZZxcEG6URgci6v41bZPnI+G0Rf?=
 =?us-ascii?Q?0agtTYLW+hXsG2rDWaBTQcxY0SaGQt7zUfk48y2utBW1qtAqs9O9QLO/rmO6?=
 =?us-ascii?Q?5JenjcfkgK7wEvyc2q+vektWi7TSSKKmNKRs2lNrW5ozcfkXnb/baO//GwNI?=
 =?us-ascii?Q?jEXy4RX5/lIsre/s3zHv4uisFST9np0RqlpZNFjyDrQ3RCaBQYz/6vLu30vt?=
 =?us-ascii?Q?E5Hl1lTwQoADYkS4HWxus33RahpPy9gBLgNebY4W2EKPoJVOIrsQUiVCVZdX?=
 =?us-ascii?Q?6Y10Yhp1RHWoNFsgJYX0pP9LV0s/hFs4jzTszD4INgFObFbzX9hgC/bd9zhW?=
 =?us-ascii?Q?+1mKqe4Qyj4UkUO4aFfHk0wajnRkEOyHXhTieelPzSAbgltb2knrdEkwycfR?=
 =?us-ascii?Q?BSxy4NYQz6QHhRNrA0GKBZWQbbP37w/JER3XlJFLFpPtW1sM7yP8Sl5hAWvY?=
 =?us-ascii?Q?lWcZe2fzoNT4uayEzl6aLmXt1HbQNTljDAWJm6FYR8BZD6xfM6irx6tZHSpw?=
 =?us-ascii?Q?u/GSM8ncQAFYkNww548Ui6Ie4anlx8BNw4pxsk1RKJ4PW5ccq5YW7UFyiyMb?=
 =?us-ascii?Q?BUTs6o8SSzAHdhaRsSU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e89e105f-9d95-4d4f-755d-08dc46fd4c05
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 03:41:29.5276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q5WQTEn7R/QVbRoBZcfpa2c34QwOeEcBmAtYk3Ov0BDMIELyNg6pAPC5dC9RoRkaoCTbA2U7aogaauk0xIksGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8179



>=20
> On Fri, Mar 15, 2024 at 03:24:49PM +0800, Xu Yang wrote:
> > Add restrictions for reg, interrupts, clock and clock-names properties
> > for imx Socs.
> >
> > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> >
> > ---
>=20
> [...]
>=20
> > +  # imx7d Soc need one clock
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          items:
> > +            - const: fsl,imx7d-usb
> > +            - const: fsl,imx27-usb
> > +    then:
> > +      properties:
> > +        clocks:
> > +          maxItems: 1
> > +        clock-names: false
> > +
> > +  # other Soc need one clock
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - fsl,imx23-usb
> > +              - fsl,imx28-usb
> > +              - fsl,imx50-usb
> > +              - fsl,imx51-usb
> > +              - fsl,imx53-usb
> > +              - fsl,imx6q-usb
> > +              - fsl,imx6sl-usb
> > +              - fsl,imx6sx-usb
> > +              - fsl,imx6ul-usb
> > +              - fsl,imx8mm-usb
> > +              - fsl,imx8mn-usb
> > +              - fsl,vf610-usb
>=20
> Can't you add 'fsl,imx7d-usb' here and drop the previous if/then?
>=20
> With that,

If I do this I need to remove 'fsl,imx7d-usb' again in patch 06/11.
(KK said I'd not better do that)
Because imx93 is compatible with imx7d in non-wakeup case, but
imx93 need one wakeup clock to support wakeup feature. Here 'contains'
'fsl,imx7d-usb' will include both imx7d and imx7d compliant socs.

Thanks,
Xu Yang

>=20
> Reviewed-by: Rob Herring <robh@kernel.org>
>=20
> > +    then:
> > +      properties:
> > +        clocks:
> > +          maxItems: 1
> > +        clock-names: false
> > +
> >  unevaluatedProperties: false
> >
> >  examples:
> > --
> > 2.34.1
> >


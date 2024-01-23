Return-Path: <linux-kernel+bounces-34815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0559A8387D9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF0E11F257C2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599B252F85;
	Tue, 23 Jan 2024 07:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ltm810LO"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2061.outbound.protection.outlook.com [40.107.103.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6909C524D3;
	Tue, 23 Jan 2024 07:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705994021; cv=fail; b=qfRnqrUfVzGDoV5ksut5CYL6VFNq7Fk2u3zJxtsiYweniQX1K/8DN1Lds416IRZsRcgEhiq61ZsWDhe85JkqPIilbacDTQzN7VKvVJFBcmpg1p6muqtDCfhS+gDsGDjApPwbmU4Wxl76Z39K1pWw14ni/KoSsiL6HxZjDRq0LnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705994021; c=relaxed/simple;
	bh=qBKKKqfpKPVWQq36kb42i6GvNrdjoJRG2p7b7ua8YUg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jSIrtZRHKULvg0CKF30/qhCA27hcTgwTEEvrInV8OnzbvljB8/4PCtWgNBOVx0xMcIEh5aYMMSjJiCWQb7raMxkEg1Jx5eN/MRsvychGtQwsZDt3YuB8t/lZ80RGsQxzPgs3zNOeLVMD2pkm0m8Yfbs8XZwXaohh55H5lpVjxqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ltm810LO; arc=fail smtp.client-ip=40.107.103.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNL8xmlQnN50N7nPoGVGjT4jvQZ6P/3aWDP/Lg7zRM4QCSIlMG2cUhwtbraAaSo3t7VhUcw6O8ZkylFnIP+mRzIvHM9YVBlryVdIktDTkqx8Trs4pIsLxhXAL3l9mA993sRnSDRUk83TN8J9tWiHINONJ0bt2cYS2VIIHVnsbJLQoy+og5kSujER+rUCPFo6GGDUry05h7KydUmO2sQzRINMCrMZxax5PzcuQ+VpNe5t/rg3iKVW10UNxkrCnT2/JM3FTGxGuUGlduANbUhhn8GWdm0iGaKXyxcFdY30jKVJEelru8OI1x45S6nYXc11ilJrdaiy8qbstyq5TApWlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sijmh89hWHRcgL+TAxjFtVemMjw0lVIZpbxXk6Vzw5Y=;
 b=lGEwQZbR2UOGGn7qtzg90z1nzr7p23Pxgxr4c0P/iyKMhhj754b8bFcK3nUQAYR839ixJHFtfG5PaKPk9RhUV9gufaWfY1a39NfZWzd/3Gz2hqJMe6Pm394Y8sgioBsiS5BqObc3gJKvgkl0uJA7lZ9evbekFFlCsD8BiPZcxo3w0x4Lpuz6PJEHrSMgN6KkkqIBd3VwvX2JVoj4Atk9/T7LGehxJXh2V8WHQhxzPVm/7JbEU4WAYrveOrqIs9lSZJ0mkNHLdvVjPP9QOrdjLqP0nmssfddilJ8fYd+H3PJPl8tw7efuvBnxnk4SaYMzC8kGmD2aGlYFNMkTuVx+kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sijmh89hWHRcgL+TAxjFtVemMjw0lVIZpbxXk6Vzw5Y=;
 b=Ltm810LOXeXOp0ABlLEFz3PeKVXoww/B8ncVyaPdq8XQrH6Pk4YjULJkpfmMl2fHnXSosa5BXAGwrd8FKST1BkmmKApDOzU0gF7nGIWhaBkekPMtoA+7PX50IY9eVh0uRg5zUztV1RuadgTOR/eCH+dkn/XSvbvtdktDuZs80aQ=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8633.eurprd04.prod.outlook.com (2603:10a6:20b:43c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.36; Tue, 23 Jan
 2024 07:13:36 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7202.031; Tue, 23 Jan 2024
 07:13:36 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Jassi Brar
	<jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Aisheng Dong <aisheng.dong@nxp.com>, Shawn Guo
	<shawnguo@kernel.org>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio
 Estevam <festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2 2/3] mailbox: imx: get RR/TR registers num from
 Parameter register
Thread-Topic: [PATCH v2 2/3] mailbox: imx: get RR/TR registers num from
 Parameter register
Thread-Index: AQHaTPpbp7xyUI3B60Gv2ce5VFbv/7DliccAgAEWP0CAAFxVgIAAAGvw
Date: Tue, 23 Jan 2024 07:13:36 +0000
Message-ID:
 <DU0PR04MB94173EEDEE5896D6B9C549F788742@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240122-imx-mailbox-v2-0-7b3c80333b92@nxp.com>
 <20240122-imx-mailbox-v2-2-7b3c80333b92@nxp.com>
 <20240122090330.GR4700@pengutronix.de>
 <DU0PR04MB9417852AC47FA4BCFB38560F88742@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20240123070951.GA93665@pengutronix.de>
In-Reply-To: <20240123070951.GA93665@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM9PR04MB8633:EE_
x-ms-office365-filtering-correlation-id: 12ac7092-ef58-4433-aaca-08dc1be2d109
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 tn8h1L5rRVUQBG68sKnif2m6kGYL58y2X04PVxeAMkknbJTtkNCctCSlV183CviG6KmMldEaxi9dZ4fYvYvHToZKMGgqxS8fS5mLrqjxc6CQ0R6vanvApMzHW7w7jSuZXdzybh68+Az5S1/iHu/HLCOMFe6cAVoFHpxQCXMQAOo/4Fxh2Kc52nvivwAvOnNSjQTq/uWWyGdffOlVQIMMfotzWw3OfXrrkkgjh5d+3ACQEXAW+ynvS1E+7QY3c69e/3FlRIhuNLMMAH+/+ixjCgn2czONCb8dIp+HbItgxo8TShkd4ynEEa2oAinyC5jMj3fy7Y7UkthM9XW4kVHj19MIYE8auTEcMZJJAZvFcNcsZcGN3aBR9NXxDAAYcOlYx+EWLggOo921jVYs4gcQHdQMx9u+D3Cyz02FM6kK/OfK0kEGgqC0H6BO6n6nhQnZhznJzruk/QQ7uw3xyOtG99ujFJudw1mkHzdHl/7fZoQdhZ09hhrZhcWM3He1+xW9wi9T5MMAe3M/awELiAlbbe4MJWY3Qm7xMjY+ErwK59rotf2jSgYZxWxjclqwSoulzxMv/uIcCRhFM9LByaR5K67eWTlFt4BH5a8OU/pS7AGaZNS8pREdse6PJiHLaEnC+kLHO9ZFaMiSH3jkakrt4Q==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(376002)(346002)(396003)(230273577357003)(230922051799003)(230173577357003)(64100799003)(451199024)(1800799012)(186009)(44832011)(71200400001)(122000001)(7416002)(5660300002)(15650500001)(8936002)(8676002)(4326008)(52536014)(7696005)(478600001)(966005)(9686003)(6506007)(26005)(76116006)(66476007)(6916009)(66946007)(54906003)(66446008)(64756008)(66556008)(55016003)(38100700002)(316002)(83380400001)(86362001)(2906002)(45080400002)(33656002)(41300700001)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NkHqJD+DFlmTjGaYT5fkjtwwWb0jHRyRqVJHE4bEUHc0Y2h4lyEZtMEhpXAU?=
 =?us-ascii?Q?u40zftf9vca6+TxSZhGkXAg6fKnWjZJNcNBU3I9IwRwHMitHWxhFq3R4ZmTb?=
 =?us-ascii?Q?AhEFVGKhw6yZR7x5ykGv88YkhcIs3vqruYUXhNR8C2RG+36K/fB1MF7SqhvJ?=
 =?us-ascii?Q?lWNhbWuEvnwcE4zG2iPkggf8DgraqG86uui5tPA8M7QJ2xvmqomhxwtvWWda?=
 =?us-ascii?Q?RkP7F285v7XC0lHVQu/p4d58xTcnc1aCKNyIyOhLYNDIwJHUzR3FU25xPeIH?=
 =?us-ascii?Q?duBVVmoWRSxbuuYF09seZuCvQCd/d1YjfzPWcBndCRo0Ah/zXZFiictyj8sl?=
 =?us-ascii?Q?wrUSKbb63cQxibeIkQpVd/vjRg5P7/hedoqAuWdy0rtTx1dJTpNaaNU3H/Vh?=
 =?us-ascii?Q?Axt3XYRZVSRFdfyPS3StBJTwX/K3wepkhiD6bRygjTteY+YzcJ3iWXpP8tXa?=
 =?us-ascii?Q?2/yjdWZ/jIoTbiz1p+V7lxn9EOsfvLDGemoYUjaBR1YOqbRi7tex2OBpcLeX?=
 =?us-ascii?Q?/9FkHNImqPPlRD1ONwhBTMcv4ZKEYtBJkOdM4yjnZqOy9cjJD1JW73/5dg2K?=
 =?us-ascii?Q?+Bcj/ufdQO1s2nLNMYF3H1+NRymbvSAZW7IF8qqPWC7ClHaFewIAXGf7QCAw?=
 =?us-ascii?Q?zP+D6kTX5lsXJvsqNjZ7cmPjTe1aTpt6yWUt/s1mXEhQzK/rPTf2FelKq5r3?=
 =?us-ascii?Q?q6ICpQ7LOhrd6fN9XgLW5woHl6V2SbmI4mn0a9MtiU0bDnpTr7VmQcZwT9cB?=
 =?us-ascii?Q?jd+MIEhK8gwhSi7TuNRep8+WzwqD+AD44i5IjdLqFSiuaTFZqzNQmw+XInve?=
 =?us-ascii?Q?KJDRaagi3BLWsnYgVvagkyTMi9WkUbnKVaydKyf21ifCwExd74Fj0+UjCP3x?=
 =?us-ascii?Q?9TSD4HC56Cppq4lXXix1RPPwOe8xhucXRyUFRC0OQ/f+eIlQVKL52peBC5Ya?=
 =?us-ascii?Q?2alnBm/j7MBr40aYKN0VgvIEw/jOegKcNmCaRrPPmQ6szN136/XaxW0y7lJ3?=
 =?us-ascii?Q?Cn00yzi+lf4H/WrYFiphTNoqBb1/LbF+BFaLYcV6C2Kkfr/FsZ0mkPsc8oCJ?=
 =?us-ascii?Q?SBaiB/4NywNbRt2Vwya3srjUPe8gr4OEIDQiNrbj54kQMaioxRG4XP9/o2T0?=
 =?us-ascii?Q?9xekNi622x/23OcUpJLubmG8RpUcY/wvYjqi4Bd73PyEiEpSLEwutMYW6W9f?=
 =?us-ascii?Q?qA7FbBWlvd5u9ZB2QUt24rLJwprk4NbspQvupawyuA1Kyu4Mh1Ds2+UpW88R?=
 =?us-ascii?Q?eC1cFzovHSTFhKFr/LGleraDtkrMLaaWRLwng1xBkNSx6FxaMjDIt2i5cjF0?=
 =?us-ascii?Q?Xjbus8sqgFM4NLR6mIBo7jfwpO89RhyLjCWuLncwdlB55+v6SjRzAbFmBtoQ?=
 =?us-ascii?Q?Du/YO4urvbkkHFrjyAwhJ7wiWm/4yZ5ZPYjwrxpgCicbQTKssaXJbYESWtHH?=
 =?us-ascii?Q?amZ0CHB/ves3XCI+GWIURKyAQnORKTfckBR+edX71EEUj7AM2fXJfFyc3reH?=
 =?us-ascii?Q?XGVg5sOmLQbiH5avXGVPQ+IB/3HcNIwD5cOVbkvhkOfe/T1UDjtKih9XmCzt?=
 =?us-ascii?Q?d2Zn7wd6U0ZDBdQq49k=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ac7092-ef58-4433-aaca-08dc1be2d109
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 07:13:36.2956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZUTLFk/TQ53cQOVcOKTBE/jpusdj3SHgaEMFQn42ysd2FrjRDX6ZQgmGBnhCCzbyYOtxCcsh8goxWqXuB1lp4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8633

> Subject: Re: [PATCH v2 2/3] mailbox: imx: get RR/TR registers num from
> Parameter register
>
> On Tue, Jan 23, 2024 at 01:42:03AM +0000, Peng Fan wrote:
> > Hi Sascha,
> >
> > > Subject: Re: [PATCH v2 2/3] mailbox: imx: get RR/TR registers num
> > > from Parameter register
> > >
> > > Hi Peng,
> >
> > [snip]
> > >
> > > >  };
> > > >
> > > >  enum imx_mu_type {
> > > > @@ -264,18 +267,17 @@ static int imx_mu_generic_rxdb(struct
> > > > imx_mu_priv *priv,  static int imx_mu_specific_tx(struct
> > > > imx_mu_priv *priv, struct imx_mu_con_priv *cp, void *data)  {
> > > >     u32 *arg =3D data;
> > > > +   u32 num_tr =3D priv->num_tr;
> > > >     int i, ret;
> > > >     u32 xsr;
> > > > -   u32 size, max_size, num_tr;
> > > > +   u32 size, max_size;
> > > >
> > > >     if (priv->dcfg->type & IMX_MU_V2_S4) {
> > > >             size =3D ((struct imx_s4_rpc_msg_max *)data)->hdr.size;
> > > >             max_size =3D sizeof(struct imx_s4_rpc_msg_max);
> > > > -           num_tr =3D 8;
> > >
> > > This change looks unexpected here. num_tr used to be 8 here and now
> > > becomes 4 at maximum. Was this a bug? If yes, this deserves a
> > > separate patch with an explanation what was wrong here.
> >
> > Sorry, I could not follow you here.
> > The num_tr is switch to use priv->num_tr now. It is not changed to 4
> > at maximum, it is just use priv->num_tr to avoid hardcoding it to 8.
> > As of now, all platforms has IMX_MU_V2_S4 are using 8, and the
> > hardware register num is 8, except i.MX95 V2X MU using 4.
>
> I was confused by the warning you introduced:
>
> > > > +   if (priv->num_rr > 4 || priv->num_tr > 4) {
> > > > +           WARN_ONCE(true, "%s not support TR/RR larger than
> > > > + 4\n",
> > > __func__);
> > > > +           return;
> > > > +   }
>
> It will trigger when priv->num_tr is read as 8, so I assumed it is 4 at m=
aximum.
> Indeed just the check is wrong and you might haven't notice the warning
> during testing.

For now, we not have platform use generic MU with TR/RR larger than 4, so
just give a warning. I could follow your suggestion to return error in V2.

The reason for not supporting 8 here is it would introduce too much change,
because of more channel numbers. So I leave it for future when there
is real need.

Thanks,
Peng.

>
> Sascha
>
> --
> Pengutronix e.K.                           |                             =
|
> Steuerwalder Str. 21                       |
> http://www.p/
> engutronix.de%2F&data=3D05%7C02%7Cpeng.fan%40nxp.com%7Cc0a6c1b5cd
> 1d4c37940708dc1be25585%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0
> %7C0%7C638415906104836756%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi
> MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C30
> 00%7C%7C%7C&sdata=3DyIw7NjXMamXh2IQNfLFU4EBblgYlRz1rYyh4nsSpHww
> %3D&reserved=3D0  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|


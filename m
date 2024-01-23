Return-Path: <linux-kernel+bounces-34598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21850838247
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15F481C268D5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0C85A100;
	Tue, 23 Jan 2024 01:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bAEnNcTN"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2067.outbound.protection.outlook.com [40.107.105.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805065A0F0;
	Tue, 23 Jan 2024 01:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705974128; cv=fail; b=PTF61fr9YFUYwHYhhaaHelQxOR7EewyLO3+nM2g7Ww6+jSCJkXEtE7GBA/9CjVw/t1X5UZhsrW+dzw+vpF6iypMBlrT+6cgmHZJGlTX6NKF62glHhr1/iqwd+rFMIe5hBcvUe148FUIxhOgLoAo1nPBK9iLF2cvS2ts1lJ8P/dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705974128; c=relaxed/simple;
	bh=2cn9994aLTb7IlF3/r6blFktMDYriQB7KIwFyLankT0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VA9iqVCVFb/5raQG4Urm7LBw61agnSv+xgsWMY70umdfPxs2wAzrSZKMv+di0tIfL3uqmJMO4EM1Bh6vosHRpeeB1Tprndzjhdhrd9iW8dgJGdUXC/WWU4FvrDSnsyyb+z1lx/8X2n3VWrFXVnWhSCZM/D2AJ0ZDeTx1sNiUMGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=bAEnNcTN; arc=fail smtp.client-ip=40.107.105.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5YbJ1/o9Ihtuy3bsUn+qW8vEMCSjV3EQZB95B9MuaCTkXgS1lfG6fRx4tJRRGNpQF6eK2e9uUDCFH3AsBFpPA/a6mknREZve7cpxaVxBTtOSocM/XWDhUz16hTTrs2e/Aw1wXSfrB9sFGoDO/SP4hMNZgwAvXZP1uNqrJncCrdChx17iLTsya5u6zT0O7XngPFsrvVbxfWLA6QTOHX/nrhPdQU77uM+c5rx7U1bgYlH7XTr1mW8VR1siRNJ3i2THQHD2pOQ4bZ7H30gCDBhZVxiUjHPAw7KlXymus2KIlthiE7yX0x4LZxmI6QgbIsnahnFNJvm+ESg1j/c6idgCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PosSft4JBc430SykRCvABEUQypD4xIWVX/cg7G65ZRw=;
 b=E6yxxQh5TDlGQUC5/Juw4PpFFauGqSu0GyQGtw+Ro4GK+umn4yYyvA4PDenM4j/zo0YzM1L4s6x/Z8kNuZ4VwwTPSqQ3epn7B+c3KIjcfuwKB9m2zKlm/wirQgMtn0qPbJVau9Sm24WjhVVUmDpLh4NsyVfw57Mc44iNLR4senrbhxQ8Vnon9AlVG9WTnVlpmSeq9ODLBpDTxdQ78zVKHHJxbgoX89lTVlSHCaihK2Xw0z2bce4iAjBeeNBGegySgnZx5xHSbEvIl8zXRjHCoGiSXyU8bLpFwrlsbtw0EyT2XgZZEAu7zqxtEWDp+bCfaGwNnYcRM5/CNlWQKX7YGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PosSft4JBc430SykRCvABEUQypD4xIWVX/cg7G65ZRw=;
 b=bAEnNcTNz3xxL4fzkm//GfY91Sdv9i3wK2DgUO7KQ48BsispcHHA5rgPViD/VA2aJVMEe/sIV/bG4TnLGaoWmxCoez2OMUaniGAtlJDWxnZhfJhZk5LjFlTcSXRrlryD5apuW7KrJPs/prmoJ7f5G5cD7u31ExwZdEOtkxehLHs=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8355.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Tue, 23 Jan
 2024 01:42:03 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7202.031; Tue, 23 Jan 2024
 01:42:03 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Sascha Hauer <s.hauer@pengutronix.de>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
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
Thread-Index: AQHaTPpbp7xyUI3B60Gv2ce5VFbv/7DliccAgAEWP0A=
Date: Tue, 23 Jan 2024 01:42:03 +0000
Message-ID:
 <DU0PR04MB9417852AC47FA4BCFB38560F88742@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240122-imx-mailbox-v2-0-7b3c80333b92@nxp.com>
 <20240122-imx-mailbox-v2-2-7b3c80333b92@nxp.com>
 <20240122090330.GR4700@pengutronix.de>
In-Reply-To: <20240122090330.GR4700@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM9PR04MB8355:EE_
x-ms-office365-filtering-correlation-id: 311ef9dd-aa43-48af-bd08-08dc1bb47fc5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 9uSbCqVaSZJfSaMGOs9wXDxNRRoe5UdFURefgNC80LwLne+aTdGrpd+saYLz1G9119PnJuKXYIYLmX9aevHtfqFQ868SIRbMxy99n09vDhzKs0XlPYY9jc9HYQ1i9uGJvk8OVog9bcmZezsnfzAZ9Ns5p7tT/eYsrNb/xez/Gyh2BRvzzYX1a7BmMl4w1c33bX3wMHWzMML9qvVfggGywn9CHCEC3s/W81ZzOLtSuLWL7ErXNCPoATXc0GMqQEEUsVn/xkTdqlbjVm3G2hG2KWqAWGSoDYGa1M72Pq6FP4yYZSnJOKsaTS00t5nHTXzmCK6nJlY6bJXoRf4w/vwFZ3ywUnou8LhcNDLotAxueckqYKgDiRVKxyh+SPxt/RT0/ZpV6ruYb0yPkhvAw0w/hvzun6CYAJmcfsIaKILdTchxtRqoNwQMy3CLDjN5ScyJIIf1i8DnD3fh7PODGRI4w9d9n89LjJp/YFcjyDs2Ffd5XDHt8hC2GrzBIAnYirsqC8Lj10NYksTBN4TMd7LNlhFFhqIzHLhMt9S484By3wcOkm3OHg2Sc3k/0OXPqd+HIGBF+ll0rZTdoXXlQKByY9tsgVy1WE5gsOwJPDb2xWydpcs5XLoN2DjDGZY17lw1JFHn2WWsYgDVK8fL+0EzoQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(39860400002)(396003)(230173577357003)(230922051799003)(230273577357003)(451199024)(1800799012)(186009)(64100799003)(7696005)(9686003)(6506007)(316002)(8936002)(76116006)(8676002)(52536014)(71200400001)(966005)(64756008)(110136005)(66946007)(66446008)(45080400002)(66556008)(26005)(66476007)(83380400001)(54906003)(41300700001)(2906002)(4326008)(5660300002)(7416002)(15650500001)(478600001)(44832011)(86362001)(55016003)(33656002)(38070700009)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?g8kQGoRuPqUdxjgF1kvY33he+q5ZcM+xgfrKQTQGaRoAe/QUyXOI/qP0Yqs+?=
 =?us-ascii?Q?fK2FMqm4puEJMTz5Q0/jlE6h27HQY8xYycSfaz88vj31VFHMt7l+bHzerpgN?=
 =?us-ascii?Q?cJiiqAABgLP50UvejbA+mnY+MKPBtTUPaDMNm+fjvQgtOVKRzMWHLljHznMU?=
 =?us-ascii?Q?5HHGtXqyOoVZljmgutQi6A1yXPKNuXfmLBrU9NQIc/hIg+UfefNktqwbENyB?=
 =?us-ascii?Q?gR9FXXlFXf7Ip8dYcTz6saD5cF+Mr1QPDJL/GCnBvvRVEpJ2iyAjq+MAlU3A?=
 =?us-ascii?Q?v4vW5HaUlEEaOtfKLiJH8W3e0ZJxKZDFap8Jg7Nu7th50qw9w+8CX6XYlWFk?=
 =?us-ascii?Q?2+92mCzBKqdV49ikQlpT0vRbnGjvC8EnbEz37LoJtn8zq6tS8oZomw+K2meU?=
 =?us-ascii?Q?SY4WMldQcVx8fxM3uwa+mQttVgImoQQk+WUlREk3QnuEBgU6dRzg+SYEcB8W?=
 =?us-ascii?Q?IW7giFilnXb7fvggidZpEtoA8UsdPKB/rl33+G023209ZTbtptoT3ZgsPxoa?=
 =?us-ascii?Q?yqQFCW4gUqQx1o8BPZfxPYbRCD7IyR2WyGvMysesnlVZCRpdPnwSgM52L2ud?=
 =?us-ascii?Q?AWax+7f0UwnsFlYgQSeIuCC2CXzw7nU5b2LqaSHxo+2ef2GXn8dfuo7X/SLr?=
 =?us-ascii?Q?KK4iHqCLfcmveFD3aYBb5ibsysAHi201bOIAMbiUmb2tnJuYsghwyuC4g0d0?=
 =?us-ascii?Q?i6aAAEIQOpQCA1ibK3FCYpMsm6fLZftMnJJZuc2jPEb9D/Z1hGV+7u5ZnXtY?=
 =?us-ascii?Q?r2CQHmTjEhIgB3Li64pzNkZc2JP5lyYDKgg83x/mUE8wqu/xZq2lMVLAGNGS?=
 =?us-ascii?Q?ZoEWJzRKaT4smYu98FkfrUiNGsxynJZMNDjvFgD9zTaaAfHbfPDpy7xsD+a3?=
 =?us-ascii?Q?XfV79e0GyN8ZOuItwmrDtx4wyQ649qrGzA9vZrTK+E6nIwZ75REjpvqfquME?=
 =?us-ascii?Q?Om8ulm2RAtsM04Pi9WzRX9iapHAXCajr4LAFucBH3Y4LIVaD+rIqkQ7t10ve?=
 =?us-ascii?Q?OzT55kobKnxrsqXIcdUZb6/Mb9wRwF59UgcyrMX9lnZ8Ux1TZgawhRiuWCrv?=
 =?us-ascii?Q?shv4bIjx3dS0eHrlkiGP0uCjQzzXbSnF3oSvHT1nP28el+/g0eTBArka6KqI?=
 =?us-ascii?Q?/UBWFc3qBQEQgjiTPr+09K51L5SUxVllhFR9vH0kgAo6XqdNXRVdUBi0IFZI?=
 =?us-ascii?Q?hJOpomUdaq1mJzuVZB7pokpCJZeWmMcujV9TNREFBGMGx8kcXQLRDTQf6UXz?=
 =?us-ascii?Q?Dg/PWtg4S2+Ys+liEgiRPyuYsm+RtJxeEmceZdW6ylw6VlR0a/agKK8Oy7xK?=
 =?us-ascii?Q?wha6yg02sVGSvQ9GjwvUFHZMXqKygIa5cTT746Hh3uQnXzkavx0mKUsPCLoZ?=
 =?us-ascii?Q?vXoDFq6Or7lzQnxkvrRFVb9W46I5sW9z8hXHDevkr2vRPNXmmbtcn7t1dvs7?=
 =?us-ascii?Q?r/HqdcHGl7P8YBwXMW54CQlAPMFT5YaQQ6qz421zkOptgrbNRSnSl943IvI7?=
 =?us-ascii?Q?wRGXqlldC+knn2vGq8VdxQvvvxCFEp2cQtFbLjrYPrL3R8KEu/9ZQwctWLPm?=
 =?us-ascii?Q?PY3DPPVilGqP5zZEBSU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 311ef9dd-aa43-48af-bd08-08dc1bb47fc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 01:42:03.1197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pX2/81MijmHVB+d2xACPdZnXvtBurKKmAxCen4vzzEBsg9eH+250ykVPCNulwZLsdeuZx0CWvjV0ePE6OaR3AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8355

Hi Sascha,

> Subject: Re: [PATCH v2 2/3] mailbox: imx: get RR/TR registers num from
> Parameter register
>
> Hi Peng,

[snip]
>
> >  };
> >
> >  enum imx_mu_type {
> > @@ -264,18 +267,17 @@ static int imx_mu_generic_rxdb(struct
> > imx_mu_priv *priv,  static int imx_mu_specific_tx(struct imx_mu_priv
> > *priv, struct imx_mu_con_priv *cp, void *data)  {
> >     u32 *arg =3D data;
> > +   u32 num_tr =3D priv->num_tr;
> >     int i, ret;
> >     u32 xsr;
> > -   u32 size, max_size, num_tr;
> > +   u32 size, max_size;
> >
> >     if (priv->dcfg->type & IMX_MU_V2_S4) {
> >             size =3D ((struct imx_s4_rpc_msg_max *)data)->hdr.size;
> >             max_size =3D sizeof(struct imx_s4_rpc_msg_max);
> > -           num_tr =3D 8;
>
> This change looks unexpected here. num_tr used to be 8 here and now
> becomes 4 at maximum. Was this a bug? If yes, this deserves a separate
> patch with an explanation what was wrong here.

Sorry, I could not follow you here.
The num_tr is switch to use priv->num_tr now. It is not changed to 4 at
maximum, it is just use priv->num_tr to avoid hardcoding it to 8.
As of now, all platforms has IMX_MU_V2_S4 are using 8, and
the hardware register num is 8, except i.MX95 V2X MU using 4.

>
> >     } else {
> >             size =3D ((struct imx_sc_rpc_msg_max *)data)->hdr.size;
> >             max_size =3D sizeof(struct imx_sc_rpc_msg_max);
> > -           num_tr =3D 4;
> >     }
> >
> >     switch (cp->type) {
> > @@ -324,6 +326,7 @@ static int imx_mu_specific_rx(struct imx_mu_priv
> *priv, struct imx_mu_con_priv *
> >     int i, ret;
> >     u32 xsr;
> >     u32 size, max_size;
> > +   u32 num_rr =3D priv->num_rr;
> >
> >     data =3D (u32 *)priv->msg;
> >
> > @@ -345,13 +348,13 @@ static int imx_mu_specific_rx(struct
> imx_mu_priv
> > *priv, struct imx_mu_con_priv *
> >
> >     for (i =3D 1; i < size; i++) {
> >             ret =3D readl_poll_timeout(priv->base + priv->dcfg-
> >xSR[IMX_MU_RSR], xsr,
> > -                                    xsr & IMX_MU_xSR_RFn(priv-
> >dcfg->type, i % 4), 0,
> > +                                    xsr & IMX_MU_xSR_RFn(priv-
> >dcfg->type, i % num_rr), 0,
> >                                      5 * USEC_PER_SEC);
> >             if (ret) {
> >                     dev_err(priv->dev, "timeout read idx %d\n", i);
> >                     return ret;
> >             }
> > -           *data++ =3D imx_mu_read(priv, priv->dcfg->xRR + (i % 4) * 4=
);
> > +           *data++ =3D imx_mu_read(priv, priv->dcfg->xRR + (i % num_rr=
)
> * 4);
> >     }
> >
> >     imx_mu_xcr_rmw(priv, IMX_MU_RCR, IMX_MU_xCR_RIEn(priv->dcfg-
> >type,
> > 0), 0); @@ -737,11 +740,30 @@ static struct mbox_chan
> *imx_mu_seco_xlate(struct mbox_controller *mbox,
> >     return imx_mu_xlate(mbox, sp);
> >  }
> >
> > +static void imx_mu_get_tr_rr(struct imx_mu_priv *priv) {
> > +   u32 val;
> > +
> > +   if (priv->dcfg->type & IMX_MU_V2) {
> > +           val =3D imx_mu_read(priv, IMX_MU_V2_PAR_OFF);
> > +           priv->num_tr =3D FIELD_GET(IMX_MU_V2_TR_MASK, val);
> > +           priv->num_rr =3D FIELD_GET(IMX_MU_V2_RR_MASK, val);
> > +   } else {
> > +           priv->num_tr =3D 4;
> > +           priv->num_rr =3D 4;
> > +   }
> > +}
> > +
> >  static void imx_mu_init_generic(struct imx_mu_priv *priv)  {
> >     unsigned int i;
> >     unsigned int val;
> >
> > +   if (priv->num_rr > 4 || priv->num_tr > 4) {
> > +           WARN_ONCE(true, "%s not support TR/RR larger than 4\n",
> __func__);
> > +           return;
> > +   }
>
> imx_mu_init_generic() is not called for all device types, nevertheless th=
is
> should be treated as an error for all device types, so this check should =
be
> done where the variables are initialized. Also, please return an error ra=
ther
> than just issue a warning.

ok, I will change the function to int return type.

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
> engutronix.de%2F&data=3D05%7C02%7Cpeng.fan%40nxp.com%7C8e3e1d53fd
> 694029ddc708dc1b290bd4%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0
> %7C0%7C638415110314502701%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi
> MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C30
> 00%7C%7C%7C&sdata=3Di9Q4SuR%2BwgOGLodJtZJlgMYngyikZNP5ktxiNqzMf
> WM%3D&reserved=3D0  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|


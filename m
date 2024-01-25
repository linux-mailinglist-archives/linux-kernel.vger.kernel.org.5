Return-Path: <linux-kernel+bounces-38462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDDF83C042
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3F1C1F234A5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E61032C60;
	Thu, 25 Jan 2024 10:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VLhzAdWV"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A547A2C1B5;
	Thu, 25 Jan 2024 10:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179976; cv=fail; b=FIGmrWBBlltBX4ejdYOMBmSTcMb1UhVLcDyFZhBSBiDUB3OaXE16m2OSB8hTIBbwXxEkMkeT3pjxzGAq5qhEnO+n3M+6WodyPPo42M2MUrMdjKt7vzOzfprrt1QOQ/fscVh5rCY3QfJTmOVBpXxWImlzpxk2+jWvzC1D5OUIMqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179976; c=relaxed/simple;
	bh=4O+tBTHwTpzgCr6YQX/TdLefj6VPneoljAMSfQM4snU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sB8P4dg/yNmcobp50Y8Nma8dzES7i+hELxhblHO/7hrQB4eYxtbj0oMcuFC1IeEfw5X/W1OxshOa68VfarLJZ1sl8r9VO6bayWaVs6BeA7tJiErbi4a57rSDqK7CnqEdC87XY6tBrsz3if0QmpGaJpgfVl2U9vKl9Ri0jTgB2UI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=VLhzAdWV; arc=fail smtp.client-ip=40.107.20.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=huA3XhohoAowyA8/qoIFtVFC5Tcg4l+e5XjP2Axg7fDcNlHEJ5wyA0mFnpCJyRLAILbe5calxekXmcUuDzXbIvKV2sEIoIn1iWoCz90ZBDRkcbN26yB6EXy4VLLGtJ3iwFMMTSKtC/DJaAwI6u7KIuXNRjtC/G+231eXOdjgDRUBq4RZNvq6OV9VtI2UazA+74UNa49bpef+3lhG7J6SJ9ZW6VbEaKzH7HMbVlCQXDga5a8Xrcodpz9r2OQyPwqo9fD4uFNoY1YOd6V5DTu//T11diEWQvWtayyL/TA4/F/JsUnYrFp/TPekOLC9LtOK7B8rhBc8hCr7GO0b1oom8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owlhTuPEGP6Qoy/UNqSHeeK+P5bGlLyfeX6bUuBnI10=;
 b=P8XAcacryccU47b8EnG5LJ/2eIANAeQefoKyt+vrTxpkE2rH99FfzlnaHYnbPhiX+c3yyWZuG8Igw6Lwrys0wuhy1B/cm/bkS06s7wPDTFjOUeryYHG6vHcTeXZjadrA39lA/9qVpImWhCgeefG7URh5htSMe1v3NN0IoyF3CscpleFTKp1N1kS2KfoQWOfvVfY4zGUCiUT/I2u++JjLlGQVc+wlv8gpFXwxPPV6m2BWFuUAqT7Bi/8YlUttTvfNSTXuyJL/ZxrT+zQ1baqi3uAqJzLOcGAe/cZ8byKrhz/WbDdEku45N/hBT4WynVfVLDzN5sKHVDVCEKme6yWdrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owlhTuPEGP6Qoy/UNqSHeeK+P5bGlLyfeX6bUuBnI10=;
 b=VLhzAdWV2UAVyI/VJhdtygzkwQ5FxfL3hLzg8gXVYALEjO52UzCiUC3jaBRSzrw3nKz/PgVJusoSvil8vJVEo9RkUVOqw0UD7VRL0GolZby7muOR5BZOuU2VH8w37PYi29/99Bbuycz76CzT03jXiOiHKIp7eZ0cyiR3TeB9Juo=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6916.eurprd04.prod.outlook.com (2603:10a6:208:185::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Thu, 25 Jan
 2024 10:52:50 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7228.022; Thu, 25 Jan 2024
 10:52:50 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>, Jassi Brar
	<jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Aisheng Dong <aisheng.dong@nxp.com>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	dl-linux-imx <linux-imx@nxp.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
Subject: RE: [PATCH v4 2/4] mailbox: imx: support return value of init
Thread-Topic: [PATCH v4 2/4] mailbox: imx: support return value of init
Thread-Index: AQHaT02U2giKdr0KhkShWWxfBi5ZB7DqPngAgAAb8yA=
Date: Thu, 25 Jan 2024 10:52:50 +0000
Message-ID:
 <DU0PR04MB9417354BF909ED3B517FD496887A2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240125-imx-mailbox-v4-0-800be5383c20@nxp.com>
 <20240125-imx-mailbox-v4-2-800be5383c20@nxp.com>
 <5774190.DvuYhMxLoT@steina-w>
In-Reply-To: <5774190.DvuYhMxLoT@steina-w>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM0PR04MB6916:EE_
x-ms-office365-filtering-correlation-id: 837be5b0-1e2f-497b-fe72-08dc1d93c652
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Wn/x9LhF7JMMklNWgFHaURb5SP4z06zoW+4CG9AZrfKwoBpgRItRfTY4RziLYeREOO0rjZ6sJ0c7bJOo+pj6zBHDM2VzRUyM2jOCv3lunviDvy/Ag4iGhQp9WI1dMQ/ui/UQg3dWrnHH4p8SMaF24FEdGjCyhWfAc7b5Ci3ptutkdouLNzeE8eY1zPIw6cLJ8klnxLv07bcnoRUHQQiNOgzq/n6iZ4FCZsGylrWqUiWeptFINovBo7m1xScNQMlS8WrVfIX6GKWpokQq38mLNNeZgTQwtE+SegdktrrLUFXumZMoZQjqr7VvIW0mMLgDuKm380YzQtJhQLGJlbi3foRmCIYDneppcL/oS4WHy86t3WNa+kTD/lbMf3KGZoMiwX1aWHiKZWmwa8ZIqCqJb6+GkHouqcChP3DxjdGm6hFXJ7NX13OhzQAeZA1IH1VCL+gIDqv8aPnO2Yp8pFYkn8nB+H5X/FwDQzqxWXrbdpiFI/kJjGcn4I77RrYraFSsGcmpSMQgbFUkemdLQ4DnS+LJ3GhEyjCOs3nmKgua2FTbRxPcDLLSax7z9SesAx9hxJMGO863j3Fr41eE7SU5hag4gS5NGLdKHHxT+ZAtp/+/BiCogpXBZapdeE9/l4In
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(376002)(346002)(136003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(41300700001)(33656002)(86362001)(122000001)(38100700002)(66574015)(52536014)(4326008)(478600001)(44832011)(54906003)(66476007)(64756008)(66446008)(66946007)(66556008)(316002)(76116006)(5660300002)(8936002)(8676002)(110136005)(2906002)(15650500001)(26005)(83380400001)(7696005)(71200400001)(45080400002)(9686003)(7416002)(966005)(6506007)(38070700009)(921011)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?xUlTXmGxHbxTpcvXjO7UmeyZavkkifhdiKp1yG3lcgqKCeKn2UM9cCVSlL?=
 =?iso-8859-1?Q?/6lIMhf2WGBP5yN7QHR0dCRYSFKXqAn2ExLwDMtSxpxoymIYBvU/WV6/OS?=
 =?iso-8859-1?Q?oBg2i8ahMMA1CmplyglqTxKWWehQsXrcCx0DLq/9ZuyLip1sUH1GJjGce/?=
 =?iso-8859-1?Q?geBt0qbqRORrund14CRZs/by6S+MzpFl00kYlmDrQN3JE2z/84OC4DBsHd?=
 =?iso-8859-1?Q?pBY4JpnsU2wmjgoC6c7T+yGoIFprbFXSkkeGE5C1vY4+pm1iZ6v0e2opUl?=
 =?iso-8859-1?Q?ZLVCVbqkGYakIZDXq2z6NsyN1Ul8NfJ/+NKJQ1IKtwwZLNQ7CN0UFJlJR0?=
 =?iso-8859-1?Q?HekQ3DFaprvQ/I8nDH8bTDsgC5kx+y18UamOGe6GVPOaOitg2TsXHq2BPS?=
 =?iso-8859-1?Q?Hs3a2ZwfXjIzBkPLLSE/OxsUbkLVr8jTcZujMuuXr0MIDcm9Gkopl76o5d?=
 =?iso-8859-1?Q?r5oBkGHVstW7R9tqYWGotuYtTNKlhaUxRCJ4zmXwQnT4bqQj1Un6vDFCOp?=
 =?iso-8859-1?Q?Xzm0j3ypZCtj7lybDz4Spkra5Eo3EqaMSWF4TlY32l48RXBujojUTRVw3F?=
 =?iso-8859-1?Q?zvzYnnNVKDxRnoKBJiixDWHjdxggjgqW9bQWueGxK19O4VSVvi3587XiBN?=
 =?iso-8859-1?Q?ZaVnLjU/wn/Ya6Lq0fakJCHIBTRkUOQy1FMEjnUlbbvROkTH+4ySsmThjV?=
 =?iso-8859-1?Q?OZZhQsVlbORwSc/KJOBWcCitqMx2Do4SlOdTaaJlKFUyuv+OUgHlvo3c7v?=
 =?iso-8859-1?Q?rDzE9Nwl4jEfmObg78RObwwLaNJirOgZmVx6e7gd4oo6nXGQYOoMKFFLzh?=
 =?iso-8859-1?Q?vbBhvSVEzOWmFK7HfSZV2tByIatfHADYr3QTJV9Lpr80T62PpRF0Rb4pxj?=
 =?iso-8859-1?Q?v02fBM4i9SFn3FFlAn0fTLgUPu+xHCgChvCZIqkozrKbbFJj2zvna6hymW?=
 =?iso-8859-1?Q?Afui/LajnKXL+CV6e6E66Fy7P3CCxAUf7m0PLsBJ5DJT5gEdZSSVT+DAFf?=
 =?iso-8859-1?Q?qFlnpSQDY8smNAOPAM2zD39MJgZM1jko4yGW61z0v9wVCdB1slzNZ6n4Xi?=
 =?iso-8859-1?Q?iGNjxgs3jSQ3RQRYLizURcqaJD2w/tQ48ZhgOMbdrPqvkYETSb+O/1+sIj?=
 =?iso-8859-1?Q?/1kpyWZ47H2pwkIz8mpfigVoAKa658Mxg1bU9P4yPFU4+nFV84s2IIwL1V?=
 =?iso-8859-1?Q?EW1/n+X4qvMeCjiBqtjl24bD0dhSbd2gRZTGGasUaS1U955B0y3DkW3nIT?=
 =?iso-8859-1?Q?wA2q5zaXW5ZxJD2uko8uCyIIyFsa66KWhLbaYVv9HTGYuFuilXyN+/RzH1?=
 =?iso-8859-1?Q?WGb2RJiZGT+UWkuEiSqLJ7U5HqDbc/LyP1SxJ9ZnQn6GeXr8Vh4j+sU34R?=
 =?iso-8859-1?Q?JEFrrvDDAxRmkvYCGvOh0uIkyW78/SeU7DsORjMrhqqSQhf+Kc6sYceyq+?=
 =?iso-8859-1?Q?09uroEfpDHPMfF6Th11RPzRrZSaXvOpmVyoZmeYi/OlngS0nL/pL9zGMCG?=
 =?iso-8859-1?Q?MTVjmI08dsK5MZm/gxzc8etr1xXMNh2kCU8n4oTcogFSD777EPjGehjcLU?=
 =?iso-8859-1?Q?2jxXvCUG2GPrZ222rGvJ3Tvo1krCFwnvomadj+Ma6Kea1UuV2ul8SgY6XC?=
 =?iso-8859-1?Q?+Jgm4b3ehc/88=3D?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 837be5b0-1e2f-497b-fe72-08dc1d93c652
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2024 10:52:50.3880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8WI3gZQzMeuY4DR2vDWKYNoWYA9EshYQKrYSVB0k7CSk8K3RysIML7ETTTWKDaq4YKZTYMNdy27TR+u1qDeUmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6916

> Subject: Re: [PATCH v4 2/4] mailbox: imx: support return value of init
>
> Hi Peng,
>
> Am Donnerstag, 25. Januar 2024, 06:20:04 CET schrieb Peng Fan (OSS):
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > There will be changes that init may fail, so adding return value for
> > init function.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/mailbox/imx-mailbox.c | 35
> > ++++++++++++++++++++++++-----------
> >  1 file changed, 24 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/mailbox/imx-mailbox.c
> > b/drivers/mailbox/imx-mailbox.c index 656171362fe9..dced4614065f
> > 100644
> > --- a/drivers/mailbox/imx-mailbox.c
> > +++ b/drivers/mailbox/imx-mailbox.c
> > @@ -110,7 +110,7 @@ struct imx_mu_dcfg {
> >     int (*tx)(struct imx_mu_priv *priv, struct imx_mu_con_priv *cp, voi=
d
> > *data); int (*rx)(struct imx_mu_priv *priv, struct imx_mu_con_priv *cp)=
;
> > int (*rxdb)(struct imx_mu_priv *priv, struct imx_mu_con_priv *cp); -
>       void
> > (*init)(struct imx_mu_priv *priv);
> > +   int (*init)(struct imx_mu_priv *priv);
> >     enum imx_mu_type type;
> >     u32     xTR;            /* Transmit Register0 */
> >     u32     xRR;            /* Receive Register0 */
> > @@ -737,7 +737,7 @@ static struct mbox_chan
> *imx_mu_seco_xlate(struct
> > mbox_controller *mbox, return imx_mu_xlate(mbox, sp);  }
> >
> > -static void imx_mu_init_generic(struct imx_mu_priv *priv)
> > +static int imx_mu_init_generic(struct imx_mu_priv *priv)
> >  {
> >     unsigned int i;
> >     unsigned int val;
> > @@ -757,7 +757,7 @@ static void imx_mu_init_generic(struct
> imx_mu_priv
> > *priv) priv->mbox.of_xlate =3D imx_mu_xlate;
> >
> >     if (priv->side_b)
> > -           return;
> > +           return 0;
> >
> >     /* Set default MU configuration */
> >     for (i =3D 0; i < IMX_MU_xCR_MAX; i++) @@ -770,9 +770,11 @@ static
> > void imx_mu_init_generic(struct imx_mu_priv
> > *priv) /* Clear any pending RSR */
> >     for (i =3D 0; i < IMX_MU_NUM_RR; i++)
> >             imx_mu_read(priv, priv->dcfg->xRR + (i % 4) * 4);
> > +
> > +   return 0;
> >  }
> >
> > -static void imx_mu_init_specific(struct imx_mu_priv *priv)
> > +static int imx_mu_init_specific(struct imx_mu_priv *priv)
> >  {
> >     unsigned int i;
> >     int num_chans =3D priv->dcfg->type & IMX_MU_V2_S4 ?
> IMX_MU_S4_CHANS :
> > IMX_MU_SCU_CHANS; @@ -794,12 +796,20 @@ static void
> > imx_mu_init_specific(struct imx_mu_priv *priv) /* Set default MU
> > configuration */
> >     for (i =3D 0; i < IMX_MU_xCR_MAX; i++)
> >             imx_mu_write(priv, 0, priv->dcfg->xCR[i]);
> > +
> > +   return 0;
> >  }
> >
> > -static void imx_mu_init_seco(struct imx_mu_priv *priv)
> > +static int imx_mu_init_seco(struct imx_mu_priv *priv)
> >  {
> > -   imx_mu_init_generic(priv);
> > +   int ret;
> > +
> > +   ret =3D imx_mu_init_generic(priv);
> > +   if (ret)
> > +           return ret;
> >     priv->mbox.of_xlate =3D imx_mu_seco_xlate;
> > +
> > +   return 0;
> >  }
> >
> >  static int imx_mu_probe(struct platform_device *pdev) @@ -866,7
> > +876,11 @@ static int imx_mu_probe(struct platform_device *pdev)
> >
> >     priv->side_b =3D of_property_read_bool(np, "fsl,mu-side-b");
> >
> > -   priv->dcfg->init(priv);
> > +   ret =3D priv->dcfg->init(priv);
> > +   if (ret) {
> > +           dev_err(dev, "Failed to init MU\n");
>
> As this is during probe, I rather use dev_err_probe right away. Even if d=
cfg-
> >init won't return -EPROBE_DEFER for now.

Let's defer this action until init could return -EPROBE_DEFER.

Thanks,
Peng.

>
> Best regards,
> Alexander
>
> > +           goto disable_clk;
> > +   }
> >
> >     spin_lock_init(&priv->xcr_lock);
> >
> > @@ -878,10 +892,8 @@ static int imx_mu_probe(struct platform_device
> *pdev)
> >     platform_set_drvdata(pdev, priv);
> >
> >     ret =3D devm_mbox_controller_register(dev, &priv->mbox);
> > -   if (ret) {
> > -           clk_disable_unprepare(priv->clk);
> > -           return ret;
> > -   }
> > +   if (ret)
> > +           goto disable_clk;
> >
> >     pm_runtime_enable(dev);
> >
> > @@ -899,6 +911,7 @@ static int imx_mu_probe(struct platform_device
> > *pdev)
> >
> >  disable_runtime_pm:
> >     pm_runtime_disable(dev);
> > +disable_clk:
> >     clk_disable_unprepare(priv->clk);
> >     return ret;
> >  }
>
>
> --
> TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
> Amtsgericht M=FCnchen, HRB 105018
> Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
> http://www.t/
> q-
> group.com%2F&data=3D05%7C02%7Cpeng.fan%40nxp.com%7C77ae5cd17000
> 42c9a4f008dc1d85b1ba%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7
> C0%7C638417707259707963%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
> wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7
> C%7C%7C&sdata=3DOuTmDvQM0MYTBv%2BhwtQNPgd%2BuA9cMKoBIHe%2Fi
> Zl9Iu4%3D&reserved=3D0
>



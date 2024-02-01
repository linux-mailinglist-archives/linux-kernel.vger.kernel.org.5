Return-Path: <linux-kernel+bounces-47527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A3E844EF5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 03:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BE6E1C2137A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E515FC14;
	Thu,  1 Feb 2024 02:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="C9yr2iRy"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2085.outbound.protection.outlook.com [40.107.7.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B074EED1;
	Thu,  1 Feb 2024 02:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706752962; cv=fail; b=aW0fWpXRcbeOE/SMXhIJTeMl48a3deOMrpEXA+rXiB99VVfubQeHrT40/+5Q2ZMrigk1pUk2V816JqEqaS5BDTi0tASibgY7HugEayDW885AJXLg0401+NxTHcecx75lERyX5L0l+dCcxV8vMww4rhXook1TbjfarqRRHTf9M0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706752962; c=relaxed/simple;
	bh=rIe+n+YISU5N9UYnYRc05IeYEYN8k1oSAzIdRsk9AZ4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cWRcy/vjcieTM4KtsTJNpZfMKTNNvB2J1JKKTeRsKF3xQVaV1InHAH8CsZfTaReV46oueWnwSJq/Cg1ubWK/n8eJq7xCb3fl1OjXVe0zkN6lWdAQdXu0ljMEUWTCBp5yb6RgRkEupLYeelNvwqYNG0i83C8MWRm3x0CJPj++fMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=C9yr2iRy; arc=fail smtp.client-ip=40.107.7.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clMoSlJQmm5/9Q1lKHYtcxuczETZk0yUGikVZmhaNSBD1fUkh0kk9uL54RlzEd/rR7FSCKeHgqcRbW3OuVY15hvEf0OW7jZMaso0u5WoapPklKcXx/pXAlDygc48S2HVIL0APzR8ri8OzVESB5q0DuAsJYFSwFJnZ2x/XpXu4hIBVT6g17MFTygrXjot/mUD8rz5DA5Sl5xftrCAF1lEWiHWs7xqne+QxNRKOgZ8swvjq/yvITNpmDVXp5Udl5VTkTHmQmPSQ5Bcu8obE5MaWB7Wl4QdQqEt2CKt3Y9GQYTxfqberxnwkfQqsBWzZqyVpSp8F0Hto7bDyi/FhlB+bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lshFMtKLQ1WhHBYTysLtAoe3Uw9fRk8P25Nc0sSZ8YI=;
 b=maP8SN+P8bxcKQeQ/o/SZahkn9WqKsBrcoHAo8DF+GMltTNjVdkZTETWECJj2aS11IKL+iQ52OGGxgijQiHPMo7SaERyT04K+Up7Z1Z3UZyLYmXRmmtBq/Qm+YD+mKc0WJJAoe89EkvofVaXr6qUTOewmHmElPqxpmBnBomy6uil0FadaglUtaDKWT99gnFRw9DmKSFfAovu2OgBxysdhdw9ol0z7+8sNgkzqNzo1PHg3KXoxCurcF9Ds5JCdqruTB+dYTvk03H8TTvo9wzQQU38YXNKDysEA0+bEvKCSyu+jHUuvW7qbyzMKKJjXB53QXnmsxSCi8fBGMJjArzfTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lshFMtKLQ1WhHBYTysLtAoe3Uw9fRk8P25Nc0sSZ8YI=;
 b=C9yr2iRyEZ68tdzaVZQBN2Sga9sW4yeKBMzW0H2ixWK5cASvbZsYYux7hyhzsefbhY9iuR7oM/flpEDvL69jgfXjax7teCFzrgrvDPzk2LIP1V1imRtoTsXyzmczV2/MrFoMEQn64EZHFDPe93AXuv61HyfSXIGDZbVZ2QRabaw=
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by DBBPR04MB7946.eurprd04.prod.outlook.com (2603:10a6:10:1ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.27; Thu, 1 Feb
 2024 02:02:36 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::f363:2b4f:4f8b:8af5]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::f363:2b4f:4f8b:8af5%6]) with mapi id 15.20.7249.024; Thu, 1 Feb 2024
 02:02:36 +0000
From: Carlos Song <carlos.song@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: "broonie@kernel.org" <broonie@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, dl-linux-imx
	<linux-imx@nxp.com>, "benjamin@bigler.one" <benjamin@bigler.one>,
	"stefanmoring@gmail.com" <stefanmoring@gmail.com>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] spi: imx: fix the burst length at DMA mode and CPU
 mode
Thread-Topic: [PATCH v2] spi: imx: fix the burst length at DMA mode and CPU
 mode
Thread-Index: AQHaVLK6Wv7a10Us/kKnxfcUHtG6JQ==
Date: Thu, 1 Feb 2024 02:02:36 +0000
Message-ID:
 <VI1PR04MB5005EB37DD02F4E32D94336FE8432@VI1PR04MB5005.eurprd04.prod.outlook.com>
References: <20240131101916.437398-1-carlos.song@nxp.com>
 <20240131194207.GB12870@francesco-nb>
In-Reply-To: <20240131194207.GB12870@francesco-nb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR04MB5005:EE_|DBBPR04MB7946:EE_
x-ms-office365-filtering-correlation-id: c3d0ba7c-fd1b-40a3-9bf4-08dc22c9dc85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 IX4zvaUqtD6AdAYt3Wi3+7Ew7IqoiociwhzoQRZYPCK8LU1XfWdpzQLzuiHK+5CB1yYNFKYklAcoLsQV+lYSs7w06S5p2R7Q/YYHZYG5WNUxfZrnjcrHwbvsvzO77NueaT5l5n+3814hl3FpWiWkRgC1nT4wJgsmAgUskoWyoXMsH3nKUVAIRgdM+veFC43GvcmmgTnkV+FvbHzCcXq31CAUJSLPW4A9WjQRAkmOscAyjxqRSsxEtjIKQiE4S5NBRcY/87TAYdBctzQmJPl+HIEcHYq9WsAzxpbVs5vnzQGVWzikBy+vYy39jleFlUwW9KZKaey+yrcusW/XRh0nBhbH6pPfDWU56dQE5o9mMhbrAPP/9V//XXIN6JyyGbRnc93LFuNd0rsuvELVq1O6D0dbGKRnsjWwmLw65rY8vNw5EUj6rcv6M9j2ahYujeald19jNTIo53K6MwkueOXv4rEnW3KFkSM9nPWHVSrfhRSapCYBM//6H49L3q0ItXeVCJQmGdqfOonXNg9bkHNt9BWXSFF7gWlX2Qs8P/PB/50L/BOI7QKPn44C1piMMlT/TLn0nF/Ltc0XRIizyKFpL1tjQHW2wp6WMeRh2SxDgXVDPwZPAaYE/xN+esZn4uMFNC5315aT03vkQ1cT/rgo/03iDpscX+hDHVpJbKBgof8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(376002)(39860400002)(230922051799003)(230273577357003)(230173577357003)(1800799012)(451199024)(186009)(64100799003)(54906003)(7416002)(2906002)(44832011)(5660300002)(33656002)(86362001)(38100700002)(478600001)(38070700009)(53546011)(83380400001)(7696005)(41300700001)(6506007)(9686003)(26005)(122000001)(71200400001)(8936002)(8676002)(4326008)(52536014)(316002)(66446008)(64756008)(66476007)(6916009)(66946007)(76116006)(66556008)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dSpsm0wG5S2qWcCiSZYXUcHtwv4mICniGf6j/4oSzlZoXd2fLzjlJbtCap/e?=
 =?us-ascii?Q?gHh9W5w27Z0MvWJNEQICzLnP+rkiXFdixTfCbInOx1PlVeUH7x09/kBKq1vT?=
 =?us-ascii?Q?xUEsFIPIskkETc+iwoUTI0RuVE/2m/eqg2Rhk6wuYZn0untYi9IDbxEbrFoF?=
 =?us-ascii?Q?bNfiTyuky951s1jW84lUzpS0JrcEH04gPYDuiax/sF45vyEtBmLCze4w3jHQ?=
 =?us-ascii?Q?HUILrFzs0jYUGZGlmH7bC8zkEo25xc1yxC+RGrbwDSNKywyhUjhHiJiJkqf9?=
 =?us-ascii?Q?9rHgpIVUu8wv/dhcdHA3csdpOWqaKg8F3Ao2q43nfnKQsAeaLuezBswt3j4/?=
 =?us-ascii?Q?hcE8kFBYJEV3Hdbk9PKVlN+hF8LU9XfRhsGlMHh0KEpdvENeNOKWaUNYWm3l?=
 =?us-ascii?Q?OKlcMdq4ln5Idl7JgqKFotak1U0FYjtDjzYmHFwLpBqk53o5Q0amPOa1Qwtz?=
 =?us-ascii?Q?DEGlfNiOkQIm0mqngS/7joINjrEwjfBojUG8el3B5eNv7PjVep79nPTeSIYH?=
 =?us-ascii?Q?gyQ6ZWIbsFV1zA0vINEKJ6jtiBxmay79noOETJXKZSP0J/olWZxFr5LfipO4?=
 =?us-ascii?Q?tOxx+K251jTf95ikxrnSOMG9qEgn73bxM9zKb47Em1FbS5wZ6fpL82Xk3FE9?=
 =?us-ascii?Q?ImE9M936nIe9REZhzypc+eiKl1YEBLjbpsEUt3u8nBqu2kw6RW2EBiLVgWK9?=
 =?us-ascii?Q?S1WyuYAB/okhmWWrKaQ/UjeSg44dzVPfnIbYVVJC9KdQ2tlUWV2RJEQx/nHd?=
 =?us-ascii?Q?CQW6AMukDfpzDi4QRlJotjFwpAanqjaL4whn8wBbqDfFKaiaNrKg7c2RzZ7D?=
 =?us-ascii?Q?zRX2opQ8qEUQIL2UzmJop4FB0Ow9av8h8uX2RBnyxZ0fRfh8TzsO5TiZs4M8?=
 =?us-ascii?Q?OKjTgdh9gUloHe7jVSQlBUUIScIMz83TCYwkWo/dluP/SVZaFapM5GpizvQy?=
 =?us-ascii?Q?ZUZTY1L48qJt3T5iCNC+j/rq4+Yf58ER5YW9ImpnN8NKkU7KS8wJYvYOM0GS?=
 =?us-ascii?Q?nXvFWrxRD9acmhUrA0F5Kj4uAmfmOH+lNY9fw/SzzWyb0GeArSTgRqon+XOV?=
 =?us-ascii?Q?vX3xJT4g66oJRbIbG2fGUYAqxAvNDhjxW+IVJOU1hca23hPwRZD027Fuhws/?=
 =?us-ascii?Q?wxZRpMzeA4D2PsVh5GONRqx1PEIuU2EZByKYK3xfrgxmy6BZbpbeoXwghocP?=
 =?us-ascii?Q?u6/CZV3aEzV42NYx/WDjXWOBt81sW/kz3vZtAsqPMT4rgTs8k7dFj1LkUFG4?=
 =?us-ascii?Q?cFMDu3Ae6sflSQ2uNG3JhvgdBcabkzHuPJcR3RKMcrRfb//nDcwBsQ5W5tpe?=
 =?us-ascii?Q?vwBGSqeKTFtu+QgvJ7D00gYHFC6T7ASN9NDmzu2Ig6R6MulL9PVWyI6kGbG8?=
 =?us-ascii?Q?ep5pjroM/ADb8DU7nILcZP9/vxv/rcrRyx0LqXbinsJ6Nf5WrF7eSfq8QisP?=
 =?us-ascii?Q?DIVc8BIWKYFD8fyZPXRIGuzSM66EChYGOiQfjlJHfUJ95PF5/lQ36g1N7R+Q?=
 =?us-ascii?Q?CeaqwflCK1Qu5ntaqR5N9AUFSDcr8JALBib/mCz1ZUzkRH5iPzy6MOgWUNA0?=
 =?us-ascii?Q?DW94xeaqsBKkMl/PWsI=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d0ba7c-fd1b-40a3-9bf4-08dc22c9dc85
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2024 02:02:36.3164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zkS9vFM2SwxYn1bqZsiEGjShXZ6ALHhqDA81U9qFQyuXquw06qzqgJ5/W9Q/SNTfYVN1YnVr1tNL32CcSTrEhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7946



> -----Original Message-----
> From: Francesco Dolcini <francesco@dolcini.it>
> Sent: Thursday, February 1, 2024 3:42 AM
> To: Carlos Song <carlos.song@nxp.com>
> Cc: broonie@kernel.org; shawnguo@kernel.org; s.hauer@pengutronix.de;
> kernel@pengutronix.de; dl-linux-imx <linux-imx@nxp.com>; benjamin@bigler.=
one;
> stefanmoring@gmail.com; linux-spi@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: [EXT] Re: [PATCH v2] spi: imx: fix the burst length at DMA mode =
and CPU
> mode
>=20
> Caution: This is an external email. Please take care when clicking links =
or opening
> attachments. When in doubt, report the message using the 'Report this ema=
il'
> button
>=20
>=20
> On Wed, Jan 31, 2024 at 06:19:16PM +0800, carlos.song@nxp.com wrote:
> > From: Carlos Song <carlos.song@nxp.com>
> >
> > For DMA mode, the bus width of the DMA is equal to the size of data
> > word, so burst length should be configured as bits per word.
> >
> > For CPU mode, because of the spi transfer len is in byte, so burst
> > length should be configured as bits per byte * spi_imx->count.
> >
> > Signed-off-by: Carlos Song <carlos.song@nxp.com>
> > Reviewed-by: Clark Wang <xiaoning.wang@nxp.com>
> > Fixes: e9b220aeacf1 ("spi: spi-imx: correctly configure burst length
> > when using dma")
> > Fixes: 5f66db08cbd3 ("spi: imx: Take in account bits per word instead
> > of assuming 8-bits")
> > ---
> > Changes for V2:
> > - Removed BITS_PER_BYTE defination
> > ---
> >  drivers/spi/spi-imx.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c index
> > 546cdce525fc..0436e7a161ef 100644
> > --- a/drivers/spi/spi-imx.c
> > +++ b/drivers/spi/spi-imx.c
> > @@ -660,15 +660,14 @@ static int mx51_ecspi_prepare_transfer(struct
> spi_imx_data *spi_imx,
> >                       << MX51_ECSPI_CTRL_BL_OFFSET;
> >       else {
> >               if (spi_imx->usedma) {
> > -                     ctrl |=3D (spi_imx->bits_per_word *
> > -
> spi_imx_bytes_per_word(spi_imx->bits_per_word) - 1)
> > +                     ctrl |=3D (spi_imx->bits_per_word - 1)
> >                               << MX51_ECSPI_CTRL_BL_OFFSET;
> >               } else {
> >                       if (spi_imx->count >=3D
> MX51_ECSPI_CTRL_MAX_BURST)
> > -                             ctrl |=3D (MX51_ECSPI_CTRL_MAX_BURST - 1)
> > +                             ctrl |=3D (MX51_ECSPI_CTRL_MAX_BURST *
> > + BITS_PER_BYTE - 1)
> >                                               <<
> MX51_ECSPI_CTRL_BL_OFFSET;
> >                       else
> > -                             ctrl |=3D (spi_imx->count *
> spi_imx->bits_per_word - 1)
> > +                             ctrl |=3D (spi_imx->count * BITS_PER_BYTE
> > + - 1)
> >                                               <<
> MX51_ECSPI_CTRL_BL_OFFSET;
> >               }
> >       }
>=20
> Add #include <linux/bits.h> given you are using BITS_PER_BYTE
>=20
Hi,=20

Thanks for your advice!
I found that <linux/property.h> has been included in spi-imx.c driver.
And <linux/bits.h> has been included in <linux/property.h>.
So I didn't add the "#include <linux/bits.h>" on purpose.

BR
Carlos
> Francesco



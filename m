Return-Path: <linux-kernel+bounces-51547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F40848C5F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 10:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEFB62816D2
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 09:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6336A15AE0;
	Sun,  4 Feb 2024 09:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="G4wqJlkl"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2043.outbound.protection.outlook.com [40.107.105.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5BA14F64;
	Sun,  4 Feb 2024 09:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707037931; cv=fail; b=MLsKpxaqoX5ro7QcdlymPanh/DAJzcCFBr0bYOJATAfI7s6pjhlBPXrfY7VFBnW4Z40NNBha4EMzN9uW7njnL7pPQBPTs0r5rh6Kyx93zj4QrRnC0H+v+26TE9X9vSILSjnpK6vnLZoTy2zOz9plNkk3iD5AELZVnegesDRWiM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707037931; c=relaxed/simple;
	bh=m5Gc+rIxSwlS6yX/DYkueOi5AvKFyx2uquTqqKf9yno=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NO35kxYd3aod+1xlZmsg0LagMQwP1ucT5yvOZYa7RWhD5PeSFdqX6pyhgBM+rUpBVMW0iEZUA+k52oae550XhuQv86sdAIE3YBUedN1V51H5IMxRvjTNaIgoAgp8J/Z+MYPeU5z6wuUSf1agB9Oa4kdVQ/RzkNKxJ3sLBUMhvu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=G4wqJlkl; arc=fail smtp.client-ip=40.107.105.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WvwYWrvGFzL47G7y50Vxe3iCywSDpRV1DEYsAjEUSZxAa2mEuf07k5/t2WWOrjQxytPKGdhgqp85crFHT/GildlgzYjU1HTJUkh2qM8rhk0YVcZWA8a8feGBl7MG79cJtbngjOHljtEN0SLwQ0pgxslM5RajfWyEU+bjB0Hsl8qsorEy8/b+Gg+l+CCppc9u6xcNHWq9k1LJguwAKSTgbtY7GtmcC6KLhLh9HOxe0Hik3uRFV0+zMDIIsBOaVntq6+kwZL+LzOIYcGkFLlL1aXgq46+Fzd7HOmom1Ts64V+AbDyeA4FlpiGVpYzzfmzF2tVGvZ5I45823cJUDgY2Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uPkAttSSxuih5skb/4s+5rgV7mrNy4sXyJuTxfYmv4=;
 b=fCc516cdjYipvuD+RlhWQYwKa8gzPCtr0PdJtFTpt/ql17e4f6wquSdroSsYP43eBzWR9tn2xaFmkOpfHMegHBqiYTRQ+5y6yeDnJ8fKFZWn6Y1BrzWN/R4TPNYCy2n2Fk4+GAMX1xORgo3UhY1GOMqeR24J2S+vLKkm5/jrs9yz4/HlsLc9tym8pJ9uVD6gCl4T6RpyIFy24mmWX6HBwW/ILTXKKnXuwgM9yKMFkrbXPjeNgzCG2qP99dRChYRBD9XSRlRUOCclKhfCWMEryW+Qs/lVM6hZSHdYtc/EWp3iRb09K4ueXeK4Lom89Q/X1Fu9pDLua+/RVIjXsj5ZVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uPkAttSSxuih5skb/4s+5rgV7mrNy4sXyJuTxfYmv4=;
 b=G4wqJlklV67OWWa5d2wdyWdngtzMHqRAqVtU5NRqySLCWAgxI63VIb8jtqVCXqDBDU+rMvcqxKAxFY8mJwjRDfWA25eGpyhiLDB2e5I4bb9xbN15PC63I14KrfQV1LQnh4XHfWe0ey6jNjrHmX6O0kEKcmYnQOuvzsvU82F0hoY=
Received: from DB7PR04MB5003.eurprd04.prod.outlook.com (2603:10a6:10:1a::19)
 by AM9PR04MB8922.eurprd04.prod.outlook.com (2603:10a6:20b:409::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.33; Sun, 4 Feb
 2024 09:12:06 +0000
Received: from DB7PR04MB5003.eurprd04.prod.outlook.com
 ([fe80::6bca:3978:83bb:8a8a]) by DB7PR04MB5003.eurprd04.prod.outlook.com
 ([fe80::6bca:3978:83bb:8a8a%7]) with mapi id 15.20.7249.027; Sun, 4 Feb 2024
 09:12:05 +0000
From: Carlos Song <carlos.song@nxp.com>
To: Benjamin Bigler <benjamin@bigler.one>, "broonie@kernel.org"
	<broonie@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, dl-linux-imx <linux-imx@nxp.com>,
	"stefanmoring@gmail.com" <stefanmoring@gmail.com>
CC: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v4] spi: imx: fix the burst length at DMA mode
 and CPU mode
Thread-Topic: [EXT] Re: [PATCH v4] spi: imx: fix the burst length at DMA mode
 and CPU mode
Thread-Index: AQHaVPwvL7F21UIX+Eu+WXSq/tBgQbD17JiAgAOBU2A=
Date: Sun, 4 Feb 2024 09:12:05 +0000
Message-ID:
 <DB7PR04MB50035B2C0BFCD427F280ECEEE8402@DB7PR04MB5003.eurprd04.prod.outlook.com>
References: <20240201105451.507005-1-carlos.song@nxp.com>
 <c7326b50ce3fe2a660638e1eb2c11519ad82feee.camel@bigler.one>
In-Reply-To: <c7326b50ce3fe2a660638e1eb2c11519ad82feee.camel@bigler.one>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB5003:EE_|AM9PR04MB8922:EE_
x-ms-office365-filtering-correlation-id: f2cc70bf-3865-47bc-05a1-08dc25615ba1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 uRpTITFfFH/p62r+UoLXaPpjbPWA+ACxfDHeLfpdgtrkAK/7iMCqWjAkQhZkBfu3HiFL71F0kkDpksRH3cFhgE71FCEUPk5JcOv/ac8ScMfX2i05GaqGhkMN8rlTBv2H8ADJxoyckFZ2+1IzeKiXnQtrCb3Wx9JePFxDUu9yrD0SwL7WE9uq1cg13i0+gbyL9N7pSIraEPVg/HveI8nnd4AvoAv5qcuy+Bprw+JgPTmN2EiwtxkVG6C/2Y4A7VU8WOHOk7NCZqxs0Lneg1rOH/QAMCZoG7KsOfFTbfk27j5KdHLtduPLys0d/JpBjRhMbMvKEXXo584sJOpbNkgy3tth/wIHTGEDp6Jcxh71NUD1ntQGI8G5+a4EpYAG8G0kB8Y3O0lrK3BMzuJQ6Q/l9/2sQjE3DPbhnJejxHuY2P3mEyvZiouZvAxJIeGMmT3dXIibXPEvCQvDvREqpwW1zsMJLKCHs1DUC7wqIuVqI1CCqQZVPDYsGZ/umAZRc6sFr4r3dchhqH2m3WKDfeqU+aJiFrZjDZMWb7GZm93N+jV/q9VqTDgn1SPcWPGVM5MvwDlcCEg2LZiWXNK4YCws3JAye5RDq+baKVTvDoSw2g0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5003.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(366004)(346002)(396003)(230273577357003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(55016003)(33656002)(41300700001)(53546011)(9686003)(966005)(478600001)(45080400002)(38070700009)(86362001)(26005)(83380400001)(2906002)(5660300002)(66556008)(66946007)(316002)(66476007)(54906003)(66446008)(64756008)(71200400001)(6506007)(52536014)(44832011)(38100700002)(8936002)(122000001)(4326008)(8676002)(110136005)(76116006)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HGA5yXhdIWM9qMWVlagOKKfb1UWko15iyOdraicsQ39gXebRsaiAJgjbCaT8?=
 =?us-ascii?Q?abDnp9tIklT6AHaxtKB+78wZdu5+kUUBkVkx15HxzQ8mMWCZ1Y0WoqEORJgh?=
 =?us-ascii?Q?+M2B8RCjMD0KykPSogRfE1QzpHWc7grAyJqxDWq6HLML79PswPwmFndryhjr?=
 =?us-ascii?Q?IgQqaBOilx96pZx3vCsxyw9bmIZ12XgrlhKg1S6y7dNb5l/sacY32HykB91E?=
 =?us-ascii?Q?kDji9YS/g5WgBKRO1lVeKtAn8pKV4KEYGASMKjElD0Onh/Q2Euhdwc+AWru7?=
 =?us-ascii?Q?O+aKfIc73Aa0yvQVAd7v+0IKg5tEZu5ZTQbsbz+4OB/iAQ/iRgZNENNjIrMf?=
 =?us-ascii?Q?+FwwELo/MmZVuYgIlA+0k+CsGTMnd03l6DPfUK1z/OVd0j13u88UJsh4+GOh?=
 =?us-ascii?Q?0+RwBXisCdYqBhSGuqRlH0PK6bjzSiCDuXYuQBZg7Uw8/jS19kJ/+kZVXQU9?=
 =?us-ascii?Q?ZhPIsP02Az9wCU/6CvNHKxcLsfaP9DIaRksVmqbqIZKmWHSWiAuRRyji5h2m?=
 =?us-ascii?Q?icHBPQdv4WGLrFwMLQl+dl/J0TE89ThaHC1LlfllfLrtHQ8hhdwH5g6Qtuhc?=
 =?us-ascii?Q?FwWj4YJljsOyELC5s+HL7/pd12ftA//hE1MSvo7DgvovhFZtyHO4PjtmC5bW?=
 =?us-ascii?Q?PRd4JEZMkHwQo8xjQdAIXTqLpmbgTY0Ad7Cyc1j4oVDsfmiKt/E3HiL1gotJ?=
 =?us-ascii?Q?JIQE23JVBdxO3YBlTqGtORavF6YPFWzD6w57cuUE0qpGS8RVPbq4gfByXT55?=
 =?us-ascii?Q?5ve9k9S7ZCCTClobDdJ3nsWqT5WSa035m/upDE3CFKXQZnHwfB6T2MNfwxT9?=
 =?us-ascii?Q?o9oLXE3RXLyAm6ywMMBiUDwZehvUkTHAQm2YjVfIQeWCxh2FtwhNUS2MeC7w?=
 =?us-ascii?Q?BMFl5aczIhnbDX+xdXNW9eLvUQVoTMTbKLikP/o9GJT9NS09KnN0QHYW2Dst?=
 =?us-ascii?Q?5xY2Wc5w6BpYc8rafEmNaMAt050kkWNydsIPhl7dZgxQbzJFa5WY1e1SA5i8?=
 =?us-ascii?Q?8Uy2TsZpwSOIF1EghklDF57ikTIemg/W8462OdshA1DjVve+X4VpBVIAJ9ss?=
 =?us-ascii?Q?T5Rp3nGYUgyaKiNs1IZ7BQ+3WYbWM7+QqpJLo657BhwPss3dA9PYQhAgYG2S?=
 =?us-ascii?Q?gE8gANU8DPXxQ2wMktrtU8Opz+RssqsnaQrw+j+YFelBSw52so9Pyb+pUk7N?=
 =?us-ascii?Q?MfO+Xdr00SLyJLzAIVgpKeWAJ701hJIv+PXb1z+hG0aL4Ji4WZAdGMWL9bV7?=
 =?us-ascii?Q?azb1wcZ1mIkSztmDshIbw2bpgwSJyy/4NCwstIl/LbzbAKZttl9NiMd1ISRx?=
 =?us-ascii?Q?Tdk9Ti2xiamSES3Vto5Rdv9MlaGa4upkbGcXPCtgE4rJGdLxA3+Vn2YZg1eS?=
 =?us-ascii?Q?yW3pLyPF5EW87eURRmI9glgws02FerNrgbQ6tvyL4g0+85fZjBph/Mo9hc1l?=
 =?us-ascii?Q?6WEIreJsMX7Q3pwxEbQu9XiZCou4rLK9eWgKKrekJUNAOJq5Tm1VworJESwb?=
 =?us-ascii?Q?1XPvQooyBTKjdkmSzYqtqJ/rc3sQiKfHtCYCZMn2BNBHcoVRjgVkYFrkaSez?=
 =?us-ascii?Q?1EPhdXv1cY5+SwW2/o0=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5003.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2cc70bf-3865-47bc-05a1-08dc25615ba1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2024 09:12:05.8606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cN+f9gTk7pzu62K+rs/Dt9srQaoW4pfNPRr4aoZjSCsxvU8aEsS7AEsnLMVB+L6l2fXpz45adYZnWdZEBj38FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8922



> -----Original Message-----
> From: Benjamin Bigler <benjamin@bigler.one>
> Sent: Friday, February 2, 2024 4:15 AM
> To: Carlos Song <carlos.song@nxp.com>; broonie@kernel.org;
> shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
> dl-linux-imx <linux-imx@nxp.com>; stefanmoring@gmail.com
> Cc: linux-spi@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org
> Subject: [EXT] Re: [PATCH v4] spi: imx: fix the burst length at DMA mode =
and
> CPU mode
>
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report =
this
> email' button
>
>
> On Thu, 2024-02-01 at 18:54 +0800, carlos.song@nxp.com wrote:
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
> > Changes for V3:
> > - include <linux/bits.h>
> > Changes for V4:
> > - keep the includes sorted alphabetically.
> > ---
> >  drivers/spi/spi-imx.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c index
> > 546cdce525fc..f7990ac2c654 100644
> > --- a/drivers/spi/spi-imx.c
> > +++ b/drivers/spi/spi-imx.c
> > @@ -2,6 +2,7 @@
> >  // Copyright 2004-2007 Freescale Semiconductor, Inc. All Rights Reserv=
ed.
> >  // Copyright (C) 2008 Juergen Beisert
> >
> > +#include <linux/bits.h>
> >  #include <linux/clk.h>
> >  #include <linux/completion.h>
> >  #include <linux/delay.h>
> > @@ -660,15 +661,14 @@ static int mx51_ecspi_prepare_transfer(struct
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
> > -                             ctrl |=3D (MX51_ECSPI_CTRL_MAX_BURST -
> 1)
> > +                             ctrl |=3D (MX51_ECSPI_CTRL_MAX_BURST *
> > + BITS_PER_BYTE - 1)
> >                                               <<
> MX51_ECSPI_CTRL_BL_OFFSET;
> >                       else
> > -                             ctrl |=3D (spi_imx->count *
> spi_imx->bits_per_word - 1)
> > +                             ctrl |=3D (spi_imx->count * BITS_PER_BYTE
> > + - 1)


Hi,

Thank you! You re right. I have get the patch history that spi->bits_per_wo=
rd =3D 9 will
break the driver, this is a special case.

So burst length should be calculated by the number of words, instead of the=
 number of bytes, otherwise the transmission of these non-byte-aligned word=
 will break the driver.

the burst length can be set by:
spi_imx->count/DIV_ROUND_UP(spi_imx->bits_per_word, BITS_PER_BYTE) * spi_im=
x->bits_per_word.

I will set V5 later.
> I think that will not work for drivers which dont use bits_per_word=3D8.
> https://lore.ker/
> nel.org%2Fall%2F20230917164037.29284-1-stefanmoring%40gmail.com%2F&
> data=3D05%7C02%7Ccarlos.song%40nxp.com%7C6f52557285a34b97c6f508dc2
> 3626f51%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638424152
> 883113184%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> V2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3D2RerZ6
> 2kHdgiwqi5yxnDPLwWViplttHA2E05WFZmTuw%3D&reserved=3D0
> >                                               <<
> MX51_ECSPI_CTRL_BL_OFFSET;
> >               }
> >       }
>
> Best regards,
> Benjamin Bigler



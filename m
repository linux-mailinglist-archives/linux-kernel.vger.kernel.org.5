Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0740F7527BE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235083AbjGMPwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235066AbjGMPwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:52:17 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2110.outbound.protection.outlook.com [40.107.113.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B6926AE;
        Thu, 13 Jul 2023 08:52:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/4S4FLjAETV4pnLgvA3lKRuQwvDNa5BvJo895CCIdgq0u574bBFgNjjIrWjeApZutyQSWjR7sFnhHd3gfZM7cAj3L+xXQ6/ng1vDk8TdqmjEMKXhUiKi6QlK50hMhWfxWOG7XkYO5o66woanTP3lLfv0mlxZ4D18ciuijwMRWFaoXldMLjeCIJE4+S+tVI0CAJ5+N80zGJ/pu9vMD5kpHfD+0eu39vf/fDqJRryG5JWJTzekS3HlytEcvn6IWZHi6qyNuGTBx2DKrNeCd+Bqsnvcn7u4LqaF6AN8iD32A56iuEsJwbcnp1bx2CqEfo32IP6u3DnfiKlv881RcsmjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGI9i5ecs7LeLNRBrQL7Jyo+9PXb80pS9kJDAJ0GTrA=;
 b=bsb8M73JTCJ2JfyLszbKqMCeZIFHQk9fNkZvYSKLSWChIKNMhjvGqofhrsDhebYQ2tjN5ozuvMcvWlQg8NPHaTdVnjNPNWhJPK9ntf277KYMhAurOhpNHXNO7qR84n42r4Qwa/4ta+F0Y+l8SBPuJESII1IcODqncL0OeXa3JTZp4XEUkrKAbaLnk+UkDiQMM2+eVxo+0ouxN9fBXhFno/Q1LQ/bUTbHi3rrNFkRTB2noe+6bDkz1dEK9KbQsqAGgG+bOhTD1TVdbA7WL5V3MZq73GD36VW+2e8QbdRiziV/FpGOVG9lxOq43wnOjlxOFTEc7cEYo8fRk3zGjpcDTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGI9i5ecs7LeLNRBrQL7Jyo+9PXb80pS9kJDAJ0GTrA=;
 b=pLjiH8h1VnS8+Hu+FS79L4Lyj8MWsk0s12bpg1qmuBsEQOKVXVrrYTP3fLmqPtnqUU6D8uAHanoF5yG5bHZ8PketZ9aX2Q8MO2vMzzEOhOG9a5jmIrqLl0iriCLuIrTi4HWjJSYN3vD2lquLBOphdDlM8Vmtl87jSSNDUeuGSU0=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by TYBPR01MB5568.jpnprd01.prod.outlook.com (2603:1096:404:802d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.26; Thu, 13 Jul
 2023 15:52:11 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::c3b4:9b5b:7ec3:7ab7]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::c3b4:9b5b:7ec3:7ab7%5]) with mapi id 15.20.6588.022; Thu, 13 Jul 2023
 15:52:11 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>
CC:     Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: RE: [PATCH v2 3/5] spi: Add support for Renesas CSI
Thread-Topic: [PATCH v2 3/5] spi: Add support for Renesas CSI
Thread-Index: AQHZpP1zFctKcaLpHUujhHkndUbaba+rEJGAgAzi07A=
Date:   Thu, 13 Jul 2023 15:52:11 +0000
Message-ID: <TYWPR01MB8775144ADA4B4FF2CB9B940BC237A@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20230622113341.657842-1-fabrizio.castro.jz@renesas.com>
 <20230622113341.657842-4-fabrizio.castro.jz@renesas.com>
 <ZKVI4XPbPXfzQa9J@surfacebook>
In-Reply-To: <ZKVI4XPbPXfzQa9J@surfacebook>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|TYBPR01MB5568:EE_
x-ms-office365-filtering-correlation-id: 49399ced-22d5-49b6-8c17-08db83b91ef7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FPdu2oHQ84tlDpZZZ72QYl8g/jW6fFvJA7CrsxhZkmtNxXLXs847KFiH1IDnFlOPZxJwu3LcxuV+04P8lSs7xL61zXLf5Mh9O4UAiaCWP1LETY6tNzMiea/OXShSqNb2pqryQ9OMhF3KlGXFOcTrYnXcUTCK0x4SQjuEBXxWiX6VwJbC8LFhEIkoG8bi/J5bgQWcsW4XWXJDhcafRTGI+T3aOTyMr0Ufy7xYlZTDoIXJKkf0rNE8oqh6AI/pMs1/xvwv5moGhjniwLwisO6xqknKgtouCMD6cjRqPSJR6QKOGo6JzeOAQDHA5LDfQQUmHoOniK0BARBBGwByOz3LnG2e5v6qqb8iIEidJdkn0RzASErf7+dc3e1+r/8RJCAkxj7u38Bs7D+fW10JxeVBo4CMN7nfMzExtC1/zL7wZumRSHS6xs0uJje1CCyR7BsbVcEukKpY2zeGTkSZBKywlJdXe6MXb3mzOuuxN2cxzIEtOocynmrfGl5lhWYAWZWDo1PgpIPwJJ8xUeQWUXd/y+NGxpWZZcH+KUijazc75b+VY0QLQDG4hNgp6uuGRZGStRdcjyvk5WKgAmn/SnLtCJ9xZoYFIWE5WKcsMZVGh76Q33s0HxUjN9UD84nDZsPy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199021)(2906002)(55016003)(38100700002)(122000001)(9686003)(83380400001)(186003)(107886003)(26005)(86362001)(33656002)(6506007)(5660300002)(52536014)(38070700005)(8676002)(8936002)(54906003)(478600001)(7696005)(71200400001)(41300700001)(316002)(66946007)(76116006)(66556008)(66476007)(64756008)(66446008)(4326008)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?v+9D5zSxdOP5qCE2AvJ4ILRQX28l1xTa6ZS91cNbQApRsOokpbFEni3J9AVD?=
 =?us-ascii?Q?0NxLF8jFTjFMuy5gx8BW961oZeRwoML868fd2RC9XghjWETNHd0rB1j0Uqn6?=
 =?us-ascii?Q?G5Wn5mVtiL02Zz5Nqe3NoGGZZWgVDH3eTlAfshP5sNWYEYbOKvA19e2c7Lj3?=
 =?us-ascii?Q?1DcrrbtRD+f6mCqxJnhK99S14n6ZMyC2Ka9nIWPE3twmA5Vqr8sn1LWLxF8W?=
 =?us-ascii?Q?AjwhyMKJeAIZ1SvArQDSAnJAvh4fIA98WloKVgMMcRLZ3OUrl2Aga143qLjO?=
 =?us-ascii?Q?22DK1xtdFDWKg5dJ6zXIn4fMHu/5C+ItA6fZ/VwYBUY69ca323GjcqJIwpAU?=
 =?us-ascii?Q?/lyacuqJINVpnG7oRbtWsfi4P15Qp7r/neMG+IgwfilXT2PDzvgAHDncZfI7?=
 =?us-ascii?Q?D9VhNgBalQDL8/QSCoGKS+PGBwKg4HpHz0VOmlgH0AOGPHiKMUNzPjPBbhCj?=
 =?us-ascii?Q?OPrfTlrL7oF+rjDLIr60RRzGEj10SMt+MvrL8bL4Ek34Uc22DjQCgOSguuV2?=
 =?us-ascii?Q?5xXCEwRfpC4htbkHfZbt8Ti7tMGaNj6d1+xU0mT3Bm7rdA4xfE1xbd3frDMO?=
 =?us-ascii?Q?DhRAH5JoR91rNgKvfp14jd8vYhbPu4offRXWtsrZkRsDeycFsDSdykSXV92l?=
 =?us-ascii?Q?GDglB8q6RZYAPwhkkK2OdHFQ+1U1qThi5NZyoN75q9U9T/Oyg9Z98uMXdPVu?=
 =?us-ascii?Q?Emf2Edhk4wDwTlRXEjwFFGwuRO4S4yiI6yq/SrUaVrN4RYxhqdBVsfA/DRc6?=
 =?us-ascii?Q?cexehJHJRX2FLbMk/mCTi/Qs49ptyD9pwg/RGJWmeVr578XQ9nSxNJ8FOGri?=
 =?us-ascii?Q?LWzKhPjczS7Ru0uz6bRJX4ASCLqOcYorHZqzESZh8vyuxLHPfl8dglCBfG1P?=
 =?us-ascii?Q?Jw9VyrTh0aZtH9bRjpNrF1FMxZq0EnvKWteZLAlDg3KVKsKjtWLOepp1azvl?=
 =?us-ascii?Q?Txr9OdFF5pYjT7f9GfszR9Ciy7F5YJaliLtVSHFudZU6cTnmIyM6AxrFKubk?=
 =?us-ascii?Q?/BRsf976xZAW8ocgiQRrALHjfa0kh+5UzpN2KKC/Au3msEpTNa8t/p2uibpY?=
 =?us-ascii?Q?oHGs9ocj4hiKswXjbfL5ZMaKeAEPY49jnbBHvc/5ZckN+xmeXbV/tmXrdT5k?=
 =?us-ascii?Q?QT+y0fu+Oc5Dm3AjwpSKJ2jSvipytn9AtecMjvWeqvnZBuTbxZmV1Z+Tsugz?=
 =?us-ascii?Q?qSNkD+xVOhtuz47jo1XD34+5zv14OImJSzpREX9J4IYqoQAUxLXJnN5k+GNN?=
 =?us-ascii?Q?vBqXV40gZd6b0HZXgPlghbfz2GnToyq33P6rvHiBP3bfqonaTdHcz2uchrhf?=
 =?us-ascii?Q?qTfK4RqSfu375KHmgmBdvnHjYwIt2Rc0zPkeQnWOMa2/YX4OVttkrQnMWFoK?=
 =?us-ascii?Q?uO1hfvHRwb80IaIc1igybrpvxK00EwrNJ7DDYbp+3ZxG0RXLn6bJqtKfZz0C?=
 =?us-ascii?Q?dvD/CcqHCAOw40D4lNv4++Xv9ac+ndCJYwUtA01xXUvkbudLESvQMeiVUOlY?=
 =?us-ascii?Q?RtHJhr4wVEv+q19ziLwcOwu4AoECV1N2u9E9qMvUmTabcbF0zP/ArBwlHdb5?=
 =?us-ascii?Q?yjzrz1Jy1WrbjFBgiqz5L9YeJVy+HMh40ADzKkNts3QrCfoGKWuLI4tfYIbs?=
 =?us-ascii?Q?tg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49399ced-22d5-49b6-8c17-08db83b91ef7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 15:52:11.4247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /i5V2vzrQQLpIkdCE9nLmFjT8o7xAc6gYfwj73JIYtq5RsbthQydpafxT8P/zfN0KX1lZlZTq5Fa2Tko14tfBcfda3x8Gsh12t/IciSMTOQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5568
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Thanks for your feedback!

> From: andy.shevchenko@gmail.com <andy.shevchenko@gmail.com>
> Subject: Re: [PATCH v2 3/5] spi: Add support for Renesas CSI
>=20
> Thu, Jun 22, 2023 at 12:33:39PM +0100, Fabrizio Castro kirjoitti:
> > The RZ/V2M SoC comes with the Clocked Serial Interface (CSI)
> > IP, which is a master/slave SPI controller.
> >
> > This commit adds a driver to support CSI master mode.
>=20
> Submitting Patches recommends to use imperative voice.
>=20
> ...
>=20
> + bits.h

Okay

>=20
> > +#include <linux/clk.h>
> > +#include <linux/count_zeros.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/reset.h>
> > +#include <linux/spi/spi.h>
>=20
> ...
>=20
> > +#define CSI_CKS_MAX		0x3FFF
>=20
> If it's limited by number of bits, i would explicitly use that informatio=
n
> as
> (BIT(14) - 1).

That value represents the register setting for the maximum clock divider.
The maximum divider and corresponding register setting are plainly stated
in the HW User Manual, therefore I would like to use either (plain) value
to make it easier for the reader.

I think perhaps the below makes this clearer:
#define CSI_CKS_MAX_DIV_RATIO   32766
#define CSI_CKS_MAX             (CSI_CKS_MAX_DIV_RATIO >> 1)


>=20
> ...
>=20
> > +#define CSI_MAX_SPI_SCKO	8000000
>=20
> Units?
> Also, HZ_PER_MHZ?

I'll replace that with:
#define CSI_MAX_SPI_SCKO        (8 * HZ_PER_MHZ)

>=20
> ...
>=20
> > +static const unsigned char x_trg[] =3D {
> > +	0, 1, 1, 2, 2, 2, 2, 3,
> > +	3, 3, 3, 3, 3, 3, 3, 4,
> > +	4, 4, 4, 4, 4, 4, 4, 4,
> > +	4, 4, 4, 4, 4, 4, 4, 5
> > +};
> > +
> > +static const unsigned char x_trg_words[] =3D {
> > +	1,  2,  2,  4,  4,  4,  4,  8,
> > +	8,  8,  8,  8,  8,  8,  8,  16,
> > +	16, 16, 16, 16, 16, 16, 16, 16,
> > +	16, 16, 16, 16, 16, 16, 16, 32
> > +};
>=20
> Why do you need tables? At the first glance these values can be easily
> calculated from indexes.

I think I am going to replace those tables with the below (and of course
adjust the callers accordingly since the argument is not an index anymore):

static inline unsigned int x_trg(unsigned int words)
{
	return fls(words) - 1;
}

static inline unsigned int x_trg_words(unsigned int words)
{
	return 1 << x_trg(words);
}

>=20
> ...
>=20
> > +	rzv2m_csi_reg_write_bit(csi, CSI_CNT, CSI_CNT_CSIRST, assert);
> > +
> > +	if (assert) {
>=20
> 	If (!assert)
> 		return 0;

Can do

>=20
> > +		return readl_poll_timeout(csi->base + CSI_MODE, reg,
> > +					  !(reg & CSI_MODE_CSOT), 0,
> > +					  CSI_EN_DIS_TIMEOUT_US);
> > +	}
> > +
> > +	return 0;
>=20
> ...
>=20
> > +	rzv2m_csi_reg_write_bit(csi, CSI_MODE, CSI_MODE_CSIE, enable);
> > +
> > +	if (!enable && wait)
>=20
> In the similar way.

Okay

>=20
> > +		return readl_poll_timeout(csi->base + CSI_MODE, reg,
> > +					  !(reg & CSI_MODE_CSOT), 0,
> > +					  CSI_EN_DIS_TIMEOUT_US);
> > +
> > +	return 0;
>=20
> ...
>=20
> > +		for (i =3D 0; i < csi->words_to_transfer; i++)
> > +			writel(buf[i], csi->base + CSI_OFIFO);
>=20
> writesl()?

I think you mean writesw and writesb.
They should simplify things a bit, I'll go for them.

>=20
> ...
>=20
> > +		for (i =3D 0; i < csi->words_to_transfer; i++)
> > +			buf[i] =3D (u16)readl(csi->base + CSI_IFIFO);
>=20
> readsl()?

I'll use readsw

>=20
> ...
>=20
> > +		for (i =3D 0; i < csi->words_to_transfer; i++)
> > +			buf[i] =3D (u8)readl(csi->base + CSI_IFIFO);
>=20
> readsl()?

I'll use readsb

>=20
> ...
>=20
> Yes, in read cases you would need carefully handle the buffer data.
> Or drop the idea if it looks too monsterous.

It should be okay in my case. Thanks.

>=20
> ...
>=20
> > +	ret =3D rzv2m_csi_wait_for_interrupt(csi, CSI_INT_TREND,
> CSI_CNT_TREND_E);
>=20
> > +
>=20
> Unneeded blank line.

Will take out

>=20
> > +	if (ret =3D=3D -ETIMEDOUT)
> > +		csi->errors |=3D TX_TIMEOUT_ERROR;
>=20
> ...
>=20
> > +	struct rzv2m_csi_priv *csi =3D (struct rzv2m_csi_priv *)data;
>=20
> From/to void * does not need an explicit casting in C.

Of course.

>=20
> ...
>=20
> > +	/* Setup clock polarity and phase timing */
> > +	rzv2m_csi_reg_write_bit(csi, CSI_CLKSEL, CSI_CLKSEL_CKP,
> > +				!(spi->mode & SPI_CPOL));
> > +	rzv2m_csi_reg_write_bit(csi, CSI_CLKSEL, CSI_CLKSEL_DAP,
> > +				!(spi->mode & SPI_CPHA));
>=20
> Is it a must to do in a sequential writes?

It's not a must, I'll combine those 2 statements into 1.

>=20
> ...
>=20
> > +	bool tx_completed =3D csi->txbuf ? false : true;
> > +	bool rx_completed =3D csi->rxbuf ? false : true;
>=20
> Ternaries are redundant in the above.

They are also horrible, the below should do:
bool tx_completed =3D !csi->txbuf;
bool rx_completed =3D !csi->rxbuf;

>=20
> ...
>=20
> > +	controller->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST;
>=20
> SPI_MODE_X_MASK

This statement sets the mode_bits. Using a macro meant to be used as a
mask in this context is something I would want to avoid if possible.

>=20
> ...
>=20
> > +	controller->dev.of_node =3D pdev->dev.of_node;
>=20
> device_set_node();

Will change.

I'll send an enhancement patch shortly to reflect your suggestions and
also Geert's.

Thanks for your help!

Cheers,
Fab

>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20


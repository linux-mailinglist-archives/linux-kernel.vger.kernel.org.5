Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E8B7D5051
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 14:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbjJXMxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 08:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbjJXMxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 08:53:02 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DE490;
        Tue, 24 Oct 2023 05:52:59 -0700 (PDT)
Received: from pendragon.ideasonboard.com (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5CC0CAE;
        Tue, 24 Oct 2023 14:52:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1698151966;
        bh=Z8lGk3CLn172c1awVm68bNMBIr+yFrYRyprU4D+J9gM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=mha+FND4nmKh74daFUIU4wshVjn7alJPLszWBvaDkp4xQC34SQrBomYQhzWrHmy74
         yn+nuqCufcnyD4I5owfKfuc5azIlW9VY11zWut+RARP/Nr3YEVgbl+n+K9WLHc4AsM
         3c4aRSL6191tRTOdE32ul5XYlrKXiusUIHIbyQ94=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <9117e551a4a4dd0e94a1395817d89cb18ac11b24.camel@apitzsch.eu>
References: <20231023-imx214-v1-0-b33f1bbd1fcf@apitzsch.eu> <20231023-imx214-v1-1-b33f1bbd1fcf@apitzsch.eu> <169810104910.2245571.16606813523946813634@ping.linuxembedded.co.uk> <9117e551a4a4dd0e94a1395817d89cb18ac11b24.camel@apitzsch.eu>
Subject: Re: [PATCH 1/4] media: i2c: imx214: Explain some magic numbers
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
To:     =?utf-8?q?Andr=C3=A9?= Apitzsch <git@apitzsch.eu>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ricardo Ribalda <ribalda@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Date:   Tue, 24 Oct 2023 13:52:54 +0100
Message-ID: <169815197462.630990.3330310524563366908@ping.linuxembedded.co.uk>
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andr=C3=A9 Apitzsch (2023-10-24 08:30:01)
> Am Montag, dem 23.10.2023 um 23:44 +0100 schrieb Kieran Bingham:
> > Quoting Andr=C3=A9 Apitzsch (2023-10-23 22:47:50)
> > > Code refinement, no functional changes.
> > >=20
> > > Signed-off-by: Andr=C3=A9 Apitzsch <git@apitzsch.eu>
> > > ---
> > > =C2=A0drivers/media/i2c/imx214.c | 24 +++++++++++++++++++-----
> > > =C2=A01 file changed, 19 insertions(+), 5 deletions(-)
> > >=20
> > > diff --git a/drivers/media/i2c/imx214.c
> > > b/drivers/media/i2c/imx214.c
> > > index 4f77ea02cc27..9218c149d4c8 100644
> > > --- a/drivers/media/i2c/imx214.c
> > > +++ b/drivers/media/i2c/imx214.c
> > > @@ -19,12 +19,23 @@
> > > =C2=A0#include <media/v4l2-fwnode.h>
> > > =C2=A0#include <media/v4l2-subdev.h>
> > > =C2=A0
> > > +#define IMX214_REG_MODE_SELECT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0x0100
> > > +#define IMX214_MODE_STANDBY=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x00
> > > +#define IMX214_MODE_STREAMING=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0x01
> > > +
> > > =C2=A0#define IMX214_DEFAULT_CLK_FREQ=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 24000000
> > > =C2=A0#define IMX214_DEFAULT_LINK_FREQ 480000000
> > > =C2=A0#define IMX214_DEFAULT_PIXEL_RATE ((IMX214_DEFAULT_LINK_FREQ *
> > > 8LL) / 10)
> > > =C2=A0#define IMX214_FPS 30
> > > =C2=A0#define IMX214_MBUS_CODE MEDIA_BUS_FMT_SRGGB10_1X10
> > > =C2=A0
> > > +/* Exposure control */
> > > +#define IMX214_REG_EXPOSURE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0202
> > > +#define IMX214_EXPOSURE_MIN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
> > > +#define IMX214_EXPOSURE_MAX=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 3184
> > > +#define IMX214_EXPOSURE_STEP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 1
> > > +#define IMX214_EXPOSURE_DEFAULT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0c70
> >=20
> > I like this change, and I see that 0x0c70 was directly moved here
> > from
> > the code below. But could we replace 0xc70 here with 3184 please so
> > that
> > it's /far/ clearer that the Exposure Default =3D=3D Exposure Max which =
is
> > otherwise hidden?
> >=20
> Hi Kieran,
>=20
> I can do that. But I propose to replace 3184 with 0x0c70 instead.
> Because that matches the entries used in the reg_8 lists
> mode_4096x2304[] and mode_1920x1080[].
>=20
>         {0x0202, 0x0C},
>         {0x0203, 0x70},=20
>=20
> What do you think?

I think exposure values are easier to read as integers than hex values.

This is the 'Coarse Integration Time' register with a unit of 'lines'.

If you have lots of time, or wish to delve deeper - we could talk about
splitting out those register tables to use CCI and/or more readable
functions ;-)

Do you have the datasheet for this sensor - or are you just working from
the information within this driver?

What device are you using to test this driver?

--
Kieran

> Regards,
> Andr=C3=A9

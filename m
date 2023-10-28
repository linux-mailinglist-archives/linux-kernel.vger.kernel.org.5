Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801507DA71C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 15:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjJ1NID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 09:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1NIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 09:08:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE1CD9;
        Sat, 28 Oct 2023 06:08:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E358C433C8;
        Sat, 28 Oct 2023 13:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698498480;
        bh=KBUyRH5iBmgvQ8CyEdi22IBAbVqBkZuq2Xzf3BqGzuc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HzrbRbMoFLkEWfi3MJrBk2GRygax4NBUflJZmZqBQVtwaGWVZVE8tkjSW6OE4aACE
         Fc/06QC7VBWNUxPTExy+GcwQ9NUw7fM0sQ4N1SfJzt/Qm0vVom771/mrqB4mKrkRXD
         hWbNRL3GqAmJmx48ebLQ0DJ2y5qTtLxtG2SYx7wbanoFKwo54eAbyYPSi+SVuS/0FF
         OjkirPgR0c6nSCmT1NOUIAGnBsFXVKNJ1uaKR/TRXCv+nkKkePnaMpxgf+QPhrzN0r
         NzObDvZVv5WzBsxrYC2VVDz8lVpj+zGbRgqSpzT/ZqV8f1Frh3N7vRUyEW3w8+qtX9
         Qn+1/8UsGbwUg==
Date:   Sat, 28 Oct 2023 14:07:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Phil Elwell <phil@raspberrypi.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 4/5] iio: pressure: bmp280: Allow multiple chips id
 per family of devices
Message-ID: <20231028140717.7a1b4c6d@jic23-huawei>
In-Reply-To: <2a5ccee0ce33b2918e8b32b25ff1cd7221d01892.camel@gmail.com>
References: <cover.1697994521.git.ang.iglesiasg@gmail.com>
        <eade22d11e9de4405ea19fdaa5a8249143ae94df.1697994521.git.ang.iglesiasg@gmail.com>
        <ZTZYNjq/1X95ijXh@smile.fi.intel.com>
        <20231027144234.0ad6c7b6@jic23-huawei>
        <20231027144625.36cc694c@jic23-huawei>
        <2a5ccee0ce33b2918e8b32b25ff1cd7221d01892.camel@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Oct 2023 13:23:46 +0200
Angel Iglesias <ang.iglesiasg@gmail.com> wrote:

> On Fri, 2023-10-27 at 14:46 +0100, Jonathan Cameron wrote:
> > On Fri, 27 Oct 2023 14:42:34 +0100
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >  =20
> > > On Mon, 23 Oct 2023 14:25:42 +0300
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > >  =20
> > > > On Sun, Oct 22, 2023 at 07:22:20PM +0200, Angel Iglesias wrote:=C2=
=A0  =20
> > > > > Improve device detection in certain chip families known to have v=
arious
> > > > > chip ids.
> > > > > When no known ids match, gives a warning but follows along what d=
evice
> > > > > said on the firmware and tries to configure it.=C2=A0=C2=A0=C2=A0=
  =20
> > > >=20
> > > > I would rephrase it a bit:
> > > >=20
> > > > "Improve device detection in certain chip families known to have
> > > > various chip IDs. When no ID matches, give a warning but follow
> > > > along what device said on the firmware side and try to configure
> > > > it."
> > > >=20
> > > > ...
> > > > =C2=A0  =20
> > > > > +	for (i =3D 0; i < data->chip_info->num_chip_id; i++) {
> > > > > +		if (chip_id =3D=3D data->chip_info->chip_id[i]) {
> > > > > +			dev_info(dev, "0x%x is a known chip id for
> > > > > %s\n", chip_id, name);
> > > > > +			break;
> > > > > +		}=C2=A0=C2=A0=C2=A0  =20
> > > > =C2=A0  =20
> > > > > +		dev_warn(dev, "chip id 0x%x does not match known id
> > > > > 0x%x\n",
> > > > > +			 chip_id, data->chip_info->chip_id[i]);=C2=A0=C2=A0=C2=A0  =20
> > > >=20
> > > > If the matching ID is not the first one, user will have an unneeded
> > > > warning here.=C2=A0  =20
> > >=20
> > > Could be a dev_dbg() but I'd just drop it entirely.
> > >  =20
> > Given that was all that came up, I've hopefully saved us all time by
> > dropping the bring and changing the patch description as Andy suggested.
> >=20
> > With that done, applied.
> >=20
> > Jonathan
> >  =20
>=20
> Sorry for the extra work Jonathan. Next time I'll be quicker checking the=
 inbox.
Don't worry about it!  It's a bit random when I get to IIO stuff these days
so when I do, I like to clear as much as possible out in one go.

J=20

>=20
> Thanks for your time guys.
>=20
> Angel
>=20
> > >  =20
> > > > =C2=A0  =20
> > > > > =C2=A0	}=C2=A0=C2=A0=C2=A0  =20
> > > > =C2=A0  =20
> > >  =20
> >  =20
>=20


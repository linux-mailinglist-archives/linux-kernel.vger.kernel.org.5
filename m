Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B60807640
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 18:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378536AbjLFRP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 12:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235260AbjLFRP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 12:15:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09221D40
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 09:15:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA0DC433C7;
        Wed,  6 Dec 2023 17:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701882931;
        bh=TWZ1PvW7WsY9XY5jYN+qaVdqjJkgESCw9MviqH1sYBE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hGV6V4mJFQX2x3YGSlq+x1KYAj6S4+h6e5vo7bjpEbX1F6AlgsWjSm+LJxZcm37G+
         kLrI5g7wRdBb02GY0lOAuxnW+OsWrTar5jDylsFMTvKBRjlLLYMI9+SdWq1wz6B/HA
         zT1S/kNthQtmnvqPz/3TE/mrlT+vnat8ZTOuQCJ8OOyCFt/OzdlWxCLXnIvfGnB/nu
         T4w1gxDa++qDnAPQ9gIInnmLSDvQp382+3rMoSrxeaTeP3e+jiQ1byPsKebBINY8+y
         HXRIoU0V9IkVIAUhxhgEvdaFOfqMeVRIchZeMgjQ4QHwu2MCUx92ETbG4V4Hx0fSz8
         s/yP5yW/w56kw==
Date:   Wed, 6 Dec 2023 17:15:21 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc:     Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>,
        nuno.sa@analog.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Olivier MOYSAN <olivier.moysan@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 03/12] iio: add the IIO backend framework
Message-ID: <20231206171521.4133569a@jic23-huawei>
In-Reply-To: <bba767835e775909c6b8a3334cceeb419afef4ca.camel@gmail.com>
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
        <20231121-dev-iio-backend-v1-3-6a3d542eba35@analog.com>
        <20231204153855.71c9926f@jic23-huawei>
        <bba767835e775909c6b8a3334cceeb419afef4ca.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Dec 2023 13:05:53 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, 2023-12-04 at 15:38 +0000, Jonathan Cameron wrote:
> > On Tue, 21 Nov 2023 11:20:16 +0100
> > Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
> >  =20
> > > From: Nuno Sa <nuno.sa@analog.com>
> > >=20
> > > This is a Framework to handle complex IIO aggregate devices.
> > >=20
> > > The typical architecture is to have one device as the frontend device=
 which
> > > can be "linked" against one or multiple backend devices. All the IIO =
and
> > > userspace interface is expected to be registers/managed by the fronte=
nd
> > > device which will callback into the backends when needed (to get/set
> > > some configuration that it does not directly control). =20
> >=20
> > As this is first place backend / frontend terminology used (I think), m=
ake
> > sure to give an example so people understand what sorts of IP / devices=
 thes
> > might be.
> >  =20
> > >=20
> > > The basic framework interface is pretty simple:
> > > =C2=A0- Backends should register themselves with @devm_iio_backend_re=
gister()
> > > =C2=A0- Frontend devices should get backends with @devm_iio_backend_g=
et()
> > >=20
> > > Signed-off-by: Nuno Sa <nuno.sa@analog.com> =20
> >=20
> > Looks good to me in general.=C2=A0 I'll need to have a really close rea=
d though
> > before we merge this as there may be sticky corners! (hopefully not)
> >=20
> >=20
> > ...
> >  =20
> > > +static LIST_HEAD(iio_back_list);
> > > +static DEFINE_MUTEX(iio_back_lock);
> > > +
> > > +/*
> > > + * Helper macros to properly call backend ops. The main point for th=
ese macros
> > > + * is to properly lock the backend mutex on every call plus checking=
 if the
> > > + * backend device is still around (by looking at the *ops pointer). =
=20
> > If just checking if it is around rather thank looking for a bug, then
> > I'd suggest a lighter choice than WARN_ON_x=20
> >  =20
>=20
> Arguably, in here, removing a backend is the user doing something serious=
ly wrong so
> I see the splat with good eyes :D.
>=20
> That said, I'm fine in turning this into a pr_warn_once()...
>=20
> > Btw, there were some interesting discussions on lifetimes and consumer =
/ provider
> > models at plumbers. I think https://www.youtube.com/watch?v=3DbHaMMnIH6=
AM=C2=A0will be
> > the video.=C2=A0=C2=A0 Suggested the approach of not refcounting but in=
stead allowing for
> > a deliberate removal of access similar to your check on ops here (and t=
he one
> > we do in core IIO for similar purposes).=C2=A0 Sounded interesting but =
I've not
> > explored what it would really mean to switch to that model yet. =20
>=20
> Yes, interesting talk indeed. I have been following this issue for some t=
ime now.
> That's why I tried to be careful in the backend stuff (so we don't explod=
e if a
> backend is gone) even though is a much more simpler approach. But the tal=
k mentions
> three solutions and we kind of have both option C (the pointer stuff) and=
 option A
> (consumer removed on provicer unbind)
> in here. option A is being given through device links with the AUTO_REMOV=
E_CONSUMER
> flag.
>=20
> And the talk actually left me thinking on that (as it's discussed in ther=
e. In our
> simpler case (ADI ones), it does make sense to remove the consumer if the=
 provider is
> not there. But if we think in more advanced usecases (or maybe already in=
 the STM
> usecase) where we have a backend per data path. Does it make sense to com=
pletely
> "kill" the consumer if we remove one of the data paths? Starting to think=
 it
> doesn't...

There is a reasonably argument that partial tear down isn't a common case. =
So
may not be worth worrying about.

J
>=20
> - Nuno S=C3=A1
>=20


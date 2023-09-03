Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2ED790B7D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 12:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236481AbjICKqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 06:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235800AbjICKqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 06:46:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33617120;
        Sun,  3 Sep 2023 03:46:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76864B80B74;
        Sun,  3 Sep 2023 10:46:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 501B8C433C8;
        Sun,  3 Sep 2023 10:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693737991;
        bh=fHQHtVJU95tWVAt5a2wKC1eHKHzE83lNKBDz+6XcItw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XyjSGL5QrYBvk4SaMUkYXmRvBaPBe96WLfKrnbhgm/9xSQvBJKr2wqOXBnNEuyZ7f
         y7cG3RtKZWEnuh0AOqID4q2GpMEbo6rFjA5otDnNYQW5LXFCICkjTzsIy/yDBXFppw
         s1eVSd4EzsujDU99/1bhB/OXq/Pdky0CBw0lBNaOTkxGDAix5zHkfm4U+3w2/g3Znc
         Ai/nRdnYKEwTAbZa58h/TaHR256ds+fEnM2Jp+Tw9ndYVTfw4uz1Gb5StEwl9K1GBt
         cLxD+3nRPvNFAT29PzGiledmcM2TN5PLMYbTmh3poQuNMtJWfS1DBJpS3/s+hUBKBu
         AeztbBn9Ivurg==
Date:   Sun, 3 Sep 2023 11:46:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc:     Olivier MOYSAN <olivier.moysan@foss.st.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Fabrice GASNIER <fabrice.gasnier@st.com>
Subject: Re: [RFC v2 01/11] iio: introduce iio backend device
Message-ID: <20230903114658.24eed6bd@jic23-huawei>
In-Reply-To: <8b63cad8749ceca31d2f50ee36925ce18523620f.camel@gmail.com>
References: <20230727150324.1157933-1-olivier.moysan@foss.st.com>
        <20230727150324.1157933-2-olivier.moysan@foss.st.com>
        <7ec3fe6183409c218b97a3359e951731b47fe16d.camel@gmail.com>
        <095f9c64-bcac-e838-ba69-b5df623c444f@foss.st.com>
        <8b63cad8749ceca31d2f50ee36925ce18523620f.camel@gmail.com>
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

On Fri, 01 Sep 2023 10:01:19 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> Hi Olivier,
>=20
> On Thu, 2023-08-31 at 18:14 +0200, Olivier MOYSAN wrote:
> > Hi Nuno,
> >=20
> > On 7/28/23 10:42, Nuno S=C3=A1 wrote: =20
> > > Hi Olivier,
> > >=20
> > > On Thu, 2023-07-27 at 17:03 +0200, Olivier Moysan wrote: =20
> > > > Add a new device type in IIO framework.
> > > > This backend device does not compute channel attributes and does no=
t expose
> > > > them through sysfs, as done typically in iio-rescale frontend devic=
e.
> > > > Instead, it allows to report information applying to channel
> > > > attributes through callbacks. These backend devices can be cascaded
> > > > to represent chained components.
> > > > An IIO device configured as a consumer of a backend device can comp=
ute
> > > > the channel attributes of the whole chain.
> > > >=20
> > > > Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> > > > ---
> > > > =C2=A0=C2=A0drivers/iio/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > > > =C2=A0=C2=A0drivers/iio/industrialio-backend.c | 107 ++++++++++++++=
+++++++++++++++
> > > > =C2=A0=C2=A0include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 56 +++++++++++++++
> > > > =C2=A0=C2=A03 files changed, 164 insertions(+)
> > > > =C2=A0=C2=A0create mode 100644 drivers/iio/industrialio-backend.c
> > > > =C2=A0=C2=A0create mode 100644 include/linux/iio/backend.h
> > > >=20
> > > > diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> > > > index 9622347a1c1b..9b59c6ab1738 100644
> > > > --- a/drivers/iio/Makefile
> > > > +++ b/drivers/iio/Makefile
> > > > @@ -5,6 +5,7 @@
> > > > =C2=A0=20
> > > > =C2=A0=C2=A0obj-$(CONFIG_IIO) +=3D industrialio.o
> > > > =C2=A0=C2=A0industrialio-y :=3D industrialio-core.o industrialio-ev=
ent.o inkern.o
> > > > +industrialio-$(CONFIG_IIO_BACKEND) +=3D industrialio-backend.o
> > > > =C2=A0=C2=A0industrialio-$(CONFIG_IIO_BUFFER) +=3D industrialio-buf=
fer.o
> > > > =C2=A0=C2=A0industrialio-$(CONFIG_IIO_TRIGGER) +=3D industrialio-tr=
igger.o
> > > > =C2=A0=20
> > > > diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/indus=
trialio-
> > > > backend.c
> > > > new file mode 100644
> > > > index 000000000000..7d0625889873
> > > > --- /dev/null
> > > > +++ b/drivers/iio/industrialio-backend.c
> > > > @@ -0,0 +1,107 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/* The industrial I/O core, backend handling functions
> > > > + *
> > > > + */
> > > > +
> > > > +#include <linux/kernel.h>
> > > > +#include <linux/device.h>
> > > > +#include <linux/property.h>
> > > > +#include <linux/iio/iio.h>
> > > > +#include <linux/iio/backend.h>
> > > > +
> > > > +static DEFINE_IDA(iio_backend_ida);
> > > > +
> > > > +#define to_iio_backend(_device) container_of((_device), struct iio=
_backend,
> > > > dev)
> > > > +
> > > > +static void iio_backend_release(struct device *device)
> > > > +{
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct iio_backend *back=
end =3D to_iio_backend(device);
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kfree(backend->name);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kfree(backend);
> > > > +}
> > > > +
> > > > +static const struct device_type iio_backend_type =3D {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.release =3D iio_backend=
_release,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.name =3D "iio_backend_d=
evice",
> > > > +};
> > > > +
> > > > +struct iio_backend *iio_backend_alloc(struct device *parent)
> > > > +{
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct iio_backend *back=
end;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0backend =3D devm_kzalloc=
(parent, sizeof(*backend), GFP_KERNEL);
> > > >  =20
> > >=20
> > > No error checking.
> > >=20
> > > I guess a lot of cleanings are still missing but the important thing =
I wanted to
> > > notice is that the above pattern is not ok.
> > > Your 'struct iio_backend *backend'' embeds a 'stuct device' which is a
> > > refcounted object. Nevertheless, you're binding the lifetime of your =
object to
> > > the parent device and that is wrong. The reason is that as soon as yo=
ur parent
> > > device get's released or just unbinded from it's driver, all the devr=
es stuff
> > > (including your 'struct iio_backend' object) will be released indepen=
dentof
> > > your 'struct device' refcount value...
> > >=20
> > > So, you might argue this won't ever be an issue in here but the patte=
rn is still
> > > wrong. There are some talks about this, the last one was given at the=
 latest
> > > EOSS:
> > >=20
> > > https://www.youtube.com/watch?v=3DHCiJL7djGw8&list=3DPLbzoR-pLrL6pY8a=
8zSKRC6-AihFrruOkq&index=3D27&ab_channel=3DTheLinuxFoundation
> > >  =20
> >=20
> > This is a good point. Thanks for pointing it out. Sure, there are still=
=20
> > many things to improve.
> >=20
> > I have seen the comment from Jonathan on your "Add converter framework"=
=20
> > serie. I had a quick look at the serie. It seems that we share the need=
=20
> > to aggregate some IIO devices. But I need to read it more carefully to=
=20
> > check if we can find some convergences here. =20
>=20
> Yeah, In my case, the backend devices are typically FPGA soft cores and t=
he aggregate
> device might connect to multiple of these backends. That was one of the r=
eason why I
> used the component API where the aggregate device is only configured when=
 all the
> devices are probed. Similarly, when one of them is unbind, the whole thin=
g should be
> torn down. Also, in my case, the frontend device needs to do a lot of set=
up on the
> backend device so the whole thing works (so I do have/need a lot more .op=
s).
>=20
> Anyways, it does not matter much what the backend device is and from a fi=
rst glance
> and looking at the .ops you have, it seems that this could easily be supp=
orted in the
> framework I'm adding. The only things I'm seeing are:
>=20
> 1) You would need to use the component API if it's ok. Also not sure if t=
he cascaded
> usecase you mention would work with that API.
>=20
> 2) We would need to add the .read_raw() op. If you look at my RFC, I alre=
ady have
> some comments/concerns about having an option like that (see there).
>=20
> Having said that, none of the above are blockers as 1), I can ditch the c=
omponent API
> in favour of typical FW/OF lookup (even though the component API makes so=
me things
> easier to handle) and 2), adding a .read_raw() op is not a blocker for me.
>=20
> Alternatively, another (maybe crazy) idea would be to have this framework=
 have the
> really generic stuff (like lookup + generic ops) and build my iio-convert=
er on top of
> it (extending it). You know, some OO fun :). Maybe not worth the trouble =
though.
>=20
> Let's if Jonathan has some suggestions on how to proceed...

The two of you are definitely the most familiar with the code and the restr=
ictions
around it, so ideally I'd like you go figure out the path forwards and tell=
 me :)

To me this is a non core extension of IIO so as long as we end up with some=
thing
maintainable that solves some (all?) of the ordering and dependency issues =
I'll
be happy.  I'd rather not have two solutions of course if there is not a go=
od
reason why they have to be different.  If we do end up with two solutions I
want clear documentation for the restrictions of each so that we hopefully
don't end up with a 3rd solution down the line.

Jonathan

>=20
> - Nuno S=C3=A1
> > >  =20
>=20


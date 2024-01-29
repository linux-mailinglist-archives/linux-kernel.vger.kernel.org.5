Return-Path: <linux-kernel+bounces-42627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A506B840407
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38A5F282FDF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EAB5D8EC;
	Mon, 29 Jan 2024 11:44:57 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162C55BAD2;
	Mon, 29 Jan 2024 11:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706528697; cv=none; b=FOrcd3fd1CY4dFVXbjxlzLKHNPmcKDBWeQUyVSlcyZz1FMwYEWzaWbS363ayBm9Krqu4s9l3jj0enRLL9wFKVFcrXITN9MYiiPjZU0s7KJro5dMF4OJqG/F6bsMAsoEJ1fax6xgBLNoVRZqyK/MKqIWsq/sqV/klKmt/FJUO/SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706528697; c=relaxed/simple;
	bh=7rIIlS6tYuaBa6fIid1E/uhSEnk5byE1WX/epsrjhMY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ye0yyCjOG5QnQL3x7mBz9KLDsjlW4s0ZPtOOJBYssbB8OnmJpvLdy35apiblRbCI83aLnHUWU+sBfIb+aQ8xVeocAkmJwsrSw/xdNPjNiOMvNrgDkEJUL1CLSHm5ELLRogKBtbJZVgWincPC22DjTWkN9XG61p7iwm51mXoMllw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TNmbw0dSFz6K98m;
	Mon, 29 Jan 2024 19:41:48 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 25EE61400CD;
	Mon, 29 Jan 2024 19:44:52 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Jan
 2024 11:44:51 +0000
Date: Mon, 29 Jan 2024 11:44:50 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Julia Lawall <julia.lawall@inria.fr>
CC: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
	<jic23@kernel.org>, <linux-iio@vger.kernel.org>, Rob Herring
	<robh@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
	<linux-kernel@vger.kernel.org>, Nicolas Palix <nicolas.palix@imag.fr>,
	"Sumera Priyadarsini" <sylphrenadin@gmail.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	<linux-acpi@vger.kernel.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: [RFC PATCH 2/5] of: Introduce for_each_child_of_node_scoped()
 to automate of_node_put() handling
Message-ID: <20240129114450.000061f6@Huawei.com>
In-Reply-To: <alpine.DEB.2.22.394.2401290754250.3150@hadrien>
References: <20240128160542.178315-1-jic23@kernel.org>
	<20240128160542.178315-3-jic23@kernel.org>
	<CAMknhBEL3cv4L0A-W=_1EcDmD3Cj8apheDcpnqjyJjKBZuPYew@mail.gmail.com>
	<alpine.DEB.2.22.394.2401290754250.3150@hadrien>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 29 Jan 2024 07:54:57 +0100 (CET)
Julia Lawall <julia.lawall@inria.fr> wrote:

> On Sun, 28 Jan 2024, David Lechner wrote:
>=20
> > On Sun, Jan 28, 2024 at 10:06=E2=80=AFAM Jonathan Cameron <jic23@kernel=
org> wrote: =20
> > >
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >
> > > To avoid issues with out of order cleanup, or ambiguity about when the
> > > auto freed data is first instantiated, do it within the for loop defi=
nition.
> > >
> > > The disadvantage is that the struct device_node *child variable creat=
ion
> > > is not immediately obvious where this is used.
> > > However, in many cases, if there is another definition of
> > > struct device_node *child; the compiler / static analysers will notif=
y us
> > > that it is unused, or uninitialized.
> > >
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > ---
> > >  include/linux/of.h | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/include/linux/of.h b/include/linux/of.h
> > > index 50e882ee91da..f822226eac6d 100644
> > > --- a/include/linux/of.h
> > > +++ b/include/linux/of.h
> > > @@ -1434,6 +1434,12 @@ static inline int of_property_read_s32(const s=
truct device_node *np,
> > >         for (child =3D of_get_next_available_child(parent, NULL); chi=
ld !=3D NULL; \
> > >              child =3D of_get_next_available_child(parent, child))
> > >
> > > +#define for_each_child_of_node_scoped(parent, child) \
> > > +       for (struct device_node *child __free(device_node) =3D       =
     \
> > > +            of_get_next_child(parent, NULL);                        =
   \
> > > +            child !=3D NULL;                                        =
     \
> > > +            child =3D of_get_next_available_child(parent, child)) =20
> >
> > Doesn't this need to match the initializer (of_get_next_child)?
> > Otherwise it seems like the first node could be a disabled node but no
> > other disabled nodes would be included in the iteration.
> >
> > It seems like we would want two macros, one for each variation,
> > analogous to for_each_child_of_node() and
> > for_each_available_child_of_node(). =20
>=20
> There are a bunch of iterators, and I guess a scoped version is needed for
> each of them?

Yes. I just didn't want to add too much to the RFC. I'd want to
convert a user of each as part of the patch set introducing the new
loop definitions.

Jonathan

>=20
> julia
>=20
>=20
> >
> > =20
> > > +
> > >  #define for_each_of_cpu_node(cpu) \
> > >         for (cpu =3D of_get_next_cpu_node(NULL); cpu !=3D NULL; \
> > >              cpu =3D of_get_next_cpu_node(cpu))
> > > --
> > > 2.43.0
> > >
> > > =20
> > =20



Return-Path: <linux-kernel+bounces-48372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED05845B1A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8B30282A5D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F73562165;
	Thu,  1 Feb 2024 15:17:10 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5523E62141;
	Thu,  1 Feb 2024 15:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706800629; cv=none; b=ZFGBrWbl+2ba9lKrEXmtaMfks00Oi4F7WShfslRHDLgEdrE718opQ+h30FPr7o2uBxCaHzmeHeWkNfHPC4+hoM704CBrINLXy4VP6Ih7hSXm9likhU6f1pJ/cImVC26X8AUgVxQOPd1h5jLh/JtCC23vcWxWmd6JEJK1BXoswLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706800629; c=relaxed/simple;
	bh=SQTRgcD+I6ibp2a9ZIUzFHD1oB/zY7oXL+TAzvzz0I0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EFezXi0l5TOj7WDhXz+UujN+0HWYzfdGU1s62LDmLQPoiNh/wcl0AqHoerBoOEgXcv+YsQciA8Th3CsADHq79uPswLd4NqmQD+hWPfKDAMqHIYEq0ICjmPGUyicTS6mP4ZM4OyH60vaKZ/ZUAowFCKiYHYEQJyFh40fbei9kVJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TQj8z1Wqlz6JB1P;
	Thu,  1 Feb 2024 23:13:39 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 12A8E140DAF;
	Thu,  1 Feb 2024 23:17:02 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 1 Feb
 2024 15:17:01 +0000
Date: Thu, 1 Feb 2024 15:17:00 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Rob Herring <robh@kernel.org>
CC: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
	<jic23@kernel.org>, <linux-iio@vger.kernel.org>, Frank Rowand
	<frowand.list@gmail.com>, <linux-kernel@vger.kernel.org>, Julia Lawall
	<Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, "Sumera
 Priyadarsini" <sylphrenadin@gmail.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	<linux-acpi@vger.kernel.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: [RFC PATCH 2/5] of: Introduce for_each_child_of_node_scoped()
 to automate of_node_put() handling
Message-ID: <20240201151700.000038ee@Huawei.com>
In-Reply-To: <20240131235148.GA2743404-robh@kernel.org>
References: <20240128160542.178315-1-jic23@kernel.org>
	<20240128160542.178315-3-jic23@kernel.org>
	<CAMknhBEL3cv4L0A-W=_1EcDmD3Cj8apheDcpnqjyJjKBZuPYew@mail.gmail.com>
	<20240131235148.GA2743404-robh@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 31 Jan 2024 17:51:48 -0600
Rob Herring <robh@kernel.org> wrote:

> On Sun, Jan 28, 2024 at 03:11:01PM -0600, David Lechner wrote:
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
> >=20
> > Doesn't this need to match the initializer (of_get_next_child)?
> > Otherwise it seems like the first node could be a disabled node but no
> > other disabled nodes would be included in the iteration.
> >=20
> > It seems like we would want two macros, one for each variation,
> > analogous to for_each_child_of_node() and
> > for_each_available_child_of_node(). =20
>=20
> Yes, but really I'd like these the other way around. 'available' should=20
> be the default as disabled should really be the same as a node not=20
> present except for a few cases where it is not.
>=20
> I bring it up only because if we're changing things then it is a=20
> convenient time to change this. That's really a side issue to sorting=20
> out how this new way should work.

Happy to push that forwards by not initially defining the non available ver=
sion
of this scoped form. So we will just have

for_each_avaiable_child_of_node_scoped()

Short and snappy it isn't but such is life.

Jonathan

>=20
> Rob
>=20



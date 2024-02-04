Return-Path: <linux-kernel+bounces-51863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5A9849032
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 20:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D6831F2142A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 19:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0902562F;
	Sun,  4 Feb 2024 19:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3Oyl7kd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CCE288D9;
	Sun,  4 Feb 2024 19:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707076587; cv=none; b=C0hwGmIUyCkv1kAZ/9kdL8hukqzKeIrABmWY9Ua9IGW8xnJpE4CyuCvvlucXM3EUtnZwYIp2zS0lzxRJNDX3bEq7YG+ws/Fv6pMiVnfutePmDpc9rxzvlM6d3lC4zGD//5tBWc3BCUFBmdiCpxrJEBsVftlQcfCJjHfEisdtFM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707076587; c=relaxed/simple;
	bh=G3+CP77UbJCipyCA87pI2FMze2ZRBhHlill3yS+hHpI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UY7Pz5eU2JoLhgYIlykAwsktzkNtfDvHWYBNKP98JWuxOmJW33Buql4Hn81+oIObQrwpaNOIgOH0Ybzvkzlj/NrmqpGtjbGz5uqN4ASxk9E+9kyuAg3RZsfL4qnolVK+mfkyHKa1CoD1CufAqjObRy3EOtdNfHhmP5Cc5KZ+8aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3Oyl7kd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3335C43390;
	Sun,  4 Feb 2024 19:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707076586;
	bh=G3+CP77UbJCipyCA87pI2FMze2ZRBhHlill3yS+hHpI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T3Oyl7kd0uyQgK+BwaZgUuA/ztfCkYYNnFHtCzEXhfQazojUnDCZNnaxE+HSD61b3
	 Qumhr29+SuoHio+Jx9YdTU6Ck/KGn4ve3u6o0T4Mi5/wGypryOVdF6rIwkHi0fQSJ6
	 se5JHhGJ1v1WsRtRpixiCy9q4j+rWIZhuVCNgX5kPKuATBCstjBbfneE8fYwv8xGsg
	 bJ+qcmiFiEnhA5dGST7m4Lhc3GKddjHwZWcW1VtG8kuagf+0HhGsByLK+T9TZkUBQw
	 x+3IM2W8y8cL+oBDLbBJnvxOEUJUoINfjBwR+33TqBAtKJyvD9bZrAk2mEEcQXkrgH
	 GC7uxwJM2FkjQ==
Date: Sun, 4 Feb 2024 19:56:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, Rob Herring <robh@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, linux-kernel@vger.kernel.org, Julia Lawall
 <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, Sumera
 Priyadarsini <sylphrenadin@gmail.com>, "Rafael J . Wysocki"
 <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [RFC PATCH 2/5] of: Introduce for_each_child_of_node_scoped()
 to automate of_node_put() handling
Message-ID: <20240204195611.2bb6ff58@jic23-huawei>
In-Reply-To: <CAMknhBEL3cv4L0A-W=_1EcDmD3Cj8apheDcpnqjyJjKBZuPYew@mail.gmail.com>
References: <20240128160542.178315-1-jic23@kernel.org>
	<20240128160542.178315-3-jic23@kernel.org>
	<CAMknhBEL3cv4L0A-W=_1EcDmD3Cj8apheDcpnqjyJjKBZuPYew@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 28 Jan 2024 15:11:01 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On Sun, Jan 28, 2024 at 10:06=E2=80=AFAM Jonathan Cameron <jic23@kernel.o=
rg> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > To avoid issues with out of order cleanup, or ambiguity about when the
> > auto freed data is first instantiated, do it within the for loop defini=
tion.
> >
> > The disadvantage is that the struct device_node *child variable creation
> > is not immediately obvious where this is used.
> > However, in many cases, if there is another definition of
> > struct device_node *child; the compiler / static analysers will notify =
us
> > that it is unused, or uninitialized.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  include/linux/of.h | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/include/linux/of.h b/include/linux/of.h
> > index 50e882ee91da..f822226eac6d 100644
> > --- a/include/linux/of.h
> > +++ b/include/linux/of.h
> > @@ -1434,6 +1434,12 @@ static inline int of_property_read_s32(const str=
uct device_node *np,
> >         for (child =3D of_get_next_available_child(parent, NULL); child=
 !=3D NULL; \
> >              child =3D of_get_next_available_child(parent, child))
> >
> > +#define for_each_child_of_node_scoped(parent, child) \
> > +       for (struct device_node *child __free(device_node) =3D         =
   \
> > +            of_get_next_child(parent, NULL);                          =
 \
> > +            child !=3D NULL;                                          =
   \
> > +            child =3D of_get_next_available_child(parent, child)) =20
>=20
> Doesn't this need to match the initializer (of_get_next_child)?
> Otherwise it seems like the first node could be a disabled node but no
> other disabled nodes would be included in the iteration.

FwIW that was was entirely unintentional.  Not sure how it happened :(
Anyhow, now will be for_each_available_child_of_node_scoped() with the
right first call.

>=20
> It seems like we would want two macros, one for each variation,
> analogous to for_each_child_of_node() and
> for_each_available_child_of_node().
>=20
>=20
> > +
> >  #define for_each_of_cpu_node(cpu) \
> >         for (cpu =3D of_get_next_cpu_node(NULL); cpu !=3D NULL; \
> >              cpu =3D of_get_next_cpu_node(cpu))
> > --
> > 2.43.0
> >
> > =20



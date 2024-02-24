Return-Path: <linux-kernel+bounces-79578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B0086246B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 12:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEEC7283B4F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 11:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1B325575;
	Sat, 24 Feb 2024 11:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FiNZ2KZ0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFFC2260B;
	Sat, 24 Feb 2024 11:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708773100; cv=none; b=HQzWhTyTak1X7M0qd1rR7Dt2wO4JCvOZTJATWsP2KDcteOXVXIwM6KlS/poy2RCncCeJo7mQzc196pqO+VgdXVQeUoF0m5x0ePLT7hKss11/XvGRuOox9jbIGafsme3LQj2zCOEvQb/b9+Hftau+mUHWFKLjkIqA3avbwXT1LTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708773100; c=relaxed/simple;
	bh=TAtRQi+l4Sj9/DzrNgyATnGTs3432p6TwmIDVHp3tnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K2he6P4lacyl3B+IAH7IQFfpmOex4KZhpgQERhMPD4mbLVyvB/snvXNfPE3/pJzxe6F4n3S2oPO6EcAnCuDymhftL2cjossr+sBwhvBOOQ1bohcRN8Dcj7v653k1JuLovM8AgQhPCOs04/2qI1VtlpazxtdTGy4LvteMK0Rlcp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FiNZ2KZ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C582C433C7;
	Sat, 24 Feb 2024 11:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708773100;
	bh=TAtRQi+l4Sj9/DzrNgyATnGTs3432p6TwmIDVHp3tnQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FiNZ2KZ0ZxiYZruinUZyso9Fz1N0ZcOZzBhGQFTR3Lh3X/6Ph73xSFyK/fgicmNWS
	 Gi3lJGNE8W/BMaGr7zljo3aAh777rZpIBek+0YlChC1neCVhXfxIMLBdG1gmXfvVZw
	 Vs29PQpkNop3NNoh1maQE2/jl1R4j7Vkw1U6rrzSKiYvqVmYdltJ3lnA98g2phaxCC
	 9f11SiN2wFWyM7vDJ723+jv0ZpYfU7JGpdQ/yZLZTpncvD7VFo0bBRpVAYtTiohHQz
	 A4W8uLpN35jC8QIjE5PIPcui5/ydIHO8HgwrGNYoEoCBES1lIK52qSfw+8U7gMjAbZ
	 AjbHTPoTzvJAg==
Date: Sat, 24 Feb 2024 11:11:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-gpio@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, Kent Gibson <warthog618@gmail.com>, Lars-Peter
 Clausen <lars@metafoo.de>, stable@vger.kernel.org
Subject: Re: [PATCH v2] kbuild: tools: drop overridden CFLAGS from
 MAKEOVERRIDES
Message-ID: <20240224111125.6e17305c@jic23-huawei>
In-Reply-To: <CAMo8BfLXW1tYG9bNQZciBC+NSS+1debXLSYkjNOQe200+aWFEg@mail.gmail.com>
References: <20240131042509.4034723-1-jcmvbkbc@gmail.com>
	<CAMo8BfLXW1tYG9bNQZciBC+NSS+1debXLSYkjNOQe200+aWFEg@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 21 Feb 2024 20:47:33 -0800
Max Filippov <jcmvbkbc@gmail.com> wrote:

> Ping?
>=20
> On Tue, Jan 30, 2024 at 8:25=E2=80=AFPM Max Filippov <jcmvbkbc@gmail.com>=
 wrote:
> >
> > Some Makefiles under tools/ use the 'override CFLAGS +=3D ...' construct
> > to add a few required options to CFLAGS passed by the user.
> > Unfortunately that only works when user passes CFLAGS as an environment
> > variable, i.e.
> >   CFLAGS=3D... make ...
> > and not in case when CFLAGS are passed as make command line arguments:
> >   make ... CFLAGS=3D...
> > It happens because in the latter case CFLAGS=3D... is recorded in the m=
ake
> > variable MAKEOVERRIDES and this variable is passed in its original form
> > to all $(MAKE) subcommands, taking precedence over modified CFLAGS value
> > passed in the environment variable. E.g. this causes build failure for
> > gpio and iio tools when the build is run with user CFLAGS because of
> > missing _GNU_SOURCE definition needed for the asprintf().
> >
> > One way to fix it is by removing overridden variables from the
> > MAKEOVERRIDES. Add macro 'drop-var-from-overrides' that removes a
> > definition of a variable passed to it from the MAKEOVERRIDES and use it
> > to fix CFLAGS passing for tools/gpio and tools/iio.
> >
> > This implementation tries to be precise in string processing and handle
> > variables with embedded spaces and backslashes correctly. To achieve
> > that it replaces every '\\' sequence with '\-' to make sure that every
> > '\' in the resulting string is an escape character. It then replaces
> > every '\ ' sequence with '\_' to turn string values with embedded spaces
> > into single words. After filtering the overridden variable definition
> > out of the resulting string these two transformations are reversed.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 4ccc98a48958 ("tools gpio: Allow overriding CFLAGS")
> > Fixes: 572974610273 ("tools iio: Override CFLAGS assignments")
> > Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
I'm fine with this, but it's out of my area of expertise - rarely
write Makefiles etc!  So I'd like some more inputs from others.

With that in mind,
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> > ---
> > Changes v1->v2:
> > - make drop-var-from-overrides-code work correctly with arbitrary
> >   variables, including thoses ending with '\'.
> >
> >  tools/gpio/Makefile            | 1 +
> >  tools/iio/Makefile             | 1 +
> >  tools/scripts/Makefile.include | 9 +++++++++
> >  3 files changed, 11 insertions(+)
> >
> > diff --git a/tools/gpio/Makefile b/tools/gpio/Makefile
> > index d29c9c49e251..46fc38d51639 100644
> > --- a/tools/gpio/Makefile
> > +++ b/tools/gpio/Makefile
> > @@ -24,6 +24,7 @@ ALL_PROGRAMS :=3D $(patsubst %,$(OUTPUT)%,$(ALL_TARGE=
TS))
> >  all: $(ALL_PROGRAMS)
> >
> >  export srctree OUTPUT CC LD CFLAGS
> > +$(call drop-var-from-overrides,CFLAGS)
> >  include $(srctree)/tools/build/Makefile.include
> >
> >  #
> > diff --git a/tools/iio/Makefile b/tools/iio/Makefile
> > index fa720f062229..04307588dd3f 100644
> > --- a/tools/iio/Makefile
> > +++ b/tools/iio/Makefile
> > @@ -20,6 +20,7 @@ ALL_PROGRAMS :=3D $(patsubst %,$(OUTPUT)%,$(ALL_TARGE=
TS))
> >  all: $(ALL_PROGRAMS)
> >
> >  export srctree OUTPUT CC LD CFLAGS
> > +$(call drop-var-from-overrides,CFLAGS)
> >  include $(srctree)/tools/build/Makefile.include
> >
> >  #
> > diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.in=
clude
> > index 6fba29f3222d..0f68b95cf55c 100644
> > --- a/tools/scripts/Makefile.include
> > +++ b/tools/scripts/Makefile.include
> > @@ -51,6 +51,15 @@ define allow-override
> >      $(eval $(1) =3D $(2)))
> >  endef
> >
> > +# When a Makefile overrides a variable and exports it for the nested $=
(MAKE)
> > +# invocations to use its modified value, it must remove that variable =
definition
> > +# from the MAKEOVERRIDES variable, otherwise the original definition f=
rom the
> > +# MAKEOVERRIDES takes precedence over the exported value.
> > +drop-var-from-overrides =3D $(eval $(drop-var-from-overrides-code))
> > +define drop-var-from-overrides-code
> > +MAKEOVERRIDES :=3D $(subst \-,\\,$(subst \_,\ ,$(filter-out $(1)=3D%,$=
(subst \ ,\_,$(subst \\,\-,$(MAKEOVERRIDES))))))
> > +endef
> > +
> >  ifneq ($(LLVM),)
> >  ifneq ($(filter %/,$(LLVM)),)
> >  LLVM_PREFIX :=3D $(LLVM)
> > --
> > 2.39.2
> > =20
>=20
>=20



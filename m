Return-Path: <linux-kernel+bounces-150250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 921B78A9C4C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2DC51F25C42
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6173A165FC9;
	Thu, 18 Apr 2024 14:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHFF7J0s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A463D163A9B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 14:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713449309; cv=none; b=dC6sMIhBA+YMv0wWRI4ngte+yrl+vb2mOZFLC/s9SrUlY7o2zqzrYxlJktOA3L5O1U2Rg6ffCrjHyXeBl2GwbnPnr8ldrRr2vsdnGPDDFOw1OX2tj6ktydKGpIo4Pol5GjqsoKCRETdvs1FcxregqyNds8G9fcudvXW/REiav3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713449309; c=relaxed/simple;
	bh=g/KqDqr1SceKtAwHTvVpWKhfc8Vr3dFUZKNkr7xMSAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CK4kp2pvzLvOGmv36OqezUJTqm7R+4g09TK+vxKn2fx+rWQzCKg1Ic04MNqe8Yzs5RWz46SSueBmYrKgvqbqfMZy2N+/XpKtTrpUq7GDa2zpjW4f9KWHc7JhAjyeNqhU+7v7J64U4h/EZiVXqASw0fj/ffNku/6HHsTVa+LyP5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHFF7J0s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FFBEC113CC;
	Thu, 18 Apr 2024 14:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713449309;
	bh=g/KqDqr1SceKtAwHTvVpWKhfc8Vr3dFUZKNkr7xMSAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jHFF7J0sE5nDYCDNIjnpvnuG6mADEST9SsZFgbZc7P+ASD4sH1A5T9CNlbzIgct5m
	 T8qIc9P8CiPwh4z0q4IFJf/FwkuCuGKjg93dt/yta6kb7AGWugWuzqQHyyfGJaMRLN
	 Y5bCl+jeAPRfYuAQOg9lLBEMp+nGGklWk9rG3fasYRJRXBkFdx/vRuYU6/B2n9ne+e
	 ft0yHZmnXWMwhOvehAWfuA5Uvx9/sJ3VvLYxQUrhs7wwrWmeHnxFhTnzegYYOC0gVq
	 XE3aN4+uz4mkmgWPvdR530dZunEl3/7XDu6C18sDCRFfAlxgR/c05Dp5S/yhfWxWy7
	 pRQboWqPtTsDw==
Date: Thu, 18 Apr 2024 15:08:24 +0100
From: Conor Dooley <conor@kernel.org>
To: Xu Lu <luxu.kernel@bytedance.com>
Cc: Christoph =?iso-8859-1?Q?M=FCllner?= <christoph.muellner@vrull.eu>,
	Andrew Jones <ajones@ventanamicro.com>, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, andy.chiu@sifive.com,
	guoren@kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, lihangjing@bytedance.com,
	dengliang.1214@bytedance.com, xieyongji@bytedance.com,
	chaiwen.cc@bytedance.com, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [External] Re: [RFC 0/2] riscv: Idle thread using Zawrs extension
Message-ID: <20240418-variety-exhume-4fe364344086@spud>
References: <20240418114942.52770-1-luxu.kernel@bytedance.com>
 <CAEg0e7gDk6SFRh4oF0KsA7xZoMr7RuZXFWL8qD7rmM2cBDLwcg@mail.gmail.com>
 <CAPYmKFsQQPCd-34GArHfC-Sv8PCYHgmZxprK3WHKnJquQDoXiQ@mail.gmail.com>
 <CAEg0e7hpjAec=2k+PwJeb0WezmJCFdUD=HbCiGe7+RxKgPHgtg@mail.gmail.com>
 <CAPYmKFudqq6Yg=uaVjAubCMM5TBMj8dkC0mXz+6eq3vNizTt7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Fk4xyD64bIbrps5W"
Content-Disposition: inline
In-Reply-To: <CAPYmKFudqq6Yg=uaVjAubCMM5TBMj8dkC0mXz+6eq3vNizTt7A@mail.gmail.com>


--Fk4xyD64bIbrps5W
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 09:09:06PM +0800, Xu Lu wrote:
> On Thu, Apr 18, 2024 at 8:56=E2=80=AFPM Christoph M=C3=BCllner
> <christoph.muellner@vrull.eu> wrote:
> >
> > On Thu, Apr 18, 2024 at 2:44=E2=80=AFPM Xu Lu <luxu.kernel@bytedance.co=
m> wrote:
> > >
> > > On Thu, Apr 18, 2024 at 8:26=E2=80=AFPM Christoph M=C3=BCllner
> > > <christoph.muellner@vrull.eu> wrote:
> > > >
> > > > On Thu, Apr 18, 2024 at 1:50=E2=80=AFPM Xu Lu <luxu.kernel@bytedanc=
e.com> wrote:
> > > > >
> > > > > This patch series introduces a new implementation of idle thread =
using
> > > > > Zawrs extension.
> > > >
> > > > This overlaps with the following series:
> > > >   https://lore.kernel.org/all/20240315134009.580167-7-ajones@ventan=
amicro.com/
> > >
> > > Hi Christoph.
> > > Thanks for your reply!
> > > Actually our patch series is different from this. The work from your
> > > link focuses on providing support for Zawrs and implementing spinlock
> > > using it, while our work focuses on implementing idle thread using
> > > Zawrs and accelerating IPI to idle cpu. Of course, the ISA ZAWRS
> > > config part can be merged. We will refine our code in the next version
> > > to reduce code conflicts.
> >
> > Yes, I've seen that this targets another optimization, but the basic
> > Zawrs support
> > would be identical to the other patchset (even if it is not).
> > I would propose that we work on a basic Zawrs support patchset that int=
roduces
> > the Kconfig, DTS and hwprobe parts (a subset of Andrew's patchset).
> > Once this is merged, all other optimizations can be built upon it
> > (spinlocks, idle thread, glibc CPU spinning).
> > If this proposal is fine for the maintainers/reviewers, then Andrew cou=
ld resend
> > these basic-support patches.
> >
> > BR
> > Christoph
>=20
> Roger that! This does make more sense. We will rebase our code on
> Andrew's basic support patches in the next version.

IIRC Drew's working on a new version of the linked series (we were
talking about it yesterday) so hold off for that before doing a rebase
and sending a new version I think.

Thanks,
Conor.

--Fk4xyD64bIbrps5W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZiEpWAAKCRB4tDGHoIJi
0iP1AQDU2aET0LsGNcFkDzq2ZvrGNzqDCDtIdtlPBbmS/gTmsQEAxzRxLXs9jbYn
R3OVENIITqSyFtfdaNrNL/ezuQ87OgA=
=Qxuc
-----END PGP SIGNATURE-----

--Fk4xyD64bIbrps5W--


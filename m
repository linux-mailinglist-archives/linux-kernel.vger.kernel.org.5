Return-Path: <linux-kernel+bounces-37928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2927283B86D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 04:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95DA5B218C7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 03:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1C66FD1;
	Thu, 25 Jan 2024 03:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="XN+AK6ff"
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD5A6FAE;
	Thu, 25 Jan 2024 03:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706154138; cv=none; b=X2xtsAWTyQeoKTTddcb/B5hgPVumC7NsQ4zIK6Ya/lAzH/+J4py36rZpTW/hUM3FRmnxu0MmxaGdbcA+Fx5XT0IT6PQZggjJDzLCZwJ1z72hppIVMCoJ/jsqD/etfOD2CiHq5S96syBYyP0irM4QbNxKA1M0PUMddgiPg8XxmJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706154138; c=relaxed/simple;
	bh=GVIfoRSrCh6tdzuJ61LdUv6kvUUuyxps1ZM55/obhJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iKsUVUF509PJT5gxReDH2VqvFu1w61YcskKhBou9onA+J0bKXeHv59uSGM0NSI6XyjdW9tQJaKbh5BBWTQeVyRBgVFWH3vZaMyKj/ldgVj7PPqPl5FVI8+8KHxrS50iNdn05+BQdhvsaEZ94UGJ7Ke7yHjp7mQH7akk7aa+bZVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=XN+AK6ff; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=SzRFkiNt6Vcc+jBrSxbHVvrqks+TgE2qyykxd+Yu4WE=; b=XN+AK6ffBA6xsWA8om2UZeZrVg
	eUUEUr8hJ5xWzHTpOR+cxJpt8za6/VGnSuPOsPuHtT94EpEsZnbMyKF4i+aG/s9faStfvQt2REVff
	R8L47fXdeKrrdzSl1q9TK+dLdAxu/lsxWrnqkbd8ajt6VRrMnlthtzIxdWd79IhfR+S1b9huUqSnA
	zyFXQEBqflpaSIUZee9gAFnbhfnWD1Dbriq7STuLp0q4xA6NZLuGAHtnrGFPAxStdVEHDm6BA3JiV
	fz873fVfw8zOOTS6+AUnkNu3H//qH8VN+qAtAyxtl6kr1dIRk71WlJTac1CFZDD3SUEDV7H+C0pwf
	v8m1CFqA==;
Received: from [10.69.139.5] (helo=terabithia.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rSqcv-00ElYR-0i;
	Wed, 24 Jan 2024 21:42:05 -0600
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Andy Lutomirski <luto@kernel.org>, wine-devel@winehq.org
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 wine-devel@winehq.org,
 =?ISO-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
 Wolfram Sang <wsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Alexandre Julliard <julliard@winehq.org>,
 Elizabeth Figura <zfigura@codeweavers.com>
Subject:
 Re: [RFC PATCH 1/9] ntsync: Introduce the ntsync driver and character device.
Date: Wed, 24 Jan 2024 21:42:04 -0600
Message-ID: <10405963.nUPlyArG6x@terabithia>
In-Reply-To: <5907233.BlLQTPImNI@camazotz>
References:
 <20240124004028.16826-1-zfigura@codeweavers.com>
 <CALCETrU+Eb5CdkqfYK8JvOiPA7K-6Bfs4uEWiu-U9oH95XfvKw@mail.gmail.com>
 <5907233.BlLQTPImNI@camazotz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Wednesday, 24 January 2024 16:56:23 CST Elizabeth Figura wrote:
> On Wednesday, 24 January 2024 15:26:15 CST Andy Lutomirski wrote:
>=20
> > On Tue, Jan 23, 2024 at 4:59=E2=80=AFPM Elizabeth Figura
> > <zfigura@codeweavers.com> wrote:
> >=20
> > >
> > >
> > > ntsync uses a misc device as the simplest and least intrusive uAPI
> > > interface.
> >
> > >
> > >
> > > Each file description on the device represents an isolated NT instanc=
e,
> > > intended to correspond to a single NT virtual machine.
> >=20
> >=20
> > If I understand this text right, and if I understood the code right,
> > you're saying that each open instance of the device represents an
> > entire universe of NT synchronization objects, and no security or
> > isolation is possible between those objects.  For single-process use,
> > this seems fine.  But fork() will be a bit odd (although NT doesn't
> > really believe in fork, so maybe this is fine).
> >=20
> > Except that NT has *named* semaphores and such.  And I'm pretty sure
> > I've written GUI programs that use named synchronization objects (IIRC
> > they were events, and this was a *very* common pattern, regularly
> > discussed in MSDN, usenet, etc) to detect whether another instance of
> > the program is running.  And this all works on real Windows because
> > sessions have sufficiently separated namespaces, and the security all
> > works out about as any other security on Windows, etc.  But
> > implementing *that* on top of this
> > file-description-plus-integer-equals-object will be fundamentally
> > quite subject to one buggy program completely clobbering someone
> > else's state.
> >=20
> > Would it make sense and scale appropriately for an NT synchronization
> > *object* to be a Linux open file description?  Then SCM_RIGHTS could
> > pass them around, an RPC server could manage *named* objects, and
> > they'd generally work just like other "Object Manager" objects like,
> > say, files.
>=20
>=20
> It's a sensible concern. I think when I discussed this with Alexandre
> Julliard (the Wine maintainer, CC'd) the conclusion was this wasn't
> something we were concerned about.
>=20
> While the current model *does* allow for processes to arbitrarily mess
> with each other, accidentally or not, I think we're not concerned with
> the scope of that than we are about implementing a whole scheduler in
> user space.
>=20
> For one, you can't corrupt the wineserver state this way=E2=80=94wineserv=
er
> being sort of like a dedicated process that handles many of the things
> that a kernel would, and so sometimes needs to set or reset events, or
> perform NTSYNC_IOC_KILL_MUTEX, but never relies on ntsync object state.
> Whereas trying to implement a scheduler in user space would involve the
> wineserver taking locks, and hence other processes could deadlock.
>=20
> For two, it's probably a lot harder to mess with that internal state
> accidentally.
>=20
> [There is also a potential problem where some broken applications
> create a million (literally) sync objects. Making these into files runs
> into NOFILE. We did specifically push distributions and systemd to
> increase those limits because an older solution *did* use eventfds and
> *did* run into those limits. Since that push was successful I don't
> know if this is *actually* a concern anymore, but avoiding files is
> probably not a bad thing either.]

Of course, looking at it from a kernel maintainer's perspective, it wouldn'=
t=20
be insane to do this anyway. If we at some point do start to care about cro=
ss-
process isolation in this way, or if another NT emulator wants to use this=
=20
interface and does care about cross-process isolation, it'll be necessary. =
At=20
least it'd make sense to make them separate files even if we don't implemen=
t=20
granular permission handling just yet.

The main question is, is NOFILE a realistic concern, and what other problem=
s=20
might there be, in terms of making these heavier objects? Besides memory us=
age=20
I can't think of any, but of course I don't have much knowledge of this are=
a.

Alternatively, maybe there's another more lightweight way to store per-proc=
ess=20
data?




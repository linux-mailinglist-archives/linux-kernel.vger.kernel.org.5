Return-Path: <linux-kernel+bounces-39157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8E483CBA8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4117C1C261E9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41BA1339B7;
	Thu, 25 Jan 2024 18:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEy+Gu7S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9424135416
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 18:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706208917; cv=none; b=h/oDAElBWPa9DAJEcAd6XfOdd+WhQFwJzaqrlRuVjzowEMjYZFESr6vQmqEF5N1xYwwQQymD5A78yxr43uSX+GDDui4V5kJZVS3Vd6z+mUp4M2Ypg7A6vbFFdTIOwe3BOdvJTvDSkHyMzhR2cfMRNoubI+TyltYIyo3fIeKWb8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706208917; c=relaxed/simple;
	bh=g+SYRAmnXVb6DyX/0SomqqJ8/DmYauIbTPIYSVrGVhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uq3vRCim033z0iVklE5KQfDQdwUAnv3GhUMhsye0vzlE9kxgms/h6eBRB36F/ZhaYr2daLdCRLE0e+APvYw1BWcR4zHUXfe+/N+ht8PzF8qSwSx6ljflMOcMWHMP6+5zgDHaMOtrc3KjWRaEYcAaO6T1Qqn1WoaYIuHLEG5eFb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pEy+Gu7S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B5C0C433B1
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 18:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706208917;
	bh=g+SYRAmnXVb6DyX/0SomqqJ8/DmYauIbTPIYSVrGVhc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pEy+Gu7S+IpF+ZPUWI1/A2li2kBVNIcVHeF62OqJ2X94My2UL5Om8CVD5ZT7volO8
	 qihOUnrLpAZGmg0aLEBI0wgFiF5zby9VQa3F5AD7BClJsV37iaSn+c6QJtzhWADFSq
	 P2NUrzGTT+kuoJVClevAEZOzXKWYk5jybc724s7fRPh5GOPuYd+5DWg9YSI1bIwZpO
	 I8dmcBvthCMtCBPbGTVw8yd3nmCQ82W+azDjbAqefx0NZHsmpAC1GymVsEZr+fD7OP
	 hC6+Y8iGfXjzhY7vH5qdapYss9WproYudis9bAX+rkvB++IkaC1lZIgkb/5EeYhXNx
	 L0pNL6VG1oMpA==
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4bd8bf75341so115265e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 10:55:17 -0800 (PST)
X-Gm-Message-State: AOJu0YwsGW4XryfuesGzvYK1++A4UCMtw6/Wc/NOVdEz2koNJ8dW7kMf
	nobNir2BrAdpEjI1VW7byCXlNRhsBMUge3C4c1sRR+DppRj5nGRCIXa3L3K1miW2X+ACZtg1y2u
	GznNqjP7LYIi2eaXrQLHT+vlkWUrODwAmnlXv
X-Google-Smtp-Source: AGHT+IGWPfm/h8tdZxxC4/3EOBNgbDRnb5tbf3vWlU94Dr4vqO3jD+LdoWgtG+90f63JMV+JojcdYVC8+c0G1SasbvU=
X-Received: by 2002:a05:6122:4f0a:b0:4bd:8926:8e15 with SMTP id
 gh10-20020a0561224f0a00b004bd89268e15mr201992vkb.0.1706208916220; Thu, 25 Jan
 2024 10:55:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124004028.16826-1-zfigura@codeweavers.com>
 <CALCETrU+Eb5CdkqfYK8JvOiPA7K-6Bfs4uEWiu-U9oH95XfvKw@mail.gmail.com>
 <5907233.BlLQTPImNI@camazotz> <10405963.nUPlyArG6x@terabithia>
In-Reply-To: <10405963.nUPlyArG6x@terabithia>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 25 Jan 2024 10:55:04 -0800
X-Gmail-Original-Message-ID: <CALCETrVZFhH-dKCFpxj=nML2cn1EBc5wWHj9zhKK07TLSSqnDA@mail.gmail.com>
Message-ID: <CALCETrVZFhH-dKCFpxj=nML2cn1EBc5wWHj9zhKK07TLSSqnDA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/9] ntsync: Introduce the ntsync driver and character device.
To: Elizabeth Figura <zfigura@codeweavers.com>
Cc: Andy Lutomirski <luto@kernel.org>, wine-devel@winehq.org, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Wolfram Sang <wsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Alexandre Julliard <julliard@winehq.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 7:42=E2=80=AFPM Elizabeth Figura
<zfigura@codeweavers.com> wrote:
>
> On Wednesday, 24 January 2024 16:56:23 CST Elizabeth Figura wrote:
> > On Wednesday, 24 January 2024 15:26:15 CST Andy Lutomirski wrote:
> >
> > > On Tue, Jan 23, 2024 at 4:59=E2=80=AFPM Elizabeth Figura
> > > <zfigura@codeweavers.com> wrote:
> > >
> > > >
> > > >
> > > > ntsync uses a misc device as the simplest and least intrusive uAPI
> > > > interface.
> > >
> > > >
> > > >
> > > > Each file description on the device represents an isolated NT insta=
nce,
> > > > intended to correspond to a single NT virtual machine.
> > >
> > >
> > > If I understand this text right, and if I understood the code right,
> > > you're saying that each open instance of the device represents an
> > > entire universe of NT synchronization objects, and no security or
> > > isolation is possible between those objects.  For single-process use,
> > > this seems fine.  But fork() will be a bit odd (although NT doesn't
> > > really believe in fork, so maybe this is fine).
> > >
> > > Except that NT has *named* semaphores and such.  And I'm pretty sure
> > > I've written GUI programs that use named synchronization objects (IIR=
C
> > > they were events, and this was a *very* common pattern, regularly
> > > discussed in MSDN, usenet, etc) to detect whether another instance of
> > > the program is running.  And this all works on real Windows because
> > > sessions have sufficiently separated namespaces, and the security all
> > > works out about as any other security on Windows, etc.  But
> > > implementing *that* on top of this
> > > file-description-plus-integer-equals-object will be fundamentally
> > > quite subject to one buggy program completely clobbering someone
> > > else's state.
> > >
> > > Would it make sense and scale appropriately for an NT synchronization
> > > *object* to be a Linux open file description?  Then SCM_RIGHTS could
> > > pass them around, an RPC server could manage *named* objects, and
> > > they'd generally work just like other "Object Manager" objects like,
> > > say, files.
> >
> >
> > It's a sensible concern. I think when I discussed this with Alexandre
> > Julliard (the Wine maintainer, CC'd) the conclusion was this wasn't
> > something we were concerned about.
> >
> > While the current model *does* allow for processes to arbitrarily mess
> > with each other, accidentally or not, I think we're not concerned with
> > the scope of that than we are about implementing a whole scheduler in
> > user space.
> >
> > For one, you can't corrupt the wineserver state this way=E2=80=94winese=
rver
> > being sort of like a dedicated process that handles many of the things
> > that a kernel would, and so sometimes needs to set or reset events, or
> > perform NTSYNC_IOC_KILL_MUTEX, but never relies on ntsync object state.
> > Whereas trying to implement a scheduler in user space would involve the
> > wineserver taking locks, and hence other processes could deadlock.
> >
> > For two, it's probably a lot harder to mess with that internal state
> > accidentally.
> >
> > [There is also a potential problem where some broken applications
> > create a million (literally) sync objects. Making these into files runs
> > into NOFILE. We did specifically push distributions and systemd to
> > increase those limits because an older solution *did* use eventfds and
> > *did* run into those limits. Since that push was successful I don't
> > know if this is *actually* a concern anymore, but avoiding files is
> > probably not a bad thing either.]
>
> Of course, looking at it from a kernel maintainer's perspective, it would=
n't
> be insane to do this anyway. If we at some point do start to care about c=
ross-
> process isolation in this way, or if another NT emulator wants to use thi=
s
> interface and does care about cross-process isolation, it'll be necessary=
 At
> least it'd make sense to make them separate files even if we don't implem=
ent
> granular permission handling just yet.

I'm not convinced that any complexity at all beyond using individual
files is needed for granular permission handling.  Unless something
actually needs permission bits on different files pointing at the same
sync object (which I believe NT supports, but it's sort of an odd
concept and I'm not immediately convinced that anything uses it),
merely having individual files ought to do the trick.  Handling of who
has permission to open a given named object can live in a daemon, and
I'd guess that Wine even already implements this.

And keeping everything together gives me flashbacks of Windows 95 and
Mac OS pre-X.  Sure, in principle the software wasn't malicious, but
there was no shortage whatsoever of buggy crap out there, and systems
were quite unstable.  Even just:

CreateSemaphore();
fork();
sleep a few seconds;
exit();

seems like it could corrupt the shared namespace world.  (Obviously no
one would ever do that, right?)

Also, handle leaks:

while(true) {
  make a subprocess, which creates a semaphore and crashes;
}

>
> The main question is, is NOFILE a realistic concern, and what other probl=
ems
> might there be, in terms of making these heavier objects? Besides memory =
usage
> I can't think of any, but of course I don't have much knowledge of this a=
rea.

Years ago there was some discussion of making struct file
lighter-weight for light-weight things that aren't files.  And, in any
case, even the little integer indices in your code aren't free -- they
just aren't accounted as files.

And struct file isn't *that* bad.  I bet it's not dramatically bigger,
or even smaller, than whatever the Windows kernel stores for a
semaphore handle.

--Andy


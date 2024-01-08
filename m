Return-Path: <linux-kernel+bounces-19726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E75498271F6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 024D51C22AFF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57DC46B8E;
	Mon,  8 Jan 2024 14:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="RJU3hCOO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7E745C18;
	Mon,  8 Jan 2024 14:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=eeXtdx992y+1nJUpXYwWG19Qi8cqqD3QCgs9gZkGRVw=; b=RJU3hCOOKl9TthnSWlI9/vqN1w
	++SllsTqIyWLVyh3itvO5JO3Mr0EYyn0RTszfozQUgUZQ3So6QvzUozTDE0AGPGngr0b/JniJMZ80
	p3W7uHj0NLHrfu+pL2PeQTN+oVHes+5pYE/LUaf8C/4vcew3jSoC4z+iZjbTjHVqLQRsq1sCzIvFR
	cxH07pVhBo0tYdBYIB9iroixwcRL4bp91upCQuG/SwL94rGZqAFWSJ63z7CTHCjFqTHOyTLfypb9J
	8nwEe64n6URWC8+E9uXkzsCYPVRdOV09V/JUFMda5ZZ4yeBcdJzfs+639VpjSHOY9mZE/DTuHFoxA
	9UJWqayb5aAgwLAoHTCOPBW1im824y4iLxk7s4wtAy5vQ1MUaTtg2bgMeA3bSD7sEuwmVcHmTCKi8
	toGPuK5VEqWSAl+/BF8r7oOypYrJ6258Y77yRQUH0HZimkEo5AmNYELQa0CvlYHML5wm4kuWyTANv
	dt75uUlhYPkPFIoP1xeLQJRTE48iL7S/YUu5dwwVDIdKmkHBjnQl9ox3u/0mCuEiULDcD7/gJq6ZY
	z6q/GQIfQlOxSqSQ9NZpWiOOV/pZ1mqe8gY2kPS5QiHBc/OAo+yxcFioS0339Uju7ZHa5z/f7FrZ3
	1FOHjLWC1WlOG1CbEk9BG/OUfpdtqD6qd3VUZSBrs=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Eric Van Hensbergen <ericvh@kernel.org>
Cc: asmadeus@codewreck.org, linux-kernel@vger.kernel.org,
 v9fs@lists.linux.dev, rminnich@gmail.com, lucho@ionkov.net
Subject: Re: [PATCH] fs/9p: fix inode nlink accounting
Date: Mon, 08 Jan 2024 15:55:53 +0100
Message-ID: <7785659.j189Hiylts@silver>
In-Reply-To:
 <CAFkjPTn0HFnnZk8rt7m+mfLyPofMxZC6EzaoFChoyRVdVnwM6Q@mail.gmail.com>
References:
 <20240107-fix-nlink-handling-v1-1-8b1f65ebc9b2@kernel.org>
 <8004884.rDQMAZhJ5Z@silver>
 <CAFkjPTn0HFnnZk8rt7m+mfLyPofMxZC6EzaoFChoyRVdVnwM6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Monday, January 8, 2024 3:12:24 PM CET Eric Van Hensbergen wrote:
> On Mon, Jan 8, 2024 at 6:08=E2=80=AFAM Christian Schoenebeck
> <linux_oss@crudebyte.com> wrote:
> >
> > On Monday, January 8, 2024 12:19:34 PM CET asmadeus@codewreck.org wrote:
> > > Eric Van Hensbergen wrote on Sun, Jan 07, 2024 at 07:07:52PM +0000:
> > > > I was running some regressions and noticed a (race-y) kernel warnin=
g that
> > > > happens when nlink becomes less than zero.  Looking through the code
> > > > it looks like we aren't good about protecting the inode lock when
> > > > manipulating nlink and some code that was added several years ago to
> > > > protect against bugs in underlying file systems nlink handling didn=
't
> > > > look quite right either.  I took a look at what NFS was doing and t=
ried to
> > > > follow similar approaches in the 9p code.
> > >
> > > I was about to say the set/inc/etc_nlink helpers could probably just =
be
> > > using atomic (there's an atomic_dec_if_postive that we could have used
> > > for the v9fs_dec_count warning), but this isn't our code so not much =
to
> > > do about that -- I agree it needs a lock.
> > >
> > > I didn't take the time to check if you missed any, but it won't be wo=
rse
> > > than what we have right now:
> > > Acked-by: Dominique Martinet <asmadeus@codewreck.org>
> >
> > That's actually a good point. For these tasks atomic inc/sub/etc are us=
ually
> > used instead of locks.
> >
> > I would at least add local wrapper functions that would do these spinlo=
cks for
> > us.
> >
>=20
> I'm good with adding local wrapper functions,  I imagine these aren't
> used in the kernel because for regular file-systems maybe you want the
> warning that your inode link accounting is wrong.
> I suppose we could be naughty and not use the kernel functions (which
> themselves are basically wrappers).

Well, one half of that code is actually using atomic operations to incremen=
t/
decrement the private counter. Which means to me those kernel functions were
intended to be called from a concurrent context. So I don't get why the oth=
er
variable is not atomic there. They should be I think.

I would probably try and send a patch for changing those kernel functions a=
nd
see if people are fine with that. But up to you.




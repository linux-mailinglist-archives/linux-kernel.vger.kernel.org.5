Return-Path: <linux-kernel+bounces-128600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA30895CEF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACE131C21BA1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63E015CD53;
	Tue,  2 Apr 2024 19:43:02 +0000 (UTC)
Received: from mail.lichtvoll.de (lichtvoll.de [89.58.27.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EF115B972;
	Tue,  2 Apr 2024 19:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.27.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086982; cv=none; b=RsAb8MnltWq7mkajqHf7Tt+tmot9uH355Vr5gWD87xy4AfK4ICPgVUbPds0SvdRdulwR0U6WyibgtphMAe/VEUEUq5dyFL0BJC/Pq8yn2upjrO1zZ2hwynn8/YyfvSSNsD69Gh6ZoTQh6LYJmMXX8D1eG2qWLERqsmWmqR9t29o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086982; c=relaxed/simple;
	bh=T2zD/3mEbZDKBbyeVef0lMlUrsq/eZAor3kTjCaqZq8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uHEal2uDs/WWdopDYkExoij2S3seS8Rd9RHOOryK7j/iEn4MranTT9MzWuRtU9D11ulMLBHQL7efW5z7+qNsW4YryQFRB//ExbtDBeSX58iLfk9NETU8EByZTSR3e26paPFkKdAq5gXgH6CjdgZbVyJYtEZFE66xPkvHTwKTpc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de; spf=pass smtp.mailfrom=lichtvoll.de; arc=none smtp.client-ip=89.58.27.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail.lichtvoll.de (Postfix) with ESMTPSA id A96EA872F;
	Tue,  2 Apr 2024 19:42:58 +0000 (UTC)
Authentication-Results: mail.lichtvoll.de;
	auth=pass smtp.auth=martin@lichtvoll.de smtp.mailfrom=martin@lichtvoll.de
From: Martin Steigerwald <martin@lichtvoll.de>
To: linux-pm@vger.kernel.org, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Linux regressions mailing list <regressions@lists.linux.dev>
Subject:
 Re: [regression] 6.8.1: fails to hibernate with
 pm_runtime_force_suspend+0x0/0x120 returns -16
Date: Tue, 02 Apr 2024 21:42:58 +0200
Message-ID: <22240355.EfDdHjke4D@lichtvoll.de>
In-Reply-To: <be5a7213-78b3-4917-b95b-ec31cd2350e4@leemhuis.info>
References:
 <2325246.ElGaqSPkdT@lichtvoll.de> <12401263.O9o76ZdvQC@lichtvoll.de>
 <be5a7213-78b3-4917-b95b-ec31cd2350e4@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Hi Thorsten, hi,

Linux regression tracking (Thorsten Leemhuis) - 19.03.24, 09:40:06 CEST:
> On 16.03.24 17:12, Martin Steigerwald wrote:
> > Martin Steigerwald - 16.03.24, 17:02:44 CET:
> >> ThinkPad T14 AMD Gen 1 fails to hibernate with self-compiled 6.8.1.
> >> Hibernation works correctly with self-compiled 6.7.9.
> >=20
> > Apparently 6.8.1 does not even reboot correctly anymore. runit on
> > Devuan. It says it is doing the system reboot but then nothing
> > happens.
> >=20
> > As for hibernation the kernel cancels the attempt and returns back to
> > user space desktop session.
> >=20
> >> Trying to use "no_console_suspend" to debug next. Will not do bisect
> >> between major kernel releases on a production machine.
>=20
> FWIW, without a bisection I guess no developer will take a closer look
> (but I might be wrong and you lucky here!), as any change in those
> hundreds of drivers used on that machine can possibly lead to problems
> like yours. So without a bisection we are likely stuck here, unless
> someone else runs into the same problem and bisects or fixes it. Sorry,
> but that's just how it is.

I have been asked this repeatedly with previous bug reports. My issue
with bisecting between major kernel versions is this:

When I look around here I see no second ThinkPad T14 AMD Gen 1 here I=20
could use for testing. Also doing a kernel bisect using a GRML live iso=E2=
=80=A6=20
not really.

The one I reported this from is a production machine with a 4 TB NVMe
SSD which contains a lot of data. I am not willing to risk data loss or
(silent) file system corruption by bisecting between major kernel
releases. Bisecting between major kernel releases in my understanding
would require to test various releases between in this example 6.7 and
6.8 and even between 6.7 and 6.8-rc1. At least in my understand anything=20
between 6.7 and 6.8-rc1 is not guaranteed to be even be somewhat stable. I=
=20
am not usually installing an rc1 kernel on a production machine, but=20
rather wait for at least rc2/3 nowadays. Its a balanced risk calculation.=20
And rc2/3 or later appears to be a risk I am willing to take. But=20
something between stable and rc1? Nope.

It is not even that rare. 6.7 some rc failed with hibernation as well.=20
With exactly the same machine. I refused to do a bisect as well in that=20
case. At some later time the issue was fixed without me doing anything=20
more.

Now my question is this: Without me willing to bisect in that case, is
a bug report even useful? Otherwise I may just switch this last machine
to distribution kernels. It would save a lot of time for me. This private=20
and freelancer production machine is the last left-over machine with self-
compiled kernels.

So far I still thought I would somehow be contributing to Linux kernel
quality with detailed bug reports that take time to write, but apparently=20
I am not. Can you clarify?

Ciao,
=2D-=20
Martin




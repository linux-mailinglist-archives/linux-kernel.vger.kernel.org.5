Return-Path: <linux-kernel+bounces-132924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF71899C12
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52A17284D9B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AC916C6AE;
	Fri,  5 Apr 2024 11:49:15 +0000 (UTC)
Received: from mail.lichtvoll.de (lichtvoll.de [89.58.27.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7F016C696;
	Fri,  5 Apr 2024 11:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.27.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712317755; cv=none; b=NdAUdo5NPCgH+Co3HgXNyDjMVczhsRQZLxZ2VV9YLcuAJfd6YsTz3EIPIHvyLhUDNLO/IoP166WhV0lSQVgGrzGq5mVOyVbkWyzRR86hetXX3z/oXbDatgeDIKdygbuqxbrA04NHBzEMbXoUVGS7vvNd51/9imdj1FJupROvP5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712317755; c=relaxed/simple;
	bh=1OjGkRdD/bYDsePiq+qSN6i3amCm1EPH02CPR05K2vM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kiL5yqvjfP82v0mQgbKnOZe8sdzqSGyKulNMBsuFlrsCuc2zXQF1v6F3rsIYpP3DTGfkPazKcMR+RLY3R9psbz/rffkjT5xyIWnZQBzizEs5tIDjoRmRvTu/cAOnLo9FsibNHGL3f6uBayHlBhY6niBFV1nYJd2LOr+Grt4lmVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de; spf=pass smtp.mailfrom=lichtvoll.de; arc=none smtp.client-ip=89.58.27.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail.lichtvoll.de (Postfix) with ESMTPSA id 7EE44A155;
	Fri,  5 Apr 2024 11:49:04 +0000 (UTC)
Authentication-Results: mail.lichtvoll.de;
	auth=pass smtp.auth=martin@lichtvoll.de smtp.mailfrom=martin@lichtvoll.de
From: Martin Steigerwald <martin@lichtvoll.de>
To: linux-pm@vger.kernel.org, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Linux regressions mailing list <regressions@lists.linux.dev>
Subject:
 Re: [regression] 6.8.1: fails to hibernate with
 pm_runtime_force_suspend+0x0/0x120 returns -16
Date: Fri, 05 Apr 2024 13:49:00 +0200
Message-ID: <6034738.lOV4Wx5bFT@lichtvoll.de>
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
Content-Type: text/plain; charset="iso-8859-1"

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

The plot thickens, now 6.7.12 as compared to 6.7.11 which failed hibernation
with busy work queues=B9 and 6.7.9 + bcachefs downgrade fixes fails
hibernation with the same error message than 6.8.1:

[   74.330285] PM: hibernation: hibernation entry
[   74.617009] Filesystems sync: 0.097 seconds
[   74.617309] Freezing user space processes
[   74.620021] Freezing user space processes completed (elapsed 0.002 secon=
ds)
[   74.620048] OOM killer disabled.
[   74.620250] PM: hibernation: Marking nosave pages: [mem 0x00000000-0x000=
00fff]
[   74.620253] PM: hibernation: Marking nosave pages: [mem 0x0009f000-0x000=
fffff]
[   74.620256] PM: hibernation: Marking nosave pages: [mem 0x09c00000-0x09d=
00fff]
[   74.620261] PM: hibernation: Marking nosave pages: [mem 0x09f00000-0x09f=
0ffff]
[   74.620263] PM: hibernation: Marking nosave pages: [mem 0xa22b7000-0xa22=
b7fff]
[   74.620264] PM: hibernation: Marking nosave pages: [mem 0xa22c4000-0xa22=
c5fff]
[   74.620266] PM: hibernation: Marking nosave pages: [mem 0xa22d3000-0xa22=
d4fff]
[   74.620267] PM: hibernation: Marking nosave pages: [mem 0xa22e5000-0xa22=
e5fff]
[   74.620269] PM: hibernation: Marking nosave pages: [mem 0xb9533000-0xb95=
c3fff]
[   74.620272] PM: hibernation: Marking nosave pages: [mem 0xbd9de000-0xcc3=
fdfff]
[   74.620752] PM: hibernation: Marking nosave pages: [mem 0xce000000-0xfff=
fffff]
[   74.622717] PM: hibernation: Basic memory bitmaps created
[   74.629269] PM: hibernation: Preallocating image memory
[   76.658495] PM: hibernation: Allocated 2042025 pages for snapshot
[   76.658875] PM: hibernation: Allocated 8168100 kbytes in 2.02 seconds (4=
043.61 MB/s)
[   76.658901] Freezing remaining freezable tasks
[   76.660457] Freezing remaining freezable tasks completed (elapsed 0.001 =
seconds)
[   76.666115] port 0000:02:00.1:0.0: PM: dpm_run_callback(): pm_runtime_fo=
rce_suspend+0x0/0x120 returns -16
[   76.666255] port 0000:02:00.1:0.0: PM: failed to freeze: error -16
[   78.616495] psmouse serio1: synaptics: queried max coordinates: x [..567=
8], y [..4694]
[   78.654349] psmouse serio1: synaptics: queried min coordinates: x [1266.=
=2E], y [1162..]
[   79.106531] PM: hibernation: Basic memory bitmaps freed
[   79.106855] OOM killer enabled.
[   79.106873] Restarting tasks ... done.
[   79.111514] PM: hibernation: hibernation exit

Not doing it today or probably the weekend, but now I have some actionable
git bisect plan without bisecting between major kernel releases which as I
have been told between 6.7 an 6.8-rc1 can lead to non working modeset
graphics on AMD Ryzen in between.

It seems now I only need to git bisect between 6.7.11 and 6.7.12 to find the
patch that breaks hibernation on 6.8.1 as well. However first I will briefly
check whether 6.8.4 hibernates okay.

[1] * 6.7.11: Fails to hibernate - work queues still busy
@ 2024-04-02 19:29 Martin Steigerwald

https://lore.kernel.org/regressions/2ad93b57-8fdc-476e-83b7-2c0af1cfd41d@le=
emhuis.info/T/#t

Best,
=2D-=20
Martin




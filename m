Return-Path: <linux-kernel+bounces-39117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1A983CB08
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C01A1C25F23
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589AE1350E6;
	Thu, 25 Jan 2024 18:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iCylgfo0"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A0E1339A3
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 18:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706207055; cv=none; b=q/9gPXMAY6c6Uk0T0p5eW+6QfqhQP0O+JmEc2BP2xV9UXCsx81Gw/lMzzgGiJpfxblilJ8611TqACTcjM0NSLmuNWaEO81qbuFq7Yza3sFd5zkVZXzcV9grAj3/sfpcMrzxGA2GAWBesmo8tsgsJXTJ0PI2i8wCqVTSsNLo5JoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706207055; c=relaxed/simple;
	bh=xBV/3/6RdfeVxU/KK6DrFXOPuu6fYWfziuz93+hEUTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pMx10r065ne3mtY5OuldZBLo6iKjLMXgTGbpEach88tg4gOX/Cxor/CF0fyto0o0tgisAHqZzicAJM+Y2FspbeuGGs3Mj/Zaaz3KgvYoe3pKF16Voix60isuy+6J49fT50yfmVCof+KFoK5k27jQlxVdYEWcc4hmAoYEMJ88mA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iCylgfo0; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d72d240c69so7065ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 10:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706207053; x=1706811853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVbxbr6LNVA4m+1guLf1yBKa8ZYscvBPPrsKeyi1Y40=;
        b=iCylgfo0Uaq6tWHCehMcjWeTSznhR4nN+337ynu6UCLUq2qY+RZUSUSmbV6zWHosoO
         o/vCLOJPYkWLdYYBfUfcSPMsGGnzzvqENmxbnSH9DGMfa3nFNGZXs+i48Po5vgpfcreA
         QZUHBsVY2LzRT9fuRF5smzhrXmoNOkGm5E/0aoHPelaRtcGIg18P7UfQCtE0MFcmmBcE
         qGcDerCrTFonn0bfHO8ZIvGJs5751xCw6dyOO1AYd3+aPuuTIe66WnpUN6QgSx5cRBam
         5hyUYMGu289YiKXqdCst6w4aRRrO94UbFntbKG8aK7gYW9EJCVR0U3GxRyJR+4mGsAi7
         7Hlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706207053; x=1706811853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bVbxbr6LNVA4m+1guLf1yBKa8ZYscvBPPrsKeyi1Y40=;
        b=IWqcb4f3vZ6sSrq04+U5ZoL/CvgkM5tURzjNvg/MX/BMrfFhXFfzZMkM/pCQiU8tL9
         AUxOjJf1l89PArRjMxzjaXx3PXp6cPpqkywnok3nELu66xnDnV40s3oiLI81U0M2a9X1
         DdNfqtekDhbU6X3vqlW8t5Zn2OxGldw6uyOYfMkeNj0cS2tFv+JCShzUFKljpSPt5jFu
         FiAuNdfbnoJZw1UsCCxLc+mQ2rV8oSotaUwuadcHf0hp8jfw5uWqkM7d0dCSScInD4+i
         rkEp8rBZXLlgGWaMrQ1Ofe7rIMX7L6KFJh04brChtaOa9Qiu+NeYRm3pwI/Vxtbnb8wl
         YpoA==
X-Gm-Message-State: AOJu0YyClG+ZhS5qEXcJ8s2T+wxxrxomcgGVtQHlKPGxxQzqz4g/XVqz
	vgCGf/teZi+m+A5xSSDbK6TpD11VHAnHM0EjtLXrtPYc8OIRIVf4nJ/sAcke2qV4zNKEGVHta37
	rgpKRKTwwQDaYwa0WMfwu4WCbU2Jdipz5hGDv
X-Google-Smtp-Source: AGHT+IG4ktaL/+qGghqfraAYkeHm+Jg0sX/q3huOFE8F/jos8hIAyxhdJFLMRVOuCCBDJoL8nJCKQu0dlG83Bi5eCMg=
X-Received: by 2002:a17:903:607:b0:1d6:f66b:1057 with SMTP id
 kg7-20020a170903060700b001d6f66b1057mr300590plb.28.1706207052993; Thu, 25 Jan
 2024 10:24:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000083513f060340d472@google.com> <000000000000e5e71a060fc3e747@google.com>
 <20240125-legten-zugleich-21a988d80b45@brauner> <11868eb4-0528-4298-b8bc-2621fd1aac83@kernel.dk>
 <20240125-addition-audienz-c955ab3c8435@brauner>
In-Reply-To: <20240125-addition-audienz-c955ab3c8435@brauner>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Thu, 25 Jan 2024 19:24:01 +0100
Message-ID: <CANp29Y69y5Ctmcrf4SFFrMAD1hzsx+GYriDaa9q=3aexRspaxw@mail.gmail.com>
Subject: Re: [syzbot] [jfs?] INFO: task hung in path_mount (2)
To: Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, 
	syzbot <syzbot+fb337a5ea8454f5f1e3f@syzkaller.appspotmail.com>, hdanton@sina.com, 
	jack@suse.cz, jfs-discussion@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 5:47=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Thu, Jan 25, 2024 at 09:11:34AM -0700, Jens Axboe wrote:
> > On Thu, Jan 25, 2024 at 9:08?AM Christian Brauner <brauner@kernel.org> =
wrote:
> > >
> > > On Thu, Jan 25, 2024 at 03:59:03AM -0800, syzbot wrote:
> > > > syzbot suspects this issue was fixed by commit:
> > > >
> > > > commit 6f861765464f43a71462d52026fbddfc858239a5
> > > > Author: Jan Kara <jack@suse.cz>
> > > > Date:   Wed Nov 1 17:43:10 2023 +0000
> > > >
> > > >     fs: Block writes to mounted block devices
> > > >
> > > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1317=
5a53e80000
> > > > start commit:   2ccdd1b13c59 Linux 6.5-rc6
> > > > git tree:       upstream
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D9c37cc0=
e4fcc5f8d
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dfb337a5ea=
8454f5f1e3f
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D17ba5=
d53a80000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1426537=
3a80000
> > > >
> > > > If the result looks correct, please mark the issue as fixed by repl=
ying with:
> > >
> > > #syz fix: fs: Block writes to mounted block devices
> >
> > Like Dave replied a few days ago, I'm kind of skeptical on all of these
> > bugs being closed by this change. I'm guessing that they are all
> > resolved now because a) the block writes while mounted option was set t=
o
> > Y, and b) the actual bug is just masked by that.

Yes, that's true. For a) there are also two sub-reasons:
1) The bug itself is indeed no longer reproducible because of this new
kernel option.
2) The bug is not reproducible because the change broke the way
syzkaller did the mounts -- we used to hold an fd to the loop device
while doing the mount. That was fixed[1] soon after the commit reached
torvalds, but for bisections syzbot has to build syzkaller exactly at
the revision when the reproducer was found (otherwise it may parse the
syz reproducer incorrectly). So this kernel commit becomes exactly the
point where the reproducer stops working.

For most of the recently closed fs bugs (2) should not be the primary
reason though -- these fix bisections are done only when syzbot
stopped seeing crashes with the corresponding titles, which was very
likely caused by (1) in the first place.

[1] https://github.com/google/syzkaller/commit/551587c192ecb4df26fcdab775ed=
145ee69c07d4

> >
> > Maybe this is fine, but it does seem a bit... sketchy? The bugs aren't
> > really fixed, and what happens if someone doesn't turn on that option?
> > If it's required, perhaps it should not be an option at all? Though
> > that'd seem to be likely to break some funky use cases, whether they ar=
e
> > valid or not.
>
> We have no way of actually testing or verifying this stuff and a lot of
> these have been around for a long time. For example, this report here
> has a C reproducer but following the actual dashboard link that
> reproducer is striked-through which supposedly means that it isn't valid
> or reliable. And no other reproducer ever showed up.
>
> As far as I can see we should just close reports such as. If this is a
> real bug that is separate from the ability to mount to writed block
> devices then one should hope that syzbot finds another reproducer that
> let's us really analyze the bug?

Yes, if the ability to write to the block device is not really
necessary to trigger the bug, syzbot should find it again in some
time.

>
> A separate issue is that syzbot keeps suggesting as all of these being
> closable because of this. So how serious can we take this and how much
> time can/should we spend given that we got ~20 or more of these mails in
> the last two weeks or so.

I can add the "fs: Block writes to mounted block devices" commit to
the black list for syzbot bisections -- it will stop sending such
emails then.

--=20
Aleksandr

>
> I have no better answers than this tbh. And fwiw, apart from this one I
> haven't closed a single bug based on this.
>
> And yes, ideally the ability to write to mounted block devices should be
> turned off. But we'll have to let it trickle into the individual
> distributions first and make remaining userspace tools that rely on this
> move to alternate apis before we can make any serious effort.
>


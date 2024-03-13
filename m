Return-Path: <linux-kernel+bounces-101709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 279B687AAD6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C7001C21C1E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D87481CD;
	Wed, 13 Mar 2024 16:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="QnkD+bn7"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF29D481A5
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 16:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710345722; cv=none; b=NvXjp2RlTKiVDVFABNo7gRFNTR7r6h7Wf290MBGgLYDHiC9HTGA4YhthsnPf5Gimaa08sMwwQ+yjVk8Y4jKm7p0IdNlcKI1YeoSPzZfRl//KSz6RemffLPBYDAtotobwLvzCSKsESlK4Av5OBbewTVku9TqDGULuWAaO+Oenb+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710345722; c=relaxed/simple;
	bh=skEFlYVRbGKrwaoRI9SBnK72i4qW8cNFfPFUKmMt/V4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=In5phVLK67Frjo5wVEKJLT8ZYhF7SRIlbrk25B2pWRBfkAg2ytRIB8antGp6Trtk7HZuob1NxyjRUV3zC3ycOLacjVNEwbEzT//o63Jekzp85u7IwMgUh+f5kqTLFyTjAf53xED1dxqxhGDL1j2w3lehFhbEl76JWAe49qN4sLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=QnkD+bn7; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d4541bf57eso16699451fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 09:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1710345719; x=1710950519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhI7fuOW7O94CdymJJXoJUrg+PQKoUQdDuMwFu4gOLk=;
        b=QnkD+bn71GHRBfgc2+oSSOVxJjg7U9yLCwoek6EifD2I2yLHdXnWMA/utDeelZjPVS
         3wBbvzkX+2tI82+N4Y2GQ4/JUz2q0VA9k5sLZ61XoZmid8cfkRR1QOAzQM1/xTwsDk6P
         19ZqznP79EZXH9VUbFd/XBScIXpM7kSFSNdME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710345719; x=1710950519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PhI7fuOW7O94CdymJJXoJUrg+PQKoUQdDuMwFu4gOLk=;
        b=kVD0cbwx7lzjtyP+kCX8aMv38OahVODgCrovH2BNWZHdA1edsv0u8TWQKXCn1HegBy
         8u6BpGIY/agGJqUOY7crrMnXSAYb0SmIFL5iIoWZ+Vr6SWRW04WhawunjJ48D7ksfqrY
         SHXIWmApHsPa6DLy9V63wnUA325NJiBIw8jj/aLkVafalQEaJy05hlvl2QMRtdi5r+KJ
         YTQAWeGXCASHHD/QVRkEB50Ri3BVd10W8xV2iu8HLokpyddXfu2CavAgzHuAc771Zyj/
         C+1rYobka8DMjq45JXReLunanOvt4Y5necOPgXqghQgwsTqc1NOQ1MGtqco8zyWVhab+
         ebRA==
X-Forwarded-Encrypted: i=1; AJvYcCXERvHMfVlz7CTEn4wGPWgxPSqSHIUBCYW5xS9UjLl3o20e44Ghf9rrgbiiIZFLIW5LCjrMPH5U7ZzaTSVG/hdf2V9xLqw9urB68Ezf
X-Gm-Message-State: AOJu0Yy+u+Wju/0hRGbELBMQ2yKuo1f7ZPpIkKBQ5USyNxlaAhD36Hww
	XMyEN/Hr9UWIxWkRKR1L7RPP7dPRcFq+jb2aWq48l5ML5iqujJ5i4Or7Y3VR6sNFkrOm5lDEDZs
	zEG5qUD2PDvsXGMVDJqXOBbTm/GOJbp+4qXCEvA==
X-Google-Smtp-Source: AGHT+IEB+ypKw1227kSwoEpCb58giwsbWQ7T3kqHZKNM52jxhQC6RiCthXFaTfppDX19xNPkqW1S/iblz4CA4LMGbpA=
X-Received: by 2002:a05:651c:3c9:b0:2d4:6e5:2cd6 with SMTP id
 f9-20020a05651c03c900b002d406e52cd6mr2361699ljp.25.1710345718592; Wed, 13 Mar
 2024 09:01:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZetHwrCb0KXE0xFI@tardis> <4274be61-60bd-4e1e-9c16-26e6e5e06f65@gmail.com>
 <ZfDEIs63EBIYBJIC@boqun-archlinux> <c5f9c640-4c06-495e-9c7e-0c208b914fa7@gmail.com>
 <CAHk-=wgP=9JxdOJ5oYtVO5yM6pFi5+3FPxfCQa4ezpagJuXq3g@mail.gmail.com> <ZfDptafiK0jns050@boqun-archlinux>
In-Reply-To: <ZfDptafiK0jns050@boqun-archlinux>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Wed, 13 Mar 2024 12:01:45 -0400
Message-ID: <CAEXW_YRvz8xf-6hpwpYqS=YNa-xkn4CsuJzELJxOH_2FP+6ptQ@mail.gmail.com>
Subject: Re: Unexplained long boot delays [Was Re: [GIT PULL] RCU changes for v6.9]
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Florian Fainelli <f.fainelli@gmail.com>, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, paulmck@kernel.org, 
	mingo@kernel.org, tglx@linutronix.de, rcu@vger.kernel.org, 
	neeraj.upadhyay@amd.com, urezki@gmail.com, qiang.zhang1211@gmail.com, 
	frederic@kernel.org, bigeasy@linutronix.de, anna-maria@linutronix.de, 
	chenzhongjin@huawei.com, yangjihong1@huawei.com, rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Florian,

On Tue, Mar 12, 2024 at 7:48=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Tue, Mar 12, 2024 at 02:44:14PM -0700, Linus Torvalds wrote:
> > On Tue, 12 Mar 2024 at 14:34, Florian Fainelli <f.fainelli@gmail.com> w=
rote:
> > >
> > > and here is a log where this fails:
> > >
> > > https://gist.github.com/ffainelli/ed08a2b3e853f59343786ebd20364fc8
> >
> > You could try the 'initcall_debug' kernel command line.
> >
>
> Right, that'll be helpful.
>
> Besides I took a look at the config Florian shared, no TASKS_RCU,
> RCU_LAZY or RCU nocb is enabled. So probably the only left changes in
> the PR are around RCU expedited. Florian, could you see if you can build
> and test with CONFIG_PROVE_RCU=3Dy (you need to select
> CONFIG_PROVE_LOCKING for that)? That'll call synchronize_rcu() +
> synchronize_rcu_expedited() before and after we switch
> rcu_scheduler_active, and it may provide more information. Thanks!

Adding to everyone's suggestions, could you also try booting with
"rcupdate.rcu_normal=3D1" ? This will disable expedited RCU and help us
further confirm that it is indeed expedited RCU (and then we can look
into fixing that).

Also there are 2 additional users of expedited RCU in this release I notice=
d:

78c3253f27e5 ("net: use synchronize_rcu_expedited in cleanup_net()")
1ebb85f9c03d ("netfilter: conntrack: expedite rcu in
nf_conntrack_cleanup_net_list")

Could you also try reverting those patches as well, and see if the
issue goes away?

thanks,

 - Joel

On Tue, Mar 12, 2024 at 7:48=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Tue, Mar 12, 2024 at 02:44:14PM -0700, Linus Torvalds wrote:
> > On Tue, 12 Mar 2024 at 14:34, Florian Fainelli <f.fainelli@gmail.com> w=
rote:
> > >
> > > and here is a log where this fails:
> > >
> > > https://gist.github.com/ffainelli/ed08a2b3e853f59343786ebd20364fc8
> >
> > You could try the 'initcall_debug' kernel command line.
> >
>
> Right, that'll be helpful.
>
> Besides I took a look at the config Florian shared, no TASKS_RCU,
> RCU_LAZY or RCU nocb is enabled. So probably the only left changes in
> the PR are around RCU expedited. Florian, could you see if you can build
> and test with CONFIG_PROVE_RCU=3Dy (you need to select
> CONFIG_PROVE_LOCKING for that)? That'll call synchronize_rcu() +
> synchronize_rcu_expedited() before and after we switch
> rcu_scheduler_active, and it may provide more information. Thanks!
>
> Regards,
> Boqun
>
> > It will make the above *much* noisier, but it might - thanks to all
> > the new noise - show exactly *what* is being crazy slow to initialize.
> >
> > Because right now it's just radio silence in between those
> >
> >   [    1.926435] bcmgenet f0480000.ethernet: GENET 5.0 EPHY: 0x0000
> >   [  162.148135] unimac-mdio unimac-mdio.0: Broadcom UniMAC MDIO bus
> >
> > things, and that's presumably because some random initcall there just
> > takes forever to time out.
> >
> >              Linus


Return-Path: <linux-kernel+bounces-90476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B12EA86FFC3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 671EA281938
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE48383B4;
	Mon,  4 Mar 2024 11:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CQhfIRau"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97907376F9
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 11:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709550399; cv=none; b=Prew5015M2DzOo9BmYwAU0gWo5ANAj8Hv9kllC9h4GD8nprmwxe6/O4VQ3XAl0+Cd49GP2+0v8k+5b1hs3kJz3nom91Zri53G+beq49INW0IHP8KEYV8qpScWIQpClAFqVi8kkFNmZJqwff+z3l7QlUkpToDJq9eMvLyMkCkYEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709550399; c=relaxed/simple;
	bh=AKyYXQuGpHGdgrax2QfR8MIXUBvB9lMPOboMV9ivIg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EwCuad/+R729TQ62ooLRLHW/3SS3zsOB615CGTz8QtnRaAT0T83AB7VCfYFQkwZK9sIzqphNSyPUlTFFRgAS5AW96FVV6+Qsk7lmLfg5hUR8e7VJ89morpquDdVKUsVhAhMwTkm56VuYfRhnmzwCJL/PoMKbiOQVqfXWRdsFuUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CQhfIRau; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709550395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NgrMrv3/i2xavSJaYF0r12WWFk3+aFKbxQx5Q9iepN0=;
	b=CQhfIRau1I3swnUL0vxL8v8zaOId4jkajp05iD7PuEBU9y4q1R+u1ymhCgIP9dlHlkzICc
	vHgo6ghu/QS5zPevhwC2d4zBvMMVal5/jj6PYTbiQ1hB7bMAHiaG7VKFxQrvfNSKEFxx5e
	jXHbPg3t56vn/0NzXPffe10Z7lazsqU=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-5TP5s09JPVSGl3jBxJLnog-1; Mon, 04 Mar 2024 06:06:34 -0500
X-MC-Unique: 5TP5s09JPVSGl3jBxJLnog-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-29954faf16dso3406650a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 03:06:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709550393; x=1710155193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NgrMrv3/i2xavSJaYF0r12WWFk3+aFKbxQx5Q9iepN0=;
        b=itI7ZW47lz6vFm1SuB5VJzB+ncy5l43a+gvT+L1Y0nnuRG+LRXcdNgX/3NtxauWtjx
         tHXxglSi7lnc4bJ5PGdi63LRaeJO4FYVaqBDGUYPlVRGaDv9F4Ar5NQPDpDsrToXQkVY
         p4FIcPLvo1dGGX4MaA7hW2BvwAcPun4VMOvTUDpVNQ69UbvEFul/vtRN+I96VrY9pvcK
         jqbFCWZ4GIxHb/01ETRY3fTJeZipXpWiWQxIPHxnWRWaCveeOTCYCeyISQWTPNADEl5x
         /dzZ2lR11ehglIuVK6EiKCDb6W33pMTBdsrhA6R4xWq9H6w9RRK7VkxcSaqiFj+77HoP
         TwNw==
X-Forwarded-Encrypted: i=1; AJvYcCWXS0O95bsKKnkMzI4VBe13pPlrZk7mDL65nNuEQvTeMXoqnfhh6/RAyTOEYC9TT4NCf0BbDJ5dAhUAnUH4VvgyY0tLEM6qDjGZsFbh
X-Gm-Message-State: AOJu0YwYGyQK0TCf3GBgM9QtSOq18hn70ymdSyKO/1Wa3VWrGKz2GyoY
	y0Ss2Zs7klDUpTBfwiGTgaA8PV2YhEHnkTQsZO/8OG6fljaaok7qugQE/R8FuA1i+ywvh6x6c/T
	IoMnKQ5jaPB2k6wE9VBvpIy3gU0/FpatvCJV/p/szBAzT9ASRGQMhAptOeKqtnrrjUYYjlyiFfL
	cMfuyu/DTV8HzYQ1SUNcoyUYnZ/qJTFQpVy1DF
X-Received: by 2002:a17:90a:5986:b0:299:63bd:c17d with SMTP id l6-20020a17090a598600b0029963bdc17dmr11339146pji.2.1709550393078;
        Mon, 04 Mar 2024 03:06:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcbtT5DaGGKaNkeEjvKzECNHenxMp1SBObuazw/kY0fiLXb12Bve5b/NrYyCNmUMboRp/o7HTlEgllktCgsP8=
X-Received: by 2002:a17:90a:5986:b0:299:63bd:c17d with SMTP id
 l6-20020a17090a598600b0029963bdc17dmr11339121pji.2.1709550392734; Mon, 04 Mar
 2024 03:06:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301095657.662111-1-yukuai1@huaweicloud.com>
 <CALTww2-GV-YBX1ey4juaVHjHz-wNS0xRBqBn=ucDXEb4WNbSOg@mail.gmail.com>
 <0091f7d1-2273-16ff-8285-5fa3f7e2e0f7@huaweicloud.com> <35feaa54-db9e-f0d6-d5a5-a10a45bb90a5@huaweicloud.com>
 <CALTww2-BmudurHbsbbqBMq+KgZs+hokqOJnovS5KDGEidHqZzA@mail.gmail.com> <CALTww2_tP9kZEeReystMVLT+UqE7gpHvLO6yrSJ_bjsfTOuaxQ@mail.gmail.com>
In-Reply-To: <CALTww2_tP9kZEeReystMVLT+UqE7gpHvLO6yrSJ_bjsfTOuaxQ@mail.gmail.com>
From: Xiao Ni <xni@redhat.com>
Date: Mon, 4 Mar 2024 19:06:21 +0800
Message-ID: <CALTww2_8B1XMaFEBtPeWae0Gse7ngqZuuRZMn32BdfW2-M8uYA@mail.gmail.com>
Subject: Re: [PATCH -next 0/9] dm-raid, md/raid: fix v6.7 regressions part2
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: zkabelac@redhat.com, agk@redhat.com, snitzer@kernel.org, 
	mpatocka@redhat.com, dm-devel@lists.linux.dev, song@kernel.org, 
	heinzm@redhat.com, neilb@suse.de, jbrassow@redhat.com, 
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 4:27=E2=80=AFPM Xiao Ni <xni@redhat.com> wrote:
>
> On Mon, Mar 4, 2024 at 9:25=E2=80=AFAM Xiao Ni <xni@redhat.com> wrote:
> >
> > On Mon, Mar 4, 2024 at 9:24=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com=
> wrote:
> > >
> > > Hi,
> > >
> > > =E5=9C=A8 2024/03/04 9:07, Yu Kuai =E5=86=99=E9=81=93:
> > > > Hi,
> > > >
> > > > =E5=9C=A8 2024/03/03 21:16, Xiao Ni =E5=86=99=E9=81=93:
> > > >> Hi all
> > > >>
> > > >> There is a error report from lvm regression tests. The case is
> > > >> lvconvert-raid-reshape-stripes-load-reload.sh. I saw this error wh=
en I
> > > >> tried to fix dmraid regression problems too. In my patch set,  aft=
er
> > > >> reverting ad39c08186f8a0f221337985036ba86731d6aafe (md: Don't regi=
ster
> > > >> sync_thread for reshape directly), this problem doesn't appear.
> > > >
> >
> > Hi Kuai
> > > > How often did you see this tes failed? I'm running the tests for ov=
er
> > > > two days now, for 30+ rounds, and this test never fail in my VM.
> >
> > I ran 5 times and it failed 2 times just now.
> >
> > >
> > > Take a quick look, there is still a path from raid10 that
> > > MD_RECOVERY_FROZEN can be cleared, and in theroy this problem can be
> > > triggered. Can you test the following patch on the top of this set?
> > > I'll keep running the test myself.
> >
> > Sure, I'll give the result later.
>
> Hi all
>
> It's not stable to reproduce this. After applying this raid10 patch it
> failed once 28 times. Without the raid10 patch, it failed once 30
> times, but it failed frequently this morning.

Hi all

After running 152 times with kernel 6.6, the problem can appear too.
So it can return the state of 6.6. This patch set can make this
problem appear quickly.

Best Regards
Xiao


>
> Regards
> Xiao
> >
> > Regards
> > Xiao
> > >
> > > diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> > > index a5f8419e2df1..7ca29469123a 100644
> > > --- a/drivers/md/raid10.c
> > > +++ b/drivers/md/raid10.c
> > > @@ -4575,7 +4575,8 @@ static int raid10_start_reshape(struct mddev *m=
ddev)
> > >          return 0;
> > >
> > >   abort:
> > > -       mddev->recovery =3D 0;
> > > +       if (mddev->gendisk)
> > > +               mddev->recovery =3D 0;
> > >          spin_lock_irq(&conf->device_lock);
> > >          conf->geo =3D conf->prev;
> > >          mddev->raid_disks =3D conf->geo.raid_disks;
> > >
> > > Thanks,
> > > Kuai
> > > >
> > > > Thanks,
> > > > Kuai
> > > >
> > > >>
> > > >> I put the log in the attachment.
> > > >>
> > > >> On Fri, Mar 1, 2024 at 6:03=E2=80=AFPM Yu Kuai <yukuai1@huaweiclou=
d.com> wrote:
> > > >>>
> > > >>> From: Yu Kuai <yukuai3@huawei.com>
> > > >>>
> > > >>> link to part1:
> > > >>> https://lore.kernel.org/all/CAPhsuW7u1UKHCDOBDhD7DzOVtkGemDz_QnJ4=
DUq_kSN-Q3G66Q@mail.gmail.com/
> > > >>>
> > > >>>
> > > >>> part1 contains fixes for deadlocks for stopping sync_thread
> > > >>>
> > > >>> This set contains fixes:
> > > >>>   - reshape can start unexpected, cause data corruption, patch 1,=
5,6;
> > > >>>   - deadlocks that reshape concurrent with IO, patch 8;
> > > >>>   - a lockdep warning, patch 9;
> > > >>>
> > > >>> I'm runing lvm2 tests with following scripts with a few rounds no=
w,
> > > >>>
> > > >>> for t in `ls test/shell`; do
> > > >>>          if cat test/shell/$t | grep raid &> /dev/null; then
> > > >>>                  make check T=3Dshell/$t
> > > >>>          fi
> > > >>> done
> > > >>>
> > > >>> There are no deadlock and no fs corrupt now, however, there are s=
till
> > > >>> four
> > > >>> failed tests:
> > > >>>
> > > >>> ###       failed: [ndev-vanilla] shell/lvchange-raid1-writemostly=
sh
> > > >>> ###       failed: [ndev-vanilla] shell/lvconvert-repair-raid.sh
> > > >>> ###       failed: [ndev-vanilla] shell/lvcreate-large-raid.sh
> > > >>> ###       failed: [ndev-vanilla] shell/lvextend-raid.sh
> > > >>>
> > > >>> And failed reasons are the same:
> > > >>>
> > > >>> ## ERROR: The test started dmeventd (147856) unexpectedly
> > > >>>
> > > >>> I have no clue yet, and it seems other folks doesn't have this is=
sue.
> > > >>>
> > > >>> Yu Kuai (9):
> > > >>>    md: don't clear MD_RECOVERY_FROZEN for new dm-raid until resum=
e
> > > >>>    md: export helpers to stop sync_thread
> > > >>>    md: export helper md_is_rdwr()
> > > >>>    md: add a new helper reshape_interrupted()
> > > >>>    dm-raid: really frozen sync_thread during suspend
> > > >>>    md/dm-raid: don't call md_reap_sync_thread() directly
> > > >>>    dm-raid: add a new helper prepare_suspend() in md_personality
> > > >>>    dm-raid456, md/raid456: fix a deadlock for dm-raid456 while io
> > > >>>      concurrent with reshape
> > > >>>    dm-raid: fix lockdep waring in "pers->hot_add_disk"
> > > >>>
> > > >>>   drivers/md/dm-raid.c | 93 ++++++++++++++++++++++++++++++++++---=
-------
> > > >>>   drivers/md/md.c      | 73 ++++++++++++++++++++++++++--------
> > > >>>   drivers/md/md.h      | 38 +++++++++++++++++-
> > > >>>   drivers/md/raid5.c   | 32 ++++++++++++++-
> > > >>>   4 files changed, 196 insertions(+), 40 deletions(-)
> > > >>>
> > > >>> --
> > > >>> 2.39.2
> > > >>>
> > > >
> > > >
> > > > .
> > > >
> > >



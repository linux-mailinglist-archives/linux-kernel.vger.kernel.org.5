Return-Path: <linux-kernel+bounces-89963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A580286F82D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 02:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C90891C20BF4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 01:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C74D1362;
	Mon,  4 Mar 2024 01:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="asXt3tEc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6D12F30
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 01:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709515572; cv=none; b=eM0wF/4KJVHHFr8PBsBw0oqaG0KEiza5/zXx+N1tTuI2Y+McMcprIB/4Vqb0sBTI9caBLGkrZ0RziQCIKiuP4a/sSAACwZN+elB3q/vS63LZBe6WfuEdFgrF4zOKdJSl62bHkF4rv8gPlkWXNhg+Qr3Ob3dmZVUSgSWmqDL9xKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709515572; c=relaxed/simple;
	bh=S07ID7UsiNh9WVeNT25TX3PVNmyMCqj6IzQIEg7TTlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U8F1fcTLLQql/gDm43gh6sn4Bbrt8yoMkXbWPm+EGzgsEhKUko1dW57yJliiDXNKh6oeeao8Lk8BWm1oukfFYHXGY1AH/gZgMlQXQ4fWC3UxDor0TkBersqoyGNNU9n7Z0ZMzEwsK3jEb+DD1wCICdrCCjodJ2MAcxC3g03DUog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=asXt3tEc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709515569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CojaXQJJcZOQUU8jh0jnjeeaAVlOw1HZo2KWPjGs5yk=;
	b=asXt3tEcIZYnU99hRJD+S65nfTxYqBpwM60Z6B0XRGoguMZS6IzzgT2PkFYakiUylg/Tsf
	pgUc+wUrzdZKRHYerRzFIQX68iRcb7jO5QRftzUE38YPvRk+nZ28Ydxuc+ZMIuIFop58qh
	aRZ8rsrd0QgJdPq6wOx6oJ0jg58x7k4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-o0oAMIOENPeZfHGso_vZPQ-1; Sun, 03 Mar 2024 20:26:07 -0500
X-MC-Unique: o0oAMIOENPeZfHGso_vZPQ-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-29a5f3804fbso2944151a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 17:26:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709515567; x=1710120367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CojaXQJJcZOQUU8jh0jnjeeaAVlOw1HZo2KWPjGs5yk=;
        b=gQJRPFFTIFq38iWb1c0fyzR8H0E83Jy9T3mGD/oZBqJ57gdsa+6Z4qDy6mnqXvgoyB
         cT5XrT+my+iLcUOXDQt0hQITVmaGB6KYLW+Fj+IPDrNCVNNZkJHmHbH55qezCTztjycg
         5gWd/oFniWV7cqXvhldTd0mVCg0Xn8hKReLkbqotQxWHqikLP9hM1pgsAoRvOcb13s9T
         1qXUVcK19jhm4Aqh474VeZefJxQojqVE3xlGbLLCXAwgk4jfyzGWSqlX/6RnpJhaG4F/
         Bw1O0DxQ+miFEHhQ9AIk7t3m658ClXw1tWygNawNk3xlj8uC4Bpk2cRLoBDuMraChTV4
         zE5w==
X-Forwarded-Encrypted: i=1; AJvYcCVTxnE8hwfJBpDs1s0/WTtwb8lVOtI92Lhf/ZYmsSu8M1Wwp6Rqf1bS7xLcYlmo8xvRCeUjzUr4xIQC5x8muZlzba/pdEnkK2nU3Ry6
X-Gm-Message-State: AOJu0YwEf6v6ZxeozgPA0ImVijJjVKbnx0QNyLNW2ADyAsOfYUsvaw11
	a2xITT6IGe/swi7aZqQqh58WPghoXhZg8WQDcvjch0QilTYh7gjJi1K3zJZMDi9kZkFPagwLPOn
	9Aajg9Xc0WK75AZcRwUsde0OWOnriO/f+yy/7aQoY0xTkA08yp8e3XMcnzHHomFqzVtRKeowOS1
	0HlmsQTNGmm+qKXY8ILhDntbcOq1re8DknB1H+
X-Received: by 2002:a17:90a:a109:b0:29a:575c:7d90 with SMTP id s9-20020a17090aa10900b0029a575c7d90mr5074297pjp.9.1709515566790;
        Sun, 03 Mar 2024 17:26:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5wsVkFGvI0g3UiyyqsUZIaC7FJXgvH6hoNmoP+0JzLudAnmk7yvN1wiITDdpnn0NlTe5w6otoZQCYKLXa9Vc=
X-Received: by 2002:a17:90a:a109:b0:29a:575c:7d90 with SMTP id
 s9-20020a17090aa10900b0029a575c7d90mr5074285pjp.9.1709515566419; Sun, 03 Mar
 2024 17:26:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301095657.662111-1-yukuai1@huaweicloud.com>
 <CALTww2-GV-YBX1ey4juaVHjHz-wNS0xRBqBn=ucDXEb4WNbSOg@mail.gmail.com>
 <0091f7d1-2273-16ff-8285-5fa3f7e2e0f7@huaweicloud.com> <35feaa54-db9e-f0d6-d5a5-a10a45bb90a5@huaweicloud.com>
In-Reply-To: <35feaa54-db9e-f0d6-d5a5-a10a45bb90a5@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
Date: Mon, 4 Mar 2024 09:25:55 +0800
Message-ID: <CALTww2-BmudurHbsbbqBMq+KgZs+hokqOJnovS5KDGEidHqZzA@mail.gmail.com>
Subject: Re: [PATCH -next 0/9] dm-raid, md/raid: fix v6.7 regressions part2
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: zkabelac@redhat.com, agk@redhat.com, snitzer@kernel.org, 
	mpatocka@redhat.com, dm-devel@lists.linux.dev, song@kernel.org, 
	heinzm@redhat.com, neilb@suse.de, jbrassow@redhat.com, 
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 9:24=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> wr=
ote:
>
> Hi,
>
> =E5=9C=A8 2024/03/04 9:07, Yu Kuai =E5=86=99=E9=81=93:
> > Hi,
> >
> > =E5=9C=A8 2024/03/03 21:16, Xiao Ni =E5=86=99=E9=81=93:
> >> Hi all
> >>
> >> There is a error report from lvm regression tests. The case is
> >> lvconvert-raid-reshape-stripes-load-reload.sh. I saw this error when I
> >> tried to fix dmraid regression problems too. In my patch set,  after
> >> reverting ad39c08186f8a0f221337985036ba86731d6aafe (md: Don't register
> >> sync_thread for reshape directly), this problem doesn't appear.
> >

Hi Kuai
> > How often did you see this tes failed? I'm running the tests for over
> > two days now, for 30+ rounds, and this test never fail in my VM.

I ran 5 times and it failed 2 times just now.

>
> Take a quick look, there is still a path from raid10 that
> MD_RECOVERY_FROZEN can be cleared, and in theroy this problem can be
> triggered. Can you test the following patch on the top of this set?
> I'll keep running the test myself.

Sure, I'll give the result later.

Regards
Xiao
>
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index a5f8419e2df1..7ca29469123a 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -4575,7 +4575,8 @@ static int raid10_start_reshape(struct mddev *mddev=
)
>          return 0;
>
>   abort:
> -       mddev->recovery =3D 0;
> +       if (mddev->gendisk)
> +               mddev->recovery =3D 0;
>          spin_lock_irq(&conf->device_lock);
>          conf->geo =3D conf->prev;
>          mddev->raid_disks =3D conf->geo.raid_disks;
>
> Thanks,
> Kuai
> >
> > Thanks,
> > Kuai
> >
> >>
> >> I put the log in the attachment.
> >>
> >> On Fri, Mar 1, 2024 at 6:03=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.co=
m> wrote:
> >>>
> >>> From: Yu Kuai <yukuai3@huawei.com>
> >>>
> >>> link to part1:
> >>> https://lore.kernel.org/all/CAPhsuW7u1UKHCDOBDhD7DzOVtkGemDz_QnJ4DUq_=
kSN-Q3G66Q@mail.gmail.com/
> >>>
> >>>
> >>> part1 contains fixes for deadlocks for stopping sync_thread
> >>>
> >>> This set contains fixes:
> >>>   - reshape can start unexpected, cause data corruption, patch 1,5,6;
> >>>   - deadlocks that reshape concurrent with IO, patch 8;
> >>>   - a lockdep warning, patch 9;
> >>>
> >>> I'm runing lvm2 tests with following scripts with a few rounds now,
> >>>
> >>> for t in `ls test/shell`; do
> >>>          if cat test/shell/$t | grep raid &> /dev/null; then
> >>>                  make check T=3Dshell/$t
> >>>          fi
> >>> done
> >>>
> >>> There are no deadlock and no fs corrupt now, however, there are still
> >>> four
> >>> failed tests:
> >>>
> >>> ###       failed: [ndev-vanilla] shell/lvchange-raid1-writemostly.sh
> >>> ###       failed: [ndev-vanilla] shell/lvconvert-repair-raid.sh
> >>> ###       failed: [ndev-vanilla] shell/lvcreate-large-raid.sh
> >>> ###       failed: [ndev-vanilla] shell/lvextend-raid.sh
> >>>
> >>> And failed reasons are the same:
> >>>
> >>> ## ERROR: The test started dmeventd (147856) unexpectedly
> >>>
> >>> I have no clue yet, and it seems other folks doesn't have this issue.
> >>>
> >>> Yu Kuai (9):
> >>>    md: don't clear MD_RECOVERY_FROZEN for new dm-raid until resume
> >>>    md: export helpers to stop sync_thread
> >>>    md: export helper md_is_rdwr()
> >>>    md: add a new helper reshape_interrupted()
> >>>    dm-raid: really frozen sync_thread during suspend
> >>>    md/dm-raid: don't call md_reap_sync_thread() directly
> >>>    dm-raid: add a new helper prepare_suspend() in md_personality
> >>>    dm-raid456, md/raid456: fix a deadlock for dm-raid456 while io
> >>>      concurrent with reshape
> >>>    dm-raid: fix lockdep waring in "pers->hot_add_disk"
> >>>
> >>>   drivers/md/dm-raid.c | 93 ++++++++++++++++++++++++++++++++++-------=
---
> >>>   drivers/md/md.c      | 73 ++++++++++++++++++++++++++--------
> >>>   drivers/md/md.h      | 38 +++++++++++++++++-
> >>>   drivers/md/raid5.c   | 32 ++++++++++++++-
> >>>   4 files changed, 196 insertions(+), 40 deletions(-)
> >>>
> >>> --
> >>> 2.39.2
> >>>
> >
> >
> > .
> >
>



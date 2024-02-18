Return-Path: <linux-kernel+bounces-70173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 352D3859452
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 04:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28F711C20CC3
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 03:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0280C4C7C;
	Sun, 18 Feb 2024 03:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="glQ0d5m3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5AA7FF
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 03:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708226120; cv=none; b=BS1ofhmO4l/hyRyWhY09YIST88wfj4WkNfT8GB/C/eevAtwQXn2m7HyFHJt5c3r8MF8/9N0b6bKP6Z/GnzQKVNNYLB02FvEMZdyjDbxQactLv6rSxZasC9pyHOAkSIDpxg+eYqcoCELvzWIRf9BYL14gpC78SZWNRpmRyG50JII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708226120; c=relaxed/simple;
	bh=JhQ/DYTGZ6OXDc4n+pEvGDPHKTnZVihhZLkDzAmY7sE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YllMqPobkujOwiVCJ//3yAqHfe3UcwdhZYVsDj705yUTMvGe7PA9UkxFFzEj6v4O3r0Cx+w2gu4z78DxmrBkqs4JUlWDLWkCubIfys67U49TwSfxphltF4QC7QnzlaKHMrEDS0MOqNgomQu7RCQWzTQdHyLKFnyue0Jx0eEgzkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=glQ0d5m3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708226117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FONogVbUVoWaKi1IS5e6r7xy0yWbXds112ya5owKv98=;
	b=glQ0d5m3v+Htra5scUbQL8qTQ013stkXzPJsfnfufq3SPv2W3SogesYCeVARC8InCwMbPR
	cpu1b1xVfpxgiG5dQcKKcV0+8xAmnYjrs9g8Q4aJWwbHsyPft7VyVlGxUX9GqURsdQbPcL
	0zjPVXjVuM5As0pGvLbliqmH/+bXg9I=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-jYx6Yve4NTmxRYDEWUX9xg-1; Sat, 17 Feb 2024 22:15:15 -0500
X-MC-Unique: jYx6Yve4NTmxRYDEWUX9xg-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-21e5e758d36so2656864fac.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 19:15:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708226114; x=1708830914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FONogVbUVoWaKi1IS5e6r7xy0yWbXds112ya5owKv98=;
        b=l5hhEZRMjhlxLwcxC2JPDZwnFjIyZJ0jW7zz/K5dk5o6g02pnL3LTKZqvgnXI+Pf/6
         5e20cUYabls+kGmq/h1lyAUWfCzifdPgfl+KH0ZzIvteYNyK+15aHGU3WYav+ct9XWUy
         LdUr5eaSx1gPxQLDsAV0W4pVLNDmsDQb8nCZ/paVJaHY/9wYC5QqYx1yFm+GE9C128Ll
         DEYG/1SkVdMWGVCoqQad3NYua/G7nCzjvwdsfQEVQmh/aP1uhEGMgjnDCTEYJXVG2DX6
         CcyNIGEn0TcW9/6ZBKTGYgxQNp+Sj5nmhAv4YisEY2n87VFkTFuND7tS+1T6P/5ew7CZ
         jNbw==
X-Forwarded-Encrypted: i=1; AJvYcCUHJoOrikiAZ1dqJg+xEc75GR6hHCNpnz3bGYBfrV2hPE/UFqecby1Bi3oHSWGP+WLM698R7jGq5UsNdtTefdaF8jl+6Tm9tsO4Y7St
X-Gm-Message-State: AOJu0YxhIv29BC5xtOvhcAyK3rA6CPy47npGxReVDYFyPJWY87tOygrh
	PVg6Te8w81FP/QWOCpiySCTiJaKscs7WO+V8e6cztoDWw5cterPGMV4PILi8IB2g8L/FysbqMaX
	FjZE/so0+At7PMydt0V+5WPRpJyoDOoMd5xW70aN90ITx2EyylNCQjVHNx0B4DUNcbm64e22q0X
	IYneHfTdBWrUettiajZdYpqXNQBbNz4wk8TRiy
X-Received: by 2002:a05:6358:63a7:b0:17a:e013:9586 with SMTP id k39-20020a05635863a700b0017ae0139586mr10437466rwh.29.1708226114672;
        Sat, 17 Feb 2024 19:15:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIgia/qEw07ssNGmM9O+z1EcAhhjS/w03o9vfsuxo5JCOkd6PlYGtg0txemzIhE7BZh2FDQ7Lc4T/kshTKxLQ=
X-Received: by 2002:a05:6358:63a7:b0:17a:e013:9586 with SMTP id
 k39-20020a05635863a700b0017ae0139586mr10437456rwh.29.1708226114371; Sat, 17
 Feb 2024 19:15:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201092559.910982-1-yukuai1@huaweicloud.com>
 <20240201092559.910982-2-yukuai1@huaweicloud.com> <CALTww2-ZhRBJOD3jXs=xKFaD=iR=dtoC9h2rUQi5Stpi+tJ9Bw@mail.gmail.com>
 <64d27757-9387-09dc-48e8-a9eedd67f075@huaweicloud.com> <CALTww28E=k6fXJURG77KwHb7M2OByLrcE8g7GNkQDTtcOV48hQ@mail.gmail.com>
 <d4a2689e-b5cc-f268-9fb2-84c10e5eb0f4@huaweicloud.com> <CALTww28bUzmQASme3XOz0CY=o86f1EUU23ENmnf42UVyuGzQ4Q@mail.gmail.com>
 <c1195efd-dd83-317e-3067-cd4891ae013e@huaweicloud.com>
In-Reply-To: <c1195efd-dd83-317e-3067-cd4891ae013e@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
Date: Sun, 18 Feb 2024 11:15:03 +0800
Message-ID: <CALTww2-7tTMdf_XZ60pNKH_QCq3OUX2P==VPXZo3f-dHzVhmnw@mail.gmail.com>
Subject: Re: [PATCH v5 01/14] md: don't ignore suspended array in md_check_recovery()
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: mpatocka@redhat.com, heinzm@redhat.com, blazej.kucman@linux.intel.com, 
	agk@redhat.com, snitzer@kernel.org, dm-devel@lists.linux.dev, song@kernel.org, 
	jbrassow@f14.redhat.com, neilb@suse.de, shli@fb.com, akpm@osdl.org, 
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 18, 2024 at 10:34=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> =
wrote:
>
> Hi,
>
> =E5=9C=A8 2024/02/18 10:27, Xiao Ni =E5=86=99=E9=81=93:
> > On Sun, Feb 18, 2024 at 9:46=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.co=
m> wrote:
> >>
> >> Hi,
> >>
> >> =E5=9C=A8 2024/02/18 9:33, Xiao Ni =E5=86=99=E9=81=93:
> >>> The deadlock problem mentioned in this patch should not be right?
> >>
> >> No, I think it's right. Looks like you are expecting other problems,
> >> like mentioned in patch 6, to be fixed by this patch.
> >
> > Hi Kuai
> >
> > Could you explain why step1 and step2 from this comment can happen
> > simultaneously? From the log, the process should be
> > The process is :
> > dev_remove->dm_destroy->__dm_destroy->dm_table_postsuspend_targets(raid=
_postsuspend)
> > -> dm_table_destroy(raid_dtr).
> > After suspending the array, it calls raid_dtr. So these two functions
> > can't happen simultaneously.
>
> You're removing the target directly, however, dm can suspend the disk
> directly, you can simplily:
>
> 1) dmsetup suspend xxx
> 2) dmsetup remove xxx

For dm-raid, the design of suspend stops sync thread first and then it
calls mddev_suspend to suspend array. So I'm curious why the sync
thread can still exit when array is suspended. I know the reason now.
Because before f52f5c71f (md: fix stopping sync thread), the process
is raid_postsuspend->md_stop_writes->__md_stop_writes
(__md_stop_writes sets MD_RECOVERY_FROZEN). In patch f52f5c71f, it
doesn't set MD_RECOVERY_FROZEN in __md_stop_writes anymore.

The process changes to
1. raid_postsuspend->md_stop_writes->__md_stop_writes->stop_sync_thread
(wait until MD_RECOVERY_RUNNING clears)
2. md thread -> md_check_recovery -> unregister_sync_thread ->
md_reap_sync_thread (clears MD_RECOVERY_RUNNING, stop_sync_thread
returns, md_reap_sync_thread sets MD_RECOVERY_NEEDED)
3. raid_postsuspend->mddev_suspend
4. md sync thread starts again because __md_stop_writes doesn't set
MD_RECOVERY_FROZEN.
It's the reason why we can see sync thread still happens when raid is suspe=
nded.

So the patch fix this problem should:

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 9e41a9aaba8b..666761466f02 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -6315,6 +6315,7 @@ static void md_clean(struct mddev *mddev)

 static void __md_stop_writes(struct mddev *mddev)
 {
+       set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
        stop_sync_thread(mddev, true, false);
        del_timer_sync(&mddev->safemode_timer);

Like other places which call stop_sync_thread, it needs to set the
MD_RECOVERY_FROZEN bit.

Regards
Xiao

>
> Please also take a look at other patches, why step 1) can't stop sync
> thread.
>
> Thanks,
> Kuai
>
> >
> >
> >>
> >> Noted that this patch just fix one case that MD_RECOVERY_RUNNING can't
> >> be cleared, I you are testing this patch alone, please make sure that
> >> you still triggered the exactly same case:
> >>
> >> - MD_RCOVERY_RUNNING can't be cleared while array is suspended.
> >
> > I'm not testing this patch. I want to understand the patch well. So I
> > need to understand the issue first. I can't understand how this
> > deadlock (step1,step2) happens.
> >
> > Regards
> > Xiao
> >>
> >> Thanks,
> >> Kuai
> >>
> >
> > .
> >
>



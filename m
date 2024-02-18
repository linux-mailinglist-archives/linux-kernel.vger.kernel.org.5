Return-Path: <linux-kernel+bounces-70204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 030C98594BD
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 06:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5307628381A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 05:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FB34C80;
	Sun, 18 Feb 2024 05:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="At9VW+6c"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371181C2D
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 05:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708232871; cv=none; b=AiW806KQbvLOz9bdhQo8S2UAedDS4xFNzsO62AmL8QCNR/7XcXSlHwjziRsLXTt6O2rjCnOqqER5CWnHSw2VHqf2D+EVvwdQdX0pDFmuEXCPegZPt+TIPNZVK34XlxPGUmgMxmbq2Y3/x53dCzFoG3g6RMCDfiLrpRlNr6hXMxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708232871; c=relaxed/simple;
	bh=HZJ3U0g4wRuZo2pg0bTw3VaU/bIeCw89iQoFwZuF4Gk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uKj6JUJ5I+kkggoC4ZJY09DjVqnaO8RoJdZcWh+0f15ZQmlkI2/p8MMCTQ6uLxTvYn75gmtuDFpWIhvaSXcTpzF69L1fWqj1I4v+6EcdeaEnYAURjkSCE0TGkVzfBaYCnBg7polMKIHJjlkRYcLER4o1SHtftIpfqcjqIraKBQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=At9VW+6c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708232868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kJ111bQjIWllvC1+z6kOv3m0B4nYnfXeoU1iuZax3jk=;
	b=At9VW+6cyuej8o2/iYBZpsvcN1oaIIMqvFTPJz/wxVFifuraLTqUTNbRU8aQTg+fBZ4CpU
	dC5pnaJ6g5XZkWq8syRCH62XgNVU+JA8kBJT6PA2dklG+wp6QkkIHhmhr7HinF9ZFWE9UG
	JKarjUXus7IZYAn3+OM/DW5UkBmn2JE=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-MGBqGcqQOmK06LNGY-9O4Q-1; Sun, 18 Feb 2024 00:07:46 -0500
X-MC-Unique: MGBqGcqQOmK06LNGY-9O4Q-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1d542680c9cso46383035ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 21:07:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708232865; x=1708837665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJ111bQjIWllvC1+z6kOv3m0B4nYnfXeoU1iuZax3jk=;
        b=kDv6RoN7rlS4zytVDkXzj6xcLG9RXWXbwMDmumFAZ1wtBNykJ0x63SwebMyGslquoi
         oewrC/wKNP90+Cg05nZqvWC8vep7HCUAVifPFZxU1AW3xc77/SiyaQM8u1Z714/yHHb/
         ZxuIR0q8pflNS0eSBl8Ql8VAygdrAtEiiviuEknbRm3dSnSBVCuHWV8R7RFToFPIkmuM
         2oy7dO/NHPVKCqMpLbwP8AOoXoKbVAGkrbQB+BOjGr90qt7LCGacOCLirSxZDpbSGBdp
         35aqz0Acr2a5d/Hg1m8B9/EMvMUFebTdwGyTScM67wN3+wtLNVWTGhglXQ8EfD7X2uMf
         jrKw==
X-Forwarded-Encrypted: i=1; AJvYcCW79kPaKHGvAuty3HagYicoMOvTc3c2nPK5VzYd4naXlBvM9o1uIsAtDXtIm5ZTh01MH+HWr00XcG1n7uDbAuAo1g0c1UZ5NX0y8dwV
X-Gm-Message-State: AOJu0Yy9Y8qCrrZNAwrfnTSSo/RwigYO5e9jDWjaeabcoq0nTVdQzvCy
	dfAVlvesyGkdkXXkSwkHY+c42aOSovvFHlJffER+GM6RzPTFKzlzqmO7vobKaRd9L1xTVBeFyGi
	mfpCv983wKjwJphuHaCfryCmFGsEnCnn69d2GJygZ4C+mSqpypKDMCh6baEmB5YG2Be18ebibtP
	U/LOkSF3mX8bfPZqm1oyMkfeYPVjlt8cfZQtT+
X-Received: by 2002:a05:6a21:670b:b0:19c:9b7b:66a with SMTP id wh11-20020a056a21670b00b0019c9b7b066amr8922776pzb.49.1708232865694;
        Sat, 17 Feb 2024 21:07:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHafX1sQI6ruA1HkPRzewVQrJ+P3ZuePIevyyS/GYEBtEXqzHPbF8lZ65hk0HbjSN5VjFlH2Hxcn/VWxQ1PP6M=
X-Received: by 2002:a05:6a21:670b:b0:19c:9b7b:66a with SMTP id
 wh11-20020a056a21670b00b0019c9b7b066amr8922771pzb.49.1708232865367; Sat, 17
 Feb 2024 21:07:45 -0800 (PST)
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
 <c1195efd-dd83-317e-3067-cd4891ae013e@huaweicloud.com> <CALTww2-7tTMdf_XZ60pNKH_QCq3OUX2P==VPXZo3f-dHzVhmnw@mail.gmail.com>
 <2fa01c30-2ee7-7c01-6833-bf74142e6d7c@huaweicloud.com>
In-Reply-To: <2fa01c30-2ee7-7c01-6833-bf74142e6d7c@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
Date: Sun, 18 Feb 2024 13:07:34 +0800
Message-ID: <CALTww2-HngEJ9z9cYZ0=kcfuKMpziH3utSgk_8u3dxc553ZNeg@mail.gmail.com>
Subject: Re: [PATCH v5 01/14] md: don't ignore suspended array in md_check_recovery()
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: mpatocka@redhat.com, heinzm@redhat.com, blazej.kucman@linux.intel.com, 
	agk@redhat.com, snitzer@kernel.org, dm-devel@lists.linux.dev, song@kernel.org, 
	jbrassow@f14.redhat.com, neilb@suse.de, shli@fb.com, akpm@osdl.org, 
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 18, 2024 at 11:24=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> =
wrote:
>
> Hi,
>
> =E5=9C=A8 2024/02/18 11:15, Xiao Ni =E5=86=99=E9=81=93:
> > On Sun, Feb 18, 2024 at 10:34=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.c=
om> wrote:
> >>
> >> Hi,
> >>
> >> =E5=9C=A8 2024/02/18 10:27, Xiao Ni =E5=86=99=E9=81=93:
> >>> On Sun, Feb 18, 2024 at 9:46=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.=
com> wrote:
> >>>>
> >>>> Hi,
> >>>>
> >>>> =E5=9C=A8 2024/02/18 9:33, Xiao Ni =E5=86=99=E9=81=93:
> >>>>> The deadlock problem mentioned in this patch should not be right?
> >>>>
> >>>> No, I think it's right. Looks like you are expecting other problems,
> >>>> like mentioned in patch 6, to be fixed by this patch.
> >>>
> >>> Hi Kuai
> >>>
> >>> Could you explain why step1 and step2 from this comment can happen
> >>> simultaneously? From the log, the process should be
> >>> The process is :
> >>> dev_remove->dm_destroy->__dm_destroy->dm_table_postsuspend_targets(ra=
id_postsuspend)
> >>> -> dm_table_destroy(raid_dtr).
> >>> After suspending the array, it calls raid_dtr. So these two functions
> >>> can't happen simultaneously.
> >>
> >> You're removing the target directly, however, dm can suspend the disk
> >> directly, you can simplily:
> >>
> >> 1) dmsetup suspend xxx
> >> 2) dmsetup remove xxx
> >
> > For dm-raid, the design of suspend stops sync thread first and then it
> > calls mddev_suspend to suspend array. So I'm curious why the sync
> > thread can still exit when array is suspended. I know the reason now.
> > Because before f52f5c71f (md: fix stopping sync thread), the process
> > is raid_postsuspend->md_stop_writes->__md_stop_writes
> > (__md_stop_writes sets MD_RECOVERY_FROZEN). In patch f52f5c71f, it
> > doesn't set MD_RECOVERY_FROZEN in __md_stop_writes anymore.
> >
> > The process changes to
> > 1. raid_postsuspend->md_stop_writes->__md_stop_writes->stop_sync_thread
> > (wait until MD_RECOVERY_RUNNING clears)
> > 2. md thread -> md_check_recovery -> unregister_sync_thread ->
> > md_reap_sync_thread (clears MD_RECOVERY_RUNNING, stop_sync_thread
> > returns, md_reap_sync_thread sets MD_RECOVERY_NEEDED)
> > 3. raid_postsuspend->mddev_suspend
> > 4. md sync thread starts again because __md_stop_writes doesn't set
> > MD_RECOVERY_FROZEN.
> > It's the reason why we can see sync thread still happens when raid is s=
uspended.
> >
> > So the patch fix this problem should:
>
> As I said, this is really a different problem from this patch, and it is
> fixed seperately by patch 9. Please take a look at that patch.

I think we're talking about the same problem. In patch07 it has a new
api md_frozen_sync_thread. It sets MD_RECOVERY_FROZEN before
stop_sync_thread. This is right. If we use this api in
raid_postsuspend, sync thread can't restart. So the deadlock can't
happen anymore?

And patch01 is breaking one logic which seems right:

commit 68866e425be2ef2664aa5c691bb3ab789736acf5
Author: Jonathan Brassow <jbrassow@f14.redhat.com>
Date:   Wed Jun 8 15:10:08 2011 +1000

    MD: no sync IO while suspended

    Disallow resync I/O while the RAID array is suspended.

We're trying to fix deadlock problems. But it's not good to fix a
problem by breaking an existing rule.

Regards
Xiao


>
> Thanks,
> Kuai
>
> >
> > diff --git a/drivers/md/md.c b/drivers/md/md.c
> > index 9e41a9aaba8b..666761466f02 100644
> > --- a/drivers/md/md.c
> > +++ b/drivers/md/md.c
> > @@ -6315,6 +6315,7 @@ static void md_clean(struct mddev *mddev)
> >
> >   static void __md_stop_writes(struct mddev *mddev)
> >   {
> > +       set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
> >          stop_sync_thread(mddev, true, false);
> >          del_timer_sync(&mddev->safemode_timer);
> >
> > Like other places which call stop_sync_thread, it needs to set the
> > MD_RECOVERY_FROZEN bit.
> >
> > Regards
> > Xiao
> >
> >>
> >> Please also take a look at other patches, why step 1) can't stop sync
> >> thread.
> >>
> >> Thanks,
> >> Kuai
> >>
> >>>
> >>>
> >>>>
> >>>> Noted that this patch just fix one case that MD_RECOVERY_RUNNING can=
't
> >>>> be cleared, I you are testing this patch alone, please make sure tha=
t
> >>>> you still triggered the exactly same case:
> >>>>
> >>>> - MD_RCOVERY_RUNNING can't be cleared while array is suspended.
> >>>
> >>> I'm not testing this patch. I want to understand the patch well. So I
> >>> need to understand the issue first. I can't understand how this
> >>> deadlock (step1,step2) happens.
> >>>
> >>> Regards
> >>> Xiao
> >>>>
> >>>> Thanks,
> >>>> Kuai
> >>>>
> >>>
> >>> .
> >>>
> >>
> >
> > .
> >
>



Return-Path: <linux-kernel+bounces-70958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92986859EB3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6E911C2173D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00C2224D4;
	Mon, 19 Feb 2024 08:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UUHVxEGY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D420224CB
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 08:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708332373; cv=none; b=PNKohb+BNRyYF4pcgK13CRDfk80sku/sHoiqgQx+8BdgRsGTRRh5MF8CzKyhiBMC2111cnlHBBpQ3fOqCExyjQOtVnGDQ/w0wcM0G9ClTUhyYDcPWCy0/c2O6wTwkkmL7SoHkzRqdSUbtW3Sjzt+ZtMj7Ro8uD5hAAJsgRmr25E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708332373; c=relaxed/simple;
	bh=QSyDgLWRwdHUvwdaCODzCH2j0jGaHTV9Bnd4YMUI/4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TZjBFcbETyCRug4LX0jaPIRsWME+lxHQGHjORP3SsxrmOMkHPjt9TlXifpsXDGtYuyipY9wbtxOpGVj00ynFezPz+F5JaNAAn5gAcOWAvarR3Wn/eiZ8YtYJjAzS5yHwQ7zT8UJ3oyW8VffyH/Mo7SciEplrxvz2Qr8jUF5RX7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UUHVxEGY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708332369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iCUvyVBmYRz6H/XAzrl1bVxLHyzxAeTb/4NOzF1rqOM=;
	b=UUHVxEGYj9/sxEUOn8bSlRPGE5hu6coz25Eiyxu63D+NyyY9SAHttdQwYYZRafu69sJWwG
	cFyTYnnYPeBR0xyC9Xmc24PW5/eUdzNWwASKXvrC+vVY6RxNzv/ljoQBpMuD48WWEINetn
	BmVP3Hdcf6Y82TXb0DWBmPpm0ti+lig=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-vZtE-CF1NtqGjhXR9jPDwA-1; Mon, 19 Feb 2024 03:46:06 -0500
X-MC-Unique: vZtE-CF1NtqGjhXR9jPDwA-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5ce63e72bc3so2658972a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 00:46:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708332365; x=1708937165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iCUvyVBmYRz6H/XAzrl1bVxLHyzxAeTb/4NOzF1rqOM=;
        b=kQt2gED0HkWbWYxIvjz2dqplTQUTDednt0ewYt7e+PckterfNCmmD++HG+QRHM/p5y
         hit2UkKZ1yA8a3bRJd3IqbTqiiJNfkW8dP/vzY16XGRn52GF3/OTdu+FEwS/VOpbBJ8a
         FQqvGtUF+IAfOZ3E79A1/ypbbaiK17uoTp/GK4DrCqRy7YBsg7fq9sidB4RRbHNKn0DX
         1jHp6BLj7NsVfozCezaB4feQC9oAZEdXQBBKC2mkRry0UwrGPfK6kav3w9s/gheZCiCX
         si0wxglkJ8PAYSTYy0q4Ti4xeOAFTHg3ZpbVtq5se9HKRCKSDgssO3jZxTzWalGUBWse
         aVzg==
X-Forwarded-Encrypted: i=1; AJvYcCXTDxDaCQ6NXTEvF0UI/840eTmX3rpCt3dxFO664N+dIlTvnL3wB+jZ0+asGsiXdDbu6dVOsmR0Ld3YVd3OQGxvq2eyPjqZYofJ58r8
X-Gm-Message-State: AOJu0Yywy0nzSBoyBQr5q2j4mt5yxX4Tkw4AMEQbgUYiGqgpvev++jlR
	33DCc2p9EhYDEYQV9Id03vpazKZEtVgyxoPKpPrnhcJrfy1srYBUH9z+sn57je8bzJzioNyylgl
	Md70Jvabi1dAcfTSjRK03C/kbl1ZGZI51MHZDSnxlsI00PLxOim+k75DkTlTgzEWiMaDIMZ/qqz
	w+wR/nfODkulN6/C6eI0sblZAFAglCRxCKLJ7I
X-Received: by 2002:a05:6a20:c6ca:b0:19e:ac58:7b0d with SMTP id gw10-20020a056a20c6ca00b0019eac587b0dmr11815940pzb.5.1708332364890;
        Mon, 19 Feb 2024 00:46:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGCthts1xxg9kCK/ufK6YjoPdY5ONIsg4WAXJZueXmPVBaZY35T67b0sIBs7GOdzWvZWqLXi+8nxjL7jfxcfBY=
X-Received: by 2002:a05:6a20:c6ca:b0:19e:ac58:7b0d with SMTP id
 gw10-20020a056a20c6ca00b0019eac587b0dmr11815920pzb.5.1708332364557; Mon, 19
 Feb 2024 00:46:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201092559.910982-1-yukuai1@huaweicloud.com>
 <20240201092559.910982-10-yukuai1@huaweicloud.com> <CALTww2_ppGe29wMOsLS45kR4YS6TyCTBswmeKyVE+-H6XmoN+g@mail.gmail.com>
 <3c062731-3b74-2b3e-94c8-ffdf940df014@huaweicloud.com> <CALTww29wMJffDUddW526aLbcArqkZVZnrjfuFjOEMUgBMD=AZA@mail.gmail.com>
 <afc67a7d-60b9-ae78-77b3-19bfb2df5f86@huaweicloud.com>
In-Reply-To: <afc67a7d-60b9-ae78-77b3-19bfb2df5f86@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
Date: Mon, 19 Feb 2024 16:45:53 +0800
Message-ID: <CALTww29-yJ-vw4z5WLoE0c-8CggUdTZjGJNc8YivUUAcPoxRtg@mail.gmail.com>
Subject: Re: [PATCH v5 09/14] dm-raid: really frozen sync_thread during suspend
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: mpatocka@redhat.com, heinzm@redhat.com, blazej.kucman@linux.intel.com, 
	agk@redhat.com, snitzer@kernel.org, dm-devel@lists.linux.dev, song@kernel.org, 
	jbrassow@f14.redhat.com, neilb@suse.de, shli@fb.com, akpm@osdl.org, 
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 3:53=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2024/02/19 15:27, Xiao Ni =E5=86=99=E9=81=93:
> > On Sun, Feb 18, 2024 at 2:34=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.co=
m> wrote:
> >>
> >> Hi,
> >>
> >> =E5=9C=A8 2024/02/18 12:53, Xiao Ni =E5=86=99=E9=81=93:
> >>> Hi Kuai
> >>>
> >>> On Thu, Feb 1, 2024 at 5:30=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.c=
om> wrote:
> >>>>
> >>>> From: Yu Kuai <yukuai3@huawei.com>
> >>>>
> >>>> 1) The flag MD_RECOVERY_FROZEN doesn't mean that sync thread is froz=
en,
> >>>>      it only prevent new sync_thread to start, and it can't stop the
> >>>>      running sync thread;
> >>>
> >>> Agree with this
> >>>
> >>>> 2) The flag MD_RECOVERY_FROZEN doesn't mean that writes are stopped,=
 use
> >>>>      it as condition for md_stop_writes() in raid_postsuspend() does=
n't
> >>>>      look correct.
> >>>
> >>> I don't agree with it. __md_stop_writes stops sync thread, so it need=
s
> >>> to check this flag. And It looks like the name __md_stop_writes is no=
t
> >>> right. Does it really stop write io? mddev_suspend should be the
> >>> function that stop write request. From my understanding,
> >>> raid_postsuspend does two jobs. One is stopping sync thread. Two is
> >>> suspending array.
> >>
> >> MD_RECOVERY_FROZEN is not just used in __md_stop_writes(), so I think
> >> it's not correct to to check this. For example, if MD_RECOVERY_FROZEN =
is
> >> set by raid_message(), then __md_stop_writes() will be skipped.
> >
> > Hi Kuai
> >
> > raid_message sets MD_RECOVERY_FROZEN and it stops the sync thread
> > synchronously. So it doesn't need __md_stop_writes. So from md and
> > dmraid, it has a rule. If you set MD_RECOVERY_FROZEN, you're in the
> > process of stopping sync thread.
>
> There are so much problems here, I'm not sure if you really walk through
> all patches here.

I haven't read all of them. But as you mentioned, the following
patches are based on patch01. They work together.  I want to narrow
the change to fix these regression problems. But it depends on the
song's decision.

>
> 1) stop the sync_thread synchronously is problematic, and raid_message()
> doesn't even hold 'reconfig_mutex' for md_reap_sync_thread();
> 2) skip __md_stop_writes() because sycn_thread is stopped is wrong,
> __md_stop_writes() does more work.

Agree with this. We can use the same way as action_store does. But we
can do this later, not this patch set.

> >
> >>
> >>>
> >>>> 3) raid_message can set/clear the flag MD_RECOVERY_FROZEN at anytime=
,
> >>>>      and if MD_RECOVERY_FROZEN is cleared while the array is suspend=
ed,
> >>>>      new sync_thread can start unexpected.
> >>>
> >>> md_action_store doesn't check this either. If the array is suspended
> >>> and MD_RECOVERY_FROZEN is cleared, before patch01, sync thread can't
> >>> happen. So it looks like patch01 breaks the logic.
> >>
> >> The difference is that md/raid doen't need to frozen sync_thread while
> >> suspending the array for now. And I don't understand at all why sync
> >> thread can't happed before patch01.
> >
> > There is a condition you mentioned above -- the array is suspended.
> > Before patch01, if one array is suspended, the sync thread can't
> 3) before patch 1, sync_thread can still running even if array is
> suspended;
> And even without patch 1, raid_message() can still start new
> sync_thread:
>
> // assume sync_thread is not register
> raid_postsuspend        raid_message
>   md_stop_writes
>                          set_bit(MD_RECOVERY_NEEDED, &mddev->recovery)
>                          if (!mddev->suspended)
>                           md_wakeup_thread
>                           // new sync_thread is registered
>   mddev_suspend

The array is not suspended in the above case. Before patch01, after
mddev_suspend, sync thread can't start.

But this looks like a problem. I'm not sure if dm has a way to handle
the concurrency. In md, we have a new lock sync_mutex to protect this,
right? If dm doesn't do this, dm-raid can do the same thing as md
does.

>
> > happen. Even raid_messages clears MD_RECOVERY_FROZEN, the sync thread
> > can't start. After resume the array, the sync thread can start again.
>
> 4) I think I don't need to explain again why suspended should not be
> used to prevent starting new sync_thread;

Yes. I understand you. But I only follow the existing logic. It has
been there for many years. Especially for dmraid/lvmraid, maybe there
are some codes that depend on this logic. For such a change, I don't
reject it 100%. I just want to say we need to be more careful.

Best Regards
Xiao
>
> Thanks,
> Kuai
>
> >
> > Regards
> > Xiao
> >>
> >> Thanks,
> >> Kuai
> >>
> >>>
> >>> Regards
> >>> Xiao
> >>>
> >>>
> >>>>
> >>>> Fix above problems by using the new helper to suspend the array duri=
ng
> >>>> suspend, also disallow raid_message() to change sync_thread status
> >>>> during suspend.
> >>>>
> >>>> Note that after commit f52f5c71f3d4 ("md: fix stopping sync thread")=
, the
> >>>> test shell/lvconvert-raid-reshape.sh start to hang in stop_sync_thre=
ad(),
> >>>> and with previous fixes, the test won't hang there anymore, however,=
 the
> >>>> test will still fail and complain that ext4 is corrupted. And with t=
his
> >>>> patch, the test won't hang due to stop_sync_thread() or fail due to =
ext4
> >>>> is corrupted anymore. However, there is still a deadlock related to
> >>>> dm-raid456 that will be fixed in following patches.
> >>>>
> >>>> Reported-by: Mikulas Patocka <mpatocka@redhat.com>
> >>>> Closes: https://lore.kernel.org/all/e5e8afe2-e9a8-49a2-5ab0-958d4065=
c55e@redhat.com/
> >>>> Fixes: 1af2048a3e87 ("dm raid: fix deadlock caused by premature md_s=
top_writes()")
> >>>> Fixes: 9dbd1aa3a81c ("dm raid: add reshaping support to the target")
> >>>> Fixes: f52f5c71f3d4 ("md: fix stopping sync thread")
> >>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> >>>> ---
> >>>>    drivers/md/dm-raid.c | 38 +++++++++++++++++++++++++++++---------
> >>>>    1 file changed, 29 insertions(+), 9 deletions(-)
> >>>>
> >>>> diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
> >>>> index eb009d6bb03a..5ce3c6020b1b 100644
> >>>> --- a/drivers/md/dm-raid.c
> >>>> +++ b/drivers/md/dm-raid.c
> >>>> @@ -3240,11 +3240,12 @@ static int raid_ctr(struct dm_target *ti, un=
signed int argc, char **argv)
> >>>>           rs->md.ro =3D 1;
> >>>>           rs->md.in_sync =3D 1;
> >>>>
> >>>> -       /* Keep array frozen until resume. */
> >>>> -       set_bit(MD_RECOVERY_FROZEN, &rs->md.recovery);
> >>>> -
> >>>>           /* Has to be held on running the array */
> >>>>           mddev_suspend_and_lock_nointr(&rs->md);
> >>>> +
> >>>> +       /* Keep array frozen until resume. */
> >>>> +       md_frozen_sync_thread(&rs->md);
> >>>> +
> >>>>           r =3D md_run(&rs->md);
> >>>>           rs->md.in_sync =3D 0; /* Assume already marked dirty */
> >>>>           if (r) {
> >>>> @@ -3722,6 +3723,9 @@ static int raid_message(struct dm_target *ti, =
unsigned int argc, char **argv,
> >>>>           if (!mddev->pers || !mddev->pers->sync_request)
> >>>>                   return -EINVAL;
> >>>>
> >>>> +       if (test_bit(RT_FLAG_RS_SUSPENDED, &rs->runtime_flags))
> >>>> +               return -EBUSY;
> >>>> +
> >>>>           if (!strcasecmp(argv[0], "frozen"))
> >>>>                   set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
> >>>>           else
> >>>> @@ -3791,15 +3795,31 @@ static void raid_io_hints(struct dm_target *=
ti, struct queue_limits *limits)
> >>>>           blk_limits_io_opt(limits, chunk_size_bytes * mddev_data_st=
ripes(rs));
> >>>>    }
> >>>>
> >>>> +static void raid_presuspend(struct dm_target *ti)
> >>>> +{
> >>>> +       struct raid_set *rs =3D ti->private;
> >>>> +
> >>>> +       mddev_lock_nointr(&rs->md);
> >>>> +       md_frozen_sync_thread(&rs->md);
> >>>> +       mddev_unlock(&rs->md);
> >>>> +}
> >>>> +
> >>>> +static void raid_presuspend_undo(struct dm_target *ti)
> >>>> +{
> >>>> +       struct raid_set *rs =3D ti->private;
> >>>> +
> >>>> +       mddev_lock_nointr(&rs->md);
> >>>> +       md_unfrozen_sync_thread(&rs->md);
> >>>> +       mddev_unlock(&rs->md);
> >>>> +}
> >>>> +
> >>>>    static void raid_postsuspend(struct dm_target *ti)
> >>>>    {
> >>>>           struct raid_set *rs =3D ti->private;
> >>>>
> >>>>           if (!test_and_set_bit(RT_FLAG_RS_SUSPENDED, &rs->runtime_f=
lags)) {
> >>>>                   /* Writes have to be stopped before suspending to =
avoid deadlocks. */
> >>>> -               if (!test_bit(MD_RECOVERY_FROZEN, &rs->md.recovery))
> >>>> -                       md_stop_writes(&rs->md);
> >>>> -
> >>>> +               md_stop_writes(&rs->md);
> >>>>                   mddev_suspend(&rs->md, false);
> >>>>           }
> >>>>    }
> >>>> @@ -4012,8 +4032,6 @@ static int raid_preresume(struct dm_target *ti=
)
> >>>>           }
> >>>>
> >>>>           /* Check for any resize/reshape on @rs and adjust/initiate=
 */
> >>>> -       /* Be prepared for mddev_resume() in raid_resume() */
> >>>> -       set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
> >>>>           if (mddev->recovery_cp && mddev->recovery_cp < MaxSector) =
{
> >>>>                   set_bit(MD_RECOVERY_REQUESTED, &mddev->recovery);
> >>>>                   mddev->resync_min =3D mddev->recovery_cp;
> >>>> @@ -4056,9 +4074,9 @@ static void raid_resume(struct dm_target *ti)
> >>>>                           rs_set_capacity(rs);
> >>>>
> >>>>                   mddev_lock_nointr(mddev);
> >>>> -               clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
> >>>>                   mddev->ro =3D 0;
> >>>>                   mddev->in_sync =3D 0;
> >>>> +               md_unfrozen_sync_thread(mddev);
> >>>>                   mddev_unlock_and_resume(mddev);
> >>>>           }
> >>>>    }
> >>>> @@ -4074,6 +4092,8 @@ static struct target_type raid_target =3D {
> >>>>           .message =3D raid_message,
> >>>>           .iterate_devices =3D raid_iterate_devices,
> >>>>           .io_hints =3D raid_io_hints,
> >>>> +       .presuspend =3D raid_presuspend,
> >>>> +       .presuspend_undo =3D raid_presuspend_undo,
> >>>>           .postsuspend =3D raid_postsuspend,
> >>>>           .preresume =3D raid_preresume,
> >>>>           .resume =3D raid_resume,
> >>>> --
> >>>> 2.39.2
> >>>>
> >>>
> >>> .
> >>>
> >>
> >
> >
> > .
> >
>



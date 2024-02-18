Return-Path: <linux-kernel+bounces-70278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F737859585
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 09:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A89831C20B4B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 08:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5E01078D;
	Sun, 18 Feb 2024 08:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="inpPsbN5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910AE2903
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 08:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708243643; cv=none; b=PoKBJ9P6hLhTyrIrqQ6f/DPwSvqp40ugVWZ9zbExTOisKccA2Lx/Py5Jc1oeW0BVWDs/eJ9Ev1elMSPUdwZcolT5i8HEPyVU1M8119+32InEkQBWM6/+2PC2P7EANg/A7+5sVmG7StuE5QZIPRIvs1gtETXowa86/nPzbktoBEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708243643; c=relaxed/simple;
	bh=DdZAQ6O4mU4Dgqwya3Gydo+92TRLusgyQd9na6dhnsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SBO6IhcAlapKns/tBaTYJ8/aSws3PwqndTi73M1NRmQyrdbtPc5B+/nr1kULToubfQki1znaF0wRoNdS7CRs19xVbwO0ZEkVpzBx3y+5BwtTflZUMIBCC5IHawKSAJ4D+vMl2CVGR89Vqvh/DXQzxyYYEJJvHmdTD4RXR/9K8g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=inpPsbN5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708243640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Jtfh06HICiZjq82VG1z1ScLpR7A6O8tDUT6Uaocrgg=;
	b=inpPsbN5c1IBKL3k4iW5e2JrAziE/+yA/AnVuJw+5/6BSvXW2rvjnwb7gNKo8XYtGAj8Yv
	t4GT6/fIPBUgAdt0+U/76AdUz1e3EGTEJ0dYRMcxdg38ykwouF5l8Kqy/8vCwyMpqS4f4M
	Mbc+NHlANvE7RAeR7i/0iAziPscqHYA=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-_vvx-bmGPv6ZreYsKwELsg-1; Sun, 18 Feb 2024 03:07:15 -0500
X-MC-Unique: _vvx-bmGPv6ZreYsKwELsg-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1d4212b6871so26133455ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 00:07:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708243634; x=1708848434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Jtfh06HICiZjq82VG1z1ScLpR7A6O8tDUT6Uaocrgg=;
        b=qpxQUPQyqzge1n8uqSq/qtYmAhYkfqHjMGtL45fsmmz1+atVTBljqyCk6A8V42RlM0
         npSpPmPfrm6FuMKvw5TfRyk47y5OOjfArRh5bE3oaQ9jr65W+vO9xScOfSVarMrGR6P8
         IWKsbksSqRVvWjTojANQ1/e/GjQEcHv73iQhw3sSUvDehh1qGm8AOdYUxGHrSZs6H0EM
         /IZ/lXM7bvVymBbu2tITZRFx2A96+6x7Ib0j5gf3ceqkaDsaWUuLccuUvmt47BDwP/Ro
         LLhkO3KnmLF17VOkbBndmfjB14Olc4Dcwmda671p4xShCAmvNy1rnX5T1vLdLW+fFV0W
         o4Zw==
X-Forwarded-Encrypted: i=1; AJvYcCXQROkU3plZHC8hSG66764lhJHX1wNZZjDnSuhK6pffufuLlWvxfluhJh22HxU0XoHae9Z+6Icmp3iU/VNjm8zzSIbFoMskVeTbHm+F
X-Gm-Message-State: AOJu0Yw5/V98N/dbCORCehSk6+pR+HR9z57YlPeO56Js9FHkz9Kren+0
	gVf6OUhykCW07hIIsLqNF54RgtogR70UGymIgj2uYLnI15Fqx4yEA3+6XfW9FJ1dYJ2ouK5jeqU
	fEDbq1+OfQaMItGjIA92FdL2AiY43KSH6PwPd+RZmK0B8HFTy+Qfz+02aTwogYoQ6AmU4Vg7VYK
	jWOKHUKNtnYaHDh+TAKyPKmshCt2H8BU1kCPbm
X-Received: by 2002:a17:902:f54a:b0:1db:579a:9fda with SMTP id h10-20020a170902f54a00b001db579a9fdamr12147573plf.61.1708243634366;
        Sun, 18 Feb 2024 00:07:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEYJq2UrivG1TuOO3YvaqUJDyMbQhvJyfjOV2g5r9qvL9XxPqvvp7JAKz5Ku9oGvgmpO3Sdn6fv6+tlM29m+A=
X-Received: by 2002:a17:902:f54a:b0:1db:579a:9fda with SMTP id
 h10-20020a170902f54a00b001db579a9fdamr12147561plf.61.1708243634082; Sun, 18
 Feb 2024 00:07:14 -0800 (PST)
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
 <2fa01c30-2ee7-7c01-6833-bf74142e6d7c@huaweicloud.com> <CALTww2-HngEJ9z9cYZ0=kcfuKMpziH3utSgk_8u3dxc553ZNeg@mail.gmail.com>
 <5480b350-efe3-2be7-cf3b-3a62bb0e012b@huaweicloud.com>
In-Reply-To: <5480b350-efe3-2be7-cf3b-3a62bb0e012b@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
Date: Sun, 18 Feb 2024 16:07:02 +0800
Message-ID: <CALTww2-_uvkB7M=_J_6DgW1kfzW2rpQgp0vyKt7EYvON41adGw@mail.gmail.com>
Subject: Re: [PATCH v5 01/14] md: don't ignore suspended array in md_check_recovery()
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: mpatocka@redhat.com, heinzm@redhat.com, blazej.kucman@linux.intel.com, 
	agk@redhat.com, snitzer@kernel.org, dm-devel@lists.linux.dev, song@kernel.org, 
	neilb@suse.de, shli@fb.com, akpm@osdl.org, linux-kernel@vger.kernel.org, 
	linux-raid@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com, 
	"yukuai (C)" <yukuai3@huawei.com>, Jonathan Brassow <jbrassow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 18, 2024 at 2:22=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2024/02/18 13:07, Xiao Ni =E5=86=99=E9=81=93:
> > On Sun, Feb 18, 2024 at 11:24=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.c=
om> wrote:
> >>
> >> Hi,
> >>
> >> =E5=9C=A8 2024/02/18 11:15, Xiao Ni =E5=86=99=E9=81=93:
> >>> On Sun, Feb 18, 2024 at 10:34=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud=
com> wrote:
> >>>>
> >>>> Hi,
> >>>>
> >>>> =E5=9C=A8 2024/02/18 10:27, Xiao Ni =E5=86=99=E9=81=93:
> >>>>> On Sun, Feb 18, 2024 at 9:46=E2=80=AFAM Yu Kuai <yukuai1@huaweiclou=
d.com> wrote:
> >>>>>>
> >>>>>> Hi,
> >>>>>>
> >>>>>> =E5=9C=A8 2024/02/18 9:33, Xiao Ni =E5=86=99=E9=81=93:
> >>>>>>> The deadlock problem mentioned in this patch should not be right?
> >>>>>>
> >>>>>> No, I think it's right. Looks like you are expecting other problem=
s,
> >>>>>> like mentioned in patch 6, to be fixed by this patch.
> >>>>>
> >>>>> Hi Kuai
> >>>>>
> >>>>> Could you explain why step1 and step2 from this comment can happen
> >>>>> simultaneously? From the log, the process should be
> >>>>> The process is :
> >>>>> dev_remove->dm_destroy->__dm_destroy->dm_table_postsuspend_targets(=
raid_postsuspend)
> >>>>> -> dm_table_destroy(raid_dtr).
> >>>>> After suspending the array, it calls raid_dtr. So these two functio=
ns
> >>>>> can't happen simultaneously.
> >>>>
> >>>> You're removing the target directly, however, dm can suspend the dis=
k
> >>>> directly, you can simplily:
> >>>>
> >>>> 1) dmsetup suspend xxx
> >>>> 2) dmsetup remove xxx
> >>>
> >>> For dm-raid, the design of suspend stops sync thread first and then i=
t
> >>> calls mddev_suspend to suspend array. So I'm curious why the sync
> >>> thread can still exit when array is suspended. I know the reason now.
> >>> Because before f52f5c71f (md: fix stopping sync thread), the process
> >>> is raid_postsuspend->md_stop_writes->__md_stop_writes
> >>> (__md_stop_writes sets MD_RECOVERY_FROZEN). In patch f52f5c71f, it
> >>> doesn't set MD_RECOVERY_FROZEN in __md_stop_writes anymore.
> >>>
> >>> The process changes to
> >>> 1. raid_postsuspend->md_stop_writes->__md_stop_writes->stop_sync_thre=
ad
> >>> (wait until MD_RECOVERY_RUNNING clears)
> >>> 2. md thread -> md_check_recovery -> unregister_sync_thread ->
> >>> md_reap_sync_thread (clears MD_RECOVERY_RUNNING, stop_sync_thread
> >>> returns, md_reap_sync_thread sets MD_RECOVERY_NEEDED)
> >>> 3. raid_postsuspend->mddev_suspend
> >>> 4. md sync thread starts again because __md_stop_writes doesn't set
> >>> MD_RECOVERY_FROZEN.
> >>> It's the reason why we can see sync thread still happens when raid is=
 suspended.
> >>>
> >>> So the patch fix this problem should:
> >>
> >> As I said, this is really a different problem from this patch, and it =
is
> >> fixed seperately by patch 9. Please take a look at that patch.
> >
> > I think we're talking about the same problem. In patch07 it has a new
> > api md_frozen_sync_thread. It sets MD_RECOVERY_FROZEN before
> > stop_sync_thread. This is right. If we use this api in
> > raid_postsuspend, sync thread can't restart. So the deadlock can't
> > happen anymore?
>
> We are not talking about the same problem at all. This patch just fix a
> simple problem in md/raid(not dm-raid). And the deadlock can also be
> triggered for md/raid the same.
>
> - mddev_suspend() doesn't handle sync_thread at all;
> - md_check_recovery() ignore suspended array;
>
> Please keep in mind this patch just fix the above case. The deadlock in
> dm-raid is just an example of problems caused by this. Fix the deadlock
> other way doesn't mean this case is fine.

Because this patch set is used to fix dm raid deadlocks. But this
patch changes logic, it looks like more a feature - "we can start/stop
sync thread when array is suspended". Because this patch is added many
years ago and dm raid works well. If we change this, there is
possibilities to introduce new problems. Now we should try to walk
slowly.

And is it a deadlock? After resume, the sync thread can be
started/stopped again. Could you explain the deadlock more?

>
> >
> > And patch01 is breaking one logic which seems right:
> >
> > commit 68866e425be2ef2664aa5c691bb3ab789736acf5
> > Author: Jonathan Brassow <jbrassow@f14.redhat.com>
> > Date:   Wed Jun 8 15:10:08 2011 +1000
> >
> >      MD: no sync IO while suspended
> >
> >      Disallow resync I/O while the RAID array is suspended.
> >
> > We're trying to fix deadlock problems. But it's not good to fix a
> > problem by breaking an existing rule.
>
> The existing rule itself is problematic. Above patch doesn't do well.
>
> It's just a simple problem here, should sync thread also stop in
> mddev_suspend? If you want do do this, you can submit a patch, in the
> right way, we'll see how this will work.

I don't want to change the logic of mddev_suspend. mddev_suspend is
only used to suspend array. Cc Jon who is the author of this patch.
>
> - keep this patch to remove checking of suspended array;
> - set MD_RECOVERY_FORZEN and stop sync thread in mddev_suspend,
> 'reconfig_mutex' will be needed again, and lots of callers need to be
> checked.
>
> Thanks,
> Kuai
>
> >
> > Regards
> > Xiao
> >
> >
> >>
> >> Thanks,
> >> Kuai
> >>
> >>>
> >>> diff --git a/drivers/md/md.c b/drivers/md/md.c
> >>> index 9e41a9aaba8b..666761466f02 100644
> >>> --- a/drivers/md/md.c
> >>> +++ b/drivers/md/md.c
> >>> @@ -6315,6 +6315,7 @@ static void md_clean(struct mddev *mddev)
> >>>
> >>>    static void __md_stop_writes(struct mddev *mddev)
> >>>    {
> >>> +       set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
> >>>           stop_sync_thread(mddev, true, false);
> >>>           del_timer_sync(&mddev->safemode_timer);
> >>>
> >>> Like other places which call stop_sync_thread, it needs to set the
> >>> MD_RECOVERY_FROZEN bit.
> >>>
> >>> Regards
> >>> Xiao
> >>>
> >>>>
> >>>> Please also take a look at other patches, why step 1) can't stop syn=
c
> >>>> thread.
> >>>>
> >>>> Thanks,
> >>>> Kuai
> >>>>
> >>>>>
> >>>>>
> >>>>>>
> >>>>>> Noted that this patch just fix one case that MD_RECOVERY_RUNNING c=
an't
> >>>>>> be cleared, I you are testing this patch alone, please make sure t=
hat
> >>>>>> you still triggered the exactly same case:
> >>>>>>
> >>>>>> - MD_RCOVERY_RUNNING can't be cleared while array is suspended.
> >>>>>
> >>>>> I'm not testing this patch. I want to understand the patch well. So=
 I
> >>>>> need to understand the issue first. I can't understand how this
> >>>>> deadlock (step1,step2) happens.
> >>>>>
> >>>>> Regards
> >>>>> Xiao
> >>>>>>
> >>>>>> Thanks,
> >>>>>> Kuai
> >>>>>>
> >>>>>
> >>>>> .
> >>>>>
> >>>>
> >>>
> >>> .
> >>>
> >>
> >
> > .
> >
>



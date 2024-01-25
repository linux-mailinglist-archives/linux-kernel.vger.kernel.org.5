Return-Path: <linux-kernel+bounces-38545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAA783C151
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CB2DB22252
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E4B33CD4;
	Thu, 25 Jan 2024 11:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cLKqjHM2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC5621363
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 11:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706183542; cv=none; b=sj1PKShA/1F93m+tmrdtXso9oQYpX1+YEhqw0+V63a8WbKzMT1f03AF4PqAkYETO3ptv7ZUhgrHODhon/mYXNODQNfiM3sjUFMG9xzBmu+HTokYbrbo+Ka82HwmdxMqOjawkErErzgo41vcr9ZPRg+H3yx+ZKwXE15p2wT8Mkb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706183542; c=relaxed/simple;
	bh=8IesGh+lx2LeP9ioxmdrGvTfTItFKf+5RiQ6HGAYuic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gehEWDBjYevwzdF1Nq3Ir5GylEiVtw88aX0dq9jh+b+2zfLdhmlpBNw5keVfEV9YKVvbztDvG1YAPfkBzqv1HCkQO8v30I/8dFOVoTBtLSkDf4ONRQCblKQFsPKRjUzGmiHu8yxNObAqIJWGxwv15a+D1Y2Yt+qY9gOwdnD3LeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cLKqjHM2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706183539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a/fiwP5nCJZgkSM5yfNnrbsyzm77LZ+A2VSTp+p+hDE=;
	b=cLKqjHM2bSNjhLI2CRnCXamJ0VpQsWKsNC175zyn+tqZyusEbExg7ibYZtuPOxTF8gPHWm
	oJiKh91560Vx1H8et5nvz5LsYV08AlJX/i3FminsxIJWvZqsIeTPFJR5yroRRylQfy/PDf
	9NWtqUzFNciWHLc4S5kPk770CUpy+u4=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-_9YzTG2WNWmDpzvdAFlr-g-1; Thu, 25 Jan 2024 06:52:16 -0500
X-MC-Unique: _9YzTG2WNWmDpzvdAFlr-g-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6dbcdfde0eeso3752985b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 03:52:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706183535; x=1706788335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/fiwP5nCJZgkSM5yfNnrbsyzm77LZ+A2VSTp+p+hDE=;
        b=n/x1ohy3+oi/dwn2akBWocxDE/cRofVGEcotNFtLuKjAPmVnGTCAH/MgSvtdWiv+It
         wuAZJ9mUICs4LIAkrlhhPoNNLcQv4Hf5QJlLWOY9Um0KNbmoY1q+aPvy9GmmxveORpBU
         yPS9JHJOJA9sL1KF4dKUyIg4RwqB0q2lkXN3dP6z4nKO8fJeo91Ed2IcEG8zCLcfvUSb
         H4srgEILyHCs1+OF5+K9PW4rmM5gudfPJY3PAJLSsTpafnn98ri21KRSDWGgUZ+YVT+L
         iQAN2AGpyHzUgJ1kG7c803CtNO1M55oPFfbt7OsuaB1dzIGjZ1pnq4MloWkJbTIkZA/x
         KO0Q==
X-Gm-Message-State: AOJu0YyF4lFNS5vJ9D7/1E2kv5ny3ngOQJ4fQx7orefqCCDYodGFfD5b
	55yZnrmIWzZoUi1D9MrwR1zTyqbcmo5KCbpHKM5oB5hs6FyC5bnIKYvx6DGkseLCZYLhX7OBSbg
	3IMYNjGJA4CxNyr0+891cSgkPv/MchJmqDLYGLVDNdEReRt4/bNB84bpiY5JLRqZy71qzjKFdSO
	/5MishHFMva/djK6bhj5553UN4bObzFtlWdv2R
X-Received: by 2002:aa7:9888:0:b0:6db:acb2:a95d with SMTP id r8-20020aa79888000000b006dbacb2a95dmr405920pfl.21.1706183535465;
        Thu, 25 Jan 2024 03:52:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYrXlRNOoYBrLSZC2TdQI370D1/7JhsEPYlxfVvUC8O4Maf4BOLfkBDc7QWWl2ffHVXX0VtYxkCOuCMhofu54=
X-Received: by 2002:aa7:9888:0:b0:6db:acb2:a95d with SMTP id
 r8-20020aa79888000000b006dbacb2a95dmr405910pfl.21.1706183535167; Thu, 25 Jan
 2024 03:52:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124091421.1261579-1-yukuai3@huawei.com> <20240124091421.1261579-6-yukuai3@huawei.com>
 <CALTww2_V6Cr4j7hMPnMMt-g2w_xfCHQvwBpwbyOk=5rGcap6YA@mail.gmail.com> <d7b8043e-c921-8769-f39f-5105f2e866b6@huawei.com>
In-Reply-To: <d7b8043e-c921-8769-f39f-5105f2e866b6@huawei.com>
From: Xiao Ni <xni@redhat.com>
Date: Thu, 25 Jan 2024 19:52:04 +0800
Message-ID: <CALTww2_jezrwJu0Vea+0mePBrV_9RwUMZ=J+_WV0KS-ShW1WPg@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] md: export helpers to stop sync_thread
To: Yu Kuai <yukuai3@huawei.com>
Cc: agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com, 
	dm-devel@lists.linux.dev, song@kernel.org, neilb@suse.de, heinzm@redhat.com, 
	shli@fb.com, akpm@osdl.org, linux-kernel@vger.kernel.org, 
	linux-raid@vger.kernel.org, yukuai1@huaweicloud.com, yi.zhang@huawei.com, 
	yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 7:42=E2=80=AFPM Yu Kuai <yukuai3@huawei.com> wrote:
>
> Hi,
>
> =E5=9C=A8 2024/01/25 19:35, Xiao Ni =E5=86=99=E9=81=93:
> > Hi all
> >
> > This is the result of lvm2 tests:
> > make check
> > ### 426 tests: 319 passed, 74 skipped, 0 timed out, 5 warned, 28
> > failed   in 56:04.914
>
> Are you testing with this patchset? 28 failed is much more than my
> test result in following:

Yes, 6.7.0-rc8 with this patch set.
>
> > make[1]: *** [Makefile:138: check] Error 1
> > make[1]: Leaving directory '/root/lvm2/test'
> > make: *** [Makefile:89: check] Error 2
> >
> > Do you know where to check which cases fail?
>
> I saved logs and grep keyword "failed:", and the result will look like
> this:

I'll use this way to collect the failed cases.

Regards
Xiao
>
>
> You can find each test log in the dir test/result/
> >
> > Best Regards
> > Xiao
> >
> > On Wed, Jan 24, 2024 at 5:19=E2=80=AFPM Yu Kuai <yukuai3@huawei.com> wr=
ote:
> >>
> >> The new heleprs will be used in dm-raid in later patches to fix
> >> regressions and prevent calling md_reap_sync_thread() directly.
> >>
> >> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> >> ---
> >>   drivers/md/md.c | 41 +++++++++++++++++++++++++++++++++++++----
> >>   drivers/md/md.h |  3 +++
> >>   2 files changed, 40 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/md/md.c b/drivers/md/md.c
> >> index 6c5d0a372927..90cf31b53804 100644
> >> --- a/drivers/md/md.c
> >> +++ b/drivers/md/md.c
> >> @@ -4915,30 +4915,63 @@ static void stop_sync_thread(struct mddev *mdd=
ev, bool locked, bool check_seq)
> >>                  mddev_lock_nointr(mddev);
> >>   }
> >>
> >> -static void idle_sync_thread(struct mddev *mddev)
> >> +void md_idle_sync_thread(struct mddev *mddev)
> >>   {
> >> +       lockdep_assert_held(mddev->reconfig_mutex);
> >> +
> >>          mutex_lock(&mddev->sync_mutex);
> >>          clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
> >> +       stop_sync_thread(mddev, true, true);
> >> +       mutex_unlock(&mddev->sync_mutex);
> >> +}
> >> +EXPORT_SYMBOL_GPL(md_idle_sync_thread);
> >> +
> >> +void md_frozen_sync_thread(struct mddev *mddev)
> >> +{
> >> +       lockdep_assert_held(mddev->reconfig_mutex);
> >> +
> >> +       mutex_lock(&mddev->sync_mutex);
> >> +       set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
> >> +       stop_sync_thread(mddev, true, false);
> >> +       mutex_unlock(&mddev->sync_mutex);
> >> +}
> >> +EXPORT_SYMBOL_GPL(md_frozen_sync_thread);
> >>
> >> +void md_unfrozen_sync_thread(struct mddev *mddev)
> >> +{
> >> +       lockdep_assert_held(mddev->reconfig_mutex);
> >> +
> >> +       mutex_lock(&mddev->sync_mutex);
> >> +       clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
> >> +       set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
> >> +       md_wakeup_thread(mddev->thread);
> >> +       sysfs_notify_dirent_safe(mddev->sysfs_action);
> >> +       mutex_unlock(&mddev->sync_mutex);
> >> +}
> >> +EXPORT_SYMBOL_GPL(md_unfrozen_sync_thread);
> >> +
> >> +static void idle_sync_thread(struct mddev *mddev)
> >> +{
> >>          if (mddev_lock(mddev)) {
> >>                  mutex_unlock(&mddev->sync_mutex);
> >>                  return;
> >>          }
> >>
> >> +       mutex_lock(&mddev->sync_mutex);
> >> +       clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
> >>          stop_sync_thread(mddev, false, true);
> >>          mutex_unlock(&mddev->sync_mutex);
> >>   }
> >>
> >>   static void frozen_sync_thread(struct mddev *mddev)
> >>   {
> >> -       mutex_lock(&mddev->sync_mutex);
> >> -       set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
> >> -
> >>          if (mddev_lock(mddev)) {
> >>                  mutex_unlock(&mddev->sync_mutex);
> >>                  return;
> >>          }
> >>
> >> +       mutex_lock(&mddev->sync_mutex);
> >> +       set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
> >>          stop_sync_thread(mddev, false, false);
> >>          mutex_unlock(&mddev->sync_mutex);
> >>   }
> >> diff --git a/drivers/md/md.h b/drivers/md/md.h
> >> index 8d881cc59799..437ab70ce79b 100644
> >> --- a/drivers/md/md.h
> >> +++ b/drivers/md/md.h
> >> @@ -781,6 +781,9 @@ extern void md_rdev_clear(struct md_rdev *rdev);
> >>   extern void md_handle_request(struct mddev *mddev, struct bio *bio);
> >>   extern int mddev_suspend(struct mddev *mddev, bool interruptible);
> >>   extern void mddev_resume(struct mddev *mddev);
> >> +extern void md_idle_sync_thread(struct mddev *mddev);
> >> +extern void md_frozen_sync_thread(struct mddev *mddev);
> >> +extern void md_unfrozen_sync_thread(struct mddev *mddev);
> >>
> >>   extern void md_reload_sb(struct mddev *mddev, int raid_disk);
> >>   extern void md_update_sb(struct mddev *mddev, int force);
> >> --
> >> 2.39.2
> >>
> >
> > .
> >
>



Return-Path: <linux-kernel+bounces-37836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0450683B63A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 01:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28C161C22AF0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 00:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450DC1C17;
	Thu, 25 Jan 2024 00:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bujfcz1Z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64C080A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 00:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706143871; cv=none; b=eWcpjOE7JX4ectarvDPmUk8wIs39Yuh3KJ7wdDk8e5KlTUNbxly9WpLV7Yp3DKs7T/sdwadhsFzxyDK+TRig00Ljta7lip7dZuxd8wAeeHgktSDWWqa1uv0RFYL95Qff4g96CxrmLRioVV4xcXPVtAvLgxxHpA7yIvW7Ryc4bGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706143871; c=relaxed/simple;
	bh=c2fjGalsLFeem+qwFcS0e2Y00bJme3JEbHPVemUaIZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QnuySTjir4J5wtI/uoprFSbEsY0qDcMsHc4d6UCrt2UESGFA9fJLbW1tILfS3SimgbI0svpJ9e9qj7qylMJOnAOGCAJLR7UcbW1nHBpdNiilSQVu68/kLAZAgM6Jm6chrZDRVC8mZA7fTC/l3qc2Hy1SPBIKRf4flaH2Iuf07H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bujfcz1Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706143867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qKGJNl2O8JOD0LA1Q2Y+fNkjTUD3jEbvdwB0OSzoS/o=;
	b=bujfcz1ZtBKaTLoGvKMxVQJAIgWhmq657Bil4NsAKGUVALlaG+JPql5zbusQBT5DC2bG6b
	SSrpl9KgzlzJhMMsSLobmlQYDVMrX22YodSSxRVrses5Eq6Rmv47Rf6ajsc2C6hNSzxpUW
	vZ9CT9z0rN8MIinqiA8F3e1oyvzIwBY=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-dGBFBVZUNKiJWYxv4RFJZQ-1; Wed, 24 Jan 2024 19:51:06 -0500
X-MC-Unique: dGBFBVZUNKiJWYxv4RFJZQ-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5d1bffa322eso2825525a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 16:51:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706143865; x=1706748665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qKGJNl2O8JOD0LA1Q2Y+fNkjTUD3jEbvdwB0OSzoS/o=;
        b=msP8ARFeG/qYNMAJ0GkSO96A9+ANv0M5CCJHhg419givemgQ6+OXKcPKMbPsiCI76s
         lb6zt7fmcM1DDgUA6C6n9Eu6wsPX7+5ZeBDQ24QuQjqn5TF4JKEInx0tlWv83yZoboh7
         04ydFQQiMNPc/wpLaSzU3lY3tWE/yS1k2v8J+ZtLIGM2dIAV604OBOOi6nqinbpJzRcR
         n/ZeM1SSTay6UmfbUFaFV7xMrbbSfx95Uqm2BbS9hSZzldG3A6F1AXADLEMGfGC9n2xY
         BiTE3vtA527sAFgELpKoTadUwYEXdjkazhT4fsFw5itDPW5t1evdR74kviLbt4h73NyM
         lwjA==
X-Gm-Message-State: AOJu0Yx2nBDhp0H9f0PSNgJTmBtVWu6anF+FR7f2b31QoD+ZmulhHMyb
	Iu7tg7zUIlcv64K6qVDfhmmCd/IuPQGvU0sixBe1/bozPuib+2NKW2NwwCCuAd8sZncJQMN3ewV
	KyRruTL+p/1vUXsr6cAMsubn3lQI66m5VxYlfH1IYfMZJwYllYVZwqpC6eWGnd6CMelElOZYB3Y
	SJSd3SrxyX7+Uo99AtTiI4MwYUMR2cu3WNitkm
X-Received: by 2002:a05:6a20:42a1:b0:199:8ae6:6419 with SMTP id o33-20020a056a2042a100b001998ae66419mr429236pzj.1.1706143865528;
        Wed, 24 Jan 2024 16:51:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEslbhODYYRMYKKvDHhLBAJWJBER5MC9tYxHRWekks7CcSWaN2wJe1Y6BN4Nnxn83BYoiZpVD0QWYJcZJr3NRU=
X-Received: by 2002:a05:6a20:42a1:b0:199:8ae6:6419 with SMTP id
 o33-20020a056a2042a100b001998ae66419mr429218pzj.1.1706143865220; Wed, 24 Jan
 2024 16:51:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124091421.1261579-1-yukuai3@huawei.com> <CALTww28G_CmSxzJZVDqHmPgdmT1e2X8+QcToiUOGV1msAisTcQ@mail.gmail.com>
In-Reply-To: <CALTww28G_CmSxzJZVDqHmPgdmT1e2X8+QcToiUOGV1msAisTcQ@mail.gmail.com>
From: Xiao Ni <xni@redhat.com>
Date: Thu, 25 Jan 2024 08:50:54 +0800
Message-ID: <CALTww2-1oSCahsqouQv2WT1SDCYDGRepJyh9e_Ph=YjPEboqXQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] dm-raid: fix v6.7 regressions
To: Yu Kuai <yukuai3@huawei.com>
Cc: agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com, 
	dm-devel@lists.linux.dev, song@kernel.org, jbrassow@f14.redhat.com, 
	neilb@suse.de, heinzm@redhat.com, shli@fb.com, akpm@osdl.org, 
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, 
	yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 8:19=E2=80=AFPM Xiao Ni <xni@redhat.com> wrote:
>
> On Wed, Jan 24, 2024 at 5:18=E2=80=AFPM Yu Kuai <yukuai3@huawei.com> wrot=
e:
> >
> > First regression related to stop sync thread:
> >
> > The lifetime of sync_thread is designed as following:
> >
> > 1) Decide want to start sync_thread, set MD_RECOVERY_NEEDED, and wake u=
p
> > daemon thread;
> > 2) Daemon thread detect that MD_RECOVERY_NEEDED is set, then set
> > MD_RECOVERY_RUNNING and register sync_thread;
> > 3) Execute md_do_sync() for the actual work, if it's done or
> > interrupted, it will set MD_RECOVERY_DONE and wake up daemone thread;
> > 4) Daemon thread detect that MD_RECOVERY_DONE is set, then clear
> > MD_RECOVERY_RUNNING and unregister sync_thread;
> >
> > In v6.7, we fix md/raid to follow this design by commit f52f5c71f3d4
> > ("md: fix stopping sync thread"), however, dm-raid is not considered at
> > that time, and following test will hang:
>
> Hi Kuai
>
> Thanks very much for the patch set. I reported the dm raid deadlock
> when stopping dm raid and we had the patch set "[PATCH v5 md-fixes
> 0/3] md: fix stopping sync thread" which has patch f52f5c71f3d4. So we
> indeed considered dm-raid that time. Because we want to resolve the
> deadlock problem. I re-look patch f52f5c71f3d4. It has two major
> changes. One is to use a common function stop_sync_thread for stopping
> sync thread. This can fix the deadlock problem. The second change
> changes the way to reap sync thread. mdraid and dmraid reap sync
> thread in __md_stop_writes. So the patch looks overweight.
>
> Before f52f5c71f3d4  do_md_stop release reconfig_mutex before waiting
> sync_thread to finish. So there should not be the deadlock problem
> which has been fixed in 130443d60b1b ("md: refactor
> idle/frozen_sync_thread() to fix deadlock"). So we only need to change
> __md_stop_writes to stop sync thread like do_md_stop and reap sync
> thread directly.
>
> Maybe this can avoid deadlock? I'll try this way and give the test result=
.

Please ignore my last comment. There is something wrong. Only dmraid
calls reap_sync_thread directly in __md_stop_writes before.

130443d60b1b ("md: refactor idle/frozen_sync_thread() to fix
deadlock") fixes a deadlock problem. sync io is running and user io
comes. sync io needs to wait user io. user io needs to update
suerblock and it needs mddev->reconfig_mutex. But user action happens
with this lock to stop sync thread. So this is the deadlock. For
dmraid, it doesn't update superblock like md. I'm not sure if dmraid
has such deadlock problem. If not, dmraid can call md_reap_sync_thread
directly, right?

> >
> > shell/integrity-caching.sh
> > shell/lvconvert-raid-reshape.sh
> >
> > This patch set fix the broken test by patch 1-4;
> >  - patch 1 fix that step 4) is broken by suspended array;
> >  - patch 2 fix that step 4) is broken by read-only array;
> >  - patch 3 fix that step 3) is broken that md_do_sync() doesn't set
> >  MD_RECOVERY_DONE; Noted that this patch will introdece new problem tha=
t
> >  data will be corrupted, which will be fixed in later patches.
> >  - patch 4 fix that setp 1) is broken that sync_thread is register and
> >  MD_RECOVERY_RUNNING is set directly;
> >
> > With patch 1-4, the above test won't hang anymore, however, the test
> > will still fail and complain that ext4 is corrupted;
>
> For patch3, as I mentioned today, the root cause is
> dm-raid->rs_start_reshape sets MD_RECOVERY_WAIT. So md_do_sync returns
> when MD_RECOVERY_WAIT is set. It's the reason why dm-raid can't stop
> sync thread when start a new reshape. . The way in patch3 looks like a
> workaround. We need to figure out if dm raid really needs to set
> MD_RECOVERY_WAIT. Because now we stop sync thread in an asynchronous
> way. So the deadlock problem which was fixed in 644e2537f (dm raid:
> fix stripe adding reshape deadlock) may disappear. Maybe we can revert
> the patch.

After talking with Heinz, he mentioned dmraid needs this bit to avoid
md sync thread to start during reshape. So patch3 looks good.

Best Regards
Xiao
>
> Best Regards
> Xiao
>
> >
> > Second regression related to frozen sync thread:
> >
> > Noted that for raid456, if reshape is interrupted, then call
> > "pers->start_reshape" will corrupt data. This is because dm-raid rely o=
n
> > md_do_sync() doesn't set MD_RECOVERY_DONE so that new sync_thread won't
> > be registered, and patch 3 just break this.
> >
> >  - Patch 5-6 fix this problem by interrupting reshape and frozen
> >  sync_thread in dm_suspend(), then unfrozen and continue reshape in
> > dm_resume(). It's verified that dm-raid tests won't complain that
> > ext4 is corrupted anymore.
> >  - Patch 7 fix the problem that raid_message() call
> >  md_reap_sync_thread() directly, without holding 'reconfig_mutex'.
> >
> > Last regression related to dm-raid456 IO concurrent with reshape:
> >
> > For raid456, if reshape is still in progress, then IO across reshape
> > position will wait for reshape to make progress. However, for dm-raid,
> > in following cases reshape will never make progress hence IO will hang:
> >
> > 1) the array is read-only;
> > 2) MD_RECOVERY_WAIT is set;
> > 3) MD_RECOVERY_FROZEN is set;
> >
> > After commit c467e97f079f ("md/raid6: use valid sector values to determ=
ine
> > if an I/O should wait on the reshape") fix the problem that IO across
> > reshape position doesn't wait for reshape, the dm-raid test
> > shell/lvconvert-raid-reshape.sh start to hang at raid5_make_request().
> >
> > For md/raid, the problem doesn't exist because:
> >
> > 1) If array is read-only, it can switch to read-write by ioctl/sysfs;
> > 2) md/raid never set MD_RECOVERY_WAIT;
> > 3) If MD_RECOVERY_FROZEN is set, mddev_suspend() doesn't hold
> >    'reconfig_mutex' anymore, it can be cleared and reshape can continue=
 by
> >    sysfs api 'sync_action'.
> >
> > However, I'm not sure yet how to avoid the problem in dm-raid yet.
> >
> >  - patch 9-11 fix this problem by detecting the above 3 cases in
> >  dm_suspend(), and fail those IO directly.
> >
> > If user really meet the IO error, then it means they're reading the wro=
ng
> > data before c467e97f079f. And it's safe to read/write the array after
> > reshape make progress successfully.
> >
> > Tests:
> >
> > I already run the following two tests many times and verified that they
> > won't fail anymore:
> >
> > shell/integrity-caching.sh
> > shell/lvconvert-raid-reshape.sh
> >
> > For other tests, I'm still running. However, I'm sending this patchset
> > in case people think the fixes is not appropriate. Running the full
> > tests will cost lots of time in my VM, and I'll update full test result=
s
> > soon.
> >
> > Yu Kuai (11):
> >   md: don't ignore suspended array in md_check_recovery()
> >   md: don't ignore read-only array in md_check_recovery()
> >   md: make sure md_do_sync() will set MD_RECOVERY_DONE
> >   md: don't register sync_thread for reshape directly
> >   md: export helpers to stop sync_thread
> >   dm-raid: really frozen sync_thread during suspend
> >   md/dm-raid: don't call md_reap_sync_thread() directly
> >   dm-raid: remove mddev_suspend/resume()
> >   dm-raid: add a new helper prepare_suspend() in md_personality
> >   md: export helper md_is_rdwr()
> >   md/raid456: fix a deadlock for dm-raid456 while io concurrent with
> >     reshape
> >
> >  drivers/md/dm-raid.c |  76 +++++++++++++++++++++----------
> >  drivers/md/md.c      | 104 ++++++++++++++++++++++++++++---------------
> >  drivers/md/md.h      |  16 +++++++
> >  drivers/md/raid10.c  |  16 +------
> >  drivers/md/raid5.c   |  61 +++++++++++++------------
> >  5 files changed, 171 insertions(+), 102 deletions(-)
> >
> > --
> > 2.39.2
> >



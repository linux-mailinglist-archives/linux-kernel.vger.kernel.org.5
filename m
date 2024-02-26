Return-Path: <linux-kernel+bounces-81484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0D6867686
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 474411F2A665
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C871292DA;
	Mon, 26 Feb 2024 13:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D5x+QZ9B"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24834128390
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 13:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708954076; cv=none; b=sLb1vs23iO30Eb9q38Te7HF6zjHTWmiHx0MvH5sotu0KpPAGAtR4y1rsGKxVwQsdvNy9Jj2mm2ykmo3o93CajwjDmOsYzXh7ySfYT0fPpy4jF6mXTwyvBwvwS4JPT4gprbZCOZJwMYwIQ54cFA27Nfm0c7vynKDz/P/+7H3DmYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708954076; c=relaxed/simple;
	bh=T8tdgzrhrtTp977R/V+8iJ3V0sG95/J33jqfc52O2MI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NQEIufYnOVlZjzwJXWQAieMYuF98ZUZOYnct6I8UqyM6v6jw7xGDgtTX77V5/BJElYTG5PxNJ6sBqcb9pfLnFf60uYuErYz521l5dwHuQdB6d8COCdLQXLzy1AIC0CumjbIKOtGa42p+F8wwp7uisRDRX0KmrzJHHXVwFkF1mu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D5x+QZ9B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708954072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z8w6/0vqHg5ud85HrdTrNfceLXjncDmoV6MpxEMiBEE=;
	b=D5x+QZ9BfdrkC4MdohzBGhZ7ftyY3LTxNf1EWe07KsJsh1qw2/uQcig33pBeURhEJ6CkSP
	euvJjE799kfbWivaQ1gfcw4DzNP+Bpud+8JFeMDXYCORMBrJy8Sk2K2VIvsG0pfEMNBSVH
	SXCSxGwApD6Uecbz07G6qS0aBc5ith4=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-bD3Y7vqAOMmxHUOy71knuQ-1; Mon, 26 Feb 2024 08:27:51 -0500
X-MC-Unique: bD3Y7vqAOMmxHUOy71knuQ-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5d1bffa322eso3114316a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 05:27:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708954070; x=1709558870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z8w6/0vqHg5ud85HrdTrNfceLXjncDmoV6MpxEMiBEE=;
        b=pEbM5kYjezET2Z1lh7ThKVUoZMe/bi0ttE/RhYXq/zbesk9jG4Miek8tiJVv/Hl8mP
         ET0/2K2BlyIxYwYlCO7qY/bRIcEcalnaxaaPmX7Mgz4AGJXLmgzaTDBQcBapEDFlEnLY
         ANplX3rZY71RF9mhBk5EzEEjmGc/Chh+wsFF2aR97MmuQLqT3hGj7Z6CMUsf5LMY6RqH
         NAcy7J5GKlw7rBjaLHVyO0xXZgz3hOxevlft8T919iO4RyPakxUAzbhmzcSuHwmex91M
         NbXVWUxu3LIbomx0CGZyyajfxoS+2Ec9klVNop0ljWYnOkK6Hsu+XMFJw74JhnOtHtJz
         AGIw==
X-Forwarded-Encrypted: i=1; AJvYcCVktq7xL5wYi9h9nDaWRfnkIZ+kzevMaeienph7IU7og9MAe8lz36GtO0s+rzmsIgOlGaxKtxN2vLrotzxjf+r8sSxbZFojAuX7E66t
X-Gm-Message-State: AOJu0YyzOVJIjqw8SfUWrSy9rB0zyl1CRyCTfBSqLRqnoHtV/0QLQ50K
	Ln0mGHoxAGa0IP5/WMTC8GaVX4oPp6XhEmCd1sVOb4Fc9CwDDfzwq4mmcDGQmeP3KvOd05SrO+a
	WT2elyNgvCX/j83R/et4ZSR9JgVQgNarNlCKWItgEKdDgzHdSezvtYLJTs0qn5/gd/zLupb5zgP
	9yUhf6wRVSeI1nsCd618L8ijF9IncdRSUEufPf
X-Received: by 2002:a17:902:c40b:b0:1db:28bd:2949 with SMTP id k11-20020a170902c40b00b001db28bd2949mr10039759plk.0.1708954070419;
        Mon, 26 Feb 2024 05:27:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGa0lkMg6tODupd6hGyVfbDgzjWaQY33FnusjLpMThoApTW1DfAPH95zMASPt7DGnwvK0FBiE2CWDZWSQLaWKE=
X-Received: by 2002:a17:902:c40b:b0:1db:28bd:2949 with SMTP id
 k11-20020a170902c40b00b001db28bd2949mr10039741plk.0.1708954070086; Mon, 26
 Feb 2024 05:27:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222075806.1816400-1-yukuai1@huaweicloud.com>
 <20240222075806.1816400-3-yukuai1@huaweicloud.com> <CALTww28nOniYZDV9Kpaymze=Ph+EKSwrr+2QMo2WQsR3hKvD_A@mail.gmail.com>
 <32521aa2-876e-0e87-975b-34ff00f9095c@huaweicloud.com>
In-Reply-To: <32521aa2-876e-0e87-975b-34ff00f9095c@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
Date: Mon, 26 Feb 2024 21:27:39 +0800
Message-ID: <CALTww2-dzRKm2xNUMskbRyeEtgLSrsS38uAzVdG4UUeAk1PiOw@mail.gmail.com>
Subject: Re: [PATCH md-6.9 02/10] md: record nonrot rdevs while
 adding/removing rdevs to conf
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: paul.e.luse@linux.intel.com, song@kernel.org, neilb@suse.com, shli@fb.com, 
	linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 9:25=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2024/02/26 21:12, Xiao Ni =E5=86=99=E9=81=93:
> > Hi Kuai
> >
> > I added some logs to check and add_bound_rdev can't be called when
> > creating raid device. Maybe move rdev_update_nonrot to
> > bind_rdev_to_array?
>
> bind_rdev_to_array() is used to add new rdev to the array, then
> 'pers->hot_add_disk' is used to add the rdev to conf. For new spares,
> bind_rdev_to_array() will be called while 'pers->hot_add_disk' won't.
> Hence rdev_update_nonrot() is used where 'pers->hot_add_disk' succeed
> in this patch.
>
> Perhaps it's better to move related code to raid1/raid10_add_disk() and
> the new counter in raid1/raid10 conf?

Yes, this sounds better.

Regards
Xiao
>
> Thanks,
> Kuai
>
> >
> > Regards
> > Xiao
> >
> > On Thu, Feb 22, 2024 at 4:04=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.co=
m> wrote:
> >>
> >> From: Yu Kuai <yukuai3@huawei.com>
> >>
> >> For raid1/raid10, each read will iterate all the rdevs from conf and
> >> check if any rdev is non-rotational, then choose rdev with minimal IO
> >> inflight if so, or rdev with closest distance otherwise.
> >>
> >> Disk nonrot info can be changed through sysfs entry:
> >>
> >> /sys/block/[disk_name]/queue/rotational
> >>
> >> However, consider that this should only be used for testing, and user
> >> really shouldn't do this in real life. Record the number of non-rotati=
onal
> >> disks in mddev, to avoid checking each rdev in IO fast path and simpli=
fy
> >> read_balance() a little bit.
> >>
> >> Co-developed-by: Paul Luse <paul.e.luse@linux.intel.com>
> >> Signed-off-by: Paul Luse <paul.e.luse@linux.intel.com>
> >> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> >> ---
> >>   drivers/md/md.c     | 28 ++++++++++++++++++++++++++--
> >>   drivers/md/md.h     |  2 ++
> >>   drivers/md/raid1.c  |  9 ++-------
> >>   drivers/md/raid10.c |  8 ++------
> >>   4 files changed, 32 insertions(+), 15 deletions(-)
> >>
> >> diff --git a/drivers/md/md.c b/drivers/md/md.c
> >> index e2a5f513dbb7..9e671eec9309 100644
> >> --- a/drivers/md/md.c
> >> +++ b/drivers/md/md.c
> >> @@ -146,6 +146,24 @@ static inline int speed_max(struct mddev *mddev)
> >>                  mddev->sync_speed_max : sysctl_speed_limit_max;
> >>   }
> >>
> >> +static void rdev_update_nonrot(struct md_rdev *rdev)
> >> +{
> >> +       if (!bdev_nonrot(rdev->bdev))
> >> +               return;
> >> +
> >> +       set_bit(Nonrot, &rdev->flags);
> >> +       WRITE_ONCE(rdev->mddev->nonrot_disks, rdev->mddev->nonrot_disk=
s + 1);
> >> +}
> >> +
> >> +static void rdev_clear_nonrot(struct md_rdev *rdev)
> >> +{
> >> +       if (!test_bit(Nonrot, &rdev->flags))
> >> +               return;
> >> +
> >> +       clear_bit(Nonrot, &rdev->flags);
> >> +       WRITE_ONCE(rdev->mddev->nonrot_disks, rdev->mddev->nonrot_disk=
s - 1);
> >> +}
> >> +
> >>   static void rdev_uninit_serial(struct md_rdev *rdev)
> >>   {
> >>          if (!test_and_clear_bit(CollisionCheck, &rdev->flags))
> >> @@ -2922,6 +2940,8 @@ static int add_bound_rdev(struct md_rdev *rdev)
> >>                          md_kick_rdev_from_array(rdev);
> >>                          return err;
> >>                  }
> >> +
> >> +               rdev_update_nonrot(rdev);
> >>          }
> >>          sysfs_notify_dirent_safe(rdev->sysfs_state);
> >>
> >> @@ -3271,8 +3291,10 @@ slot_store(struct md_rdev *rdev, const char *bu=
f, size_t len)
> >>                  if (err) {
> >>                          rdev->raid_disk =3D -1;
> >>                          return err;
> >> -               } else
> >> -                       sysfs_notify_dirent_safe(rdev->sysfs_state);
> >> +               }
> >> +
> >> +               rdev_update_nonrot(rdev);
> >> +               sysfs_notify_dirent_safe(rdev->sysfs_state);
> >>                  /* failure here is OK */;
> >>                  sysfs_link_rdev(rdev->mddev, rdev);
> >>                  /* don't wakeup anyone, leave that to userspace. */
> >> @@ -9266,6 +9288,7 @@ static int remove_and_add_spares(struct mddev *m=
ddev,
> >>          rdev_for_each(rdev, mddev) {
> >>                  if ((this =3D=3D NULL || rdev =3D=3D this) && rdev_re=
moveable(rdev) &&
> >>                      !mddev->pers->hot_remove_disk(mddev, rdev)) {
> >> +                       rdev_clear_nonrot(rdev);
> >>                          sysfs_unlink_rdev(mddev, rdev);
> >>                          rdev->saved_raid_disk =3D rdev->raid_disk;
> >>                          rdev->raid_disk =3D -1;
> >> @@ -9289,6 +9312,7 @@ static int remove_and_add_spares(struct mddev *m=
ddev,
> >>                  if (!test_bit(Journal, &rdev->flags))
> >>                          rdev->recovery_offset =3D 0;
> >>                  if (mddev->pers->hot_add_disk(mddev, rdev) =3D=3D 0) =
{
> >> +                       rdev_update_nonrot(rdev);
> >>                          /* failure here is OK */
> >>                          sysfs_link_rdev(mddev, rdev);
> >>                          if (!test_bit(Journal, &rdev->flags))
> >> diff --git a/drivers/md/md.h b/drivers/md/md.h
> >> index a49ab04ab707..54aa951f2bba 100644
> >> --- a/drivers/md/md.h
> >> +++ b/drivers/md/md.h
> >> @@ -207,6 +207,7 @@ enum flag_bits {
> >>                                   * check if there is collision betwee=
n raid1
> >>                                   * serial bios.
> >>                                   */
> >> +       Nonrot,                 /* non-rotational device (SSD) */
> >>   };
> >>
> >>   static inline int is_badblock(struct md_rdev *rdev, sector_t s, int =
sectors,
> >> @@ -312,6 +313,7 @@ struct mddev {
> >>          unsigned long                   flags;
> >>          unsigned long                   sb_flags;
> >>
> >> +       int                             nonrot_disks;
> >>          int                             suspended;
> >>          struct mutex                    suspend_mutex;
> >>          struct percpu_ref               active_io;
> >> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> >> index a145fe48b9ce..c60ea58ae8c5 100644
> >> --- a/drivers/md/raid1.c
> >> +++ b/drivers/md/raid1.c
> >> @@ -599,7 +599,6 @@ static int read_balance(struct r1conf *conf, struc=
t r1bio *r1_bio, int *max_sect
> >>          int sectors;
> >>          int best_good_sectors;
> >>          int best_disk, best_dist_disk, best_pending_disk;
> >> -       int has_nonrot_disk;
> >>          int disk;
> >>          sector_t best_dist;
> >>          unsigned int min_pending;
> >> @@ -620,7 +619,6 @@ static int read_balance(struct r1conf *conf, struc=
t r1bio *r1_bio, int *max_sect
> >>          best_pending_disk =3D -1;
> >>          min_pending =3D UINT_MAX;
> >>          best_good_sectors =3D 0;
> >> -       has_nonrot_disk =3D 0;
> >>          choose_next_idle =3D 0;
> >>          clear_bit(R1BIO_FailFast, &r1_bio->state);
> >>
> >> @@ -637,7 +635,6 @@ static int read_balance(struct r1conf *conf, struc=
t r1bio *r1_bio, int *max_sect
> >>                  sector_t first_bad;
> >>                  int bad_sectors;
> >>                  unsigned int pending;
> >> -               bool nonrot;
> >>
> >>                  rdev =3D conf->mirrors[disk].rdev;
> >>                  if (r1_bio->bios[disk] =3D=3D IO_BLOCKED
> >> @@ -703,8 +700,6 @@ static int read_balance(struct r1conf *conf, struc=
t r1bio *r1_bio, int *max_sect
> >>                          /* At least two disks to choose from so failf=
ast is OK */
> >>                          set_bit(R1BIO_FailFast, &r1_bio->state);
> >>
> >> -               nonrot =3D bdev_nonrot(rdev->bdev);
> >> -               has_nonrot_disk |=3D nonrot;
> >>                  pending =3D atomic_read(&rdev->nr_pending);
> >>                  dist =3D abs(this_sector - conf->mirrors[disk].head_p=
osition);
> >>                  if (choose_first) {
> >> @@ -731,7 +726,7 @@ static int read_balance(struct r1conf *conf, struc=
t r1bio *r1_bio, int *max_sect
> >>                           * small, but not a big deal since when the s=
econd disk
> >>                           * starts IO, the first disk is likely still =
busy.
> >>                           */
> >> -                       if (nonrot && opt_iosize > 0 &&
> >> +                       if (test_bit(Nonrot, &rdev->flags) && opt_iosi=
ze > 0 &&
> >>                              mirror->seq_start !=3D MaxSector &&
> >>                              mirror->next_seq_sect > opt_iosize &&
> >>                              mirror->next_seq_sect - opt_iosize >=3D
> >> @@ -763,7 +758,7 @@ static int read_balance(struct r1conf *conf, struc=
t r1bio *r1_bio, int *max_sect
> >>           * mixed ratation/non-rotational disks depending on workload.
> >>           */
> >>          if (best_disk =3D=3D -1) {
> >> -               if (has_nonrot_disk || min_pending =3D=3D 0)
> >> +               if (conf->mddev->nonrot_disks || min_pending =3D=3D 0)
> >>                          best_disk =3D best_pending_disk;
> >>                  else
> >>                          best_disk =3D best_dist_disk;
> >> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> >> index d5a7a621f0f0..1f6693e40e12 100644
> >> --- a/drivers/md/raid10.c
> >> +++ b/drivers/md/raid10.c
> >> @@ -735,7 +735,6 @@ static struct md_rdev *read_balance(struct r10conf=
 *conf,
> >>          struct md_rdev *best_dist_rdev, *best_pending_rdev, *rdev =3D=
 NULL;
> >>          int do_balance;
> >>          int best_dist_slot, best_pending_slot;
> >> -       bool has_nonrot_disk =3D false;
> >>          unsigned int min_pending;
> >>          struct geom *geo =3D &conf->geo;
> >>
> >> @@ -766,7 +765,6 @@ static struct md_rdev *read_balance(struct r10conf=
 *conf,
> >>                  int bad_sectors;
> >>                  sector_t dev_sector;
> >>                  unsigned int pending;
> >> -               bool nonrot;
> >>
> >>                  if (r10_bio->devs[slot].bio =3D=3D IO_BLOCKED)
> >>                          continue;
> >> @@ -818,10 +816,8 @@ static struct md_rdev *read_balance(struct r10con=
f *conf,
> >>                  if (!do_balance)
> >>                          break;
> >>
> >> -               nonrot =3D bdev_nonrot(rdev->bdev);
> >> -               has_nonrot_disk |=3D nonrot;
> >>                  pending =3D atomic_read(&rdev->nr_pending);
> >> -               if (min_pending > pending && nonrot) {
> >> +               if (min_pending > pending && test_bit(Nonrot, &rdev->f=
lags)) {
> >>                          min_pending =3D pending;
> >>                          best_pending_slot =3D slot;
> >>                          best_pending_rdev =3D rdev;
> >> @@ -851,7 +847,7 @@ static struct md_rdev *read_balance(struct r10conf=
 *conf,
> >>                  }
> >>          }
> >>          if (slot >=3D conf->copies) {
> >> -               if (has_nonrot_disk) {
> >> +               if (conf->mddev->nonrot_disks) {
> >>                          slot =3D best_pending_slot;
> >>                          rdev =3D best_pending_rdev;
> >>                  } else {
> >> --
> >> 2.39.2
> >>
> >>
> >
> > .
> >
>



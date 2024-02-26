Return-Path: <linux-kernel+bounces-81456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1488786762C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBB5428DB7C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E4885932;
	Mon, 26 Feb 2024 13:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C2cl7PDe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5353823A7
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 13:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708953162; cv=none; b=LHEKove9eQRz1iDRDas6qbYom9GKAtdHa4X3ZIqAt1jfwTMM3G3WdZS58wZD44JN50H3WdU/2DuSG7hufp9wkWzUCw3JSLcLFnLLGqAMA2Xq2KPXXXeeGrEy+MTbuP2B/RXBZOlff4r4vZJRQrn4fzCe8vNPOPs7vrLpBOgll1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708953162; c=relaxed/simple;
	bh=fsYH7yRiIwmSl4bFrhwGnk1xJB9YZ0wCYn7Brh+RFDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GS2drl256G5e5DSuCEtVw3OxNsw3SYJVpd+a/WTbK0NDpwI2agmKKRUyihZPQwgxU1wEux7ejxlex+5C18TiP02SwntW6heT7Hgf2y5XvajYQnnNkjkHKbQ+KYTVxTguqDl3ctSp9Y4h3FNXWBPWZRCnV538nnzWrtzrXm2q6LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C2cl7PDe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708953159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mi/rICR6v2l0zIyW2o4OFVxffuCJyl6C1qrC1bwsIXc=;
	b=C2cl7PDeC+pxgGmS9g6shLAOjxw1jYhEAOt0Gipyi3GUgZkGO2oUkW7hZwHxHLWR9kPkSP
	IWDSlUh4nHB/rciJ2m1MF2LviOXXmb90bbb1ENokUNlKYmx6sgEjEijbKiukXr+nPLAAvN
	vcRL1hzbotAKjbVu6iLHHDvxzkUEfw4=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-6jS2oN-1M4CdbjuvKULc1g-1; Mon, 26 Feb 2024 08:12:37 -0500
X-MC-Unique: 6jS2oN-1M4CdbjuvKULc1g-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5dc992f8c8aso2979648a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 05:12:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708953156; x=1709557956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mi/rICR6v2l0zIyW2o4OFVxffuCJyl6C1qrC1bwsIXc=;
        b=BCkcGNuYHgJ17yWWIqOYGdL8z71sCJddN1YmZsG70/OBCMLI02VjVNCKwXlI8KML/M
         T1bEPFdqrS4m3zkrLEucZa1NLOp4VmQxZpVxmkkPI43uz/HecJyc4jt0oJgSA7bwy8oZ
         EWuepVT1zNo2W3H4Nt5koP821VvqX21jbUY+Pj3eisA4u6yQi5KyQvNGWiOiwuKO0mSF
         g/EKkCQew2Vv8jC6Ivrxu/798GAgpT6h+lqD+FAEduDest3smRFVh6DLpHegaJJEpyr1
         thr7FYjHOJrJU8PwJRv0ClK1l4guopHl4TfydizDDJX3WLM1CaV2pfP5Pi4ipP6eTNGY
         LF3A==
X-Forwarded-Encrypted: i=1; AJvYcCW9QfJThquQAoMvTXuxmToCkT27NLAjHDWeXJ2cG0YY5KJqxyAEjMh7GqnAK0g9ysffpl9HAYWMy7wurka6PkcQ6mQncSwAuP9Pbre1
X-Gm-Message-State: AOJu0YyO7JqQgCMnn1kj7gKc486d48/zOi7pzYqnFEwYgtOZBrFXylKW
	FCrz33EV863raiShGZQ7jva+KeV6EH2nMxWF6Ym0RqQPe2x/4ArRGfwDmavRIci4ylzIQNQchEl
	vBso8xpwPWzI2qrxvoTboP7SGk+lK1wlijswbazTgqX47boLM6CpxOelwV6ELbHeNSbrGIJU0vT
	Rpy45p+mxZZPka7nVoh8GwBvg7DNB0yDZyCj2h
X-Received: by 2002:a05:6a20:9f48:b0:1a0:e1c4:d403 with SMTP id ml8-20020a056a209f4800b001a0e1c4d403mr6989446pzb.35.1708953155989;
        Mon, 26 Feb 2024 05:12:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHB6l/NoP0QKK6y6n0tZavYyyJeaCC267d6fAujqjYWmC70L+jorXEHxoHzuF5ThnsLx+pfxX6WmAhrHPttvBI=
X-Received: by 2002:a05:6a20:9f48:b0:1a0:e1c4:d403 with SMTP id
 ml8-20020a056a209f4800b001a0e1c4d403mr6989424pzb.35.1708953155640; Mon, 26
 Feb 2024 05:12:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222075806.1816400-1-yukuai1@huaweicloud.com> <20240222075806.1816400-3-yukuai1@huaweicloud.com>
In-Reply-To: <20240222075806.1816400-3-yukuai1@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
Date: Mon, 26 Feb 2024 21:12:24 +0800
Message-ID: <CALTww28nOniYZDV9Kpaymze=Ph+EKSwrr+2QMo2WQsR3hKvD_A@mail.gmail.com>
Subject: Re: [PATCH md-6.9 02/10] md: record nonrot rdevs while
 adding/removing rdevs to conf
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: paul.e.luse@linux.intel.com, song@kernel.org, neilb@suse.com, shli@fb.com, 
	linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, yukuai3@huawei.com, 
	yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kuai

I added some logs to check and add_bound_rdev can't be called when
creating raid device. Maybe move rdev_update_nonrot to
bind_rdev_to_array?

Regards
Xiao

On Thu, Feb 22, 2024 at 4:04=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> For raid1/raid10, each read will iterate all the rdevs from conf and
> check if any rdev is non-rotational, then choose rdev with minimal IO
> inflight if so, or rdev with closest distance otherwise.
>
> Disk nonrot info can be changed through sysfs entry:
>
> /sys/block/[disk_name]/queue/rotational
>
> However, consider that this should only be used for testing, and user
> really shouldn't do this in real life. Record the number of non-rotationa=
l
> disks in mddev, to avoid checking each rdev in IO fast path and simplify
> read_balance() a little bit.
>
> Co-developed-by: Paul Luse <paul.e.luse@linux.intel.com>
> Signed-off-by: Paul Luse <paul.e.luse@linux.intel.com>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/md.c     | 28 ++++++++++++++++++++++++++--
>  drivers/md/md.h     |  2 ++
>  drivers/md/raid1.c  |  9 ++-------
>  drivers/md/raid10.c |  8 ++------
>  4 files changed, 32 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index e2a5f513dbb7..9e671eec9309 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -146,6 +146,24 @@ static inline int speed_max(struct mddev *mddev)
>                 mddev->sync_speed_max : sysctl_speed_limit_max;
>  }
>
> +static void rdev_update_nonrot(struct md_rdev *rdev)
> +{
> +       if (!bdev_nonrot(rdev->bdev))
> +               return;
> +
> +       set_bit(Nonrot, &rdev->flags);
> +       WRITE_ONCE(rdev->mddev->nonrot_disks, rdev->mddev->nonrot_disks +=
 1);
> +}
> +
> +static void rdev_clear_nonrot(struct md_rdev *rdev)
> +{
> +       if (!test_bit(Nonrot, &rdev->flags))
> +               return;
> +
> +       clear_bit(Nonrot, &rdev->flags);
> +       WRITE_ONCE(rdev->mddev->nonrot_disks, rdev->mddev->nonrot_disks -=
 1);
> +}
> +
>  static void rdev_uninit_serial(struct md_rdev *rdev)
>  {
>         if (!test_and_clear_bit(CollisionCheck, &rdev->flags))
> @@ -2922,6 +2940,8 @@ static int add_bound_rdev(struct md_rdev *rdev)
>                         md_kick_rdev_from_array(rdev);
>                         return err;
>                 }
> +
> +               rdev_update_nonrot(rdev);
>         }
>         sysfs_notify_dirent_safe(rdev->sysfs_state);
>
> @@ -3271,8 +3291,10 @@ slot_store(struct md_rdev *rdev, const char *buf, =
size_t len)
>                 if (err) {
>                         rdev->raid_disk =3D -1;
>                         return err;
> -               } else
> -                       sysfs_notify_dirent_safe(rdev->sysfs_state);
> +               }
> +
> +               rdev_update_nonrot(rdev);
> +               sysfs_notify_dirent_safe(rdev->sysfs_state);
>                 /* failure here is OK */;
>                 sysfs_link_rdev(rdev->mddev, rdev);
>                 /* don't wakeup anyone, leave that to userspace. */
> @@ -9266,6 +9288,7 @@ static int remove_and_add_spares(struct mddev *mdde=
v,
>         rdev_for_each(rdev, mddev) {
>                 if ((this =3D=3D NULL || rdev =3D=3D this) && rdev_remove=
able(rdev) &&
>                     !mddev->pers->hot_remove_disk(mddev, rdev)) {
> +                       rdev_clear_nonrot(rdev);
>                         sysfs_unlink_rdev(mddev, rdev);
>                         rdev->saved_raid_disk =3D rdev->raid_disk;
>                         rdev->raid_disk =3D -1;
> @@ -9289,6 +9312,7 @@ static int remove_and_add_spares(struct mddev *mdde=
v,
>                 if (!test_bit(Journal, &rdev->flags))
>                         rdev->recovery_offset =3D 0;
>                 if (mddev->pers->hot_add_disk(mddev, rdev) =3D=3D 0) {
> +                       rdev_update_nonrot(rdev);
>                         /* failure here is OK */
>                         sysfs_link_rdev(mddev, rdev);
>                         if (!test_bit(Journal, &rdev->flags))
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index a49ab04ab707..54aa951f2bba 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -207,6 +207,7 @@ enum flag_bits {
>                                  * check if there is collision between ra=
id1
>                                  * serial bios.
>                                  */
> +       Nonrot,                 /* non-rotational device (SSD) */
>  };
>
>  static inline int is_badblock(struct md_rdev *rdev, sector_t s, int sect=
ors,
> @@ -312,6 +313,7 @@ struct mddev {
>         unsigned long                   flags;
>         unsigned long                   sb_flags;
>
> +       int                             nonrot_disks;
>         int                             suspended;
>         struct mutex                    suspend_mutex;
>         struct percpu_ref               active_io;
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index a145fe48b9ce..c60ea58ae8c5 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -599,7 +599,6 @@ static int read_balance(struct r1conf *conf, struct r=
1bio *r1_bio, int *max_sect
>         int sectors;
>         int best_good_sectors;
>         int best_disk, best_dist_disk, best_pending_disk;
> -       int has_nonrot_disk;
>         int disk;
>         sector_t best_dist;
>         unsigned int min_pending;
> @@ -620,7 +619,6 @@ static int read_balance(struct r1conf *conf, struct r=
1bio *r1_bio, int *max_sect
>         best_pending_disk =3D -1;
>         min_pending =3D UINT_MAX;
>         best_good_sectors =3D 0;
> -       has_nonrot_disk =3D 0;
>         choose_next_idle =3D 0;
>         clear_bit(R1BIO_FailFast, &r1_bio->state);
>
> @@ -637,7 +635,6 @@ static int read_balance(struct r1conf *conf, struct r=
1bio *r1_bio, int *max_sect
>                 sector_t first_bad;
>                 int bad_sectors;
>                 unsigned int pending;
> -               bool nonrot;
>
>                 rdev =3D conf->mirrors[disk].rdev;
>                 if (r1_bio->bios[disk] =3D=3D IO_BLOCKED
> @@ -703,8 +700,6 @@ static int read_balance(struct r1conf *conf, struct r=
1bio *r1_bio, int *max_sect
>                         /* At least two disks to choose from so failfast =
is OK */
>                         set_bit(R1BIO_FailFast, &r1_bio->state);
>
> -               nonrot =3D bdev_nonrot(rdev->bdev);
> -               has_nonrot_disk |=3D nonrot;
>                 pending =3D atomic_read(&rdev->nr_pending);
>                 dist =3D abs(this_sector - conf->mirrors[disk].head_posit=
ion);
>                 if (choose_first) {
> @@ -731,7 +726,7 @@ static int read_balance(struct r1conf *conf, struct r=
1bio *r1_bio, int *max_sect
>                          * small, but not a big deal since when the secon=
d disk
>                          * starts IO, the first disk is likely still busy=
.
>                          */
> -                       if (nonrot && opt_iosize > 0 &&
> +                       if (test_bit(Nonrot, &rdev->flags) && opt_iosize =
> 0 &&
>                             mirror->seq_start !=3D MaxSector &&
>                             mirror->next_seq_sect > opt_iosize &&
>                             mirror->next_seq_sect - opt_iosize >=3D
> @@ -763,7 +758,7 @@ static int read_balance(struct r1conf *conf, struct r=
1bio *r1_bio, int *max_sect
>          * mixed ratation/non-rotational disks depending on workload.
>          */
>         if (best_disk =3D=3D -1) {
> -               if (has_nonrot_disk || min_pending =3D=3D 0)
> +               if (conf->mddev->nonrot_disks || min_pending =3D=3D 0)
>                         best_disk =3D best_pending_disk;
>                 else
>                         best_disk =3D best_dist_disk;
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index d5a7a621f0f0..1f6693e40e12 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -735,7 +735,6 @@ static struct md_rdev *read_balance(struct r10conf *c=
onf,
>         struct md_rdev *best_dist_rdev, *best_pending_rdev, *rdev =3D NUL=
L;
>         int do_balance;
>         int best_dist_slot, best_pending_slot;
> -       bool has_nonrot_disk =3D false;
>         unsigned int min_pending;
>         struct geom *geo =3D &conf->geo;
>
> @@ -766,7 +765,6 @@ static struct md_rdev *read_balance(struct r10conf *c=
onf,
>                 int bad_sectors;
>                 sector_t dev_sector;
>                 unsigned int pending;
> -               bool nonrot;
>
>                 if (r10_bio->devs[slot].bio =3D=3D IO_BLOCKED)
>                         continue;
> @@ -818,10 +816,8 @@ static struct md_rdev *read_balance(struct r10conf *=
conf,
>                 if (!do_balance)
>                         break;
>
> -               nonrot =3D bdev_nonrot(rdev->bdev);
> -               has_nonrot_disk |=3D nonrot;
>                 pending =3D atomic_read(&rdev->nr_pending);
> -               if (min_pending > pending && nonrot) {
> +               if (min_pending > pending && test_bit(Nonrot, &rdev->flag=
s)) {
>                         min_pending =3D pending;
>                         best_pending_slot =3D slot;
>                         best_pending_rdev =3D rdev;
> @@ -851,7 +847,7 @@ static struct md_rdev *read_balance(struct r10conf *c=
onf,
>                 }
>         }
>         if (slot >=3D conf->copies) {
> -               if (has_nonrot_disk) {
> +               if (conf->mddev->nonrot_disks) {
>                         slot =3D best_pending_slot;
>                         rdev =3D best_pending_rdev;
>                 } else {
> --
> 2.39.2
>
>



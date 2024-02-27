Return-Path: <linux-kernel+bounces-82708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EBF868864
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 05:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 975E51C229CD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A84152F77;
	Tue, 27 Feb 2024 04:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZMNnHdR5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D7052F6E
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 04:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709009289; cv=none; b=WCsTYMhKn8kzLsXGJGWmPbujt8PhgdoP3ZrhRQlQ4u/lBBSIDRf8Zssxvvc1md1IM5a70Xs3s8NxMOKV40L7hmWjbQowUhYYZAAj9/LpcIYB8fZEZm1rMv7vnpUOKPtAR/67uJ4dFL+I1NbCJCc+TqL00a/xVUlwHeakMHnkZYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709009289; c=relaxed/simple;
	bh=rmaBheVRT7dVz2Ci+SvEzncm3P0Sopk72jLZm6tuZs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PUIyARKGJ6T0WFdrOk1rTx2xud8Cuo1mP84zhR82nJ4Lwml7e5QaoOul7y7n7iCGlUUFfePLkydnhQ/PUJSc6RHo1QDu3LIpNc54wiweaADcf3jp7p0Jb4Ya6j/rkrgn5l23H4Q5666tZD6I83TMbsEYYxZmkjBw26oQNExi/mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZMNnHdR5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709009284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IByj/tHZrS4f8RNKhNTMyLYgiYZedr3yfTZYhDqnqAI=;
	b=ZMNnHdR5cJeirGVXR5I3f+rgk60oIUHXlM85ygz2UVHPSqx3HY/2jFqJC0OQCLYm3BG7o9
	DlmF+DfJQK+bBjRo/mop3mKK5VvC6n351JdVeFU/bADfEu42u7N/daO4jO64MLptKq2HhY
	jXJ0EHGiGKU1ewKgG0fhpvSfbtTn1AQ=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-2B3s_676OSCKcN1mYojNuA-1; Mon, 26 Feb 2024 23:48:02 -0500
X-MC-Unique: 2B3s_676OSCKcN1mYojNuA-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1d4a87da75dso42527745ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 20:48:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709009282; x=1709614082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IByj/tHZrS4f8RNKhNTMyLYgiYZedr3yfTZYhDqnqAI=;
        b=ZAZ2FcAQRQKRv6SHU5HXcGk4eoX9XGJ8qNUmdjhRipuaelJfjQtIbQ5LXiXi+yb8g2
         g/H9nblegSd2Eq3E0xoV/XUfSvutgWZX1eozg9I4F7aF5hDs+/3mfa0eb6q8rkuAJ6jO
         YlX7iPfTO/BIvnz9SolYHtlf7k2MMRGTSmmeonLfA36RZh4Y3+2KRUVmkQsNFkMojrmz
         XW6xgJjhzguIi9ZZXNL7y9DxVGym88cUrrauJI/xlXRW6q59gNr46Qfu4veGwdSAuzrw
         C+ChwpPMNb6Cf69JQM1glXZWyNSBcVfOahBvvqtu6yUmJW47Av/1lSUt4o/RmKK/BxrC
         HIBw==
X-Forwarded-Encrypted: i=1; AJvYcCXMDmWSV5Zf3Lw06hzbTDYBinbS783zMrlmpyvMrXVulQ7SSJEvopuKNanBb5+KmqwyOks2IuJVKNbXh2Snr79HY5O19gdplBmIpbdx
X-Gm-Message-State: AOJu0Yx07aCNAxL75j0SA7BX8DcGOlnYVUuWveZpFOINWgLG4gpoN6C5
	zpfc3Fp/PPUuer3s/d73kROWpN7p3q3kf0HAcCw/fq1rYqJX0yK3fMlLZWszHgl4rayufEoCU8A
	wsCQW3m38sXSo1DBaA/f7nRsj4Mycg3X60c6kb963InrqSqWbxnCGkePqsgyCp+GpXGUMSTg9Qz
	T/cCssdNVfxFjRWaDLOEqYO2Xvk5HVrh241j4D
X-Received: by 2002:a17:903:187:b0:1db:e494:4b5d with SMTP id z7-20020a170903018700b001dbe4944b5dmr10739071plg.16.1709009281798;
        Mon, 26 Feb 2024 20:48:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFVd5S/1hiFH9Pqg3D7OmbK5D8d9fC1S119oCZD76FbvAgyt7mH00lc1rkQ5oz7NBgiREODpExfA45b/xdMP4=
X-Received: by 2002:a17:903:187:b0:1db:e494:4b5d with SMTP id
 z7-20020a170903018700b001dbe4944b5dmr10739062plg.16.1709009281470; Mon, 26
 Feb 2024 20:48:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222075806.1816400-1-yukuai1@huaweicloud.com> <20240222075806.1816400-11-yukuai1@huaweicloud.com>
In-Reply-To: <20240222075806.1816400-11-yukuai1@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
Date: Tue, 27 Feb 2024 12:47:50 +0800
Message-ID: <CALTww28=sZNJESGX5fjuW5TaM0rSO6PoR_GgJZY3e+yF3KWobA@mail.gmail.com>
Subject: Re: [PATCH md-6.9 10/10] md/raid1: factor out helpers to choose the
 best rdev from read_balance()
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: paul.e.luse@linux.intel.com, song@kernel.org, neilb@suse.com, shli@fb.com, 
	linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, yukuai3@huawei.com, 
	yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 4:06=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> The way that best rdev is chosen:
>
> 1) If the read is sequential from one rdev:
>  - if rdev is rotational, use this rdev;
>  - if rdev is non-rotational, use this rdev until total read length
>    exceed disk opt io size;
>
> 2) If the read is not sequential:
>  - if there is idle disk, use it, otherwise:
>  - if the array has non-rotational disk, choose the rdev with minimal
>    inflight IO;
>  - if all the underlaying disks are rotational disk, choose the rdev
>    with closest IO;
>
> There are no functional changes, just to make code cleaner and prepare
> for following refactor.
>
> Co-developed-by: Paul Luse <paul.e.luse@linux.intel.com>
> Signed-off-by: Paul Luse <paul.e.luse@linux.intel.com>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/raid1.c | 171 ++++++++++++++++++++++++---------------------
>  1 file changed, 92 insertions(+), 79 deletions(-)
>
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index 223ef8d06f67..938b0e0170df 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -730,73 +730,68 @@ static bool should_choose_next(struct r1conf *conf,=
 int disk)
>                mirror->next_seq_sect - opt_iosize >=3D mirror->seq_start;
>  }
>
> -/*
> - * This routine returns the disk from which the requested read should
> - * be done. There is a per-array 'next expected sequential IO' sector
> - * number - if this matches on the next IO then we use the last disk.
> - * There is also a per-disk 'last know head position' sector that is
> - * maintained from IRQ contexts, both the normal and the resync IO
> - * completion handlers update this position correctly. If there is no
> - * perfect sequential match then we pick the disk whose head is closest.
> - *
> - * If there are 2 mirrors in the same 2 devices, performance degrades
> - * because position is mirror, not device based.
> - *
> - * The rdev for the device selected will have nr_pending incremented.
> - */
> -static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *=
max_sectors)
> +static bool rdev_readable(struct md_rdev *rdev, struct r1bio *r1_bio)
>  {
> -       const sector_t this_sector =3D r1_bio->sector;
> -       int sectors;
> -       int best_good_sectors;
> -       int best_disk, best_dist_disk, best_pending_disk;
> -       int disk;
> -       sector_t best_dist;
> -       unsigned int min_pending;
> -       struct md_rdev *rdev;
> +       if (!rdev || test_bit(Faulty, &rdev->flags))
> +               return false;
>
> - retry:
> -       sectors =3D r1_bio->sectors;
> -       best_disk =3D -1;
> -       best_dist_disk =3D -1;
> -       best_dist =3D MaxSector;
> -       best_pending_disk =3D -1;
> -       min_pending =3D UINT_MAX;
> -       best_good_sectors =3D 0;
> -       clear_bit(R1BIO_FailFast, &r1_bio->state);
> +       /* still in recovery */
> +       if (!test_bit(In_sync, &rdev->flags) &&
> +           rdev->recovery_offset < r1_bio->sector + r1_bio->sectors)
> +               return false;
>
> -       if (raid1_should_read_first(conf->mddev, this_sector, sectors))
> -               return choose_first_rdev(conf, r1_bio, max_sectors);
> +       /* don't read from slow disk unless have to */
> +       if (test_bit(WriteMostly, &rdev->flags))
> +               return false;
> +
> +       /* don't split IO for bad blocks unless have to */
> +       if (rdev_has_badblock(rdev, r1_bio->sector, r1_bio->sectors))
> +               return false;
> +
> +       return true;
> +}
> +
> +struct read_balance_ctl {
> +       sector_t closest_dist;
> +       int closest_dist_disk;
> +       int min_pending;
> +       int min_pending_disk;
> +       int readable_disks;
> +};
> +
> +static int choose_best_rdev(struct r1conf *conf, struct r1bio *r1_bio)
> +{
> +       int disk;
> +       struct read_balance_ctl ctl =3D {
> +               .closest_dist_disk      =3D -1,
> +               .closest_dist           =3D MaxSector,
> +               .min_pending_disk       =3D -1,
> +               .min_pending            =3D UINT_MAX,
> +       };
>
>         for (disk =3D 0 ; disk < conf->raid_disks * 2 ; disk++) {
> +               struct md_rdev *rdev;
>                 sector_t dist;
>                 unsigned int pending;
>
> -               rdev =3D conf->mirrors[disk].rdev;
> -               if (r1_bio->bios[disk] =3D=3D IO_BLOCKED
> -                   || rdev =3D=3D NULL
> -                   || test_bit(Faulty, &rdev->flags))
> -                       continue;
> -               if (!test_bit(In_sync, &rdev->flags) &&
> -                   rdev->recovery_offset < this_sector + sectors)
> -                       continue;
> -               if (test_bit(WriteMostly, &rdev->flags))
> +               if (r1_bio->bios[disk] =3D=3D IO_BLOCKED)
>                         continue;
> -               if (rdev_has_badblock(rdev, this_sector, sectors))
> +
> +               rdev =3D conf->mirrors[disk].rdev;
> +               if (!rdev_readable(rdev, r1_bio))
>                         continue;
>
> -               if (best_disk >=3D 0)
> -                       /* At least two disks to choose from so failfast =
is OK */
> +               /* At least two disks to choose from so failfast is OK */
> +               if (ctl.readable_disks++ =3D=3D 1)
>                         set_bit(R1BIO_FailFast, &r1_bio->state);
>
>                 pending =3D atomic_read(&rdev->nr_pending);
> -               dist =3D abs(this_sector - conf->mirrors[disk].head_posit=
ion);
> +               dist =3D abs(r1_bio->sector - conf->mirrors[disk].head_po=
sition);
> +
>                 /* Don't change to another disk for sequential reads */
>                 if (is_sequential(conf, disk, r1_bio)) {
> -                       if (!should_choose_next(conf, disk)) {
> -                               best_disk =3D disk;
> -                               break;
> -                       }
> +                       if (!should_choose_next(conf, disk))
> +                               return disk;
>
>                         /*
>                          * Add 'pending' to avoid choosing this disk if t=
here is
> @@ -810,42 +805,60 @@ static int read_balance(struct r1conf *conf, struct=
 r1bio *r1_bio, int *max_sect
>                         dist =3D 0;
>                 }
>
> -               if (min_pending > pending) {
> -                       min_pending =3D pending;
> -                       best_pending_disk =3D disk;
> +               if (ctl.min_pending > pending) {
> +                       ctl.min_pending =3D pending;
> +                       ctl.min_pending_disk =3D disk;
>                 }
>
> -               if (dist < best_dist) {
> -                       best_dist =3D dist;
> -                       best_dist_disk =3D disk;
> +               if (dist < ctl.closest_dist) {
> +                       ctl.closest_dist =3D dist;
> +                       ctl.closest_dist_disk =3D disk;
>                 }
>         }
>
> -       /*
> -        * If all disks are rotational, choose the closest disk. If any d=
isk is
> -        * non-rotational, choose the disk with less pending request even=
 the
> -        * disk is rotational, which might/might not be optimal for raids=
 with
> -        * mixed ratation/non-rotational disks depending on workload.
> -        */
> -       if (best_disk =3D=3D -1) {
> -               if (conf->mddev->nonrot_disks || min_pending =3D=3D 0)
> -                       best_disk =3D best_pending_disk;
> -               else
> -                       best_disk =3D best_dist_disk;
> -       }
>
> -       if (best_disk >=3D 0) {
> -               rdev =3D conf->mirrors[best_disk].rdev;
> -               if (!rdev)
> -                       goto retry;
> +       if (ctl.min_pending_disk !=3D -1 &&
> +           (conf->mddev->nonrot_disks || ctl.min_pending =3D=3D 0))
> +               return ctl.min_pending_disk;
> +       else
> +               return ctl.closest_dist_disk;
> +}
>
> -               sectors =3D best_good_sectors;
> -               update_read_sectors(conf, disk, this_sector, sectors);
> -       }
> -       *max_sectors =3D sectors;
> +/*
> + * This routine returns the disk from which the requested read should be=
 done.
> + *
> + * 1) If resync is in progress, find the first usable disk and use
> + * it even if it has some bad blocks.
> + *
> + * 2) Now that there is no resync, loop through all disks and skipping s=
low
> + * disks and disks with bad blocks for now. Only pay attention to key di=
sk
> + * choice.
> + *
> + * 3) If we've made it this far, now look for disks with bad blocks and =
choose
> + * the one with most number of sectors.
> + *
> + * 4) If we are all the way at the end, we have no choice but to use a d=
isk even
> + * if it is write mostly.
> +
> + * The rdev for the device selected will have nr_pending incremented.
> + */
> +static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *=
max_sectors)
> +{
> +       int disk;
> +
> +       clear_bit(R1BIO_FailFast, &r1_bio->state);
>
> -       if (best_disk >=3D 0)
> -               return best_disk;
> +       if (raid1_should_read_first(conf->mddev, r1_bio->sector,
> +                                   r1_bio->sectors))
> +               return choose_first_rdev(conf, r1_bio, max_sectors);
> +
> +       disk =3D choose_best_rdev(conf, r1_bio);
> +       if (disk >=3D 0) {
> +               *max_sectors =3D r1_bio->sectors;
> +               update_read_sectors(conf, disk, r1_bio->sector,
> +                                   r1_bio->sectors);
> +               return disk;
> +       }
>
>         /*
>          * If we are here it means we didn't find a perfectly good disk s=
o
> --
> 2.39.2
>
>

Hi
This patch looks good to me. Thanks very much for the effort. Now the
read_balance is more easy to read and understand.
Reviewed-by: Xiao Ni <xni@redhat.com>



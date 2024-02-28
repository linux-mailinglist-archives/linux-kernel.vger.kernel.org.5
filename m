Return-Path: <linux-kernel+bounces-84394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCB586A635
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 292A228C2F6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027DF1E864;
	Wed, 28 Feb 2024 01:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gd/K7kLc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292D81DDF5
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 01:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709085402; cv=none; b=ghO+n97gx8gccAoxsTQq+ifxErEZrl1JAuL2Vvgx9lRGPkIb2Qkim5cR2Za+EDUEVnW560s4ju9/e63Uw+n7/LqWFGdAYG9WsuwXEDKBbX9I3gMZSnlGwj3BgG/h+ZVon7s7w0/sGCitp0OVPIyv70sQrKnsm2mnkOu043RC+uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709085402; c=relaxed/simple;
	bh=M30Tj3t5lTZv786f+bXW/0GU7BTmjZeW6hKWvgtwyds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DnX0uiC5AfPoAKzT1CCp9b8r8w98bz6clNLE3UGTPbxnsmmjVZShGX8iAxniamf49TS5FlMs5vhoCNpLYS0ugaOLDqIwmHyg4kWL7yt97r/ZCs46pFcEB2c9BSWsXa/U8wHRuL1c/z67qM7wFi+27dS6ALaPYeO7DdJ2ky51jd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gd/K7kLc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709085398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XHsJ7e3BatoYAGnNUg/1QAkgMUz1VE3RchWUpq3AxE4=;
	b=Gd/K7kLclIQd5y1u3IkFZFpdhj7i5d0hyhHEOQAkBeUzUYqHsKKyCLtFjFqJk9DRcgOgRR
	w6bUr9rPuuEjQgW2B9ZbNVm41pEhqSdONDCy+syHsC7lNEzsCSjk20lZfTiaL/5dj45sNb
	F7KEMotji5IZlXtXCZ2okGdSk+Et9q8=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-a6aJsr1jNX6kGFxtrKWtig-1; Tue, 27 Feb 2024 20:56:36 -0500
X-MC-Unique: a6aJsr1jNX6kGFxtrKWtig-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5ce63e72bc3so4576914a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 17:56:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709085395; x=1709690195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHsJ7e3BatoYAGnNUg/1QAkgMUz1VE3RchWUpq3AxE4=;
        b=jnl1qWeytxYeAVccgNNyr39Uos3DC/AQpT4WhOCZF6B4Ipd4TmKAqRIBV28+dtGqXo
         UwgcWuVT4sg/bI5udlTFW0OkcKs4ibFrsBVm6coIbw5lBL367V3YUZjM5n9u1FwrG8s3
         3uMtovZXpZ84OnOEW0ekZWzr8A/tXCW4OVDZ+KVc6sRFfibb6kKUp2PH8f6t1Cm1bBb8
         bTnSaX06ZsNwTQAPkD41fFSKK+fFM4b94AbGWWAj7RmCpyqPjmnpqyFsozyxURcaSaqy
         2B4QiSr44lsbD3wdHXwSOUpElGszrGZprDnGNLpbHIN0a05HWgr4BM6VxRO4mjHM4PUW
         GUog==
X-Forwarded-Encrypted: i=1; AJvYcCVJU/ZOV9Mw0tv85Ohaj0QX+XV+3b6GYfD7e0a6A5d9ppcmpIA+qw2ZJcedqc/MgDHAjwDT2C7hXNxTucL0QF7WmxtPEfXwl/TwVJSF
X-Gm-Message-State: AOJu0YzgSA+BFghu+cT/VU6mjDPevk8/jUt8RuMte5tZCB8fshPhDP83
	OVJpQPBZmGfkHFL0PU9j/Y3stZ22oDfOdFNUh5V/c3z/H5WYW4mK+ZO8KjFtPKmkkfXDI+wfkej
	TK74sfTWW6NP+zZlGAu3neWLLR4ypq3Mr7796fM8MkjkN6+Hyni4kl8B5BZTXhv/wRlpqILfp6C
	zxG3Zf0NoKgNH3mGRZyv2jFiN/ZpGgpn5l+25o
X-Received: by 2002:a05:6a20:7829:b0:1a0:ee92:b6d2 with SMTP id a41-20020a056a20782900b001a0ee92b6d2mr3070409pzg.14.1709085395316;
        Tue, 27 Feb 2024 17:56:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG93uOJZ4Fv/BAmZEPHmiM+Cbhv2k8uPCwWC3HGvqCkG7nJ9jZxvmGjMwUnDZwWUZ2qSStnGq2ny3Rr38uV/x0=
X-Received: by 2002:a05:6a20:7829:b0:1a0:ee92:b6d2 with SMTP id
 a41-20020a056a20782900b001a0ee92b6d2mr3070399pzg.14.1709085395014; Tue, 27
 Feb 2024 17:56:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227120327.1432511-1-yukuai1@huaweicloud.com> <20240227120327.1432511-3-yukuai1@huaweicloud.com>
In-Reply-To: <20240227120327.1432511-3-yukuai1@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
Date: Wed, 28 Feb 2024 09:56:24 +0800
Message-ID: <CALTww29DXbnhPF241WUbaibFS_aF3jZR8HiuBuj94+hCFUCgOA@mail.gmail.com>
Subject: Re: [PATCH md-6.9 v2 02/10] md/raid1: record nonrot rdevs while
 adding/removing rdevs to conf
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: paul.e.luse@linux.intel.com, song@kernel.org, shli@fb.com, neilb@suse.com, 
	linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, yukuai3@huawei.com, 
	yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 8:09=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> For raid1, each read will iterate all the rdevs from conf and check if
> any rdev is non-rotational, then choose rdev with minimal IO inflight
> if so, or rdev with closest distance otherwise.
>
> Disk nonrot info can be changed through sysfs entry:
>
> /sys/block/[disk_name]/queue/rotational
>
> However, consider that this should only be used for testing, and user
> really shouldn't do this in real life. Record the number of non-rotationa=
l
> disks in conf, to avoid checking each rdev in IO fast path and simplify
> read_balance() a little bit.
>
> Co-developed-by: Paul Luse <paul.e.luse@linux.intel.com>
> Signed-off-by: Paul Luse <paul.e.luse@linux.intel.com>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/md.h    |  1 +
>  drivers/md/raid1.c | 17 ++++++++++-------
>  drivers/md/raid1.h |  1 +
>  3 files changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index a49ab04ab707..b2076a165c10 100644
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
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index a145fe48b9ce..0fed01b06de9 100644
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
> +               if (READ_ONCE(conf->nonrot_disks) || min_pending =3D=3D 0=
)
>                         best_disk =3D best_pending_disk;
>                 else
>                         best_disk =3D best_dist_disk;
> @@ -1819,6 +1814,11 @@ static int raid1_add_disk(struct mddev *mddev, str=
uct md_rdev *rdev)
>                 WRITE_ONCE(p[conf->raid_disks].rdev, rdev);
>         }
>
> +       if (!err && bdev_nonrot(rdev->bdev)) {
> +               set_bit(Nonrot, &rdev->flags);
> +               WRITE_ONCE(conf->nonrot_disks, conf->nonrot_disks + 1);
> +       }
> +

Hi Kuai

I noticed raid1_run->setup_conf is used to add rdev to conf when
creating raid1. raid1_add_disk is only used for --add/--re-add after
creating array. So we need to add the same logic in setup_conf?

Regards
Xiao
>         print_conf(conf);
>         return err;
>  }
> @@ -1883,6 +1883,9 @@ static int raid1_remove_disk(struct mddev *mddev, s=
truct md_rdev *rdev)
>         }
>  abort:
>
> +       if (test_and_clear_bit(Nonrot, &rdev->flags))
> +               WRITE_ONCE(conf->nonrot_disks, conf->nonrot_disks - 1);
> +
>         print_conf(conf);
>         return err;
>  }
> diff --git a/drivers/md/raid1.h b/drivers/md/raid1.h
> index 14d4211a123a..5300cbaa58a4 100644
> --- a/drivers/md/raid1.h
> +++ b/drivers/md/raid1.h
> @@ -71,6 +71,7 @@ struct r1conf {
>                                                  * allow for replacements=
.
>                                                  */
>         int                     raid_disks;
> +       int                     nonrot_disks;
>
>         spinlock_t              device_lock;
>
> --
> 2.39.2
>



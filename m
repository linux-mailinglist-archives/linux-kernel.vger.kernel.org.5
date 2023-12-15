Return-Path: <linux-kernel+bounces-1810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC94815464
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56FCB1F257E3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD1530138;
	Fri, 15 Dec 2023 23:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8CI79A4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FEB18EB5;
	Fri, 15 Dec 2023 23:13:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84261C433C8;
	Fri, 15 Dec 2023 23:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702681985;
	bh=lOtRbEGfqiGEbQ0Iv6/I87uvPvm4WKKzJ4UF0h0ROhM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=e8CI79A4uWpqv3e8++yIGvLbJcwEmzRAZxs2zKqSpFnvhmZ96NhmIBk5BnCJG+dmq
	 b7tyca8Q26fddtsf2+QyK4j2VJbslA2sWkv2PmAmvIy4U4MkGWABpsTCB79kV5+a65
	 VXIEOrj3gi3OdMvnE3vOP8yvveSO8m7YPKQuwj09NMzQEYuz5dUg5hOXDk3GntEu4G
	 RReYCh71L96D/qXZ2IcymwpZNShses6g4+JHHBgIF/z1shRPdhlXPvonCk4zwWeYOP
	 Idk6Y4tsAHgHB5CfHtna+vN9ExJF0EtwgKx6caFtyqck9tn33SuY2HjcltuWiD+m3p
	 l2i9gdLjWOJNQ==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cc5a0130faso3762201fa.1;
        Fri, 15 Dec 2023 15:13:05 -0800 (PST)
X-Gm-Message-State: AOJu0YzKFisrbavygv4ykhWQYCgDjUbIOAwgWpWiHqkEB17bUMlhCkoq
	VC+hxqR797AOc/GWFOx1NlFvtRLB9fiNGWHWVqo=
X-Google-Smtp-Source: AGHT+IFBJ0uAqyf0H1dPTomrQhiPhWzSDsrhPegRJjTqzVhJ3Ev4EX7icvs5iUP03R7W3AD50ffhcah6PTWEfGpZASs=
X-Received: by 2002:a2e:a5c4:0:b0:2cc:1dd2:2f66 with SMTP id
 n4-20020a2ea5c4000000b002cc1dd22f66mr7197507ljp.38.1702681983682; Fri, 15 Dec
 2023 15:13:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215013931.3329455-1-linan666@huaweicloud.com> <20231215013931.3329455-2-linan666@huaweicloud.com>
In-Reply-To: <20231215013931.3329455-2-linan666@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Fri, 15 Dec 2023 15:12:52 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6VTvXy3L9CUhTrSC3+_-_n9FDVrtdzQ7SWWkukoQg13Q@mail.gmail.com>
Message-ID: <CAPhsuW6VTvXy3L9CUhTrSC3+_-_n9FDVrtdzQ7SWWkukoQg13Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] md: Fix overflow in is_mddev_idle
To: linan666@huaweicloud.com
Cc: axboe@kernel.dk, linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com, 
	houtao1@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 5:41=E2=80=AFPM <linan666@huaweicloud.com> wrote:
>
> From: Li Nan <linan122@huawei.com>
>
> UBSAN reports this problem:
>
>   UBSAN: Undefined behaviour in drivers/md/md.c:8175:15
>   signed integer overflow:
>   -2147483291 - 2072033152 cannot be represented in type 'int'
>   Call trace:
>    dump_backtrace+0x0/0x310
>    show_stack+0x28/0x38
>    dump_stack+0xec/0x15c
>    ubsan_epilogue+0x18/0x84
>    handle_overflow+0x14c/0x19c
>    __ubsan_handle_sub_overflow+0x34/0x44
>    is_mddev_idle+0x338/0x3d8
>    md_do_sync+0x1bb8/0x1cf8
>    md_thread+0x220/0x288
>    kthread+0x1d8/0x1e0
>    ret_from_fork+0x10/0x18
>
> 'curr_events' will overflow when stat accum or 'sync_io' is greater than
> INT_MAX.
>
> Fix it by changing sync_io, last_events and curr_events to 64bit.
>
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>  drivers/md/md.h        | 4 ++--
>  include/linux/blkdev.h | 2 +-
>  drivers/md/md.c        | 7 ++++---
>  3 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index ade83af123a2..1a4f976951c1 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -50,7 +50,7 @@ struct md_rdev {
>
>         sector_t sectors;               /* Device size (in 512bytes secto=
rs) */
>         struct mddev *mddev;            /* RAID array if running */
> -       int last_events;                /* IO event timestamp */
> +       long long last_events;          /* IO event timestamp */
>
>         /*
>          * If meta_bdev is non-NULL, it means that a separate device is
> @@ -584,7 +584,7 @@ extern void mddev_unlock(struct mddev *mddev);
>
>  static inline void md_sync_acct(struct block_device *bdev, unsigned long=
 nr_sectors)
>  {
> -       atomic_add(nr_sectors, &bdev->bd_disk->sync_io);
> +       atomic64_add(nr_sectors, &bdev->bd_disk->sync_io);
>  }
>
>  static inline void md_sync_acct_bio(struct bio *bio, unsigned long nr_se=
ctors)
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 3f8a21cd9233..d28b98adf457 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -170,7 +170,7 @@ struct gendisk {
>         struct list_head slave_bdevs;
>  #endif
>         struct timer_rand_state *random;
> -       atomic_t sync_io;               /* RAID */
> +       atomic64_t sync_io;             /* RAID */
>         struct disk_events *ev;

As we are on this, I wonder whether we really need this.
AFAICT, is_mddev_idle() is the only consumer of sync_io.
We can probably do the same check in is_mddev_idle()
without sync_io.

Thanks,
Song


>
>  #ifdef CONFIG_BLK_DEV_ZONED
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index c94373d64f2c..1d71b2a9af03 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -8496,14 +8496,15 @@ static int is_mddev_idle(struct mddev *mddev, int=
 init)
>  {
>         struct md_rdev *rdev;
>         int idle;
> -       int curr_events;
> +       long long curr_events;
>
>         idle =3D 1;
>         rcu_read_lock();
>         rdev_for_each_rcu(rdev, mddev) {
>                 struct gendisk *disk =3D rdev->bdev->bd_disk;
> -               curr_events =3D (int)part_stat_read_accum(disk->part0, se=
ctors) -
> -                             atomic_read(&disk->sync_io);
> +               curr_events =3D
> +                       (long long)part_stat_read_accum(disk->part0, sect=
ors) -
> +                             atomic64_read(&disk->sync_io);
>                 /* sync IO will cause sync_io to increase before the disk=
_stats
>                  * as sync_io is counted when a request starts, and
>                  * disk_stats is counted when it completes.
> --
> 2.39.2
>
>


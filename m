Return-Path: <linux-kernel+bounces-660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A6481442B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C181D1F23480
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B218618039;
	Fri, 15 Dec 2023 09:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkQn9Anu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E600E179AF;
	Fri, 15 Dec 2023 09:08:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C5FBC433C9;
	Fri, 15 Dec 2023 09:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702631299;
	bh=etF3n/c/vZB/s/upUIIczhOuwDkgPCswl+M7l6q57aE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MkQn9AnuqAlCWTtFEINsE7Qv/Gfy9wT/VQVnCptT9cdFLud8/QPcmAp0eEIlV+6rv
	 kJQr5G7JqcqkuWRLlkHVVxb2+aZkxFhK2SUJtPCCKzcQ0N1q+n+nlorvUR8bHoDzem
	 aXjtvEdjdXBC5dKPQCPqyiW+9OK+HWLtKpaPVbN5HrKRK9uCE6tnwPfaofUkcjrZqp
	 IjNgSEa4JYwyNLWgFefWqHuvbO83UN5AN3BhiIP6UVJX5h420J1D2D82xVNqBpnigF
	 2M6ps1VyebT2Eiz9PHuFBml1Q5cIDIOv3HkC/uJj7uREeHrZNRKkFxNgrc3p2gZng3
	 WRt+fLMEFbbog==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2c9f7fe6623so4072651fa.3;
        Fri, 15 Dec 2023 01:08:19 -0800 (PST)
X-Gm-Message-State: AOJu0YwowBA0yJsYfBKe4jDMlUoG4Ex0juWqnFhtO5Yk7zRQuHO8kM+5
	ILkDc5i/nYJuPBmKTZcxRJ22VhQLSgRPmXEvlqo=
X-Google-Smtp-Source: AGHT+IFBsSAqbIrJrzlWMqq7eN5u7EP40FndTU2ytB6YRms+bsO3JCuGxCQpLtRtJ1sj/CCOTMf2swyW14BKRbl/la0=
X-Received: by 2002:a2e:a914:0:b0:2cb:2a1f:4716 with SMTP id
 j20-20020a2ea914000000b002cb2a1f4716mr5587241ljq.8.1702631297602; Fri, 15 Dec
 2023 01:08:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215013931.3329455-1-linan666@huaweicloud.com> <20231215013931.3329455-3-linan666@huaweicloud.com>
In-Reply-To: <20231215013931.3329455-3-linan666@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Fri, 15 Dec 2023 01:08:06 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7aQoh-sHqJ1de+z7rHZLbbXVimUtxae1pBbzOQxXAB_Q@mail.gmail.com>
Message-ID: <CAPhsuW7aQoh-sHqJ1de+z7rHZLbbXVimUtxae1pBbzOQxXAB_Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] md: don't account sync_io if iostats of the disk
 is disabled
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
> If iostats is disabled, disk_stats will not be updated and
> part_stat_read_accum() only returns a constant value. In this case,
> continuing to count sync_io and to check is_mddev_idle() is no longer
> meaningful.
>
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>  drivers/md/md.h | 3 ++-
>  drivers/md/md.c | 4 ++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index 1a4f976951c1..75f5c5d04e71 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -589,7 +589,8 @@ static inline void md_sync_acct(struct block_device *=
bdev, unsigned long nr_sect
>
>  static inline void md_sync_acct_bio(struct bio *bio, unsigned long nr_se=
ctors)
>  {
> -       md_sync_acct(bio->bi_bdev, nr_sectors);
> +       if (blk_queue_io_stat(bio->bi_bdev->bd_disk->queue))
> +               md_sync_acct(bio->bi_bdev, nr_sectors);

Do we need the same check for md_sync_acct()?

>  }
>
>  struct md_personality
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 1d71b2a9af03..18bbceb0ffd6 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -8502,6 +8502,10 @@ static int is_mddev_idle(struct mddev *mddev, int =
init)
>         rcu_read_lock();
>         rdev_for_each_rcu(rdev, mddev) {
>                 struct gendisk *disk =3D rdev->bdev->bd_disk;
> +
> +               if (blk_queue_io_stat(mddev->queue))
> +                       continue;

This looks weird. Do you mean

   if (!blk_queue_io_stat(disk->queue))

Note that I changed two things here: 1) add "!"; 2) check disk, not mddev.

Did I miss something?

Thanks,
Song

> +
>                 curr_events =3D
>                         (long long)part_stat_read_accum(disk->part0, sect=
ors) -
>                               atomic64_read(&disk->sync_io);
> --
> 2.39.2
>


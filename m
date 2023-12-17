Return-Path: <linux-kernel+bounces-2418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAC0815CD2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 01:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99BEB286558
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 00:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3033A35;
	Sun, 17 Dec 2023 00:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfOyjAO3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB9436E;
	Sun, 17 Dec 2023 00:28:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A96C433C7;
	Sun, 17 Dec 2023 00:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702772905;
	bh=h2sz8/dtn/sHq1qOGU4fOqWx6jU4GBXGdvx3X6TskjI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QfOyjAO3Ynvi8JGe+6JpF0MRhhbQIQv/Qo5LgeXRZl0WxMIgHUssSGsFGEI6gu+r9
	 19JkJv8KNXty2F/o1vusOVekAnH5KAFMMZlklb/C+wGZDzFDsp/pqyPcgt+V2T9flE
	 0t5yidAH+hRIEDV2bkmshyiYabfuYMG/ID0UIX6pI2FKPytv2WDSZk+xZ9VO5+XuCl
	 U4xv/cjlj+7N8jHI0KZOYJBdoFByvFzQLMDaXEbhIfNYYzXl4rg7bm7kotgj36JB9r
	 HEaHpD6/BTLmVcYAvWFc/n9wSrztmosoZZAaSlS6O6tV4DHuZPFNZNhYEQ9ocARtsn
	 IfpCPGasVbBVw==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ca1e6a94a4so21717051fa.0;
        Sat, 16 Dec 2023 16:28:25 -0800 (PST)
X-Gm-Message-State: AOJu0Yz9P0TWGZLbt2xPE6tW/9UhGTCNoMt3VGoXl4ca8+CT6Ig03A8E
	Gp3nwg7Z8XvAk+aL/mMs4VgTZwpmZ9qwZjaz9Qg=
X-Google-Smtp-Source: AGHT+IGEdZWD6qEzZOAoX3ZcDKN8EJFuv4Nn4W8FsCrhE7zJJ5BDgJwr3IKUz17DVeBG5rVGrsQWyfFF2rcVPqUqIbw=
X-Received: by 2002:a2e:b74b:0:b0:2cc:2f4e:a146 with SMTP id
 k11-20020a2eb74b000000b002cc2f4ea146mr3510864ljo.53.1702772903626; Sat, 16
 Dec 2023 16:28:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215013931.3329455-1-linan666@huaweicloud.com>
 <20231215013931.3329455-2-linan666@huaweicloud.com> <CAPhsuW6VTvXy3L9CUhTrSC3+_-_n9FDVrtdzQ7SWWkukoQg13Q@mail.gmail.com>
 <be8d9147-4f7f-2fab-da2a-bb4cde46fd12@huaweicloud.com>
In-Reply-To: <be8d9147-4f7f-2fab-da2a-bb4cde46fd12@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Sat, 16 Dec 2023 16:28:11 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6kv7FRB_1NoheiDqvmLmongiJ-ty9mYRNvFw3yecE_Ug@mail.gmail.com>
Message-ID: <CAPhsuW6kv7FRB_1NoheiDqvmLmongiJ-ty9mYRNvFw3yecE_Ug@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] md: Fix overflow in is_mddev_idle
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: linan666@huaweicloud.com, axboe@kernel.dk, linux-raid@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com, 
	"yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 6:24=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
[...]
> >>   static inline void md_sync_acct_bio(struct bio *bio, unsigned long n=
r_sectors)
> >> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> >> index 3f8a21cd9233..d28b98adf457 100644
> >> --- a/include/linux/blkdev.h
> >> +++ b/include/linux/blkdev.h
> >> @@ -170,7 +170,7 @@ struct gendisk {
> >>          struct list_head slave_bdevs;
> >>   #endif
> >>          struct timer_rand_state *random;
> >> -       atomic_t sync_io;               /* RAID */
> >> +       atomic64_t sync_io;             /* RAID */
> >>          struct disk_events *ev;
> >
> > As we are on this, I wonder whether we really need this.
> > AFAICT, is_mddev_idle() is the only consumer of sync_io.
> > We can probably do the same check in is_mddev_idle()
> > without sync_io.
>
> After reviewing some code, what I'm understand is following:
>
> I think 'sync_io' is used to distinguish 'sync io' from raid(this can
> from different raid, for example, different partition is used for
> different array) and other io(any io, even it's not from raid). And
> if there are any other IO, sync speed is limited to min, otherwise it's
> limited to max.
>
> If we want to keep this behaviour, I can't think of any other way for
> now...

Thanks for looking into this. To keep current behavior, we will need it
in gendisk.

[...]

> >> @@ -8496,14 +8496,15 @@ static int is_mddev_idle(struct mddev *mddev, =
int init)
> >>   {
> >>          struct md_rdev *rdev;
> >>          int idle;
> >> -       int curr_events;
> >> +       long long curr_events;
> >>
> >>          idle =3D 1;
> >>          rcu_read_lock();
> >>          rdev_for_each_rcu(rdev, mddev) {
> >>                  struct gendisk *disk =3D rdev->bdev->bd_disk;
> >> -               curr_events =3D (int)part_stat_read_accum(disk->part0,=
 sectors) -
> >> -                             atomic_read(&disk->sync_io);
> >> +               curr_events =3D
> >> +                       (long long)part_stat_read_accum(disk->part0, s=
ectors) -
> >> +                             atomic64_read(&disk->sync_io);
>
> By the way, I don't think this overflow is problematic, assume that
> sectors accumulate by 'A' and sync_io accumulate by 'B':
>
> (setros + A) - (sync_io + B) -(sectors - sync_io) =3D (A - B)
>
> Nomatter overflow or truncation happened of not in the abouve addition
> and subtraction, the result is correct.
>
> And even if io accounting is disabled, which means sectors and A is
> always 0, the result will always be -B that is <=3D 0, hence
> is_mddev_idle() will always return true, and sync_speed will be limited
> to max in this case.

We only use  this for idle or not check, the behavior is OK (I think).
However, this logic is error prone.

On 64-bit systems, there is a 4-byte hole behind sync_io. I think we can
just use it for atomic64_t so that we don't have to worry about overflow.

Thanks,
Song


Return-Path: <linux-kernel+bounces-82605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EC18686F3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36C65291644
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BB51D698;
	Tue, 27 Feb 2024 02:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="evKkf1lE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A35F9F0
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 02:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709000645; cv=none; b=R/1KjsfrWgt4/4Rjaz75j9EcFtnhXg1UE6aSfol9fQbV8vNr0mtQsBYz9l7Iu7nLNr4QeEWhIQ7V/cJ7FPfdpO/fv+f8uENjZN/bDB3oyExOnWFuxY6X5UNjaTnUO99aweKICvGUQ5Nuugnxu+DiVhxvY9pFQBGDuVEhCxXjMqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709000645; c=relaxed/simple;
	bh=m9TooM0cwnkc1+bq/BZQz6Huvr9O8nSycpXXvh/YqOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fjWnDgsA4S0bmH1viz54qyzzM3MgIBfLb/z1nGefY0qTu2KpZYNSL17FawveBIqe+SJ1CmBH9W4xK8h6shrwz1aOkQe2o9fOFRe88M3GsrACZWndpPIEm8clijgpAuAKa3U780ErF4t7G9lgpyAGLjM/nhnt44Mkmr7Hj1yzuRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=evKkf1lE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709000642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b5a16VMzkMT+MI17+9HmctoPRzIdjNSYPO8LyTflFu8=;
	b=evKkf1lEAQ9Jqi5mZ+d7NTNs8eOTJ4I1NnswbrtK+4o89SID3X4IfhyJNnmWSJeAQvnerf
	le8b1PiX67DqkTNUqGcMAJNHJQO94fSTHMRuQ79x0AsAekSZDAgG7UNPNwiCHhJ8r5F3Rg
	8lJeMHxvaTX1/Gf6WZ0l5kf81ksRirI=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-nDw_-EG4NS6YpW-t9QShOw-1; Mon, 26 Feb 2024 21:24:00 -0500
X-MC-Unique: nDw_-EG4NS6YpW-t9QShOw-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1dcb989a738so1201915ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 18:24:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709000639; x=1709605439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b5a16VMzkMT+MI17+9HmctoPRzIdjNSYPO8LyTflFu8=;
        b=vCABqgqxVla6KU+gnvSQsBzTN/2HTqLAN1969orZ4+Efjr/SOwdGHE64CjoSw+ju3I
         Ahd49kufaM4ZgwHKMAVXfxtExa3kpvD+QqOa0xB3dMo1e/7cHFnF+Pixq1oG2PRm6+h5
         5rCUPl6dOdaZcBQt0AdRiWwgAvd+pViMHmwi00ER/diAQQfUB+oqnvJqOHhwW0L6x0jA
         ab3sUZn7J+5wpsGKlTDJrSuy7d51SplDrHymPy1r655F+795nnRQ/iHENuCh7ruTsCAw
         rMjcdW9RjSjyNETtBlamMS4iPRqLQmDyLCzpaeNP4MGWNA7pRCbQQq5dbhwCbNjpeoQW
         Oj3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWtyW9Ag6wJ/ca70fW6vKCf27MX/QmlYttN8duml1doVe0LD6uyOCISn1upea5BdmqAoZ76VhRjjntHc8oTVb8rL1cJEB7Dp1/1XUE3
X-Gm-Message-State: AOJu0YyWCK0tJDTBWAWDu1damJA1sq1XV7hVysljUtEMD/Dno2AfjmsZ
	iPedfqkGjy2oxwuFqBBlcWraoaNJdsmX7H45w3WbonUX2LUpD++XeHpU3psyodTIkt4uvbII68b
	wk/Ovar6v0gtqwG6pnhhyRHM5U2lOYRIHnMozOnKk+rZ7fl1oIjyKWxo3UnLbiOxHa2Cp+qKS7v
	MSZoI55k0uZT89IwomGLrjU3D2g2kx/P6V0OF63Opt073HtaC8zA==
X-Received: by 2002:a17:902:e80b:b0:1db:cf57:7bb5 with SMTP id u11-20020a170902e80b00b001dbcf577bb5mr11039003plg.8.1709000639591;
        Mon, 26 Feb 2024 18:23:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2vR9IwZQtWVoU6U3/SjKZ8ZS/OalZUG08cBdNDdLWZI/Ab/k/lnPrNwQq62u5FRx2fTQoVN7MKOs91473uyI=
X-Received: by 2002:a17:902:e80b:b0:1db:cf57:7bb5 with SMTP id
 u11-20020a170902e80b00b001dbcf577bb5mr11038983plg.8.1709000639281; Mon, 26
 Feb 2024 18:23:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222075806.1816400-1-yukuai1@huaweicloud.com> <20240222075806.1816400-4-yukuai1@huaweicloud.com>
In-Reply-To: <20240222075806.1816400-4-yukuai1@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
Date: Tue, 27 Feb 2024 10:23:47 +0800
Message-ID: <CALTww28PJPdqRkSEarwATG5GmkuMmEtT0La5s-9c9r5UPy4siA@mail.gmail.com>
Subject: Re: [PATCH md-6.9 03/10] md/raid1: fix choose next idle in read_balance()
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: paul.e.luse@linux.intel.com, song@kernel.org, neilb@suse.com, shli@fb.com, 
	linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, yukuai3@huawei.com, 
	yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 4:04=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Commit 12cee5a8a29e ("md/raid1: prevent merging too large request") add
> the case choose next idle in read_balance():
>
> read_balance:
>  for_each_rdev
>   if(next_seq_sect =3D=3D this_sector || disk =3D=3D 0)
>   -> sequential reads
>    best_disk =3D disk;
>    if (...)
>     choose_next_idle =3D 1
>     continue;
>
>  for_each_rdev
>  -> iterate next rdev
>   if (pending =3D=3D 0)
>    best_disk =3D disk;
>    -> choose the next idle disk
>    break;
>
>   if (choose_next_idle)
>    -> keep using this rdev if there are no other idle disk
>    contine
>
> However, commit 2e52d449bcec ("md/raid1: add failfast handling for reads.=
")
> remove the code:
>
> -               /* If device is idle, use it */
> -               if (pending =3D=3D 0) {
> -                       best_disk =3D disk;
> -                       break;
> -               }
>
> Hence choose next idle will never work now, fix this problem by
> following:
>
> 1) don't set best_disk in this case, read_balance() will choose the best
>    disk after iterating all the disks;
> 2) add 'pending' so that other idle disk will be chosen;
> 3) set 'dist' to 0 so that if there is no other idle disk, and all disks
>    are rotational, this disk will still be chosen;
>
> Fixes: 2e52d449bcec ("md/raid1: add failfast handling for reads.")
> Co-developed-by: Paul Luse <paul.e.luse@linux.intel.com>
> Signed-off-by: Paul Luse <paul.e.luse@linux.intel.com>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/raid1.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index c60ea58ae8c5..d0bc67e6d068 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -604,7 +604,6 @@ static int read_balance(struct r1conf *conf, struct r=
1bio *r1_bio, int *max_sect
>         unsigned int min_pending;
>         struct md_rdev *rdev;
>         int choose_first;
> -       int choose_next_idle;
>
>         /*
>          * Check if we can balance. We can balance on the whole
> @@ -619,7 +618,6 @@ static int read_balance(struct r1conf *conf, struct r=
1bio *r1_bio, int *max_sect
>         best_pending_disk =3D -1;
>         min_pending =3D UINT_MAX;
>         best_good_sectors =3D 0;
> -       choose_next_idle =3D 0;
>         clear_bit(R1BIO_FailFast, &r1_bio->state);
>
>         if ((conf->mddev->recovery_cp < this_sector + sectors) ||
> @@ -712,7 +710,6 @@ static int read_balance(struct r1conf *conf, struct r=
1bio *r1_bio, int *max_sect
>                         int opt_iosize =3D bdev_io_opt(rdev->bdev) >> 9;
>                         struct raid1_info *mirror =3D &conf->mirrors[disk=
];
>
> -                       best_disk =3D disk;
>                         /*
>                          * If buffered sequential IO size exceeds optimal
>                          * iosize, check if there is idle disk. If yes, c=
hoose
> @@ -731,15 +728,21 @@ static int read_balance(struct r1conf *conf, struct=
 r1bio *r1_bio, int *max_sect
>                             mirror->next_seq_sect > opt_iosize &&
>                             mirror->next_seq_sect - opt_iosize >=3D
>                             mirror->seq_start) {
> -                               choose_next_idle =3D 1;
> -                               continue;
> +                               /*
> +                                * Add 'pending' to avoid choosing this d=
isk if
> +                                * there is other idle disk.
> +                                * Set 'dist' to 0, so that if there is n=
o other
> +                                * idle disk and all disks are rotational=
, this
> +                                * disk will still be chosen.
> +                                */
> +                               pending++;
> +                               dist =3D 0;
> +                       } else {
> +                               best_disk =3D disk;
> +                               break;
>                         }
> -                       break;
>                 }

Hi Kuai

I noticed something. In patch 12cee5a8a29e, it sets best_disk if it's
a sequential read. If there are no other idle disks, it will read from
the sequential disk. With this patch, it reads from the
best_pending_disk even min_pending is not 0. It looks like a wrong
behaviour?

Best Regards
Xiao
>
> -               if (choose_next_idle)
> -                       continue;
> -
>                 if (min_pending > pending) {
>                         min_pending =3D pending;
>                         best_pending_disk =3D disk;
> --
> 2.39.2
>
>



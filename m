Return-Path: <linux-kernel+bounces-81526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8932286771B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 148601F2477E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036F21292D6;
	Mon, 26 Feb 2024 13:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TvwZ1BLx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E93129A8F
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 13:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708955227; cv=none; b=V3F56R/V8W9ZGJ9xXVAWVtaD2H8P+vLp6BIKiiHvcrYhE1xqOGT2dUtnowo1dsc0jYwkqT6c7Wr9taErVgMxt5j6F/1oKgILAiYbkXxmdP0GgmW3iBEJa1YESx4rCVeXuISKXGsbq8QbfHi3mCBgdXxBxTLRx+ooOjc+i3OL4Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708955227; c=relaxed/simple;
	bh=81sdhCcN9wporVYbJerD7h86zygDNdYtXMFH1Wo/mCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oYT0ugZliMHzApq6YgJ4tQEGQ8brm0nO49/Z19PQ/DMDDguW5qt4dNJPdr3PTQpJFX54KnCEM9UL1lQ5TakgYZj38P7j5+lgxiD9KCtpSCSyQDOAGsfYjPvY3uTh/DukipYjpSfsVo4mFg+CYV2p4cDJIMtnV3Kj4Hn1dospzJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TvwZ1BLx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708955223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=USZoAZmeJUCkk8eKkEZ4nGh7Q9sDulz8ByqxvL+GExk=;
	b=TvwZ1BLxoGYk0azePVOnmuwR54OsGu5r5yfpx2IZkKEQvVvp7HWPb91YLsLK00uVLB+uKu
	O3VAxULgfdpKDeJyH5u9ZFCa9lWvbdL1C03V5Gmfeka0ElotugNkBTREj3B5oJJ0TB7Bjz
	y7Bdzkc+umRD1iZEbCrC9GlKPoizTig=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-8EmOiJJCPEW5nRNu9zlqJA-1; Mon, 26 Feb 2024 08:47:02 -0500
X-MC-Unique: 8EmOiJJCPEW5nRNu9zlqJA-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1dc30bbb7b6so34698125ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 05:47:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708955221; x=1709560021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=USZoAZmeJUCkk8eKkEZ4nGh7Q9sDulz8ByqxvL+GExk=;
        b=OqGqPcJiLHRTh4zPzQKOY77NIsSyyTxXM9RPyKuixHrsIQWYsSib33/VsWZ1QLPNVL
         4FF7aIp8zQfOOibkHP2TvOn3u4uAn5IGPosbVyZyP2BIOvKsme+0Cub15hPwIsXFEcG9
         kttKdmiNmYDjyEIOCSOmM7kM7nwRLDd0GjXX4mw2h/99nBpwE0WHy3vpq/kD+gumcgR9
         hh1Jpn7bsb1pUT+U0iu+NI2GnNKty1PHb1TkLWOtQGUOoncNSlmmDAsjn0fNzt6bMpdi
         ScoyjvFZjvMWNnNk36orKiwVfQNwfdUFws1RGuzqxitXsAloxry/GG+f++OYZ34lKA+7
         bY0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVsFXrGlvyqIzCC+EQ9E/7V2H8yhmUo4c6j3SL2sADfc2YUKIg8wq9D8ZZVdOsKPU3SXBujvkn8kFVbIVNFRopTU8eFGxT/wXsEnp9i
X-Gm-Message-State: AOJu0YwgpLcGUbU3DBjY65T1qoqN+xPiOHS3cOuIA5NVoTfmszMfgQnO
	X64BU4lnPO9vGuv6Nld8KOLOh4n+qYJfwvcukxyHKnoS6TVgk8EWFDZF1+VamQVxaUpSbQ81I8x
	q+YFvXt8HlvsqVmP4mIB3gA96CcMjx/PVhL67nUfTy/I/qLKnkcNxoLGY2a+dHtBZ8lfD/tWmhL
	c5HllZTpdG80FKz7jOAreKimvurHGm3/+LVj+w
X-Received: by 2002:a17:902:ec82:b0:1dc:7719:7095 with SMTP id x2-20020a170902ec8200b001dc77197095mr11309440plg.60.1708955221377;
        Mon, 26 Feb 2024 05:47:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3wu1znA06e66UTQp6LckmdvIqmqkOe3t5EVXB0YykdFUD+gBcwlUT/cbbm9iOl+jzbZbULqAKTii64tztJm8=
X-Received: by 2002:a17:902:ec82:b0:1dc:7719:7095 with SMTP id
 x2-20020a170902ec8200b001dc77197095mr11309407plg.60.1708955221062; Mon, 26
 Feb 2024 05:47:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222075806.1816400-1-yukuai1@huaweicloud.com> <20240222075806.1816400-6-yukuai1@huaweicloud.com>
In-Reply-To: <20240222075806.1816400-6-yukuai1@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
Date: Mon, 26 Feb 2024 21:46:49 +0800
Message-ID: <CALTww28NoA4bF=gRYVEE_yYwXMdhYC4hwP2Fo0Tbgv7zAp1bwA@mail.gmail.com>
Subject: Re: [PATCH md-6.9 05/10] md/raid1-10: factor out a new helper raid1_should_read_first()
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: paul.e.luse@linux.intel.com, song@kernel.org, neilb@suse.com, shli@fb.com, 
	linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, yukuai3@huawei.com, 
	yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 4:05=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> If resync is in progress, read_balance() should find the first usable
> disk, otherwise, data could be inconsistent after resync is done. raid1
> and raid10 implement the same checking, hence factor out the checking
> to make code cleaner.
>
> Noted that raid1 is using 'mddev->recovery_cp', which is updated after
> all resync IO is done, while raid10 is using 'conf->next_resync', which
> is inaccurate because raid10 update it before submitting resync IO.
> Fortunately, raid10 read IO can't concurrent with resync IO, hence there
> is no problem. And this patch also switch raid10 to use
> 'mddev->recovery_cp'.
>
> Co-developed-by: Paul Luse <paul.e.luse@linux.intel.com>
> Signed-off-by: Paul Luse <paul.e.luse@linux.intel.com>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/raid1-10.c | 20 ++++++++++++++++++++
>  drivers/md/raid1.c    | 15 ++-------------
>  drivers/md/raid10.c   | 13 ++-----------
>  3 files changed, 24 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
> index 9bc0f0022a6c..2ea1710a3b70 100644
> --- a/drivers/md/raid1-10.c
> +++ b/drivers/md/raid1-10.c
> @@ -276,3 +276,23 @@ static inline int raid1_check_read_range(struct md_r=
dev *rdev,
>         *len =3D first_bad + bad_sectors - this_sector;
>         return 0;
>  }
> +
> +/*
> + * Check if read should choose the first rdev.
> + *
> + * Balance on the whole device if no resync is going on (recovery is ok)=
 or
> + * below the resync window. Otherwise, take the first readable disk.
> + */
> +static inline bool raid1_should_read_first(struct mddev *mddev,
> +                                          sector_t this_sector, int len)
> +{
> +       if ((mddev->recovery_cp < this_sector + len))
> +               return true;
> +
> +       if (mddev_is_clustered(mddev) &&
> +           md_cluster_ops->area_resyncing(mddev, READ, this_sector,
> +                                          this_sector + len))
> +               return true;
> +
> +       return false;
> +}
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index d0bc67e6d068..8089c569e84f 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -605,11 +605,6 @@ static int read_balance(struct r1conf *conf, struct =
r1bio *r1_bio, int *max_sect
>         struct md_rdev *rdev;
>         int choose_first;
>
> -       /*
> -        * Check if we can balance. We can balance on the whole
> -        * device if no resync is going on, or below the resync window.
> -        * We take the first readable disk when above the resync window.
> -        */
>   retry:
>         sectors =3D r1_bio->sectors;
>         best_disk =3D -1;
> @@ -618,16 +613,10 @@ static int read_balance(struct r1conf *conf, struct=
 r1bio *r1_bio, int *max_sect
>         best_pending_disk =3D -1;
>         min_pending =3D UINT_MAX;
>         best_good_sectors =3D 0;
> +       choose_first =3D raid1_should_read_first(conf->mddev, this_sector=
,
> +                                              sectors);
>         clear_bit(R1BIO_FailFast, &r1_bio->state);
>
> -       if ((conf->mddev->recovery_cp < this_sector + sectors) ||
> -           (mddev_is_clustered(conf->mddev) &&
> -           md_cluster_ops->area_resyncing(conf->mddev, READ, this_sector=
,
> -                   this_sector + sectors)))
> -               choose_first =3D 1;
> -       else
> -               choose_first =3D 0;
> -
>         for (disk =3D 0 ; disk < conf->raid_disks * 2 ; disk++) {
>                 sector_t dist;
>                 sector_t first_bad;
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 1f6693e40e12..22bcc3ce11d3 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -747,17 +747,8 @@ static struct md_rdev *read_balance(struct r10conf *=
conf,
>         best_good_sectors =3D 0;
>         do_balance =3D 1;
>         clear_bit(R10BIO_FailFast, &r10_bio->state);
> -       /*
> -        * Check if we can balance. We can balance on the whole
> -        * device if no resync is going on (recovery is ok), or below
> -        * the resync window. We take the first readable disk when
> -        * above the resync window.
> -        */
> -       if ((conf->mddev->recovery_cp < MaxSector
> -            && (this_sector + sectors >=3D conf->next_resync)) ||
> -           (mddev_is_clustered(conf->mddev) &&
> -            md_cluster_ops->area_resyncing(conf->mddev, READ, this_secto=
r,
> -                                           this_sector + sectors)))
> +
> +       if (raid1_should_read_first(conf->mddev, this_sector, sectors))
>                 do_balance =3D 0;
>
>         for (slot =3D 0; slot < conf->copies ; slot++) {
> --
> 2.39.2
>
>

This patch looks good to me.
Reviewed-by: Xiao Ni <xni@redhat.com>



Return-Path: <linux-kernel+bounces-81600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A24086780C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FB6BB21BEC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E52F12AAC5;
	Mon, 26 Feb 2024 14:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XyYm2SsY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923BD129A75
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 14:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708957029; cv=none; b=Uihrb5uO4Q4Dig0viB2iG91uz6btrTvVatWDvgKDwoH41DRlgq2Ic8zk/awRm/RVpWpVslUU/kzM1r3gE9o/7v8vdqyFK+RcnhXZtS0iJc1eYHb24EwDiTSQi+qsk0nwkn/XM2iGEmkJRwd0ZbMQVxbKnSMPMrnfFvdK9em1AuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708957029; c=relaxed/simple;
	bh=2R8zmYeri3zsG9W6fhcIti0cqMgjlxvVSXl9omqewUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h+hIPg+of4i4KRkooO7YXYzb0N5lre153+K1Nkb0ahpZsIPxeRB27xYBQ2VFaLOxm08Gznfm+lF/lQfhRfsUd5/q/1NfwK/ECI9J0VSjmIqHwDalyvh8/ZgxJHQSIX5CzbrydvKxAXsRf09SULRtIvfv0IM3dLpkdIYePzb2+3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XyYm2SsY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708957025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rT5FNd5ZdPMnJpwMSAxERhFJWRk/ww2nvQqf7Xzgvsw=;
	b=XyYm2SsY/MwNeaJUi35r0Zp9mcwVdQjLn7W3h2NI+g70j/8TJ2PSfDnFJYEdLHHFg7BA8o
	doPahK3lJmQjFwoyR6aClQkoaK3tggCvx58Jp7aWLj9hf26ROwITCGA2VV4GIZzWGiUR0X
	H14KuBOoPaiFORw4YQjoeDr0t3Y1OGs=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-PIHWAKlQPeWBOlQDfJq_Mg-1; Mon, 26 Feb 2024 09:17:03 -0500
X-MC-Unique: PIHWAKlQPeWBOlQDfJq_Mg-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1dbcbfff988so29303695ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 06:17:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708957022; x=1709561822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rT5FNd5ZdPMnJpwMSAxERhFJWRk/ww2nvQqf7Xzgvsw=;
        b=FDt1D9G7hlqLOzLIvZQD+qXJEg9vyBxz6OqbhDyYMx1wmFGoKjhyJ5Vpkimi416x6H
         7Tz0s+FdheLz5iAfvG/fgKjt2aLp/3zlh9jll/vDDkTmjqEd2+1pILb1P6LSlNc+/ULZ
         Xu1oWFVl10S/XBlWTJ504sYwSMXqJz+3TumBn5D3v+EarWL/qNAWMbaeAgkwan20EKFc
         OVCrgbmZ3s/XmYzKl5HypVGbRNGzbph9iSU4yMJnga4PpHt2auvMHDB5/kvwCQcUl6Uk
         b7mY/crWl5RpK29hqJPkI3zS86gdGaFY6t+1BbgQycn/c4Bg0oxQ4W77AA398fOPWPzD
         G3UA==
X-Forwarded-Encrypted: i=1; AJvYcCWvNTDuWFlXtxY7Etj25ykJ6dApaREvEvPxJTFT0yht20gVdUhAa0LoM0Ei1WDcmQ1SDWFUnt60PIcM0zEaQILXdfNrnjSF6AcWc5OG
X-Gm-Message-State: AOJu0YyqGu063yQ9AtGqQDK3rJq3j/W7Me6m6v1rIGMPjVYqnbNHhcfl
	C3fntvYiIVMNm5vT6aXiCcummCsg7cU1qVWRosoVA67Vwk1MZyAYKNki1ZbbqfV2XESfi1FFycx
	g8IvtswZMtFXKlztkE+TCGL7ddRpj3oYsf9cWAh2oupCVBWKqgLuEZWwcPKlWuZXLsPdVAw3NOM
	R5qXECut7QSacEt1+g17fVvdR/Yd972CFZFXaJ
X-Received: by 2002:a17:902:f690:b0:1dc:5dc0:9ba with SMTP id l16-20020a170902f69000b001dc5dc009bamr7813018plg.26.1708957022702;
        Mon, 26 Feb 2024 06:17:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGpEzUc/7S8O7mb0wIKBfe+g8VFrEOyCmvLDtXYk2SFh9UHlV+5Ma265vgaNuM2ir0S+UM+QJ0tYa/XbzRugQ=
X-Received: by 2002:a17:902:f690:b0:1dc:5dc0:9ba with SMTP id
 l16-20020a170902f69000b001dc5dc009bamr7812995plg.26.1708957022361; Mon, 26
 Feb 2024 06:17:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222075806.1816400-1-yukuai1@huaweicloud.com> <20240222075806.1816400-7-yukuai1@huaweicloud.com>
In-Reply-To: <20240222075806.1816400-7-yukuai1@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
Date: Mon, 26 Feb 2024 22:16:51 +0800
Message-ID: <CALTww2-ypx2YJOeXTzj7Y0EtXMkfrTOAJzzmDnnUK=1irspWtQ@mail.gmail.com>
Subject: Re: [PATCH md-6.9 06/10] md/raid1: factor out read_first_rdev() from read_balance()
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
> read_balance() is hard to understand because there are too many status
> and branches, and it's overlong.
>
> This patch factor out the case to read the first rdev from
> read_balance(), there are no functional changes.
>
> Co-developed-by: Paul Luse <paul.e.luse@linux.intel.com>
> Signed-off-by: Paul Luse <paul.e.luse@linux.intel.com>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/raid1.c | 63 +++++++++++++++++++++++++++++++++-------------
>  1 file changed, 46 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index 8089c569e84f..08c45ca55a7e 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -579,6 +579,47 @@ static sector_t align_to_barrier_unit_end(sector_t s=
tart_sector,
>         return len;
>  }
>
> +static void update_read_sectors(struct r1conf *conf, int disk,
> +                               sector_t this_sector, int len)
> +{
> +       struct raid1_info *info =3D &conf->mirrors[disk];
> +
> +       atomic_inc(&info->rdev->nr_pending);
> +       if (info->next_seq_sect !=3D this_sector)
> +               info->seq_start =3D this_sector;
> +       info->next_seq_sect =3D this_sector + len;
> +}
> +
> +static int choose_first_rdev(struct r1conf *conf, struct r1bio *r1_bio,
> +                            int *max_sectors)
> +{
> +       sector_t this_sector =3D r1_bio->sector;
> +       int len =3D r1_bio->sectors;
> +       int disk;
> +
> +       for (disk =3D 0 ; disk < conf->raid_disks * 2 ; disk++) {
> +               struct md_rdev *rdev;
> +               int read_len;
> +
> +               if (r1_bio->bios[disk] =3D=3D IO_BLOCKED)
> +                       continue;
> +
> +               rdev =3D conf->mirrors[disk].rdev;
> +               if (!rdev || test_bit(Faulty, &rdev->flags))
> +                       continue;
> +
> +               /* choose the first disk even if it has some bad blocks. =
*/
> +               read_len =3D raid1_check_read_range(rdev, this_sector, &l=
en);
> +               if (read_len > 0) {
> +                       update_read_sectors(conf, disk, this_sector, read=
_len);
> +                       *max_sectors =3D read_len;
> +                       return disk;
> +               }

Hi Kuai

It needs to update max_sectors even if the bad block starts before
this_sector. Because it can't read more than bad_blocks from other
member disks. If it reads more data than bad blocks, it will cause
data corruption. One rule here is read from the primary disk (the
first readable disk) if it has no bad block and read the
badblock-data-length data from other disks.

Best Regards
Xiao

> +       }
> +
> +       return -1;
> +}
> +
>  /*
>   * This routine returns the disk from which the requested read should
>   * be done. There is a per-array 'next expected sequential IO' sector
> @@ -603,7 +644,6 @@ static int read_balance(struct r1conf *conf, struct r=
1bio *r1_bio, int *max_sect
>         sector_t best_dist;
>         unsigned int min_pending;
>         struct md_rdev *rdev;
> -       int choose_first;
>
>   retry:
>         sectors =3D r1_bio->sectors;
> @@ -613,10 +653,11 @@ static int read_balance(struct r1conf *conf, struct=
 r1bio *r1_bio, int *max_sect
>         best_pending_disk =3D -1;
>         min_pending =3D UINT_MAX;
>         best_good_sectors =3D 0;
> -       choose_first =3D raid1_should_read_first(conf->mddev, this_sector=
,
> -                                              sectors);
>         clear_bit(R1BIO_FailFast, &r1_bio->state);
>
> +       if (raid1_should_read_first(conf->mddev, this_sector, sectors))
> +               return choose_first_rdev(conf, r1_bio, max_sectors);
> +
>         for (disk =3D 0 ; disk < conf->raid_disks * 2 ; disk++) {
>                 sector_t dist;
>                 sector_t first_bad;
> @@ -662,8 +703,6 @@ static int read_balance(struct r1conf *conf, struct r=
1bio *r1_bio, int *max_sect
>                                  * bad_sectors from another device..
>                                  */
>                                 bad_sectors -=3D (this_sector - first_bad=
);
> -                               if (choose_first && sectors > bad_sectors=
)
> -                                       sectors =3D bad_sectors;
>                                 if (best_good_sectors > sectors)
>                                         best_good_sectors =3D sectors;
>
> @@ -673,8 +712,6 @@ static int read_balance(struct r1conf *conf, struct r=
1bio *r1_bio, int *max_sect
>                                         best_good_sectors =3D good_sector=
s;
>                                         best_disk =3D disk;
>                                 }
> -                               if (choose_first)
> -                                       break;
>                         }
>                         continue;
>                 } else {
> @@ -689,10 +726,6 @@ static int read_balance(struct r1conf *conf, struct =
r1bio *r1_bio, int *max_sect
>
>                 pending =3D atomic_read(&rdev->nr_pending);
>                 dist =3D abs(this_sector - conf->mirrors[disk].head_posit=
ion);
> -               if (choose_first) {
> -                       best_disk =3D disk;
> -                       break;
> -               }
>                 /* Don't change to another disk for sequential reads */
>                 if (conf->mirrors[disk].next_seq_sect =3D=3D this_sector
>                     || dist =3D=3D 0) {
> @@ -760,13 +793,9 @@ static int read_balance(struct r1conf *conf, struct =
r1bio *r1_bio, int *max_sect
>                 rdev =3D conf->mirrors[best_disk].rdev;
>                 if (!rdev)
>                         goto retry;
> -               atomic_inc(&rdev->nr_pending);
> -               sectors =3D best_good_sectors;
> -
> -               if (conf->mirrors[best_disk].next_seq_sect !=3D this_sect=
or)
> -                       conf->mirrors[best_disk].seq_start =3D this_secto=
r;
>
> -               conf->mirrors[best_disk].next_seq_sect =3D this_sector + =
sectors;
> +               sectors =3D best_good_sectors;
> +               update_read_sectors(conf, disk, this_sector, sectors);
>         }
>         *max_sectors =3D sectors;
>
> --
> 2.39.2
>
>



Return-Path: <linux-kernel+bounces-82564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49381868667
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7C5928EA38
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909B3EAF1;
	Tue, 27 Feb 2024 01:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XgHHq85p"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF9C5C82
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 01:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708998639; cv=none; b=t4xAmG2x/icodCtQr6J9xEAq4I6N4VmRH9cM0ojTcMCB/NM5zT8fB80LN3opeEXtc+NkZylHURPL6AfbZkvZxNTW01fVIdPzeMSpUfQwKyz5KWKtx7Edwu9UVWQCRiRrzmkVedEwh+ffQc4btH1oedQAFjyx2YNyfvFxiKS1S+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708998639; c=relaxed/simple;
	bh=gAQlvGhS6nER+GNSg1JbNb1rqkJQCpq+MwxvFfPc8Ng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B0Gb33zhw53XvlMIG4ozDrV02j5pur9tYQQHdQ1Rb7f/4nKsnCnSaQcxDBEyWRq99Zs5YG+Dau0MZ2MHNOci0q23MkzbEBco5biPPRrG0HLVl57mueZFHr4XcAwY/CiYFXu0QxBHWNzQF7Yj1tzTqeIb2rLopzaZDNkT6TgdMJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XgHHq85p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708998637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vTTITb2cSjdmzEUUDSvzoi0Me6vG5i4YZ5c4Xa5F5Ak=;
	b=XgHHq85pIbfRVTanrY5aW/IhBff5jDHRL1ymCmiBpiIDRroNDYPVPWsrunC48OLpuQ65P6
	yjcJHVg0WeaayZth2GxWilv6eYDQFcyWRc1U1EzjCTj5xaKXjKjyAjc6p9capit8xd+76/
	hJgPgVsMXUKO5kBgxMMClve8xVnYfMA=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-mr6dco8vNAW6UX1069ttKw-1; Mon, 26 Feb 2024 20:50:35 -0500
X-MC-Unique: mr6dco8vNAW6UX1069ttKw-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1dc435b3e87so28030845ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 17:50:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708998635; x=1709603435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vTTITb2cSjdmzEUUDSvzoi0Me6vG5i4YZ5c4Xa5F5Ak=;
        b=jM/90XkLL9Oh/aOlgfJEuQpERwuCqpAEchQZzhUOyTR/MPfte5OdeURoR4WTORcSK7
         WgSb/vZT97r1EAe+DDP8GtzKomYmnI8tcz18R19dw3vt3LiIBoae2uftjedkv9TjFNlR
         RxOpfxJ/uMI+AK9kFn8mupu02xH6AY+JH45qzpdSgv+Ybg4fa5sXDIX4QHSbtB2oa775
         2BdhFE02suzpmJ9fPZX1o8e/Vkb0rN+fH6mMDCNjjfu9R9+beE6WXAED9YhrGe6nOMgO
         PAoEPtU3LXmHC8hsaJSGRSQOdR37kv+7gJ/UIQiRVAPSFDy3cW6S+jWQLV0dl1xHJKen
         BhGg==
X-Forwarded-Encrypted: i=1; AJvYcCVsY/A105XpE8CBsj4yj+jqAf5FWm/osJeu2pm4MkdsxXKTsZkL3gMTl9WFt6EdepauiD13rKFBgAtGDgu05AzgwjgLqR3Korh2vucx
X-Gm-Message-State: AOJu0YzXi5Hwx8fmr6bhoAAAV8xWln80gADM+wbvNmsBd6RELD4571CI
	zpwryqOB8+iZBlRcWRyMmHzAxCv/PNptlyfmAy+WrpXQfkpZPv9q77RTpqpLkQwMhfw6e1+ebCI
	p/rM5giXXxR44YnR9uANhEyQrlch/4FkFIbHqLpBlBoJZTQbgNVkK6BDZx6xDB3lrMoK2n7lXPp
	1QLcLUqrjmG4QWDZfIs5o6Vdi6D2/lGdkx4sOV
X-Received: by 2002:a17:902:ced1:b0:1dc:a00c:5442 with SMTP id d17-20020a170902ced100b001dca00c5442mr5072565plg.43.1708998634855;
        Mon, 26 Feb 2024 17:50:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtkIUDwNPdnbq7WXdG192cZoWa/oJN4PKqmmAq+7eH8nhOsVmQDO3AQHqZstow/xCSVVoQyLfe3Pg8i6DVi1k=
X-Received: by 2002:a17:902:ced1:b0:1dc:a00c:5442 with SMTP id
 d17-20020a170902ced100b001dca00c5442mr5072555plg.43.1708998634550; Mon, 26
 Feb 2024 17:50:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222075806.1816400-1-yukuai1@huaweicloud.com> <20240222075806.1816400-9-yukuai1@huaweicloud.com>
In-Reply-To: <20240222075806.1816400-9-yukuai1@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
Date: Tue, 27 Feb 2024 09:50:23 +0800
Message-ID: <CALTww285P14E8oucJuLunNL8H+hGeVa4LRpjurP1is3xjqTLQg@mail.gmail.com>
Subject: Re: [PATCH md-6.9 08/10] md/raid1: factor out choose_bb_rdev() from read_balance()
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
> read_balance() is hard to understand because there are too many status
> and branches, and it's overlong.
>
> This patch factor out the case to read the rdev with bad blocks from
> read_balance(), there are no functional changes.
>
> Co-developed-by: Paul Luse <paul.e.luse@linux.intel.com>
> Signed-off-by: Paul Luse <paul.e.luse@linux.intel.com>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/raid1.c | 79 ++++++++++++++++++++++++++++------------------
>  1 file changed, 48 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index bc2f8fcbe5b3..4694e0e71e36 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -620,6 +620,44 @@ static int choose_first_rdev(struct r1conf *conf, st=
ruct r1bio *r1_bio,
>         return -1;
>  }
>
> +static int choose_bb_rdev(struct r1conf *conf, struct r1bio *r1_bio,
> +                         int *max_sectors)
> +{
> +       sector_t this_sector =3D r1_bio->sector;
> +       int best_disk =3D -1;
> +       int best_len =3D 0;
> +       int disk;
> +
> +       for (disk =3D 0 ; disk < conf->raid_disks * 2 ; disk++) {
> +               struct md_rdev *rdev;
> +               int len;
> +               int read_len;
> +
> +               if (r1_bio->bios[disk] =3D=3D IO_BLOCKED)
> +                       continue;
> +
> +               rdev =3D conf->mirrors[disk].rdev;
> +               if (!rdev || test_bit(Faulty, &rdev->flags) ||
> +                   test_bit(WriteMostly, &rdev->flags))
> +                       continue;
> +
> +               /* keep track of the disk with the most readable sectors.=
 */
> +               len =3D r1_bio->sectors;
> +               read_len =3D raid1_check_read_range(rdev, this_sector, &l=
en);
> +               if (read_len > best_len) {
> +                       best_disk =3D disk;
> +                       best_len =3D read_len;
> +               }
> +       }
> +
> +       if (best_disk !=3D -1) {
> +               *max_sectors =3D best_len;
> +               update_read_sectors(conf, best_disk, this_sector, best_le=
n);
> +       }
> +
> +       return best_disk;
> +}
> +
>  static int choose_slow_rdev(struct r1conf *conf, struct r1bio *r1_bio,
>                             int *max_sectors)
>  {
> @@ -707,8 +745,6 @@ static int read_balance(struct r1conf *conf, struct r=
1bio *r1_bio, int *max_sect
>
>         for (disk =3D 0 ; disk < conf->raid_disks * 2 ; disk++) {
>                 sector_t dist;
> -               sector_t first_bad;
> -               int bad_sectors;
>                 unsigned int pending;
>
>                 rdev =3D conf->mirrors[disk].rdev;
> @@ -721,36 +757,8 @@ static int read_balance(struct r1conf *conf, struct =
r1bio *r1_bio, int *max_sect
>                         continue;
>                 if (test_bit(WriteMostly, &rdev->flags))
>                         continue;
> -               /* This is a reasonable device to use.  It might
> -                * even be best.
> -                */
> -               if (is_badblock(rdev, this_sector, sectors,
> -                               &first_bad, &bad_sectors)) {
> -                       if (best_dist < MaxSector)
> -                               /* already have a better device */
> -                               continue;
> -                       if (first_bad <=3D this_sector) {
> -                               /* cannot read here. If this is the 'prim=
ary'
> -                                * device, then we must not read beyond
> -                                * bad_sectors from another device..
> -                                */
> -                               bad_sectors -=3D (this_sector - first_bad=
);
> -                               if (best_good_sectors > sectors)
> -                                       best_good_sectors =3D sectors;
> -
> -                       } else {
> -                               sector_t good_sectors =3D first_bad - thi=
s_sector;
> -                               if (good_sectors > best_good_sectors) {
> -                                       best_good_sectors =3D good_sector=
s;
> -                                       best_disk =3D disk;
> -                               }
> -                       }
> +               if (rdev_has_badblock(rdev, this_sector, sectors))
>                         continue;
> -               } else {
> -                       if ((sectors > best_good_sectors) && (best_disk >=
=3D 0))
> -                               best_disk =3D -1;
> -                       best_good_sectors =3D sectors;
> -               }
>
>                 if (best_disk >=3D 0)
>                         /* At least two disks to choose from so failfast =
is OK */
> @@ -834,6 +842,15 @@ static int read_balance(struct r1conf *conf, struct =
r1bio *r1_bio, int *max_sect
>         if (best_disk >=3D 0)
>                 return best_disk;
>
> +       /*
> +        * If we are here it means we didn't find a perfectly good disk s=
o
> +        * now spend a bit more time trying to find one with the most goo=
d
> +        * sectors.
> +        */
> +       disk =3D choose_bb_rdev(conf, r1_bio, max_sectors);
> +       if (disk >=3D 0)
> +               return disk;
> +
>         return choose_slow_rdev(conf, r1_bio, max_sectors);
>  }
>
> --
> 2.39.2
>
>
Hi
This patch looks good to me.
Reviewed-by: Xiao Ni <xni@redhat.com>



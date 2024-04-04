Return-Path: <linux-kernel+bounces-131950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E35898DD9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E02E21C22749
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1046F1304B7;
	Thu,  4 Apr 2024 18:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cN2nUqmu"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA02612AAEA
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 18:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712254844; cv=none; b=fxp/qGjg2pAkS92C14t3oTm22KvG+1FaUUpwJig7iVHJtHLH97HTJu+piOCu6T3V0huXaQQaldWl5mMGDxn25Yx5t02xSTB/bBUHUy0swgKccwztt7Vv4EV3ZXmN0X6RdM4I+UD17rLKunj0IHPbc+3qhQE+5c3B/qSO13y4WW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712254844; c=relaxed/simple;
	bh=e5g0fNwhaRE7FXVA54FziCjuxasfr6glNkCGFONMlxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lspluMELIg9XheucumcjGz720OCsBp70S0gBfMxpRWf+d8GC0FXgnYR93DmfsZvfguwJH75ifu5WxQ2bX5WacBC3Hdj+Pt1Ix88QPMy4e44dBDZZOR325pGZ7vR/Ydemwb/92gxF9cQTAGepWlKRfHZxsbUH557BQYQkNLFHnyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cN2nUqmu; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5a56710cdccso595632eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 11:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712254842; x=1712859642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hCTjSQ3G8vwzoqRaOEC3cHI2iX+8hi+olDPLQuDHRkA=;
        b=cN2nUqmunaUBD+y/wEp8S+ReU5WbuebJ6+yOBjr/4QbIynscbw454dYXzOcz+86XRT
         YQRdxePE/dl1O03nKoaQYv3p/h0Ukf375LaDWZ7jcmPo1WYu6p/h1qJ4mUJAHMRqCX67
         OEwq4A7bC62kt0cC204m16RpFmcii9Xn4coz/R3ar9X1gt71H1nX9RbeofivM8Yga31r
         VG630FejzEGXyYyBz0NH1ZfAdDBIbF56kY7fG07/cPWlJ7T+c0OgmuIDeSw5b0WEhnMk
         jAYKUpaE1/x4SwJo+NQSkBkVV4CeBFZaAIit1RsnY4h6Hg65Pf6ALeu4GJO7N1sMePoT
         iZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712254842; x=1712859642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hCTjSQ3G8vwzoqRaOEC3cHI2iX+8hi+olDPLQuDHRkA=;
        b=aZ6OHrSPJi0QRl0kCUgEQz/JN8b3AI7bXmoieKvVDBkF4Vojbfy9ifLDUrU2Ei3fT+
         Kj74Q292YOVDJng1+Kr079esEs5i6JYs/dvqONK2ADcJG1CkJJ/TYx75mxTvUqzi1Sep
         jjIwtfQqNk0SdTqkO/aFsq4PiP9zbNIYLMAeJhEcwSwvIEMD0HaVDxS0V+BzsG2CCDzK
         /MN7lbZq2s4NNWVK3ro1nyxZULTQZhH/Pjj9r/JOFGzJvdCam14sFs4P1JgJfmS4cZsa
         ZdmsF9I8LUri24ZvwR4yYxCo7Sh9H53M2T8jh+13mlYvZTYcB9NISvKHh4amAhytdfSd
         wF/w==
X-Forwarded-Encrypted: i=1; AJvYcCWB0i872p1zxtRPGsMuhIhOjcc65TpRCCAh8nFlc2z75BsOJXwsVKpZpd2nqDxa2ZPkyFTFo6qm3wkL5TH0KKL9/2vfk1vhDAEJQkBM
X-Gm-Message-State: AOJu0YwuYMmtryUe6FQgbMqY0eq9ANP7sdWe1UKM6XhNth56TklYLWCT
	YGhyOeQoIyJ7oEaX6YePvZV4Ricl+xP2DY8HUX5MRn+H1X/Okf+jZSpDNv9bGs0ra/N4e7rVo0h
	ePn7FA+7HT2iem4IyXslUDkEIMQklVFXHiiI=
X-Google-Smtp-Source: AGHT+IHPGeiiu47FUDDpgQkoqFhZCWQZi6JtgKQDL5jzut6zhAA+ynl+4+e/MN9+fvRi/yVxkuseDfV7OtF4U6xIPZ4=
X-Received: by 2002:a05:6359:45a9:b0:17f:56c9:95e4 with SMTP id
 no41-20020a05635945a900b0017f56c995e4mr3484609rwb.7.1712254841826; Thu, 04
 Apr 2024 11:20:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328072136.3023135-1-chao@kernel.org>
In-Reply-To: <20240328072136.3023135-1-chao@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Thu, 4 Apr 2024 11:20:30 -0700
Message-ID: <CACOAw_w0YgVtGGdb-2DQ6ROCc7YyXETWxWPiAB+D0qHt369fQQ@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v6] f2fs: fix zoned block device information initialization
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, Wenjie Qi <qwjhust@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 12:23=E2=80=AFAM Chao Yu <chao@kernel.org> wrote:
>
> From: Wenjie Qi <qwjhust@gmail.com>
>
> If the max open zones of zoned devices are less than
> the active logs of F2FS, the device may error due to
> insufficient zone resources when multiple active logs
> are being written at the same time.
>
> Signed-off-by: Wenjie Qi <qwjhust@gmail.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v6:
> - add check condition to avoid remount failure.
>  fs/f2fs/f2fs.h  |  1 +
>  fs/f2fs/super.c | 27 +++++++++++++++++++++++++++
>  2 files changed, 28 insertions(+)
>
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 0550929dc6e5..694f8a52cb84 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1559,6 +1559,7 @@ struct f2fs_sb_info {
>
>  #ifdef CONFIG_BLK_DEV_ZONED
>         unsigned int blocks_per_blkz;           /* F2FS blocks per zone *=
/
> +       unsigned int max_open_zones;            /* max open zone resource=
s of the zoned device */
>  #endif
>
>         /* for node-related operations */
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 7c45929671ad..642540782471 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2326,6 +2326,17 @@ static int f2fs_remount(struct super_block *sb, in=
t *flags, char *data)
>         if (err)
>                 goto restore_opts;
>
> +#ifdef CONFIG_BLK_DEV_ZONED
> +       if (f2fs_is_multi_device(sbi) &&

Why do we check multiple devices' condition here?

Thanks,

> +               sbi->max_open_zones < F2FS_OPTION(sbi).active_logs) {
> +               f2fs_err(sbi,
> +                       "zoned: max open zones %u is too small, need at l=
east %u open zones",
> +                                sbi->max_open_zones, F2FS_OPTION(sbi).ac=
tive_logs);
> +               err =3D -EINVAL;
> +               goto restore_opts;
> +       }
> +#endif
> +
>         /* flush outstanding errors before changing fs state */
>         flush_work(&sbi->s_error_work);
>
> @@ -3868,11 +3879,24 @@ static int init_blkz_info(struct f2fs_sb_info *sb=
i, int devi)
>         sector_t nr_sectors =3D bdev_nr_sectors(bdev);
>         struct f2fs_report_zones_args rep_zone_arg;
>         u64 zone_sectors;
> +       unsigned int max_open_zones;
>         int ret;
>
>         if (!f2fs_sb_has_blkzoned(sbi))
>                 return 0;
>
> +       if (bdev_is_zoned(FDEV(devi).bdev)) {
> +               max_open_zones =3D bdev_max_open_zones(bdev);
> +               if (max_open_zones && (max_open_zones < sbi->max_open_zon=
es))
> +                       sbi->max_open_zones =3D max_open_zones;
> +               if (sbi->max_open_zones < F2FS_OPTION(sbi).active_logs) {
> +                       f2fs_err(sbi,
> +                               "zoned: max open zones %u is too small, n=
eed at least %u open zones",
> +                               sbi->max_open_zones, F2FS_OPTION(sbi).act=
ive_logs);
> +                       return -EINVAL;
> +               }
> +       }
> +
>         zone_sectors =3D bdev_zone_sectors(bdev);
>         if (sbi->blocks_per_blkz && sbi->blocks_per_blkz !=3D
>                                 SECTOR_TO_BLOCK(zone_sectors))
> @@ -4186,6 +4210,9 @@ static int f2fs_scan_devices(struct f2fs_sb_info *s=
bi)
>
>         logical_blksize =3D bdev_logical_block_size(sbi->sb->s_bdev);
>         sbi->aligned_blksize =3D true;
> +#ifdef CONFIG_BLK_DEV_ZONED
> +       sbi->max_open_zones =3D UINT_MAX;
> +#endif
>
>         for (i =3D 0; i < max_devices; i++) {
>                 if (i =3D=3D 0)
> --
> 2.40.1
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


Return-Path: <linux-kernel+bounces-51378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D6B848A9E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 03:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D49A1F2483C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 02:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A43138C;
	Sun,  4 Feb 2024 02:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZSUvlf/"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A522410F5
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 02:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707013104; cv=none; b=P8vcleFcsRePYzQ+cQF/ivLVJs/toaYxmtEmJez9E7sMHoLQmazY17ae0pgu+GU381l60L+NhUkktlLJOpqnVTb9ME/G0aRLwsMyHTdEFRBbbVTcyEGltX4k7KLDf0viu7wKJsi5+ZVDT5P79BeNV2M8lcj+ksEAZcSjgZqEZYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707013104; c=relaxed/simple;
	bh=zYfgsWh5OFyEIsulmmU/NWZrxk8k3w5eiAzU2GphGXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uE5Vk+P609S3cREz5FfXXOfSL0M91D/77G0aJ5BTguojdvppNYC+YuKuB4yCq2Gzo0S5Qje7dl3G+Km/9B2mjZQPTJp9nzLl+ofgydpcL5PXoWjAC0iuSPb0oWM1xfXVzqxTsldLjBFkzwmtdxQjWeciEAkmZIdV7FLIBmDCBcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZSUvlf/; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-42a99cbb4bbso34779041cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 18:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707013101; x=1707617901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGsXDZjqFHawsjoYr3JCHIL/fKcB3IoHbX6tslRW6HA=;
        b=dZSUvlf/E0mPjqj8p5iiLQa60y1uRp6ycXAycQ+BoF676khKtD9mKt3Luw5Vwsphzd
         pzvyolZcgtsxrB9ycq86VyFs5uVEBMlH/4uMkin+ZVx9MvUZDtZMnUu23tqtXMC1PmzH
         T4ILh1Qz8EAqsgja+zWnM0+uQdYFaMUT6aE8rnPOquHjDs3JX+oKr3i3AK0rh8d3TT1z
         NZBzr2Yy6XPUY1hUPVNeyW6CBCVXmRtiSHOTgYgm8fz1E1jyCNdILkM67AA9SA2nJmG/
         9PYY1CTZgNzNFnN9hb04V054aN8/feLHzn8zKSSJkH0kNZP/wIqjPkkcCPqj3aDBelPD
         bwjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707013101; x=1707617901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tGsXDZjqFHawsjoYr3JCHIL/fKcB3IoHbX6tslRW6HA=;
        b=mOxr6EpDnq9HD59gp7ETykDuvZ4fMg0E5omkxzFWh/KqFcSNe5mDPpoIuxZnADz5i2
         QGE4aiAswQjf15QwTWUQSnFk+CKg8NjfYBBiEbyMYrucfvmXju28JoEfQ0eFq+BVL+fk
         yJte42Zfj91XVAabXVlvOWrRBHYEN30cxZ3Ux88ZkaKo3R2VZdVRLVZBnCeB0Og1PF2p
         XWYjWFlamYXv33Va6Po5I8tGpIbjz/FRIruoLlkzyqsVl8W7nFxuj4JdbWNJsxaQ1OBN
         VLY0woYVkS4TTMDbCtRyxXcTwNBaWrgOoMLlKy9kGptH5uazSESPLo3INOVE7xm1vM+F
         TSGQ==
X-Gm-Message-State: AOJu0YyIvCMzmRqdShm44VVuyJr03htU2ST29gc+Si1ppY28Hpjqmxq+
	fyKnVhEHWRxC+SN/0bahQwq3G/aTAGqeHJhWBZOO0XI75JVdNjgi3u8d0rKoRgsmmMuF3XIO7n3
	z7rTE7X0Bt6YpookQdJa2P2zJMuj8OF6PLngjhvcI
X-Google-Smtp-Source: AGHT+IFc9Pmi5ImlvuBMdyt5nssr3BB70eTeqYP47Nq3ns0PasmwejUoo/JqgOwNjwNSwlRzg8UaHkOZgVovnKyLfW0=
X-Received: by 2002:ac8:5d89:0:b0:42c:768:7b12 with SMTP id
 d9-20020ac85d89000000b0042c07687b12mr4382614qtx.22.1707013101231; Sat, 03 Feb
 2024 18:18:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240203152436.1352-1-qwjhust@gmail.com> <8eaf59a4-1aaa-460e-a3cc-b798ed5e0f63@kernel.org>
In-Reply-To: <8eaf59a4-1aaa-460e-a3cc-b798ed5e0f63@kernel.org>
From: Wenjie Qi <qwjhust@gmail.com>
Date: Sun, 4 Feb 2024 10:18:10 +0800
Message-ID: <CAGFpFsTz_9Zaj0PuptjBxOJwxF68geAUfd1qtx9--Tczh+jZww@mail.gmail.com>
Subject: Re: [PATCH v4] f2fs: fix zoned block device information initialization
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, yangyongpeng1@oppo.com, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	hustqwj@hust.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chao,

It seems to me that when mounting multiple zoned devices,
if their max_open_zones are all 0, then sbi->max_open_zones is 0.
This suggests that all of the mounted devices can open an unlimited
number of zones,
and that we don't need to compare sbi->max_open_zones with
F2FS_OPTION( sbi).active_logs.

Thanks,

Chao Yu <chao@kernel.org> =E4=BA=8E2024=E5=B9=B42=E6=9C=884=E6=97=A5=E5=91=
=A8=E6=97=A5 09:47=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2024/2/3 23:24, Wenjie Qi wrote:
> > If the max open zones of zoned devices are less than
> > the active logs of F2FS, the device may error due to
> > insufficient zone resources when multiple active logs are
> > being written at the same time. If this value is 0,
> > there is no limit.
> >
> > Signed-off-by: Wenjie Qi <qwjhust@gmail.com>
> > ---
> >   fs/f2fs/f2fs.h  |  1 +
> >   fs/f2fs/super.c | 21 +++++++++++++++++++++
> >   2 files changed, 22 insertions(+)
> >
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index 543898482f8b..161107f2d3bd 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -1558,6 +1558,7 @@ struct f2fs_sb_info {
> >
> >   #ifdef CONFIG_BLK_DEV_ZONED
> >       unsigned int blocks_per_blkz;           /* F2FS blocks per zone *=
/
> > +     unsigned int max_open_zones;            /* max open zone resource=
s of the zoned device */
> >   #endif
> >
> >       /* for node-related operations */
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index 1b718bebfaa1..45e82d6016fc 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -2388,6 +2388,16 @@ static int f2fs_remount(struct super_block *sb, =
int *flags, char *data)
> >       if (err)
> >               goto restore_opts;
> >
> > +#ifdef CONFIG_BLK_DEV_ZONED
> > +     if (sbi->max_open_zones && sbi->max_open_zones < F2FS_OPTION(sbi)=
active_logs) {
> > +             f2fs_err(sbi,
> > +                     "zoned: max open zones %u is too small, need at l=
east %u open zones",
> > +                              sbi->max_open_zones, F2FS_OPTION(sbi).ac=
tive_logs);
> > +             err =3D -EINVAL;
> > +             goto restore_opts;
> > +     }
> > +#endif
> > +
> >       /* flush outstanding errors before changing fs state */
> >       flush_work(&sbi->s_error_work);
> >
> > @@ -3930,11 +3940,22 @@ static int init_blkz_info(struct f2fs_sb_info *=
sbi, int devi)
> >       sector_t nr_sectors =3D bdev_nr_sectors(bdev);
> >       struct f2fs_report_zones_args rep_zone_arg;
> >       u64 zone_sectors;
> > +     unsigned int max_open_zones;
> >       int ret;
> >
> >       if (!f2fs_sb_has_blkzoned(sbi))
> >               return 0;
> >
> > +     max_open_zones =3D bdev_max_open_zones(bdev);
>
> Wenjie,
>
> max_open_zones can always be zero? then sbi->max_open_zones will be zero,
> is this a valid case?
>
> Thanks,
>
> > +     if (max_open_zones && (max_open_zones < sbi->max_open_zones || !s=
bi->max_open_zones))
> > +             sbi->max_open_zones =3D max_open_zones;
> > +     if (sbi->max_open_zones && sbi->max_open_zones < F2FS_OPTION(sbi)=
active_logs) {
> > +             f2fs_err(sbi,
> > +                     "zoned: max open zones %u is too small, need at l=
east %u open zones",
> > +                              sbi->max_open_zones, F2FS_OPTION(sbi).ac=
tive_logs);
> > +             return -EINVAL;
> > +     }
> > +
> >       zone_sectors =3D bdev_zone_sectors(bdev);
> >       if (!is_power_of_2(zone_sectors)) {
> >               f2fs_err(sbi, "F2FS does not support non power of 2 zone =
sizes\n");


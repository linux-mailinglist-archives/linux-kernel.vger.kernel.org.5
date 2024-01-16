Return-Path: <linux-kernel+bounces-28370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC9D82FDAD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 00:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D187292D7B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8041E870;
	Tue, 16 Jan 2024 23:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPMZKA8Q"
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611E51E862
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 23:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705446753; cv=none; b=sahqmHlmNppDzXAhwPiCsS7YJ11lD0EqYRuJecAJ98RrJIa7CUJHyUZrN/k3ros/POhmPU73zGpEYybl1bDX7jM5EOGgazHx+b18cSTfdFHf7QNfYp1e1goAaag1RCQy22VSG78OEuk7lnhYg9vWfDsvsV29CTcrih6JQslo648=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705446753; c=relaxed/simple;
	bh=uLxVOquFjmDY4gS4eAhfDVhF7nq2o8dwLs69K+wYiKA=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=Lmom280lXnPWMYTVEqwa2MoKNhl/2gN3L8dltn/MyHGo2RhHGSbyi4PmtNvCWTxTrTMi9kL3EDoKO8LaB/SE1dvDnOPkcuLAvQqjacmxBuLCS+nUBIWAqTMaXdhYs1LFKPayV4Cep8lBxNuLlWhEu+lIh3RefH6A1EnrlxlxuQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPMZKA8Q; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-46771fc85cdso2008549137.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 15:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705446751; x=1706051551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JrCXnFeEnVjZwLJzqlTFvtVLNn2OtM0Ejf5cfJHCHUQ=;
        b=dPMZKA8Qmzev7qPhSZyIQ+ngtwR4CRIDdPPyJbxSR27V7IVowGyT+5MaSFEa3XA0bT
         8mfcPh6JR3zuUpstROEbie/z5GDNLDlztjGrRAamXr/bdErJK4fIJYgrM6YTyGkpe7Ol
         okjBawbCHRjzxzHS4bz5QIswtks4s14GzJoJeqKf+tbyOIdHOHkrCBpw/vBgCcfoWcZE
         EHVQn1bro7kFE3CuGo8CXvdycjOEVjimcy+qNQW3BsrPyjNq4n9K9acRWrnyLBD9n+FB
         OE0Syo77WoNun+BFrMBig60TbYYqkhp0trrG059QdgJTFtpKoQ/WrIU0f9nF5knbArni
         4nhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705446751; x=1706051551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JrCXnFeEnVjZwLJzqlTFvtVLNn2OtM0Ejf5cfJHCHUQ=;
        b=hrZihOWyl0OfmEZwkBHRQuwvGaIevnLBzkMveM4GP9bVoJb2BI+8zSqdzUdk5MRLjY
         DW4dZG4LsLabwAh0Ux6WNZ2SSJUAuj4dpkcuILUHZ7WEZOPTDOIj6zlubGRmgIfah9T5
         14ojKUJgiFcANEeCCk0d5bbsgypwopf6tDx9IS81n9psplQFxSYriCANrGz0rZBBW/ck
         WOzn4BNvEnuq4wrW5FVVC6LPaiigTlcrC6waXDc0HbDE1NvtEJ8D+NqFThATgwcgl4Tk
         cGGvj/uPeJIV2CCzlJdSq0cDbXSluyVnwbyxjdmq3Jvz8J8LeIAVw7LksZj6t/GTfYZ2
         CUdw==
X-Gm-Message-State: AOJu0YzNx2sMFm7gon1YXqRdtYTTtZ4DNyFnvxsR2HvUNDy67jA26IDH
	9hqmyDndRCU8nGvW052Ft/UZQw2Ao/bnVejo4ClL87U+zmc=
X-Google-Smtp-Source: AGHT+IFRaNgz6iaC46k9haS6qg82l2Z4/p+B907lQqSOoENGP4rrmZeWvU15EJWfV2ri9niW77owN97EogZakc9Ht/I=
X-Received: by 2002:a67:ef89:0:b0:467:ed18:56e2 with SMTP id
 r9-20020a67ef89000000b00467ed1856e2mr5671510vsp.7.1705446751000; Tue, 16 Jan
 2024 15:12:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116143422.1268-1-qwjhust@gmail.com> <CACOAw_zP_=w21p__X5hD8Br8tARLHozn5REA5maW8OU2M=AAhg@mail.gmail.com>
In-Reply-To: <CACOAw_zP_=w21p__X5hD8Br8tARLHozn5REA5maW8OU2M=AAhg@mail.gmail.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Tue, 16 Jan 2024 15:12:20 -0800
Message-ID: <CACOAw_wzP2emXE_Os-eutBp9L3QRCwsDWg+qt-pQEHto_BvFUw@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v1] f2fs: fix max open zone constraints
To: Wenjie Qi <qwjhust@gmail.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	hustqwj@hust.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 2:58=E2=80=AFPM Daeho Jeong <daeho43@gmail.com> wro=
te:
>
> On Tue, Jan 16, 2024 at 6:36=E2=80=AFAM Wenjie Qi <qwjhust@gmail.com> wro=
te:
> >
> > We can get the number of remaining available zone
> > resources by subtracting the number of active logs from
> > the number of max active zones of zoned devices. We can
> > use these available zone resources to reduce the number
> > of pending bio when switching zones.
> > If max active zones is 0, there is no limit.
> >
> > Signed-off-by: Wenjie Qi <qwjhust@gmail.com>
> > ---
> >  fs/f2fs/data.c  | 32 +++++++++++++++++++++++++-------
> >  fs/f2fs/f2fs.h  |  2 ++
> >  fs/f2fs/super.c | 11 +++++++++++
> >  3 files changed, 38 insertions(+), 7 deletions(-)
> >
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index dce8defdf4c7..0b62ca296074 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -392,6 +392,19 @@ static void f2fs_zone_write_end_io(struct bio *bio=
)
> >         complete(&io->zone_wait);
> >         f2fs_write_end_io(bio);
> >  }
> > +
> > +static void f2fs_zone_write_end_io_nowait(struct bio *bio)
> > +{
> > +#ifdef CONFIG_F2FS_IOSTAT
> > +       struct bio_iostat_ctx *iostat_ctx =3D bio->bi_private;
> > +       struct f2fs_sb_info *sbi =3D iostat_ctx->sbi;
> > +#else
> > +       struct f2fs_sb_info *sbi =3D (struct f2fs_sb_info *)bio->bi_pri=
vate;
> > +#endif
> > +
> > +       atomic_inc(&sbi->available_active_zones);
> > +       f2fs_write_end_io(bio);
> > +}
> >  #endif
>
> I don't think this works. Let's assume we start with 2
> available_active_zones and 4 active logs.
> How about 4 active logs reach at the end of the zones at the same time?

Sorry, I was confused. It would work. However, it might be a little clumsy.
How about using a data structure like a counting semaphore?
We can decrease it as we open a zone and increase it as we close a zone.

>
> >
> >  struct block_device *f2fs_target_device(struct f2fs_sb_info *sbi,
> > @@ -1085,14 +1098,19 @@ void f2fs_submit_page_write(struct f2fs_io_info=
 *fio)
> >                 goto next;
> >  out:
> >  #ifdef CONFIG_BLK_DEV_ZONED
> > -       if (f2fs_sb_has_blkzoned(sbi) && btype < META &&
> > +       if (f2fs_sb_has_blkzoned(sbi) && sbi->max_active_zones && btype=
 < META &&
> >                         is_end_zone_blkaddr(sbi, fio->new_blkaddr)) {
> > -               bio_get(io->bio);
> > -               reinit_completion(&io->zone_wait);
> > -               io->bi_private =3D io->bio->bi_private;
> > -               io->bio->bi_private =3D io;
> > -               io->bio->bi_end_io =3D f2fs_zone_write_end_io;
> > -               io->zone_pending_bio =3D io->bio;
> > +               if (!atomic_add_negative(-1, &sbi->available_active_zon=
es)) {
> > +                       io->bio->bi_end_io =3D f2fs_zone_write_end_io_n=
owait;
> > +               } else {
> > +                       atomic_inc(&sbi->available_active_zones);
> > +                       bio_get(io->bio);
> > +                       reinit_completion(&io->zone_wait);
> > +                       io->bi_private =3D io->bio->bi_private;
> > +                       io->bio->bi_private =3D io;
> > +                       io->bio->bi_end_io =3D f2fs_zone_write_end_io;
> > +                       io->zone_pending_bio =3D io->bio;
> > +               }
> >                 __submit_merged_bio(io);
> >         }
> >  #endif
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index 65294e3b0bef..2aade367ac66 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -1551,6 +1551,8 @@ struct f2fs_sb_info {
> >
> >  #ifdef CONFIG_BLK_DEV_ZONED
> >         unsigned int blocks_per_blkz;           /* F2FS blocks per zone=
 */
> > +       unsigned int max_active_zones;          /* max zone resources o=
f the zoned device */
> > +       atomic_t available_active_zones;        /* remaining zone resou=
rces for zone switch */
> >  #endif
> >
> >         /* for node-related operations */
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index 206d03c82d96..6711283ff187 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -2385,6 +2385,12 @@ static int f2fs_remount(struct super_block *sb, =
int *flags, char *data)
> >         if (err)
> >                 goto restore_opts;
> >
> > +#ifdef CONFIG_BLK_DEV_ZONED
> > +       if (sbi->max_active_zones)
> > +               atomic_set(&sbi->available_active_zones,
> > +                               sbi->max_active_zones - F2FS_OPTION(sbi=
).active_logs);
> > +#endif
> > +
> >         /* flush outstanding errors before changing fs state */
> >         flush_work(&sbi->s_error_work);
> >
> > @@ -3932,6 +3938,11 @@ static int init_blkz_info(struct f2fs_sb_info *s=
bi, int devi)
> >         if (!f2fs_sb_has_blkzoned(sbi))
> >                 return 0;
> >
> > +       sbi->max_active_zones =3D bdev_max_active_zones(bdev);
> > +       if (sbi->max_active_zones)
> > +               atomic_set(&sbi->available_active_zones,
> > +                               sbi->max_active_zones - F2FS_OPTION(sbi=
).active_logs);
> > +
>
> Need to make available_active_zones not be negative, right?
> Hmm, need to make sure active_logs should be equal or less than
> max_active_zones.
>
> >         zone_sectors =3D bdev_zone_sectors(bdev);
> >         if (!is_power_of_2(zone_sectors)) {
> >                 f2fs_err(sbi, "F2FS does not support non power of 2 zon=
e sizes\n");
> > --
> > 2.34.1
> >
> >
> >
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


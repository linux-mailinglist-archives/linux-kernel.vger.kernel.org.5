Return-Path: <linux-kernel+bounces-51383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DAD848AB0
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 03:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A36861F21BF9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 02:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98F24416;
	Sun,  4 Feb 2024 02:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHQo8mQs"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9055617E9
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 02:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707014188; cv=none; b=MItoMFriS2vysXTPs+ZzkDTvtiPQVIeEvIRzCcQzYyRyJ1H838DNMa3lux7ZJAkG63Q+M0aGaGaR4ZOEcyVX231zSi3ZsnU7/PxAF2n2/D1NXs+QAWujuLp7r98LHdBYCJr9nQqrZ5CVJ7Ux0bvuOcyj2EUz0IRWWe/nugfUH84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707014188; c=relaxed/simple;
	bh=6ToYzSO6TT7iwbrqbulGLZgBo4gu0uLL3DZP2uBKrFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FFZqqMN7PmybDAtcj3AUvDBG0mF8bg4evWS6qUADX5htwsWxR11TsPuidL0S78lfWzDO2KoINMJQVGMPEkp0yH1sOpuRUfb6vHHYqNnfC7ES/Ns5IkvFR4QaZWfBjrE1BhAjPHZF1Hdwik7teHsUQYFyJEVx+nZN1RjUhCnL1LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHQo8mQs; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-42a9f4935a6so34445751cf.1
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 18:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707014185; x=1707618985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIWdLIt7qWx0iRk6mguZcbqKY6VxYqeUlneCozypm+c=;
        b=SHQo8mQsVl6Vs5/1aRXQhwMbq4rW5YDTfm5dThdAH2P6ezKR0RSqLMPW1dOcx9JLb/
         0M4LOZae4z2lTlmpIDUmv8f4PUnVHKK3R75wTL2xMdnTp0/XxFAklSh8VGi7xCP0BLV+
         FIfNK/9UNEuKnkcUQ1NIusxighhBb4U1/ehezIHyPTY5Px5EppjkdWvuPTJj3Y2ptQEk
         eGMKlrSrD8/+UMWt9KHeAyOLXGOVXzpwiY7CvDPzia6GS7dmmiVlN6nyg5ie7wNvMqTf
         Dic1My7AdRwvbGIxL8bE+2ISOk6/ksd4WdtVEj5jAOIBBEtGo4GWe4jpxvCMlClzYXA6
         6nbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707014185; x=1707618985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RIWdLIt7qWx0iRk6mguZcbqKY6VxYqeUlneCozypm+c=;
        b=PEIgvUP5zmPw+6Apx0yfN6O2WVcOFpCeaVtvBxbtus3ZEYX1+9TLPWDCbVZTbMVj57
         WTDKd1kas+3LAJUcz1zET2uqgYJntEPoQHd05t6cMaCqvyjKfBFzfAhX5onjLZ8Sv5VT
         RVXioMe7d8AwPn5/ffCmW7JAVxd0p42denZOxOEVuatcxA4uPpvKP1LyRvFcURCcQVOZ
         wmpSf2251DR8+MmIkiTCWTuBJmE43H/5kCj8KDohM1JBqMLoDQGsXG7fh/BJX8yUZnaq
         8lAu0A9DMQjxtoMOlZ8R//j/K+jz+1w2yMVw2PzCkacOp7xjxOxvu9FHyaSh5jkxjX8F
         bZuA==
X-Gm-Message-State: AOJu0Yw66urhvfOF4SMiBLV2ZVcGmyk3bAuDC5Peb0haQ9CwKttDgAQL
	k9agaMohiPHtvNlmlx9D+8RXWrRuYs+OfvDBb0a2XwdtcYeeBipkKlllUXUIGAK3e9VGcfmzxD4
	mezUPJaXE/o5bzBhTL6zP4fL0uXw=
X-Google-Smtp-Source: AGHT+IEjJ9y3U2Ef+W/FHH+YiCml0EuxG95JG5fpys3Qlvv5Ss+R20O5FEwzmAf30txXd/gPfkascUfcI44ihb+b1l0=
X-Received: by 2002:ac8:568c:0:b0:42c:1492:68ef with SMTP id
 h12-20020ac8568c000000b0042c149268efmr3103068qta.9.1707014185357; Sat, 03 Feb
 2024 18:36:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240203152436.1352-1-qwjhust@gmail.com> <8eaf59a4-1aaa-460e-a3cc-b798ed5e0f63@kernel.org>
 <CAGFpFsTz_9Zaj0PuptjBxOJwxF68geAUfd1qtx9--Tczh+jZww@mail.gmail.com> <e42ae14e-88b8-41de-9693-1513bf335fc2@kernel.org>
In-Reply-To: <e42ae14e-88b8-41de-9693-1513bf335fc2@kernel.org>
From: Wenjie Qi <qwjhust@gmail.com>
Date: Sun, 4 Feb 2024 10:36:15 +0800
Message-ID: <CAGFpFsTwH8S5QsDCd5hqS+WNNr4ZZPJ2FuPFLRWzkVCqfjxiQQ@mail.gmail.com>
Subject: Re: [PATCH v4] f2fs: fix zoned block device information initialization
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, yangyongpeng1@oppo.com, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	hustqwj@hust.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I agree with you, it looks a bit more intuitive that way.
I'll submit a new version of the patch as soon as I can.
Thanks,

On Sun, Feb 4, 2024 at 10:24=E2=80=AFAM Chao Yu <chao@kernel.org> wrote:
>
> On 2024/2/4 10:18, Wenjie Qi wrote:
> > Hi Chao,
> >
> > It seems to me that when mounting multiple zoned devices,
> > if their max_open_zones are all 0, then sbi->max_open_zones is 0.
> > This suggests that all of the mounted devices can open an unlimited
> > number of zones,
> > and that we don't need to compare sbi->max_open_zones with
> > F2FS_OPTION( sbi).active_logs.
>
> Yes, but I'm curious about how this case (sbi->max_open_zones is zero)
> works w/ following patch, do we need to initialized sbi->max_open_zones
> w/ UINT_MAX to indicate the unlimited open zone status of device if
> all zoned devices' max_open_zones is zero?
>
> >
> > Thanks,
> >
> > Chao Yu <chao@kernel.org> =E4=BA=8E2024=E5=B9=B42=E6=9C=884=E6=97=A5=E5=
=91=A8=E6=97=A5 09:47=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On 2024/2/3 23:24, Wenjie Qi wrote:
> >>> If the max open zones of zoned devices are less than
> >>> the active logs of F2FS, the device may error due to
> >>> insufficient zone resources when multiple active logs are
> >>> being written at the same time. If this value is 0,
> >>> there is no limit.
> >>>
> >>> Signed-off-by: Wenjie Qi <qwjhust@gmail.com>
> >>> ---
> >>>    fs/f2fs/f2fs.h  |  1 +
> >>>    fs/f2fs/super.c | 21 +++++++++++++++++++++
> >>>    2 files changed, 22 insertions(+)
> >>>
> >>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> >>> index 543898482f8b..161107f2d3bd 100644
> >>> --- a/fs/f2fs/f2fs.h
> >>> +++ b/fs/f2fs/f2fs.h
> >>> @@ -1558,6 +1558,7 @@ struct f2fs_sb_info {
> >>>
> >>>    #ifdef CONFIG_BLK_DEV_ZONED
> >>>        unsigned int blocks_per_blkz;           /* F2FS blocks per zon=
e */
> >>> +     unsigned int max_open_zones;            /* max open zone resour=
ces of the zoned device */
> >>>    #endif
> >>>
> >>>        /* for node-related operations */
> >>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> >>> index 1b718bebfaa1..45e82d6016fc 100644
> >>> --- a/fs/f2fs/super.c
> >>> +++ b/fs/f2fs/super.c
> >>> @@ -2388,6 +2388,16 @@ static int f2fs_remount(struct super_block *sb=
, int *flags, char *data)
> >>>        if (err)
> >>>                goto restore_opts;
> >>>
> >>> +#ifdef CONFIG_BLK_DEV_ZONED
> >>> +     if (sbi->max_open_zones && sbi->max_open_zones < F2FS_OPTION(sb=
i).active_logs) {
> >>> +             f2fs_err(sbi,
> >>> +                     "zoned: max open zones %u is too small, need at=
 least %u open zones",
> >>> +                              sbi->max_open_zones, F2FS_OPTION(sbi).=
active_logs);
> >>> +             err =3D -EINVAL;
> >>> +             goto restore_opts;
> >>> +     }
> >>> +#endif
> >>> +
> >>>        /* flush outstanding errors before changing fs state */
> >>>        flush_work(&sbi->s_error_work);
> >>>
> >>> @@ -3930,11 +3940,22 @@ static int init_blkz_info(struct f2fs_sb_info=
 *sbi, int devi)
> >>>        sector_t nr_sectors =3D bdev_nr_sectors(bdev);
> >>>        struct f2fs_report_zones_args rep_zone_arg;
> >>>        u64 zone_sectors;
> >>> +     unsigned int max_open_zones;
> >>>        int ret;
> >>>
> >>>        if (!f2fs_sb_has_blkzoned(sbi))
> >>>                return 0;
> >>>
> >>> +     max_open_zones =3D bdev_max_open_zones(bdev);
> >>
> >> Wenjie,
> >>
> >> max_open_zones can always be zero? then sbi->max_open_zones will be ze=
ro,
> >> is this a valid case?
> >>
> >> Thanks,
> >>
> >>> +     if (max_open_zones && (max_open_zones < sbi->max_open_zones || =
!sbi->max_open_zones))
> >>> +             sbi->max_open_zones =3D max_open_zones;
> >>> +     if (sbi->max_open_zones && sbi->max_open_zones < F2FS_OPTION(sb=
i).active_logs) {
> >>> +             f2fs_err(sbi,
> >>> +                     "zoned: max open zones %u is too small, need at=
 least %u open zones",
> >>> +                              sbi->max_open_zones, F2FS_OPTION(sbi).=
active_logs);
> >>> +             return -EINVAL;
> >>> +     }
> >>> +
> >>>        zone_sectors =3D bdev_zone_sectors(bdev);
> >>>        if (!is_power_of_2(zone_sectors)) {
> >>>                f2fs_err(sbi, "F2FS does not support non power of 2 zo=
ne sizes\n");


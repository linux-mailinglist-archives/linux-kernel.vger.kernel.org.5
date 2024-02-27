Return-Path: <linux-kernel+bounces-82709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B74868866
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 05:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E8F71F22263
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8DD52F79;
	Tue, 27 Feb 2024 04:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h6ExSm/S"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A3151C5B
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 04:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709009382; cv=none; b=dXn1Rxsvi0DEABn68JjKhW749SGVzwTAWSGG+DLAUqbqe+MMQw9Pmhp8HJZfJ0DzPZdBR2Y0zE0P4IAQAi7MpHJMki395QwGkaTwVDe13Pvvg0rYyxAr8dzDDhJ3bF783YGBk5jPurovQsWWtcty4SLgQQBMWQ0/IXJP+QQHuuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709009382; c=relaxed/simple;
	bh=FuHYOldpPnqbaKrdQRI+3loAuTSXbdWRUieVFpn6n6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NWhdNKLKrWj4Hpm4uTzbHEm3xQsdSwuwlHDkWuKtjcbbTR571CMDltWupZpdZNJ17XDgoCt/YDTca7nUobJhzieP4euGmqyPoXhnPAAJcEwNFDUzYkuJ3SRn31JX1Jcp2oJsXpRGrkotA8+o4gj5h6mr2UF29WOrB1j6siwwn7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h6ExSm/S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709009379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w/eq9c918teT3asFeHzf8cTm6jZIDfMNRa5Rd6esSYg=;
	b=h6ExSm/SFwtRrLNw1Pc20mQt/c83XeUYFLS6i8C/SSk2912oRgBN9T6kfM06IyPw40jGEx
	Y45GQsAxwUAy/IBduU/zbrvyP8ggIeAuxktpS+3mg6JrnrXsA/q/7bXnxvZvFpJFal4zmx
	YhvlT2nzL6lv/229D2dLKg4kkIoZ4H8=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-xmhmA6uMM227UzaBKMwr5g-1; Mon, 26 Feb 2024 23:49:15 -0500
X-MC-Unique: xmhmA6uMM227UzaBKMwr5g-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1dc6b99b045so21736055ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 20:49:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709009354; x=1709614154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/eq9c918teT3asFeHzf8cTm6jZIDfMNRa5Rd6esSYg=;
        b=xFjbKPsjCnY36Ml+niD3irwOW1+xfibNYhkTk8vI0K82Frmv3h/JggXtdB30NCvwpX
         Yk5z3q2QAsARbe1C2fn3ZKQCQ8ay/fNo5TqcCfB4qYBWqp78r/FuobTQPzJQN0IxfZ1V
         bSjwEM09J+WkuraB3flcVSq3gKIh8hWnHQXuBAcpAiQ0peARSitXD+aP6N9bOwtMzR5K
         bUCPBRJFPrjyFtnMD3rEEZNRnE09BCIcyJfL9XKF1VesXfi1j39ScJqIEb/qnNAC1ZFz
         pmKmkmyu5kXQPU7Md+W1481gUbnm6K3LbW5xS2Ht2mEjYg0ygrV6nAnXdmIIVzA43KJU
         SOmA==
X-Forwarded-Encrypted: i=1; AJvYcCV+ifXRJrBK3tuqeewpOvgSV5VlSLGhcb9YfkgtDa3xr95XN6QYSU92HB97GeZ4SyS6rxC5ZwXGF8fggXDLps0++33I01xSDuklaned
X-Gm-Message-State: AOJu0YxJh8+R+5Jz9AgfX5UKvXjwV90QeU8Q+yF20mueEvnGkuFw4y4S
	qVDdLuDGIGVrp7UmJp6IU4WDpdIBffgbbPoyqKSvT8JMqEX8b3Yk/x8yHmk9U67b5L19/PGQC7G
	4Dd0mOFAHUpZgPv8b4lUxwbpCcabhVzAtDdROTePqX98EUZjutBJzqtebN8mSJ7BHjWdUd7nFAN
	ouekmqescl7GsoC0CP2DvxHwV9SV+NetBjXYlD
X-Received: by 2002:a17:902:c404:b0:1d7:836d:7b3f with SMTP id k4-20020a170902c40400b001d7836d7b3fmr12471168plk.9.1709009354661;
        Mon, 26 Feb 2024 20:49:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcQHKqVXo0WXICXk9+Xsnh8f59Fw9GO8bR1Tyz59KHSKC2XmtaJOO764mlIcroPKV+fGliO39IJ8JdCQit7ZQ=
X-Received: by 2002:a17:902:c404:b0:1d7:836d:7b3f with SMTP id
 k4-20020a170902c40400b001d7836d7b3fmr12471157plk.9.1709009354330; Mon, 26 Feb
 2024 20:49:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222075806.1816400-1-yukuai1@huaweicloud.com>
 <20240222075806.1816400-4-yukuai1@huaweicloud.com> <CALTww28PJPdqRkSEarwATG5GmkuMmEtT0La5s-9c9r5UPy4siA@mail.gmail.com>
 <6114e6f5-87a6-216e-027d-cbb0a7e8e429@huaweicloud.com>
In-Reply-To: <6114e6f5-87a6-216e-027d-cbb0a7e8e429@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
Date: Tue, 27 Feb 2024 12:49:03 +0800
Message-ID: <CALTww2_iPFJiX17ORbN2+ssdYWVk0=M4pCgJDoWh_-jJPn0bRA@mail.gmail.com>
Subject: Re: [PATCH md-6.9 03/10] md/raid1: fix choose next idle in read_balance()
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: paul.e.luse@linux.intel.com, song@kernel.org, neilb@suse.com, shli@fb.com, 
	linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 10:38=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> =
wrote:
>
> Hi,
>
> =E5=9C=A8 2024/02/27 10:23, Xiao Ni =E5=86=99=E9=81=93:
> > On Thu, Feb 22, 2024 at 4:04=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.co=
m> wrote:
> >>
> >> From: Yu Kuai <yukuai3@huawei.com>
> >>
> >> Commit 12cee5a8a29e ("md/raid1: prevent merging too large request") ad=
d
> >> the case choose next idle in read_balance():
> >>
> >> read_balance:
> >>   for_each_rdev
> >>    if(next_seq_sect =3D=3D this_sector || disk =3D=3D 0)
> >>    -> sequential reads
> >>     best_disk =3D disk;
> >>     if (...)
> >>      choose_next_idle =3D 1
> >>      continue;
> >>
> >>   for_each_rdev
> >>   -> iterate next rdev
> >>    if (pending =3D=3D 0)
> >>     best_disk =3D disk;
> >>     -> choose the next idle disk
> >>     break;
> >>
> >>    if (choose_next_idle)
> >>     -> keep using this rdev if there are no other idle disk
> >>     contine
> >>
> >> However, commit 2e52d449bcec ("md/raid1: add failfast handling for rea=
ds.")
> >> remove the code:
> >>
> >> -               /* If device is idle, use it */
> >> -               if (pending =3D=3D 0) {
> >> -                       best_disk =3D disk;
> >> -                       break;
> >> -               }
> >>
> >> Hence choose next idle will never work now, fix this problem by
> >> following:
> >>
> >> 1) don't set best_disk in this case, read_balance() will choose the be=
st
> >>     disk after iterating all the disks;
> >> 2) add 'pending' so that other idle disk will be chosen;
> >> 3) set 'dist' to 0 so that if there is no other idle disk, and all dis=
ks
> >>     are rotational, this disk will still be chosen;
> >>
> >> Fixes: 2e52d449bcec ("md/raid1: add failfast handling for reads.")
> >> Co-developed-by: Paul Luse <paul.e.luse@linux.intel.com>
> >> Signed-off-by: Paul Luse <paul.e.luse@linux.intel.com>
> >> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> >> ---
> >>   drivers/md/raid1.c | 21 ++++++++++++---------
> >>   1 file changed, 12 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> >> index c60ea58ae8c5..d0bc67e6d068 100644
> >> --- a/drivers/md/raid1.c
> >> +++ b/drivers/md/raid1.c
> >> @@ -604,7 +604,6 @@ static int read_balance(struct r1conf *conf, struc=
t r1bio *r1_bio, int *max_sect
> >>          unsigned int min_pending;
> >>          struct md_rdev *rdev;
> >>          int choose_first;
> >> -       int choose_next_idle;
> >>
> >>          /*
> >>           * Check if we can balance. We can balance on the whole
> >> @@ -619,7 +618,6 @@ static int read_balance(struct r1conf *conf, struc=
t r1bio *r1_bio, int *max_sect
> >>          best_pending_disk =3D -1;
> >>          min_pending =3D UINT_MAX;
> >>          best_good_sectors =3D 0;
> >> -       choose_next_idle =3D 0;
> >>          clear_bit(R1BIO_FailFast, &r1_bio->state);
> >>
> >>          if ((conf->mddev->recovery_cp < this_sector + sectors) ||
> >> @@ -712,7 +710,6 @@ static int read_balance(struct r1conf *conf, struc=
t r1bio *r1_bio, int *max_sect
> >>                          int opt_iosize =3D bdev_io_opt(rdev->bdev) >>=
 9;
> >>                          struct raid1_info *mirror =3D &conf->mirrors[=
disk];
> >>
> >> -                       best_disk =3D disk;
> >>                          /*
> >>                           * If buffered sequential IO size exceeds opt=
imal
> >>                           * iosize, check if there is idle disk. If ye=
s, choose
> >> @@ -731,15 +728,21 @@ static int read_balance(struct r1conf *conf, str=
uct r1bio *r1_bio, int *max_sect
> >>                              mirror->next_seq_sect > opt_iosize &&
> >>                              mirror->next_seq_sect - opt_iosize >=3D
> >>                              mirror->seq_start) {
> >> -                               choose_next_idle =3D 1;
> >> -                               continue;
> >> +                               /*
> >> +                                * Add 'pending' to avoid choosing thi=
s disk if
> >> +                                * there is other idle disk.
> >> +                                * Set 'dist' to 0, so that if there i=
s no other
> >> +                                * idle disk and all disks are rotatio=
nal, this
> >> +                                * disk will still be chosen.
> >> +                                */
> >> +                               pending++;
> >> +                               dist =3D 0;
> >> +                       } else {
> >> +                               best_disk =3D disk;
> >> +                               break;
> >>                          }
> >> -                       break;
> >>                  }
> >
> > Hi Kuai
> >
> > I noticed something. In patch 12cee5a8a29e, it sets best_disk if it's
> > a sequential read. If there are no other idle disks, it will read from
> > the sequential disk. With this patch, it reads from the
> > best_pending_disk even min_pending is not 0. It looks like a wrong
> > behaviour?
>
> Yes, nice catch, I didn't notice this yet... So there is a hidden
> logical, sequential IO priority is higher than minimal 'pending'
> selection, it's only less than 'choose_next_idle' where idle disk
> exist.

Yes.


>
> Looks like if we want to keep this behaviour, we can add a 'sequential
> disk':
>
> if (is_sequential())
>   if (!should_choose_next())
>    return disk;
>   ctl.sequential_disk =3D disk;
>
> ...
>
> if (ctl.min_pending !=3D 0 && ctl.sequential_disk !=3D -1)
>   return ctl.sequential_disk;

Agree with this, thanks :)

Best Regards
Xiao
>
> Thanks,
> Kuai
>
> >
> > Best Regards
> > Xiao
> >>
> >> -               if (choose_next_idle)
> >> -                       continue;
> >> -
> >>                  if (min_pending > pending) {
> >>                          min_pending =3D pending;
> >>                          best_pending_disk =3D disk;
> >> --
> >> 2.39.2
> >>
> >>
> >
> > .
> >
>



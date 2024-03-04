Return-Path: <linux-kernel+bounces-90015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F316186F8E9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 04:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA8972814B5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 03:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5397D4696;
	Mon,  4 Mar 2024 03:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfvpaLtt"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1D42F35
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 03:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709523197; cv=none; b=u0AfpWeDk6oIB+QUtZ27DFgLxLnbtM9f/0fuaSL/VizkJDnLHG7osxrII/I77GL5pUAqTbYGgYrXokn1HxcoAb0gHZpCubbKD8Qq5U+rpw/rcoWncIiomMRkMFnZjSWyOSZvViXrciqowl/kEGvQczX1BCEfzUVYiCk1ZQLBHUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709523197; c=relaxed/simple;
	bh=Z3a+J4afS0p+nxEqzHjSjJeaMq1vLrM6lKfKvJ91f+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V6J2KgxKTlXh40zZtelDsgr84zQBu3BHJdnghRbxDPLdpoKZ3r7RRLcx67P7QFFKebqWb0aMe9awJGM40RZD2RDwOwbr9SUtXsat6jgz5EKBYMMOeQB+9C/2TwDt8UXwnR6Mxki1mt74T+lawLKAWm9pNlnyXpwG+nyv+Ud58Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfvpaLtt; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56454c695e6so6623138a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 19:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709523194; x=1710127994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXzQeUxGWlBH373XqQNyUnK789ftXqphQPOVNjBeEBo=;
        b=FfvpaLttzy3MHCP2+nwRxUxFlsfduIBzOOPeVMOSkcUogC1z8y1sACqD+v9zXyPzAf
         5/HOtzqEm82edLHotVyN+MmGmNRtwxxDOjXgiAGJwQoxHYAtvNx3ZMUxnXkwOwVxt1zW
         Ty3i+p3UsGEOJ4cN9L2SRKvVdgiQ2b+rGfTLSKUTcN5Nfg8C+FqxvXcSWC2sQJXZ/sme
         IL9P1sCs8e4gSmbfcwR0WJX4sZrMNWg957doHuGZgKFg0h7vS79tBX0oEDtA9SRREB1C
         D3AHXP2aLAYe50HlgwWAcY5G1rlhVPi69UdQSSbC/8oLRcPaiEoclGSH/p38jWcMc4QK
         EyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709523194; x=1710127994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LXzQeUxGWlBH373XqQNyUnK789ftXqphQPOVNjBeEBo=;
        b=iiv7oyIhfvaftrD3WKHQqmq6Ik8eC/LpekKZLIkgabs/uAQGB7E+OlYUf96aP1na3+
         LSkb5NO5WY+ylkXpsSzC6uNySFOgdLLkfx+hzqJvhfaKcSMAPNEd/S7k7NmjptygOw9m
         Mk67G5Xaz1xPWmezKWLo0heu4cgZrSnqPCsiTwCJfbUpyQ/dlpzga7RxXr5HFQ9gaUqH
         l/CHTY+T5DbAiTOYkw5Eft0KaKxlhlJxrrmhq3EHAZpJgZjSjKW9aWfUWUb+C7k80QSm
         zYbpgHxiKGTrKjs0yb9wkMa2YwP/kzYDs2stgnNMRnVvUkc3K/p9EbJmJJCgsRUJUUv7
         Kkkg==
X-Forwarded-Encrypted: i=1; AJvYcCU8AZkrUvVsOtTeXUDDh1fXI44UxL2zT18MrjG3jXcgehKdvrqW+8EIo0eBkL74cH5d81C8uQ37j7wA9sKdgKJULYnCdQJmWb8FJBwj
X-Gm-Message-State: AOJu0YyTLenCFiRs2HlO2svehXO99Lk5j2gZh+7rkj9kZYzHTbq+RoLt
	0PmbnjEKWOvIkGFzw7dc8zVBKiaSkGcCyIaW03gp6lbV8exHn1ixVC8dVq2O2uU2ZTVeMklnC4s
	mZ9JbCIhZGITXeIIVEclBTaBrKd1TGCYNuuCL5w==
X-Google-Smtp-Source: AGHT+IGz17seY6e3eCF7vnfl/hLXBedWth7fLNremT2TxQNnVfPVBrGM5Yn9Oe2DilkB1RlOTX6QmqJoOTapi29PXCQ=
X-Received: by 2002:aa7:d517:0:b0:566:78ff:b24e with SMTP id
 y23-20020aa7d517000000b0056678ffb24emr7172003edq.17.1709523193979; Sun, 03
 Mar 2024 19:33:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1709292976-13118-1-git-send-email-zhiguo.niu@unisoc.com> <7dc371ad-2448-4dd4-9551-8caef0a00d48@kernel.org>
In-Reply-To: <7dc371ad-2448-4dd4-9551-8caef0a00d48@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Mon, 4 Mar 2024 11:33:02 +0800
Message-ID: <CAHJ8P3+ZBuBu9Sdpm_6fxhY2sVyu97dXFKKLdtEF4shi_3Fs1Q@mail.gmail.com>
Subject: Re: [PATCH] f2fs: fix to check result of new_curseg in f2fs_allocate_segment_for_resize
To: Chao Yu <chao@kernel.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com, hongyu.jin@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 11:19=E2=80=AFAM Chao Yu <chao@kernel.org> wrote:
>
> On 2024/3/1 19:36, Zhiguo Niu wrote:
> > new_curseg may return error if get_new_segment fail, so its result
> > should be check in its caller f2fs_allocate_segment_for_resize,
> > alos pass this results to free_segment_range.
>
> Zhiguo,
>
> What about handling all error paths of new_curseg() and change_curseg()
> in one patch?
Dear Chao,

Do you mean to merge it with the previous patch =E2=80=9Cf2fs: fix to check
return value of f2fs_gc_range=E2=80=9D?
Because in addition to new_curseg/change_curseg error handling, there
are some other changes in the previous patch.
besides, I searched for new related codes, and there should be the
only place left without error handling about new_curseg/
change_curseg .

thanks!
>
> Thanks,
>
> >
> > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > ---
> >   fs/f2fs/f2fs.h    | 2 +-
> >   fs/f2fs/gc.c      | 7 +++++--
> >   fs/f2fs/segment.c | 9 +++++++--
> >   3 files changed, 13 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index 4331012..39dda7d 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -3701,7 +3701,7 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_i=
nfo *sbi,
> >   void f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi);
> >   void f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi);
> >   void f2fs_restore_inmem_curseg(struct f2fs_sb_info *sbi);
> > -void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int ty=
pe,
> > +int f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int typ=
e,
> >                                       unsigned int start, unsigned int =
end);
> >   int f2fs_allocate_new_section(struct f2fs_sb_info *sbi, int type, boo=
l force);
> >   int f2fs_allocate_pinning_section(struct f2fs_sb_info *sbi);
> > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > index c60b747..7a458fa 100644
> > --- a/fs/f2fs/gc.c
> > +++ b/fs/f2fs/gc.c
> > @@ -2037,8 +2037,11 @@ static int free_segment_range(struct f2fs_sb_inf=
o *sbi,
> >       mutex_unlock(&DIRTY_I(sbi)->seglist_lock);
> >
> >       /* Move out cursegs from the target range */
> > -     for (type =3D CURSEG_HOT_DATA; type < NR_CURSEG_PERSIST_TYPE; typ=
e++)
> > -             f2fs_allocate_segment_for_resize(sbi, type, start, end);
> > +     for (type =3D CURSEG_HOT_DATA; type < NR_CURSEG_PERSIST_TYPE; typ=
e++) {
> > +             err =3D f2fs_allocate_segment_for_resize(sbi, type, start=
, end);
> > +             if (err)
> > +                     goto out;
> > +     }
> >
> >       /* do GC to move out valid blocks in the range */
> >       err =3D f2fs_gc_range(sbi, start, end, dry_run, 0);
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index 1bb3019..2a07b9d 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -3071,11 +3071,12 @@ static bool need_new_seg(struct f2fs_sb_info *s=
bi, int type)
> >       return false;
> >   }
> >
> > -void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int ty=
pe,
> > +int f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int typ=
e,
> >                                       unsigned int start, unsigned int =
end)
> >   {
> >       struct curseg_info *curseg =3D CURSEG_I(sbi, type);
> >       unsigned int segno;
> > +     int err =3D 0;
> >
> >       f2fs_down_read(&SM_I(sbi)->curseg_lock);
> >       mutex_lock(&curseg->curseg_mutex);
> > @@ -3089,7 +3090,10 @@ void f2fs_allocate_segment_for_resize(struct f2f=
s_sb_info *sbi, int type,
> >               change_curseg(sbi, type);
> >       else
> >               new_curseg(sbi, type, true);
> > -
> > +     if (curseg->segno =3D=3D NULL_SEGNO) {
> > +             err =3D -ENOSPC;
> > +             goto unlock;
> > +     }
> >       stat_inc_seg_type(sbi, curseg);
> >
> >       locate_dirty_segment(sbi, segno);
> > @@ -3102,6 +3106,7 @@ void f2fs_allocate_segment_for_resize(struct f2fs=
_sb_info *sbi, int type,
> >
> >       mutex_unlock(&curseg->curseg_mutex);
> >       f2fs_up_read(&SM_I(sbi)->curseg_lock);
> > +     return err;
> >   }
> >
> >   static int __allocate_new_segment(struct f2fs_sb_info *sbi, int type,


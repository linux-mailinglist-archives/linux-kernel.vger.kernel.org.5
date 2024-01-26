Return-Path: <linux-kernel+bounces-40478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D5B83E12A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54A3D1C22649
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC58520DF7;
	Fri, 26 Jan 2024 18:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWoZ/737"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F721EB5E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 18:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706293055; cv=none; b=Ilex9a5S2nAYtg57hqtdSf+p7F3mbcJPG+b4V8oKeMYYfpHNzXNUCxAH2L+oZdz3hCXhH973LrlnLSjkRT9SRkRKDq8lhSJlfVOAOgjaqwPp37EQ6Elj0zO/SusGI70Dxk1ePWK9XHV6ZY3YznjBb356nbflNjhtbkcrzwXWmXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706293055; c=relaxed/simple;
	bh=gxpvoRT0NBeaKaFOtAJ5db69+lOmBO9bDH01CtCgoSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ua1s4M0xeI+u+mIC95f98zRWK21ThufHAwnVBypJ5HGEJPo+RoD/2RBoCh7STla/lmVcKAwMdH7eKR6IT51TBk1Ygc9/r4AYxnnMXTdfRI7+vhoSF4C/3a5smA4X59TZeEY5CL/10LZOvJw8HxRWK4CszSr027CxtotjNFYiuzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWoZ/737; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7cecc0a662dso234731241.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 10:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706293043; x=1706897843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDzPmeQkHrpI5XFKI2TgWRa68Bt+XbqFDvv7zmvmDME=;
        b=AWoZ/737aBYy2b4x/fVwvn4Cs5zCFueM3eFWClDcagConhLcSfWv81fz6dMRoeuUvk
         a5hl+AvtU9i7fFGpk9Dh0QHnxdRsMyYC49kTkLcLuEWXJw716l4CapJmL8uug3qLHeaH
         R6QjccS9gwJWepmVis3LYy0u/8zWTISYTp4urQzb4IQbCZPkDEGJDKxQIR4jW5jArlLD
         Q7LRoELOEx7Ker/tvglFJ/KqQiWAp4+86c646df3q5qegHccyKrQgMF5/AbIcToN1PM0
         3MaLJelEDqQhYMojfWYg1mcxFWGEEUMqteP1i5OnsOkkg4kmmszeQNCeAZ/kap5ZHP/T
         CTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706293043; x=1706897843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KDzPmeQkHrpI5XFKI2TgWRa68Bt+XbqFDvv7zmvmDME=;
        b=E/xRa1VZPUmon2jJ5y6tE5vymPNnHXgEfivjrZG0Aw+JOASlODEESXRIsLVuGU/Hbm
         62lwlKV18cgrwE1QSHavPPhXuF2Pm1c27SAqLFpTaY7nqQMZeFOxTo9E2HeOChqOpztm
         V7UQ2YTYKpOTMhmwjHTm+WSY6VU+6jlPHKo4l4BLa1RFo/0hwYMOGM/ptJV3sFbTu27B
         pjcqxpqgIjRiOhG7ZE8TSwLDp7GqQyBfJYEgOo3YL5XzM6XEZwzg9/X5SdAiplL8mck0
         T+Qmkr0kR7AuY4FC6uz2S7wJ4m6yYJV/ktikY+hb1BPx6NhLgw9Z3BkXUjhX16gZgMQT
         d//Q==
X-Gm-Message-State: AOJu0YxqHNHlFYAt7B4ELyi1G0aPMTo8ep+N5Sv414dWffICsOmVWKFy
	lPtZvKl7ALnjFIBAIo3yQUD8u2FKZrgY93765mgoMKird1bGtsnyk83OTcNCjPxgrA2TcX1XWlF
	aofwBOYVAw6dZyT5wQYpotWIA2Uo=
X-Google-Smtp-Source: AGHT+IFY1bvX/lr35a97PlGA5IQKTrRHO4kPzqY+aCB5bHdtUoZm/oqZm9/8L8J5IvINAVxo4QmfJBW9pqWop3YX7hg=
X-Received: by 2002:a05:6122:905:b0:4b6:d44e:2897 with SMTP id
 j5-20020a056122090500b004b6d44e2897mr184702vka.33.1706293043136; Fri, 26 Jan
 2024 10:17:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117230032.2312067-1-daeho43@gmail.com> <df9645d9-1e9a-4bd2-88bb-26425cf45811@kernel.org>
 <CACOAw_yjEuGSvo_qyoA13U0HwOr3gOzGtNf2Twhes01SNSGQeg@mail.gmail.com> <b18c286a-cc72-439c-b373-98e0d6504618@kernel.org>
In-Reply-To: <b18c286a-cc72-439c-b373-98e0d6504618@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Fri, 26 Jan 2024 10:17:12 -0800
Message-ID: <CACOAw_yqrtEhq4wtJbs7CVn260h7iZyC7koCWH1iMyeQo5140g@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs-tools: allocate logs after conventional
 area for HM zoned devices
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	kernel-team@android.com, Daeho Jeong <daehojeong@google.com>, 
	Yongpeng Yang <yangyongpeng1@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 5:27=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> On 2024/1/26 0:25, Daeho Jeong wrote:
> > On Wed, Jan 24, 2024 at 7:34=E2=80=AFPM Chao Yu <chao@kernel.org> wrote=
:
> >>
> >> +Cc Yongpeng Yang
> >>
> >> Daeho,
> >>
> >> Yongpeng reports a potential issue: if c.devices[0].total_segments is
> >> larger than segments of mainarea, c.cur_seg[CURSEG_HOT_NODE] will exce=
ed
> >> end boundary of mainarea. Could you please check that? though it's a c=
orner
> >> case.
> >
> > Can you elaborate more?
>
> Since c.cur_seg[CURSEG_HOT_NODE] is an offset started from main_blkaddr.

Oh, Got it.
Then, how about this?

         c.cur_seg[CURSEG_HOT_NODE] =3D c.zoned_model =3D=3D F2FS_ZONED_HM =
?
                         (c.devices[1].start_blkaddr -
get_sb(main_blkaddr)) / c.blks_per_seg : 0;

> If c.cur_seg[CURSEG_HOT_NODE] was assigned w/ c.devices[0].total_segments=
,
> and c.devices[0].total_segments is larger than segments of mainare,
> c.cur_seg[CURSEG_HOT_NODE] will exceed the end boundary of mainarea.
>
>         c.cur_seg[CURSEG_HOT_NODE] =3D c.zoned_model =3D=3D F2FS_ZONED_HM=
 ?
>                         c.devices[0].total_segments : 0;
>
> > In the case of F2FS_ZONED_HM, we have the devices[1].
> > Do you mean the case we format the filesystem intentionally smaller
> > than what devices have?
>
> I mean blew case:
> device[0]: conventional device size =3D 10240 MB
> device[1]: zone device size =3D 2 MB
>
> Thanks,
>
> >
> >>
> >> On 2024/1/18 7:00, Daeho Jeong wrote:
> >>> From: Daeho Jeong <daehojeong@google.com>
> >>>
> >>> Make to allocate logs after conventional area for HM zoned devices to
> >>> spare them for file pinning support.
> >>>
> >>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> >>> ---
> >>>    mkfs/f2fs_format.c | 3 ++-
> >>>    1 file changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
> >>> index f2840c8..91a7f4b 100644
> >>> --- a/mkfs/f2fs_format.c
> >>> +++ b/mkfs/f2fs_format.c
> >>> @@ -557,7 +557,8 @@ static int f2fs_prepare_super_block(void)
> >>>                c.cur_seg[CURSEG_COLD_DATA] =3D 0;
> >>>                c.cur_seg[CURSEG_WARM_DATA] =3D next_zone(CURSEG_COLD_=
DATA);
> >>>        } else if (c.zoned_mode) {
> >>> -             c.cur_seg[CURSEG_HOT_NODE] =3D 0;
> >>> +             c.cur_seg[CURSEG_HOT_NODE] =3D c.zoned_model =3D=3D F2F=
S_ZONED_HM ?
> >>> +                     c.devices[0].total_segments : 0;
> >>>                c.cur_seg[CURSEG_WARM_NODE] =3D next_zone(CURSEG_HOT_N=
ODE);
> >>>                c.cur_seg[CURSEG_COLD_NODE] =3D next_zone(CURSEG_WARM_=
NODE);
> >>>                c.cur_seg[CURSEG_HOT_DATA] =3D next_zone(CURSEG_COLD_N=
ODE);


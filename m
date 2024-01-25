Return-Path: <linux-kernel+bounces-38890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F7383C7D0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 212F11F27664
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5401292F3;
	Thu, 25 Jan 2024 16:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qrafq6sh"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6284573177
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 16:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706199956; cv=none; b=BKCUTtNnwa8w76wHer7oLeWrrJIXYW6pTPLCTUi9eITmbAxh0qN9LUqM/JDRClQJ7lEMb6V1dlMCBn0d1Lvw3Fp9dpZYWmprCE90A1yLqeBluiehR8SmxlaByO0NXc0zliVLDP6Yj0PNWecxhTuYFLaerLm2cgJc9p6kjtoxbR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706199956; c=relaxed/simple;
	bh=vZD2j7DC7ThmpeyZ0qJXeaxP/ygU0+YmklpJEPuzpa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eRMeJCyr5vIMVVloHJDeV/0WaBdVzoGKmJiZpB97ON8FdNsmrAlijMX6vV84mUPs3JaG/0t+c+p/MVvPxUkY+H5luaH2QpKgHTN6SMk/v+1MJknaqtvOZqYUPXkDPkVFow3VYta1aJXCZ25F2JZvAtjReBXzFVhpYnlm8dHOIR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qrafq6sh; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7d2de2cc440so820804241.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 08:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706199954; x=1706804754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GdnADLmcOXmpEJAODZvOFI1y6zXc0+rymvs+ALAMMQY=;
        b=Qrafq6shgDvYKakj8bPLnY8Jua+5lYJF9oLETcWW7CDEUycpEEn++XlaJ3vMpovGoG
         PHDIrFWNnwpM/ZpAbqJxQwptdaXllHp0lmxJOQMBw/ILH2+1152UkRTnXoW08gaBntMy
         9GM+pSW7EwS2Pa8Jk5BdWDA48bgjVPqbz7sNTXBrAfQaoyhL82cZDp4irOw8GlN8nrbs
         ZM9StCqdmDReAGyJ38ijr0Mj7wljYkkK7tfcdDGDzl/zr0J/8sIKBILsQs/UltPc1dRZ
         hTCHRjW+1pyNU26Ws+z5APkygfFfCvb1QWV/p29vE0Yc9oAyhCtUmt0d3DtjsiV2c+qZ
         Kcqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706199954; x=1706804754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GdnADLmcOXmpEJAODZvOFI1y6zXc0+rymvs+ALAMMQY=;
        b=SstIMHZW9fTRJPmKIjF6g65YGl2wwmRfkIh49MLVy5dXooVzWCVTRsr/S0RnEP5e0P
         RdQp9vI9H89DHo8ADnkjAc+8KnkiymXcoDr5bdoeUEcVuF0fUTd7JSY9SpEV2aVRS+K6
         xtZwqTmT7+ndXmer7d5Kh5gtQB6nhopmZdLktSBfD/UMJvSLV5LJ6N6oFG6GUpFR9uHo
         3Sj3elcyQs506SIj96NdiVIPeLIEHE1sTOsRRjQ7R3yeM3EcnLGzMoZH3zDJf19jQ34r
         cjtW/svLxwHEF3Aj9KUyLeMPBhW5sd3erlxcevtv55hT2aBIdeRXHAgaSR4iVyY8WvX5
         ynhQ==
X-Gm-Message-State: AOJu0YwFHKtjcjNgNxb4PtwxtONdvdR8tuBsGkWXjlTIX1elA+uBUKOr
	yUVvNIK+4qUwrSKti0rFtjM/h0nJjxlDqvFjlOgYsWWu/3VUvY7eyUQI4iB67nr96GInaJa4tyu
	MXS/1aX1ZpFTD3E35ZHrTUgyIj0gVi0ffLzM=
X-Google-Smtp-Source: AGHT+IHYY9AhsErrdnkftO4vih3ZADQcfj41ON3M50rR0196rOXouYA4O4QxHTwiei5yLas8BOFyhAV/i18LAz8ZDv8=
X-Received: by 2002:ac5:cd5c:0:b0:4bd:3398:61a3 with SMTP id
 n28-20020ac5cd5c000000b004bd339861a3mr470102vkm.31.1706199953984; Thu, 25 Jan
 2024 08:25:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117230032.2312067-1-daeho43@gmail.com> <df9645d9-1e9a-4bd2-88bb-26425cf45811@kernel.org>
In-Reply-To: <df9645d9-1e9a-4bd2-88bb-26425cf45811@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Thu, 25 Jan 2024 08:25:43 -0800
Message-ID: <CACOAw_yjEuGSvo_qyoA13U0HwOr3gOzGtNf2Twhes01SNSGQeg@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs-tools: allocate logs after conventional
 area for HM zoned devices
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	kernel-team@android.com, Daeho Jeong <daehojeong@google.com>, 
	Yongpeng Yang <yangyongpeng1@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 7:34=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> +Cc Yongpeng Yang
>
> Daeho,
>
> Yongpeng reports a potential issue: if c.devices[0].total_segments is
> larger than segments of mainarea, c.cur_seg[CURSEG_HOT_NODE] will exceed
> end boundary of mainarea. Could you please check that? though it's a corn=
er
> case.

Can you elaborate more?
In the case of F2FS_ZONED_HM, we have the devices[1].
Do you mean the case we format the filesystem intentionally smaller
than what devices have?

>
> On 2024/1/18 7:00, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > Make to allocate logs after conventional area for HM zoned devices to
> > spare them for file pinning support.
> >
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > ---
> >   mkfs/f2fs_format.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
> > index f2840c8..91a7f4b 100644
> > --- a/mkfs/f2fs_format.c
> > +++ b/mkfs/f2fs_format.c
> > @@ -557,7 +557,8 @@ static int f2fs_prepare_super_block(void)
> >               c.cur_seg[CURSEG_COLD_DATA] =3D 0;
> >               c.cur_seg[CURSEG_WARM_DATA] =3D next_zone(CURSEG_COLD_DAT=
A);
> >       } else if (c.zoned_mode) {
> > -             c.cur_seg[CURSEG_HOT_NODE] =3D 0;
> > +             c.cur_seg[CURSEG_HOT_NODE] =3D c.zoned_model =3D=3D F2FS_=
ZONED_HM ?
> > +                     c.devices[0].total_segments : 0;
> >               c.cur_seg[CURSEG_WARM_NODE] =3D next_zone(CURSEG_HOT_NODE=
);
> >               c.cur_seg[CURSEG_COLD_NODE] =3D next_zone(CURSEG_WARM_NOD=
E);
> >               c.cur_seg[CURSEG_HOT_DATA] =3D next_zone(CURSEG_COLD_NODE=
);


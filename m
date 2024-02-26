Return-Path: <linux-kernel+bounces-82039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BCE867E19
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAD7B28B24D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17F012F5BA;
	Mon, 26 Feb 2024 17:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WILr/G5g"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607AA12C800
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 17:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708967883; cv=none; b=bUVupIZZNwDpyXkmpLuwUVlkNQHUTuT4hlNXejNRhhqwuily+xhoWrcXReLcI3TUW9filEVZUrfTxt+0HO9hYrakl3IB/gS/YHhQ7sM20g542YOWEVTsx59hE0ej2KJ3M8GHPbmqJQ2DQQADaJhwjZwYWySTiimcG8wqQ2e6U6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708967883; c=relaxed/simple;
	bh=um5p/4uZ5x3XbNAI5QEINO7rp5RsgydWg3nCuBfgEWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sV29bni7wdeETSsJMK1Hh+sGuYXb2qCu9wA9+KKbvhuyDj3dCLM8UQXGfA25HWHsq8HK2SGoufC4EDE0cDsqcMwjU+RLNEUFtnDlDDsR2UctxAv9x2SQzQrNYv+UaeWcGWLzLm80G2WLBKaNWbNWxUA//3IkmyqmkZ9V4dxiGXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WILr/G5g; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6dc8b280155so2485212a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708967881; x=1709572681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAVwApJhl3od3oLSzjzXFngZMESNrDGR/c4sLez2SP4=;
        b=WILr/G5gMmDXq3xkpcSp3S3SlMaS9kzXQbSpbcXPj/VDyJfVlUnQtWz9NPCLw9hMRO
         CuYxKJNUwXmNW1Ma37FU7W/GnpVk55mH0SOoH6xC2AanbXF36AUAUQ8/rpGRUJV+MouH
         HR+vn71uYnRsgYHt704a8OLIecqvNI5HFmMmqa7q+Lt9rcDbQxdnuCAd4oINfXZmtoQ3
         9pe8pV9dB1JuOW7Jx4GtXNc8/24J26aU4bERSh5QObWez9mLrHjGI7SnqqgvFe5Iz06l
         FDLgdRco9LkghzF2nV5ibpCDmaIIEkI86T14uPn0tOlaPXqNovuKy1fzqPgaba/QWHhi
         36Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708967881; x=1709572681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NAVwApJhl3od3oLSzjzXFngZMESNrDGR/c4sLez2SP4=;
        b=GsKppNfialRHWFY7xSdnYUY8N7GUCEW8Hw5biSpYtXDz/Cmvp1XloeRAl4knRGtFj4
         BOSjw8SfVUHxcDfr3H2gwe4RgR5EIyx7rOoxN94IDNk8EHeplmCxO/w4mGcN61S7hKwS
         QlEk7Ap8Xd+UAyvrlrX02XztnPdGWJQB+xGeHcgKdqkdkARxlJcijyCv1AjxFbAteVgK
         BiILYq2byxI6FwkLsRUV666hf9y2beR3mEXBnjqKS/lYUQ6qK46q8Ftmp8hwxc0Sx9Bd
         W03qqiHk781fhwhjRaeOrRMbA4Bj2IAi2M/BitkylaOwgXB5L/g8r1nty+4+Zaw5vvKe
         PX9w==
X-Forwarded-Encrypted: i=1; AJvYcCUy7qleQm7/LqhnZHMZeJaQ/x1bT+Emmto1EROt2ahaAyDCSE489/IihBnTtJZnVkukI3XO2iT/yWefrxGZLhn+2CxYO2XoJOHJV9L4
X-Gm-Message-State: AOJu0YwC0WKxOItI+hQuYm+cFh2d/3TAVgLRIaHw0t08b5XNtH/ubV+A
	yVr0WG3dIWfN5RujzJwFLW07+kSieA2n5v2wQv5PHXGlatC/x55/htAiy8VlTpzQgzG6uHDKfcO
	ZynoAHjfS09/qjmS2cCy5WG5MVKP+efEQmcA=
X-Google-Smtp-Source: AGHT+IHlwotQLUh9i9aTfOKfEJh6sdq3ccECmDnrFEW5VqxgZO7vkzNQjt53ccJRVVMlnXlBqCZPUSo45ybxKNp97/w=
X-Received: by 2002:a05:6871:4e88:b0:21e:7156:a6ad with SMTP id
 uk8-20020a0568714e8800b0021e7156a6admr6879866oab.48.1708967881293; Mon, 26
 Feb 2024 09:18:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223205535.307307-1-jaegeuk@kernel.org> <afa444c5-7ac1-457e-9559-6d7c6623c426@kernel.org>
In-Reply-To: <afa444c5-7ac1-457e-9559-6d7c6623c426@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Mon, 26 Feb 2024 09:17:50 -0800
Message-ID: <CACOAw_zpmxHnG_n4pyKzqWEY2cGyJ5fQXuWfBgDx8-V0Nqu8QA@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH 1/5] f2fs: check number of blocks in a current section
To: Chao Yu <chao@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 25, 2024 at 6:42=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> On 2024/2/24 4:55, Jaegeuk Kim wrote:
> > In cfd66bb715fd ("f2fs: fix deadloop in foreground GC"), we needed to c=
heck
> > the number of blocks in a section instead of the segment.
> >
> > In addtion, let's check the entire node sections when checking the avai=
able
> > node block space. It does not match one to one per temperature, but cur=
rently
>
> I tested this patch w/ testcase in [1], it doesn't complain.
>
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D215914
>
> > we don't have exact dirty page count per temperature. Hence, use a roug=
h
> > estimation.
>
> Do we need more accurate per-temperature dirty node count for extreme
> corner case?
>
> e.g. node_blocks is counted from hot dirty nodes, and current hot_node
> log has no enough free space for it.
>
> Thanks,
>
> >
> > Fixes: cfd66bb715fd ("f2fs: fix deadloop in foreground GC")
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >   fs/f2fs/segment.h | 22 +++++++++++-----------
> >   1 file changed, 11 insertions(+), 11 deletions(-)
> >
> > diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> > index 3edd3809b6b5..15bf5edd9b3c 100644
> > --- a/fs/f2fs/segment.h
> > +++ b/fs/f2fs/segment.h
> > @@ -561,23 +561,23 @@ static inline bool has_curseg_enough_space(struct=
 f2fs_sb_info *sbi,
> >                       unsigned int node_blocks, unsigned int dent_block=
s)
> >   {
> >
> > -     unsigned int segno, left_blocks;
> > +     unsigned segno, left_blocks;
> >       int i;
> >
> > -     /* check current node segment */
> > +     /* check current node sections, which counts very roughly */
> > +     left_blocks =3D 0;
> >       for (i =3D CURSEG_HOT_NODE; i <=3D CURSEG_COLD_NODE; i++) {
> >               segno =3D CURSEG_I(sbi, i)->segno;
> > -             left_blocks =3D f2fs_usable_blks_in_seg(sbi, segno) -
> > -                             get_seg_entry(sbi, segno)->ckpt_valid_blo=
cks;
> > -
> > -             if (node_blocks > left_blocks)
> > -                     return false;
> > +             left_blocks +=3D CAP_BLKS_PER_SEC(sbi) -
> > +                             get_ckpt_valid_blocks(sbi, segno, true);
> >       }
> > +     if (node_blocks > left_blocks)
> > +             return false;

I am not sure this is okay. The current implementation of f2fs may not
be optimal when the HOT_NODE section's space requirements exceed its
current capacity. In such cases, f2fs necessitates the creation of a
new free section to accommodate the overflow, even though there might
be free space available in other NODE sections. To address this issue,
it may be necessary to implement a more accurate accounting system for
NODE sections based on their temperature levels.

> >
> > -     /* check current data segment */
> > +     /* check current data section for dentry blocks. */
> >       segno =3D CURSEG_I(sbi, CURSEG_HOT_DATA)->segno;
> > -     left_blocks =3D f2fs_usable_blks_in_seg(sbi, segno) -
> > -                     get_seg_entry(sbi, segno)->ckpt_valid_blocks;
> > +     left_blocks =3D CAP_BLKS_PER_SEC(sbi) -
> > +                     get_ckpt_valid_blocks(sbi, segno, true);
> >       if (dent_blocks > left_blocks)
> >               return false;
> >       return true;
> > @@ -626,7 +626,7 @@ static inline bool has_not_enough_free_secs(struct =
f2fs_sb_info *sbi,
> >
> >       if (free_secs > upper_secs)
> >               return false;
> > -     else if (free_secs <=3D lower_secs)
> > +     if (free_secs <=3D lower_secs)
> >               return true;
> >       return !curseg_space;
> >   }
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


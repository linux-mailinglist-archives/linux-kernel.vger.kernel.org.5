Return-Path: <linux-kernel+bounces-37906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1725B83B779
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 04:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0C281C21564
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 03:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4955C9A;
	Thu, 25 Jan 2024 03:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRM8uu+z"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FB01FB2
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 03:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706151713; cv=none; b=bFDH4P9AqDmkCrj0h/orydP8OQ+2Z51b1vZAb45P+p4STsrzVZL9fsZNr20GaeShF4dx9rJs20XctWO4Cog0X31SWrWmmzd5wUQxqVOpAAjAjDQbCTGQzoMdT9STg4cclgm4tF0AhQsAJmRXki4PFZF4wQUM2dgOMtku9exk5SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706151713; c=relaxed/simple;
	bh=0XZnJVSl9yT8NzFj11BZfz8A5Hu9fLHvy/N1lIZxJr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CWHROXPvgI14hidc9gJ1Al32uCtB9N5zoBSet0b3rVb1nnC1O/ux92ybahu0xAa253pArDlVPZVnQM2q7gfXLh1xkpuZTVk+C+v0SXeKRlOKvbq6ByKx776Twrc/WZBjQt2+D6BywoEe27Up16ZmUbzagxcUMpvjL884mitFH80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRM8uu+z; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55a86795a3bso6474622a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 19:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706151710; x=1706756510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WGiyAHud1zklxr4w5Cvq4HldX0ROxrGXkPXnV56dMB4=;
        b=RRM8uu+z+enLHr+u9lVSUNEGCnHN1jas6/xllbS0IiKjrhusMis+lPZQFR1uDMrGuP
         MMTDJlOkrSUFTlfSlzI1FErcV2N5Skm/CfFPqwvziCfJTTuUws9H9oW6lQXdH9jIh3tn
         yiBLa6gVMP0ReqXWmCbwn715qxy7k4Tws1o4IxgHKYu93Td3c/VF5vvT8pImYg41KbcN
         JteS5HI96PyNBltCDoQdI8vsR1IqMOURizNO9pVEBGsgtA36guW7Wab6trwCaiRVChro
         X6JK69EyIjNI5X2LJSjvzDcEQH56VTKou+38fF1hed12XfJJ+0q3BA2y06LzztffhFKF
         qkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706151710; x=1706756510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WGiyAHud1zklxr4w5Cvq4HldX0ROxrGXkPXnV56dMB4=;
        b=C1ihn2itn8CoFgv1sltTY3JZZKGP85JFY+BOJG1cFdYmVVBVZMsts1UcieBRR4YQmc
         bTbrhbfY0Bvrk6FPmvu+tum9ANhewyj9utcggnv0AKDMSZWz9iGR0nu5w+VN3nIgpXrj
         15PUzqh38lHQqolfF0l84T6pl1MfJJDkCqntiqqT3Cu3/w4WqT6wu1Bs27DLb61f9NhQ
         QI4O33nJMJTHqBgcamUQ005lUbHUjuZ8EouSbX6l0tX49u3H2F03k/1kKlMyRQZZC332
         mDgIgDxXUP/oqX1Xn3F6ln+sIW5cqDOCl+MhFB4yXFobvthyCd9zivco5HOkuLN5sfWC
         TZJA==
X-Gm-Message-State: AOJu0Yy/x3Feck2GvDlb9rr9oOYdIqsL/yfTIbAAy88HflrvXT7Q7ahw
	iYGS2xheDapjgpSEM0fogtkiLED0bJbU08SpBJvAXQSu78LaCfM6VUKJiQ/y7OOHHCL15XmMSt+
	jRFG937UsP9EBi5MDwfFxPLvFpBk=
X-Google-Smtp-Source: AGHT+IEnoFE7ytn/E8cRDRjQCSJsv0fMwsa6UB/wMFssFu0dpTGk7NCfLiIJVRNBUYrudDH8UDT6tYTKKpzjT82hHrg=
X-Received: by 2002:a05:6402:32f:b0:55c:972e:3e9c with SMTP id
 q15-20020a056402032f00b0055c972e3e9cmr101429edw.80.1706151709630; Wed, 24 Jan
 2024 19:01:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1703502715-11936-1-git-send-email-zhiguo.niu@unisoc.com>
 <74243f43-c129-4530-970c-4de2afcd307e@kernel.org> <CAHJ8P3KmnN3rc5yXh2ecg21Eu61srUJsJP8=TbPxfSu4dY91EQ@mail.gmail.com>
 <b2a3268a-7087-4ff5-9148-dcbc7c95e2bb@kernel.org>
In-Reply-To: <b2a3268a-7087-4ff5-9148-dcbc7c95e2bb@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Thu, 25 Jan 2024 11:01:38 +0800
Message-ID: <CAHJ8P3+GeS4TSdwAPJ8dO_R08Vvi1iv_ua+9SU2JY5weuN4hKw@mail.gmail.com>
Subject: Re: [PATCH V1] f2fs: fix potentail deadloop issue in do_recover_data
To: Chao Yu <chao@kernel.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chao,

On Wed, Jan 24, 2024 at 10:54=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> Zhiguo,
>m
> Can you please check below version? Is it fine to you?
>
> https://lore.kernel.org/linux-f2fs-devel/20240124144915.19445-1-chao@kern=
el.org
it is ok to me and more reasonable than my  version
thanks~
>
> On 2024/1/22 13:46, Zhiguo Niu wrote:
> > Hi Chao
> >
> > On Mon, Jan 22, 2024 at 11:46=E2=80=AFAM Chao Yu <chao@kernel.org> wrot=
e:
> >>
> >> On 2023/12/25 19:11, Zhiguo Niu wrote:
> >>> There is a potentail deadloop issue in the corner case of
> >>> CONFIG_F2FS_FAULT_INJECTION is enabled and the return value
> >>> of f2fs_reserve_new_block is error but not -ENOSPC, such as
> >>> this error case:
> >>> if (unlikely(is_inode_flag_set(dn->inode, FI_NO_ALLOC)))
> >>>                return -EPERM;
> >>
> >> I don't see any path to trigger this error? am I missing something?
> >>
> >>> besides, the mainly error -ENOSPC has been handled as bug on,
> >>> so other error cases can be proecssed normally without looping.
> >>
> >> commit 975756c41332bc5e523e9f843271ed5ab6aaaaaa
> >> Author: Jaegeuk Kim <jaegeuk@kernel.org>
> >> Date:   Thu May 19 11:57:21 2016 -0700
> >>
> >>       f2fs: avoid ENOSPC fault in the recovery process
> >>
> >>       This patch avoids impossible error injection, ENOSPC, during rec=
overy process.
> >>
> >> Please check above patch, I guess intention of adding such loop is
> >> to avoid mount failure due to fault injection was triggered in
> >> f2fs_reserve_new_block().
> >>
> >> What about change as blew?
> >> - keep the loop to avoid mount failure.
> >> - remove bug_on() to avoid panic due to fault injection error.
> >>
> >> #define DEFAULT_RETRY_COUNT             8
> >>
> >>                  for (loops =3D DEFAULT_RETRY_COUNT; loops > 0; loops-=
-) {
> >>                          err =3D f2fs_reserve_new_block(&dn);
> >>                          if (!err ||
> >>                                  !IS_ENABLED(CONFIG_F2FS_FAULT_INJECTI=
ON))
> >>                                  break;
> >>                  }
> >
> > Thanks for your detailed explanation and I understand.
> > It seems that the original process is also reasonable,
> > so it=E2=80=99s okay to keep it as it is.
> >>
> >> Thanks,
> >>
> >>>
> >>> Fixes: 956fa1ddc132 ("f2fs: fix to check return value of f2fs_reserve=
_new_block()")
> >>> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> >>> ---
> >>>    fs/f2fs/recovery.c | 26 ++++++++------------------
> >>>    1 file changed, 8 insertions(+), 18 deletions(-)
> >>>
> >>> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> >>> index 21381b7..5d658f6 100644
> >>> --- a/fs/f2fs/recovery.c
> >>> +++ b/fs/f2fs/recovery.c
> >>> @@ -710,15 +710,10 @@ static int do_recover_data(struct f2fs_sb_info =
*sbi, struct inode *inode,
> >>>                 */
> >>>                if (dest =3D=3D NEW_ADDR) {
> >>>                        f2fs_truncate_data_blocks_range(&dn, 1);
> >>> -                     do {
> >>> -                             err =3D f2fs_reserve_new_block(&dn);
> >>> -                             if (err =3D=3D -ENOSPC) {
> >>> -                                     f2fs_bug_on(sbi, 1);
> >>> -                                     break;
> >>> -                             }
> >>> -                     } while (err &&
> >>> -                             IS_ENABLED(CONFIG_F2FS_FAULT_INJECTION)=
);
> >>> -                     if (err)
> >>> +                     err =3D f2fs_reserve_new_block(&dn);
> >>> +                     if (err =3D=3D -ENOSPC)
> >>> +                             f2fs_bug_on(sbi, 1);
> >>> +                     else if (err)
> >>>                                goto err;
> >>>                        continue;
> >>>                }
> >>> @@ -727,15 +722,10 @@ static int do_recover_data(struct f2fs_sb_info =
*sbi, struct inode *inode,
> >>>                if (f2fs_is_valid_blkaddr(sbi, dest, META_POR)) {
> >>>
> >>>                        if (src =3D=3D NULL_ADDR) {
> >>> -                             do {
> >>> -                                     err =3D f2fs_reserve_new_block(=
&dn);
> >>> -                                     if (err =3D=3D -ENOSPC) {
> >>> -                                             f2fs_bug_on(sbi, 1);
> >>> -                                             break;
> >>> -                                     }
> >>> -                             } while (err &&
> >>> -                                     IS_ENABLED(CONFIG_F2FS_FAULT_IN=
JECTION));
> >>> -                             if (err)
> >>> +                             err =3D f2fs_reserve_new_block(&dn);
> >>> +                             if (err =3D=3D -ENOSPC)
> >>> +                                     f2fs_bug_on(sbi, 1);
> >>> +                             else if (err)
> >>>                                        goto err;
> >>>                        }
> >>>    retry_prev:


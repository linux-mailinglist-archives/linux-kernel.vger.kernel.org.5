Return-Path: <linux-kernel+bounces-84296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B40786A4B0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DC281C242A0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9394A35;
	Wed, 28 Feb 2024 01:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTzYo8Nd"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD554400
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 01:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709082052; cv=none; b=uNQSkhT4jW5bFlO9SEXsp3Q9qAb6RnoK0PW41K/n9BuNiEFot6y19q/Ii4eqFrArKgzNVpG8I9HO3KXYgeSEua+g4gHChVDtPU+X4ArAdQd6LzAEcdb64ioM7Vyrbr2Mh2hreE+0FDaY29qCyP+bsQKQZ0Zuwyr8q1zhy3dwOxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709082052; c=relaxed/simple;
	bh=6+BR0EC2Ra2k0UU+DJSR6GCq30U9286cyQ3jggTkF2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kjedPxpDsykiq2396zGxTuseEs2ZDQHga2oLq0KqFMSXRQfRCY0LaYPksbX1Z+LSoNL5W0wZQ/VDDbTt5fYaTTa/RX5id3ZxmnwFodXfDYy/nAkwz58t/k6pfOti017BfBlrEDVHjFykZksgxjkz9vzHeewilBPYE8M6aoxH21Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTzYo8Nd; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-565ef8af2f5so3506408a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 17:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709082049; x=1709686849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjXEhuh0YtyIbM5bguMeiWD8HgiRpdwUBVGzKxGhXgI=;
        b=YTzYo8NdKlKLdLJcgujCynJ9YWUdV05pWX9zb6ZafJ2alvZyrYXNChXl726aOJ54iJ
         FPQADaJN1nvdP8MS1vQ5dbBiHVSK8jRhRZeAvyAiqCyj75Apt09X3ZmMy+fIww9qZACv
         43jUOLfMubMFWPhL2t6EBLykddWr2KFAPTjAy36d+NjJ5bSh+6tk86oCPbwOAbbYKvbm
         Kn5mnPU1T8UYV1KpW3cyZGuhO1JBWiJJ0+8daZ9K9eeXa0WM/B9twHgMYNMa4horUPki
         tXr2vvp88dp8jq8McxEgHXvJzk3DA7wNofWaCQiqdRvnPJVFdAWYOiRU4d+iZjPrER/7
         U5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709082049; x=1709686849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjXEhuh0YtyIbM5bguMeiWD8HgiRpdwUBVGzKxGhXgI=;
        b=DitsQm2dzPR0LxKw0FI4HVxE6Oq/qSgaAHJcGAbZvQ4njKwLl4WL88iabTtTmHZ/Ou
         Z2hX4pYytHqCtrBOx0ldUuN2wJeNca3mX5mcUUdlWzBj4OLMiHN/9TMXZO9rFvnIVv7P
         rgduh/gtXM5TsAuAIMzydR0LNHwck0pw0e0981YB+KGI3+274b8k5hSmde5XgrV5Eej7
         3dE0nGVvE9gvMCvHNi+Yet+trz9iAuj3S19BaTCT11R48pj05GKtUgP9K+0fRzbdyZzQ
         gkTQfvwtCaDPFv2cdFdZCKa8wC2KU1032w2WmgKw33SaSCkqeXSNSf+5nqRd19ji2jMN
         JunQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwQjwAsOo5ZelD11ogZ1fuTaMBbwJ5bp1M9NDBzuvo7U65io2F9/YGyEvgSP1FH6dMurjUD9CkrYkdm+9oiYgFUs6iUTwXAtErsyay
X-Gm-Message-State: AOJu0YzE66Ramu3n/K/1RxO6wtdLYK/YKnvYgB8pOzuk5Vo1cQ0ECP1e
	2+HEd9H5x/g8nt//kBHOzpLjhhD/XtigrO3MevBZzy2KviJ/5MUhwOvDVBH3PpUQKndJn/sMiGT
	lMzVH7E1mB/7M6Yg900vwoFslNtmD60EBnASpEr3v
X-Google-Smtp-Source: AGHT+IF0ZgQXFJn7ExsYap7so0xX0djl5COXxTIClpDONqOxfAL+1QaaCPT06+J5sB14oAuEHMbrMXsA9+k5CY5oTP8=
X-Received: by 2002:aa7:d6cf:0:b0:564:a4e9:3683 with SMTP id
 x15-20020aa7d6cf000000b00564a4e93683mr8898548edr.16.1709082049151; Tue, 27
 Feb 2024 17:00:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1707271264-5551-1-git-send-email-zhiguo.niu@unisoc.com>
 <88459a22-a21c-4c3d-8371-31d7d713b536@kernel.org> <CAHJ8P3KYY27M3v=9Lu-yD2ufxU1fdG-bg=G92AbpnLUx0zLz3g@mail.gmail.com>
 <f36ef5d0-8922-449e-b19c-de009c89e712@kernel.org> <CAHJ8P3KS2YAXm=GND8DknZqvGqTvm38Nv_9z1nEq4cTJjir-sA@mail.gmail.com>
 <Zd03RHMKBqv1f6GF@google.com> <CAHJ8P3Lj_1pa=npkAsMfeStEY3nWgf591tFndKTT_skFYLv+GQ@mail.gmail.com>
 <Zd4ZTokbVPkj5gy4@google.com>
In-Reply-To: <Zd4ZTokbVPkj5gy4@google.com>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Wed, 28 Feb 2024 09:00:37 +0800
Message-ID: <CAHJ8P3+bpRyghkcOoDaJ_2r1Wh69jF1W-8Rm881y6d3rif8xhQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] f2fs: fix panic issue in small capacity device
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <chao@kernel.org>, Zhiguo Niu <zhiguo.niu@unisoc.com>, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com, hongyu.jin@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 1:18=E2=80=AFAM Jaegeuk Kim <jaegeuk@kernel.org> wr=
ote:
>
> On 02/27, Zhiguo Niu wrote:
> > On Tue, Feb 27, 2024 at 9:13=E2=80=AFAM Jaegeuk Kim <jaegeuk@kernel.org=
> wrote:
> > >
> > > On 02/26, Zhiguo Niu wrote:
> > > > Dear Chao,
> > > >
> > > > On Fri, Feb 23, 2024 at 10:38=E2=80=AFAM Chao Yu <chao@kernel.org> =
wrote:
> > > > >
> > > > > On 2024/2/23 10:01, Zhiguo Niu wrote:
> > > > > >
> > > > > >
> > > > > > On Thu, Feb 22, 2024 at 8:30=E2=80=AFPM Chao Yu <chao@kernel.or=
g <mailto:chao@kernel.org>> wrote:
> > > > > >
> > > > > >     On 2024/2/7 10:01, Zhiguo Niu wrote:
> > > > > >      > A panic issue happened in a reboot test in small capacit=
y device
> > > > > >      > as following:
> > > > > >      > 1.The device size is 64MB, and main area has 24 segments=
, and
> > > > > >      > CONFIG_F2FS_CHECK_FS is not enabled.
> > > > > >      > 2.There is no any free segments left shown in free_segma=
p_info,
> > > > > >      > then another write request cause get_new_segment get a o=
ut-of-bound
> > > > > >      > segment with segno 24.
> > > > > >      > 3.panic happen in update_sit_entry because access invali=
d bitmap
> > > > > >      > pointer.
> > > > > >
> > > > > >     Zhiguo,
> > > > > >
> > > > > >     Can you please try below patch to see whether it can fix yo=
ur problem?
> > > > > >
> > > > > >     https://lore.kernel.org/linux-f2fs-devel/20240222121851.883=
141-3-chao@kernel.org <https://lore.kernel.org/linux-f2fs-devel/20240222121=
851.883141-3-chao@kernel.org>
> > > > > >
> > > > > >     Thanks,
> > > > > >
> > > > > >
> > > > > > Dear Chao,
> > > > > > I need to coordinate the testing resources. The previous testin=
g has been stopped because it was fixed with the current patch. In addition=
, this requires stability testing to reproduce, so it will take a certain a=
mount of time. If there is any situation, I will tell you in time.
> > > > >
> > > > > Zhiguo, thank you!
> > > >
> > > > We tested this patch  this weekend on the previous version with
> > > > problem, and it can not reproduce panic issues,
> > > > so this patch should fix the original issue.
> > > > thanks=EF=BC=81
> > >
> > Dear Jaegeuk,
> > > Hey, do you guys please point out which patches were tested without w=
hat?
> > This problem occurred during our platform stability testing.
> > it can be fixed by my  this patch set, mainly be fixed by:
> > f2fs: fix panic issue in update_sit_entry & f2fs: enhance judgment
> > conditions of GET_SEGNO
> > and Chao's patch can also fix this problems testing without my patch
> > > IOWs, which patches should I remove and keep Chao's patch?
> > I think chao's patch is more reasonable, it does error handling more co=
mplete.
> > but my patch just do some sanity check for return value of GET_SEGNO
> > Same as other codes(update_segment_mtime)
> > and i think it also needed except this part:
>
> Thanks for confirmation. It seems it'd be better to revert yours and appl=
y
> Chao's patch first. If you think there's something to improve on top of i=
t,
> could you please send another patch afterwards?

OK, I think this two patches still needed
  f2fs: correct counting methods of free_segments in __set_inuse
  f2fs: fix panic issue in update_sit_entry
and I'll reorganize it
thanks
>
> >
> > diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> > index 3bf2ce46fa0907..bb22feeae1cfcb 100644
> > --- a/fs/f2fs/segment.h
> > +++ b/fs/f2fs/segment.h
> > @@ -96,7 +96,8 @@ static inline void sanity_check_seg_type(struct
> > f2fs_sb_info *sbi,
> > (GET_SEGOFF_FROM_SEG0(sbi, blk_addr) & (BLKS_PER_SEG(sbi) - 1))
> > #define GET_SEGNO(sbi, blk_addr) \
> > - ((!__is_valid_data_blkaddr(blk_addr)) ? \
> > + ((!__is_valid_data_blkaddr(blk_addr) || \
> > + !f2fs_is_valid_blkaddr(sbi, blk_addr, DATA_GENERIC)) ? \
> > NULL_SEGNO : GET_L2R_SEGNO(FREE_I(sbi), \
> > GET_SEGNO_FROM_SEG0(sbi, blk_addr)))
> > #define CAP_BLKS_PER_SEC(sbi)
> > because Chao's patch let new_addr=3Dnull_addr when  get_new_segment
> > returns NOSPACE,
> > so I think this can be reverted and it also saves code running time.
> > How about Chao's opinions?
> > thanks!
> > >
> > > >
> > > > >
> > > > > BTW, I've tested this patch for a while, and it looks there is no=
 issue w/
> > > > > FAULT_NO_SEGMENT fault injection is on.
> > > > >
> > > > > > btw, Why can=E2=80=99t I see this patch on your branch^^?
> > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/=
log/?h=3Ddev-test <https://git.kernel.org/pub/scm/linux/kernel/git/chao/lin=
ux.git/log/?h=3Ddev-test>
> > > > >
> > > > > Too lazy to push patches in time, will do it in this weekend. :P
> > > > >
> > > > > > thanks=EF=BC=81
> > > > > >
> > > > > >
> > > > > >      >
> > > > > >      > More detail shown in following patch sets.
> > > > > >      > The three patches are splited here because the modificat=
ions are
> > > > > >      > relatively independent and more readable.
> > > > > >      >
> > > > > >      > ---
> > > > > >      > Changes of v2: stop checkpoint when get a out-of-bound s=
egment
> > > > > >      > ---
> > > > > >      >
> > > > > >      > Zhiguo Niu (4):
> > > > > >      >    f2fs: correct counting methods of free_segments in __=
set_inuse
> > > > > >      >    f2fs: fix panic issue in update_sit_entry
> > > > > >      >    f2fs: enhance judgment conditions of GET_SEGNO
> > > > > >      >    f2fs: stop checkpoint when get a out-of-bounds segmen=
t
> > > > > >      >
> > > > > >      >   fs/f2fs/file.c          |  7 ++++++-
> > > > > >      >   fs/f2fs/segment.c       | 21 ++++++++++++++++-----
> > > > > >      >   fs/f2fs/segment.h       |  7 ++++---
> > > > > >      >   include/linux/f2fs_fs.h |  1 +
> > > > > >      >   4 files changed, 27 insertions(+), 9 deletions(-)
> > > > > >      >
> > > > > >


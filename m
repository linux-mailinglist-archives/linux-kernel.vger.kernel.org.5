Return-Path: <linux-kernel+bounces-32343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FDB835A6E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 06:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12F3A1C21ABA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 05:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C7C63A7;
	Mon, 22 Jan 2024 05:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzwhgRUu"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7972610C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 05:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705902433; cv=none; b=kMQujQAzNnKN2s7ByfhbOYac9+oK0f8g87veCkHi4KygQvByGuPJoAj1lwVCu899Ejwo/HaZKUb8GJdAb9GSuLcYG0+X2j5zRKT66tsrWqJ81fC/2Z6+w1kBKMGZDRflz9vtskfjgasVTgxsFmreBgq+wBWnu+4Ng3yE57HQiyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705902433; c=relaxed/simple;
	bh=w0YGYBZ/dh7Vk/tQn34Q3nmnir8jia1dl5Hvefz2fEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eF0F48h9PByoeU3NBM9c4QucWRutqOdwZAniTeUUX0Ox6Wu01rWA+UKEur7ZGyIE/eRFGdz84FZU4cHk1rwxB3LYaQ8BGNgEz2TRfCQHs55lvGuKSJC7845TGU/1xtQOaOgZC7IUdpOxzSJ0+KDgi61vZ0EVoQapkT9jP1KTshw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EzwhgRUu; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-559f92bf7b6so4829041a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 21:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705902430; x=1706507230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WpZ26oyMw52BtqasRQKvc0RRxoPsrrYn13Naqm6uq6w=;
        b=EzwhgRUuCIjsQX2nOUO4d1L62QGyAixXytLxgNxkD6R2CVWJopY2hI8/0qxJ54/zXO
         9hxYOZlLmu8KaGohARjZ0YPtS7X92ezgqU0+Pgg7jvZBOeGGHNK4gYayolau5T8S6r5n
         CEcSD1P/sPKSjtIr4bPfhgI+GW7q9+uRAkMIK4MJ7krLAXNb3iuN3u1ECSB82s/gXEB2
         AuXPZS+xIccAUwrl9oBvTijA5hd9kCGJLWrfaMaa3bMztmMnjvRGuT7C3ivfAqcapEAY
         SMKxqJAj1tw2xNL+1o8LKbv7V1i1khH2hoMkAfE096bh88IzJ7FplHLAgi4VFS9d62Vy
         ovfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705902430; x=1706507230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WpZ26oyMw52BtqasRQKvc0RRxoPsrrYn13Naqm6uq6w=;
        b=Vk9/tnSc9RS/ydB/s0EwrMIrIP8QCCcK7HIZwWOJ802p9zY7M0CRC56UdgVAJWbhxY
         4UTm2d0rfj1vezN3Ijdrykow4SGCW/rmqiiMEGw7lUwfTxGnBnLadMgAf+KHDC5wmH9a
         UPH4m0/8FP+0PRrYI5bE+Jks+juKcgBdfS4s/v/SW05DQlM/YY5nvqncWXmH0C+sb5bX
         3eANuf4lYFIvDepinIMJTP50Q2evRwfBVGz9rf/RP8dqdzonbA6fR36K7QmUntlpv3bF
         jLS1Gk5MHGb9HiMByzt1TUbwSbc17UPCq/K2wOpmOuPyBDWcuWOjJ56XbxlXoBqtAYgN
         q8wQ==
X-Gm-Message-State: AOJu0YzWOV+2kfxHZ+YhVb3B4Rz6inZjJK3pdWRB1zjQihPCUinYJtLf
	NmU4LX7vI1DcCoXeIDUv8grC1bdJ83ZOUswBgQeu5P7g8TPjJohM12CJZcqxyne6DNHsbXH4oqW
	oGfrB+XYP4EAP9Du5GerfBCHdGoU=
X-Google-Smtp-Source: AGHT+IG8KekwYXaPWjcm1ovpIPGbaaDPlX1vP/WNmB8qLpmGxP//yELYJnFVZktgGZ1s/IPIFs7sXSi6Nz3jXeDEPe4=
X-Received: by 2002:a05:6402:13cb:b0:55c:383f:3cba with SMTP id
 a11-20020a05640213cb00b0055c383f3cbamr1301223edx.29.1705902429832; Sun, 21
 Jan 2024 21:47:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1703502715-11936-1-git-send-email-zhiguo.niu@unisoc.com> <74243f43-c129-4530-970c-4de2afcd307e@kernel.org>
In-Reply-To: <74243f43-c129-4530-970c-4de2afcd307e@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Mon, 22 Jan 2024 13:46:58 +0800
Message-ID: <CAHJ8P3KmnN3rc5yXh2ecg21Eu61srUJsJP8=TbPxfSu4dY91EQ@mail.gmail.com>
Subject: Re: [PATCH V1] f2fs: fix potentail deadloop issue in do_recover_data
To: Chao Yu <chao@kernel.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chao

On Mon, Jan 22, 2024 at 11:46=E2=80=AFAM Chao Yu <chao@kernel.org> wrote:
>
> On 2023/12/25 19:11, Zhiguo Niu wrote:
> > There is a potentail deadloop issue in the corner case of
> > CONFIG_F2FS_FAULT_INJECTION is enabled and the return value
> > of f2fs_reserve_new_block is error but not -ENOSPC, such as
> > this error case:
> > if (unlikely(is_inode_flag_set(dn->inode, FI_NO_ALLOC)))
> >               return -EPERM;
>
> I don't see any path to trigger this error? am I missing something?
>
> > besides, the mainly error -ENOSPC has been handled as bug on,
> > so other error cases can be proecssed normally without looping.
>
> commit 975756c41332bc5e523e9f843271ed5ab6aaaaaa
> Author: Jaegeuk Kim <jaegeuk@kernel.org>
> Date:   Thu May 19 11:57:21 2016 -0700
>
>      f2fs: avoid ENOSPC fault in the recovery process
>
>      This patch avoids impossible error injection, ENOSPC, during recover=
y process.
>
> Please check above patch, I guess intention of adding such loop is
> to avoid mount failure due to fault injection was triggered in
> f2fs_reserve_new_block().
>
> What about change as blew?
> - keep the loop to avoid mount failure.
> - remove bug_on() to avoid panic due to fault injection error.
>
> #define DEFAULT_RETRY_COUNT             8
>
>                 for (loops =3D DEFAULT_RETRY_COUNT; loops > 0; loops--) {
>                         err =3D f2fs_reserve_new_block(&dn);
>                         if (!err ||
>                                 !IS_ENABLED(CONFIG_F2FS_FAULT_INJECTION))
>                                 break;
>                 }

Thanks for your detailed explanation and I understand.
It seems that the original process is also reasonable,
so it=E2=80=99s okay to keep it as it is.
>
> Thanks,
>
> >
> > Fixes: 956fa1ddc132 ("f2fs: fix to check return value of f2fs_reserve_n=
ew_block()")
> > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > ---
> >   fs/f2fs/recovery.c | 26 ++++++++------------------
> >   1 file changed, 8 insertions(+), 18 deletions(-)
> >
> > diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> > index 21381b7..5d658f6 100644
> > --- a/fs/f2fs/recovery.c
> > +++ b/fs/f2fs/recovery.c
> > @@ -710,15 +710,10 @@ static int do_recover_data(struct f2fs_sb_info *s=
bi, struct inode *inode,
> >                */
> >               if (dest =3D=3D NEW_ADDR) {
> >                       f2fs_truncate_data_blocks_range(&dn, 1);
> > -                     do {
> > -                             err =3D f2fs_reserve_new_block(&dn);
> > -                             if (err =3D=3D -ENOSPC) {
> > -                                     f2fs_bug_on(sbi, 1);
> > -                                     break;
> > -                             }
> > -                     } while (err &&
> > -                             IS_ENABLED(CONFIG_F2FS_FAULT_INJECTION));
> > -                     if (err)
> > +                     err =3D f2fs_reserve_new_block(&dn);
> > +                     if (err =3D=3D -ENOSPC)
> > +                             f2fs_bug_on(sbi, 1);
> > +                     else if (err)
> >                               goto err;
> >                       continue;
> >               }
> > @@ -727,15 +722,10 @@ static int do_recover_data(struct f2fs_sb_info *s=
bi, struct inode *inode,
> >               if (f2fs_is_valid_blkaddr(sbi, dest, META_POR)) {
> >
> >                       if (src =3D=3D NULL_ADDR) {
> > -                             do {
> > -                                     err =3D f2fs_reserve_new_block(&d=
n);
> > -                                     if (err =3D=3D -ENOSPC) {
> > -                                             f2fs_bug_on(sbi, 1);
> > -                                             break;
> > -                                     }
> > -                             } while (err &&
> > -                                     IS_ENABLED(CONFIG_F2FS_FAULT_INJE=
CTION));
> > -                             if (err)
> > +                             err =3D f2fs_reserve_new_block(&dn);
> > +                             if (err =3D=3D -ENOSPC)
> > +                                     f2fs_bug_on(sbi, 1);
> > +                             else if (err)
> >                                       goto err;
> >                       }
> >   retry_prev:


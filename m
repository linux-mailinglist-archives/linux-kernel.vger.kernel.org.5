Return-Path: <linux-kernel+bounces-120172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC27188D3B5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07FA51C251FA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 01:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630F21BF3F;
	Wed, 27 Mar 2024 01:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lY7bkqU4"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB31C3DAC0D
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 01:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711502833; cv=none; b=ItY9ni8m8udyLfaF8zPmQJ/zqK2AsQc0xy5nqJ4vJJSKCJ8/IuJBo1FA3wKWOLyve/DT1tBCBxOUh1aiuNW11rOQ2nqSxtq8zH48x8AK+PU+RAcpjFPonalHIoEGYdhxsO7YLAnB2o2pPT4I5TbZiqPa2nMueh8il97NhiMJJME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711502833; c=relaxed/simple;
	bh=sHtvbU0ILdyqseK1y7njbtWmei1VFZnUe38FxpEO2zc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EvZtrAaRmr6gV6dpAuQqdNHTqObz5eqidiFgVMTI/AQ8E37IX+vXPyTbghqAxqmODfPtLbOBaUSe9paHRBr7Qyl12OpNDEcvnFUC0THvtf2uedo0V4UlOMiV63GAMOdXKdFp4vrxMkMCrdDLGQUmQdrTktsTowFxoDZslwdBiio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lY7bkqU4; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d21cdbc85bso82293901fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 18:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711502830; x=1712107630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zppxzZTYcPYTCfwQCIgoByNCATXqeso08TOMqgh4uHY=;
        b=lY7bkqU4Owfvlzox2kB2avVBUb5dM8Sw37y2xmpFjouvpcV2F2jBbaCKJ6GMfDq2en
         s9y9VMlAQxoRBRJYxS1A/VqOxLFrzCYtXlcuEPJevKXI3NXXfjN8xLpl6NQrNGSagv5I
         diQRzxR/wkPQdv3MNC0V+zfX2iORa0O0MF6Dskqsy/2RVtXWvXQPLtBnnBDepni/hXY9
         h5OCHUNOifwqebr95ZHeLnjdOTlVm+nHtKEGjf8bWiZq6Zt9+xhYwOnJty+ohyEkZZp6
         /68uXFeZIUxpEHr6ovW0HvLQbpSq4BjSZNoaTiK20KjBGYO4NADM4vqBPBfEF5zpMSI1
         2OuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711502830; x=1712107630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zppxzZTYcPYTCfwQCIgoByNCATXqeso08TOMqgh4uHY=;
        b=kMPz4ytvqsXnrQxAi2JqlScHEXg5jMnf3t6gG9riN9wFVLH6yjrtT2qvf4MYWMBL+e
         HEYMeJNiJE3RuWfMrSfduMLLeNdGOz1FLo2YXkmTmXZ+MKXVjpczVktkUBJIKrP8SRW7
         qhpQ9+HLhlr18CPrTMSe7nSX53akvlynS6novzs3ydiRCjEWj7k2dZa79ygYab3Mu89l
         pJnm79YNlbM6NG8yrcwOGq8wwqq00CpZfyoeezz1dA5H+yze+vTAarfq2guZ/kK/XI2m
         YwBgPrFyHzCLRjR+6UoMFmbh0Zlh3bc8smtC96BIumuOn/WRFsJVJi6iRWhMBTBkmtb8
         NE3g==
X-Forwarded-Encrypted: i=1; AJvYcCUN3rtzp9O2osbv+O7IRQtW/S9n3amY8d/A8xkve8oN+we2EdeFTB8KKCpLtlDTzJWzLe8jAGqz3JfwNu+DmU6we4XdbuB/f3s14e8M
X-Gm-Message-State: AOJu0Yzlr7ov+qgtgCq2TBobHB+6SSPfQi3x0B8ZnF6uIP1iv1wAZc4R
	cPttGRo4SwxwC83ypIekcPdlJkreP8VSwhJMdafng45bUdykvVdMw87uqIjXiFTyyE1tRUC14KQ
	H9etpIPIy73G57GSZx659WJdKcqk=
X-Google-Smtp-Source: AGHT+IGTeCa7sBciFGIKw9lSR5iXHo9XhZkQYSeX+wTLh2+99nQ/NVnxgW7umWmBqjGIOJrmk/XvQBndl0kVBRInLGg=
X-Received: by 2002:a19:7016:0:b0:515:b06f:a89a with SMTP id
 h22-20020a197016000000b00515b06fa89amr782978lfc.38.1711502829855; Tue, 26 Mar
 2024 18:27:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1711346195-24555-1-git-send-email-zhiguo.niu@unisoc.com> <8a6b2768-8ab6-4275-8c4e-05b4eca83987@kernel.org>
In-Reply-To: <8a6b2768-8ab6-4275-8c4e-05b4eca83987@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Wed, 27 Mar 2024 09:26:58 +0800
Message-ID: <CAHJ8P3J3xK2uz7egvShyCeAjGFJ87AvqKxVN=NFiKDgMLMJDPg@mail.gmail.com>
Subject: Re: [PATCH V2] f2fs: fix to adjust appropirate defragment pg_end
To: Chao Yu <chao@kernel.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com, hongyu.jin@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 7:11=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> On 2024/3/25 13:56, Zhiguo Niu wrote:
> > A length that exceeds the real size of the inode may be
> > specified from user, although these out-of-range areas
> > are not mapped, but they still need to be check in
> > while loop, which is unnecessary.
> >
> > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > ---
> > v2: check i_size within inode lock according to Chao's suggestions
> > ---
> > ---
> >   fs/f2fs/file.c | 11 +++++++----
> >   1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index 128e53d..cf63db7 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -2608,9 +2608,6 @@ static int f2fs_defragment_range(struct f2fs_sb_i=
nfo *sbi,
> >       bool fragmented =3D false;
> >       int err;
> >
> > -     pg_start =3D range->start >> PAGE_SHIFT;
> > -     pg_end =3D (range->start + range->len) >> PAGE_SHIFT;
> > -
> >       f2fs_balance_fs(sbi, true);
> >
> >       inode_lock(inode);
> > @@ -2629,10 +2626,16 @@ static int f2fs_defragment_range(struct f2fs_sb=
_info *sbi,
>
> pg_start =3D range->start >> PAGE_SHIFT;
> pg_end =3D min_t(pgoff_t, (range->start + range->len) >> PAGE_SHIFT,
>                         DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE));
>
> >
> >       /* writeback all dirty pages in the range */
> >       err =3D filemap_write_and_wait_range(inode->i_mapping, range->sta=
rt,
> > -                                             range->start + range->len=
 - 1);
> > +                                             min_t(loff_t, range->star=
t + range->len - 1,
> > +                                             i_size_read(inode) - 1));
>
> , pg_start << PAGE_SHIFT - 1, pg_end << PAGE_SHIFT - 1); ?
should be  pg_start << PAGE_SHIFT , pg_end << PAGE_SHIFT - 1)??
if range.start=3D0, pg_start is also 0, lstart in
filemap_write_and_wait_range is 0,
but pg_start << PAGE_SHIFT - 1 will get lstart=3D-1?
thanks=EF=BC=81
>
> Thanks,
>
> >       if (err)
> >               goto out;
> >
> > +     pg_start =3D range->start >> PAGE_SHIFT;
> > +     pg_end =3D min_t(pgoff_t,
> > +                             (range->start + range->len) >> PAGE_SHIFT=
,
> > +                             DIV_ROUND_UP(i_size_read(inode), PAGE_SIZ=
E));
> > +
> >       /*
> >        * lookup mapping info in extent cache, skip defragmenting if phy=
sical
> >        * block addresses are continuous.


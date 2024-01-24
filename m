Return-Path: <linux-kernel+bounces-37116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDBA83ABB8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DCB728F036
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D608C7A72F;
	Wed, 24 Jan 2024 14:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="II6L0Wc/"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA6F7A713
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 14:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106500; cv=none; b=Omo0gSjHcdC54rRtRs3KRMWQY0OUKtMelipsnanbFz2ng68WVuEpY90LfkFq2z+9fcchV3ahVsSoZy39scj2fLCN35bzTB9Twz0D96OHQRuvxp4blBwmUErRfcqma+pmvemt/wWxezw/0C2ULzhhTNJdsjmiZIMt6uWHegmNBGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106500; c=relaxed/simple;
	bh=CNG0yxA64p/VfK+z7q8n8Bap5iF3fervA6gZqPmVuIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p26h4JMCqMbBiYkqK2pXyWts7d+RGvFy6AlSWh1qEg2hJlh4shJqLDpyZn00Dh+QkepnZKiJfs0QaTWDmG49IQ1ukBA/GfyM+e3Ixn6wKM9pm47GsDqSWh+UBoeLYmtFktvG29LITChSx/pKqU1v4YBG3Wieu39rWTMGCmc8Csg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=II6L0Wc/; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so600776566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 06:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1706106494; x=1706711294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qv0sDPq6uuAdBYOm6vYVHDFbzrz/5/gcuAOhRKbPfRk=;
        b=II6L0Wc/woRvjpYI6zb/5gm6ALdpy0YEjxJ/pyuTuFuXYBGAKsAuS3xXsxLRNHfpmx
         VjswC7cu7pafns5kKQcwdiK8fmuaHShk+2UNMaOxN1iPs9cu+zcHxSfxD5qHWS59i6XN
         BmUhyyRsjQoa9Pl3X6KS901UK3rPEcz8nxsUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706106494; x=1706711294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qv0sDPq6uuAdBYOm6vYVHDFbzrz/5/gcuAOhRKbPfRk=;
        b=TdRHhKJi9cQgIeE9tmbYoOTeLZIRJo7b1sIdnqXppl8VcIlXZlFiZgx+IEGw4LyVmZ
         kNLFazDvTpGmS36vTvu93hbB/KBTran2yjsvlAjypS1ziyJAA70QT2Tb2wRSkjzz3NFs
         xxdiuTJL1Mvgs8nRy6VTv5bGkzFlBbCCn0zeYJaTFO8zuqNZLfcD+y2zbhp40MbHhj5T
         /X95Lv73/HAmb8r62Kuin8Of7j7i9KllK/YF0E3ULkcJI3/UrYBR8VMYrfbJa1KIMx8f
         25rnKBsT4/VgTfJl0USOv9vuR6X5lUcZH9xCeNnA2G/rDc5dIVjzWtNXUKTfDz8NQuZb
         HHBg==
X-Gm-Message-State: AOJu0YxikhrpID7dUgE8lGdH99Ep0sy4Jho/5s2gtqUVOyVyFqEfCRLA
	qGahiKA8Z3dzE5BvaDxdTfrDzKNU64fqdnGjmitWVyvuqI22/nmQR0QlaBx7EP8+9JaAquD+pJB
	4qZZr5L8/e32jVnEd3vIIMLy3HjpGqgja01KJQw==
X-Google-Smtp-Source: AGHT+IE19WIGLtZTJnVM1fC+uAIt3JA8bmWYHhVJE0ZONKimsCsf7l4IahIqPSb/ScBjfSP2loTOOwBoqM8+IX7tXbo=
X-Received: by 2002:a17:906:4697:b0:a2c:4a17:1d66 with SMTP id
 a23-20020a170906469700b00a2c4a171d66mr1033777ejr.47.1706106494285; Wed, 24
 Jan 2024 06:28:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124113042.44300-1-jefflexu@linux.alibaba.com>
 <CAJfpegtkSgRO-24bdnA4xUMFW5vFwSDQ7WkcowNR69zmbRwKqQ@mail.gmail.com> <CAOQ4uxjN6f=M8jjM0-_eysLy8Jx1+r0Dy3MhWHc8f2r7RnEmdQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxjN6f=M8jjM0-_eysLy8Jx1+r0Dy3MhWHc8f2r7RnEmdQ@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 24 Jan 2024 15:28:02 +0100
Message-ID: <CAJfpegtBod6ECv6O0GVXhLSGB5OH6P=uOpMN6JjAm3C+Mrg55g@mail.gmail.com>
Subject: Re: [PATCH] fuse: add support for explicit export disabling
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jingbo Xu <jefflexu@linux.alibaba.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 24 Jan 2024 at 15:11, Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Wed, Jan 24, 2024 at 2:17=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu=
> wrote:
> >
> > On Wed, 24 Jan 2024 at 12:30, Jingbo Xu <jefflexu@linux.alibaba.com> wr=
ote:
> > >
> > > open_by_handle_at(2) can fail with -ESTALE with a valid handle return=
ed
> > > by a previous name_to_handle_at(2) for evicted fuse inodes, which is
> > > especially common when entry_valid_timeout is 0, e.g. when the fuse
> > > daemon is in "cache=3Dnone" mode.
> > >
> > > The time sequence is like:
> > >
> > >         name_to_handle_at(2)    # succeed
> > >         evict fuse inode
> > >         open_by_handle_at(2)    # fail
> > >
> > > The root cause is that, with 0 entry_valid_timeout, the dput() called=
 in
> > > name_to_handle_at(2) will trigger iput -> evict(), which will send
> > > FUSE_FORGET to the daemon.  The following open_by_handle_at(2) will s=
end
> > > a new FUSE_LOOKUP request upon inode cache miss since the previous in=
ode
> > > eviction.  Then the fuse daemon may fail the FUSE_LOOKUP request with
> > > -ENOENT as the cached metadata of the requested inode has already bee=
n
> > > cleaned up during the previous FUSE_FORGET.  The returned -ENOENT is
> > > treated as -ESTALE when open_by_handle_at(2) returns.
> > >
> > > This confuses the application somehow, as open_by_handle_at(2) fails
> > > when the previous name_to_handle_at(2) succeeds.  The returned errno =
is
> > > also confusing as the requested file is not deleted and already there=
.
> > > It is reasonable to fail name_to_handle_at(2) early in this case, aft=
er
> > > which the application can fallback to open(2) to access files.
> > >
> > > Since this issue typically appears when entry_valid_timeout is 0 whic=
h
> > > is configured by the fuse daemon, the fuse daemon is the right person=
 to
> > > explicitly disable the export when required.
> > >
> > > Also considering FUSE_EXPORT_SUPPORT actually indicates the support f=
or
> > > lookups of "." and "..", and there are existing fuse daemons supporti=
ng
> > > export without FUSE_EXPORT_SUPPORT set, for compatibility, we add a n=
ew
> > > INIT flag for such purpose.
> >
> > This looks good overall.
> >
> > >
> > > Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> > > ---
> > > RFC: https://lore.kernel.org/all/20240123093701.94166-1-jefflexu@linu=
x.alibaba.com/
> > > ---
> > >  fs/fuse/inode.c           | 11 ++++++++++-
> > >  include/uapi/linux/fuse.h |  2 ++
> > >  2 files changed, 12 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > > index 2a6d44f91729..851940c0e930 100644
> > > --- a/fs/fuse/inode.c
> > > +++ b/fs/fuse/inode.c
> > > @@ -1110,6 +1110,11 @@ static struct dentry *fuse_get_parent(struct d=
entry *child)
> > >         return parent;
> > >  }
> > >
> > > +/* only for fid encoding; no support for file handle */
> > > +static const struct export_operations fuse_fid_operations =3D {
> >
> > Nit: I'd call this fuse_no_export_operations (or something else that
> > emphasizes the fact that this is only for encoding and not for full
> > export support).
>
> Not that I really care what the name is, but overlayfs already has
> ovl_export_fid_operations and the name aspires from AT_HANDLE_FID,
> which is already documented in man pages.
>
> How about fuse_export_fid_operations?

Okay, let's be consistent with overlayfs naming.

Thanks,
Miklos


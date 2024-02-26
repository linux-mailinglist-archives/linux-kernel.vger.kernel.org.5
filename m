Return-Path: <linux-kernel+bounces-82073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CB5867EA9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35A5B285299
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B95E12F394;
	Mon, 26 Feb 2024 17:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMV1Kk5s"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA5112F36D
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 17:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708968827; cv=none; b=L3K7MlkYmi8xPyHZg0tARmq8WERcI+TGpVwDvaAk/yBvbqtkRd8lvWJOlXsl1QZCpXMhfy3nOSh/yUZkBQDRfL95GTpswcWlkbNliSXGVaE5Cj/YHom11wQiA776boJLMxs9VvPWjuI90YYk13mXheGsOb3tdBJf8uz5YxQ5JKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708968827; c=relaxed/simple;
	bh=1jx/w99Yn7u3jjX/SSipjJanjYCHGd441Q+rqpRw4FQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d9JiPHhORdPt4flvM+nUEczw32yUPLC2rlgD2wx45jMT5K7biMUl3bIIG9uEz0gr02K+eiJP4XPTuHsIHtdZyePgCA7U4zLgLSy9Ryz5llOUeX+qQHNmYAearjCFcfO1HzdXpy8/qMMvtMoql0Vktax44CbT2+mZNqaGnAloesk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMV1Kk5s; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7d5fce59261so2171880241.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708968824; x=1709573624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjCc/IhW4VTH60NHsQaSy5PBjw8dYdxVYEZhXVSvdM0=;
        b=YMV1Kk5sPbSXCBdnvNco8ps+iJ8oJGJlRS9IwMB1r7j8ruMIhOA6NWrrRxN2joCKgr
         dfxv6k/SilehKRB0aCSwBJ5EVxYJCX7/YGtW6/4aygH1pVf3Id9TnU6F3S0a9d0nsp8J
         /5vAAmeLskmwbXj6VrhC2KUxK9rBwjsazHP+6g0dYHp0SX+DT8tfXodgSQpJfl3uKB43
         HKt5gejvfSk5UWofyMULTzRwqL9AIG1SosOSxCi1ta2SLjb8R7FGHQqFYuyEM3yBV4L9
         reHqKs6X8YqR7789GHbkPU726Tis6RkfKMKHqmqJ1NcCPClMFokJjY4m7hTLQ70vLqAt
         eGYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708968824; x=1709573624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HjCc/IhW4VTH60NHsQaSy5PBjw8dYdxVYEZhXVSvdM0=;
        b=xFLE+DilzTAg1D5QUoEy1+n0x0tsoZqrZx0vuoQEM4amx74mHf9n3JOdmduaHYiBVo
         VaFbVGKR9+23lLO8rMHzsvDmtMy+ZtR3q/JTZSTYXdJCCpBu7SoW6a/vbtDYjlxUWmry
         duCtx4XHmwJer51/JnOz7ESFXgJzyXrYR5Xu+30qLEysnDm6U1pa+7OwQS+MnjvlYFLE
         oajhk1nz+g+5x6EcwtFJHWbAceaVV+waPTX58rcLVXaUdG6tfJ8yncMC1Jb20p3lPbzQ
         3egLumbejb+/t1OWX7iOC8V6+cFVQQB3P4Jlvqs2wSDdDOyOF9X7Aj/BXW5POMfyzVk+
         UmVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXp+XrP+KBFqoJSuinVGnmJn5eiCpnv82Dn4ns13kTDlreFNGRvBHlMdWpZo5QcU7muDkbWKV6a1Ka9E+H9Vtx/YnKKgpCpyCQtFM7
X-Gm-Message-State: AOJu0YzYJsLIrnoK2GjQY+IYLU32+onvmAf6N2fooZ6F6t7xu9bNqn93
	wqtv3LkCCBFG8qfd+l7bUV1lSnwLzQerGw9O3acmMlxjVJ4mpwMN+UJPeIyvvl6HBRI7Bk1t2EY
	A+59NheGRtYIHb8Vs4pYQ/4T54Jw=
X-Google-Smtp-Source: AGHT+IE8aT3V9/49fcrreBfpVmvC8OUSrXl4/G0plOnQ6n3oR8khT/JxwxSf/hKKF12BY5k9VgG9CXylUMW6dpExJgg=
X-Received: by 2002:a1f:c607:0:b0:4c8:8025:f451 with SMTP id
 w7-20020a1fc607000000b004c88025f451mr4256308vkf.12.1708968824456; Mon, 26 Feb
 2024 09:33:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223205535.307307-1-jaegeuk@kernel.org> <20240223205535.307307-2-jaegeuk@kernel.org>
 <68e95cb8-9bf5-4849-befc-bbbe8becfd68@kernel.org>
In-Reply-To: <68e95cb8-9bf5-4849-befc-bbbe8becfd68@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Mon, 26 Feb 2024 09:33:33 -0800
Message-ID: <CACOAw_yXZM6MsPpMYWeDSsOgehGSR3=OQc3aOjfMSF8xvn3RpQ@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH 2/5] f2fs: fix write pointers all the time
To: Chao Yu <chao@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 25, 2024 at 6:49=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> On 2024/2/24 4:55, Jaegeuk Kim wrote:
> > Even if the roll forward recovery stopped due to any error, we have to =
fix
> > the write pointers in order to mount the disk from the previous checkpo=
int.
>
> Jaegeuk,
>
> IIUC, we may lost warm node chain once we allocate new section for all lo=
gs,
> should we give some notification in log to indicate such condition that
> filesystem doesn't process a full recovery flow?
>
> Thanks,
>
> >
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >   fs/f2fs/recovery.c | 2 +-
> >   fs/f2fs/super.c    | 2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> > index b3baec666afe..8bbecb5f9323 100644
> > --- a/fs/f2fs/recovery.c
> > +++ b/fs/f2fs/recovery.c
> > @@ -913,7 +913,7 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sb=
i, bool check_only)
> >        * and the f2fs is not read only, check and fix zoned block devic=
es'
> >        * write pointer consistency.
> >        */
> > -     if (!err && fix_curseg_write_pointer && !f2fs_readonly(sbi->sb) &=
&
> > +     if (fix_curseg_write_pointer && !f2fs_readonly(sbi->sb) &&
> >                       f2fs_sb_has_blkzoned(sbi)) {
> >               err =3D f2fs_fix_curseg_write_pointer(sbi);

We might overwrite the previous err value here with a new err from
f2fs_fix_curseg_write_pointer().

> >               if (!err)
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index 2e41142d07c0..4d03ce1109ad 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -4673,7 +4673,7 @@ static int f2fs_fill_super(struct super_block *sb=
, void *data, int silent)
> >        * If the f2fs is not readonly and fsync data recovery succeeds,
> >        * check zoned block devices' write pointer consistency.
> >        */
> > -     if (!err && !f2fs_readonly(sb) && f2fs_sb_has_blkzoned(sbi)) {
> > +     if (!f2fs_readonly(sb) && f2fs_sb_has_blkzoned(sbi)) {
> >               err =3D f2fs_check_write_pointer(sbi);

ditto

> >               if (err)
> >                       goto free_meta;
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


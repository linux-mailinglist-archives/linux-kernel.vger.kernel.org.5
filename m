Return-Path: <linux-kernel+bounces-98514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01670877B4F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 08:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0A53281287
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 07:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E3510796;
	Mon, 11 Mar 2024 07:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqOMGGwH"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A181C20
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 07:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710141981; cv=none; b=KhdU869s+asGSltRWORqKeIutmz19X94I/YY1fkoSrnvPi2e08IqgRF1mDPydMrW3gFNUtW+s5D5qaxZs7z2lht3QTethUDuiYX4MW7bSiyLGyzSTVgEXLsLlik9T1FlRJB9X7p6AFsnP9QauuX/mkRMf55tmF9CML7WKazPq7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710141981; c=relaxed/simple;
	bh=4A1Ch0SnOg2vriHO4K6Az87fQ2K5aKoZjo2rqINki10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=doZjGDei4AUbj0DQGy445DZgAx5aMka9zArUMVWZinO5yS1KDSbTen8wjIODkxn5JI/umYuQl9DhRZqrn2AOPushJA0VTehyeEHaVEHooYsWip8wINlj6OzG/1a+OPQmj/5JZlBmLzWPkEhlsNfnIFW0V5cTFkhZ4NKvQotjhn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqOMGGwH; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5682360e095so4258781a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 00:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710141978; x=1710746778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWkn4Jgv2vGWKej5ZM1NioOSMWReqWi9UHuS9WHYkl4=;
        b=EqOMGGwHfe4zytqQdHkFJqe0UW3dFKCCWDtXidiLqNFwuJS1TQ2/nQJSmZFj6Xq3vu
         TpoKwr4QTqRLKbOds/fDrPhKnKh13KP3pNpY6NP1Db/+HPoOJcV868VhKO2MDaa2Wu6U
         VilQqbmuwOYZt5Zuy2TV/sQLyaYGY/UAE8hDGbXIPwLMvwpE/I8iiwXuYYDkFfjGqM9u
         B2WpGpzG1Z7ZEMDXj1K3Sgd/z9RR1Ahvo/QRm6DR51RTHH31lVPZUct337jcL80lZdMq
         VxiYjcfrfA+3zXDpmucB3IwpBMSGV1wUGSYert6hKR/IY2XAE6niq3WgYpf5lXF427dn
         noag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710141978; x=1710746778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWkn4Jgv2vGWKej5ZM1NioOSMWReqWi9UHuS9WHYkl4=;
        b=HyBQx9UUVXtOSymst3iPytnA4TzleFFT4Iol5jk5qFj3i7IW2NHXap5J7u8xDhhYc9
         x7O6bKNGziTK/sfFR7t/NIlrSIrsES6EPywR92M6YYywPdEkhhjomqjJ7fWizhgqxd9L
         N3VGHbX+VyIj+na/CKKPWAGGJRhheungzYo2Qd3oo4KZ0YcbG1dFA/Dx0H/6WoOrmvk3
         TL2IrZrpGJ2jwckXERsZ6PoRlBSekyTMDuQpxuXxxcNHsyp+0JfB8UGPixZQaY2KpuLk
         UI7UuI/gtNX0Rn8Weu9IC3d3Boxrac6+ia6Re6BsoiiYyIgejYZ2H0aiYKgzv+cfVq7v
         ZJog==
X-Forwarded-Encrypted: i=1; AJvYcCWm2rQ/iozSfWf6CcKCcepvfyVzoHPXbBSWf3Q22ANDtwqyJVwq6IvBNlEIY2d8I3rOnpw6ElJY+ARIoZryxWqCgsMIesdWBOujKpg6
X-Gm-Message-State: AOJu0YwZ6OkeFjc6O6JDLWROqdJzkFhSapAObFTrw9O7S9xBSjkS4Wne
	OPOkT9zkRNrv7ofeDxpBXJptPT2HKaGvxnRI6NOUKPe4XLK2F63EU38V3Cy/lUrM2KDin6EJ09Z
	9g20Z4yASjQmNUwX3OPBXs2Gr15I=
X-Google-Smtp-Source: AGHT+IHlIrKxTq7vP0MeJ2GvPvVKvxoi93bl1RTM4o8dFr26YTt7kFx/WqKjoksumG4QiKtPySZp1LqDHt/GHwhn0II=
X-Received: by 2002:a50:bb4c:0:b0:566:49f4:c538 with SMTP id
 y70-20020a50bb4c000000b0056649f4c538mr3608881ede.34.1710141978051; Mon, 11
 Mar 2024 00:26:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1709892753-27461-1-git-send-email-zhiguo.niu@unisoc.com> <67a7f35d-5cc3-4b5f-968a-e4151c63eb74@kernel.org>
In-Reply-To: <67a7f35d-5cc3-4b5f-968a-e4151c63eb74@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Mon, 11 Mar 2024 15:26:07 +0800
Message-ID: <CAHJ8P3KnG6OmjeCq2JE6z-xXVbqjVU=pR+3A9Fz6qgELkeq90Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] f2fs: fix to remove f2fs_bug_on in add_bio_entry
To: Chao Yu <chao@kernel.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com, hongyu.jin@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 11:54=E2=80=AFAM Chao Yu <chao@kernel.org> wrote:
>
> On 2024/3/8 18:12, Zhiguo Niu wrote:
> > add_bio_entry should not trigger system panic when bio_add_page fail,
> > fix to remove it.
> >
> > Fixes: 0b20fcec8651 ("f2fs: cache global IPU bio")
> > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > ---
> >   fs/f2fs/data.c | 6 ++++--
> >   1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index d9494b5..f8ae684 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -759,8 +759,10 @@ static void add_bio_entry(struct f2fs_sb_info *sbi=
, struct bio *bio,
> >       be->bio =3D bio;
> >       bio_get(bio);
> >
> > -     if (bio_add_page(bio, page, PAGE_SIZE, 0) !=3D PAGE_SIZE)
> > -             f2fs_bug_on(sbi, 1);
> > +     if (bio_add_page(bio, page, PAGE_SIZE, 0) !=3D PAGE_SIZE) {
> > +             bio_put(bio);
>
> I didn't get it, why new created bio has no space to store one page?
>
> Thanks,

Dear Chao,
I got what you mean.

We are doing bio merge optimization in bio_add_page.
After looking at all the locations where bio_add_page is called,
and think it is unreasonable to panic the system if bio_add_page fails.
but it is not impossible to panic in the current flow about bio_add_page.
so keeping it as is is a good choice.
thanks!
> > +             return;
> > +     }
> >
> >       f2fs_down_write(&io->bio_list_lock);
> >       list_add_tail(&be->list, &io->bio_list);


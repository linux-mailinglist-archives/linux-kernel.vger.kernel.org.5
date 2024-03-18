Return-Path: <linux-kernel+bounces-106678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CAD87F1D8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6D681C20D21
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBE35915F;
	Mon, 18 Mar 2024 21:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2Gn5PCP"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E89D59140
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 21:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710796361; cv=none; b=bJFm7xbjvu5mlJfQmq+stCdybMa1i07dvQ1xqdZjoY0cjlcoeBbAlVJ7QUJ7BykuYAmGvko1hRdRgQobk+AJGd7zT0doerailK8zEJks+oTt39yMt+FMaLkp4e2Rw+jd+CaJ2Qy5a5ySaD5SvI8I9KPYPd/XcNdiaGD9EAkf1+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710796361; c=relaxed/simple;
	bh=3YjLqajLJ5T3EW8Lu9X/xeHWJ+3fF1/Ew3tqQVLC2xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VpuvEtp4pMoXANqnIus+UhvhnH0NzhjA2M76AxguagbBy6ZSGfYNh5qBpLBB52f0xTL2tIAuX3fANI+4Te52kdjfr+4CK+SB+FNu9/gesRH3X7QaeKUjIrNa1UTMDpcTdPv36KgDP+YrkNFo5YibaGukPY0x55CLTFtzGjoLBSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2Gn5PCP; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4d452e2f0aeso322224e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 14:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710796359; x=1711401159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zlB2IBskv+pb6Y21WlslfXrWn1gChW7bUWNPd3xKciM=;
        b=L2Gn5PCPRPqgQM2RgQ1lqmCfiWNavO2mna2vjkGS9J6Hyfn3yAcc7S6/csB1So3L2m
         TiQqe5OrXp8oln7MEO5u1Zb9V6Tak2XRhSw7XwMeyi3N80/G2gTo+ZhU6OluEcIcihb5
         nE0oq1VmjSfo8pCjmilspH1TkGyH5q2FqskBJmJANfzCIzTsRBwaIw/vGJDDem9k/quX
         Q5q8uqcQLQRf25dV2yG7xfY3zdMuXj1UvvpyhrUfryWBH0dS0elT60s0vlBdBjZ5z2YF
         NUSUILsvaepFbPNdFkIf/jjq+nRefH6hF/PYYPp2d6nm/iJDFLk2a80cxFk11nKlTEST
         jQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710796359; x=1711401159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zlB2IBskv+pb6Y21WlslfXrWn1gChW7bUWNPd3xKciM=;
        b=pGhI6dklDN7YOB94Q7pShgi+0GXBAUuo3A5i2wtux9QgeMQ+dSDuCZXQQoyVi+ngbp
         uixCXOxGgZ+eqLr4+XZSWsNBXi0rFKxyn4nF9r9D0qVZtgTqUxqzhgX/EVjw5DzwGfid
         9bC4fACzmi573ytdWmVjGLsbiUNIewPezibgXkKjbQW4tlCuYzLvqWwXXSGeZZDSCDOp
         UOlZ52ujGd5L1xL8YlRFmpp2rPCsMdE8cMtWYol/VIjgw71HToLh1VV6j+gCtvwtsL6E
         qZy4u7Xh7SXQ0bxLPz6kAgxemTlNKSfk+6/I+iAVrHm8Lwbrh9hd/rQpij68QOfJh5O9
         sxcA==
X-Forwarded-Encrypted: i=1; AJvYcCVeL9oXXY52dllsO4819bsvsq8E8KHvCZzOPUTYc23LwZywwB9WiQPfOXrwALlrnahCuAbsBdR2sxhqEuo9TA67p2TAftSYH+Od4VRz
X-Gm-Message-State: AOJu0YyVwuLsKUDxtxmVgmMA35h9n5krkKuBGp72w4Sh9UJt77vgdoj6
	XD35tVnOenrwQDu+Y/RmXDynamKWtEEns1pJc4kZATM+SwlvmRkxNPfHmDz2mN1gGqs0i5r2NYj
	/zqjhZTOr05loliriKqrjBENnQwTqIBpI7QI=
X-Google-Smtp-Source: AGHT+IH6nNI7kAYp9hdUHVHAEoerdfDrfXI1sQHCSXBSe302uiu29a/CWmWw7OpFggD4+7kus4h7qpPmoMuEozc1OXU=
X-Received: by 2002:ac5:c7b7:0:b0:4cd:b718:4b08 with SMTP id
 d23-20020ac5c7b7000000b004cdb7184b08mr7207012vkn.11.1710796359326; Mon, 18
 Mar 2024 14:12:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000bbb3d80613f243a6@google.com> <CAKEwX=MAX0km1p43DQmKbeSy2G4dPFHiF+deH_qzqygc2Vnjig@mail.gmail.com>
 <CAGsJ_4y7aFg3FBh_isa_TCqY1B8n64Rro5mVu6=wvk7FP35mWw@mail.gmail.com>
 <CAJD7tkaPmgsUjPCi0wKCYAmPb+Vnif_zS+ouyd9NGQN=mdhJPw@mail.gmail.com>
 <CAGsJ_4xyDm0BLYvbW0z9J-Q=sQPYrttva33g2mRFVXcJJ+wimw@mail.gmail.com> <CAJD7tkaP_wfkJG_dfsp-jV7QP2JWyMFfNApTFPWbsqmTvfKyLw@mail.gmail.com>
In-Reply-To: <CAJD7tkaP_wfkJG_dfsp-jV7QP2JWyMFfNApTFPWbsqmTvfKyLw@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 19 Mar 2024 10:12:27 +1300
Message-ID: <CAGsJ_4yKHYsPomhjnmdoWPSes_M5+8ZxvPry+X78pA5Kj_F_Jg@mail.gmail.com>
Subject: Re: [syzbot] [mm?] kernel BUG in sg_init_one
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Nhat Pham <nphamcs@gmail.com>, 
	syzbot <syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, chengming.zhou@linux.dev, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 10:00=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> [..]
> > > > I guess that is because on arm32 , we have highmem but
> > > > sg_init_one supports lowmem only. the below should be
> > > > able to fix?
> > > >
> > > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > > index 9dec853647c8..47c0386caba2 100644
> > > > --- a/mm/zswap.c
> > > > +++ b/mm/zswap.c
> > > > @@ -1086,7 +1086,8 @@ static void zswap_decompress(struct zswap_ent=
ry
> > > > *entry, struct page *page)
> > > >                 zpool_unmap_handle(zpool, entry->handle);
> > > >         }
> > > >
> > > > -       sg_init_one(&input, src, entry->length);
> > > > +       sg_init_table(&input, 1);
> > > > +       sg_set_page(&input, kmap_to_page(src), entry->length,
> > > > offset_in_page(src));
> > >
> > > Is this working around the debug check in sg_init_one()? IIUC, only
> >
> > I wouldn't characterize it as a workaround; it's more of a solution.
>
> I assumed that the debug check in sg_set_buf() is because
> sg_set_page() cannot handle highmem pages, sorry if that isn't the
> case. Apparently we are hitting a warning with kmap_to_page() though
> as syzbot just reported.
>
> >
> > > lowmem pages are supported. We may be passing in a highmem page to
> > > sg_set_page() now, right?
> >
> > we can pass highmem to sg_set_page(). This is perfectly fine.
>
> So the debug check is only because we are using virt_to_page() in sg_set_=
buf()?

yes. it is checking if linear_mapping can apply on the buffer.

>
> >
> > >
> > > Also, it seems like if src is a lowmem address kmap_to_page() will be
> > > doing unnecessary checks (assuming it's working correctly)?
> >
> > In practice, we consistently use kmap and kunmap even on systems with
> > low memory.
> > However, it's worth noting that for low memory scenarios, kmap
> > essentially returns
> > page_to_virt(page_address). Thus, the overhead of kmap_to_page shouldn'=
t be
> > significant on low memory systems, especially considering that it simpl=
ifies to
> > virt_to_page().
> >
> > Another approach is to consistently employ page_to_virt() for low
> > memory situations
> > and reserve kmap for high memory scenarios. However, since we always
> > utilize kmap
> > regardless of whether the page is low or high memory, we don't need to =
concern
> > ourselves with this distinction
>
> I see. Thanks for elaborating.
>
> >
> > >
> > > Would it be more robust to just use the temporary buffer if src is a
> > > kmap address?
> >
> > I don't think so because we will need a memcpy then.
>
> I thought that was necessary because sg_set_page() cannot take in
> highmem pages, but you mentioned that this isn't the case.

I think both sg_init_one() and sg_set_page() lack docs. as apparently
sg_init_one() can't take highmem. sg_set_page() can definitely take
highmem as crypto/scompress.c takes care of both high
and low. and scatterwalk_map_and_copy() can handle both.

Thanks
Barry


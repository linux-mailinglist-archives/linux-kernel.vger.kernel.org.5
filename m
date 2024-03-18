Return-Path: <linux-kernel+bounces-106631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EA387F132
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39AAD284458
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC77249F7;
	Mon, 18 Mar 2024 20:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SdLDBBUh"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F066B1862C
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 20:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710794132; cv=none; b=jsuZdbtp11aZw30JWE06lC7emxX8usMmR0s5RTJmE9TGsRYxlKkOXA8f7ByJPziuoxoM/SL/sGOTEL4dE9KMiRe8VzaYPOBmCGlYhlLFDXm7NRx8cDqVg2T4C6/A8E+BiPPCzV3qr+qBuwnX+IQcUe1NzcuVG4GHBHOmU+X67ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710794132; c=relaxed/simple;
	bh=0KlFaugblY0RG/JMeoq+qlMxJs2HBMsCvC4ogmRFe3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nXNAcC8873drndYAh5riMnca44S7PWS0VTP6T74ANZR9xGHAMHXlxdrYGHv6r3wxyGMlfhroK0c2AM9B6bi2HMM3byKP6aBnWiiYPkdazNH/Jy5UsuXk4nU608OUnLVuHBrUeGm7v9wtT9TYnKAJCMPulRe0gEc+kYj2XaqLPIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SdLDBBUh; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a46db55e64fso2987866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 13:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710794129; x=1711398929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x5BUKxjEnp0SlFbo7OxBR2+MgOTG/OdBxN7WM985RJk=;
        b=SdLDBBUhs6YWh+VANncJZ0NKfD7ho6h5dl/gEOhfnssD5kt6zXtnwzDyOeVKqoOZTT
         ZW5aWVUw8VG9c+LAQtEkeXv5j1qUBmBEWGwryJTu3sUsc/+LShYe2tknRDctAlefEw3J
         NsAFiijlPUpepaWmHVXtQbXCKf9DK2/5hE7Jv/0vtoW8qw+h5d2vsu5Kyp3GwWZ72H2G
         IY4FIoy36tc/UjcQjSoBWm26egLj8e/O3lni9xf9n83w4SC4b1VMGzPTGpB1ybABzpjE
         mKg/+aS61Gv3oJTm0aMdCB/LuGjQqKPUFUUjQ+DMC581X6N5jrTOArAqOZ2thgIu6a2u
         XtKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710794129; x=1711398929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x5BUKxjEnp0SlFbo7OxBR2+MgOTG/OdBxN7WM985RJk=;
        b=a7q8LGsYz5mccjB0jgn5F5fwD7eZAZDe/Izi+D30fB0+dHxfjVzJo6dySaSZcF60CT
         QxnB/ANhqnos9ZJlEIkrIR7Q6R1LWvFdtD2jZeW77F1p+7QelQBMoLJclG2uI3jaL20p
         YznKr76KZlcZv0RYfDmA5bAZcT1+GA+fzjtCcYd/Eov2UYrDYtCC7dxB9b5fGX3dqYxu
         SXeD0NGK1phSMDK0GUQ+lz92OWwqW+foaiiBgL9fQl4X+NjSZ1XodSMME2G0PHaOBYjB
         ovRrGGhl3JcrV4tj0gwj6YlFUbSZVMbBBl+/iLnuh/j6X2pHesDQCVWZDq94n5CsGwrF
         a3kQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGTsP8KnjPch8As2H+eogShopZd4mkexjOdtwV5tgOx6U5+6clsn2v31L1Jn2SZjTDoWrhk9j8utbVGShYuMKqpVeQHvPaKin2OAVl
X-Gm-Message-State: AOJu0Ywsk95WqjPgn/sFtY7R2TnJJHkCStHH7q2a/nKYoh8eRoAfWwHn
	RmS5nUit90ryYFpX7TX8aeIpNhec7b3UKHvh596Ruq2ewRFvQk606PolH55QZ4p/YnqXD2vu5oW
	iNB6YMtGqHWd/0IDg/pRhzek3sAw2w7v+2KCO
X-Google-Smtp-Source: AGHT+IEfA8uNHoyZHC8a5dMsN20mTU0Fb48nkHfeZIdgAvI/ZuuR+1ELW7nIy3FSvWU96PSYY1HHPdrLW5wIatuJ1ao=
X-Received: by 2002:a17:907:7a93:b0:a46:74fe:904f with SMTP id
 mm19-20020a1709077a9300b00a4674fe904fmr9931408ejc.26.1710794129097; Mon, 18
 Mar 2024 13:35:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000bbb3d80613f243a6@google.com> <CAKEwX=MAX0km1p43DQmKbeSy2G4dPFHiF+deH_qzqygc2Vnjig@mail.gmail.com>
 <CAGsJ_4y7aFg3FBh_isa_TCqY1B8n64Rro5mVu6=wvk7FP35mWw@mail.gmail.com>
In-Reply-To: <CAGsJ_4y7aFg3FBh_isa_TCqY1B8n64Rro5mVu6=wvk7FP35mWw@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 18 Mar 2024 13:34:50 -0700
Message-ID: <CAJD7tkaPmgsUjPCi0wKCYAmPb+Vnif_zS+ouyd9NGQN=mdhJPw@mail.gmail.com>
Subject: Re: [syzbot] [mm?] kernel BUG in sg_init_one
To: Barry Song <21cnbao@gmail.com>
Cc: Nhat Pham <nphamcs@gmail.com>, 
	syzbot <syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, chengming.zhou@linux.dev, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 1:25=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Tue, Mar 19, 2024 at 7:00=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wro=
te:
> >
> > On Mon, Mar 18, 2024 at 9:58=E2=80=AFAM syzbot
> > <syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    e5eb28f6d1af Merge tag 'mm-nonmm-stable-2024-03-14-09=
-36' ..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D13043abe1=
80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D19bb57c23=
dffc38e
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dadbc983a158=
8b7805de3
> > > compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU =
ld (GNU Binutils for Debian) 2.40
> > > userspace arch: arm
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1706d23=
1180000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D13ba79591=
80000
> > >
> > > Downloadable assets:
> > > disk image (non-bootable): https://storage.googleapis.com/syzbot-asse=
ts/8ead8862021c/non_bootable_disk-e5eb28f6.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/0a7371c63ff2/vm=
linux-e5eb28f6.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/7539441b4a=
dd/zImage-e5eb28f6.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
> > > Reported-by: syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com
> > >
> > > ------------[ cut here ]------------
> > > kernel BUG at include/linux/scatterlist.h:187!
> >
> > Looks like the provided buffer is invalid:
> >
> > #ifdef CONFIG_DEBUG_SG
> > BUG_ON(!virt_addr_valid(buf));
> > #endif
> >
> > which is "src" from:
> >
> > sg_init_one(&input, src, entry->length);
> >
> > Looking at the surrounding code and recent history, there's this
> > commit that stands out:
> >
> > mm/zswap: remove the memcpy if acomp is not sleepable
> > (sha: 270700dd06ca41a4779c19eb46608f076bb7d40e)
> >
> > which has the effect of, IIUC, using the zpool mapped memory directly
> > as src, instead of acomp_ctx->buffer (which was previously the case,
> > as zsmalloc was not sleepable).
> >
> > This might not necessarily be a bug with that commit itself, but might
> > have revealed another bug elsewhere.
> >
> > Anyway, cc-ing the author, Barry Song, to fact check me :) Will take a
> > closer look later.
>
> I guess that is because on arm32 , we have highmem but
> sg_init_one supports lowmem only. the below should be
> able to fix?
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 9dec853647c8..47c0386caba2 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1086,7 +1086,8 @@ static void zswap_decompress(struct zswap_entry
> *entry, struct page *page)
>                 zpool_unmap_handle(zpool, entry->handle);
>         }
>
> -       sg_init_one(&input, src, entry->length);
> +       sg_init_table(&input, 1);
> +       sg_set_page(&input, kmap_to_page(src), entry->length,
> offset_in_page(src));

Is this working around the debug check in sg_init_one()? IIUC, only
lowmem pages are supported. We may be passing in a highmem page to
sg_set_page() now, right?

Also, it seems like if src is a lowmem address kmap_to_page() will be
doing unnecessary checks (assuming it's working correctly)?

Would it be more robust to just use the temporary buffer if src is a
kmap address?

Also FWIW, I think you can use "#sys test" to check if a diff fixes the pro=
blem.

>         sg_init_table(&output, 1);
>         sg_set_page(&output, page, PAGE_SIZE, 0);
>         acomp_request_set_params(acomp_ctx->req, &input, &output,
> entry->length, PAGE_SIZE);
>
>
>
> >


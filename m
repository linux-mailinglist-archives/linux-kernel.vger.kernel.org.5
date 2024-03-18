Return-Path: <linux-kernel+bounces-106623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E5987F119
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ADBA283ECC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BC558224;
	Mon, 18 Mar 2024 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZzyZL4p"
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA33158201
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 20:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710793525; cv=none; b=FPoWtvYv4zXKUrHMbpRgXjOtKyASKXYgIm+oCtCgV+pFpffbDifKAJFOmoCEJB1MkcU23hDeSCNfvUYNZYpKg0tC7i2UUlSRowS10Hy/GsGXlVrx4pnCj+asUMIVvJW2EyBaS/DkCQQ95VKcNb/0MrzgilfKHVmeBlz2eLOHdIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710793525; c=relaxed/simple;
	bh=Qb5PtJbv+LWEYgdVtG6iXUBoTHAx6rVZJO7TcJA7ugw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t40hxH7MpdNNPMggxfrZxspBLdyk5LqoDHOoiZme5TKan7ljj+tEsgFns8fvtw89MfXFk2biJr6WztiNFFsdphCY/ltqVUyl4imx8p4NJxMV2wbV329v3UoZf4EugFGW8QKO/ItJb1hGor4VMe+wRfVIapn5s0Pioy/BXmUZcDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZzyZL4p; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4760fe9c282so1527082137.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 13:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710793522; x=1711398322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yh13/+xplAtGooEGPkIeg18n7lJuselZGYLiwqNgbTg=;
        b=GZzyZL4pu83QOn92VBE0B9H5gu68w3VMfOv9lgbIVlwe+ULhaWWNf5MbgxPesLIFk7
         VYQ5Q2B71w+10KgHqBdCxaxoroVkgp45DtOWZtQwZX4YP8jaZnUTQl9fPwrSEfaSJiQZ
         KmB0RLVDVkmNi7O5Tgm1D3sYCnEkpPRndtWamAE+bP92X9ln2HjehXbYpMMfjI9NxQwe
         WFCTtr4crzPBIFBVW34B/nP9GLxNjlHCKqiIhy1sIDaBWq9v4UQy82tgWm2iuh1maleX
         UXRv8KusUb81Rr6yr3/RsjcxabDB+Y9HTx5xGstHfQNTTot+uTu3TyBN8kvkftbEwCaw
         MaFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710793522; x=1711398322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yh13/+xplAtGooEGPkIeg18n7lJuselZGYLiwqNgbTg=;
        b=D1rXlgKxXPnkYIVprzNnkwxjEWjgzzWGTmpzqNBhHhednG2FZHKJwNLEN8wi5pR9qr
         C0titaMWsfk7WS6GXcd/s4iOawDLwEkYRrVAPPzosQ7Ilsm6LM3uMZjvjWANj7nZyEXP
         /Lsx6RZlLDxlnoyqiCl94D3yNvBw4anZlglu3z40oQ+/9CHSK1vd8vLUBqKX9w5fB3oT
         HGVYKzngoh5+cCdWQWsbZrOM4YbfEqQMw9qjp8bTyZEpuiRb9tMpVZ/B99oxdqe9TAvZ
         8Xoo4VlzMphnVY3GDjao/g1gIdg8KH4Tpmp7YhnZovqgpRyQ9OJ8RnO4zrcNYd2a+0/A
         EpOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnhucpEQa3Czsq7jFCdHPxa9NVJc8sBhajQ2/xbq4Jgq4ZIeJgKU3mVDw8nhcd9Sf9OmenBzzMzf4u7194peEyaHmfQiM8P7+5lDZl
X-Gm-Message-State: AOJu0YyYR5AFooY8ssif9cbYbVjRvgQHQ70r/6gIXw6wvwEUk4OTNKtt
	Hx22LBYE5WiUCxKFcOElnxfsAptKCobTwsJ0cnd9FWArRbiakvb11YcqUS84yw60oO7U07OCAeh
	4Ky/rwVQEsNslOIu26UiQ39efaAPegmzhme0=
X-Google-Smtp-Source: AGHT+IHD+hGP/ZN8Jo+jvJKOM89hWwYxhbzHH5KX8yOZkQv9N4xi/9XSZZLwCnxJaXCwqOIP+t2YDTUGZUKmUo9UWvc=
X-Received: by 2002:a05:6102:216d:b0:476:9727:b810 with SMTP id
 i13-20020a056102216d00b004769727b810mr1611089vsg.35.1710793521127; Mon, 18
 Mar 2024 13:25:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000bbb3d80613f243a6@google.com> <CAKEwX=MAX0km1p43DQmKbeSy2G4dPFHiF+deH_qzqygc2Vnjig@mail.gmail.com>
In-Reply-To: <CAKEwX=MAX0km1p43DQmKbeSy2G4dPFHiF+deH_qzqygc2Vnjig@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 19 Mar 2024 09:25:09 +1300
Message-ID: <CAGsJ_4y7aFg3FBh_isa_TCqY1B8n64Rro5mVu6=wvk7FP35mWw@mail.gmail.com>
Subject: Re: [syzbot] [mm?] kernel BUG in sg_init_one
To: Nhat Pham <nphamcs@gmail.com>
Cc: syzbot <syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, chengming.zhou@linux.dev, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, yosryahmed@google.com, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 7:00=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Mon, Mar 18, 2024 at 9:58=E2=80=AFAM syzbot
> <syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    e5eb28f6d1af Merge tag 'mm-nonmm-stable-2024-03-14-09-3=
6' ..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D13043abe180=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D19bb57c23df=
fc38e
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dadbc983a1588b=
7805de3
> > compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld=
 (GNU Binutils for Debian) 2.40
> > userspace arch: arm
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1706d2311=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D13ba7959180=
000
> >
> > Downloadable assets:
> > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets=
/8ead8862021c/non_bootable_disk-e5eb28f6.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/0a7371c63ff2/vmli=
nux-e5eb28f6.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/7539441b4add=
/zImage-e5eb28f6.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com
> >
> > ------------[ cut here ]------------
> > kernel BUG at include/linux/scatterlist.h:187!
>
> Looks like the provided buffer is invalid:
>
> #ifdef CONFIG_DEBUG_SG
> BUG_ON(!virt_addr_valid(buf));
> #endif
>
> which is "src" from:
>
> sg_init_one(&input, src, entry->length);
>
> Looking at the surrounding code and recent history, there's this
> commit that stands out:
>
> mm/zswap: remove the memcpy if acomp is not sleepable
> (sha: 270700dd06ca41a4779c19eb46608f076bb7d40e)
>
> which has the effect of, IIUC, using the zpool mapped memory directly
> as src, instead of acomp_ctx->buffer (which was previously the case,
> as zsmalloc was not sleepable).
>
> This might not necessarily be a bug with that commit itself, but might
> have revealed another bug elsewhere.
>
> Anyway, cc-ing the author, Barry Song, to fact check me :) Will take a
> closer look later.

I guess that is because on arm32 , we have highmem but
sg_init_one supports lowmem only. the below should be
able to fix?

diff --git a/mm/zswap.c b/mm/zswap.c
index 9dec853647c8..47c0386caba2 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1086,7 +1086,8 @@ static void zswap_decompress(struct zswap_entry
*entry, struct page *page)
                zpool_unmap_handle(zpool, entry->handle);
        }

-       sg_init_one(&input, src, entry->length);
+       sg_init_table(&input, 1);
+       sg_set_page(&input, kmap_to_page(src), entry->length,
offset_in_page(src));
        sg_init_table(&output, 1);
        sg_set_page(&output, page, PAGE_SIZE, 0);
        acomp_request_set_params(acomp_ctx->req, &input, &output,
entry->length, PAGE_SIZE);



>


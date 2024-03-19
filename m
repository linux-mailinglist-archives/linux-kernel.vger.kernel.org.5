Return-Path: <linux-kernel+bounces-106849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD2687F477
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 01:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBDF8B21083
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECE06AC0;
	Tue, 19 Mar 2024 00:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3y9L2q7"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9DC4A09
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 00:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710807550; cv=none; b=nqnQgtR8GHcKB95MqVwN2c+DTk+ZUYOoTkI5nynZtXovySj+3Hf5wdUzpizXifozc7+6eRkrKs8IP3ItMYv1mtmc77sllHIfsnuwJ6wDSvyH9h66BG4WwW8z/tBm6OYviiKyV7nA8VLDq4r4Sh6GtPznLpIFORfKjws39Uz90LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710807550; c=relaxed/simple;
	bh=MGFoZXzRG8bw5cDzmzUxF4ww0BFMu1SLRorXiHcJrOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cPwM5dplW1PjHuerjS/MkpKn/znGVouuSzL2p2YAtKnvmuSdk1tlIlsNToTnHikdR4gneJbtqOfZUokIkXUaRleO4irDpanW6+JU1or/wTO0yyKqXBRpSUZHQ7/H3Aj/QlOeePB2ln01y9ja205A62oBPN4WxRp1plXyRkChMgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3y9L2q7; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7db36dbd474so1932331241.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 17:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710807547; x=1711412347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cm60JN4zn2i0OoCzg391A+FGu8cENfkGRcA7bzuvGiE=;
        b=V3y9L2q7TpVAFb70RSPp9lsw9y2CNt4yGC+hOP1deWKXJjivu2Nb1hn1h7ZeqEoGul
         /3cxObhs42R2xRafiJJ0fXYPfyPIkDyrBDLQbIeBboK69PPs3hYFaVFOlXxOF+MCsUZx
         MnJ5Yx5JJIUi92XSAcTOaBP7dMNDA6v5dTUUhcq8G3vCfHJPHGQ1Q1MAg2N5Zv8wMNvD
         uKZFwaVG/52izspmabP0JyBbUTNOBMgBmEv0cTCCIUNWvUe8Hidepxdwk3JmxW+wCpm9
         aNiL/K9iJXTaf7PPtevrevo6wtwJjWIauloFvj1XZDfweUWObgqoO3FyVOn+23weFcGN
         +7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710807547; x=1711412347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cm60JN4zn2i0OoCzg391A+FGu8cENfkGRcA7bzuvGiE=;
        b=lVoxcZNGp5HauUMROgPn2w3+iy8E/bHcSKCpZ/wRVK0E3LZLtJXezBG2GSYfCrL2r8
         9z1oxwS2R0gFMl/krlKHl4MpJ4ze4ryePRMUjO1EQp4X+Bk1SgwW6EvHTLBC0Bv4Cteu
         u+mVlRDD+84VDl3LWHLrmPFcV2U9io3zH1t7vj4CiPtUTbtOHEbc0Q9+FuxMQ+y5M5ss
         7BD/fvVOb6ySA4V7bfACwHMRSr2pbX6DRFaTJBlETGfmaJyq3oCJpRPdJrB4c+iaA7xQ
         YpsogxBq0zjiyFRcnErP9sOEPY4xe4BAbu5jWzJnU//M8QhhBdbyXSqPfaAU8/2e5Lu/
         re2A==
X-Forwarded-Encrypted: i=1; AJvYcCXX0i4DHWzk3+qVDBzrIv0facV0aoUpI5wavY4CT1lOxmzgSSPY3Q7qsMMoTNGovZ4pfTUIkO60R1pOjqkCvz7gjbJrpejenKb3saoY
X-Gm-Message-State: AOJu0Yythli0E94A/LA9H1znBK/IQ29DL77/0d6yjR15m90HzN5cg6fz
	eI5lSS0ljmmH7UzuTQ6A8NXdfutIiOVycy+0gboNd5VehSPNqPTcbkGEpKpjWLLByrim3qT9OWb
	9/N3m5OC0k6Epoe3oB0YwXOxb++M=
X-Google-Smtp-Source: AGHT+IHKYvWifb/X1cQpIthmLo4QDQbWakAQsLUny45KC/LIhxm/8QQUaaNhK7+ziC7F+41yQbnf2mnrkRU4yOoCj6M=
X-Received: by 2002:a67:f14d:0:b0:475:fd25:3c6 with SMTP id
 t13-20020a67f14d000000b00475fd2503c6mr8981354vsm.35.1710807546363; Mon, 18
 Mar 2024 17:19:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318234706.95347-1-21cnbao@gmail.com> <ZfjV5VUcz_KUZm-x@google.com>
In-Reply-To: <ZfjV5VUcz_KUZm-x@google.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 19 Mar 2024 13:18:54 +1300
Message-ID: <CAGsJ_4wN8ObnqdtkJsJavv076f63WjdoUSV3OvA26TYvQdEYmA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: zswap: fix kernel BUG in sg_init_one
To: Yosry Ahmed <yosryahmed@google.com>
Cc: hannes@cmpxchg.org, nphamcs@gmail.com, akpm@linux-foundation.org, 
	chrisl@kernel.org, v-songbaohua@oppo.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, ira.weiny@intel.com, 
	syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 1:01=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Tue, Mar 19, 2024 at 12:47:06PM +1300, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > sg_init_one() relies on linearly mapped low memory for the safe
> > utilization of virt_to_page(). Otherwise, we trigger a kernel
> > BUG,
> >
> > kernel BUG at include/linux/scatterlist.h:187!
> > Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
> > Modules linked in:
> > CPU: 0 PID: 2997 Comm: syz-executor198 Not tainted 6.8.0-syzkaller #0
> > Hardware name: ARM-Versatile Express
> > PC is at sg_set_buf include/linux/scatterlist.h:187 [inline]
> > PC is at sg_init_one+0x9c/0xa8 lib/scatterlist.c:143
> > LR is at sg_init_table+0x2c/0x40 lib/scatterlist.c:128
> > Backtrace:
> > [<807e16ac>] (sg_init_one) from [<804c1824>] (zswap_decompress+0xbc/0x2=
08 mm/zswap.c:1089)
> >  r7:83471c80 r6:def6d08c r5:844847d0 r4:ff7e7ef4
> > [<804c1768>] (zswap_decompress) from [<804c4468>] (zswap_load+0x15c/0x1=
98 mm/zswap.c:1637)
> >  r9:8446eb80 r8:8446eb80 r7:8446eb84 r6:def6d08c r5:00000001 r4:844847d=
0
> > [<804c430c>] (zswap_load) from [<804b9644>] (swap_read_folio+0xa8/0x498=
 mm/page_io.c:518)
> >  r9:844ac800 r8:835e6c00 r7:00000000 r6:df955d4c r5:00000001 r4:def6d08=
c
> > [<804b959c>] (swap_read_folio) from [<804bb064>] (swap_cluster_readahea=
d+0x1c4/0x34c mm/swap_state.c:684)
> >  r10:00000000 r9:00000007 r8:df955d4b r7:00000000 r6:00000000 r5:00100c=
ca
> >  r4:00000001
> > [<804baea0>] (swap_cluster_readahead) from [<804bb3b8>] (swapin_readahe=
ad+0x68/0x4a8 mm/swap_state.c:904)
> >  r10:df955eb8 r9:00000000 r8:00100cca r7:84476480 r6:00000001 r5:000000=
00
> >  r4:00000001
> > [<804bb350>] (swapin_readahead) from [<8047cde0>] (do_swap_page+0x200/0=
xcc4 mm/memory.c:4046)
> >  r10:00000040 r9:00000000 r8:844ac800 r7:84476480 r6:00000001 r5:000000=
00
> >  r4:df955eb8
> > [<8047cbe0>] (do_swap_page) from [<8047e6c4>] (handle_pte_fault mm/memo=
ry.c:5301 [inline])
> > [<8047cbe0>] (do_swap_page) from [<8047e6c4>] (__handle_mm_fault mm/mem=
ory.c:5439 [inline])
> > [<8047cbe0>] (do_swap_page) from [<8047e6c4>] (handle_mm_fault+0x3d8/0x=
12b8 mm/memory.c:5604)
> >  r10:00000040 r9:842b3900 r8:7eb0d000 r7:84476480 r6:7eb0d000 r5:835e6c=
00
> >  r4:00000254
> > [<8047e2ec>] (handle_mm_fault) from [<80215d28>] (do_page_fault+0x148/0=
x3a8 arch/arm/mm/fault.c:326)
> >  r10:00000007 r9:842b3900 r8:7eb0d000 r7:00000207 r6:00000254 r5:7eb0d9=
b4
> >  r4:df955fb0
> > [<80215be0>] (do_page_fault) from [<80216170>] (do_DataAbort+0x38/0xa8 =
arch/arm/mm/fault.c:558)
> >  r10:7eb0da7c r9:00000000 r8:80215be0 r7:df955fb0 r6:7eb0d9b4 r5:000002=
07
> >  r4:8261d0e0
> > [<80216138>] (do_DataAbort) from [<80200e3c>] (__dabt_usr+0x5c/0x60 arc=
h/arm/kernel/entry-armv.S:427)
> > Exception stack(0xdf955fb0 to 0xdf955ff8)
> > 5fa0:                                     00000000 00000000 22d5f800 00=
08d158
> > 5fc0: 00000000 7eb0d9a4 00000000 00000109 00000000 00000000 7eb0da7c 7e=
b0da3c
> > 5fe0: 00000000 7eb0d9a0 00000001 00066bd4 00000010 ffffffff
> >  r8:824a9044 r7:835e6c00 r6:ffffffff r5:00000010 r4:00066bd4
> > Code: 1a000004 e1822003 e8860094 e89da8f0 (e7f001f2)
> > ---[ end trace 0000000000000000 ]---
> > ----------------
> > Code disassembly (best guess):
> >    0: 1a000004        bne     0x18
> >    4: e1822003        orr     r2, r2, r3
> >    8: e8860094        stm     r6, {r2, r4, r7}
> >    c: e89da8f0        ldm     sp, {r4, r5, r6, r7, fp, sp, pc}
> > * 10: e7f001f2        udf     #18 <-- trapping instruction
> >
> > Consequently, we have two choices: either employ kmap_to_page() alongsi=
de
> > sg_set_page(), or resort to copying high memory contents to a temporary
> > buffer residing in low memory. However, considering the introduction
> > of the WARN_ON_ONCE in commit ef6e06b2ef870 ("highmem: fix kmap_to_page=
()
> > for kmap_local_page() addresses"), which specifically addresses high
> > memory concerns, it appears that memcpy remains the sole viable
> > option.
> >
> > Reported-and-tested-by: syzbot+adbc983a1588b7805de3@syzkaller.appspotma=
il.com
> > Closes: https://lore.kernel.org/all/000000000000bbb3d80613f243a6@google=
com/
> > Fixes: 270700dd06ca ("mm/zswap: remove the memcpy if acomp is not sleep=
able")
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  -v2:
> >    add comments according to Yosry
> >
> >  mm/zswap.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 9dec853647c8..dbd9f745fa8f 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -1080,7 +1080,17 @@ static void zswap_decompress(struct zswap_entry =
*entry, struct page *page)
> >       mutex_lock(&acomp_ctx->mutex);
> >
> >       src =3D zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
> > -     if (acomp_ctx->is_sleepable && !zpool_can_sleep_mapped(zpool)) {
> > +     /*
> > +      * If zpool_map_handle is atomic, we cannot reliably utilize its =
mapped buffer
> > +      * to do crypto_acomp_decompress() which might sleep. In such cas=
es, we must
> > +      * resort to copying the buffer to a temporary one.
> > +      * Meanwhile, zpool_map_handle() might return a non-linearly mapp=
ed buffer,
> > +      * such as a kmap address of high memory or even ever a vmap addr=
ess.
> > +      * However, sg_init_one is only equipped to handle linearly mappe=
d low memory.
> > +      * In such cases, we also must copy the buffer to a temporary and=
 lowmem one.
> > +      */
>
> Can I interest you in something simpler? :)
>
>         /*
>          * There are two cases where we cannot directly use the pointer r=
eturned
>          * by zpool_map_handle() during decompression and use a buffer in=
stead:
>          * 1. zpool_map_handle() is atomic but crypto_acomp_decompress() =
is not.
>          * 2. The pointer is not in the direct map, so it cannot be used =
by
>          * sg_init_one().
>          */
>
> Whether you take it or not, feel free to add:

I prefer to retain my version as it focuses more on the explanation
of why something occurs :-)

>
> Acked-by: Yosry Ahmed <yosryahmed@google.com>

Thanks!


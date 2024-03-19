Return-Path: <linux-kernel+bounces-106910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E81B87F54A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 080381F21DC1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 02:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7BF64CEC;
	Tue, 19 Mar 2024 02:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccPWVgHB"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D4B56B77
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 02:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710814552; cv=none; b=qivbOc/UXnua+1WOnOi0MkRb2BcZvb823TPWrmL9uOd997SqgeBVuw83qNyJPu3zZROgJw/GvOui2hmINZ5vJb04t1nMlrdlwZSkK+qtM2C8giCyl4lcPyPUf7DUp0CdbS7bngMJuPdhj3Zu1aAR+UiK4tq3/u+XqggPjVKX8bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710814552; c=relaxed/simple;
	bh=8bipK6t1k+3gcuPSWBkHDr99KA1p7uXMqs7UrF8ihDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BpBAStOkelPIYTWWJ5CWkXLCPoG80eBz30B7fhJdtMo4apg0Qt6So7+/dot0CfflN88j5E8RF19UWzuxerqe5cP7FpSh9tRGmyatvpJ4KI/vZeM1tnBnul6vZqC+K+SH2sOcnD6MCxuiiJXSPiTlmeAnSVTlcyS6M9SLI2xLH/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ccPWVgHB; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dcc4de7d901so3962288276.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 19:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710814549; x=1711419349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYVrQrEsh6uYviSopgSQhcHv9TIjtMyaJxqSICXb3ro=;
        b=ccPWVgHBqJEf8nxclAQZg8bB2/UUBPe3xpbXmBBjNF+xtg94/kx1M7VRYK2Nx0Njtc
         wmKLGgIgnKM8yhTlgl9kbqUJqH9oVydI8ko4UNN0oTfKSkNNie2kYfgyWlQczawUI8vz
         7aKfIWwjQijOOIg/hnKfKNjDGplJoFZ3BMmLUaNMAlB1jG7gxmLNmFOvpklJgQwDQuGb
         6Pw5AwuV2qQzUfJiwDDxX7IK5Wm3FJ92R/OxYzVXL5uPKd8bfVA8sKAe6he1nnCFQDF2
         3eLsDApFN4KNrl6YQFMCJsZHoG9OFT2yRtxuJwN8V5UXnzamx7IqsuZYe/yRzjRbV1Ar
         Q9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710814549; x=1711419349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fYVrQrEsh6uYviSopgSQhcHv9TIjtMyaJxqSICXb3ro=;
        b=apRoRrIT06lg0DU4by+WJsBFZ7Zm0LIK6DBm/6/a3enPeMQVLTAAucQc5tqUSgfwv7
         n3+25HDfe3M5UBDZRL4wTknr3tvpu85a+8vT4sZo9by6cSH0fyeohMyWr5YOCOeuSPR3
         ba5Qc6XK6IgXQ1VY8s6aN2u6PcyHD8xgD3fS5SGLds3ZBI7s2nf6UpDu/RFFNNfx+c6m
         D2fRCLhbFw+vHdi0DAl0VAC/hkuxKk6WxM56uokXe5iiwoB1FxDpNhaMzZ56r6XSTV9s
         manDjdfYTY3R+JC6CKNciknnnJe2ZNXmTXU0govcUrfmznXKKDs/AQYNh0MnqKFq5FYr
         /hTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOHLCZpdvegv2r1YoZcYKQ8IuvgBmd+RUhQPhfnHJqCkByjXCbtft5YRPhGU/pFGSt0MRfRTiqA6ROLmXhyoEWhwpMMdMNOeALpftR
X-Gm-Message-State: AOJu0Yy5HTfMpFRccZoFQHCfLy33ZqTHhGW3dR3XteUvQrEpbDLDbiZe
	IX7nOuq+ALz4A/2nOhIr/RhT8iQ57yfQzyQIud5rIpDlV+LeanMLu/yqUdAf5xu9Klt2bL5Q7z0
	Ny0bT+qFmbz8JVDmNmAtMEcxIllw=
X-Google-Smtp-Source: AGHT+IEZNIhbNyYG+uI64ZLjlo0tkDENy952EK2dJ1BI9Q53Khz7vgHe08KvUjvzgVsECUGrom4LN+dZfFriPOIUM4Y=
X-Received: by 2002:a5b:b10:0:b0:dcb:fa70:c09 with SMTP id z16-20020a5b0b10000000b00dcbfa700c09mr660781ybp.28.1710814549112;
 Mon, 18 Mar 2024 19:15:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318234706.95347-1-21cnbao@gmail.com>
In-Reply-To: <20240318234706.95347-1-21cnbao@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 18 Mar 2024 19:15:38 -0700
Message-ID: <CAKEwX=OvEB3sc_G46AMMPerFU7vTm8W1UMOv6UgcE_ToPtUy5Q@mail.gmail.com>
Subject: Re: [PATCH v2] mm: zswap: fix kernel BUG in sg_init_one
To: Barry Song <21cnbao@gmail.com>
Cc: hannes@cmpxchg.org, yosryahmed@google.com, akpm@linux-foundation.org, 
	chrisl@kernel.org, v-songbaohua@oppo.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, ira.weiny@intel.com, 
	syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 4:47=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> From: Barry Song <v-songbaohua@oppo.com>
>
> sg_init_one() relies on linearly mapped low memory for the safe
> utilization of virt_to_page(). Otherwise, we trigger a kernel
> BUG,
>
> kernel BUG at include/linux/scatterlist.h:187!
> Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
> Modules linked in:
> CPU: 0 PID: 2997 Comm: syz-executor198 Not tainted 6.8.0-syzkaller #0
> Hardware name: ARM-Versatile Express
> PC is at sg_set_buf include/linux/scatterlist.h:187 [inline]
> PC is at sg_init_one+0x9c/0xa8 lib/scatterlist.c:143
> LR is at sg_init_table+0x2c/0x40 lib/scatterlist.c:128
> Backtrace:
> [<807e16ac>] (sg_init_one) from [<804c1824>] (zswap_decompress+0xbc/0x208=
 mm/zswap.c:1089)
>  r7:83471c80 r6:def6d08c r5:844847d0 r4:ff7e7ef4
> [<804c1768>] (zswap_decompress) from [<804c4468>] (zswap_load+0x15c/0x198=
 mm/zswap.c:1637)
>  r9:8446eb80 r8:8446eb80 r7:8446eb84 r6:def6d08c r5:00000001 r4:844847d0
> [<804c430c>] (zswap_load) from [<804b9644>] (swap_read_folio+0xa8/0x498 m=
m/page_io.c:518)
>  r9:844ac800 r8:835e6c00 r7:00000000 r6:df955d4c r5:00000001 r4:def6d08c
> [<804b959c>] (swap_read_folio) from [<804bb064>] (swap_cluster_readahead+=
0x1c4/0x34c mm/swap_state.c:684)
>  r10:00000000 r9:00000007 r8:df955d4b r7:00000000 r6:00000000 r5:00100cca
>  r4:00000001
> [<804baea0>] (swap_cluster_readahead) from [<804bb3b8>] (swapin_readahead=
+0x68/0x4a8 mm/swap_state.c:904)
>  r10:df955eb8 r9:00000000 r8:00100cca r7:84476480 r6:00000001 r5:00000000
>  r4:00000001
> [<804bb350>] (swapin_readahead) from [<8047cde0>] (do_swap_page+0x200/0xc=
c4 mm/memory.c:4046)
>  r10:00000040 r9:00000000 r8:844ac800 r7:84476480 r6:00000001 r5:00000000
>  r4:df955eb8
> [<8047cbe0>] (do_swap_page) from [<8047e6c4>] (handle_pte_fault mm/memory=
c:5301 [inline])
> [<8047cbe0>] (do_swap_page) from [<8047e6c4>] (__handle_mm_fault mm/memor=
y.c:5439 [inline])
> [<8047cbe0>] (do_swap_page) from [<8047e6c4>] (handle_mm_fault+0x3d8/0x12=
b8 mm/memory.c:5604)
>  r10:00000040 r9:842b3900 r8:7eb0d000 r7:84476480 r6:7eb0d000 r5:835e6c00
>  r4:00000254
> [<8047e2ec>] (handle_mm_fault) from [<80215d28>] (do_page_fault+0x148/0x3=
a8 arch/arm/mm/fault.c:326)
>  r10:00000007 r9:842b3900 r8:7eb0d000 r7:00000207 r6:00000254 r5:7eb0d9b4
>  r4:df955fb0
> [<80215be0>] (do_page_fault) from [<80216170>] (do_DataAbort+0x38/0xa8 ar=
ch/arm/mm/fault.c:558)
>  r10:7eb0da7c r9:00000000 r8:80215be0 r7:df955fb0 r6:7eb0d9b4 r5:00000207
>  r4:8261d0e0
> [<80216138>] (do_DataAbort) from [<80200e3c>] (__dabt_usr+0x5c/0x60 arch/=
arm/kernel/entry-armv.S:427)
> Exception stack(0xdf955fb0 to 0xdf955ff8)
> 5fa0:                                     00000000 00000000 22d5f800 0008=
d158
> 5fc0: 00000000 7eb0d9a4 00000000 00000109 00000000 00000000 7eb0da7c 7eb0=
da3c
> 5fe0: 00000000 7eb0d9a0 00000001 00066bd4 00000010 ffffffff
>  r8:824a9044 r7:835e6c00 r6:ffffffff r5:00000010 r4:00066bd4
> Code: 1a000004 e1822003 e8860094 e89da8f0 (e7f001f2)
> ---[ end trace 0000000000000000 ]---
> ----------------
> Code disassembly (best guess):
>    0:   1a000004        bne     0x18
>    4:   e1822003        orr     r2, r2, r3
>    8:   e8860094        stm     r6, {r2, r4, r7}
>    c:   e89da8f0        ldm     sp, {r4, r5, r6, r7, fp, sp, pc}
> * 10:   e7f001f2        udf     #18 <-- trapping instruction
>
> Consequently, we have two choices: either employ kmap_to_page() alongside
> sg_set_page(), or resort to copying high memory contents to a temporary
> buffer residing in low memory. However, considering the introduction
> of the WARN_ON_ONCE in commit ef6e06b2ef870 ("highmem: fix kmap_to_page()
> for kmap_local_page() addresses"), which specifically addresses high
> memory concerns, it appears that memcpy remains the sole viable
> option.
>
> Reported-and-tested-by: syzbot+adbc983a1588b7805de3@syzkaller.appspotmail=
com
> Closes: https://lore.kernel.org/all/000000000000bbb3d80613f243a6@google.c=
om/
> Fixes: 270700dd06ca ("mm/zswap: remove the memcpy if acomp is not sleepab=
le")
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  -v2:
>    add comments according to Yosry
>
>  mm/zswap.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 9dec853647c8..dbd9f745fa8f 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1080,7 +1080,17 @@ static void zswap_decompress(struct zswap_entry *e=
ntry, struct page *page)
>         mutex_lock(&acomp_ctx->mutex);
>
>         src =3D zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
> -       if (acomp_ctx->is_sleepable && !zpool_can_sleep_mapped(zpool)) {
> +       /*
> +        * If zpool_map_handle is atomic, we cannot reliably utilize its =
mapped buffer
> +        * to do crypto_acomp_decompress() which might sleep. In such cas=
es, we must
> +        * resort to copying the buffer to a temporary one.
> +        * Meanwhile, zpool_map_handle() might return a non-linearly mapp=
ed buffer,

nit: /s/Meanwhile/In addition

Very insignificant though - please disregard unless you submit a new versio=
n :)

> +        * such as a kmap address of high memory or even ever a vmap addr=
ess.
> +        * However, sg_init_one is only equipped to handle linearly mappe=
d low memory.
> +        * In such cases, we also must copy the buffer to a temporary and=
 lowmem one.
> +        */

I like this extensive comment - this will be useful for beginners who
are not familiar with the underlying machinery (read: me).

> +       if ((acomp_ctx->is_sleepable && !zpool_can_sleep_mapped(zpool)) |=
|
> +           !virt_addr_valid(src)) {

Nice! You and Yosry beat me to it - I was staring at the same piece of
zsmalloc code.

It's somewhat serendipitous (albeit anti-climatic) when the fix is
simply checking for the BUG_ON condition. Thanks for the fix and the
detailed explanation, Barry!

Reviewed-by: Nhat Pham <nphamcs@gmail.com>


Return-Path: <linux-kernel+bounces-106842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9C587F457
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 01:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3758A282AC3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9FD33C9;
	Tue, 19 Mar 2024 00:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1kH3vpv9"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C0217C2
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 00:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710806505; cv=none; b=cnGaD7OVH5YDxDlRpe4uVJD2c34ZI6lLHTPiQF8yxs0dCHt0eZWs9PDZK5NOqkuNZ6UpwGmNOngd4nHhk01ADc2XSwCB5YNq9Iwb1PLN4pOZUSjgN2p9dxiz4dgIaXe8sZfMHGhikhQanImMGOps6RgP7HX+fWnA9LfJa2w2PAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710806505; c=relaxed/simple;
	bh=Y+TSJiWIsSSiJ6Q3QEm8If3qGdltkg2FuShFUUVfu54=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oE57jPmL/3v+ijHPnzXobtscGbHgkwwxB1iQRFb4HxaVIeyuEwxiwwuCfiF6Ameig/a8IVw1J9mg03VTtFD0OQ3RZ+piSFw2IIjJ6tlIWO2rkoHXO38fuDTEmWdSv1MtWvM42uTypuYkZOpmbpIcEIfHV5RU38n5lLrf1lDO2Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1kH3vpv9; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-29de982f09aso3387541a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 17:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710806503; x=1711411303; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Txb/UPy1hXnjUdJP6etJpIDGhx4pfOtkLCZUw/zlPF0=;
        b=1kH3vpv9qshMGxv/JmG9CjaponxQVhSG5r1NZSBHdxBI6YjsuekOEUTSa63D0gdiMI
         opRW1wVgrzz7PUYhJt0RKZzJiNbx41Rv3e+l7ARG5J3V2jqXnQzz2eT5nIZXUr8AfWyF
         cKoUFabudH8jYJqsZDizrN+8y4cdKE8nPptVHf0ML9zFIqvXLhZpkMSN8NFsSchvZVY8
         OvAnnWPZxytdPJg6COPlc4eOZ4SPxe0Su7Q5Wq6pXBiscbUFVCimHiDtqPhZROehcf1C
         HWghGy+rJGb5nYJptqUSrx4XHeYUtRO7cvaWcvkJdj4YUpfaNp9xrPIeWusHGzWf4o6y
         PuzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710806503; x=1711411303;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Txb/UPy1hXnjUdJP6etJpIDGhx4pfOtkLCZUw/zlPF0=;
        b=DKbtBbQBRkjgAKv4EqswcHZ5tmO2sOSTER64Ek+Lb/kSrJupgxkLb5W23Quu/4pjll
         7Wc3iGd6883RKN1t4TAMXid+Bd2vx1KgHX2/kK7BaxHfyWEX/58p6lw4E2CyR54pitPO
         1bb8dGZpuopIXSkwiqyMDVf01MKT8l6u6emLDHHwj80h4sQqkwWLfhQbwP2b2J5J6+vi
         WFQ7x94A7u47SYyD5o77NjPhTV8cjqKfh06af/FcraHbaoRwi0lrLThsxfYTzYg/tybn
         6lzWhT2PH+bybewWyzLoyiw4xPZOZitZN4+aIvb297nnBsFePqhjJ4lEGs93bwKR0dWi
         DiaA==
X-Forwarded-Encrypted: i=1; AJvYcCXNI/jD1qjpWVyAeROG4YeU6JqxhKDNZRW/d+SBWZIEpPh4SzV4RuycA75irfYjKHojl3mpepHPUGM0twuVsfBcNOXSS9HbIg2Em+lb
X-Gm-Message-State: AOJu0YxXvtBtd0diftiTpRGUP2vw0vq0GZ08h6O3UaPWyR+TLOG3+Gzm
	iDzEfCAVaz+YyLOOZ1aQ/Z0wSkDMTfJTBn2HrVj1Xhz8uZkNsu9HpkyFhUhEv07YImHaC/N/hpy
	TTD6wnzOUxWHrKxnCcQ==
X-Google-Smtp-Source: AGHT+IEuyB/pN7r/hoBoB9sWbdhawK5kkFd4d+2Eek427GpioGkF25Wi/1QzzXnPSQhXQaMvj1i2RW9mTRyUKV0i
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a17:90a:fd93:b0:29c:5fcb:447a with SMTP
 id cx19-20020a17090afd9300b0029c5fcb447amr2568pjb.6.1710806503429; Mon, 18
 Mar 2024 17:01:43 -0700 (PDT)
Date: Tue, 19 Mar 2024 00:01:41 +0000
In-Reply-To: <20240318234706.95347-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240318234706.95347-1-21cnbao@gmail.com>
Message-ID: <ZfjV5VUcz_KUZm-x@google.com>
Subject: Re: [PATCH v2] mm: zswap: fix kernel BUG in sg_init_one
From: Yosry Ahmed <yosryahmed@google.com>
To: Barry Song <21cnbao@gmail.com>
Cc: hannes@cmpxchg.org, nphamcs@gmail.com, akpm@linux-foundation.org, 
	chrisl@kernel.org, v-songbaohua@oppo.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, ira.weiny@intel.com, 
	syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Mar 19, 2024 at 12:47:06PM +1300, Barry Song wrote:
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
> [<807e16ac>] (sg_init_one) from [<804c1824>] (zswap_decompress+0xbc/0x208 mm/zswap.c:1089)
>  r7:83471c80 r6:def6d08c r5:844847d0 r4:ff7e7ef4
> [<804c1768>] (zswap_decompress) from [<804c4468>] (zswap_load+0x15c/0x198 mm/zswap.c:1637)
>  r9:8446eb80 r8:8446eb80 r7:8446eb84 r6:def6d08c r5:00000001 r4:844847d0
> [<804c430c>] (zswap_load) from [<804b9644>] (swap_read_folio+0xa8/0x498 mm/page_io.c:518)
>  r9:844ac800 r8:835e6c00 r7:00000000 r6:df955d4c r5:00000001 r4:def6d08c
> [<804b959c>] (swap_read_folio) from [<804bb064>] (swap_cluster_readahead+0x1c4/0x34c mm/swap_state.c:684)
>  r10:00000000 r9:00000007 r8:df955d4b r7:00000000 r6:00000000 r5:00100cca
>  r4:00000001
> [<804baea0>] (swap_cluster_readahead) from [<804bb3b8>] (swapin_readahead+0x68/0x4a8 mm/swap_state.c:904)
>  r10:df955eb8 r9:00000000 r8:00100cca r7:84476480 r6:00000001 r5:00000000
>  r4:00000001
> [<804bb350>] (swapin_readahead) from [<8047cde0>] (do_swap_page+0x200/0xcc4 mm/memory.c:4046)
>  r10:00000040 r9:00000000 r8:844ac800 r7:84476480 r6:00000001 r5:00000000
>  r4:df955eb8
> [<8047cbe0>] (do_swap_page) from [<8047e6c4>] (handle_pte_fault mm/memory.c:5301 [inline])
> [<8047cbe0>] (do_swap_page) from [<8047e6c4>] (__handle_mm_fault mm/memory.c:5439 [inline])
> [<8047cbe0>] (do_swap_page) from [<8047e6c4>] (handle_mm_fault+0x3d8/0x12b8 mm/memory.c:5604)
>  r10:00000040 r9:842b3900 r8:7eb0d000 r7:84476480 r6:7eb0d000 r5:835e6c00
>  r4:00000254
> [<8047e2ec>] (handle_mm_fault) from [<80215d28>] (do_page_fault+0x148/0x3a8 arch/arm/mm/fault.c:326)
>  r10:00000007 r9:842b3900 r8:7eb0d000 r7:00000207 r6:00000254 r5:7eb0d9b4
>  r4:df955fb0
> [<80215be0>] (do_page_fault) from [<80216170>] (do_DataAbort+0x38/0xa8 arch/arm/mm/fault.c:558)
>  r10:7eb0da7c r9:00000000 r8:80215be0 r7:df955fb0 r6:7eb0d9b4 r5:00000207
>  r4:8261d0e0
> [<80216138>] (do_DataAbort) from [<80200e3c>] (__dabt_usr+0x5c/0x60 arch/arm/kernel/entry-armv.S:427)
> Exception stack(0xdf955fb0 to 0xdf955ff8)
> 5fa0:                                     00000000 00000000 22d5f800 0008d158
> 5fc0: 00000000 7eb0d9a4 00000000 00000109 00000000 00000000 7eb0da7c 7eb0da3c
> 5fe0: 00000000 7eb0d9a0 00000001 00066bd4 00000010 ffffffff
>  r8:824a9044 r7:835e6c00 r6:ffffffff r5:00000010 r4:00066bd4
> Code: 1a000004 e1822003 e8860094 e89da8f0 (e7f001f2) 
> ---[ end trace 0000000000000000 ]---
> ----------------
> Code disassembly (best guess):
>    0:	1a000004 	bne	0x18
>    4:	e1822003 	orr	r2, r2, r3
>    8:	e8860094 	stm	r6, {r2, r4, r7}
>    c:	e89da8f0 	ldm	sp, {r4, r5, r6, r7, fp, sp, pc}
> * 10:	e7f001f2 	udf	#18 <-- trapping instruction
> 
> Consequently, we have two choices: either employ kmap_to_page() alongside
> sg_set_page(), or resort to copying high memory contents to a temporary
> buffer residing in low memory. However, considering the introduction
> of the WARN_ON_ONCE in commit ef6e06b2ef870 ("highmem: fix kmap_to_page()
> for kmap_local_page() addresses"), which specifically addresses high
> memory concerns, it appears that memcpy remains the sole viable
> option.
> 
> Reported-and-tested-by: syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/000000000000bbb3d80613f243a6@google.com/
> Fixes: 270700dd06ca ("mm/zswap: remove the memcpy if acomp is not sleepable")
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
> @@ -1080,7 +1080,17 @@ static void zswap_decompress(struct zswap_entry *entry, struct page *page)
>  	mutex_lock(&acomp_ctx->mutex);
>  
>  	src = zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
> -	if (acomp_ctx->is_sleepable && !zpool_can_sleep_mapped(zpool)) {
> +	/*
> +	 * If zpool_map_handle is atomic, we cannot reliably utilize its mapped buffer
> +	 * to do crypto_acomp_decompress() which might sleep. In such cases, we must
> +	 * resort to copying the buffer to a temporary one.
> +	 * Meanwhile, zpool_map_handle() might return a non-linearly mapped buffer,
> +	 * such as a kmap address of high memory or even ever a vmap address.
> +	 * However, sg_init_one is only equipped to handle linearly mapped low memory.
> +	 * In such cases, we also must copy the buffer to a temporary and lowmem one.
> +	 */

Can I interest you in something simpler? :)

	/*
	 * There are two cases where we cannot directly use the pointer returned
	 * by zpool_map_handle() during decompression and use a buffer instead:
	 * 1. zpool_map_handle() is atomic but crypto_acomp_decompress() is not.
	 * 2. The pointer is not in the direct map, so it cannot be used by
	 * sg_init_one().
	 */

Whether you take it or not, feel free to add:

Acked-by: Yosry Ahmed <yosryahmed@google.com>


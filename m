Return-Path: <linux-kernel+bounces-106922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA2F87F575
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D90F282BCD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 02:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B486C65BB1;
	Tue, 19 Mar 2024 02:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="JwsK0zxA"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02047657D8
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 02:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710815417; cv=none; b=j3MJVpI0dFGvrbuB+btH4S9/kgC2DWlf4ibcvcz5uQ7BhXAHltUDxGniJSROvMH2qmFg826DDcBzb6mj7aTy89paXbVrbRoOpCGDDBF1lOFJ9IWqUTWS7yNYQ/IykIQ0Lwop2ug5o3LEX2ZDZY6jCul0dG6/I6wtJj9jPbPwlEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710815417; c=relaxed/simple;
	bh=cp4o9Bnc4U6j/OZpR5t4IUj8v5X/kqCHqBwEgAVZMBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYNMyCnJLj29PJ9yqrHm1k5cOE3Ev6+tduWo4xMm23YUjlGo31KCVsQ9qiI0DEtdotcIP2EO73GfRqpPbZ1NYfY/scOgHzFX8R/e1yW1GCFTk6Cnoh6uH7kZ8PkUtJSPIcIIFuCRgeRFjo5/cO7ZiXOYZnD1ybzzorSk13UNtys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=JwsK0zxA; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-42a35c720b8so18481391cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 19:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1710815413; x=1711420213; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YBzra2Th0pPUWgLwXZXyocunbnlDqKGO4FQ4Z1Askz0=;
        b=JwsK0zxAhCcCg1K2Z9HKUhpXSNQUYeUWoCF7INPrACsFfp5sw2u9BEK9/XdZocPJ/f
         hAC8q0HoPaoCVEunUrZUUiOQz1uNfmgaAbdMdXZV5Ly707kSSVEHiV5s0Q5mcLUKPqTW
         nO9rq7ZUbgVR+sRDrN70Fdf7DGk751AvyB4HcFCMlOntC+/2BglTurMBpG74dpo77D1y
         EkPllOvNTxNPe+2X3y6oL4FmVl9LGWwnpiNxn+qHOKuYHWJYaKiWPitGATWBDzxCqmF0
         FAFnLg1JMHmbrxC6GI57lNorsgaTxfI+pegXWixW04+sQqdAQd9jcAJzZT/EyIeNlnEB
         WqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710815413; x=1711420213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YBzra2Th0pPUWgLwXZXyocunbnlDqKGO4FQ4Z1Askz0=;
        b=W71D5HMACgYW01ZnvWJ0s1Ab31PHqlrZQWAgo0JIpVcvyfM0HQkKjID0ZgVs+GgW7/
         uvuBdYeTPzHpFuLZgB2MXWOyjOY0wCipnPmebTX5MIDrdJBE5V//wqG5GMCtj3n7OdpJ
         xqShMIHe/RhxuN7IG3RgJgp33xpo9MiByufBDzIOL17okAgcm21cVYzGUqb0psp9nzJI
         5cOUpYPhyVKJzm49GOP5VXuJS380zR7Mzo2ARO4bOrubxPs08Yl2kqd1ZeOFsDjOssWk
         G+Ahz1/WWT4LVbRwXs9NVVJBWhu/2adPllwJfPhbSOt/hppga+RnwmmGTXAAbArdU3xE
         Xw7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUUDLrpW9TB34lN8dpZi0X5bo26ACDra0yDOscxnBgSnvfBuScWiOhkrbMH07T5vML11MnRKIegMkLGZxtl7jze3J4TyjMnbY2QXKSu
X-Gm-Message-State: AOJu0Yw2/i4z7cugbzT0y0wc9OAHbdtZ1L5GaRDjlPSVD1+E4zgtktJX
	2YcGCTwL4Y9bpOjwK7TBShD1aQQP8yP4KR5ApHqZywpbFGz2Qb31SmMLG1zEnkM=
X-Google-Smtp-Source: AGHT+IGbJvABeebHXC7KKwM+viTH9nzNbDCF2xmpL7GjTnGlvOddUvlPFg0Igf1O+QjCrgBE/eMe5A==
X-Received: by 2002:a05:622a:178d:b0:42e:f3bc:9d9b with SMTP id s13-20020a05622a178d00b0042ef3bc9d9bmr17371005qtk.9.1710815413708;
        Mon, 18 Mar 2024 19:30:13 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id eh14-20020a05622a578e00b0042f2130cd0csm2237424qtb.34.2024.03.18.19.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 19:30:13 -0700 (PDT)
Date: Mon, 18 Mar 2024 22:30:12 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Barry Song <21cnbao@gmail.com>
Cc: yosryahmed@google.com, nphamcs@gmail.com, akpm@linux-foundation.org,
	chrisl@kernel.org, v-songbaohua@oppo.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, ira.weiny@intel.com,
	syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] mm: zswap: fix kernel BUG in sg_init_one
Message-ID: <20240319023012.GC4210@cmpxchg.org>
References: <20240318234706.95347-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318234706.95347-1-21cnbao@gmail.com>

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

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Making highmem more efficient isn't much of a priority, but I would
still be curious to hear Ira's thought on that WARN_ON_ONCE().


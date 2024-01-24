Return-Path: <linux-kernel+bounces-37058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0731B83AAC6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8AD8B25866
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9F277F02;
	Wed, 24 Jan 2024 13:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PfM9BPxR"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E156E63116
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 13:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706102151; cv=none; b=ZhySmpYY1ytKh7vWkhFfyKqeIUS+s3rkt1TT2aTNFXmViWMA1hXOEOh+h3GLHsd5G5KWA+nA9oAxSjCzQjg/LJEJ+PJetr92N7WP518PDrayLq6982OhLeyOujXBefuc6aXgS4asd/nkWDu09cLa3NwjjYFhLAOSwFxpYAQ2Fsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706102151; c=relaxed/simple;
	bh=GDgE5UmpTACnIM5ZWOIoeJNdQHYEyryeW2i+pwuhcOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLkPcCXMwAeopcfq5H8OOD6YQPs5XsrU87FQStP+9vJzH5pQ4zOb75sWSPM++AsawacmSJycsPiQSZ/bcw4adhJNDOZHd+8OxXtuHZ0lYI2oDfzi3mB0E4i57GT19hqvtF8TnKT0rl1KrnmSclHGgWtVBr8vM1C5S77BKRgwFg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PfM9BPxR; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qxKHPmrLHSpXaEhqdYvFl7e0WLs/NEDBg3zrdUtq0Qs=; b=PfM9BPxRRxlsXYG3xYyMev4PKV
	AtVrV/pFcYCvKgql1Of69rLr/2CzN3f4H9c1PHhdKWs8odnwYCpF62Sb7ReToQKA0b6q17FEz1ypR
	wdQlnaSVBcRnvpFsP52DEPV/NRmQnhobmhxHE4SsH+UoDiHs8jxa5tdZVKRPTY5uQouMan43JOQOn
	pMjTO4dTjZNEVkEmIkStlXx0R2jfIJMclkkWm4cxN1jgkhWd3Xw0eryiWS7IMn1+E5GFmQnu8zNBI
	QEtMBS3Y3RtMSJbaY7nrN0137/QHi9alXJGdYEtLIn5nX8+U4vfvscHXqDc9DiwBqOvJuqVDT99Jf
	A5uYQW7Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rSd6X-00000006iKy-3ewZ;
	Wed, 24 Jan 2024 13:15:46 +0000
Date: Wed, 24 Jan 2024 13:15:45 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: naoya.horiguchi@nec.com, akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/memory-failure: fix crash in
 split_huge_page_to_list from soft_offline_page
Message-ID: <ZbENgT-2dZHQQ90h@casper.infradead.org>
References: <20240124084014.1772906-1-linmiaohe@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124084014.1772906-1-linmiaohe@huawei.com>

On Wed, Jan 24, 2024 at 04:40:14PM +0800, Miaohe Lin wrote:
> When I did soft offline stress test, a machine was observed to crash with
> the following message:
> 
>   kernel BUG at include/linux/memcontrol.h:554!
>   invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
>   CPU: 5 PID: 3837 Comm: hwpoison.sh Not tainted 6.7.0-next-20240112-00001-g8ecf3e7fb7c8-dirty #97
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
>   RIP: 0010:folio_memcg+0xaf/0xd0
>   Code: 10 5b 5d c3 cc cc cc cc 48 c7 c6 08 b1 f2 b2 48 89 ef e8 b4 c5 f8 ff 90 0f 0b 48 c7 c6 d0 b0 f2 b2 48 89 ef e8 a2 c5 f8 ff 90 <0f> 0b 48 c7 c6 08 b1 f2 b2 48 89 ef e8 90 c5 f8 ff 90 0f 0b 66 66
>   RSP: 0018:ffffb6c043657c98 EFLAGS: 00000296
>   RAX: 000000000000004b RBX: ffff932bc1d1e401 RCX: ffff933abfb5c908
>   RDX: 0000000000000000 RSI: 0000000000000027 RDI: ffff933abfb5c900
>   RBP: ffffea6f04019080 R08: ffffffffb3338ce8 R09: 0000000000009ffb
>   R10: 00000000000004dd R11: ffffffffb3308d00 R12: ffffea6f04019080
>   R13: ffffea6f04019080 R14: 0000000000000001 R15: ffffb6c043657da0
>   FS:  00007f6c60f6b740(0000) GS:ffff933abfb40000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 0000559c3bc8b980 CR3: 0000000107f1c000 CR4: 00000000000006f0
>   Call Trace:
>    <TASK>
>    ? die+0x32/0x90
>    ? do_trap+0xde/0x110
>    ? folio_memcg+0xaf/0xd0
>    ? do_error_trap+0x60/0x80
>    ? folio_memcg+0xaf/0xd0
>    ? exc_invalid_op+0x53/0x70
>    ? folio_memcg+0xaf/0xd0
>    ? asm_exc_invalid_op+0x1a/0x20
>    ? folio_memcg+0xaf/0xd0
>    ? folio_memcg+0xae/0xd0

I might trim these ? lines out of the backtrace ...

>    split_huge_page_to_list+0x4d/0x1380
>    ? sysvec_apic_timer_interrupt+0xf/0x80
>    try_to_split_thp_page+0x3a/0xf0
>    soft_offline_page+0x1ea/0x8a0
>    soft_offline_page_store+0x52/0x90
>    kernfs_fop_write_iter+0x118/0x1b0
>    vfs_write+0x30b/0x430
>    ksys_write+0x5e/0xe0
>    do_syscall_64+0xb0/0x1b0
>    entry_SYSCALL_64_after_hwframe+0x6d/0x75
>   RIP: 0033:0x7f6c60d14697
>   Code: 10 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
>   RSP: 002b:00007ffe9b72b8d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
>   RAX: ffffffffffffffda RBX: 000000000000000c RCX: 00007f6c60d14697
>   RDX: 000000000000000c RSI: 0000559c3bc8b980 RDI: 0000000000000001
>   RBP: 0000559c3bc8b980 R08: 00007f6c60dd1460 R09: 000000007fffffff
>   R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000000c
>   R13: 00007f6c60e1a780 R14: 00007f6c60e16600 R15: 00007f6c60e15a00
> 
> The problem is that page->mapping is overloaded with slab->slab_list or
> slabs fields now, so slab pages could be taken as non-LRU movable pages
> if field slabs contains PAGE_MAPPING_MOVABLE or slab_list->prev is set
> to LIST_POISON2. These slab pages will be treated as thp later leading
> to crash in split_huge_page_to_list().
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Fixes: 130d4df57390 ("mm/sl[au]b: rearrange struct slab fields to allow larger rcu_head")

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>


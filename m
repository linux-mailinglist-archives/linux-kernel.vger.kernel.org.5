Return-Path: <linux-kernel+bounces-142155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DA48A2831
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A2E01F21C73
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0BC4CE09;
	Fri, 12 Apr 2024 07:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3u9mTxX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782794AEDA;
	Fri, 12 Apr 2024 07:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712907292; cv=none; b=uHPMNUmyq1L9wafqFhxJJE3sT+9VpyqBkPJ3S+L+RPf3qIW6Lbmo4DsfNkef2qj6x94xP7Vy/4S3XAlhpOMoe0uNxoa3GH0Z2OMV49CpCl80VMGGakwTWZPVmNEmq+j5JZtAkcmQylgJYVQdjyfCUSYcX6x7UxEaRoukDTaO05k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712907292; c=relaxed/simple;
	bh=15F1o0wnaOSb0+2taQZ31Mu+Qemw7dCHw+75GzdsEBI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=k7EtwuojKmquFdKWoJn5oxo+eVLwOfxSe2PM6v3uFMhGOHj5dyZ1J6Nn544RtZiCA0gtHmvHYWEsDGRDEjC5pjb8T1Y16iwCLCxbI4H+rJ6vVbTeHMkdfW4BzELBbzUI6EBeygjObQFPFPRA1EVr3a+kFDfEJEcsDb2YL7Ydyxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3u9mTxX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220E9C3277B;
	Fri, 12 Apr 2024 07:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712907292;
	bh=15F1o0wnaOSb0+2taQZ31Mu+Qemw7dCHw+75GzdsEBI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t3u9mTxXzMRTHlaYd2D8ZzlmBV1GnOxQiRLlt1A4T+o67d0193/pfAl0YVCWJnKQK
	 NTcbO3oeoHpxL7HGvLZA6LEkqBPettPejSlCKLgyY6aGupa4Tt64djRsdlqtDMWpZM
	 WzsXxFAtAZcDpBiu90lgE9U5zM/imohuw2C+RMX4e2yQSVSinrp2Vbxc39gYVMIn3s
	 mhyyfJZZjrN/KCGL2pdOssJhBtSOZZYHGcdDx7pOMA3+S23jMsz7RvBNuVOSVJyfDw
	 otdkbBPqM6lmJVssuD9cYtYnbanjWtQVjS2+nw8dmx7aQcpisV6jdjKfBJZ+3YKDrm
	 9OSB0ZuyiKiEg==
Date: Fri, 12 Apr 2024 16:34:48 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: qiang4.zhang@linux.intel.com
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Qiang Zhang <qiang4.zhang@intel.com>,
 Stable@vger.kernel.org
Subject: Re: [PATCH RESEND] bootconfig: use memblock_free_late to free xbc
 memory to buddy
Message-Id: <20240412163448.98950acccc3baea1a3f07fed@kernel.org>
In-Reply-To: <20240412024103.3078378-1-qiang4.zhang@linux.intel.com>
References: <20240412024103.3078378-1-qiang4.zhang@linux.intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Apr 2024 10:41:04 +0800
qiang4.zhang@linux.intel.com wrote:

> From: Qiang Zhang <qiang4.zhang@intel.com>
> 
> On the time to free xbc memory, memblock has handed over memory to buddy
> allocator. So it doesn't make sense to free memory back to memblock.
> memblock_free() called by xbc_exit() even causes UAF bugs on architectures
> with CONFIG_ARCH_KEEP_MEMBLOCK disabled like x86. Following KASAN logs
> shows this case.
> 
> [    9.410890] ==================================================================
> [    9.418962] BUG: KASAN: use-after-free in memblock_isolate_range+0x12d/0x260
> [    9.426850] Read of size 8 at addr ffff88845dd30000 by task swapper/0/1
> 
> [    9.435901] CPU: 9 PID: 1 Comm: swapper/0 Tainted: G     U             6.9.0-rc3-00208-g586b5dfb51b9 #5
> [    9.446403] Hardware name: Intel Corporation RPLP LP5 (CPU:RaptorLake)/RPLP LP5 (ID:13), BIOS IRPPN02.01.01.00.00.19.015.D-00000000 Dec 28 2023
> [    9.460789] Call Trace:
> [    9.463518]  <TASK>
> [    9.465859]  dump_stack_lvl+0x53/0x70
> [    9.469949]  print_report+0xce/0x610
> [    9.473944]  ? __virt_addr_valid+0xf5/0x1b0
> [    9.478619]  ? memblock_isolate_range+0x12d/0x260
> [    9.483877]  kasan_report+0xc6/0x100
> [    9.487870]  ? memblock_isolate_range+0x12d/0x260
> [    9.493125]  memblock_isolate_range+0x12d/0x260
> [    9.498187]  memblock_phys_free+0xb4/0x160
> [    9.502762]  ? __pfx_memblock_phys_free+0x10/0x10
> [    9.508021]  ? mutex_unlock+0x7e/0xd0
> [    9.512111]  ? __pfx_mutex_unlock+0x10/0x10
> [    9.516786]  ? kernel_init_freeable+0x2d4/0x430
> [    9.521850]  ? __pfx_kernel_init+0x10/0x10
> [    9.526426]  xbc_exit+0x17/0x70
> [    9.529935]  kernel_init+0x38/0x1e0
> [    9.533829]  ? _raw_spin_unlock_irq+0xd/0x30
> [    9.538601]  ret_from_fork+0x2c/0x50
> [    9.542596]  ? __pfx_kernel_init+0x10/0x10
> [    9.547170]  ret_from_fork_asm+0x1a/0x30
> [    9.551552]  </TASK>
> 
> [    9.555649] The buggy address belongs to the physical page:
> [    9.561875] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x45dd30
> [    9.570821] flags: 0x200000000000000(node=0|zone=2)
> [    9.576271] page_type: 0xffffffff()
> [    9.580167] raw: 0200000000000000 ffffea0011774c48 ffffea0012ba1848 0000000000000000
> [    9.588823] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
> [    9.597476] page dumped because: kasan: bad access detected
> 
> [    9.605362] Memory state around the buggy address:
> [    9.610714]  ffff88845dd2ff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [    9.618786]  ffff88845dd2ff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [    9.626857] >ffff88845dd30000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> [    9.634930]                    ^
> [    9.638534]  ffff88845dd30080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> [    9.646605]  ffff88845dd30100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> [    9.654675] ==================================================================
> 

Oops, good catch! Indeed, it is too late to use memblock_free().

BTW, is it safe to call memblock_free_late() in early boot stage,
because xbc_free_mem() will be called also from xbc_init().
If not, we need a custom internal __xbc_exit() or xbc_cleanup()
which is called from xbc_init() and uses memblock_free().

Thank you,


> Cc: Stable@vger.kernel.org
> Signed-off-by: Qiang Zhang <qiang4.zhang@intel.com>
> ---
>  lib/bootconfig.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/bootconfig.c b/lib/bootconfig.c
> index c59d26068a64..4524ee944df0 100644
> --- a/lib/bootconfig.c
> +++ b/lib/bootconfig.c
> @@ -63,7 +63,7 @@ static inline void * __init xbc_alloc_mem(size_t size)
>  
>  static inline void __init xbc_free_mem(void *addr, size_t size)
>  {
> -	memblock_free(addr, size);
> +	memblock_free_late(__pa(addr), size);
>  }
>  
>  #else /* !__KERNEL__ */
> -- 
> 2.39.2
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


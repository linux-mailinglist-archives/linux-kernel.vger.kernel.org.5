Return-Path: <linux-kernel+bounces-143727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED04F8A3CB6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 14:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 438C4B2178B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 12:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6530E1C68D;
	Sat, 13 Apr 2024 12:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnZ+cu0i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509E6381B9;
	Sat, 13 Apr 2024 12:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713010903; cv=none; b=hscY33e+uEsyfOd5rWZywMSKwf39GRxTwOfXYL/7MzfuWB13mcLKl58q7ttUXPIjnOaL63DfaFnL+a/b9S6XMOhz/WFc+tz9bVltwxUae8MldmSBZtsnmYM+zKY7QVYqd/U/sdQArizhPMDlF8dBiKdhGx1kDJpSzSUSzyXWhWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713010903; c=relaxed/simple;
	bh=bL4nvugP2H1H7zakqq3Xbnb5B+OOHtfZstKt8xMrFzs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=aKnGHXkeLcevfoblPUorYUPBsEFa7WEV57XwHzM6BEP3s9rBJGNl+fzFbs9spVcO7J3ybZheHVCwLiggjNqGlVOubtNZEVml6P+JhxOQcRvmQkr38i1QgfHoVwj4S3P8J+RtdgOM8mMyvDkJIAfvkyu7IOBjZgaNuaPM54cIRwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnZ+cu0i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE8AC2BBFC;
	Sat, 13 Apr 2024 12:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713010902;
	bh=bL4nvugP2H1H7zakqq3Xbnb5B+OOHtfZstKt8xMrFzs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GnZ+cu0ii0jJ199oVdQ/EYymanIrG71Ql4dU6NspYF/RTuwBEfmsvAqTPzY1m+mGM
	 iOTH2TOO05GWgEaR/RhVX3OXHiRbe6r3Zpk/Ptqns9Mme8WRBdv7M047wLcSoPi9fD
	 3JG2c7vhO/P4P3ueBZFbWLJ1hnDQ2QBQgiQxHEz8eqhNH8vWfFaRu0o6xKhOURe2kO
	 molOhe37tnwZcGPxk78vQnjxZgQKjjkCll6qrSzB/P03oIJB1K1ENvfV/DAnE11PH+
	 yrY/OflNLwUjHag8b746EdWCexYeroIIgdO5Q9rEkLH1Hswt7pUNwAN39ctNOqvRCs
	 Mnv8MsgGhzScg==
Date: Sat, 13 Apr 2024 21:21:38 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: qiang4.zhang@linux.intel.com, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Qiang
 Zhang <qiang4.zhang@intel.com>, Stable@vger.kernel.org
Subject: Re: [PATCH v2] bootconfig: use memblock_free_late to free xbc
 memory to buddy
Message-Id: <20240413212138.26726485be53bec3009452d7@kernel.org>
In-Reply-To: <20240412221820.852abeb57feceec893ca0dad@kernel.org>
References: <20240412104940.456257-1-qiang4.zhang@linux.intel.com>
	<20240412221820.852abeb57feceec893ca0dad@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Qiang,

I found xbc_free_mem() missed to check !addr. When I booted kernel without
bootconfig data but with "bootconfig" cmdline, I got a kernel crash below;


[    2.394904] ------------[ cut here ]------------
[    2.396490] kernel BUG at arch/x86/mm/physaddr.c:28!
[    2.398176] invalid opcode: 0000 [#1] PREEMPT SMP PTI
[    2.399388] CPU: 7 PID: 1 Comm: swapper/0 Tainted: G                 N 6.9.0-rc3-00004-g121fbb463836 #10
[    2.401579] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[    2.403247] RIP: 0010:__phys_addr+0x40/0x60
[    2.404196] Code: 48 2b 05 fb a4 3d 01 48 05 00 00 00 80 48 39 c7 72 17 0f b6 0d ee 9e c0 01 48 89 c2 48 d3 ea 48 85 d2 75 05 c3 cc cc cc cc 90 <0f> 0b 48 03 05 e7 e2 9d 01 48 81 ff ff ff ff 1f 76 e8 90 0f6
[    2.407250] RSP: 0000:ffffc90000013f18 EFLAGS: 00010287
[    2.407991] RAX: 0000778000000000 RBX: ffffffff81c17940 RCX: 000000000080000a
[    2.408891] RDX: 000000000080000b RSI: ffff88800775f320 RDI: 0000000080000000
[    2.409727] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[    2.410555] R10: ffff888005028a60 R11: 000000000080000a R12: 0000000000000000
[    2.411423] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[    2.412155] FS:  0000000000000000(0000) GS:ffff88807d9c0000(0000) knlGS:0000000000000000
[    2.412970] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.413550] CR2: 0000000000000000 CR3: 0000000002a48000 CR4: 00000000000006b0
[    2.414264] Call Trace:
[    2.414520]  <TASK>
[    2.414755]  ? die+0x37/0x90
[    2.415062]  ? do_trap+0xe3/0x110
[    2.415451]  ? __phys_addr+0x40/0x60
[    2.415822]  ? do_error_trap+0x9c/0x120
[    2.416215]  ? __phys_addr+0x40/0x60
[    2.416573]  ? __phys_addr+0x40/0x60
[    2.416968]  ? exc_invalid_op+0x53/0x70
[    2.417358]  ? __phys_addr+0x40/0x60
[    2.417709]  ? asm_exc_invalid_op+0x1a/0x20
[    2.418122]  ? __pfx_kernel_init+0x10/0x10
[    2.418569]  ? __phys_addr+0x40/0x60
[    2.418960]  _xbc_exit+0x74/0xc0
[    2.419374]  kernel_init+0x3a/0x1c0
[    2.419764]  ret_from_fork+0x34/0x50
[    2.420132]  ? __pfx_kernel_init+0x10/0x10
[    2.420578]  ret_from_fork_asm+0x1a/0x30
[    2.420973]  </TASK>
[    2.421200] Modules linked in:
[    2.421598] ---[ end trace 0000000000000000 ]---
[    2.422053] RIP: 0010:__phys_addr+0x40/0x60
[    2.422484] Code: 48 2b 05 fb a4 3d 01 48 05 00 00 00 80 48 39 c7 72 17 0f b6 0d ee 9e c0 01 48 89 c2 48 d3 ea 48 85 d2 75 05 c3 cc cc cc cc 90 <0f> 0b 48 03 05 e7 e2 9d 01 48 81 ff ff ff ff 1f 76 e8 90 0f6
[    2.424294] RSP: 0000:ffffc90000013f18 EFLAGS: 00010287
[    2.424769] RAX: 0000778000000000 RBX: ffffffff81c17940 RCX: 000000000080000a
[    2.425378] RDX: 000000000080000b RSI: ffff88800775f320 RDI: 0000000080000000
[    2.425993] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[    2.426589] R10: ffff888005028a60 R11: 000000000080000a R12: 0000000000000000
[    2.427156] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[    2.427746] FS:  0000000000000000(0000) GS:ffff88807d9c0000(0000) knlGS:0000000000000000
[    2.428368] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.428820] CR2: 0000000000000000 CR3: 0000000002a48000 CR4: 00000000000006b0
[    2.429373] Kernel panic - not syncing: Fatal exception
[    2.429982] Kernel Offset: disabled
[    2.430261] ---[ end Kernel panic - not syncing: Fatal exception ]---

Adding below patch fixed it.

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index f9a45adc6307..8841554432d5 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -65,7 +65,7 @@ static inline void __init xbc_free_mem(void *addr, size_t size, bool early)
 {
 	if (early)
 		memblock_free(addr, size);
-	else
+	else if (addr)
 		memblock_free_late(__pa(addr), size);
 }
 
Can you update with this fix?

Thank you,


On Fri, 12 Apr 2024 22:18:20 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Fri, 12 Apr 2024 18:49:41 +0800
> qiang4.zhang@linux.intel.com wrote:
> 
> > From: Qiang Zhang <qiang4.zhang@intel.com>
> > 
> > On the time to free xbc memory in xbc_exit(), memblock may has handed
> > over memory to buddy allocator. So it doesn't make sense to free memory
> > back to memblock. memblock_free() called by xbc_exit() even causes UAF bugs
> > on architectures with CONFIG_ARCH_KEEP_MEMBLOCK disabled like x86.
> > Following KASAN logs shows this case.
> > 
> > This patch fixes the xbc memory free problem by calling memblock_free()
> > in early xbc init error rewind path and calling memblock_free_late() in
> > xbc exit path to free memory to buddy allocator.
> > 
> > [    9.410890] ==================================================================
> > [    9.418962] BUG: KASAN: use-after-free in memblock_isolate_range+0x12d/0x260
> > [    9.426850] Read of size 8 at addr ffff88845dd30000 by task swapper/0/1
> > 
> > [    9.435901] CPU: 9 PID: 1 Comm: swapper/0 Tainted: G     U             6.9.0-rc3-00208-g586b5dfb51b9 #5
> > [    9.446403] Hardware name: Intel Corporation RPLP LP5 (CPU:RaptorLake)/RPLP LP5 (ID:13), BIOS IRPPN02.01.01.00.00.19.015.D-00000000 Dec 28 2023
> > [    9.460789] Call Trace:
> > [    9.463518]  <TASK>
> > [    9.465859]  dump_stack_lvl+0x53/0x70
> > [    9.469949]  print_report+0xce/0x610
> > [    9.473944]  ? __virt_addr_valid+0xf5/0x1b0
> > [    9.478619]  ? memblock_isolate_range+0x12d/0x260
> > [    9.483877]  kasan_report+0xc6/0x100
> > [    9.487870]  ? memblock_isolate_range+0x12d/0x260
> > [    9.493125]  memblock_isolate_range+0x12d/0x260
> > [    9.498187]  memblock_phys_free+0xb4/0x160
> > [    9.502762]  ? __pfx_memblock_phys_free+0x10/0x10
> > [    9.508021]  ? mutex_unlock+0x7e/0xd0
> > [    9.512111]  ? __pfx_mutex_unlock+0x10/0x10
> > [    9.516786]  ? kernel_init_freeable+0x2d4/0x430
> > [    9.521850]  ? __pfx_kernel_init+0x10/0x10
> > [    9.526426]  xbc_exit+0x17/0x70
> > [    9.529935]  kernel_init+0x38/0x1e0
> > [    9.533829]  ? _raw_spin_unlock_irq+0xd/0x30
> > [    9.538601]  ret_from_fork+0x2c/0x50
> > [    9.542596]  ? __pfx_kernel_init+0x10/0x10
> > [    9.547170]  ret_from_fork_asm+0x1a/0x30
> > [    9.551552]  </TASK>
> > 
> > [    9.555649] The buggy address belongs to the physical page:
> > [    9.561875] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x45dd30
> > [    9.570821] flags: 0x200000000000000(node=0|zone=2)
> > [    9.576271] page_type: 0xffffffff()
> > [    9.580167] raw: 0200000000000000 ffffea0011774c48 ffffea0012ba1848 0000000000000000
> > [    9.588823] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
> > [    9.597476] page dumped because: kasan: bad access detected
> > 
> > [    9.605362] Memory state around the buggy address:
> > [    9.610714]  ffff88845dd2ff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > [    9.618786]  ffff88845dd2ff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > [    9.626857] >ffff88845dd30000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > [    9.634930]                    ^
> > [    9.638534]  ffff88845dd30080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > [    9.646605]  ffff88845dd30100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > [    9.654675] ==================================================================
> > 
> > Cc: Stable@vger.kernel.org
> > Signed-off-by: Qiang Zhang <qiang4.zhang@intel.com>
> 
> Looks good to me.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Also,
> 
> Fixes: 40caa127f3c7 ("init: bootconfig: Remove all bootconfig data when the init memory is removed")
> 
> Let me pick this for bootconfig/fixes.
> 
> Thanks!
> 
> > ---
> > v2:
> > - add an early flag in xbc_free_mem() to free memory back to memblock in
> >   xbc_init error path or put memory to buddy allocator in normal xbc_exit.
> > 
> > ---
> >  include/linux/bootconfig.h |  7 ++++++-
> >  lib/bootconfig.c           | 19 +++++++++++--------
> >  2 files changed, 17 insertions(+), 9 deletions(-)
> > 
> > diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
> > index e5ee2c694401..3f4b4ac527ca 100644
> > --- a/include/linux/bootconfig.h
> > +++ b/include/linux/bootconfig.h
> > @@ -288,7 +288,12 @@ int __init xbc_init(const char *buf, size_t size, const char **emsg, int *epos);
> >  int __init xbc_get_info(int *node_size, size_t *data_size);
> >  
> >  /* XBC cleanup data structures */
> > -void __init xbc_exit(void);
> > +void __init _xbc_exit(bool early);
> > +
> > +static inline void xbc_exit(void)
> > +{
> > +	_xbc_exit(false);
> > +}
> >  
> >  /* XBC embedded bootconfig data in kernel */
> >  #ifdef CONFIG_BOOT_CONFIG_EMBED
> > diff --git a/lib/bootconfig.c b/lib/bootconfig.c
> > index c59d26068a64..f9a45adc6307 100644
> > --- a/lib/bootconfig.c
> > +++ b/lib/bootconfig.c
> > @@ -61,9 +61,12 @@ static inline void * __init xbc_alloc_mem(size_t size)
> >  	return memblock_alloc(size, SMP_CACHE_BYTES);
> >  }
> >  
> > -static inline void __init xbc_free_mem(void *addr, size_t size)
> > +static inline void __init xbc_free_mem(void *addr, size_t size, bool early)
> >  {
> > -	memblock_free(addr, size);
> > +	if (early)
> > +		memblock_free(addr, size);
> > +	else
> > +		memblock_free_late(__pa(addr), size);
> >  }
> >  
> >  #else /* !__KERNEL__ */
> > @@ -73,7 +76,7 @@ static inline void *xbc_alloc_mem(size_t size)
> >  	return malloc(size);
> >  }
> >  
> > -static inline void xbc_free_mem(void *addr, size_t size)
> > +static inline void xbc_free_mem(void *addr, size_t size, bool early)
> >  {
> >  	free(addr);
> >  }
> > @@ -904,13 +907,13 @@ static int __init xbc_parse_tree(void)
> >   * If you need to reuse xbc_init() with new boot config, you can
> >   * use this.
> >   */
> > -void __init xbc_exit(void)
> > +void __init _xbc_exit(bool early)
> >  {
> > -	xbc_free_mem(xbc_data, xbc_data_size);
> > +	xbc_free_mem(xbc_data, xbc_data_size, early);
> >  	xbc_data = NULL;
> >  	xbc_data_size = 0;
> >  	xbc_node_num = 0;
> > -	xbc_free_mem(xbc_nodes, sizeof(struct xbc_node) * XBC_NODE_MAX);
> > +	xbc_free_mem(xbc_nodes, sizeof(struct xbc_node) * XBC_NODE_MAX, early);
> >  	xbc_nodes = NULL;
> >  	brace_index = 0;
> >  }
> > @@ -963,7 +966,7 @@ int __init xbc_init(const char *data, size_t size, const char **emsg, int *epos)
> >  	if (!xbc_nodes) {
> >  		if (emsg)
> >  			*emsg = "Failed to allocate bootconfig nodes";
> > -		xbc_exit();
> > +		_xbc_exit(true);
> >  		return -ENOMEM;
> >  	}
> >  	memset(xbc_nodes, 0, sizeof(struct xbc_node) * XBC_NODE_MAX);
> > @@ -977,7 +980,7 @@ int __init xbc_init(const char *data, size_t size, const char **emsg, int *epos)
> >  			*epos = xbc_err_pos;
> >  		if (emsg)
> >  			*emsg = xbc_err_msg;
> > -		xbc_exit();
> > +		_xbc_exit(true);
> >  	} else
> >  		ret = xbc_node_num;
> >  
> > -- 
> > 2.39.2
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


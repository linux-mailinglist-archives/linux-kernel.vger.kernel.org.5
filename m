Return-Path: <linux-kernel+bounces-26492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9947082E20D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 21:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33222283B04
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 20:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AD01AADF;
	Mon, 15 Jan 2024 20:58:37 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD411AACF
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 20:58:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C0FC433C7;
	Mon, 15 Jan 2024 20:58:35 +0000 (UTC)
Date: Mon, 15 Jan 2024 15:58:33 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Ajay Kaher <akaher@vmware.com>, Al Viro
 <viro@ZenIV.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Subject: Re: [for-next][PATCH 2/3] eventfs: Stop using dcache_readdir() for
 getdents()
Message-ID: <20240115155833.57c9a38b@rorschach.local.home>
In-Reply-To: <20240104164738.483305222@goodmis.org>
References: <20240104164703.808999991@goodmis.org>
	<20240104164738.483305222@goodmis.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 04 Jan 2024 11:47:05 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The eventfs creates dynamically allocated dentries and inodes. Using the
> dcache_readdir() logic for its own directory lookups requires hiding the
> cursor of the dcache logic and playing games to allow the dcache_readdir()
> to still have access to the cursor while the eventfs saved what it created
> and what it needs to release.
> 
> Instead, just have eventfs have its own iterate_shared callback function
> that will fill in the dent entries. This simplifies the code quite a bit.
> 
> Link: https://lore.kernel.org/linux-trace-kernel/20240104015435.682218477@goodmis.org

So now I know why Ajay did what he did with the
dcach_dir_open_wrapper():

  https://lore.kernel.org/all/202401152142.bfc28861-oliver.sang@intel.com/

Basically it crashed with:

> [   41.602625][ T4377] kernel BUG at fs/dcache.c:2031!
> [   41.602625][ T4374] RSP: 0018:ffa000000fcdfcd0 EFLAGS: 00010286
> [   41.602629][ T4374] RAX: 0000000000000002 RBX: ff11000109392980 RCX: 0000000000000000
> [   41.602630][ T4374] RDX: 0000000000000000 RSI: ff1100405e46c6f0 RDI: ff1100405f05afc0
> [   41.602631][ T4374] RBP: ff1100405f05afc0 R08: ffffffff830ad0e0 R09: 0000000000000000
> [   41.602632][ T4374] R10: 0000000000000280 R11: ffffffff8162036a R12: 0000000000000000
> [   41.602633][ T4374] R13: ff1100405e46c6f0 R14: ff1100405f05aff8 R15: 0000000000000000
> [   41.602634][ T4374] FS:  00007f2582ff9740(0000) GS:ff1100407fa80000(0000) knlGS:0000000000000000
> [   41.602635][ T4374] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   41.602635][ T4374] CR2: 00005624511f3328 CR3: 000000208a342006 CR4: 0000000000771ef0
> [   41.602636][ T4374] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   41.602637][ T4374] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   41.602638][ T4374] PKRU: 55555554
> [   41.602638][ T4374] Call Trace:
> [   41.602640][ T4374]  <TASK>
> [ 41.602642][ T4374] ? die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434 arch/x86/kernel/dumpstack.c:447) 
> [ 41.602644][ T4374] ? do_trap (arch/x86/kernel/traps.c:112 arch/x86/kernel/traps.c:153) 
> [ 41.602645][ T4374] ? d_instantiate (fs/dcache.c:2031 (discriminator 1)) 
> [ 41.602647][ T4374] ? do_error_trap (arch/x86/include/asm/traps.h:59 arch/x86/kernel/traps.c:174) 
> [ 41.602648][ T4374] ? d_instantiate (fs/dcache.c:2031 (discriminator 1)) 
> [ 41.602649][ T4374] ? exc_invalid_op (arch/x86/kernel/traps.c:265) 
> [ 41.602652][ T4374] ? d_instantiate (fs/dcache.c:2031 (discriminator 1)) 
> [ 41.602653][ T4374] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:568) 
> [ 41.602655][ T4374] ? tracefs_alloc_inode (fs/tracefs/inode.c:38) 
> [ 41.602657][ T4374] ? d_instantiate (fs/dcache.c:2031 (discriminator 1)) 
> [ 41.602659][ T4374] create_dir_dentry (fs/tracefs/event_inode.c:329 fs/tracefs/event_inode.c:516) 
> [ 41.602661][ T4374] eventfs_root_lookup (fs/tracefs/event_inode.c:611) 
> [ 41.602662][ T4374] ? terminate_walk (fs/namei.c:691) 
> [ 41.602665][ T4374] __lookup_slow (fs/namei.c:1694) 
> [ 41.602667][ T4374] lookup_one_len (fs/namei.c:2746 (discriminator 1)) 
> [ 41.602669][ T4374] eventfs_start_creating (fs/tracefs/inode.c:536) 
> [ 41.602671][ T4374] create_dir_dentry (fs/tracefs/event_inode.c:309 fs/tracefs/event_inode.c:516) 
> [ 41.602673][ T4374] eventfs_iterate (fs/tracefs/event_inode.c:701) 
> [ 41.602674][ T4374] ? atime_needs_update (fs/inode.c:1842 fs/inode.c:1994) 
> [ 41.602677][ T4374] iterate_dir (fs/readdir.c:106) 
> [ 41.602680][ T4374] __x64_sys_getdents (fs/readdir.c:323 fs/readdir.c:307 fs/readdir.c:307) 
> [ 41.602682][ T4374] ? __pfx_filldir (fs/readdir.c:260) 
> [ 41.602684][ T4374] do_syscall_64 (arch/x86/entry/common.c:51 arch/x86/entry/common.c:82) 
> [ 41.602686][ T4374] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 

I guess that's because I'm creating the inodes and dentries in the
iterare_shared() and not at open. The inodes and dentries are created
with a ref count of zero, as they should be freed when no longer used.
But I don't think the getdents() can handle that in the iterator part.
I do need to create the inodes/dentries in the open, up their ref count
and dec the ref counts at the release.

But I still do not need the dcache_readdir() code to do it. I just have
to create an array of inodes to use at the open (like the code did
before this update), and have the iterate_shared() use that array, and
then the release just decrement the inodes/dentries.

I'm off today, so I will likely fix that tomorrow.

-- Steve


Return-Path: <linux-kernel+bounces-15514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED20D822CF9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 829A51F242AF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A3818EDB;
	Wed,  3 Jan 2024 12:25:45 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391F618ECA
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 12:25:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E861DC433C7;
	Wed,  3 Jan 2024 12:25:43 +0000 (UTC)
Date: Wed, 3 Jan 2024 12:25:41 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Christoph von Recklinghausen <crecklin@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] don't record leak information on allocations done
 between kmemleak_init and kmemleak_late_init
Message-ID: <ZZVSRSsychidiQ8P@arm.com>
References: <20240102153428.139984-1-crecklin@redhat.com>
 <ZZRtGC9ZPVR5uCqu@arm.com>
 <5d979584-a168-4594-af19-93af6bc0ae5a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d979584-a168-4594-af19-93af6bc0ae5a@redhat.com>

(as you noticed, don't post html as they usually get rejected from
lists)

On Wed, Jan 03, 2024 at 06:20:16AM -0500, Christoph von Recklinghausen wrote:
> On 1/2/24 15:07, Catalin Marinas wrote:
> > On Tue, Jan 02, 2024 at 10:34:28AM -0500, Chris von Recklinghausen wrote:
> > > If an object is allocated after kmemleak_init is called but before
> > > kmemleak_late_init is called, calls to kmemleak_not_leak or
> > > kmemleak_ignore on the object don't prevent a scan from reporting the
> > > object as a leak.
> > This may be true but what is the reason for this? Can you give some
> > example of false positives you get?
> 
> In centos-stream-9 on s390x I get the following complaint:
> 
> WARN:(libsan.host.linux) Found kernel memory leak:
> unreferenced object 0x1bff7fffb30000 (size 65536):
> comm "swapper/0", pid 0, jiffies 4294937297 (age 76.530s)
> hex dump (first 32 bytes):
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
> backtrace:
> [<00000000eda98345>] __vmalloc_node_range+0x29a/0x360
> [<00000000e3051c75>] __vmalloc_node+0x9e/0xd0
> [<00000000a5dd11b7>] stack_alloc+0x38/0x50
> [<0000000081096e42>] smp_reinit_ipl_cpu+0xf8/0x3f8
> [<00000000ee13aae5>] arch_call_rest_init+0x22/0x100
> [<00000000b37567c9>] start_kernel+0x44c/0x460
> [<00000000548d9080>] startup_continue+0x30/0x50
> 
> 
> In arch/s390/kernel/setup.c we have
> 
> unsigned long stack_alloc(void)
> {
> #ifdef CONFIG_VMAP_STACK
>         return (unsigned long)__vmalloc_node(THREAD_SIZE, THREAD_SIZE,
>                         THREADINFO_GFP, NUMA_NO_NODE,
>                         __builtin_return_address(0));
> #else
>         return __get_free_pages(GFP_KERNEL, THREAD_SIZE_ORDER);
> #endif
> }

I guess that's an older kernel as arch_call_rest_init() is no longer in
mainline.

Mainline stack_alloc() has a kmemleak_not_leak() call here with an
explanation in the commit log (it should have been added as a comment in
the code), 436fc4feeabb ("s390: add kmemleak annotation in
stack_alloc()"):

    kmemleak with enabled auto scanning reports that our stack allocation is
    lost. This is because we're saving the pointer + STACK_INIT_OFFSET to
    lowcore. When kmemleak now scans the objects, it thinks that this one is
    lost because it can't find a corresponding pointer.

Does this commit not fix it for you? It looks like it did the trick in
mainline. Late kmemleak initialisation should not interfere unless you
have a very old kernel and we had some bugs with tracking these (before
we introduced the mem_pool[] array in kmemleak for early allocations).

> void __init arch_call_rest_init(void)
> {
>         unsigned long stack;
> 
>         smp_reinit_ipl_cpu();
>         stack = stack_alloc();
>         if (!stack)
>                 panic("Couldn't allocate kernel stack");
>         current->stack = (void *) stack;
> #ifdef CONFIG_VMAP_STACK
>         current->stack_vm_area = (void *) stack;
> #endif

In mainline at least, stack_vm_area is a struct vm_struct, so it
shouldn't be assigned the actual stack pointer (but maybe that's not the
case in your version, I haven't checked the history).

-- 
Catalin


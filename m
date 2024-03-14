Return-Path: <linux-kernel+bounces-103468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D511787BFBA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F6F61F2290E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDF871B20;
	Thu, 14 Mar 2024 15:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbiD7W6I"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DC171726
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 15:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710429516; cv=none; b=q9UlGxd+GTwH4QEVzAXt1KIClUt3geFErR+b0U70TI9nYl4EGrs0z4M2AxGPTjLenjUgefST6grfZyTkXAwHk3AEgymuf+jG29QJjLiyrxYEOOjI2oA2E5t58tEkRGo7VSGcdL5hs8NwWSAJpWPDhhp+Q9AhVnP/OsCdpn8XhSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710429516; c=relaxed/simple;
	bh=EU8jpUhL5GgEXEu7wLklWaTowF5j7uTiw5r2kUFvMhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I4cQR4yYJNdCVVhMsOSYYs/3Wqo3zVMpd1ERu1lpdMcmnsTw7Y7qxh0R4ySxPYpseKeRG05Bv4iYGPzW6rqYZf/9oz5V/FALGMeni/+OsH2K6BMi6zG4N3UHHkyi9dTkDOcRMsiJ9vPJQ9ZFk1ZcaDGiNiqaXtIXWshDhgDvh6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbiD7W6I; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5a467dae51dso149004eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 08:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710429514; x=1711034314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IWsC9prqwICBYDqBo6dF4hTx/BRGLZfubNXJsXjlBYs=;
        b=lbiD7W6IoGZR4gw0KwTaDIyjZB/FFjxsBhoy6/DvMWkaqDRIJUkpJrNImioK6msP1d
         HScNJS0YODj5syIgc+SlHWzE0V+eCnxRTaXe7b3XAySjlEyxaNfzms1l9OrApcS4Iyty
         A++4bSZRYzcuEMPAZLn/B64bKz+gwOkwGYknNbjbUy2+ftw7pTZQRBfPei3IaCPG4Swo
         dXwHMxifwx3T9hqGaQ6ZguWonX/bhSeH3XryxI9SGrjD7fQMP2WJJcNEqPoll3y24j6U
         p2JPSgZmBeg5jIvpEH1MS4Y5/vqQVVXEEhRauijyACYNeF8nzQOuDiLghymkCIHOlnbO
         Ld5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710429514; x=1711034314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IWsC9prqwICBYDqBo6dF4hTx/BRGLZfubNXJsXjlBYs=;
        b=AQonPQ5ZzWBnKB8Pe/iAVWJE/96zpJ2DfG8aHuqi38Ut9ywbQR/2JH1yxU+KXJXcMt
         XVe7FHgXDoadafegpSvaP4JzUZcdl057AuTbAgZbdJrMl4pu8YYpzfrc8DIVQPVMdtaH
         vx52ANkbLJhG2E8Mxg903Iv/eZcBTUpfAxMh0reoBrAzkEsPUa/29kAdDs5K93g6C8+d
         JMqYG+1Lp+Xxrha9u7f5d0dSoCLVOOcAqLX2kDFJS44ATpi1LEXua5eybXOeZvMKbVD0
         x60e3vybUwOycEBtJ2anD3L0LtpfB4IfMQkFwo9L+hAXV5XoLWo07Ce0n9YN+GTxa1VC
         9NXg==
X-Gm-Message-State: AOJu0YwRzUhxmtHLpcjKsnVihbWMX9SUR8r9hCk5sCmLYJvDtq6CKwR6
	Lon8oDkbO4I6/S6MGEK9jy4rnb4hR7001TZBdmw5WLyqmVGiO/2pl/YOCiz7G8wgVmtiDN3LT2Z
	OY/MgBbq+MdOevK0vlsbUae5CDcs=
X-Google-Smtp-Source: AGHT+IFj5GGTqbHDRgk6XwRqs02zEkGQLWdkmfRTZNYSN1PC5QPEmUc5TmvsUj+fBkjZMA8YNutwqMP1JXY/k+RK82k=
X-Received: by 2002:a4a:6101:0:b0:5a1:c19d:bd39 with SMTP id
 n1-20020a4a6101000000b005a1c19dbd39mr2215226ooc.3.1710429513690; Thu, 14 Mar
 2024 08:18:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com> <20240311164638.2015063-9-pasha.tatashin@soleen.com>
In-Reply-To: <20240311164638.2015063-9-pasha.tatashin@soleen.com>
From: Jeff Xie <xiehuan09@gmail.com>
Date: Thu, 14 Mar 2024 23:18:21 +0800
Message-ID: <CAEr6+EDfGyJG3481RUWTamGiG2aNPDWjqSGRJaKGova-Yj8SUw@mail.gmail.com>
Subject: Re: [RFC 08/14] fork: separate vmap stack alloction and free calls
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, x86@kernel.org, bp@alien8.de, brauner@kernel.org, 
	bristot@redhat.com, bsegall@google.com, dave.hansen@linux.intel.com, 
	dianders@chromium.org, dietmar.eggemann@arm.com, eric.devolder@oracle.com, 
	hca@linux.ibm.com, hch@infradead.org, hpa@zytor.com, 
	jacob.jun.pan@linux.intel.com, jgg@ziepe.ca, jpoimboe@kernel.org, 
	jroedel@suse.de, juri.lelli@redhat.com, kent.overstreet@linux.dev, 
	kinseyho@google.com, kirill.shutemov@linux.intel.com, lstoakes@gmail.com, 
	luto@kernel.org, mgorman@suse.de, mic@digikod.net, 
	michael.christie@oracle.com, mingo@redhat.com, mjguzik@gmail.com, 
	mst@redhat.com, npiggin@gmail.com, peterz@infradead.org, pmladek@suse.com, 
	rick.p.edgecombe@intel.com, rostedt@goodmis.org, surenb@google.com, 
	tglx@linutronix.de, urezki@gmail.com, vincent.guittot@linaro.org, 
	vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 12:47=E2=80=AFAM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> In preparation for the dynamic stacks, separate out the
> __vmalloc_node_range and vfree calls from the vmap based stack
> allocations. The dynamic stacks will use their own variants of these
> functions.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  kernel/fork.c | 53 ++++++++++++++++++++++++++++++---------------------
>  1 file changed, 31 insertions(+), 22 deletions(-)
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 3004e6ce6c65..bbae5f705773 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -204,6 +204,29 @@ static bool try_release_thread_stack_to_cache(struct=
 vm_struct *vm_area)
>         return false;
>  }
>
> +static inline struct vm_struct *alloc_vmap_stack(int node)
> +{
> +       void *stack;
> +
> +       /*
> +        * Allocated stacks are cached and later reused by new threads,
> +        * so memcg accounting is performed manually on assigning/releasi=
ng
> +        * stacks to tasks. Drop __GFP_ACCOUNT.
> +        */
> +       stack =3D __vmalloc_node_range(THREAD_SIZE, THREAD_ALIGN,
> +                                    VMALLOC_START, VMALLOC_END,
> +                                    THREADINFO_GFP & ~__GFP_ACCOUNT,
> +                                    PAGE_KERNEL,
> +                                    0, node, __builtin_return_address(0)=
);
> +
> +       return (stack) ? find_vm_area(stack) : NULL;
> +}
> +
> +static inline void free_vmap_stack(struct vm_struct *vm_area)
> +{
> +       vfree(vm_area->addr);
> +}
> +
>  static void thread_stack_free_rcu(struct rcu_head *rh)
>  {
>         struct vm_stack *vm_stack =3D container_of(rh, struct vm_stack, r=
cu);
> @@ -212,7 +235,7 @@ static void thread_stack_free_rcu(struct rcu_head *rh=
)
>         if (try_release_thread_stack_to_cache(vm_stack->stack_vm_area))
>                 return;
>
> -       vfree(vm_area->addr);
> +       free_vmap_stack(vm_area);
>  }

I've discovered that the function free_vmap_stack() can trigger a warning.
It appears that free_vmap_stack() should handle interrupt context and
task context separately as vfree().

[root@JeffXie ]# poweroff
[root@JeffXie ]# umount: devtmpfs busy - remounted read-only
[   93.036872] EXT4-fs (vda): re-mounted
2e1f057b-471f-4c08-a7b8-611457b221f2 ro. Quota mode: none.
The system is going down NOW!
Sent SIGTERM to all processes
Sent SIGKILL to all processes
Requesting system poweroff
[   94.043540] ------------[ cut here ]------------
[   94.043977] WARNING: CPU: 0 PID: 0 at kernel/smp.c:786
smp_call_function_many_cond+0x4e5/0x550
[   94.044744] Modules linked in:
[   94.045024] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
6.8.0-00014-g82270db6e1f0 #91
[   94.045697] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.15.0-1 04/01/2014
[   94.046399] RIP: 0010:smp_call_function_many_cond+0x4e5/0x550
[   94.046914] Code: 48 8b 78 08 48 c7 c1 a0 84 16 81 4c 89 f6 e8 22
11 f6 ff 65 ff 0d 23 38 ec 7e 0f 85 a1 fc ff ff 0f 1f 44 00 00 e9 97
fc ff ff <0f> 0b e9 61
[   94.048509] RSP: 0018:ffffc90000003e48 EFLAGS: 00010206
[   94.048965] RAX: ffffffff82cb3fd0 RBX: ffff88811862cbc0 RCX: 00000000000=
00003
[   94.049598] RDX: 0000000000000100 RSI: 0000000000000000 RDI: 00000000000=
00000
[   94.050226] RBP: ffff8881052c5090 R08: 0000000000000000 R09: 00000000000=
00001
[   94.050861] R10: ffffffff82a060c0 R11: 0000000000008847 R12: ffff888102e=
b3500
[   94.051480] R13: ffff88811862b800 R14: ffff88811862cc38 R15: 00000000000=
00000
[   94.052109] FS:  0000000000000000(0000) GS:ffff888118600000(0000)
knlGS:0000000000000000
[   94.052812] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   94.053318] CR2: 00000000004759e0 CR3: 0000000002a2e000 CR4: 00000000007=
50ef0
[   94.053955] PKRU: 55555554
[   94.054203] Call Trace:
[   94.054433]  <IRQ>
[   94.054632]  ? __warn+0x84/0x140
[   94.054925]  ? smp_call_function_many_cond+0x4e5/0x550
[   94.055362]  ? report_bug+0x199/0x1b0
[   94.055697]  ? handle_bug+0x3c/0x70
[   94.056010]  ? exc_invalid_op+0x18/0x70
[   94.056350]  ? asm_exc_invalid_op+0x1a/0x20
[   94.056728]  ? smp_call_function_many_cond+0x4e5/0x550
[   94.057179]  ? __pfx_do_kernel_range_flush+0x10/0x10
[   94.057622]  on_each_cpu_cond_mask+0x24/0x40
[   94.057999]  flush_tlb_kernel_range+0x98/0xb0
[   94.058390]  free_unmap_vmap_area+0x2d/0x40
[   94.058768]  remove_vm_area+0x3a/0x70
[   94.059094]  free_vmap_stack+0x15/0x60
[   94.059427]  rcu_core+0x2bf/0x980
[   94.059735]  ? rcu_core+0x244/0x980
[   94.060046]  ? kvm_clock_get_cycles+0x18/0x30
[   94.060431]  __do_softirq+0xc2/0x292
[   94.060760]  irq_exit_rcu+0x6a/0x90
[   94.061074]  sysvec_apic_timer_interrupt+0x6e/0x90
[   94.061507]  </IRQ>
[   94.061704]  <TASK>
[   94.061903]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[   94.062367] RIP: 0010:default_idle+0xf/0x20
[   94.062746] Code: 4c 01 c7 4c 29 c2 e9 72 ff ff ff 90 90 90 90 90
90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d 33 b4 2a
00 fb f4 <fa> c3 cc c0
[   94.064342] RSP: 0018:ffffffff82a03e70 EFLAGS: 00000212
[   94.064805] RAX: ffff888118628608 RBX: ffffffff82a0c980 RCX: 00000000000=
00000
[   94.065429] RDX: 4000000000000000 RSI: ffffffff82725be8 RDI: 00000000000=
0a14c
[   94.066066] RBP: 0000000000000000 R08: 000000000000a14c R09: 00000000000=
00001
[   94.066705] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00000
[   94.067311] R13: 0000000000000000 R14: ffffffff82a0c030 R15: 00000000000=
000ac
[   94.067936]  default_idle_call+0x2c/0xd0
[   94.068284]  do_idle+0x1ce/0x210
[   94.068584]  cpu_startup_entry+0x2a/0x30
[   94.068931]  rest_init+0xc5/0xd0
[   94.069224]  arch_call_rest_init+0xe/0x30
[   94.069597]  start_kernel+0x58e/0x8d0
[   94.069929]  x86_64_start_reservations+0x18/0x30
[   94.070353]  x86_64_start_kernel+0xc6/0xe0
[   94.070725]  secondary_startup_64_no_verify+0x16d/0x17b
[   94.071189]  </TASK>
[   94.071392] ---[ end trace 0000000000000000 ]---
[   95.040718] e1000e: EEE TX LPI TIMER: 00000000
[   95.055005] ACPI: PM: Preparing to enter system sleep state S5
[   95.055619] reboot: Power down


 ./scripts/faddr2line ./vmlinux smp_call_function_many_cond+0x4e5/0x550
smp_call_function_many_cond+0x4e5/0x550:
smp_call_function_many_cond at kernel/smp.c:786 (discriminator 1)

 756 static void smp_call_function_many_cond(const struct cpumask *mask,
 757                                         smp_call_func_t func, void *in=
fo,
 758                                         unsigned int scf_flags,
 759                                         smp_cond_func_t cond_func)
[...]
 781          * When @wait we can deadlock when we interrupt between
llist_add() and
 782          * arch_send_call_function_ipi*(); when !@wait we can
deadlock due to
 783          * csd_lock() on because the interrupt context uses the same c=
sd
 784          * storage.
 785          */
 786         WARN_ON_ONCE(!in_task());
// <<< warning here
[...]



--=20
Thanks,
JeffXie


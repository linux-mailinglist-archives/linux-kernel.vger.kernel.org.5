Return-Path: <linux-kernel+bounces-119394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C8F88C823
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3950D1F802BF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6309F13D242;
	Tue, 26 Mar 2024 15:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="bZhX3a6w"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFC713CFAC
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 15:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711468393; cv=none; b=pqNN6xQrR8pp1muuXvOdNmjvrlDoNMXZk82T+E6PMB1Q4NTlIoKhyfXNtpr1Ibgk1BmEfGiNGkWFpscaXXU2OrrKbI/SVo7/Ck1nyxInLvu+XKSE/JuvM3r2+b1Ki0qPaMIQZS83epBhwGocAiKN1oCIMwVvpn4gii14htJJwUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711468393; c=relaxed/simple;
	bh=CMYGhs1gXEUfzVLwLKQFOQK6SPtPUQZCTfrV/Hgx2GU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNU/OVV6MQWjf8o4yyS40iE8HGZMytyFpRqZyGIiAFa7aIWDLEypWPaSfg84OpjOAh/uXsIhVbG8eN8oUqwChyXSsoH/tbkqYP1f/TcoYX8JnJoeWMyzm/YWZqLa8UGP/1+rN3KBRS6MGQucLjYieJDejbyn1yz918UYV+x0Wt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=bZhX3a6w; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C6E0E40E02A6;
	Tue, 26 Mar 2024 15:53:07 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Xxzb6lMyPGkW; Tue, 26 Mar 2024 15:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711468384; bh=TcZAuev01yKZaJPvDyAUZzPEAjCX2jHAgYb7hloP0qg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bZhX3a6wfjs7R5QZ9n1OGetMIxdodBb1ktAPUVyaasWwUXWHD3iLRnAGHSjIfIwU3
	 PDQqHNXvzpF23KeTu1fdTSz0DGJkifGwKzXQ7iTIsRVD58wg+XfcApyXioQFBN+w6d
	 n0qli2AH+DVnpbAJL4QkHUWsZxANrgRl2dZ1ttAPY1TYbXEoB01YuA7h8fZ49AqFSZ
	 QHyxd57RLHaSGTjggh2rz0dqGc5x6+lvBlr0tRwUAp7IDQEou+JJXRnG6TeYJAYDlo
	 GSTc/SS51o21jzHFEKcQblpS4jsftFuVjRRKw9wqGWMZWcEmfh7zznilw4QHhp+tQC
	 mB51o2YpF+v1o84htIe307bCXw8fbGU5x2iI3Hp/F0ca49SWYZIPYkc1dyIbMh3wQp
	 r2oOlOr2TJHyVcEsM2YMnnI6j7XKeRX3fzSvui8gLo0xPzmapt6Vzs5ig2pM8sUZOd
	 u5yI9HcetGJWq6Fs9Svy3qEaCHK91bEgLcCB0FPwT1mB+OYsafAKbFKJo/tf8vnr8X
	 8hIBCB2CMw5g44FFAYzFVVB4AMfKhI9gikcXhhkY4v53qgXcwd4o1muJ9IFFWcmlre
	 z98UO+4ceov+S+gs6onwFvjcD29izKYusPiHONhSLRfexdXr4i5chdDVZGzNFQGDaG
	 8rS5Uig/xeYqd6P9dvOv4PaY=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8004540E024C;
	Tue, 26 Mar 2024 15:52:53 +0000 (UTC)
Date: Tue, 26 Mar 2024 16:52:47 +0100
From: Borislav Petkov <bp@alien8.de>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	LKML <linux-kernel@vger.kernel.org>, Marco Elver <elver@google.com>,
	kasan-dev@googlegroups.com
Subject: Re: Unpatched return thunk in use. This should not happen!
Message-ID: <20240326155247.GJZgLvT_AZi3XPPpBM@fat_crate.local>
References: <0851a207-7143-417e-be31-8bf2b3afb57d@molgen.mpg.de>
 <47e032a0-c9a0-4639-867b-cb3d67076eaf@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <47e032a0-c9a0-4639-867b-cb3d67076eaf@suse.com>

On Tue, Mar 26, 2024 at 04:08:32PM +0200, Nikolay Borisov wrote:
> So the problem happens when KCSAN=y CONFIG_CONSTRUCTORS is also enabled and
> this results in an indirect call in do_mod_ctors():
> 
>    mod->ctors[i]();
> 
> 
> When KCSAN is disabled, do_mod_ctors is empty, hence the warning is not
> printed.

Yeah, KCSAN is doing something weird. I was able to stop the guest when
the warning fires. Here's what I see:

The callstack when it fires:

#0  warn_thunk_thunk () at arch/x86/entry/entry.S:48
#1  0xffffffff811a98f9 in do_mod_ctors (mod=0xffffffffa00052c0) at kernel/module/main.c:2462
#2  do_init_module (mod=mod@entry=0xffffffffa00052c0) at kernel/module/main.c:2535
#3  0xffffffff811ad2e1 in load_module (info=info@entry=0xffffc900004c7dd0, uargs=uargs@entry=0x564c103dd4a0 "", flags=flags@entry=0) at kernel/module/main.c:3001
#4  0xffffffff811ad8ef in init_module_from_file (f=f@entry=0xffff8880151c5d00, uargs=uargs@entry=0x564c103dd4a0 "", flags=flags@entry=0) at kernel/module/main.c:3168
#5  0xffffffff811adade in idempotent_init_module (f=f@entry=0xffff8880151c5d00, uargs=uargs@entry=0x564c103dd4a0 "", flags=flags@entry=0) at kernel/module/main.c:3185
#6  0xffffffff811adec9 in __do_sys_finit_module (flags=0, uargs=0x564c103dd4a0 "", fd=3) at kernel/module/main.c:3206
#7  __se_sys_finit_module (flags=<optimized out>, uargs=94884689990816, fd=3) at kernel/module/main.c:3189
#8  __x64_sys_finit_module (regs=<optimized out>) at kernel/module/main.c:3189
#9  0xffffffff81fccdff in do_syscall_x64 (nr=<optimized out>, regs=0xffffc900004c7f58) at arch/x86/entry/common.c:52
#10 do_syscall_64 (regs=0xffffc900004c7f58, nr=<optimized out>) at arch/x86/entry/common.c:83
#11 0xffffffff82000126 in entry_SYSCALL_64 () at arch/x86/entry/entry_64.S:120
#12 0x0000000000000000 in ?? ()

Now, when we look at frame #1:

ffffffff811a9800 <do_init_module>:
ffffffff811a9800:       e8 bb 36 ee ff          call   ffffffff8108cec0 <__fentry__>
ffffffff811a9805:       41 57                   push   %r15
ffffffff811a9807:       41 56                   push   %r14
ffffffff811a9809:       41 55                   push   %r13
ffffffff811a980b:       41 54                   push   %r12
ffffffff811a980d:       55                      push   %rbp
ffffffff811a980e:       53                      push   %rbx
ffffffff811a980f:       48 89 fb                mov    %rdi,%rbx
ffffffff811a9812:       48 c7 c7 c8 9f 6a 82    mov    $0xffffffff826a9fc8,%rdi
ffffffff811a9819:       48 83 ec 08             sub    $0x8,%rsp
ffffffff811a981d:       e8 5e 51 0d 00          call   ffffffff8127e980 <__tsan_read8>
ffffffff811a9822:       48 8b 3d 9f 07 50 01    mov    0x150079f(%rip),%rdi        # ffffffff826a9fc8 <kmalloc_caches+0x28>

..

ffffffff811a98ec:       e8 8f 50 0d 00          call   ffffffff8127e980 <__tsan_read8>
ffffffff811a98f1:       49 8b 07                mov    (%r15),%rax
ffffffff811a98f4:       e8 27 d1 e3 00          call   ffffffff81fe6a20 <__x86_indirect_thunk_array>
ffffffff811a98f9:       4c 89 ef                mov    %r13,%rdi

there's that call to the indirect array. Which is in the static kernel image:

ffffffff81fe6a20 <__x86_indirect_thunk_array>:
ffffffff81fe6a20:       e8 01 00 00 00          call   ffffffff81fe6a26 <__x86_indirect_thunk_array+0x6>
ffffffff81fe6a25:       cc                      int3
ffffffff81fe6a26:       48 89 04 24             mov    %rax,(%rsp)
ffffffff81fe6a2a:       e9 b1 07 00 00          jmp    ffffffff81fe71e0 <__x86_return_thunk>

where you'd think, ah, yes, that's why it fires.

BUT! The live kernel image in gdb looks like this:

Dump of assembler code for function __x86_indirect_thunk_array:
   0xffffffff81fe6a20 <+0>:     call   0xffffffff81fe6a26 <__x86_indirect_thunk_array+6>
   0xffffffff81fe6a25 <+5>:     int3 
   0xffffffff81fe6a26 <+6>:     mov    %rax,(%rsp)
   0xffffffff81fe6a2a <+10>:    jmp    0xffffffff81fe70a0 <srso_return_thunk>

so the right thunk is already there!

And yet, the warning still fired.

I need to singlestep this whole loading bit more carefully.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


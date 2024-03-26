Return-Path: <linux-kernel+bounces-119419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDF388C873
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 925BB1C64535
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895A313C8FA;
	Tue, 26 Mar 2024 16:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QKHEirAR"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4DD13C696
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 16:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711469071; cv=none; b=TM9u5oQuqmzFHexWZtKEiFd+4yAmsu3nhl8zZwkwHMqrGN23JJ9uP/7DIJdazaffQHgEvxU+fjGOmAlAwa/6G+MXM7fJjfAzJTqtAIJJ/KBCzri97UMh6TGH89O1itbp3okbBofkvPJRSNlpqLtsZK8EreHPO+0cQR2K3wmjPf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711469071; c=relaxed/simple;
	bh=/ToUdkB6pi5/HfPr6mO6odYLZvcuYC4IpT/jf40btlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F5rbSFXLNXFcyqTHQPuPLsyeNZ0zxzlJVil/MarIcHd+7lLPqOhm4t93NWQlAsnepttsjvyRZSdkl4FFDyCOJYY3dmTgblAxtMA7DvwemQ6/KiIH+Wf8tUsDylsJhxH1pZ98HHhU5IxcjtahcT7xReKQcXib2uhp2/36p4nj4XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QKHEirAR; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41488e17e1cso13610095e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 09:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1711469068; x=1712073868; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VHaAJ4RnYHJ8KX34kKTxzTaqVnfDqn1/9DcdAoyFrhw=;
        b=QKHEirARbNqRK5CiiDYafV+fyjXOVdIVyBb5y8xy8Pi3+KriK/zWoKddRk5qiFUIry
         BgAWmMFjbD40c2uAQAaveIj9ALzZ4d3EOhULZHJ3BlUR+MVx/K3wR4vlOYcksRkIuFGx
         6dOxdQIlY2aqiNdT/wYy7WLSoxPf7pzMg3uRUB6Mqiu/7ZUSu0WhZE83s0SweNuKZON9
         eoL9LizsKuapUq4Pc6BfnD2vPVCSxnsndx9JBBWjVqI2TkC+iNJMu5fMrG7KX3OhAhBy
         Cf23efKFIefZtfI7Cafa1KMEZe72ug6NDij0xgvWBXRa6tKn8h0LJS1xJggcLsBBWVW7
         bvzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711469068; x=1712073868;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VHaAJ4RnYHJ8KX34kKTxzTaqVnfDqn1/9DcdAoyFrhw=;
        b=KTRgt0WA2zHpGnwhv/Fl6akRkp6Iha/2QgXNth2DKPghPTb48GOSWah/U63Do/iC51
         y53FAxLBPp/IcgjLuVIXR3CZ7mITwTWLXBlNDBXXMkqt01sIeHkpHDzTOfZdW4OquQmg
         f5SOGdZg0Y6WiQbtxrAjS/LOYRmMbyQCcCHZ3YDB/eFKWZ2VgwJhygZuZrs7W71Jytiu
         tyGSXYTlKgE0mb/9FHgDU2IMfAP4QGJQhI1Q+7qiZxmqqECqBjiAF3aQaZt6vCqqNOIH
         xehZThGaBu4jWqKqlsZDSO6+3VwJGiY7JVz2/xhGEfR6b5Tlbp/oRDsrTqAUxFAuIqhQ
         6K0g==
X-Forwarded-Encrypted: i=1; AJvYcCWAwlYzlEDpdAj8QVltaVxM68URJ02+AOFI+YEhkh/UA2alQUxs0M4MOjiIz1/CC7tIEaJT8jg5I+HadecjgdnqRKPqHptS6cNFp5/0
X-Gm-Message-State: AOJu0YwHAQK3qqrKnnofX45qFiHsNuiKMCZLPYow/cevkuZ2PKDSwx7O
	ojqeVpzbToaesrbdd3xBxFgdneGPWhsgOpVJC6InyMp8Ddlmfp/Ag0shUhbOiO4=
X-Google-Smtp-Source: AGHT+IED4LzeEUW+uJwXuLG1bShpV+q+Bv27uQ764emOP5e+4rLzzdBa21tVGz4F0YHa0W241OnXEA==
X-Received: by 2002:a05:600c:3c9c:b0:414:22b5:c33a with SMTP id bg28-20020a05600c3c9c00b0041422b5c33amr2466458wmb.1.1711469067629;
        Tue, 26 Mar 2024 09:04:27 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:73fa:7285:c2ff:fedd:7e3a? ([2a10:bac0:b000:73fa:7285:c2ff:fedd:7e3a])
        by smtp.gmail.com with ESMTPSA id j19-20020a05600c191300b00414610d9223sm11999819wmq.14.2024.03.26.09.04.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 09:04:27 -0700 (PDT)
Message-ID: <80582244-8c1c-4eb4-8881-db68a1428817@suse.com>
Date: Tue, 26 Mar 2024 18:04:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Unpatched return thunk in use. This should not happen!
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Thomas Gleixner
 <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Marco Elver <elver@google.com>,
 kasan-dev@googlegroups.com
References: <0851a207-7143-417e-be31-8bf2b3afb57d@molgen.mpg.de>
 <47e032a0-c9a0-4639-867b-cb3d67076eaf@suse.com>
 <20240326155247.GJZgLvT_AZi3XPPpBM@fat_crate.local>
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20240326155247.GJZgLvT_AZi3XPPpBM@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 26.03.24 г. 17:52 ч., Borislav Petkov wrote:
> On Tue, Mar 26, 2024 at 04:08:32PM +0200, Nikolay Borisov wrote:
>> So the problem happens when KCSAN=y CONFIG_CONSTRUCTORS is also enabled and
>> this results in an indirect call in do_mod_ctors():
>>
>>     mod->ctors[i]();
>>
>>
>> When KCSAN is disabled, do_mod_ctors is empty, hence the warning is not
>> printed.
> 
> Yeah, KCSAN is doing something weird. I was able to stop the guest when
> the warning fires. Here's what I see:
> 
> The callstack when it fires:
> 
> #0  warn_thunk_thunk () at arch/x86/entry/entry.S:48
> #1  0xffffffff811a98f9 in do_mod_ctors (mod=0xffffffffa00052c0) at kernel/module/main.c:2462
> #2  do_init_module (mod=mod@entry=0xffffffffa00052c0) at kernel/module/main.c:2535
> #3  0xffffffff811ad2e1 in load_module (info=info@entry=0xffffc900004c7dd0, uargs=uargs@entry=0x564c103dd4a0 "", flags=flags@entry=0) at kernel/module/main.c:3001
> #4  0xffffffff811ad8ef in init_module_from_file (f=f@entry=0xffff8880151c5d00, uargs=uargs@entry=0x564c103dd4a0 "", flags=flags@entry=0) at kernel/module/main.c:3168
> #5  0xffffffff811adade in idempotent_init_module (f=f@entry=0xffff8880151c5d00, uargs=uargs@entry=0x564c103dd4a0 "", flags=flags@entry=0) at kernel/module/main.c:3185
> #6  0xffffffff811adec9 in __do_sys_finit_module (flags=0, uargs=0x564c103dd4a0 "", fd=3) at kernel/module/main.c:3206
> #7  __se_sys_finit_module (flags=<optimized out>, uargs=94884689990816, fd=3) at kernel/module/main.c:3189
> #8  __x64_sys_finit_module (regs=<optimized out>) at kernel/module/main.c:3189
> #9  0xffffffff81fccdff in do_syscall_x64 (nr=<optimized out>, regs=0xffffc900004c7f58) at arch/x86/entry/common.c:52
> #10 do_syscall_64 (regs=0xffffc900004c7f58, nr=<optimized out>) at arch/x86/entry/common.c:83
> #11 0xffffffff82000126 in entry_SYSCALL_64 () at arch/x86/entry/entry_64.S:120
> #12 0x0000000000000000 in ?? ()
> 
> Now, when we look at frame #1:
> 
> ffffffff811a9800 <do_init_module>:
> ffffffff811a9800:       e8 bb 36 ee ff          call   ffffffff8108cec0 <__fentry__>
> ffffffff811a9805:       41 57                   push   %r15
> ffffffff811a9807:       41 56                   push   %r14
> ffffffff811a9809:       41 55                   push   %r13
> ffffffff811a980b:       41 54                   push   %r12
> ffffffff811a980d:       55                      push   %rbp
> ffffffff811a980e:       53                      push   %rbx
> ffffffff811a980f:       48 89 fb                mov    %rdi,%rbx
> ffffffff811a9812:       48 c7 c7 c8 9f 6a 82    mov    $0xffffffff826a9fc8,%rdi
> ffffffff811a9819:       48 83 ec 08             sub    $0x8,%rsp
> ffffffff811a981d:       e8 5e 51 0d 00          call   ffffffff8127e980 <__tsan_read8>
> ffffffff811a9822:       48 8b 3d 9f 07 50 01    mov    0x150079f(%rip),%rdi        # ffffffff826a9fc8 <kmalloc_caches+0x28>
> 
> ...
> 
> ffffffff811a98ec:       e8 8f 50 0d 00          call   ffffffff8127e980 <__tsan_read8>
> ffffffff811a98f1:       49 8b 07                mov    (%r15),%rax
> ffffffff811a98f4:       e8 27 d1 e3 00          call   ffffffff81fe6a20 <__x86_indirect_thunk_array>
> ffffffff811a98f9:       4c 89 ef                mov    %r13,%rdi
> 
> there's that call to the indirect array. Which is in the static kernel image:
> 
> ffffffff81fe6a20 <__x86_indirect_thunk_array>:
> ffffffff81fe6a20:       e8 01 00 00 00          call   ffffffff81fe6a26 <__x86_indirect_thunk_array+0x6>
> ffffffff81fe6a25:       cc                      int3
> ffffffff81fe6a26:       48 89 04 24             mov    %rax,(%rsp)
> ffffffff81fe6a2a:       e9 b1 07 00 00          jmp    ffffffff81fe71e0 <__x86_return_thunk>
> 
> where you'd think, ah, yes, that's why it fires.
> 
> BUT! The live kernel image in gdb looks like this:
> 
> Dump of assembler code for function __x86_indirect_thunk_array:
>     0xffffffff81fe6a20 <+0>:     call   0xffffffff81fe6a26 <__x86_indirect_thunk_array+6>
>     0xffffffff81fe6a25 <+5>:     int3
>     0xffffffff81fe6a26 <+6>:     mov    %rax,(%rsp)
>     0xffffffff81fe6a2a <+10>:    jmp    0xffffffff81fe70a0 <srso_return_thunk>
> 
> so the right thunk is already there!
> 
> And yet, the warning still fired.

But you eventually call the address that was in %RAX from within 
srso_return_thunk, so it's likely that's where the warning is triggered. 
As far as I managed to see that address is supposed to be some compiler 
generated constructors that calls tsan_init. Dumping the .init_array 
contains:


      .type   _sub_I_00099_0, @function 

   25 _sub_I_00099_0: 

   24         endbr64 

   23         call    __tsan_init     # 

   22         jmp     __x86_return_thunk 

   21         .size   _sub_I_00099_0, .-_sub_I_00099_0 

   20         .section        .init_array.00099,"aw" 

   19         .align 8 

   18         .quad   _sub_I_00099_0 

   17         .ident  "GCC: (Ubuntu 12.3.0-1ubuntu1~22.04) 12.3.0" 

   16         .section        .note.GNU-stack,"",@progbits 

   15         .section        .note.gnu.property,"a" 

   14         .align 8 

   13         .long   1f - 0f 

   12         .long   4f - 1f 

   11         .long   5 

   10 0: 

    9         .string "GNU" 

    8 1: 

    7         .align 8 

    6         .long   0xc0000002 

    5         .long   3f - 2f 

    4 2: 

    3         .long   0x1 

    2 3: 

    1         .align 8 

    0 4:


So this       _sub_I_00099_0 is the compiler generated ctors that is 
likely not patched. What's strange is that when adding debugging code I 
see that 2 ctors are being executed and only the 2nd one fires:

[    7.635418] in do_mod_ctors
[    7.635425] calling 0 ctor 00000000aa7a443a
[    7.635430] called 0 ctor
[    7.635433] calling 1 ctor 00000000fe9d0d54
[    7.635437] ------------[ cut here ]------------
[    7.635441] Unpatched return thunk in use. This should not happen!


> 
> I need to singlestep this whole loading bit more carefully.
> 
> Thx.
> 


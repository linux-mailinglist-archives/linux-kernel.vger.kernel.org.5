Return-Path: <linux-kernel+bounces-119816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C66AB88CD4C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01BC4B2451E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C54413D249;
	Tue, 26 Mar 2024 19:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ImziY/Od"
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC27413D246
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 19:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711481651; cv=none; b=bET6mmvTAr3D/63vMyIBPaMRUpZ54ChekTuLICj9PpmpqzP+dVprx7XaZOazu/GeUotQQtmunfdxzHNvccqjVKb8chjwhrih0F5mq+K5J6HMfTGfWWQyokm9pFb4G8nDWqFOj/bB9HWgbtWzjnaa6KJXrSQxZqYutP3T4Aj1IBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711481651; c=relaxed/simple;
	bh=GsEfyjlUIOsWChcZqvf9jiniIaj+B4woBPAO/WPWeps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qR4PdTW3d4LsQWKf5JTekhickjNgBSX/2zPpq1c9pP3QEPSVsN2ow//sltY3PJKvF/cQYYGql1bfLTydeRO9Po+zSAsAoLrYqRsm10xjOgHBULjGbU9d4zC7NfMM9kxSqh62/PF1Yz//6MA8H2mzuCHMQoayyBE1sog7aurDeJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ImziY/Od; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-476d0f0bba4so668993137.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 12:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711481648; x=1712086448; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B6sTqJ0aPnz4xq/ZZGbsUBdM/hjOugrKakCuozLiqI4=;
        b=ImziY/Odl5b1J8Fwr0CHaxHTZJgW/q6Dv88JWQZXWLRLYKyLm7zpNR8jmjWEwWxr8v
         tXu14jgotGfZbiIaDupleR93Ak0iZUYqWsYlg8knm5wBfbj0PFgxM3rlUKDisB/9dkwX
         SrbO3+OYUscGVC3ukX2cWmmx1qvI9456yYUzmqeDYX4nGTsG96btm4HwH0rfpkpEHCGW
         FpDGxS622t6yXIssAe4DZcuRnRQUHv+DeMqb4/bC+e+iuHbHALqwao/zNGMjIhCIk7MK
         r6iMjDwnFQPfk8UvB0O+tx0aU//xOZOVOIQb97kvXvVAVsLPpolLWBBkyER59NKCqpZH
         J1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711481648; x=1712086448;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B6sTqJ0aPnz4xq/ZZGbsUBdM/hjOugrKakCuozLiqI4=;
        b=AmowTC14fEqX87MWvfta4bNa5EZwA4dFKObqKfziTUdLx3jHhPYnBbJGu7gQUivAK6
         Z0nRAs75T9dNToC7VN0IZ8mq/kQxjCn17VZLVkrVK344omL2RVAXRzUGMSG/ypyT7i52
         tFfJRX+z/Cr9MRzUqQrZDRc6pG2uW4fqFldhht/amPen/UliTQPM4XX6nO9jG7WOPXxX
         ZE/NMh3KUO7p4hHl8aLaWdKydWQOoGXuG23CfX3isj0ZIMpXttPgJ3SZTASMByosA3Wc
         80UAsAqpNeOT7Kj1s8OUrDAg9m/HzjnsBGe3j37uC0ljJhAv+tPI93qH8BWbBoJlVOKH
         vB2w==
X-Forwarded-Encrypted: i=1; AJvYcCX9OfHj53Smcwj3Xtl7GNfJmpBOoaxNZZtMNYE81mMxxtzRVg+cU/xNLWsFA8huT4RjGu4uWjPe6JX3/Rv5HFsWX6YxX8AzKxaoeYN2
X-Gm-Message-State: AOJu0YyiqqJvPKuD8tqrVd5uG/GABgk83IAStb/QzIwCEdpJwSao7tuJ
	pP3YpQCz/iPLxzLnjojR1037AJw6VYUl5Y9m8a9Ofy9x3L0z91cnqfqTxJUZ3d0jny8xwGjEvF0
	Fe67Ol5/Cdqe/LiYdC643DbB2bOsCKsN8coXcRudH4YuvE8BVoA==
X-Google-Smtp-Source: AGHT+IE+slGZTbzdJa0pOx36MteAJ+21c3Rra2OYd4lvu0zA09PGaPCjAvF88xdcev7eD0SBuEKd+nv8R7bfeEhNtKc=
X-Received: by 2002:a05:6102:24b8:b0:476:9ac0:e8c4 with SMTP id
 s24-20020a05610224b800b004769ac0e8c4mr10157730vse.34.1711481648508; Tue, 26
 Mar 2024 12:34:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0851a207-7143-417e-be31-8bf2b3afb57d@molgen.mpg.de>
 <47e032a0-c9a0-4639-867b-cb3d67076eaf@suse.com> <20240326155247.GJZgLvT_AZi3XPPpBM@fat_crate.local>
 <80582244-8c1c-4eb4-8881-db68a1428817@suse.com> <20240326191211.GKZgMeC21uxi7H16o_@fat_crate.local>
In-Reply-To: <20240326191211.GKZgMeC21uxi7H16o_@fat_crate.local>
From: Marco Elver <elver@google.com>
Date: Tue, 26 Mar 2024 20:33:31 +0100
Message-ID: <CANpmjNOcKzEvLHoGGeL-boWDHJobwfwyVxUqMq2kWeka3N4tXA@mail.gmail.com>
Subject: Re: Unpatched return thunk in use. This should not happen!
To: Borislav Petkov <bp@alien8.de>
Cc: Nikolay Borisov <nik.borisov@suse.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Paul Menzel <pmenzel@molgen.mpg.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, kasan-dev@googlegroups.com, 
	David Kaplan <David.Kaplan@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Mar 2024 at 20:12, Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Mar 26, 2024 at 06:04:26PM +0200, Nikolay Borisov wrote:
> > So this       _sub_I_00099_0 is the compiler generated ctors that is likely
> > not patched. What's strange is that when adding debugging code I see that 2
> > ctors are being executed and only the 2nd one fires:
> >
> > [    7.635418] in do_mod_ctors
> > [    7.635425] calling 0 ctor 00000000aa7a443a
> > [    7.635430] called 0 ctor
> > [    7.635433] calling 1 ctor 00000000fe9d0d54
> > [    7.635437] ------------[ cut here ]------------
> > [    7.635441] Unpatched return thunk in use. This should not happen!
>
> ... and this is just the beginning of the rabbit hole. David and I went
> all the way down.
>
> Turns out that objtool runs on the .o files and creates the
> .return_sites just fine but then the module building dance creates an
> intermediary *.mod.c file and when that thing is built, KCSAN would
> cause the addition of *another* constructor to .text.startup in the
> module.
>
> The .o file has one:
>
> -------------------
> Disassembly of section .text.startup:
>
> ...
>
> 0000000000000010 <_sub_I_00099_0>:
>   10:   f3 0f 1e fa             endbr64
>   14:   e8 00 00 00 00          call   19 <_sub_I_00099_0+0x9>
>                         15: R_X86_64_PLT32      __tsan_init-0x4
>   19:   e9 00 00 00 00          jmp    1e <__UNIQUE_ID___addressable_cryptd_alloc_aead349+0x6>
>                         1a: R_X86_64_PLT32      __x86_return_thunk-0x4
> -------------------
>
>
> while the .ko file has two:
>
> -------------------
> Disassembly of section .text.startup:
>
> 0000000000000010 <_sub_I_00099_0>:
>   10:   f3 0f 1e fa             endbr64
>   14:   e8 00 00 00 00          call   19 <_sub_I_00099_0+0x9>
>                         15: R_X86_64_PLT32      __tsan_init-0x4
>   19:   e9 00 00 00 00          jmp    1e <_sub_I_00099_0+0xe>
>                         1a: R_X86_64_PLT32      __x86_return_thunk-0x4
>
> ...
>
> 0000000000000030 <_sub_I_00099_0>:
>   30:   f3 0f 1e fa             endbr64
>   34:   e8 00 00 00 00          call   39 <_sub_I_00099_0+0x9>
>                         35: R_X86_64_PLT32      __tsan_init-0x4
>   39:   e9 00 00 00 00          jmp    3e <__ksymtab_cryptd_alloc_ahash+0x2>
>                         3a: R_X86_64_PLT32      __x86_return_thunk-0x4
> -------------------
>
> Once we've figured that out, finding a fix is easy:

Thanks for figuring this one out!

> diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> index 8568d256d6fb..79fcf2731686 100644
> --- a/scripts/Makefile.modfinal
> +++ b/scripts/Makefile.modfinal
> @@ -23,7 +23,7 @@ modname = $(notdir $(@:.mod.o=))
>  part-of-module = y
>
>  quiet_cmd_cc_o_c = CC [M]  $@
> -      cmd_cc_o_c = $(CC) $(filter-out $(CC_FLAGS_CFI) $(CFLAGS_GCOV), $(c_flags)) -c -o $@ $<
> +      cmd_cc_o_c = $(CC) $(filter-out $(CC_FLAGS_CFI) $(CFLAGS_GCOV) $(CFLAGS_KCSAN), $(c_flags)) -c -o $@ $<

This looks reasonable.

>  %.mod.o: %.mod.c FORCE
>         $(call if_changed_dep,cc_o_c)
>
> However, I'm not sure.
>
> I wanna say that since those are constructors then we don't care about
> dynamic races there so we could exclude them from KCSAN.

Yeah, we can just exclude all the code from the auto-generated mod.c
files from KCSAN instrumentation. It looks like they just contain
global metadata for the module, and no other code. The auto-generated
constructors don't contain much interesting code (unlikely they'd
contain data races we'd ever care about).

> If not, I could disable the warning on KCSAN. I'm thinking no one would
> run KCSAN in production...
>
> A third option would be to make objtool run on .ko files. Yeah, that
> would be fun for Josh. :-P
>
> I'd look into the direction of melver for suggestions here.

I think just removing instrumentation from the mod.c files is very reasonable.

Thanks,
-- Marco


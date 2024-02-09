Return-Path: <linux-kernel+bounces-59793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2579584FBCE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 575BE1C21017
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D887F48A;
	Fri,  9 Feb 2024 18:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PPzgQnMg"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9B969E16
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 18:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707502841; cv=none; b=Ypi+CxeSKyyfX14LLFrrvRblfMLsXZaQPI5zhoCoeSpyiPWhvCpOv2CV8xq5hjdoekFc6rIa+yXmlwjTAkH5qFWBBxWblEWgrPSjID1CSZdn0+z4qBDb29VlR1HepDUEfuTQeCPs9vRW1DpYh/Ec8eK0HGh3PH1wHNiZ2veSWtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707502841; c=relaxed/simple;
	bh=flaRgTjJ3ECoc4R2pegG/D+sFiX6IzLBk6IwXeTkD6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rXD+wQwB+Snb2KrR5srkMapEoW/clPIg3WtCWGCU/va4hg1HWVZ3FzEBRS14qcCzdC9hySw2lLd1eiVPnBSGoYJFi7EQ+Zkl29WdT8AftKJN0cDxeA0u9dGKcmJm+IOlfgIoY6jYqGuRhmiuKHvaDtWlwRpfJ2SqWM0r0uS1EF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PPzgQnMg; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5c66b093b86so1659587a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 10:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707502839; x=1708107639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TxepppgEC3P8V7/7bMlcPF10Hibly4nFjR2zsEK0CGc=;
        b=PPzgQnMgq2289eBLNgAz5T15vAq2Tdr5y3KmK4JsfiHcLoPJ0T+WJWkOVawzhywL0m
         Q+Psq6CwiNpHOJxMZflxjHAS44U8JbmbKuIPY7E6IUHYxtZKUV4EPIi7jk6AMoBtQOE7
         t084EZsu2ioIxY+AL5y8TIhUlCLiGJRG+K6oOw9TU5n8CmG9B5iunoAAw0BhBUFYrX/v
         jNfPcHJDKghax0fkznVG7MXTtrdckVgCeIyJG0012sCiRUwlA10eI+TH0uhZj/YXXiz5
         JbNXykgyeE7Mg/2fQfWvEHFoEXodXHlJ3g3Gs+d37ElumRpnBOiPOBrNQ6ERMmyD1CCF
         D//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707502839; x=1708107639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TxepppgEC3P8V7/7bMlcPF10Hibly4nFjR2zsEK0CGc=;
        b=rZ+e2GFQiCD2QE8VbsWkTKSKkQ+GncGKMyOf4zG7+GRLaKAq1yoU0o8mOe6sSRL+Eo
         R9l2FDaovEOJEochpTnyDTulxxZ39RTX0OZ8JG+3mcczlciPNWRn7XWzQIvjIxGP9HlW
         i5ONPTcSIz3B3ZSLELXwC1a3+zrjMCivFHxF+aqU5OOmIle6SXZIdGkyEjLf7hZqTCHV
         DLG+rgzi5jOxvu8rYwXsBWGXe+SajaquMW91V0mom7XZLflQeipX1Xpa3akT4dW3iwBE
         7GcVNsEV7T8AuHAdSrPtNCRCZMf1HSB/lywk3INsq1jlzy08x4O+4ax3NBlxXAfKKDMX
         vnpQ==
X-Gm-Message-State: AOJu0Yx0GPzzvkU4GhjmfBzRQVhRTb9NagSRlPSsY/EHodQTs2rgtKZA
	oYWNP5Jy/m/09tUevsm1iUfeCf2lv7JxoJedQWbyqtdWsi9A3kPPobbNGH/9e/nvtNwYADdl6Au
	Q86Z8aaX5wnGnUnpXCmkFE6zSaIS7vzdzqJ3i
X-Google-Smtp-Source: AGHT+IH5k138KN/lx8w8wnOdChIayRIbRLw+Ip2KZOZtXQGr/VQOaVqNA0HM7sX4J0PaEEh/aV3GmupmNIxdr0qE5ZA=
X-Received: by 2002:a17:90a:f0c3:b0:296:1667:e879 with SMTP id
 fa3-20020a17090af0c300b002961667e879mr2282435pjb.23.1707502838891; Fri, 09
 Feb 2024 10:20:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206223620.1833276-1-acdunlap@google.com> <168b4e3b-8076-4fc3-92bc-fcd9f2b516a8@intel.com>
 <CAMj1kXE4Yhh_5y=ybFkD7YQUZuh7+-P_Vyzv-gpvbQ=i=eRMnw@mail.gmail.com>
In-Reply-To: <CAMj1kXE4Yhh_5y=ybFkD7YQUZuh7+-P_Vyzv-gpvbQ=i=eRMnw@mail.gmail.com>
From: Adam Dunlap <acdunlap@google.com>
Date: Fri, 9 Feb 2024 10:20:22 -0800
Message-ID: <CAMBK9=bTMJircCK9SYHsZcKvbD0oZUByQPXcYciD6mcVqgg6=g@mail.gmail.com>
Subject: Re: [PATCH v3] x86/asm: Force native_apic_mem_read to use mov
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	Arjan van de Ven <arjan@linux.intel.com>, Wei Liu <wei.liu@kernel.org>, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, Jacob Xu <jacobhxu@google.com>, Alper Gun <alpergun@google.com>, 
	Kevin Loughlin <kevinloughlin@google.com>, Peter Gonda <pgonda@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 7:22=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wro=
te:
>
> On Thu, 8 Feb 2024 at 16:48, Dave Hansen <dave.hansen@intel.com> wrote:
> >
> > On 2/6/24 14:36, Adam Dunlap wrote:
> > ...
> > > In particular, when compiled with clang and run as a SEV-ES or
> > > SEV-SNP guest, the compiler would emit a testl instruction which is
> > > not supported by the SEV-ES emulator
> >
> > What changed?  Why is this a bug that we're only noticing now?  The lin=
e
> > of code that's modified here is from 2008.
> >
> > I assume that it's something new in clang, but it'd be great to know
> > that for sure.
> >
>
> Might be the use of LTO in the Google prod[uction]kernel. Adam, can you c=
onfirm?

It doesn't look like it's LTO. I disabled the LTO options in .config
and you can see the
problem just in a single object file:

With gcc:

% gdb -batch -ex 'file arch/x86/kernel/apic/ipi.o' -ex 'disassemble
apic_mem_wait_icr_idle'
Dump of assembler code for function apic_mem_wait_icr_idle:
   0x0000000000000260 <+0>:     endbr64
   0x0000000000000264 <+4>:     jmp    0x268 <apic_mem_wait_icr_idle+8>
   0x0000000000000266 <+6>:     pause
   0x0000000000000268 <+8>:     mov    0xffffffffff5fc300,%eax
   0x000000000000026f <+15>:    test   $0x10,%ah
   0x0000000000000272 <+18>:    jne    0x266 <apic_mem_wait_icr_idle+6>
   0x0000000000000274 <+20>:    jmpq   0x279

With clang:

% gdb -batch -ex 'file arch/x86/kernel/apic/ipi.o' -ex 'disassemble
apic_mem_wait_icr_idle'
Dump of assembler code for function apic_mem_wait_icr_idle:
   0x0000000000000250 <+0>:     endbr64
   0x0000000000000254 <+4>:     testl  $0x1000,0xffffffffff5fc300
   0x000000000000025f <+15>:    je     0x270 <apic_mem_wait_icr_idle+32>
   0x0000000000000261 <+17>:    pause
   0x0000000000000263 <+19>:    testl  $0x1000,0xffffffffff5fc300
   0x000000000000026e <+30>:    jne    0x261 <apic_mem_wait_icr_idle+17>
   0x0000000000000270 <+32>:    cs jmpq 0x276

This shows how gcc uses mov to load the apic memory and then testl to
test it, while clang
combines those instructions.

I plugged in the relevant subsection into godbolt [0] and it appears
the assembly changed in
clang 8 (released 2019). I'm not set up to do full compilations with
old clang versions, but
this is the most likely change point.

> this seems like the kind of thing we'll want in -stable in case folks
> are compiling stable kernels with new clangs.

That makes sense. Note that there was another patch accepted recently
that fixed another
clang-with-SEV problem [1], so they should probably be backported to
the same stable
branches since neither is that useful without the other.

[0] https://godbolt.org/z/nq9M9e8ex
[1] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=
=3D1c811d403afd73f04bde82b83b24c754011bd0e8


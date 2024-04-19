Return-Path: <linux-kernel+bounces-151007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 077F78AA7E2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B1DF1F22548
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 05:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDF7B676;
	Fri, 19 Apr 2024 05:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="BuDsMaCr"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E547494
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 05:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713503592; cv=none; b=mJWw+8ISk6+/F7M4jFiifklCZfNnjHNAtYfra34BlnAZIvUttClcFiehputiq5MjLXxwspazD6TvOFDVuwnl0iMddeT+nQHb/gWS39BSHFITJhy0a2KrC+OYQWDwWxniCaDaw4bcdwunc+AhjzRltvv3PD1BdPYxpkZDCFJerOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713503592; c=relaxed/simple;
	bh=0uUaHshrb8NAIBnznpZKZX0Au6m6hxj9X/9tabmQHAc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mfFHcWKjRydxDbqDZpnDi5QjqO8gd5cm8zyfcN6n14klCaHwlmKkUQUnNt0a62CCJji6rS5d/D5dq6Bv6CLQ6W+UJ1HFz72LLRd31oFgMvtRQfdfmLPiGGIqFtTde1f6a1hN8tC11IattOdsZWWtBiA1JpSHILU+E6Lqj5ReQ7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=BuDsMaCr; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1713503582;
	bh=kKJbHRkyLHBaxd0WzWWbPlJiRCeUkrJqnmVheMKFAs8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=BuDsMaCrIPoMUPy5N7wfOxpl9Q7/pGYp4Sl8j2DC2jVZ5CcGvulsbeS4mEdlPHaQj
	 JxFVWgcvjAnVgg/68Ew8uK3o4C9UJgpkdWIF12waMjhr7fFcfoHNBZJuaadQLDjZCW
	 xBPIQ30XChhLhDOsIQkiYGsU+f6iPH6bQ2ckBJbzRI+rGjD1NU5yOrCOTZdup7ba6/
	 gYeoT4OUck4v4i3UKzsilII1+q+bOUbW43KKDWw86IHGM+jxbHTcghrrGHvrQmxsY6
	 rYA0ZN5w5jAbdMJVRTkTZjovEXhlxtmSNfxIS8gqhuPxs9xNBkMCo5gR1UbcWYgCg/
	 uI8piTbVvl/Qg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VLN7x53gbz4wnr;
	Fri, 19 Apr 2024 15:13:01 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, "Aneesh Kumar K . V"
 <aneesh.kumar@kernel.org>, Anders Roxell <anders.roxell@linaro.org>, Kees
 Cook <keescook@chromium.org>, Niklas Schnelle <schnelle@linux.ibm.com>,
 clang-built-linux <llvm@lists.linux.dev>, Nick Desaulniers
 <ndesaulniers@google.com>, Nathan Chancellor <nathan@kernel.org>, Jeff Xu
 <jeffxu@chromium.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Dan
 Carpenter <dan.carpenter@linaro.org>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Baoquan He
 <bhe@redhat.com>, Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH] powerpc: drop port I/O helpers for CONFIG_HAS_IOPORT=n
In-Reply-To: <8734ribza2.fsf@mail.lhotse>
References: <20240416153331.1617772-1-arnd@kernel.org>
 <878r1bb2zj.fsf@mail.lhotse>
 <59473eb6-1707-4bbf-85a3-ba4835f3ee7f@app.fastmail.com>
 <8734ribza2.fsf@mail.lhotse>
Date: Fri, 19 Apr 2024 15:12:58 +1000
Message-ID: <87wmou9bqd.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Michael Ellerman <mpe@ellerman.id.au> writes:
> "Arnd Bergmann" <arnd@arndb.de> writes:
>> On Thu, Apr 18, 2024, at 08:26, Michael Ellerman wrote:
>>> Arnd Bergmann <arnd@kernel.org> writes:
>>
>>> @@ -692,6 +692,7 @@ static inline void name at                          
>>>         \
>>>  #define writesw writesw
>>>  #define writesl writesl
>>>
>>> +#ifdef CONFIG_HAS_IOPORT
>>>  #define inb inb
>>>  #define inw inw
>>>  #define inl inl
>>> @@ -704,6 +705,8 @@ static inline void name at                          
>>>         \
>>>  #define outsb outsb
>>>  #define outsw outsw
>>>  #define outsl outsl
>>> +#endif // CONFIG_HAS_IOPORT
>>> +
>>>  #ifdef __powerpc64__
>>>  #define readq  readq
>>>  #define writeq writeq
>>
>> I had included this at first, but then I still ran into
>> the same warnings because it ends up pulling in the
>> generic outsb() etc from include/asm-generic/io.h
>> that relies on setting a non-NULL PCI_IOBASE.
>
> Yes you're right. The above fixes the gcc build, but not clang.
>
> So I think I'll just cherry pick f0a816fb12da ("/dev/port: don't compile
> file operations without CONFIG_DEVPORT") into my next and then apply
> this. But will see if there's any other build failures over night.

That didn't work. Still lots of drivers in my tree (based on rc2) which
use inb/outb etc, and barf on the empty #define inb.

So I think this patch needs to wait until all the CONFIG_HAS_IOPORT
checks have been merged for various drivers.

For now the below fixes the clang warning. AFAICS it's safe because any
code using inb() etc. with CONFIG_PCI=n is currently just doing a plain
load from virtual address ~zero which should fault anyway.

cheers


diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index 08c550ed49be..1cd6eb6c8101 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -37,7 +37,7 @@ extern struct pci_dev *isa_bridge_pcidev;
  * define properly based on the platform
  */
 #ifndef CONFIG_PCI
-#define _IO_BASE       0
+#define _IO_BASE       POISON_POINTER_DELTA
 #define _ISA_MEM_BASE  0
 #define PCI_DRAM_OFFSET 0
 #elif defined(CONFIG_PPC32)


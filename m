Return-Path: <linux-kernel+bounces-111589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4025B886E3B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71C351C21CAE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3E347A40;
	Fri, 22 Mar 2024 14:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="gKTvbo0I"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B6E46546
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 14:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711116822; cv=none; b=qAn6L2CgdMIOQIwL8CpNC2kvonNVvhRq4ANGq36ZC86yGoO+4jHLiOLc1eUSZRvcRTDp7ejbUbifXA+vABjVfGbooPf0NmTAvgPvywcVPAvZeTKkwVLEY2bJeTHDghs3bGhVkVlB7CgMXUiuK9YFwtsgP6C2bZiBC0Zm3rn5188=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711116822; c=relaxed/simple;
	bh=uabN1U09dpaxwPgK5zBOg/0q/WFlWJn6j0Uu62VmsG0=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=Jeh6+OHNPGYnQb/BXjKJwb1lenJ/zp2nnXrhLusQifv8YQA0bMHi6Qj2r+j3P/8nv6unpO0EQak45LZrr6VKsw6YqrQCBLHKb9j/Jve7GxG72F7pfSDZss923TB/j46y4AImC+t8mAjUPftuC7MLOqhYkp0QtyEaOk9Yxpio+/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=gKTvbo0I; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-221ffba5c8bso1303421fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 07:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1711116819; x=1711721619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yMwbsV2lr5D+n8eq4lwX8uN+1JbL7Okl9fmvTySMdOM=;
        b=gKTvbo0IA+i7JFCQLZvD+KJF0i8JF3DVuaCwE8ZRucJZHBbjrCGOy54L1OqjzCZLm9
         AADl/UPodDrfgKeGJdAqmLBlM5MuUJt6Noxa31zXMIpNphBMd4h1vPAHjVqVFGtb7Bvs
         08LHgWkGvw9ajQFkdrdSWlGVm628iF82zbqrLjcZ51ImJS0l5TtiGFczKyXz9j0CUs/1
         q3sQjh1GrKFa/rVWzYQxacrcg1GFKGOlAEFo8ocV2wjp34Widk7uN2ltQnxc8JRNOmQC
         HirmLqMECEvrheftAUByk5256asN6dNCsaUVl76Hai+FlHyhu9bFuT03WHy4dvuQAjek
         01qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711116819; x=1711721619;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMwbsV2lr5D+n8eq4lwX8uN+1JbL7Okl9fmvTySMdOM=;
        b=hWT/eIKd/c8ZpLumAHkoWR26it+v7Zgoys2HG+KpOr2cT6SHITxERpslNnhSP1cJBP
         FDonPZ5U9vS34WCI8IDj+a6ykH2uk8O6RPuEL47MOf0l48lw1jFAmlaCx89X4tHaUt8/
         /XQzX6Eog4qWkLwPV2jCGiffXGSmSieXnuF+FnapNvrSi9hMVtIe+cW7HvBFhkdDkWSi
         yPxz+fd7Ji9pN1Vn/y6a947TO1jbAD4X7JkUBe+OF7nUaiktFUzCqqffcrNoj0W56TVg
         uNogrfn/s/XDrtXANfqPFfbVkUmhc8e0WJgRkhKRzS40lwDeieLlUPn4RvhQ00U5EMqX
         dI8A==
X-Forwarded-Encrypted: i=1; AJvYcCUCde/9XQUmj1EoS0yyn3oJ58iNJa3u3aIz+NN9hy2oikZ29P4b2ddxb4kPTt/Vu1GMRJz+PtMzmUGZZtplceAYPWZAOPLbbz1jLA6v
X-Gm-Message-State: AOJu0YwJq4PtWwQFwIIktzOKc2l+4oisxcxr/ABUePCD6qtTSphVscoz
	oxt4EaBOx2vEz79LXvNREmLYge0xzCKDGZyN3tkPWB/aN0m5Df9K5rriB3hKoJbmeF/abLQ0XWg
	/
X-Google-Smtp-Source: AGHT+IF67p/WhASEEUOaMLQ7DminN+c4zr/4NoTc7CLi/rZc+sVKHX93JtQeh2Zc4uFIFtVUaKoXtg==
X-Received: by 2002:a05:6a21:920a:b0:1a3:7b9a:4dd6 with SMTP id tl10-20020a056a21920a00b001a37b9a4dd6mr2763771pzb.54.1711116379234;
        Fri, 22 Mar 2024 07:06:19 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id x8-20020a056a000bc800b006ea918dab9csm94982pfu.157.2024.03.22.07.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 07:06:18 -0700 (PDT)
Date: Fri, 22 Mar 2024 07:06:18 -0700 (PDT)
X-Google-Original-Date: Fri, 22 Mar 2024 07:06:16 PDT (-0700)
Subject:     Re: [PATCH v3 1/3] riscv: mm: Use hint address in mmap if available
In-Reply-To: <ZbxTNjQPFKBatMq+@ghost>
CC: cyy@cyyself.name, alexghiti@rivosinc.com,
  Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, shuah@kernel.org, corbet@lwn.net, linux-mm@kvack.org,
  linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
  linux-doc@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Message-ID: <mhng-5d9bb6c0-9f40-44b2-b9dc-3823cf6dbdef@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Thu, 01 Feb 2024 18:28:06 PST (-0800), Charlie Jenkins wrote:
> On Wed, Jan 31, 2024 at 11:59:43PM +0800, Yangyu Chen wrote:
>> On Wed, 2024-01-31 at 22:41 +0800, Yangyu Chen wrote:
>> > On Tue, 2024-01-30 at 17:07 -0800, Charlie Jenkins wrote:
>> > > On riscv it is guaranteed that the address returned by mmap is less
>> > > than
>> > > the hint address. Allow mmap to return an address all the way up to
>> > > addr, if provided, rather than just up to the lower address space.
>> > > 
>> > > This provides a performance benefit as well, allowing mmap to exit
>> > > after
>> > > checking that the address is in range rather than searching for a
>> > > valid
>> > > address.
>> > > 
>> > > It is possible to provide an address that uses at most the same
>> > > number
>> > > of bits, however it is significantly more computationally expensive
>> > > to
>> > > provide that number rather than setting the max to be the hint
>> > > address.
>> > > There is the instruction clz/clzw in Zbb that returns the highest
>> > > set
>> > > bit
>> > > which could be used to performantly implement this, but it would
>> > > still
>> > > be slower than the current implementation. At worst case, half of
>> > > the
>> > > address would not be able to be allocated when a hint address is
>> > > provided.
>> > > 
>> > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
>> > > ---
>> > >  arch/riscv/include/asm/processor.h | 27 +++++++++++---------------
>> > > -
>> > >  1 file changed, 11 insertions(+), 16 deletions(-)
>> > > 
>> > > diff --git a/arch/riscv/include/asm/processor.h
>> > > b/arch/riscv/include/asm/processor.h
>> > > index f19f861cda54..8ece7a8f0e18 100644
>> > > --- a/arch/riscv/include/asm/processor.h
>> > > +++ b/arch/riscv/include/asm/processor.h
>> > > @@ -14,22 +14,16 @@
>> > >  
>> > >  #include <asm/ptrace.h>
>> > >  
>> > > -#ifdef CONFIG_64BIT
>> > > -#define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
>> > > -#define STACK_TOP_MAX		TASK_SIZE_64
>> > > -
>> > >  #define arch_get_mmap_end(addr, len, flags)			\
>> > >  ({								\
>> > >  	unsigned long
>> > > mmap_end;					\
>> > >  	typeof(addr) _addr = (addr);				\
>> > > -	if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) &&
>> > > is_compat_task())) \
>> > > +	if ((_addr) == 0 ||					\
>> > > +	    (IS_ENABLED(CONFIG_COMPAT) && is_compat_task()) ||	\
>> > > +	    ((_addr + len) > BIT(VA_BITS -
>> > > 1)))			\
>> > >  		mmap_end = STACK_TOP_MAX;			\
>> > > -	else if ((_addr) >= VA_USER_SV57)			\
>> > > -		mmap_end = STACK_TOP_MAX;			\
>> > > -	else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >=
>> > > VA_BITS_SV48)) \
>> > > -		mmap_end = VA_USER_SV48;			\
>> > >  	else							\
>> > > -		mmap_end = VA_USER_SV39;			\
>> > > +		mmap_end = (_addr + len);			\
>> > >  	mmap_end;						\
>> > >  })
>> > >  
>> > > @@ -39,17 +33,18 @@
>> > >  	typeof(addr) _addr = (addr);				\
>> > >  	typeof(base) _base = (base);				\
>> > >  	unsigned long rnd_gap = DEFAULT_MAP_WINDOW - (_base);	\
>> > > -	if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) &&
>> > > is_compat_task())) \
>> > > +	if ((_addr) == 0 ||					\
>> > > +	    (IS_ENABLED(CONFIG_COMPAT) && is_compat_task()) ||	\
>> > > +	    ((_addr + len) > BIT(VA_BITS -
>> > > 1)))			\
>> > >  		mmap_base = (_base);				\
>> > > -	else if (((_addr) >= VA_USER_SV57) && (VA_BITS >=
>> > > VA_BITS_SV57)) \
>> > > -		mmap_base = VA_USER_SV57 - rnd_gap;		\
>> > > -	else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >=
>> > > VA_BITS_SV48)) \
>> > > -		mmap_base = VA_USER_SV48 - rnd_gap;		\
>> > >  	else							\
>> > > -		mmap_base = VA_USER_SV39 - rnd_gap;		\
>> > > +		mmap_base = (_addr + len) - rnd_gap;		\
>> > >  	mmap_base;						\
>> > >  })
>> > >  
>> > > +#ifdef CONFIG_64BIT
>> > > +#define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
>> > > +#define STACK_TOP_MAX		TASK_SIZE_64
>> > >  #else
>> > >  #define DEFAULT_MAP_WINDOW	TASK_SIZE
>> > >  #define STACK_TOP_MAX		TASK_SIZE
>> > > 
>> > 
>> > I have carefully tested your patch on qemu with sv57. A bug that
>> > needs
>> > to be solved is that mmap with the same hint address without
>> > MAP_FIXED
>> > set will fail the second time.
>> > 
>> > Userspace code to reproduce the bug:
>> > 
>> > #include <sys/mman.h>
>> > #include <stdio.h>
>> > #include <stdint.h>
>> > 
>> > void test(char *addr) {
>> >     char *res = mmap(addr, 4096, PROT_READ | PROT_WRITE,
>> > MAP_ANONYMOUS
>> > > MAP_PRIVATE, -1, 0);
>> >     printf("hint %p got %p.\n", addr, res);
>> > }
>> > 
>> > int main (void) {
>> >     test(1<<30);
>> >     test(1<<30);
>> >     test(1<<30);
>> >     return 0;
>> > }
>> > 
>> > output:
>> > 
>> > hint 0x40000000 got 0x40000000.
>> > hint 0x40000000 got 0xffffffffffffffff.
>> > hint 0x40000000 got 0xffffffffffffffff.
>> > 
>> > output on x86:
>> > 
>> > hint 0x40000000 got 0x40000000.
>> > hint 0x40000000 got 0x7f9171363000.
>> > hint 0x40000000 got 0x7f9171362000.
>> > 
>> > It may need to implement a special arch_get_unmapped_area and
>> > arch_get_unmapped_area_topdown function.
>> > 
>> 
>> This is because hint address < rnd_gap. I have tried to let mmap_base =
>> min((_addr + len), (base) + TASK_SIZE - DEFAULT_MAP_WINDOW). However it
>> does not work for bottom-up while ulimit -s is unlimited. You said this
>> behavior is expected from patch v2 review. However it brings a new
>> regression even on sv39 systems.
>> 
>> I still don't know the reason why use addr+len as the upper-bound. I
>> think solution like x86/arm64/powerpc provide two address space switch
>> based on whether hint address above the default map window is enough.
>> 
>
> Yep this is expected. It is up to the maintainers to decide.

Sorry I forgot to reply to this, I had a buffer sitting around somewhere 
but I must have lost it.

I think Charlie's approach is the right way to go.  Putting my userspace 
hat on, I'd much rather have my allocations fail rather than silently 
ignore the hint when there's memory pressure.

If there's some real use case that needs these low hints to be silently 
ignored under VA pressure then we can try and figure something out that 
makes those applications work.

>
> - Charlie


Return-Path: <linux-kernel+bounces-47638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DD684508C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C01B1F27EDE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 04:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9B03BB4E;
	Thu,  1 Feb 2024 04:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TJeoq46D"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F503BB2D
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 04:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706763358; cv=none; b=jlWXD2DYXJfacGnB1xSMCBBQ38xz/J/LfE2ZGu5cTXTgd4piozi1YQuGrtmA4HhmqmqvADu2532aEKsLCpVPhHR+Wy3ou+hWx78Zy1+l80aXLuVmErmpFe53qexhNP+yIPpRta33bKpPXzRMn9xlQboijLcBhSdsVGPY6eSjvLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706763358; c=relaxed/simple;
	bh=L0yoXvq/d6omUMi6xtzN6TigsEZjzXC09EqfFo90GtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TwDTZwurQ/R43ICV+rKZt4lvCrOvzKlaMaZbEnXps/DpOmeTrL7ZOErS38Jo37uEsxjWIjkM7LXY1+xAUs6U209hnVMgj9IoE8iaOVnLCq5GkYyywVIfSIECIYVHzNRgRBasfzZ5wXXD9ASYEJuQLpbDxfRUUYTVVswMWaWtYno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TJeoq46D; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d93b982761so119425ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 20:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706763356; x=1707368156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YsqrP80NBPWxBx78FsktitHzUN/DGz3kT5ZrnUUMNWc=;
        b=TJeoq46DV0d6lA9cshUVwSeFYmEEqkBSUW4BG4NCXqGCrpDmJ7ZwzmvW0lj5b6JgOS
         +bODEdibSzFkkNrrNkEJuy+WqfjMOSY/BrnduUdBefpeI2gbgkJNx8STvK99i3rjIYwg
         9ijWtUF0KMJXHFMjhjp8eD8lP80HQs3AySu60rP5bPzAGlXpL/CMxryBsnmo6iDhFqn0
         8PrEtje+/hiPIAyYUV1MLFR62oxB8RsNok2B5KQrCgolRTz41f0kN0BnoGGqulpKtutL
         V/IBmll2PzVN/9CSJpbvYTRuTre6aRlzYAt/4M8u4LehjePo7BniVyYtNtjI8t7pmrtv
         0r/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706763356; x=1707368156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YsqrP80NBPWxBx78FsktitHzUN/DGz3kT5ZrnUUMNWc=;
        b=AOIvUN7As2Jgk4gjn2214NQliv0OEyIZo3N7DKf5Sw5vvYzLUQGuqB8TeafZgVkqE+
         0NeKcqc1RaPC3ajH2YmSqhRVJ3bVL4y0xteMxpj3bPApuS7/NQr696kiB6Ggqd3Q1D8/
         vJRzDUvfxswxAeiZe4S5/42/dbbQjHai/WzABxyEvre8FlCswx/g7zD8ogtu2ogCOajC
         7Pv+PcGIcRAUq1b9pUsKfuBwF1spNCEwSh2cyhKXT8i8BtVZZDDCZU+LnFLa5zhIf0ZE
         2xSB0O7IedlF9DoszMIt8m/2AeciG0NI15FmvZolyaOdBPvhW+nj+ukLBubNbrWslUyx
         YxdA==
X-Gm-Message-State: AOJu0Yy7/uuHZJMLu1tion0j4Z2FoZri90EdEccvNIVsWc2JFQHKDxrM
	Tb/yaayEYzGChmfnSadvrHrz9XW1tdCEH0iwa6o1qmceIJFk9Jz+jFLCLrWePQ==
X-Google-Smtp-Source: AGHT+IHK1/WgkjIKx0flbjpFflqU9a56/6fl9CXpl7gOvyu5gmDaW1mxugbmgLgncwtMdAWnWaNzZg==
X-Received: by 2002:a17:902:d58f:b0:1d8:f3c7:fb83 with SMTP id k15-20020a170902d58f00b001d8f3c7fb83mr106370plh.9.1706763356049;
        Wed, 31 Jan 2024 20:55:56 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV4Q548nt1ArvLGL2wR2E8vSlBntuR737WWtXt371mCiALATgckvigQx4dwtoGKhCMAatv2D8bgdgK02B+fOCaMn4Bf4YU8F27jYiuApzRhepfS+rHhUyzbSLKP8LIRnPbZFUD1yS1BWQL8Ewyk6oZDXFNulca7j+6S4Gs6tejvqqNk3CHRnFK3eJwLrkzePpZcAvG5g6PVOUh4lIGl5HItVTfnNu63wYd+qACW2eiF+PqyotQ8L71W+jKKENG7//L4f9hcdxI=
Received: from google.com ([2620:15c:2d3:205:ce95:ce9d:3dd2:5053])
        by smtp.gmail.com with ESMTPSA id o4-20020a170902d4c400b001d8a5c08277sm9616689plg.260.2024.01.31.20.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 20:55:55 -0800 (PST)
Date: Wed, 31 Jan 2024 20:55:51 -0800
From: Fangrui Song <maskray@google.com>
To: Dave Martin <Dave.Martin@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	Jisheng Zhang <jszhang@kernel.org>, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: jump_label: use constraint "S" instead of "i"
Message-ID: <20240201045551.ajg4iqcajyowl2rh@google.com>
References: <20240131065322.1126831-1-maskray@google.com>
 <CAMj1kXGzADFWa7RmXyjWpCnQ=9hhz6i-XkN4PS1CboZ-kFL8dQ@mail.gmail.com>
 <ZbpEnDK3U/O24ng0@e133380.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZbpEnDK3U/O24ng0@e133380.arm.com>

On 2024-01-31, Dave Martin wrote:
>On Wed, Jan 31, 2024 at 08:16:04AM +0100, Ard Biesheuvel wrote:
>> Hello Fangrui,
>>
>> On Wed, 31 Jan 2024 at 07:53, Fangrui Song <maskray@google.com> wrote:
>> >
>> > The constraint "i" seems to be copied from x86 (and with a redundant
>> > modifier "c"). It works with -fno-PIE but not with -fPIE/-fPIC in GCC's
>> > aarch64 port.
>
>(I'm not sure of the exact history, but the "c" may be inherited from
>arm, where an output modifier was needed to suppress the "#" that
>prefixes immediates in the traditional asm syntax.  This does not
>actually seem to be required for AArch64: rather while a # is allowed
>and still considered good style in handwritten asm code, the syntax
>doesn't require it, and the compiler doesn't emit it for "i" arguments,
>AFAICT.)

The aarch64 one could be inherited from
arch/arm/include/asm/jump_label.h (2012), which could in turn be
inherited from x86 (2010).
Both the constraint "i" and the modifier "c" are generic..
For -fno-pic this combination can be used for every arch.

>> > The constraint "S", which denotes a symbol reference (e.g. function,
>> > global variable) or label reference, is more appropriate, and has been
>> > available in GCC since 2012 and in Clang since 7.0.
>> >
>> > Signed-off-by: Fangrui Song <maskray@google.com>
>> > Link: https://maskray.me/blog/2024-01-30-raw-symbol-names-in-inline-assembly
>> > ---
>> >  arch/arm64/include/asm/jump_label.h | 8 ++++----
>> >  1 file changed, 4 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/arch/arm64/include/asm/jump_label.h b/arch/arm64/include/asm/jump_label.h
>> > index 48ddc0f45d22..31862b3bb33d 100644
>> > --- a/arch/arm64/include/asm/jump_label.h
>> > +++ b/arch/arm64/include/asm/jump_label.h
>> > @@ -23,9 +23,9 @@ static __always_inline bool arch_static_branch(struct static_key * const key,
>> >                  "      .pushsection    __jump_table, \"aw\"    \n\t"
>> >                  "      .align          3                       \n\t"
>> >                  "      .long           1b - ., %l[l_yes] - .   \n\t"
>> > -                "      .quad           %c0 - .                 \n\t"
>> > +                "      .quad           %0 - .                  \n\t"
>> >                  "      .popsection                             \n\t"
>> > -                :  :  "i"(&((char *)key)[branch]) :  : l_yes);
>> > +                :  :  "S"(&((char *)key)[branch]) :  : l_yes);
>>
>> 'key' is not used as a raw symbol name. We should make this
>>
>> "    .quad   %0 + %1 - ."
>>
>> and
>>
>> ::  "S"(key), "i"(branch) :: l_yes);
>>
>> if we want to really clean this up.
>
>This hides more logic in the asm so it's arguably more cryptic
>(although the code is fairly cryptic to begin with -- I don't really
>see why the argument wasn't written as the equivalent
>(char *)key + branch...)

I agree that using "S" and "i" would introduce complexity.
Using just "S" as this patch does should be clear.

All of "i" "s" "S" support a symbol or label reference and a constant offset (can be zero),
(in object file, a symbol and an addend; in GCC's term, the sum of a SYMBOL_REF and a CONST_INT).

>Anyway, I don't think the "i" versys "S" distinction makes any
>difference without -fpic or equivalent, so it is not really relevant
>for the kernel (except that "S" breaks compatibility with older
>compilers...)
>
>
>I think the main advantage of "S" is that it stops you accidentally
>emitting undesirable relocations from asm code that is not written for
>the -fpic case.
>
>But just changing "i" to "S" is not sufficient to port asms to -fpic:
>the asms still need to be reviewed.
>
>
>So unless the asm has been reviewed for position-independence, it may
>anyway be better to stick with "i" so that the compiler actually chokes
>if someone tries to build the code with -fpic.

The asm is position-independent.
This `.long sym - .` is a common metadata section pattern to support PIC:)

Regarding the constraints, I've updated
https://maskray.me/blog/2024-01-30-raw-symbol-names-in-inline-assembly
to include more details.

>Since we are not trying to run arbitraily many running kernels in a
>common address space (and not likely to do that), I'm not sure that we
>would ever build the kernel with -fpic except for a few special-case
>bits like the EFI stub and vDSO... unless I've missed something?
>
>If there's another reason why "S" is advantageous though, I'm happy to
>be corrected.

I remember that Ard has an RFC
https://lore.kernel.org/linux-arm-kernel/20220427171241.2426592-1-ardb@kernel.org/
"[RFC PATCH 0/2] arm64: use PIE code generation for KASLR kernel"
and see some recent PIE codegen patches.

> Building the KASLR kernel without -fpie but linking it with -pie works
> in practice, but it is not something that is explicitly supported by the
> toolchains - it happens to work because the default 'small' code model
> used by both GCC and Clang relies mostly on ADRP+ADD/LDR to generate
> symbol references.

I agree that current -fno-PIE with -shared -Bsymbolic linking is a hack
that works as a conincidence, not guaranteed by the toolchain.
This jump_label improvement (with no object file difference) fixes an
obstacle. 


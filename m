Return-Path: <linux-kernel+bounces-150761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 213EE8AA43A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 22:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 867D0280C51
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00501190687;
	Thu, 18 Apr 2024 20:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uD4wCO9g"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54432E416
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 20:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713473212; cv=none; b=Z0rLwEDu1yxqHcnTRNfJHK77YJz9DSeGzl1mG3ykD8c5r/FTRa17lwq8/TI9MjWxeFMJg6fr3WoxZBX9ASd02gsh78uD4xymeGauBSr6aLcghuwJO//x4ZzLgIujLrCigkqOtnf7Ov2ZCYi188OLeq48s6DktVWUo7/c0wGlA0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713473212; c=relaxed/simple;
	bh=2uEjWGQAsOsIfV8JweL2+DM0EtwCDNgkVsQGr2+cEXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GldczNTXsk6CJnUjB9Ekh9tVezrWrc7bg2hBdm4TDop9G8q8pC4NcGG04zLQ0n9CxplVnxTSDGaMyjyCAquJg9SDqumzLFmPpLPpfEQHdaHDHd0E9qKpH5PPRpwwcAFbJvY8WtMG6PjWCU4Sh0oTHtQzjJLGUG6oNsxOB3ygZ2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uD4wCO9g; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e8414dc4e8so11905ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 13:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713473210; x=1714078010; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+OxDjoGGy1HqEOb4w0cL5x3uQ8o+UC2ei3huEHy8ahs=;
        b=uD4wCO9gOe7TS7XxbYRnMo3yUekKX35BGa9TYKa4dmUy9UrpsqMtl/jL3geGsizwk1
         YXGaaykmo8bD0eeYlgjTnsInU19/M1554+Y3lr92VLJsX+fMnkYO/MDctYneJ06uYHB3
         grF4wQ+SzLZhRyRBDy9wr4ej1tewETDtk3gsI9qoEXNPUOb/F4S6OPVzfP8BcZfFbRdg
         fd8GR+zjSGwrRpaAw6agoYhrtocTPe00bmFHAOukJgcMhr74lxV97D3uo3DP79yRj2vX
         DalQHaF4JhGiihAQLe9CYU8F5+GXRxVtGwRoz7wTxQbV+OPNNJA2n0Myh7aENu0GAuT7
         zkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713473210; x=1714078010;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+OxDjoGGy1HqEOb4w0cL5x3uQ8o+UC2ei3huEHy8ahs=;
        b=gtFb2PqXOA6iFil4U2D2IBMvr77YKlTNhVnIFbyiSB2aVufku7S3H65/SgwuEcsZog
         FyjSt18x+m9wGtsvqHP6ZmM7lwvUDA5E1Ylih9SosOPa1ZXMLevbIgAvEeKwXuq9z6fh
         c+wrKeesprp2WN/z40JS+bB8O+aysMyfNONNBwcX6vo4di1j84PHa7H/SF4mpy2xdpiR
         br4DelkS1+wYXyhg/Yw0VBLLz3ASlb8MvQ8Y/dxP/+S8ZE7n4gSmdp8EQjpFzkbqBp/7
         jqtmmBtu3Pj0XpR5hkklVFwRpvXYlc9Cu9x0ViNsHkTTRab9xdvcCzdVkNBN+ec35lDD
         e+Zg==
X-Forwarded-Encrypted: i=1; AJvYcCUP6/4azbYoFSg4LZXXjPC3QH7eKmqnoDMfSvDdyDGo/7Ip08gTPLKLyRZ2NTXIcM1vz32axfPmnzHSVXlNokWD/zmA5pixFI0EI8Po
X-Gm-Message-State: AOJu0YyJaxIL2ZXIJ03BMYV/Jr3XBqBdF5PlPZorxELJ993/TCJ7Bkgx
	QJZpauCA//Hga/GouBaR5IVAISGM7MDumFCfd9B1D890Ytg+hRCPl0fjVt4Kpw==
X-Google-Smtp-Source: AGHT+IFj941mf9cufQ2vfb9yEB1VjE8vhFQwbWqrjph2DM5feMXwOPO/D+qJcXCDQar1DEssSmKLYA==
X-Received: by 2002:a17:902:fa07:b0:1e5:c85e:6b71 with SMTP id la7-20020a170902fa0700b001e5c85e6b71mr60894plb.22.1713473209904;
        Thu, 18 Apr 2024 13:46:49 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:205:4bdb:93c3:5c52:fa8a])
        by smtp.gmail.com with ESMTPSA id a8-20020aa78e88000000b006f0ba1c8ddesm318098pfr.184.2024.04.18.13.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 13:46:49 -0700 (PDT)
Date: Thu, 18 Apr 2024 13:46:45 -0700
From: Fangrui Song <maskray@google.com>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, Song Liu <song@kernel.org>,
	Ricardo Ribalda <ribalda@kernel.org>,
	Arthur Eubanks <aeubanks@google.com>, stable@vger.kernel.org,
	Steve Wahl <steve.wahl@hpe.com>,
	Vaibhav Rustagi <vaibhavrustagi@google.com>,
	Andreas Smas <andreas@lonelycoder.com>
Subject: Re: [PATCH] x86/purgatory: Switch to the position-independent small
 code model
Message-ID: <20240418204645.o4av4kl2y35qcm2u@google.com>
References: <20240418201705.3673200-2-ardb+git@google.com>
 <CAKwvOdnNurTJNb7iOVW4dpkV-rZGWg2t3HuLkL+B5sNOin39WA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdnNurTJNb7iOVW4dpkV-rZGWg2t3HuLkL+B5sNOin39WA@mail.gmail.com>


On 2024-04-18, Nick Desaulniers wrote:
>On Thu, Apr 18, 2024 at 1:17 PM Ard Biesheuvel <ardb+git@google.com> wrote:
>>
>> From: Ard Biesheuvel <ardb@kernel.org>
>>
>> On x86, the ordinary, position dependent 'small' and 'kernel' code models only
>> support placement of the executable in 32-bit addressable memory, due to
>> the use of 32-bit signed immediates to generate references to global
>> variables. For the kernel, this implies that all global variables must
>> reside in the top 2 GiB of the kernel virtual address space, where the
>> implicit address bits 63:32 are equal to sign bit 31.
>>
>> This means the kernel code model is not suitable for other bare metal
>> executables such as the kexec purgatory, which can be placed arbitrarily
>> in the physical address space, where its address may no longer be
>> representable as a sign extended 32-bit quantity. For this reason,
>> commit
>>
>>   e16c2983fba0 ("x86/purgatory: Change compiler flags from -mcmodel=kernel to -mcmodel=large to fix kexec relocation errors")
>>
>> switched to the 'large' code model, which uses 64-bit immediates for all
>> symbol references, including function calls, in order to avoid relying
>> on any assumptions regarding proximity of symbols in the final
>> executable.
>>
>> The large code model is rarely used, clunky and the least likely to
>> operate in a similar fashion when comparing GCC and Clang, so it is best
>> avoided. This is especially true now that Clang 18 has started to emit
>> executable code in two separate sections (.text and .ltext), which
>> triggers an issue in the kexec loading code at runtime.
>>
>> Instead, use the position independent small code model, which makes no
>> assumptions about placement but only about proximity, where all
>> referenced symbols must be within -/+ 2 GiB, i.e., in range for a
>> RIP-relative reference. Use hidden visibility to suppress the use of a
>> GOT, which carries absolute addresses that are not covered by static ELF
>> relocations, and is therefore incompatible with the kexec loader's
>> relocation logic.
>>
>> Cc: Nathan Chancellor <nathan@kernel.org>
>> Cc: Nick Desaulniers <ndesaulniers@google.com>
>
>Thanks Ard!
>
>Acked-by: Nick Desaulniers <ndesaulniers@google.com>
>Reported-by: ns <0n-s@users.noreply.github.com>
>Closes: https://github.com/ClangBuiltLinux/linux/issues/2016
>Fixes: e16c2983fba0 ("x86/purgatory: Change compiler flags from
>-mcmodel=kernel to -mcmodel=large to fix kexec relocation errors")
>
>(I don't have a kexec setup ready to go; maybe someone that does can
>help test it.)

LGTM.

Position-dependent small code model may generate R_X86_64_32S
relocations with a range of [0,2GiB) (the negative half cannot be used).
Position-independent small code model with hidden visibility will
generate R_X86_64_PC32 and can typically be quite larger than 2G without
hitting an overflow issue.

(I have some notes about R_X86_64_32S at
https://maskray.me/blog/2023-05-14-relocation-overflow-and-code-models#x86-64-linker-requirement)

Reviewed-by: Fangrui Song <maskray@google.com>

>> Cc: Bill Wendling <morbo@google.com>
>> Cc: Justin Stitt <justinstitt@google.com>
>> Cc: Song Liu <song@kernel.org>
>> Cc: Ricardo Ribalda <ribalda@kernel.org>
>> Cc: Fangrui Song <maskray@google.com>
>> Cc: Arthur Eubanks <aeubanks@google.com>
>> Link: https://lore.kernel.org/all/20240417-x86-fix-kexec-with-llvm-18-v1-0-5383121e8fb7@kernel.org/
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>> ---
>>  arch/x86/purgatory/Makefile | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
>> index bc31863c5ee6..a18591f6e6d9 100644
>> --- a/arch/x86/purgatory/Makefile
>> +++ b/arch/x86/purgatory/Makefile
>> @@ -42,7 +42,8 @@ KCOV_INSTRUMENT := n
>>  # make up the standalone purgatory.ro
>>
>>  PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel
>> -PURGATORY_CFLAGS := -mcmodel=large -ffreestanding -fno-zero-initialized-in-bss -g0
>> +PURGATORY_CFLAGS := -mcmodel=small -ffreestanding -fno-zero-initialized-in-bss -g0
>> +PURGATORY_CFLAGS += -fpic -fvisibility=hidden
>>  PURGATORY_CFLAGS += $(DISABLE_STACKLEAK_PLUGIN) -DDISABLE_BRANCH_PROFILING
>>  PURGATORY_CFLAGS += -fno-stack-protector
>>
>> --
>> 2.44.0.769.g3c40516874-goog
>>
>
>
>-- 
>Thanks,
>~Nick Desaulniers


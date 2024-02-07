Return-Path: <linux-kernel+bounces-56548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AD984CB8D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA94D1C212F1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B7476C7C;
	Wed,  7 Feb 2024 13:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpLCbaIt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E5F76C8E
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 13:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707312476; cv=none; b=NKKoupI82MbalxUK1WQ0Z6WZCm8nYbxr9qa8xKv4kGpAcTdsOrdMgFvUIlj0XBvc1zGSs4HxLd5sdkxCEto+0r26Y/SyizZLgj5GtcIoMaBW+NVH0JXKHWV8bHaASMXk82CiPVnGUfDsMlC2K3myIpqZk7t9VQhKMdRnI9NBQbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707312476; c=relaxed/simple;
	bh=5rRb9zbU+Nz6ghZbuyCes4zjfjcgYvGoNoMaCvvVXaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LEFFUHccNR+dN9GZB9Shu11NALb4NtNTAFItbEDr9ET/D/wuJmySu7obQTyK12d8o3zlt7dEsZK3QkxwbH2ymZqIAyGmoTvs9zMn8Iy2uFaR/pC57v24XymaWEKu2UlFKcCKQ3BzcSzueEZvTU03/29ga3cWq5MgDiMlsLbBy5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpLCbaIt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23122C433F1
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 13:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707312476;
	bh=5rRb9zbU+Nz6ghZbuyCes4zjfjcgYvGoNoMaCvvVXaA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OpLCbaIts2BujqD664RCtbilmhFgmDM4OC8t+/O+ecp3+FikpSljE2oKfCt+C5+xY
	 uCGcwa8WFYPVpj7Hgm656dBPTfv6FQt3bg3qzyWKs/JdmvlhnURFdOwr7KVjhLoatR
	 BMusor7ra2mA2DbKh9A/VfYXLi3tu51m/WtUq+VNL8aR1wj55mZhCUmLnKuzKeDxSJ
	 jE9C2PS4asbE0mtbvljA/dOutLWmOTEU77pr5qal2R4VKZ01+PtYPsw86LC9ZOzxsj
	 Gnm4jMWw+CJ12PPnoXfQeqJhgnhWp5BfNGOPGjMAWyzNmUHX9YDmqGS7ram7BxeusE
	 v2b+K/ZHNCoxA==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-557dcb0f870so746509a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 05:27:56 -0800 (PST)
X-Gm-Message-State: AOJu0YyUrJRGdkFjya1N85n3h1Dpgdb+FhitY4Io+gAcTGbczKTxChlM
	hKwhoRrBHPb5m1XaiZQ0jpH6fhxLWxjDC8cyqAgKMqVsuzdAfmUadleFa7omO7WL1EIixLDzMzN
	Q4AP7mUb+ObfHOgUx1GoUem38JWw=
X-Google-Smtp-Source: AGHT+IEX2BtaRGTKiDFsyAisrfIFwHSBUUPfvfCEp6q8X/TGqWT8ZRRomT4oxcgrQsLT8jZjmVtamzWC2sGgL8cgq8o=
X-Received: by 2002:a05:6402:695:b0:560:9267:95af with SMTP id
 f21-20020a056402069500b00560926795afmr3687280edy.22.1707312474550; Wed, 07
 Feb 2024 05:27:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130061730.21118-1-yangtiezhu@loongson.cn>
In-Reply-To: <20240130061730.21118-1-yangtiezhu@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 7 Feb 2024 21:27:47 +0800
X-Gmail-Original-Message-ID: <CAAhV-H43VOj9UhMjv-um-U3Hyix_KStNhuwzTHSRxnuk-u4bvg@mail.gmail.com>
Message-ID: <CAAhV-H43VOj9UhMjv-um-U3Hyix_KStNhuwzTHSRxnuk-u4bvg@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] Add objtool, orc and livepatching support for LoongArch
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Josh and Peter,

This version looks good to me now. Should this series go through the
objtool tree or the loongarch tree? If it should go through the
objtool tree, then please apply the first 6 patches with

Acked-by: Huacai Chen <chenhuacai@loongson.cn>

And if it can go through the loongarch tree, I will apply the whole 8
patches. Thanks.

Huacai

On Tue, Jan 30, 2024 at 2:17=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> This version is based on 6.8-rc2, tested with the latest upstream
> gcc and binutils (20240129).
>
> v6:
>   -- Add "-mno-relax" option
>   -- Remove "-fno-optimize-sibling-calls" option
>   -- Remove "-falign-functions=3D4 -falign-labels=3D4" options
>   -- Remove "#ifdef CONFIG_CPU_HAS_LBT" in lbt.S
>   -- Remove patch "objtool: Check local label about sibling call"
>   -- Silence the objtool warnings under CONFIG_FUNCTION_TRACER
>   -- Add livepatching support and fix the problems when testing
>
> Tiezhu Yang (8):
>   objtool/LoongArch: Enable objtool to be built
>   objtool/LoongArch: Implement instruction decoder
>   objtool/x86: Separate arch-specific and generic parts
>   objtool/LoongArch: Enable orc to be built
>   objtool: Check local label in add_dead_ends()
>   objtool: Check local label in read_unwind_hints()
>   LoongArch: Add ORC stack unwinder support
>   LoongArch: Add kernel livepatching support
>
>  arch/loongarch/Kconfig                        |   6 +
>  arch/loongarch/Kconfig.debug                  |  11 +
>  arch/loongarch/Makefile                       |  23 +-
>  arch/loongarch/include/asm/Kbuild             |   2 +
>  arch/loongarch/include/asm/bug.h              |   1 +
>  arch/loongarch/include/asm/exception.h        |   2 +
>  arch/loongarch/include/asm/module.h           |   7 +
>  arch/loongarch/include/asm/orc_header.h       |  18 +
>  arch/loongarch/include/asm/orc_lookup.h       |  31 ++
>  arch/loongarch/include/asm/orc_types.h        |  58 ++
>  arch/loongarch/include/asm/stackframe.h       |   3 +
>  arch/loongarch/include/asm/thread_info.h      |   2 +
>  arch/loongarch/include/asm/unwind.h           |  20 +-
>  arch/loongarch/include/asm/unwind_hints.h     |  28 +
>  arch/loongarch/kernel/Makefile                |   4 +
>  arch/loongarch/kernel/entry.S                 |   5 +
>  arch/loongarch/kernel/fpu.S                   |   7 +
>  arch/loongarch/kernel/genex.S                 |   6 +
>  arch/loongarch/kernel/lbt.S                   |   2 +
>  arch/loongarch/kernel/mcount_dyn.S            |   6 +
>  arch/loongarch/kernel/module.c                |  22 +-
>  arch/loongarch/kernel/relocate_kernel.S       |   8 +-
>  arch/loongarch/kernel/rethook_trampoline.S    |   1 +
>  arch/loongarch/kernel/setup.c                 |   2 +
>  arch/loongarch/kernel/stacktrace.c            |  42 ++
>  arch/loongarch/kernel/traps.c                 |  42 +-
>  arch/loongarch/kernel/unwind_orc.c            | 516 ++++++++++++++++++
>  arch/loongarch/kernel/vmlinux.lds.S           |   3 +
>  arch/loongarch/kvm/switch.S                   |   9 +-
>  arch/loongarch/lib/clear_user.S               |   2 +
>  arch/loongarch/lib/copy_user.S                |   2 +
>  arch/loongarch/lib/memcpy.S                   |   2 +
>  arch/loongarch/lib/memset.S                   |   2 +
>  arch/loongarch/mm/tlb.c                       |  27 +-
>  arch/loongarch/mm/tlbex.S                     |   9 +
>  arch/loongarch/vdso/Makefile                  |   1 +
>  include/linux/compiler.h                      |   9 +
>  scripts/Makefile                              |   7 +-
>  tools/arch/loongarch/include/asm/inst.h       | 161 ++++++
>  tools/arch/loongarch/include/asm/orc_types.h  |  58 ++
>  tools/include/linux/bitops.h                  |  11 +
>  tools/objtool/Makefile                        |   4 +
>  tools/objtool/arch/loongarch/Build            |   3 +
>  tools/objtool/arch/loongarch/decode.c         | 356 ++++++++++++
>  .../arch/loongarch/include/arch/cfi_regs.h    |  22 +
>  .../objtool/arch/loongarch/include/arch/elf.h |  30 +
>  .../arch/loongarch/include/arch/special.h     |  33 ++
>  tools/objtool/arch/loongarch/orc.c            | 171 ++++++
>  tools/objtool/arch/loongarch/special.c        |  15 +
>  tools/objtool/arch/x86/Build                  |   1 +
>  tools/objtool/arch/x86/orc.c                  | 188 +++++++
>  tools/objtool/check.c                         |  52 +-
>  tools/objtool/include/objtool/elf.h           |   1 +
>  tools/objtool/include/objtool/orc.h           |  14 +
>  tools/objtool/orc_dump.c                      |  69 +--
>  tools/objtool/orc_gen.c                       | 113 +---
>  56 files changed, 2011 insertions(+), 239 deletions(-)
>  create mode 100644 arch/loongarch/include/asm/orc_header.h
>  create mode 100644 arch/loongarch/include/asm/orc_lookup.h
>  create mode 100644 arch/loongarch/include/asm/orc_types.h
>  create mode 100644 arch/loongarch/include/asm/unwind_hints.h
>  create mode 100644 arch/loongarch/kernel/unwind_orc.c
>  create mode 100644 tools/arch/loongarch/include/asm/inst.h
>  create mode 100644 tools/arch/loongarch/include/asm/orc_types.h
>  create mode 100644 tools/objtool/arch/loongarch/Build
>  create mode 100644 tools/objtool/arch/loongarch/decode.c
>  create mode 100644 tools/objtool/arch/loongarch/include/arch/cfi_regs.h
>  create mode 100644 tools/objtool/arch/loongarch/include/arch/elf.h
>  create mode 100644 tools/objtool/arch/loongarch/include/arch/special.h
>  create mode 100644 tools/objtool/arch/loongarch/orc.c
>  create mode 100644 tools/objtool/arch/loongarch/special.c
>  create mode 100644 tools/objtool/arch/x86/orc.c
>  create mode 100644 tools/objtool/include/objtool/orc.h
>
> --
> 2.42.0
>


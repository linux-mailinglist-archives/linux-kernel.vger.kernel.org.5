Return-Path: <linux-kernel+bounces-112315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B8188783E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 12:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD8AFB213F9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 11:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288E417566;
	Sat, 23 Mar 2024 11:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awnMZ4DL"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D16168A9
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 11:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711193950; cv=none; b=Ut5RnuwGksYcU5aJB4FntuOq/T2UCiBEK6Hz+3p5jvINiDSy4N18iLdE1hgUAI/ylJZGKcD90BSQllLdnCSYK4JYN/o1lDICii9zs0vZdrtRN8pKuwHIIcNFAcuvR+GaclE7l9sCZ0GgT+IT2QFWCkeaoiIdgn8+c5n772Alx28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711193950; c=relaxed/simple;
	bh=OguGju/cuiGBlAgbGppg6drf1SWbtCLw1xYQj9VlcuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i8PvzoPcdRs6aM34gD7a/sYmAG1jeXS1WnBrlYaKNnrbDsjqpkv0GRrOqZt5s74WfmySrcqLIQSxY3BRmlxtR9P6n593u4s2/7zfQyjhHORomjKoA3qgEqxXiUFrI7IL5tG9Pvnno7Is1+4VD5d37hUFNajSUIvKitHXZGXv9u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awnMZ4DL; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d6c220a377so7079611fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 04:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711193946; x=1711798746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ztiQ49/UF8ul9Bo00LJXzC+8MFSrv4eIT5AeEL26wU=;
        b=awnMZ4DLcBSwqnoeqjrMuI8PKeCCKtuWF7h1TMiIrNH+uT5AjeOGA1Hv6EMoRShulM
         Ttl00aZg/B6rV+O7+Y8vjaF/WFsQMlq+oajXHtMiFlb4Unld+0kl9A7GlPlQ1gIOxmQB
         rlktu/fXt5slifXEXDhsOK4+rO9d2yGmcyeyZh9PQbxyh/sOaZxE10f1tEet7Ez93Ajz
         4sA9NSCJLU5E+K72VDO8894Fp0ey2JJMIjjYxBRRJlmzOr83VkqnjJMmadKlxuIW8tiV
         bji3QJIa/cXfIZ3uJICRRBn215u5VpYWa/ikQyA5ocWGjvSsMt91rUF3/Ug9CZiNAUyF
         DXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711193946; x=1711798746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ztiQ49/UF8ul9Bo00LJXzC+8MFSrv4eIT5AeEL26wU=;
        b=QSQaZh42gyWz8hJPPZW0KvrMmxym7gfzkAGfvifGTAgO8xWaC69idknWWTa5gujCCh
         dLQUysr8ZJhTDKqouhm7Qy4PSyEhq7Mtxr/a05ZT6DHtj5mUc1tXGD0l+lXy/8hUl9h+
         vBh/j3V/vJrJ2u0f4eKmMfEoYaXbOEkksmitfcBRecyCdGdjI4bbntDeDD+eduyfkF4n
         4jKLEE4/ztiKfBtvDzumGkAAdkSlaXny3W4Bw82hhEaZVjCAeS9GeG4q7DWIJJ0LCge5
         P8CE0c2HseBg2dpsStGAmZ44zGDo0NzkbbZqyVGMVNXEwWo/LJcAOpzg9TmeutMkQVj5
         VL9g==
X-Gm-Message-State: AOJu0YyXKzj14vBO1ofWMQgIeOiZmC3m5TlsoSKxRtw08QVwXmjpiAgq
	PBF92hdXjPh9xjsWu9XkqR58A0V4E6d+wxUP5Dl4FdjNIPg6YD5J94QiDS5nlpUL7PLVs60/8Xg
	5zsjtLth8Bx3AIek8LnLcpp48yB0Fu+2vlbRw/Q==
X-Google-Smtp-Source: AGHT+IFFyABDBOwgDsAzH0C2a0yBT1V8lbUZrvVadAKzgOdWZxsUF5p1Nh+e/UVKysUtuVXnD+nVdrg+fqKLK5I/BWU=
X-Received: by 2002:a2e:9984:0:b0:2d6:c94d:94c2 with SMTP id
 w4-20020a2e9984000000b002d6c94d94c2mr537002lji.46.1711193946198; Sat, 23 Mar
 2024 04:39:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322165233.71698-1-brgerst@gmail.com>
In-Reply-To: <20240322165233.71698-1-brgerst@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sat, 23 Mar 2024 12:39:04 +0100
Message-ID: <CAFULd4bCufzKjaUyOcJ5MfsPBcVTj1zQiP3+FFCGo6SbxTpK2A@mail.gmail.com>
Subject: Re: [PATCH v4 00/16] x86-64: Stack protector and percpu improvements
To: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	"H . Peter Anvin" <hpa@zytor.com>, David.Laight@aculab.com, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 5:52=E2=80=AFPM Brian Gerst <brgerst@gmail.com> wro=
te:
>
> Currently, x86-64 uses an unusual percpu layout, where the percpu section
> is linked at absolute address 0.  The reason behind this is that older GC=
C
> versions placed the stack protector (if enabled) at a fixed offset from t=
he
> GS segment base.  Since the GS segement is also used for percpu variables=
,
> this forced the current layout.
>
> GCC since version 8.1 supports a configurable location for the stack
> protector value, which allows removal of the restriction on how the percp=
u
> section is linked.  This allows the percpu section to be linked normally,
> like other architectures.  In turn, this allows removal of code that was
> needed to support the zero-based percpu section.

The number of simplifications throughout the code, enabled by this
patch set, is really impressive, and it reflects the number of
workarounds to enable the feature that was originally not designed for
the kernel usage. As noted above, this issue was recognized in the GCC
compiler and the stack protector support was generalized by adding
configurable location for the stack protector value [1,2].

The improved stack protector support was implemented in gcc-8.1,
released on May 2, 2018, when linux 4.17 was in development. In light
of this fact, and 5 (soon 6) GCC major releases later, I'd like to ask
if the objtool support to fixup earlier compilers is really necessary.
Please note that years ago x86_32 simply dropped stack protector
support with earlier compilers and IMO, we should follow this example
also with x86_64, because:

a) There are currently 5 (soon 6) GCC major releases that support
configurable location for stack protector value. GCC 10 is already out
of active maintenance, and GCC 7 is considered an ancient release at
this time. For x86_32, it was advised to drop the support for stack
protector entirely with too old compilers to somehow force users to
upgrade the compiler.

b) Stack protector is not a core feature - the kernel will still boot
without stack protector. So, if someone really has the urge to use
ancient compilers with the bleeding edge kernel, it is still possible
to create a bootable image. I do not think using ancient compilers to
compile bleeding edge kernels makes any sense at all.

c) Maintenance burden - an objtool feature will have to be maintained
until gcc-8.1 is the minimum required compiler version. This feature
will IMO be seldom used and thus prone to bitrot.

d) Discrepancy between x86_32 and x86_64 - either both targets should
use objtool fixups for stack protector, or none at all. As shown by
x86_32 approach in the past, removing stack protector support with
ancient compilers was not problematic at all.

That said, the whole series is heartily Acked-by: Uros Bizjak
<ubizjak@gmail.com>

[1] https://gcc.gnu.org/git/?p=3Dgcc.git;a=3Dcommitdiff;h=3De1769bdd4cef522=
ada32aec863feba41116b183a
[2] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D81708

Thanks,
Uros.

>
> v4:
> - Updated to current tip tree
> - Added two new cleanups made possible by the removal of IA-64.
> - Small improvements to the objtool conversion code.
>
> Brian Gerst (16):
>   x86/stackprotector/32: Remove stack protector test script
>   x86/stackprotector/64: Remove stack protector test script
>   x86/boot: Disable stack protector for early boot code
>   x86/pvh: Use fixed_percpu_data for early boot GSBASE
>   x86/relocs: Handle R_X86_64_REX_GOTPCRELX relocations
>   objtool: Allow adding relocations to an existing section
>   objtool: Convert fixed location stack protector accesses
>   x86/stackprotector/64: Convert to normal percpu variable
>   x86/percpu/64: Use relative percpu offsets
>   x86/percpu/64: Remove fixed_percpu_data
>   x86/boot/64: Remove inverse relocations
>   x86/percpu/64: Remove INIT_PER_CPU macros
>   percpu: Remove PER_CPU_FIRST_SECTION
>   percpu: Remove PERCPU_VADDR()
>   percpu: Remove __per_cpu_load
>   kallsyms: Remove KALLSYMS_ABSOLUTE_PERCPU
>
>  arch/x86/Kconfig                          |  16 +--
>  arch/x86/Makefile                         |  21 ++--
>  arch/x86/boot/compressed/misc.c           |  14 +--
>  arch/x86/entry/entry_64.S                 |   2 +-
>  arch/x86/include/asm/desc.h               |   1 -
>  arch/x86/include/asm/percpu.h             |  22 ----
>  arch/x86/include/asm/processor.h          |  28 +----
>  arch/x86/include/asm/stackprotector.h     |  36 +-----
>  arch/x86/kernel/Makefile                  |   2 +
>  arch/x86/kernel/asm-offsets_64.c          |   6 -
>  arch/x86/kernel/cpu/common.c              |   9 +-
>  arch/x86/kernel/head64.c                  |   2 +-
>  arch/x86/kernel/head_64.S                 |  20 ++-
>  arch/x86/kernel/irq_64.c                  |   1 -
>  arch/x86/kernel/setup_percpu.c            |  12 +-
>  arch/x86/kernel/vmlinux.lds.S             |  35 ------
>  arch/x86/platform/pvh/head.S              |  10 +-
>  arch/x86/tools/relocs.c                   | 143 ++--------------------
>  arch/x86/xen/xen-head.S                   |  10 +-
>  include/asm-generic/sections.h            |   2 +-
>  include/asm-generic/vmlinux.lds.h         |  43 +------
>  include/linux/percpu-defs.h               |  12 --
>  init/Kconfig                              |  11 +-
>  kernel/kallsyms.c                         |  12 +-
>  mm/percpu.c                               |   4 +-
>  scripts/Makefile.lib                      |   2 +
>  scripts/gcc-x86_32-has-stack-protector.sh |   8 --
>  scripts/gcc-x86_64-has-stack-protector.sh |   4 -
>  scripts/kallsyms.c                        |  80 +++---------
>  scripts/link-vmlinux.sh                   |   4 -
>  tools/objtool/arch/x86/decode.c           |  46 +++++++
>  tools/objtool/arch/x86/special.c          |  91 ++++++++++++++
>  tools/objtool/builtin-check.c             |   9 +-
>  tools/objtool/check.c                     |  14 ++-
>  tools/objtool/elf.c                       | 133 ++++++++++++++++----
>  tools/objtool/include/objtool/arch.h      |   3 +
>  tools/objtool/include/objtool/builtin.h   |   2 +
>  tools/objtool/include/objtool/elf.h       |  90 +++++++++++---
>  38 files changed, 442 insertions(+), 518 deletions(-)
>  delete mode 100755 scripts/gcc-x86_32-has-stack-protector.sh
>  delete mode 100755 scripts/gcc-x86_64-has-stack-protector.sh
>
>
> base-commit: 30052fd948a3b43506c83590eaaada12d1f2dd09
> --
> 2.44.0
>


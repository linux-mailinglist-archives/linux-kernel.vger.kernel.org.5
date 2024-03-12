Return-Path: <linux-kernel+bounces-99719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F97878C33
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 02:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDC48282C32
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 01:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE35186A;
	Tue, 12 Mar 2024 01:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P1yz4TxU"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FCD10E6
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 01:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710206316; cv=none; b=doKTdzx3LHM9MHxTjhSex9I2vWO0K63bV5QkZuPcb/1YnylNOPF8++IF9b06AZvKqwiU+W62HOeb3cj0hut7+jyh2vdLLXiUW4pp6yipXH/lfhMxMLArqt3GM9ur2p2mUc/s2l0IMSCoJ14qc5G6htUxK5wq9ZsQkYLl3ua9pOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710206316; c=relaxed/simple;
	bh=LlDPdGUSuEysW+0IelyZlJYvm8m/D/jWNozdLA6bZqs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QCEfuUdGFanmhuuWw1Sg93ufVKdfmttCwOrMqptz/qOysEjA4jeaw/STPPS9QRLTS7lhZTzXgwGfglD5AMDfq0lmvUfi4F8P4IIleFCQQM8BAc/eKE4iJQE6mUEYni1iYqoXc6bZS7HfUznpkZ4UwaA6uI895eTRd/3xEYrezXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=P1yz4TxU; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-22222357d76so5813fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 18:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710206313; x=1710811113; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nTIpAV28U7eYXX05YBdvGn20WGUMvQJYSHzcZsEDIko=;
        b=P1yz4TxUTPj+ml8I7flaiDTqPx9Vceff+s+vxdZSc44lQ5LYoy51TFutSm7+gBuXOU
         G7Wfx2UUIF86EG/VA2wPi25v2dTsLsub2yHOyZ2PD7viIvdRErzm9tQakR6ap7nkbAqx
         6SylJUy01ktCzLDxq6GiIIxEmbl4OeYyHTxEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710206313; x=1710811113;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nTIpAV28U7eYXX05YBdvGn20WGUMvQJYSHzcZsEDIko=;
        b=MtbtdkQGBBn1bjhp8zYr2rQhCBdVN3HPs8NvmDF1K+HieRPzbBEscULcthSVrW24W9
         gxh6ZYOib22bj8ymaAy0FN5CUEBQqt020Xh7UA7IvUD3x1IbClzI5AEydq1Pu8S7uSP+
         K6SZlZL/WcOf/6rcTDSA7Z3ADHLokkU4/T2u5hhIbepUWwDTLJ+uRVKh+aDsBI5SOe13
         xOXkFJOEJ0AaM8T2/eR3a2YN+ODW0RdKF4ewjckkSfEMoEmCTlWgZnxf2BPfHpiW9FZX
         8f4l7T+hAyaZm9a5x2AklEl6r3i99dqNBNaPtZjl4ZwfR18ZkW0ukapcoNhgjfPyCQQv
         qHyQ==
X-Gm-Message-State: AOJu0Yx1vLlXBQ2d8cINMnD1L9Xv81RFlbQKB9+P0olHjgyxYSwQXjDu
	Nia/tsoRqscQW0tOVH2yDhSnxnCpkGlNV9dRJQsk785Gf2tTlg3a3BC84iEdBg==
X-Google-Smtp-Source: AGHT+IGa2+n/kL5yHpIt+c14VdLJqa5M0PfowwbIe6llPlKW5ygTTklzFdMVZkC5IAHXYgOfOSzKgg==
X-Received: by 2002:a05:6870:a110:b0:220:dc43:f9f2 with SMTP id m16-20020a056870a11000b00220dc43f9f2mr9272891oae.38.1710206312947;
        Mon, 11 Mar 2024 18:18:32 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u13-20020a056a00124d00b006e58663dd0asm4944826pfi.110.2024.03.11.18.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 18:18:32 -0700 (PDT)
Date: Mon, 11 Mar 2024 18:18:31 -0700
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Bill Wendling <morbo@google.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Fangrui Song <maskray@google.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Guixiong Wei <guixiongwei@gmail.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jani Nikula <jani.nikula@intel.com>,
	Jingzi Meng <mengjingzi@iie.ac.cn>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <keescook@chromium.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	kernel test robot <lkp@intel.com>, linux-doc@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
	llvm@lists.linux.dev, Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Marco Elver <elver@google.com>, Mark Rutland <mark.rutland@arm.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Nicolas Schier <n.schier@avm.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Richard Weinberger <richard@nod.at>, Rich Felker <dalias@libc.org>,
	Sachin Sant <sachinp@linux.ibm.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	syzkaller <syzkaller@googlegroups.com>,
	Tanzir Hasan <tanzirh@google.com>,
	Tycho Andersen <tandersen@netflix.com>,
	Vasiliy Kovalev <kovalev@altlinux.org>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [GIT PULL] hardening updates for v6.9-rc1
Message-ID: <202403111702.828C918E55@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull these kernel hardening updates for v6.9-rc1. As is pretty
normal for this tree, there are changes all over the place, especially
for small fixes, selftest improvements, and improved macro usability.
Some header changes ended up landing via this tree as they depended on
the string header cleanups. Also, a notable set of changes is the work
for the reintroduction of the UBSAN signed integer overflow sanitizer
so that we can continue to make improvements on the compiler side to
make this sanitizer a more viable future security hardening option.

Everything has been in -next for a while, but there are a couple small
merge conflicts to deal with:

kbuild tree:
	https://lore.kernel.org/linux-next/20240226165811.56f71171@canb.auug.org.au/

bcachefs tree:
	https://lore.kernel.org/linux-next/20240301154351.1d097566@canb.auug.org.au/

Later in the merge window I intend to send some macro adjustment
collateral changes, but since they're mechanical, I figured it would be
simpler to wait for the end of -rc1.

Thanks!

-Kees

The following changes since commit 41bccc98fb7931d63d03f326a746ac4d429c1dd3:

  Linux 6.8-rc2 (2024-01-28 17:01:12 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.9-rc1

for you to fetch changes up to 3fe1eb4dd2e4b872ffb7b9b081b34ffcfa934ba7:

  selftests/powerpc: Fix load_unaligned_zeropad build failure (2024-03-05 10:29:15 -0800)

----------------------------------------------------------------
hardening updates for v6.9-rc1

- string.h and related header cleanups (Tanzir Hasan, Andy Shevchenko)

- VMCI memcpy() usage and struct_size() cleanups (Vasiliy Kovalev, Harshit
  Mogalapalli)

- selftests/powerpc: Fix load_unaligned_zeropad build failure (Michael
  Ellerman)

- hardened Kconfig fragment updates (Marco Elver, Lukas Bulwahn)

- Handle tail call optimization better in LKDTM (Douglas Anderson)

- Use long form types in overflow.h (Andy Shevchenko)

- Add flags param to string_get_size() (Andy Shevchenko)

- Add Coccinelle script for potential struct_size() use (Jacob Keller)

- Fix objtool corner case under KCFI (Josh Poimboeuf)

- Drop 13 year old backward compat CAP_SYS_ADMIN check (Jingzi Meng)

- Add str_plural() helper (Michal Wajdeczko, Kees Cook)

- Ignore relocations in .notes section

- Add comments to explain how __is_constexpr() works

- Fix m68k stack alignment expectations in stackinit Kunit test

- Convert string selftests to KUnit

- Add KUnit tests for fortified string functions

- Improve reporting during fortified string warnings

- Allow non-type arg to type_max() and type_min()

- Allow strscpy() to be called with only 2 arguments

- Add binary mode to leaking_addresses scanner

- Various small cleanups to leaking_addresses scanner

- Adding wrapping_*() arithmetic helper

- Annotate initial signed integer wrap-around in refcount_t

- Add explicit UBSAN section to MAINTAINERS

- Fix UBSAN self-test warnings

- Simplify UBSAN build via removal of CONFIG_UBSAN_SANITIZE_ALL

- Reintroduce UBSAN's signed overflow sanitizer

----------------------------------------------------------------
Andy Shevchenko (4):
      kernel.h: Move upper_*_bits() and lower_*_bits() to wordpart.h
      kernel.h: Move lib/cmdline.c prototypes to string.h
      overflow: Use POD in check_shl_overflow()
      lib/string_helpers: Add flags param to string_get_size()

Douglas Anderson (3):
      lkdtm: Make lkdtm_do_action() return to avoid tail call optimization
      lkdtm/bugs: Adjust lkdtm_HUNG_TASK() to avoid tail call optimization
      lkdtm/bugs: In lkdtm_HUNG_TASK() use BUG(), not BUG_ON(1)

Harshit Mogalapalli (2):
      VMCI: Use struct_size() in kmalloc()
      VMCI: Fix memcpy() run-time warning in dg_dispatch_as_host()

Jacob Keller (1):
      coccinelle: semantic patch to check for potential struct_size calls

Jingzi Meng (1):
      cap_syslog: remove CAP_SYS_ADMIN when dmesg_restrict

Josh Poimboeuf (1):
      objtool: Fix UNWIND_HINT_{SAVE,RESTORE} across basic blocks

Kees Cook (31):
      MAINTAINERS: Add UBSAN section
      ubsan: Use Clang's -fsanitize-trap=undefined option
      ubsan: Silence W=1 warnings in self-test
      ubsan: Remove CONFIG_UBSAN_SANITIZE_ALL
      ubsan: Reintroduce signed overflow sanitizer
      string: Redefine strscpy_pad() as a macro
      string: Allow 2-argument strscpy()
      string: Allow 2-argument strscpy_pad()
      um: Convert strscpy() usage to 2-argument style
      overflow: Adjust check_*_overflow() kern-doc to reflect results
      overflow: Introduce wrapping_add(), wrapping_sub(), and wrapping_mul()
      overflow: Introduce wrapping_assign_add() and wrapping_assign_sub()
      coccinelle: Add rules to find str_plural() replacements
      refcount: Annotated intentional signed integer wrap-around
      fortify: Split reporting and avoid passing string pointer
      fortify: Allow KUnit test to build without FORTIFY
      fortify: Provide KUnit counters for failure testing
      fortify: Add KUnit tests for runtime overflows
      fortify: Improve buffer overflow reporting
      MAINTAINERS: Update LEAKING_ADDRESSES details
      leaking_addresses: Use File::Temp for /tmp files
      leaking_addresses: Ignore input device status lines
      leaking_addresses: Provide mechanism to scan binary files
      sparc: vdso: Disable UBSAN instrumentation
      lib: stackinit: Adjust target string to 8 bytes for m68k
      x86, relocs: Ignore relocations in .notes section
      overflow: Allow non-type arg to type_max() and type_min()
      compiler.h: Explain how __is_constexpr() works
      sh: Fix build with CONFIG_UBSAN=y
      string: Convert selftest to KUnit
      string: Convert helpers selftest to KUnit

Lukas Bulwahn (2):
      hardening: drop obsolete UBSAN_SANITIZE_ALL from config fragment
      hardening: drop obsolete DRM_LEGACY from config fragment

Marco Elver (1):
      hardening: Enable KFENCE in the hardening config

Michael Ellerman (1):
      selftests/powerpc: Fix load_unaligned_zeropad build failure

Michal Wajdeczko (1):
      lib/string_choices: Add str_plural() helper

Tanzir Hasan (2):
      kernel.h: removed REPEAT_BYTE from kernel.h
      lib/string: shrink lib/string.i via IWYU

Vasiliy Kovalev (1):
      VMCI: Fix possible memcpy() run-time warning in vmci_datagram_invoke_guest_handler()

 Documentation/dev-tools/ubsan.rst                  |  28 +-
 MAINTAINERS                                        |  26 +-
 arch/arm/Kconfig                                   |   2 +-
 arch/arm/boot/compressed/misc.c                    |   2 +-
 arch/arm/boot/compressed/misc.h                    |   2 +-
 arch/arm/include/asm/word-at-a-time.h              |   3 +-
 arch/arm64/Kconfig                                 |   2 +-
 arch/arm64/include/asm/word-at-a-time.h            |   3 +-
 arch/mips/Kconfig                                  |   2 +-
 arch/parisc/Kconfig                                |   2 +-
 arch/powerpc/Kconfig                               |   2 +-
 arch/powerpc/include/asm/word-at-a-time.h          |   4 +-
 arch/riscv/Kconfig                                 |   2 +-
 arch/riscv/include/asm/word-at-a-time.h            |   3 +-
 arch/s390/Kconfig                                  |   2 +-
 arch/s390/include/asm/word-at-a-time.h             |   3 +-
 arch/sh/boot/compressed/Makefile                   |   1 +
 arch/sh/include/asm/word-at-a-time.h               |   2 +
 arch/sparc/vdso/Makefile                           |   1 +
 arch/um/drivers/net_kern.c                         |   2 +-
 arch/um/drivers/vector_kern.c                      |   2 +-
 arch/um/drivers/vector_user.c                      |   4 +-
 arch/um/include/shared/user.h                      |   3 +-
 arch/um/os-Linux/drivers/ethertap_user.c           |   2 +-
 arch/um/os-Linux/drivers/tuntap_user.c             |   2 +-
 arch/um/os-Linux/umid.c                            |   6 +-
 arch/x86/Kconfig                                   |   2 +-
 arch/x86/boot/compressed/misc.c                    |   2 +-
 arch/x86/include/asm/word-at-a-time.h              |   3 +-
 arch/x86/kvm/mmu/mmu.c                             |   1 +
 arch/x86/tools/relocs.c                            |   8 +
 drivers/misc/lkdtm/bugs.c                          |   3 +-
 drivers/misc/lkdtm/core.c                          |  22 +-
 drivers/misc/vmw_vmci/vmci_datagram.c              |  10 +-
 fs/namei.c                                         |   2 +-
 include/asm-generic/word-at-a-time.h               |   3 +-
 include/linux/compiler.h                           |  39 ++
 include/linux/compiler_types.h                     |   9 +-
 include/linux/fortify-string.h                     | 122 ++--
 include/linux/kernel.h                             |  44 +-
 include/linux/overflow.h                           | 115 +++-
 include/linux/refcount.h                           |   9 +-
 include/linux/string.h                             |  86 ++-
 include/linux/string_choices.h                     |  11 +
 include/linux/string_helpers.h                     |  10 +-
 include/linux/wordpart.h                           |  42 ++
 kernel/configs/hardening.config                    |   7 +-
 kernel/printk/printk.c                             |  11 -
 lib/Kconfig.debug                                  |  14 +-
 lib/Kconfig.ubsan                                  |  28 +-
 lib/Makefile                                       |   7 +-
 lib/fortify_kunit.c                                | 662 ++++++++++++++++++++-
 lib/overflow_kunit.c                               |  67 ++-
 lib/stackinit_kunit.c                              |  19 +-
 lib/string.c                                       |  23 +-
 lib/string_helpers.c                               |  89 ++-
 ...est-string_helpers.c => string_helpers_kunit.c} | 255 ++++----
 lib/string_kunit.c                                 | 199 +++++++
 lib/test_string.c                                  | 257 --------
 lib/test_ubsan.c                                   |  41 +-
 lib/ubsan.c                                        |  68 +++
 lib/ubsan.h                                        |   4 +
 scripts/Makefile.lib                               |   5 +-
 scripts/Makefile.ubsan                             |   5 +-
 scripts/coccinelle/api/string_choices.cocci        |  41 ++
 scripts/coccinelle/misc/struct_size.cocci          |  74 +++
 scripts/leaking_addresses.pl                       |  90 ++-
 tools/objtool/check.c                              |  12 +
 tools/objtool/noreturns.h                          |   2 +-
 .../selftests/powerpc/primitives/linux/bitops.h    |   0
 .../selftests/powerpc/primitives/linux/wordpart.h  |   1 +
 71 files changed, 1949 insertions(+), 688 deletions(-)
 create mode 100644 include/linux/wordpart.h
 rename lib/{test-string_helpers.c => string_helpers_kunit.c} (67%)
 create mode 100644 lib/string_kunit.c
 delete mode 100644 lib/test_string.c
 create mode 100644 scripts/coccinelle/api/string_choices.cocci
 create mode 100644 scripts/coccinelle/misc/struct_size.cocci
 create mode 100644 tools/testing/selftests/powerpc/primitives/linux/bitops.h
 create mode 120000 tools/testing/selftests/powerpc/primitives/linux/wordpart.h

-- 
Kees Cook


Return-Path: <linux-kernel+bounces-111809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01271887145
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 841A828227A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EA95D917;
	Fri, 22 Mar 2024 16:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxUuzewA"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035315D749
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 16:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711126368; cv=none; b=S2Wz7zNn54YRsH7Gx3OrwHqef89TQdFqNF6m8VwRgjPCEByGzS0bmgyt7ExUHlmu4w46sc1fiZXppHI7m0JSSPtH/E5empZuHZWVC/kEVjSiizj+NxGyz7/6IrMUZAhv+9XW4ld6UzDgfZh2pQvRuK3Xn5JtSOU/DzeIpNyomh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711126368; c=relaxed/simple;
	bh=hBqusfpeBkVmefE85XsEn17cxdE4qE4ZgKyCekh5dAA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gc4dWqv/b2OKIGN7sWw9OU9FbQxWjVfi/rzvYfhrnR8BQalbT4PzFWqeyVYdqdAhhoRBzE0jgyhjMF2kkHdZsEs1JsrsaS/+ilYjAOM2PgB2bUjHTdUzr40AYfqg1OzZHl4cvCSIrhuqPvsvHAtlYUldRUDkKtFdV+frztyHw6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NxUuzewA; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-789e4a4d3a5so160928885a.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711126365; x=1711731165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m4y5+0+oAQIlI43aDoNNcW7UyxGgy4flhCtXSAtWytQ=;
        b=NxUuzewAFQ8cxwAovxQTnsSmznZbSViSQMeER0wBRX+1eoVtmwHnnXaZLGmEcNM09W
         j5+xe6C/vztJnTgV9MSclltcEqQIFV6sKcO3VPRawQTAeTRWfl9epuauDtBGf2LyF2nU
         Iydn9oBYDYRm/jWgKdGgwFq9ozRBToXxI0ZcMz4xx9RG7a2CxLCDZaNeg5ToyFTZ1yQx
         uAEj+ebq9RjwTrgHhJS1KJWFG9Xzkj1WDZxjb5avEWrU16Q0Mq4i+g99RDLb+1R3Jm2n
         XuH62JvjYfioHKkOHawXJuID5C0aaoB2kHkL5UybcstzV2H2tgowOW3vMpvroGH1vxuZ
         ScuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711126365; x=1711731165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m4y5+0+oAQIlI43aDoNNcW7UyxGgy4flhCtXSAtWytQ=;
        b=qvvtto0phpMvV6Q17pQJSCYCG+99BWsKn34K/ACoS50S4TvSxFhxS0Wi9e4FO2qxUZ
         5cpDAlTne2vfXIDUBSwti/x2Jzgx1WozJJMcnQWEdpthicAlNMirHOppWINSF4meOI3o
         /noHPM4iumqBG5LToc0U/iiu9xZi+JGq5dxC1/aZnme3MQM6e/zizZbVkeyxX3cZ+8B4
         E4oFL+RhDSiBEhaFF3mipaDSXFAQn5HVXbI0T8QVHBk858Gu8E3tS6QhLbOgi72dl79W
         BzYGDrkWK6izq5TVEA4Kuv3A21RE4++UgkdG3Oqjfi87TFVfc+yPQSPutEDTXK9GRlsK
         X7mw==
X-Gm-Message-State: AOJu0YyzCZQkprqT5M13FLhB20hpCGLcDFQPO59F7mjwIqjoRIVZuUh8
	x90yvo3DNB/psR7/kAaYEIUQcZVCSs5uMQVojYsunEZmRE5BoglBUNlm2+s=
X-Google-Smtp-Source: AGHT+IGMTlHdS/diWd+UEtRVXGMX/0yVWwdUCsBrsa4OE2ABTq5Z2aHTKiyA62juTuVftq1d+3QDVA==
X-Received: by 2002:a05:620a:821f:b0:789:f14b:19c9 with SMTP id ow31-20020a05620a821f00b00789f14b19c9mr2947369qkn.70.1711126365030;
        Fri, 22 Mar 2024 09:52:45 -0700 (PDT)
Received: from citadel.lan (2600-6c4a-4d3f-6d5c-0000-0000-0000-1019.inf6.spectrum.com. [2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id j1-20020a37ef01000000b00789e9bbf962sm894901qkk.133.2024.03.22.09.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 09:52:44 -0700 (PDT)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	David.Laight@aculab.com,
	Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v4 00/16] x86-64: Stack protector and percpu improvements
Date: Fri, 22 Mar 2024 12:52:17 -0400
Message-ID: <20240322165233.71698-1-brgerst@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, x86-64 uses an unusual percpu layout, where the percpu section
is linked at absolute address 0.  The reason behind this is that older GCC
versions placed the stack protector (if enabled) at a fixed offset from the
GS segment base.  Since the GS segement is also used for percpu variables,
this forced the current layout.

GCC since version 8.1 supports a configurable location for the stack
protector value, which allows removal of the restriction on how the percpu
section is linked.  This allows the percpu section to be linked normally,
like other architectures.  In turn, this allows removal of code that was
needed to support the zero-based percpu section.

v4:
- Updated to current tip tree
- Added two new cleanups made possible by the removal of IA-64.
- Small improvements to the objtool conversion code.

Brian Gerst (16):
  x86/stackprotector/32: Remove stack protector test script
  x86/stackprotector/64: Remove stack protector test script
  x86/boot: Disable stack protector for early boot code
  x86/pvh: Use fixed_percpu_data for early boot GSBASE
  x86/relocs: Handle R_X86_64_REX_GOTPCRELX relocations
  objtool: Allow adding relocations to an existing section
  objtool: Convert fixed location stack protector accesses
  x86/stackprotector/64: Convert to normal percpu variable
  x86/percpu/64: Use relative percpu offsets
  x86/percpu/64: Remove fixed_percpu_data
  x86/boot/64: Remove inverse relocations
  x86/percpu/64: Remove INIT_PER_CPU macros
  percpu: Remove PER_CPU_FIRST_SECTION
  percpu: Remove PERCPU_VADDR()
  percpu: Remove __per_cpu_load
  kallsyms: Remove KALLSYMS_ABSOLUTE_PERCPU

 arch/x86/Kconfig                          |  16 +--
 arch/x86/Makefile                         |  21 ++--
 arch/x86/boot/compressed/misc.c           |  14 +--
 arch/x86/entry/entry_64.S                 |   2 +-
 arch/x86/include/asm/desc.h               |   1 -
 arch/x86/include/asm/percpu.h             |  22 ----
 arch/x86/include/asm/processor.h          |  28 +----
 arch/x86/include/asm/stackprotector.h     |  36 +-----
 arch/x86/kernel/Makefile                  |   2 +
 arch/x86/kernel/asm-offsets_64.c          |   6 -
 arch/x86/kernel/cpu/common.c              |   9 +-
 arch/x86/kernel/head64.c                  |   2 +-
 arch/x86/kernel/head_64.S                 |  20 ++-
 arch/x86/kernel/irq_64.c                  |   1 -
 arch/x86/kernel/setup_percpu.c            |  12 +-
 arch/x86/kernel/vmlinux.lds.S             |  35 ------
 arch/x86/platform/pvh/head.S              |  10 +-
 arch/x86/tools/relocs.c                   | 143 ++--------------------
 arch/x86/xen/xen-head.S                   |  10 +-
 include/asm-generic/sections.h            |   2 +-
 include/asm-generic/vmlinux.lds.h         |  43 +------
 include/linux/percpu-defs.h               |  12 --
 init/Kconfig                              |  11 +-
 kernel/kallsyms.c                         |  12 +-
 mm/percpu.c                               |   4 +-
 scripts/Makefile.lib                      |   2 +
 scripts/gcc-x86_32-has-stack-protector.sh |   8 --
 scripts/gcc-x86_64-has-stack-protector.sh |   4 -
 scripts/kallsyms.c                        |  80 +++---------
 scripts/link-vmlinux.sh                   |   4 -
 tools/objtool/arch/x86/decode.c           |  46 +++++++
 tools/objtool/arch/x86/special.c          |  91 ++++++++++++++
 tools/objtool/builtin-check.c             |   9 +-
 tools/objtool/check.c                     |  14 ++-
 tools/objtool/elf.c                       | 133 ++++++++++++++++----
 tools/objtool/include/objtool/arch.h      |   3 +
 tools/objtool/include/objtool/builtin.h   |   2 +
 tools/objtool/include/objtool/elf.h       |  90 +++++++++++---
 38 files changed, 442 insertions(+), 518 deletions(-)
 delete mode 100755 scripts/gcc-x86_32-has-stack-protector.sh
 delete mode 100755 scripts/gcc-x86_64-has-stack-protector.sh


base-commit: 30052fd948a3b43506c83590eaaada12d1f2dd09
-- 
2.44.0



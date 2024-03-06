Return-Path: <linux-kernel+bounces-94541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FAC874127
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4CFD1C208CE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91111143730;
	Wed,  6 Mar 2024 20:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWSqOQfG"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E564514039D;
	Wed,  6 Mar 2024 20:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709755548; cv=none; b=sBkMM/POXTVDWXlJ5mNYWKVyzYvLa2rAl2HgzlIh99de4drni743Zcnrv6h5ciVWcmIhg8uE/WvLVbjya9asd894xPN2DFHW7EKF2QZOISJZkZ6Q1IDAgQLhKz6cjyOyP+8JVYZrzgqlP8attdtfFmqkEEwXTBNP8OcCxGsudIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709755548; c=relaxed/simple;
	bh=S124P+mm3Kl3zFpQxSCsgU9NgXjbbAI2YP6sizbVbXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QAClAbdp1i5CHpL5g6X5fJYnRqpnOy8U76Vn+B2XJ+GEj+KvralEFk2p97r8N2AVpKBhjdUM7pUHUPWc8+hf8A7xhsKtAaPSdPm4BkqMbe4wamKCX+c1PAzddy6TIP2K4UlB9db8o63OuoqPbk1jjYeSYwP4fP+On2xr5AsqVJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWSqOQfG; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dc3b4b9b62so1261555ad.1;
        Wed, 06 Mar 2024 12:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709755546; x=1710360346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ESj7oVujXgrkYivCI2YmJM9UXLkhtSWs5CWgAIwkimU=;
        b=PWSqOQfGrV6YrNVkCHsI4YvRKQa4GSDg2vlk5MgjFpZrX1oTUJmbWZGAIhUq0gtPuj
         LTkxpjzUtAYC6Dr4UR45glXnNgQ4WxUwtOBgGwXuya26T+8EcEiu+vD4HiaxqGqQetku
         1vqX9zOiX9pUxQOjz8EP81HUU5Bs4pBg44kx74y6/72HH076vRz/yem/grrm4ZRVIP9e
         P2iiftS1AkACu7TiQOjdg8A7Z4t5HBYXaXviq2ybh5hEFHrLryOX9Mn1pIE5xla5FQw8
         HCoVsDrZSTHAkiScvPdOlkE8JCXZyfiCThkFln/JEHQrQOHJtDQWy63wg70fGtVfqm5G
         w6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709755546; x=1710360346;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ESj7oVujXgrkYivCI2YmJM9UXLkhtSWs5CWgAIwkimU=;
        b=PZIEWXa7yxwDDth02YB69Mx7+Y5kuMw4GR4qW4/7tGhU4vNn5jnQfJKcecqsAMlqyY
         VWSePK3UpJ39VmS8yLcCXgsVJv3KVu5Z1PhoSrSKR2ugD9LRIsVsDwjbJ6RNZiANV+c6
         RRZGKIRjZPFTntmqYZBwUKERyVIvGcmcW7b+KD3hWAy2m0NsUjA1hQZNCgbJLcW0KNzZ
         /bUT6r3gOo0ligGC4JG2DydA6d2eqmQrxLmTrb2CUSrbWKMnsNcak+IPzHFBOyOTJiXu
         yXGxEMLA1Jnp6jEwlUn8KlfvszdZm6b48EIcULS6pM5lbF58x4G1jczdfrqQOqs7jvlR
         6/jg==
X-Forwarded-Encrypted: i=1; AJvYcCVTE3TXNw+C3Y2+ZEFBVS7T7JQ4Qhb05pKcXeOhaoMozucXzjrdANZgc0Y7NRVJNItxBkaKivr9lXqrYdGHqsZBhjoaYJYKkQcnpHFhFm76t5fllGKiwRzno57zDafToJOTdQedqIXuUr1ER+Vh0OLZ4ogevd0LE6d4EqJPGa3I4Q==
X-Gm-Message-State: AOJu0YxMdrF1k57Y9aSBlJU0073AEkDiL0YawkuVoWLbihVPlNh9JAg8
	rv8gCyOf0L020xAdr5QaiAK1TOU6W196d3y3cOwyOVojmr2Va0EJ
X-Google-Smtp-Source: AGHT+IH6M31mE34Me8SM21tMS8XfhsE3dhmJ1lHuJdEN16FIegxlJS+I/Wfc5klC7Ry9QFJHthE2CA==
X-Received: by 2002:a17:902:e887:b0:1dc:cc0c:a29f with SMTP id w7-20020a170902e88700b001dccc0ca29fmr1736695plg.4.1709755545642;
        Wed, 06 Mar 2024 12:05:45 -0800 (PST)
Received: from mozart.vkv.me ([192.184.166.229])
        by smtp.gmail.com with ESMTPSA id n15-20020a170902e54f00b001dcfc88ccf6sm8869341plf.263.2024.03.06.12.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 12:05:45 -0800 (PST)
From: Calvin Owens <jcalvinowens@gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen.n.rao@linux.ibm.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	David S Miller <davem@davemloft.net>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Calvin Owens <jcalvinowens@gmail.com>,
	bpf@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 0/4] Make bpf_jit and kprobes work with CONFIG_MODULES=n
Date: Wed,  6 Mar 2024 12:05:07 -0800
Message-ID: <cover.1709676663.git.jcalvinowens@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello all,

This patchset makes it possible to use bpftrace with kprobes on kernels
built without loadable module support.

On a Raspberry Pi 4b, this saves about 700KB of memory where BPF is
needed but loadable module support is not. These two kernels had
identical configurations, except CONFIG_MODULE was off in the second:

   - Linux version 6.8.0-rc7
   - Memory: 3330672K/4050944K available (16576K kernel code, 2390K rwdata,
   - 12364K rodata, 5632K init, 675K bss, 195984K reserved, 524288K cma-reserved)
   + Linux version 6.8.0-rc7-00003-g2af01251ca21
   + Memory: 3331400K/4050944K available (16512K kernel code, 2384K rwdata,
   + 11728K rodata, 5632K init, 673K bss, 195256K reserved, 524288K cma-reserved)

I don't intend to present an exhaustive list of !MODULES usecases, since
I'm sure there are many I'm not aware of. Performance is a common one,
the primary justification being that static text is mapped on hugepages
and module text is not. Security is another, since rootkits are much
harder to implement without modules.

The first patch is the interesting one: it moves module_alloc() into its
own file with its own Kconfig option, so it can be utilized even when
loadable module support is disabled. I got the idea from an unmerged
patch from a few years ago I found on lkml (see [1/4] for details). I
think this also has value in its own right, since I suspect there are
potential users beyond bpf, hopefully we will hear from some.

Patches 2-3 are proofs of concept to demonstrate the first patch is
sufficient to achieve my goal (full ebpf functionality without modules).

Patch 4 adds a new "-n" argument to vmtest.sh to run the BPF selftests
without modules, so the prior three patches can be rigorously tested.

If something like the first patch were to eventually be merged, the rest
could go through the normal bpf-next process as I clean them up: I've
only based them on Linus' tree and combined them into a series here to
introduce the idea.

If you prefer to fetch the patches via git:

  [1/4] https://github.com/jcalvinowens/linux.git work/module-alloc
 +[2/4]+[3/4] https://github.com/jcalvinowens/linux.git work/nomodule-bpf
 +[4/4] https://github.com/jcalvinowens/linux.git testing/nomodule-bpf-ci

In addition to the automated BPF selftests, I've lightly tested this on
my laptop (x86_64), a Raspberry Pi 4b (arm64), and a Raspberry Pi Zero W
(arm). The other architectures have only been compile tested.

I didn't want to spam all the arch maintainers with what I expect will
be a discussion mostly about modules and bpf, so I've left them off this
first submission. I will be sure to add them on future submissions of
the first patch. Of course, feedback on the arch bits is welcome here.

In addition to feedback on the patches themselves, I'm interested in
hearing from anybody else who might find this functionality useful.

Thanks,
Calvin


Calvin Owens (4):
  module: mm: Make module_alloc() generally available
  bpf: Allow BPF_JIT with CONFIG_MODULES=n
  kprobes: Allow kprobes with CONFIG_MODULES=n
  selftests/bpf: Support testing the !MODULES case

 arch/Kconfig                                  |   4 +-
 arch/arm/kernel/module.c                      |  35 -----
 arch/arm/mm/Makefile                          |   2 +
 arch/arm/mm/module_alloc.c                    |  40 ++++++
 arch/arm64/kernel/module.c                    | 127 -----------------
 arch/arm64/mm/Makefile                        |   1 +
 arch/arm64/mm/module_alloc.c                  | 130 ++++++++++++++++++
 arch/loongarch/kernel/module.c                |   6 -
 arch/loongarch/mm/Makefile                    |   2 +
 arch/loongarch/mm/module_alloc.c              |  10 ++
 arch/mips/kernel/module.c                     |  10 --
 arch/mips/mm/Makefile                         |   2 +
 arch/mips/mm/module_alloc.c                   |  13 ++
 arch/nios2/kernel/module.c                    |  20 ---
 arch/nios2/mm/Makefile                        |   2 +
 arch/nios2/mm/module_alloc.c                  |  22 +++
 arch/parisc/kernel/module.c                   |  12 --
 arch/parisc/mm/Makefile                       |   1 +
 arch/parisc/mm/module_alloc.c                 |  15 ++
 arch/powerpc/kernel/module.c                  |  36 -----
 arch/powerpc/mm/Makefile                      |   1 +
 arch/powerpc/mm/module_alloc.c                |  41 ++++++
 arch/riscv/kernel/module.c                    |  11 --
 arch/riscv/mm/Makefile                        |   1 +
 arch/riscv/mm/module_alloc.c                  |  17 +++
 arch/s390/kernel/module.c                     |  37 -----
 arch/s390/mm/Makefile                         |   1 +
 arch/s390/mm/module_alloc.c                   |  42 ++++++
 arch/sparc/kernel/module.c                    |  31 -----
 arch/sparc/mm/Makefile                        |   2 +
 arch/sparc/mm/module_alloc.c                  |  31 +++++
 arch/x86/kernel/ftrace.c                      |   2 +-
 arch/x86/kernel/module.c                      |  56 --------
 arch/x86/mm/Makefile                          |   2 +
 arch/x86/mm/module_alloc.c                    |  59 ++++++++
 fs/proc/kcore.c                               |   2 +-
 include/trace/events/bpf_testmod.h            |   1 +
 kernel/bpf/Kconfig                            |  11 +-
 kernel/bpf/Makefile                           |   2 +
 kernel/bpf/bpf_struct_ops.c                   |  28 +++-
 kernel/bpf/bpf_testmod/Makefile               |   1 +
 kernel/bpf/bpf_testmod/bpf_testmod.c          |   1 +
 kernel/bpf/bpf_testmod/bpf_testmod.h          |   1 +
 kernel/bpf/bpf_testmod/bpf_testmod_kfunc.h    |   1 +
 kernel/kprobes.c                              |  22 +++
 kernel/module/Kconfig                         |   1 +
 kernel/module/main.c                          |  17 ---
 kernel/trace/trace_kprobe.c                   |  11 ++
 mm/Kconfig                                    |   3 +
 mm/Makefile                                   |   1 +
 mm/module_alloc.c                             |  21 +++
 mm/vmalloc.c                                  |   2 +-
 net/bpf/test_run.c                            |   2 +
 tools/testing/selftests/bpf/Makefile          |  28 ++--
 .../selftests/bpf/bpf_testmod/Makefile        |   2 +-
 .../bpf/bpf_testmod/bpf_testmod-events.h      |   6 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |   4 +
 .../bpf/bpf_testmod/bpf_testmod_kfunc.h       |   2 +
 tools/testing/selftests/bpf/config            |   5 -
 tools/testing/selftests/bpf/config.mods       |   5 +
 tools/testing/selftests/bpf/config.nomods     |   1 +
 .../selftests/bpf/progs/btf_type_tag_percpu.c |   2 +
 .../selftests/bpf/progs/btf_type_tag_user.c   |   2 +
 tools/testing/selftests/bpf/progs/core_kern.c |   2 +
 .../selftests/bpf/progs/iters_testmod_seq.c   |   2 +
 .../bpf/progs/test_core_reloc_module.c        |   2 +
 .../selftests/bpf/progs/test_ldsx_insn.c      |   2 +
 .../selftests/bpf/progs/test_module_attach.c  |   3 +
 .../selftests/bpf/progs/tracing_struct.c      |   2 +
 tools/testing/selftests/bpf/testing_helpers.c |  14 ++
 tools/testing/selftests/bpf/vmtest.sh         |  24 +++-
 71 files changed, 636 insertions(+), 424 deletions(-)
 create mode 100644 arch/arm/mm/module_alloc.c
 create mode 100644 arch/arm64/mm/module_alloc.c
 create mode 100644 arch/loongarch/mm/module_alloc.c
 create mode 100644 arch/mips/mm/module_alloc.c
 create mode 100644 arch/nios2/mm/module_alloc.c
 create mode 100644 arch/parisc/mm/module_alloc.c
 create mode 100644 arch/powerpc/mm/module_alloc.c
 create mode 100644 arch/riscv/mm/module_alloc.c
 create mode 100644 arch/s390/mm/module_alloc.c
 create mode 100644 arch/sparc/mm/module_alloc.c
 create mode 100644 arch/x86/mm/module_alloc.c
 create mode 120000 include/trace/events/bpf_testmod.h
 create mode 100644 kernel/bpf/bpf_testmod/Makefile
 create mode 120000 kernel/bpf/bpf_testmod/bpf_testmod.c
 create mode 120000 kernel/bpf/bpf_testmod/bpf_testmod.h
 create mode 120000 kernel/bpf/bpf_testmod/bpf_testmod_kfunc.h
 create mode 100644 mm/module_alloc.c
 create mode 100644 tools/testing/selftests/bpf/config.mods
 create mode 100644 tools/testing/selftests/bpf/config.nomods

-- 
2.43.0



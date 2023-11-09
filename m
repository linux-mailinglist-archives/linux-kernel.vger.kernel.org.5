Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABFCD7E618B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 01:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbjKIAnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 19:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjKIAnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 19:43:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC777C6;
        Wed,  8 Nov 2023 16:43:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF486C433C7;
        Thu,  9 Nov 2023 00:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699490618;
        bh=Pc9caaey7aHM7qDFPo67u9OP06WjqgJKiis0yYkxtEo=;
        h=From:To:Cc:Subject:Date:From;
        b=QvNtqecZLEG36r7OUjMTHtHT0nk+RcYvspPKJ5ODKiAql8/K1UnHG5f4AzwYfIsZN
         eNXKcCs8zhEYaVmWocXHQmgYjpfDcT8Vnuor3Gh3PP8s7TT3guiZO8WWB59lEh2Vck
         Yu/52a0vZ5bWxZ6EKmqi1Q2B88baanD1NflpHB4AS4aVJN5cZw7g6W87N+YgznI2qp
         pFHMJTQy1QTtJpzP07z+zDy96wGHT23MJPMBPsRl/fq6lCeT822+svGFV181UjQDKR
         WjaCuzjtlHNcB+znwzW2MZ4UIOapOuxZnNvWKMyFwIOUb2TNjsM3jOYSztZd5uM94l
         8QEcCDETcw2Tw==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Indu Bhagat <indu.bhagat@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-toolchains@vger.kernel.org
Subject: [PATCH RFC 00/10] perf: user space sframe unwinding
Date:   Wed,  8 Nov 2023 16:41:05 -0800
Message-ID: <cover.1699487758.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some distros have started compiling frame pointers into all their
packages to enable the kernel to do system-wide profiling of user space.
Unfortunately that creates a runtime performance penalty across the
entire system.  Using DWARF (or .eh_frame) instead isn't feasible
because of complexity and slowness.

For in-kernel unwinding we solved this problem with the creation of the
ORC unwinder for x86_64.  Similarly, for user space the GNU assembler
has created the SFrame ("Simple Frame") format starting with binutils
2.40.

These patches add support for unwinding user space from the kernel using
SFrame with perf.  It should be easy to add user unwinding support for
other components like ftrace.

I tested it on Gentoo by recompiling everything with -Wa,-gsframe and
using a custom glibc patch (which I'll send in a reply to this email).

The unwinding itself seems to work well, though I still have a major
problem: how to tell perf tool to stitch together the separate
kernel+user callchains into a single event?

Right now I have a hack which somehow causes perf tool to overwrite the
kernel callchain with the user one.  I'm perf-clueless, any ideas or
patches for a clean way to implement that would be most helpful.


Otherwise there were two main challenges:

1) Finding .sframe sections in shared/dlopened libraries

   The kernel has no visibility to the contents of shared libraries.
   This was solved by adding a PR_ADD_SFRAME option to prctl() which
   allows the runtime linker to manually provide the in-memory address
   of an .sframe section to the kernel.

2) Dealing with page faults

   Keeping all binaries' sframe data pinned would likely waste a lot of
   memory.  Instead, read it from user space on demand.  That can't be
   done from perf NMI context due to page faults, so defer the unwind to
   the next user exit.  Since the NMI handler doesn't do exit work,
   self-IPI and then schedule task work to be run on exit from the IPI.


Special thanks to Indu for the original concept, and to Steven and Peter
for helping a lot with the design.  And to Steven for letting me do it ;-)


TODO:
- Stitch kernel+user events together in perf tool (help needed)
- Add arm64 support
- Add VDSO .sframe support
- Allow specifying FP vs sframe from perf tool?  Right now it's
  auto-detected, maybe that's enough
- Port ftrace and others to use sframe
- Support sframe v2
- Determine the impact of missing DRAP support (aligned stacks which
  SFrame doesn't currently support)
- Add debugging hooks



Josh Poimboeuf (10):
  perf: Remove get_perf_callchain() 'init_nr' argument
  perf: Remove get_perf_callchain() 'crosstask' argument
  perf: Simplify get_perf_callchain() user logic
  perf: Introduce deferred user callchains
  perf/x86: Add HAVE_PERF_CALLCHAIN_DEFERRED
  unwind: Introduce generic user space unwinding interfaces
  unwind/x86: Add HAVE_USER_UNWIND
  perf/x86: Use user_unwind interface
  unwind: Introduce SFrame user space unwinding
  unwind/x86/64: Add HAVE_USER_UNWIND_SFRAME

 arch/Kconfig                       |   9 +
 arch/x86/Kconfig                   |   3 +
 arch/x86/events/core.c             |  65 ++---
 arch/x86/include/asm/mmu.h         |   2 +-
 arch/x86/include/asm/user_unwind.h |  11 +
 fs/binfmt_elf.c                    |  46 +++-
 include/linux/mm_types.h           |   3 +
 include/linux/perf_event.h         |  24 +-
 include/linux/sframe.h             |  46 ++++
 include/linux/user_unwind.h        |  33 +++
 include/uapi/linux/elf.h           |   1 +
 include/uapi/linux/perf_event.h    |   1 +
 include/uapi/linux/prctl.h         |   3 +
 kernel/Makefile                    |   1 +
 kernel/bpf/stackmap.c              |   6 +-
 kernel/events/callchain.c          |  39 ++-
 kernel/events/core.c               |  96 ++++++-
 kernel/fork.c                      |  10 +
 kernel/sys.c                       |  11 +
 kernel/unwind/Makefile             |   2 +
 kernel/unwind/sframe.c             | 414 +++++++++++++++++++++++++++++
 kernel/unwind/sframe.h             | 217 +++++++++++++++
 kernel/unwind/user.c               |  86 ++++++
 mm/init-mm.c                       |   2 +
 24 files changed, 1060 insertions(+), 71 deletions(-)
 create mode 100644 arch/x86/include/asm/user_unwind.h
 create mode 100644 include/linux/sframe.h
 create mode 100644 include/linux/user_unwind.h
 create mode 100644 kernel/unwind/Makefile
 create mode 100644 kernel/unwind/sframe.c
 create mode 100644 kernel/unwind/sframe.h
 create mode 100644 kernel/unwind/user.c

-- 
2.41.0


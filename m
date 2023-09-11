Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7B179BA3A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347997AbjIKVZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238208AbjIKNuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:50:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD40F5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:50:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5559CC433C8;
        Mon, 11 Sep 2023 13:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694440214;
        bh=cdL4F45X7q2eDDQEefXsRxpzbifuY4pqd5j0vvnyMXU=;
        h=Date:From:To:Cc:Subject:From;
        b=hH08iKAb8nHZh9822TQ+swNGt7bVfUBKEhcZkk75UWtWF4YQbpyvWaRj+hlvnskAp
         TeB8nWR0YslN1o5dUzw0dqHs1+27U7KKRXaMv2yWZxRw2Ko3/ljZozpPDBA2lrcp/n
         Y5CIDvOnSDLJlFWVCON7lt5tOgIq4oPhf1zFxiJl4OerwCp+mMizsxKR1DOZ8auAJS
         /lp22NX0M/8JgyV0KRCBjBndls623svRYaVTU+GdL9m9XNOMfx9j5BHWYNF3IMTF0I
         BjErsCnFJ2lOtx76cC6u3QZjdHQnsnFqwZb9r3WkvYHA5ft9Wl/lz8zDpwsmW/1VuI
         HjjH3jGwfBS4A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 20CA8403F4; Mon, 11 Sep 2023 10:50:11 -0300 (-03)
Date:   Mon, 11 Sep 2023 10:50:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Christian Brauner <brauner@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH 1/1 fyi] tools headers UAPI: Sync files changed by new
 fchmod2 and map_shadow_stack syscalls with the kernel sources
Message-ID: <ZP8bE7aXDBu/drak@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tldr; Just FYI, I'm carrying this on the perf tools tree.

- Arnaldo

Full explanation:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

The way these headers are used in perf are not restricted to just
including them to compile something.

There are sometimes used in scripts that convert defines into string
tables, etc, so some change may break one of these scripts, or new MSRs
may use some different #define pattern, etc.

E.g.:

  $ ls -1 tools/perf/trace/beauty/*.sh | head -5
  tools/perf/trace/beauty/arch_errno_names.sh
  tools/perf/trace/beauty/drm_ioctl.sh
  tools/perf/trace/beauty/fadvise.sh
  tools/perf/trace/beauty/fsconfig.sh
  tools/perf/trace/beauty/fsmount.sh
  $
  $ tools/perf/trace/beauty/fadvise.sh
  static const char *fadvise_advices[] = {
  	[0] = "NORMAL",
  	[1] = "RANDOM",
  	[2] = "SEQUENTIAL",
  	[3] = "WILLNEED",
  	[4] = "DONTNEED",
  	[5] = "NOREUSE",
  };
  $

The tools/perf/check-headers.sh script, part of the tools/ build
process, points out changes in the original files.

So its important not to touch the copies in tools/ when doing changes in
the original kernel headers, that will be done later, when
check-headers.sh inform about the change to the perf tools hackers.

---

To pick the changes in these csets:

  c35559f94ebc3e3b ("x86/shstk: Introduce map_shadow_stack syscall")
  78252deb023cf087 ("arch: Register fchmodat2, usually as syscall 452")

That add support for this new syscall in tools such as 'perf trace'.

For instance, this is now possible:

  # perf trace -v -e fchmodat*,map_shadow_stack --max-events=4
  Using CPUID AuthenticAMD-25-21-0
  Reusing "openat" BPF sys_enter augmenter for "fchmodat"
  event qualifier tracepoint filter: (common_pid != 3499340 && common_pid != 11259) && (id == 268 || id == 452 || id == 453)
  ^C#

  And it'll work as with other syscalls, for instance openat:

  # perf trace -e openat* --max-events=4
     0.000 ( 0.015 ms): systemd-oomd/1150 openat(dfd: CWD, filename: "/proc/meminfo", flags: RDONLY|CLOEXEC)    = 11
     0.068 ( 0.019 ms): systemd-oomd/1150 openat(dfd: CWD, filename: "/sys/fs/cgroup/user.slice/user-1001.slice/user@1001.service/memory.pressure", flags: RDONLY|CLOEXEC) = 11
     0.119 ( 0.008 ms): systemd-oomd/1150 openat(dfd: CWD, filename: "/sys/fs/cgroup/user.slice/user-1001.slice/user@1001.service/memory.current", flags: RDONLY|CLOEXEC) = 11
     0.138 ( 0.006 ms): systemd-oomd/1150 openat(dfd: CWD, filename: "/sys/fs/cgroup/user.slice/user-1001.slice/user@1001.service/memory.min", flags: RDONLY|CLOEXEC) = 11
  #

That is the filter expression attached to the raw_syscalls:sys_{enter,exit}
tracepoints.

  $ find tools/perf/arch/ -name "syscall*tbl" | xargs grep -E fchmodat\|sys_map_shadow_stack
  tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl:258	n64	fchmodat			sys_fchmodat
  tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl:452	n64	fchmodat2			sys_fchmodat2
  tools/perf/arch/powerpc/entry/syscalls/syscall.tbl:297	common	fchmodat			sys_fchmodat
  tools/perf/arch/powerpc/entry/syscalls/syscall.tbl:452	common	fchmodat2			sys_fchmodat2
  tools/perf/arch/s390/entry/syscalls/syscall.tbl:299  common	fchmodat		sys_fchmodat			sys_fchmodat
  tools/perf/arch/s390/entry/syscalls/syscall.tbl:452  common	fchmodat2		sys_fchmodat2			sys_fchmodat2
  tools/perf/arch/x86/entry/syscalls/syscall_64.tbl:268	common	fchmodat		sys_fchmodat
  tools/perf/arch/x86/entry/syscalls/syscall_64.tbl:452	common	fchmodat2		sys_fchmodat2
  tools/perf/arch/x86/entry/syscalls/syscall_64.tbl:453	64	map_shadow_stack	sys_map_shadow_stack
  $

  $ grep -Ew map_shadow_stack\|fchmodat2 /tmp/build/perf-tools/arch/x86/include/generated/asm/syscalls_64.c
	[452] = "fchmodat2",
	[453] = "map_shadow_stack",
  $

This addresses these perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/include/uapi/asm-generic/unistd.h include/uapi/asm-generic/unistd.h
    diff -u tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry/syscalls/syscall_64.tbl
    diff -u tools/perf/arch/powerpc/entry/syscalls/syscall.tbl arch/powerpc/kernel/syscalls/syscall.tbl
    diff -u tools/perf/arch/s390/entry/syscalls/syscall.tbl arch/s390/kernel/syscalls/syscall.tbl
    diff -u tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl arch/mips/kernel/syscalls/syscall_n64.tbl

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/asm-generic/unistd.h             | 5 ++++-
 tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl | 1 +
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl  | 1 +
 tools/perf/arch/s390/entry/syscalls/syscall.tbl     | 1 +
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl   | 2 ++
 5 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index fd6c1cb585db43c4..abe087c53b4b0434 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -820,8 +820,11 @@ __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
 #define __NR_cachestat 451
 __SYSCALL(__NR_cachestat, sys_cachestat)
 
+#define __NR_fchmodat2 452
+__SYSCALL(__NR_fchmodat2, sys_fchmodat2)
+
 #undef __NR_syscalls
-#define __NR_syscalls 452
+#define __NR_syscalls 453
 
 /*
  * 32 bit systems traditionally used different
diff --git a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
index cfda2511badf3ad0..cb5e757f6621c885 100644
--- a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
+++ b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
@@ -366,3 +366,4 @@
 449	n64	futex_waitv			sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	n64	cachestat			sys_cachestat
+452	n64	fchmodat2			sys_fchmodat2
diff --git a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
index 8c0b08b7a80ec4b7..20e50586e8a26c34 100644
--- a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
@@ -538,3 +538,4 @@
 449	common  futex_waitv                     sys_futex_waitv
 450 	nospu	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
+452	common	fchmodat2			sys_fchmodat2
diff --git a/tools/perf/arch/s390/entry/syscalls/syscall.tbl b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
index a6935af2235cab6c..0122cc156952cf55 100644
--- a/tools/perf/arch/s390/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
@@ -454,3 +454,4 @@
 449  common	futex_waitv		sys_futex_waitv			sys_futex_waitv
 450  common	set_mempolicy_home_node	sys_set_mempolicy_home_node	sys_set_mempolicy_home_node
 451  common	cachestat		sys_cachestat			sys_cachestat
+452  common	fchmodat2		sys_fchmodat2			sys_fchmodat2
diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
index 227538b0ce801eeb..1d6eee30eceb22ab 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
@@ -373,6 +373,8 @@
 449	common	futex_waitv		sys_futex_waitv
 450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
 451	common	cachestat		sys_cachestat
+452	common	fchmodat2		sys_fchmodat2
+453	64	map_shadow_stack	sys_map_shadow_stack
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
-- 
2.37.1


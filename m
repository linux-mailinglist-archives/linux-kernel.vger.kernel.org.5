Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBAAB7D69F7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 13:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbjJYLXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 07:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234479AbjJYLXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 07:23:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F0D130
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 04:23:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2699CC433C8;
        Wed, 25 Oct 2023 11:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698232988;
        bh=rd8vsu6VohhU/lcsgpXqdi7nIrZyR6h4n0YxnC1/pQM=;
        h=Date:From:To:Cc:Subject:From;
        b=eC7a/rJ18UcEM9fHbpovUo0TkOPNGQdPNEJfnTsSh2Pm0hVznbAoxo93mM8m3YxS/
         rq7p7v7Tw9AFPoKraGX6w/50zZ5zfSsFEbtbC/2x+bODvR+lxL/2Wv5QeAfb+DdW1Z
         8u7N3cyX7mu91uOzpt4wnuxsGVT5xa5je7BZIh4egeIAKLVfuGP9NnGI/LT5X/tRGl
         aAvkFJLJphftUJlqpeeEQYjtUTsl8yLP+HZiup7pggGhubPpzdvh06ELROUSTrAHYJ
         RfG3kypUaPYi6bUn2PpJyKKidP/udKN0fs1XgW2DXSbL9wAk/afOumyYDO4RC+yx0W
         VN2EROU/1lw2w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 42EC74035D; Wed, 25 Oct 2023 08:23:05 -0300 (-03)
Date:   Wed, 25 Oct 2023 08:23:05 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] perf build: Address stray '\' before # that is warned
 about since grep 3.8
Message-ID: <ZTj6mfM9UqY2DggC@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To address this grep 3.8 warning:

  grep: warning: stray \ before #

We needed to remove the '' around the grep expression and keep the \
before # so that it is escaped by the $(shell grep ...) and thus doesn't
get to grep.

We need that \ before the #, otherwise we get this:

  Makefile.perf:364: *** unterminated call to function 'shell': missing ')'.  Stop.

As everything after the # will be considered a comment.

Removing the single quotes needs some more escaping so that _some_ of
the escaped chars gets to grep, like the '\|' that becomes '\\\|´.

Running on debian:10, where there is no libtraceevent-devel available,
we get:

  Makefile.perf:367: *** PYTHON_EXT_SRCS= util/python.c ../lib/ctype.c util/cap.c util/evlist.c util/evsel.c util/evsel_fprintf.c util/perf_event_attr_fprintf.c util/cpumap.c util/memswap.c util/mmap.c util/namespaces.c ../lib/bitmap.c ../lib/find_bit.c ../lib/list_sort.c ../lib/hweight.c ../lib/string.c ../lib/vsprintf.c util/thread_map.c util/util.c util/cgroup.c util/parse-branch-options.c util/rblist.c util/counts.c util/print_binary.c util/strlist.c ../lib/rbtree.c util/string.c util/symbol_fprintf.c util/units.c util/affinity.c util/rwsem.c util/hashmap.c util/perf_regs.c util/fncache.c util/perf-regs-arch/perf_regs_aarch64.c util/perf-regs-arch/perf_regs_arm.c util/perf-regs-arch/perf_regs_csky.c util/perf-regs-arch/perf_regs_loongarch.c util/perf-regs-arch/perf_regs_mips.c util/perf-regs-arch/perf_regs_powerpc.c util/perf-regs-arch/perf_regs_riscv.c util/perf-regs-arch/perf_regs_s390.c util/perf-regs-arch/perf_regs_x86.c.  Stop.
  make[1]: *** [Makefile.perf:242: sub-make] Error 2

I.e. both the comments and the util/trace-event.c were removed.

When using:

msg := $(error PYTHON_EXT_SRCS=$(PYTHON_EXT_SRCS))

While on the more recent fedora:38, with the new grep and make packages
and libtraceevent-devel installed:

  Makefile.perf:367: *** PYTHON_EXT_SRCS= util/python.c ../lib/ctype.c util/cap.c util/evlist.c util/evsel.c util/evsel_fprintf.c util/perf_event_attr_fprintf.c util/cpumap.c util/memswap.c util/mmap.c util/namespaces.c ../lib/bitmap.c ../lib/find_bit.c ../lib/list_sort.c ../lib/hweight.c ../lib/string.c ../lib/vsprintf.c util/thread_map.c util/util.c util/cgroup.c util/parse-branch-options.c util/rblist.c util/counts.c util/print_binary.c util/strlist.c util/trace-event.c ../lib/rbtree.c util/string.c util/symbol_fprintf.c util/units.c util/affinity.c util/rwsem.c util/hashmap.c util/perf_regs.c util/fncache.c util/perf-regs-arch/perf_regs_aarch64.c util/perf-regs-arch/perf_regs_arm.c util/perf-regs-arch/perf_regs_csky.c util/perf-regs-arch/perf_regs_loongarch.c util/perf-regs-arch/perf_regs_mips.c util/perf-regs-arch/perf_regs_powerpc.c util/perf-regs-arch/perf_regs_riscv.c util/perf-regs-arch/perf_regs_s390.c util/perf-regs-arch/perf_regs_x86.c.  Stop.
  make[1]: *** [Makefile.perf:242: sub-make] Error 2
  make: *** [Makefile:113: install-bin] Error 2
  make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
  $

I.e. only the comments were removed.

If we build it on the same fedora:38 system, but using NO_LIBTRACEEVENT=1

  $ make NO_LIBTRACEEVENT=1 CORESIGHT=1 O=/tmp/build/$(basename $PWD) -C tools/perf install-bin
  Makefile.perf:367: *** PYTHON_EXT_SRCS= util/python.c ../lib/ctype.c util/cap.c util/evlist.c util/evsel.c util/evsel_fprintf.c util/perf_event_attr_fprintf.c util/cpumap.c util/memswap.c util/mmap.c util/namespaces.c ../lib/bitmap.c ../lib/find_bit.c ../lib/list_sort.c ../lib/hweight.c ../lib/string.c ../lib/vsprintf.c util/thread_map.c util/util.c util/cgroup.c util/parse-branch-options.c util/rblist.c util/counts.c util/print_binary.c util/strlist.c ../lib/rbtree.c util/string.c util/symbol_fprintf.c util/units.c util/affinity.c util/rwsem.c util/hashmap.c util/perf_regs.c util/fncache.c util/perf-regs-arch/perf_regs_aarch64.c util/perf-regs-arch/perf_regs_arm.c util/perf-regs-arch/perf_regs_csky.c util/perf-regs-arch/perf_regs_loongarch.c util/perf-regs-arch/perf_regs_mips.c util/perf-regs-arch/perf_regs_powerpc.c util/perf-regs-arch/perf_regs_riscv.c util/perf-regs-arch/perf_regs_s390.c util/perf-regs-arch/perf_regs_x86.c.  Stop.
  make[1]: *** [Makefile.perf:242: sub-make] Error 2
  make: *** [Makefile:113: install-bin] Error 2
  make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
  $

Both comments and the util/trace-event.c file removed.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 456872ac410df4c0..d80dcaa5a1e337ae 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -361,7 +361,7 @@ python-clean := $(call QUIET_CLEAN, python) $(RM) -r $(PYTHON_EXTBUILD) $(OUTPUT
 ifeq ($(CONFIG_LIBTRACEEVENT),y)
   PYTHON_EXT_SRCS := $(shell grep -v ^\# util/python-ext-sources)
 else
-  PYTHON_EXT_SRCS := $(shell grep -v '^\#\|util/trace-event.c' util/python-ext-sources)
+  PYTHON_EXT_SRCS := $(shell grep -v ^\#\\\|util/trace-event.c util/python-ext-sources)
 endif
 
 PYTHON_EXT_DEPS := util/python-ext-sources util/setup.py $(LIBAPI)
-- 
2.41.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2217D9B04
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346111AbjJ0OTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346080AbjJ0OS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:18:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B687CC
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 07:18:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA01C433C7;
        Fri, 27 Oct 2023 14:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698416333;
        bh=QA/EzngEcjKiHw3G2Xgs28uFBBDEG7gMt/kOCgWKK0g=;
        h=Date:From:To:Cc:Subject:From;
        b=h3Y1SWY6TdxTJEd1qTFAa/PZsMR43/bJM9GhhdOHKQHIreUMLM+vsfacgPZVu6WEL
         XKvO0346rylCeYEKOmO3Waa+L7+jYHcOworeSqrccDyJFbMX/al46jrkUWQROrUNtH
         KCNlEeaNuXSoXHXjgSeCeEnOd8Y1Aa+MP387zFE7b9eYgCLasOU6b9C9sm3UfPaSQL
         HsPk4+wd6Ch7ohD/G1bjx7oJdaHbBEaqOhY5UiQTmLQagG67FtFC4cwzhiFyNn2UWw
         jC9EjQJq8ARaJypawj4ogUVJsrxMdlZNtG81ekgvQE2SlEUumzP6cD0IbisQvMZUwM
         WwW/UkFgBnAOw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5AE264035D; Fri, 27 Oct 2023 11:18:47 -0300 (-03)
Date:   Fri, 27 Oct 2023 11:18:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] perf build: Disable BPF skeletons if clang version is <
 12.0.1
Message-ID: <ZTvGx/Ou6BVnYBqi@kernel.org>
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

While building on a wide range of distros and clang versions it was
noticed that at least version 12.0.1 (noticed on Alpine 3.15 with
"Alpine clang version 12.0.1") is needed to not fail with BTF generation
errors such as:

Debian:10

  Debian clang version 11.0.1-2~deb10u1:

    CLANG   /tmp/build/perf/util/bpf_skel/.tmp/sample_filter.bpf.o
  <SNIP>
    GENSKEL /tmp/build/perf/util/bpf_skel/sample_filter.skel.h
  libbpf: failed to find BTF for extern 'bpf_cast_to_kern_ctx' [21] section: -2
  Error: failed to open BPF object file: No such file or directory
  make[2]: *** [Makefile.perf:1121: /tmp/build/perf/util/bpf_skel/sample_filter.skel.h] Error 254
  make[2]: *** Deleting file '/tmp/build/perf/util/bpf_skel/sample_filter.skel.h'

Amazon Linux 2:

  clang version 11.1.0 (Amazon Linux 2 11.1.0-1.amzn2.0.2)

    GENSKEL /tmp/build/perf/util/bpf_skel/sample_filter.skel.h
  libbpf: elf: skipping unrecognized data section(18) .eh_frame
  libbpf: elf: skipping relo section(19) .rel.eh_frame for section(18) .eh_frame
  libbpf: failed to find BTF for extern 'bpf_cast_to_kern_ctx' [21] section: -2
  Error: failed to open BPF object file: No such file or directory
  make[2]: *** [/tmp/build/perf/util/bpf_skel/sample_filter.skel.h] Error 254
  make[2]: *** Deleting file `/tmp/build/perf/util/bpf_skel/sample_filter.skel.h'

Ubuntu 20.04:

  clang version 10.0.0-4ubuntu1

    CLANG   /tmp/build/perf/util/bpf_skel/.tmp/augmented_raw_syscalls.bpf.o
    GENSKEL /tmp/build/perf/util/bpf_skel/bench_uprobe.skel.h
    GENSKEL /tmp/build/perf/util/bpf_skel/bperf_leader.skel.h
  libbpf: sec '.reluprobe': corrupted symbol #27 pointing to invalid section #65522 for relo #0
    GENSKEL /tmp/build/perf/util/bpf_skel/bperf_follower.skel.h
  Error: failed to open BPF object file: BPF object format invalid
  make[2]: *** [Makefile.perf:1121: /tmp/build/perf/util/bpf_skel/bench_uprobe.skel.h] Error 95
  make[2]: *** Deleting file '/tmp/build/perf/util/bpf_skel/bench_uprobe.skel.h'

So check if the version is at least 12.0.1 otherwise disable building
BPF skels and provide a message about it, continuing the build.

The message, when running on amazonlinux:2:

  Makefile.config:698: Warning: Disabled BPF skeletons as reliable BTF generation needs at least clang version 12.0.1

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 4300a9e4253a0c87..8b6cffbc485834c8 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -693,6 +693,13 @@ ifeq ($(BUILD_BPF_SKEL),1)
     dummy := $(warning Warning: Disabled BPF skeletons as clang ($(CLANG)) is missing)
     BUILD_BPF_SKEL := 0
   else
+    CLANG_VERSION := $(shell $(CLANG) --version | head -1 | sed 's/.*clang version \([[:digit:]]\+.[[:digit:]]\+.[[:digit:]]\+\).*/\1/g')
+    ifeq ($(call version-lt3,$(CLANG_VERSION),12.0.1),1)
+      dummy := $(warning Warning: Disabled BPF skeletons as reliable BTF generation needs at least $(CLANG) version 12.0.1)
+      BUILD_BPF_SKEL := 0
+    endif
+  endif
+  ifeq ($(BUILD_BPF_SKEL),1)
     $(call feature_check,clang-bpf-co-re)
     ifeq ($(feature-clang-bpf-co-re), 0)
       dummy := $(warning Warning: Disabled BPF skeletons as clang is too old)
-- 
2.41.0


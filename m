Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30702785FB5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 20:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238170AbjHWSdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 14:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbjHWSdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 14:33:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F13EFD
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 11:33:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA0796208B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 18:32:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B58C433C7;
        Wed, 23 Aug 2023 18:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692815579;
        bh=7WSLAdWSCJ4baK4IhgkjUanLQjLQJoatnEMew7d1GVc=;
        h=Date:From:To:Cc:Subject:From;
        b=jDXP9gv20HXWZi8btLX27uoifDkz9/IFIrdWACIxkzEWxzcxqOQGK1bsVWDDRiSNU
         fOqj95LF7iKUomJDFh9WWQcVhFURgFCbd3BXzeLO2C9TNhcnbka3y02fH9MBAGJXoC
         F+rXP89X0KlXhzTbaakw/6E+xQpc7ZuaU7f7HVgpW6RhgOzmH09DF/CJ4Id8sk9WTP
         w6Uuh/nrjh/qXd6Y8ZyF/BikC9lGBv05sG4AKXfLLh0ugizGFDsWi/XkVMjXBIQVPV
         RsooTRGXslNy6IdGinCFlz963xFxVLNo1fFh6kplQu1GXSJB7zyyuZU5AoH99Dgv/Y
         WQKiejHPUvFWQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4673840722; Wed, 23 Aug 2023 15:32:56 -0300 (-03)
Date:   Wed, 23 Aug 2023 15:32:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Guilherme Amadio <amadio@gentoo.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] perf build: Allow customization of clang options for BPF
 target
Message-ID: <ZOZQ2LDA+3Wg8x2T@kernel.org>
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

Fixed it up to apply to current source tree.

- Arnaldo

From: Guilherme Amadio <amadio@gentoo.org>

This also puts an unconditional -Werror under control of WERROR. The
clang includes added during the build can lead to a warning that may be
turned into an error. In addition, hardened clang produces a warning
about lack of support for -fstack-protector* options for the BPF target:

  clang -g -O2 -target bpf -Wall -Werror -Ilinux/tools/perf/util/bpf_skel/.tmp/.. \
    -I -idirafter /usr/lib/llvm/16/bin/../../../../lib/clang/16/include -idirafter /usr/local/include \
    -idirafter /usr/include  -Ilinux/tools/include/uapi -c util/bpf_skel/bperf_follower.bpf.c \
    -o linux/tools/perf/util/bpf_skel/.tmp/bperf_follower.bpf.o && llvm-strip -g linux/tools/perf/util/bpf_skel/.tmp/bperf_follower.bpf.o
  clang-16: error: /usr/lib/llvm/16/bin/../../../../lib/clang/16/include: 'linker' input unused [-Werror,-Wunused-command-line-argument]
  clang-16: error: ignoring '-fstack-protector-strong' option as it is not currently supported for target 'bpf' [-Werror,-Woption-ignored]
  make[1]: *** [Makefile.perf:1082: linux/tools/perf/util/bpf_skel/.tmp/bpf_prog_profiler.bpf.o] Error 1

Signed-off-by: Guilherme Amadio <amadio@gentoo.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index a5dd1ba0fb5f1f17..37af6df7b978de27 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1056,10 +1056,15 @@ ifneq ($(CROSS_COMPILE),)
 CLANG_TARGET_ARCH = --target=$(notdir $(CROSS_COMPILE:%-=%))
 endif
 
+CLANG_OPTIONS = -Wall
 CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_ARCH))
 BPF_INCLUDE := -I$(SKEL_TMP_OUT)/.. -I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES)
 TOOLS_UAPI_INCLUDE := -I$(srctree)/tools/include/uapi
 
+ifneq ($(WERROR),0)
+  CLANG_OPTIONS += -Werror
+endif
+
 $(BPFTOOL): | $(SKEL_TMP_OUT)
 	$(Q)CFLAGS= $(MAKE) -C ../bpf/bpftool \
 		OUTPUT=$(SKEL_TMP_OUT)/ bootstrap
@@ -1101,7 +1106,7 @@ else
 endif
 
 $(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) $(SKEL_OUT)/vmlinux.h | $(SKEL_TMP_OUT)
-	$(QUIET_CLANG)$(CLANG) -g -O2 --target=bpf -Wall -Werror $(BPF_INCLUDE) $(TOOLS_UAPI_INCLUDE) \
+	$(QUIET_CLANG)$(CLANG) -g -O2 --target=bpf $(CLANG_OPTIONS) $(BPF_INCLUDE) $(TOOLS_UAPI_INCLUDE) \
 	  -c $(filter util/bpf_skel/%.bpf.c,$^) -o $@
 
 $(SKEL_OUT)/%.skel.h: $(SKEL_TMP_OUT)/%.bpf.o | $(BPFTOOL)
-- 
2.37.1


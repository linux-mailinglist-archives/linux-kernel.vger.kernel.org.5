Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED36777E70
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234417AbjHJQiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236745AbjHJQh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:37:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585B62D6B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 09:37:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC6016642D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 16:37:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C768C433C8;
        Thu, 10 Aug 2023 16:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691685469;
        bh=G59dWErv7Dy1cYa994rAi+7s2XnaASLsQ30DsnGslBM=;
        h=Date:From:To:Cc:Subject:From;
        b=iLvQQtwpotExQw3JGttY7ItQ9OOKh6cGIM/uwgWyl9RVl5Zv8VNX4YlqavfVZAucU
         PYU9qCN3H2Agje06XFm6Im7fRQbvLnMFX27FsYa8+O4Wey4MvWrr1irPb6KAJn5ISu
         +3MMsNd5hx5JZdPPJ65e9nf9wa/ESYc6mM1noD8SXHvlVABLVsgVw+GZgMWddpzux9
         RbuvpctvEHoEweFKj2ck4ElIyjWRdIO6CmOfwzVtUJzrlwN2qHuyjFxQv2VkWQm9dG
         tPEbM/ZsxhGROA+GVoSXzVRtTgVKAe1chPTSQsxk1DWDIsCMbq+XiihGi0G1kqNh2v
         Y3JK2eAHS27mQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8DE8D404DF; Thu, 10 Aug 2023 13:37:46 -0300 (-03)
Date:   Thu, 10 Aug 2023 13:37:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] perf build: Remove -Wno-unused-but-set-variable from the
 flex flags when building with clang < 13.0.0
Message-ID: <ZNUSWr52jUnVaaa/@kernel.org>
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

clang < 13.0.0 doesn't grok -Wno-unused-but-set-variable, so just remove
it to avoid:

  error: unknown warning option '-Wno-unused-but-set-variable'; did you mean '-Wno-unused-const-variable'? [-Werror,-Wunknown-warning-option]
  make[4]: *** [/git/perf-6.5.0-rc4/tools/build/Makefile.build:128: /tmp/build/perf/util/pmu-flex.o] Error 1
  make[4]: *** Waiting for unfinished jobs....

Fixes: ddc8e4c966923ad1 ("perf build: Disable fewer bison warnings")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/Build | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index d487aec0b458a0d9..a9051ab2d52ac926 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -1,3 +1,4 @@
+include $(srctree)/tools/scripts/Makefile.include
 include $(srctree)/tools/scripts/utilities.mak
 
 perf-y += arm64-frame-pointer-unwind-support.o
@@ -311,6 +312,15 @@ CFLAGS_bpf-filter-flex.o    += $(flex_flags)
 #  int yynerrs = 0;
 
 bison_flags := -DYYENABLE_NLS=0 -Wno-unused-but-set-variable
+
+# Old clangs don't grok -Wno-unused-but-set-variable, remove it
+ifeq ($(CC_NO_CLANG), 0)
+  CLANG_VERSION := $(shell $(CLANG) --version | head -1 | sed 's/.*clang version \([[:digit:]]\+.[[:digit:]]\+.[[:digit:]]\+\).*/\1/g')
+  ifeq ($(call version-lt3,$(CLANG_VERSION),13.0.0),1)
+    bison_flags := $(subst -Wno-unused-but-set-variable,,$(bison_flags))
+  endif
+endif
+
 BISON_GE_382 := $(shell expr $(shell $(BISON) --version | grep bison | sed -e 's/.\+ \([0-9]\+\).\([0-9]\+\).\([0-9]\+\)/\1\2\3/g') \>\= 382)
 ifeq ($(BISON_GE_382),1)
   bison_flags += -Wno-switch-enum
-- 
2.37.1


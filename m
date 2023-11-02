Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3309F7DF02A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 11:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346880AbjKBKdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 06:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346832AbjKBKdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 06:33:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C430AC2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 03:32:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22382C433C7;
        Thu,  2 Nov 2023 10:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698921179;
        bh=vCsEm5kYfVokXfpt6FzUVW6m+28U/AvZkO+g4Ew8jFk=;
        h=From:To:Cc:Subject:Date:From;
        b=ZJiNlDs4f9oSJYvvei6uvYrpqZq37TUCwF2TSXFU0cathgxMjUlb4jnlSBN4uWgXY
         h1C9FNJXF8eXE6TTbyrPdzGPap3ZvqTeBycVZLwtI/OBCUOA+yoZaqgqRt9+AtkZYO
         1kJ2hdn88SArB44LpXio9JYg3HVTdQLy/72rTKqAFoB3/hWHcAVdzvxYSVIMHY/pmQ
         uCnjE2dRoZusENcLrLAjYtjG94rH95ydVkXdor2gNtHsd8Jh5z22QhPIQ3qx+ucgsn
         Hnsk6XReZPEAH78MSG8NTPZp2RwwvCPMNAXDwhxHJEM2hylphICX3Wg97UUqFLlfiL
         TC+p/kmOFN+ZA==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, bpf@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>, llvm@lists.linux.dev,
        Jiri Olsa <olsajiri@gmail.com>
Subject: [PATCH v2] tools/build: Add clang cross-compilation flags to feature detection
Date:   Thu,  2 Nov 2023 11:32:52 +0100
Message-Id: <20231102103252.247147-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Björn Töpel <bjorn@rivosinc.com>

When a tool cross-build has LLVM=1 set, the clang cross-compilation
flags are not passed to the feature detection build system. This
results in the host's features are detected instead of the targets.

E.g, triggering a cross-build of bpftool:

  cd tools/bpf/bpftool
  make ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- LLVM=1

would report the host's, and not the target's features.

Correct the issue by passing the CLANG_CROSS_FLAGS variable to the
feature detection makefile.

Fixes: cebdb7374577 ("tools: Help cross-building with clang")
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 tools/build/Makefile.feature |  2 +-
 tools/build/feature/Makefile | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 934e2777a2db..25b009a6c05f 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -8,7 +8,7 @@ endif
 
 feature_check = $(eval $(feature_check_code))
 define feature_check_code
-  feature-$(1) := $(shell $(MAKE) OUTPUT=$(OUTPUT_FEATURES) CC="$(CC)" CXX="$(CXX)" CFLAGS="$(EXTRA_CFLAGS) $(FEATURE_CHECK_CFLAGS-$(1))" CXXFLAGS="$(EXTRA_CXXFLAGS) $(FEATURE_CHECK_CXXFLAGS-$(1))" LDFLAGS="$(LDFLAGS) $(FEATURE_CHECK_LDFLAGS-$(1))" -C $(feature_dir) $(OUTPUT_FEATURES)test-$1.bin >/dev/null 2>/dev/null && echo 1 || echo 0)
+  feature-$(1) := $(shell $(MAKE) OUTPUT=$(OUTPUT_FEATURES) CC="$(CC)" CXX="$(CXX)" CFLAGS="$(EXTRA_CFLAGS) $(FEATURE_CHECK_CFLAGS-$(1))" CXXFLAGS="$(EXTRA_CXXFLAGS) $(FEATURE_CHECK_CXXFLAGS-$(1))" LDFLAGS="$(LDFLAGS) $(FEATURE_CHECK_LDFLAGS-$(1))" CLANG_CROSS_FLAGS="$(CLANG_CROSS_FLAGS)" -C $(feature_dir) $(OUTPUT_FEATURES)test-$1.bin >/dev/null 2>/dev/null && echo 1 || echo 0)
 endef
 
 feature_set = $(eval $(feature_set_code))
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index dad79ede4e0a..c4458345e564 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -84,12 +84,12 @@ PKG_CONFIG ?= $(CROSS_COMPILE)pkg-config
 
 all: $(FILES)
 
-__BUILD = $(CC) $(CFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.c,$(@F)) $(LDFLAGS)
+__BUILD = $(CC) $(CFLAGS) $(CLANG_CROSS_FLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.c,$(@F)) $(LDFLAGS)
   BUILD = $(__BUILD) > $(@:.bin=.make.output) 2>&1
   BUILD_BFD = $(BUILD) -DPACKAGE='"perf"' -lbfd -ldl
   BUILD_ALL = $(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=2 -ldw -lelf -lnuma -lelf -lslang $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) -DPACKAGE='"perf"' -lbfd -ldl -lz -llzma -lzstd -lcap
 
-__BUILDXX = $(CXX) $(CXXFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.cpp,$(@F)) $(LDFLAGS)
+__BUILDXX = $(CXX) $(CXXFLAGS) $(CLANG_CROSS_FLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.cpp,$(@F)) $(LDFLAGS)
   BUILDXX = $(__BUILDXX) > $(@:.bin=.make.output) 2>&1
 
 ###############################
@@ -259,10 +259,10 @@ $(OUTPUT)test-reallocarray.bin:
 	$(BUILD)
 
 $(OUTPUT)test-libbfd-liberty.bin:
-	$(CC) $(CFLAGS) -Wall -Werror -o $@ test-libbfd.c -DPACKAGE='"perf"' $(LDFLAGS) -lbfd -ldl -liberty
+	$(CC) $(CFLAGS) $(CLANG_CROSS_FLAGS) -Wall -Werror -o $@ test-libbfd.c -DPACKAGE='"perf"' $(LDFLAGS) -lbfd -ldl -liberty
 
 $(OUTPUT)test-libbfd-liberty-z.bin:
-	$(CC) $(CFLAGS) -Wall -Werror -o $@ test-libbfd.c -DPACKAGE='"perf"' $(LDFLAGS) -lbfd -ldl -liberty -lz
+	$(CC) $(CFLAGS) $(CLANG_CROSS_FLAGS) -Wall -Werror -o $@ test-libbfd.c -DPACKAGE='"perf"' $(LDFLAGS) -lbfd -ldl -liberty -lz
 
 $(OUTPUT)test-cplus-demangle.bin:
 	$(BUILD) -liberty
@@ -283,10 +283,10 @@ $(OUTPUT)test-libbabeltrace.bin:
 	$(BUILD) # -lbabeltrace provided by $(FEATURE_CHECK_LDFLAGS-libbabeltrace)
 
 $(OUTPUT)test-compile-32.bin:
-	$(CC) -m32 -o $@ test-compile.c
+	$(CC) $(CLANG_CROSS_FLAGS) -m32 -o $@ test-compile.c
 
 $(OUTPUT)test-compile-x32.bin:
-	$(CC) -mx32 -o $@ test-compile.c
+	$(CC) $(CLANG_CROSS_FLAGS) -mx32 -o $@ test-compile.c
 
 $(OUTPUT)test-zlib.bin:
 	$(BUILD) -lz

base-commit: 21e80f3841c01aeaf32d7aee7bbc87b3db1aa0c6
-- 
2.40.1


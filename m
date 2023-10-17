Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DF77CC0CB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 12:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343687AbjJQKiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 06:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234594AbjJQKiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 06:38:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6EBA2;
        Tue, 17 Oct 2023 03:38:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C4EC433CA;
        Tue, 17 Oct 2023 10:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697539094;
        bh=A6qLcCYxkwgWjCL+CxEKfQPWGv0e7JNIKXIZW89MeuU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k2ytQAQi1GJKjYWyS2S00/+UNBIvCCyZOAFkCE9TFt+3ZueDC4OLAjybipTBO++p7
         lSznrtrnBtPgpvlmBNt6OM2fAUeOwQxj4dQNjqNvWKTX+DMCwS4qNiSkTiXcgF7iXX
         IVWyV/5vgO1OM9YzlILfH8VzLtz/pCA9hqXZrvwDjhxZ+F6gUUJP9/OIEhYH1ElMue
         dFHIhx2GPCHJTtAQeuqceZ02h0gP8+H7GgB8vFa1SINkFD1W4N0B3HEMOSRPXrmsYA
         6ACuJiALmbS0dKkNEiRZKjV1i4jhjjf/Y7/5bJXdH8bcAESPGvcIcVX73YsDJgg5gO
         Wsuoqa5OLtQBQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benno Lossin <benno.lossin@proton.me>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Gary Guo <gary@garyguo.net>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Song Liu <song@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
        rust-for-linux@vger.kernel.org
Subject: [PATCH 2/4] kbuild: avoid too many execution of scripts/pahole-flags.sh
Date:   Tue, 17 Oct 2023 19:37:40 +0900
Message-Id: <20231017103742.130927-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231017103742.130927-1-masahiroy@kernel.org>
References: <20231017103742.130927-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

scripts/pahole-flags.sh is executed so many times.

You can check how many times it is invoked during the build, as follows:

  $ cat <<EOF >> scripts/pahole-flags.sh
  > echo "scripts/pahole-flags.sh was executed" >&2
  > EOF

  $ make -s
  scripts/pahole-flags.sh was executed
  scripts/pahole-flags.sh was executed
  scripts/pahole-flags.sh was executed
  scripts/pahole-flags.sh was executed
  scripts/pahole-flags.sh was executed
    [ lots of repeated lines suppressed... ]

This scripts is exectuted more than 20 times during the kernel build
because PAHOLE_FLAGS is a recursively expanded variable and exported
to sub-processes.

With the GNU Make >= 4.4, it is executed more than 60 times because
exported variables are also passed to other $(shell ) invocations.
Without careful coding, it is known to cause an exponential fork
explosion. [1]

The use of $(shell ) in an exported recursive variable is likely wrong
because $(shell ) is always evaluated due to the 'export' keyword, and
the evaluation can occur multiple times by the nature of recursive
variables.

Convert the shell script to a Makefile, which is included only when
CONFIG_DEBUG_INFO_BTF=y.

[1]: https://savannah.gnu.org/bugs/index.php?64746

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile                |  4 +---
 scripts/Makefile.btf    | 19 +++++++++++++++++++
 scripts/pahole-flags.sh | 30 ------------------------------
 3 files changed, 20 insertions(+), 33 deletions(-)
 create mode 100644 scripts/Makefile.btf
 delete mode 100755 scripts/pahole-flags.sh

diff --git a/Makefile b/Makefile
index fed9a6cc3665..eaddec67e5e1 100644
--- a/Makefile
+++ b/Makefile
@@ -513,8 +513,6 @@ LZ4		= lz4c
 XZ		= xz
 ZSTD		= zstd
 
-PAHOLE_FLAGS	= $(shell PAHOLE=$(PAHOLE) $(srctree)/scripts/pahole-flags.sh)
-
 CHECKFLAGS     := -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ \
 		  -Wbitwise -Wno-return-void -Wno-unknown-attribute $(CF)
 NOSTDINC_FLAGS :=
@@ -605,7 +603,6 @@ export KBUILD_RUSTFLAGS RUSTFLAGS_KERNEL RUSTFLAGS_MODULE
 export KBUILD_AFLAGS AFLAGS_KERNEL AFLAGS_MODULE
 export KBUILD_AFLAGS_MODULE KBUILD_CFLAGS_MODULE KBUILD_RUSTFLAGS_MODULE KBUILD_LDFLAGS_MODULE
 export KBUILD_AFLAGS_KERNEL KBUILD_CFLAGS_KERNEL KBUILD_RUSTFLAGS_KERNEL
-export PAHOLE_FLAGS
 
 # Files to ignore in find ... statements
 
@@ -1002,6 +999,7 @@ KBUILD_CPPFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
 # include additional Makefiles when needed
 include-y			:= scripts/Makefile.extrawarn
 include-$(CONFIG_DEBUG_INFO)	+= scripts/Makefile.debug
+include-$(CONFIG_DEBUG_INFO_BTF)+= scripts/Makefile.btf
 include-$(CONFIG_KASAN)		+= scripts/Makefile.kasan
 include-$(CONFIG_KCSAN)		+= scripts/Makefile.kcsan
 include-$(CONFIG_KMSAN)		+= scripts/Makefile.kmsan
diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
new file mode 100644
index 000000000000..82377e470aed
--- /dev/null
+++ b/scripts/Makefile.btf
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0
+
+pahole-ver := $(CONFIG_PAHOLE_VERSION)
+pahole-flags-y :=
+
+# pahole 1.18 through 1.21 can't handle zero-sized per-CPU vars
+ifeq ($(call test-le, $(pahole-ver), 121),y)
+pahole-flags-$(call test-ge, $(pahole-ver), 118)	+= --skip_encoding_btf_vars
+endif
+
+pahole-flags-$(call test-ge, $(pahole-ver), 121)	+= --btf_gen_floats
+
+pahole-flags-$(call test-ge, $(pahole-ver), 122)	+= -j
+
+pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)		+= --lang_exclude=rust
+
+pahole-flags-$(call test-ge, $(pahole-ver), 125)	+= --skip_encoding_btf_inconsistent_proto --btf_gen_optimized
+
+export PAHOLE_FLAGS := $(pahole-flags-y)
diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
deleted file mode 100755
index 728d55190d97..000000000000
--- a/scripts/pahole-flags.sh
+++ /dev/null
@@ -1,30 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-
-extra_paholeopt=
-
-if ! [ -x "$(command -v ${PAHOLE})" ]; then
-	exit 0
-fi
-
-pahole_ver=$($(dirname $0)/pahole-version.sh ${PAHOLE})
-
-if [ "${pahole_ver}" -ge "118" ] && [ "${pahole_ver}" -le "121" ]; then
-	# pahole 1.18 through 1.21 can't handle zero-sized per-CPU vars
-	extra_paholeopt="${extra_paholeopt} --skip_encoding_btf_vars"
-fi
-if [ "${pahole_ver}" -ge "121" ]; then
-	extra_paholeopt="${extra_paholeopt} --btf_gen_floats"
-fi
-if [ "${pahole_ver}" -ge "122" ]; then
-	extra_paholeopt="${extra_paholeopt} -j"
-fi
-if [ "${pahole_ver}" -ge "124" ]; then
-	# see PAHOLE_HAS_LANG_EXCLUDE
-	extra_paholeopt="${extra_paholeopt} --lang_exclude=rust"
-fi
-if [ "${pahole_ver}" -ge "125" ]; then
-	extra_paholeopt="${extra_paholeopt} --skip_encoding_btf_inconsistent_proto --btf_gen_optimized"
-fi
-
-echo ${extra_paholeopt}
-- 
2.40.1


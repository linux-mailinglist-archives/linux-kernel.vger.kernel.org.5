Return-Path: <linux-kernel+bounces-69582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE07858BD8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 01:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BE95B22EE0
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4AC2D052;
	Sat, 17 Feb 2024 00:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMXSQ8n7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7F836139;
	Sat, 17 Feb 2024 00:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708129619; cv=none; b=l51cyHd2G1JKi0qw3y/wjdx5Iwx3ZSxA+crrDJ7s8dpIzA+2HpBNXpw5+eUOSjBB8q/Jn68U/Dxvgd05VYAperdPugfy8Dzn50Syn2NOCXzh/AWgzU9I+Bqe9kYbGKfRZT+i4P9uNq7O48Md0AkEfvp7bw96ItS/2bv4hTM3RmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708129619; c=relaxed/simple;
	bh=YVKRAnC7d4hzaICP226MHHJLYcDk7gXEJEYnfsLDk0A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZoBsG424DWRdltlp9gt3TCvx4wUhv6v/x0cbfAwI7Zut0rWxf1fJrwEOIKFFYzc379gUSQVQL0NKiWX7+7vn119mfkr/6yhcgnQuWfMfFi9JNPodDDRtQdH3Wh+eMy8/+f37TMEn4DkbaMfW/xNsomS+x/rUA47jyNxROIhiX9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMXSQ8n7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F29C433F1;
	Sat, 17 Feb 2024 00:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708129618;
	bh=YVKRAnC7d4hzaICP226MHHJLYcDk7gXEJEYnfsLDk0A=;
	h=From:To:Cc:Subject:Date:From;
	b=gMXSQ8n75+gG0Qz1LO/mD5786VVS4Yk22sDmLfm1syU6nr47dR2G36NPlDiogzVNG
	 RhfWKDulwZhWrCWspRwZ/HuX7ygwerLqarDtwxFyYfs8jwd4fNQGJiB4wX8ePCPRZ3
	 hasJlPSptX//kaiATohY2d2eZu07wrP2L7nTgnQPJm6povSuCNKLo6aWMxfIVWuhYH
	 1TE55lkeR2mtxKy80swYz7kV/9yuF2YLGIbChbsL4qVMXZG3v9xq+sGYizgqtdDoQU
	 2iJ/ygPlAGFpZOdT1NkdMLa3UTkeLPVYJXgCJVxkVqCYDHcoEOOMilCTrdwHLfWYrz
	 Phuodm4xlRv0g==
From: Miguel Ojeda <ojeda@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Alex Gaynor <alex.gaynor@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kbuild@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH 1/2] kbuild: mark `rustc` (and others) invocations as recursive
Date: Sat, 17 Feb 2024 01:26:37 +0100
Message-ID: <20240217002638.57373-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`rustc` (like Cargo) may take advantage of the jobserver at any time
(e.g. for backend parallelism, or eventually frontend too). In the kernel,
we call `rustc` with `-Ccodegen-units=1` (and `-Zthreads` is 1 so far),
so we do not expect parallelism. However, in the upcoming Rust 1.76.0, a
warning is emitted by `rustc` when it cannot connect to the jobserver it
was passed (in many cases, but not all: compiling and `--print sysroot`
do, but `--version` does not). And given GNU Make always passes
the jobserver in the environment variable (even when a line is deemed
non-recursive), `rustc` will end up complaining about it (in particular
in Make 4.3 where there is only the simple pipe jobserver style).

One solution is to remove the jobserver from `MAKEFLAGS`. However, we
can mark the lines with calls to `rustc` (and Cargo) as recursive, which
looks simpler. This is what is now documented and recommended by `rustc`
and allows us to be ready for the time we may use parallelism inside
`rustc` (potentially now, if a user passes `-Zthreads`). Thus do so.

Similarly, do the same for `rustdoc` and `cargo` calls.

Finally, there is one case that the solution does not cover, which is the
`$(shell ...)` call we have. Thus, for that one, set an empty `MAKEFLAGS`
environment variable.

Link: https://github.com/rust-lang/rust/issues/120515
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 Makefile               |  4 ++--
 rust/Makefile          | 48 +++++++++++++++++++++---------------------
 scripts/Makefile.build |  8 +++----
 scripts/Makefile.host  |  2 +-
 4 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/Makefile b/Makefile
index 9869f57c3fb3..cbcdd8d9d0e3 100644
--- a/Makefile
+++ b/Makefile
@@ -1197,7 +1197,7 @@ prepare0: archprepare
 # All the preparing..
 prepare: prepare0
 ifdef CONFIG_RUST
-	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/rust_is_available.sh
+	+$(Q)$(CONFIG_SHELL) $(srctree)/scripts/rust_is_available.sh
 	$(Q)$(MAKE) $(build)=rust
 endif

@@ -1707,7 +1707,7 @@ $(DOC_TARGETS):
 # "Is Rust available?" target
 PHONY += rustavailable
 rustavailable:
-	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/rust_is_available.sh && echo "Rust is available!"
+	+$(Q)$(CONFIG_SHELL) $(srctree)/scripts/rust_is_available.sh && echo "Rust is available!"

 # Documentation target
 #
diff --git a/rust/Makefile b/rust/Makefile
index 9d2a16cc91cb..a78fcf4004b0 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -40,7 +40,7 @@ obj-$(CONFIG_RUST_KERNEL_DOCTESTS) += doctests_kernel_generated_kunit.o
 ifdef CONFIG_RUST

 # `$(rust_flags)` is passed in case the user added `--sysroot`.
-rustc_sysroot := $(shell $(RUSTC) $(rust_flags) --print sysroot)
+rustc_sysroot := $(shell MAKEFLAGS= $(RUSTC) $(rust_flags) --print sysroot)
 rustc_host_target := $(shell $(RUSTC) --version --verbose | grep -F 'host: ' | cut -d' ' -f2)
 RUST_LIB_SRC ?= $(rustc_sysroot)/lib/rustlib/src/rust/library

@@ -108,14 +108,14 @@ rustdoc-macros: private rustdoc_host = yes
 rustdoc-macros: private rustc_target_flags = --crate-type proc-macro \
     --extern proc_macro
 rustdoc-macros: $(src)/macros/lib.rs FORCE
-	$(call if_changed,rustdoc)
+	+$(call if_changed,rustdoc)

 rustdoc-core: private rustc_target_flags = $(core-cfgs)
 rustdoc-core: $(RUST_LIB_SRC)/core/src/lib.rs FORCE
-	$(call if_changed,rustdoc)
+	+$(call if_changed,rustdoc)

 rustdoc-compiler_builtins: $(src)/compiler_builtins.rs rustdoc-core FORCE
-	$(call if_changed,rustdoc)
+	+$(call if_changed,rustdoc)

 # We need to allow `rustdoc::broken_intra_doc_links` because some
 # `no_global_oom_handling` functions refer to non-`no_global_oom_handling`
@@ -124,7 +124,7 @@ rustdoc-compiler_builtins: $(src)/compiler_builtins.rs rustdoc-core FORCE
 rustdoc-alloc: private rustc_target_flags = $(alloc-cfgs) \
     -Arustdoc::broken_intra_doc_links
 rustdoc-alloc: $(src)/alloc/lib.rs rustdoc-core rustdoc-compiler_builtins FORCE
-	$(call if_changed,rustdoc)
+	+$(call if_changed,rustdoc)

 rustdoc-kernel: private rustc_target_flags = --extern alloc \
     --extern build_error --extern macros=$(objtree)/$(obj)/libmacros.so \
@@ -132,7 +132,7 @@ rustdoc-kernel: private rustc_target_flags = --extern alloc \
 rustdoc-kernel: $(src)/kernel/lib.rs rustdoc-core rustdoc-macros \
     rustdoc-compiler_builtins rustdoc-alloc $(obj)/libmacros.so \
     $(obj)/bindings.o FORCE
-	$(call if_changed,rustdoc)
+	+$(call if_changed,rustdoc)

 quiet_cmd_rustc_test_library = RUSTC TL $<
       cmd_rustc_test_library = \
@@ -146,18 +146,18 @@ quiet_cmd_rustc_test_library = RUSTC TL $<
 		--crate-name $(subst rusttest-,,$(subst rusttestlib-,,$@)) $<

 rusttestlib-build_error: $(src)/build_error.rs rusttest-prepare FORCE
-	$(call if_changed,rustc_test_library)
+	+$(call if_changed,rustc_test_library)

 rusttestlib-macros: private rustc_target_flags = --extern proc_macro
 rusttestlib-macros: private rustc_test_library_proc = yes
 rusttestlib-macros: $(src)/macros/lib.rs rusttest-prepare FORCE
-	$(call if_changed,rustc_test_library)
+	+$(call if_changed,rustc_test_library)

 rusttestlib-bindings: $(src)/bindings/lib.rs rusttest-prepare FORCE
-	$(call if_changed,rustc_test_library)
+	+$(call if_changed,rustc_test_library)

 rusttestlib-uapi: $(src)/uapi/lib.rs rusttest-prepare FORCE
-	$(call if_changed,rustc_test_library)
+	+$(call if_changed,rustc_test_library)

 quiet_cmd_rustdoc_test = RUSTDOC T $<
       cmd_rustdoc_test = \
@@ -189,7 +189,7 @@ quiet_cmd_rustdoc_test_kernel = RUSTDOC TK $<
     $(src)/kernel/lib.rs $(obj)/kernel.o \
     $(objtree)/scripts/rustdoc_test_builder \
     $(objtree)/scripts/rustdoc_test_gen FORCE
-	$(call if_changed,rustdoc_test_kernel)
+	+$(call if_changed,rustdoc_test_kernel)

 # We cannot use `-Zpanic-abort-tests` because some tests are dynamic,
 # so for the moment we skip `-Cpanic=abort`.
@@ -254,21 +254,21 @@ quiet_cmd_rustsysroot = RUSTSYSROOT
 		$(objtree)/$(obj)/test/sysroot/lib/rustlib/$(rustc_host_target)/lib

 rusttest-prepare: FORCE
-	$(call if_changed,rustsysroot)
+	+$(call if_changed,rustsysroot)

 rusttest-macros: private rustc_target_flags = --extern proc_macro
 rusttest-macros: private rustdoc_test_target_flags = --crate-type proc-macro
 rusttest-macros: $(src)/macros/lib.rs rusttest-prepare FORCE
-	$(call if_changed,rustc_test)
-	$(call if_changed,rustdoc_test)
+	+$(call if_changed,rustc_test)
+	+$(call if_changed,rustdoc_test)

 rusttest-kernel: private rustc_target_flags = --extern alloc \
     --extern build_error --extern macros --extern bindings --extern uapi
 rusttest-kernel: $(src)/kernel/lib.rs rusttest-prepare \
     rusttestlib-build_error rusttestlib-macros rusttestlib-bindings \
     rusttestlib-uapi FORCE
-	$(call if_changed,rustc_test)
-	$(call if_changed,rustc_test_library)
+	+$(call if_changed,rustc_test)
+	+$(call if_changed,rustc_test_library)

 ifdef CONFIG_CC_IS_CLANG
 bindgen_c_flags = $(c_flags)
@@ -396,7 +396,7 @@ quiet_cmd_rustc_procmacro = $(RUSTC_OR_CLIPPY_QUIET) P $@
 # Therefore, to get `libmacros.so` automatically recompiled when the compiler
 # version changes, we add `core.o` as a dependency (even if it is not needed).
 $(obj)/libmacros.so: $(src)/macros/lib.rs $(obj)/core.o FORCE
-	$(call if_changed_dep,rustc_procmacro)
+	+$(call if_changed_dep,rustc_procmacro)

 quiet_cmd_rustc_library = $(if $(skip_clippy),RUSTC,$(RUSTC_OR_CLIPPY_QUIET)) L $@
       cmd_rustc_library = \
@@ -435,36 +435,36 @@ $(obj)/core.o: private skip_flags = -Dunreachable_pub
 $(obj)/core.o: private rustc_objcopy = $(foreach sym,$(redirect-intrinsics),--redefine-sym $(sym)=__rust$(sym))
 $(obj)/core.o: private rustc_target_flags = $(core-cfgs)
 $(obj)/core.o: $(RUST_LIB_SRC)/core/src/lib.rs scripts/target.json FORCE
-	$(call if_changed_dep,rustc_library)
+	+$(call if_changed_dep,rustc_library)

 $(obj)/compiler_builtins.o: private rustc_objcopy = -w -W '__*'
 $(obj)/compiler_builtins.o: $(src)/compiler_builtins.rs $(obj)/core.o FORCE
-	$(call if_changed_dep,rustc_library)
+	+$(call if_changed_dep,rustc_library)

 $(obj)/alloc.o: private skip_clippy = 1
 $(obj)/alloc.o: private skip_flags = -Dunreachable_pub
 $(obj)/alloc.o: private rustc_target_flags = $(alloc-cfgs)
 $(obj)/alloc.o: $(src)/alloc/lib.rs $(obj)/compiler_builtins.o FORCE
-	$(call if_changed_dep,rustc_library)
+	+$(call if_changed_dep,rustc_library)

 $(obj)/build_error.o: $(src)/build_error.rs $(obj)/compiler_builtins.o FORCE
-	$(call if_changed_dep,rustc_library)
+	+$(call if_changed_dep,rustc_library)

 $(obj)/bindings.o: $(src)/bindings/lib.rs \
     $(obj)/compiler_builtins.o \
     $(obj)/bindings/bindings_generated.rs \
     $(obj)/bindings/bindings_helpers_generated.rs FORCE
-	$(call if_changed_dep,rustc_library)
+	+$(call if_changed_dep,rustc_library)

 $(obj)/uapi.o: $(src)/uapi/lib.rs \
     $(obj)/compiler_builtins.o \
     $(obj)/uapi/uapi_generated.rs FORCE
-	$(call if_changed_dep,rustc_library)
+	+$(call if_changed_dep,rustc_library)

 $(obj)/kernel.o: private rustc_target_flags = --extern alloc \
     --extern build_error --extern macros --extern bindings --extern uapi
 $(obj)/kernel.o: $(src)/kernel/lib.rs $(obj)/alloc.o $(obj)/build_error.o \
     $(obj)/libmacros.so $(obj)/bindings.o $(obj)/uapi.o FORCE
-	$(call if_changed_dep,rustc_library)
+	+$(call if_changed_dep,rustc_library)

 endif # CONFIG_RUST
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index dae447a1ad30..0fb7a785594c 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -290,7 +290,7 @@ quiet_cmd_rustc_o_rs = $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
       cmd_rustc_o_rs = $(rust_common_cmd) --emit=obj=$@ $<

 $(obj)/%.o: $(src)/%.rs FORCE
-	$(call if_changed_dep,rustc_o_rs)
+	+$(call if_changed_dep,rustc_o_rs)

 quiet_cmd_rustc_rsi_rs = $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
       cmd_rustc_rsi_rs = \
@@ -298,19 +298,19 @@ quiet_cmd_rustc_rsi_rs = $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
 	command -v $(RUSTFMT) >/dev/null && $(RUSTFMT) $@

 $(obj)/%.rsi: $(src)/%.rs FORCE
-	$(call if_changed_dep,rustc_rsi_rs)
+	+$(call if_changed_dep,rustc_rsi_rs)

 quiet_cmd_rustc_s_rs = $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
       cmd_rustc_s_rs = $(rust_common_cmd) --emit=asm=$@ $<

 $(obj)/%.s: $(src)/%.rs FORCE
-	$(call if_changed_dep,rustc_s_rs)
+	+$(call if_changed_dep,rustc_s_rs)

 quiet_cmd_rustc_ll_rs = $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
       cmd_rustc_ll_rs = $(rust_common_cmd) --emit=llvm-ir=$@ $<

 $(obj)/%.ll: $(src)/%.rs FORCE
-	$(call if_changed_dep,rustc_ll_rs)
+	+$(call if_changed_dep,rustc_ll_rs)

 # Compile assembler sources (.S)
 # ---------------------------------------------------------------------------
diff --git a/scripts/Makefile.host b/scripts/Makefile.host
index 08d83d9db31a..3c17e6ba421c 100644
--- a/scripts/Makefile.host
+++ b/scripts/Makefile.host
@@ -156,7 +156,7 @@ quiet_cmd_host-rust	= HOSTRUSTC $@
       cmd_host-rust	= \
 	$(HOSTRUSTC) $(hostrust_flags) --emit=link=$@ $<
 $(host-rust): $(obj)/%: $(src)/%.rs FORCE
-	$(call if_changed_dep,host-rust)
+	+$(call if_changed_dep,host-rust)

 targets += $(host-csingle) $(host-cmulti) $(host-cobjs) \
 	   $(host-cxxmulti) $(host-cxxobjs) $(host-rust)

base-commit: f090f0d0eea9666a96702b29bc9a64cbabee85c5
--
2.43.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226EA7E1119
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 22:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjKDVMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 17:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjKDVM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 17:12:29 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84266D69;
        Sat,  4 Nov 2023 14:12:26 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-da30fd994fdso3736796276.1;
        Sat, 04 Nov 2023 14:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699132345; x=1699737145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1+YL2Yjacvz8rzAR5vnISqtQY7Ls7DpSWKcTQHzMSQ=;
        b=i2aWaG2o+CRu1OkOeQLD+Hb3SuYGihptEcnHLdWXAYpsnnJCgAfPcfDqfoMqWsThAQ
         9a51b+YxZNIIwagrt41xmVDovYTGXdV91hLY3GQpVQYGlLRjEBRJu4vADp8CcueuICUc
         ad5/+FUEPiFx6bvsOSjOhHhs02bUhPWoJnnD19k7mUorskxcbK2x2nrhyEnTvIkb9vii
         7QVpbVG34df/Eqgm/upqVxVOoT4J1FvE9AXv69j+GEQ7+XvdpCW+FtYZQDJ8gSnkREAN
         QPhq2GMv3Grjq1sd5oao+B+7aCE3fbcHP92c6/9CyT70ep9sL9I7yXV56G/yhhaXK7tw
         KtkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699132345; x=1699737145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l1+YL2Yjacvz8rzAR5vnISqtQY7Ls7DpSWKcTQHzMSQ=;
        b=evd30A3a77a12kehSC0aOP3fokRNmQXvmobvw1cp1yfE93R79Ty8+OB1FJsdg/wHC4
         58OpJ3AsVcy4RjK78wkFsG94SLwocX3f0Cmu670m9j3o6dbQU85BTP4wy8rbcy5IvCAP
         hyoRYu7sYgEb0Rcpxcra/bdAwDIRpfsJADWKcC/o0bacGIjSmLy5yLVexNZPdoLYYLQv
         GVfly2ULWDFvuSr/oPvYUdkO8horris0Tr81eW7hUiiY4KR0mwjGpEDE2N8yDTCX2iYs
         xxzf2VcBkew4LHdR1T5Q4KNykQfGTnR41S/aNG1uUL5yredDWBhccJ2u1NfEE/uBqyaW
         /FOg==
X-Gm-Message-State: AOJu0YxmwZJa9u0IQjDfy3z+M9lH5Dnr0jldkjQNUab2QWGKU8YYl5eg
        8OaREAP19wqL6b9bctLA17I=
X-Google-Smtp-Source: AGHT+IGT6zFASbTC5oiNFGpQkU5Z6grGCh7qN+2jrKjvJjatE+zHucrS2QSae2CfsLRzV1qoae5yrA==
X-Received: by 2002:a25:1507:0:b0:da0:aa1b:80f3 with SMTP id 7-20020a251507000000b00da0aa1b80f3mr5050646ybv.10.1699132345601;
        Sat, 04 Nov 2023 14:12:25 -0700 (PDT)
Received: from tx3000mach.io (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id t14-20020a25838e000000b00d9cc49edae9sm2094731ybk.63.2023.11.04.14.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 14:12:25 -0700 (PDT)
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Davis <afd@ti.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org
Subject: [RFC PATCH v3 1/2] kbuild: Build Rust crates as libraries
Date:   Sat,  4 Nov 2023 18:11:58 -0300
Message-ID: <20231104211213.225891-2-yakoyoku@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231104211213.225891-1-yakoyoku@gmail.com>
References: <20231104211213.225891-1-yakoyoku@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enables compiling Rust crates as dependencies of kernel modules. These
are also meant to be used as libraries for other parts of the kernel.

For these crates `bindings` is also exposed to them and they get their
symbols exported for them to be used by other code.

When a composite object depends on an `.rlib` file, which by the way is
a current ar archive, Kbuild will compile it from its base Rust source
and archive it.

This makes possible to have Rust bindings for a subsystem that is
compiled either built-in or as a module. They can also be made into
modules by themselves too.

Signed-off-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
---
v2 -> v3:
- Fixed erroneous dependency on exported symbols from KUnit tests.
v1 -> v2:
- Fixed builtins compilation.
- Added support for building crates as modules.

 .gitignore                |  2 ++
 Makefile                  |  4 ++--
 scripts/Makefile.build    | 42 ++++++++++++++++++++++++++++++++++++---
 scripts/Makefile.lib      | 20 +++++++++++++++----
 scripts/Makefile.modfinal |  9 +++++++--
 5 files changed, 66 insertions(+), 11 deletions(-)

diff --git a/.gitignore b/.gitignore
index 0bbae167bf93..8353b01e2915 100644
--- a/.gitignore
+++ b/.gitignore
@@ -38,6 +38,7 @@
 *.o
 *.o.*
 *.patch
+*.rlib
 *.rmeta
 *.rpm
 *.rsi
@@ -53,6 +54,7 @@
 *.zst
 Module.symvers
 modules.order
+exports_*_generated.c
 
 #
 # Top-level generic files
diff --git a/Makefile b/Makefile
index 8a40530868ff..4113a5b93ddc 100644
--- a/Makefile
+++ b/Makefile
@@ -283,7 +283,7 @@ no-compiler-targets := $(no-dot-config-targets) install dtbs_install \
 			headers_install modules_install modules_sign kernelrelease image_name
 no-sync-config-targets := $(no-dot-config-targets) %install modules_sign kernelrelease \
 			  image_name
-single-targets := %.a %.i %.ko %.lds %.ll %.lst %.mod %.o %.rsi %.s %.symtypes %/
+single-targets := %.a %.i %.ko %.lds %.ll %.lst %.mod %.o %.rlib %.rsi %.s %.symtypes %/
 
 config-build	:=
 mixed-build	:=
@@ -1919,7 +1919,7 @@ $(clean-dirs):
 clean: $(clean-dirs)
 	$(call cmd,rmfiles)
 	@find $(or $(KBUILD_EXTMOD), .) $(RCS_FIND_IGNORE) \
-		\( -name '*.[aios]' -o -name '*.rsi' -o -name '*.ko' -o -name '.*.cmd' \
+		\( -name '*.[aios]' -o -name '*.rlib' -o -name '*.rsi' -o -name '*.ko' -o -name '.*.cmd' \
 		-o -name '*.ko.*' \
 		-o -name '*.dtb' -o -name '*.dtbo' \
 		-o -name '*.dtb.S' -o -name '*.dtbo.S' \
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index da37bfa97211..d31b4272a79f 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -20,6 +20,7 @@ always-m :=
 targets :=
 subdir-y :=
 subdir-m :=
+rust-libs :=
 EXTRA_AFLAGS   :=
 EXTRA_CFLAGS   :=
 EXTRA_CPPFLAGS :=
@@ -274,7 +275,7 @@ rust_common_cmd = \
 	-Zcrate-attr='feature($(rust_allowed_features))' \
 	--extern alloc --extern kernel \
 	--crate-type rlib -L $(objtree)/rust/ \
-	--crate-name $(basename $(notdir $@)) \
+	--crate-name $(basename $(notdir $<)) \
 	--out-dir $(dir $@) --emit=dep-info=$(depfile)
 
 # `--emit=obj`, `--emit=asm` and `--emit=llvm-ir` imply a single codegen unit
@@ -285,11 +286,41 @@ rust_common_cmd = \
 # i.e. the outputs we would get for the different single targets (e.g. `.ll`)
 # would not match each other.
 
+rlib_obj = $(dir $@)$*.$*.o
+rlib_meta = $(dir $@)$(patsubst %.rlib,%.rmeta,$(notdir $@))
+
 quiet_cmd_rustc_o_rs = $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
       cmd_rustc_o_rs = $(rust_common_cmd) --emit=obj=$@ $<
 
+quiet_cmd_ln_rlib_o = SYMLINK $@
+      cmd_ln_rlib_o = ln -s -f $*.$*.o $@
+
 $(obj)/%.o: $(src)/%.rs FORCE
-	$(call if_changed_dep,rustc_o_rs)
+	$(if $(findstring $@,$(crate-obj-m)), \
+		$(call if_changed,ln_rlib_o), $(call if_changed_dep,rustc_o_rs))
+
+quiet_cmd_rustc_rlib_rs = $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
+      cmd_rustc_rlib_rs = $(rust_common_cmd) --extern bindings \
+		--emit=obj=$(rlib_obj) --emit=metadata=$(rlib_meta) $<; \
+	rm -f $@; $(AR) cDPrST $@ $(rlib_obj) $(rlib_meta)
+
+quiet_cmd_rlib_exports = EXPORTS $@
+      cmd_rlib_exports = \
+	echo "\#include <linux/module.h>"  > $@; \
+	$(NM) -p --defined-only $(rlib_obj) \
+		| perl -ae '/ (T|R|D) (?!(init|cleanup)_module)/ and' \
+			-e 'print "extern int @F[2]; EXPORT_SYMBOL_GPL(@F[2]);"' >> $@
+
+$(crate-obj-m): $(obj)/%.o: $(obj)/exports_%_generated.o $(obj)/lib%.rlib $(src)/%.rs FORCE
+
+$(obj)/lib%.rlib: $(src)/%.rs FORCE
+	$(call if_changed_dep,rustc_rlib_rs)
+
+$(obj)/exports_%_generated.c: $(obj)/lib%.rlib FORCE
+	$(call if_changed,rlib_exports)
+
+$(obj)/exports_%_generated.o: $(obj)/exports_%_generated.c FORCE
+	$(call if_changed,cc_o_c)
 
 quiet_cmd_rustc_rsi_rs = $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
       cmd_rustc_rsi_rs = \
@@ -394,9 +425,14 @@ $(subdir-modorder): $(obj)/%/modules.order: $(obj)/% ;
 # To make this rule robust against "Argument list too long" error,
 # remove $(obj)/ prefix, and restore it by a shell command.
 
+# If we have a .rlib for the archive change it for its object member
+crate-obj = $(foreach m, $1, $(if $(findstring .rlib, $m), \
+	$(basename $(m:lib%=%)).$(m:lib%.rlib=%.o),$m))
+
 quiet_cmd_ar_builtin = AR      $@
       cmd_ar_builtin = rm -f $@; \
-	$(if $(real-prereqs), printf "$(obj)/%s " $(patsubst $(obj)/%,%,$(real-prereqs)) | xargs) \
+	$(if $(real-prereqs), printf "$(obj)/%s " \
+		$(call crate-obj, $(patsubst $(obj)/%,%,$(real-prereqs))) | xargs) \
 	$(AR) cDPrST $@
 
 $(obj)/built-in.a: $(real-obj-y) FORCE
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 68d0134bdbf9..3fe419250dbd 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -45,12 +45,17 @@ else
 obj-y		:= $(filter-out %/, $(obj-y))
 endif
 
+crate-obj-y := $(foreach m, $(filter lib%.rlib, $(obj-y)), $(m:lib%.rlib=%.o))
+crate-obj-m := $(foreach m, $(filter lib%.rlib, $(obj-m)), $(m:lib%.rlib=%.o))
+
 # Expand $(foo-objs) $(foo-y) etc. by replacing their individuals
 suffix-search = $(strip $(foreach s, $3, $($(1:%$(strip $2)=%$s))))
 # List composite targets that are constructed by combining other targets
 multi-search = $(sort $(foreach m, $1, $(if $(call suffix-search, $m, $2, $3 -), $m)))
 # List primitive targets that are compiled from source files
 real-search = $(foreach m, $1, $(if $(call suffix-search, $m, $2, $3 -), $(call suffix-search, $m, $2, $3), $m))
+# List exported symbols from .rlib targets
+rlib-exports = $(foreach m, $1, $(if $(findstring .rlib, $m),$(m:lib%.rlib=exports_%_generated.o)) $m)
 
 # If $(foo-objs), $(foo-y), $(foo-m), or $(foo-) exists, foo.o is a composite object
 multi-obj-y := $(call multi-search, $(obj-y), .o, -objs -y)
@@ -59,8 +64,8 @@ multi-obj-ym := $(multi-obj-y) $(multi-obj-m)
 
 # Replace multi-part objects by their individual parts,
 # including built-in.a from subdirectories
-real-obj-y := $(call real-search, $(obj-y), .o, -objs -y)
-real-obj-m := $(call real-search, $(obj-m), .o, -objs -y -m)
+real-obj-y := $(call rlib-exports, $(call real-search, $(obj-y), .o, -objs -y))
+real-obj-m := $(call rlib-exports, $(call real-search, $(obj-m), .o, -objs -y -m))
 
 always-y += $(always-m)
 
@@ -96,6 +101,8 @@ always-y	:= $(addprefix $(obj)/,$(always-y))
 targets		:= $(addprefix $(obj)/,$(targets))
 obj-m		:= $(addprefix $(obj)/,$(obj-m))
 lib-y		:= $(addprefix $(obj)/,$(lib-y))
+crate-obj-y	:= $(addprefix $(obj)/,$(crate-obj-y))
+crate-obj-m	:= $(addprefix $(obj)/,$(crate-obj-m))
 real-obj-y	:= $(addprefix $(obj)/,$(real-obj-y))
 real-obj-m	:= $(addprefix $(obj)/,$(real-obj-m))
 multi-obj-m	:= $(addprefix $(obj)/, $(multi-obj-m))
@@ -210,7 +217,11 @@ _cpp_flags += -I $(srctree)/$(src) -I $(objtree)/$(obj)
 endif
 endif
 
-part-of-module = $(if $(filter $(basename $@).o, $(real-obj-m)),y)
+_rust_libs = $(foreach l, $(rust-libs), -L $(obj)/$(dir $l) --extern $(notdir $(basename $l)))
+
+part-of-module =                                             \
+	$(if $(or $(filter $(basename $@).o, $(real-obj-m)), \
+		$(filter $(basename $@).rlib, $(real-obj-m))),y)
 quiet_modtag = $(if $(part-of-module),[M],   )
 
 modkern_cflags =                                          \
@@ -232,7 +243,8 @@ c_flags        = -Wp,-MMD,$(depfile) $(NOSTDINC_FLAGS) $(LINUXINCLUDE)     \
 		 $(_c_flags) $(modkern_cflags)                           \
 		 $(basename_flags) $(modname_flags)
 
-rust_flags     = $(_rust_flags) $(modkern_rustflags) @$(objtree)/include/generated/rustc_cfg
+rust_flags     = $(_rust_flags) $(modkern_rustflags) $(_rust_libs) \
+		 @$(objtree)/include/generated/rustc_cfg
 
 a_flags        = -Wp,-MMD,$(depfile) $(NOSTDINC_FLAGS) $(LINUXINCLUDE)     \
 		 $(_a_flags) $(modkern_aflags)
diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index b3a6aa8fbe8c..aab17203f5b1 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -19,7 +19,7 @@ __modfinal: $(modules:%.o=%.ko)
 	@:
 
 # modname and part-of-module are set to make c_flags define proper module flags
-modname = $(notdir $(@:.mod.o=))
+modname = $(notdir $*)
 part-of-module = y
 
 quiet_cmd_cc_o_c = CC [M]  $@
@@ -30,11 +30,16 @@ quiet_cmd_cc_o_c = CC [M]  $@
 
 ARCH_POSTLINK := $(wildcard $(srctree)/arch/$(SRCARCH)/Makefile.postlink)
 
+# Symlinks of foo.o that point to foo.foo.o are members of a .rlib archives,
+# so their exports should be added to the module
+ko_objs = $(if $(filter %$(modname).$(modname).o,$(realpath $*.o)),\
+	$(dir $*)exports_$(modname)_generated.o) $(filter %.o, $^)
+
 quiet_cmd_ld_ko_o = LD [M]  $@
       cmd_ld_ko_o +=							\
 	$(LD) -r $(KBUILD_LDFLAGS)					\
 		$(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE)		\
-		-T scripts/module.lds -o $@ $(filter %.o, $^);		\
+		-T scripts/module.lds -o $@ $(ko_objs);			\
 	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
 
 quiet_cmd_btf_ko = BTF [M] $@
-- 
2.42.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01647D8C92
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 02:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345053AbjJ0AfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 20:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJ0AfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 20:35:22 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9711D1B9;
        Thu, 26 Oct 2023 17:35:19 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6bb4abb8100so1502014b3a.2;
        Thu, 26 Oct 2023 17:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698366919; x=1698971719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pPKzZ65QPfvinxuv+XWTt04Oq7CmZo+T0ZeTj8JXU6o=;
        b=nBZBenkmrrJzeCPE6oghs17gjVDBYbzw24sJcRl2YN6loHzCi0hOtBxl8Phcudinnz
         gLjthNLz4V8YhgoYF86LEx7xSCUq2HrJvE0LHFLa85eceTHw/CRUcrHRnwFtLIjKr5Nl
         EpIevCZVTUCEikv+Jj/U9TDBMdoUQKOMQ/gn2GANaUK+KBcU5e+nrNtALcRT7zP9y7Bj
         lNtabPzgYDQSNTlpyJ+5XgynHb40X25guDozq/UCCbPcIBHO2bBRf2sw6srV6w1oO7PW
         Uj5jsw+rZGDzLxxsDFUviQBG8iWr459mHaH0kA9kSIiO670d3oauIKmpXPIFhRMBzrQM
         5HhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698366919; x=1698971719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pPKzZ65QPfvinxuv+XWTt04Oq7CmZo+T0ZeTj8JXU6o=;
        b=kNxMfGvjB+aNfDpKxqtwU2k6JmTo7CzoqcUhWppZ7fd7nqO96LwgYwlcNL2jPJQaCH
         Dw6EqrKcwSSqVEG8O89VEn52eH2oluHcKDmCFje8IjUbvKGPPm94uvnLUNVsx78p2ECx
         uYcZrrBFwAw3ALxaVaoGqilkpPL2jw1N5Gg21bdKJcvgBIQ6+j/n63aebU4s89U58QTu
         AX6sfoqBMOVsLQEReFXAINkBACs/xQZoGJuzvfS3SA9UALuJjm88RIWB7AcAAMkk5+9t
         4MOCw10FujzHZ60dm25wZVeUVPj1wpTrlg0rSjnUzxa1bi+LYEgTh3yDnykZ0GsFVDyQ
         Nrwg==
X-Gm-Message-State: AOJu0Ywjtilq/EIbqxfW2Zdeg5t2HY5mI6ZF6dH/FsL3zYOtLF3uZF0e
        R6ALp5xIXtlpgTsqKBvKNs0=
X-Google-Smtp-Source: AGHT+IEKgg+DiVjhSNIkYPYl2YEANykN1y7tn5Z3abUOzdh8Ayaa4EC2u6eMCAajWihOn3q1C/18cQ==
X-Received: by 2002:a05:6a00:124b:b0:690:2ad9:1436 with SMTP id u11-20020a056a00124b00b006902ad91436mr1323609pfi.7.1698366918834;
        Thu, 26 Oct 2023 17:35:18 -0700 (PDT)
Received: from tx3000mach.io (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id g21-20020aa78755000000b006be683108cesm183096pfo.213.2023.10.26.17.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 17:35:18 -0700 (PDT)
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
        Alice Ryhl <aliceryhl@google.com>, Andrew Davis <afd@ti.com>,
        Rob Herring <robh@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org
Subject: [RFC PATCH v2 1/2] kbuild: Build Rust crates as libraries
Date:   Thu, 26 Oct 2023 21:34:50 -0300
Message-ID: <20231027003504.146703-2-yakoyoku@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231027003504.146703-1-yakoyoku@gmail.com>
References: <20231027003504.146703-1-yakoyoku@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
v1 -> v2:
- Fixed kernel compilation.
- Added support for building crates as modules.

 .gitignore                |  2 ++
 Makefile                  |  4 ++--
 scripts/Makefile.build    | 49 +++++++++++++++++++++++++++++++++++----
 scripts/Makefile.lib      | 18 +++++++++++---
 scripts/Makefile.modfinal |  7 +++++-
 5 files changed, 70 insertions(+), 10 deletions(-)

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
index da37bfa97211..11045ddba1a9 100644
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
@@ -243,9 +244,13 @@ $(obj)/%.o: $(src)/%.c $(recordmcount_source) FORCE
 	$(call if_changed_rule,cc_o_c)
 	$(call cmd,force_checksrc)
 
+mod_objs = $(call real-search, $*.o, .o, -objs -y -m)
+exports_objs = $(foreach m, $(sort $(basename \
+	$(filter $(notdir $(rlib-m)), $(mod_objs)))), exports_$m_generated.o)
+
 # To make this rule robust against "Argument list too long" error,
 # ensure to add $(obj)/ prefix by a shell command.
-cmd_mod = printf '%s\n' $(call real-search, $*.o, .o, -objs -y -m) | \
+cmd_mod = printf '%s\n' $(mod_objs) $(exports_objs) | \
 	$(AWK) '!x[$$0]++ { print("$(obj)/"$$0) }' > $@
 
 $(obj)/%.mod: FORCE
@@ -274,7 +279,7 @@ rust_common_cmd = \
 	-Zcrate-attr='feature($(rust_allowed_features))' \
 	--extern alloc --extern kernel \
 	--crate-type rlib -L $(objtree)/rust/ \
-	--crate-name $(basename $(notdir $@)) \
+	--crate-name $(basename $(notdir $<)) \
 	--out-dir $(dir $@) --emit=dep-info=$(depfile)
 
 # `--emit=obj`, `--emit=asm` and `--emit=llvm-ir` imply a single codegen unit
@@ -285,11 +290,42 @@ rust_common_cmd = \
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
+	$(if $(findstring $@, $(rlib-y) $(rlib-m)), \
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
+		| grep -P ' (T|R|D) (?!(init|cleanup)_module)' | cut -d ' ' -f 3 \
+		| xargs -Isymbol \
+		echo 'extern int symbol; EXPORT_SYMBOL_GPL(symbol);' >> $@
+
+$(rlib-m): $(obj)/%.o: $(obj)/exports_%_generated.o $(obj)/lib%.rlib $(src)/%.rs FORCE
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
@@ -394,9 +430,14 @@ $(subdir-modorder): $(obj)/%/modules.order: $(obj)/% ;
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
index 68d0134bdbf9..3454b05dbbdc 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -45,12 +45,17 @@ else
 obj-y		:= $(filter-out %/, $(obj-y))
 endif
 
+rlib-y := $(foreach m, $(filter lib%.rlib, $(obj-y)), $(m:lib%.rlib=%.o))
+rlib-m := $(foreach m, $(filter lib%.rlib, $(obj-m)), $(m:lib%.rlib=%.o))
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
@@ -59,7 +64,7 @@ multi-obj-ym := $(multi-obj-y) $(multi-obj-m)
 
 # Replace multi-part objects by their individual parts,
 # including built-in.a from subdirectories
-real-obj-y := $(call real-search, $(obj-y), .o, -objs -y)
+real-obj-y := $(call rlib-exports, $(call real-search, $(obj-y), .o, -objs -y))
 real-obj-m := $(call real-search, $(obj-m), .o, -objs -y -m)
 
 always-y += $(always-m)
@@ -95,6 +100,8 @@ extra-y		:= $(addprefix $(obj)/,$(extra-y))
 always-y	:= $(addprefix $(obj)/,$(always-y))
 targets		:= $(addprefix $(obj)/,$(targets))
 obj-m		:= $(addprefix $(obj)/,$(obj-m))
+rlib-y		:= $(addprefix $(obj)/,$(rlib-y))
+rlib-m		:= $(addprefix $(obj)/,$(rlib-m))
 lib-y		:= $(addprefix $(obj)/,$(lib-y))
 real-obj-y	:= $(addprefix $(obj)/,$(real-obj-y))
 real-obj-m	:= $(addprefix $(obj)/,$(real-obj-m))
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
index b3a6aa8fbe8c..e05749a5ca0a 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -30,11 +30,16 @@ quiet_cmd_cc_o_c = CC [M]  $@
 
 ARCH_POSTLINK := $(wildcard $(srctree)/arch/$(SRCARCH)/Makefile.postlink)
 
+# Symlinks of foo.o that point to foo.foo.o are members of a .rlib archives,
+# so their exports should be added to the module
+ko_objs = $(foreach o, $(filter %.o, $^),$(if \
+	$(filter-out %$o,$(realpath $o)),$(dir $o)exports_$(notdir $*)_generated.o) $o)
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
2.42.0


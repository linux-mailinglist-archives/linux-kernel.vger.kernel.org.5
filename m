Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D27B7BBC3B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 17:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbjJFP5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 11:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjJFP5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 11:57:51 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F174B6;
        Fri,  6 Oct 2023 08:57:50 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c760b34d25so17896615ad.3;
        Fri, 06 Oct 2023 08:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696607870; x=1697212670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dylRp2V5hDsi4674Tiw8VLIJ52LHz+mcDjR7Zr1Bs3Y=;
        b=KRjIXQz5+/Ya8A1pTDQePtOVSP5DlMpVhnQ/w01LYosO7ncr//zOIrCLs4NfRz3DYC
         0hQgoeX46OBM0KCalXQBb8S6q4urwNrcJlfIKHsL5Hfxv6/mAQjsz9lSpG9uNRaICHR0
         OMnDoIGScsAsTwI0z/AixAM0xEMRloUD+9JYQHt1c40cOIl0F6Xl6BiMi/kxpd8XGNAH
         ak4WOt8h+4oQKztlBv6Xgb9faH7RF4zPN5qN2xu5G/mpnTeM4CkY67CNDpRUfo5nSKh2
         yTlHabnCqipVt+xqPoID+pF4jDoDNL2tMm1MSCFUimL1Dkzx6/O1VPZa2ZzPH+55hBSf
         dxBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696607870; x=1697212670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dylRp2V5hDsi4674Tiw8VLIJ52LHz+mcDjR7Zr1Bs3Y=;
        b=KWhhxOFAnllSNKCMPxQCSQFsrEXIspAVPDVeUn5wYBjrLItrpP5/4dctytuCg1rMsU
         Cbh3oETSbXlkFQF3w91oGFp5lc6CRKicnRdQg00UPu6i1TtN5rc5YPZ7O1uBjqSiSALU
         QK33I03LDWLqmoIt6Xjn3OlRiiMEqRc+rrsdP9HUoaElaATXZ4vcuWbyCKW6T/q1Ic7Q
         Fb7zZLfysIXzRri0PKui+WIUKHc0/goGq5bAbUlDX3Nkfed1yOAil5+FqcBMjiLvagd6
         YSEgQs3xCr1S3rtr9H0lwK+ii18zJCOeRKD5G6IBL3LRp6BMJp5rdlCdnJNTzb2XOGhV
         ohSg==
X-Gm-Message-State: AOJu0YzC08lnTYXM6dgqqy+8XWISClzAEPGswbtJPFAb6yxLk9WYJSX4
        OTA8LUC1+f6NTFHDTI9jEpo=
X-Google-Smtp-Source: AGHT+IG7vWiKtSobRyxTqjlRPV7HrpoBU3Ji68aWY9K+5VbFhCnthI+zOioQEBbbot/nKuljTyayAw==
X-Received: by 2002:a17:902:d2cd:b0:1c3:94a4:34bf with SMTP id n13-20020a170902d2cd00b001c394a434bfmr10084533plc.66.1696607869908;
        Fri, 06 Oct 2023 08:57:49 -0700 (PDT)
Received: from tx3000mach.io (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902eac400b001aaf2e8b1eesm4040797pld.248.2023.10.06.08.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 08:57:49 -0700 (PDT)
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
        Alice Ryhl <aliceryhl@google.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org
Subject: [RFC PATCH 1/1] scripts: Build per module Rust crates
Date:   Fri,  6 Oct 2023 12:57:37 -0300
Message-ID: <20231006155739.246381-2-yakoyoku@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231006155739.246381-1-yakoyoku@gmail.com>
References: <20231006155739.246381-1-yakoyoku@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enables compiling Rust crates as dependencies of kernel modules.

When a composite object depends on an `.rlib` file, which by the way is
a current ar archive, Kbuild will compile it from its base Rust source
and link it.

This makes possible to have Rust bindings for a subsystem that is
compiled as a module.

Signed-off-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
---
 Makefile               |  4 ++--
 scripts/Makefile.build | 10 +++++++++-
 scripts/Makefile.lib   | 19 +++++++++++++------
 3 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index 7d6be12e4c3e..7774c97e8aa0 100644
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
index da37bfa97211..627010518b27 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -246,7 +246,9 @@ $(obj)/%.o: $(src)/%.c $(recordmcount_source) FORCE
 # To make this rule robust against "Argument list too long" error,
 # ensure to add $(obj)/ prefix by a shell command.
 cmd_mod = printf '%s\n' $(call real-search, $*.o, .o, -objs -y -m) | \
-	$(AWK) '!x[$$0]++ { print("$(obj)/"$$0) }' > $@
+	$(AWK) '!x[$$0]++ { print("$(obj)/"$$0) }' > $@ && \
+	printf '%s\n' $(call real-search, $*.rlib, .rlib, -objs -y -m) | \
+	$(AWK) '!x[$$0]++ { print("--library=$(obj)/"$$0) }' >> $@
 
 $(obj)/%.mod: FORCE
 	$(call if_changed,mod)
@@ -291,6 +293,12 @@ quiet_cmd_rustc_o_rs = $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
 $(obj)/%.o: $(src)/%.rs FORCE
 	$(call if_changed_dep,rustc_o_rs)
 
+quiet_cmd_rustc_rlib_rs = $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
+      cmd_rustc_rlib_rs = $(rust_common_cmd) -Ccodegen-units=1 --emit=link=$@ $<
+
+$(obj)/%.rlib: $(src)/%.rs FORCE
+	$(call if_changed_dep,rustc_rlib_rs)
+
 quiet_cmd_rustc_rsi_rs = $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
       cmd_rustc_rsi_rs = \
 	$(rust_common_cmd) -Zunpretty=expanded $< >$@; \
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 68d0134bdbf9..6e8cfbad015d 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -53,14 +53,18 @@ multi-search = $(sort $(foreach m, $1, $(if $(call suffix-search, $m, $2, $3 -),
 real-search = $(foreach m, $1, $(if $(call suffix-search, $m, $2, $3 -), $(call suffix-search, $m, $2, $3), $m))
 
 # If $(foo-objs), $(foo-y), $(foo-m), or $(foo-) exists, foo.o is a composite object
-multi-obj-y := $(call multi-search, $(obj-y), .o, -objs -y)
-multi-obj-m := $(call multi-search, $(obj-m), .o, -objs -y -m)
+multi-obj-y := $(call multi-search, $(obj-y), .o, -objs -y) \
+	$(call multi-search, $(obj-y), .rlib, -objs -y)
+multi-obj-m := $(call multi-search, $(obj-m), .o, -objs -y -m) \
+	$(call multi-search, $(obj-m), .rlib, -objs -y -m)
 multi-obj-ym := $(multi-obj-y) $(multi-obj-m)
 
 # Replace multi-part objects by their individual parts,
 # including built-in.a from subdirectories
-real-obj-y := $(call real-search, $(obj-y), .o, -objs -y)
-real-obj-m := $(call real-search, $(obj-m), .o, -objs -y -m)
+real-obj-y := $(call real-search, $(obj-y), .o, -objs -y) \
+	$(call real-search, $(obj-y), .rlib, -objs -y)
+real-obj-m := $(call real-search, $(obj-m), .o, -objs -y -m) \
+	$(call real-search, $(obj-m), .rlib, -objs -y -m)
 
 always-y += $(always-m)
 
@@ -107,7 +111,8 @@ endif
 # Finds the multi-part object the current object will be linked into.
 # If the object belongs to two or more multi-part objects, list them all.
 modname-multi = $(sort $(foreach m,$(multi-obj-ym),\
-		$(if $(filter $*.o, $(call suffix-search, $m, .o, -objs -y -m)),$(m:.o=))))
+		$(if $(filter $*.o, $(call suffix-search, $m, .o, -objs -y -m)),$(m:.o=)) \
+		$(if $(filter $*.rlib, $(call suffix-search, $m, .rlib, -objs -y -m)),$(m:.rlib=))))
 
 __modname = $(or $(modname-multi),$(basetarget))
 
@@ -210,7 +215,9 @@ _cpp_flags += -I $(srctree)/$(src) -I $(objtree)/$(obj)
 endif
 endif
 
-part-of-module = $(if $(filter $(basename $@).o, $(real-obj-m)),y)
+part-of-module =                                             \
+	$(if $(or $(filter $(basename $@).o, $(real-obj-m)), \
+		$(filter $(basename $@).rlib, $(real-obj-m))),y)
 quiet_modtag = $(if $(part-of-module),[M],   )
 
 modkern_cflags =                                          \
-- 
2.42.0


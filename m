Return-Path: <linux-kernel+bounces-20827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2CA8285C0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB2ECB21F15
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B68B381CB;
	Tue,  9 Jan 2024 12:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwGYdl4H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CCF381AE;
	Tue,  9 Jan 2024 12:07:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1249C43399;
	Tue,  9 Jan 2024 12:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704802069;
	bh=uYa16IEEJlpGSqmjAAvT3Wz06Y8oSxPf78zrq9xQRVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XwGYdl4HWKvN8WrzDx3lBhxVXf5qH1spEwHoYUj3ccjxwKAV4WRIaPZKTIEGC2wyy
	 QBsnfn0mZjYKOy+WL31y6zNIxrxOPiGKjsQtnwUudrcEATTDC72xsiHaVlGCv8FXuM
	 biu2JsE7ln2jHOP8ca15tQ2fOUB6ap3eEWgPsMOP1VAME1vDgwZ4QDkaj2QbJFj1PW
	 8sEkFEsJmelRjvGYA0SETCicU4kAi492LCdA5i2WoH5jkLXdyklKEFXSGkVWU/7JDb
	 7bGoqfOibgebZ4Y0gfWYGtehPlFBZt0ohiA5URPt6vII3IpyGpSJG71a6Ws47cPEn2
	 SgT4OAuQ+IxDg==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Simon Glass <sjg@chromium.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] kbuild: create a list of all built DTB files
Date: Tue,  9 Jan 2024 21:07:34 +0900
Message-Id: <20240109120738.346061-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240109120738.346061-1-masahiroy@kernel.org>
References: <20240109120738.346061-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is useful to have a list of all *.dtb and *.dtbo files generated
from the current build.

With this commit, 'make dtbs' creates arch/*/boot/dts/dtbs-order, which
lists the dtb(o) files created in the current build. It maintains the
order of the dtb-y additions in Makefiles although the order is not
important for DTBs. It is a (good) side effect through the reuse of the
modules.order rule.

Please note this list only includes the files directly added to dtb-y.

For example, consider this case:

    foo-dtbs := foo_base.dtb foo_overlay.dtbo
    dtb-y := foo.dtb

In this example, the list will include foo.dtb, but not foo_base.dtb
or foo_overlay.dtbo.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 .gitignore             |  1 +
 Makefile               |  4 ++--
 scripts/Makefile.build | 20 ++++++++++++--------
 scripts/Makefile.lib   |  6 ++++++
 4 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/.gitignore b/.gitignore
index 689a4fa3f547..c59dc60ba62e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -52,6 +52,7 @@
 *.xz
 *.zst
 Module.symvers
+dtbs-list
 modules.order
 
 #
diff --git a/Makefile b/Makefile
index 6204a3803a90..db7f9e34a24e 100644
--- a/Makefile
+++ b/Makefile
@@ -1389,7 +1389,7 @@ ifneq ($(dtstree),)
 
 PHONY += dtbs dtbs_prepare dtbs_install dtbs_check
 dtbs: dtbs_prepare
-	$(Q)$(MAKE) $(build)=$(dtstree)
+	$(Q)$(MAKE) $(build)=$(dtstree) need-dtbslist=1
 
 # include/config/kernel.release is actually needed when installing DTBs because
 # INSTALL_DTBS_PATH contains $(KERNELRELEASE). However, we do not want to make
@@ -1927,7 +1927,7 @@ clean: $(clean-dirs)
 		-o -name '*.ko.*' \
 		-o -name '*.dtb' -o -name '*.dtbo' \
 		-o -name '*.dtb.S' -o -name '*.dtbo.S' \
-		-o -name '*.dt.yaml' \
+		-o -name '*.dt.yaml' -o -name 'dtbs-list' \
 		-o -name '*.dwo' -o -name '*.lst' \
 		-o -name '*.su' -o -name '*.mod' \
 		-o -name '.*.d' -o -name '.*.tmp' -o -name '*.mod.c' \
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 9a3063735e71..d23797dbca0f 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -71,6 +71,7 @@ endif
 # subdir-builtin and subdir-modorder may contain duplications. Use $(sort ...)
 subdir-builtin := $(sort $(filter %/built-in.a, $(real-obj-y)))
 subdir-modorder := $(sort $(filter %/modules.order, $(obj-m)))
+subdir-dtbslist := $(sort $(filter %/dtbs-list, $(dtb-y)))
 
 targets-for-builtin := $(extra-y)
 
@@ -387,6 +388,7 @@ $(obj)/%.asn1.c $(obj)/%.asn1.h: $(src)/%.asn1 $(objtree)/scripts/asn1_compiler
 # To build objects in subdirs, we need to descend into the directories
 $(subdir-builtin): $(obj)/%/built-in.a: $(obj)/% ;
 $(subdir-modorder): $(obj)/%/modules.order: $(obj)/% ;
+$(subdir-dtbslist): $(obj)/%/dtbs-list: $(obj)/% ;
 
 #
 # Rule to compile a set of .o files into one .a file (without symbol table)
@@ -403,19 +405,21 @@ $(obj)/built-in.a: $(real-obj-y) FORCE
 	$(call if_changed,ar_builtin)
 
 #
-# Rule to create modules.order file
+# Rule to create modules.order and dtbs-list
 #
-# Create commands to either record .ko file or cat modules.order from
-# a subdirectory
-# Add $(obj-m) as the prerequisite to avoid updating the timestamp of
-# modules.order unless contained modules are updated.
+# This is a list of build artifacts (module or dtb) from the current Makefile
+# and its sub-directories. The timestamp should be updated when any of the
+# member files.
 
-cmd_modules_order = { $(foreach m, $(real-prereqs), \
-	$(if $(filter %/modules.order, $m), cat $m, echo $m);) :; } \
+cmd_gen_order = { $(foreach m, $(real-prereqs), \
+	$(if $(filter %/$(notdir $@), $m), cat $m, echo $m);) :; } \
 	> $@
 
 $(obj)/modules.order: $(obj-m) FORCE
-	$(call if_changed,modules_order)
+	$(call if_changed,gen_order)
+
+$(obj)/dtbs-list: $(dtb-y) FORCE
+	$(call if_changed,gen_order)
 
 #
 # Rule to compile a set of .o files into one .a file (with symbol table)
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index cd5b181060f1..b35d39022a30 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -45,6 +45,11 @@ else
 obj-y		:= $(filter-out %/, $(obj-y))
 endif
 
+ifdef need-dtbslist
+dtb-y		+= $(addsuffix /dtbs-list, $(subdir-ym))
+always-y	+= dtbs-list
+endif
+
 # Expand $(foo-objs) $(foo-y) etc. by replacing their individuals
 suffix-search = $(strip $(foreach s, $3, $($(1:%$(strip $2)=%$s))))
 # List composite targets that are constructed by combining other targets
@@ -99,6 +104,7 @@ lib-y		:= $(addprefix $(obj)/,$(lib-y))
 real-obj-y	:= $(addprefix $(obj)/,$(real-obj-y))
 real-obj-m	:= $(addprefix $(obj)/,$(real-obj-m))
 multi-obj-m	:= $(addprefix $(obj)/, $(multi-obj-m))
+dtb-y		:= $(addprefix $(obj)/, $(dtb-y))
 multi-dtb-y	:= $(addprefix $(obj)/, $(multi-dtb-y))
 real-dtb-y	:= $(addprefix $(obj)/, $(real-dtb-y))
 subdir-ym	:= $(addprefix $(obj)/,$(subdir-ym))
-- 
2.40.1



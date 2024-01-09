Return-Path: <linux-kernel+bounces-20828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9A68285C3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C42628734D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B81F38DDD;
	Tue,  9 Jan 2024 12:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZhQQiq1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559C5381A2;
	Tue,  9 Jan 2024 12:07:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A43C43390;
	Tue,  9 Jan 2024 12:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704802071;
	bh=0i7egdX2nZv01YOBcXbZOK2my3bgeNy9DuIuiyc852c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JZhQQiq16hZd3VAds5HeEend/8zOji+3Gy2B7/Z153/q/SYl++wP8N2JJe3yotR6j
	 HCmmjQoUyKBXQkp0JfNUyJ+GBoH5l3unv7bPQgNYngXx4xzLkFnz4iDgBtIVt2d7wi
	 3CY/3m9IJ5uRNQe7QN8VaGs6UWL+uXn1F5TL/VB3p13Tnz/RpQmEyPn0bz0qo7KudX
	 cWMaexrdMZNFdjWCRtBRu4SOKukeZ2dMddOSB5z1wdEXOgxdjYR9frnhfHm5rjyBwd
	 LiZKQ35fZ0RDfg2OHvoxUSzZZENM1c0N9yxTdr6Y2ERIPuugu4Yi/zbzcuX0s00b09
	 e5/pRgqlLb+LA==
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
Subject: [PATCH 2/4] kbuild: simplify dtbs_install by reading the list of compiled DTBs
Date: Tue,  9 Jan 2024 21:07:35 +0900
Message-Id: <20240109120738.346061-3-masahiroy@kernel.org>
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

Retrieve the list of *.dtb(o) files from arch/*/boot/dts/dtbs-list
instead of traversing the directory tree again.

Please note that 'make dtbs_install' installs *.dtb(o) files directly
added to dtb-y because scripts/Makefile.dtbinst installs $(dtb-y)
without expanding the -dtbs suffix.

This commit preserves this behavior.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile                 |  2 +-
 scripts/Kbuild.include   |  6 ------
 scripts/Makefile.dtbinst | 32 ++++++++++++++++++--------------
 3 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/Makefile b/Makefile
index db7f9e34a24e..dae6825b8082 100644
--- a/Makefile
+++ b/Makefile
@@ -1407,7 +1407,7 @@ endif
 dtbs_check: dtbs
 
 dtbs_install:
-	$(Q)$(MAKE) $(dtbinst)=$(dtstree) dst=$(INSTALL_DTBS_PATH)
+	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.dtbinst obj=$(dtstree)
 
 ifdef CONFIG_OF_EARLY_FLATTREE
 all: dtbs
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 7778cc97a4e0..2f331879816b 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -113,12 +113,6 @@ endef
 # $(Q)$(MAKE) $(build)=dir
 build := -f $(srctree)/scripts/Makefile.build obj
 
-###
-# Shorthand for $(Q)$(MAKE) -f scripts/Makefile.dtbinst obj=
-# Usage:
-# $(Q)$(MAKE) $(dtbinst)=dir
-dtbinst := -f $(srctree)/scripts/Makefile.dtbinst obj
-
 ###
 # Shorthand for $(Q)$(MAKE) -f scripts/Makefile.clean obj=
 # Usage:
diff --git a/scripts/Makefile.dtbinst b/scripts/Makefile.dtbinst
index 4405d5b67578..67956f6496a5 100644
--- a/scripts/Makefile.dtbinst
+++ b/scripts/Makefile.dtbinst
@@ -8,32 +8,36 @@
 #   $INSTALL_PATH/dtbs/$KERNELRELEASE
 # ==========================================================================
 
-src := $(obj)
-
 PHONY := __dtbs_install
 __dtbs_install:
 
 include include/config/auto.conf
 include $(srctree)/scripts/Kbuild.include
-include $(kbuild-file)
 
-dtbs    := $(addprefix $(dst)/, $(dtb-y) $(if $(CONFIG_OF_ALL_DTBS),$(dtb-)))
-subdirs := $(addprefix $(obj)/, $(subdir-y) $(subdir-m))
-
-__dtbs_install: $(dtbs) $(subdirs)
-	@:
+dst := $(INSTALL_DTBS_PATH)
 
 quiet_cmd_dtb_install = INSTALL $@
       cmd_dtb_install = install -D $< $@
 
-$(dst)/%.dtb: $(obj)/%.dtb
+$(dst)/%: $(obj)/%
 	$(call cmd,dtb_install)
 
-$(dst)/%.dtbo: $(obj)/%.dtbo
-	$(call cmd,dtb_install)
+dtbs := $(patsubst $(obj)/%,%,$(call read-file, $(obj)/dtbs-list))
 
-PHONY += $(subdirs)
-$(subdirs):
-	$(Q)$(MAKE) $(dtbinst)=$@ dst=$(if $(CONFIG_ARCH_WANT_FLAT_DTB_INSTALL),$(dst),$(patsubst $(obj)/%,$(dst)/%,$@))
+ifdef CONFIG_ARCH_WANT_FLAT_DTB_INSTALL
+
+define gen_install_rules
+$(dst)/%: $(obj)/$(1)%
+	$$(call cmd,dtb_install)
+endef
+
+$(foreach d, $(sort $(dir $(dtbs))), $(eval $(call gen_install_rules,$(d))))
+
+dtbs := $(notdir $(dtbs))
+
+endif # CONFIG_ARCH_WANT_FLAT_DTB_INSTALL
+
+__dtbs_install: $(addprefix $(dst)/, $(dtbs))
+	@:
 
 .PHONY: $(PHONY)
-- 
2.40.1



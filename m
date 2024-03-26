Return-Path: <linux-kernel+bounces-119212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C581588C5BE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C89F1F6213A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE14A13C806;
	Tue, 26 Mar 2024 14:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TU8StDAF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8A9763E6;
	Tue, 26 Mar 2024 14:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464585; cv=none; b=c2LjnqB/3nids4LYCCRETjxWFAWpkgcINPdH2KMkee4bzeQByyQIwTXsDtjL2mVw5zsccf/yNDPaVfs7oaa7W467g1cJ+YEFPvD7/N6MUq3oGI1V2XUf2uawOtQvpm10LInqUoF4LwyagFWU738T2fmzEXHVpOVCYdqKZgix2v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464585; c=relaxed/simple;
	bh=lDWiD7+nw474pdvcvkBIm1FE6rlA0anUmxKsPlaP/CQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QqMfy4QgI7r/N6cjS95uDdewadCRk74del3BOBnkZDVXC8emUMUEWqX7bSGexRxpi0NuV0LfxZhHD9NIhgYkzM+0o4sREVUXlt0oEPjymuvfbh5jGfFQZIaAMACvi7KrpnZzTYxtPrgf9sRtvFwLJ++s2voR/T5ntmiWywMUF7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TU8StDAF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F44C433C7;
	Tue, 26 Mar 2024 14:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711464585;
	bh=lDWiD7+nw474pdvcvkBIm1FE6rlA0anUmxKsPlaP/CQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TU8StDAF6hFrF/NLuivrhqNn7caz5dOF+e1Bdm1h+X+faqh0YN5MlOabmNrOYgouD
	 5d5mnrfmNj1BrU/iqcsYqlCwekPmTDr3yH3HHuY4H7PSRmSIx1HhlN7zgsBg5qXcxc
	 tQjCg8v3djrN3YihebJ5ueIHSkU+cgHiJ8ReDlZKqdNrDC0Gsl16TdmpVzBDRCS2nc
	 2pgcOe74ycfq0RIXyDLUl18vRjh6EjpSuZS79NfVPHJokzs1F6eUtKXm6WSkjnvW8W
	 Y39zsyCYQp6NAdqYk8Q+1xQP1WmAx00xm+7QiUDyjp/78HosxzaUjZQO/zDdEkDylp
	 aHSiI8JdeysZg==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kbuild@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Harry Wentland <harry.wentland@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Linus Walleij <linus.walleij@linaro.org>,
	Joel Stanley <joel@jms.id.au>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nicolas@fjasle.eu>,
	Arnd Bergmann <arnd@arndb.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-mm@kvack.org,
	llvm@lists.linux.dev
Subject: [PATCH 01/12] kbuild: make -Woverride-init warnings more consistent
Date: Tue, 26 Mar 2024 15:47:16 +0100
Message-Id: <20240326144741.3094687-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240326144741.3094687-1-arnd@kernel.org>
References: <20240326144741.3094687-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The -Woverride-init warn about code that may be intentional or not,
but the inintentional ones tend to be real bugs, so there is a bit of
disagreement on whether this warning option should be enabled by default
and we have multiple settings in scripts/Makefile.extrawarn as well as
individual subsystems.

Older versions of clang only supported -Wno-initializer-overrides with
the same meaning as gcc's -Woverride-init, though all supported versions
now work with both. Because of this difference, an earlier cleanup of
mine accidentally turned the clang warning off for W=1 builds and only
left it on for W=2, while it's still enabled for gcc with W=1.

There is also one driver that only turns the warning off for newer
versions of gcc but not other compilers, and some but not all the
Makefiles still use a cc-disable-warning conditional that is no
longer needed with supported compilers here.

Address all of the above by removing the special cases for clang
and always turning the warning off unconditionally where it got
in the way, using the syntax that is supported by both compilers.

Fixes: 2cd3271b7a31 ("kbuild: avoid duplicate warning options")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/display/dc/dce110/Makefile |  2 +-
 drivers/gpu/drm/amd/display/dc/dce112/Makefile |  2 +-
 drivers/gpu/drm/amd/display/dc/dce120/Makefile |  2 +-
 drivers/gpu/drm/amd/display/dc/dce60/Makefile  |  2 +-
 drivers/gpu/drm/amd/display/dc/dce80/Makefile  |  2 +-
 drivers/gpu/drm/i915/Makefile                  |  6 +++---
 drivers/gpu/drm/xe/Makefile                    |  4 ++--
 drivers/net/ethernet/renesas/sh_eth.c          |  2 +-
 drivers/pinctrl/aspeed/Makefile                |  2 +-
 fs/proc/Makefile                               |  2 +-
 kernel/bpf/Makefile                            |  2 +-
 mm/Makefile                                    |  3 +--
 scripts/Makefile.extrawarn                     | 10 +++-------
 13 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/Makefile b/drivers/gpu/drm/amd/display/dc/dce110/Makefile
index f0777d61c2cb..c307f040e48f 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dce110/Makefile
@@ -23,7 +23,7 @@
 # Makefile for the 'controller' sub-component of DAL.
 # It provides the control and status of HW CRTC block.
 
-CFLAGS_$(AMDDALPATH)/dc/dce110/dce110_resource.o = $(call cc-disable-warning, override-init)
+CFLAGS_$(AMDDALPATH)/dc/dce110/dce110_resource.o = -Wno-override-init
 
 DCE110 = dce110_timing_generator.o \
 dce110_compressor.o dce110_opp_regamma_v.o \
diff --git a/drivers/gpu/drm/amd/display/dc/dce112/Makefile b/drivers/gpu/drm/amd/display/dc/dce112/Makefile
index 7e92effec894..683866797709 100644
--- a/drivers/gpu/drm/amd/display/dc/dce112/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dce112/Makefile
@@ -23,7 +23,7 @@
 # Makefile for the 'controller' sub-component of DAL.
 # It provides the control and status of HW CRTC block.
 
-CFLAGS_$(AMDDALPATH)/dc/dce112/dce112_resource.o = $(call cc-disable-warning, override-init)
+CFLAGS_$(AMDDALPATH)/dc/dce112/dce112_resource.o = -Wno-override-init
 
 DCE112 = dce112_compressor.o
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce120/Makefile b/drivers/gpu/drm/amd/display/dc/dce120/Makefile
index 1e3ef68a452a..8f508e662748 100644
--- a/drivers/gpu/drm/amd/display/dc/dce120/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dce120/Makefile
@@ -24,7 +24,7 @@
 # It provides the control and status of HW CRTC block.
 
 
-CFLAGS_$(AMDDALPATH)/dc/dce120/dce120_resource.o = $(call cc-disable-warning, override-init)
+CFLAGS_$(AMDDALPATH)/dc/dce120/dce120_resource.o = -Wno-override-init
 
 DCE120 = dce120_timing_generator.o
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce60/Makefile b/drivers/gpu/drm/amd/display/dc/dce60/Makefile
index fee331accc0e..eede83ad91fa 100644
--- a/drivers/gpu/drm/amd/display/dc/dce60/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dce60/Makefile
@@ -23,7 +23,7 @@
 # Makefile for the 'controller' sub-component of DAL.
 # It provides the control and status of HW CRTC block.
 
-CFLAGS_$(AMDDALPATH)/dc/dce60/dce60_resource.o = $(call cc-disable-warning, override-init)
+CFLAGS_$(AMDDALPATH)/dc/dce60/dce60_resource.o = -Wno-override-init
 
 DCE60 = dce60_timing_generator.o dce60_hw_sequencer.o \
 	dce60_resource.o
diff --git a/drivers/gpu/drm/amd/display/dc/dce80/Makefile b/drivers/gpu/drm/amd/display/dc/dce80/Makefile
index 7eefffbdc925..fba189d26652 100644
--- a/drivers/gpu/drm/amd/display/dc/dce80/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dce80/Makefile
@@ -23,7 +23,7 @@
 # Makefile for the 'controller' sub-component of DAL.
 # It provides the control and status of HW CRTC block.
 
-CFLAGS_$(AMDDALPATH)/dc/dce80/dce80_resource.o = $(call cc-disable-warning, override-init)
+CFLAGS_$(AMDDALPATH)/dc/dce80/dce80_resource.o = -Wno-override-init
 
 DCE80 = dce80_timing_generator.o
 
diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
index 3ef6ed41e62b..4c2f85632391 100644
--- a/drivers/gpu/drm/i915/Makefile
+++ b/drivers/gpu/drm/i915/Makefile
@@ -33,9 +33,9 @@ endif
 subdir-ccflags-$(CONFIG_DRM_I915_WERROR) += -Werror
 
 # Fine grained warnings disable
-CFLAGS_i915_pci.o = $(call cc-disable-warning, override-init)
-CFLAGS_display/intel_display_device.o = $(call cc-disable-warning, override-init)
-CFLAGS_display/intel_fbdev.o = $(call cc-disable-warning, override-init)
+CFLAGS_i915_pci.o = -Wno-override-init
+CFLAGS_display/intel_display_device.o = -Wno-override-init
+CFLAGS_display/intel_fbdev.o = -Wno-override-init
 
 # Support compiling the display code separately for both i915 and xe
 # drivers. Define I915 when building i915.
diff --git a/drivers/gpu/drm/xe/Makefile b/drivers/gpu/drm/xe/Makefile
index 5a428ca00f10..c29a850859ad 100644
--- a/drivers/gpu/drm/xe/Makefile
+++ b/drivers/gpu/drm/xe/Makefile
@@ -172,8 +172,8 @@ subdir-ccflags-$(CONFIG_DRM_XE_DISPLAY) += \
 	-Ddrm_i915_gem_object=xe_bo \
 	-Ddrm_i915_private=xe_device
 
-CFLAGS_i915-display/intel_fbdev.o = $(call cc-disable-warning, override-init)
-CFLAGS_i915-display/intel_display_device.o = $(call cc-disable-warning, override-init)
+CFLAGS_i915-display/intel_fbdev.o = -Wno-override-init
+CFLAGS_i915-display/intel_display_device.o = -Wno-override-init
 
 # Rule to build SOC code shared with i915
 $(obj)/i915-soc/%.o: $(srctree)/drivers/gpu/drm/i915/soc/%.c FORCE
diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
index 475e1e8c1d35..0786eb0da391 100644
--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -50,7 +50,7 @@
  * the macros available to do this only define GCC 8.
  */
 __diag_push();
-__diag_ignore(GCC, 8, "-Woverride-init",
+__diag_ignore_all("-Woverride-init",
 	      "logic to initialize all and then override some is OK");
 static const u16 sh_eth_offset_gigabit[SH_ETH_MAX_REGISTER_OFFSET] = {
 	SH_ETH_OFFSET_DEFAULTS,
diff --git a/drivers/pinctrl/aspeed/Makefile b/drivers/pinctrl/aspeed/Makefile
index 489ea1778353..db2a7600ae2b 100644
--- a/drivers/pinctrl/aspeed/Makefile
+++ b/drivers/pinctrl/aspeed/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 # Aspeed pinctrl support
 
-ccflags-y += $(call cc-option,-Woverride-init)
+ccflags-y += -Woverride-init
 obj-$(CONFIG_PINCTRL_ASPEED)	+= pinctrl-aspeed.o pinmux-aspeed.o
 obj-$(CONFIG_PINCTRL_ASPEED_G4)	+= pinctrl-aspeed-g4.o
 obj-$(CONFIG_PINCTRL_ASPEED_G5)	+= pinctrl-aspeed-g5.o
diff --git a/fs/proc/Makefile b/fs/proc/Makefile
index bd08616ed8ba..7b4db9c56e6a 100644
--- a/fs/proc/Makefile
+++ b/fs/proc/Makefile
@@ -5,7 +5,7 @@
 
 obj-y   += proc.o
 
-CFLAGS_task_mmu.o	+= $(call cc-option,-Wno-override-init,)
+CFLAGS_task_mmu.o	+= -Wno-override-init
 proc-y			:= nommu.o task_nommu.o
 proc-$(CONFIG_MMU)	:= task_mmu.o
 
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 368c5d86b5b7..e497011261b8 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -4,7 +4,7 @@ ifneq ($(CONFIG_BPF_JIT_ALWAYS_ON),y)
 # ___bpf_prog_run() needs GCSE disabled on x86; see 3193c0836f203 for details
 cflags-nogcse-$(CONFIG_X86)$(CONFIG_CC_IS_GCC) := -fno-gcse
 endif
-CFLAGS_core.o += $(call cc-disable-warning, override-init) $(cflags-nogcse-yy)
+CFLAGS_core.o += -Wno-override-init $(cflags-nogcse-yy)
 
 obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o log.o token.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_iter.o map_iter.o task_iter.o prog_iter.o link_iter.o
diff --git a/mm/Makefile b/mm/Makefile
index e4b5b75aaec9..4abb40b911ec 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -29,8 +29,7 @@ KCOV_INSTRUMENT_mmzone.o := n
 KCOV_INSTRUMENT_vmstat.o := n
 KCOV_INSTRUMENT_failslab.o := n
 
-CFLAGS_init-mm.o += $(call cc-disable-warning, override-init)
-CFLAGS_init-mm.o += $(call cc-disable-warning, initializer-overrides)
+CFLAGS_init-mm.o += -Wno-override-init
 
 mmu-y			:= nommu.o
 mmu-$(CONFIG_MMU)	:= highmem.o memory.o mincore.o \
diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 3ce5d503a6da..c5af566e911a 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -114,6 +114,8 @@ KBUILD_CFLAGS += $(call cc-disable-warning, format-overflow)
 KBUILD_CFLAGS += $(call cc-disable-warning, format-truncation)
 KBUILD_CFLAGS += $(call cc-disable-warning, stringop-truncation)
 
+KBUILD_CFLAGS += -Wno-override-init # alias for -Wno-initializer-overrides in clang
+
 ifdef CONFIG_CC_IS_CLANG
 # Clang before clang-16 would warn on default argument promotions.
 ifneq ($(call clang-min-version, 160000),y)
@@ -151,10 +153,6 @@ KBUILD_CFLAGS += -Wtype-limits
 KBUILD_CFLAGS += $(call cc-option, -Wmaybe-uninitialized)
 KBUILD_CFLAGS += $(call cc-option, -Wunused-macros)
 
-ifdef CONFIG_CC_IS_CLANG
-KBUILD_CFLAGS += -Winitializer-overrides
-endif
-
 KBUILD_CPPFLAGS += -DKBUILD_EXTRA_WARN2
 
 else
@@ -164,9 +162,7 @@ KBUILD_CFLAGS += -Wno-missing-field-initializers
 KBUILD_CFLAGS += -Wno-type-limits
 KBUILD_CFLAGS += -Wno-shift-negative-value
 
-ifdef CONFIG_CC_IS_CLANG
-KBUILD_CFLAGS += -Wno-initializer-overrides
-else
+ifdef CONFIG_CC_IS_GCC
 KBUILD_CFLAGS += -Wno-maybe-uninitialized
 endif
 
-- 
2.39.2



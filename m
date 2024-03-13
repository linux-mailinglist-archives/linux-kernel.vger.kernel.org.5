Return-Path: <linux-kernel+bounces-102058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E814087AE0C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 263C91C22279
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DF9157E65;
	Wed, 13 Mar 2024 16:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8B0EHMd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4CB15698F;
	Wed, 13 Mar 2024 16:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348437; cv=none; b=mqJDoWfXIjX7X4lE+OHGkcusM1ST3d0+qxCNoczWnefMgsutIo1zwMOLbYC/RpOq98yk8rLL55azYuR+F9aLmD4a72nph/DYyVtHHvpJVVPUm16/sg8/mfOCMrBwCHfD4LKOELl+iqvztDxZ3AUDd3NZ2xo5c7iZ4pdb309/lfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348437; c=relaxed/simple;
	bh=aIRckklprcjrKa5eh6He5Pc9CpbUWiX2S4adw6PMp1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NRxoU8g2skXPTCjilMCwXDPRnFYRiLZYgbeuCgh1RhHWL4vVBoukzj/6UgBhImAybFKxcjyP56kxC/9tLnekC1qDSrrBvjeLp9j8briMlg785VexISAwIVOeIFGf4And2G69pQU5Yr4lsNw50mpzERS2NRuF6HdjfB2BrlAgMwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8B0EHMd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D68C433F1;
	Wed, 13 Mar 2024 16:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348437;
	bh=aIRckklprcjrKa5eh6He5Pc9CpbUWiX2S4adw6PMp1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J8B0EHMdRVN63TkS0UXeYyQ3tXYIh3sqRspNenZYobT73dr9gw0l3+p3/nvUxmrgd
	 PxDCh1qiYqbyST+LUg0JNf2qUnFe1p+YW42pVuXTXi7HNjAOGqs95rJPvy2yLb3V/a
	 +7nun26jG6aNz0Y69QDQocap/HlDOo6ixr6SO3rh7RNOG9dK/6TZo4dCptp8AQtG/w
	 zuldxPo11C7/M/j173bkKjzZo4x2YCzcYSlsZC8GRdqQVMKuUPWNcptl6BglQ/wiH1
	 /dZ1LFewWofG1qbfSxbohvxJLqyC9GexH9+OZd/Mc+9e6sgyckeI7//JAyalzBYCxI
	 FM0WIC4U78LeA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Richard Weinberger <richard@nod.at>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 32/73] um: allow not setting extra rpaths in the linux binary
Date: Wed, 13 Mar 2024 12:45:59 -0400
Message-ID: <20240313164640.616049-33-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164640.616049-1-sashal@kernel.org>
References: <20240313164640.616049-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.213-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.213-rc1
X-KernelTest-Deadline: 2024-03-15T16:46+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 386093c68ba3e8bcfe7f46deba901e0e80713c29 ]

There doesn't seem to be any reason for the rpath being set in
the binaries, at on systems that I tested on. On the other hand,
setting rpath is actually harming binaries in some cases, e.g.
if using nix-based compilation environments where /lib & /lib64
are not part of the actual environment.

Add a new Kconfig option (under EXPERT, for less user confusion)
that allows disabling the rpath additions.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Stable-dep-of: 846cfbeed09b ("um: Fix adding '-no-pie' for clang")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/Kconfig      | 13 +++++++++++++
 arch/um/Makefile     |  3 ++-
 arch/x86/Makefile.um |  2 +-
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index eb1c6880bde49..20264b47dcffc 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -92,6 +92,19 @@ config LD_SCRIPT_DYN
 	depends on !LD_SCRIPT_STATIC
 	select MODULE_REL_CRCS if MODVERSIONS
 
+config LD_SCRIPT_DYN_RPATH
+	bool "set rpath in the binary" if EXPERT
+	default y
+	depends on LD_SCRIPT_DYN
+	help
+	  Add /lib (and /lib64 for 64-bit) to the linux binary's rpath
+	  explicitly.
+
+	  You may need to turn this off if compiling for nix systems
+	  that have their libraries in random /nix directories and
+	  might otherwise unexpected use libraries from /lib or /lib64
+	  instead of the desired ones.
+
 config HOSTFS
 	tristate "Host filesystem"
 	help
diff --git a/arch/um/Makefile b/arch/um/Makefile
index 56e5320da7624..4211e23a2f68f 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -118,7 +118,8 @@ archprepare:
 	$(Q)$(MAKE) $(build)=$(HOST_DIR)/um include/generated/user_constants.h
 
 LINK-$(CONFIG_LD_SCRIPT_STATIC) += -static
-LINK-$(CONFIG_LD_SCRIPT_DYN) += -Wl,-rpath,/lib $(call cc-option, -no-pie)
+LINK-$(CONFIG_LD_SCRIPT_DYN) += $(call cc-option, -no-pie)
+LINK-$(CONFIG_LD_SCRIPT_DYN_RPATH) += -Wl,-rpath,/lib
 
 CFLAGS_NO_HARDENING := $(call cc-option, -fno-PIC,) $(call cc-option, -fno-pic,) \
 	-fno-stack-protector $(call cc-option, -fno-stack-protector-all)
diff --git a/arch/x86/Makefile.um b/arch/x86/Makefile.um
index 1db7913795f51..b3c1ae084180d 100644
--- a/arch/x86/Makefile.um
+++ b/arch/x86/Makefile.um
@@ -44,7 +44,7 @@ ELF_FORMAT := elf64-x86-64
 
 # Not on all 64-bit distros /lib is a symlink to /lib64. PLD is an example.
 
-LINK-$(CONFIG_LD_SCRIPT_DYN) += -Wl,-rpath,/lib64
+LINK-$(CONFIG_LD_SCRIPT_DYN_RPATH) += -Wl,-rpath,/lib64
 LINK-y += -m64
 
 endif
-- 
2.43.0



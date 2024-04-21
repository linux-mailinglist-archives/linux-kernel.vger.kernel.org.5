Return-Path: <linux-kernel+bounces-152486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 998698ABF24
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 14:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 192461F21108
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 12:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD151429B;
	Sun, 21 Apr 2024 12:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0oOt+64"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8F2134B1;
	Sun, 21 Apr 2024 12:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713701313; cv=none; b=g5JdBpeK0mFEDIrnfFQdioaMug8PtZaYPoEJCHAiQ7bXxKvx/+gcTEtjBkZgi/gF3xKYPqTWuWOoSsDy3VMiJt6hAgWkV/mvht7WksD9TgyfxY1+o8+Pu2YMACep4LV6xcETzAuPWNtk9+psiSr6/K+gE51UwuInR4iW+vURgIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713701313; c=relaxed/simple;
	bh=5pdOG3fqB9EcBpM+IoDRFdTWt7Wc0FiNnfI3JC9igOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MGFj1/a5dKonQ3t9M0EzSm9OhoOkGZYUOKG0ImhRMNEuJy6QwEzNx/PskMOKIwmtJ7FItLdr5GoW2YJtFVMWNp8VFILfwaPqnWpXrKWfPKWQPCYIg2D7UakO8Y0Ld+sZQT4gW8sBPVyLDuKc/sL4dr12o6Lw6+d/xayTq9QdC8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0oOt+64; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71B1C2BD10;
	Sun, 21 Apr 2024 12:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713701312;
	bh=5pdOG3fqB9EcBpM+IoDRFdTWt7Wc0FiNnfI3JC9igOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b0oOt+64fb2EielyhtFl7k7aANFhZT378KUu8c1XVSK5Mov4yr839kX5d9FqslIsd
	 x9eBjUJk3V+49FP0NhD6kPhKM++38UzTC/TAIF/AirT772K94vSoMx4wIFL8c/Og7m
	 apJ2QvqWSoAnWlieG5qeh9a176nRqkuEkOMZLQOCBN1Y6jOiGRGwhxIc5nsGNTblRA
	 C2txMO/CZ2R9WferZtJU7WF7dU6Jl7EzdvxrcedXiCuhRcERus7wpWMu9oMCi4Uryf
	 +41fnv8rrHVz9YXAtzyKdy7skhpu3ij+5cXLBTpsqXh8pYcFMOl6nnRWO3f5f7hj1V
	 F+ds5v29PyEnw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 1/2] sh: convert the last use of 'optional' property in Kconfig
Date: Sun, 21 Apr 2024 21:08:23 +0900
Message-Id: <20240421120824.2713923-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240421120824.2713923-1-masahiroy@kernel.org>
References: <20240421120824.2713923-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'choice' statement is primarily used to exclusively select one
option, but the 'optional' property allows all entries to be disabled.

This feature is only used in arch/sh/Kconfig because the equivalent
outcome can be achieved by inserting one more entry as a place-holder.
This approach is commonly used, for example, LTO_NONE, DEBUG_INFO_NONE,
INITRAMFS_COMPRESSION_NONE, etc.

The 'optional' property support will be removed from Kconfig.

This commit converts the last user.

Note:
 The 'default CMDLINE_OVERWRITE' statement does not work as intended
 in combination with 'optional'. If neither CONFIG_CMDLINE_OVERWRITE
 nor CONFIG_CMD_EXTEND is specified in a defconfig file, both of them
 are disabled. This is a bug. To maintain the current behavior, I
 added CONFIG_CMD_NO_MODIFY=y to those defconfig files.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/sh/Kconfig                           | 6 +++++-
 arch/sh/configs/apsh4a3a_defconfig        | 1 +
 arch/sh/configs/apsh4ad0a_defconfig       | 1 +
 arch/sh/configs/edosk7705_defconfig       | 1 +
 arch/sh/configs/hp6xx_defconfig           | 1 +
 arch/sh/configs/landisk_defconfig         | 1 +
 arch/sh/configs/magicpanelr2_defconfig    | 1 +
 arch/sh/configs/rsk7264_defconfig         | 1 +
 arch/sh/configs/rsk7269_defconfig         | 1 +
 arch/sh/configs/se7619_defconfig          | 1 +
 arch/sh/configs/se7705_defconfig          | 1 +
 arch/sh/configs/se7722_defconfig          | 1 +
 arch/sh/configs/se7750_defconfig          | 1 +
 arch/sh/configs/secureedge5410_defconfig  | 1 +
 arch/sh/configs/sh7710voipgw_defconfig    | 1 +
 arch/sh/configs/sh7724_generic_defconfig  | 1 +
 arch/sh/configs/sh7770_generic_defconfig  | 1 +
 arch/sh/configs/sh7785lcr_32bit_defconfig | 1 +
 arch/sh/configs/sh7785lcr_defconfig       | 1 +
 arch/sh/configs/urquell_defconfig         | 1 +
 20 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 2ad3e29f0ebe..bebc801c9619 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -709,7 +709,6 @@ config ROMIMAGE_MMCIF
 
 choice
 	prompt "Kernel command line"
-	optional
 	default CMDLINE_OVERWRITE
 	help
 	  Setting this option allows the kernel command line arguments
@@ -727,6 +726,11 @@ config CMDLINE_EXTEND
 	  Given string will be concatenated with arguments passed in
 	  by a bootloader.
 
+config CMDLINE_NO_MODIFY
+	bool "Do not modify bootloader kernel arguments"
+	help
+	  Given string will be used as-is.
+
 endchoice
 
 config CMDLINE
diff --git a/arch/sh/configs/apsh4a3a_defconfig b/arch/sh/configs/apsh4a3a_defconfig
index cc909f347877..25ba2e55c546 100644
--- a/arch/sh/configs/apsh4a3a_defconfig
+++ b/arch/sh/configs/apsh4a3a_defconfig
@@ -15,6 +15,7 @@ CONFIG_MEMORY_START=0x0C000000
 CONFIG_FLATMEM_MANUAL=y
 CONFIG_SH_STORE_QUEUES=y
 CONFIG_SH_APSH4A3A=y
+CONFIG_CMDLINE_NO_MODIFY=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_KEXEC=y
 CONFIG_PREEMPT=y
diff --git a/arch/sh/configs/apsh4ad0a_defconfig b/arch/sh/configs/apsh4ad0a_defconfig
index 64558bf60e10..36a6fbb71c0f 100644
--- a/arch/sh/configs/apsh4ad0a_defconfig
+++ b/arch/sh/configs/apsh4ad0a_defconfig
@@ -42,6 +42,7 @@ CONFIG_SECCOMP=y
 CONFIG_PREEMPT=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_BINFMT_MISC=y
+CONFIG_CMDLINE_NO_MODIFY=y
 CONFIG_PM=y
 CONFIG_PM_DEBUG=y
 CONFIG_PM=y
diff --git a/arch/sh/configs/edosk7705_defconfig b/arch/sh/configs/edosk7705_defconfig
index 9ee35269bee2..9bb371ad4273 100644
--- a/arch/sh/configs/edosk7705_defconfig
+++ b/arch/sh/configs/edosk7705_defconfig
@@ -19,6 +19,7 @@
 CONFIG_CPU_SUBTYPE_SH7705=y
 CONFIG_SH_EDOSK7705=y
 CONFIG_SH_PCLK_FREQ=31250000
+CONFIG_CMDLINE_NO_MODIFY=y
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
 # CONFIG_INPUT is not set
 # CONFIG_SERIO is not set
diff --git a/arch/sh/configs/hp6xx_defconfig b/arch/sh/configs/hp6xx_defconfig
index 0c45f2a0f9bd..d0746e6ecfa9 100644
--- a/arch/sh/configs/hp6xx_defconfig
+++ b/arch/sh/configs/hp6xx_defconfig
@@ -15,6 +15,7 @@ CONFIG_SH_DMA_API=y
 CONFIG_HD64461_ENABLER=y
 CONFIG_PCCARD=y
 CONFIG_PM=y
+CONFIG_CMDLINE_NO_MODIFY=y
 CONFIG_APM_EMULATION=y
 # CONFIG_STANDALONE is not set
 CONFIG_BLK_DEV_SD=y
diff --git a/arch/sh/configs/landisk_defconfig b/arch/sh/configs/landisk_defconfig
index 541082090918..08e1e301b83b 100644
--- a/arch/sh/configs/landisk_defconfig
+++ b/arch/sh/configs/landisk_defconfig
@@ -15,6 +15,7 @@ CONFIG_KEXEC=y
 CONFIG_PCI=y
 CONFIG_PCCARD=y
 CONFIG_YENTA=y
+CONFIG_CMDLINE_NO_MODIFY=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
diff --git a/arch/sh/configs/magicpanelr2_defconfig b/arch/sh/configs/magicpanelr2_defconfig
index 52937f9cc2ab..fdb2f95b9c35 100644
--- a/arch/sh/configs/magicpanelr2_defconfig
+++ b/arch/sh/configs/magicpanelr2_defconfig
@@ -22,6 +22,7 @@ CONFIG_SH_PCLK_FREQ=24000000
 CONFIG_SH_DMA=y
 CONFIG_SH_DMA_API=y
 CONFIG_HEARTBEAT=y
+CONFIG_CMDLINE_NO_MODIFY=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
diff --git a/arch/sh/configs/rsk7264_defconfig b/arch/sh/configs/rsk7264_defconfig
index a88cb3b77957..6d1694e24634 100644
--- a/arch/sh/configs/rsk7264_defconfig
+++ b/arch/sh/configs/rsk7264_defconfig
@@ -21,6 +21,7 @@ CONFIG_MEMORY_START=0x0c000000
 CONFIG_FLATMEM_MANUAL=y
 CONFIG_CPU_BIG_ENDIAN=y
 CONFIG_SH_RSK=y
+CONFIG_CMDLINE_NO_MODIFY=y
 # CONFIG_SH_TIMER_MTU2 is not set
 CONFIG_BINFMT_FLAT=y
 CONFIG_NET=y
diff --git a/arch/sh/configs/rsk7269_defconfig b/arch/sh/configs/rsk7269_defconfig
index d9a7ce783c9b..e4086d9b4fd9 100644
--- a/arch/sh/configs/rsk7269_defconfig
+++ b/arch/sh/configs/rsk7269_defconfig
@@ -10,6 +10,7 @@ CONFIG_MEMORY_SIZE=0x02000000
 CONFIG_FLATMEM_MANUAL=y
 CONFIG_CPU_BIG_ENDIAN=y
 CONFIG_SH_RSK=y
+CONFIG_CMDLINE_NO_MODIFY=y
 # CONFIG_SH_TIMER_MTU2 is not set
 CONFIG_SH_PCLK_FREQ=66700000
 CONFIG_BINFMT_FLAT=y
diff --git a/arch/sh/configs/se7619_defconfig b/arch/sh/configs/se7619_defconfig
index 14d0f5ead502..bc3105bd33d2 100644
--- a/arch/sh/configs/se7619_defconfig
+++ b/arch/sh/configs/se7619_defconfig
@@ -14,6 +14,7 @@ CONFIG_FLATMEM_MANUAL=y
 CONFIG_CPU_BIG_ENDIAN=y
 CONFIG_SH_7619_SOLUTION_ENGINE=y
 CONFIG_HZ_100=y
+CONFIG_CMDLINE_NO_MODIFY=y
 CONFIG_BINFMT_FLAT=y
 CONFIG_BINFMT_ZFLAT=y
 # CONFIG_STANDALONE is not set
diff --git a/arch/sh/configs/se7705_defconfig b/arch/sh/configs/se7705_defconfig
index 16a0f72f0822..efe34f6f9c18 100644
--- a/arch/sh/configs/se7705_defconfig
+++ b/arch/sh/configs/se7705_defconfig
@@ -13,6 +13,7 @@ CONFIG_FLATMEM_MANUAL=y
 # CONFIG_SH_ADC is not set
 CONFIG_SH_SOLUTION_ENGINE=y
 CONFIG_HEARTBEAT=y
+CONFIG_CMDLINE_NO_MODIFY=y
 CONFIG_PREEMPT=y
 CONFIG_NET=y
 CONFIG_PACKET=y
diff --git a/arch/sh/configs/se7722_defconfig b/arch/sh/configs/se7722_defconfig
index 09e455817447..bf7deaf881a3 100644
--- a/arch/sh/configs/se7722_defconfig
+++ b/arch/sh/configs/se7722_defconfig
@@ -17,6 +17,7 @@ CONFIG_SH_7722_SOLUTION_ENGINE=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_HEARTBEAT=y
+CONFIG_CMDLINE_NO_MODIFY=y
 CONFIG_KEXEC=y
 CONFIG_PREEMPT=y
 CONFIG_NET=y
diff --git a/arch/sh/configs/se7750_defconfig b/arch/sh/configs/se7750_defconfig
index 5fa6239ae4ea..2d0cd40f9634 100644
--- a/arch/sh/configs/se7750_defconfig
+++ b/arch/sh/configs/se7750_defconfig
@@ -15,6 +15,7 @@ CONFIG_FLATMEM_MANUAL=y
 CONFIG_SH_SOLUTION_ENGINE=y
 CONFIG_SH_PCLK_FREQ=33333333
 CONFIG_HEARTBEAT=y
+CONFIG_CMDLINE_NO_MODIFY=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
diff --git a/arch/sh/configs/secureedge5410_defconfig b/arch/sh/configs/secureedge5410_defconfig
index 120176afe3f6..4ffdb1049d89 100644
--- a/arch/sh/configs/secureedge5410_defconfig
+++ b/arch/sh/configs/secureedge5410_defconfig
@@ -10,6 +10,7 @@ CONFIG_SH_SECUREEDGE5410=y
 CONFIG_SH_DMA=y
 CONFIG_SH_DMA_API=y
 CONFIG_PCI=y
+CONFIG_CMDLINE_NO_MODIFY=y
 CONFIG_NET=y
 CONFIG_INET=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
diff --git a/arch/sh/configs/sh7710voipgw_defconfig b/arch/sh/configs/sh7710voipgw_defconfig
index 7f742729df69..6d7842542caf 100644
--- a/arch/sh/configs/sh7710voipgw_defconfig
+++ b/arch/sh/configs/sh7710voipgw_defconfig
@@ -15,6 +15,7 @@ CONFIG_MEMORY_SIZE=0x00800000
 CONFIG_FLATMEM_MANUAL=y
 # CONFIG_SH_ADC is not set
 CONFIG_SH_PCLK_FREQ=32768000
+CONFIG_CMDLINE_NO_MODIFY=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
diff --git a/arch/sh/configs/sh7724_generic_defconfig b/arch/sh/configs/sh7724_generic_defconfig
index cbc9389a89a8..04bb71aeeb44 100644
--- a/arch/sh/configs/sh7724_generic_defconfig
+++ b/arch/sh/configs/sh7724_generic_defconfig
@@ -12,6 +12,7 @@ CONFIG_CPU_FREQ=y
 CONFIG_SH_CPU_FREQ=y
 CONFIG_KEXEC=y
 CONFIG_KEXEC_JUMP=y
+CONFIG_CMDLINE_NO_MODIFY=y
 CONFIG_HIBERNATION=y
 CONFIG_CPU_IDLE=y
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
diff --git a/arch/sh/configs/sh7770_generic_defconfig b/arch/sh/configs/sh7770_generic_defconfig
index ee2357deba0f..5561ad497938 100644
--- a/arch/sh/configs/sh7770_generic_defconfig
+++ b/arch/sh/configs/sh7770_generic_defconfig
@@ -14,6 +14,7 @@ CONFIG_SH_CPU_FREQ=y
 CONFIG_KEXEC=y
 CONFIG_KEXEC_JUMP=y
 CONFIG_PM=y
+CONFIG_CMDLINE_NO_MODIFY=y
 CONFIG_HIBERNATION=y
 CONFIG_CPU_IDLE=y
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
diff --git a/arch/sh/configs/sh7785lcr_32bit_defconfig b/arch/sh/configs/sh7785lcr_32bit_defconfig
index 59262f42abe6..e742b7c37f2d 100644
--- a/arch/sh/configs/sh7785lcr_32bit_defconfig
+++ b/arch/sh/configs/sh7785lcr_32bit_defconfig
@@ -32,6 +32,7 @@ CONFIG_PREEMPT=y
 CONFIG_INTC_USERIMASK=y
 CONFIG_PCI=y
 CONFIG_PCI_DEBUG=y
+CONFIG_CMDLINE_NO_MODIFY=y
 CONFIG_PM=y
 CONFIG_CPU_IDLE=y
 CONFIG_NET=y
diff --git a/arch/sh/configs/sh7785lcr_defconfig b/arch/sh/configs/sh7785lcr_defconfig
index 94381f8268ff..5d4fda1fe672 100644
--- a/arch/sh/configs/sh7785lcr_defconfig
+++ b/arch/sh/configs/sh7785lcr_defconfig
@@ -17,6 +17,7 @@ CONFIG_HEARTBEAT=y
 CONFIG_KEXEC=y
 CONFIG_PREEMPT=y
 CONFIG_PCI=y
+CONFIG_CMDLINE_NO_MODIFY=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
diff --git a/arch/sh/configs/urquell_defconfig b/arch/sh/configs/urquell_defconfig
index 445bb451a5ec..fb9872609e38 100644
--- a/arch/sh/configs/urquell_defconfig
+++ b/arch/sh/configs/urquell_defconfig
@@ -34,6 +34,7 @@ CONFIG_PCIEPORTBUS=y
 CONFIG_PCIEASPM_DEBUG=y
 CONFIG_PCI_DEBUG=y
 CONFIG_BINFMT_MISC=y
+CONFIG_CMDLINE_NO_MODIFY=y
 CONFIG_PM=y
 CONFIG_CPU_IDLE=y
 CONFIG_NET=y
-- 
2.40.1



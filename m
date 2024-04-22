Return-Path: <linux-kernel+bounces-153733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E69738AD276
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E317287819
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C677C155393;
	Mon, 22 Apr 2024 16:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTKQcXLD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B897A153BE3;
	Mon, 22 Apr 2024 16:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713804104; cv=none; b=SKpUVMODrILH9nmAOabsqibj7yGQc83XeKkkWkcqrZRdijfxpQtjTHlX+lk2WUChXjcd1c6yUMmArhA/RaQFMkH+sDVDTWB4aiTTfnGitUOAjO093z0923/Mndt2T9pi6qF7qS9Bp+R5M0STxMqA3mGm49jwXK5dZSLVJFIDPa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713804104; c=relaxed/simple;
	bh=NqIy7nf1sAoPqh0OTVgs/yJzIPXNWGrpgiGYO8owuME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NssyE+mDuLT3/hDdZYPQOffpsmyY63MShljso3pmuKiuwmpdi7Rgvff3Ig4AnSLdnV62xuuMG5tgCQcrULlEY245RYKgnoFeICuzcIsUpZqM81Ns0SW/+WY66htiBwLfDHaqnxMMME4O9r3hO5vWxUpxDQ2vXUYW1J2ydiViDU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTKQcXLD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A67C32783;
	Mon, 22 Apr 2024 16:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713804104;
	bh=NqIy7nf1sAoPqh0OTVgs/yJzIPXNWGrpgiGYO8owuME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cTKQcXLDQE9J3x8VKak+jgkINdMoxQdlwcCM8/UR+QiTyn3bsdkRvX+pAP6WJhLzh
	 PkkGVLPJi84dWtvhc3joZOfgVXki0G3/gw2AsAOCqVKyAUrdhIknE8ZkeFc0kN9FiM
	 weoqon4Q2XHknwDoz+vj6l++x/ozfFw9sbK7WTbqKI4QNoNrchOOSJjlISFMxnXxbn
	 yHfrqSArW/dz96gakqVjOfrVpl8SbVVWJh7ntuVPkq5EXHz0J+/7rvjgEmzfSHiTGD
	 q156mdJCRMzjD32aaKmmv3ZclExi2xV4kcSZbfEJHjksmmC4tR4vAA8nur3eFISGXP
	 6XdIP9th+XZvQ==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2 1/2] sh: Convert the last use of 'optional' property in Kconfig
Date: Tue, 23 Apr 2024 01:41:03 +0900
Message-Id: <20240422164104.2869507-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240422164104.2869507-1-masahiroy@kernel.org>
References: <20240422164104.2869507-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'choice' statement is primarily used to exclusively select one
option, but the 'optional' property allows all entries to be disabled.

This feature is rarely used. In fact, it is only used in arch/sh/Kconfig
because the equivalent outcome can be achieved by inserting one more
entry as a place-holder.

The 'optional' property support will be removed from Kconfig.

This commit replaces the 'optional' property with a dummy option,
CMDLINE_FROM_BOOTLOADER, as seen in some other architectures.

Note:
 The 'default CMDLINE_OVERWRITE' statement does not work as intended
 in combination with 'optional'. If neither CONFIG_CMDLINE_OVERWRITE
 nor CONFIG_CMDLINE_EXTEND is specified in a defconfig file, both of
 them are disabled. This is a bug. To maintain the current behavior,
 I added CONFIG_CMDLINE_FROM_BOOTLOADER=y to those defconfig files.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
 - Rename CONFIG_CMDLINE_NO_MODIFY to CONFIG_CMDLINE_FROM_BOOTLOADER
 - Capitalize the first work of the subject

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
index 2ad3e29f0ebe..8b64ca76aa4b 100644
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
 
+config CMDLINE_FROM_BOOTLOADER
+	bool "Use bootloader kernel arguments"
+	help
+	  Uses the command-line options passed by the boot loader.
+
 endchoice
 
 config CMDLINE
diff --git a/arch/sh/configs/apsh4a3a_defconfig b/arch/sh/configs/apsh4a3a_defconfig
index cc909f347877..9c2644443c4d 100644
--- a/arch/sh/configs/apsh4a3a_defconfig
+++ b/arch/sh/configs/apsh4a3a_defconfig
@@ -15,6 +15,7 @@ CONFIG_MEMORY_START=0x0C000000
 CONFIG_FLATMEM_MANUAL=y
 CONFIG_SH_STORE_QUEUES=y
 CONFIG_SH_APSH4A3A=y
+CONFIG_CMDLINE_FROM_BOOTLOADER=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_KEXEC=y
 CONFIG_PREEMPT=y
diff --git a/arch/sh/configs/apsh4ad0a_defconfig b/arch/sh/configs/apsh4ad0a_defconfig
index 64558bf60e10..05d21d91f41d 100644
--- a/arch/sh/configs/apsh4ad0a_defconfig
+++ b/arch/sh/configs/apsh4ad0a_defconfig
@@ -42,6 +42,7 @@ CONFIG_SECCOMP=y
 CONFIG_PREEMPT=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_BINFMT_MISC=y
+CONFIG_CMDLINE_FROM_BOOTLOADER=y
 CONFIG_PM=y
 CONFIG_PM_DEBUG=y
 CONFIG_PM=y
diff --git a/arch/sh/configs/edosk7705_defconfig b/arch/sh/configs/edosk7705_defconfig
index 9ee35269bee2..57c79da1ff8e 100644
--- a/arch/sh/configs/edosk7705_defconfig
+++ b/arch/sh/configs/edosk7705_defconfig
@@ -19,6 +19,7 @@
 CONFIG_CPU_SUBTYPE_SH7705=y
 CONFIG_SH_EDOSK7705=y
 CONFIG_SH_PCLK_FREQ=31250000
+CONFIG_CMDLINE_FROM_BOOTLOADER=y
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
 # CONFIG_INPUT is not set
 # CONFIG_SERIO is not set
diff --git a/arch/sh/configs/hp6xx_defconfig b/arch/sh/configs/hp6xx_defconfig
index 0c45f2a0f9bd..77e3185f63e4 100644
--- a/arch/sh/configs/hp6xx_defconfig
+++ b/arch/sh/configs/hp6xx_defconfig
@@ -15,6 +15,7 @@ CONFIG_SH_DMA_API=y
 CONFIG_HD64461_ENABLER=y
 CONFIG_PCCARD=y
 CONFIG_PM=y
+CONFIG_CMDLINE_FROM_BOOTLOADER=y
 CONFIG_APM_EMULATION=y
 # CONFIG_STANDALONE is not set
 CONFIG_BLK_DEV_SD=y
diff --git a/arch/sh/configs/landisk_defconfig b/arch/sh/configs/landisk_defconfig
index 541082090918..0311380160f4 100644
--- a/arch/sh/configs/landisk_defconfig
+++ b/arch/sh/configs/landisk_defconfig
@@ -15,6 +15,7 @@ CONFIG_KEXEC=y
 CONFIG_PCI=y
 CONFIG_PCCARD=y
 CONFIG_YENTA=y
+CONFIG_CMDLINE_FROM_BOOTLOADER=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
diff --git a/arch/sh/configs/magicpanelr2_defconfig b/arch/sh/configs/magicpanelr2_defconfig
index 52937f9cc2ab..8d443749550e 100644
--- a/arch/sh/configs/magicpanelr2_defconfig
+++ b/arch/sh/configs/magicpanelr2_defconfig
@@ -22,6 +22,7 @@ CONFIG_SH_PCLK_FREQ=24000000
 CONFIG_SH_DMA=y
 CONFIG_SH_DMA_API=y
 CONFIG_HEARTBEAT=y
+CONFIG_CMDLINE_FROM_BOOTLOADER=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
diff --git a/arch/sh/configs/rsk7264_defconfig b/arch/sh/configs/rsk7264_defconfig
index a88cb3b77957..e4ef259425c4 100644
--- a/arch/sh/configs/rsk7264_defconfig
+++ b/arch/sh/configs/rsk7264_defconfig
@@ -21,6 +21,7 @@ CONFIG_MEMORY_START=0x0c000000
 CONFIG_FLATMEM_MANUAL=y
 CONFIG_CPU_BIG_ENDIAN=y
 CONFIG_SH_RSK=y
+CONFIG_CMDLINE_FROM_BOOTLOADER=y
 # CONFIG_SH_TIMER_MTU2 is not set
 CONFIG_BINFMT_FLAT=y
 CONFIG_NET=y
diff --git a/arch/sh/configs/rsk7269_defconfig b/arch/sh/configs/rsk7269_defconfig
index d9a7ce783c9b..e0d1560b2bfd 100644
--- a/arch/sh/configs/rsk7269_defconfig
+++ b/arch/sh/configs/rsk7269_defconfig
@@ -10,6 +10,7 @@ CONFIG_MEMORY_SIZE=0x02000000
 CONFIG_FLATMEM_MANUAL=y
 CONFIG_CPU_BIG_ENDIAN=y
 CONFIG_SH_RSK=y
+CONFIG_CMDLINE_FROM_BOOTLOADER=y
 # CONFIG_SH_TIMER_MTU2 is not set
 CONFIG_SH_PCLK_FREQ=66700000
 CONFIG_BINFMT_FLAT=y
diff --git a/arch/sh/configs/se7619_defconfig b/arch/sh/configs/se7619_defconfig
index 14d0f5ead502..6b25e9713e77 100644
--- a/arch/sh/configs/se7619_defconfig
+++ b/arch/sh/configs/se7619_defconfig
@@ -14,6 +14,7 @@ CONFIG_FLATMEM_MANUAL=y
 CONFIG_CPU_BIG_ENDIAN=y
 CONFIG_SH_7619_SOLUTION_ENGINE=y
 CONFIG_HZ_100=y
+CONFIG_CMDLINE_FROM_BOOTLOADER=y
 CONFIG_BINFMT_FLAT=y
 CONFIG_BINFMT_ZFLAT=y
 # CONFIG_STANDALONE is not set
diff --git a/arch/sh/configs/se7705_defconfig b/arch/sh/configs/se7705_defconfig
index 16a0f72f0822..1752ddc2694a 100644
--- a/arch/sh/configs/se7705_defconfig
+++ b/arch/sh/configs/se7705_defconfig
@@ -13,6 +13,7 @@ CONFIG_FLATMEM_MANUAL=y
 # CONFIG_SH_ADC is not set
 CONFIG_SH_SOLUTION_ENGINE=y
 CONFIG_HEARTBEAT=y
+CONFIG_CMDLINE_FROM_BOOTLOADER=y
 CONFIG_PREEMPT=y
 CONFIG_NET=y
 CONFIG_PACKET=y
diff --git a/arch/sh/configs/se7722_defconfig b/arch/sh/configs/se7722_defconfig
index 09e455817447..5327a2f70980 100644
--- a/arch/sh/configs/se7722_defconfig
+++ b/arch/sh/configs/se7722_defconfig
@@ -17,6 +17,7 @@ CONFIG_SH_7722_SOLUTION_ENGINE=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_HEARTBEAT=y
+CONFIG_CMDLINE_FROM_BOOTLOADER=y
 CONFIG_KEXEC=y
 CONFIG_PREEMPT=y
 CONFIG_NET=y
diff --git a/arch/sh/configs/se7750_defconfig b/arch/sh/configs/se7750_defconfig
index 5fa6239ae4ea..a1e25d7de8a6 100644
--- a/arch/sh/configs/se7750_defconfig
+++ b/arch/sh/configs/se7750_defconfig
@@ -15,6 +15,7 @@ CONFIG_FLATMEM_MANUAL=y
 CONFIG_SH_SOLUTION_ENGINE=y
 CONFIG_SH_PCLK_FREQ=33333333
 CONFIG_HEARTBEAT=y
+CONFIG_CMDLINE_FROM_BOOTLOADER=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
diff --git a/arch/sh/configs/secureedge5410_defconfig b/arch/sh/configs/secureedge5410_defconfig
index 120176afe3f6..2f77b60e9540 100644
--- a/arch/sh/configs/secureedge5410_defconfig
+++ b/arch/sh/configs/secureedge5410_defconfig
@@ -10,6 +10,7 @@ CONFIG_SH_SECUREEDGE5410=y
 CONFIG_SH_DMA=y
 CONFIG_SH_DMA_API=y
 CONFIG_PCI=y
+CONFIG_CMDLINE_FROM_BOOTLOADER=y
 CONFIG_NET=y
 CONFIG_INET=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
diff --git a/arch/sh/configs/sh7710voipgw_defconfig b/arch/sh/configs/sh7710voipgw_defconfig
index 7f742729df69..99a5d0760532 100644
--- a/arch/sh/configs/sh7710voipgw_defconfig
+++ b/arch/sh/configs/sh7710voipgw_defconfig
@@ -15,6 +15,7 @@ CONFIG_MEMORY_SIZE=0x00800000
 CONFIG_FLATMEM_MANUAL=y
 # CONFIG_SH_ADC is not set
 CONFIG_SH_PCLK_FREQ=32768000
+CONFIG_CMDLINE_FROM_BOOTLOADER=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
diff --git a/arch/sh/configs/sh7724_generic_defconfig b/arch/sh/configs/sh7724_generic_defconfig
index cbc9389a89a8..5440bd0ca4ed 100644
--- a/arch/sh/configs/sh7724_generic_defconfig
+++ b/arch/sh/configs/sh7724_generic_defconfig
@@ -12,6 +12,7 @@ CONFIG_CPU_FREQ=y
 CONFIG_SH_CPU_FREQ=y
 CONFIG_KEXEC=y
 CONFIG_KEXEC_JUMP=y
+CONFIG_CMDLINE_FROM_BOOTLOADER=y
 CONFIG_HIBERNATION=y
 CONFIG_CPU_IDLE=y
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
diff --git a/arch/sh/configs/sh7770_generic_defconfig b/arch/sh/configs/sh7770_generic_defconfig
index ee2357deba0f..4338af8d02d0 100644
--- a/arch/sh/configs/sh7770_generic_defconfig
+++ b/arch/sh/configs/sh7770_generic_defconfig
@@ -14,6 +14,7 @@ CONFIG_SH_CPU_FREQ=y
 CONFIG_KEXEC=y
 CONFIG_KEXEC_JUMP=y
 CONFIG_PM=y
+CONFIG_CMDLINE_FROM_BOOTLOADER=y
 CONFIG_HIBERNATION=y
 CONFIG_CPU_IDLE=y
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
diff --git a/arch/sh/configs/sh7785lcr_32bit_defconfig b/arch/sh/configs/sh7785lcr_32bit_defconfig
index 59262f42abe6..44f9b2317f09 100644
--- a/arch/sh/configs/sh7785lcr_32bit_defconfig
+++ b/arch/sh/configs/sh7785lcr_32bit_defconfig
@@ -32,6 +32,7 @@ CONFIG_PREEMPT=y
 CONFIG_INTC_USERIMASK=y
 CONFIG_PCI=y
 CONFIG_PCI_DEBUG=y
+CONFIG_CMDLINE_FROM_BOOTLOADER=y
 CONFIG_PM=y
 CONFIG_CPU_IDLE=y
 CONFIG_NET=y
diff --git a/arch/sh/configs/sh7785lcr_defconfig b/arch/sh/configs/sh7785lcr_defconfig
index 94381f8268ff..aec74b0e7003 100644
--- a/arch/sh/configs/sh7785lcr_defconfig
+++ b/arch/sh/configs/sh7785lcr_defconfig
@@ -17,6 +17,7 @@ CONFIG_HEARTBEAT=y
 CONFIG_KEXEC=y
 CONFIG_PREEMPT=y
 CONFIG_PCI=y
+CONFIG_CMDLINE_FROM_BOOTLOADER=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
diff --git a/arch/sh/configs/urquell_defconfig b/arch/sh/configs/urquell_defconfig
index 445bb451a5ec..00ef62133b04 100644
--- a/arch/sh/configs/urquell_defconfig
+++ b/arch/sh/configs/urquell_defconfig
@@ -34,6 +34,7 @@ CONFIG_PCIEPORTBUS=y
 CONFIG_PCIEASPM_DEBUG=y
 CONFIG_PCI_DEBUG=y
 CONFIG_BINFMT_MISC=y
+CONFIG_CMDLINE_FROM_BOOTLOADER=y
 CONFIG_PM=y
 CONFIG_CPU_IDLE=y
 CONFIG_NET=y
-- 
2.40.1



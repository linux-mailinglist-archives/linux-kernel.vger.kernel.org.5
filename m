Return-Path: <linux-kernel+bounces-102147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9251D87AED0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 334C91F30BE2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B31C4D9ED;
	Wed, 13 Mar 2024 17:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iaJZcFsD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF6374BEB;
	Wed, 13 Mar 2024 17:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349363; cv=none; b=VaknWriqurYyI5jv+bBrHHr8mMUiTzqbwe8dpHqmBRRKsFBVG8Yal+l4NTpfsvDZTlYcg4adKHSLrqYk+MRdDMv+rxJcQR+XNzZ6Ir8QItW+jGFF0hWcxhR4Xn8tbrz4DE1y0I3UabPi+/LuURfB8aGqzcfxnXE5zgtdYejfvYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349363; c=relaxed/simple;
	bh=noSTJlXRcgDjp3N/BVak0TfI6we7ARRsLPccEiaIzIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NzS8l2CWCxgZD5EbNU6HTHTEB4I8f8fh1uNHWsaV4gGKgZ1Pji5dhq7SI8+FDnLJQ0i37vVEhg86Ug6xicYV6RQeARwzfxlEDzLs96Ntu0rcJ/lYvxPMVM2YVnohvltQEwrvZpEchquNitf56GBUfiXDWTunBoAvOBejojlQSCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iaJZcFsD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A0D6C43394;
	Wed, 13 Mar 2024 17:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349363;
	bh=noSTJlXRcgDjp3N/BVak0TfI6we7ARRsLPccEiaIzIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iaJZcFsD0OLsM6ZBDBL8Pwf5grOCXYVVLgME+7xjeiv8soDn3RqYqNbGN5Wg9nLgl
	 e3B9Eos7/sfTGGQzLdf02Vmk59bl5dxOaCOrwFPXBYPla411W5/fjskJdOni2tvcij
	 F4oXqbtNoCLhNvnUxbwz1g/wojD3Pd6Nvjv6a/wuK9z02NfmhMr6kfIxS/ro3/XEzP
	 OimzRrsE2spNoExS9cndQ4qbqqAb7E5Qac0iIG3C2dD0uyAVfVXBtJ2G5kFJT/VIiB
	 gVixWEuVepFKD8JJHkJZJCkOrQ/8XEDcjNIutaCjxN6BOQWH8OROw2xOpGeKOTFduv
	 LEKoK6Aj7hCWQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Richard Weinberger <richard@nod.at>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 26/51] um: allow not setting extra rpaths in the linux binary
Date: Wed, 13 Mar 2024 13:01:47 -0400
Message-ID: <20240313170212.616443-27-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313170212.616443-1-sashal@kernel.org>
References: <20240313170212.616443-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.272-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.272-rc1
X-KernelTest-Deadline: 2024-03-15T17:02+00:00
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
index 468a5d63ef269..107a0bc668e9f 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -85,6 +85,19 @@ config LD_SCRIPT_DYN
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
index 773120be0f56f..94cea8d46b222 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -118,7 +118,8 @@ archprepare:
 	$(Q)$(MAKE) $(build)=$(HOST_DIR)/um include/generated/user_constants.h
 
 LINK-$(CONFIG_LD_SCRIPT_STATIC) += -static
-LINK-$(CONFIG_LD_SCRIPT_DYN) += -Wl,-rpath,/lib $(call cc-option, -no-pie)
+LINK-$(CONFIG_LD_SCRIPT_DYN) += $(call cc-option, -no-pie)
+LINK-$(CONFIG_LD_SCRIPT_DYN_RPATH) += -Wl,-rpath,/lib
 
 CFLAGS_NO_HARDENING := $(call cc-option, -fno-PIC,) $(call cc-option, -fno-pic,) \
 	$(call cc-option, -fno-stack-protector,) \
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



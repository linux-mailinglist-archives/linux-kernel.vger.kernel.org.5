Return-Path: <linux-kernel+bounces-102214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D8A87AF7B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9406A288F4B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7E91A0A3F;
	Wed, 13 Mar 2024 17:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qAmQA30D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217DE1A0A28;
	Wed, 13 Mar 2024 17:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349508; cv=none; b=F2A1RXkxxZjRHZY5+nppyJUw1xIVZclobau/N071AcMaljdMrl2zY38+aCkyaEaAHSl3AhI8oYBcgP8KFZjjXDLCTok9uP2cNsHPCyBY5yctRLGuIdQW8/1OdI7ugAGscvduxk1dw9voojm+4eHsy1tPU0tBJyvFU8e9KY9CPVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349508; c=relaxed/simple;
	bh=maJUSkQfGx/uo6I5Mw8R4UoWYlWWMiuJ3i3H5XFNFVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=loZDneE/Y6UfiHMb0VlzbwlDdN9oy+RvMsOUfPG+hS+ijeHtfu3IMMUMi0CH2wwWAVPi4FAFlvFMKjfDPNd14YGewJtcXNJmqoA8dPacoj1/phOIroLEAppWfF4NHm7x1ImkGkXiw2PXGN4svn8s+jyk3oGEu86AnXeAagahHrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qAmQA30D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C900C433F1;
	Wed, 13 Mar 2024 17:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349508;
	bh=maJUSkQfGx/uo6I5Mw8R4UoWYlWWMiuJ3i3H5XFNFVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qAmQA30DPXEcCdWFpTNtG8NjpjZY71m7LgYhNvRxlp5qAuMxpXrOr2f3OSKQ7mcBu
	 8GbfOynqyxw9OO1SiDY7NV1FUOhEPPidxM6ailhu9GiYtQPUKZrIsuHqwtC/oF0BJv
	 oCiZtDSV4fpBghGXoWEdYlAhxTfkhyFtZeiFPrPM5KGCtECmF4+DSku46N8ljxija2
	 P3sx4p6DzXMjpzta34E5iooH/CLygWzIyby5pFCsuXb1TwLZwKbZnSJq3+abgXDHyZ
	 1h2NC76prlkdzdwIye5w3WEESW/btO+wqBZPgy47b7Q84GxTKent5tzb7/xa2wifQ3
	 GuCYhML5ZB+rg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Richard Weinberger <richard@nod.at>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 27/41] um: allow not setting extra rpaths in the linux binary
Date: Wed, 13 Mar 2024 13:04:21 -0400
Message-ID: <20240313170435.616724-28-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313170435.616724-1-sashal@kernel.org>
References: <20240313170435.616724-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.310-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.310-rc1
X-KernelTest-Deadline: 2024-03-15T17:04+00:00
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
index 8f0cb28099392..251c77474e7b8 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -88,6 +88,19 @@ config LD_SCRIPT_DYN
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
index ab1066c38944e..439edee0b2878 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -119,7 +119,8 @@ archheaders:
 archprepare: include/generated/user_constants.h
 
 LINK-$(CONFIG_LD_SCRIPT_STATIC) += -static
-LINK-$(CONFIG_LD_SCRIPT_DYN) += -Wl,-rpath,/lib $(call cc-option, -no-pie)
+LINK-$(CONFIG_LD_SCRIPT_DYN) += $(call cc-option, -no-pie)
+LINK-$(CONFIG_LD_SCRIPT_DYN_RPATH) += -Wl,-rpath,/lib
 
 CFLAGS_NO_HARDENING := $(call cc-option, -fno-PIC,) $(call cc-option, -fno-pic,) \
 	$(call cc-option, -fno-stack-protector,) \
diff --git a/arch/x86/Makefile.um b/arch/x86/Makefile.um
index 91085a08de6cb..8bc3d493d429a 100644
--- a/arch/x86/Makefile.um
+++ b/arch/x86/Makefile.um
@@ -51,7 +51,7 @@ ELF_FORMAT := elf64-x86-64
 
 # Not on all 64-bit distros /lib is a symlink to /lib64. PLD is an example.
 
-LINK-$(CONFIG_LD_SCRIPT_DYN) += -Wl,-rpath,/lib64
+LINK-$(CONFIG_LD_SCRIPT_DYN_RPATH) += -Wl,-rpath,/lib64
 LINK-y += -m64
 
 # Do unit-at-a-time unconditionally on x86_64, following the host
-- 
2.43.0



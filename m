Return-Path: <linux-kernel+bounces-51909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1ECC84909E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 22:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1367B1C21459
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 21:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738F328E26;
	Sun,  4 Feb 2024 21:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpBAgEim"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10152C689;
	Sun,  4 Feb 2024 21:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707081733; cv=none; b=AW95gDCgKzk47GIxvDsArpTy4N+qtEEonl1GW0Nn0/g0813J9HwBdG+Pj/Lob8cz1UwAT8bkGR7WC+eMaH1gY4a6BQhO6uECRIQ5OoqqXfl370Pl73pVVqDVMT3itP/DqkIvgZhWKHMzC8RuP2uUCJrRck5HlCqVLHLWBF7SIgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707081733; c=relaxed/simple;
	bh=2Zo6tJdnJLLYyOEE56f5GLNyJyZ0OqgdoZ3rpPbquSE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=llY8Y6GRGX33Q5p9sOIQjHnffvyLoEWxAKija8xy+Zs1aa9eAtFpWcKJm5LUNkeyEnEWZQ24iZauneyPgCnWMZZ3K5+tfjPsiVp3AWF+ZkJp5jyW72Vmvk4BpvPqTFRyE/SAUUObAy06cT1mHr5pixbx65MvT2l1ya4k/0SPWNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpBAgEim; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA86FC433C7;
	Sun,  4 Feb 2024 21:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707081733;
	bh=2Zo6tJdnJLLYyOEE56f5GLNyJyZ0OqgdoZ3rpPbquSE=;
	h=From:To:Cc:Subject:Date:From;
	b=QpBAgEimW9lj4KBX6zvXnRbyLjtsLiISw3I20FK/8ZTy80NEO2sKA2C7N4B+kfptk
	 l9slqZTzb44th2iYH7ltC9ScQoFNM5fWNsihZu2Rm2cqVkzeb+mC3unY9/fjPIadoV
	 SIorREYecfj9CtoNjLtOMi24NpBAVPaCQw/0eCvUeUWyk8P8FVHiqfObfo2Ybz8P5M
	 BvCmnl3BNANVoYVYYP8AGh1xv54RBKlKaN6Kg0CdLrQkMnOjpngXK8OF1+omiAbR+4
	 FBelWEGiv+Sdat46Fzx6b3LJG5b01hT9HPecoKXOj3EEp7Yz+9xazLgoiNEE/ov+de
	 QPjVhonpZ0soQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Syed Saba Kareem <Syed.SabaKareem@amd.com>,
	Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
	Vinod Koul <vkoul@kernel.org>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ASoC: SOF: amd: fix SND_AMD_SOUNDWIRE_ACPI dependencies
Date: Sun,  4 Feb 2024 22:22:01 +0100
Message-Id: <20240204212207.3158914-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The snd-amd-sdw-acpi.ko module is under CONFIG_SND_SOC_AMD_ACP_COMMON but
selected from SoF, which causes build failures in some randconfig builds
that enable SOF but not ACP:

WARNING: unmet direct dependencies detected for SND_AMD_SOUNDWIRE_ACPI
  Depends on [n]: SOUND [=m] && SND [=m] && SND_SOC [=m] && SND_SOC_AMD_ACP_COMMON [=n] && ACPI [=y]
  Selected by [m]:
  - SND_SOC_SOF_AMD_SOUNDWIRE_LINK_BASELINE [=m] && SOUND [=m] && SND [=m] && SND_SOC [=m] && SND_SOC_SOF_TOPLEVEL [=y] && SND_SOC_SOF_AMD_TOPLEVEL [=m] && ACPI [=y]
ERROR: modpost: "amd_sdw_scan_controller" [sound/soc/sof/amd/snd-sof-amd-acp.ko] undefined!

Change the Makefile and Kconfig to allow it to get built regardless
of CONFIG_SND_SOC_AMD_ACP_COMMON.

Fixes: d948218424bf ("ASoC: SOF: amd: add code for invoking soundwire manager helper functions")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/amd/Makefile    |  2 +-
 sound/soc/amd/acp/Kconfig | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/amd/Makefile b/sound/soc/amd/Makefile
index 82e1cf864a40..ebbe49c2bbff 100644
--- a/sound/soc/amd/Makefile
+++ b/sound/soc/amd/Makefile
@@ -15,7 +15,7 @@ obj-$(CONFIG_SND_SOC_AMD_RV_RT5682_MACH) += snd-soc-acp-rt5682-mach.o
 obj-$(CONFIG_SND_SOC_AMD_RENOIR) += renoir/
 obj-$(CONFIG_SND_SOC_AMD_ACP5x) += vangogh/
 obj-$(CONFIG_SND_SOC_AMD_ACP6x) += yc/
-obj-$(CONFIG_SND_SOC_AMD_ACP_COMMON) += acp/
+obj-$(CONFIG_SND_AMD_ACP_CONFIG) += acp/
 obj-$(CONFIG_SND_AMD_ACP_CONFIG) += snd-acp-config.o
 obj-$(CONFIG_SND_SOC_AMD_RPL_ACP6x) += rpl/
 obj-$(CONFIG_SND_SOC_AMD_PS) += ps/
diff --git a/sound/soc/amd/acp/Kconfig b/sound/soc/amd/acp/Kconfig
index b3105ba9c3a3..30590a23ad63 100644
--- a/sound/soc/amd/acp/Kconfig
+++ b/sound/soc/amd/acp/Kconfig
@@ -101,13 +101,6 @@ config SND_SOC_AMD_MACH_COMMON
 	help
 	  This option enables common Machine driver module for ACP.
 
-config SND_AMD_SOUNDWIRE_ACPI
-	tristate "AMD SoundWire ACPI Support"
-	depends on ACPI
-	help
-	  This options enables ACPI helper functions for SoundWire
-	  interface for AMD platforms.
-
 config SND_SOC_AMD_LEGACY_MACH
 	tristate "AMD Legacy Machine Driver Support"
 	depends on X86 && PCI && I2C
@@ -123,3 +116,10 @@ config SND_SOC_AMD_SOF_MACH
 	  This option enables SOF sound card support for ACP audio.
 
 endif # SND_SOC_AMD_ACP_COMMON
+
+config SND_AMD_SOUNDWIRE_ACPI
+	tristate
+	depends on ACPI
+	help
+	  This options enables ACPI helper functions for SoundWire
+	  interface for AMD platforms.
-- 
2.39.2



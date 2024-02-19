Return-Path: <linux-kernel+bounces-71046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE98859FD8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23C871F226BB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586C223741;
	Mon, 19 Feb 2024 09:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQdv/c8W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9969423772;
	Mon, 19 Feb 2024 09:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708335547; cv=none; b=mdpJvDTupyHk2VNDWjLkM8vmvcdSUuohkM/98zvvwObkVNfq12DR0URrapF7rt3BbXKvGHdqpfo+um3JBW/uL3sAniOzTI28gbsjYGAdJf7RAa3VUMmEXhYg+K4Ab8Qx1CMBbtVsIxTmX+I6CTez2lBCInIYU9v09Q1y0YniLjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708335547; c=relaxed/simple;
	bh=IbE2CDeEgw5qxef5aPRGuFLeArPxpFNa+l8ySOIF6G4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B70rLh8v49GbMMKorC2EV51ELOrujhPiApcGqNVN6V7bTP8aSGGd6oIbj+FIYsrPaQzgezNyrTJ9WtlIWTbWvntwIswoKgQqtfDRlCxWh+sEHRcLx5m/yX8CpYK1ZvhKofBaw1ZTQoLFjFZQYJ+BbdRw5ZYclf8Mn3KuSCAmpb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQdv/c8W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9927C433C7;
	Mon, 19 Feb 2024 09:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708335547;
	bh=IbE2CDeEgw5qxef5aPRGuFLeArPxpFNa+l8ySOIF6G4=;
	h=From:To:Cc:Subject:Date:From;
	b=qQdv/c8WkmDH1PuagjECgWbP68kn6jnVdsz8iq6XaV5j3IKTNz0MalEd0KRqpie+v
	 T3U+Dsyi1oc9LnlaO04hejBfBoEYnPbYLqa0OgRRJ+NI8WRW2XpYd+t0wvESzkYKO1
	 s2YYWbqjRwv6wJE2lNBeB2pg1TD35pwJnm4GlSuLhHtXQ2GqBcR+doA5Yfb5fwD5mX
	 6A2jFWkkRNmxwlzBEedoI4rQKTILFPKrb5cn9iRbRlmHa3g2BActlGWh9qR2vkBdXc
	 PwKFzqiJBbaEohoEhJr75KzJQI8f3HRSHDnf9yVt7IRebCz8XWDmyJdV22TLXeOmMX
	 MmmostB39UfzQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
	Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: SOF: amd: fix soundwire dependencies
Date: Mon, 19 Feb 2024 10:38:45 +0100
Message-Id: <20240219093900.644574-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The soundwire-amd driver has a bit of a layering violation requiring
the SOF driver to directly call into its exported symbols rather than
through an abstraction.

The SND_SOC_SOF_AMD_SOUNDWIRE Kconfig symbol tries to deal with the
dependency by selecting SOUNDWIRE_AMD in a complicated set of conditions,
but gets it wrong for a configuration involving SND_SOC_SOF_AMD_COMMON=y,
SND_SOC_SOF_AMD_ACP63=m, and SND_SOC_SOF_AMD_SOUNDWIRE_LINK_BASELINE=m
SOUNDWIRE_AMD=m, which results in a link failure:

ld.lld: error: undefined symbol: sdw_amd_get_slave_info
>>> referenced by acp-common.c
ld.lld: error: undefined symbol: amd_sdw_scan_controller
ld.lld: error: undefined symbol: sdw_amd_probe
ld.lld: error: undefined symbol: sdw_amd_exit
>>> referenced by acp.c
>>>               sound/soc/sof/amd/acp.o:(amd_sof_acp_remove) in archive vmlinux.a

In essence, the SND_SOC_SOF_AMD_COMMON option cannot be built-in when
trying to link against a modular SOUNDWIRE_AMD driver.

Since CONFIG_SOUNDWIRE_AMD is a user-visible option, it really should
never be selected by another driver in the first place, so replace the
extra complexity with a normal Kconfig dependency in SND_SOC_SOF_AMD_SOUNDWIRE,
plus a top-level check that forbids any of the AMD SOF drivers from being
built-in with CONFIG_SOUNDWIRE_AMD=m.

In normal configs, they should all either be built-in or all loadable
modules anyway, so this simplification does not limit any real usecases.

Fixes: d948218424bf ("ASoC: SOF: amd: add code for invoking soundwire manager helper functions")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/sof/amd/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sof/amd/Kconfig b/sound/soc/sof/amd/Kconfig
index c3bbe6c70fb2..2729c6eb3feb 100644
--- a/sound/soc/sof/amd/Kconfig
+++ b/sound/soc/sof/amd/Kconfig
@@ -6,6 +6,7 @@
 
 config SND_SOC_SOF_AMD_TOPLEVEL
 	tristate "SOF support for AMD audio DSPs"
+	depends on SOUNDWIRE_AMD || !SOUNDWIRE_AMD
 	depends on X86 || COMPILE_TEST
 	help
 	  This adds support for Sound Open Firmware for AMD platforms.
@@ -62,15 +63,14 @@ config SND_SOC_SOF_ACP_PROBES
 
 config SND_SOC_SOF_AMD_SOUNDWIRE_LINK_BASELINE
 	tristate
-	select SOUNDWIRE_AMD if SND_SOC_SOF_AMD_SOUNDWIRE != n
 	select SND_AMD_SOUNDWIRE_ACPI if ACPI
 
 config SND_SOC_SOF_AMD_SOUNDWIRE
 	tristate "SOF support for SoundWire based AMD platforms"
 	default SND_SOC_SOF_AMD_SOUNDWIRE_LINK_BASELINE
 	depends on SND_SOC_SOF_AMD_SOUNDWIRE_LINK_BASELINE
-	depends on ACPI && SOUNDWIRE
-	depends on !(SOUNDWIRE=m && SND_SOC_SOF_AMD_SOUNDWIRE_LINK_BASELINE=y)
+	depends on ACPI
+	depends on SOUNDWIRE_AMD
 	help
 	  This adds support for SoundWire with Sound Open Firmware
 	  for AMD platforms.
-- 
2.39.2



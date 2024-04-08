Return-Path: <linux-kernel+bounces-135219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E38089BCE0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32ED21C210D4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E30553389;
	Mon,  8 Apr 2024 10:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="ALgZkFIr"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A119A52F87;
	Mon,  8 Apr 2024 10:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712571513; cv=none; b=sBtr9N3+KxEt2/30hR1LmpnDvlFT8LIMJZTVainQT1XM85VhmMq9jhT2YnnOEMK9JS4D58R5riR5dcGxYel7y/uOSFRcoca/Lmsz2+nMBOauS/yhrBkzhmS83gF/QyMx+E0aM1U9bFLt4tIwLCTvFv9U9nVUBUy9V9clP6/uhFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712571513; c=relaxed/simple;
	bh=qa6qtoo91LrB1qaXiQb/QiFYyJioLMK1RUVQhdD5UvE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=twMMPEIGlIZr4Decqsxve+LLFy/tkB05Fct43aoi3Bzb774cMoXTz692H167amStRwxEqvwMOAGOSG+wwolQ/kRguwkj3bvmnfk5pB70gSmfx+2hh0aDsZqphsh6RyT13TKZHU1JY9Y8qLGbVKjzyqr7yBOmV+EE0qEOa5Ya6Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=ALgZkFIr; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43850rVC005178;
	Mon, 8 Apr 2024 05:18:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=HP5jOhe9Z2fx8yJ8S42D1z6FwLnTIVOPjHt3pv7FB0Q=; b=
	ALgZkFIr4XGDzWgvdCzkdNoWt4KyeDfgvoEjrjJ4SuXVwppwSpduMxn5lPpWCpve
	ootVn4qB0shCwYhKWnI5zfT0V4U5TQCChPcM+Omr9feH/8FngpCarcs2BwhpX9t/
	67rCSp52NoSkpXuef+J+Tx0Ece82vupw1I5YSTGyHCPW943WZ2MRiKjeSmaU9qxN
	+MRoDYfhl2KRihXN19RUmppSbMHNSEykj8ivIIdGsR8/7lPLccLdyb61B52tnqXM
	128vVtDWUq4D/ps4bGDCfuFysuQ4Q6GJT1iuYUPbgv5whF0w3SGRwtF+V8srEZaf
	xuT4Rv1yQgc6q2QxdAg0yA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xb3sxhbbq-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 05:18:07 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 8 Apr 2024
 11:18:03 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 8 Apr 2024 11:18:03 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 43ADE820258;
	Mon,  8 Apr 2024 10:18:03 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 3/4] ASoC: cs35l56: Fix unintended bus access while resetting amp
Date: Mon, 8 Apr 2024 11:18:02 +0100
Message-ID: <20240408101803.43183-4-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240408101803.43183-1-rf@opensource.cirrus.com>
References: <20240408101803.43183-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Us6V62P_agtVZ1KfO10K_Oxc05tnbEsy
X-Proofpoint-GUID: Us6V62P_agtVZ1KfO10K_Oxc05tnbEsy
X-Proofpoint-Spam-Reason: safe

Use the new regmap_read_bypassed() so that the regmap can be left
in cache-only mode while it is booting, but the driver can still
read boot-status and chip-id information during this time.

This fixes race conditions where some writes could be issued to the
silicon while it is still rebooting, before the driver has determined
that the boot is complete.

This is typically prevented by putting regmap into cache-only until the
hardware is ready. But this assumes that the driver does not need to
access device registers to determine when it is "ready". For cs35l56
this involves polling a register and the original implementation relied
on having special handlers to block racing callbacks until dsp_work()
is complete. However, some cases were missed, most notably the ASP DAI
functions.

The regmap_read_bypassed() function allows the fix for this to be
simplified to putting regmap into cache-only during the reset. The
initial boot stages (poll HALO_STATE and read the chip ID) are all done
bypassed. Only when the amp is seen to be booted is the cache-only
revoked.

Changes are:
- cs35l56_system_reset() now leaves the regmap in cache-only status.

- cs35l56_wait_for_firmware_boot() polls using regmap_read_bypassed().

- cs35l56_init() revokes cache-only either via cs35l56_hw_init() or
  when firmware has rebooted after a soft reset.

- cs35l56_hw_init() exits cache-only after it has determined that the
  amp has booted.

- cs35l56_sdw_init() doesn't disable cache-only, since this must be
  deferred to cs35l56_init().

- cs35l56_runtime_resume_common() waits for firmware boot before exiting
  cache-only.

These changes cover three situations where the registers are not
accessible:

1) SoundWire first-time enumeration. The regmap is kept in cache-only
   until the chip is fully booted. The original code had to exit
   cache-only to read chip status in cs35l56_init() and cs35l56_hw_init()
   but this is now deferred to after the firmware has rebooted.

   In this case cs35l56_sdw_probe() leaves regmap in cache-only
   (unchanged behaviour) and cs35l56_hw_init() exits cache-only after the
   firmware is booted and the chip identified.

2) Soft reset during first-time initialization. cs35l56_init() calls
   cs35l56_system_reset(), which puts regmap into cache-only.
   On I2C/SPI cs35l56_init() then flows through to call
   cs35l56_wait_for_firmware_boot() and exit cache-only. On SoundWire
   the re-enumeration will enter cs35l56_init() again, which then drops
   down to call cs35l56_wait_for_firmware_boot() and exit cache-only.

3) Soft reset after firmware download. dsp_work() calls
   cs35l56_system_reset(), which puts regmap into cache-only. After this
   the flow is the same as (2).

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 8a731fd37f8b ("ASoC: cs35l56: Move utility functions to shared file")
---
 sound/soc/codecs/cs35l56-sdw.c    |  2 --
 sound/soc/codecs/cs35l56-shared.c | 20 ++++++++++++--------
 sound/soc/codecs/cs35l56.c        |  2 ++
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/cs35l56-sdw.c b/sound/soc/codecs/cs35l56-sdw.c
index 14a5f86019aa..70ff55c1517f 100644
--- a/sound/soc/codecs/cs35l56-sdw.c
+++ b/sound/soc/codecs/cs35l56-sdw.c
@@ -188,8 +188,6 @@ static void cs35l56_sdw_init(struct sdw_slave *peripheral)
 			goto out;
 	}
 
-	regcache_cache_only(cs35l56->base.regmap, false);
-
 	ret = cs35l56_init(cs35l56);
 	if (ret < 0) {
 		regcache_cache_only(cs35l56->base.regmap, true);
diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index 08cac58e3ab2..a83317db75ed 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -307,10 +307,10 @@ int cs35l56_wait_for_firmware_boot(struct cs35l56_base *cs35l56_base)
 		reg = CS35L56_DSP1_HALO_STATE;
 
 	/*
-	 * This can't be a regmap_read_poll_timeout() because cs35l56 will NAK
-	 * I2C until it has booted which would terminate the poll
+	 * The regmap must remain in cache-only until the chip has
+	 * booted, so use a bypassed read of the status register.
 	 */
-	poll_ret = read_poll_timeout(regmap_read, read_ret,
+	poll_ret = read_poll_timeout(regmap_read_bypassed, read_ret,
 				     (val < 0xFFFF) && (val >= CS35L56_HALO_STATE_BOOT_DONE),
 				     CS35L56_HALO_STATE_POLL_US,
 				     CS35L56_HALO_STATE_TIMEOUT_US,
@@ -362,7 +362,8 @@ void cs35l56_system_reset(struct cs35l56_base *cs35l56_base, bool is_soundwire)
 		return;
 
 	cs35l56_wait_control_port_ready();
-	regcache_cache_only(cs35l56_base->regmap, false);
+
+	/* Leave in cache-only. This will be revoked when the chip has rebooted. */
 }
 EXPORT_SYMBOL_NS_GPL(cs35l56_system_reset, SND_SOC_CS35L56_SHARED);
 
@@ -577,14 +578,14 @@ int cs35l56_runtime_resume_common(struct cs35l56_base *cs35l56_base, bool is_sou
 		cs35l56_issue_wake_event(cs35l56_base);
 
 out_sync:
-	regcache_cache_only(cs35l56_base->regmap, false);
-
 	ret = cs35l56_wait_for_firmware_boot(cs35l56_base);
 	if (ret) {
 		dev_err(cs35l56_base->dev, "Hibernate wake failed: %d\n", ret);
 		goto err;
 	}
 
+	regcache_cache_only(cs35l56_base->regmap, false);
+
 	ret = cs35l56_mbox_send(cs35l56_base, CS35L56_MBOX_CMD_PREVENT_AUTO_HIBERNATE);
 	if (ret)
 		goto err;
@@ -757,7 +758,7 @@ int cs35l56_hw_init(struct cs35l56_base *cs35l56_base)
 	 * devices so the REVID needs to be determined before waiting for the
 	 * firmware to boot.
 	 */
-	ret = regmap_read(cs35l56_base->regmap, CS35L56_REVID, &revid);
+	ret = regmap_read_bypassed(cs35l56_base->regmap, CS35L56_REVID, &revid);
 	if (ret < 0) {
 		dev_err(cs35l56_base->dev, "Get Revision ID failed\n");
 		return ret;
@@ -768,7 +769,7 @@ int cs35l56_hw_init(struct cs35l56_base *cs35l56_base)
 	if (ret)
 		return ret;
 
-	ret = regmap_read(cs35l56_base->regmap, CS35L56_DEVID, &devid);
+	ret = regmap_read_bypassed(cs35l56_base->regmap, CS35L56_DEVID, &devid);
 	if (ret < 0) {
 		dev_err(cs35l56_base->dev, "Get Device ID failed\n");
 		return ret;
@@ -787,6 +788,9 @@ int cs35l56_hw_init(struct cs35l56_base *cs35l56_base)
 
 	cs35l56_base->type = devid & 0xFF;
 
+	/* Silicon is now identified and booted so exit cache-only */
+	regcache_cache_only(cs35l56_base->regmap, false);
+
 	ret = regmap_read(cs35l56_base->regmap, CS35L56_DSP_RESTRICT_STS1, &secured);
 	if (ret) {
 		dev_err(cs35l56_base->dev, "Get Secure status failed\n");
diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 8d2f021fb362..5a4e0e479414 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -1531,6 +1531,8 @@ int cs35l56_init(struct cs35l56_private *cs35l56)
 			return ret;
 
 		dev_dbg(cs35l56->base.dev, "Firmware rebooted after soft reset\n");
+
+		regcache_cache_only(cs35l56->base.regmap, false);
 	}
 
 	/* Disable auto-hibernate so that runtime_pm has control */
-- 
2.39.2



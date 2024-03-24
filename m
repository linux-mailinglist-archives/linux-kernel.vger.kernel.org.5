Return-Path: <linux-kernel+bounces-113434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC8D88844C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D906B24ADB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFAE1AB19F;
	Sun, 24 Mar 2024 22:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOlHLEXl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD4C1AB17C;
	Sun, 24 Mar 2024 22:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320236; cv=none; b=RvNKWp5YTwbcVisIV3Y5yZdQIVsOTCvBvI3vMrut+VFBvoxJjCfEWSNp3skHaydLaDV20PpoVouQlQGNAu5kO6yV/UmanDeb9utA6gEKAV8KWqy0cGZ6lbk4IXmcWa12w4kQSlHjtVFCOtWPewzY6dhk4+eQIHhn3HpuPSFWwKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320236; c=relaxed/simple;
	bh=lppP1siZJgQmbkQMvaFEoIwmC5tUGtg3YwEGgKlGD9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZBcCfKKCYh5Rh133jPGjfVyWpfFaWlX0+qHL487Mvqivm3WMlcqC9XCBoEmcL3lcbMCjQg/JLoznyMvSAJefUWVhXoB+OW+PYdtn4d+CFStIoYEwdxCqDgVaXjUWcMUBDzkMpYRYkGBC+poG+vQCMHFsCVzqEt6fegNdBDhkXOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOlHLEXl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6E0C433B1;
	Sun, 24 Mar 2024 22:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320236;
	bh=lppP1siZJgQmbkQMvaFEoIwmC5tUGtg3YwEGgKlGD9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hOlHLEXlfxnI4u26GDflKk8epihASbnHsUog2iiG8OHXUWAB7d3wOSa9TvZJr3HX0
	 QblWRSO5jXuuXVNLXxb8pXRAmzCgcsLFtNXKHYBvK8aPizdhFCvTIIouU1ZOfUM+NK
	 LpLF3Yylw9EoksIGkbYrNweqHTKdoApNrxxvXc+NpNyog3IhLrukdP1UV8k2nh7ZxL
	 vSJibViPoe+rocSpiJLRgjdgUZhY5VYW3nGzrCXTgoYGyGg3WrbXaYHQq3ide43Jli
	 qxeyu7BsoqtlcXgSkQe0HFYEZMY7eXrNtVbgQq3mq1euFiLwq8lhcr2p4o+fbB4lOV
	 NudLfuN48rLAQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gergo Koteles <soyer@irl.hu>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 543/715] ALSA: hda/tas2781: restore power state after system_resume
Date: Sun, 24 Mar 2024 18:32:02 -0400
Message-ID: <20240324223455.1342824-544-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Gergo Koteles <soyer@irl.hu>

[ Upstream commit 9fc91a6fe37c78ef301aed4251f7e50b8524e72d ]

After system_resume the amplifers will remain off, even if they were on
before system_suspend.

Use playback_started bool to save the playback state, and restore power
state based on it.

Fixes: 5be27f1e3ec9 ("ALSA: hda/tas2781: Add tas2781 HDA driver")
Signed-off-by: Gergo Koteles <soyer@irl.hu>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Message-ID: <1742b61901781826f6e6212ffe1d21af542d134a.1709918447.git.soyer@irl.hu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/tas2781_hda_i2c.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index a99f490c6a234..7aef93126ed0c 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -160,11 +160,13 @@ static void tas2781_hda_playback_hook(struct device *dev, int action)
 		pm_runtime_get_sync(dev);
 		mutex_lock(&tas_hda->priv->codec_lock);
 		tasdevice_tuning_switch(tas_hda->priv, 0);
+		tas_hda->priv->playback_started = true;
 		mutex_unlock(&tas_hda->priv->codec_lock);
 		break;
 	case HDA_GEN_PCM_ACT_CLOSE:
 		mutex_lock(&tas_hda->priv->codec_lock);
 		tasdevice_tuning_switch(tas_hda->priv, 1);
+		tas_hda->priv->playback_started = false;
 		mutex_unlock(&tas_hda->priv->codec_lock);
 
 		pm_runtime_mark_last_busy(dev);
@@ -666,6 +668,7 @@ static void tasdev_fw_ready(const struct firmware *fmw, void *context)
 	tasdevice_save_calibration(tas_priv);
 
 	tasdevice_tuning_switch(tas_hda->priv, 0);
+	tas_hda->priv->playback_started = true;
 
 out:
 	mutex_unlock(&tas_hda->priv->codec_lock);
@@ -837,6 +840,9 @@ static int tas2781_runtime_suspend(struct device *dev)
 
 	mutex_lock(&tas_hda->priv->codec_lock);
 
+	/* The driver powers up the amplifiers at module load time.
+	 * Stop the playback if it's unused.
+	 */
 	if (tas_hda->priv->playback_started) {
 		tasdevice_tuning_switch(tas_hda->priv, 1);
 		tas_hda->priv->playback_started = false;
@@ -876,7 +882,8 @@ static int tas2781_system_suspend(struct device *dev)
 	mutex_lock(&tas_hda->priv->codec_lock);
 
 	/* Shutdown chip before system suspend */
-	tasdevice_tuning_switch(tas_hda->priv, 1);
+	if (tas_hda->priv->playback_started)
+		tasdevice_tuning_switch(tas_hda->priv, 1);
 
 	mutex_unlock(&tas_hda->priv->codec_lock);
 
@@ -908,6 +915,10 @@ static int tas2781_system_resume(struct device *dev)
 	 * calibrated data inside algo.
 	 */
 	tasdevice_apply_calibration(tas_hda->priv);
+
+	if (tas_hda->priv->playback_started)
+		tasdevice_tuning_switch(tas_hda->priv, 0);
+
 	mutex_unlock(&tas_hda->priv->codec_lock);
 
 	return 0;
-- 
2.43.0



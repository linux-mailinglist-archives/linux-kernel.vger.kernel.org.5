Return-Path: <linux-kernel+bounces-113908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 671BB88874D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98BAD1C265C5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A59A21087A;
	Sun, 24 Mar 2024 23:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGCehZq8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F141F1DF0E5;
	Sun, 24 Mar 2024 22:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321001; cv=none; b=T+5tYwSbomD5dLZlxxK7NNbj3uPf9Bj0WXky6d0MoWu1rsKD3Dja3eKZ4gL/H17MKMQy61LuMLJ0P69FtpSbaOfzfw5IhxUYsrnY3vSOQbQDCvzCWj78+9VbKnTHaVhrQzBMzIUsxQ6CrAcg0FjX3wBy/dV4SoiqOPpFmATUBHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321001; c=relaxed/simple;
	bh=0YEcVCzwFnO9xkjbSpQTe/cq3xstYc6uRljyZtwnVUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=USJAgHI4IcTx6PBArbVADRyuJJy0TtzX+zi3ZI+RJd+hvCf2YEzh4NkEVzHrfxysMtaCwtV4LAjJ1tesq6Jj7wMgJ8HXl9YePXehEYMy7Rm2j9ykvSnPEx66JkSfcgR1vn5PtNGw0amsLUWgCZAukUM6TM6j4q6QMseA9kaCCeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sGCehZq8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D38C43394;
	Sun, 24 Mar 2024 22:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320999;
	bh=0YEcVCzwFnO9xkjbSpQTe/cq3xstYc6uRljyZtwnVUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sGCehZq8zWuU33VGQxhWFnYw/RB11MCutyKOpCKOVjdhV+hbZqFEByGAF/SZbAKi+
	 7RtRzp2gEuK6jXo0ILm/qYiJ6lbejRueWbi9bomjQIX1vD0t5KeCa8dvZOGh3jZGFy
	 IP7T5Uvh2n54xA4Ns7/JJuPRgqihvKq1zFE3vjQpebCTacq+49SqUbqsxxtpSCfyV4
	 wneD16rJ/zf22FMfE5rkbJ9+Fq5V67w6OL/4lHsmWsUHxpQw7RNiJWqU1+vAU6awQt
	 vmS6PGFRZCan/+pC4UTXgaynNFrgHMY69lwHGeF1+Whdor4tdKbpW6GJcP7y5mREE+
	 4GOZNPpU34xPA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gergo Koteles <soyer@irl.hu>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 562/713] ALSA: hda/tas2781: restore power state after system_resume
Date: Sun, 24 Mar 2024 18:44:48 -0400
Message-ID: <20240324224720.1345309-563-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index 4b6e22a4b0c11..5179b69e403ac 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -142,11 +142,13 @@ static void tas2781_hda_playback_hook(struct device *dev, int action)
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
@@ -585,6 +587,7 @@ static void tasdev_fw_ready(const struct firmware *fmw, void *context)
 	tasdevice_save_calibration(tas_priv);
 
 	tasdevice_tuning_switch(tas_hda->priv, 0);
+	tas_hda->priv->playback_started = true;
 
 out:
 	mutex_unlock(&tas_hda->priv->codec_lock);
@@ -750,6 +753,9 @@ static int tas2781_runtime_suspend(struct device *dev)
 
 	mutex_lock(&tas_hda->priv->codec_lock);
 
+	/* The driver powers up the amplifiers at module load time.
+	 * Stop the playback if it's unused.
+	 */
 	if (tas_hda->priv->playback_started) {
 		tasdevice_tuning_switch(tas_hda->priv, 1);
 		tas_hda->priv->playback_started = false;
@@ -789,7 +795,8 @@ static int tas2781_system_suspend(struct device *dev)
 	mutex_lock(&tas_hda->priv->codec_lock);
 
 	/* Shutdown chip before system suspend */
-	tasdevice_tuning_switch(tas_hda->priv, 1);
+	if (tas_hda->priv->playback_started)
+		tasdevice_tuning_switch(tas_hda->priv, 1);
 
 	mutex_unlock(&tas_hda->priv->codec_lock);
 
@@ -821,6 +828,10 @@ static int tas2781_system_resume(struct device *dev)
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



Return-Path: <linux-kernel+bounces-114377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50528888A19
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B6EA2909DD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8E6270C80;
	Sun, 24 Mar 2024 23:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pIqi48U7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F62217DF4;
	Sun, 24 Mar 2024 23:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321779; cv=none; b=pknI0VJFv1JUT1NhXidiiPGLIG246aZWm709rzd5TBxQcltm7zeTxRrMzmEj1ARH/knOa2q1st9r4BcesSz3NDqod3wb7ICCeuHbCPW//+jMF44DjPBrirzxuQmqhh2/Vw2LuqPpRuchCguie3OrUwbnx1pHCsP3ECS7+aRNJYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321779; c=relaxed/simple;
	bh=krK+wVOeM6q1gNeW62YWargjT6/9PNRDvSAASNYt+VA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hg/GsVkSOQ/2yCrQ9cUpJJ+Q43X60HRsnAFDP0tPui0RZgFxw3EO5iVRkAW8WlnQD3f1niaIEpH8bYEFvYOI3i04hKT8dxRaO/OOCFgONk0fXOpMyB2mr82luApp81IAHtTxT/PgnyeG/wt/cq9aLeZhW0U7f+QyAcognQSgWPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pIqi48U7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EFE2C433C7;
	Sun, 24 Mar 2024 23:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321777;
	bh=krK+wVOeM6q1gNeW62YWargjT6/9PNRDvSAASNYt+VA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pIqi48U73jAS+8ejnv1Pp43GOamMy4pXfrnOjlvrR1H3rVCtUo1onwZAF/TMH95Rp
	 eRghc9ROtExuV+633eFt7wTqny5Juydz5wTWrZB0W6WbI4Ol6p4H19QnYMRLe+ZQVp
	 vd3IT36s2bD4Ubh6zetgsSV8On7CxYLJyS48kzntDll68fNREenoaghaHXd9WFunSp
	 XUQjJfqJW7XhCq1bI+Omfrpv13AVeH7xno8h0tVs+vCgLeTKzfgDdOosUdG+Zmpii6
	 prZ0lSVglGj1JQbWUBQoznYhXps81QhUZThL2IIobioE1EZBAImEPUIP4tYjkUNlmb
	 ti0QYeN3/F1QA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gergo Koteles <soyer@irl.hu>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 505/638] ALSA: hda/tas2781: restore power state after system_resume
Date: Sun, 24 Mar 2024 18:59:02 -0400
Message-ID: <20240324230116.1348576-506-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index a63860f0e283d..4c1fb4e87faaf 100644
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



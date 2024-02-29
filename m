Return-Path: <linux-kernel+bounces-86971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 449AA86CDB7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E72A72845C0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B064AEF8;
	Thu, 29 Feb 2024 15:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qu+PETy8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B744AEDC;
	Thu, 29 Feb 2024 15:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221773; cv=none; b=fqJKESXSIcCNhjuODLKpPHM7dbLZkoMbEIquuLf+idPMgpu7NOPhZMwmZSz7BVl2Y8tJy9/G1GGQFiWMXHDfjrxwC2mU+mmIA+NvK/6efK+nlbU6YQ8eQJ0f6nuJmku34vyJd+AchZsrnLyui0Rib+4Icd/oGOrnYiyLYr++HgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221773; c=relaxed/simple;
	bh=I+vVsVM23mkEKCiSNKy8dYWHbX1Qn5lawkbweNDKI1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fcUi5ZtHpOmM8pnXmPcSeV1OiGtvFj9K+2ZHPBCoH/T5/idC+Osq50Ivvm1Dbrye0iDdelHYr99eJjfvlMA35aJTuJjMxHSz8scFYm6PGYmCbLuwHP166vRKsVEOSqqYnfEzYzyTaGEIx5mmAd3jhB0Z85eBDZqdIcp0J5QJE/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qu+PETy8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1343C43399;
	Thu, 29 Feb 2024 15:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221773;
	bh=I+vVsVM23mkEKCiSNKy8dYWHbX1Qn5lawkbweNDKI1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qu+PETy8IjPRBrbkWj7WhHnzcR+SmhM2hBKCSasL1wdoIEvzUXHldgWYfIw8nt2Cn
	 FD3Gl63jGYYhd9YZjprh1+43F47DeMbcDcfovwOQcFQcqP/vbxmeQOuzZAeTs4qXxD
	 VKocXYHLdEyGEt9dNreOfe1cVeqTufQj3FrM95zT8zmj3MKt0LbZR/7ymuAGO75bxu
	 /X9dbuKO28lEKcTX5c+wVBiJHOFfzZmRSwpKxgFBWqC7VW2yP5yr9uZeZueHuiwalj
	 3S7SRE7Cgm/YEzImKRKK2GJ6xuWGtYtMmoMqfrJg/06ARwIeu0Rz1FWxEaYJhfJz1y
	 F9+RIL+UrJ5KA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	daniel.baluta@nxp.com,
	perex@perex.cz,
	tiwai@suse.com,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 23/26] ASoC: SOF: ipc4-pcm: Workaround for crashed firmware on system suspend
Date: Thu, 29 Feb 2024 10:48:42 -0500
Message-ID: <20240229154851.2849367-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229154851.2849367-1-sashal@kernel.org>
References: <20240229154851.2849367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.6
Content-Transfer-Encoding: 8bit

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

[ Upstream commit c40aad7c81e5fba34b70123ed7ce3397fa62a4d2 ]

When the system is suspended while audio is active, the
sof_ipc4_pcm_hw_free() is invoked to reset the pipelines since during
suspend the DSP is turned off, streams will be re-started after resume.

If the firmware crashes during while audio is running (or when we reset
the stream before suspend) then the sof_ipc4_set_multi_pipeline_state()
will fail with IPC error and the state change is interrupted.
This will cause misalignment between the kernel and firmware state on next
DSP boot resulting errors returned by firmware for IPC messages, eventually
failing the audio resume.
On stream close the errors are ignored so the kernel state will be
corrected on the next DSP boot, so the second boot after the DSP panic.

If sof_ipc4_trigger_pipelines() is called from sof_ipc4_pcm_hw_free() then
state parameter is SOF_IPC4_PIPE_RESET and only in this case.

Treat a forced pipeline reset similarly to how we treat a pcm_free by
ignoring error on state sending to allow the kernel's state to be
consistent with the state the firmware will have after the next boot.

Link: https://github.com/thesofproject/sof/issues/8721
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://msgid.link/r/20240213115233.15716-1-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/ipc4-pcm.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/ipc4-pcm.c b/sound/soc/sof/ipc4-pcm.c
index 39039a647cca3..ea70c0d7cf75a 100644
--- a/sound/soc/sof/ipc4-pcm.c
+++ b/sound/soc/sof/ipc4-pcm.c
@@ -413,7 +413,18 @@ static int sof_ipc4_trigger_pipelines(struct snd_soc_component *component,
 	ret = sof_ipc4_set_multi_pipeline_state(sdev, state, trigger_list);
 	if (ret < 0) {
 		dev_err(sdev->dev, "failed to set final state %d for all pipelines\n", state);
-		goto free;
+		/*
+		 * workaround: if the firmware is crashed while setting the
+		 * pipelines to reset state we must ignore the error code and
+		 * reset it to 0.
+		 * Since the firmware is crashed we will not send IPC messages
+		 * and we are going to see errors printed, but the state of the
+		 * widgets will be correct for the next boot.
+		 */
+		if (sdev->fw_state != SOF_FW_CRASHED || state != SOF_IPC4_PIPE_RESET)
+			goto free;
+
+		ret = 0;
 	}
 
 	/* update RUNNING/RESET state for all pipelines that were just triggered */
-- 
2.43.0



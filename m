Return-Path: <linux-kernel+bounces-86994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6955786CE08
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F6641F2573F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228C614405A;
	Thu, 29 Feb 2024 15:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLJQmvWq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6907E14404A;
	Thu, 29 Feb 2024 15:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221823; cv=none; b=eGw/+NMM7DABnYanh1O7MuMEt69alBLcXgfJyli+zqnoPCZnezh4SKqMCSuEb3G2Nl/zKbcqyQDbj6x6IM/p/sIGxPauShOugDv87lrovatVoUIH9/e/XcODAQhFQgYocfS5NQ92mKgLv5vVwWlhfAzMVnGu3xzEb48QcUhkqDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221823; c=relaxed/simple;
	bh=BTstNTU4rdjYfmXZ3VWwYPtnTndcYv9QQpk64ZexWUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ra/7HChvlYLrtX9olNGjVF7s9s7Y61091Ypd43/tN+JIGtFzIlNcSmRNstoL9whjoQWVuXVhBQBiFHe1AzH4DDQFZDFbV9EMBbCUF1sIsE59e22Q7hetpbyEXjAiwNa9BQqw410xynBo153GjsUgyu7bQVFE0HOG1ITcUz846o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLJQmvWq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2879C433F1;
	Thu, 29 Feb 2024 15:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221823;
	bh=BTstNTU4rdjYfmXZ3VWwYPtnTndcYv9QQpk64ZexWUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kLJQmvWqsh51aS4RcOflgkcF9YVxyLpKs2waVK54OO+kwT21a/S2Z9D3axjwtjdm1
	 h6ezYybWUCCz9pmMxS3tG6LS0PHU2nwXh3ltFMPaD/2ekmOK8RDM8yLFqPQFr6VdOe
	 EWrBRkcQbh1CdKNRXMWVF0aUFPrVPbx+flEAtMwwrXMLaWToqMavt+6yJ5WA3hEbVJ
	 fplENAvs9filep/dduWs20NJG4S08bnvhhvohxNisoMyDbw3L8+9OMYKqlfRQmBU8U
	 nVxdEZOuertEjyDzFXRYVYBKhLEu5DsM0xS9XTBc7AL5jFwl1ALE+MJmBIh5+62RKQ
	 8YSWWydNWwoYw==
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
Subject: [PATCH AUTOSEL 6.6 19/21] ASoC: SOF: ipc4-pcm: Workaround for crashed firmware on system suspend
Date: Thu, 29 Feb 2024 10:49:39 -0500
Message-ID: <20240229154946.2850012-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229154946.2850012-1-sashal@kernel.org>
References: <20240229154946.2850012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.18
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
index db19cd03ecad8..e8acf60c27a74 100644
--- a/sound/soc/sof/ipc4-pcm.c
+++ b/sound/soc/sof/ipc4-pcm.c
@@ -377,7 +377,18 @@ static int sof_ipc4_trigger_pipelines(struct snd_soc_component *component,
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



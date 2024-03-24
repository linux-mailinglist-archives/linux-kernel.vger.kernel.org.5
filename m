Return-Path: <linux-kernel+bounces-115334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F45889AD4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5400A1F3482D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C151E5857;
	Mon, 25 Mar 2024 02:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zj/cxrP/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54CD77F1E;
	Sun, 24 Mar 2024 22:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320462; cv=none; b=TlXOh0hyUJEVIRyBKuuoCuHl5Xlf71FRs8xKc3hW85vQkFEBC32POmumDe8KjRX7zYek+AEoBlzU7K7nCbbJCslk0kc0cn598gamY7uy4Z+V0EHgvpgRZjEDm8EtX7k8gYCbdNh0nl4XfgWfPCU03dCk+OObRFxzZQwczitmbNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320462; c=relaxed/simple;
	bh=I+vVsVM23mkEKCiSNKy8dYWHbX1Qn5lawkbweNDKI1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Szmhh5fLrz+tW0MhvQaaLzevue+JFaAWsBQyLUSuRK6KuMUatflaahU75i3xg9Cynl2ACn4RdBSEbSmc381qCsX2qsDE4W7jMqB89cUiWRbbPzGmnqsewAVjdTyIq3CllqQvkmCvUgUT5EJVJ/4vyzBdpgAh630RZo8a4QP8IQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zj/cxrP/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97433C43390;
	Sun, 24 Mar 2024 22:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320462;
	bh=I+vVsVM23mkEKCiSNKy8dYWHbX1Qn5lawkbweNDKI1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zj/cxrP/gEvNpE+Ibx6wtU8YB4FOU5x87M/pThTAVP425XrZljFBgweMSwjZUpTB8
	 56vtES4+vdGOIpmjPm1ZwrbgszRpxuZyPW0riIKc4M2RPptARUJj2eZvtmBPhUnVAp
	 cpoKZfnFV9gnS7N6xOfDDSGiofnOa2K6SXgjA8oMcekY5hxrdnHuefbLQ5U3tCd5vo
	 CbsqZTd96zoqyobkd7fi3Ic/d38O5A2mTwQB85+I8tPOtc4vUnly83fPXMBq6SKdVJ
	 L4lv74juFiQeAp2mw28E5xcZ3oa6IGgsvVS/aVnmNCgIM1ruSZDac3QUjoO7vWTFfy
	 j9e+n0iu40k6g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 021/713] ASoC: SOF: ipc4-pcm: Workaround for crashed firmware on system suspend
Date: Sun, 24 Mar 2024 18:35:47 -0400
Message-ID: <20240324224720.1345309-22-sashal@kernel.org>
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



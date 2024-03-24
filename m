Return-Path: <linux-kernel+bounces-115591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE35188943C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F055D1C2F06E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E307F251161;
	Mon, 25 Mar 2024 02:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKd+DjPs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094701E5F4D;
	Sun, 24 Mar 2024 23:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321297; cv=none; b=TQqKixEw61tlY7miunYbB5dmoD/UwTR4OGl316v9M2i9glg4WHDKwtdgTD11tye3m5N0A7UqWiltcQynx+i1djY6t4vZ2gwQ+P47jnsi2UEpf9wixtjOImjNcH+jnk43nf0A4Tn0VFIpTosGJPxsAj+f5/k/KaD58sULK5prQoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321297; c=relaxed/simple;
	bh=BTstNTU4rdjYfmXZ3VWwYPtnTndcYv9QQpk64ZexWUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D11m9NqdwupslmJpQ8SI6MKxwKGord2OLmRT74vOxeyG6v8Uc1kWA0FHZRS0xnlhUT3LdGkrFI5BKtGSF4BVyjv0SimLez1m8chSkBuoVbmVxvexc3suWPB91uHlE7Ej+YwdwOswLkQVTj6yb6yhlYe4Vfvkg2qIP9QAFQBN/3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKd+DjPs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDDD8C433F1;
	Sun, 24 Mar 2024 23:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321295;
	bh=BTstNTU4rdjYfmXZ3VWwYPtnTndcYv9QQpk64ZexWUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jKd+DjPsi9d8OytFZCg1b6qIQ5gdwXVRR5qXwjU89TUN8eG1P/FIxylQZHc+XdiFh
	 iUcyODz5JKwyIbqcf0Ga5ieJVxw2gXLfeWvsCS+JoviG66W+Y6BCJDXYr7vFa10kvx
	 /OGAMx1iRkscNYxNWm77uNBZXWzee/kEoHrgVp35ldwLeoMHFvltBrFrW1Vxjeomo7
	 uIKgS2v9WA0DvG7B2VzM2SUTegJL/jnV1+js9w2GpH1gQ+b/bLpz2ZWsvB+tNCrwTn
	 prJ3UrsY3F6IOurGRJJGhVE00DUspjD32YQTvw6Qv69w8rjSvQ3ijKv0VINTbv0Kyo
	 /uBx6uLpPlsOQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 018/638] ASoC: SOF: ipc4-pcm: Workaround for crashed firmware on system suspend
Date: Sun, 24 Mar 2024 18:50:55 -0400
Message-ID: <20240324230116.1348576-19-sashal@kernel.org>
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



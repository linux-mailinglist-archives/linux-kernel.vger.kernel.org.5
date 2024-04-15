Return-Path: <linux-kernel+bounces-145097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 875AA8A4F85
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFABDB217FD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621507317D;
	Mon, 15 Apr 2024 12:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWO1CeD1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993B871B44;
	Mon, 15 Apr 2024 12:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185348; cv=none; b=JHvhziKmgtmJOZjTq7f/fc16f1OCwIXNVaAr1cyXpSkl2E1fxnLyMr6tcuCWKMBmaaGUw8Bp8OHAKieChF9P/bYHJB5cRATMMRW5c8zPL+AoIhX9+ODfKJc7eTQrynevddRtp+Tz9H3XF0gyphd8ea2pT0jcqZLoM/6u5Qbv/dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185348; c=relaxed/simple;
	bh=vC/YQUO5EwZMe8J3Kp1GMB275WzEYkCYfIae53AZnHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z+xYu7YJj8itGygttsS7Ttw7eCHwli6gNRoh6P+ubhaeqlD0uv8aU2RjPElmv4IhD5uXJ0oZssXBsGhZhsbuW4wkFA4/drO4b6fCJh4ByyOVvAb1Y3fufuYYrHMjiDnS7OCSRVV9TSalFcxDM7MDwq6DsgeB/ZguzfDjDb3dSfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWO1CeD1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D41C2BD10;
	Mon, 15 Apr 2024 12:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713185348;
	bh=vC/YQUO5EwZMe8J3Kp1GMB275WzEYkCYfIae53AZnHc=;
	h=From:To:Cc:Subject:Date:From;
	b=VWO1CeD1p5WOj/bLFFTooLjCqmAkFGn4/WD2XaXyQewzrUhobBQB6+PjHXiWLxKt+
	 AY0sunwHV1Xp0D9RMaGFJiykgVXZv9OKrgYFhB4C+SxXKogu58nZKYWpZwvXUpO6rP
	 Sv3ADUBTigWV6V0CXehhglqavTOKtoYNzJ0k+cUj1C3xke/jNXjYfaMEMzlTkvOrip
	 kZREV1D66xzssu6wcO866Rft1saXX7TdpYWpMVmoQN1CvspwSFVdtueIBPofrlbtwU
	 YolyWhZ8VjYD/W/AobqK08S4e1aAl+e4HKLlfbU/SNYvfCqrYGP2fn0Vase3VIXCTf
	 3q1U/1WX32ExA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Rander Wang <rander.wang@intel.com>,
	Liam Girdwood <liam.r.girdwood@intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	yung-chuan.liao@linux.intel.com,
	daniel.baluta@nxp.com,
	perex@perex.cz,
	tiwai@suse.com,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 01/15] ASoC: SOF: Intel: hda-dsp: Skip IMR boot on ACE platforms in case of S3 suspend
Date: Mon, 15 Apr 2024 06:02:41 -0400
Message-ID: <20240415100311.3126785-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.6
Content-Transfer-Encoding: 8bit

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

[ Upstream commit c61115b37ff964d63191dbf4a058f481daabdf57 ]

SoCs with ACE architecture are tailored to use s2idle instead deep (S3)
suspend state and the IMR content is lost when the system is forced to
enter even to S3.
When waking up from S3 state the IMR boot will fail as the content is lost.
Set the skip_imr_boot flag to make sure that we don't try IMR in this case.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Link: https://msgid.link/r/20240322112504.4192-1-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/intel/hda-dsp.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sof/intel/hda-dsp.c b/sound/soc/sof/intel/hda-dsp.c
index 2445ae7f6b2e9..1506982a56c30 100644
--- a/sound/soc/sof/intel/hda-dsp.c
+++ b/sound/soc/sof/intel/hda-dsp.c
@@ -681,17 +681,27 @@ static int hda_suspend(struct snd_sof_dev *sdev, bool runtime_suspend)
 	struct sof_intel_hda_dev *hda = sdev->pdata->hw_pdata;
 	const struct sof_intel_dsp_desc *chip = hda->desc;
 	struct hdac_bus *bus = sof_to_bus(sdev);
+	bool imr_lost = false;
 	int ret, j;
 
 	/*
-	 * The memory used for IMR boot loses its content in deeper than S3 state
-	 * We must not try IMR boot on next power up (as it will fail).
-	 *
+	 * The memory used for IMR boot loses its content in deeper than S3
+	 * state on CAVS platforms.
+	 * On ACE platforms due to the system architecture the IMR content is
+	 * lost at S3 state already, they are tailored for s2idle use.
+	 * We must not try IMR boot on next power up in these cases as it will
+	 * fail.
+	 */
+	if (sdev->system_suspend_target > SOF_SUSPEND_S3 ||
+	    (chip->hw_ip_version >= SOF_INTEL_ACE_1_0 &&
+	     sdev->system_suspend_target == SOF_SUSPEND_S3))
+		imr_lost = true;
+
+	/*
 	 * In case of firmware crash or boot failure set the skip_imr_boot to true
 	 * as well in order to try to re-load the firmware to do a 'cold' boot.
 	 */
-	if (sdev->system_suspend_target > SOF_SUSPEND_S3 ||
-	    sdev->fw_state == SOF_FW_CRASHED ||
+	if (imr_lost || sdev->fw_state == SOF_FW_CRASHED ||
 	    sdev->fw_state == SOF_FW_BOOT_FAILED)
 		hda->skip_imr_boot = true;
 
-- 
2.43.0



Return-Path: <linux-kernel+bounces-43087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FDD840B6F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E022428EA27
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFD9156965;
	Mon, 29 Jan 2024 16:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="T80kB7TM"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BB015699A;
	Mon, 29 Jan 2024 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545683; cv=none; b=jxnacxtqqKcea7Fo75En3OE9j/gCy0ggLhBWY0sPGyQThL1xAsabzLz5p7xXuQpB3akb/dytaHVV/f7e4IyjmIM919QhOnN9QaHh2Bl/0kp97kSMQRGy/ecGupvdHxYMrtbE+nEt/e3xuUjcp7RsapsXj6CuggTN2MsoO7BisiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545683; c=relaxed/simple;
	bh=Swu1L1Cn783DMdkZFh+9JpM4v2AC76QqJymHwYw/bN0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PV3zbBdPX7YajGY6RN7OPq9I/Zjn9h8H6yrovP57JfyEBbIGgSdfdvNERIZUbI+ezKLhHw01p1epVZ5JuAFMdbQtjx5s1IQndWrIgSbo5WpM9LHNN8qIsMhVW753SC3g//qGgB1t8RVL5xMfpEMlJOeVNtCzCm/zBMlpTsch10A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=T80kB7TM; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T5fM0F006968;
	Mon, 29 Jan 2024 10:27:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=aC6ZyauHCUjrBt24NljiwgVZd+pvmCzsqS/E5+3JjT4=; b=
	T80kB7TMsJFHkirn/tbi6oAOIe+EVvlKcS+uoRIGLVesRHysSh3uFfmzhd7nmHry
	VgOl2fb/DnEL/KjsfSv1kcsFpXAcnLTVSDHQVMV2u4hZ9uesRRsScUHuQoJ9dhjm
	2phU2b7aPCWtABH+9eteBmv6cdTWl4aWzV7XGtePXIWVKc/4SxnN5nW2EJjveN9y
	V9/ELFX8BTu8MlXVYxygC0iHYX4VzXO16+u8ObZLZmkAzMCZ14gb4IvOQNnwjowT
	veYHHAm5hIiQ1TxH+zrhNjV8z6GyrdBj6kasLgZbVmh6/lKHKyWmWM6e4lLr9gkU
	oSYqCjkIzlExbRgaZ8RpIw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3vvy4nta8p-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 10:27:54 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jan
 2024 16:27:43 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Mon, 29 Jan 2024 16:27:43 +0000
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.204])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 7585E820242;
	Mon, 29 Jan 2024 16:27:43 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 06/18] ASoC: cs35l56: Remove buggy checks from cs35l56_is_fw_reload_needed()
Date: Mon, 29 Jan 2024 16:27:25 +0000
Message-ID: <20240129162737.497-7-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240129162737.497-1-rf@opensource.cirrus.com>
References: <20240129162737.497-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: bWtfPBqWyiJgLzXe8bT_v_QwQOJFqq0r
X-Proofpoint-GUID: bWtfPBqWyiJgLzXe8bT_v_QwQOJFqq0r
X-Proofpoint-Spam-Reason: safe

Remove the check of fw_patched from cs35l56_is_fw_reload_needed().
Also remove the redundant check for control of the reset GPIO.

The fw_patched flag is set when cs35l56_dsp_work() has completed its
steps to download firmware and power-up wm_adsp. There was a check in
cs35l56_is_fw_reload_needed() to make a quick exit of 'false' if
!fw_patched. The original idea was that the system might be suspended
before the driver has ever made any attempt to download firmware, and
in that case the driver doesn't need to return to a patched state
because it was never in a patched state.

This check of fw_patched is buggy because it prevented ever recovering
from a failed patch. If a previous attempt to patch and reboot the
silicon had failed it would leave fw_patched==false. This would mean
the driver never attempted another download even though the fault may
have been cleared (by a hard reset, for example).

It is also a redundant check because the calling code already makes
a quick exit if cs35l56_component_probe() has not been called, which
deals with the original intent of this check but in a safer way.

The check for reset GPIO is redundant: if the silicon was hard-reset
the FIRMWARE_MISSING flag will be 1. But this check created an
expectation that the suspend/resume code toggles reset. This can't
easily be protected against accidental code breakage. The only reason
for the check was to skip runtime-resuming the driver to read the
PROTECTION_STATUS register when it already knows it reset the silicon.
But in that case the driver will have to be runtime-resumed to do
the firmware download. So it created an assumption for no benefit.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 8a731fd37f8b ("ASoC: cs35l56: Move utility functions to shared file")
---
 sound/soc/codecs/cs35l56-shared.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index 953ba066bab1..0cd572de73a9 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -400,17 +400,6 @@ int cs35l56_is_fw_reload_needed(struct cs35l56_base *cs35l56_base)
 	unsigned int val;
 	int ret;
 
-	/* Nothing to re-patch if we haven't done any patching yet. */
-	if (!cs35l56_base->fw_patched)
-		return false;
-
-	/*
-	 * If we have control of RESET we will have asserted it so the firmware
-	 * will need re-patching.
-	 */
-	if (cs35l56_base->reset_gpio)
-		return true;
-
 	/*
 	 * In secure mode FIRMWARE_MISSING is cleared by the BIOS loader so
 	 * can't be used here to test for memory retention.
-- 
2.39.2



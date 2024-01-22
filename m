Return-Path: <linux-kernel+bounces-33512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1899D836A83
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BA181C24BC3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1CB14077A;
	Mon, 22 Jan 2024 15:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFZQpZfM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759B5140772;
	Mon, 22 Jan 2024 15:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936565; cv=none; b=OJktyk8vdBKZw0ovbJVUOyftdpyGDtRFM3XYmb7v+9bzP8HhnBDGOIo4KMTPRAlwSA+w8NJxvNB74khyKDQqqgzWBM8wqFEWUOZoJCJY8rcAU9pNxLhpFggUU+itIjEV3E5KsbRrR+WZdzgKTa/UV6J5RtKN8TY34G9FhrucyCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936565; c=relaxed/simple;
	bh=Co1hU6h6+FfNMHYhM0Md9CxnsIPY+jOY59OLGlmZ50w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cj1w+sWaNZIyAkBkb22pKu+2a0SQGJl5KQB4OUHvqyiYc242l8S/jRoMTZYR3Vg9Zi8PY2mG2AYxaz/5/Qt8oa6M11xSdAdGtCqRygRoiJDj5C0dk7hGnuSSsZjsaqUK2Xhn6frRB5tevhM8T4UYZf5CpBmH32yDHYrSUZ6lRnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFZQpZfM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05475C43390;
	Mon, 22 Jan 2024 15:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936565;
	bh=Co1hU6h6+FfNMHYhM0Md9CxnsIPY+jOY59OLGlmZ50w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kFZQpZfMFi94Kk8P6hSYVRMN78MpurDwVwMK3dekw9A/tELvavEK7X+rofiQ88Bnd
	 fJFMv5xqCkSwWropP2eqtYghUdSm1Kd6FWYJUMvVDcC3GdTi3WgqjecL3nWdCP1QG+
	 eWi3ycwW5+0QDdhVVCLarC2Mt9c3YL0fE9vdCdiok02HQ/+Sq6JItSRERDHJho9SpH
	 BTI9Pnipy6gS57VR5FhSzT5vnGQX81M0iT4ZIOoe93Lob16yBKzwSuWxRZy/oT8rbC
	 yLtgsyzJQ2dX9BeBfU/+/o3gVoZoCv8eqotf+tkDPGRKFmefwV6TDLXN1Bsm+Mq8G2
	 t2UPKDDzM1wyw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	amadeuszx.slawinski@linux.intel.com,
	markhas@chromium.org,
	bradynorander@gmail.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 17/28] ALSA: hda: intel-dspcfg: add filters for ARL-S and ARL
Date: Mon, 22 Jan 2024 10:14:43 -0500
Message-ID: <20240122151521.996443-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151521.996443-1-sashal@kernel.org>
References: <20240122151521.996443-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit 7a9d6bbe8a663c817080be55d9fecf19a4a8fd8f ]

Same usual filters, SOF is required for DMIC and/or SoundWire support.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Acked-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20231204212710.185976-4-pierre-louis.bossart@linux.intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/intel-dsp-config.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
index 48c78388c1d2..ea0a2b1d23a3 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -372,6 +372,16 @@ static const struct config_entry config_table[] = {
 		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
 		.device = 0x7e28,
 	},
+	/* ArrowLake-S */
+	{
+		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
+		.device = PCI_DEVICE_ID_INTEL_HDA_ARL_S,
+	},
+	/* ArrowLake */
+	{
+		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
+		.device = PCI_DEVICE_ID_INTEL_HDA_ARL,
+	},
 #endif
 
 /* Lunar Lake */
-- 
2.43.0



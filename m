Return-Path: <linux-kernel+bounces-99407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCB98787F8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BED6A282208
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6FB612CF;
	Mon, 11 Mar 2024 18:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTAZZ7h5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDD5612C9;
	Mon, 11 Mar 2024 18:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182336; cv=none; b=Mp5XyhB4ABqwTqUMKP0nqzk4tfO1bALI3dqD9lyuA4v68bGVSs2pBFmHI7pzWd8FTA1Sv8OBk1nK1qdhFP/NoZYa3K7blCutZj5XT54qMZBfWEUxMahtWTQHzjkz6PXl3FtW1QrpFZDvj3I6Y0CZKWyrUwEEf++TFgXmEqMhduQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182336; c=relaxed/simple;
	bh=EkiW/xBoFPH9AMXJdE9+NbGQAItDzmU2qSMfZ3TDNe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hy6oJFuM6egd7KYshDEOqdNUswO6WiEhiipWcvDTHBB5RHOMlSwFC7Ck8zLOtAXfaRvjDDwUZomXhg6ZRtQcGFqdE++sd7pmTIX4IMAyhkrvpwOJFYokgp0+uxhIyTw0risamvTjJ7OxtDcGifNqFovnI7OnMvmI5uN8nGvOVSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTAZZ7h5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0886C43394;
	Mon, 11 Mar 2024 18:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182336;
	bh=EkiW/xBoFPH9AMXJdE9+NbGQAItDzmU2qSMfZ3TDNe4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hTAZZ7h5XPqj0ke2vgqp32iOtFnDzy+q6TBdMnHXJQP6WUgSgZRhB5KYYEvdnecOg
	 2IywRxEfow2VNddrIMO4lcDeSLg/0deIe/WlJ51ZNDUFsZoQms6bH0UNUHCU8vhyDX
	 BOokvdpSspLdupYvfQVe6ZlNBlR2WuyZ2vZEo/qgyLaLck3jH+SsFTNPCxq6o7kT6L
	 jmyKLw0sbpWpMG9VpbMFb37zwbWn89UDDAKjyrci6VD3XkwTmZb3MEmRdQZ6lMMXoS
	 vli3xTT330bomy8s0o5r0SmCpEAnn1YYqYjoEj6wr17ct6z7oinJv1RWYhwtJ4zr1C
	 lkXFBrVtuZfQA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stuart Henderson <stuarth@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	patches@opensource.cirrus.com,
	alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.1 6/7] ASoC: wm8962: Enable both SPKOUTR_ENA and SPKOUTL_ENA in mono mode
Date: Mon, 11 Mar 2024 14:38:24 -0400
Message-ID: <20240311183826.328535-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311183826.328535-1-sashal@kernel.org>
References: <20240311183826.328535-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.81
Content-Transfer-Encoding: 8bit

From: Stuart Henderson <stuarth@opensource.cirrus.com>

[ Upstream commit 6fa849e4d78b880e878138bf238e4fd2bac3c4fa ]

Signed-off-by: Stuart Henderson <stuarth@opensource.cirrus.com>
Link: https://msgid.link/r/20240306161439.1385643-2-stuarth@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wm8962.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 35d8cd4fc71a7..806b69c9b2e36 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2229,6 +2229,9 @@ SND_SOC_DAPM_PGA_E("HPOUT", SND_SOC_NOPM, 0, 0, NULL, 0, hp_event,
 
 SND_SOC_DAPM_OUTPUT("HPOUTL"),
 SND_SOC_DAPM_OUTPUT("HPOUTR"),
+
+SND_SOC_DAPM_PGA("SPKOUTL Output", WM8962_CLASS_D_CONTROL_1, 6, 0, NULL, 0),
+SND_SOC_DAPM_PGA("SPKOUTR Output", WM8962_CLASS_D_CONTROL_1, 7, 0, NULL, 0),
 };
 
 static const struct snd_soc_dapm_widget wm8962_dapm_spk_mono_widgets[] = {
@@ -2236,7 +2239,6 @@ SND_SOC_DAPM_MIXER("Speaker Mixer", WM8962_MIXER_ENABLES, 1, 0,
 		   spkmixl, ARRAY_SIZE(spkmixl)),
 SND_SOC_DAPM_MUX_E("Speaker PGA", WM8962_PWR_MGMT_2, 4, 0, &spkoutl_mux,
 		   out_pga_event, SND_SOC_DAPM_POST_PMU),
-SND_SOC_DAPM_PGA("Speaker Output", WM8962_CLASS_D_CONTROL_1, 7, 0, NULL, 0),
 SND_SOC_DAPM_OUTPUT("SPKOUT"),
 };
 
@@ -2251,9 +2253,6 @@ SND_SOC_DAPM_MUX_E("SPKOUTL PGA", WM8962_PWR_MGMT_2, 4, 0, &spkoutl_mux,
 SND_SOC_DAPM_MUX_E("SPKOUTR PGA", WM8962_PWR_MGMT_2, 3, 0, &spkoutr_mux,
 		   out_pga_event, SND_SOC_DAPM_POST_PMU),
 
-SND_SOC_DAPM_PGA("SPKOUTR Output", WM8962_CLASS_D_CONTROL_1, 7, 0, NULL, 0),
-SND_SOC_DAPM_PGA("SPKOUTL Output", WM8962_CLASS_D_CONTROL_1, 6, 0, NULL, 0),
-
 SND_SOC_DAPM_OUTPUT("SPKOUTL"),
 SND_SOC_DAPM_OUTPUT("SPKOUTR"),
 };
@@ -2366,12 +2365,18 @@ static const struct snd_soc_dapm_route wm8962_spk_mono_intercon[] = {
 	{ "Speaker PGA", "Mixer", "Speaker Mixer" },
 	{ "Speaker PGA", "DAC", "DACL" },
 
-	{ "Speaker Output", NULL, "Speaker PGA" },
-	{ "Speaker Output", NULL, "SYSCLK" },
-	{ "Speaker Output", NULL, "TOCLK" },
-	{ "Speaker Output", NULL, "TEMP_SPK" },
+	{ "SPKOUTL Output", NULL, "Speaker PGA" },
+	{ "SPKOUTL Output", NULL, "SYSCLK" },
+	{ "SPKOUTL Output", NULL, "TOCLK" },
+	{ "SPKOUTL Output", NULL, "TEMP_SPK" },
+
+	{ "SPKOUTR Output", NULL, "Speaker PGA" },
+	{ "SPKOUTR Output", NULL, "SYSCLK" },
+	{ "SPKOUTR Output", NULL, "TOCLK" },
+	{ "SPKOUTR Output", NULL, "TEMP_SPK" },
 
-	{ "SPKOUT", NULL, "Speaker Output" },
+	{ "SPKOUT", NULL, "SPKOUTL Output" },
+	{ "SPKOUT", NULL, "SPKOUTR Output" },
 };
 
 static const struct snd_soc_dapm_route wm8962_spk_stereo_intercon[] = {
-- 
2.43.0



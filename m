Return-Path: <linux-kernel+bounces-99387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5F88787AB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6915CB2260C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BCF5C5EE;
	Mon, 11 Mar 2024 18:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxKtXwjy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B945BAC1;
	Mon, 11 Mar 2024 18:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182241; cv=none; b=QzWbv2CyssKkCETtfPtLmsaBJmvDVb5G17jscxthAC1XyiyAV4r7CmLrv6gRoPLp/Co9CNe5qry7qUYUFu4ca1nLkNaGTnt/pWMB2V6qrmcT6OOe6422Pn4Kh+AVFpiShERDF+oe8htfXOcUTz0PklJeSuzYqHVygjpyEqeJ1ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182241; c=relaxed/simple;
	bh=kN41ERk6uq12skAjGTO6BjFCIfERQsxkyKHG8F0KuKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G1s5MoLNlvqGa6Ttc2walvhug53sN0C6S4xbQZrGCEIiKuRL/qLsCVPI7krPYv1V9e4ACQwVjZpAR+M97pgYjcg1UfDzzt9vlpdnUQLzbgLMYNtV7JbnHKdq1bjp+S1sSrofXAr/TgqRtql7bjA7GNN+EIbnMO+ohuI0iPlpfHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uxKtXwjy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD00C43394;
	Mon, 11 Mar 2024 18:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182241;
	bh=kN41ERk6uq12skAjGTO6BjFCIfERQsxkyKHG8F0KuKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uxKtXwjy2h7Cc619RcF4yQx8JlYhdWNUkOpiqLNkyG6qsdfe4KxtMBlMbrW0ei9Fd
	 tcv34QNM1wb3dHKgFGECH4iX1geO/U7ssTDY2lONhpft6zEqRrx7uFsPy5KSh9Qz6m
	 qPB/Ev1n+E/1sk4VqYyeLhXQ/RIpVwryk7DAIexYgOVjI8CFtSBZbBhPF+D26k67Fk
	 P9Wxogy4qMNY6umZGDgK3pvqXww56Rq4C6Y4MhoR2iJOK7nHcoTnlNNCgP0zzNZ0PJ
	 EQFe1dsHAVuwNnrrdb0NtZ02QUtAWsPK9Djx5XrLvOMmp6tTLjrdvnheXw4pYgIdtj
	 bscAX7HvjKwDg==
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
Subject: [PATCH AUTOSEL 6.7 13/14] ASoC: wm8962: Enable both SPKOUTR_ENA and SPKOUTL_ENA in mono mode
Date: Mon, 11 Mar 2024 14:36:16 -0400
Message-ID: <20240311183618.327694-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311183618.327694-1-sashal@kernel.org>
References: <20240311183618.327694-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.9
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
index 6d7bb696b1356..2256cc0a37ebd 100644
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



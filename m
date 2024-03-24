Return-Path: <linux-kernel+bounces-115343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02676889AF0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC40F2A6154
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0401E6F51;
	Mon, 25 Mar 2024 02:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaM7vfaF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896891411DE;
	Sun, 24 Mar 2024 22:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320518; cv=none; b=B4hzqG+yiSGzboZ8LrCSoqaDb5KWGUuu9r5ZgY+OMkAYyw8iq+JkwR5caO5alCS878VBL0kQ82KtRep7NCSRafuKbmKEBPjfv0NOXCM1lmsON8VewUxo9uKpEAxrzEcsmrmZAcNDEgU5j17A6UgYZkj/rP/eC7vb9x9Af47UZ8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320518; c=relaxed/simple;
	bh=kN41ERk6uq12skAjGTO6BjFCIfERQsxkyKHG8F0KuKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pXL2OQM20YN8GAOXiZqEACn+d06TRBYyE05u5AJxs13NzHTeushJ3sBmjCUILgNL1H7WvAvTuhY0K8Wg9DshntOs/vXRCJDEn7V8RwHInyaa3DkXDsdVdZuEKfI68YGqqgoxcZzSQXnFwV53AYj45gegr6Grfv8tPzr87mw5L6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaM7vfaF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8154C43390;
	Sun, 24 Mar 2024 22:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320518;
	bh=kN41ERk6uq12skAjGTO6BjFCIfERQsxkyKHG8F0KuKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BaM7vfaFYBejurke0OPOQH/tNUOpZgVEmia63h/lTAnfk0RGL2SqguNtCYU0QqYA1
	 eT/17g95t8xXTKqafFmY49EBowOp3uJyd9aD/KcOXVTWstiCEuzOSZiWOfpENNWqU1
	 sC+CYyjwNqVCXjQjefu6vkMSHp7C6b8y5cXrJAmqBjOQNC9QNSjHAIyWM5eOlyW29a
	 01Qpv4RNpNq5gz7/9vyxI6c4oGGevO8eRm3F/PLpP6yiCSES+xUbQKI6T6qHivLqVA
	 pWaeP0AT6po3aFM3aRxpxuoNwOlwmaf2QzET8dTj6Z5ltTpmRCh9CvQSJ7vgTCjTi0
	 4mFcaFY54VqKg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stuart Henderson <stuarth@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 079/713] ASoC: wm8962: Enable both SPKOUTR_ENA and SPKOUTL_ENA in mono mode
Date: Sun, 24 Mar 2024 18:36:45 -0400
Message-ID: <20240324224720.1345309-80-sashal@kernel.org>
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



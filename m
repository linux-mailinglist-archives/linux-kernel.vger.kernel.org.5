Return-Path: <linux-kernel+bounces-63314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 506C9852D89
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83D251C249F9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C504225B2;
	Tue, 13 Feb 2024 10:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0STckFO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F243224DE;
	Tue, 13 Feb 2024 10:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707819073; cv=none; b=hkvjOoQzdmqFQfbBzO/f6B1iczmd9BobkUvXI4b9gL5mtbfCmBqH5wQA/iRF86pYEKiaZmD+1M9FtI0qN4HvHFMTqubBqWZ4jt/wyb6b2gPIyrfhLKeBgbT1rdcl+O0en6qK6f/YfZzuJERfXAItTjrRJohPJQi2GtZfC0X9BSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707819073; c=relaxed/simple;
	bh=mL4XO56Z6BWv4tMNoHpJYHvphFG+5pdC53wWnQvEb5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TyC92Z6l/lUTftSEMeVQTBEqb+5QWs5ClE8M2PyNCszMZfrOjdHfzCi8st5+F57lb18OKyg3oAK8td8HAyDKU4F8Q0t+/ho7DDQj79lzWK0m8uFtwcD34UNtemIYjYj1z2uGsVIHxpt8PhAHrL+YnhxAVRIp3DgyPfyLQhSVM+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0STckFO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6125C433F1;
	Tue, 13 Feb 2024 10:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707819073;
	bh=mL4XO56Z6BWv4tMNoHpJYHvphFG+5pdC53wWnQvEb5Y=;
	h=From:To:Cc:Subject:Date:From;
	b=D0STckFOFxSAdd91J4HTYXokBfOyGak+23LmZrrtGV8AmqeeGqFOg7G9KY4zrdkQo
	 9fJbaRR9gKmH9eJ/i9WDck6tH3Lh0kNVuNI8I4TYDJZkvjsNAoifcmIfGk/P8DhvaQ
	 F65xBXJ3N/cRhr40DhCUME0JWoxEXNRazJ1M8xnu3euc7YWesbTpIjVJ+WGkZOzu4R
	 g67zJBv1Vz8uDDPz8oZhzsBl6dluwFkNVth8k+9Pz624uJAAvdN/dcHPLX/5aW565v
	 GofS96pPXezVY6x1A5pS55CqTLqMEzRJoRCnAvkg218pRjmFS6UYizMDpd6kn1wbiA
	 DaAlElGw6nIUg==
From: Arnd Bergmann <arnd@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Mohammad Rafi Shaik <quic_mohs@quicinc.com>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] ASoC: q6dsp: fix event handler prototype
Date: Tue, 13 Feb 2024 11:10:46 +0100
Message-Id: <20240213101105.459402-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

clang-16 points out a mismatch in function types that was hidden
by a typecast:

sound/soc/qcom/qdsp6/q6apm-dai.c:355:38: error: cast from 'void (*)(uint32_t, uint32_t, uint32_t *, void *)' (aka 'void (*)(unsigned int, unsigned int, unsigned int *, void *)') to 'q6apm_cb' (aka 'void (*)(unsigned int, unsigned int, void *, void *)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
  355 |         prtd->graph = q6apm_graph_open(dev, (q6apm_cb)event_handler, prtd, graph_id);
sound/soc/qcom/qdsp6/q6apm-dai.c:499:38: error: cast from 'void (*)(uint32_t, uint32_t, uint32_t *, void *)' (aka 'void (*)(unsigned int, unsigned int, unsigned int *, void *)') to 'q6apm_cb' (aka 'void (*)(unsigned int, unsigned int, void *, void *)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
  499 |         prtd->graph = q6apm_graph_open(dev, (q6apm_cb)event_handler_compr, prtd, graph_id);

The only difference here is the 'payload' argument, which is not even
used in this function, so just fix its type and remove the cast.

Fixes: 88b60bf047fd ("ASoC: q6dsp: q6apm-dai: Add open/free compress DAI callbacks")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/qcom/qdsp6/q6apm-dai.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
index 052e40cb38fe..00bbd291be5c 100644
--- a/sound/soc/qcom/qdsp6/q6apm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
@@ -123,7 +123,7 @@ static struct snd_pcm_hardware q6apm_dai_hardware_playback = {
 	.fifo_size =            0,
 };
 
-static void event_handler(uint32_t opcode, uint32_t token, uint32_t *payload, void *priv)
+static void event_handler(uint32_t opcode, uint32_t token, void *payload, void *priv)
 {
 	struct q6apm_dai_rtd *prtd = priv;
 	struct snd_pcm_substream *substream = prtd->substream;
@@ -157,7 +157,7 @@ static void event_handler(uint32_t opcode, uint32_t token, uint32_t *payload, vo
 }
 
 static void event_handler_compr(uint32_t opcode, uint32_t token,
-				uint32_t *payload, void *priv)
+				void *payload, void *priv)
 {
 	struct q6apm_dai_rtd *prtd = priv;
 	struct snd_compr_stream *substream = prtd->cstream;
@@ -352,7 +352,7 @@ static int q6apm_dai_open(struct snd_soc_component *component,
 
 	spin_lock_init(&prtd->lock);
 	prtd->substream = substream;
-	prtd->graph = q6apm_graph_open(dev, (q6apm_cb)event_handler, prtd, graph_id);
+	prtd->graph = q6apm_graph_open(dev, event_handler, prtd, graph_id);
 	if (IS_ERR(prtd->graph)) {
 		dev_err(dev, "%s: Could not allocate memory\n", __func__);
 		ret = PTR_ERR(prtd->graph);
@@ -496,7 +496,7 @@ static int q6apm_dai_compr_open(struct snd_soc_component *component,
 		return -ENOMEM;
 
 	prtd->cstream = stream;
-	prtd->graph = q6apm_graph_open(dev, (q6apm_cb)event_handler_compr, prtd, graph_id);
+	prtd->graph = q6apm_graph_open(dev, event_handler_compr, prtd, graph_id);
 	if (IS_ERR(prtd->graph)) {
 		ret = PTR_ERR(prtd->graph);
 		kfree(prtd);
-- 
2.39.2



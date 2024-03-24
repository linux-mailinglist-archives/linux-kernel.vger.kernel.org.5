Return-Path: <linux-kernel+bounces-116193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A92889F94
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AB49B2286F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199B73BA35B;
	Mon, 25 Mar 2024 03:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aoFhEBLa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B5428455B;
	Sun, 24 Mar 2024 23:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323794; cv=none; b=IhNqZusL2hZoyNHeLhTalPVw2s51hJzp500E2zRvVBKlH0vK/YgoqlRyfeLL9WHA3uKmdU3abuJkAHE72RiLiZ4/9nYnZwMdC8/bZRJDf+a9C8bxZDMe1mj6fRXpGOSgxI3es2/AtdaEDQQYVXSvq5Bo6bVxY6pQ3ZyN6D1wVuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323794; c=relaxed/simple;
	bh=myIllbPmWSYMqa2z/yZAREFiWRKzaKp/8Lpn3zjJYXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WCdjLXVXWnPJbSG1HhMCvv0Y4GbKOdjeaOUSGLYVHAYEgxdHDpX6hTZlrL2r99uycW8cMmxxhJJo9F0PJD5kkKsf1tTYdITMYXX0z1aaap6u8yFuJL4OLp66R5pq2qEGUBWvxLkRmN+VJeVSneRhoFqnsdsGmPzgVQesxkhkBQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aoFhEBLa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42892C43390;
	Sun, 24 Mar 2024 23:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323792;
	bh=myIllbPmWSYMqa2z/yZAREFiWRKzaKp/8Lpn3zjJYXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aoFhEBLaz4bgpW0DiI7G9IMHj4naRfo3zOJ6CFnOA24tlZeBpc0dBDNvk7cRXb1WY
	 oqd6D+pcynfNPJF9aWzzNW3BjJtrmPjTHTqfIdKy8HcQmUI48axCBPPJ7oJIxzb7rS
	 j5mKB6g5WLIWABp3jHejxeyxvlltJRW5KGc82rxoB2kFuPssKHTAEUMVVJbQje/N7M
	 FTRDQhbsQcSkLlhQpEANoEwHr2PnD8fDIbqEIXalHH/f8mNJfrMoMkQzpT1TfsZub0
	 4tSFGcrwbS/QKL0U6D3o0Qowh7Z+/P9EaB3xO9X1r/8c9FbdMwYhhX4XVZO+sAkyrS
	 +q9EjrYZx7SYw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 170/238] ASoC: meson: axg-tdm-interface: add frame rate constraint
Date: Sun, 24 Mar 2024 19:39:18 -0400
Message-ID: <20240324234027.1354210-171-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jerome Brunet <jbrunet@baylibre.com>

[ Upstream commit 59c6a3a43b221cc2a211181b1298e43b2c2df782 ]

According to Amlogic datasheets for the SoCs supported by this driver, the
maximum bit clock rate is 100MHz.

The tdm interface allows the rates listed by the DAI driver, regardless of
the number slots or their width. However, these will impact the bit clock
rate.

Hitting the 100MHz limit is very unlikely for most use cases but it is
possible.

For example with 32 slots / 32 bits wide, the maximum rate is no longer
384kHz but ~96kHz.

Add the constraint accordingly if the component is not already active.
If it is active, the rate is already constrained by the first stream rate.

Fixes: d60e4f1e4be5 ("ASoC: meson: add tdm interface driver")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Link: https://msgid.link/r/20240223175116.2005407-3-jbrunet@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/meson/axg-tdm-interface.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/sound/soc/meson/axg-tdm-interface.c b/sound/soc/meson/axg-tdm-interface.c
index ac43a7ab7bcf6..60d132ab1ab78 100644
--- a/sound/soc/meson/axg-tdm-interface.c
+++ b/sound/soc/meson/axg-tdm-interface.c
@@ -12,6 +12,9 @@
 
 #include "axg-tdm.h"
 
+/* Maximum bit clock frequency according the datasheets */
+#define MAX_SCLK 100000000 /* Hz */
+
 enum {
 	TDM_IFACE_PAD,
 	TDM_IFACE_LOOPBACK,
@@ -155,19 +158,27 @@ static int axg_tdm_iface_startup(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	/* Apply component wide rate symmetry */
 	if (snd_soc_component_active(dai->component)) {
+		/* Apply component wide rate symmetry */
 		ret = snd_pcm_hw_constraint_single(substream->runtime,
 						   SNDRV_PCM_HW_PARAM_RATE,
 						   iface->rate);
-		if (ret < 0) {
-			dev_err(dai->dev,
-				"can't set iface rate constraint\n");
-			return ret;
-		}
+
+	} else {
+		/* Limit rate according to the slot number and width */
+		unsigned int max_rate =
+			MAX_SCLK / (iface->slots * iface->slot_width);
+		ret = snd_pcm_hw_constraint_minmax(substream->runtime,
+						   SNDRV_PCM_HW_PARAM_RATE,
+						   0, max_rate);
 	}
 
-	return 0;
+	if (ret < 0)
+		dev_err(dai->dev, "can't set iface rate constraint\n");
+	else
+		ret = 0;
+
+	return ret;
 }
 
 static int axg_tdm_iface_set_stream(struct snd_pcm_substream *substream,
-- 
2.43.0



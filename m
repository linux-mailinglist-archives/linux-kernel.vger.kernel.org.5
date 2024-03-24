Return-Path: <linux-kernel+bounces-113882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D06D8888717
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 851201F259C6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB58613958D;
	Sun, 24 Mar 2024 23:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+eov45X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138191EC63F;
	Sun, 24 Mar 2024 22:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320949; cv=none; b=qYDUhMUki29UPpFDkOcZrnRUXm85TVNqLbYqJq+kcOjwi9A7kWTWAIDlte4QR7L9uROcdN8XEiQ/rCfSPpg5eEJKZNev0248gp6KIH76PCnBd93JhEVIQAnyHP6fcqyahsT037unjqg4MLq4K0xdmkRlLx8zxiKKAbk/xDXhoX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320949; c=relaxed/simple;
	bh=Z8X2zP+nEhY/enFqxgIxcycK4W9hG7UStcYvoIYNi8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EJCK9tUzdFlRJ9SOMhkPO51UtyY4zt6AgT6AnZJEJ+vDh1YwFKw5tanfXrqU3BGHx0wNKPy0Upg8ezzCnsc7rbUs/C6laTbidI/7vtHysTpqYPoMHaJ/GxALzmXXbARnzqyat/JC/YKJ9JQJiNBzirOg9KIq7x/HZ9Zntr0NW/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+eov45X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE97BC433A6;
	Sun, 24 Mar 2024 22:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320947;
	bh=Z8X2zP+nEhY/enFqxgIxcycK4W9hG7UStcYvoIYNi8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L+eov45XysMISHJHqZ9wQHhhryRk8WCrKAVFCqpc984U2cKUZ1xt+/2FQAlmdcPsr
	 /WTMgGjB4dhYNma111qBGRtQLimjmt3EBZTXqZh1xIbGMJ8Tyyrf69fRxg8o7VpP7j
	 iW0BxhiTtTbzeP76WNXFyCu54YfNxHleRxB8HHhEULsfBl3KJ+PvDBz1u0+Ik7HzFg
	 cdBY7Tw1NgXSyu5xC0SJ8MWUnHyLt6k3RnnoELGPFXzFG9vB30Q1HGIrxzwRUsdcl+
	 oPG4psM2zYMprYnfPfXINclBo4pp3dYjZpLz2QgWFDH9v39IBs3ngDeVT5f7v3/idg
	 k6bayTMJYG7fg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 511/713] ASoC: meson: axg-tdm-interface: add frame rate constraint
Date: Sun, 24 Mar 2024 18:43:57 -0400
Message-ID: <20240324224720.1345309-512-sashal@kernel.org>
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
index cd5168e826df4..2cedbce738373 100644
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
@@ -153,19 +156,27 @@ static int axg_tdm_iface_startup(struct snd_pcm_substream *substream,
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



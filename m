Return-Path: <linux-kernel+bounces-114264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE257888977
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF9231C28032
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D174F15B987;
	Sun, 24 Mar 2024 23:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MI2DWFqU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0BA20C043;
	Sun, 24 Mar 2024 23:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321628; cv=none; b=Dwp+zEDIp7khPML8IvG5WGSeitURLBf+Pyw1ULJ1FKyzgWr7nZqozK8S8PoNhcl/QwH+tdzPS6FRuWfxWN0i0G5LZskSIw8WuBCsTpwgAVWQ0LjesZAs8ucPqtI5kEL56n6L/DehfAqRdxoIZOILDLR91bXXQYwlk32wMBpXM+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321628; c=relaxed/simple;
	bh=IQMlcf/x3JYpjgH2EoHDafE++YM8FkcTZYcWbvKrJG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qdYk4E8vM7u8/kdDJwr2HFyIv/B1PQ2sK/BcFQmwtqppnd6+CACd3GTCcEopZ8qfQUmNLGrMQdoFZPNfpvfTv143P4JHBvxhl9dLQBOhaVp1JZHFYhUZvLWk7fYTvR1zSsJ0+UH/04PzoY9jYYJ0WqYOOQTmx++QDoBAOt2fuR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MI2DWFqU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A0DC433A6;
	Sun, 24 Mar 2024 23:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321628;
	bh=IQMlcf/x3JYpjgH2EoHDafE++YM8FkcTZYcWbvKrJG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MI2DWFqUAI6oB2W61axsTUSlpxKsFHp7unh0YfwVHjtgcWCvzTgyS6hPknhLqOaQL
	 Yw4LuWKqmGuKjz6C4msnFmGi30K0edyTRfuljricHiYdr/fnx0iKA8jlyWgvBRCCFG
	 GoUZUmFyv6nLmjOgyO28IR57z121qg+p2aJDHPOzEbvNy2QCEUmcZZY7SRV+l2UD6P
	 XOD8CBKcg9yKQGM7Yqp7XFTDCHf4aFih908y+6xZ8NGfPcmYvSPaUF1oOsI/HzIZqY
	 tExcUVBphDjuoseDvc6Pj7e/fgKvFYwSzPJkRnv1+BuSFw6/LngGV13T8JaJKUod8S
	 RBxBGj7puObHA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Emil Velikov <emil.velikov@collabora.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 359/638] ASoC: amd: acp: Add missing error handling in sof-mach
Date: Sun, 24 Mar 2024 18:56:36 -0400
Message-ID: <20240324230116.1348576-360-sashal@kernel.org>
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

From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

[ Upstream commit d0ada20279db2649a7549a2b8a4a3379c59f238d ]

Handle potential acp_sofdsp_dai_links_create() errors in ACP SOF machine
driver's probe function.  Note there is no need for an undo.

While at it, switch to dev_err_probe().

Fixes: 9f84940f5004 ("ASoC: amd: acp: Add SOF audio support on Chrome board")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Reviewed-by: Emil Velikov <emil.velikov@collabora.com>
Link: https://msgid.link/r/20231219030728.2431640-4-cristian.ciocaltea@collabora.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/acp/acp-sof-mach.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/soc/amd/acp/acp-sof-mach.c b/sound/soc/amd/acp/acp-sof-mach.c
index 5223033a122f8..354d0fc55299b 100644
--- a/sound/soc/amd/acp/acp-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sof-mach.c
@@ -120,16 +120,14 @@ static int acp_sof_probe(struct platform_device *pdev)
 	if (dmi_id && dmi_id->driver_data)
 		acp_card_drvdata->tdm_mode = dmi_id->driver_data;
 
-	acp_sofdsp_dai_links_create(card);
+	ret = acp_sofdsp_dai_links_create(card);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Failed to create DAI links\n");
 
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
-	if (ret) {
-		dev_err(&pdev->dev,
-				"devm_snd_soc_register_card(%s) failed: %d\n",
-				card->name, ret);
-		return ret;
-	}
-
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Failed to register card(%s)\n", card->name);
 	return 0;
 }
 
-- 
2.43.0



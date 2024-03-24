Return-Path: <linux-kernel+bounces-113257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B568882B9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2156E287B95
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA40C13CA88;
	Sun, 24 Mar 2024 22:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTb8QbJ3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72F3187E90;
	Sun, 24 Mar 2024 22:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320056; cv=none; b=jnu2luSg0Bn8UhdrbhWAJBDQBUJnEnVMCZHeQJH07i3SbOLKKB7IeYRGAHr0iPjpHnXiV7vCe9fE0Gx40JjZiB91hxUAqDYniuhK54NdTYlL4ShqDWs3P7wO2+IiVfisVNvhRnLqT/HPfLn00oXCKfTFIct80qkOdDhE2MrYXW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320056; c=relaxed/simple;
	bh=+rMlh2QubRCArm0kM1Dj0Fl4nnNuuvzgyDokws4LcJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I2KOScESkXiz0kEDWRFdvZxsxzoMgBZ6EXClZmnaqjD+3CF4HoHF7yePENKKdkK05CHt6+ycTCXIPn6TFF+56MGjV69C6eMpMTmGe2OG/9lXpms5MY3rbRNO7ugRvjukFDXwfVBjlq94c4/aoSjxLgmTIR23ip8eLIgPpLGoPcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTb8QbJ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF4BC433A6;
	Sun, 24 Mar 2024 22:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320056;
	bh=+rMlh2QubRCArm0kM1Dj0Fl4nnNuuvzgyDokws4LcJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WTb8QbJ3PCMdPSCOXww8imJ4NoYlbD7md0hQMdq3jcWUgarwIMGjDYO7twkl9b7/Q
	 yskPhXKQ1SgU04JiL/FV3fOuf0Q4x2Gq6q/+o0mKOEAHgOZnlUhmqX7FLSSgrN3c9e
	 xmy8mSNFZT9NV6GauZkQlk3zWj2hnpaJ7K7BRe5kJVWu18MV1qy0MT8DiN7a//nz9t
	 eCn5yjkAW6EP1tWFLdGSmZLcT/fu59wHIFXJecwSiuJD74x7X3MdnN6Zpx81/qfnXS
	 P+QxnHXomMhUfvFEkYNb8yJJFOQyzpV86K8bpyZ+wV8WUr4PQRjPJ8SoPb0ZAkE5eL
	 sAwFlCIzhKv1g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Emil Velikov <emil.velikov@collabora.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 366/715] ASoC: amd: acp: Add missing error handling in sof-mach
Date: Sun, 24 Mar 2024 18:29:05 -0400
Message-ID: <20240324223455.1342824-367-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index 20b94814a0462..b86f65d420054 100644
--- a/sound/soc/amd/acp/acp-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sof-mach.c
@@ -126,16 +126,14 @@ static int acp_sof_probe(struct platform_device *pdev)
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



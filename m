Return-Path: <linux-kernel+bounces-113813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 975608886BD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52D87291322
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664491FD126;
	Sun, 24 Mar 2024 23:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUAN57mj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80AF1E6210;
	Sun, 24 Mar 2024 22:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320840; cv=none; b=VhrnNRcMCiNhcS/lg5m6nLkxtST1C2MSnmMmV/MuDXoi1wnN3xg5TIfF8/8NvKSrxtlRaBWwOHLHKOFwq4hYyUBD6UgI793D3QaKOkwvLcInZz1iDkAZYZytQVfzQi9FfdNhHMoWHVBBlxjiU/G+e6sXvMOJYFYn7RQP8qyIWMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320840; c=relaxed/simple;
	bh=IQMlcf/x3JYpjgH2EoHDafE++YM8FkcTZYcWbvKrJG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lcyPFNx9+GMkFAOfq/mpxSoUM2gweDcZWQXAO+305TbUOwa4a2qvX/hJGPIfA4/l5ZsjDW59wIRblKz/od+E2JK9z0+c3MoSoD64MQh7wmbN9WeG6EsfeZP3yuEjuAy3tKLreSrBunUIAZq4tlxP2UvG/1W9gxqDGdyg9PO48ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUAN57mj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CCD1C433F1;
	Sun, 24 Mar 2024 22:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320839;
	bh=IQMlcf/x3JYpjgH2EoHDafE++YM8FkcTZYcWbvKrJG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kUAN57mjsQWfd0iNqWtwBQQzyP8ImOFZ36NePaIJ/UBDFi7ISfdFW5BGmjanU5jEk
	 cP+e80y5yPS45CGg/SZI2oBnNvub+h2RD1jtSGqMCzxPKrzal7Yfz4LX9tJmv4kaU+
	 GDqhA9vMfWtcD5JoynsgCkBMx4U04Q+5dTjC6M2ElR6JE+HLdtxTGXc5eERod2jiha
	 x8rLfzvBm4Zq/2v4yW1UV0VDc7lS9J/FBsG/0gVQTEUC57HrOkwaFuCqZuwSNG8KHP
	 2RRd54kC7XlyG+Z3Id3m7TL2ANPeaIKiRIbACuS0yCD7OWNvDi6YDormqc05aQEJqH
	 DtDqhPuYwF4rw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Emil Velikov <emil.velikov@collabora.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 405/713] ASoC: amd: acp: Add missing error handling in sof-mach
Date: Sun, 24 Mar 2024 18:42:11 -0400
Message-ID: <20240324224720.1345309-406-sashal@kernel.org>
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



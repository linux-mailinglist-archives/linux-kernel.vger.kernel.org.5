Return-Path: <linux-kernel+bounces-114541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE038888AF8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3D321C2925E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0F7183B87;
	Sun, 24 Mar 2024 23:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cb02b/h1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F361622BC11;
	Sun, 24 Mar 2024 23:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322174; cv=none; b=mTiIiwTOPmzrVz1huzh1RiEGLMf/J7kRf6Y0FOhshe/FJ9htqRsqDo7LP6EW8mF5IjKvubzE52WWWNvHouzOnNK82HHwgKjsE76pcLL3oMiY4EUGuqBIzx1qFfBIho4z1UeBKp9TxlL0+74dK+EcLCoFgZy6M1ohlAkrMvyB8PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322174; c=relaxed/simple;
	bh=wOxrlDQb/o+fIKY5fOSf87sw8b8VaR6iGTWcg5WyI2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W7AIMz3AtCrx9ptXnsZRnb0nR2fHDKAE6rW46cyDfP8MBGhEOpliQ6StLrYX5fG+iVEx4lClh/Nb5lYdbe12pYdqQ7lviUPHxhxWin2JlG8+PJH27Kcc7DWgRq1HzCRijaMzrXUfV9KoNSurDAeNy7vMq0YH6jfMK7eHuvd1heA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cb02b/h1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE644C433C7;
	Sun, 24 Mar 2024 23:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322172;
	bh=wOxrlDQb/o+fIKY5fOSf87sw8b8VaR6iGTWcg5WyI2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cb02b/h1lRenONgRL/8+75yNSg4+RtjAMc5Xo1uBG+KgetJ0Fsuij6KnygFjZhuT8
	 HtJv3NRCge3y0kiDZ28pw1yGq17/C/Ib4Nm8zLX1jt2cgKwHVAgCcjKi8SeLXADcAL
	 YOwxeehpEOMKI6lmpaMA1uu+gm5ZuzNW13v3ovkfWO2Gdlg94VBkFaCQFGnGieYOeI
	 iX+gq5t7UU0DOw4PSPJazCHaJ/cORBqmyMt8XgogSR6VG9BYnXcrbW5qdKmDDb1Vtr
	 QwY3rNYtStx+KuC55/bQG+V3RtBROQrwbKiWgvYKkb+jKGXoXjnbTQ9rZgNV/5jO3I
	 f13at1aR/56Eg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Emil Velikov <emil.velikov@collabora.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 251/451] ASoC: amd: acp: Add missing error handling in sof-mach
Date: Sun, 24 Mar 2024 19:08:47 -0400
Message-ID: <20240324231207.1351418-252-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index f19f064a75272..972600d271586 100644
--- a/sound/soc/amd/acp/acp-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sof-mach.c
@@ -114,16 +114,14 @@ static int acp_sof_probe(struct platform_device *pdev)
 	card->num_controls = ARRAY_SIZE(acp_controls);
 	card->drvdata = (struct acp_card_drvdata *)pdev->id_entry->driver_data;
 
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



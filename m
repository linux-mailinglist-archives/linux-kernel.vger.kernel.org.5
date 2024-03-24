Return-Path: <linux-kernel+bounces-114011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D775888F2D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F1F5B36D61
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B387E1487D8;
	Sun, 24 Mar 2024 23:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmFo7MbX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B81B1FA813;
	Sun, 24 Mar 2024 23:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321285; cv=none; b=Fk1OmziOt06k7GbgHiXv9XbC4WeQOY4/kcdJm1T5GM93VAH7hm5H5XkPMxqx8XVRE8mJhKoAjNqsWjjFsHeV5oxBgbfUp8GaZuGVPKxG0ss9rG0tErfrWhf89aB8xVcsp8E5AIpIHnZqEvDJlA5E1hdp+0LwlXBHpfGQjQSluIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321285; c=relaxed/simple;
	bh=seMaBnzxWwvV+xWVKAtZ7vvq6fEuoCY+K3+gKI3+l9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mvWvew5OfPV/fKHNzN+CpZopLsrojWoFNuouWuCkOQQnla5FVfEj3VsytzzwtnJvg6AxMJlIqnPPbNz4ZoPulc2XVrP3Ny195H+QCqvD/qFvD8n/pPuM+ketc9mBdCktHGa4Rr3ojGAUVi1CcmbzNJTBHxZINyM1l8Q0uxLHPjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmFo7MbX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7B3C433F1;
	Sun, 24 Mar 2024 23:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321284;
	bh=seMaBnzxWwvV+xWVKAtZ7vvq6fEuoCY+K3+gKI3+l9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mmFo7MbXhs7TeTpMPilYUOiFrHRNoBTx5PAgSn/QFpSCGDV6Whkc7+CkfQfHPRa+S
	 g2HAuXIxVWsXxETamThL9kz/DI9w1LM7pd+zH4aE0VqkHkjJyDqwQIGWAs62QhnSQH
	 LtMfI/c57rRvY7KtbtF91gBhRCdD5LglICj2Lp+D5IUMyAVwR0Mw/YTrbG1wfJb7OR
	 T9oRWwhf39VSdlQB1UYDYMPdzVOJe9l9JhluBPiXRMd2Dq7m5LvOZgDbiXc/XswsZv
	 IeCyuqS9wxc+NyKN7zLg7JlyAAuPFnoQvHKls8cYdRGITWobrR2LD5SGwe0E4c9u89
	 r7d6P4XWtYsDA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 006/638] ASoC: cs42l43: Handle error from devm_pm_runtime_enable
Date: Sun, 24 Mar 2024 18:50:43 -0400
Message-ID: <20240324230116.1348576-7-sashal@kernel.org>
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

From: Charles Keepax <ckeepax@opensource.cirrus.com>

[ Upstream commit d1722057477a3786b8c0d60c28fc281f6ecf1cc3 ]

As devm_pm_runtime_enable can fail due to memory allocations, it is
best to handle the error.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20240206113850.719888-1-ckeepax@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs42l43.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l43.c b/sound/soc/codecs/cs42l43.c
index 5643c666d7d04..8015f4b7a5b32 100644
--- a/sound/soc/codecs/cs42l43.c
+++ b/sound/soc/codecs/cs42l43.c
@@ -2175,7 +2175,10 @@ static int cs42l43_codec_probe(struct platform_device *pdev)
 	pm_runtime_use_autosuspend(priv->dev);
 	pm_runtime_set_active(priv->dev);
 	pm_runtime_get_noresume(priv->dev);
-	devm_pm_runtime_enable(priv->dev);
+
+	ret = devm_pm_runtime_enable(priv->dev);
+	if (ret)
+		goto err_pm;
 
 	for (i = 0; i < ARRAY_SIZE(cs42l43_irqs); i++) {
 		ret = cs42l43_request_irq(priv, dom, cs42l43_irqs[i].name,
-- 
2.43.0



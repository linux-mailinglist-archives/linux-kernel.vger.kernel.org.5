Return-Path: <linux-kernel+bounces-113614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 140EE888FA5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEAF9B2DAEF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1E71D1D7B;
	Sun, 24 Mar 2024 22:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bC7ael0n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F021CF8DB;
	Sun, 24 Mar 2024 22:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320449; cv=none; b=rPJk/QPh1qaiUMuKEWKzR2NoF1mAznue7KN3HOx2E8R8fjU2Tv9PZAwSRzbUsDIwyQq7cWMKrt47w7dhwtPAtBQhGzm0Ib4CF4mMtKn/5Xy8lWox2Zx0xqugBRUZwULESw3zSewx9RAlNb+/DcgCEp6FtVn6ADXQWMad7xKFtmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320449; c=relaxed/simple;
	bh=KMdpPcg5w+z+tVeN+JvRVV4A2DEvvetANQO9444T5ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q0Hyz9cQwwLAoVOlG/eOIyAiBHA20PphDh3TlTVtrTjPe3YsQ8zi9mbKttUpI3bRdZWcQk/jR6+sPlsvPDOEGmkHb9tjKW2zUr7XiNOMJVNG2/dsv1oyjNnu59h6dX+NbnkZTyr7D2mccG3TWqD8r1KgTYp2ExzLj60/38vy5C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bC7ael0n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73664C433F1;
	Sun, 24 Mar 2024 22:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320449;
	bh=KMdpPcg5w+z+tVeN+JvRVV4A2DEvvetANQO9444T5ko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bC7ael0nhGLx9Po7pczKETrkTDMUo5Fdnvy8/YSSo9lt5J0AS97xnopvJwfII/yC2
	 vUiKNgMUdnK8zrs/W6VsjHltnAKf1RYZmP2ydslloW+kKeVVNsCN/aeMrfsUBlIuqe
	 xF15F13t0JgPhSkm3lkErgBBn566L9Hn6xwNDBweTSnlq1TTZCuZSmCNISsxScyLob
	 mcgJYpQcY9zNHSF/AtkxkFwnaFFmFFTa+UhZd8h/5/tTDsTqusCta6Fx5tuAWZNHvE
	 /kVTT+6SW7rAq+JptX1Vm9FknPmaqNpFXRHl4V9sGkYZFWL1rM6HMsQjO0FR26TK92
	 HKnKXnvsUuUVw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 007/713] ASoC: cs42l43: Handle error from devm_pm_runtime_enable
Date: Sun, 24 Mar 2024 18:35:33 -0400
Message-ID: <20240324224720.1345309-8-sashal@kernel.org>
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
index d62c9f26c6325..5009cf64124ed 100644
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



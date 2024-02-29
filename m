Return-Path: <linux-kernel+bounces-86952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9810D86CD77
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C63CC1C2274A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07726151CF6;
	Thu, 29 Feb 2024 15:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owoyZWg4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C79151CE2;
	Thu, 29 Feb 2024 15:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221741; cv=none; b=UB+/hdOnGPajs4jnVopcH7yFZgiPKMbC9c9gtkHp/4H1eFVslxGU40GGCvkJp17wlTLeqSWgOQl54FHH0UitJ05JAayxKWnA+Q5a56pSqwM+83M98U6mPlv3LcdbbvuAGtswwQxCOU8jA/awh5SFCAmNA7nYxnnOwGIhZBtVkCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221741; c=relaxed/simple;
	bh=KMdpPcg5w+z+tVeN+JvRVV4A2DEvvetANQO9444T5ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DG5v2HOyrUuA1WBK0qs0YNuskWz9bCUHBf14nBCThr/HnCmSYLSOZv9JfPeQ310vK5VyoRkHgkUd/BDIcvjodTzjsgFhSUaxS853SmRQzRJTMlhPeDKV87TtkuBMzqv0Rn4Ozv1O1SfW1Idms2Avoaw/SdJaxr5elCYzzzk3CmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=owoyZWg4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB06C433A6;
	Thu, 29 Feb 2024 15:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221740;
	bh=KMdpPcg5w+z+tVeN+JvRVV4A2DEvvetANQO9444T5ko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=owoyZWg4qRJsKOblM7lLkon+fYe32zEEZ+3DZNcIYccb2fZx6KToAIeLvCz7FFX6E
	 OUWhqAWSUPJOrLL6x/w9oW6+SaCgLe4tWnLtAPV/XVpPoiMFkR18zsCOO4WU6o1eyQ
	 W40NzN2HiZlTB6b6v+PfXthDGVHvcJDF31xPtAaUa/+kIo1/YjqNdKOK2Hae4pSiS7
	 RjlE/q/vomxgqs3fQkQMZMKnMzc2peKbDGlYGv9RgKf1va3FC6eU3hTmOEdlTRaeVY
	 nAK7mnDjC/B88GG8780A/pYvlym7aHV+ZAXf+2MXMuK9/vwGNalJTQSLyUVPUW3hOb
	 Zh48lsCr+pmmg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	james.schulman@cirrus.com,
	david.rhodes@cirrus.com,
	rf@opensource.cirrus.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 05/26] ASoC: cs42l43: Handle error from devm_pm_runtime_enable
Date: Thu, 29 Feb 2024 10:48:24 -0500
Message-ID: <20240229154851.2849367-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229154851.2849367-1-sashal@kernel.org>
References: <20240229154851.2849367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.6
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



Return-Path: <linux-kernel+bounces-115173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F36E2888D8A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADAB3291C4D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5E4307071;
	Mon, 25 Mar 2024 01:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rTh+vaNK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F3722BF80;
	Sun, 24 Mar 2024 23:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324232; cv=none; b=ILYT36S6gh5bOOYLGmAMyO9UKuldurFIItY53CXPiweB6GqpJiDDVNWcK1DOKtMUjKgsDKja+dmK3wevyoIs6LUtNUt6pRoKyLOr9MBAgGL5/sGaL+mVEKblpmEbDyy44bzpO2ihnTOWy8QjjLHJe8+J7dcfrzkZ4VMR8xutwI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324232; c=relaxed/simple;
	bh=NbFoFKDFJZ/lAIRyGGvrwioKM5cI7LsQ0SBfnOwu3Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IateY19U9hWd9JVZzio8XuBhMmgk3QOcHLFPNLlI9WN++g0hGjZ7OuO1BNmcsR23zTyC0ovA+0nwfVgFZ7EhrbfFcydTZxrFrYBjwkaB+ypgLc304J4jfp8XC0+jq5uE9yuENGBCCqu2zn0whz+ZN9TFM15qB6mgO7WXoOoPXSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rTh+vaNK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C8BC433F1;
	Sun, 24 Mar 2024 23:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324231;
	bh=NbFoFKDFJZ/lAIRyGGvrwioKM5cI7LsQ0SBfnOwu3Sg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rTh+vaNKGaFgMwhYBeiZevwKhM9gXstPnOxx95OxkAQGdxAO/cUa87nRN6TwKhRhB
	 NaVJKItUv7NLnAuHuvpgjo7Csno21BcMiyN52xoLULfbpadue4Ug8Z9VLKUOXxEDCL
	 Eoc66KOPsrWN3oDUME7m16uS1i57rRyT7xLgNwPKNcAImc7eh05oleBONSfHWJHL3T
	 qEmyXZ3o81xQqEK774F420mEpg8aZKwsgdIY3tKT/Zqg54I5T+lVLFnOcaz1SgQ/FD
	 ez/ipHRU6MS/XIA24PscPt9fazPAOCxqn1UHAlogOtYiVrr812q5QYboI0UZiZlNUM
	 yoT/Wjrr1etdA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stuart Henderson <stuarth@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 014/148] ASoC: wm8962: Fix up incorrect error message in wm8962_set_fll
Date: Sun, 24 Mar 2024 19:47:58 -0400
Message-ID: <20240324235012.1356413-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Stuart Henderson <stuarth@opensource.cirrus.com>

[ Upstream commit 96e202f8c52ac49452f83317cf3b34cd1ad81e18 ]

Use source instead of ret, which seems to be unrelated and will always
be zero.

Signed-off-by: Stuart Henderson <stuarth@opensource.cirrus.com>
Link: https://msgid.link/r/20240306161439.1385643-5-stuarth@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wm8962.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 55e041031d398..74321c16e41f4 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2867,7 +2867,7 @@ static int wm8962_set_fll(struct snd_soc_component *component, int fll_id, int s
 				    WM8962_FLL_FRC_NCO, WM8962_FLL_FRC_NCO);
 		break;
 	default:
-		dev_err(component->dev, "Unknown FLL source %d\n", ret);
+		dev_err(component->dev, "Unknown FLL source %d\n", source);
 		return -EINVAL;
 	}
 
-- 
2.43.0



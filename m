Return-Path: <linux-kernel+bounces-115792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 039B98897DB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 974B41F361A8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16ED83702E7;
	Mon, 25 Mar 2024 03:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpUynXYc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AE314533A;
	Sun, 24 Mar 2024 23:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321982; cv=none; b=jqzWp6JBPYncZQjsV+0/M4ug82EuAPTdy/Hcuq9kPhV3V0Di1J/wNG9A+JmD7Xcwfox4oKSx931jOpsfc2n0Hu3uTBA2L5fBmrsdXbi3Ks9HnEuX0aIqo+ZPpUs9iNrB0hvv3BRe2w4NFUrMRW6D4KENVdOpZ0zFlwj7jLpk8Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321982; c=relaxed/simple;
	bh=6Y0sxHPmF359JPj2GjZUJqNCtsxnGlEXTdvPBG3aWy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tiiLx1YjXcH3St9UzBbYMcYM+b7KDs2UvMmEujBzWEaNx6WMUc4KO/44uShrCA97UtVQDo/WBI9LzSmitb+nf/F9PdNtUs6WD4DqLnVCidE3vu7cz0bktwpvpTcr/naV39QIANETAR6aCp9O0xcCVtr1DIrD7W72HeFuwJ0qMVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpUynXYc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0240C433F1;
	Sun, 24 Mar 2024 23:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321982;
	bh=6Y0sxHPmF359JPj2GjZUJqNCtsxnGlEXTdvPBG3aWy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BpUynXYcvVpGk41MtRMok34tPJv3Vqfq/TGuW0Oe7a+NmY7AuavCCsUyhkonf9qr+
	 eyusOQRQtlj3F+wGzw6K0aNr8F8IKw+zHoVLfJnobfcrWOkqqokq4C9c5UyoNqJ0DR
	 Syct1v8M4jGmyFyFo5T38ysOGyKMHK/0DSe2vtZvJP5vHp/ZtZNDYAt70MpFlxgryu
	 7d3e1eALFXLkCN1MM7BS9E7yIjBPjb2a32aaZijvTaqqUqLl6xnEKVDT5+Q5NSO5B3
	 jqgW+TSdLMtmmlwYwTLi22zXJHRceSMW4e+XXA/cr3ye8kMDAEh8qKAwZzc3WD02GB
	 f/1uHAdG6Py1Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stuart Henderson <stuarth@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 055/451] ASoC: wm8962: Enable oscillator if selecting WM8962_FLL_OSC
Date: Sun, 24 Mar 2024 19:05:31 -0400
Message-ID: <20240324231207.1351418-56-sashal@kernel.org>
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

From: Stuart Henderson <stuarth@opensource.cirrus.com>

[ Upstream commit 03c7874106ca5032a312626b927b1c35f07b1f35 ]

Signed-off-by: Stuart Henderson <stuarth@opensource.cirrus.com>
Link: https://msgid.link/r/20240306161439.1385643-1-stuarth@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wm8962.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index b901e4c65e8a5..35d8cd4fc71a7 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2914,8 +2914,12 @@ static int wm8962_set_fll(struct snd_soc_component *component, int fll_id, int s
 	switch (fll_id) {
 	case WM8962_FLL_MCLK:
 	case WM8962_FLL_BCLK:
+		fll1 |= (fll_id - 1) << WM8962_FLL_REFCLK_SRC_SHIFT;
+		break;
 	case WM8962_FLL_OSC:
 		fll1 |= (fll_id - 1) << WM8962_FLL_REFCLK_SRC_SHIFT;
+		snd_soc_component_update_bits(component, WM8962_PLL2,
+					      WM8962_OSC_ENA, WM8962_OSC_ENA);
 		break;
 	case WM8962_FLL_INT:
 		snd_soc_component_update_bits(component, WM8962_FLL_CONTROL_1,
-- 
2.43.0



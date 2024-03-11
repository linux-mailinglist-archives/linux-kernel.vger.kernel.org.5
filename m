Return-Path: <linux-kernel+bounces-99406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3A98787F5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48CFD1F26404
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C743B60ED4;
	Mon, 11 Mar 2024 18:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOq6Tphn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066125821C;
	Mon, 11 Mar 2024 18:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182333; cv=none; b=bERg8J630vTu4hjxtbe8BsZ8weirwflyMmLZ1ke1EKQ0mXDGrOO3gu3hUJJtFTA3IG/fMEL2CQ23BU0rblu12h/mwQSJHNVvUVkG9bbymqU4Y/JO1uVTF7unxLyhy/lgByyn6D2l8LHNf7mH94lErT7KErNKoU8THofbq0uMtZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182333; c=relaxed/simple;
	bh=6Y0sxHPmF359JPj2GjZUJqNCtsxnGlEXTdvPBG3aWy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qtDBJMqp95BiMsp5oFwjeye54WcMCnSxF9V/cTIYhMF1rCKTu93QvhxucO3ic8wbRd7clu5o0U7T0JR9KTOuxQJG7+McNPir9QNVsh24Lhz7Adyk2piVHZnSzJpDQpSMYTb/V+mcrFOfBfbU4lFxhc2Kp1NovEXMQlo60SIAziE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOq6Tphn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E303C43394;
	Mon, 11 Mar 2024 18:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182332;
	bh=6Y0sxHPmF359JPj2GjZUJqNCtsxnGlEXTdvPBG3aWy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jOq6TphnE1ocs4wUciRMv2eqPgyTxrcWoxisGzpm0y5pJgmeErRI6luKpummXZ01p
	 +QwCrq3BTIz8GJxzc/O40MaV7kbMjkIn1nnphQk2lMZ0qEWNg9VqnkJ+EVX3vUga8e
	 XgTxPavJeesL9n5It8ibKUBfP5Bue9YDSuwO6VJGJvPwuuXNPO/ScHdkvVJr5v+DiX
	 WlaUdVmLdnu4hRW6XGqCqS1MA5Xu0haykZqiiTBveDPuwTvgd7P7wWxnqA5iffJDJk
	 YdW0uAXSH552T9BIyjuMorHlNRTvoJoaqid9N60JruM6wDQqBGVnxccbKx1/WNP8NV
	 q7sXgBA2qqFbQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stuart Henderson <stuarth@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	patches@opensource.cirrus.com,
	alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.1 5/7] ASoC: wm8962: Enable oscillator if selecting WM8962_FLL_OSC
Date: Mon, 11 Mar 2024 14:38:23 -0400
Message-ID: <20240311183826.328535-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311183826.328535-1-sashal@kernel.org>
References: <20240311183826.328535-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.81
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



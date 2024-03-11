Return-Path: <linux-kernel+bounces-99386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 322C38787A6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD01C1F227C9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0855B1FB;
	Mon, 11 Mar 2024 18:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBudWVwC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069665B1E4;
	Mon, 11 Mar 2024 18:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182239; cv=none; b=E2lMmh5r4Or1lSGGxAFoMZtx1YbAUww6wcQeoZqOc6RKHj5ouv/V6/K12fBu0s4MFH9I3XOVxeuZw+t14k++ffKrueFVisLJhOFGdLa9Nnktf3pEwQIWBsBXxZKVPRwjbgJ9qgcqbrYxpGpvU3i//bxYqA5KKF9T2pQPQhQj6Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182239; c=relaxed/simple;
	bh=+QnN6eBvfT5YP0LZVKnQaEsUmmjbX3a5mPdlwG1VBws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HS+YxvVsKcCl8TaxPZimQegI3sKGQ+uJ74ulEjtgL8qopRexksvVC/FllWHEE7w2cZot3K/yBCVnpBCG4/JCNHGBYB9ZseyOC01JKFosDXVdgsXpRo0j7sLaiSQ+ayUDAqTxZP0HrmZHkEO4kS4VBsjGLRkvo46+QyakLZGrXGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBudWVwC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E10C43394;
	Mon, 11 Mar 2024 18:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182238;
	bh=+QnN6eBvfT5YP0LZVKnQaEsUmmjbX3a5mPdlwG1VBws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jBudWVwCDBxjsOJUmT51tXNsJzNZpQ3eHYRfVhncJ4J6R0gQOySNCwSEkbO6hlLfa
	 TXgbmdtFYktVnLyWog5iwUo5l2XBS5+AHwtE57/yz2PIjcYYRdYW1aXDOSxoHc8GdA
	 NvfCNMMDp2lTPbnJE6yFMDlVplPM4Pi0rK5pDHxvFtzwcDmZ7AS5jV70QPddmeiRJS
	 ci+cVCXyPJWXdkpza1yQ3UcJqKz/NrceilSsCamyczH9ojD6+y17BTfo5EGuHVLCOJ
	 sHvYLGEzBYmRGF2Djwmq3+oX06dMNjR3TopB81vDk0WyYFOjLQNqyB3z2UwuaY9clj
	 W1iETTGhdL0Ew==
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
Subject: [PATCH AUTOSEL 6.7 12/14] ASoC: wm8962: Enable oscillator if selecting WM8962_FLL_OSC
Date: Mon, 11 Mar 2024 14:36:15 -0400
Message-ID: <20240311183618.327694-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311183618.327694-1-sashal@kernel.org>
References: <20240311183618.327694-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.9
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
index fb90ae6a8a344..6d7bb696b1356 100644
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



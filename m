Return-Path: <linux-kernel+bounces-99399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6198787DB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 368841F25B64
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65ED6089B;
	Mon, 11 Mar 2024 18:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f79Jhrj/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E8F604BB;
	Mon, 11 Mar 2024 18:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182298; cv=none; b=hq0P1DeaVaHvj9y0wPsC2UUhAoq3PiRVcLSokNASBr3BLxPgDtHiLlTALbbtnA0bYvEHOgzve8LBW+yflXsIup7ZwC6jBXgLlKzd/syTHDTU2ssXZrIKr2oSNgAjrqZYTXmcz7LI/stGTn6Gd5y0vER/DxgGarfnQ4LVERZDKXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182298; c=relaxed/simple;
	bh=g0bIDGsnLq4XPpGnk9HQAmPP+fiIyU1Ypk3bcF0ztd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YdWlY9EcR+0KrjJq8iSrqjlBfgo2f7XFEUTl1hQygRwwW3OsvI43wqxXCnidDkLxYeBdlhBDKTaRMRp4Hsvu6Y5DriaG6sDW8ahy0g337xiWt6MVPeevVA6J+S+AwXoEd87epc3t7609eRPmHqDTX9cd3dpHNw1F5lvQA8qq/qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f79Jhrj/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB321C43394;
	Mon, 11 Mar 2024 18:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182297;
	bh=g0bIDGsnLq4XPpGnk9HQAmPP+fiIyU1Ypk3bcF0ztd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f79Jhrj/dZIrpozoNfS/A417w5U7ulf3ng/EC7/npYjDSeM9V8QUDOdIrf5oJGQba
	 AfZyn0+E8GexKHIZkom6JvDXyQd7/SezYbfnscYxcRkEMB3hGw50Nu+WCNC86csR/X
	 FQUuDvjbqEr3ASiVVUCZaN6BEY0CNxzTavhdwLEkIQXwIoVKeMB1MWczqHgXw7Qtej
	 Jqp8U0sluxZvNNTcDYHL9B6lgWe9BtrEWi+cMx1vHc9CrQ8TdVPh3RzZOzL7E5jnYF
	 LJ/Gb+dvAdQbCngh1raUdySax3HiUMJinyX6FDBXuxWxjansbs/J4KZjeE24lMRcNj
	 kihcHpBT8M6bA==
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
Subject: [PATCH AUTOSEL 6.6 10/12] ASoC: wm8962: Enable oscillator if selecting WM8962_FLL_OSC
Date: Mon, 11 Mar 2024 14:37:24 -0400
Message-ID: <20240311183727.328187-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311183727.328187-1-sashal@kernel.org>
References: <20240311183727.328187-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.21
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
index 83ce5dbecc45d..d444b7776ece1 100644
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



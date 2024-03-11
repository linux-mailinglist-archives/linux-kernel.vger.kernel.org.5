Return-Path: <linux-kernel+bounces-99428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B1787882B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 707C61F21F12
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26794664AB;
	Mon, 11 Mar 2024 18:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMDKUnXQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697FD664A9;
	Mon, 11 Mar 2024 18:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182430; cv=none; b=UWbcSEJ7s4TlCbEwJ86h2p3xFt68/PVd/fd2a4GcSLe53L45Fbl8Kt4zylLeVNGZt3He4cTjHlA95UF8rJhHhobm/OVkW5vj/iYJcFTE+1aMwuTkFPfL7f+IHxL+JONSXHpMJYkQqoH2HQIara/cpUUHaMQTyYR4i5lEBQNxFrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182430; c=relaxed/simple;
	bh=lqUQWIx+8Xr3kNZFo3F/Pk5FsJwY8BoGx7jkaoPKYX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cKo24KSe8LD5d3FnLSGVLKmKzMWjXu4oaCeDE8FXDFyrjRC/VlUr68CIaRFq6eml2j5eh5fnqeWZC8euqccLccvLbc3AcxBkj+JWWIqwryUKIT8TdWlU2aupWF4wPX1OKocMnISwELaGwVf1QaiAcqEmqUQeAc2ZVaXRHr0MspU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMDKUnXQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB5DC433C7;
	Mon, 11 Mar 2024 18:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182430;
	bh=lqUQWIx+8Xr3kNZFo3F/Pk5FsJwY8BoGx7jkaoPKYX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aMDKUnXQzA1fQzeq8T6NG0aWAIoioNXxKjXg9a8Z4QFmoxmA+zRJ0EWmeeukV0RB6
	 DFP4vB91nckbcrFgnYJ6j3CAPMl1p4DD0f8z8kdqQMnH/yZ6U5EgEt4D8tUqtretuL
	 J313Qz0djX9xLN6qgpgoIM71hiXQVle+c2FNH5vlpW68GCYHae8pVcXcSNZPtq9jX2
	 bKz96zJEvVTyjOapTLh7c0XaX74vD65Sng6ElCQwUHdmKwKtOPnmIJ2bjyuJJ3kvXX
	 MdTedDOhNUwtrYiOw5atvGeiA/IFUcGNrATn8du/46uUwMMXlG5V6ldXml79OQzVzn
	 wUMLV5P/Dzecw==
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
Subject: [PATCH AUTOSEL 4.19 3/5] ASoC: wm8962: Enable oscillator if selecting WM8962_FLL_OSC
Date: Mon, 11 Mar 2024 14:40:09 -0400
Message-ID: <20240311184011.329314-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311184011.329314-1-sashal@kernel.org>
References: <20240311184011.329314-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.309
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
index 3f75cb3209ffa..674bc6f65ed0e 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2848,8 +2848,12 @@ static int wm8962_set_fll(struct snd_soc_component *component, int fll_id, int s
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



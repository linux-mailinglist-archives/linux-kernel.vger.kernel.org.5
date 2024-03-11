Return-Path: <linux-kernel+bounces-99411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A06878803
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D32072827EE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68385627E9;
	Mon, 11 Mar 2024 18:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXeCV41H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A902A627E6;
	Mon, 11 Mar 2024 18:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182356; cv=none; b=CrVDZmhGo/+3+nOokYZxE+RNoBgHvylqzpXpYhxEy6R80rw3eRb4kYI2P1xHTqHMRiowyNSo3oG+RsfWLRjiXmb2GHz076h6FU+59YdBtQs8IJs+zsifLibeo5xL6erm+IXmBAS5PMxyTuiyqmvRjqoPBDHSU82Vhx1tgcp5aCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182356; c=relaxed/simple;
	bh=sYDEOH0SIb1oJ1rax5oz64WlqG7l/xYsPg5+CTtP2AA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o85iWBownWBz+CuyYWp0Yasjllx31Nbym0j2/MyvCdun9QHuiXnq5QyBingkp69QmKNpTkNMP0J1fFbusOdgo7cS8ly7R9i5m1vfEDeEpNW8BwTZjddHcljnIVqbfslpuGsEkXqHXgU2oEcZ2tFVDtfbr7GVwpxq2deXS+BnyXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXeCV41H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D233CC433C7;
	Mon, 11 Mar 2024 18:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182356;
	bh=sYDEOH0SIb1oJ1rax5oz64WlqG7l/xYsPg5+CTtP2AA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NXeCV41HHx3c87M0MFjznRquUEhvSqrPdnEavtiz/6IvxR0D8wRB/zw7U2QNc+MsX
	 RNQsSpKiUWULyvEavRX0gDU1jaNuy2VQ3lm39qnZxzfXWvH+netSb8JJ7s1PfqH4VH
	 3Xs2RQ23Kdi03StQoOFwcPy7DsxtS1cp/BuTKuuKZhdfmhTatloJru7FnVUtHW9oS3
	 kuuseIUc4/6xhDcT9XlMqjdSg4DkKDryHV/ZhVT0I4ndxvNLQ5goNGXoShxk2szbxT
	 QhrrEtcRRsYx1NSh6PMfO2IwNiBvCOroik9TFSgY/o60NxYqvD26wuUEoCWe7eWZep
	 dlgHmw3qqV4Tw==
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
Subject: [PATCH AUTOSEL 5.15 3/5] ASoC: wm8962: Enable oscillator if selecting WM8962_FLL_OSC
Date: Mon, 11 Mar 2024 14:38:59 -0400
Message-ID: <20240311183901.328749-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311183901.328749-1-sashal@kernel.org>
References: <20240311183901.328749-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.151
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
index 779f7097d336c..9f8929cfada22 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2901,8 +2901,12 @@ static int wm8962_set_fll(struct snd_soc_component *component, int fll_id, int s
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



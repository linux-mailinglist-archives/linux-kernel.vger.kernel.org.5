Return-Path: <linux-kernel+bounces-115169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC40889338
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E21D1C20A58
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9941C8FB3;
	Mon, 25 Mar 2024 01:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldo6+76+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D0822BF66;
	Sun, 24 Mar 2024 23:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324229; cv=none; b=jaRc5lisF6nOUVG4fJT81kTMn84QERQdSB6E8wHq7HSCmWVPnDpKXV8SrYH7r2Exw0hYrGTXvz44fbn7RTqdKXb3Y14vz0gn+SMYDW4JrUKckL9JoxnLB6anF3Swc03o8bvKREH52/koJMFDVk8M1N6GInHB06sx2Xo4A14ZcQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324229; c=relaxed/simple;
	bh=lqUQWIx+8Xr3kNZFo3F/Pk5FsJwY8BoGx7jkaoPKYX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IPOI0QRMEhRHtjHuD12EAN/5gR8ie3m2QxEqwFiQQFZkvBJ++Yp/W5rzP1LFvxVjSyemunPd4Mr1bTX1PPn1Egj7b0SWN9bwZqWicaY7ZUgBUgOWirl7YYz1sVzTIREmoAjPVb63d0+Xnp09ZSGnWVdL6ilcqb1yeQZ9NuuKgss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldo6+76+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC476C43394;
	Sun, 24 Mar 2024 23:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324228;
	bh=lqUQWIx+8Xr3kNZFo3F/Pk5FsJwY8BoGx7jkaoPKYX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ldo6+76+iFIq6qIZWy8r6Z2MD6WAHNJVuQyXPpgNy0loO0Jdf3l0U+/gfkkxgy54c
	 qrIyB6KNBoYSsQmO8ZTUf9Kh46w87XFcvkEsJehmqjY44/M+4TrHB2cbz0mLS+onLn
	 +DEJGrsHkHjEVaR1wyV7LzLsI5eV3+uwtLnVfxHWRasWB7YgLZ57Y27BNSZtSwwgDE
	 GH/ZDgpcphHMTMKHmtB3p1/GG6nOCd3yKWZ2QKIDbg2hKkTixeJrCwL/fusOp5Yqmr
	 BiWHxWtlqHV6JGZO5CPA1GnFmSKLMdPJg/LsvNbHDWRai8KnzcL9TE8xT3oC2UoGp6
	 41ll5Mfl7GyRA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stuart Henderson <stuarth@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 012/148] ASoC: wm8962: Enable oscillator if selecting WM8962_FLL_OSC
Date: Sun, 24 Mar 2024 19:47:56 -0400
Message-ID: <20240324235012.1356413-13-sashal@kernel.org>
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



Return-Path: <linux-kernel+bounces-99408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 786188787FB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C8691F2135C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8066167C;
	Mon, 11 Mar 2024 18:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5eTV/ab"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E44058207;
	Mon, 11 Mar 2024 18:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182341; cv=none; b=PClC1g1a4OAUTxE/TbIEGFBvoas0oY2qUDqNHPr5xMGQDRFUXp0GUwFHgRhM+pWf7XL8pXxJ17IZZtqyUYckEPXNqXadCxEzbGnwnbyx2xKrHV5teX/mLsQ5W4ODEm0l0STL69dYTX293UXid3a+d+3nHWb+Kzrqk1iY2EQ4oAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182341; c=relaxed/simple;
	bh=TIf3s6V5bENwoiLVAZ6jPbBX6LcknLpg34pqRGhwQso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tx6d4lRidww6Lr6dxWmGnTZkeTcLWu19TFbemLFX16SluG4VCSMMBEjD+8ycRFmDfHFR0/se67TUnqPIuD5gaqOJkUpuOoK86Gll4SZ9GfzIBTaxaXfoq1H/im+/hDq0O6077ISQaqjN5CL3agTmHk3wQTn0SaOe4t9R46hZDfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5eTV/ab; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 771EDC433C7;
	Mon, 11 Mar 2024 18:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182340;
	bh=TIf3s6V5bENwoiLVAZ6jPbBX6LcknLpg34pqRGhwQso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X5eTV/abM31YEPbYQJzmkhPSGv4zSwLokP70BGWtMAULi+3km+m/TwQdPO2PwUeQn
	 PqL+71v8XlhtfnlIx7zks/Lp3m86vb5EdONdXAz91r0oAVi9iN6XURdcmTIhmeTw7c
	 TGxJJ0TgaxRZj5PaBUQlsvbcZ73MSDx0PEO76RNjLYEMfHZyKVE7nPLCczq5FWsob7
	 KfCrJLR+OXPjBXK+baXwDLRx4jyUu0UQRtYoBRW7+5g7kaWFP3vOLATGjbwpW/6Dvi
	 HeWQKEtKnH1K5oznvMcHNLl9VYGFdZ8zLoGfTKtDQw+GDv5biR6qaPimNvA3nAlC9s
	 n+yvLibDxF/HA==
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
Subject: [PATCH AUTOSEL 6.1 7/7] ASoC: wm8962: Fix up incorrect error message in wm8962_set_fll
Date: Mon, 11 Mar 2024 14:38:25 -0400
Message-ID: <20240311183826.328535-7-sashal@kernel.org>
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
index 806b69c9b2e36..d215e58c4a7b3 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2933,7 +2933,7 @@ static int wm8962_set_fll(struct snd_soc_component *component, int fll_id, int s
 				    WM8962_FLL_FRC_NCO, WM8962_FLL_FRC_NCO);
 		break;
 	default:
-		dev_err(component->dev, "Unknown FLL source %d\n", ret);
+		dev_err(component->dev, "Unknown FLL source %d\n", source);
 		return -EINVAL;
 	}
 
-- 
2.43.0



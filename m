Return-Path: <linux-kernel+bounces-57223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D183484D54B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EF8B1C259A8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71967145FF0;
	Wed,  7 Feb 2024 21:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ie/FINcG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFA2139943;
	Wed,  7 Feb 2024 21:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341263; cv=none; b=NReAMua1ARhBnrmaZ96R26HziCWqFroTDDdm+wFNpcIyd3st8qpm1hIm/RcZ7/y56OVTG72bb0lJCAvkQLhf/Ha/4eIQUamq7syq0KMs3lyK1kYJrCmp7kaf4lw5nwnDojDtMRphcKPYnl0jXXykXe+OUyu+wR/jKgjvBG3vEiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341263; c=relaxed/simple;
	bh=rfP78/Abx8Kp60WplKnnefeljYYal+/1mu05tON0jkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OXaK/3zJhbfPNN3V4vH3pDM4N6OgryV/RPziX0mdsGMpn/vmZoIwLITjbi1aGahH2aK4Mvn6dZS0jDiWwFQkiTHw62Fh052IsZLgcncGQ2tSW8zsF4yieXLab7rdRrj5ex7wiBjSjzDSPP6SQ8IilSNNRK888DNTqw800TkP5OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ie/FINcG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D7EC433F1;
	Wed,  7 Feb 2024 21:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341263;
	bh=rfP78/Abx8Kp60WplKnnefeljYYal+/1mu05tON0jkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ie/FINcGfW8g4nw4YhYQqiJ1+IaeCpfoxPYil8DasteGCI2vhaGF0xVQCkdUS+jyr
	 CkJ8aEdhZNAXKPrLUEJwIw3E4mDm25OdwcXRzqzRnJstBrl+u9VZZSL/9EeBkGXZCA
	 bpOSGZz1Pg/EMdJPVPK9biroGa9UMgpJ1tU4RRHAa2IIOiVBOuTSU1crxqjl6ZX0hB
	 RkDUYNKe7GTiDbioaSshiK676w2XgJVJkXAgZXeyqZ8xcu60Hu9YO5UTIRONJyuAB1
	 p9u959Ij3RjmCimUw912wLDPyfS/S0MkZ+1dSqdkhszyYErOD+a2KAGhCFOKu+eLjW
	 pLpjsao+eMsEA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chen-Yu Tsai <wens@csie.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	samuel@sholland.org,
	kuninori.morimoto.gx@renesas.com,
	ckeepax@opensource.cirrus.com,
	ruanjinjie@huawei.com,
	robh@kernel.org,
	u.kleine-koenig@pengutronix.de,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH AUTOSEL 5.4 5/7] ASoC: sunxi: sun4i-spdif: Add support for Allwinner H616
Date: Wed,  7 Feb 2024 16:27:29 -0500
Message-ID: <20240207212732.4627-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212732.4627-1-sashal@kernel.org>
References: <20240207212732.4627-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.268
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

[ Upstream commit 0adf963b8463faa44653e22e56ce55f747e68868 ]

The SPDIF hardware block found in the H616 SoC has the same layout as
the one found in the H6 SoC, except that it is missing the receiver
side.

Since the driver currently only supports the transmit function, support
for the H616 is identical to what is currently done for the H6.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Link: https://msgid.link/r/20240127163247.384439-4-wens@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sunxi/sun4i-spdif.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdif.c
index cbe598b0fb10..680d64e0d69f 100644
--- a/sound/soc/sunxi/sun4i-spdif.c
+++ b/sound/soc/sunxi/sun4i-spdif.c
@@ -464,6 +464,11 @@ static const struct of_device_id sun4i_spdif_of_match[] = {
 		.compatible = "allwinner,sun50i-h6-spdif",
 		.data = &sun50i_h6_spdif_quirks,
 	},
+	{
+		.compatible = "allwinner,sun50i-h616-spdif",
+		/* Essentially the same as the H6, but without RX */
+		.data = &sun50i_h6_spdif_quirks,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sun4i_spdif_of_match);
-- 
2.43.0



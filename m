Return-Path: <linux-kernel+bounces-57081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 044F384D3D9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD87C1F27432
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8A0135A62;
	Wed,  7 Feb 2024 21:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpJMULxa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BBC135A4A;
	Wed,  7 Feb 2024 21:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340936; cv=none; b=nG+RRr1VfErqMKPuHK4T4RYtfrZ5eYvaUIkqByxPAC5o9VlDELIiY2nSLyEpTtX/Kha0p6D5L909q4uWePYdO4ieCZK6x82kCOX4d3PJYHTtUrQlgnChAqtaUWtbbvlaA6nn4osymdno2aM+kf3+mN6n4UuYLwF9mr6paH9gnck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340936; c=relaxed/simple;
	bh=93jnX0X1VEpNdrH3+7indBG/9bv6BaajaOA/UlBZVhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BalTbi0NMKCICho1ou8cAVslT9ZbOMPuAdfsVhaEUY33BKcJCV/Tfn5REBAkhaK2mTT7p53zLl8zk+b4laLrcqPkbozdNfPtiX4VVE6tg54ImgGSiOVZx3mqzc0PTADLuiC+7rq3rCW6vKoqNYc9yXnP2ZY5SZB3h4z9/vXjBmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpJMULxa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57592C43399;
	Wed,  7 Feb 2024 21:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707340935;
	bh=93jnX0X1VEpNdrH3+7indBG/9bv6BaajaOA/UlBZVhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NpJMULxaHD7bMwX39e4kAS8qOgH/BYXlFVg6bgofWcIkqUkW0ZQsrQiJKiCkUrYi5
	 Y0wtz8ssyh/eF8BU9XlX1wj4GSU0xeqeeAOWTP9YT6k9v8dGuELGHfLyHS4oCETq+3
	 hKsQrGP3BVvPHi1GaQio5fzNvPr2MQMft3T4lSRI+OK7M8XF8ROfUktTl9Jildg+8X
	 d+Ve2ssJaXCWtymP9ugs9XRTwE9hMRRL+7PPMAtt+ySjvkCwme/tKJhzXS9Ln9P4Ss
	 +rtyJP3RtkvW0IA9tytLC0YB3JijhPgflNu8ysHT9dUsZy7+Hibks9MWzXzdVIGsoO
	 0qLCpfHq1PU5g==
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
	u.kleine-koenig@pengutronix.de,
	robh@kernel.org,
	ruanjinjie@huawei.com,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH AUTOSEL 6.7 16/44] ASoC: sunxi: sun4i-spdif: Add support for Allwinner H616
Date: Wed,  7 Feb 2024 16:20:43 -0500
Message-ID: <20240207212142.1399-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212142.1399-1-sashal@kernel.org>
References: <20240207212142.1399-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
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
index 702386823d17..f41c30955857 100644
--- a/sound/soc/sunxi/sun4i-spdif.c
+++ b/sound/soc/sunxi/sun4i-spdif.c
@@ -577,6 +577,11 @@ static const struct of_device_id sun4i_spdif_of_match[] = {
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



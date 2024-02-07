Return-Path: <linux-kernel+bounces-57126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC16E84D447
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 798B42830D5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3CB14F9CF;
	Wed,  7 Feb 2024 21:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5Ut9bB9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57B512FF60;
	Wed,  7 Feb 2024 21:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341050; cv=none; b=RZmuUjJiLnEFrKC+2BEuX1PStvma1KcOhgQNnao3jpKGGwIj9MQU0sYUsFMTWqm5lIVzH/0F8kR4Zl3pqzv0zPuVczVbUoekH613LXNZ8BKiQ0BaAOMpYp+1NZTwzARjxqV1WLfSOJVx+ed1Ay+2THjcF+KYqUIO5SkAwG+KAfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341050; c=relaxed/simple;
	bh=droCsilHD9FvkUxBYds2+zzj71Va/FfGxR2e9G/B7cQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tameCt+VV/Eorwan7B6+/6bpj21wsgobhRhw4e/GgeG62blzC1GizRqR/5rwtH6tdrcw7l6PUlHPqAxpNSuC8A4gvg7Vdt6hs61b5QTsnUIJPJazBz/41k5XK7K561Yv1CxLrhx+7DiRBXKsaMW6NRDmrHcLz4wiuTjoDJ0DFyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5Ut9bB9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E4B7C43390;
	Wed,  7 Feb 2024 21:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341050;
	bh=droCsilHD9FvkUxBYds2+zzj71Va/FfGxR2e9G/B7cQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H5Ut9bB9By8kaXmNwEY+Q/vv9Vwyo9+g30+sse5/vV7OQD5FEQweMMQXLAKbdUuZ8
	 EwJNFEmi2AIOQFxxh26dBfFRkevHoy4gAsp+JuLq2bJtiy7hA4GUxomGwyowWd0kzI
	 UbdOiOq5+QfyUSgiFbnNHNarHrVTklZgYpC5UzWQ/jS8qFnCNThNRSu7hvRByM+32g
	 M3w3fYs9vMCScdt8eVhDdQPNgTyOSGjJ6sKGSQ9cIdiZELYagsrgd3CYcwIlgAEfr4
	 B9lUYHHm7jpkPLweFMwyUil98WtJrNQ1dr404aojTjZRCTADzZnd0GSd9ZRpDS5qTI
	 K+PMBvqJTdxSA==
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
	robh@kernel.org,
	ckeepax@opensource.cirrus.com,
	ruanjinjie@huawei.com,
	u.kleine-koenig@pengutronix.de,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 16/38] ASoC: sunxi: sun4i-spdif: Add support for Allwinner H616
Date: Wed,  7 Feb 2024 16:23:02 -0500
Message-ID: <20240207212337.2351-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212337.2351-1-sashal@kernel.org>
References: <20240207212337.2351-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
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
index b849bb7cf58e..2347aeb049bc 100644
--- a/sound/soc/sunxi/sun4i-spdif.c
+++ b/sound/soc/sunxi/sun4i-spdif.c
@@ -578,6 +578,11 @@ static const struct of_device_id sun4i_spdif_of_match[] = {
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



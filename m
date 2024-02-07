Return-Path: <linux-kernel+bounces-57188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C80F84D4E1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF2D81C23658
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2B11353E9;
	Wed,  7 Feb 2024 21:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3FJhFEK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4239D16E365;
	Wed,  7 Feb 2024 21:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341189; cv=none; b=Nj/L7QyvF4uT9yu0Q8BOEiRsJN0jS1U3UiDjMWyhv6UawZGO5hrgQSQ9sPKA8bmtd4+rRstU5mj21S3NA+gWD84hfpD312iR2EQ0oCiGBCwakz4SubRSWO0X+3RD0iPKDiFahlvPcoGqy2uAebZOCP5L6Vv+jMogK4w+AeWAW1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341189; c=relaxed/simple;
	bh=sl5TAruvrv4TSDXD3Yv/uY59z0SCSctU9KLkFude0bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nvoc2RQXzwXzlIz5eFeQJ4sNsftS83p810gdc9blfDB1pAQnAfGg4uebQvxeEDARyIMklY4kzLDB2E79BMQ5+MqR5aad/blPcC/JPLQBEW6BjLR6tDdlX1K76RX/4/Ozi3cl22fKgI8BXnnNSqTIzvN+sM/xlfWzN0cn30zr6+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3FJhFEK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 987E3C433C7;
	Wed,  7 Feb 2024 21:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341188;
	bh=sl5TAruvrv4TSDXD3Yv/uY59z0SCSctU9KLkFude0bg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B3FJhFEKSavUOgnWHKA0W07bHjxO6kLqOLiWUVMxLU3jxE982kfzcMYWXQ1AcJApD
	 oQAOf/SV4Rfw5cSwIpfpipMsuvxGaiXuEW+GqnRE/zj2DixCvUTy3yy5IFAho072Ee
	 UMYRA0/zefE0yHWkKxRfakGUPtWSHnHx8OMr6rc4ZtwV1DPBnihOZDuFk/GB/yr/pK
	 MsB6wKFRrmdDx3WqS1vCBNwyzszTbAPtvP67zaeObrRS0cAl0h3UrTjYip7gqXZBC3
	 jIn9csQLNgy/fuVKRgvz54Uo29WXho7kj9YoWzcYe0174jmiDsCORquTyx6uTqgBEJ
	 KtwXaDtGAxVWw==
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
	nicolas.ferre@microchip.com,
	robh@kernel.org,
	u.kleine-koenig@pengutronix.de,
	ruanjinjie@huawei.com,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 09/23] ASoC: sunxi: sun4i-spdif: Add support for Allwinner H616
Date: Wed,  7 Feb 2024 16:25:50 -0500
Message-ID: <20240207212611.3793-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212611.3793-1-sashal@kernel.org>
References: <20240207212611.3793-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.148
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
index a10949bf0ca1..dd8d13f3fd12 100644
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



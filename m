Return-Path: <linux-kernel+bounces-57159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B2184D499
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 283741F2198B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B04D1350D3;
	Wed,  7 Feb 2024 21:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oP2OIF+z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF6F157043;
	Wed,  7 Feb 2024 21:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341127; cv=none; b=qpHvGw9kjmfMdMWzq0wctWb6sm6q2vhsEY8DZkJKXWfcjnNSepSKBz2fpsZCJxwy7KM02EYpa6EFeYFQTp98ZkJh64H+pQIjn0IDWWvv0/cchjs4BdcQyelmzuh83y98hG0k07vl3EdqBjywriXHQgOsiPT8+6a/RTTiGT3W3dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341127; c=relaxed/simple;
	bh=8clVlBmFo+UTPTjVu6eDvOnRGTbqZs8d+hMhuA2e8fE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CpKIkacdOhlWBgiQSx4AQ+u2shyqWK5fNf8FTWAZTwVMsUKWnZlbD7GjgdScBdHj8ddB7mmLb7NU/iFshAK3vWkYmFam6I9akDtwJolDUg6CoywNQekYjqfnR0K9Is2ElEzq3Gyvyss5qlr4KiuamNX3JhDQ9dHyTm/2QcFUcNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oP2OIF+z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B1BC433F1;
	Wed,  7 Feb 2024 21:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341127;
	bh=8clVlBmFo+UTPTjVu6eDvOnRGTbqZs8d+hMhuA2e8fE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oP2OIF+z/flvS0b8WN+dZNSNRDnBE2tYTNotherI38YfknQDzEDDgGGM3rLrGwdQK
	 QhMUs2Y5eSJxSkWyzdw6ShJeGq2mUOuhKwYOpx2/BjiROXCJKktBO5tdzLUk4pB/Ud
	 SB5ZpZjTomGm31R5K0vAbeLuUkArNxVyxCngXt4Y3RxVwc8AkKDjclXRR1Z86ekW24
	 5iMG28O2KiDspsicKhPV7/4vxaGHW5baGzXj/BsPT1oF3e5yWJbYd4CTGxUOU2I8H1
	 buqRDO1bzDs5USUKQpXWWoY4bTsJSl7iRjF0Xltisl5ke6vex8ZtP/HxJYJt86ztwO
	 RizItBAwY9cBA==
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
	robh@kernel.org,
	u.kleine-koenig@pengutronix.de,
	ruanjinjie@huawei.com,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 11/29] ASoC: sunxi: sun4i-spdif: Add support for Allwinner H616
Date: Wed,  7 Feb 2024 16:24:36 -0500
Message-ID: <20240207212505.3169-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212505.3169-1-sashal@kernel.org>
References: <20240207212505.3169-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.77
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
index bcceebca915a..484b0e7c2def 100644
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



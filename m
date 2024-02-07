Return-Path: <linux-kernel+bounces-57209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B4E84D525
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76E721C209AF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D7C7641C;
	Wed,  7 Feb 2024 21:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQU/jNlH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426A16F521;
	Wed,  7 Feb 2024 21:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341235; cv=none; b=oJsyVb/Rkv0xYlBBuH+7rkuqVHx0DUVCW9hgFNTB1P0WdlG1McARMPH/gbJDC7WceRWXSSquhpC5gW9uUOEJVNPJSBE5Pzn556f0Od5Dtm3b3umElLIakwgT++JtXERzav4bCUAhA+fzgQTEeh50VkD11YBx/2D14PS7m0PtMOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341235; c=relaxed/simple;
	bh=lxCjGoMz1GPeg4iphNIXQdTpaiA/vfzyJn8/wK9k3AE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kZdLSFaUQIXGDgWRpoiWDXWI21xD4UDE2gFKuAzSX3oIhVdHdx7xmLDPRqqhouUAuetcm3yFxOtPVu00W2/mtuMxvbpmXN0ekqzB6iCL47xzWVbwq9ojQBv1PmZHTKqN2VSw56O4C/lIGGhzYTdFPfEPqpNkgVEi2lzOLLM1OdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQU/jNlH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A72C433C7;
	Wed,  7 Feb 2024 21:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341234;
	bh=lxCjGoMz1GPeg4iphNIXQdTpaiA/vfzyJn8/wK9k3AE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OQU/jNlHdGNFQncLTSi/gXL3aLQsIaP6sNnfCRrjr7RIfd2KU76wr5qTQuvEAJTlk
	 mVstpx/5IbVNDvafRHiRzyzRzS1IF12wg6qTr+Y9GwqZIb6WW83uHiPrPtN5t8Uqfp
	 j7oS96lScIPEjMxU7vuV66b5Qegrw2WMgHUOIK4tAruEg/AfmsazsgNrSFqF1T3obY
	 y90hw1FBrYa1E5UmnBlUuHWnvCVs7S2OWq/YtAf+O/jFYQTIzNPrGfzAZ103rnS0RG
	 NepTZMx3dJVNavXheXMrCJUcmZMth+FwzuWNXv3STl/xK4gF4zqKTKlEEedjDwKa4m
	 zQGZeKOpJ8rSA==
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
	ruanjinjie@huawei.com,
	u.kleine-koenig@pengutronix.de,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH AUTOSEL 5.10 07/16] ASoC: sunxi: sun4i-spdif: Add support for Allwinner H616
Date: Wed,  7 Feb 2024 16:26:47 -0500
Message-ID: <20240207212700.4287-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212700.4287-1-sashal@kernel.org>
References: <20240207212700.4287-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.209
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
index 228485fe0734..6dcad1aa2503 100644
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



Return-Path: <linux-kernel+bounces-144340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C03488A44C0
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 20:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F14721C210F5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 18:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D0F1384BE;
	Sun, 14 Apr 2024 18:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHEGDY+x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FEC136E1A;
	Sun, 14 Apr 2024 18:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713120529; cv=none; b=llokTs8FVjOaKtkyWrYtDHhJjBL2AbMNgSjM+ODIFCRqo6ESVSJPVTedn/GfGq0mttXX49lPfjGD+LJScaFx4o0Xowyc7q079nmGG+BT6DV/tSWTNnooyBWEev6OETU1Ot9G5lh/n9dyO1IB3X6gYhoyxJ24W3gv3GHkVe73ND0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713120529; c=relaxed/simple;
	bh=qgb4PnCVl0dqQSpagyMoidmTAcUFqQ7boy1JaeGL+xw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e7kqdLZp6oXQHhruJDmKo8pVYgXwZduUpM6+lQefhjVA6PaadryIGvvQsim/Dzlz7RbYQB+81CiIc41tnqPF2DP6GSxR7E+F4WufKKf5kLwyVV1jBiVaYVoi1d90PkgFfFs/BNhYW4I6QcYouNZ/+dHvxjrS3/wv+p6cTj10408=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHEGDY+x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE0CC32781;
	Sun, 14 Apr 2024 18:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713120529;
	bh=qgb4PnCVl0dqQSpagyMoidmTAcUFqQ7boy1JaeGL+xw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SHEGDY+xloKWsvdr1QregSOPFE5gZDmG8xvNFgBuIGon3puktflzKUrL9aUk2OXTb
	 FojfSY5yP54bq24DZv1HJfC7IwwGCfwUmM51x01JKqhIh3O3/4tErqQGQg6nR7pVfG
	 4o2KfoWO2BOwWpyPu+PbilVoX2DWm55eKMxx5A5YVvkUtl1iY2QxyJ7yKpde+JT7SH
	 ZBOtub+8OjKoeeUBONcyECzbylOZOWW7v8rIChX+qL3p7VYxq0Yf45dPTmVdIMcyGF
	 e7qbWEaqg/mTrAllusKO0DYnT1fGjrNwFuaQXvvj83tq0eKHDK3fzDtD0zIvgoZggY
	 o4U4QL/UTKSxQ==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 14 Apr 2024 20:47:33 +0200
Subject: [PATCH 08/14] ASoC: SOF: imx8: Constify snd_sof_dsp_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240414-n-const-ops-var-v1-8-8f53ee5d981c@kernel.org>
References: <20240414-n-const-ops-var-v1-0-8f53ee5d981c@kernel.org>
In-Reply-To: <20240414-n-const-ops-var-v1-0-8f53ee5d981c@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1012; i=krzk@kernel.org;
 h=from:subject:message-id; bh=qgb4PnCVl0dqQSpagyMoidmTAcUFqQ7boy1JaeGL+xw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmHCTLxCrRFj2CbxXNcJMF1mYYqYrCPBlpVKzLk
 ZK0FIwRfi6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZhwkywAKCRDBN2bmhouD
 18WqD/4t4JUa14a9ctzBg8GUlqATymsKIponwobiAd+pdWdo4nZULjKytV1nfQdgj2wsuviDLfW
 6se3BJx7VHjcOfGcJXXXbrPVEDgXRwmP2j3bWYfwsfi+8nG6l338p160sOivSVoZ1vdcALpKe4k
 SYo/2t2Ugo/MnYOC4d7hI6ABT15UNpNOsmT4i5ELyAU3qswUbxVtffxB1H3KXCi4xl2cpS8NZeZ
 Z/KOrRuG31ZWmPrdr2wtHpQKMFHh1vBJMvriMVrvKpd+zOntTsYdS/fznqBCyjIVmJcWJwR2zof
 BKgS/O5gNEcW72mbpeUHeNj53kUg2j9I6KtUewi9asBJdudH5tcmLFHsfWGjo+F6c4f6vJtYd7R
 wFD941HoSLeuESMiqK4oO3kmf2FC1yDl50jhD2OxeehTbUN5KFV2tY9fJdYwCuy99Ie+hBmiVNr
 gtd8NV8+IhPNRRkWggI3/4RUmILVdYwqy2+K1Bf9BP7irQd4w9R5oZqP02TclMLArojpr16DKz7
 d5+S6usRxjE6Sb89p9jwuWCBiGZ2gn9b2ZgWOmk5EZZeW5s2YKu7O+iYlWMwZwP5Xf6lKarIdor
 uybySSbglauDc4Iv7VBLAOAog5l2faNB5Vq7k2eX3YJLbjeiHyyt/TvfeEQmAWbT/xYlrsXSb4Y
 1iemPv7EFYgM9Vg==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct snd_sof_dsp_ops' is not modified by core code, so it can be made
const for increased code safety.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/sof/imx/imx8.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/imx/imx8.c b/sound/soc/sof/imx/imx8.c
index d65e09a927f6..3021dc87ab5a 100644
--- a/sound/soc/sof/imx/imx8.c
+++ b/sound/soc/sof/imx/imx8.c
@@ -478,7 +478,7 @@ static int imx8_dsp_set_power_state(struct snd_sof_dev *sdev,
 }
 
 /* i.MX8 ops */
-static struct snd_sof_dsp_ops sof_imx8_ops = {
+static const struct snd_sof_dsp_ops sof_imx8_ops = {
 	/* probe and remove */
 	.probe		= imx8_probe,
 	.remove		= imx8_remove,
@@ -539,7 +539,7 @@ static struct snd_sof_dsp_ops sof_imx8_ops = {
 };
 
 /* i.MX8X ops */
-static struct snd_sof_dsp_ops sof_imx8x_ops = {
+static const struct snd_sof_dsp_ops sof_imx8x_ops = {
 	/* probe and remove */
 	.probe		= imx8_probe,
 	.remove		= imx8_remove,

-- 
2.34.1



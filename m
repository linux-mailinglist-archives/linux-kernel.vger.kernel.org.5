Return-Path: <linux-kernel+bounces-159748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E53B8B338F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A07BC2819D2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328AA13D53C;
	Fri, 26 Apr 2024 09:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ja5OV4SZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F4313E02A;
	Fri, 26 Apr 2024 09:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714122356; cv=none; b=CbmKIyvzso4lnDztitrBig1KL0qR6xSpONWKhqHlFQti8feOpC6JPYSQlG9WO+7p/MfBizy/zG2mKRSbB6S/b5q6kCrnsNgM0NobQOAHQ1YbsDEXfTKHX7L+Nfk9n70x/3hOsxmxIfhTMIgop0Bn0zhc/Xm5MrvCuyy6zdbcJiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714122356; c=relaxed/simple;
	bh=dwWOV4SZweJ8ytLb+w8zBZXa3dPFIs1yZjd4j/v8Io4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N137tw0RpHp/+4s/7JKzc5S29uxMbVRKYQrB3aqgueFVFHGyLyOWp2aD1rElGnkcKPSBpRoxKNhwWs5mQxF5gTRY2cB7pKGUG07MuU1zo4OdE669PrO+E9jtlupfWIGylORFxmJDG1Ko1lC44FFHHunjhBy+qGr0xodlrwXqDTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ja5OV4SZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 247A2C113CD;
	Fri, 26 Apr 2024 09:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714122355;
	bh=dwWOV4SZweJ8ytLb+w8zBZXa3dPFIs1yZjd4j/v8Io4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ja5OV4SZvYXWq0hVVyR2HGgLXllJRbCAzbNUhiI7aRKRIQ5mmnxniMI0MbzEk+a/1
	 SzaSti8MrMWG7tvrvdKqlUNP04pMsOapue8eKQD48aqVnsvidim4VIFMUrJTZg7V7I
	 oAbkDXMpl35GgzcmIBMXvzD8iiF90yDCih9wEozr8Cy7C4oqE5WuvadIAt78oP6NI0
	 q6ksE68h7w4JPuWkP1PIp5FoD7cQheiglgOrt6uQ9KXEBc7jdhTfLN6J8lqEak3t70
	 +5O/RYBgxj0y3zLYPXWduAzwXKpMxo3Qz903t4EKijg/ydbsuVwGYxWPlkEdzoTsdh
	 Ygzru04ZDYoHg==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 26 Apr 2024 11:03:55 +0200
Subject: [PATCH v2 08/14] ASoC: SOF: imx8: Constify snd_sof_dsp_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-n-const-ops-var-v2-8-e553fe67ae82@kernel.org>
References: <20240426-n-const-ops-var-v2-0-e553fe67ae82@kernel.org>
In-Reply-To: <20240426-n-const-ops-var-v2-0-e553fe67ae82@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1084; i=krzk@kernel.org;
 h=from:subject:message-id; bh=dwWOV4SZweJ8ytLb+w8zBZXa3dPFIs1yZjd4j/v8Io4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmK24mHSbrjv60BeG3lTvTBn2FMZ6o7H6vVAw6/
 YLLpWRLHgiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZituJgAKCRDBN2bmhouD
 11qsD/9pumSWYNhS8XZXAHrJFMGx/Fm4mJI2ptbjfWaYBmnMu/gTxjYVkbt374o8VNmEq9Z/xZv
 N9gC01eQD+WDWkAV8c5/84gHaEk57UWhazF2UV5LlpIYSnL/9YO+jfmgw7YkRolCWqArPRIDXkF
 Q7hE4OKj5KJNx8vvJ9JOY+mc9cqRd6i+1qE/Am2h9EUL30v+WCz6/Sd/I/p8HwepPH6fB99Tfiz
 X7o+isE6+SFBDczOjgDRn7lmlFzZXPBssCri2pHxeamUXWHD0zb30o8t9tatSp4rBcnEkRfxnn4
 YjpWjqNLi+lpTw3+zGz5kFIUIv9Mn2l7eGNvRk9umW02LH+yavfgDkBFu1MEcY2FlBtXcP4LIBT
 IqNco2HBZLF9yA73rP6V92S6O2qLjoQ3Bc4gVRVPNE+eL1j1Ww+6cR8KWz6lMstE7rIZskHCQB8
 u/LAguK7dZlAbEYxggGHCO1jFoeKnClyOZ3rwpsZpGVjSCiARJ8d/J4/c4n0yJQ/sSL69tbtvzq
 qgWtlNZP9ETI//QXueq/o/vePJOqstM8SYnn+UwKzYO7rEOgzhKy18sHQxDAyovvhDMx+/vshH5
 pKplkGAt7RkeLv3ET9jBkwmkirNSGWjnq5eTYlEmEeP22eTP0UuIV9RiuO/+3QSUbeKOwkSAgNA
 h1H32jNGeafVSAw==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct snd_sof_dsp_ops' is not modified by core code, so it can be made
const for increased code safety.

Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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
2.43.0



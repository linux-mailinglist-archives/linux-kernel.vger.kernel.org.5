Return-Path: <linux-kernel+bounces-144342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2E68A44C2
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 20:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DA391F210D5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 18:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737361386CF;
	Sun, 14 Apr 2024 18:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ReQCdqbb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13CD13774E;
	Sun, 14 Apr 2024 18:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713120545; cv=none; b=tUUwmTDk77FcYgjZOqFglH0C7QiFIGNnjqt0ZT02XMkvpWg0rP+ez7YuqZ8OtWvGOnZB5V4qtojcfN6KiQVShxxPM5KbwKUS/BSDAE9rzLP8EXelYUwEGH62D8iWEzwr3hCZnDXuxScCsoyH9ZF04NGaDK46OC74FX4XdUJKixU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713120545; c=relaxed/simple;
	bh=jtqJAvdCzVf0KHLlWMGtcqe5mcAFkufBUSxCwKo/4SI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DD+As8XkKRFLcFyC8kQ4iyBIpkHEYVgrXe9XCy1+7rSMvSL76Uko0XJ3TUQffo2y416xmTToyYZXx96ICnm86wiS4nF7g85NO/TSE/EKPVlTu53600y2UXdgn8aFy14dlq9lvAEtAX1J6Oma+EhqNMFjs7f8NMgaL2bsyqhquco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ReQCdqbb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0964C3277B;
	Sun, 14 Apr 2024 18:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713120545;
	bh=jtqJAvdCzVf0KHLlWMGtcqe5mcAFkufBUSxCwKo/4SI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ReQCdqbbnH0DOQNUXYk+seYVigCJ6US4GhxHsxbg3kGdn9Bc7qDo9uJyYrvcRuwLA
	 H6jjvpo6rj5ZpGdJ4K9eq3a3VbAvyDFp9oSCv62ZBjm+df7cVSJOHTXBiM5sq6E+Ms
	 oS+lZ8H51876UmIiL2YXy1PnFcOiARZ7dbRENiVb6rqBiH+CS2+vOzJ2mlXX7Po7GJ
	 cjlMvRfWWsNDMfzv3X+o5oUx9TzCkBGe7czfzt84JpZ6mvgeyMc/lQ7AlXTC9CYHiy
	 oq3cfQ+uoWazQM/gxEl6wqX2TReFJUAUERy6yxzH0Et7+VcTM1b2jlEOugW/hgNT9V
	 sroNSXiqnC6JQ==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 14 Apr 2024 20:47:35 +0200
Subject: [PATCH 10/14] ASoC: SOF: imx8ulp: Constify snd_sof_dsp_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240414-n-const-ops-var-v1-10-8f53ee5d981c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=759; i=krzk@kernel.org;
 h=from:subject:message-id; bh=jtqJAvdCzVf0KHLlWMGtcqe5mcAFkufBUSxCwKo/4SI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmHCTMZvIPE90QIjHh4JDJGIIE6imTFU4GmmswP
 yyXSkheG0yJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZhwkzAAKCRDBN2bmhouD
 1y2NEACXCTRj2D3a4ADYFmh0jZtAPLpxvUIiVRHBk53PjOv4nRt3dZgoFazC/j/O9Z6jPXNgBTw
 cIJ7hOguwi0gL4UijZ1ydMf4AfVdMMg3F6icDvFXe4iLt5RASdBTdQKw/7qXXo0Emse0B1xHJqw
 ncIPWBAslfh+FRlGVBjE+HL3/CfKdnUjvf2prGZVCejhAEZKiV/AtWbZ8QLkjkn0XE2vcmHz9KU
 YcdLpLdR3HHHXJXsBu2s+QL6KCnLI5pvzblSY6bmro+ah0ycU792HYJps7IvFA/ONgR/gFemL4r
 3nNTtrNVejmifOi7VR/SBNgoKR7CzUOiLQ+rel8ByH5Xzj36ZryfCyNeWPx67ZmNKFvFB4IVSN0
 RGQpGuGdqYm004sTagDasOceIBUsznRdNfmZkXbl0n/6N548l6vE9/VuIOPFXDkrTpZfLOhimZo
 mdqNF5HHbr7EMqaWAnAMVL+olJM/gdSWWDrutkZQQkNUJxYXEYoNMJwIOPJtdbsbdK1vqEtIzZa
 YgghG20mcoK1w0aoAK6nhp1MA/sAcwAN6+328yW8QFZ39W3LF/gMLOEp7DoqrxhUnAv9OZ5WH66
 CGfBWS2ZPpUTbU6Z6n87+Q+e/v+sz9gf4XsChST06WomtmYTTaFBk2NhmkFTo29FyKCOxrdhsiH
 66madR3UGdgLN9g==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct snd_sof_dsp_ops' is not modified by core code, so it can be made
const for increased code safety.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/sof/imx/imx8ulp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/imx/imx8ulp.c b/sound/soc/sof/imx/imx8ulp.c
index 296fbf11f6d0..8adfdd00413a 100644
--- a/sound/soc/sof/imx/imx8ulp.c
+++ b/sound/soc/sof/imx/imx8ulp.c
@@ -408,7 +408,7 @@ static int imx8ulp_dsp_set_power_state(struct snd_sof_dev *sdev,
 }
 
 /* i.MX8 ops */
-static struct snd_sof_dsp_ops sof_imx8ulp_ops = {
+static const struct snd_sof_dsp_ops sof_imx8ulp_ops = {
 	/* probe and remove */
 	.probe		= imx8ulp_probe,
 	.remove		= imx8ulp_remove,

-- 
2.34.1



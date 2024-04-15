Return-Path: <linux-kernel+bounces-145109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E88718A4FA9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4231284C31
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA1C7317C;
	Mon, 15 Apr 2024 12:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxSc3T8e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA377EF10;
	Mon, 15 Apr 2024 12:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185371; cv=none; b=YWMz0jO4N60YNZv90iK8oGpSWu2bly7ylDAc9N1j+RDpD6AyVxxfEgraTHZQ+t8ArcFVssqkoLPFe463d5cQFyOwhXee6IJt32IsCNk0zhm2OqHJHOi5zoLRLNIbdJGaqcUhbDmWi1DWJqU4hcSyiGL+XyfHfyDPcleROTp/3l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185371; c=relaxed/simple;
	bh=2+fWmE4fzjm1UpgpZwcaWiLdJ/D5ZVxPyMB2wribPws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bOHJuRkYa122CtSkFKakzS/Y00NyhYBG2GzOLkbGkbF687x4KhKrVa6FLAj8RZLvfj1fqqN93M72XGu+PiunaXBQrlDbzXqpJpjUsnfGPU8CiYFEHgJeS5WUlegNt4IwD5yCa4v+P/6S4La2LsHVge9a/XYArs59kL+VYSRzCKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxSc3T8e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F7AC113CC;
	Mon, 15 Apr 2024 12:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713185371;
	bh=2+fWmE4fzjm1UpgpZwcaWiLdJ/D5ZVxPyMB2wribPws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gxSc3T8eErbArDdhZwp5MYjc6/N82S4IWStRmFjuxOrOB82Tjn9ht3DlDP9JQLToU
	 K+VNA3iGi9u2wJbN9YGLXdawsg6wHwIou3lfl7JWTg6+5hLBDtSgbNnmiThMEr8jrM
	 FE6hSoNJiT20gqDlv1IcIyoTjypNZR06jgJK2j+vtVH6EUwuoRZzsOQgE4LkrIpmbJ
	 6iYmvcmtGCDAmU06DA8IXNvBm10BegAXL/oGZEsssMJiOnUeQfGvhMf8ZaQintHER+
	 I+t3AdOi0+WorKKY9u+gV8j73K7mTPeOBJYbULNWvek/XAMSPdmJBLMLZN2hhGXolT
	 kn4UICz+opjzA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhang Yi <zhangyi@everest-semi.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	zhuning0077@gmail.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 10/15] ASoC: codecs: ES8326: Solve error interruption issue
Date: Mon, 15 Apr 2024 06:02:50 -0400
Message-ID: <20240415100311.3126785-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415100311.3126785-1-sashal@kernel.org>
References: <20240415100311.3126785-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.6
Content-Transfer-Encoding: 8bit

From: Zhang Yi <zhangyi@everest-semi.com>

[ Upstream commit 8a655cee6c9d4588570ad0cb099c5660f9a44a12 ]

We got an error report about headphone type detection and button detection.
We fixed the headphone type detection error by adjusting the debounce timer
configuration. And we fixed the button detection error by disabling the
button detection feature when the headphone are unplugged and enabling it
when headphone are plugged in.

Signed-off-by: Zhang Yi <zhangyi@everest-semi.com>
Link: https://msgid.link/r/20240402062043.20608-2-zhangyi@everest-semi.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/es8326.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/es8326.c b/sound/soc/codecs/es8326.c
index cbcd02ec6ba42..fd1af97412bdd 100644
--- a/sound/soc/codecs/es8326.c
+++ b/sound/soc/codecs/es8326.c
@@ -757,6 +757,7 @@ static void es8326_jack_detect_handler(struct work_struct *work)
 		regmap_update_bits(es8326->regmap, ES8326_HPDET_TYPE, 0x03, 0x01);
 		regmap_write(es8326->regmap, ES8326_SYS_BIAS, 0x0a);
 		regmap_update_bits(es8326->regmap, ES8326_HP_DRIVER_REF, 0x0f, 0x03);
+		regmap_write(es8326->regmap, ES8326_INT_SOURCE, ES8326_INT_SRC_PIN9);
 		/*
 		 * Inverted HPJACK_POL bit to trigger one IRQ to double check HP Removal event
 		 */
@@ -779,6 +780,8 @@ static void es8326_jack_detect_handler(struct work_struct *work)
 			 * set auto-check mode, then restart jack_detect_work after 400ms.
 			 * Don't report jack status.
 			 */
+			regmap_write(es8326->regmap, ES8326_INT_SOURCE,
+					(ES8326_INT_SRC_PIN9 | ES8326_INT_SRC_BUTTON));
 			regmap_update_bits(es8326->regmap, ES8326_HPDET_TYPE, 0x03, 0x01);
 			es8326_enable_micbias(es8326->component);
 			usleep_range(50000, 70000);
@@ -901,7 +904,7 @@ static int es8326_resume(struct snd_soc_component *component)
 	regmap_write(es8326->regmap, ES8326_VMIDSEL, 0x0E);
 	regmap_write(es8326->regmap, ES8326_ANA_LP, 0xf0);
 	usleep_range(10000, 15000);
-	regmap_write(es8326->regmap, ES8326_HPJACK_TIMER, 0xe9);
+	regmap_write(es8326->regmap, ES8326_HPJACK_TIMER, 0xd9);
 	regmap_write(es8326->regmap, ES8326_ANA_MICBIAS, 0xcb);
 	/* set headphone default type and detect pin */
 	regmap_write(es8326->regmap, ES8326_HPDET_TYPE, 0x83);
@@ -952,8 +955,7 @@ static int es8326_resume(struct snd_soc_component *component)
 	es8326_enable_micbias(es8326->component);
 	usleep_range(50000, 70000);
 	regmap_update_bits(es8326->regmap, ES8326_HPDET_TYPE, 0x03, 0x00);
-	regmap_write(es8326->regmap, ES8326_INT_SOURCE,
-		    (ES8326_INT_SRC_PIN9 | ES8326_INT_SRC_BUTTON));
+	regmap_write(es8326->regmap, ES8326_INT_SOURCE, ES8326_INT_SRC_PIN9);
 	regmap_write(es8326->regmap, ES8326_INTOUT_IO,
 		     es8326->interrupt_clk);
 	regmap_write(es8326->regmap, ES8326_SDINOUT1_IO,
-- 
2.43.0



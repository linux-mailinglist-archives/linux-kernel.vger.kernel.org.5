Return-Path: <linux-kernel+bounces-15872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B6C82348E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A69A0B23C14
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D171CFAC;
	Wed,  3 Jan 2024 18:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mN06hYTJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E125B1CF9A;
	Wed,  3 Jan 2024 18:34:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39CCC433C8;
	Wed,  3 Jan 2024 18:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704306872;
	bh=k+wZ9DUmK1WPFz8OxLLNZ0ZWpbB8ZluB+bNJACGBqHw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mN06hYTJYP4vUJkzIVyJggMtNhH5bjGEC6hbcWm2nZoVDE75nJtA5usZkUEJxobtk
	 OSbPcKja44zFBMGKrJxFfsW8cNTRIuwl5tluLRTqn7GoyXqVzych+HD8AHJOpRCxPj
	 JR3MoBhNhf1GOqAZizk0oo89SDeoTunakH2oqAawKchZqc3WrEVgWmkzI8O9l3tjwB
	 JffOo/wQk4Q3yO/bzmLW03GkQ96c1KPcGQSlAFQb0a1kx6Vam1tN4iBjUQx1aSHfZl
	 GnFLAOGvT7j4bBgqej52HoM86B8nVOOnKWLhJLHVo8XnvI5rdhpFYM/ug+pxnQw8pv
	 cia96wv1Stc6w==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 03 Jan 2024 18:34:04 +0000
Subject: [PATCH 4/4] ASoC: meson: g12a-tohdmitx: Fix event generation for
 S/PDIF mux
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-meson-enum-val-v1-4-424af7a8fb91@kernel.org>
References: <20240103-meson-enum-val-v1-0-424af7a8fb91@kernel.org>
In-Reply-To: <20240103-meson-enum-val-v1-0-424af7a8fb91@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=932; i=broonie@kernel.org;
 h=from:subject:message-id; bh=k+wZ9DUmK1WPFz8OxLLNZ0ZWpbB8ZluB+bNJACGBqHw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBllaiofg5sZ5UECpsyDPRJXOqEZ9mf0sLO11M27
 kloJ0lo/iqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZZWoqAAKCRAk1otyXVSH
 0EXVB/9EPTFgsfoqfT5+k9WPYlVvILzv7DRCBrrX4Dk30LFrjy0hOPaay0t+wOgCgFgqVDUcqJI
 LwFTPUnsmA7j5yRuN+SMrAnnFfnQEyuPPV/EFxkREUXU/aCyQKFLmW7OqHmrUwS9htAziujJjrG
 Ww9xm5TT7dpYbhiOpbIFJcRfsDyY3iO2g4BHveT7FZxe4NqiHD7SuRpk6Fye1iM/aF4XgE20rxC
 0n/ft7mDMd1x2vtbccdNl29rtTK2PZd+UwixHb7cG/mkxMcTqlM6MCCvrHnrjU3am5eW2J81emb
 EAzSaCZpR8PwygqGkgKRcUz9e2Bp2lrNwqW1bF/hhufwivfC
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

When a control changes value the return value from _put() should be 1 so
we get events generated to userspace notifying applications of the change.
While the I2S mux gets this right the S/PDIF mux does not, fix the return
value.

Fixes: c8609f3870f7 ("ASoC: meson: add g12a tohdmitx control")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/g12a-tohdmitx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/meson/g12a-tohdmitx.c b/sound/soc/meson/g12a-tohdmitx.c
index 51b7703e1834..b92434125fac 100644
--- a/sound/soc/meson/g12a-tohdmitx.c
+++ b/sound/soc/meson/g12a-tohdmitx.c
@@ -118,7 +118,7 @@ static int g12a_tohdmitx_spdif_mux_put_enum(struct snd_kcontrol *kcontrol,
 
 	snd_soc_dapm_mux_update_power(dapm, kcontrol, mux, e, NULL);
 
-	return 0;
+	return 1;
 }
 
 static SOC_ENUM_SINGLE_DECL(g12a_tohdmitx_spdif_mux_enum, TOHDMITX_CTRL0,

-- 
2.39.2



Return-Path: <linux-kernel+bounces-33961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F21708370F8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73479294C9A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C98547F5A;
	Mon, 22 Jan 2024 18:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K24fJxSp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1293E490;
	Mon, 22 Jan 2024 18:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705947508; cv=none; b=lmzjaVQXyF1FQyB2+urxmLfdCDdC/2HUK2OOAlzfy1jBHQCo4XhzB04IJrpgSAOXa3zdkZGA7+LJTgmKy8LzYHIuGHAW7kgSwlrbGwgFRFyiWrDbEH5UBp+zpwLXcQgR+1Xbfl96mURCliBTjMZp8Xk0PTOvpymc1Z86nysniHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705947508; c=relaxed/simple;
	bh=J3pJykalQ9z5qLyd0IoXv2mhNXbeb8C+rJuQjv479Gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MSugylEISZxdBjo9oS0CXVKBhF713kZJEFQ/WT42KFxyliX/jOs49XI9aLFlR+Zk+XVpI3gLw05DbyuGnvZFhOZjV2xmoOVq8cTSdxsKzBDi5kfJaJXaEyPxAb5T/lUuFkzGZFPt8WpFZPIfN9tejulzfCO5EcPgMELH2lu7xsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K24fJxSp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC71C43399;
	Mon, 22 Jan 2024 18:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705947507;
	bh=J3pJykalQ9z5qLyd0IoXv2mhNXbeb8C+rJuQjv479Gs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K24fJxSp+FVgatotrYgfDwSUxsJpUEUirW5i9YYtNy82g7DIQQb8BNKtVxHiXa4Pe
	 WbtgD6zZUdGpU2tphB1q7HqEvldJNHIzfIVA5R6RjTYkHDg4xTQdFzAvTkAx+CUEFf
	 hwbwP2fPqRCrLn1XxDA8XEKKB2eavF044La9klYHiWDFyVANSqK1S+AII7R+G92SbJ
	 KA84JkyVeb5KQdZV1Mz9MEIcHpZg9tzeSCMyk/4P16zr14RMCLe9ylTrFoUgVDzD2c
	 lpakAwNuE/2+uRRsEOFN20SObhp9DBfyjH+n8P8z/rzHIPf9JnlQYmD53TJy4jvHE+
	 Z9TP1RLO37Chg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rRysa-0000000013T-1ZCx;
	Mon, 22 Jan 2024 19:18:40 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v5 1/4] ASoC: codecs: wsa883x: fix PA volume control
Date: Mon, 22 Jan 2024 19:18:16 +0100
Message-ID: <20240122181819.4038-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122181819.4038-1-johan+linaro@kernel.org>
References: <20240122181819.4038-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PA gain can be set in steps of 1.5 dB from -3 dB to 18 dB, that is,
in 15 levels.

Fix the dB values for the PA volume control as experiments using wsa8835
show that the first 16 levels all map to the same lowest gain while the
last three map to the highest gain.

These values specifically need to be correct for the sound server to
provide proper volume control.

Note that level 0 (-3 dB) does not mute the PA so the mute flag should
also not be set.

Fixes: cdb09e623143 ("ASoC: codecs: wsa883x: add control, dapm widgets and map")
Cc: stable@vger.kernel.org      # 6.0
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 sound/soc/codecs/wsa883x.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
index cb83c569e18d..a2e86ef7d18f 100644
--- a/sound/soc/codecs/wsa883x.c
+++ b/sound/soc/codecs/wsa883x.c
@@ -1098,7 +1098,11 @@ static int wsa_dev_mode_put(struct snd_kcontrol *kcontrol,
 	return 1;
 }
 
-static const DECLARE_TLV_DB_SCALE(pa_gain, -300, 150, -300);
+static const SNDRV_CTL_TLVD_DECLARE_DB_RANGE(pa_gain,
+	0, 14, TLV_DB_SCALE_ITEM(-300, 0, 0),
+	15, 29, TLV_DB_SCALE_ITEM(-300, 150, 0),
+	30, 31, TLV_DB_SCALE_ITEM(1800, 0, 0),
+);
 
 static int wsa883x_get_swr_port(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
-- 
2.43.0



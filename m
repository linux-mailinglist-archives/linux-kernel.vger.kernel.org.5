Return-Path: <linux-kernel+bounces-31091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2468328BB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3357128569A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5202B4D110;
	Fri, 19 Jan 2024 11:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADbkUCsi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C56A4CB4E;
	Fri, 19 Jan 2024 11:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705663615; cv=none; b=TfJA7haXPBhD+etezCZd4WFqblZ1Rdbpj1AeigbNp4t9o0LSFs2/iaP2WmK1PedyVybe38ABdAkPYPP4sXVwMaJ+qH+80MQBIG871DKIgZ+FYTNHiRDj4QUX8EKnbl3ekS+hEcFisGfwnJFFEGUftl1l828STzyFWjd2///mDqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705663615; c=relaxed/simple;
	bh=7FAxMSZYO+6rp+32a2jHSpUGNLMh3wVgFHZWk8Irimk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kopNSqpsbRQVKqzQS8YrWf+VAjeCHvP29naXntVFNq22+qRbjvrgBZpjeiUC5wn3OfU+4T+0KxsMF2BZPXrMFsooqbEjyqPdfuCMEIpiFBRehxRAj6qvGgz0fgWFJLvgPPGS87cDCWFNphzNWIepUjJTgNte0d+azLzEpq954LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADbkUCsi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2516BC43390;
	Fri, 19 Jan 2024 11:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705663615;
	bh=7FAxMSZYO+6rp+32a2jHSpUGNLMh3wVgFHZWk8Irimk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ADbkUCsi+gQ1V2GpTItDg1bSvrT+UDjAIdH8Caif9AX6/QklxHnXtFj9V2PwLYXrN
	 +rr++YYQLjOVEmSPlmRA9YRO6tzcsJSjuQ0rJZCQNybWvQIApMUyAtE3YcWFLuXJ1i
	 46VSQHXGXxM9/0uy577nOpXGEIvfTGnpNHUpEmYboHUSo97p3DfJMyt09cXmfwMNMb
	 qvCp3h2J48QXN3oUyaP2Xwej7iF8R+QDzI3MgXJ0oopYKRzmNbETZJXHAoaCnI7ZDX
	 YRLoZkRih5NxYqvH0qec6PIJzE+/Ra6OnWNQLjJXT27wS15etRRROmLfOXSvZmQLNi
	 yPoKG/ATmo8VQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rQn1b-0001xJ-2g;
	Fri, 19 Jan 2024 12:27:03 +0100
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
Subject: [PATCH v4 1/4] ASoC: codecs: wsa883x: fix PA volume control
Date: Fri, 19 Jan 2024 12:24:17 +0100
Message-ID: <20240119112420.7446-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240119112420.7446-1-johan+linaro@kernel.org>
References: <20240119112420.7446-1-johan+linaro@kernel.org>
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
2.41.0



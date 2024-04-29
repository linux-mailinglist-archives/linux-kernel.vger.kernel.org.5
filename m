Return-Path: <linux-kernel+bounces-162970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0834B8B62DB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 980611F210AC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048EF13C3F6;
	Mon, 29 Apr 2024 19:50:11 +0000 (UTC)
Received: from mail.schimsalabim.eu (vps01.schimsalabim.eu [85.214.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7DF13D88C;
	Mon, 29 Apr 2024 19:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714420210; cv=none; b=JODHLSuzkihBHnpbCJDbMVsNsjZ5t47zbPtBK3FMLDwRVqXNyVyZPVoxBU2vUg4AbUR6aGg7rz5HMy1V0KcXCZyvFFvoeOMas1ZF56SqTBwtlDTsi0jT279G2wesZPZjOhl81RzAPmL2e5IbZUPasbWblWHQzK8rT8quOyeMMDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714420210; c=relaxed/simple;
	bh=zj3KU5WojxV+uFClMlpfJ5QoCeWL4Ou+kVZkLfofrs4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iO4x0ai8BPCoKxrzJ+rRWD4/YPSqt7a835Zf5gdFWqnMYOM+uCgSpnfpJl2clROXhMr8FEG3QUJQal0jp9nK6Hie8CJ8nGnSAZoBXYzUzBcKXDOBKELViSVOLJqTvAuDBeIMOgOA4DYj2V8bggOFyDj6PBriHjSZgft5fhj2tbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=schimsalabim.eu; spf=pass smtp.mailfrom=schimsalabim.eu; arc=none smtp.client-ip=85.214.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=schimsalabim.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schimsalabim.eu
Received: from localhost.localdomain (82-217-109-137.cable.dynamic.v4.ziggo.nl [82.217.109.137])
	(authenticated bits=0)
	by h2374449.stratoserver.net (8.14.7/8.14.7) with ESMTP id 43TJnPPQ000764
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 29 Apr 2024 21:49:30 +0200
From: Joao Schim <joao@schimsalabim.eu>
To: Ban Tao <fengzheng923@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: sunxi: DMIC: Add controls for adjusting the mic gains
Date: Mon, 29 Apr 2024 21:49:20 +0200
Message-Id: <20240429194920.1596257-1-joao@schimsalabim.eu>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AllWinner H6 and later SoCs that sport a DMIC block contain a set of registers to control
the gain (left + right) of each of the four supported channels.

Add ASoC controls for changing each of the stereo channel gains using alsamixer and alike

Signed-off-by: Joao Schim <joao@schimsalabim.eu>
---
 sound/soc/sunxi/sun50i-dmic.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/sound/soc/sunxi/sun50i-dmic.c b/sound/soc/sunxi/sun50i-dmic.c
index c76628bc86c6..dd32780fb6a4 100644
--- a/sound/soc/sunxi/sun50i-dmic.c
+++ b/sound/soc/sunxi/sun50i-dmic.c
@@ -14,6 +14,7 @@
 #include <sound/dmaengine_pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
+#include <sound/tlv.h>
 
 #define SUN50I_DMIC_EN_CTL			(0x00)
 	#define SUN50I_DMIC_EN_CTL_GLOBE			BIT(8)
@@ -43,6 +44,17 @@
 	#define SUN50I_DMIC_CH_NUM_N_MASK			GENMASK(2, 0)
 #define SUN50I_DMIC_CNT				(0x2c)
 	#define SUN50I_DMIC_CNT_N				(1 << 0)
+#define SUN50I_DMIC_D0D1_VOL_CTR		(0x30)
+	#define SUN50I_DMIC_D0D1_VOL_CTR_0R			(0)
+	#define SUN50I_DMIC_D0D1_VOL_CTR_0L			(8)
+	#define SUN50I_DMIC_D0D1_VOL_CTR_1R			(16)
+	#define SUN50I_DMIC_D0D1_VOL_CTR_1L			(24)
+#define SUN50I_DMIC_D2D3_VOL_CTR                (0x34)
+        #define SUN50I_DMIC_D2D3_VOL_CTR_2R                     (0)
+        #define SUN50I_DMIC_D2D3_VOL_CTR_2L                     (8)
+        #define SUN50I_DMIC_D2D3_VOL_CTR_3R                     (16)
+        #define SUN50I_DMIC_D2D3_VOL_CTR_3L                     (24)
+
 #define SUN50I_DMIC_HPF_CTRL			(0x38)
 #define SUN50I_DMIC_VERSION			(0x50)
 
@@ -273,8 +285,30 @@ static const struct of_device_id sun50i_dmic_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, sun50i_dmic_of_match);
 
+static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(sun50i_dmic_vol_scale, -12000, 75, 1);
+
+static const struct snd_kcontrol_new sun50i_dmic_controls[] = {
+
+        SOC_DOUBLE_TLV("DMIC Channel 0 Capture Volume", SUN50I_DMIC_D0D1_VOL_CTR,
+                       SUN50I_DMIC_D0D1_VOL_CTR_0L, SUN50I_DMIC_D0D1_VOL_CTR_0R,
+                       0xFF, 0, sun50i_dmic_vol_scale),
+        SOC_DOUBLE_TLV("DMIC Channel 1 Capture Volume", SUN50I_DMIC_D0D1_VOL_CTR,
+                       SUN50I_DMIC_D0D1_VOL_CTR_1L, SUN50I_DMIC_D0D1_VOL_CTR_1R,
+                       0xFF, 0, sun50i_dmic_vol_scale),
+        SOC_DOUBLE_TLV("DMIC Channel 2 Capture Volume", SUN50I_DMIC_D2D3_VOL_CTR,
+                       SUN50I_DMIC_D2D3_VOL_CTR_2L, SUN50I_DMIC_D2D3_VOL_CTR_2R,
+                       0xFF, 0, sun50i_dmic_vol_scale),
+        SOC_DOUBLE_TLV("DMIC Channel 3 Capture Volume", SUN50I_DMIC_D2D3_VOL_CTR,
+                       SUN50I_DMIC_D2D3_VOL_CTR_3L, SUN50I_DMIC_D2D3_VOL_CTR_3R,
+                       0xFF, 0, sun50i_dmic_vol_scale),
+
+
+};
+
 static const struct snd_soc_component_driver sun50i_dmic_component = {
 	.name           = "sun50i-dmic",
+	.controls	= sun50i_dmic_controls,
+	.num_controls	= ARRAY_SIZE(sun50i_dmic_controls),
 };
 
 static int sun50i_dmic_runtime_suspend(struct device *dev)
-- 
2.25.1



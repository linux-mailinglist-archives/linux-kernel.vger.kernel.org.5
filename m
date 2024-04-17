Return-Path: <linux-kernel+bounces-147948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D53A8A7BB9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C6F31F24469
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 05:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85ED2524AE;
	Wed, 17 Apr 2024 05:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b="yV0cmB0j"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0884F52F62
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 05:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713330904; cv=none; b=UW1m4w3VBoPl6AhL1xD9uhZALYbCaKFZP31OXwC5nj1nXmn79O9JlrXnOmGVMLY7aX49wtl5SWSFBRpb6twm0fYhyblpe4veuYu6dDA/9CkVKxrBLHTA5g/z5QkbIb02uaYLx4Kj61Cya2qAQ5Wmi6mvRUCVfetteQyLHY+T2fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713330904; c=relaxed/simple;
	bh=ejYuVDMK8hQ3c3/RJmhQWa4DT0PpOPzvnbD7CuzTmag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OmWQOs/c9dZsDGKJk0K2tCFxQeByVENeb7ZvV1m9wLu8q+vP9FYXapX11WmoTYuqxaXc8oMaQPMjJyv9p/PlPrMnA0tXc6WvBP/jP9N3Dw2sn6I2n+ivS0jHbHT3SYGruFRdLcPd7MSzNJspC1BNdI5DrahKlzH8vaJYrB+RWyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org; spf=none smtp.mailfrom=jookia.org; dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b=yV0cmB0j; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jookia.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
	t=1713330896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+wO2NVJgGgKxL9AnuBOvlzeMvS5QSt87gBINoPwNkwE=;
	b=yV0cmB0juL+gE4drGnEPB+Xk5XISypajXJXqLKpewPtGxn4U+IS7Zsfv9xgrhLvHVRljhd
	/YAmLU+jDFgpV8fbY0JjP7Lq0fd3A4Rug6xYw2Xz+thgXdwe1EWLjykviCKDEvBTFBxZVY
	65Y3HMcWmCh6MLGO7J28vBoVANlKoU5gvyQA0Y+P+azWNXK494UrVXoubWHbwLLwOOuhzB
	sIkfP5DFotpKQZWdwlLW4P1hVoA8PwyJMKcix+fgc0zS16cjVVYDBMVNrwErWAlGmu3oIr
	2m+rUm3qj8OiEOS92HavDCnPNeO+KzdqYwMqBNjVo9no3b1AXIFsGCFLerHqEA==
From: John Watts <contact@jookia.org>
Date: Wed, 17 Apr 2024 15:14:43 +1000
Subject: [PATCH] ASoC: sunxi: sun4i-i2s: Fix pcm_formats type specification
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240417-sunxi_s32_fix-v1-1-d82e451565c0@jookia.org>
X-B4-Tracking: v=1; b=H4sIAMJaH2YC/x2MQQqAIBAAvxJ7TjBdCfpKRGSttRcLl0KQ/p50n
 IGZAkKJSWBoCiR6WPiMFbq2gfVY4k6Kt8pgtEGNXa/kjplnsWYOnBUFZx161MEj1OZKVPX/G6f
 3/QDEL4kjXwAAAA==
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>, John Watts <contact@jookia.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1713330884; l=1490;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=ejYuVDMK8hQ3c3/RJmhQWa4DT0PpOPzvnbD7CuzTmag=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgpGuA3uho2
 8zVxm554DVLHyl4gq5/nBHglU5WIWN8/zYAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABA0GgHA+q2gKda09EGULTSaiS
 2/DdtY5KQbmfXmCRvUveV9K+PrfFhcZr7UTMaGjmtXlHZf8vs8mEGa+TKZk6GDgUAAOoA
X-Developer-Key: i=contact@jookia.org; a=openssh;
 fpr=SHA256:6LBQmZH5u7i/edmEZXzCTwCrpSevs/ZshZxNmlD1thY
X-Migadu-Flow: FLOW_OUT

pcm_formats should be a u64 as it is a SNDRV_PCM_FMTBIT_* not a
SNDRV_PCM_FORMAT_*.

Also fix a small grammar error while we're here.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404170103.ySYwieqi-lkp@intel.com/
Signed-off-by: John Watts <contact@jookia.org>
---
This is a quick fix for a type error found by the kernel test robot.
---
 sound/soc/sunxi/sun4i-i2s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 59830f2a0d30..5f8d979585b6 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -156,7 +156,7 @@ struct sun4i_i2s;
 /**
  * struct sun4i_i2s_quirks - Differences between SoC variants.
  * @has_reset: SoC needs reset deasserted.
- * @pcm_formats: available PCM formats
+ * @pcm_formats: available PCM formats.
  * @reg_offset_txdata: offset of the tx fifo.
  * @sun4i_i2s_regmap: regmap config to use.
  * @field_clkdiv_mclk_en: regmap field to enable mclk output.
@@ -176,7 +176,7 @@ struct sun4i_i2s;
  */
 struct sun4i_i2s_quirks {
 	bool				has_reset;
-	snd_pcm_format_t		pcm_formats;
+	u64				pcm_formats;
 	unsigned int			reg_offset_txdata;	/* TX FIFO */
 	const struct regmap_config	*sun4i_i2s_regmap;
 

---
base-commit: 66e4190e92ce0e4a50b2f6be0e5f5b2e47e072f4
change-id: 20240417-sunxi_s32_fix-ef5354b40fb4

Best regards,
-- 
John Watts <contact@jookia.org>



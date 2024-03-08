Return-Path: <linux-kernel+bounces-97265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C318767E5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C779828403E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6015825759;
	Fri,  8 Mar 2024 15:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhBLY3+e"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4342C69B;
	Fri,  8 Mar 2024 15:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709913551; cv=none; b=lKUJeV5egJfJyU8+uZrqy/rNxWul8i/8dxag1Uj937jvGMdL6em8Tnu9qfuyK+72Hhl9dmg5BRoDUhnnvkWLoWD9wl0nINUjEJnLFzZkXE7rSfsGaXKkAtkVoUo5MCDhHDLUBaSCM1gCX8Wl42bjQSKniAx6VkjglPSFBjrW6Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709913551; c=relaxed/simple;
	bh=01oGQVB+1MGpz/WrJ3cNV27KabiNA7KrZZjVMngQZWA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tWRRTwhP2GoxFnPKOR9oKm+zdI8N7/cCAGDeg82Xpyvy6v8E7u4tuSkCW3mPA/QoFAgvtaHgQDBSVlwFDfeyOCOBmExK04ShPLb8U4sXRnkpzatgpJQOHEcivdsHlgartqd62k6jUO/UUS6SQpUk5T9NEvkZJvCQHcxdL8TPn0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YhBLY3+e; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56781070f38so5785402a12.0;
        Fri, 08 Mar 2024 07:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709913548; x=1710518348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKDIZeRYfx/SGJ+xSgTPdf4tZUEttCA5Brs/0km3SyU=;
        b=YhBLY3+eZLbr0Cpx8RP7Qktg9/B1YAb8yIKmFZUOLQeAVbgstKPg3lzLrw82xjpZe+
         cW5GyDkIDQU/WZrNH9ArKOZgcADmfq2pKKt9Gj2X7ttjegOJLaU4GHb1dTmx2sRGtmQu
         N6HMSVZl7j4gRz80Vq3aZxsldGVAR+fDb3naQXYcTn1T2J0BH4Yy6h7Cstc8CDExD7zU
         8zn08qMSr/q1k6IgYF3S+DQ+aN75D7l9ydKYNqNbX3ipozxDFgKan73HwprCK5txqOEh
         i86ZSYzQklYEfPryZGrPME3BNLQG5eYSNO78OGGxJAE1T+mjXQ1/9HV18B346WEPDP0N
         Nxkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709913548; x=1710518348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZKDIZeRYfx/SGJ+xSgTPdf4tZUEttCA5Brs/0km3SyU=;
        b=gim9I2phDg+TD8VxcCrwBv/5pIfAwGpU6VPMhq0TQ7gZKtgHKNqlcWu6Xr1Schy5O0
         ORwsDMB469UDDdW26P6dWGVIwYVjMIxIbECdx49+EEKuBsDKyyK0RYV4q6JG/RKCpsIL
         D+K2Y8VQvv/WewCs9dn43Ehtez2HpSBkVt4oxyNCn/OuHoGgqcuTH3iKkCTqFn22RCjG
         4wS+GKEi7tKUd6LmCus5iDth/2Mn4Am4RCbQd/OekLC7cHr57An7YGzkGC9d7ck9sPbc
         A3qXNzNhcVPGO+f//FxCc94W51jyBMlRJJ6zJGYy9KSvVu/6R2cBVC9OLMdzT6tDeR/w
         KmTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWG1YuKX4edqwVSDV3X1MhBSMbofoYs2WuZgyyNU82KR+T+neRhKbS7Nj+4LgzRjlGFyWii4o5V7KgS660BhU93etUipDQ8E21UVm9uAVeUW63nYGZNT1e31vxkTziqWMD8uWcyCDN+VVU=
X-Gm-Message-State: AOJu0YzKS0CW3Parz8HlfhPyMoIY9ZGE4IkH+wOFWFLzQjfzati8CrXH
	Kcf8V983j39FfoLlbnfqCS/r87XXtAksOQ1v6MsLegIZZTRm0bb1
X-Google-Smtp-Source: AGHT+IG7j4VM9OTI83F9vv3NeCmYvLsZ50mRl/li+QKukju1NUqqGMdsV61ZK7IwoSqaS8DK7JgQPQ==
X-Received: by 2002:a17:907:c308:b0:a45:163a:c08e with SMTP id tl8-20020a170907c30800b00a45163ac08emr849873ejc.0.1709913547854;
        Fri, 08 Mar 2024 07:59:07 -0800 (PST)
Received: from andrejs-nb.int.toradex.com (77-59-154-235.dclient.hispeed.ch. [77.59.154.235])
        by smtp.gmail.com with ESMTPSA id lb7-20020a170906adc700b00a4479997b97sm8494682ejb.66.2024.03.08.07.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 07:59:07 -0800 (PST)
From: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
To: patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Subject: [RFC PATCH v1] ASoC: wm8904: enable fll with fixed mclk
Date: Fri,  8 Mar 2024 16:58:31 +0100
Message-Id: <20240308155831.141229-1-andrejs.cainikovs@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>

Dear all,

This is an attempt to change wm8904 for a scenario when reference clock
supposed to be fixed to a particular frequency, but is not configured as
a fixed-clock. While this change is working fine, I'm struggling to
finalize it, not being able to find a proper solution of adding a check
whether we want to use fixed MCLK with codec's FLL or not. I could, of
course, introduce a new device tree property, but do not feel this would
be a proper way forward. Hence, I'm sending out this RFC patch to gather
your valuable feedback.

DUT: Dahlia carrier board with Verdin TI AM62 SOM.
Audio card configuration can be found in ti/k3-am62-verdin-dahlia.dtsi.

Thanks,
Andrejs.

On systems with a fixed reference clock output rate it
is impossible to use this clock for all audio frequencies.

Following is an example of playing a 44100Hz audio on a system
with a fixed 25MHz reference clock applied to wm8904 codec,
in combination with simple-audio-card without mclk-fs:

[   27.013564] wm8904 1-001a: Target BCLK is 1411200Hz
[   27.013601] wm8904 1-001a: Using 25000000Hz MCLK
[   27.013611] wm8904 1-001a: CLK_SYS is 12500000Hz
[   27.013654] wm8904 1-001a: Selected CLK_SYS_RATIO of 256
[   27.013663] wm8904 1-001a: Selected SAMPLE_RATE of 44100Hz
[   27.013671] wm8904 1-001a: Selected BCLK_DIV of 80 for 1562500Hz BCLK
[   27.013680] wm8904 1-001a: LRCLK_RATE is 35

This leads to a distorted sound and this configuration is unusable.

On the other hand, configuring simple-audio-card with mclk-fs will
force the system to change MCLK frequency, which supposed to be fixed.

This change forces to use wm8904 FLL while keeping SoC's MCLK
frequency intact:

[  234.108149] wm8904 1-001a: Target BCLK is 1411200Hz
[  234.108304] wm8904 1-001a: Using 0Hz FLL clock
[  234.108722] wm8904 1-001a: FLL configured for 25000000Hz->1411200Hz
[  234.108794] wm8904 1-001a: CLK_SYS is 1411200Hz
[  234.108835] wm8904 1-001a: Selected CLK_SYS_RATIO of 64
[  234.108875] wm8904 1-001a: Selected SAMPLE_RATE of 44100Hz
[  234.108913] wm8904 1-001a: Selected BCLK_DIV of 10 for 1411200Hz BCLK
[  234.108955] wm8904 1-001a: LRCLK_RATE is 32

Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
---
 sound/soc/codecs/wm8904.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index 829bf055622a7..033ef1d67ac50 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -311,10 +311,17 @@ static bool wm8904_readable_register(struct device *dev, unsigned int reg)
 	}
 }
 
-static int wm8904_configure_clocking(struct snd_soc_component *component)
+/* Forward declaration */
+static int wm8904_set_fll(struct snd_soc_dai *dai, int fll_id, int source,
+			  unsigned int Fref, unsigned int Fout);
+
+static int wm8904_configure_clocking(struct snd_soc_dai *dai)
 {
+	struct snd_soc_component *component = dai->component;
 	struct wm8904_priv *wm8904 = snd_soc_component_get_drvdata(component);
 	unsigned int clock0, clock2, rate;
+	unsigned long mclk_freq;
+	int ret;
 
 	/* Gate the clock while we're updating to avoid misclocking */
 	clock2 = snd_soc_component_read(component, WM8904_CLOCK_RATES_2);
@@ -338,6 +345,14 @@ static int wm8904_configure_clocking(struct snd_soc_component *component)
 		dev_dbg(component->dev, "Using %dHz FLL clock\n",
 			wm8904->fll_fout);
 
+		mclk_freq = clk_get_rate(wm8904->mclk);
+		ret = wm8904_set_fll(dai, WM8904_FLL_MCLK, WM8904_FLL_MCLK,
+				     mclk_freq, wm8904->bclk);
+		if (ret) {
+			dev_err(component->dev, "Could not configure FLL\n");
+			return ret;
+		}
+
 		clock2 |= WM8904_SYSCLK_SRC;
 		rate = wm8904->fll_fout;
 		break;
@@ -1334,7 +1349,7 @@ static int wm8904_hw_params(struct snd_pcm_substream *substream,
 
 	dev_dbg(component->dev, "Target BCLK is %dHz\n", wm8904->bclk);
 
-	ret = wm8904_configure_clocking(component);
+	ret = wm8904_configure_clocking(dai);
 	if (ret != 0)
 		return ret;
 
@@ -1809,7 +1824,6 @@ static int wm8904_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 	struct snd_soc_component *component = dai->component;
 	struct wm8904_priv *priv = snd_soc_component_get_drvdata(component);
 	unsigned long mclk_freq;
-	int ret;
 
 	switch (clk_id) {
 	case WM8904_CLK_AUTO:
@@ -1820,17 +1834,11 @@ static int wm8904_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 			return 0;
 
 		mclk_freq = clk_get_rate(priv->mclk);
-		/* enable FLL if a different sysclk is desired */
-		if (mclk_freq != freq) {
-			priv->sysclk_src = WM8904_CLK_FLL;
-			ret = wm8904_set_fll(dai, WM8904_FLL_MCLK,
-					     WM8904_FLL_MCLK,
-					     mclk_freq, freq);
-			if (ret)
-				return ret;
-			break;
-		}
-		clk_id = WM8904_CLK_MCLK;
+		/* TODO: add a check to force fll with fixed mclk */
+		if (mclk_freq != freq || 1)
+			clk_id = WM8904_CLK_FLL;
+		else
+			clk_id = WM8904_CLK_MCLK;
 		fallthrough;
 
 	case WM8904_CLK_MCLK:
@@ -1848,7 +1856,7 @@ static int wm8904_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 
 	dev_dbg(dai->dev, "Clock source is %d at %uHz\n", clk_id, freq);
 
-	wm8904_configure_clocking(component);
+	wm8904_configure_clocking(dai);
 
 	return 0;
 }
-- 
2.34.1



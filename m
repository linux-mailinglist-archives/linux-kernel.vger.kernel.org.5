Return-Path: <linux-kernel+bounces-92521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A950D872193
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96F341C216E0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147B3126F14;
	Tue,  5 Mar 2024 14:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gxBn1uoi"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D015C609;
	Tue,  5 Mar 2024 14:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709649421; cv=none; b=P/gmZce7qt8pXOxWW/mDKMWPQHNsqxy5oejp3AFALipEabJe+SSrimOSnwcYEpyT80rVee7wEw7wqVdgnznkjsqGorru27E/6aBSSnOhGZmBkJhGdjyY3Fx8IR1y7qE0S+YpxCDjKict20YkzY0KAL9Qa3oDvT05+9g+MqQNt0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709649421; c=relaxed/simple;
	bh=rygfSMNziCOfzvDFvMeSWfA75j2/LCnrOAvQOQUzqg4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FdBHj05LsbIotAYnBQ6fF6VXVETf0EUg6EHm2cFzAPnW5EjVvuPtVmwVdnOYv/kQAulW0AOBVCwz8iBqULjcPWKhnpEn03pFhE75WFAUvUJsYXQoZoIfVpPZbFvtR1w8CDdarlbV9/7VPYVKYxOD0CV0ubRQmWtD01ik6iWoNKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gxBn1uoi; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7E5DCC000A;
	Tue,  5 Mar 2024 14:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709649416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m8TjScZjVydSWcpu/RN3oleW3uv9eLcKokpPK/smbvU=;
	b=gxBn1uoiqLj+gbz5NIk+Wq2LNJhuo5frpNQ90SkOuPhlxfbvMv16davepw2fv+6IL8SlCS
	M1JhLvYTwvImXp+OEM873aTR/7+gQMypXFYrGRS9/E2B+SAKyV94dCNcX3nwnRBBG+Ftg/
	5hNj/zdgl2n7sjbrMEW/+/+3zfYXz/Xv2niZuE3RRXpoPhSRSXYtmtvWvVcMuxm0dP+4V2
	r88msCe418+mWqxbrcb6aKe93INopDY0nSZgRhxaV9jLmMlI985TzV33MzUAdb8U+7AKaz
	qOqtxlbEWfmgkSIlWkMCvEAcjevzD8i5HB4aKsEKLgU/1ZAZHhJD8XjpZERwzQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 05 Mar 2024 15:36:28 +0100
Subject: [PATCH v4 1/7] ASoC: rockchip: i2s-tdm: Fix inaccurate sampling
 rates
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-rk3308-audio-codec-v4-1-312acdbe628f@bootlin.com>
References: <20240305-rk3308-audio-codec-v4-0-312acdbe628f@bootlin.com>
In-Reply-To: <20240305-rk3308-audio-codec-v4-0-312acdbe628f@bootlin.com>
To: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-rockchip@lists.infradead.org, linux-sound@vger.kernel.org, 
 alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: luca.ceresoli@bootlin.com

The sample rates set by the rockchip_i2s_tdm driver in master mode are
inaccurate up to 5% in several cases, due to the driver logic to configure
clocks and a nasty interaction with the Common Clock Framework.

To understand what happens, here is the relevant section of the clock tree
(slightly simplified), along with the names used in the driver:

       vpll0 _OR_ vpll1               "mclk_root"
          clk_i2s2_8ch_tx_src         "mclk_parent"
             clk_i2s2_8ch_tx_mux
                clk_i2s2_8ch_tx       "mclk" or "mclk_tx"

This is what happens when playing back e.g. at 192 kHz using
audio-graph-card (when recording the same applies, only s/tx/rx/):

 0. at probe, rockchip_i2s_tdm_set_sysclk() stores the passed frequency in
    i2s_tdm->mclk_tx_freq (*) which is 50176000, and that is never modified
    afterwards

 1. when playback is started, rockchip_i2s_tdm_hw_params() is called and
    does the following two calls

 2. rockchip_i2s_tdm_calibrate_mclk():

    2a. selects mclk_root0 (vpll0) as a parent for mclk_parent
        (mclk_tx_src), which is OK because the vpll0 rate is a good for
        192000 (and sumbultiple) rates

    2b. sets the mclk_root frequency based on ppm calibration computations

    2c. sets mclk_tx_src to 49152000 (= 256 * 192000), which is also OK as
        it is a multiple of the required bit clock

 3. rockchip_i2s_tdm_set_mclk()

    3a. calls clk_set_rate() to set the rate of mclk_tx (clk_i2s2_8ch_tx)
        to the value of i2s_tdm->mclk_tx_freq (*), i.e. 50176000 which is
        not a multiple of the sampling frequency -- this is not OK

        3a1. clk_set_rate() reacts by reparenting clk_i2s2_8ch_tx_src to
             vpll1 -- this is not OK because the default vpll1 rate can be
	     divided to get 44.1 kHz and related rates, not 192 kHz

The result is that the driver does a lot of ad-hoc decisions about clocks
and ends up in using the wrong parent at an unoptimal rate.

Step 0 is one part of the problem: unless the card driver calls set_sysclk
at each stream start, whatever rate is set in mclk_tx_freq during boot will
be taken and used until reboot. Moreover the driver does not care if its
value is not a multiple of any audio frequency.

Another part of the problem is that the whole reparenting and clock rate
setting logic is conflicting with the CCF algorithms to achieve largely the
same goal: selecting the best parent and setting the closest clock
rate. And it turns out that only calling once clk_set_rate() on
clk_i2s2_8ch_tx picks the correct vpll and sets the correct rate.

The fix is based on removing the custom logic in the driver to select the
parent and set the various clocks, and just let the Clock Framework do it
all. As a side effect, the set_sysclk() op becomes useless because we now
let the CCF compute the appropriate value for the sampling rate.  It also
implies that the whole calibration logic is now dead code and so it is
removed along with the "PCM Clock Compensation in PPM" kcontrol, which has
always been broken anyway. The handling of the 4 optional clocks also
becomes dead code and is removed.

The actual rates have been tested playing 30 seconds of audio at various
sampling rates before and after this change using sox:

    time play -r <sample_rate> -n synth 30 sine 950 gain -3

The time reported in the table below is the 'real' value reported by the
'time' command in the above command line.

     rate        before     after
   ---------     ------     ------
     8000 Hz     30.60s     30.63s
    11025 Hz     30.45s     30.51s
    16000 Hz     30.47s     30.50s
    22050 Hz     30.78s     30.41s
    32000 Hz     31.02s     30.43s
    44100 Hz     30.78s     30.41s
    48000 Hz     29.81s     30.45s
    88200 Hz     30.78s     30.41s
    96000 Hz     29.79s     30.42s
   176400 Hz     27.40s     30.41s
   192000 Hz     29.79s     30.42s

While the tests are running the clock tree confirms that:

 * without the patch, vpll1 is always used and clk_i2s2_8ch_tx always
   produces 50176000 Hz, which cannot be divided for most audio rates
   except the slowest ones, generating inaccurate rates
 * with the patch:
   - for 192000 Hz vpll0 is used
   - for 176400 Hz vpll1 is used
   - clk_i2s2_8ch_tx always produces (256 * <rate>) Hz

Tested on the RK3308 using the internal audio codec.

Fixes: 081068fd6414 ("ASoC: rockchip: add support for i2s-tdm controller")
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

As discussed after v3, the clock manipulation logic that this patch removes
is a remnant of the downstream 4.19 driver
(https://github.com/rockchip-linux/kernel/blob/develop-4.19/sound/soc/rockchip/rockchip_i2s_tdm.c).
It might be that the CCF was not yet capable of optimally reparenting back
in 4.19, so it did make sense back then.

Changed in v4:
 - Mention the tested hardware in the commit message
 - No content changes

Changed in v3:
 - this patch is new in v3, and it replaces and supersedes the patch "ASoC:
   rockchip: i2s-tdm: Fix clk_id usage in .set_sysclk()"
---
 sound/soc/rockchip/rockchip_i2s_tdm.c | 352 +---------------------------------
 1 file changed, 6 insertions(+), 346 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s_tdm.c b/sound/soc/rockchip/rockchip_i2s_tdm.c
index 860e66ec85e8..9fa020ef7eab 100644
--- a/sound/soc/rockchip/rockchip_i2s_tdm.c
+++ b/sound/soc/rockchip/rockchip_i2s_tdm.c
@@ -25,8 +25,6 @@
 #define DEFAULT_MCLK_FS				256
 #define CH_GRP_MAX				4  /* The max channel 8 / 2 */
 #define MULTIPLEX_CH_MAX			10
-#define CLK_PPM_MIN				-1000
-#define CLK_PPM_MAX				1000
 
 #define TRCM_TXRX 0
 #define TRCM_TX 1
@@ -53,20 +51,6 @@ struct rk_i2s_tdm_dev {
 	struct clk *hclk;
 	struct clk *mclk_tx;
 	struct clk *mclk_rx;
-	/* The mclk_tx_src is parent of mclk_tx */
-	struct clk *mclk_tx_src;
-	/* The mclk_rx_src is parent of mclk_rx */
-	struct clk *mclk_rx_src;
-	/*
-	 * The mclk_root0 and mclk_root1 are root parent and supplies for
-	 * the different FS.
-	 *
-	 * e.g:
-	 * mclk_root0 is VPLL0, used for FS=48000Hz
-	 * mclk_root1 is VPLL1, used for FS=44100Hz
-	 */
-	struct clk *mclk_root0;
-	struct clk *mclk_root1;
 	struct regmap *regmap;
 	struct regmap *grf;
 	struct snd_dmaengine_dai_dma_data capture_dma_data;
@@ -76,19 +60,11 @@ struct rk_i2s_tdm_dev {
 	const struct rk_i2s_soc_data *soc_data;
 	bool is_master_mode;
 	bool io_multiplex;
-	bool mclk_calibrate;
 	bool tdm_mode;
-	unsigned int mclk_rx_freq;
-	unsigned int mclk_tx_freq;
-	unsigned int mclk_root0_freq;
-	unsigned int mclk_root1_freq;
-	unsigned int mclk_root0_initial_freq;
-	unsigned int mclk_root1_initial_freq;
 	unsigned int frame_width;
 	unsigned int clk_trcm;
 	unsigned int i2s_sdis[CH_GRP_MAX];
 	unsigned int i2s_sdos[CH_GRP_MAX];
-	int clk_ppm;
 	int refcount;
 	spinlock_t lock; /* xfer lock */
 	bool has_playback;
@@ -114,12 +90,6 @@ static void i2s_tdm_disable_unprepare_mclk(struct rk_i2s_tdm_dev *i2s_tdm)
 {
 	clk_disable_unprepare(i2s_tdm->mclk_tx);
 	clk_disable_unprepare(i2s_tdm->mclk_rx);
-	if (i2s_tdm->mclk_calibrate) {
-		clk_disable_unprepare(i2s_tdm->mclk_tx_src);
-		clk_disable_unprepare(i2s_tdm->mclk_rx_src);
-		clk_disable_unprepare(i2s_tdm->mclk_root0);
-		clk_disable_unprepare(i2s_tdm->mclk_root1);
-	}
 }
 
 /**
@@ -142,29 +112,9 @@ static int i2s_tdm_prepare_enable_mclk(struct rk_i2s_tdm_dev *i2s_tdm)
 	ret = clk_prepare_enable(i2s_tdm->mclk_rx);
 	if (ret)
 		goto err_mclk_rx;
-	if (i2s_tdm->mclk_calibrate) {
-		ret = clk_prepare_enable(i2s_tdm->mclk_tx_src);
-		if (ret)
-			goto err_mclk_rx;
-		ret = clk_prepare_enable(i2s_tdm->mclk_rx_src);
-		if (ret)
-			goto err_mclk_rx_src;
-		ret = clk_prepare_enable(i2s_tdm->mclk_root0);
-		if (ret)
-			goto err_mclk_root0;
-		ret = clk_prepare_enable(i2s_tdm->mclk_root1);
-		if (ret)
-			goto err_mclk_root1;
-	}
 
 	return 0;
 
-err_mclk_root1:
-	clk_disable_unprepare(i2s_tdm->mclk_root0);
-err_mclk_root0:
-	clk_disable_unprepare(i2s_tdm->mclk_rx_src);
-err_mclk_rx_src:
-	clk_disable_unprepare(i2s_tdm->mclk_tx_src);
 err_mclk_rx:
 	clk_disable_unprepare(i2s_tdm->mclk_tx);
 err_mclk_tx:
@@ -564,159 +514,6 @@ static void rockchip_i2s_tdm_xfer_resume(struct snd_pcm_substream *substream,
 			   I2S_XFER_RXS_START);
 }
 
-static int rockchip_i2s_tdm_clk_set_rate(struct rk_i2s_tdm_dev *i2s_tdm,
-					 struct clk *clk, unsigned long rate,
-					 int ppm)
-{
-	unsigned long rate_target;
-	int delta, ret;
-
-	if (ppm == i2s_tdm->clk_ppm)
-		return 0;
-
-	if (ppm < 0)
-		delta = -1;
-	else
-		delta = 1;
-
-	delta *= (int)div64_u64((u64)rate * (u64)abs(ppm) + 500000,
-				1000000);
-
-	rate_target = rate + delta;
-
-	if (!rate_target)
-		return -EINVAL;
-
-	ret = clk_set_rate(clk, rate_target);
-	if (ret)
-		return ret;
-
-	i2s_tdm->clk_ppm = ppm;
-
-	return 0;
-}
-
-static int rockchip_i2s_tdm_calibrate_mclk(struct rk_i2s_tdm_dev *i2s_tdm,
-					   struct snd_pcm_substream *substream,
-					   unsigned int lrck_freq)
-{
-	struct clk *mclk_root;
-	struct clk *mclk_parent;
-	unsigned int mclk_root_freq;
-	unsigned int mclk_root_initial_freq;
-	unsigned int mclk_parent_freq;
-	unsigned int div, delta;
-	u64 ppm;
-	int ret;
-
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		mclk_parent = i2s_tdm->mclk_tx_src;
-	else
-		mclk_parent = i2s_tdm->mclk_rx_src;
-
-	switch (lrck_freq) {
-	case 8000:
-	case 16000:
-	case 24000:
-	case 32000:
-	case 48000:
-	case 64000:
-	case 96000:
-	case 192000:
-		mclk_root = i2s_tdm->mclk_root0;
-		mclk_root_freq = i2s_tdm->mclk_root0_freq;
-		mclk_root_initial_freq = i2s_tdm->mclk_root0_initial_freq;
-		mclk_parent_freq = DEFAULT_MCLK_FS * 192000;
-		break;
-	case 11025:
-	case 22050:
-	case 44100:
-	case 88200:
-	case 176400:
-		mclk_root = i2s_tdm->mclk_root1;
-		mclk_root_freq = i2s_tdm->mclk_root1_freq;
-		mclk_root_initial_freq = i2s_tdm->mclk_root1_initial_freq;
-		mclk_parent_freq = DEFAULT_MCLK_FS * 176400;
-		break;
-	default:
-		dev_err(i2s_tdm->dev, "Invalid LRCK frequency: %u Hz\n",
-			lrck_freq);
-		return -EINVAL;
-	}
-
-	ret = clk_set_parent(mclk_parent, mclk_root);
-	if (ret)
-		return ret;
-
-	ret = rockchip_i2s_tdm_clk_set_rate(i2s_tdm, mclk_root,
-					    mclk_root_freq, 0);
-	if (ret)
-		return ret;
-
-	delta = abs(mclk_root_freq % mclk_parent_freq - mclk_parent_freq);
-	ppm = div64_u64((uint64_t)delta * 1000000, (uint64_t)mclk_root_freq);
-
-	if (ppm) {
-		div = DIV_ROUND_CLOSEST(mclk_root_initial_freq, mclk_parent_freq);
-		if (!div)
-			return -EINVAL;
-
-		mclk_root_freq = mclk_parent_freq * round_up(div, 2);
-
-		ret = clk_set_rate(mclk_root, mclk_root_freq);
-		if (ret)
-			return ret;
-
-		i2s_tdm->mclk_root0_freq = clk_get_rate(i2s_tdm->mclk_root0);
-		i2s_tdm->mclk_root1_freq = clk_get_rate(i2s_tdm->mclk_root1);
-	}
-
-	return clk_set_rate(mclk_parent, mclk_parent_freq);
-}
-
-static int rockchip_i2s_tdm_set_mclk(struct rk_i2s_tdm_dev *i2s_tdm,
-				     struct snd_pcm_substream *substream,
-				     struct clk **mclk)
-{
-	unsigned int mclk_freq;
-	int ret;
-
-	if (i2s_tdm->clk_trcm) {
-		if (i2s_tdm->mclk_tx_freq != i2s_tdm->mclk_rx_freq) {
-			dev_err(i2s_tdm->dev,
-				"clk_trcm, tx: %d and rx: %d should be the same\n",
-				i2s_tdm->mclk_tx_freq,
-				i2s_tdm->mclk_rx_freq);
-			return -EINVAL;
-		}
-
-		ret = clk_set_rate(i2s_tdm->mclk_tx, i2s_tdm->mclk_tx_freq);
-		if (ret)
-			return ret;
-
-		ret = clk_set_rate(i2s_tdm->mclk_rx, i2s_tdm->mclk_rx_freq);
-		if (ret)
-			return ret;
-
-		/* mclk_rx is also ok. */
-		*mclk = i2s_tdm->mclk_tx;
-	} else {
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-			*mclk = i2s_tdm->mclk_tx;
-			mclk_freq = i2s_tdm->mclk_tx_freq;
-		} else {
-			*mclk = i2s_tdm->mclk_rx;
-			mclk_freq = i2s_tdm->mclk_rx_freq;
-		}
-
-		ret = clk_set_rate(*mclk, mclk_freq);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
 static int rockchip_i2s_ch_to_io(unsigned int ch, bool substream_capture)
 {
 	if (substream_capture) {
@@ -853,19 +650,17 @@ static int rockchip_i2s_tdm_hw_params(struct snd_pcm_substream *substream,
 				      struct snd_soc_dai *dai)
 {
 	struct rk_i2s_tdm_dev *i2s_tdm = to_info(dai);
-	struct clk *mclk;
-	int ret = 0;
 	unsigned int val = 0;
 	unsigned int mclk_rate, bclk_rate, div_bclk = 4, div_lrck = 64;
+	int err;
 
 	if (i2s_tdm->is_master_mode) {
-		if (i2s_tdm->mclk_calibrate)
-			rockchip_i2s_tdm_calibrate_mclk(i2s_tdm, substream,
-							params_rate(params));
+		struct clk *mclk = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
+			i2s_tdm->mclk_tx : i2s_tdm->mclk_rx;
 
-		ret = rockchip_i2s_tdm_set_mclk(i2s_tdm, substream, &mclk);
-		if (ret)
-			return ret;
+		err = clk_set_rate(mclk, DEFAULT_MCLK_FS * params_rate(params));
+		if (err)
+			return err;
 
 		mclk_rate = clk_get_rate(mclk);
 		bclk_rate = i2s_tdm->frame_width * params_rate(params);
@@ -973,96 +768,6 @@ static int rockchip_i2s_tdm_trigger(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int rockchip_i2s_tdm_set_sysclk(struct snd_soc_dai *cpu_dai, int stream,
-				       unsigned int freq, int dir)
-{
-	struct rk_i2s_tdm_dev *i2s_tdm = to_info(cpu_dai);
-
-	/* Put set mclk rate into rockchip_i2s_tdm_set_mclk() */
-	if (i2s_tdm->clk_trcm) {
-		i2s_tdm->mclk_tx_freq = freq;
-		i2s_tdm->mclk_rx_freq = freq;
-	} else {
-		if (stream == SNDRV_PCM_STREAM_PLAYBACK)
-			i2s_tdm->mclk_tx_freq = freq;
-		else
-			i2s_tdm->mclk_rx_freq = freq;
-	}
-
-	dev_dbg(i2s_tdm->dev, "The target mclk_%s freq is: %d\n",
-		stream ? "rx" : "tx", freq);
-
-	return 0;
-}
-
-static int rockchip_i2s_tdm_clk_compensation_info(struct snd_kcontrol *kcontrol,
-						  struct snd_ctl_elem_info *uinfo)
-{
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
-	uinfo->count = 1;
-	uinfo->value.integer.min = CLK_PPM_MIN;
-	uinfo->value.integer.max = CLK_PPM_MAX;
-	uinfo->value.integer.step = 1;
-
-	return 0;
-}
-
-static int rockchip_i2s_tdm_clk_compensation_get(struct snd_kcontrol *kcontrol,
-						 struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_soc_dai *dai = snd_kcontrol_chip(kcontrol);
-	struct rk_i2s_tdm_dev *i2s_tdm = snd_soc_dai_get_drvdata(dai);
-
-	ucontrol->value.integer.value[0] = i2s_tdm->clk_ppm;
-
-	return 0;
-}
-
-static int rockchip_i2s_tdm_clk_compensation_put(struct snd_kcontrol *kcontrol,
-						 struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_soc_dai *dai = snd_kcontrol_chip(kcontrol);
-	struct rk_i2s_tdm_dev *i2s_tdm = snd_soc_dai_get_drvdata(dai);
-	int ret = 0, ppm = 0;
-	int changed = 0;
-	unsigned long old_rate;
-
-	if (ucontrol->value.integer.value[0] < CLK_PPM_MIN ||
-	    ucontrol->value.integer.value[0] > CLK_PPM_MAX)
-		return -EINVAL;
-
-	ppm = ucontrol->value.integer.value[0];
-
-	old_rate = clk_get_rate(i2s_tdm->mclk_root0);
-	ret = rockchip_i2s_tdm_clk_set_rate(i2s_tdm, i2s_tdm->mclk_root0,
-					    i2s_tdm->mclk_root0_freq, ppm);
-	if (ret)
-		return ret;
-	if (old_rate != clk_get_rate(i2s_tdm->mclk_root0))
-		changed = 1;
-
-	if (clk_is_match(i2s_tdm->mclk_root0, i2s_tdm->mclk_root1))
-		return changed;
-
-	old_rate = clk_get_rate(i2s_tdm->mclk_root1);
-	ret = rockchip_i2s_tdm_clk_set_rate(i2s_tdm, i2s_tdm->mclk_root1,
-					    i2s_tdm->mclk_root1_freq, ppm);
-	if (ret)
-		return ret;
-	if (old_rate != clk_get_rate(i2s_tdm->mclk_root1))
-		changed = 1;
-
-	return changed;
-}
-
-static struct snd_kcontrol_new rockchip_i2s_tdm_compensation_control = {
-	.iface = SNDRV_CTL_ELEM_IFACE_PCM,
-	.name = "PCM Clock Compensation in PPM",
-	.info = rockchip_i2s_tdm_clk_compensation_info,
-	.get = rockchip_i2s_tdm_clk_compensation_get,
-	.put = rockchip_i2s_tdm_clk_compensation_put,
-};
-
 static int rockchip_i2s_tdm_dai_probe(struct snd_soc_dai *dai)
 {
 	struct rk_i2s_tdm_dev *i2s_tdm = snd_soc_dai_get_drvdata(dai);
@@ -1072,9 +777,6 @@ static int rockchip_i2s_tdm_dai_probe(struct snd_soc_dai *dai)
 	if (i2s_tdm->has_playback)
 		snd_soc_dai_dma_data_set_playback(dai, &i2s_tdm->playback_dma_data);
 
-	if (i2s_tdm->mclk_calibrate)
-		snd_soc_add_dai_controls(dai, &rockchip_i2s_tdm_compensation_control, 1);
-
 	return 0;
 }
 
@@ -1115,7 +817,6 @@ static const struct snd_soc_dai_ops rockchip_i2s_tdm_dai_ops = {
 	.probe = rockchip_i2s_tdm_dai_probe,
 	.hw_params = rockchip_i2s_tdm_hw_params,
 	.set_bclk_ratio	= rockchip_i2s_tdm_set_bclk_ratio,
-	.set_sysclk = rockchip_i2s_tdm_set_sysclk,
 	.set_fmt = rockchip_i2s_tdm_set_fmt,
 	.set_tdm_slot = rockchip_dai_tdm_slot,
 	.trigger = rockchip_i2s_tdm_trigger,
@@ -1444,35 +1145,6 @@ static void rockchip_i2s_tdm_path_config(struct rk_i2s_tdm_dev *i2s_tdm,
 		rockchip_i2s_tdm_tx_path_config(i2s_tdm, num);
 }
 
-static int rockchip_i2s_tdm_get_calibrate_mclks(struct rk_i2s_tdm_dev *i2s_tdm)
-{
-	int num_mclks = 0;
-
-	i2s_tdm->mclk_tx_src = devm_clk_get(i2s_tdm->dev, "mclk_tx_src");
-	if (!IS_ERR(i2s_tdm->mclk_tx_src))
-		num_mclks++;
-
-	i2s_tdm->mclk_rx_src = devm_clk_get(i2s_tdm->dev, "mclk_rx_src");
-	if (!IS_ERR(i2s_tdm->mclk_rx_src))
-		num_mclks++;
-
-	i2s_tdm->mclk_root0 = devm_clk_get(i2s_tdm->dev, "mclk_root0");
-	if (!IS_ERR(i2s_tdm->mclk_root0))
-		num_mclks++;
-
-	i2s_tdm->mclk_root1 = devm_clk_get(i2s_tdm->dev, "mclk_root1");
-	if (!IS_ERR(i2s_tdm->mclk_root1))
-		num_mclks++;
-
-	if (num_mclks < 4 && num_mclks != 0)
-		return -ENOENT;
-
-	if (num_mclks == 4)
-		i2s_tdm->mclk_calibrate = 1;
-
-	return 0;
-}
-
 static int rockchip_i2s_tdm_path_prepare(struct rk_i2s_tdm_dev *i2s_tdm,
 					 struct device_node *np,
 					 bool is_rx_path)
@@ -1610,11 +1282,6 @@ static int rockchip_i2s_tdm_probe(struct platform_device *pdev)
 	i2s_tdm->io_multiplex =
 		of_property_read_bool(node, "rockchip,io-multiplex");
 
-	ret = rockchip_i2s_tdm_get_calibrate_mclks(i2s_tdm);
-	if (ret)
-		return dev_err_probe(i2s_tdm->dev, ret,
-				     "mclk-calibrate clocks missing");
-
 	regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(regs)) {
 		return dev_err_probe(i2s_tdm->dev, PTR_ERR(regs),
@@ -1667,13 +1334,6 @@ static int rockchip_i2s_tdm_probe(struct platform_device *pdev)
 		goto err_disable_hclk;
 	}
 
-	if (i2s_tdm->mclk_calibrate) {
-		i2s_tdm->mclk_root0_initial_freq = clk_get_rate(i2s_tdm->mclk_root0);
-		i2s_tdm->mclk_root1_initial_freq = clk_get_rate(i2s_tdm->mclk_root1);
-		i2s_tdm->mclk_root0_freq = i2s_tdm->mclk_root0_initial_freq;
-		i2s_tdm->mclk_root1_freq = i2s_tdm->mclk_root1_initial_freq;
-	}
-
 	pm_runtime_enable(&pdev->dev);
 
 	regmap_update_bits(i2s_tdm->regmap, I2S_DMACR, I2S_DMACR_TDL_MASK,

-- 
2.34.1



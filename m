Return-Path: <linux-kernel+bounces-17919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 558DC82551E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7E5E285908
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A642DF83;
	Fri,  5 Jan 2024 14:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="AJrqeiCZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF272D7AB;
	Fri,  5 Jan 2024 14:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 405CoImA010379;
	Fri, 5 Jan 2024 08:25:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=PODMain02222019; bh=ZumaiG3tWqCqKwL
	m2w2GskBu2Je61hqPZwFOilMwiIA=; b=AJrqeiCZvg6cBzkMrbWsGf4ZYzTxpLR
	Aqqpkg+Y+XMxRBryAoyhNeP3dJIZezjOO0zGkvMntEV4AE9QzlSXzutTfl/n/AlQ
	mttMcDrp0lmUASW0Oot3Yb/uYurB770O90FVhmF0+Ve6fBWosb7J7zsmXUziqiQj
	I/Ht8LhH7UKwbWFXJY5Xzuq83aRfIXh5bRM+txI8Eu3XyAXQtsOhk6H2Qdr0Su9m
	csHPRXIiVPgtaSzaCjickhZKe9Yno/hIHhWjiPyxS0JFmXuDnWTg8GgLwG9Ymxfm
	7fieelw/d4XkZvfyXUGMpPny5j3JidLzVqzDYrKVpKxkPOlLP2MKDcg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3ve9e8gnu1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jan 2024 08:25:16 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 5 Jan
 2024 14:25:13 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Fri, 5 Jan 2024 14:24:58 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A6473468;
	Fri,  5 Jan 2024 14:24:58 +0000 (UTC)
Date: Fri, 5 Jan 2024 14:24:58 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: James Ogletree <jogletre@opensource.cirrus.com>
CC: James Ogletree <james.ogletree@cirrus.com>,
        Fred Treven
	<fred.treven@cirrus.com>,
        Ben Bright <ben.bright@cirrus.com>,
        Dmitry Torokhov
	<dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>,
        Lee Jones <lee@kernel.org>, "Liam
 Girdwood" <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, "Jaroslav
 Kysela" <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        James Schulman
	<james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        "Jacky
 Bai" <ping.bai@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jeff LaBundy <jeff@labundy.com>,
        Sebastian Reichel
	<sebastian.reichel@collabora.com>,
        Peng Fan <peng.fan@nxp.com>, Weidong Wang
	<wangweidong.a@awinic.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Herve Codina
	<herve.codina@bootlin.com>,
        Shuming Fan <shumingf@realtek.com>,
        Shenghao Ding
	<13916275206@139.com>, Ryan Lee <ryans.lee@analog.com>,
        Linus Walleij
	<linus.walleij@linaro.org>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        "open
 list:CIRRUS LOGIC HAPTIC DRIVERS" <patches@opensource.cirrus.com>,
        "open
 list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..."
	<linux-input@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE
 TREE BINDINGS" <devicetree@vger.kernel.org>,
        open list
	<linux-kernel@vger.kernel.org>,
        "open list:SOUND - SOC LAYER / DYNAMIC AUDIO
 POWER MANAGEM..." <linux-sound@vger.kernel.org>,
        "moderated list:CIRRUS LOGIC
 AUDIO CODEC DRIVERS" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v5 5/5] ASoC: cs40l50: Support I2S streaming to CS40L50
Message-ID: <20240105142458.GH14858@ediswmail.ad.cirrus.com>
References: <20240104223643.876292-1-jogletre@opensource.cirrus.com>
 <20240104223643.876292-6-jogletre@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240104223643.876292-6-jogletre@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: 0hqQg34txAQs78OTUD5wUFCbmWzwicQt
X-Proofpoint-ORIG-GUID: 0hqQg34txAQs78OTUD5wUFCbmWzwicQt
X-Proofpoint-Spam-Reason: safe

On Thu, Jan 04, 2024 at 10:36:38PM +0000, James Ogletree wrote:
> Introduce support for Cirrus Logic Device CS40L50: a
> haptic driver with waveform memory, integrated DSP,
> and closed-loop algorithms.
> 
> The ASoC driver enables I2S streaming to the device.
> 
> Signed-off-by: James Ogletree <jogletre@opensource.cirrus.com>
> ---
> +#include <linux/mfd/cs40l50.h>
> +#include <linux/pm_runtime.h>
> +#include <sound/pcm_params.h>
> +#include <sound/soc.h>

Need to also include bitfield.h for FIELD_PREP etc.

> +static int cs40l50_clk_en(struct snd_soc_dapm_widget *w,
> +			  struct snd_kcontrol *kcontrol,
> +			  int event)
> +{
> +	struct snd_soc_component *comp = snd_soc_dapm_to_component(w->dapm);
> +	struct cs40l50_codec *codec = snd_soc_component_get_drvdata(comp);
> +	int ret;
> +
> +	switch (event) {
> +	case SND_SOC_DAPM_POST_PMU:
> +		ret = regmap_write(codec->regmap, CS40L50_DSP_QUEUE, CS40L50_STOP_PLAYBACK);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_write(codec->regmap, CS40L50_DSP_QUEUE, CS40L50_START_I2S);
> +		if (ret)
> +			return ret;
> +

Feels weird that we don't wait for these two commands to be
acknowledged by the DSP before doing the clock swap. Is that
intentional? Is the DSP just guaranteed to be so fast it doesn't
matter, in which case a comment would be nice.

> +static int cs40l50_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
> +{
> +	struct cs40l50_codec *codec = snd_soc_component_get_drvdata(codec_dai->component);
> +
> +	if ((fmt & SND_SOC_DAIFMT_MASTER_MASK) != SND_SOC_DAIFMT_CBS_CFS)
> +		return -EINVAL;
> +
> +	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
> +	case SND_SOC_DAIFMT_NB_NF:
> +		codec->daifmt = 0;
> +		break;
> +	case SND_SOC_DAIFMT_NB_IF:
> +		codec->daifmt = CS40L50_ASP_FSYNC_INV_MASK;
> +		break;
> +	case SND_SOC_DAIFMT_IB_NF:
> +		codec->daifmt = CS40L50_ASP_BCLK_INV_MASK;
> +		break;
> +	case SND_SOC_DAIFMT_IB_IF:
> +		codec->daifmt = CS40L50_ASP_FSYNC_INV_MASK | CS40L50_ASP_BCLK_INV_MASK;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if ((fmt & SND_SOC_DAIFMT_FORMAT_MASK) == SND_SOC_DAIFMT_I2S)
> +		codec->daifmt |= FIELD_PREP(CS40L50_ASP_FMT_MASK, CS40L50_ASP_FMT_I2S);

It feels unlikely the chip supports all formats with no
additional settings? Probably should have a switch for the
supported formats and return an error.

> +static struct snd_soc_dai_driver cs40l50_dai[] = {
> +	{
> +		.name = "cs40l50-pcm",
> +		.id = 0,
> +		.playback = {
> +			.stream_name = "ASP Playback",
> +			.channels_min = 1,
> +			.channels_max = 2,
> +			.rates = SNDRV_PCM_RATE_48000,
> +			.formats = CS40L50_FORMATS,
> +		},
> +		.ops = &cs40l50_dai_ops,
> +		.symmetric_rate = 1,

The symmetric_rate feels a bit redundant since we only have
playback supported.

Thanks,
Charles


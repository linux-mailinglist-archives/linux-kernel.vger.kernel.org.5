Return-Path: <linux-kernel+bounces-121345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B5888E675
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 130B62931B5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7632C156899;
	Wed, 27 Mar 2024 13:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t8BiU5MV"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC4515689C
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 13:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711545005; cv=none; b=Iwu6dss6mn3QsZ+d2z+maqHTEjuAIUWSU8F1IuPW49P7ikDwfer6ea0xEGI6JgfHiBUQQppSUmOhxM69O+feVgZqap2goSEFdsbiht9IPZdaHdrUwaor6xwneO6VSgxVBoE/aZu6LcZP6ex8E4uRZmZLWbUaBz6sfYFOalFVFYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711545005; c=relaxed/simple;
	bh=EIfAaG+8ChusQ7KuCbmqxqXGfMQafmgd9vGhe7mjxFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o/H+S7FXnV3Euhi5N2pnFMXQ2Wi+oYTVSl71g3zSwQCyIsvP2wOQpJNZT/uY+G258yWpC3e3LwqBoFULIbTlsxeT73l6KTK+GCopXnq+/ZWdC34xsqc5i2iQsoMn+5X+0kMBmJ6XcpzDeEfP2OIhlxM3c3F7E1TBZtnIO3G69tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t8BiU5MV; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so6220483276.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 06:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711545002; x=1712149802; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lzCuQ38z5tEvKes8luQhWNfmBRoi0Op2h6rKQaV0U3o=;
        b=t8BiU5MVQYeF/ET1h+1fgbuiRa1CN64fWsGnCfnRFskMyeZcQHF06TroG+fQIMe/4q
         DvH2yJoj/Erarf0oiJMcz5SAn3dy9r/9yg+aU/1IR2ZrkmRFR43uk+2m1Y90EBKDPJE0
         1M4T+l7nowAHuN7FaXqLjDnM+OMSe90ojtKiOOzBhPE4LDByzGneVrWVKfUyBQtGh8kq
         FBZqunfIa0GUDbo9KGaZgw3x6hwJk72Mh+qz0d0XJHKCB1ZRbAj0zw5WnnGS6g0fsFA4
         H+zMud+BfwAZQIVBc/TQOzh7caad9PUik7eeUZV3i4JPvffWb3SOayIuR8MlUQrtjiAi
         d5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711545002; x=1712149802;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lzCuQ38z5tEvKes8luQhWNfmBRoi0Op2h6rKQaV0U3o=;
        b=iN3jr2du2SVNVp8FZt6bM9MdNmOROhvKYe4KCM8kehN7ztmlJGWXrYyvjFFx3YbBBJ
         tgEH77s3Y010RxOtsxM2fodthvZWsJ5zyjgA/5gwuMtojWUJ7beAvUijWORoT6BP97Km
         SVi/rPGaLCy4Q6TrujcquuLdkHUyzYK0t00euWT4GdaZHwEMT5lMJ3SREPW0H/FD14jk
         SMbk1LC7WGTvuqECFcGBNtK2Ydkd0+timdDXgeiNrfSg4nLDhvle0FeFg5b2mcubZvPO
         85ypGeqOdxPJC39ng1INCT5r9V8oQGFmysXjNotAEPidhGKK39D9V/rSHWwXRsGLDKOe
         Imug==
X-Forwarded-Encrypted: i=1; AJvYcCW/UAXiSBGt2iTAh40XMwCHJ+EAciG4fGHZx7SkF4bt+y5rDIEy7g4Iu0t1wGkaQtXb+vvRtNp9H8j/xzh7r75XPp/yl4BIMHfC3LVg
X-Gm-Message-State: AOJu0Yw/Gv/kantSOL+IlW4c4OOffmCoatThVF3PKf9EiOUVZ7Ar0uSd
	s+GKI5GJNl/BOGPFc2Zk6PG6A/TgOiWchkZhPDLgXKi1PSMp+VvOwSfhA6roTOa3DJDTGmoKtuY
	ifq2g8fGjCD5rWR5ALShyJdVAB7bvB5Yd1t/NBA==
X-Google-Smtp-Source: AGHT+IFEFjTBVS4HBczGqVH75JCqDQR+t3W+i9jRyLyq5dNnFwQJkaqlnv27HDRa7w6hVneeKjVD/LRnNW7r5pdZrf0=
X-Received: by 2002:a25:ac10:0:b0:dcb:e82c:f7d with SMTP id
 w16-20020a25ac10000000b00dcbe82c0f7dmr3861776ybi.41.1711545002212; Wed, 27
 Mar 2024 06:10:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327113228.1706975-1-quic_mohs@quicinc.com> <20240327113228.1706975-3-quic_mohs@quicinc.com>
In-Reply-To: <20240327113228.1706975-3-quic_mohs@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 27 Mar 2024 15:09:51 +0200
Message-ID: <CAA8EJpqh0emOFUPSj8rPaKr2hZRWwOh9NNTco8fyJCtwXe9sSA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] ASoC: qcom: qcm6490: Add machine driver for qcm6490
To: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Cc: srinivas.kandagatla@linaro.org, bgoswami@quicinc.com, broonie@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, andersson@kernel.org, 
	konrad.dybcio@linaro.org, lgirdwood@gmail.com, tiwai@suse.com, 
	quic_rohkumar@quicinc.com, linux-kernel@vger.kernel.org, 
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Mar 2024 at 13:34, Mohammad Rafi Shaik <quic_mohs@quicinc.com> wrote:
>
> Add machine driver for qcm6490 SoC.
>
> This initial supports which includes WSA883x Speakers with onboard DMIC
> connected to internal LPASS codec via VA macros respectively and also
> WCD937x based headset.
>
> Add compatible for sound card on Qualcomm qcs6490 boards.

Granted that qcm6490 is similar to sc7280, is there any reason why you
can not use one of the existing sound card drivers? Like sc7280.c or
sc8280xp.c?

>
> Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
> ---
>  sound/soc/qcom/Kconfig   |  13 +++
>  sound/soc/qcom/Makefile  |   2 +
>  sound/soc/qcom/qcm6490.c | 173 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 188 insertions(+)
>  create mode 100644 sound/soc/qcom/qcm6490.c
>
> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
> index 762491d6f2f2..0bc536766872 100644
> --- a/sound/soc/qcom/Kconfig
> +++ b/sound/soc/qcom/Kconfig
> @@ -151,6 +151,19 @@ config SND_SOC_MSM8996
>           APQ8096 SoC-based systems.
>           Say Y if you want to use audio device on this SoCs
>
> +config SND_SOC_QCM6490
> +       tristate "SoC Machine driver for QCM6490 boards"
> +       depends on QCOM_APR && SOUNDWIRE
> +       depends on COMMON_CLK
> +       select SND_SOC_QDSP6
> +       select SND_SOC_QCOM_COMMON
> +       select SND_SOC_QCOM_SDW
> +       help
> +         Add support for audio on Qualcomm Technologies Inc.
> +         QCM6490 SoC-based systems.
> +         To compile this driver say Y or M if you want to
> +         use audio device on this SoCs.
> +
>  config SND_SOC_SDM845
>         tristate "SoC Machine driver for SDM845 boards"
>         depends on QCOM_APR && I2C && SOUNDWIRE
> diff --git a/sound/soc/qcom/Makefile b/sound/soc/qcom/Makefile
> index 34f3fcb8ee9a..feb2c164be69 100644
> --- a/sound/soc/qcom/Makefile
> +++ b/sound/soc/qcom/Makefile
> @@ -22,6 +22,7 @@ obj-$(CONFIG_SND_SOC_LPASS_SC7280) += snd-soc-lpass-sc7280.o
>  snd-soc-storm-objs := storm.o
>  snd-soc-apq8016-sbc-objs := apq8016_sbc.o
>  snd-soc-apq8096-objs := apq8096.o
> +snd-soc-qcm6490-objs := qcm6490.o
>  snd-soc-sc7180-objs := sc7180.o
>  snd-soc-sc7280-objs := sc7280.o
>  snd-soc-sdm845-objs := sdm845.o
> @@ -34,6 +35,7 @@ snd-soc-x1e80100-objs := x1e80100.o
>  obj-$(CONFIG_SND_SOC_STORM) += snd-soc-storm.o
>  obj-$(CONFIG_SND_SOC_APQ8016_SBC) += snd-soc-apq8016-sbc.o
>  obj-$(CONFIG_SND_SOC_MSM8996) += snd-soc-apq8096.o
> +obj-$(CONFIG_SND_SOC_QCM6490) += snd-soc-qcm6490.o
>  obj-$(CONFIG_SND_SOC_SC7180) += snd-soc-sc7180.o
>  obj-$(CONFIG_SND_SOC_SC7280) += snd-soc-sc7280.o
>  obj-$(CONFIG_SND_SOC_SC8280XP) += snd-soc-sc8280xp.o
> diff --git a/sound/soc/qcom/qcm6490.c b/sound/soc/qcom/qcm6490.c
> new file mode 100644
> index 000000000000..5b0dc95963f5
> --- /dev/null
> +++ b/sound/soc/qcom/qcm6490.c
> @@ -0,0 +1,173 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> +
> +#include <dt-bindings/sound/qcom,q6afe.h>
> +#include <linux/input.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/of_device.h>
> +#include <sound/core.h>
> +#include <sound/soc.h>
> +#include <sound/soc-dapm.h>
> +#include <sound/pcm.h>
> +#include <linux/soundwire/sdw.h>
> +#include <sound/jack.h>
> +#include <sound/pcm_params.h>
> +#include "lpass.h"
> +#include "qdsp6/q6afe.h"
> +#include "common.h"
> +#include "sdw.h"
> +
> +struct qcm6490_snd_data {
> +       bool stream_prepared[AFE_PORT_MAX];
> +       struct snd_soc_card *card;
> +       struct sdw_stream_runtime *sruntime[AFE_PORT_MAX];
> +       struct snd_soc_jack jack;
> +       bool jack_setup;
> +};
> +
> +static int qcm6490_snd_init(struct snd_soc_pcm_runtime *rtd)
> +{
> +       struct qcm6490_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
> +       struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
> +
> +       switch (cpu_dai->id) {
> +       case TX_CODEC_DMA_TX_3:
> +       case LPASS_CDC_DMA_TX3:
> +       case RX_CODEC_DMA_RX_0:
> +               return qcom_snd_wcd_jack_setup(rtd, &data->jack, &data->jack_setup);
> +       case VA_CODEC_DMA_TX_0:
> +       case WSA_CODEC_DMA_RX_0:
> +               return 0;
> +       default:
> +               dev_err(rtd->dev, "%s: invalid dai id 0x%x\n", __func__, cpu_dai->id);
> +       }
> +
> +       return -EINVAL;
> +}
> +
> +static int qcm6490_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
> +                                     struct snd_pcm_hw_params *params)
> +{
> +       struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
> +       struct snd_interval *rate = hw_param_interval(params,
> +                                       SNDRV_PCM_HW_PARAM_RATE);
> +       struct snd_interval *channels = hw_param_interval(params,
> +                                       SNDRV_PCM_HW_PARAM_CHANNELS);
> +
> +       rate->min = 48000;
> +       rate->max = 48000;
> +       channels->min = 2;
> +       channels->max = 2;
> +       switch (cpu_dai->id) {
> +       case TX_CODEC_DMA_TX_0:
> +       case TX_CODEC_DMA_TX_1:
> +       case TX_CODEC_DMA_TX_2:
> +       case TX_CODEC_DMA_TX_3:
> +               channels->min = 1;
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       return 0;
> +}
> +
> +static int qcm6490_snd_hw_params(struct snd_pcm_substream *substream,
> +                                struct snd_pcm_hw_params *params)
> +{
> +       struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +       struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
> +       struct qcm6490_snd_data *pdata = snd_soc_card_get_drvdata(rtd->card);
> +
> +       return qcom_snd_sdw_hw_params(substream, params, &pdata->sruntime[cpu_dai->id]);
> +}
> +
> +static int qcm6490_snd_prepare(struct snd_pcm_substream *substream)
> +{
> +       struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +       struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
> +       struct qcm6490_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
> +       struct sdw_stream_runtime *sruntime = data->sruntime[cpu_dai->id];
> +
> +       return qcom_snd_sdw_prepare(substream, sruntime,
> +                                   &data->stream_prepared[cpu_dai->id]);
> +}
> +
> +static int qcm6490_snd_hw_free(struct snd_pcm_substream *substream)
> +{
> +       struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +       struct qcm6490_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
> +       struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
> +       struct sdw_stream_runtime *sruntime = data->sruntime[cpu_dai->id];
> +
> +       return qcom_snd_sdw_hw_free(substream, sruntime,
> +                                   &data->stream_prepared[cpu_dai->id]);
> +}
> +
> +static const struct snd_soc_ops qcm6490_be_ops = {
> +       .hw_params = qcm6490_snd_hw_params,
> +       .hw_free = qcm6490_snd_hw_free,
> +       .prepare = qcm6490_snd_prepare,
> +};
> +
> +static void qcm6490_add_be_ops(struct snd_soc_card *card)
> +{
> +       struct snd_soc_dai_link *link;
> +       int i;
> +
> +       for_each_card_prelinks(card, i, link) {
> +               if (link->no_pcm == 1) {
> +                       link->init = qcm6490_snd_init;
> +                       link->be_hw_params_fixup = qcm6490_be_hw_params_fixup;
> +                       link->ops = &qcm6490_be_ops;
> +               }
> +       }
> +}
> +
> +static int qcm6490_platform_probe(struct platform_device *pdev)
> +{
> +       struct snd_soc_card *card;
> +       struct qcm6490_snd_data *data;
> +       struct device *dev = &pdev->dev;
> +       int ret;
> +
> +       card = devm_kzalloc(dev, sizeof(*card), GFP_KERNEL);
> +       if (!card)
> +               return -ENOMEM;
> +       card->owner = THIS_MODULE;
> +       /* Allocate the private data */
> +       data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return -ENOMEM;
> +
> +       card->dev = dev;
> +       dev_set_drvdata(dev, card);
> +       snd_soc_card_set_drvdata(card, data);
> +       ret = qcom_snd_parse_of(card);
> +       if (ret)
> +               return ret;
> +
> +       card->driver_name = of_device_get_match_data(dev);
> +       qcm6490_add_be_ops(card);
> +       return devm_snd_soc_register_card(dev, card);
> +}
> +
> +static const struct of_device_id snd_qcm6490_dt_match[] = {
> +       {.compatible = "qcom,qcm6490-sndcard", "qcm6490"},
> +       {.compatible = "qcom,qcs6490-sndcard", "qcs6490"},
> +       {}
> +};
> +
> +MODULE_DEVICE_TABLE(of, snd_qcm6490_dt_match);
> +
> +static struct platform_driver snd_qcm6490_driver = {
> +       .probe  = qcm6490_platform_probe,
> +       .driver = {
> +               .name = "snd-qcm6490",
> +               .of_match_table = snd_qcm6490_dt_match,
> +       },
> +};
> +module_platform_driver(snd_qcm6490_driver);
> +MODULE_DESCRIPTION("qcm6490 ASoC Machine Driver");
> +MODULE_LICENSE("GPL");
> --
> 2.25.1
>
>


-- 
With best wishes
Dmitry


Return-Path: <linux-kernel+bounces-808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF9C814686
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D5C5B23CA4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DD024A15;
	Fri, 15 Dec 2023 11:14:23 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95232C681;
	Fri, 15 Dec 2023 11:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rE68w-0002u5-G6; Fri, 15 Dec 2023 12:14:10 +0100
Message-ID: <b8a905a7-8fae-4482-9a6d-d9ed2f5dafbc@leemhuis.info>
Date: Fri, 15 Dec 2023 12:14:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH V2 2/2] ASoC: amd: acp: add pm ops support for renoir
 platform
Content-Language: en-US, de-DE
To: Syed Saba Kareem <Syed.SabaKareem@amd.com>, broonie@kernel.org,
 alsa-devel@alsa-project.org
Cc: Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
 Sunil-kumar.Dommati@amd.com, mario.limonciello@amd.com, richgong@amd.com,
 posteuca@mutex.one, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 open list <linux-kernel@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20231113123345.2196504-1-Syed.SabaKareem@amd.com>
 <20231113123345.2196504-2-Syed.SabaKareem@amd.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
In-Reply-To: <20231113123345.2196504-2-Syed.SabaKareem@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1702638860;284e795e;
X-HE-SMSGID: 1rE68w-0002u5-G6

Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
for once, to make this easily accessible to everyone.

Does anyone know what happened to below patch? It afaics was meant to
fix a regression that made it into 6.6. For details see:

https://lore.kernel.org/lkml/87a5v8szhc.fsf@mutex.one/
https://lore.kernel.org/lkml/ac9d4f7b-c7af-4d21-b0b8-d0f188b94b0f@amd.com/

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

On 13.11.23 13:33, Syed Saba Kareem wrote:
> Add pm ops for renoir platform.
> 
> Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
> ---
>  sound/soc/amd/acp/acp-renoir.c | 38 +++++++++++++++++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/amd/acp/acp-renoir.c b/sound/soc/amd/acp/acp-renoir.c
> index a591482a0726..8539fbacdf4c 100644
> --- a/sound/soc/amd/acp/acp-renoir.c
> +++ b/sound/soc/amd/acp/acp-renoir.c
> @@ -20,6 +20,7 @@
>  #include <sound/soc.h>
>  #include <sound/soc-dai.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/pm_runtime.h>
>  
>  #include "amd.h"
>  #include "acp-mach.h"
> @@ -195,7 +196,11 @@ static int renoir_audio_probe(struct platform_device *pdev)
>  	dev_set_drvdata(dev, adata);
>  	acp_enable_interrupts(adata);
>  	acp_platform_register(dev);
> -
> +	pm_runtime_set_autosuspend_delay(&pdev->dev, ACP_SUSPEND_DELAY_MS);
> +	pm_runtime_use_autosuspend(&pdev->dev);
> +	pm_runtime_mark_last_busy(&pdev->dev);
> +	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
>  	return 0;
>  }
>  
> @@ -208,11 +213,42 @@ static void renoir_audio_remove(struct platform_device *pdev)
>  	acp_platform_unregister(dev);
>  }
>  
> +static int __maybe_unused rn_pcm_resume(struct device *dev)
> +{
> +	struct acp_dev_data *adata = dev_get_drvdata(dev);
> +	struct acp_stream *stream;
> +	struct snd_pcm_substream *substream;
> +	snd_pcm_uframes_t buf_in_frames;
> +	u64 buf_size;
> +
> +	spin_lock(&adata->acp_lock);
> +	list_for_each_entry(stream, &adata->stream_list, list) {
> +		substream = stream->substream;
> +		if (substream && substream->runtime) {
> +			buf_in_frames = (substream->runtime->buffer_size);
> +			buf_size = frames_to_bytes(substream->runtime, buf_in_frames);
> +			config_pte_for_stream(adata, stream);
> +			config_acp_dma(adata, stream, buf_size);
> +			if (stream->dai_id)
> +				restore_acp_i2s_params(substream, adata, stream);
> +			else
> +				restore_acp_pdm_params(substream, adata);
> +		}
> +	}
> +	spin_unlock(&adata->acp_lock);
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops rn_dma_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(NULL, rn_pcm_resume)
> +};
> +
>  static struct platform_driver renoir_driver = {
>  	.probe = renoir_audio_probe,
>  	.remove_new = renoir_audio_remove,
>  	.driver = {
>  		.name = "acp_asoc_renoir",
> +		.pm = &rn_dma_pm_ops,
>  	},
>  };
>  


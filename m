Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF2576E304
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbjHCI10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbjHCI0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:26:55 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C38DF
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 01:23:25 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6B5A76607194;
        Thu,  3 Aug 2023 09:23:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691051004;
        bh=rp9/2JVvPkY4DgcgUhtQzb7rv506eUs97Qg8bysS3KU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CV2IVZiZqASjHDEVihub0lIJ2F7x/U+GR0EFJjHonsqsLU/yoqDEuQLYLSn9cjcqN
         mN8/2lrZlBq6U4VUGOUVaVIoy3+5biU6JscM83SJCdprPieE55PMVxQHoB4JBj+H5M
         sXNOSSQmZhSyuNZ90ewGYz7Rv63L+HJCpTXGGf0gF7F78mlxGqf3Wi0HgTmG84UHsi
         OrOEePp2TmLHGazGpc+Zz6j2JQsiHoniJPOEdu8TNjCreaPDZbBG7ls5r3tDPGKa2a
         29hBVzAObGdc4jCGtX+grmbQlqTfvyAdbGVAfHgLinLSvNvtO4HKP8Lom+dZqE0jV3
         OfC8/T5YHxRlA==
Message-ID: <b363f992-9e70-cf10-6b21-801aa266ec68@collabora.com>
Date:   Thu, 3 Aug 2023 10:23:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/3] ASoC: mediatek: common: revise SOF common code
To:     Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org,
        lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        matthias.bgg@gmail.com
Cc:     alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230803052607.25843-1-trevor.wu@mediatek.com>
 <20230803052607.25843-3-trevor.wu@mediatek.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230803052607.25843-3-trevor.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 03/08/23 07:26, Trevor Wu ha scritto:
> Originally, normal dai link fixup callback is overwritten by sof fixup
> callback on mtk_sof_card_late_probe and it relies on the mapping defined
> on struct sof_conn_stream.
> 
> It's not flexible. When a new hardware connection is adopted, user needs
> to update struct sof_conn_stream defined in machine driver which is used
> to specify the mapping relationship of normal BE and SOF BE.
> 
> In the patch, mtk_sof_check_tplg_be_dai_link_fixup() is introduced for
> all normal BEs. In mtk_sof_late_probe, back up normal BE fixup if it
> exists and then overwrite be_hw_params_fixup by the new callback.
> 
> There are two cases for FE and BE connection.
> 
> case 1:
> SOF FE -> normal BE
>         -> SOF_BE
> 
> case 2:
> normal FE -> normal BE
> 
> In the new fixup callback, it tries to find SOF_BE which connects to the
> same FE, and then reuses the fixup of SOF_BE. If no SOF_BE exists,
> it must be case 2, so rollback to the original fixup if it exists.
> 
> As a result, the predefined relation is not needed anymore. Hardware
> connection can be controlled by the mixer control for AFE interconn.
> Then, DPCM finds the BE mapping at runtime.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
> ---
>   .../soc/mediatek/common/mtk-dsp-sof-common.c  | 106 +++++++++++++++---
>   .../soc/mediatek/common/mtk-dsp-sof-common.h  |   8 ++
>   2 files changed, 99 insertions(+), 15 deletions(-)
> 
> diff --git a/sound/soc/mediatek/common/mtk-dsp-sof-common.c b/sound/soc/mediatek/common/mtk-dsp-sof-common.c
> index 6fef16306f74..3fb193c1f0d9 100644
> --- a/sound/soc/mediatek/common/mtk-dsp-sof-common.c
> +++ b/sound/soc/mediatek/common/mtk-dsp-sof-common.c
> @@ -54,6 +54,8 @@ int mtk_sof_card_probe(struct snd_soc_card *card)
>   {
>   	int i;
>   	struct snd_soc_dai_link *dai_link;
> +	struct mtk_soc_card_data *soc_card_data = snd_soc_card_get_drvdata(card);
> +	struct mtk_sof_priv *sof_priv = soc_card_data->sof_priv;
>   
>   	/* Set stream_name to help sof bind widgets */
>   	for_each_card_prelinks(card, i, dai_link) {
> @@ -61,10 +63,74 @@ int mtk_sof_card_probe(struct snd_soc_card *card)
>   			dai_link->stream_name = dai_link->name;
>   	}
>   
> +	INIT_LIST_HEAD(&sof_priv->dai_link_list);
> +
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(mtk_sof_card_probe);
>   

static int mtk_sof_find_tplg_be_dai_link(struct snd_soc_pcm_runtime *rtd,
					 struct snd_soc_dai_link **sof_dai_link)
{
	... variables here...

	for_each_pcm_streams() {
		fe = NULL;

		.....

		if (!strcmp(...)) {
			sof_dai_link = ....
			return 0;
		}
	}
	return -ENOENT (or something else error);
}

P.S.: otherwise just make this function return a snd_soc_dai_link pointer...

> +/* fixup the BE DAI link to match any values from topology */
> +static int mtk_sof_check_tplg_be_dai_link_fixup(struct snd_soc_pcm_runtime *rtd,
> +						struct snd_pcm_hw_params *params)
> +{
> +	struct snd_soc_card *card = rtd->card;
> +	struct mtk_soc_card_data *soc_card_data = snd_soc_card_get_drvdata(card);
> +	struct mtk_sof_priv *sof_priv = soc_card_data->sof_priv;
> +	struct snd_soc_pcm_runtime *fe;
> +	struct snd_soc_pcm_runtime *be;
> +	struct snd_soc_dai_link *sof_dai_link = NULL;
> +	struct mtk_dai_link *dai_link;
> +	struct snd_soc_dpcm *dpcm;
> +	int i, stream;
> +	int ret = 0;
> +
> +	for_each_pcm_streams(stream) {
> +		fe = NULL;
> +		for_each_dpcm_fe(rtd, stream, dpcm) {
> +			fe = dpcm->fe;
> +			if (fe)
> +				break;
> +		}
> +
> +		if (!fe)
> +			continue;
> +
> +		for_each_dpcm_be(fe, stream, dpcm) {
> +			be = dpcm->be;
> +			if (be == rtd)
> +				continue;
> +
> +			for (i = 0; i < sof_priv->num_streams; i++) {
> +				const struct sof_conn_stream *conn = &sof_priv->conn_streams[i];
> +
> +				if (!strcmp(be->dai_link->name, conn->sof_link)) {
> +					sof_dai_link = be->dai_link;
> +					goto FIXUP;
> +				}
> +			}
> +		}
> +	}
> +
> +FIXUP:

Please, lowercase labels... or you can avoid gotos entirely:

	ret = mtk_sof_find_tplg_be_dai_link(...)
	if (ret == 0 && sof_dai_link) {
		if (sof_priv->sof_dai_link_fixup)
			return sof_priv->sof_dai_link_fixup(rtd, params);
		else if (sof_dai_link->be_hw_params_fixup)
			return sof_dai_link->be_hw_params_fixup(be, params);	
	} else {
		list_for_each_entry(dai_link, &sof_priv->dai_link_list, list) {
			if (strcmp(dai_link->name, rtd->dai_link->name) == 0) {
				if (dai_link->be_hw_params_fixup)
					return dai_link->be_hw_params_fixup(rtd, params);
				else
					break;
			}
		}
	}

	return 0;
}

P.S.: I'm truly sorry for not noticing that before!

Regards,
Angelo

> +	if (sof_dai_link) {
> +		if (sof_priv->sof_dai_link_fixup)
> +			ret = sof_priv->sof_dai_link_fixup(rtd, params);
> +		else if (sof_dai_link->be_hw_params_fixup)
> +			ret = sof_dai_link->be_hw_params_fixup(be, params);
> +	} else {
> +		list_for_each_entry(dai_link, &sof_priv->dai_link_list, list) {
> +			if (strcmp(dai_link->name, rtd->dai_link->name) == 0) {
> +				if (dai_link->be_hw_params_fixup)
> +					ret = dai_link->be_hw_params_fixup(rtd, params);
> +
> +				break;
> +			}
> +		}
> +	}
> +
> +	return ret;
> +}
> +
>   int mtk_sof_card_late_probe(struct snd_soc_card *card)
>   {
>   	struct snd_soc_pcm_runtime *rtd;
> @@ -72,6 +138,8 @@ int mtk_sof_card_late_probe(struct snd_soc_card *card)
>   	struct mtk_soc_card_data *soc_card_data =
>   		snd_soc_card_get_drvdata(card);
>   	struct mtk_sof_priv *sof_priv = soc_card_data->sof_priv;
> +	struct snd_soc_dai_link *dai_link;
> +	struct mtk_dai_link *mtk_dai_link;
>   	int i;
>   
>   	/* 1. find sof component */
> @@ -86,25 +154,37 @@ int mtk_sof_card_late_probe(struct snd_soc_card *card)
>   		return 0;
>   	}
>   
> -	/* 2. add route path and fixup callback */
> +	/* 2. overwrite all BE fixups, and backup the existing fixup */
> +	for_each_card_prelinks(card, i, dai_link) {
> +		if (dai_link->be_hw_params_fixup) {
> +			mtk_dai_link = devm_kzalloc(card->dev,
> +						    sizeof(*mtk_dai_link),
> +						    GFP_KERNEL);
> +			if (!mtk_dai_link)
> +				return -ENOMEM;
> +
> +			mtk_dai_link->be_hw_params_fixup = dai_link->be_hw_params_fixup;
> +			mtk_dai_link->name = dai_link->name;
> +
> +			list_add(&mtk_dai_link->list, &sof_priv->dai_link_list);
> +		}
> +
> +		if (dai_link->no_pcm)
> +			dai_link->be_hw_params_fixup = mtk_sof_check_tplg_be_dai_link_fixup;
> +	}
> +
> +	/* 3. add route path and SOF_BE fixup callback */
>   	for (i = 0; i < sof_priv->num_streams; i++) {
>   		const struct sof_conn_stream *conn = &sof_priv->conn_streams[i];
>   		struct snd_soc_pcm_runtime *sof_rtd = NULL;
> -		struct snd_soc_pcm_runtime *normal_rtd = NULL;
>   
>   		for_each_card_rtds(card, rtd) {
>   			if (!strcmp(rtd->dai_link->name, conn->sof_link)) {
>   				sof_rtd = rtd;
> -				continue;
> -			}
> -			if (!strcmp(rtd->dai_link->name, conn->normal_link)) {
> -				normal_rtd = rtd;
> -				continue;
> -			}
> -			if (normal_rtd && sof_rtd)
>   				break;
> +			}
>   		}
> -		if (normal_rtd && sof_rtd) {
> +		if (sof_rtd) {
>   			int j;
>   			struct snd_soc_dai *cpu_dai;
>   
> @@ -131,13 +211,9 @@ int mtk_sof_card_late_probe(struct snd_soc_card *card)
>   				}
>   			}
>   
> +			/* overwrite SOF BE fixup */
>   			sof_rtd->dai_link->be_hw_params_fixup =
>   				sof_comp->driver->be_hw_params_fixup;
> -			if (sof_priv->sof_dai_link_fixup)
> -				normal_rtd->dai_link->be_hw_params_fixup =
> -					sof_priv->sof_dai_link_fixup;
> -			else
> -				normal_rtd->dai_link->be_hw_params_fixup = mtk_sof_dai_link_fixup;
>   		}
>   	}
>   
> diff --git a/sound/soc/mediatek/common/mtk-dsp-sof-common.h b/sound/soc/mediatek/common/mtk-dsp-sof-common.h
> index dd38c4a93574..4bc5e1c0c8ed 100644
> --- a/sound/soc/mediatek/common/mtk-dsp-sof-common.h
> +++ b/sound/soc/mediatek/common/mtk-dsp-sof-common.h
> @@ -18,11 +18,19 @@ struct sof_conn_stream {
>   	int stream_dir;
>   };
>   
> +struct mtk_dai_link {
> +	const char *name;
> +	int (*be_hw_params_fixup)(struct snd_soc_pcm_runtime *rtd,
> +				  struct snd_pcm_hw_params *params);
> +	struct list_head list;
> +};
> +
>   struct mtk_sof_priv {
>   	const struct sof_conn_stream *conn_streams;
>   	int num_streams;
>   	int (*sof_dai_link_fixup)(struct snd_soc_pcm_runtime *rtd,
>   				  struct snd_pcm_hw_params *params);
> +	struct list_head dai_link_list;
>   };
>   
>   int mtk_sof_dai_link_fixup(struct snd_soc_pcm_runtime *rtd,


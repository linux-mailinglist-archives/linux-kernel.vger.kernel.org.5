Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E17B79C949
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbjILIIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbjILIIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:08:01 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644741722;
        Tue, 12 Sep 2023 01:07:53 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 62150660731E;
        Tue, 12 Sep 2023 09:07:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694506072;
        bh=6YZCuSZf4unv0v4wQASvumX+Wwk5m7wJ4MlGmVXivrY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AxtZEjEE5P9IojT5NpLqTlq/NUf/VsDUdrSqoxKhG2KqP/v8rczwBy0O3p20bm9V2
         pHSTu+nqCjGg5Gc4ostbAVEkaiUS4ltxFzm+ZKH/BnhbHqs5J7Uv5sLavbdXdGfkMB
         qRYwYK9vxCVvZ24zx/siKXbfAyS2P1uSjnXx91+eyP6vWnmweHV03JARFgCiArsrLY
         8bMYOD2bKtY46A27s0mlmQUiABZ+eJfWPxr9lAZ3ZqVqB/qU1AFK0sIfL1h3Y+EYL/
         pqlDH3b2X+vlbWKiKfj5P3yjHhCgsOat0BfRwd++Yifl3HsB9kdgopScJy2bNfMSjs
         MqE/B8J/ydJLg==
Message-ID: <9fe6f075-c5c0-3f59-d6ea-dc6766d74c96@collabora.com>
Date:   Tue, 12 Sep 2023 10:07:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 03/14] media: mediatek: vcodec: send share memory data to
 optee
Content-Language: en-US
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Nathan Hebert <nhebert@chromium.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230911125936.10648-1-yunfei.dong@mediatek.com>
 <20230911125936.10648-4-yunfei.dong@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230911125936.10648-4-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 11/09/23 14:59, Yunfei Dong ha scritto:
> Setting msg and vsi information to shared buffer, then call tee invoke
> function to send it to optee-os.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
>   .../vcodec/decoder/mtk_vcodec_dec_optee.c     | 139 ++++++++++++++++++
>   .../vcodec/decoder/mtk_vcodec_dec_optee.h     |  51 +++++++
>   2 files changed, 190 insertions(+)
> 
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_optee.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_optee.c
> index 806ca87c8de7..d16496003a39 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_optee.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_optee.c
> @@ -232,3 +232,142 @@ void mtk_vcodec_dec_optee_release(struct mtk_vdec_optee_private *optee_private)
>   	mutex_unlock(&optee_private->tee_mutex);
>   }
>   EXPORT_SYMBOL_GPL(mtk_vcodec_dec_optee_release);
> +
> +static int mtk_vcodec_dec_optee_fill_shm(struct tee_param *command_params,
> +					 struct mtk_vdec_optee_shm_memref *shm_memref,
> +					 struct mtk_vdec_optee_data_to_shm *data,
> +					 int index)
> +{
> +	if (!data->msg_buf_size[index] || !data->msg_buf[index]) {
> +		pr_err(MTK_DBG_VCODEC_STR "tee invalid buf param: %d.\n", index);
> +		return -EINVAL;
> +	}
> +
> +	*command_params = (struct tee_param) {
> +		.attr = shm_memref->param_type,
> +		.u.memref = {
> +			.shm = shm_memref->msg_shm,
> +			.size = data->msg_buf_size[index],
> +			.shm_offs = 0,
> +		},
> +	};
> +
> +	if (!shm_memref->copy_to_ta) {
> +		pr_debug(MTK_DBG_VCODEC_STR "share memref data: 0x%x param_type:%llu.\n",
> +			 *((unsigned int *)shm_memref->msg_shm_ca_buf), shm_memref->param_type);
> +		return 0;
> +	}
> +
> +	memset(shm_memref->msg_shm_ca_buf, 0, shm_memref->msg_shm_size);
> +	memcpy(shm_memref->msg_shm_ca_buf, data->msg_buf[index], data->msg_buf_size[index]);
> +
> +	pr_debug(MTK_DBG_VCODEC_STR "share memref data => msg id:0x%x 0x%x param_type:%llu.\n",
> +		 *((unsigned int *)data->msg_buf[index]),
> +		 *((unsigned int *)shm_memref->msg_shm_ca_buf),
> +		 shm_memref->param_type);

dev_dbg()?

> +
> +	return 0;
> +}
> +
> +void mtk_vcodec_dec_optee_set_data(struct mtk_vdec_optee_data_to_shm *data,
> +				   void *buf, int buf_size,
> +				   enum mtk_vdec_optee_data_index index)
> +{
> +	data->msg_buf[index] = buf;
> +	data->msg_buf_size[index] = buf_size;
> +}
> +EXPORT_SYMBOL_GPL(mtk_vcodec_dec_optee_set_data);
> +
> +int mtk_vcodec_dec_optee_invokd_cmd(struct mtk_vdec_optee_private *optee_private,
> +				    enum mtk_vdec_hw_id hw_id,
> +				    struct mtk_vdec_optee_data_to_shm *data)
> +{
> +	struct tee_ioctl_invoke_arg trans_args;
> +	struct tee_param command_params[MTK_OPTEE_MAX_TEE_PARAMS];
> +	struct mtk_vdec_optee_ca_info *ca_info;
> +	struct mtk_vdec_optee_shm_memref *shm_memref;
> +	int ret = 0, index;

int i, ret;

> +
> +	if (hw_id == MTK_VDEC_LAT0)
> +		ca_info = &optee_private->lat_ca;
> +	else
> +		ca_info = &optee_private->core_ca;
> +
> +	memset(&trans_args, 0, sizeof(trans_args));
> +	memset(command_params, 0, sizeof(command_params));
> +
> +	trans_args = (struct tee_ioctl_invoke_arg) {
> +		.func = ca_info->vdec_session_func,
> +		.session = ca_info->vdec_session_id,
> +		.num_params = MTK_OPTEE_MAX_TEE_PARAMS,
> +	};
> +
> +	/* Fill msg command parameters */
> +	for (index = 0; index < MTK_OPTEE_MAX_TEE_PARAMS; index++) {
> +		shm_memref = &ca_info->shm_memref[index];
> +
> +		if (shm_memref->param_type == TEE_IOCTL_PARAM_ATTR_TYPE_NONE ||
> +		    data->msg_buf_size[index] == 0)
> +			continue;
> +
> +		pr_debug(MTK_DBG_VCODEC_STR "tee share memory data size: %d -> %d.\n",
> +			 data->msg_buf_size[index], shm_memref->msg_shm_size);
> +

dev_dbg()

> +		if (data->msg_buf_size[index] > shm_memref->msg_shm_size) {
> +			pr_err(MTK_DBG_VCODEC_STR "tee buf size big then shm size(%d -> %d).\n",
> +			       data->msg_buf_size[index], shm_memref->msg_shm_size);

dev_err()

> +			return -EINVAL;
> +		}
> +
> +		ret = mtk_vcodec_dec_optee_fill_shm(&command_params[index], shm_memref,
> +						    data, index);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = tee_client_invoke_func(optee_private->tee_vdec_ctx, &trans_args, command_params);
> +	if (ret < 0 || trans_args.ret != 0) {
> +		pr_err(MTK_DBG_VCODEC_STR "tee submit command fail: 0x%x 0x%x.\n",
> +		       trans_args.ret, ret);

dev_err()

> +		return (ret < 0) ? ret : trans_args.ret;
> +	}
> +
> +	/* clear all attrs, set all command param to unused */
> +	for (index = 0; index < MTK_OPTEE_MAX_TEE_PARAMS; index++) {
> +		data->msg_buf[index] = NULL;
> +		data->msg_buf_size[index] = 0;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(mtk_vcodec_dec_optee_invokd_cmd);
> +

Regards,
Angelo


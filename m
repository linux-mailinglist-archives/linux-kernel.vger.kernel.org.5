Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FB079C945
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbjILIH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233046AbjILIGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:06:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774E010C6;
        Tue, 12 Sep 2023 01:04:57 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1F4E0660731D;
        Tue, 12 Sep 2023 09:04:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694505895;
        bh=691+u/eVfRRkkKiJaSzVcjnxIWbJX7ogA9Ey0F8h108=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iyoimOBRkb0IP9gPISVEAtopEWFBHXimo8XBbW/1M5wnLdoZV0deT5xibD6z/rYQs
         KybC7WWeIAsU+lZDA+V8hCIDvfzU8bdT24YHGHuH3B5b51DlNoxHffOEaO0IWb/sxS
         p4i+DQm5QM5Q+eFvHsWHLAKbI2efmXpXwsT79qHpL7rt0PZGGBSc2YpewYtxypTx98
         J3/FmVOBnBIkrB6NS1bMNQoxViurRydcWgr9//GkBpPBzbcNBeQis5MmqqXJzylZeg
         xsx/QrCChyk9u/z4Kr+080Aeh/+evekEiljoduBRqJ9XtZFIe+2N7TyxTaev80lCbC
         FB6rI+btIUpNw==
Message-ID: <a8a32bb7-7993-10ed-ec09-cd2db49f2436@collabora.com>
Date:   Tue, 12 Sep 2023 10:04:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 02/14] media: mediatek: vcodec: allocate tee share memory
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
 <20230911125936.10648-3-yunfei.dong@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230911125936.10648-3-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 11/09/23 14:59, Yunfei Dong ha scritto:
> Allocate two share memory for each lat and core hardware used to share
> information with optee-os. Msg buffer used to send ipi command and get ack
> command with optee-os, data buffer used to store vsi information which
> used for hardware decode.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
>   .../vcodec/decoder/mtk_vcodec_dec_optee.c     | 79 ++++++++++++++++++-
>   .../vcodec/decoder/mtk_vcodec_dec_optee.h     | 32 ++++++++
>   2 files changed, 110 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_optee.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_optee.c
> index 3ee9039d2a5b..806ca87c8de7 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_optee.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_optee.c
> @@ -47,12 +47,67 @@ int mtk_vcodec_dec_optee_private_init(struct mtk_vcodec_dec_dev *vcodec_dev)
>   }
>   EXPORT_SYMBOL_GPL(mtk_vcodec_dec_optee_private_init);
>   
> +static void mtk_vcodec_dec_optee_deinit_memref(struct mtk_vdec_optee_ca_info *ca_info,
> +					       enum mtk_vdec_optee_data_index data_index)
> +{
> +	tee_shm_free(ca_info->shm_memref[data_index].msg_shm);
> +}
> +
> +static int mtk_vcodec_dec_optee_init_memref(struct tee_context *tee_vdec_ctx,
> +					    struct mtk_vdec_optee_ca_info *ca_info,
> +					    enum mtk_vdec_optee_data_index data_index)
> +{
> +	struct mtk_vdec_optee_shm_memref *shm_memref;
> +	int alloc_size = 0, err = 0;
> +	u64 shm_param_type = 0;
> +	bool copy_buffer;
> +
> +	if (data_index >= OPTEE_MAX_INDEX) {
> +		pr_err(MTK_DBG_VCODEC_STR "tee invalid data_index: %d.\n", data_index);
> +		return -EINVAL;
> +	} else if (data_index == OPTEE_MSG_INDEX) {
> +		shm_param_type = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT;
> +		alloc_size = MTK_VDEC_OPTEE_MSG_SIZE;
> +		copy_buffer = true;
> +	} else {
> +		shm_param_type = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT;
> +		alloc_size = MTK_VDEC_OPTEE_HW_SIZE;
> +		copy_buffer = false;
> +	}

This is another good usecase for a switch.

	switch (data_index) {
	case OPTEE_MSG_INDEX:
		......
	case OPTEE_DATA_INDEX:
		......
	default:
		invalid data_index; return....
	}

> +
> +	shm_memref = &ca_info->shm_memref[data_index];
> +
> +	/* Allocate dynamic shared memory with decoder TA */
> +	shm_memref->msg_shm_size = alloc_size;
> +	shm_memref->param_type = shm_param_type;
> +	shm_memref->copy_to_ta = copy_buffer;
> +	shm_memref->msg_shm =
> +		tee_shm_alloc_kernel_buf(tee_vdec_ctx, shm_memref->msg_shm_size);

That'd be 96 columns, one line is ok.

> +	if (IS_ERR(shm_memref->msg_shm)) {
> +		pr_err(MTK_DBG_VCODEC_STR "tee alloc buf fail: data_index:%d.\n", data_index);
> +		return -ENOMEM;
> +	}
> +
> +	shm_memref->msg_shm_ca_buf = tee_shm_get_va(shm_memref->msg_shm, 0);
> +	if (IS_ERR(shm_memref->msg_shm_ca_buf)) {
> +		pr_err(MTK_DBG_VCODEC_STR "tee get shm va fail: data_index:%d.\n", data_index);
> +		err = PTR_ERR(shm_memref->msg_shm_ca_buf);
> +		goto err_get_msg_va;
> +	}
> +
> +	return err;
> +
> +err_get_msg_va:
> +	tee_shm_free(shm_memref->msg_shm);
> +	return err;
> +}
> +
>   static int mtk_vcodec_dec_optee_init_hw_info(struct mtk_vdec_optee_private *optee_private,
>   					     enum mtk_vdec_hw_id hardware_index)
>   {
>   	struct tee_ioctl_open_session_arg session_arg;
>   	struct mtk_vdec_optee_ca_info *ca_info;
> -	int err = 0, session_func;
> +	int err = 0, i = 0, j = 0, session_func;

Please don't initialize `i` and `j` here, you can do that in the for loop as
per common practice.

>   
>   	/* Open lat and core session with vdec TA. */
>   	if (hardware_index == MTK_VDEC_LAT0) {
> @@ -81,6 +136,24 @@ static int mtk_vcodec_dec_optee_init_hw_info(struct mtk_vdec_optee_private *opte
>   	pr_debug(MTK_DBG_VCODEC_STR "open vdec tee session: hw_id(%d) session_id=%x.\n",
>   		 hardware_index, ca_info->vdec_session_id);
>   
> +	/* Allocate dynamic shared memory with decoder TA */
> +	for (; i < OPTEE_MAX_INDEX; i++) {
> +		err = mtk_vcodec_dec_optee_init_memref(optee_private->tee_vdec_ctx, ca_info, i);
> +		if (err) {
> +			pr_err(MTK_DBG_VCODEC_STR "init vdec memref failed: %d.\n", i);
> +			goto err_init_memref;
> +		}
> +	}
> +
> +	return err;
> +err_init_memref:
> +	if (i != 0) {
> +		for (; j < i; j++)
> +			mtk_vcodec_dec_optee_deinit_memref(ca_info, j);
> +	}
> +
> +	tee_client_close_session(optee_private->tee_vdec_ctx, ca_info->vdec_session_id);
> +
>   	return err;
>   }
>   
> @@ -88,12 +161,16 @@ static void mtk_vcodec_dec_optee_deinit_hw_info(struct mtk_vdec_optee_private *o
>   						enum mtk_vdec_hw_id hw_id)
>   {
>   	struct mtk_vdec_optee_ca_info *ca_info;
> +	int i = 0;

int i;

>   
>   	if (hw_id == MTK_VDEC_LAT0)
>   		ca_info = &optee_private->lat_ca;
>   	else
>   		ca_info = &optee_private->core_ca;
>   
> +	for (; i < OPTEE_MAX_INDEX; i++)

for (i = 0; i < OPTEE_MAX_INDEX; i++)

> +		mtk_vcodec_dec_optee_deinit_memref(ca_info, i);
> +
>   	tee_client_close_session(optee_private->tee_vdec_ctx, ca_info->vdec_session_id);
>   }
>   
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_optee.h b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_optee.h
> index 8b1dca49331e..79b4ec890655 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_optee.h
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_optee.h
> @@ -18,16 +18,48 @@
>   
>   #define MTK_OPTEE_MAX_TEE_PARAMS 4
>   
> +#define MTK_VDEC_OPTEE_MSG_SIZE     128
> +#define MTK_VDEC_OPTEE_HW_SIZE      (8 * SZ_1K)
> +
> +/**
> + * struct mtk_vdec_optee_shm_memref - share memory reference params
> + * @msg_shm:        message shared with TA in TEE.
> + * @msg_shm_ca_buf: ca buffer.
> + *
> + * @msg_shm_size:   share message size.
> + * @param_type:     each tee param types.
> + * @copy_to_ta:     need to copy data from ca to share memory.
> + */
> +struct mtk_vdec_optee_shm_memref {
> +	struct tee_shm *msg_shm;
> +	u8 *msg_shm_ca_buf;
> +
> +	u32 msg_shm_size;
> +	u64 param_type;
> +	bool copy_to_ta;
> +};
> +
>   /**
>    * struct mtk_vdec_optee_ca_info - ca related param
>    * @vdec_session_id:   optee TA session identifier.
>    * @hw_id:             hardware index.
>    * @vdec_session_func: trusted application function id used specific to the TA.
> + * @shm_memref:        share memory reference params.
>    */
>   struct mtk_vdec_optee_ca_info {
>   	u32 vdec_session_id;
>   	enum mtk_vdec_hw_id hw_id;
>   	u32 vdec_session_func;
> +	struct mtk_vdec_optee_shm_memref shm_memref[MTK_OPTEE_MAX_TEE_PARAMS];
> +};
> +
> +/*
> + * enum mtk_vdec_optee_data_index - used to indentify each share memory informaiton

Typo: informaiton -> information

> + */
> +enum mtk_vdec_optee_data_index {
> +	OPTEE_MSG_INDEX = 0,
> +	OPTEE_DATA_INDEX,
> +	OPTEE_MAX_INDEX,
>   };
>   
>   /**

Regards,
Angelo

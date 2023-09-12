Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C86279C98C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbjILIPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbjILIPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:15:12 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB4B198C;
        Tue, 12 Sep 2023 01:15:05 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 83F8F660731E;
        Tue, 12 Sep 2023 09:15:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694506504;
        bh=iZoRX12C04P7aOw7C1x8buw/2JH8+XXGCyJ/mc0b3Gc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=diNgoIrI5h3R94O/uh+uA0OizYgI/fsvzQFKxbnJDvVHZguwPElw/+eTAcPJ5r4xL
         6XYPk5jnYF38CbdRVzdcPbh4rH97+laCL2JM+l0lwDbLSYUuhVPyMZZ5IhdXmIs+U+
         OM0hOw+xEZouAbQrwaGeA8joszsRc+QhSWPskb7jaA5D+nTA2/XmmqXqDyBiP6hWR1
         2N4+vfQm6xFHqSWHvB3R8Sk33iDfn/JynU2YeFop7Kxf0XRuVscYjOO4ATqjxGQW5F
         s/H4LCFwTyjKqiTumtvlzlYXf3wGp+FmzYQZaa+g8ntRG0rI0ub/SyJ4mkrjltfzOm
         rtWRLcA3e/RRA==
Message-ID: <72d439f3-1ec4-d396-55e0-e1e52011c81f@collabora.com>
Date:   Tue, 12 Sep 2023 10:15:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 04/14] media: mediatek: vcodec: initialize msg and vsi
 information
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
 <20230911125936.10648-5-yunfei.dong@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230911125936.10648-5-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 11/09/23 14:59, Yunfei Dong ha scritto:
> Need to initialize msg and vsi information before sending to optee-os, then
> calling optee invoke command to send the information to optee-os.
> 
> For the optee communication interface is different with scp, using
> flag to separate them.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
>   .../vcodec/decoder/mtk_vcodec_dec_drv.h       |  2 +
>   .../mediatek/vcodec/decoder/vdec_vpu_if.c     | 46 ++++++++++++++++---
>   .../mediatek/vcodec/decoder/vdec_vpu_if.h     |  4 ++
>   3 files changed, 46 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h
> index 061542c3852c..20e534151f69 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h
> @@ -165,6 +165,7 @@ struct mtk_vcodec_dec_pdata {
>    * @vpu_inst: vpu instance pointer.
>    *
>    * @is_10bit_bitstream: set to true if it's 10bit bitstream
> + * @is_svp_mode: secure video playback
>    */
>   struct mtk_vcodec_dec_ctx {
>   	enum mtk_instance_type type;
> @@ -210,6 +211,7 @@ struct mtk_vcodec_dec_ctx {
>   	void *vpu_inst;
>   
>   	bool is_10bit_bitstream;
> +	bool is_svp_mode;

This looks clearer:

@is_secure_playback: Secure Video Playback (SVP) mode

bool is_secure_playback;

>   };
>   
>   /**
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c
> index 82e57ae983d5..c1a1bddf99d8 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c
> @@ -148,7 +148,10 @@ static void vpu_dec_ipi_handler(void *data, unsigned int len, void *priv)
>   
>   static int vcodec_vpu_send_msg(struct vdec_vpu_inst *vpu, void *msg, int len)
>   {
> -	int err, id, msgid;
> +	int err, id, hw_id, msgid;
> +	struct mtk_vdec_optee_data_to_shm *optee_data;
> +	void *ack_msg, *data_msg;
> +	int data_size;

	struct mtk_vdec_optee_data_to_shm *optee_data;
	int data_size, id, hw_id, msgid;
	void *ack_msg, *data_msg;
	int err;

>   
>   	msgid = *(uint32_t *)msg;
>   	mtk_vdec_debug(vpu->ctx, "id=%X", msgid);
> @@ -158,16 +161,46 @@ static int vcodec_vpu_send_msg(struct vdec_vpu_inst *vpu, void *msg, int len)
>   
>   	if (vpu->ctx->dev->vdec_pdata->hw_arch == MTK_VDEC_LAT_SINGLE_CORE) {
>   		if (msgid == AP_IPIMSG_DEC_CORE ||
> -		    msgid == AP_IPIMSG_DEC_CORE_END)
> +		    msgid == AP_IPIMSG_DEC_CORE_END) {
> +			optee_data = &vpu->core_optee_info;
>   			id = vpu->core_id;
> -		else
> +		} else {
> +			optee_data = &vpu->lat_optee_info;
>   			id = vpu->id;
> +		}
>   	} else {
> +		optee_data = &vpu->lat_optee_info;
>   		id = vpu->id;
>   	}
>   
> -	err = mtk_vcodec_fw_ipi_send(vpu->ctx->dev->fw_handler, id, msg,
> -				     len, 2000);
> +	if (!vpu->ctx->is_svp_mode) {
> +		err = mtk_vcodec_fw_ipi_send(vpu->ctx->dev->fw_handler, id, msg, len, 2000);
> +	} else {
> +		hw_id = (id == SCP_IPI_VDEC_LAT) ? MTK_VDEC_LAT0 : MTK_VDEC_CORE;
> +
> +		mtk_vcodec_dec_optee_set_data(optee_data, msg, len, OPTEE_MSG_INDEX);
> +
> +		/* No need copy data(vsi) msg to share memory, set the buffer size to non zero
> +		 * value.
> +		 */

/*
  * There is no need to copy the data (VSI) message to shared memory,
  * but we still need to set the buffer size to a non-zero value.
  */

> +		if (msgid == AP_IPIMSG_DEC_CORE || msgid == AP_IPIMSG_DEC_START) {
> +			data_msg = mtk_vcodec_dec_get_shm_buffer_va(vpu->ctx->dev->optee_private,
> +								    hw_id, OPTEE_DATA_INDEX);
> +			data_size = mtk_vcodec_dec_get_shm_buffer_size(vpu->ctx->dev->optee_private,
> +								       hw_id, OPTEE_DATA_INDEX);
> +			mtk_vcodec_dec_optee_set_data(optee_data, data_msg, data_size,
> +						      OPTEE_DATA_INDEX);
> +		}
> +
> +		err = mtk_vcodec_dec_optee_invokd_cmd(vpu->ctx->dev->optee_private,
> +						      hw_id, optee_data);
> +		vpu->failure = err;
> +
> +		ack_msg = mtk_vcodec_dec_get_shm_buffer_va(vpu->ctx->dev->optee_private, hw_id,
> +							   OPTEE_MSG_INDEX);
> +		vpu_dec_ipi_handler(ack_msg, 0, vpu->ctx->dev);
> +	}
> +
>   	if (err) {
>   		mtk_vdec_err(vpu->ctx, "send fail vpu_id=%d msg_id=%X status=%d",
>   			     id, msgid, err);
> @@ -213,7 +246,8 @@ int vpu_dec_init(struct vdec_vpu_inst *vpu)
>   		return err;
>   	}
>   
> -	if (vpu->ctx->dev->vdec_pdata->hw_arch == MTK_VDEC_LAT_SINGLE_CORE) {
> +	if (vpu->ctx->dev->vdec_pdata->hw_arch == MTK_VDEC_LAT_SINGLE_CORE &&
> +	    !vpu->ctx->is_svp_mode) {

Please add a comment explaining why no fw_ipi is necessary here for SVP.

Regards,
Angelo

>   		err = mtk_vcodec_fw_ipi_register(vpu->ctx->dev->fw_handler,
>   						 vpu->core_id, vpu->handler,
>   						 "vdec", vpu->ctx->dev);
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.h b/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.h
> index fbb3f34a73f0..946e5abcc7d3 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.h
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.h
> @@ -28,6 +28,8 @@ struct mtk_vcodec_dec_ctx;
>    * @codec_type     : use codec type to separate different codecs
>    * @capture_type:	used capture type to separate different capture format
>    * @fb_sz  : frame buffer size of each plane
> + * @lat_optee_info  : used to send msg to optee shm buffer
> + * @core_optee_info  : used to send msg to optee shm buffer
>    */
>   struct vdec_vpu_inst {
>   	int id;
> @@ -44,6 +46,8 @@ struct vdec_vpu_inst {
>   	unsigned int codec_type;
>   	unsigned int capture_type;
>   	unsigned int fb_sz[2];
> +	struct mtk_vdec_optee_data_to_shm lat_optee_info;
> +	struct mtk_vdec_optee_data_to_shm core_optee_info;
>   };
>   
>   /**



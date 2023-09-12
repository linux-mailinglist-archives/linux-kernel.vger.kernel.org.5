Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0391679C944
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbjILIHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233045AbjILIGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:06:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBC02701;
        Tue, 12 Sep 2023 01:04:56 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 79D33660731B;
        Tue, 12 Sep 2023 09:04:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694505895;
        bh=Owrv6xswWLSiAz7bBSp0CezmLAzRNkQ/3BHLEIYLO8U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IPshnzgNSSTMMq1TX9qNWz7w3ufsDiZcLZXnrXWz6ZyZTpyg2nPcEV+LyrgmMvpg2
         vdhCycck6mHvwfXgfEZu16tN6lcczfE6yKu6v2a30U70Ep5QcTZ/oeLofGM0xu2WFp
         Pa8cHM+BerQhiodQ/mLLec8gwmc7SnUbWiLTcMVGWd0WrIfGIdgdZiy9P3ks/N/apR
         fCw46XTvEUW4TvJT07UcIonmxMylSRoBmgqDFpsr6QdDt6oEYNVMtkQqU6hu6YsAHC
         BYy4JtHmgFeDFsTqc7yu3SkI6km8C/b1LgBHqRxYivgyXakL+hc05+782mc7h98oj9
         lwWpF127rcTdA==
Message-ID: <761d8d69-bfe9-299e-e845-5ba6a6c0e2fd@collabora.com>
Date:   Tue, 12 Sep 2023 10:04:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 01/14] media: mediatek: vcodec: add tee client interface
 to communiate with optee-os
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
 <20230911125936.10648-2-yunfei.dong@mediatek.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230911125936.10648-2-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 11/09/23 14:59, Yunfei Dong ha scritto:
> Open tee context to initialize the environment in order to communiate
> with optee-os, then open tee session as the communiation pipeline for
> lat and core to send data for hardware decode.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
>   .../platform/mediatek/vcodec/decoder/Makefile |   1 +
>   .../vcodec/decoder/mtk_vcodec_dec_drv.h       |   5 +
>   .../vcodec/decoder/mtk_vcodec_dec_optee.c     | 157 ++++++++++++++++++
>   .../vcodec/decoder/mtk_vcodec_dec_optee.h     |  73 ++++++++
>   4 files changed, 236 insertions(+)
>   create mode 100644 drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_optee.c
>   create mode 100644 drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_optee.h
> 
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/Makefile b/drivers/media/platform/mediatek/vcodec/decoder/Makefile
> index 904cd22def84..1624933dfd5e 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/Makefile
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/Makefile
> @@ -21,5 +21,6 @@ mtk-vcodec-dec-y := vdec/vdec_h264_if.o \
>   		mtk_vcodec_dec_stateful.o \
>   		mtk_vcodec_dec_stateless.o \
>   		mtk_vcodec_dec_pm.o \
> +		mtk_vcodec_dec_optee.o \
>   
>   mtk-vcodec-dec-hw-y := mtk_vcodec_dec_hw.o
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h
> index 7e36b2c69b7d..061542c3852c 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h
> @@ -11,6 +11,7 @@
>   #include "../common/mtk_vcodec_dbgfs.h"
>   #include "../common/mtk_vcodec_fw_priv.h"
>   #include "../common/mtk_vcodec_util.h"
> +#include "mtk_vcodec_dec_optee.h"
>   #include "vdec_msg_queue.h"
>   
>   #define MTK_VCODEC_DEC_NAME	"mtk-vcodec-dec"
> @@ -249,6 +250,8 @@ struct mtk_vcodec_dec_ctx {
>    * @vdec_racing_info: record register value
>    * @dec_racing_info_mutex: mutex lock used for inner racing mode
>    * @dbgfs: debug log related information
> + *
> + * @tee_private: optee private data

This should be @optee_private

>    */
>   struct mtk_vcodec_dec_dev {
>   	struct v4l2_device v4l2_dev;
> @@ -289,6 +292,8 @@ struct mtk_vcodec_dec_dev {
>   	/* Protects access to vdec_racing_info data */
>   	struct mutex dec_racing_info_mutex;
>   	struct mtk_vcodec_dbgfs dbgfs;
> +
> +	struct mtk_vdec_optee_private *optee_private;
>   };
>   
>   static inline struct mtk_vcodec_dec_ctx *fh_to_dec_ctx(struct v4l2_fh *fh)
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_optee.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_optee.c
> new file mode 100644
> index 000000000000..3ee9039d2a5b
> --- /dev/null
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_optee.c
> @@ -0,0 +1,157 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 MediaTek Inc.
> + * Author: Yunfei Dong <yunfei.dong@mediatek.com>
> + */
> +
> +#include "mtk_vcodec_dec_drv.h"
> +#include "mtk_vcodec_dec_optee.h"
> +
> +/*
> + * Randomly generated, and must correspond to the GUID on the TA side.
> + */
> +static const uuid_t mtk_vdec_lat_uuid =
> +	UUID_INIT(0xBC50D971, 0xD4C9, 0x42C4,
> +		  0x82, 0xCB, 0x34, 0x3F, 0xB7, 0xF3, 0x78, 0x90);
> +
> +static const uuid_t mtk_vdec_core_uuid =
> +	UUID_INIT(0xBC50D971, 0xD4C9, 0x42C4,
> +		  0x82, 0xCB, 0x34, 0x3F, 0xB7, 0xF3, 0x78, 0x91);
> +
> +/*
> + * Check whether this driver supports decoder TA in the TEE instance,
> + * represented by the params (ver/data) of this function.
> + */
> +static int mtk_vcodec_dec_optee_match(struct tee_ioctl_version_data *ver_data, const void *not_used)
> +{
> +	if (ver_data->impl_id == TEE_IMPL_ID_OPTEE)
> +		return 1;
> +	else
> +		return 0;
> +}
> +
> +int mtk_vcodec_dec_optee_private_init(struct mtk_vcodec_dec_dev *vcodec_dev)
> +{
> +	vcodec_dev->optee_private = devm_kzalloc(&vcodec_dev->plat_dev->dev,
> +						 sizeof(*vcodec_dev->optee_private),
> +						 GFP_KERNEL);
> +	if (!vcodec_dev->optee_private)
> +		return -ENOMEM;
> +
> +	vcodec_dev->optee_private->vcodec_dev = vcodec_dev;
> +
> +	atomic_set(&vcodec_dev->optee_private->tee_active_cnt, 0);
> +	mutex_init(&vcodec_dev->optee_private->tee_mutex);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(mtk_vcodec_dec_optee_private_init);
> +
> +static int mtk_vcodec_dec_optee_init_hw_info(struct mtk_vdec_optee_private *optee_private,
> +					     enum mtk_vdec_hw_id hardware_index)
> +{
> +	struct tee_ioctl_open_session_arg session_arg;
> +	struct mtk_vdec_optee_ca_info *ca_info;
> +	int err = 0, session_func;
> +
> +	/* Open lat and core session with vdec TA. */

I assume that anything else than CORE or LAT0 cannot use secure sessions, so...

	switch (hardware_index) {
	case MTK_VDEC_CORE:
		export_uuid
		.....
		break;
	case MTK_VDEC_LAT0:
		export_uuid(...
		......
		break;
	default:
		return -EINVAL;
	}

> +	if (hardware_index == MTK_VDEC_LAT0) {
> +		export_uuid(session_arg.uuid, &mtk_vdec_lat_uuid);
> +		session_func = MTK_VDEC_OPTEE_TA_LAT_SUBMIT_COMMAND;
> +		ca_info = &optee_private->lat_ca;
> +	} else {
> +		export_uuid(session_arg.uuid, &mtk_vdec_core_uuid);
> +		session_func = MTK_VDEC_OPTEE_TA_CORE_SUBMIT_COMMAND;
> +		ca_info = &optee_private->core_ca;
> +	}
> +
> +	session_arg.clnt_login = TEE_IOCTL_LOGIN_PUBLIC;
> +	session_arg.num_params = 0;
> +
> +	err = tee_client_open_session(optee_private->tee_vdec_ctx, &session_arg, NULL);
> +	if (err < 0 || session_arg.ret != 0) {
> +		pr_err(MTK_DBG_VCODEC_STR "open vdec tee session failed: hw_id(%d) err=%x.\n",
> +		       hardware_index, session_arg.ret);

Can we use dev_err() please?

> +		return -EINVAL;
> +	}
> +	ca_info->vdec_session_id = session_arg.session;
> +	ca_info->hw_id = hardware_index;
> +	ca_info->vdec_session_func = session_func;
> +
> +	pr_debug(MTK_DBG_VCODEC_STR "open vdec tee session: hw_id(%d) session_id=%x.\n",
> +		 hardware_index, ca_info->vdec_session_id);
> +
> +	return err;
> +}
> +
> +static void mtk_vcodec_dec_optee_deinit_hw_info(struct mtk_vdec_optee_private *optee_private,
> +						enum mtk_vdec_hw_id hw_id)
> +{
> +	struct mtk_vdec_optee_ca_info *ca_info;
> +
> +	if (hw_id == MTK_VDEC_LAT0)
> +		ca_info = &optee_private->lat_ca;
> +	else
> +		ca_info = &optee_private->core_ca;
> +
> +	tee_client_close_session(optee_private->tee_vdec_ctx, ca_info->vdec_session_id);
> +}
> +
> +int mtk_vcodec_dec_optee_open(struct mtk_vdec_optee_private *optee_private)
> +{
> +	int err = 0;

int err; (but I'd prefer this to be called "ret" instead)

> +
> +	mutex_lock(&optee_private->tee_mutex);
> +	if (atomic_inc_return(&optee_private->tee_active_cnt) > 1) {
> +		mutex_unlock(&optee_private->tee_mutex);
> +		pr_debug(MTK_DBG_VCODEC_STR "already init vdec optee private data!\n");

dev_dbg()?

> +		return err;

Did you really want to return 0? In that case, don't return err, but just 0.

> +	}
> +
> +	/* Open context with TEE driver */
> +	optee_private->tee_vdec_ctx = tee_client_open_context(NULL, mtk_vcodec_dec_optee_match,
> +							      NULL, NULL);
> +	if (IS_ERR(optee_private->tee_vdec_ctx)) {
> +		pr_err(MTK_DBG_VCODEC_STR "optee vdec tee context failed.\n");

dev_err()?
		err = PTR_ERR(optee_private->tee_vdec_ctx);
		goto err_ctx_open;
	}
> +		mutex_unlock(&optee_private->tee_mutex);
> +		return -ENODEV;
> +	}
> +
> +	err = mtk_vcodec_dec_optee_init_hw_info(optee_private, MTK_VDEC_LAT0);
> +	if (err < 0)
> +		goto err_lat_init;
> +
> +	if (IS_VDEC_LAT_ARCH(optee_private->vcodec_dev->vdec_pdata->hw_arch)) {
> +		err = mtk_vcodec_dec_optee_init_hw_info(optee_private, MTK_VDEC_CORE);
> +		if (err < 0)
> +			goto err_core_init;
> +	}
> +
> +	mutex_unlock(&optee_private->tee_mutex);
> +	return 0;
> +err_core_init:
> +	mtk_vcodec_dec_optee_deinit_hw_info(optee_private, MTK_VDEC_LAT0);
> +err_lat_init:
> +	tee_client_close_context(optee_private->tee_vdec_ctx);
> +

err_ctx_open:

> +	mutex_unlock(&optee_private->tee_mutex);
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(mtk_vcodec_dec_optee_open);
> +

Regards,
Angelo


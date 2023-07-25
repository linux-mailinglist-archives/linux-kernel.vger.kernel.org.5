Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD25760D11
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 10:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbjGYIfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 04:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjGYIfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:35:01 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492CEA9;
        Tue, 25 Jul 2023 01:34:59 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36P5Bp40003874;
        Tue, 25 Jul 2023 10:34:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=m/27ndbTvIPEF5TBfSfb9GuHZ6mX2ojo3q8sYuL9QS0=;
 b=RDCWcVIMhivFxwEBbAyeFRNrWI/Het1146FDvtdVzz0m+afIAOP67RuMazANRzyXpD8N
 Qw8U8YNwCpIWy3OXsfixvHDrVuDSGOeR43MZl+HxCR2sFIzt1EILoV3xV07ctvMvq5+f
 mW+LxTj3B4/4soALN1Jz22SLvB9apU3RO/PB7WIduPFmhrbuQRjphhsP0PwZpqiK6tOT
 S3+M83tkRTck3GPNbQ6Tmi0yZ9fD8+DkUFDeo7duu3oR7gSC0TfbGyriV6hE606yPz5W
 cQhcHclg6YkpqzDFzkA4F8Ws80EuUY6OUp22fXmRUjm5+vBVgC64qyooftZgffJcApZf Kw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3s281bs8rh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 10:34:39 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6F07510002A;
        Tue, 25 Jul 2023 10:34:38 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 644C7217B9B;
        Tue, 25 Jul 2023 10:34:38 +0200 (CEST)
Received: from [10.201.22.29] (10.201.22.29) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 25 Jul
 2023 10:34:37 +0200
Message-ID: <da0de3ba-28b7-2138-733a-7d12ec0b5206@foss.st.com>
Date:   Tue, 25 Jul 2023 10:34:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/2] media: stm32: dcmi: only call s_stream on the
 source subdev
Content-Language: en-US
To:     Alain Volmat <alain.volmat@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-media@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230721120316.1172445-1-alain.volmat@foss.st.com>
 <20230721120316.1172445-3-alain.volmat@foss.st.com>
From:   Hugues FRUCHET <hugues.fruchet@foss.st.com>
In-Reply-To: <20230721120316.1172445-3-alain.volmat@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.22.29]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_04,2023-07-24_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Hugues FRUCHET <hugues.fruchet@foss.st.com>

On 7/21/23 14:03, Alain Volmat wrote:
> Avoid calling s_stream on each subdev until reaching the sensor and
> instead call s_stream on the source subdev only (which will in turn
> do whatever needed to start the stream).
> 
> Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
> ---
>   drivers/media/platform/st/stm32/stm32-dcmi.c | 63 +++++---------------
>   1 file changed, 14 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/media/platform/st/stm32/stm32-dcmi.c b/drivers/media/platform/st/stm32/stm32-dcmi.c
> index dad6e22e4ce4..ac8a5031dce6 100644
> --- a/drivers/media/platform/st/stm32/stm32-dcmi.c
> +++ b/drivers/media/platform/st/stm32/stm32-dcmi.c
> @@ -134,6 +134,7 @@ struct stm32_dcmi {
>   	struct video_device		*vdev;
>   	struct v4l2_async_notifier	notifier;
>   	struct v4l2_subdev		*source;
> +	struct v4l2_subdev		*s_subdev;
>   	struct v4l2_format		fmt;
>   	struct v4l2_rect		crop;
>   	bool				do_crop;
> @@ -692,51 +693,6 @@ static int dcmi_pipeline_s_fmt(struct stm32_dcmi *dcmi,
>   	return 0;
>   }
>   
> -static int dcmi_pipeline_s_stream(struct stm32_dcmi *dcmi, int state)
> -{
> -	struct media_entity *entity = &dcmi->vdev->entity;
> -	struct v4l2_subdev *subdev;
> -	struct media_pad *pad;
> -	int ret;
> -
> -	/* Start/stop all entities within pipeline */
> -	while (1) {
> -		pad = &entity->pads[0];
> -		if (!(pad->flags & MEDIA_PAD_FL_SINK))
> -			break;
> -
> -		pad = media_pad_remote_pad_first(pad);
> -		if (!pad || !is_media_entity_v4l2_subdev(pad->entity))
> -			break;
> -
> -		entity = pad->entity;
> -		subdev = media_entity_to_v4l2_subdev(entity);
> -
> -		ret = v4l2_subdev_call(subdev, video, s_stream, state);
> -		if (ret < 0 && ret != -ENOIOCTLCMD) {
> -			dev_err(dcmi->dev, "%s: \"%s\" failed to %s streaming (%d)\n",
> -				__func__, subdev->name,
> -				state ? "start" : "stop", ret);
> -			return ret;
> -		}
> -
> -		dev_dbg(dcmi->dev, "\"%s\" is %s\n",
> -			subdev->name, state ? "started" : "stopped");
> -	}
> -
> -	return 0;
> -}
> -
> -static int dcmi_pipeline_start(struct stm32_dcmi *dcmi)
> -{
> -	return dcmi_pipeline_s_stream(dcmi, 1);
> -}
> -
> -static void dcmi_pipeline_stop(struct stm32_dcmi *dcmi)
> -{
> -	dcmi_pipeline_s_stream(dcmi, 0);
> -}
> -
>   static int dcmi_start_streaming(struct vb2_queue *vq, unsigned int count)
>   {
>   	struct stm32_dcmi *dcmi = vb2_get_drv_priv(vq);
> @@ -758,9 +714,12 @@ static int dcmi_start_streaming(struct vb2_queue *vq, unsigned int count)
>   		goto err_pm_put;
>   	}
>   
> -	ret = dcmi_pipeline_start(dcmi);
> -	if (ret)
> +	ret = v4l2_subdev_call(dcmi->s_subdev, video, s_stream, 1);
> +	if (ret < 0) {
> +		dev_err(dcmi->dev, "%s: Failed to start source subdev, error (%d)\n",
> +			__func__, ret);
>   		goto err_media_pipeline_stop;
> +	}
>   
>   	spin_lock_irq(&dcmi->irqlock);
>   
> @@ -862,7 +821,7 @@ static int dcmi_start_streaming(struct vb2_queue *vq, unsigned int count)
>   	return 0;
>   
>   err_pipeline_stop:
> -	dcmi_pipeline_stop(dcmi);
> +	v4l2_subdev_call(dcmi->s_subdev, video, s_stream, 0);
>   
>   err_media_pipeline_stop:
>   	video_device_pipeline_stop(dcmi->vdev);
> @@ -889,8 +848,12 @@ static void dcmi_stop_streaming(struct vb2_queue *vq)
>   {
>   	struct stm32_dcmi *dcmi = vb2_get_drv_priv(vq);
>   	struct dcmi_buf *buf, *node;
> +	int ret;
>   
> -	dcmi_pipeline_stop(dcmi);
> +	ret = v4l2_subdev_call(dcmi->s_subdev, video, s_stream, 0);
> +	if (ret < 0)
> +		dev_err(dcmi->dev, "%s: Failed to stop source subdev, error (%d)\n",
> +			__func__, ret);
>   
>   	video_device_pipeline_stop(dcmi->vdev);
>   
> @@ -1876,6 +1839,8 @@ static int dcmi_graph_notify_bound(struct v4l2_async_notifier *notifier,
>   		dev_dbg(dcmi->dev, "DCMI is now linked to \"%s\"\n",
>   			subdev->name);
>   
> +	dcmi->s_subdev = subdev;
> +
>   	return ret;
>   }
>   

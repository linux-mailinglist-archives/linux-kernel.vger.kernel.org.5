Return-Path: <linux-kernel+bounces-56907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F0F84D131
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00C2E1F25AEA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB18982D84;
	Wed,  7 Feb 2024 18:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="NP1eAyhP"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DAD82D83
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 18:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707330575; cv=none; b=vD7XhE4nPIWhzOQ80C/sbGZuI8zOZHFUbVS22yYtZUjqxLeJZGv59LG2zAbeQP7cTLy9bboKDyQHYM9fJub9LboWlrI0ou05OjWNb/DcXlqqkjLLwUqpUHNe0fN5aXN/MjE1SqRvhDv58MiVGIsIqXk2yqdDYL6ncubNWGdsnck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707330575; c=relaxed/simple;
	bh=TVRTmtF83I7kvr8jh6r5+IlYG2yU8OI//BUtzqkcnJs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LAcABeIprFE6bwHL2gJuEiqXxKaKXnz3PNMxBYRWgeMZU6jhxL4v2q9N818CRWVBH+J/+UxTzaDMHzCxAyAsrrNAuUP4hL3SpoKdLRcYemZMU2qJbL/8gnJHG6vizRviI9z6SMf8SBqgPT+m5lbZzO5R7DMP2cXVix66ctT6uBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=NP1eAyhP; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc6e08fde11so1019705276.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 10:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1707330572; x=1707935372; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TRt8VTA+u9NEnHjDx3VvhSY7mO3I7aBOn8GbtpBIih8=;
        b=NP1eAyhPY7KFEiovnZJdGgDAUolR5Iom0drT3iLRdrkAmPfoCGfPFUSMQrVAGNYDlW
         LoJsUwlKO4UDueKm16BUt8Utkxz8T2tih0F8NULXXBFdfxDtTSko13NdhvW3GVr1XyMP
         fddw1rAb8YkdYnYeB+fZMQQzbeAwaqGA4UTXnq7qdZo7/WdmhpuMR7qwpT9QzwLbma8Z
         1PV52GTThDB7A8X5ornu0GNz/g6InklIzog24rkm3FRwsyVo4MZBeyxu2vHAjbniUW6/
         6iXaKBAKQp4Er++feOOFTAyvvFuHxswXry0dVmY4M5FerZWxUrYD2MPj3cYuY7YU21Vf
         nN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707330572; x=1707935372;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TRt8VTA+u9NEnHjDx3VvhSY7mO3I7aBOn8GbtpBIih8=;
        b=eSRcjuFNS9u21L9u7DNuyOEhGZcjjaDNaKbnYd5NFjItql0tB5efxSM4kUStF6NbWg
         pEeRr9ivqbxcl42tOAQy0p3OpkMpk6mRfwmisDmdxIGuP5S/7XFeZsFLfEYM3gzwiEAZ
         cX6lQhavMLbZwEsbmEB7tdKZrFwNBavCMJ7MQILsMvn4xdXKKlB26VpZHED2THOk5bMC
         RQ03nOj62NSpeskkXNXa1YS4+L81D3odTVL1susV49Cv+mt7HkFh/77HSoPFXR4EMpV2
         W5O1XnIKGKg8btyztlGIBi43MoXFhIqJ0Zu4eR1C/Y0UXLXI8sl/FngV1P3ku/3XnOeF
         KPRQ==
X-Gm-Message-State: AOJu0YyrkPCVDvJ5P/8QeYb/wYlrosOWFUo5mZ4unHTrcpeCsP3BeZwU
	jY5hn0uDCuLl6eh/zWrJnxud/CsHjP5kw7ucF5cKFAyo/4Hs3i8ifVnOlu53d/J/eb7EiaCwmL5
	R
X-Google-Smtp-Source: AGHT+IGza5alMJlDuaqYw82hcCdMvJg0eoZqQpD+SWvtYe0txDto0N6/IcFzvkHQqkdtViOKFFU03A==
X-Received: by 2002:a5b:991:0:b0:dbd:d617:7f14 with SMTP id c17-20020a5b0991000000b00dbdd6177f14mr5482810ybq.10.1707330572479;
        Wed, 07 Feb 2024 10:29:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXbCCr81oEQ5YYeQ0g/mHVCaWSoX2DFpkJ79r8yfvPeLAjsg0QkIK0OTDEpYXSI9fTQhxKFIrxiDWaeSe+w/3GGmgPlVk10TA4fmmrdLGspypfZau/T17kBt70HQT7byOpkj4G1JndT5gK45LL0f28wbXc8rpVRnDyqW76wyERNvtqDwHimsPFbsaDnFSgXVoBbYkWkkkA4JqsZBRYyCCE8T12tqG6/SdWA
Received: from nicolas-tpx395.localdomain ([2606:6d00:11:3354::7a9])
        by smtp.gmail.com with ESMTPSA id x13-20020ae9f80d000000b00785934cdb43sm739056qkh.125.2024.02.07.10.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 10:29:32 -0800 (PST)
Message-ID: <efe24b949a60034bf618eb3b8a8ba82e8a5dc99c.camel@ndufresne.ca>
Subject: Re: [RESEND PATCH v0 3/5] wave5 : Support runtime suspend/resume.
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: "jackson.lee" <jackson.lee@chipsnmedia.com>, mchehab@kernel.org, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nas.chung@chipsnmedia.com
Cc: lafley.kim@chipsnmedia.com, b-brnich@ti.com
Date: Wed, 07 Feb 2024 13:29:31 -0500
In-Reply-To: <20240131013046.15687-4-jackson.lee@chipsnmedia.com>
References: <20240131013046.15687-1-jackson.lee@chipsnmedia.com>
	 <20240131013046.15687-4-jackson.lee@chipsnmedia.com>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Jackson,

Le mercredi 31 janvier 2024 =C3=A0 10:30 +0900, jackson.lee a =C3=A9crit=C2=
=A0:
> There are two device run-time PM callbacks defined in 'struct dev_pm_ops'
> int (*runtime_suspend)(struct device *dev);
> int (*runtime_resume)(struct device *dev);

I wonder how useful is it to teach everyone what the generic 'struct dev_pm=
_ops'
contains. Perhaps you simply wanted that this patch implement both suspend =
and
resume ops ?

>=20
> Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
> Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
> ---
>  .../platform/chips-media/wave5/wave5-hw.c     |  5 +-
>  .../chips-media/wave5/wave5-vpu-dec.c         |  9 +++
>  .../chips-media/wave5/wave5-vpu-enc.c         |  9 +++
>  .../platform/chips-media/wave5/wave5-vpu.c    | 68 +++++++++++++++++++
>  .../platform/chips-media/wave5/wave5-vpuapi.c |  7 ++
>  .../media/platform/chips-media/wave5/wave5.h  |  3 +
>  6 files changed, 99 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-hw.c b/driver=
s/media/platform/chips-media/wave5/wave5-hw.c
> index 8ad7f3a28ae1..8aade5a38439 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-hw.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-hw.c
> @@ -503,6 +503,7 @@ int wave5_vpu_build_up_dec_param(struct vpu_instance =
*inst,
>  	/* This register must be reset explicitly */
>  	vpu_write_reg(inst->dev, W5_CMD_EXT_ADDR, 0);
>  	vpu_write_reg(inst->dev, W5_CMD_NUM_CQ_DEPTH_M1, (COMMAND_QUEUE_DEPTH -=
 1));
> +	vpu_write_reg(inst->dev, W5_CMD_ERR_CONCEAL, 0);

In some way, the relation between suspend and this register write is not
obvious. If its not related, please do this in its own patch. Otherwise you=
 want
to explain why you needed this (possibly just in the commit message).

> =20
>  	ret =3D send_firmware_command(inst, W5_CREATE_INSTANCE, true, NULL, NUL=
L);
>  	if (ret) {
> @@ -1075,8 +1076,8 @@ int wave5_vpu_re_init(struct device *dev, u8 *fw, s=
ize_t size)
>  	return setup_wave5_properties(dev);
>  }
> =20
> -static int wave5_vpu_sleep_wake(struct device *dev, bool i_sleep_wake, c=
onst uint16_t *code,
> -				size_t size)
> +int wave5_vpu_sleep_wake(struct device *dev, bool i_sleep_wake, const ui=
nt16_t *code,
> +			 size_t size)
>  {
>  	u32 reg_val;
>  	struct vpu_buf *common_vb;
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/d=
rivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> index ef227af72348..328a7a8f26c5 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> @@ -5,6 +5,7 @@
>   * Copyright (C) 2021-2023 CHIPS&MEDIA INC
>   */
> =20
> +#include <linux/pm_runtime.h>
>  #include "wave5-helper.h"
> =20
>  #define VPU_DEC_DEV_NAME "C&M Wave5 VPU decoder"
> @@ -1387,9 +1388,17 @@ static int wave5_vpu_dec_start_streaming(struct vb=
2_queue *q, unsigned int count
> =20
>  	if (q->type =3D=3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE && inst->state =3D=
=3D VPU_INST_STATE_NONE) {
>  		struct dec_open_param open_param;
> +		int err =3D 0;
> =20
>  		memset(&open_param, 0, sizeof(struct dec_open_param));
> =20
> +		err =3D pm_runtime_resume_and_get(inst->dev->dev);
> +		if (err) {
> +			dev_err(inst->dev->dev, "decoder runtime resume failed %d\n", err);
> +			ret =3D -EINVAL;
> +			goto return_buffers;
> +		}
> +
>  		ret =3D wave5_vpu_dec_allocate_ring_buffer(inst);
>  		if (ret)
>  			goto return_buffers;
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/d=
rivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> index 761775216cd4..ff73d69de41c 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> @@ -5,6 +5,7 @@
>   * Copyright (C) 2021-2023 CHIPS&MEDIA INC
>   */
> =20
> +#include <linux/pm_runtime.h>
>  #include "wave5-helper.h"
> =20
>  #define VPU_ENC_DEV_NAME "C&M Wave5 VPU encoder"
> @@ -1387,9 +1388,17 @@ static int wave5_vpu_enc_start_streaming(struct vb=
2_queue *q, unsigned int count
> =20
>  	if (inst->state =3D=3D VPU_INST_STATE_NONE && q->type =3D=3D V4L2_BUF_T=
YPE_VIDEO_OUTPUT_MPLANE) {
>  		struct enc_open_param open_param;
> +		int err =3D 0;
> =20
>  		memset(&open_param, 0, sizeof(struct enc_open_param));
> =20
> +		err =3D pm_runtime_resume_and_get(inst->dev->dev);
> +		if (err) {
> +			dev_err(inst->dev->dev, "encoder runtime resume failed %d\n", err);
> +			ret =3D -EINVAL;
> +			goto return_buffers;
> +		}
> +
>  		wave5_set_enc_openparam(&open_param, inst);
> =20
>  		ret =3D wave5_vpu_enc_open(inst, &open_param);
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c b/drive=
rs/media/platform/chips-media/wave5/wave5-vpu.c
> index 0d90b5820bef..f81409740a56 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> @@ -10,6 +10,7 @@
>  #include <linux/clk.h>
>  #include <linux/firmware.h>
>  #include <linux/interrupt.h>
> +#include <linux/pm_runtime.h>
>  #include "wave5-vpu.h"
>  #include "wave5-regdefine.h"
>  #include "wave5-vpuconfig.h"
> @@ -117,6 +118,65 @@ static int wave5_vpu_load_firmware(struct device *de=
v, const char *fw_name,
>  	return 0;
>  }
> =20
> +static __maybe_unused int wave5_pm_suspend(struct device *dev)
> +{
> +	struct vpu_device *vpu =3D dev_get_drvdata(dev);
> +
> +	if (pm_runtime_suspended(dev))
> +		return 0;
> +
> +	wave5_vpu_sleep_wake(dev, true, NULL, 0);
> +	clk_bulk_disable_unprepare(vpu->num_clks, vpu->clks);
> +
> +	return 0;
> +}
> +
> +static __maybe_unused int wave5_pm_resume(struct device *dev)
> +{
> +	struct vpu_device *vpu =3D dev_get_drvdata(dev);
> +	int ret =3D 0;
> +
> +	wave5_vpu_sleep_wake(dev, false, NULL, 0);
> +	ret =3D clk_bulk_prepare_enable(vpu->num_clks, vpu->clks);
> +	if (ret) {
> +		dev_err(dev, "Enabling clocks, fail: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static __maybe_unused int wave5_suspend(struct device *dev)
> +{
> +	struct vpu_device *vpu =3D dev_get_drvdata(dev);
> +	struct vpu_instance *inst;
> +
> +	list_for_each_entry(inst, &vpu->instances, list)
> +		v4l2_m2m_suspend(inst->v4l2_m2m_dev);
> +
> +	return pm_runtime_force_suspend(dev);
> +}
> +
> +static __maybe_unused int wave5_resume(struct device *dev)
> +{
> +	struct vpu_device *vpu =3D dev_get_drvdata(dev);
> +	struct vpu_instance *inst;
> +	int ret =3D 0;
> +
> +	ret =3D pm_runtime_force_resume(dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	list_for_each_entry(inst, &vpu->instances, list)
> +		v4l2_m2m_resume(inst->v4l2_m2m_dev);
> +
> +	return ret;
> +}

The functions wave5_suspend() and wave5_resume() are not just "maybe_unsued=
" but
actually never used. What was the intention ? Considering the usage of
__maybe_unused has been such a bad friend for this one, could you instead
bracket the functions with an explicit ?

#ifdef CONFIG_PM
#endif

This way the compiler will have a word if you implement something that you
forgot to actually use.

> +
> +static const struct dev_pm_ops wave5_pm_ops =3D {
> +	SET_RUNTIME_PM_OPS(wave5_pm_suspend, wave5_pm_resume, NULL)
> +};
> +
>  static int wave5_vpu_probe(struct platform_device *pdev)
>  {
>  	int ret;
> @@ -232,6 +292,10 @@ static int wave5_vpu_probe(struct platform_device *p=
dev)
>  		 (match_data->flags & WAVE5_IS_DEC) ? "'DECODE'" : "");
>  	dev_info(&pdev->dev, "Product Code:      0x%x\n", dev->product_code);
>  	dev_info(&pdev->dev, "Firmware Revision: %u\n", fw_revision);
> +
> +	pm_runtime_enable(&pdev->dev);
> +	wave5_vpu_sleep_wake(&pdev->dev, true, NULL, 0);
> +
>  	return 0;
> =20
>  err_enc_unreg:
> @@ -254,6 +318,9 @@ static int wave5_vpu_remove(struct platform_device *p=
dev)
>  {
>  	struct vpu_device *dev =3D dev_get_drvdata(&pdev->dev);
> =20
> +	pm_runtime_put_sync(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
> +
>  	mutex_destroy(&dev->dev_lock);
>  	mutex_destroy(&dev->hw_lock);
>  	clk_bulk_disable_unprepare(dev->num_clks, dev->clks);
> @@ -281,6 +348,7 @@ static struct platform_driver wave5_vpu_driver =3D {
>  	.driver =3D {
>  		.name =3D VPU_PLATFORM_DEVICE_NAME,
>  		.of_match_table =3D of_match_ptr(wave5_dt_ids),
> +		.pm =3D &wave5_pm_ops,
>  		},
>  	.probe =3D wave5_vpu_probe,
>  	.remove =3D wave5_vpu_remove,
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c b/dr=
ivers/media/platform/chips-media/wave5/wave5-vpuapi.c
> index 1a3efb638dde..f1f8e4fc8474 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
> @@ -6,6 +6,7 @@
>   */
> =20
>  #include <linux/bug.h>
> +#include <linux/pm_runtime.h>
>  #include "wave5-vpuapi.h"
>  #include "wave5-regdefine.h"
>  #include "wave5.h"
> @@ -232,6 +233,9 @@ int wave5_vpu_dec_close(struct vpu_instance *inst, u3=
2 *fail_res)
> =20
>  	wave5_vdi_free_dma_memory(vpu_dev, &p_dec_info->vb_task);
> =20
> +	if (!pm_runtime_suspended(inst->dev->dev))
> +		pm_runtime_put_sync(inst->dev->dev);
> +
>  unlock_and_return:
>  	mutex_unlock(&vpu_dev->hw_lock);
> =20
> @@ -734,6 +738,9 @@ int wave5_vpu_enc_close(struct vpu_instance *inst, u3=
2 *fail_res)
> =20
>  	wave5_vdi_free_dma_memory(vpu_dev, &p_enc_info->vb_task);
> =20
> +	if (!pm_runtime_suspended(inst->dev->dev))
> +		pm_runtime_put_sync(inst->dev->dev);

This seems very unnatural. We do the get() in "start_streaming()", but the =
put()
is only done when the device is closed, or when the driver is removed. As t=
his
is not balanced, you seem to have to check the suspended condition all over=
 the
place.

I think we could aim for start_streaming()/stop_streaming() for your get/pu=
t
placement. At least they will be bound to an entirely balanced API. But the=
n, a
media player in paused sate will prevent that device from being suspended.

If the HW is capable of preserving enough state, and From the short doc I h=
ave
it gives me the impression it can preserve that, I'd suggest to follow what
hantro driver is doing. What is does is that it will do get() in device_run=
(),
and put() whenever the job completes. This driver has been designed so when
there is no job, it means the firmware is currently idle and looking for mo=
re
work. So it seems like the perfect moment to do suspend it.

Nicolas

> +
>  	mutex_unlock(&vpu_dev->hw_lock);
> =20
>  	return 0;
> diff --git a/drivers/media/platform/chips-media/wave5/wave5.h b/drivers/m=
edia/platform/chips-media/wave5/wave5.h
> index 063028eccd3b..6125eff938a8 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5.h
> +++ b/drivers/media/platform/chips-media/wave5/wave5.h
> @@ -56,6 +56,9 @@ int wave5_vpu_get_version(struct vpu_device *vpu_dev, u=
32 *revision);
> =20
>  int wave5_vpu_init(struct device *dev, u8 *fw, size_t size);
> =20
> +int wave5_vpu_sleep_wake(struct device *dev, bool i_sleep_wake, const ui=
nt16_t *code,
> +			 size_t size);
> +
>  int wave5_vpu_reset(struct device *dev, enum sw_reset_mode reset_mode);
> =20
>  int wave5_vpu_build_up_dec_param(struct vpu_instance *inst, struct dec_o=
pen_param *param);



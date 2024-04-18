Return-Path: <linux-kernel+bounces-150773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 095768AA460
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 22:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CE901C232E5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2191E19069F;
	Thu, 18 Apr 2024 20:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="eAbZ2Jw3"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEAC1836F3
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 20:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713473455; cv=none; b=D0mA64cfugSaRhQQI1/9RszDocxbZEOsqtVty3bqhm5ZZ2N2F7VxSPznpPdcPijJ5aT1lF42AtQmD2kLFVTyIQVCHwmiWHJcQXtttkCXZmYrmolSdBfpkqzwfSN+L8eID62PKSlpDo+3LUIADWRff1ALAu3QcSIYi+1UhHBS/Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713473455; c=relaxed/simple;
	bh=Byst5ny1r7KtME6U5F1PgFA5YeFnIjcPfjX8ATGcJp8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BOCGfgpN+j2pDhF2Ja7c7ObZ5ZZhdiMLA8tq9YRqrVAV+CmK+sgKjnMsgGZcXWtRIOi6FgDfPxF/95agA2CrFUYRf5Of8yyP3IrjrMtoFKMcjAv6/gDLbAx0MosF4WEQdlUVmOAOjoUaxgUTS0A7u4YGN3Q2WjNbaCmDqVdZUfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=eAbZ2Jw3; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78f02298dc6so114936285a.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 13:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1713473452; x=1714078252; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9Xg5E7b4rna9L5u4IShunK0QDaAkLrW2e0JoNyGCrbY=;
        b=eAbZ2Jw3n8/wzPeJAJZGS/yfJ5HYRy/uNac4ZiUNVdYL3630ddUP8cQswt/oRVZL/1
         kkh8DeO4NmL4eEj3H1eqZtGatr3Ib5OX+bjkhhR9gufGu8zwXXx+c1tFyJ4JGxIRvABD
         +xAQwc+t2ycPxayOg1mHxBy6x11H8HpRlCGSUVR4dyow9iuVAaWuwYL/xcHOl8q4jxsm
         ICC9CLtwFLFbizZkW1iWsBUbkrdkvn71I2QJCXaYxa4XxXEIsRxjYo7ieqI384l0AC17
         TFkHNwBKOVqvqxeoXdVnpdo/Jno3R89Y+wGglTQGWlTyCdKKNHvXDfjzRnFDq3tniwwm
         vM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713473452; x=1714078252;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Xg5E7b4rna9L5u4IShunK0QDaAkLrW2e0JoNyGCrbY=;
        b=ZB9HmY8qSvc/osiiC68Q0IjafccaVQxro5ZMjJP97pmnufoEBvEzv8qREy/4Y0aAgj
         COPHt5rGK1IOwC8tfS8EyRHz2XthNwDrAVbG6HNXWFIrGT6AK/gY2/AcXVhi6iZSlbxC
         EtNi2JVfCy6M04ZzAsPmKnKUTr3awx5qsNtAuA2RwBwEfulv2WS8RnTa06hDO0qm5FI/
         lIRRxvfaXrvPW4EVOcInyYDOw+U4c/hT11RuefVHVbzVvJ9nc+YQNaftgCrXZ1tSpyE0
         GNVxZgSlTKbCyaLjEZnDzezvYqRLtihsgSriBtq1/ZTpHaRzXGdHEQcscrvUolzTobAq
         7DYA==
X-Forwarded-Encrypted: i=1; AJvYcCUcUhzXLZ37qrsqmLDOAER6b7/G144B+ALqoPRltvs6Oe3unFZkcbqYSgvC2Uyr0ON9B4Qzk0qLxbpqyf9hHhj1LEmdvCi3v8UNJ2cD
X-Gm-Message-State: AOJu0YzD879UeFib0tJL6rlUfkVw3quPbQNwYSneWRBr1qujMU7Tzcht
	mBrMfxDs1EOa/xyd5NEn4HumWw/3M/as03obX0UOkO6EWuqCdpYT2QdXU5VVnkY=
X-Google-Smtp-Source: AGHT+IEpdxw3QKu6kK0I4Wmq8PRCBF6Yl7OqYOgNkBl0E0rz/Tr+Lob5RsYFRjEkxhDD4IJO9Odx7Q==
X-Received: by 2002:a05:620a:1a22:b0:78f:1ae:6218 with SMTP id bk34-20020a05620a1a2200b0078f01ae6218mr5666472qkb.9.1713473451907;
        Thu, 18 Apr 2024 13:50:51 -0700 (PDT)
Received: from nicolas-tpx395.localdomain ([2606:6d00:17:6448::7a9])
        by smtp.gmail.com with ESMTPSA id c17-20020a05620a135100b0078d761e7b50sm959516qkl.106.2024.04.18.13.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 13:50:51 -0700 (PDT)
Message-ID: <89793e13775003799018a4dcf86c55c993603c57.camel@ndufresne.ca>
Subject: Re: [RESEND PATCH v2 2/4] media: chips-media: wave5: Support
 runtime suspend/resume
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: "jackson.lee" <jackson.lee@chipsnmedia.com>, mchehab@kernel.org, 
	sebastian.fricke@collabora.com
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	hverkuil@xs4all.nl, nas.chung@chipsnmedia.com, lafley.kim@chipsnmedia.com, 
	b-brnich@ti.com
Date: Thu, 18 Apr 2024 16:50:50 -0400
In-Reply-To: <20240311105623.20406-3-jackson.lee@chipsnmedia.com>
References: <20240311105623.20406-1-jackson.lee@chipsnmedia.com>
	 <20240311105623.20406-3-jackson.lee@chipsnmedia.com>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Le lundi 11 mars 2024 =C3=A0 19:56 +0900, jackson.lee a =C3=A9crit=C2=A0:
> From: "Jackson.lee" <jackson.lee@chipsnmedia.com>
>=20
> For saving a power resource, we support runtime suspend/resume for an enc=
oder/decoder.
> So our vpu module's power turns on only if an encoder/decoder is used.

As per guidelines, try to be more direct on what the patch do and make it l=
ess
looks like a discussion. Something like (I'm not sure it totally exact)

   Add support for runtime suspend/resume in the encoder and decoder. This =
is
   achieved by saving the VPU state and powering it off while the VPU idle.

>=20
> Signed-off-by: Jackson.lee <jackson.lee@chipsnmedia.com>
> Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
> ---
>  .../platform/chips-media/wave5/wave5-hw.c     |  4 +-
>  .../chips-media/wave5/wave5-vpu-dec.c         | 16 ++++++-
>  .../chips-media/wave5/wave5-vpu-enc.c         | 15 +++++++
>  .../platform/chips-media/wave5/wave5-vpu.c    | 43 +++++++++++++++++++
>  .../platform/chips-media/wave5/wave5-vpuapi.c | 14 ++++--
>  .../media/platform/chips-media/wave5/wave5.h  |  3 ++
>  6 files changed, 88 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-hw.c b/driver=
s/media/platform/chips-media/wave5/wave5-hw.c
> index 4a262822bf17..826b92b7b582 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-hw.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-hw.c
> @@ -1084,8 +1084,8 @@ int wave5_vpu_re_init(struct device *dev, u8 *fw, s=
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
> index ef227af72348..a199877c643b 100644
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
> @@ -518,6 +519,8 @@ static void wave5_vpu_dec_finish_decode(struct vpu_in=
stance *inst)
>  	if (q_status.report_queue_count =3D=3D 0 &&
>  	    (q_status.instance_queue_count =3D=3D 0 || dec_info.sequence_change=
d)) {
>  		dev_dbg(inst->dev->dev, "%s: finishing job.\n", __func__);
> +		pm_runtime_mark_last_busy(inst->dev->dev);
> +		pm_runtime_put_autosuspend(inst->dev->dev);
>  		v4l2_m2m_job_finish(inst->v4l2_m2m_dev, m2m_ctx);
>  	}
>  }
> @@ -1382,6 +1385,7 @@ static int wave5_vpu_dec_start_streaming(struct vb2=
_queue *q, unsigned int count
>  	int ret =3D 0;
> =20
>  	dev_dbg(inst->dev->dev, "%s: type: %u\n", __func__, q->type);
> +	pm_runtime_resume_and_get(inst->dev->dev);
> =20
>  	v4l2_m2m_update_start_streaming_state(m2m_ctx, q);
> =20
> @@ -1425,13 +1429,15 @@ static int wave5_vpu_dec_start_streaming(struct v=
b2_queue *q, unsigned int count
>  			}
>  		}
>  	}
> -
> +	pm_runtime_mark_last_busy(inst->dev->dev);
> +	pm_runtime_put_autosuspend(inst->dev->dev);
>  	return ret;
> =20
>  free_bitstream_vbuf:
>  	wave5_vdi_free_dma_memory(inst->dev, &inst->bitstream_vbuf);
>  return_buffers:
>  	wave5_return_bufs(q, VB2_BUF_STATE_QUEUED);
> +	pm_runtime_put_autosuspend(inst->dev->dev);
>  	return ret;
>  }
> =20
> @@ -1517,6 +1523,7 @@ static void wave5_vpu_dec_stop_streaming(struct vb2=
_queue *q)
>  	bool check_cmd =3D TRUE;
> =20
>  	dev_dbg(inst->dev->dev, "%s: type: %u\n", __func__, q->type);
> +	pm_runtime_resume_and_get(inst->dev->dev);
> =20
>  	while (check_cmd) {
>  		struct queue_status_info q_status;
> @@ -1540,6 +1547,9 @@ static void wave5_vpu_dec_stop_streaming(struct vb2=
_queue *q)
>  		streamoff_output(q);
>  	else
>  		streamoff_capture(q);
> +
> +	pm_runtime_mark_last_busy(inst->dev->dev);
> +	pm_runtime_put_autosuspend(inst->dev->dev);
>  }
> =20
>  static const struct vb2_ops wave5_vpu_dec_vb2_ops =3D {
> @@ -1626,7 +1636,7 @@ static void wave5_vpu_dec_device_run(void *priv)
>  	int ret =3D 0;
> =20
>  	dev_dbg(inst->dev->dev, "%s: Fill the ring buffer with new bitstream da=
ta", __func__);
> -
> +	pm_runtime_resume_and_get(inst->dev->dev);
>  	ret =3D fill_ringbuffer(inst);
>  	if (ret) {
>  		dev_warn(inst->dev->dev, "Filling ring buffer failed\n");
> @@ -1709,6 +1719,8 @@ static void wave5_vpu_dec_device_run(void *priv)
> =20
>  finish_job_and_return:
>  	dev_dbg(inst->dev->dev, "%s: leave and finish job", __func__);
> +	pm_runtime_mark_last_busy(inst->dev->dev);
> +	pm_runtime_put_autosuspend(inst->dev->dev);
>  	v4l2_m2m_job_finish(inst->v4l2_m2m_dev, m2m_ctx);
>  }
> =20
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/d=
rivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> index f04baa93a9b7..013e2bb37fbb 100644
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
> @@ -1310,6 +1311,7 @@ static int wave5_vpu_enc_start_streaming(struct vb2=
_queue *q, unsigned int count
>  	struct v4l2_m2m_ctx *m2m_ctx =3D inst->v4l2_fh.m2m_ctx;
>  	int ret =3D 0;
> =20
> +	pm_runtime_resume_and_get(inst->dev->dev);
>  	v4l2_m2m_update_start_streaming_state(m2m_ctx, q);
> =20
>  	if (inst->state =3D=3D VPU_INST_STATE_NONE && q->type =3D=3D V4L2_BUF_T=
YPE_VIDEO_OUTPUT_MPLANE) {
> @@ -1364,9 +1366,13 @@ static int wave5_vpu_enc_start_streaming(struct vb=
2_queue *q, unsigned int count
>  	if (ret)
>  		goto return_buffers;
> =20
> +	pm_runtime_mark_last_busy(inst->dev->dev);
> +	pm_runtime_put_autosuspend(inst->dev->dev);
>  	return 0;
>  return_buffers:
>  	wave5_return_bufs(q, VB2_BUF_STATE_QUEUED);
> +	pm_runtime_mark_last_busy(inst->dev->dev);
> +	pm_runtime_put_autosuspend(inst->dev->dev);
>  	return ret;
>  }
> =20
> @@ -1408,6 +1414,7 @@ static void wave5_vpu_enc_stop_streaming(struct vb2=
_queue *q)
>  	 */
> =20
>  	dev_dbg(inst->dev->dev, "%s: type: %u\n", __func__, q->type);
> +	pm_runtime_resume_and_get(inst->dev->dev);
> =20
>  	if (wave5_vpu_both_queues_are_streaming(inst))
>  		switch_state(inst, VPU_INST_STATE_STOP);
> @@ -1432,6 +1439,9 @@ static void wave5_vpu_enc_stop_streaming(struct vb2=
_queue *q)
>  		streamoff_output(inst, q);
>  	else
>  		streamoff_capture(inst, q);
> +
> +	pm_runtime_mark_last_busy(inst->dev->dev);
> +	pm_runtime_put_autosuspend(inst->dev->dev);
>  }
> =20
>  static const struct vb2_ops wave5_vpu_enc_vb2_ops =3D {
> @@ -1478,6 +1488,7 @@ static void wave5_vpu_enc_device_run(void *priv)
>  	u32 fail_res =3D 0;
>  	int ret =3D 0;
> =20
> +	pm_runtime_resume_and_get(inst->dev->dev);
>  	switch (inst->state) {
>  	case VPU_INST_STATE_PIC_RUN:
>  		ret =3D start_encode(inst, &fail_res);
> @@ -1491,6 +1502,8 @@ static void wave5_vpu_enc_device_run(void *priv)
>  			break;
>  		}
>  		dev_dbg(inst->dev->dev, "%s: leave with active job", __func__);
> +		pm_runtime_mark_last_busy(inst->dev->dev);
> +		pm_runtime_put_autosuspend(inst->dev->dev);
>  		return;
>  	default:
>  		WARN(1, "Execution of a job in state %s is invalid.\n",
> @@ -1498,6 +1511,8 @@ static void wave5_vpu_enc_device_run(void *priv)
>  		break;
>  	}
>  	dev_dbg(inst->dev->dev, "%s: leave and finish job", __func__);
> +	pm_runtime_mark_last_busy(inst->dev->dev);
> +	pm_runtime_put_autosuspend(inst->dev->dev);
>  	v4l2_m2m_job_finish(inst->v4l2_m2m_dev, m2m_ctx);
>  }
> =20
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c b/drive=
rs/media/platform/chips-media/wave5/wave5-vpu.c
> index 0d90b5820bef..8e08461b3515 100644
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
> @@ -117,6 +118,38 @@ static int wave5_vpu_load_firmware(struct device *de=
v, const char *fw_name,
>  	return 0;
>  }
> =20
> +static int wave5_pm_suspend(struct device *dev)
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
> +static int wave5_pm_resume(struct device *dev)
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
> +static const struct dev_pm_ops wave5_pm_ops =3D {
> +	SET_RUNTIME_PM_OPS(wave5_pm_suspend, wave5_pm_resume, NULL)
> +};
> +
>  static int wave5_vpu_probe(struct platform_device *pdev)
>  {
>  	int ret;
> @@ -232,6 +265,12 @@ static int wave5_vpu_probe(struct platform_device *p=
dev)
>  		 (match_data->flags & WAVE5_IS_DEC) ? "'DECODE'" : "");
>  	dev_info(&pdev->dev, "Product Code:      0x%x\n", dev->product_code);
>  	dev_info(&pdev->dev, "Firmware Revision: %u\n", fw_revision);
> +
> +	pm_runtime_set_autosuspend_delay(&pdev->dev, 5000);
> +	pm_runtime_use_autosuspend(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
> +	wave5_vpu_sleep_wake(&pdev->dev, true, NULL, 0);
> +
>  	return 0;
> =20
>  err_enc_unreg:
> @@ -254,6 +293,9 @@ static int wave5_vpu_remove(struct platform_device *p=
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
> @@ -281,6 +323,7 @@ static struct platform_driver wave5_vpu_driver =3D {
>  	.driver =3D {
>  		.name =3D VPU_PLATFORM_DEVICE_NAME,
>  		.of_match_table =3D of_match_ptr(wave5_dt_ids),
> +		.pm =3D &wave5_pm_ops,
>  		},
>  	.probe =3D wave5_vpu_probe,
>  	.remove =3D wave5_vpu_remove,
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c b/dr=
ivers/media/platform/chips-media/wave5/wave5-vpuapi.c
> index 1a3efb638dde..b0911fef232f 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
> @@ -6,6 +6,8 @@
>   */
> =20
>  #include <linux/bug.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/delay.h>
>  #include "wave5-vpuapi.h"
>  #include "wave5-regdefine.h"
>  #include "wave5.h"
> @@ -200,9 +202,13 @@ int wave5_vpu_dec_close(struct vpu_instance *inst, u=
32 *fail_res)
>  	if (!inst->codec_info)
>  		return -EINVAL;
> =20
> +	pm_runtime_resume_and_get(inst->dev->dev);
> +
>  	ret =3D mutex_lock_interruptible(&vpu_dev->hw_lock);
> -	if (ret)
> +	if (ret) {
> +		pm_runtime_put_sync(inst->dev->dev);
>  		return ret;
> +	}
> =20
>  	do {
>  		ret =3D wave5_vpu_dec_finish_seq(inst, fail_res);
> @@ -234,7 +240,7 @@ int wave5_vpu_dec_close(struct vpu_instance *inst, u3=
2 *fail_res)
> =20
>  unlock_and_return:
>  	mutex_unlock(&vpu_dev->hw_lock);
> -
> +	pm_runtime_put_sync(inst->dev->dev);
>  	return ret;
>  }
> =20
> @@ -702,6 +708,8 @@ int wave5_vpu_enc_close(struct vpu_instance *inst, u3=
2 *fail_res)
>  	if (!inst->codec_info)
>  		return -EINVAL;
> =20
> +	pm_runtime_resume_and_get(inst->dev->dev);
> +
>  	ret =3D mutex_lock_interruptible(&vpu_dev->hw_lock);
>  	if (ret)
>  		return ret;
> @@ -733,9 +741,9 @@ int wave5_vpu_enc_close(struct vpu_instance *inst, u3=
2 *fail_res)
>  	}
> =20
>  	wave5_vdi_free_dma_memory(vpu_dev, &p_enc_info->vb_task);
> -
>  	mutex_unlock(&vpu_dev->hw_lock);
> =20
> +	pm_runtime_put_sync(inst->dev->dev);
>  	return 0;
>  }
> =20
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


With a better commit message:

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>



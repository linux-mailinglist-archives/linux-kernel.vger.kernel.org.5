Return-Path: <linux-kernel+bounces-165694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B25848B8FDC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 20:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ECE81F239DD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550001607BB;
	Wed,  1 May 2024 18:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="J+AF/mln"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A3C146D53
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 18:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714589291; cv=none; b=f81AvV4EY9DOAPKzzOBl8cHh2OO/tSJ0ijAX7LZ/birvf3y6tXQbp4F+xoKUDlbW3bxe/Nk1yOawYMgrKT/bGDxwQf5zk1Exx7Ce7qprXuIRJeW2TxF2mP5yQTYqx38eu854z4/9HF8LFfrOasgH7BF4H5PGW6z6cuXLq1MN5qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714589291; c=relaxed/simple;
	bh=CYoVjJ6qTzeUjDPUlvLxY0BSud8fRxs4IvuU7F9gjZU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QIj3GU1BZ18cn6r6tSnz9hDHrFGQxwAq3otBSo3r48vWhz5DpBmWZ9DwjIIM6E3wN179SfTcfdlYr1gKKV4Vq+fr7JiKhQQyCfXAuh4QD5/tlVbg08e9Tc88ajGO+8w7XK0CgVd3pOUkpLI/mbcNudPqHghfVEtOJ0I58s3lJgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=J+AF/mln; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-792639cf4faso125353685a.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 11:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1714589288; x=1715194088; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aJ3PhRmp/5g8QSxWQPLLVXno2lduwCgeodi1DpEqf1E=;
        b=J+AF/mln13giZVvsOqfd8VMmSm3YD41GR7SBTMJd7F6yGUJ2ifSK//cvfNHhrpZcrG
         n3yDdjja+x2sVOEjOiUAeb8UuSRYWVHZ0jm9DURbRfgNmGhwafMv5+K9tbgmepojfZAc
         qMBLLIIuiFFLyQrhoMMf8DyCjS4j9jKGR082k1h833Q4OOcG/yaNc/SZT8nz3rlorh1c
         E/tHOnNqkGUDeazAFYf2AtBytOyyCExSWNzrg4P1AT9iezWCiIqm8WGRmXbuWeDCBtCc
         1uQiL9R3WofBOcQkpN6Fyy9qhCrmYmwDXfXookRXeCyabPa09cOkngsXGpMwwWJUeTY7
         EgBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714589288; x=1715194088;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aJ3PhRmp/5g8QSxWQPLLVXno2lduwCgeodi1DpEqf1E=;
        b=oEIZjNZnY2zm5GUAnh4RcWRestElvFyJAHWDTV+tFv0FKwaTFUTTOUhGkPR7ICIGd/
         AcmK7MbfVbUGbtHgr9nOA1MbmXqCYy5Y2p4HalIoTzWUlxPrnsEcTHbqmDaJ1L7a4RUF
         5xYryXNGRgi8vQRBGdrTI218zRqAN6Tm5xqV+Ywsp5H2jo+BgkbJEu5rFMgj8mAtibhL
         0UptpTDK44Hee7i8OBiB6c/hwOFjLdwhDDscbkUJ5KD4/ZXjCqQje78QopYpdBda7M9d
         GJ0Xr3OSqALE6A4EqYy4b3SA9AeTqjhqV/jfrclFEMoVKpRtuNUA2QzKx0B0TxlruE5M
         KXNg==
X-Forwarded-Encrypted: i=1; AJvYcCXP/UF1OTpzLZ0+NDdHjxw0ZIXQx4Hh9I4nE88fqdsv9IQ1TTYIr83Q8F+y2LpAglXnzLD8AY5L0TkD50MlCnVJAQ+WZ9uOYQt0KYIi
X-Gm-Message-State: AOJu0Yx04kw6UooPqODUtlUULAhtG5ZgDZiKNJ8gfgl946p88dzTu9nk
	7yqJkxhC9akQVETu9GcBuDng3dIdVBYkkrcCtgWHkzJdIlEPoKFkqJWuk9TNWzi+O073PRf+4Oh
	5jrs=
X-Google-Smtp-Source: AGHT+IG358XAWZroNrSie92e9jG98Lrfu4ZsuhbiVboczeN/hH1l1+533nEhGnjkbuVC8Wfnpk4h4Q==
X-Received: by 2002:a05:620a:2689:b0:790:9625:d6d9 with SMTP id c9-20020a05620a268900b007909625d6d9mr4521255qkp.35.1714589288218;
        Wed, 01 May 2024 11:48:08 -0700 (PDT)
Received: from nicolas-tpx395.lan ([2606:6d00:17:6448::7a9])
        by smtp.gmail.com with ESMTPSA id dt14-20020a05620a478e00b0078d735ca917sm12510824qkb.123.2024.05.01.11.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 11:48:07 -0700 (PDT)
Message-ID: <6d18d6aed8da52ac1b9be66347829caa64a62f54.camel@ndufresne.ca>
Subject: Re: [PATCH v3 2/4] media: chips-media: wave5: Support runtime
 suspend/resume
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Nas Chung <nas.chung@chipsnmedia.com>, mchehab@kernel.org, 
	sebastian.fricke@collabora.com
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	hverkuil@xs4all.nl, lafley.kim@chipsnmedia.com, b-brnich@ti.com, 
	jackson.lee@chipnsmedia.com, "Jackson.lee" <jackson.lee@chipsnmedia.com>
Date: Wed, 01 May 2024 14:48:07 -0400
In-Reply-To: <20240430013900.187-3-nas.chung@chipsnmedia.com>
References: <20240430013900.187-1-nas.chung@chipsnmedia.com>
	 <20240430013900.187-3-nas.chung@chipsnmedia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Le mardi 30 avril 2024 =C3=A0 10:38 +0900, Nas Chung a =C3=A9crit=C2=A0:
> From: "Jackson.lee" <jackson.lee@chipsnmedia.com>
>=20
> Add support for runtime suspend/resume in the encoder and decoder. This i=
s
> achieved by saving the VPU state and powering it off while the VPU idle.
>=20
> Signed-off-by: Jackson.lee <jackson.lee@chipsnmedia.com>
> Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

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
> index fff6e66b66e4..791b1f0e3199 100644
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
> index c8624c681fa6..861a0664047c 100644
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
> index a23908011a39..703fd8d1c7da 100644
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
> index 68a519ac412d..325e311cdedc 100644
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
> @@ -145,6 +146,38 @@ static int wave5_vpu_load_firmware(struct device *de=
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
> @@ -268,6 +301,12 @@ static int wave5_vpu_probe(struct platform_device *p=
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
> @@ -295,6 +334,9 @@ static void wave5_vpu_remove(struct platform_device *=
pdev)
>  		hrtimer_cancel(&dev->hrtimer);
>  	}
> =20
> +	pm_runtime_put_sync(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
> +
>  	mutex_destroy(&dev->dev_lock);
>  	mutex_destroy(&dev->hw_lock);
>  	clk_bulk_disable_unprepare(dev->num_clks, dev->clks);
> @@ -320,6 +362,7 @@ static struct platform_driver wave5_vpu_driver =3D {
>  	.driver =3D {
>  		.name =3D VPU_PLATFORM_DEVICE_NAME,
>  		.of_match_table =3D of_match_ptr(wave5_dt_ids),
> +		.pm =3D &wave5_pm_ops,
>  		},
>  	.probe =3D wave5_vpu_probe,
>  	.remove_new =3D wave5_vpu_remove,
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



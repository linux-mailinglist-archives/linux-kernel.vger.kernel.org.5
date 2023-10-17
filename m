Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456187CCFF0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 00:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344138AbjJQWOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 18:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjJQWOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 18:14:53 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6D9B0;
        Tue, 17 Oct 2023 15:14:51 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b9338e4695so82346131fa.2;
        Tue, 17 Oct 2023 15:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697580890; x=1698185690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zOAltFmNIIk1OQ8RE29YlbSsDwGFJQEW4YapJi7YEcE=;
        b=bsnq3ptt5rQFAizkxPbThSrT3kNjIERW0xuLe+9Be7ud1vKSABi0eFNx20LwogXf6c
         veELZaPhzh6tV5Hj3lfqQ/+/Z9V9eT7Jdb/8ZT2/Ep2+X9wVMjEn73bhpqeBXlRZk9Id
         yaKr4s6AzrTJpmRxTn4cr9xgaSSHI9P8hyPp9hPnS2jM7Wden/TguUJ+uYl4pm7QecEO
         8VFXKmrE+H4MKtQa6L9Z/CDOyUGuxfUUn2xIVeqPNG3pGBP3Ck8oDEyNQKJZjF3Z9POz
         +ly19txGXIKU7D0iezGkUHZoS3WazTJ4u4SUFJw22QDyDQ87ihntlQdlvqv7KfYJcoQN
         JMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697580890; x=1698185690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zOAltFmNIIk1OQ8RE29YlbSsDwGFJQEW4YapJi7YEcE=;
        b=QTCxZc/WmxBdv//y/S0aRb//KTe/dHBkxJ/AWqAfJ6p/tKABlEl3nhB9jV29fxdPiU
         35q6gv9gEoSgFBLAdb5ivrabJOXqurD5giiylcZGZP0luVfrLP0f4RSdjA8vouihy5dx
         1t5deq9bFLadklGIFxap1DQB4nuwj7rxrBBaKE5XDjmDIHHqQEtuVK/dKb3dKGxNG/RH
         GjcWEULnI0xOZDwdoeRioczQbl+lqx7PxkvOfCdFTXrL4qyZv7nRfwHd2cAL+8Cye0tv
         Ua8c7Bo0XBkeZPKvg2m5YJdw7j6+2KFH9NGIpdjtrBTDyvPT2EM1k9Q9njhKejLff8qI
         phyQ==
X-Gm-Message-State: AOJu0YyfwcmYS17jQd4BzYVLnIynFjZXgSAK9QSkp98Kc3Cwg99HvgeK
        TXCGycgWB0FNiEcmIlr9EkoRLVeQsge7Lw==
X-Google-Smtp-Source: AGHT+IEOpr6BB0LyNnV+m0noVjJYZ0i8J9qyJIrlwMfaZvC5GGftq5mVNUekH40+/BfvoXTTd9ds7g==
X-Received: by 2002:a2e:8e22:0:b0:2b6:a804:4cc with SMTP id r2-20020a2e8e22000000b002b6a80404ccmr2153096ljk.53.1697580889428;
        Tue, 17 Oct 2023 15:14:49 -0700 (PDT)
Received: from localhost.localdomain ([178.70.169.129])
        by smtp.gmail.com with ESMTPSA id d13-20020a2eb04d000000b002c09602150asm431479ljl.27.2023.10.17.15.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 15:14:48 -0700 (PDT)
From:   Ivan Bornyakov <brnkv.i1@gmail.com>
To:     Sebastian Fricke <sebastian.fricke@collabora.com>
Cc:     Ivan Bornyakov <brnkv.i1@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jackson Lee <jackson.lee@chipsnmedia.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nas Chung <nas.chung@chipsnmedia.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-media@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
        linux-kernel@vger.kernel.org,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        kernel@collabora.com, Robert Beckett <bob.beckett@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Darren Etheridge <detheridge@ti.com>
Subject: Re: [PATCH v13 5/8] media: chips-media: wave5: Add the v4l2 layer
Date:   Wed, 18 Oct 2023 01:13:52 +0300
Message-ID: <20231017221359.20164-1-brnkv.i1@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230929-wave5_v13_media_master-v13-5-5ac60ccbf2ce@collabora.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Thu, 12 Oct 2023 13:01:03 +0200, Sebastian Fricke wrote:
> Add the decoder and encoder implementing the v4l2
> API. This patch also adds the Makefile and the VIDEO_WAVE_VPU config
> 
> Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
> ---
>  drivers/media/platform/chips-media/Kconfig         |    1 +
>  drivers/media/platform/chips-media/Makefile        |    1 +
>  drivers/media/platform/chips-media/wave5/Kconfig   |   12 +
>  drivers/media/platform/chips-media/wave5/Makefile  |   10 +
>  .../platform/chips-media/wave5/wave5-helper.c      |  213 +++
>  .../platform/chips-media/wave5/wave5-helper.h      |   31 +
>  .../platform/chips-media/wave5/wave5-vpu-dec.c     | 1953 ++++++++++++++++++++
>  .../platform/chips-media/wave5/wave5-vpu-enc.c     | 1794 ++++++++++++++++++
>  .../media/platform/chips-media/wave5/wave5-vpu.c   |  291 +++
>  .../media/platform/chips-media/wave5/wave5-vpu.h   |   83 +
>  .../platform/chips-media/wave5/wave5-vpuapi.h      |    2 -
>  11 files changed, 4389 insertions(+), 2 deletions(-)

[...]

> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> new file mode 100644
> index 000000000000..74d1fae64fa4
> --- /dev/null
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c

[...]

> +static int wave5_vpu_dec_queue_setup(struct vb2_queue *q, unsigned int *num_buffers,
> +				     unsigned int *num_planes, unsigned int sizes[],
> +				     struct device *alloc_devs[])
> +{
> +	struct vpu_instance *inst = vb2_get_drv_priv(q);
> +	struct v4l2_pix_format_mplane inst_format =
> +		(q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) ? inst->src_fmt : inst->dst_fmt;
> +	unsigned int i;
> +
> +	dev_dbg(inst->dev->dev, "%s: num_buffers: %u | num_planes: %u | type: %u\n", __func__,
> +		*num_buffers, *num_planes, q->type);
> +
> +	/* the CREATE_BUFS case */
> +	if (*num_planes) {
> +		if (inst_format.num_planes != *num_planes)
> +			return -EINVAL;
> +
> +		for (i = 0; i < *num_planes; i++) {
> +			if (sizes[i] < inst_format.plane_fmt[i].sizeimage)
> +				return -EINVAL;
> +		}
> +	/* the REQBUFS case */
> +	} else {
> +		*num_planes = inst_format.num_planes;
> +
> +		if (q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
> +			sizes[0] = inst_format.plane_fmt[0].sizeimage;
> +			dev_dbg(inst->dev->dev, "%s: size[0]: %u\n", __func__, sizes[0]);
> +		} else if (*num_planes == 1) {

I think, you should also set *num_buffers to be inst->fbc_buf_count for
V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE, like this:

		} else if (q->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
			if (*num_buffers < inst->fbc_buf_count)
				*num_buffers = inst->fbc_buf_count;

			switch (*num_planes) {
			case 1:
				...
			case 2:
				...
			case 3:
				...
			}
		}

The reason for that is if fbc_buf_count is greater than initial num_buffers,
wave5_vpu_dec_job_ready() wouldn't allow to invoke wave5_vpu_dec_device_run()

Here is a part of the log of described situation:

  vdec 20410000.wave515: Switch state from NONE to OPEN.
  [...]
  vdec 20410000.wave515: wave5_vpu_dec_init_seq: init seq sent (queue 1 : 1)
  vdec 20410000.wave515: wave5_vpu_dec_get_seq_info: init seq complete (queue 0 : 0)
  [...]
  vdec 20410000.wave515: handle_dynamic_resolution_change: width: 4112 height: 3008 profile: 1 | minbuffer: 6
  ^^^^^^^^ note that minbuffer is 6

  vdec 20410000.wave515: Switch state from OPEN to INIT_SEQ.
  [...]
  vdec 20410000.wave515: decoder command: 1
  [...]
  vdec 20410000.wave515: wave5_vpu_dec_queue_setup: num_buffers: 4 | num_planes: 0 | type: 9
  ^^^^^^^^ note that num_buffers is 4

  vdec 20410000.wave515: wave5_vpu_dec_queue_setup: size[0]: 18625536
  vdec 20410000.wave515: CAPTURE queue must be streaming to queue jobs!
  vdec 20410000.wave515: CAPTURE queue must be streaming to queue jobs!
  vdec 20410000.wave515: CAPTURE queue must be streaming to queue jobs!
  vdec 20410000.wave515: CAPTURE queue must be streaming to queue jobs!
  vdec 20410000.wave515: wave5_vpu_dec_buf_queue: type:    9 index:    0 size: ([0]=18625536, [1]=   0, [2]=   0)
  vdec 20410000.wave515: wave5_vpu_dec_buf_queue: type:    9 index:    1 size: ([0]=18625536, [1]=   0, [2]=   0)
  vdec 20410000.wave515: wave5_vpu_dec_buf_queue: type:    9 index:    2 size: ([0]=18625536, [1]=   0, [2]=   0)
  vdec 20410000.wave515: wave5_vpu_dec_buf_queue: type:    9 index:    3 size: ([0]=18625536, [1]=   0, [2]=   0)
  vdec 20410000.wave515: wave5_vpu_dec_start_streaming: type: 9
  vdec 20410000.wave515: No capture buffer ready to decode!
  ^^^^^^^^ here v4l2_m2m_num_dst_bufs_ready(m2m_ctx) < (inst->fbc_buf_count - 1), namely 4 < 6
  
  vdec 20410000.wave515: wave5_vpu_dec_stop_streaming: type: 9
  vdec 20410000.wave515: streamoff_capture: Setting display flag of buf index: 0, fail: -22
  vdec 20410000.wave515: streamoff_capture: Setting display flag of buf index: 1, fail: -22
  vdec 20410000.wave515: streamoff_capture: Setting display flag of buf index: 2, fail: -22
  vdec 20410000.wave515: streamoff_capture: Setting display flag of buf index: 3, fail: -22
  [...]
  vdec 20410000.wave515: wave5_vpu_dec_close: dec_finish_seq complete

Altering num_buffers solves the issue for me.

> +			if (inst->output_format == FORMAT_422)
> +				sizes[0] = inst_format.width * inst_format.height * 2;
> +			else
> +				sizes[0] = inst_format.width * inst_format.height * 3 / 2;
> +			dev_dbg(inst->dev->dev, "%s: size[0]: %u\n", __func__, sizes[0]);
> +		} else if (*num_planes == 2) {
> +			sizes[0] = inst_format.width * inst_format.height;
> +			if (inst->output_format == FORMAT_422)
> +				sizes[1] = inst_format.width * inst_format.height;
> +			else
> +				sizes[1] = inst_format.width * inst_format.height / 2;
> +			dev_dbg(inst->dev->dev, "%s: size[0]: %u | size[1]: %u\n",
> +				__func__, sizes[0], sizes[1]);
> +		} else if (*num_planes == 3) {
> +			sizes[0] = inst_format.width * inst_format.height;
> +			if (inst->output_format == FORMAT_422) {
> +				sizes[1] = inst_format.width * inst_format.height / 2;
> +				sizes[2] = inst_format.width * inst_format.height / 2;
> +			} else {
> +				sizes[1] = inst_format.width * inst_format.height / 4;
> +				sizes[2] = inst_format.width * inst_format.height / 4;
> +			}
> +			dev_dbg(inst->dev->dev, "%s: size[0]: %u | size[1]: %u | size[2]: %u\n",
> +				__func__, sizes[0], sizes[1], sizes[2]);
> +		}
> +	}
> +
> +	return 0;
> +}

BTW I'm currently tinkering with your patchset on another C&M IP and would be
gratefull if you Cc me in the future versions of the patchset, if any.

Thanks.

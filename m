Return-Path: <linux-kernel+bounces-106199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2FE87EAA3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECB131F21CF2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6528F4C3D0;
	Mon, 18 Mar 2024 14:16:00 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCAF1FB5;
	Mon, 18 Mar 2024 14:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710771359; cv=none; b=rmBRs0SeP7DRVIXYk0fQ1r5uDxZJhrmioWdp8mmN1I2liKOG70LGdqGspCg1dwD8xLHrr2nN3z21XSvTFC0LnK/rOXEkQxs6RdXm8pgzi8mvwPes4MLaV2SVXKN+QJEMgk9KzzFn/aTArVS7oZIHsBc0U0cNHwY4y4o6CAQCTTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710771359; c=relaxed/simple;
	bh=90QpxAl9C9VgCNKILL9CZc9VTq+Jy/zeAU5GOku13fc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oeLy8DKboD1uMIbiLlOmBr04UADVcdhQz/0tQuIHXxbShD8XoMQXQlfcK9Shjsc2gpiqNkfR3oC060swLvychqF0hLo/pbsm4GWRFhBpRMyOSWeU70EKAyCO0s/gm8rKNXyJKewzUA1xLf9ETt/JHldxZPN4OaSaNQZG3gUen68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09909C433F1;
	Mon, 18 Mar 2024 14:15:52 +0000 (UTC)
Message-ID: <e169a0c9-197a-4662-a313-eff11caed9e8@xs4all.nl>
Date: Mon, 18 Mar 2024 15:15:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] media: imagination: Add E5010 JPEG Encoder driver
Content-Language: en-US, nl
To: Devarsh Thakkar <devarsht@ti.com>, mchehab@kernel.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, benjamin.gaignard@collabora.com,
 sebastian.fricke@collabora.com
Cc: laurent.pinchart@ideasonboard.com, praneeth@ti.com, nm@ti.com,
 vigneshr@ti.com, a-bhatia1@ti.com, j-luthra@ti.com, b-brnich@ti.com,
 detheridge@ti.com, p-mantena@ti.com, vijayp@ti.com, andrzej.p@collabora.com,
 nicolas@ndufresne.ca, afd@ti.com, milkfafa@gmail.com
References: <20240228141140.3530612-1-devarsht@ti.com>
 <20240228141140.3530612-4-devarsht@ti.com>
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20240228141140.3530612-4-devarsht@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Devarsh,

Some small notes:

On 28/02/2024 3:11 pm, Devarsh Thakkar wrote:
> This adds support for stateful V4L2 M2M based driver for Imagination E5010
> JPEG Encoder [1] which supports baseline encoding with two different
> quantization tables and compression ratio as demanded.
> 
> Support for both contiguous and non-contiguous YUV420 and YUV422 semiplanar
> formats is added along with alignment restrictions as required by the
> hardware.
> 
> System and runtime PM hooks are added in the driver along with v4l2 crop
> and selection API support.
> 
> Minimum resolution supported is 64x64 and
> Maximum resolution supported is 8192x8192.
> 
> All v4l2-compliance tests are passing [2] :
> v4l2-compliance -s -f -a  -d /dev/video0 -e /dev/video1
> 
> Total for e5010 device /dev/video0: 79, Succeeded: 79, Failed: 0,
> Warnings: 0
> 
> NOTE: video1 here is VIVID test pattern generator
> 
> Also tests [3] were run manually to verify below driver features:
>  - Runtime Power Management
>  - Multi-instance JPEG Encoding
>  - DMABUF import, export support
>  - NV12, NV21, NV16, NV61 video format support
>  - Compression quality S_CTRL
> 
> Existing V4L2 M2M based JPEG drivers namely s5p-jpeg, imx-jpeg and rcar_jpu
> were referred while making this.
> 
> TODO:
> Add MMU and memory tiling support
> 
> [1]:  AM62A TRM (Section 7.6 is for JPEG Encoder) :
> Link: https://www.ti.com/lit/pdf/spruj16
> 
> [2]: v4l2-compliance test :
> Link: https://gist.github.com/devarsht/39c1197742cc858c38860e8cab61666d
> 
> [3]: E5010 JPEG Encoder Manual tests :
> 
> Performance:
> Link: https://gist.github.com/devarsht/2f9b30f28768d9f6e338fc5b7c1d1758
> 
> Functionality:
> Link: https://gist.github.com/devarsht/f12743405b285f47a0ce9b0f9681acd3
> 
> Compression Quality:
> Link: https://gist.github.com/devarsht/8fd9edbdbfda7b2f2fe464b17484ceaf
> 
> Multi Instance:
> Link: https://gist.github.com/devarsht/dfcc17e85569bc05c62b069af82a289d
> 
> Co-developed-by: David Huang <d-huang@ti.com>
> Signed-off-by: David Huang <d-huang@ti.com>
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> ---
> V2:
> No change
> 
> V3:
> - Correct license headers
> - Use more generic name core instead of jasper for base registers
> - Add Comment for forward declarations
> - Simplify quantization table calculations
> - Use v4l2_apply_frmsize_constraints for updating framesize and remove unrequired functions
> - Place TODO at top of file and in commit message too
> - Use dev_err_probe helper in probe function
> - Fix return value checking for failure scenarios in probe function
> - Use v4l2_err/info/warn helpers instead of dev_err/info/warn helpers
> - Fix unexpected indentation
> - Correct commit message
> - Remove dependency on ARCH_K3 as driver is not specific to that
> 
> V4:
> - Fix issue with default params setting
> - Correct v4l2 error prints
> - Simplify register write functions with single statement return values
> - Remove unrequired error checks from get_queue()
> - Drop explicit device_caps setting as it is already taken care by v4l2
>   core
> - Remove unrequired multiplanar checks and memset from s_fmt, g_fmt callback
>   functions
> - Fix try_fmt callback to not update the queues
> - Remove unrequired contiguous format attribute from queue_init
> - Use dynamic allocation for video_device and remove unrequired
>   assignments in probe()
> - Remove unrequired checks from queue_setup function
> - Return queued buffers back if start_streaming fails
> - Use ARRAY_SIZE in place of hard-coding
> - Use huffman and quantization tables from reference header file
> 
> V5:
> - Sort the #includes alphabetically in e5010-jpeg-enc.c
> - Update commit message to point to V5 test reports
> 
> V6:
> - Fix sparse warnings and maintain uniform usage of dev ptr to avoid
>   future such bugs. No more errors received as shown below :
> 
>   `smatch/smatch_scripts/kchecker
>    drivers/media/platform/imagination/e5010*.c
>    CHECK   scripts/mod/empty.c
>    CALL    scripts/checksyscalls.sh
>    CHECK   arch/arm64/kernel/vdso/vgettimeofday.c
>    CC [M]  drivers/media/platform/imagination/e5010-jpeg-enc.o
>    CHECK   drivers/media/platform/imagination/e5010-jpeg-enc.c`
> 
> - Drop Reviewed-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>   as patchset got updated to fix sparse warnings mentinoed at
>   https://lore.kernel.org/all/f59b2d27-dc58-40fb-b899-647feb9d72e4@collabora.com/#t
> 
> Link to previous patch revisions:
> V3: https://lore.kernel.org/all/20230816152210.4080779-3-devarsht@ti.com/
> V4: https://lore.kernel.org/all/20240205114239.924697-4-devarsht@ti.com/
> V5: https://lore.kernel.org/all/20240215134641.3381478-4-devarsht@ti.com/
> 
>  MAINTAINERS                                   |    2 +
>  drivers/media/platform/Kconfig                |    1 +
>  drivers/media/platform/Makefile               |    1 +
>  drivers/media/platform/imagination/Kconfig    |   12 +
>  drivers/media/platform/imagination/Makefile   |    3 +
>  .../platform/imagination/e5010-core-regs.h    |  585 +++++++
>  .../platform/imagination/e5010-jpeg-enc-hw.c  |  267 +++
>  .../platform/imagination/e5010-jpeg-enc-hw.h  |   42 +
>  .../platform/imagination/e5010-jpeg-enc.c     | 1553 +++++++++++++++++
>  .../platform/imagination/e5010-jpeg-enc.h     |  169 ++
>  .../platform/imagination/e5010-mmu-regs.h     |  311 ++++
>  11 files changed, 2946 insertions(+)
>  create mode 100644 drivers/media/platform/imagination/Kconfig
>  create mode 100644 drivers/media/platform/imagination/Makefile
>  create mode 100644 drivers/media/platform/imagination/e5010-core-regs.h
>  create mode 100644 drivers/media/platform/imagination/e5010-jpeg-enc-hw.c
>  create mode 100644 drivers/media/platform/imagination/e5010-jpeg-enc-hw.h
>  create mode 100644 drivers/media/platform/imagination/e5010-jpeg-enc.c
>  create mode 100644 drivers/media/platform/imagination/e5010-jpeg-enc.h
>  create mode 100644 drivers/media/platform/imagination/e5010-mmu-regs.h
> 

<snip>

> diff --git a/drivers/media/platform/imagination/e5010-jpeg-enc.c b/drivers/media/platform/imagination/e5010-jpeg-enc.c
> new file mode 100644
> index 000000000000..8805e9089e65
> --- /dev/null
> +++ b/drivers/media/platform/imagination/e5010-jpeg-enc.c
> @@ -0,0 +1,1553 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Imagination E5010 JPEG Encoder driver.
> + *
> + * TODO: Add MMU and memory tiling support
> + *
> + * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
> + *
> + * Author: David Huang <d-huang@ti.com>
> + * Author: Devarsh Thakkar <devarsht@ti.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/ioctl.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/pm_runtime.h>
> +#include <media/jpeg.h>
> +#include <media/jpeg-enc-reftables.h>
> +#include <media/v4l2-common.h>
> +#include <media/v4l2-ctrls.h>
> +#include <media/v4l2-device.h>
> +#include <media/v4l2-event.h>
> +#include <media/v4l2-ioctl.h>
> +#include <media/v4l2-mem2mem.h>
> +#include <media/videobuf2-dma-contig.h>
> +#include <media/videobuf2-v4l2.h>
> +#include "e5010-jpeg-enc.h"
> +#include "e5010-jpeg-enc-hw.h"
> +
> +/* forward declarations */
> +static const struct of_device_id e5010_of_match[];
> +
> +static const struct v4l2_file_operations e5010_fops;
> +
> +static const struct v4l2_ioctl_ops e5010_ioctl_ops;
> +
> +static const struct vb2_ops e5010_video_ops;
> +
> +static const struct v4l2_m2m_ops e5010_m2m_ops;
> +
> +static struct e5010_fmt e5010_formats[] = {
> +	{
> +		.fourcc = V4L2_PIX_FMT_NV12,
> +		.num_planes = 1,
> +		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
> +		.subsampling = V4L2_JPEG_CHROMA_SUBSAMPLING_420,
> +		.chroma_order = CHROMA_ORDER_CB_CR,
> +		.frmsize = { MIN_DIMENSION, MAX_DIMENSION, 64,
> +			     MIN_DIMENSION, MAX_DIMENSION, 8 },
> +	},
> +	{
> +		.fourcc = V4L2_PIX_FMT_NV12M,
> +		.num_planes = 2,
> +		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
> +		.subsampling = V4L2_JPEG_CHROMA_SUBSAMPLING_420,
> +		.chroma_order = CHROMA_ORDER_CB_CR,
> +		.frmsize = { MIN_DIMENSION, MAX_DIMENSION, 64,
> +			     MIN_DIMENSION, MAX_DIMENSION, 8 },
> +	},
> +	{
> +		.fourcc = V4L2_PIX_FMT_NV21,
> +		.num_planes = 1,
> +		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
> +		.subsampling = V4L2_JPEG_CHROMA_SUBSAMPLING_420,
> +		.chroma_order = CHROMA_ORDER_CR_CB,
> +		.frmsize = { MIN_DIMENSION, MAX_DIMENSION, 64,
> +			     MIN_DIMENSION, MAX_DIMENSION, 8 },
> +	},
> +	{
> +		.fourcc = V4L2_PIX_FMT_NV21M,
> +		.num_planes = 2,
> +		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
> +		.subsampling = V4L2_JPEG_CHROMA_SUBSAMPLING_420,
> +		.chroma_order = CHROMA_ORDER_CR_CB,
> +		.frmsize = { MIN_DIMENSION, MAX_DIMENSION, 64,
> +			     MIN_DIMENSION, MAX_DIMENSION, 8 },
> +	},
> +	{
> +		.fourcc = V4L2_PIX_FMT_NV16,
> +		.num_planes = 1,
> +		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
> +		.subsampling = V4L2_JPEG_CHROMA_SUBSAMPLING_422,
> +		.chroma_order = CHROMA_ORDER_CB_CR,
> +		.frmsize = { MIN_DIMENSION, MAX_DIMENSION, 64,
> +			     MIN_DIMENSION, MAX_DIMENSION, 8 },
> +	},
> +	{
> +		.fourcc = V4L2_PIX_FMT_NV16M,
> +		.num_planes = 2,
> +		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
> +		.subsampling = V4L2_JPEG_CHROMA_SUBSAMPLING_422,
> +		.chroma_order = CHROMA_ORDER_CB_CR,
> +		.frmsize = { MIN_DIMENSION, MAX_DIMENSION, 64,
> +			     MIN_DIMENSION, MAX_DIMENSION, 8 },
> +
> +	},
> +	{
> +		.fourcc = V4L2_PIX_FMT_NV61,
> +		.num_planes = 1,
> +		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
> +		.subsampling = V4L2_JPEG_CHROMA_SUBSAMPLING_422,
> +		.chroma_order = CHROMA_ORDER_CR_CB,
> +		.frmsize = { MIN_DIMENSION, MAX_DIMENSION, 64,
> +			     MIN_DIMENSION, MAX_DIMENSION, 8 },
> +	},
> +	{
> +		.fourcc = V4L2_PIX_FMT_NV61M,
> +		.num_planes = 2,
> +		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
> +		.subsampling = V4L2_JPEG_CHROMA_SUBSAMPLING_422,
> +		.chroma_order = CHROMA_ORDER_CR_CB,
> +		.frmsize = { MIN_DIMENSION, MAX_DIMENSION, 64,
> +			     MIN_DIMENSION, MAX_DIMENSION, 8 },
> +	},
> +	{
> +		.fourcc = V4L2_PIX_FMT_JPEG,
> +		.num_planes = 1,
> +		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
> +		.subsampling = 0,
> +		.chroma_order = 0,
> +		.frmsize = { MIN_DIMENSION, MAX_DIMENSION, 16,
> +			     MIN_DIMENSION, MAX_DIMENSION, 8 },
> +	},
> +};
> +
> +static unsigned int debug;
> +module_param(debug, uint, 0644);
> +MODULE_PARM_DESC(debug, "debug level");
> +
> +#define dprintk(dev, lvl, fmt, arg...) \
> +	v4l2_dbg(lvl, debug, &(dev)->v4l2_dev, "%s: " fmt, __func__, ## arg)
> +
> +static const struct v4l2_event e5010_eos_event = {
> +	.type = V4L2_EVENT_EOS
> +};
> +
> +static const char *type_name(enum v4l2_buf_type type)
> +{
> +	switch (type) {
> +	case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
> +		return "Output";
> +	case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
> +		return "Capture";
> +	default:
> +		return "Invalid";
> +	}
> +}
> +
> +static struct e5010_q_data *get_queue(struct e5010_context *ctx, enum v4l2_buf_type type)
> +{
> +	return (type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) ? &ctx->out_queue : &ctx->cap_queue;
> +}
> +
> +static void calculate_qp_tables(struct e5010_context *ctx)
> +{
> +	long long luminosity, contrast;
> +	int quality, i;
> +
> +	quality = 50 - ctx->quality;
> +
> +	luminosity = LUMINOSITY * quality / 50;
> +	contrast = CONTRAST * quality / 50;
> +
> +	if (quality > 0) {
> +		luminosity *= INCREASE;
> +		contrast *= INCREASE;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(luma_q_table); i++) {
> +		long long delta = chroma_q_table[i] * contrast + luminosity;
> +		int val = (int)(chroma_q_table[i] + delta);
> +
> +		clamp(val, 1, 255);
> +		ctx->chroma_qp[i] = quality == -50 ? 1 : val;
> +
> +		delta = luma_q_table[i] * contrast + luminosity;
> +		val = (int)(luma_q_table[i] + delta);
> +		clamp(val, 1, 255);
> +		ctx->luma_qp[i] = quality == -50 ? 1 : val;
> +	}
> +
> +	ctx->update_qp = true;
> +}
> +
> +static int update_qp_tables(struct e5010_context *ctx)
> +{
> +	struct e5010_dev *e5010 = ctx->e5010;
> +	int i, ret = 0;
> +	u32 lvalue, cvalue;
> +
> +	lvalue = 0;
> +	cvalue = 0;
> +
> +	for (i = 0; i < QP_TABLE_SIZE; i++) {
> +		lvalue |= ctx->luma_qp[i] << (8 * (i % 4));
> +		cvalue |= ctx->chroma_qp[i] << (8 * (i % 4));
> +		if (i % 4 == 3) {
> +			ret |= e5010_hw_set_qpvalue(e5010->core_base,
> +							JASPER_LUMA_QUANTIZATION_TABLE0_OFFSET
> +							+ QP_TABLE_FIELD_OFFSET * ((i - 3) / 4),
> +							lvalue);
> +			ret |= e5010_hw_set_qpvalue(e5010->core_base,
> +							JASPER_CHROMA_QUANTIZATION_TABLE0_OFFSET
> +							+ QP_TABLE_FIELD_OFFSET * ((i - 3) / 4),
> +							cvalue);
> +			lvalue = 0;
> +			cvalue = 0;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static int e5010_set_input_subsampling(void __iomem *core_base, int subsampling)
> +{
> +	switch (subsampling) {
> +	case V4L2_JPEG_CHROMA_SUBSAMPLING_420:
> +		return e5010_hw_set_input_subsampling(core_base, SUBSAMPLING_420);
> +	case V4L2_JPEG_CHROMA_SUBSAMPLING_422:
> +		return e5010_hw_set_input_subsampling(core_base, SUBSAMPLING_422);
> +	default:
> +		return -EINVAL;
> +	};
> +}
> +
> +static int e5010_querycap(struct file *file, void *priv, struct v4l2_capability *cap)
> +{
> +	strscpy(cap->driver, E5010_MODULE_NAME, sizeof(cap->driver));
> +	strscpy(cap->card, E5010_MODULE_NAME, sizeof(cap->card));
> +
> +	return 0;
> +}
> +
> +static struct e5010_fmt *find_format(struct v4l2_format *f)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(e5010_formats); ++i) {
> +		if (e5010_formats[i].fourcc == f->fmt.pix_mp.pixelformat &&
> +		    e5010_formats[i].type == f->type)
> +			return &e5010_formats[i];
> +	}
> +
> +	return NULL;
> +}
> +
> +static int e5010_enum_fmt(struct file *file, void *priv, struct v4l2_fmtdesc *f)
> +{
> +	int i, index = 0;
> +	struct e5010_fmt *fmt = NULL;
> +	struct e5010_context *ctx = file->private_data;
> +
> +	if (!V4L2_TYPE_IS_MULTIPLANAR(f->type)) {
> +		v4l2_err(&ctx->e5010->v4l2_dev, "ENUMFMT with Invalid type: %d\n", f->type);
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(e5010_formats); ++i) {
> +		if (e5010_formats[i].type == f->type) {
> +			if (index == f->index) {
> +				fmt = &e5010_formats[i];
> +				break;
> +			}
> +			index++;
> +		}
> +	}
> +
> +	if (!fmt)
> +		return -EINVAL;
> +
> +	f->pixelformat = fmt->fourcc;
> +	return 0;
> +}
> +
> +static int e5010_g_fmt(struct file *file, void *priv, struct v4l2_format *f)
> +{
> +	struct e5010_context *ctx = file->private_data;
> +	struct e5010_q_data *queue;
> +	int i;
> +	struct v4l2_pix_format_mplane *pix_mp = &f->fmt.pix_mp;
> +	struct v4l2_plane_pix_format *plane_fmt = pix_mp->plane_fmt;
> +
> +	queue = get_queue(ctx, f->type);
> +
> +	pix_mp->flags = 0;
> +	pix_mp->field = V4L2_FIELD_NONE;
> +	pix_mp->pixelformat = queue->fmt->fourcc;
> +	pix_mp->width = queue->width_adjusted;
> +	pix_mp->height = queue->height_adjusted;
> +	pix_mp->num_planes = queue->fmt->num_planes;
> +
> +	if (V4L2_TYPE_IS_OUTPUT(f->type)) {
> +		if (!pix_mp->colorspace)
> +			pix_mp->colorspace = V4L2_COLORSPACE_SRGB;
> +
> +		for (i = 0; i < queue->fmt->num_planes; i++) {
> +			plane_fmt[i].sizeimage = queue->sizeimage[i];
> +			plane_fmt[i].bytesperline = queue->bytesperline[i];
> +		}
> +
> +	} else {
> +		pix_mp->colorspace = V4L2_COLORSPACE_JPEG;
> +		plane_fmt[0].bytesperline = 0;
> +		plane_fmt[0].sizeimage = queue->sizeimage[0];
> +	}
> +	pix_mp->ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
> +	pix_mp->xfer_func = V4L2_XFER_FUNC_DEFAULT;
> +	pix_mp->quantization = V4L2_QUANTIZATION_DEFAULT;
> +
> +	return 0;
> +}
> +
> +static int e5010_jpeg_try_fmt(struct v4l2_format *f, struct e5010_context *ctx)
> +{
> +	struct e5010_fmt *fmt;
> +	struct v4l2_pix_format_mplane *pix_mp = &f->fmt.pix_mp;
> +	struct v4l2_plane_pix_format *plane_fmt = pix_mp->plane_fmt;
> +
> +	fmt = find_format(f);
> +	if (!fmt) {
> +		if (V4L2_TYPE_IS_OUTPUT(f->type))
> +			pix_mp->pixelformat = V4L2_PIX_FMT_NV12;
> +		else
> +			pix_mp->pixelformat = V4L2_PIX_FMT_JPEG;
> +		fmt = find_format(f);
> +		if (!fmt)
> +			return -EINVAL;
> +	}
> +
> +	if (V4L2_TYPE_IS_OUTPUT(f->type)) {
> +		if (!pix_mp->colorspace)
> +			pix_mp->colorspace = V4L2_COLORSPACE_JPEG;
> +		if (!pix_mp->ycbcr_enc)
> +			pix_mp->ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
> +		if (!pix_mp->quantization)
> +			pix_mp->quantization = V4L2_QUANTIZATION_DEFAULT;
> +		if (!pix_mp->xfer_func)
> +			pix_mp->xfer_func = V4L2_XFER_FUNC_DEFAULT;
> +
> +		v4l2_apply_frmsize_constraints(&pix_mp->width,
> +					       &pix_mp->height,
> +					       &fmt->frmsize);
> +
> +		v4l2_fill_pixfmt_mp(pix_mp, pix_mp->pixelformat,
> +				    pix_mp->width, pix_mp->height);
> +
> +	} else {
> +		pix_mp->colorspace = V4L2_COLORSPACE_JPEG;
> +		pix_mp->ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
> +		pix_mp->quantization = V4L2_QUANTIZATION_DEFAULT;
> +		pix_mp->xfer_func = V4L2_XFER_FUNC_DEFAULT;
> +		v4l2_apply_frmsize_constraints(&pix_mp->width,
> +					       &pix_mp->height,
> +					       &fmt->frmsize);
> +		plane_fmt[0].sizeimage = pix_mp->width * pix_mp->height * JPEG_MAX_BYTES_PER_PIXEL;
> +		plane_fmt[0].sizeimage += HEADER_SIZE;
> +		plane_fmt[0].bytesperline = 0;
> +		pix_mp->pixelformat = fmt->fourcc;
> +		pix_mp->num_planes = fmt->num_planes;
> +	}
> +	pix_mp->flags = 0;
> +	pix_mp->field = V4L2_FIELD_NONE;
> +
> +	dprintk(ctx->e5010, 2,
> +		"ctx: 0x%p: format type %s:, wxh: %dx%d (plane0 : %d bytes, plane1 : %d bytes),fmt: %c%c%c%c\n",
> +		ctx, type_name(f->type), pix_mp->width, pix_mp->height,
> +		plane_fmt[0].sizeimage, plane_fmt[1].sizeimage,
> +		(fmt->fourcc & 0xff),
> +		(fmt->fourcc >>  8) & 0xff,
> +		(fmt->fourcc >> 16) & 0xff,
> +		(fmt->fourcc >> 24) & 0xff);
> +
> +	return 0;
> +}
> +
> +static int e5010_try_fmt(struct file *file, void *priv, struct v4l2_format *f)
> +{
> +	struct e5010_context *ctx = file->private_data;
> +
> +	return e5010_jpeg_try_fmt(f, ctx);
> +}
> +
> +static int e5010_s_fmt(struct file *file, void *priv, struct v4l2_format *f)
> +{
> +	struct e5010_context *ctx = file->private_data;
> +	struct vb2_queue *vq;
> +	int ret = 0, i = 0;
> +	struct v4l2_pix_format_mplane *pix_mp = &f->fmt.pix_mp;
> +	struct v4l2_plane_pix_format *plane_fmt = pix_mp->plane_fmt;
> +	struct e5010_q_data *queue;
> +	struct e5010_fmt *fmt;
> +
> +	vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, f->type);
> +	if (!vq)
> +		return -EINVAL;
> +
> +	if (vb2_is_busy(vq)) {
> +		v4l2_err(&ctx->e5010->v4l2_dev, "queue busy\n");
> +		return -EBUSY;
> +	}
> +
> +	ret = e5010_jpeg_try_fmt(f, ctx);
> +	if (ret)
> +		return ret;
> +
> +	fmt = find_format(f);
> +	queue = get_queue(ctx, f->type);
> +
> +	queue->fmt = fmt;
> +	queue->width = pix_mp->width;
> +	queue->height = pix_mp->height;
> +
> +	if (V4L2_TYPE_IS_OUTPUT(f->type)) {
> +		for (i = 0; i < fmt->num_planes; i++) {
> +			queue->bytesperline[i] = plane_fmt[i].bytesperline;
> +			queue->sizeimage[i] = plane_fmt[i].sizeimage;
> +		}
> +	} else {
> +		queue->sizeimage[0] = plane_fmt[0].sizeimage;
> +		queue->sizeimage[1] = 0;
> +		queue->bytesperline[0] = 0;
> +		queue->bytesperline[1] = 0;
> +	}
> +
> +	return 0;
> +}
> +
> +static int e5010_enum_framesizes(struct file *file, void *priv, struct v4l2_frmsizeenum *fsize)
> +{
> +	struct v4l2_format f;
> +	struct e5010_fmt *fmt;
> +
> +	if (fsize->index != 0)
> +		return -EINVAL;
> +
> +	f.fmt.pix_mp.pixelformat = fsize->pixel_format;
> +	if (f.fmt.pix_mp.pixelformat ==  V4L2_PIX_FMT_JPEG)
> +		f.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
> +	else
> +		f.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE;
> +
> +	fmt = find_format(&f);
> +	if (!fmt)
> +		return -EINVAL;
> +
> +	fsize->type = V4L2_FRMSIZE_TYPE_STEPWISE;
> +	fsize->stepwise = fmt->frmsize;
> +	fsize->reserved[0] = 0;
> +	fsize->reserved[1] = 0;
> +
> +	return 0;
> +}
> +
> +static int e5010_g_selection(struct file *file, void *fh, struct v4l2_selection *s)
> +{
> +	struct e5010_context *ctx = file->private_data;
> +	struct e5010_q_data *queue;
> +
> +	if (s->type != V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)


This is wrong: check against V4L2_BUF_TYPE_VIDEO_OUTPUT. See drivers/media/v4l2-core/v4l2-ioctl.c,
the comment before function v4l_g_selection.

This causes v4l2-compliance to assume that cropping is not supported.

Same for s_selection below.

> +		return -EINVAL;
> +
> +	queue = get_queue(ctx, s->type);
> +
> +	switch (s->target) {
> +	case V4L2_SEL_TGT_CROP_DEFAULT:
> +	case V4L2_SEL_TGT_CROP_BOUNDS:
> +		s->r.left = 0;
> +		s->r.top = 0;
> +		s->r.width = queue->width;
> +		s->r.height = queue->height;
> +		break;
> +	case V4L2_SEL_TGT_CROP:
> +		s->r = queue->crop;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int e5010_s_selection(struct file *file, void *fh, struct v4l2_selection *s)
> +{
> +	struct e5010_context *ctx = file->private_data;
> +	struct e5010_q_data *queue;
> +
> +	if (s->type != V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
> +		return -EINVAL;

This doesn't check if vb2_is_streaming(queue): it should return -EBUSY in that case.

It also doesn't check s->target: only V4L2_SEL_TGT_CROP is supported.

Are there no requirements w.r.t. width and height? E.g. a multiple of 2 or 4?

> +
> +	queue = get_queue(ctx, s->type);
> +
> +	queue->crop.left = 0;
> +	queue->crop.top = 0;
> +	queue->crop.width = s->r.width;
> +	queue->crop.height = s->r.height;

I think s->r.left and s->r.top should be set to 0 as well, so userspace sees
the actual crop rectangle that is used.

Note that this is not done in drivers/media/platform/verisilicon/hantro_v4l2.c
either, that's a bug.

There is also no check if the width/height are too large.

> +
> +	return 0;
> +}
> +
> +static int e5010_subscribe_event(struct v4l2_fh *fh, const struct v4l2_event_subscription *sub)
> +{
> +	switch (sub->type) {
> +	case V4L2_EVENT_EOS:
> +		return v4l2_event_subscribe(fh, sub, 0, NULL);
> +	case V4L2_EVENT_CTRL:
> +		return v4l2_ctrl_subscribe_event(fh, sub);
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_vq)
> +{
> +	struct e5010_context *ctx = priv;
> +	struct e5010_dev *e5010 = ctx->e5010;
> +	int ret = 0;
> +
> +	/* src_vq */
> +	memset(src_vq, 0, sizeof(*src_vq));
> +	src_vq->type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE;
> +	src_vq->io_modes = VB2_MMAP | VB2_DMABUF;
> +	src_vq->drv_priv = ctx;
> +	src_vq->buf_struct_size = sizeof(struct e5010_buffer);
> +	src_vq->ops = &e5010_video_ops;
> +	src_vq->mem_ops = &vb2_dma_contig_memops;
> +	src_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
> +	src_vq->lock = &e5010->mutex;
> +	src_vq->dev = e5010->v4l2_dev.dev;
> +
> +	ret = vb2_queue_init(src_vq);
> +	if (ret)
> +		return ret;
> +
> +	/* dst_vq */
> +	memset(dst_vq, 0, sizeof(*dst_vq));
> +	dst_vq->type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
> +	dst_vq->io_modes = VB2_MMAP | VB2_DMABUF;
> +	dst_vq->drv_priv = ctx;
> +	dst_vq->buf_struct_size = sizeof(struct e5010_buffer);
> +	dst_vq->ops = &e5010_video_ops;
> +	dst_vq->mem_ops = &vb2_dma_contig_memops;
> +	dst_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
> +	dst_vq->lock = &e5010->mutex;
> +	dst_vq->dev = e5010->v4l2_dev.dev;
> +
> +	ret = vb2_queue_init(dst_vq);
> +	if (ret) {
> +		vb2_queue_release(src_vq);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int e5010_s_ctrl(struct v4l2_ctrl *ctrl)
> +{
> +	struct e5010_context *ctx =
> +		container_of(ctrl->handler, struct e5010_context, ctrl_handler);
> +
> +	switch (ctrl->id) {
> +	case V4L2_CID_JPEG_COMPRESSION_QUALITY:
> +		ctx->quality = ctrl->val;
> +		calculate_qp_tables(ctx);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct v4l2_ctrl_ops e5010_ctrl_ops = {
> +	.s_ctrl = e5010_s_ctrl,
> +};
> +
> +static void e5010_encode_ctrls(struct e5010_context *ctx)
> +{
> +	v4l2_ctrl_new_std(&ctx->ctrl_handler, &e5010_ctrl_ops,
> +			  V4L2_CID_JPEG_COMPRESSION_QUALITY, 1, 100, 1, 75);
> +}
> +
> +static int e5010_ctrls_setup(struct e5010_context *ctx)
> +{
> +	int err;
> +
> +	v4l2_ctrl_handler_init(&ctx->ctrl_handler, 1);
> +
> +	e5010_encode_ctrls(ctx);
> +
> +	if (ctx->ctrl_handler.error) {
> +		err = ctx->ctrl_handler.error;
> +		v4l2_ctrl_handler_free(&ctx->ctrl_handler);
> +
> +		return err;
> +	}
> +
> +	err = v4l2_ctrl_handler_setup(&ctx->ctrl_handler);
> +	if (err)
> +		v4l2_ctrl_handler_free(&ctx->ctrl_handler);
> +
> +	return err;
> +}
> +
> +static void e5010_jpeg_set_default_params(struct e5010_context *ctx)
> +{
> +	struct e5010_q_data *queue;
> +	struct v4l2_format f;
> +	struct e5010_fmt *fmt;
> +	struct v4l2_pix_format_mplane *pix_mp = &f.fmt.pix_mp;
> +	struct v4l2_plane_pix_format *plane_fmt = pix_mp->plane_fmt;
> +	int i = 0;
> +
> +	f.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE;
> +	f.fmt.pix_mp.pixelformat = V4L2_PIX_FMT_NV12;
> +	fmt = find_format(&f);
> +	queue = &ctx->out_queue;
> +	queue->fmt = fmt;
> +	queue->width = DEFAULT_WIDTH;
> +	queue->height = DEFAULT_HEIGHT;
> +	pix_mp->width = queue->width;
> +	pix_mp->height = queue->height;
> +	v4l2_apply_frmsize_constraints(&pix_mp->width,
> +				       &pix_mp->height,
> +				       &fmt->frmsize);
> +	v4l2_fill_pixfmt_mp(pix_mp, pix_mp->pixelformat,
> +			    pix_mp->width, pix_mp->height);
> +	for (i = 0; i < fmt->num_planes; i++) {
> +		queue->bytesperline[i] = plane_fmt[i].bytesperline;
> +		queue->sizeimage[i] = plane_fmt[i].sizeimage;
> +	}
> +	queue->width_adjusted = pix_mp->width;
> +	queue->height_adjusted = pix_mp->height;
> +	queue->format_set = false;

This seems to be unused.

> +	queue->streaming = false;

Please don't duplicate state information. You can get the streaming
state directly from the queue by calling vb2_start_streaming_called().

> +
> +	f.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
> +	f.fmt.pix_mp.pixelformat = V4L2_PIX_FMT_JPEG;
> +	fmt = find_format(&f);
> +	queue = &ctx->cap_queue;
> +	queue->fmt = fmt;
> +	queue->width = DEFAULT_WIDTH;
> +	queue->height = DEFAULT_HEIGHT;

This also feels like duplication. Doesn't the queue->fmt already
contain most of this?

> +	pix_mp->width = queue->width;
> +	pix_mp->height = queue->height;
> +	v4l2_apply_frmsize_constraints(&pix_mp->width,
> +				       &pix_mp->height,
> +				       &fmt->frmsize);
> +	queue->sizeimage[0] = pix_mp->width * pix_mp->height * JPEG_MAX_BYTES_PER_PIXEL;
> +	queue->sizeimage[0] += HEADER_SIZE;
> +	queue->sizeimage[1] = 0;
> +	queue->bytesperline[0] = 0;
> +	queue->bytesperline[1] = 0;
> +	queue->format_set = false;
> +	queue->streaming = false;
> +	queue->width_adjusted = pix_mp->width;
> +	queue->height_adjusted = pix_mp->height;
> +}

Regards,

	Hans


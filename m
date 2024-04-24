Return-Path: <linux-kernel+bounces-156695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C81B8B06F1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8735283AD9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403C0159560;
	Wed, 24 Apr 2024 10:07:18 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13261E898;
	Wed, 24 Apr 2024 10:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713953237; cv=none; b=CM8LlWTJcB5g1/BXcp8YgIBtE+QyMgGLoFEQ6MuA9XM8QqMOOqawd+EbS0mzCU43vuMVFHYCUj8QrbrMMZ1TilqtSs8XkjOl9nU6jMCvWuEOCx4rVxJH4wpjO4hTQOk6dcbNfHDfJPd1u8tcF/tupMh1LlPL2UZEsP1AjywrqkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713953237; c=relaxed/simple;
	bh=8lcnCIurDEsAwt5dZGIgZqL4JM8FXi3W5HBrOI9pPPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JUUPEvKTzKycGO1XogTX67788Lbs29cGRp9fm9U9XkjT9frWwTajE44vrWUfHRDT46sDbeGdDj32XoQKyEusF1JioTtJvVvtDPTcNbdvHY7Pi32fsB8cAAnjRRDm+JUy6I5gnyu/PLGBqUeK3tktx3pZo8F9OLoc6lmM1g/9xnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D99A4C32782;
	Wed, 24 Apr 2024 10:07:13 +0000 (UTC)
Message-ID: <054e6a95-796a-4bff-b629-96928eeb1685@xs4all.nl>
Date: Wed, 24 Apr 2024 12:07:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] media: amphion: Report the average qp of current
 encoded frame
Content-Language: en-US, nl
To: Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org
Cc: shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
 xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
 ming.qian@oss.nxp.com, imx@lists.linux.dev, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240329092352.2648837-1-ming.qian@nxp.com>
 <20240329092352.2648837-2-ming.qian@nxp.com>
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20240329092352.2648837-2-ming.qian@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/03/2024 10:23, Ming Qian wrote:
> Report the average qp value of current encoded frame via the control
> V4L2_CID_MPEG_VIDEO_AVERAGE_QP
> 
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> ---
>  drivers/media/platform/amphion/venc.c        | 4 ++++
>  drivers/media/platform/amphion/vpu.h         | 2 ++
>  drivers/media/platform/amphion/vpu_defs.h    | 1 +
>  drivers/media/platform/amphion/vpu_helpers.c | 3 +++
>  drivers/media/platform/amphion/vpu_v4l2.c    | 9 +++++++++
>  drivers/media/platform/amphion/vpu_v4l2.h    | 1 +
>  drivers/media/platform/amphion/vpu_windsor.c | 2 ++
>  7 files changed, 22 insertions(+)
> 
> diff --git a/drivers/media/platform/amphion/venc.c b/drivers/media/platform/amphion/venc.c
> index 4eb57d793a9c..12cebafeaf3b 100644
> --- a/drivers/media/platform/amphion/venc.c
> +++ b/drivers/media/platform/amphion/venc.c
> @@ -680,6 +680,9 @@ static int venc_ctrl_init(struct vpu_inst *inst)
>  			       ~(1 << V4L2_MPEG_VIDEO_HEADER_MODE_JOINED_WITH_1ST_FRAME),
>  			       V4L2_MPEG_VIDEO_HEADER_MODE_JOINED_WITH_1ST_FRAME);
>  
> +	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
> +			  V4L2_CID_MPEG_VIDEO_AVERAGE_QP, 0, 51, 1, 0);
> +
>  	if (inst->ctrl_handler.error) {
>  		ret = inst->ctrl_handler.error;
>  		v4l2_ctrl_handler_free(&inst->ctrl_handler);
> @@ -819,6 +822,7 @@ static int venc_get_one_encoded_frame(struct vpu_inst *inst,
>  	vbuf->field = inst->cap_format.field;
>  	vbuf->flags |= frame->info.pic_type;
>  	vpu_set_buffer_state(vbuf, VPU_BUF_STATE_IDLE);
> +	vpu_set_buffer_average_qp(vbuf, frame->info.average_qp);
>  	dev_dbg(inst->dev, "[%d][OUTPUT TS]%32lld\n", inst->id, vbuf->vb2_buf.timestamp);
>  	v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_DONE);
>  	venc->ready_count++;
> diff --git a/drivers/media/platform/amphion/vpu.h b/drivers/media/platform/amphion/vpu.h
> index 0246cf0ac3a8..d21ca6bf2459 100644
> --- a/drivers/media/platform/amphion/vpu.h
> +++ b/drivers/media/platform/amphion/vpu.h
> @@ -270,6 +270,7 @@ struct vpu_inst {
>  	u8 xfer_func;
>  	u32 sequence;
>  	u32 extra_size;
> +	u32 current_average_qp;
>  
>  	u32 flows[16];
>  	u32 flow_idx;
> @@ -306,6 +307,7 @@ struct vpu_vb2_buffer {
>  	dma_addr_t chroma_v;
>  	unsigned int state;
>  	u32 tag;
> +	u32 average_qp;
>  };
>  
>  void vpu_writel(struct vpu_dev *vpu, u32 reg, u32 val);
> diff --git a/drivers/media/platform/amphion/vpu_defs.h b/drivers/media/platform/amphion/vpu_defs.h
> index 7320852668d6..428d988cf2f7 100644
> --- a/drivers/media/platform/amphion/vpu_defs.h
> +++ b/drivers/media/platform/amphion/vpu_defs.h
> @@ -114,6 +114,7 @@ struct vpu_enc_pic_info {
>  	u32 wptr;
>  	u32 crc;
>  	s64 timestamp;
> +	u32 average_qp;
>  };
>  
>  struct vpu_dec_codec_info {
> diff --git a/drivers/media/platform/amphion/vpu_helpers.c b/drivers/media/platform/amphion/vpu_helpers.c
> index d12310af9ebc..59139302cb1d 100644
> --- a/drivers/media/platform/amphion/vpu_helpers.c
> +++ b/drivers/media/platform/amphion/vpu_helpers.c
> @@ -378,6 +378,9 @@ int vpu_helper_g_volatile_ctrl(struct v4l2_ctrl *ctrl)
>  	case V4L2_CID_MIN_BUFFERS_FOR_OUTPUT:
>  		ctrl->val = inst->min_buffer_out;
>  		break;
> +	case V4L2_CID_MPEG_VIDEO_AVERAGE_QP:
> +		ctrl->val = inst->current_average_qp;
> +		break;

This is not a volatile control. Instead, the control should be updated
with the new average_qp in the vpu_vb2_buf_finish function.

Regards,

	Hans

>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/drivers/media/platform/amphion/vpu_v4l2.c b/drivers/media/platform/amphion/vpu_v4l2.c
> index c88738e8fff7..893f494ffb0b 100644
> --- a/drivers/media/platform/amphion/vpu_v4l2.c
> +++ b/drivers/media/platform/amphion/vpu_v4l2.c
> @@ -63,6 +63,13 @@ unsigned int vpu_get_buffer_state(struct vb2_v4l2_buffer *vbuf)
>  	return vpu_buf->state;
>  }
>  
> +void vpu_set_buffer_average_qp(struct vb2_v4l2_buffer *vbuf, u32 qp)
> +{
> +	struct vpu_vb2_buffer *vpu_buf = to_vpu_vb2_buffer(vbuf);
> +
> +	vpu_buf->average_qp = qp;
> +}
> +
>  void vpu_v4l2_set_error(struct vpu_inst *inst)
>  {
>  	vpu_inst_lock(inst);
> @@ -536,9 +543,11 @@ static int vpu_vb2_buf_prepare(struct vb2_buffer *vb)
>  static void vpu_vb2_buf_finish(struct vb2_buffer *vb)
>  {
>  	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
> +	struct vpu_vb2_buffer *vpu_buf = to_vpu_vb2_buffer(vbuf);
>  	struct vpu_inst *inst = vb2_get_drv_priv(vb->vb2_queue);
>  	struct vb2_queue *q = vb->vb2_queue;
>  
> +	inst->current_average_qp = vpu_buf->average_qp;
>  	if (vbuf->flags & V4L2_BUF_FLAG_LAST)
>  		vpu_notify_eos(inst);
>  
> diff --git a/drivers/media/platform/amphion/vpu_v4l2.h b/drivers/media/platform/amphion/vpu_v4l2.h
> index 60f43056a7a2..56f2939fa84d 100644
> --- a/drivers/media/platform/amphion/vpu_v4l2.h
> +++ b/drivers/media/platform/amphion/vpu_v4l2.h
> @@ -12,6 +12,7 @@ void vpu_inst_lock(struct vpu_inst *inst);
>  void vpu_inst_unlock(struct vpu_inst *inst);
>  void vpu_set_buffer_state(struct vb2_v4l2_buffer *vbuf, unsigned int state);
>  unsigned int vpu_get_buffer_state(struct vb2_v4l2_buffer *vbuf);
> +void vpu_set_buffer_average_qp(struct vb2_v4l2_buffer *vbuf, u32 qp);
>  
>  int vpu_v4l2_open(struct file *file, struct vpu_inst *inst);
>  int vpu_v4l2_close(struct file *file);
> diff --git a/drivers/media/platform/amphion/vpu_windsor.c b/drivers/media/platform/amphion/vpu_windsor.c
> index 5f1101d7cf9e..e7d37aa4b826 100644
> --- a/drivers/media/platform/amphion/vpu_windsor.c
> +++ b/drivers/media/platform/amphion/vpu_windsor.c
> @@ -499,6 +499,7 @@ struct windsor_pic_info {
>  	u32 proc_dacc_rng_wr_cnt;
>  	s32 tv_s;
>  	u32 tv_ns;
> +	u32 average_qp;
>  };
>  
>  u32 vpu_windsor_get_data_size(void)
> @@ -734,6 +735,7 @@ static void vpu_windsor_unpack_pic_info(struct vpu_rpc_event *pkt, void *data)
>  	info->wptr = get_ptr(windsor->str_buff_wptr);
>  	info->crc = windsor->frame_crc;
>  	info->timestamp = timespec64_to_ns(&ts);
> +	info->average_qp = windsor->average_qp;
>  }
>  
>  static void vpu_windsor_unpack_mem_req(struct vpu_rpc_event *pkt, void *data)



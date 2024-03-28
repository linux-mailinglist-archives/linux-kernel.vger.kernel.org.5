Return-Path: <linux-kernel+bounces-123229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 777218904D2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4F6A1F26DB3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C4981751;
	Thu, 28 Mar 2024 16:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GU62DeY+"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47501272AC;
	Thu, 28 Mar 2024 16:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711642693; cv=none; b=NCyQ4YckDtL+N1t83HETPa1dLAly4BeKWAFYOGtb4p2Bjxe7G0pMcBAid8+egi0BoKr4Ch6mfJ91vPPzsSC+HR7B+NPkKRa7MxM411jgOkrS1nWdUw5MWOi/Gv+WAJkUgM2WfAV0Ojyg74qJ6WtlEMGF3Re6VZKpseOkZ2OtNe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711642693; c=relaxed/simple;
	bh=rQfwKoi3fNI819v+MhT9zxpHr1nI/oSFORtdSOrz7iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pj6kosm9A1f9iCnS0lhI933Y3TCe60lCPvLh+0PkJJadkfjQn69MSBmx76xHJPy54vNZuMfwFMj776G5OgYYby6sVdC5Tvnsaknj4KuJWk5fPmjLV7nxBwd2CQ9b63nKn/HWbCfg9Q2+RBbLqYKe8pyQXy6OcDQ2TBvxaaYx+yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GU62DeY+; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711642688;
	bh=rQfwKoi3fNI819v+MhT9zxpHr1nI/oSFORtdSOrz7iw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GU62DeY+HMvlrtiYorx3WIQegavgGW6lzyGf9BJeuL6mIKuxDrBgdkaRfKUZLthXu
	 4xn3k2/kztOyatu8CT3/zZ9B+bcrLOWsM4H8/odUNz+M+K3YaOgnQxruP1iO5kaPVL
	 Aby67VS62rgynl9h3427KXrCZnKJ6s3SRp13GoxxwHOPAiwl8+ITy9/AzDw1zoXlfA
	 eZ7RqFacPY4CdSVSBEKA5/pBB6oSkKu3cOZY6cqn6oeZ3oC4aM9qD9Kvv3RJESfKhC
	 JswGB9ZvMw3FNEyJw4qx0H3ZPNaHfC93Z+UMnbTDzrjnJKPVFojDxUFM3CzfCso6Eh
	 JJfZiWeWO57mQ==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sebastianfricke)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 73B533782114;
	Thu, 28 Mar 2024 16:18:08 +0000 (UTC)
Date: Thu, 28 Mar 2024 17:18:07 +0100
From: Sebastian Fricke <sebastian.fricke@collabora.com>
To: Ivan Bornyakov <brnkv.i1@gmail.com>
Cc: Nas Chung <nas.chung@chipsnmedia.com>,
	Jackson Lee <jackson.lee@chipsnmedia.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] media: chips-media: wave5: support Wave515 decoder
Message-ID: <20240328161807.vaar3w6vmhn23lmm@basti-XPS-13-9310>
References: <20240325064102.9278-1-brnkv.i1@gmail.com>
 <20240325064102.9278-6-brnkv.i1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20240325064102.9278-6-brnkv.i1@gmail.com>

Hey Ivan,

@Nas or Jackson can you please provide your tested-by to ensure that
this doesn't break 521C. Thanks!

Thanks for the patches Ivan, see my comments inline below.

On 25.03.2024 09:41, Ivan Bornyakov wrote:
>Add initial support for Wave515 multi-decoder IP. For now it is only
>able to decode HEVC Main/Main10 profile videos.
>
>This was tested on FPGA prototype, so wave5_dt_ids[] was not expanded.
>Users of the real hardware with Wave515 IP will have to
> * provide firmware specific to their SoC
> * add struct wave5_match_data like this:
>
>	static const struct wave5_match_data platform_name_wave515_data = {
>		.flags = WAVE5_IS_DEC,
>		.fw_name = "cnm/wave515_platform_name_fw.bin",
>	};
>
> * add item to wave5_dt_ids[] like this:
>
>	{
>		.compatible = "vendor,soc-wave515",
>		.data = &platform_name_wave515_data,
>	},
>
> * describe new compatible in
>   Documentation/devicetree/bindings/media/cnm,wave521c.yaml
>
>Signed-off-by: Ivan Bornyakov <brnkv.i1@gmail.com>
>---
> .../platform/chips-media/wave5/wave5-helper.c |   3 +-
> .../platform/chips-media/wave5/wave5-hw.c     | 245 ++++++++++++++----
> .../chips-media/wave5/wave5-regdefine.h       |   5 +
> .../platform/chips-media/wave5/wave5-vdi.c    |   6 +-
> .../chips-media/wave5/wave5-vpu-dec.c         |  14 +-
> .../platform/chips-media/wave5/wave5-vpu.c    |   8 +-
> .../platform/chips-media/wave5/wave5-vpuapi.h |   1 +
> .../chips-media/wave5/wave5-vpuconfig.h       |   9 +-
> .../media/platform/chips-media/wave5/wave5.h  |   1 +
> 9 files changed, 233 insertions(+), 59 deletions(-)
>
>diff --git a/drivers/media/platform/chips-media/wave5/wave5-helper.c b/drivers/media/platform/chips-media/wave5/wave5-helper.c
>index 8433ecab230c..c68f1e110ed9 100644
>--- a/drivers/media/platform/chips-media/wave5/wave5-helper.c
>+++ b/drivers/media/platform/chips-media/wave5/wave5-helper.c
>@@ -29,7 +29,8 @@ void wave5_cleanup_instance(struct vpu_instance *inst)
> {
> 	int i;
>
>-	if (list_is_singular(&inst->list))
>+	if (list_is_singular(&inst->list) &&
>+	    inst->dev->product_code != WAVE515_CODE)
> 		wave5_vdi_free_sram(inst->dev);

So you free the sram instead in unregister device, can you note that
here please and maybe briefly explain why that is needed otherwise, one
might assume the 515 doesn't use an SRAM.

>
> 	for (i = 0; i < inst->fbc_buf_count; i++)
>diff --git a/drivers/media/platform/chips-media/wave5/wave5-hw.c b/drivers/media/platform/chips-media/wave5/wave5-hw.c
>index cdd0a0948a94..e38995de6870 100644
>--- a/drivers/media/platform/chips-media/wave5/wave5-hw.c
>+++ b/drivers/media/platform/chips-media/wave5/wave5-hw.c
>@@ -24,8 +24,10 @@
> #define FEATURE_HEVC_ENCODER		BIT(0)
>
> /* Decoder support fields */
>+#define W515_FEATURE_HEVC10BIT_DEC	BIT(1)
> #define FEATURE_AVC_DECODER		BIT(3)
> #define FEATURE_HEVC_DECODER		BIT(2)
>+#define W515_FEATURE_HEVC_DECODER	BIT(0)

I don't understand the order of these entries.
Either group the W515 ones or sort them by bit value or by codec but
this just seems random.
Also, as mentioned below please rename the other feature values, as you
show that they are clearly not general purpose but for a specific
device/device group.

>
> #define FEATURE_BACKBONE		BIT(16)
> #define FEATURE_VCORE_BACKBONE		BIT(22)
>@@ -155,6 +157,8 @@ static int wave5_wait_bus_busy(struct vpu_device *vpu_dev, unsigned int addr)
> {
> 	u32 gdi_status_check_value = 0x3f;
>
>+	if (vpu_dev->product_code == WAVE515_CODE)
>+		gdi_status_check_value = 0x0738;
> 	if (vpu_dev->product_code == WAVE521C_CODE ||
> 	    vpu_dev->product_code == WAVE521_CODE ||
> 	    vpu_dev->product_code == WAVE521E1_CODE)
>@@ -186,6 +190,8 @@ unsigned int wave5_vpu_get_product_id(struct vpu_device *vpu_dev)
> 	u32 val = vpu_read_reg(vpu_dev, W5_PRODUCT_NUMBER);
>
> 	switch (val) {
>+	case WAVE515_CODE:
>+		return PRODUCT_ID_515;
> 	case WAVE521C_CODE:
> 		return PRODUCT_ID_521;
> 	case WAVE521_CODE:
>@@ -349,17 +355,33 @@ static int setup_wave5_properties(struct device *dev)
> 	hw_config_def1 = vpu_read_reg(vpu_dev, W5_RET_STD_DEF1);
> 	hw_config_feature = vpu_read_reg(vpu_dev, W5_RET_CONF_FEATURE);
>
>-	p_attr->support_hevc10bit_enc = FIELD_GET(FEATURE_HEVC10BIT_ENC, hw_config_feature);
>-	p_attr->support_avc10bit_enc = FIELD_GET(FEATURE_AVC10BIT_ENC, hw_config_feature);
>-
>-	p_attr->support_decoders = FIELD_GET(FEATURE_AVC_DECODER, hw_config_def1) << STD_AVC;
>-	p_attr->support_decoders |= FIELD_GET(FEATURE_HEVC_DECODER, hw_config_def1) << STD_HEVC;
>-	p_attr->support_encoders = FIELD_GET(FEATURE_AVC_ENCODER, hw_config_def1) << STD_AVC;
>-	p_attr->support_encoders |= FIELD_GET(FEATURE_HEVC_ENCODER, hw_config_def1) << STD_HEVC;
>-
>-	p_attr->support_backbone = FIELD_GET(FEATURE_BACKBONE, hw_config_def0);
>-	p_attr->support_vcpu_backbone = FIELD_GET(FEATURE_VCPU_BACKBONE, hw_config_def0);
>-	p_attr->support_vcore_backbone = FIELD_GET(FEATURE_VCORE_BACKBONE, hw_config_def0);
>+	if (vpu_dev->product_code == WAVE515_CODE) {
>+		p_attr->support_hevc10bit_dec = FIELD_GET(W515_FEATURE_HEVC10BIT_DEC,
>+							  hw_config_feature);
>+		p_attr->support_decoders = FIELD_GET(W515_FEATURE_HEVC_DECODER,
>+						     hw_config_def1) << STD_HEVC;
>+	} else {
>+		p_attr->support_hevc10bit_enc = FIELD_GET(FEATURE_HEVC10BIT_ENC,

Now that the Wave515 features have a product code, this will become
quite confusing in a bit. Can you please rename the ones from WAVE521C
like you did for Wave515?

>+							  hw_config_feature);
>+		p_attr->support_avc10bit_enc = FIELD_GET(FEATURE_AVC10BIT_ENC,
>+							 hw_config_feature);
>+
>+		p_attr->support_decoders = FIELD_GET(FEATURE_AVC_DECODER,
>+						     hw_config_def1) << STD_AVC;
>+		p_attr->support_decoders |= FIELD_GET(FEATURE_HEVC_DECODER,
>+						      hw_config_def1) << STD_HEVC;
>+		p_attr->support_encoders = FIELD_GET(FEATURE_AVC_ENCODER,
>+						     hw_config_def1) << STD_AVC;
>+		p_attr->support_encoders |= FIELD_GET(FEATURE_HEVC_ENCODER,
>+						      hw_config_def1) << STD_HEVC;
>+
>+		p_attr->support_backbone = FIELD_GET(FEATURE_BACKBONE,
>+						     hw_config_def0);
>+		p_attr->support_vcpu_backbone = FIELD_GET(FEATURE_VCPU_BACKBONE,
>+							  hw_config_def0);
>+		p_attr->support_vcore_backbone = FIELD_GET(FEATURE_VCORE_BACKBONE,
>+							   hw_config_def0);
>+	}
>
> 	setup_wave5_interrupts(vpu_dev);
>
>@@ -403,12 +425,18 @@ int wave5_vpu_init(struct device *dev, u8 *fw, size_t size)
> 	common_vb = &vpu_dev->common_mem;
>
> 	code_base = common_vb->daddr;
>+
>+	if (vpu_dev->product_code == WAVE515_CODE)
>+		code_size = WAVE515_MAX_CODE_BUF_SIZE;
>+	else
>+		code_size = WAVE5_MAX_CODE_BUF_SIZE;

This one is similar, if WAVE5_MAX_CODE_BUF_SIZE is not the maximum for
all wave5 variations then we should rename it to be fitting for the one
it was originally used for, e.g. Wave521C.
>+
> 	/* ALIGN TO 4KB */
>-	code_size = (WAVE5_MAX_CODE_BUF_SIZE & ~0xfff);
>+	code_size &= ~0xfff;
> 	if (code_size < size * 2)
> 		return -EINVAL;
>
>-	temp_base = common_vb->daddr + WAVE5_TEMPBUF_OFFSET;
>+	temp_base = code_base + code_size;
> 	temp_size = WAVE5_TEMPBUF_SIZE;
>
> 	ret = wave5_vdi_write_memory(vpu_dev, common_vb, 0, fw, size);
>@@ -436,9 +464,12 @@ int wave5_vpu_init(struct device *dev, u8 *fw, size_t size)
>
> 	/* These register must be reset explicitly */
> 	vpu_write_reg(vpu_dev, W5_HW_OPTION, 0);
>-	wave5_fio_writel(vpu_dev, W5_BACKBONE_PROC_EXT_ADDR, 0);
>-	wave5_fio_writel(vpu_dev, W5_BACKBONE_AXI_PARAM, 0);
>-	vpu_write_reg(vpu_dev, W5_SEC_AXI_PARAM, 0);
>+
>+	if (vpu_dev->product_code != WAVE515_CODE) {
>+		wave5_fio_writel(vpu_dev, W5_BACKBONE_PROC_EXT_ADDR, 0);
>+		wave5_fio_writel(vpu_dev, W5_BACKBONE_AXI_PARAM, 0);
>+		vpu_write_reg(vpu_dev, W5_SEC_AXI_PARAM, 0);
>+	}
>
> 	reg_val = vpu_read_reg(vpu_dev, W5_VPU_RET_VPU_CONFIG0);
> 	if (FIELD_GET(FEATURE_BACKBONE, reg_val)) {
>@@ -453,6 +484,24 @@ int wave5_vpu_init(struct device *dev, u8 *fw, size_t size)
> 		wave5_fio_writel(vpu_dev, W5_BACKBONE_PROG_AXI_ID, reg_val);
> 	}
>
>+	if (vpu_dev->product_code == WAVE515_CODE) {
>+		dma_addr_t task_buf_base;
>+
>+		vpu_write_reg(vpu_dev, W5_CMD_INIT_NUM_TASK_BUF, WAVE515_COMMAND_QUEUE_DEPTH);
>+		vpu_write_reg(vpu_dev, W5_CMD_INIT_TASK_BUF_SIZE, WAVE515_ONE_TASKBUF_SIZE);
>+
>+		for (i = 0; i < WAVE515_COMMAND_QUEUE_DEPTH; i++) {
>+			task_buf_base = temp_base + temp_size +
>+					(i * WAVE515_ONE_TASKBUF_SIZE);
>+			vpu_write_reg(vpu_dev,
>+				      W5_CMD_INIT_ADDR_TASK_BUF0 + (i * 4),
>+				      task_buf_base);
>+		}
>+
>+		vpu_write_reg(vpu_dev, W515_CMD_ADDR_SEC_AXI, vpu_dev->sram_buf.daddr);
>+		vpu_write_reg(vpu_dev, W515_CMD_SEC_AXI_SIZE, vpu_dev->sram_buf.size);
>+	}
>+
> 	vpu_write_reg(vpu_dev, W5_VPU_BUSY_STATUS, 1);
> 	vpu_write_reg(vpu_dev, W5_COMMAND, W5_INIT_VPU);
> 	vpu_write_reg(vpu_dev, W5_VPU_REMAP_CORE_START, 1);
>@@ -493,29 +542,39 @@ int wave5_vpu_build_up_dec_param(struct vpu_instance *inst,
> 		return -EINVAL;
> 	}
>
>-	p_dec_info->vb_work.size = WAVE521DEC_WORKBUF_SIZE;
>+	if (vpu_dev->product == PRODUCT_ID_515)
>+		p_dec_info->vb_work.size = WAVE515DEC_WORKBUF_SIZE;
>+	else
>+		p_dec_info->vb_work.size = WAVE521DEC_WORKBUF_SIZE;
>+
> 	ret = wave5_vdi_allocate_dma_memory(inst->dev, &p_dec_info->vb_work);
> 	if (ret)
> 		return ret;
>
>-	vpu_write_reg(inst->dev, W5_CMD_DEC_VCORE_INFO, 1);
>+	if (inst->dev->product_code != WAVE515_CODE)
>+		vpu_write_reg(inst->dev, W5_CMD_DEC_VCORE_INFO, 1);
>
> 	wave5_vdi_clear_memory(inst->dev, &p_dec_info->vb_work);
>
> 	vpu_write_reg(inst->dev, W5_ADDR_WORK_BASE, p_dec_info->vb_work.daddr);
> 	vpu_write_reg(inst->dev, W5_WORK_SIZE, p_dec_info->vb_work.size);
>
>-	vpu_write_reg(inst->dev, W5_CMD_ADDR_SEC_AXI, vpu_dev->sram_buf.daddr);
>-	vpu_write_reg(inst->dev, W5_CMD_SEC_AXI_SIZE, vpu_dev->sram_buf.size);
>+	if (inst->dev->product_code != WAVE515_CODE) {
>+		vpu_write_reg(inst->dev, W5_CMD_ADDR_SEC_AXI, vpu_dev->sram_buf.daddr);
>+		vpu_write_reg(inst->dev, W5_CMD_SEC_AXI_SIZE, vpu_dev->sram_buf.size);
>+	}
>
> 	vpu_write_reg(inst->dev, W5_CMD_DEC_BS_START_ADDR, p_dec_info->stream_buf_start_addr);
> 	vpu_write_reg(inst->dev, W5_CMD_DEC_BS_SIZE, p_dec_info->stream_buf_size);
>
> 	/* NOTE: SDMA reads MSB first */
> 	vpu_write_reg(inst->dev, W5_CMD_BS_PARAM, BITSTREAM_ENDIANNESS_BIG_ENDIAN);
>-	/* This register must be reset explicitly */
>-	vpu_write_reg(inst->dev, W5_CMD_EXT_ADDR, 0);
>-	vpu_write_reg(inst->dev, W5_CMD_NUM_CQ_DEPTH_M1, (COMMAND_QUEUE_DEPTH - 1));
>+
>+	if (inst->dev->product_code != WAVE515_CODE) {
>+		/* This register must be reset explicitly */
>+		vpu_write_reg(inst->dev, W5_CMD_EXT_ADDR, 0);
>+		vpu_write_reg(inst->dev, W5_CMD_NUM_CQ_DEPTH_M1, (COMMAND_QUEUE_DEPTH - 1));
>+	}
>
> 	ret = send_firmware_command(inst, W5_CREATE_INSTANCE, true, NULL, NULL);
> 	if (ret) {
>@@ -566,7 +625,7 @@ static u32 get_bitstream_options(struct dec_info *info)
> int wave5_vpu_dec_init_seq(struct vpu_instance *inst)
> {
> 	struct dec_info *p_dec_info = &inst->codec_info->dec_info;
>-	u32 cmd_option = INIT_SEQ_NORMAL;
>+	u32 bs_option, cmd_option = INIT_SEQ_NORMAL;
> 	u32 reg_val, fail_res;
> 	int ret;
>
>@@ -576,7 +635,12 @@ int wave5_vpu_dec_init_seq(struct vpu_instance *inst)
> 	vpu_write_reg(inst->dev, W5_BS_RD_PTR, p_dec_info->stream_rd_ptr);
> 	vpu_write_reg(inst->dev, W5_BS_WR_PTR, p_dec_info->stream_wr_ptr);
>
>-	vpu_write_reg(inst->dev, W5_BS_OPTION, get_bitstream_options(p_dec_info));
>+	bs_option = get_bitstream_options(p_dec_info);
>+
>+	if (inst->dev->product_code == WAVE515_CODE)
>+		bs_option |= BSOPTION_RD_PTR_VALID_FLAG;

Is it possible to add a brief comment here that describes why this is
needed for that device and what this will change for the process?

>+
>+	vpu_write_reg(inst->dev, W5_BS_OPTION, bs_option);
>
> 	vpu_write_reg(inst->dev, W5_COMMAND_OPTION, cmd_option);
> 	vpu_write_reg(inst->dev, W5_CMD_DEC_USER_MASK, p_dec_info->user_data_enable);
>@@ -642,10 +706,12 @@ static void wave5_get_dec_seq_result(struct vpu_instance *inst, struct dec_initi
> 		info->profile = FIELD_GET(SEQ_PARAM_PROFILE_MASK, reg_val);
> 	}
>
>-	info->vlc_buf_size = vpu_read_reg(inst->dev, W5_RET_VLC_BUF_SIZE);
>-	info->param_buf_size = vpu_read_reg(inst->dev, W5_RET_PARAM_BUF_SIZE);
>-	p_dec_info->vlc_buf_size = info->vlc_buf_size;
>-	p_dec_info->param_buf_size = info->param_buf_size;
>+	if (inst->dev->product_code != WAVE515_CODE) {
>+		info->vlc_buf_size = vpu_read_reg(inst->dev, W5_RET_VLC_BUF_SIZE);
>+		info->param_buf_size = vpu_read_reg(inst->dev, W5_RET_PARAM_BUF_SIZE);
>+		p_dec_info->vlc_buf_size = info->vlc_buf_size;
>+		p_dec_info->param_buf_size = info->param_buf_size;
>+	}
> }
>
> int wave5_vpu_dec_get_seq_info(struct vpu_instance *inst, struct dec_initial_info *info)
>@@ -747,22 +813,27 @@ int wave5_vpu_dec_register_framebuffer(struct vpu_instance *inst, struct frame_b
>
> 		pic_size = (init_info->pic_width << 16) | (init_info->pic_height);
>
>-		vb_buf.size = (p_dec_info->vlc_buf_size * VLC_BUF_NUM) +
>+		if (inst->dev->product_code != WAVE515_CODE) {
>+			vb_buf.size = (p_dec_info->vlc_buf_size * VLC_BUF_NUM) +
> 				(p_dec_info->param_buf_size * COMMAND_QUEUE_DEPTH);
>-		vb_buf.daddr = 0;
>+			vb_buf.daddr = 0;
>
>-		if (vb_buf.size != p_dec_info->vb_task.size) {
>-			wave5_vdi_free_dma_memory(inst->dev, &p_dec_info->vb_task);
>-			ret = wave5_vdi_allocate_dma_memory(inst->dev, &vb_buf);
>-			if (ret)
>-				goto free_fbc_c_tbl_buffers;
>+			if (vb_buf.size != p_dec_info->vb_task.size) {
>+				wave5_vdi_free_dma_memory(inst->dev,
>+							  &p_dec_info->vb_task);
>+				ret = wave5_vdi_allocate_dma_memory(inst->dev,
>+								    &vb_buf);
>+				if (ret)
>+					goto free_fbc_c_tbl_buffers;
>
>-			p_dec_info->vb_task = vb_buf;
>-		}
>+				p_dec_info->vb_task = vb_buf;
>+			}
>
>-		vpu_write_reg(inst->dev, W5_CMD_SET_FB_ADDR_TASK_BUF,
>-			      p_dec_info->vb_task.daddr);
>-		vpu_write_reg(inst->dev, W5_CMD_SET_FB_TASK_BUF_SIZE, vb_buf.size);
>+			vpu_write_reg(inst->dev, W5_CMD_SET_FB_ADDR_TASK_BUF,
>+				      p_dec_info->vb_task.daddr);
>+			vpu_write_reg(inst->dev, W5_CMD_SET_FB_TASK_BUF_SIZE,
>+				      vb_buf.size);
>+		}
> 	} else {
> 		pic_size = (init_info->pic_width << 16) | (init_info->pic_height);
>
>@@ -999,17 +1070,24 @@ int wave5_vpu_re_init(struct device *dev, u8 *fw, size_t size)
> 	dma_addr_t code_base, temp_base;
> 	dma_addr_t old_code_base, temp_size;
> 	u32 code_size, reason_code;
>-	u32 reg_val;
>+	u32 i, reg_val;

You only use the variable i within the conditional branch below, so you
can just declare it there.

> 	struct vpu_device *vpu_dev = dev_get_drvdata(dev);
>
> 	common_vb = &vpu_dev->common_mem;
>
> 	code_base = common_vb->daddr;
>+
>+	if (vpu_dev->product_code == WAVE515_CODE)
>+		code_size = WAVE515_MAX_CODE_BUF_SIZE;
>+	else
>+		code_size = WAVE5_MAX_CODE_BUF_SIZE;
>+
> 	/* ALIGN TO 4KB */
>-	code_size = (WAVE5_MAX_CODE_BUF_SIZE & ~0xfff);
>+	code_size &= ~0xfff;
> 	if (code_size < size * 2)
> 		return -EINVAL;
>-	temp_base = common_vb->daddr + WAVE5_TEMPBUF_OFFSET;
>+
>+	temp_base = code_base + code_size;
> 	temp_size = WAVE5_TEMPBUF_SIZE;
>
> 	old_code_base = vpu_read_reg(vpu_dev, W5_VPU_REMAP_PADDR);
>@@ -1043,9 +1121,12 @@ int wave5_vpu_re_init(struct device *dev, u8 *fw, size_t size)
>
> 		/* These register must be reset explicitly */
> 		vpu_write_reg(vpu_dev, W5_HW_OPTION, 0);
>-		wave5_fio_writel(vpu_dev, W5_BACKBONE_PROC_EXT_ADDR, 0);
>-		wave5_fio_writel(vpu_dev, W5_BACKBONE_AXI_PARAM, 0);
>-		vpu_write_reg(vpu_dev, W5_SEC_AXI_PARAM, 0);
>+
>+		if (vpu_dev->product_code != WAVE515_CODE) {
>+			wave5_fio_writel(vpu_dev, W5_BACKBONE_PROC_EXT_ADDR, 0);
>+			wave5_fio_writel(vpu_dev, W5_BACKBONE_AXI_PARAM, 0);
>+			vpu_write_reg(vpu_dev, W5_SEC_AXI_PARAM, 0);
>+		}
>
> 		reg_val = vpu_read_reg(vpu_dev, W5_VPU_RET_VPU_CONFIG0);
> 		if (FIELD_GET(FEATURE_BACKBONE, reg_val)) {
>@@ -1060,6 +1141,28 @@ int wave5_vpu_re_init(struct device *dev, u8 *fw, size_t size)
> 			wave5_fio_writel(vpu_dev, W5_BACKBONE_PROG_AXI_ID, reg_val);
> 		}
>
>+		if (vpu_dev->product_code == WAVE515_CODE) {
>+			dma_addr_t task_buf_base;

As mentioned above you can declare the variable i here.

>+
>+			vpu_write_reg(vpu_dev, W5_CMD_INIT_NUM_TASK_BUF,
>+				      WAVE515_COMMAND_QUEUE_DEPTH);
>+			vpu_write_reg(vpu_dev, W5_CMD_INIT_TASK_BUF_SIZE,
>+				      WAVE515_ONE_TASKBUF_SIZE);
>+
>+			for (i = 0; i < WAVE515_COMMAND_QUEUE_DEPTH; i++) {
>+				task_buf_base = temp_base + temp_size +
>+						(i * WAVE515_ONE_TASKBUF_SIZE);
>+				vpu_write_reg(vpu_dev,
>+					      W5_CMD_INIT_ADDR_TASK_BUF0 + (i * 4),
>+					      task_buf_base);
>+			}
>+
>+			vpu_write_reg(vpu_dev, W515_CMD_ADDR_SEC_AXI,
>+				      vpu_dev->sram_buf.daddr);
>+			vpu_write_reg(vpu_dev, W515_CMD_SEC_AXI_SIZE,
>+				      vpu_dev->sram_buf.size);
>+		}
>+
> 		vpu_write_reg(vpu_dev, W5_VPU_BUSY_STATUS, 1);
> 		vpu_write_reg(vpu_dev, W5_COMMAND, W5_INIT_VPU);
> 		vpu_write_reg(vpu_dev, W5_VPU_REMAP_CORE_START, 1);
>@@ -1081,10 +1184,10 @@ int wave5_vpu_re_init(struct device *dev, u8 *fw, size_t size)
> static int wave5_vpu_sleep_wake(struct device *dev, bool i_sleep_wake, const uint16_t *code,
> 				size_t size)
> {
>-	u32 reg_val;
>+	u32 i, reg_val;

Like suggested in vpu_re_init please.

> 	struct vpu_buf *common_vb;
>-	dma_addr_t code_base;
>-	u32 code_size, reason_code;
>+	dma_addr_t code_base, temp_base;
>+	u32 code_size, temp_size, reason_code;
> 	struct vpu_device *vpu_dev = dev_get_drvdata(dev);
> 	int ret;
>
>@@ -1114,13 +1217,22 @@ static int wave5_vpu_sleep_wake(struct device *dev, bool i_sleep_wake, const uin
> 		common_vb = &vpu_dev->common_mem;
>
> 		code_base = common_vb->daddr;
>+
>+		if (vpu_dev->product_code == WAVE515_CODE)
>+			code_size = WAVE515_MAX_CODE_BUF_SIZE;
>+		else
>+			code_size = WAVE5_MAX_CODE_BUF_SIZE;
>+
> 		/* ALIGN TO 4KB */
>-		code_size = (WAVE5_MAX_CODE_BUF_SIZE & ~0xfff);
>+		code_size &= ~0xfff;
> 		if (code_size < size * 2) {
> 			dev_err(dev, "size too small\n");
> 			return -EINVAL;
> 		}
>
>+		temp_base = code_base + code_size;
>+		temp_size = WAVE5_TEMPBUF_SIZE;
>+
> 		/* Power on without DEBUG mode */
> 		vpu_write_reg(vpu_dev, W5_PO_CONF, 0);
>
>@@ -1133,9 +1245,12 @@ static int wave5_vpu_sleep_wake(struct device *dev, bool i_sleep_wake, const uin
>
> 		/* These register must be reset explicitly */
> 		vpu_write_reg(vpu_dev, W5_HW_OPTION, 0);
>-		wave5_fio_writel(vpu_dev, W5_BACKBONE_PROC_EXT_ADDR, 0);
>-		wave5_fio_writel(vpu_dev, W5_BACKBONE_AXI_PARAM, 0);
>-		vpu_write_reg(vpu_dev, W5_SEC_AXI_PARAM, 0);
>+
>+		if (vpu_dev->product_code != WAVE515_CODE) {
>+			wave5_fio_writel(vpu_dev, W5_BACKBONE_PROC_EXT_ADDR, 0);
>+			wave5_fio_writel(vpu_dev, W5_BACKBONE_AXI_PARAM, 0);
>+			vpu_write_reg(vpu_dev, W5_SEC_AXI_PARAM, 0);
>+		}
>
> 		setup_wave5_interrupts(vpu_dev);
>
>@@ -1152,6 +1267,28 @@ static int wave5_vpu_sleep_wake(struct device *dev, bool i_sleep_wake, const uin
> 			wave5_fio_writel(vpu_dev, W5_BACKBONE_PROG_AXI_ID, reg_val);
> 		}
>
>+		if (vpu_dev->product_code == WAVE515_CODE) {
>+			dma_addr_t task_buf_base;
>+
>+			vpu_write_reg(vpu_dev, W5_CMD_INIT_NUM_TASK_BUF,
>+				      WAVE515_COMMAND_QUEUE_DEPTH);
>+			vpu_write_reg(vpu_dev, W5_CMD_INIT_TASK_BUF_SIZE,
>+				      WAVE515_ONE_TASKBUF_SIZE);
>+
>+			for (i = 0; i < WAVE515_COMMAND_QUEUE_DEPTH; i++) {
>+				task_buf_base = temp_base + temp_size +
>+						(i * WAVE515_ONE_TASKBUF_SIZE);
>+				vpu_write_reg(vpu_dev,
>+					      W5_CMD_INIT_ADDR_TASK_BUF0 + (i * 4),
>+					      task_buf_base);
>+			}
>+
>+			vpu_write_reg(vpu_dev, W515_CMD_ADDR_SEC_AXI,
>+				      vpu_dev->sram_buf.daddr);
>+			vpu_write_reg(vpu_dev, W515_CMD_SEC_AXI_SIZE,
>+				      vpu_dev->sram_buf.size);
>+		}
>+
> 		vpu_write_reg(vpu_dev, W5_VPU_BUSY_STATUS, 1);
> 		vpu_write_reg(vpu_dev, W5_COMMAND, W5_WAKEUP_VPU);
> 		/* Start VPU after settings */
>diff --git a/drivers/media/platform/chips-media/wave5/wave5-regdefine.h b/drivers/media/platform/chips-media/wave5/wave5-regdefine.h
>index a15c6b2c3d8b..557344754c4c 100644
>--- a/drivers/media/platform/chips-media/wave5/wave5-regdefine.h
>+++ b/drivers/media/platform/chips-media/wave5/wave5-regdefine.h
>@@ -205,6 +205,9 @@ enum query_opt {
> #define W5_ADDR_TEMP_BASE                       (W5_REG_BASE + 0x011C)
> #define W5_TEMP_SIZE                            (W5_REG_BASE + 0x0120)
> #define W5_HW_OPTION                            (W5_REG_BASE + 0x012C)
>+#define W5_CMD_INIT_NUM_TASK_BUF		(W5_REG_BASE + 0x0134)
>+#define W5_CMD_INIT_ADDR_TASK_BUF0		(W5_REG_BASE + 0x0138)
>+#define W5_CMD_INIT_TASK_BUF_SIZE		(W5_REG_BASE + 0x0178)

It looks like you are using tabs here, while the others utilize spaces.
In general your tabs should expand to 8 whitespaces.
(https://www.kernel.org/doc/html/v4.10/process/coding-style.html#indentation)

> #define W5_SEC_AXI_PARAM                        (W5_REG_BASE + 0x0180)
>
> /************************************************************************/
>@@ -216,7 +219,9 @@ enum query_opt {
> #define W5_CMD_DEC_BS_SIZE                      (W5_REG_BASE + 0x0120)
> #define W5_CMD_BS_PARAM                         (W5_REG_BASE + 0x0124)
> #define W5_CMD_ADDR_SEC_AXI                     (W5_REG_BASE + 0x0130)
>+#define W515_CMD_ADDR_SEC_AXI			(W5_REG_BASE + 0x0124)
> #define W5_CMD_SEC_AXI_SIZE                     (W5_REG_BASE + 0x0134)
>+#define W515_CMD_SEC_AXI_SIZE			(W5_REG_BASE + 0x0128)

Same as above.

> #define W5_CMD_EXT_ADDR                         (W5_REG_BASE + 0x0138)
> #define W5_CMD_NUM_CQ_DEPTH_M1                  (W5_REG_BASE + 0x013C)
> #define W5_CMD_ERR_CONCEAL                      (W5_REG_BASE + 0x0140)
>diff --git a/drivers/media/platform/chips-media/wave5/wave5-vdi.c b/drivers/media/platform/chips-media/wave5/wave5-vdi.c
>index a63fffed55e9..78888c57b6da 100644
>--- a/drivers/media/platform/chips-media/wave5/wave5-vdi.c
>+++ b/drivers/media/platform/chips-media/wave5/wave5-vdi.c
>@@ -18,7 +18,11 @@ static int wave5_vdi_allocate_common_memory(struct device *dev)
> 	if (!vpu_dev->common_mem.vaddr) {
> 		int ret;
>
>-		vpu_dev->common_mem.size = SIZE_COMMON;
>+		if (vpu_dev->product_code == WAVE515_CODE)
>+			vpu_dev->common_mem.size = WAVE515_SIZE_COMMON;
>+		else
>+			vpu_dev->common_mem.size = SIZE_COMMON;
>+
> 		ret = wave5_vdi_allocate_dma_memory(vpu_dev, &vpu_dev->common_mem);
> 		if (ret) {
> 			dev_err(dev, "unable to allocate common buffer\n");
>diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
>index 5a71a711f2e8..65a99053c5e8 100644
>--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
>+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
>@@ -1869,7 +1869,8 @@ static int wave5_vpu_open_dec(struct file *filp)
> 		goto cleanup_inst;
> 	}
>
>-	wave5_vdi_allocate_sram(inst->dev);
>+	if (inst->dev->product_code != WAVE515_CODE)
>+		wave5_vdi_allocate_sram(inst->dev);
>
> 	return 0;
>
>@@ -1897,6 +1898,14 @@ int wave5_vpu_dec_register_device(struct vpu_device *dev)
> 	struct video_device *vdev_dec;
> 	int ret;
>
>+	/*
>+	 * secondary AXI setup for Wave515 is done by INIT_VPU command,
>+	 * that's why SRAM memory is allocated at VPU device register
>+	 * rather than at device open.

Just a nitpick, but if you use something that resembles more the actual
function names it makes it easier to grep this part or to refer to the
right function from reading this comment.
So for example: vpu_open_dec & vpu_dec_register_device

>+	 */
>+	if (dev->product_code == WAVE515_CODE)
>+		wave5_vdi_allocate_sram(dev);
>+
> 	vdev_dec = devm_kzalloc(dev->v4l2_dev.dev, sizeof(*vdev_dec), GFP_KERNEL);
> 	if (!vdev_dec)
> 		return -ENOMEM;
>@@ -1930,6 +1939,9 @@ int wave5_vpu_dec_register_device(struct vpu_device *dev)
>
> void wave5_vpu_dec_unregister_device(struct vpu_device *dev)
> {
>+	if (dev->product_code == WAVE515_CODE)
>+		wave5_vdi_free_sram(dev);

Why does that need to happen here just for this one version of the Wave5
codec?

>+
> 	video_unregister_device(dev->video_dev_dec);
> 	if (dev->v4l2_m2m_dec_dev)
> 		v4l2_m2m_release(dev->v4l2_m2m_dec_dev);
>diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
>index 2a972cddf4a6..fc267348399e 100644
>--- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
>+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
>@@ -60,7 +60,13 @@ static irqreturn_t wave5_vpu_irq_thread(int irq, void *dev_id)
>
> 			if (irq_reason & BIT(INT_WAVE5_INIT_SEQ) ||
> 			    irq_reason & BIT(INT_WAVE5_ENC_SET_PARAM)) {
>-				if (seq_done & BIT(inst->id)) {
>+				if ((dev->product_code == WAVE515_CODE) &&
>+				    (cmd_done & BIT(inst->id))) {
>+					cmd_done &= ~BIT(inst->id);
>+					wave5_vdi_write_register(dev, W5_RET_QUEUE_CMD_DONE_INST,
>+								 cmd_done);
>+					complete(&inst->irq_done);
>+				} else if (seq_done & BIT(inst->id)) {
> 					seq_done &= ~BIT(inst->id);
> 					wave5_vdi_write_register(dev, W5_RET_SEQ_DONE_INSTANCE_INFO,
> 								 seq_done);
>diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
>index 975d96b22191..601205df4433 100644
>--- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
>+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
>@@ -18,6 +18,7 @@
> #include "wave5-vdi.h"
>
> enum product_id {
>+	PRODUCT_ID_515,
> 	PRODUCT_ID_521,
> 	PRODUCT_ID_511,
> 	PRODUCT_ID_517,
>diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h b/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
>index 9d99afb78c89..b4128524fcfd 100644
>--- a/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
>+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
>@@ -8,6 +8,7 @@
> #ifndef _VPU_CONFIG_H_
> #define _VPU_CONFIG_H_
>
>+#define WAVE515_CODE			0x5150

Indentation again

> #define WAVE517_CODE                    0x5170
> #define WAVE537_CODE                    0x5370
> #define WAVE511_CODE                    0x5110
>@@ -21,12 +22,13 @@
> 		((c) == WAVE517_CODE ||	(c) == WAVE537_CODE ||		\
> 		 (c) == WAVE511_CODE || (c) == WAVE521_CODE ||		\
> 		 (c) == WAVE521E1_CODE || (c) == WAVE521C_CODE ||	\
>-		 (c) == WAVE521C_DUAL_CODE);				\
>+		 (c) == WAVE521C_DUAL_CODE) || (c) == WAVE515_CODE;	\
> })
>
> #define WAVE517_WORKBUF_SIZE            (2 * 1024 * 1024)
> #define WAVE521ENC_WORKBUF_SIZE         (128 * 1024)      //HEVC 128K, AVC 40K
> #define WAVE521DEC_WORKBUF_SIZE         (1784 * 1024)
>+#define WAVE515DEC_WORKBUF_SIZE		(2 * 1024 * 1024)
>
> #define WAVE5_MAX_SRAM_SIZE		(64 * 1024)
>
>@@ -52,16 +54,21 @@
> #define VLC_BUF_NUM                     (2)
>
> #define COMMAND_QUEUE_DEPTH             (2)
>+#define WAVE515_COMMAND_QUEUE_DEPTH	(4)
>
> #define W5_REMAP_INDEX0                 0
> #define W5_REMAP_INDEX1                 1
> #define W5_REMAP_MAX_SIZE               (1024 * 1024)
>
> #define WAVE5_MAX_CODE_BUF_SIZE         (2 * 1024 * 1024)
>+#define WAVE515_MAX_CODE_BUF_SIZE	(1024 * 1024)
> #define WAVE5_TEMPBUF_OFFSET            WAVE5_MAX_CODE_BUF_SIZE
> #define WAVE5_TEMPBUF_SIZE              (1024 * 1024)
>+#define WAVE515_TASKBUF_OFFSET		(WAVE515_MAX_CODE_BUF_SIZE + WAVE5_TEMPBUF_SIZE)
>
> #define SIZE_COMMON                 (WAVE5_MAX_CODE_BUF_SIZE + WAVE5_TEMPBUF_SIZE)

Just as above, this macro looks like a general macro now, but as we have
a Wave515 version this clearly isn't valid for all of them so please
rename the others.

>+#define WAVE515_ONE_TASKBUF_SIZE	(8 * 1024 * 1024)

Would something speak against: (8 * WAVE5_TEMPBUF_SIZE)?
(Especially as you use that macro for the calculation of the offset)
And why the gap between the the size and the offset? I think it makes
more sense to have them on top of each other

Just as above the indentation don't look right here.

>+#define WAVE515_SIZE_COMMON	(WAVE515_TASKBUF_OFFSET + WAVE515_COMMAND_QUEUE_DEPTH * WAVE515_ONE_TASKBUF_SIZE)
>
> //=====4. VPU REPORT MEMORY  ======================//
>
>diff --git a/drivers/media/platform/chips-media/wave5/wave5.h b/drivers/media/platform/chips-media/wave5/wave5.h
>index 063028eccd3b..57b00e182b6e 100644
>--- a/drivers/media/platform/chips-media/wave5/wave5.h
>+++ b/drivers/media/platform/chips-media/wave5/wave5.h
>@@ -22,6 +22,7 @@
>  */
> #define BSOPTION_ENABLE_EXPLICIT_END		BIT(0)
> #define BSOPTION_HIGHLIGHT_STREAM_END		BIT(1)
>+#define BSOPTION_RD_PTR_VALID_FLAG		BIT(31)

As explained above when you use it, I think an explanatory comment is
helpful here.

Greetings,
Sebastian
>
> /*
>  * Currently the driver only supports hardware with little endian but for source
>-- 
>2.44.0
>
>


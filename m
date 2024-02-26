Return-Path: <linux-kernel+bounces-82258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6526A868146
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87A731C25BBF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF7D131E55;
	Mon, 26 Feb 2024 19:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgvLdTHa"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0E7131E26;
	Mon, 26 Feb 2024 19:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708976489; cv=none; b=LL86H9oUzHcjfZF8QZXoWg+s/pW16Fe6ZsL3hhTmmwZXCHaTRrm+TuZouJTV4mOKKzRTPzVI4AhK1Iw6o+UadMRTz3BgLQC1Aa4XuY+shtnY8cXhZEBzNGcRHV2LYHo5BG4i2gRBqc0Glk9fehzvuzj8gm8+O0RO4Uea5RWf/MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708976489; c=relaxed/simple;
	bh=3QnEnAIOiL8y00WVgkVmOXEG1hPhqpBEJjwAvRXFpR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eNZGwjXmeRSnLFFp79FwG1QFyVlL/+qWmiIvDprkuIZmPG122fT4tWStz1Zilvjz2Ei2K4cffu5gdzPXk4ZpC66nqIK3FJFLYyKSAF3hJWyMerzZYZVFe8jW+H+en795TejWw9uusM3iSxdtaRpYSXyi/mZzQ08/npr+Spz55qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgvLdTHa; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-512e568607aso3423861e87.1;
        Mon, 26 Feb 2024 11:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708976484; x=1709581284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IhDLivYLv20Hp6P/4VgFRH+Rwf5bze2xAXsRl5m2rQk=;
        b=fgvLdTHaeE0sDMCgQKcZ/7cL1aldO7nnz4tB6QiDVMrr3WCnfhbMhc4FvWzTwO4EIr
         vYSMpLaZ/bkqyUn1raeXlu32evCz3W9oUTOj/cuABwvtNXamIKor/z85gxsmJPLLL8QY
         UgKWjMcAPqGnGra5nlcJD4o9ppz4hYKvXpDm2srhPAfw/nVX85oSo7JoDKcfbJhoCdxS
         XLQ/tGiv71tWTsXmtS8DmVtXrsdVtTnedoRnVBfULt4RGeN+bH3mRtiQNxDcg4TyD+r1
         +a4fsyXgcz2xxkimOZKQxScuZXOittoNQifDPFWO5rTI3/2c75oDEy26MqVpiUtYqb/1
         aoaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708976484; x=1709581284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IhDLivYLv20Hp6P/4VgFRH+Rwf5bze2xAXsRl5m2rQk=;
        b=Ou99HYCBZextA37GMVTl8KD9uTePxgZnyzE/slM7yZBIvMOAMX9+mdTfm1SsVPHSgM
         qOiYz56babD/74gduKLNon7yCuYsTqpgYH/pjqOfFFfFb3yUuzAs3UBJv1y9sQCihXN3
         DM06t1h+pS8q5EohVfC3sP76I7LVu4H7+xKQouJf1sMRoNIePhsQd1XGQ5RHQ4qoxDGt
         idx+/1l/dm7sc1DfopN8CIPFtSWF0H0xXPUuKum9db6KUpaai7yRx9VmTbEMZ99rC3ii
         uSfwhk9QtzWQiiTIAZvEa3ekuWy+oD79dsrfzTJDYZJsYaMNOMQ5uyHAz5ZU5ZXnjUch
         Thmg==
X-Forwarded-Encrypted: i=1; AJvYcCUU0fBVSkeiHE7NjvhYeVHZN6Aqc974XhCiZ/OdTunVrEn4gOR+RTaiVNdcu6MWtWAqrpiRJOQ0gbL+i/jDj+KTt9rK/fRGVKPG15PMLO6w70A14oAP9UdtioyKDSo/UyX/7usChpcZoPI=
X-Gm-Message-State: AOJu0YzmdifqslmWRkS9kKnDXH63AQw4wHDa0BkAEj86tq/gLrV9zKyA
	CVQ7uu5Y4ETUrIz+4onHVXM9QdX8VEy7nVmHDEiUuWjFAH2jNbuD
X-Google-Smtp-Source: AGHT+IEHmdTWvoD/A5dRjPOe0f2Vo6PH4ENpRJkA3ux5ZUUtCHuj3BiKL1dlK+/wepIdGb4lfmn3ZQ==
X-Received: by 2002:ac2:5584:0:b0:513:349:33fb with SMTP id v4-20020ac25584000000b00513034933fbmr269940lfg.16.1708976484279;
        Mon, 26 Feb 2024 11:41:24 -0800 (PST)
Received: from localhost.localdomain (c83-255-24-248.bredband.tele2.se. [83.255.24.248])
        by smtp.googlemail.com with ESMTPSA id e21-20020a196915000000b00512ffb9bae9sm332328lfc.143.2024.02.26.11.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 11:41:23 -0800 (PST)
From: Jonathan Bergh <bergh.jonathan@gmail.com>
To: hdegoede@redhat.com
Cc: mchehab@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH 6/6] staging: media: atomisp: Remove old commented code and fix multiple block comment style
Date: Mon, 26 Feb 2024 20:40:23 +0100
Message-Id: <20240226194023.69070-7-bergh.jonathan@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240226194023.69070-1-bergh.jonathan@gmail.com>
References: <20240226194023.69070-1-bergh.jonathan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes the following minor code and code style issues:
 * Removes a block of commented out (unused) code from the src
 * Reformats various multiline block comments to meet the kernel code
   style guidelines for block comments

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
 drivers/staging/media/atomisp/pci/sh_css_sp.c | 87 ++++++++++---------
 1 file changed, 48 insertions(+), 39 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/sh_css_sp.c b/drivers/staging/media/atomisp/pci/sh_css_sp.c
index 3ccbfcc553fb..2999d44d61d1 100644
--- a/drivers/staging/media/atomisp/pci/sh_css_sp.c
+++ b/drivers/staging/media/atomisp/pci/sh_css_sp.c
@@ -108,11 +108,6 @@ copy_isp_stage_to_sp_stage(void)
 		sh_css_isp_stage.binary_info.iterator.row_stripes_overlap_lines;
 	sh_css_sp_stage.top_cropping = (uint16_t)
 				       sh_css_isp_stage.binary_info.pipeline.top_cropping;
-	/* moved to sh_css_sp_init_stage
-	   sh_css_sp_stage.enable.vf_output =
-	   sh_css_isp_stage.binary_info.enable.vf_veceven ||
-	   sh_css_isp_stage.binary_info.num_output_pins > 1;
-	*/
 	sh_css_sp_stage.enable.sdis = sh_css_isp_stage.binary_info.enable.dis;
 	sh_css_sp_stage.enable.s3a = sh_css_isp_stage.binary_info.enable.s3a;
 }
@@ -411,14 +406,15 @@ sh_css_copy_buffer_attr_to_spbuffer(struct ia_css_buffer_sp *dest_buf,
 		 */
 		assert(queue_id < SH_CSS_MAX_NUM_QUEUES);
 
-		/* Klocwork assumes assert can be disabled;
-		   Since we can get there with any type, and it does not
-		   know that frame_in->dynamic_data_index can only be set
-		   for one of the types in the assert) it has to assume we
-		   can get here for any type. however this could lead to an
-		   out of bounds reference when indexing buf_type about 10
-		   lines below. In order to satisfy KW an additional if
-		   has been added. This one will always yield true.
+		/*
+		 * Klocwork assumes assert can be disabled;
+		 * Since we can get there with any type, and it does not
+		 * know that frame_in->dynamic_data_index can only be set
+		 * for one of the types in the assert) it has to assume we
+		 * can get here for any type. however this could lead to an
+		 * out of bounds reference when indexing buf_type about 10
+		 * lines below. In order to satisfy KW an additional if
+		 * has been added. This one will always yield true.
 		 */
 		if (queue_id < SH_CSS_MAX_NUM_QUEUES)
 			dest_buf->buf_src.queue_id = queue_id;
@@ -514,7 +510,8 @@ sh_css_copy_frame_to_spframe(struct ia_css_frame_sp *sp_frame_out,
 		    frame_in->planes.binary.data.offset;
 		break;
 	default:
-		/* This should not happen, but in case it does,
+		/*
+		 * This should not happen, but in case it does,
 		 * nullify the planes
 		 */
 		memset(&sp_frame_out->planes, 0, sizeof(sp_frame_out->planes));
@@ -949,9 +946,10 @@ sh_css_sp_init_stage(struct ia_css_binary *binary,
 	sh_css_sp_stage.isp_copy_output = (uint8_t)args->copy_output;
 	sh_css_sp_stage.enable.vf_output = (args->out_vf_frame != NULL);
 
-	/* Copy the frame infos first, to be overwritten by the frames,
-	   if these are present.
-	*/
+	/*
+	 * Copy the frame infos first, to be overwritten by the frames,
+	 * if these are present.
+	 */
 	sh_css_sp_stage.frames.effective_in_res.width = binary->effective_in_frame_res.width;
 	sh_css_sp_stage.frames.effective_in_res.height = binary->effective_in_frame_res.height;
 
@@ -1028,10 +1026,12 @@ sh_css_sp_init_stage(struct ia_css_binary *binary,
 
 	initialize_isp_states(binary);
 
-	/* we do this only for preview pipe because in fill_binary_info function
+	/*
+	 * We do this only for preview pipe because in fill_binary_info function
 	 * we assign vf_out res to out res, but for ISP internal processing, we need
 	 * the original out res. for video pipe, it has two output pins --- out and
-	 * vf_out, so it can keep these two resolutions already. */
+	 * vf_out, so it can keep these two resolutions already.
+	 */
 	if (binary->info->sp.pipeline.mode == IA_CSS_BINARY_MODE_PREVIEW &&
 	    (binary->vf_downscale_log2 > 0)) {
 		/* TODO: Remove this after preview output decimation is fixed
@@ -1067,20 +1067,22 @@ sp_init_stage(struct ia_css_pipeline_stage *stage,
 	 */
 	const char *binary_name = "";
 	const struct ia_css_binary_xinfo *info = NULL;
-	/* note: the var below is made static as it is quite large;
-	   if it is not static it ends up on the stack which could
-	   cause issues for drivers
-	*/
+	/*
+	 * Note: the var below is made static as it is quite large;
+	 * if it is not static it ends up on the stack which could
+	 * cause issues for drivers
+	 */
 	static struct ia_css_binary tmp_binary;
 	const struct ia_css_blob_info *blob_info = NULL;
 	struct ia_css_isp_param_css_segments isp_mem_if;
-	/* LA: should be ia_css_data, should not contain host pointer.
-	   However, CSS/DDR pointer is not available yet.
-	   Hack is to store it in params->ddr_ptrs and then copy it late in the SP just before vmem init.
-	   TODO: Call this after CSS/DDR allocation and store that pointer.
-	   Best is to allocate it at stage creation time together with host pointer.
-	   Remove vmem from params.
-	*/
+	/*
+	 * LA: should be ia_css_data, should not contain host pointer.
+	 * However, CSS/DDR pointer is not available yet.
+	 * Hack is to store it in params->ddr_ptrs and then copy it late in the SP just before vmem init.
+	 * TODO: Call this after CSS/DDR allocation and store that pointer.
+	 * Best is to allocate it at stage creation time together with host pointer.
+	 * Remove vmem from params.
+	 */
 	struct ia_css_isp_param_css_segments *mem_if = &isp_mem_if;
 
 	int err = 0;
@@ -1120,10 +1122,12 @@ sp_init_stage(struct ia_css_pipeline_stage *stage,
 	} else {
 		/* SP stage */
 		assert(stage->sp_func != IA_CSS_PIPELINE_NO_FUNC);
-		/* binary and blob_info are now NULL.
-		   These will be passed to sh_css_sp_init_stage
-		   and dereferenced there, so passing a NULL
-		   pointer is no good. return an error */
+		/*
+		 * binary and blob_info are now NULL.
+		 * These will be passed to sh_css_sp_init_stage
+		 * and dereferenced there, so passing a NULL
+		 * pointer is no good. return an error
+		 */
 		return -EINVAL;
 	}
 
@@ -1257,8 +1261,10 @@ sh_css_sp_init_pipeline(struct ia_css_pipeline *me,
 		SH_CSS_PIPE_CONFIG_SAMPLE_PARAMS << thread_id;
 	}
 
-	/* For continuous use-cases, SP copy is responsible for sampling the
-	 * parameters */
+	/*
+	 * For continuous use-cases, SP copy is responsible for sampling the
+	 * parameters
+	 */
 	if (continuous)
 		sh_css_sp_group.pipe[thread_id].pipe_config = 0;
 
@@ -1539,7 +1545,8 @@ ia_css_pipe_set_irq_mask(struct ia_css_pipe *pipe,
 	assert(pipe);
 
 	assert(IA_CSS_PIPE_ID_NUM == NR_OF_PIPELINES);
-	/* Linux kernel does not have UINT16_MAX
+	/*
+	 * Linux kernel does not have UINT16_MAX
 	 * Therefore decided to comment out these 2 asserts for Linux
 	 * Alternatives that were not chosen:
 	 * - add a conditional #define for UINT16_MAX
@@ -1638,7 +1645,8 @@ sh_css_sp_start_isp(void)
 			     (unsigned int)sp_address_of(sp_sw_state),
 			     (uint32_t)(IA_CSS_SP_SW_TERMINATED));
 
-	/* Note 1: The sp_start_isp function contains a wait till
+	/*
+	 * Note 1: The sp_start_isp function contains a wait till
 	 * the input network is configured by the SP.
 	 * Note 2: Not all SP binaries supports host2sp_commands.
 	 * In case a binary does support it, the host2sp_command
@@ -1648,7 +1656,8 @@ sh_css_sp_start_isp(void)
 	 * received, the SP starts configuring the input network.
 	 */
 
-	/* we need to set sp_running before we call ia_css_mmu_invalidate_cache
+	/*
+	 * We need to set sp_running before we call ia_css_mmu_invalidate_cache
 	 * as ia_css_mmu_invalidate_cache checks on sp_running to
 	 * avoid that it accesses dmem while the SP is not powered
 	 */
-- 
2.40.1



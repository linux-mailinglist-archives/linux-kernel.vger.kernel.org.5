Return-Path: <linux-kernel+bounces-109111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA12F8814C4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2144A1F2399A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1833F53E09;
	Wed, 20 Mar 2024 15:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TtjIDjCv"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10D24E1CA
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 15:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710949263; cv=none; b=Pq/M9KvVEaCszDZt1OcN7wM92HM76pKtnsugaiGb2+qhz9tJX4AuXNEGXCc9H4I4XDnQnBZuAbUj0iKfwIXX5hU3WzemJF46+bcGYgq3N2PUvfkAhF20Y43ltcW6ScSMzTrmG2QLLQmXVb0F2P2imc0paj3BUniid7HdUXZlv1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710949263; c=relaxed/simple;
	bh=G9HkBa+HliwPVMKEtRjblN6jlb0jymzVXvOgv1YlliA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nNogIU2HjhqL7IuKBtOgAY2BUUwXAQ5ShYapVR7C5Q3O9YAOBxvoa4R0SoRD+4Z4friHtf6g3OTs5OwMIYGI/+ZdtPAZ8FgEZc8+7sYJpEl86GTX8YJkc3CZr6dkUmwRDtmTlVw9C3/Iok8e9aUu/GMOTn468Dhm464BFKfm970=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TtjIDjCv; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33e672e10cfso3508215f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 08:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710949259; x=1711554059; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5T+34WGmkhqkNn4yXKT7TvpeTuM1677su3XUDtuFGVo=;
        b=TtjIDjCvE1FidItRA5UuCbe0IkISLdaI6dbm/tU2YwFwu4KIB+R2DaIhmpJrH/9jiC
         Z8YMwWuhcNHsRzcXwZGOjQEvXKmNzAcaKgbM3S5m8CQCkdPNjLZ+Hg6TzwBvXDHkx3Pr
         T/0KxD36TsSd4mGjR2H1g1gNA1uaeywb/SJWgBtrotY4WpKT9s/PphcP3wwM6yFk35YD
         1u6vyYCRoNB8xUIPNxjvj7gyUPpaeTHE1RTxwzQUiuHjMhHFESrFtFOlA7iO4/ZgZQih
         7ZkgiL0OyUAi86ZbQWrWXyhw4sVhOe/++tT25J/lRzoHVYX+1Q4iUuuzreApQs7DyFuG
         Z+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710949259; x=1711554059;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5T+34WGmkhqkNn4yXKT7TvpeTuM1677su3XUDtuFGVo=;
        b=X7pq77hpSbCyRtACEM5FH0KWNwQMbe4MKQRPGFdaQu22a56gea0oIfO1F9+ymYn3Jz
         CaTnj6L8ex0K4lqgajjJp7KST+gZO41nTT4ohMwvXmIuWHKni++djyunO3cgRGuZJHxg
         oUB3ChrNKzQ7/3gODXTcScY4r4mSXidHAtOF21nkfo3XQLW07CKaGMIANxDvV/FF23zI
         3CHjw/SmAia5MSn3Qcu0EPfMkPNwzef4kK0HIBU9PxcBbDR30Wi0eq3BjHCa0Z1w+E6N
         CJdNa126lzJaALOHWWQIr2TPleb5JWRNSkRRkZ+z41UMTeMo12eQnbc2E9LsVHFDR8uQ
         Ew+Q==
X-Gm-Message-State: AOJu0YxBOQtIa9k7LD5cXG6a8D2YWKMSSWG9OuIXGFkZkNh7kNRPdVAN
	tuXR8goW7j5GyBv3byCqqmMSlndZoPEUJ/9ft+OQ2fUkUqH2aqrTH/ve+a+llOU=
X-Google-Smtp-Source: AGHT+IEkDjx6U66pPRcpcL5yQJUOI6vm0zarax095+ktagB0g0S0AXsVhHD0lu8PX89ZzfE7jPHK0w==
X-Received: by 2002:adf:e6ca:0:b0:33e:c974:1296 with SMTP id y10-20020adfe6ca000000b0033ec9741296mr1928332wrm.25.1710949258917;
        Wed, 20 Mar 2024 08:40:58 -0700 (PDT)
Received: from [192.168.0.102] ([176.61.106.68])
        by smtp.gmail.com with ESMTPSA id i7-20020a5d5587000000b0033ec68dd3c3sm15015045wrv.96.2024.03.20.08.40.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 08:40:57 -0700 (PDT)
Message-ID: <b542f9a1-2053-4431-832e-5510e8d8220e@linaro.org>
Date: Wed, 20 Mar 2024 15:40:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] media: qcom: camss: Add CSID gen3 driver
Content-Language: en-US
To: Depeng Shao <quic_depengs@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, andersson@kernel.org, konrad.dybcio@linaro.org,
 mchehab@kernel.org, quic_yon@quicinc.com
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20240320141136.26827-1-quic_depengs@quicinc.com>
 <20240320141136.26827-6-quic_depengs@quicinc.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240320141136.26827-6-quic_depengs@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/03/2024 14:11, Depeng Shao wrote:
> The CSID in SM8550 is gen3, it has new register
> offset and new functionality, the buf done irq,
> register update and reset is moved to CSID gen3.
> 
> Signed-off-by: Depeng Shao <quic_depengs@quicinc.com>
> Co-developed-by: Yongsheng Li <quic_yon@quicinc.com>
> Signed-off-by: Yongsheng Li <quic_yon@quicinc.com>
> ---
>   drivers/media/platform/qcom/camss/Makefile    |   1 +
>   .../platform/qcom/camss/camss-csid-gen3.c     | 639 ++++++++++++++++++
>   .../platform/qcom/camss/camss-csid-gen3.h     |  26 +
>   .../media/platform/qcom/camss/camss-csid.h    |   1 +
>   4 files changed, 667 insertions(+)
>   create mode 100644 drivers/media/platform/qcom/camss/camss-csid-gen3.c
>   create mode 100644 drivers/media/platform/qcom/camss/camss-csid-gen3.h
> 
> diff --git a/drivers/media/platform/qcom/camss/Makefile b/drivers/media/platform/qcom/camss/Makefile
> index 28eba4bf3e38..c5fcd6eec0f2 100644
> --- a/drivers/media/platform/qcom/camss/Makefile
> +++ b/drivers/media/platform/qcom/camss/Makefile
> @@ -7,6 +7,7 @@ qcom-camss-objs += \
>   		camss-csid-4-1.o \
>   		camss-csid-4-7.o \
>   		camss-csid-gen2.o \
> +		camss-csid-gen3.o \
>   		camss-csiphy-2ph-1-0.o \
>   		camss-csiphy-3ph-1-0.o \
>   		camss-csiphy-2-1-2.o \
> diff --git a/drivers/media/platform/qcom/camss/camss-csid-gen3.c b/drivers/media/platform/qcom/camss/camss-csid-gen3.c
> new file mode 100644
> index 000000000000..b97005f7065d
> --- /dev/null
> +++ b/drivers/media/platform/qcom/camss/camss-csid-gen3.c
> @@ -0,0 +1,639 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * camss-csid-gen3.c
> + *
> + * Qualcomm MSM Camera Subsystem - CSID (CSI Decoder) Module
> + *
> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +#include <linux/completion.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/of.h>
> +#include <linux/delay.h>

Please alphanumerically sort your include list.

> +
> +
> +#include "camss-csid.h"
> +#include "camss-csid-gen3.h"
> +#include "camss.h"

and here.

> +
> +#define CSID_TOP_IO_PATH_CFG0(csid)	(0x4 * (csid))
> +#define		OUTPUT_IFE_EN 0x100
> +#define		INTERNAL_CSID 1
> +
> +#define CSID_HW_VERSION		0x0
> +#define		HW_VERSION_STEPPING	0
> +#define		HW_VERSION_REVISION	16
> +#define		HW_VERSION_GENERATION	28
> +
> +#define CSID_RST_CFG	0xC
> +#define		RST_MODE		0
> +#define		RST_LOCATION	4
> +
> +#define CSID_RST_CMD	0x10
> +#define		SELECT_HW_RST	0
> +#define		SELECT_SW_RST	1
> +#define		SELECT_IRQ_RST	2
> +
> +#define CSID_CSI2_RX_IRQ_STATUS	0x9C
> +#define CSID_CSI2_RX_IRQ_MASK	0xA0
> +#define CSID_CSI2_RX_IRQ_CLEAR	0xA4
> +#define CSID_CSI2_RX_IRQ_SET	0xA8
> +
> +#define CSID_CSI2_RDIN_IRQ_STATUS(rdi)		(0xEC + 0x10 * (rdi))
> +#define CSID_CSI2_RDIN_IRQ_MASK(rdi)		(0xF0 + 0x10 * (rdi))
> +#define		CSID_CSI2_RDIN_INFO_FIFO_FULL 2
> +#define		CSID_CSI2_RDIN_INFO_CAMIF_EOF 3
> +#define		CSID_CSI2_RDIN_INFO_CAMIF_SOF 4
> +#define		CSID_CSI2_RDIN_INFO_INPUT_EOF 9
> +#define		CSID_CSI2_RDIN_INFO_INPUT_SOF 12
> +#define		CSID_CSI2_RDIN_ERROR_REC_FRAME_DROP 18
> +#define		CSID_CSI2_RDIN_ERROR_REC_OVERFLOW_IRQ 19
> +#define		CSID_CSI2_RDIN_ERROR_REC_CCIF_VIOLATION 20
> +#define		CSID_CSI2_RDIN_EPOCH0 21
> +#define		CSID_CSI2_RDIN_EPOCH1 22
> +#define		CSID_CSI2_RDIN_RUP_DONE 23
> +#define		CSID_CSI2_RDIN_CCIF_VIOLATION 29
> +
> +#define CSID_CSI2_RDIN_IRQ_CLEAR(rdi)		(0xF4 + 0x10 * (rdi))
> +#define CSID_CSI2_RDIN_IRQ_SET(rdi)			(0xF8 + 0x10 * (rdi))
> +
> +#define CSID_TOP_IRQ_STATUS	0x7C
> +#define		TOP_IRQ_STATUS_RESET_DONE 0
> +#define CSID_TOP_IRQ_MASK	0x80
> +#define CSID_TOP_IRQ_CLEAR	0x84
> +#define CSID_TOP_IRQ_SET	0x88
> +#define CSID_IRQ_CMD		0x14
> +#define		IRQ_CMD_CLEAR	0
> +#define		IRQ_CMD_SET	4
> +
> +#define CSID_BUF_DONE_IRQ_STATUS	0x8C
> +#define		BUF_DONE_IRQ_STATUS_RDI_OFFSET (csid_is_lite(csid) ? 1 : 14)

Stick with hex please 0x01 : 0x0e

> +#define CSID_BUF_DONE_IRQ_MASK	0x90
> +#define CSID_BUF_DONE_IRQ_CLEAR	0x94
> +#define CSID_BUF_DONE_IRQ_SET	0x98
> +
> +#define CSID_CSI2_RX_CFG0	0x200
> +#define		CSI2_RX_CFG0_NUM_ACTIVE_LANES	0
> +#define		CSI2_RX_CFG0_DL0_INPUT_SEL	4
> +#define		CSI2_RX_CFG0_DL1_INPUT_SEL	8
> +#define		CSI2_RX_CFG0_DL2_INPUT_SEL	12
> +#define		CSI2_RX_CFG0_DL3_INPUT_SEL	16
> +#define		CSI2_RX_CFG0_PHY_NUM_SEL	20
> +#define			CSI2_RX_CFG0_PHY_SEL_BASE_IDX 1
> +#define		CSI2_RX_CFG0_PHY_TYPE_SEL	24
> +#define		CSI2_RX_CFG0_TPG_MUX_EN		27
> +#define		CSI2_RX_CFG0_TPG_NUM_SEL	28
> +
> +#define CSID_CSI2_RX_CFG1	0x204
> +#define		CSI2_RX_CFG1_PACKET_ECC_CORRECTION_EN		0
> +#define		CSI2_RX_CFG1_DE_SCRAMBLE_EN			1
> +#define		CSI2_RX_CFG1_VC_MODE				2
> +#define		CSI2_RX_CFG1_COMPLETE_STREAM_EN			4
> +#define		CSI2_RX_CFG1_COMPLETE_STREAM_FRAME_TIMING	5
> +#define		CSI2_RX_CFG1_MISR_EN				6
> +#define		CSI2_RX_CFG1_PHY_BIST_EN			7
> +#define		CSI2_RX_CFG1_EPD_MODE				8
> +#define		CSI2_RX_CFG1_EOTP_EN				9
> +#define		CSI2_RX_CFG1_DYN_SWITCH_EN			10
> +#define		CSI2_RX_CFG1_RUP_AUP_LATCH_DIS		11
> +
> +#define CSID_CSI2_RX_CAPTURE_CTRL	0x208
> +#define		CSI2_RX_CAPTURE_CTRL_LONG_PKT_CAPTURE_EN	0
> +#define		CSI2_RX_CAPTURE_CTRL_SHORT_PKT_CAPTURE_EN	1
> +#define		CSI2_RX_CAPTURE_CTRL_CPHY_PKT_CAPTURE_EN	3
> +#define		CSI2_RX_CAPTURE_CTRL_LONG_PKT_CAPTURE_DT		4
> +#define		CSI2_RX_CAPTURE_CTRL_LONG_PKT_CAPTURE_VC		10
> +#define		CSI2_RX_CAPTURE_CTRL_SHORT_PKT_CAPTURE_VC	15
> +#define		CSI2_RX_CAPTURE_CTRL_CPHY_PKT_CAPTURE_DT		20
> +#define		CSI2_RX_CAPTURE_CTRL_CPHY_PKT_CAPTURE_VC		26
> +
> +#define CSID_RDI_CFG0(rdi)			(0x500 + 0x100 * (rdi))
> +#define		RDI_CFG0_VFR_EN				0
> +#define		RDI_CFG0_FRAME_ID_DEC_EN	1
> +#define		RDI_CFG0_RETIME_DIS			5
> +#define		RDI_CFG0_TIMESTAMP_EN		6
> +#define		RDI_CFG0_TIMESTAMP_STB_SEL	8
> +#define		RDI_CFG0_DECODE_FORMAT		12
> +#define		RDI_CFG0_DT					16
> +#define		RDI_CFG0_VC					22
> +#define		RDI_CFG0_DT_ID				27
> +#define		RDI_CFG0_EN					31
> +
> +#define CSID_RDI_CFG1(rdi)			(0x510 + 0x100 * (rdi))
> +#define		RDI_CFG1_BYTE_CNTR_EN	2
> +#define		RDI_CFG1_DROP_H_EN	5
> +#define		RDI_CFG1_DROP_V_EN	6
> +#define		RDI_CFG1_CROP_H_EN	7
> +#define		RDI_CFG1_CROP_V_EN	8
> +#define		RDI_CFG1_MISR_EN	9
> +#define		RDI_CFG1_PIX_STORE  10
> +#define		RDI_CFG1_PLAIN_ALIGNMENT	11
> +#define		RDI_CFG1_PLAIN_FORMAT	12
> +#define		RDI_CFG1_EARLY_EOF_EN	14
> +#define		RDI_CFG1_PACKING_FORMAT	15
> +
> +#define CSID_RDI_CTRL(rdi)			(0x504 + 0x100 * (rdi))
> +#define		RDI_CTRL_START_CMD		0
> +#define		RDI_CTRL_START_MODE		2
> +
> +#define CSID_RDI_EPOCH_IRQ_CFG(rdi) (0x52C + 0x100 * (rdi))
> +
> +#define CSID_RDI_FRM_DROP_PATTERN(rdi)			(0x540 + 0x100 * (rdi))
> +#define CSID_RDI_FRM_DROP_PERIOD(rdi)			(0x544 + 0x100 * (rdi))
> +#define CSID_RDI_IRQ_SUBSAMPLE_PATTERN(rdi)		(0x548 + 0x100 * (rdi))
> +#define CSID_RDI_IRQ_SUBSAMPLE_PERIOD(rdi)		(0x54C + 0x100 * (rdi))
> +#define CSID_RDI_RPP_PIX_DROP_PATTERN(rdi)		(0x558 + 0x100 * (rdi))
> +#define CSID_RDI_RPP_PIX_DROP_PERIOD(rdi)		(0x55C + 0x100 * (rdi))
> +#define CSID_RDI_RPP_LINE_DROP_PATTERN(rdi)		(0x560 + 0x100 * (rdi))
> +#define CSID_RDI_RPP_LINE_DROP_PERIOD(rdi)		(0x564 + 0x100 * (rdi))
> +
> +#define CSID_RDI_RPP_HCROP(rdi)                 (0x550 + 0x100 * (rdi))
> +#define CSID_RDI_RPP_VCROP(rdi)                 (0x554 + 0x100 * (rdi))
> +
> +#define CSID_RDI_ERROR_RECOVERY_CFG0(rdi)       (0x514 + 0x100 * (rdi))
> +
> +#define CSID_DISCARD_FRAMES 4
> +
> +#define CSID_REG_UPDATE_CMD		0x18
> +static inline int reg_update_rdi(struct csid_device *csid, int n)
> +{
> +	return BIT(n + 4) + BIT(20 + n);
> +}
> +
> +#define	    REG_UPDATE_RDI		reg_update_rdi
> +
> +static const struct csid_format csid_formats[] = {
> +	{
> +		MEDIA_BUS_FMT_UYVY8_1X16,
> +		DATA_TYPE_YUV422_8BIT,
> +		DECODE_FORMAT_UNCOMPRESSED_8_BIT,
> +		8,
> +		2,
> +	},
> +	{
> +		MEDIA_BUS_FMT_VYUY8_1X16,
> +		DATA_TYPE_YUV422_8BIT,
> +		DECODE_FORMAT_UNCOMPRESSED_8_BIT,
> +		8,
> +		2,
> +	},
> +	{
> +		MEDIA_BUS_FMT_YUYV8_1X16,
> +		DATA_TYPE_YUV422_8BIT,
> +		DECODE_FORMAT_UNCOMPRESSED_8_BIT,
> +		8,
> +		2,
> +	},
> +	{
> +		MEDIA_BUS_FMT_YVYU8_1X16,
> +		DATA_TYPE_YUV422_8BIT,
> +		DECODE_FORMAT_UNCOMPRESSED_8_BIT,
> +		8,
> +		2,
> +	},
> +	{
> +		MEDIA_BUS_FMT_SBGGR8_1X8,
> +		DATA_TYPE_RAW_8BIT,
> +		DECODE_FORMAT_UNCOMPRESSED_8_BIT,
> +		8,
> +		1,
> +	},
> +	{
> +		MEDIA_BUS_FMT_SGBRG8_1X8,
> +		DATA_TYPE_RAW_8BIT,
> +		DECODE_FORMAT_UNCOMPRESSED_8_BIT,
> +		8,
> +		1,
> +	},
> +	{
> +		MEDIA_BUS_FMT_SGRBG8_1X8,
> +		DATA_TYPE_RAW_8BIT,
> +		DECODE_FORMAT_UNCOMPRESSED_8_BIT,
> +		8,
> +		1,
> +	},
> +	{
> +		MEDIA_BUS_FMT_SRGGB8_1X8,
> +		DATA_TYPE_RAW_8BIT,
> +		DECODE_FORMAT_UNCOMPRESSED_8_BIT,
> +		8,
> +		1,
> +	},
> +	{
> +		MEDIA_BUS_FMT_SBGGR10_1X10,
> +		DATA_TYPE_RAW_10BIT,
> +		DECODE_FORMAT_UNCOMPRESSED_10_BIT,
> +		10,
> +		1,
> +	},
> +	{
> +		MEDIA_BUS_FMT_SGBRG10_1X10,
> +		DATA_TYPE_RAW_10BIT,
> +		DECODE_FORMAT_UNCOMPRESSED_10_BIT,
> +		10,
> +		1,
> +	},
> +	{
> +		MEDIA_BUS_FMT_SGRBG10_1X10,
> +		DATA_TYPE_RAW_10BIT,
> +		DECODE_FORMAT_UNCOMPRESSED_10_BIT,
> +		10,
> +		1,
> +	},
> +	{
> +		MEDIA_BUS_FMT_SRGGB10_1X10,
> +		DATA_TYPE_RAW_10BIT,
> +		DECODE_FORMAT_UNCOMPRESSED_10_BIT,
> +		10,
> +		1,
> +	},
> +	{
> +		MEDIA_BUS_FMT_Y8_1X8,
> +		DATA_TYPE_RAW_8BIT,
> +		DECODE_FORMAT_UNCOMPRESSED_8_BIT,
> +		8,
> +		1,
> +	},
> +	{
> +		MEDIA_BUS_FMT_Y10_1X10,
> +		DATA_TYPE_RAW_10BIT,
> +		DECODE_FORMAT_UNCOMPRESSED_10_BIT,
> +		10,
> +		1,
> +	},
> +	{
> +		MEDIA_BUS_FMT_SBGGR12_1X12,
> +		DATA_TYPE_RAW_12BIT,
> +		DECODE_FORMAT_UNCOMPRESSED_12_BIT,
> +		12,
> +		1,
> +	},
> +	{
> +		MEDIA_BUS_FMT_SGBRG12_1X12,
> +		DATA_TYPE_RAW_12BIT,
> +		DECODE_FORMAT_UNCOMPRESSED_12_BIT,
> +		12,
> +		1,
> +	},
> +	{
> +		MEDIA_BUS_FMT_SGRBG12_1X12,
> +		DATA_TYPE_RAW_12BIT,
> +		DECODE_FORMAT_UNCOMPRESSED_12_BIT,
> +		12,
> +		1,
> +	},
> +	{
> +		MEDIA_BUS_FMT_SRGGB12_1X12,
> +		DATA_TYPE_RAW_12BIT,
> +		DECODE_FORMAT_UNCOMPRESSED_12_BIT,
> +		12,
> +		1,
> +	},
> +	{
> +		MEDIA_BUS_FMT_SBGGR14_1X14,
> +		DATA_TYPE_RAW_14BIT,
> +		DECODE_FORMAT_UNCOMPRESSED_14_BIT,
> +		14,
> +		1,
> +	},
> +	{
> +		MEDIA_BUS_FMT_SGBRG14_1X14,
> +		DATA_TYPE_RAW_14BIT,
> +		DECODE_FORMAT_UNCOMPRESSED_14_BIT,
> +		14,
> +		1,
> +	},
> +	{
> +		MEDIA_BUS_FMT_SGRBG14_1X14,
> +		DATA_TYPE_RAW_14BIT,
> +		DECODE_FORMAT_UNCOMPRESSED_14_BIT,
> +		14,
> +		1,
> +	},
> +	{
> +		MEDIA_BUS_FMT_SRGGB14_1X14,
> +		DATA_TYPE_RAW_14BIT,
> +		DECODE_FORMAT_UNCOMPRESSED_14_BIT,
> +		14,
> +		1,
> +	},
> +};
> +
> +static void __csid_configure_rx(struct csid_device *csid,
> +				struct csid_phy_config *phy, int vc)
> +{
> +	int val;
> +
> +	val = (phy->lane_cnt - 1) << CSI2_RX_CFG0_NUM_ACTIVE_LANES;
> +	val |= phy->lane_assign << CSI2_RX_CFG0_DL0_INPUT_SEL;
> +	val |= (phy->csiphy_id + CSI2_RX_CFG0_PHY_SEL_BASE_IDX) << CSI2_RX_CFG0_PHY_NUM_SEL;
> +
> +	writel_relaxed(val, csid->base + CSID_CSI2_RX_CFG0);
> +
> +	val = 1 << CSI2_RX_CFG1_PACKET_ECC_CORRECTION_EN;
> +	if (vc > 3)
> +		val |= 1 << CSI2_RX_CFG1_VC_MODE;
> +	writel_relaxed(val, csid->base + CSID_CSI2_RX_CFG1);
> +}
> +
> +static void __csid_ctrl_rdi(struct csid_device *csid, int enable, u8 rdi)
> +{
> +	int val;
> +
> +	if (enable)
> +		val = 1 << RDI_CTRL_START_CMD;
> +	else
> +		val = 0 << RDI_CTRL_START_CMD;
> +	writel_relaxed(val, csid->base + CSID_RDI_CTRL(rdi));
> +}
> +
> +static void __csid_configure_top(struct csid_device *csid)
> +{
> +	u32 val;
> +
> +	if (csid->top_base) {
> +		val = OUTPUT_IFE_EN | INTERNAL_CSID;
> +		writel_relaxed(val, csid->top_base + CSID_TOP_IO_PATH_CFG0(csid->id));
> +	}
> +}
> +
> +static void __csid_configure_rdi_stream(struct csid_device *csid, u8 enable, u8 vc)
> +{
> +	u32 val;
> +	u8 lane_cnt = csid->phy.lane_cnt;
> +	/* Source pads matching RDI channels on hardware. Pad 1 -> RDI0, Pad 2 -> RDI1, etc. */
> +	struct v4l2_mbus_framefmt *input_format = &csid->fmt[MSM_CSID_PAD_FIRST_SRC + vc];
> +	const struct csid_format *format = csid_get_fmt_entry(csid->formats, csid->nformats,
> +							      input_format->code);
> +
> +	if (!lane_cnt)
> +		lane_cnt = 4;
> +
> +	val = 0;
> +	writel_relaxed(val, csid->base + CSID_RDI_FRM_DROP_PERIOD(vc));
> +
> +	/*
> +	 * DT_ID is a two bit bitfield that is concatenated with
> +	 * the four least significant bits of the five bit VC
> +	 * bitfield to generate an internal CID value.
> +	 *
> +	 * CSID_RDI_CFG0(vc)
> +	 * DT_ID : 28:27
> +	 * VC    : 26:22
> +	 * DT    : 21:16
> +	 *
> +	 * CID   : VC 3:0 << 2 | DT_ID 1:0
> +	 */
> +	u8 dt_id = vc & 0x03;
> +
> +	val = 1 << RDI_CFG0_TIMESTAMP_EN;
> +	val |= 2 << RDI_CFG0_TIMESTAMP_STB_SEL;
> +	/* note: for non-RDI path, this should be format->decode_format */
> +	val |= DECODE_FORMAT_PAYLOAD_ONLY << RDI_CFG0_DECODE_FORMAT;
> +	val |= vc << RDI_CFG0_VC;
> +	val |= format->data_type << RDI_CFG0_DT;
> +	val |= dt_id << RDI_CFG0_DT_ID;
> +
> +	writel_relaxed(val, csid->base + CSID_RDI_CFG0(vc));
> +
> +	val = 1 << RDI_CFG1_PACKING_FORMAT;
> +	val |= 1 << RDI_CFG1_PIX_STORE;
> +	val |= 1 << RDI_CFG1_DROP_H_EN;
> +	val |= 1 << RDI_CFG1_DROP_V_EN;
> +	val |= 1 << RDI_CFG1_CROP_H_EN;
> +	val |= 1 << RDI_CFG1_CROP_V_EN;
> +	val |= RDI_CFG1_EARLY_EOF_EN;
> +
> +	writel_relaxed(val, csid->base + CSID_RDI_CFG1(vc));
> +
> +	val = 0;
> +	writel_relaxed(val, csid->base + CSID_RDI_IRQ_SUBSAMPLE_PERIOD(vc));
> +
> +	val = 1;
> +	writel_relaxed(val, csid->base + CSID_RDI_IRQ_SUBSAMPLE_PATTERN(vc));
> +
> +	val = 0;
> +	writel_relaxed(val, csid->base + CSID_RDI_CTRL(vc));
> +
> +	val = readl_relaxed(csid->base + CSID_RDI_CFG0(vc));
> +	val |=  enable << RDI_CFG0_EN;
> +	writel_relaxed(val, csid->base + CSID_RDI_CFG0(vc));
> +}

Hmm.

So I think 90% of the code here can be moved into a shared file - 
ideally instantiated in gen2.c and then reused here rather than 
copy/paste from one file to the other.

Lets sync up and try to get a unified tree for x1e80100 and sm8550 for 
that purpose.

I think the code you have here is slightly further along that the 
CSID/VFE stuff I've been working with.

But still - reductio ad absurdum - we need to functionally decompose and 
not replicate code.

> +
> +static void csid_configure_stream(struct csid_device *csid, u8 enable)
> +{
> +	u8 i;
> +
> +	/* Loop through all enabled VCs and configure stream for each */
> +	for (i = 0; i < MSM_CSID_MAX_SRC_STREAMS; i++)
> +		if (csid->phy.en_vc & BIT(i)) {
> +			__csid_configure_top(csid);
> +			__csid_configure_rdi_stream(csid, enable, i);
> +			__csid_configure_rx(csid, &csid->phy, i);
> +			__csid_ctrl_rdi(csid, enable, i);
> +		}
> +}

Another example, straight copy/paste - we need to zap all of that.

---
bod


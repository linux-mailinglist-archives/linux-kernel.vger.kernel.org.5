Return-Path: <linux-kernel+bounces-117054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2206688A67A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7AB72E0B0E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E9813DDA7;
	Mon, 25 Mar 2024 12:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="J5NMpycD"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F4713D281;
	Mon, 25 Mar 2024 12:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711370890; cv=none; b=LwTDEMklwNdgNy9u/yQUFcHzOcnTK6MXsXNAps0nnN0oMTc23+4Plx4rStsuco1iLtL5wyHVqtJmkmlyekFKTJW0yXEru/YeSCtWgsASZ6LLTm+GIknV85O5OU0ktWbYV6kohEXZVP7fAvGC8V6bP+QYNQO79Ho8/PE1gZpD9RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711370890; c=relaxed/simple;
	bh=xCF89IzgCfase9w08KvmIPjBZbPowPcMC/5/LSRgbfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tMMMTn4XOBrzyNgGyTZ0PHMckbEyZOy50eXbHRPIzxxuRZgyWhC4l6WsVIA6M7qn0dD6tfM0xzdS1CBi1/zLsGklwGsOPJsz2RqgQH5rJPe5x8FFSxgZnpZAiRKameQvWwDwMqsQY6SBLOL4+9rYKwcxAK/iRYEKBw5MxZUwSHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=J5NMpycD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42PCFHnd016146;
	Mon, 25 Mar 2024 12:47:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=P+A5D6ZIK9N+YmjD/+ubNRl6uzdRJddFT2FKjtxVsbc=; b=J5
	NMpycDEGSUzs7Blo4INg2GMZHOYS2MlrPSlYsKogyIZ5hHObH2Az6auGHUjULLlJ
	eXDrbniZkISnsU6t6xS/VYRUNxwFsrV4ojPPxR6Rz3/VX4+p+4fOiuoDeZxaAHEk
	rbduE9dwc+5t+RdtYFBaxbD+xjqzVC4edG8sMSuSG5DayCHM43pGqW4Zi/76u7T2
	icJWAFLLIWtb0L+jdu69Ypcd3JYhoJBIZi58YvjuSswl1QmRkUaRtxHulA1ku+F2
	zl2El08BzSFgwvD/Se1VUJqkxJIIQNqCevYNHCr122qXVdnUmVHAGPdNGlgKYLnC
	nZnc98uC/nSXS9X4xcYQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x392mr201-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 12:47:37 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42PClao0014660
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 12:47:36 GMT
Received: from [10.239.96.73] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 25 Mar
 2024 05:47:34 -0700
Message-ID: <9497a747-824a-438f-b9a4-d04b2f82f0e3@quicinc.com>
Date: Mon, 25 Mar 2024 20:47:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] media: qcom: camss: Add new VFE driver for SM8550
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, <rfoss@kernel.org>,
        <todor.too@gmail.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mchehab@kernel.org>,
        <quic_yon@quicinc.com>
CC: <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20240320141136.26827-1-quic_depengs@quicinc.com>
 <20240320141136.26827-7-quic_depengs@quicinc.com>
 <f92ddb35-55b3-4d49-8554-20b30257f1b5@linaro.org>
Content-Language: en-US
From: Depeng Shao <quic_depengs@quicinc.com>
In-Reply-To: <f92ddb35-55b3-4d49-8554-20b30257f1b5@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kIUQnWdEYPsEk5LNibSEhiVdAMK79eV6
X-Proofpoint-GUID: kIUQnWdEYPsEk5LNibSEhiVdAMK79eV6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_08,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403250070

Hi Bryan,

On 3/20/2024 11:57 PM, Bryan O'Donoghue wrote:
> On 20/03/2024 14:11, Depeng Shao wrote:
>> From: Yongsheng Li <quic_yon@quicinc.com>
>>
>> Add IFE driver for SM8550, the main difference with
>> old HW is register offset is different, register
>> update, reset and buf done is moved to CSID. And
>> the image address support 36 bits, so need to right
>> shift the image address when configuring the write
>> master.
>>
>> Signed-off-by: Yongsheng Li <quic_yon@quicinc.com>
>> Co-developed-by: Depeng Shao <quic_depengs@quicinc.com>
>> Signed-off-by: Depeng Shao <quic_depengs@quicinc.com>
> 
> Same comment with your co-developed and SOB
> 
>> ---
>>   drivers/media/platform/qcom/camss/Makefile    |   1 +
>>   .../media/platform/qcom/camss/camss-vfe-780.c | 455 ++++++++++++++++++
>>   drivers/media/platform/qcom/camss/camss-vfe.h |   1 +
>>   3 files changed, 457 insertions(+)
>>   create mode 100644 drivers/media/platform/qcom/camss/camss-vfe-780.c
>>
>> diff --git a/drivers/media/platform/qcom/camss/Makefile 
>> b/drivers/media/platform/qcom/camss/Makefile
>> index c5fcd6eec0f2..ac40bbab18a3 100644
>> --- a/drivers/media/platform/qcom/camss/Makefile
>> +++ b/drivers/media/platform/qcom/camss/Makefile
>> @@ -18,6 +18,7 @@ qcom-camss-objs += \
>>           camss-vfe-4-8.o \
>>           camss-vfe-17x.o \
>>           camss-vfe-480.o \
>> +        camss-vfe-780.o \
>>           camss-vfe-gen1.o \
>>           camss-vfe.o \
>>           camss-video.o \
>> diff --git a/drivers/media/platform/qcom/camss/camss-vfe-780.c 
>> b/drivers/media/platform/qcom/camss/camss-vfe-780.c
>> new file mode 100644
>> index 000000000000..a78647f23c8c
>> --- /dev/null
>> +++ b/drivers/media/platform/qcom/camss/camss-vfe-780.c
>> @@ -0,0 +1,455 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * camss-vfe-780.c
>> + *
>> + * Qualcomm MSM Camera Subsystem - VFE (Video Front End) Module v780 
>> (SM8550)
>> + *
>> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights 
>> reserved.
>> + */
>> +
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/iopoll.h>
>> +
>> +#include "camss.h"
>> +#include "camss-vfe.h"
>> +
>> +#define VFE_HW_VERSION            (vfe_is_lite(vfe) ? 0x1000 : 0x0)
>> +
>> +#define VFE_IRQ_CMD            (vfe_is_lite(vfe) ? 0x1038 : 0x30)
>> +#define     IRQ_CMD_GLOBAL_CLEAR    BIT(0)
>> +
>> +#define VFE_IRQ_MASK(n)            ((vfe_is_lite(vfe) ? 0x1024 : 
>> 0x34) + (n) * 4)
>> +#define        IRQ_MASK_0_BUS_TOP_IRQ    (vfe_is_lite(vfe) ? BIT(0) | 
>> BIT(1) | BIT(2) : \
>> +                        BIT(0) | BIT(4) | BIT(18))
>> +#define        IRQ_MASK_1_BUS_TOP_IRQ(n)    (vfe_is_lite(vfe) ? BIT(2 
>> * n + 2) | BIT(2 * n + 3) : \
>> +                        BIT(2 * n + 8) | BIT(2 * n + 9))
>> +#define VFE_IRQ_CLEAR(n)        ((vfe_is_lite(vfe) ? 0x102C : 0x3C) + 
>> (n) * 4)
>> +#define VFE_IRQ_STATUS(n)        ((vfe_is_lite(vfe) ? 0x101C : 0x44) 
>> + (n) * 4)
>> +
>> +#define BUS_REG_BASE            (vfe_is_lite(vfe) ? 0x1200 : 0xC00)
>> +
>> +#define VFE_BUS_WM_CGC_OVERRIDE        (BUS_REG_BASE + 0x08)
>> +#define        WM_CGC_OVERRIDE_ALL    (0x7FFFFFF)
>> +
>> +#define VFE_BUS_WM_TEST_BUS_CTRL    (BUS_REG_BASE + 0xdc)
>> +
>> +#define VFE_BUS_WM_CFG(n)        (BUS_REG_BASE + 0x200 + (n) * 0x100)
>> +#define        WM_CFG_EN            (0)
>> +#define        WM_VIR_FRM_EN        (1)
>> +#define        WM_CFG_MODE            (16)
>> +#define            MODE_QCOM_PLAIN    (0)
>> +#define            MODE_MIPI_RAW    (1)
>> +#define VFE_BUS_WM_IMAGE_ADDR(n)    (BUS_REG_BASE + 0x204 + (n) * 0x100)
>> +#define VFE_BUS_WM_FRAME_INCR(n)    (BUS_REG_BASE + 0x208 + (n) * 0x100)
>> +#define VFE_BUS_WM_IMAGE_CFG_0(n)    (BUS_REG_BASE + 0x20c + (n) * 
>> 0x100)
>> +#define                WM_IMAGE_CFG_0_DEFAULT_WIDTH    (0xFFFF)
>> +#define VFE_BUS_WM_IMAGE_CFG_1(n)    (BUS_REG_BASE + 0x210 + (n) * 
>> 0x100)
>> +#define VFE_BUS_WM_IMAGE_CFG_2(n)    (BUS_REG_BASE + 0x214 + (n) * 
>> 0x100)
>> +#define                WM_IMAGE_CFG_2_DEFAULT_STRIDE    (0xFFFF)
>> +#define VFE_BUS_WM_PACKER_CFG(n)    (BUS_REG_BASE + 0x218 + (n) * 0x100)
>> +#define VFE_BUS_WM_HEADER_ADDR(n)    (BUS_REG_BASE + 0x220 + (n) * 
>> 0x100)
>> +#define VFE_BUS_WM_HEADER_INCR(n)    (BUS_REG_BASE + 0x224 + (n) * 
>> 0x100)
>> +#define VFE_BUS_WM_HEADER_CFG(n)    (BUS_REG_BASE + 0x228 + (n) * 0x100)
>> +
>> +#define VFE_BUS_WM_IRQ_SUBSAMPLE_PERIOD(n)    (BUS_REG_BASE + 0x230 + 
>> (n) * 0x100)
>> +#define VFE_BUS_WM_IRQ_SUBSAMPLE_PATTERN(n)    (BUS_REG_BASE + 0x234 
>> + (n) * 0x100)
>> +#define VFE_BUS_WM_FRAMEDROP_PERIOD(n)        (BUS_REG_BASE + 0x238 + 
>> (n) * 0x100)
>> +#define VFE_BUS_WM_FRAMEDROP_PATTERN(n)        (BUS_REG_BASE + 0x23c 
>> + (n) * 0x100)
>> +
>> +#define VFE_BUS_WM_MMU_PREFETCH_CFG(n)    (BUS_REG_BASE + 0x260 + (n) 
>> * 0x100)
>> +#define VFE_BUS_WM_MMU_PREFETCH_MAX_OFFSET(n)    (BUS_REG_BASE + 
>> 0x264 + (n) * 0x100)
>> +#define VFE_BUS_WM_SYSTEM_CACHE_CFG(n)    (BUS_REG_BASE + 0x268 + (n) 
>> * 0x100)
>> +
>> +
>> +/* for titan 780, each bus client is hardcoded to a specific path */
>> +#define RDI_WM(n)            ((vfe_is_lite(vfe) ? 0 : 23) + (n))
> 
> No admixture of hex and decimal please.
> 
>> +
>> +#define MAX_VFE_OUTPUT_LINES    4
>> +#define MAX_VFE_ACT_BUF    1
>> +
>> +static u32 vfe_hw_version(struct vfe_device *vfe)
>> +{
>> +    u32 hw_version = readl_relaxed(vfe->base + VFE_HW_VERSION);
>> +
>> +    u32 gen = (hw_version >> 28) & 0xF;
>> +    u32 rev = (hw_version >> 16) & 0xFFF;
>> +    u32 step = hw_version & 0xFFFF;
>> +
>> +    dev_info(vfe->camss->dev, "VFE HW Version = %u.%u.%u\n", gen, 
>> rev, step);
>> +
>> +    return hw_version;
>> +}
> 
> Same comment as with CSID, its time to rationalise all of this 
> replicated code down to one place, instead of proliferating it further.
> 

I understand, but the original driver and current driver are using macro 
definition to define the register offset, then we aren't able to add the 
common code to one place.

We need to refactor the code to not use macro definition for the 
register offset first, then we can reuse the common code.

>> +static void vfe_global_reset(struct vfe_device *vfe)
>> +{
>> +}
>> +
>> +static void vfe_wm_start(struct vfe_device *vfe, u8 wm, struct 
>> vfe_line *line)
>> +{
>> +    struct v4l2_pix_format_mplane *pix =
>> +        &line->video_out.active_fmt.fmt.pix_mp;
>> +
>> +    wm = RDI_WM(wm); /* map to actual WM used (from wm=RDI index) */
>> +
>> +    /* no clock gating at bus input */
>> +    writel_relaxed(0, vfe->base + VFE_BUS_WM_CGC_OVERRIDE);
>> +
>> +    writel_relaxed(0x0, vfe->base + VFE_BUS_WM_TEST_BUS_CTRL);
>> +
>> +    writel_relaxed(ALIGN(pix->plane_fmt[0].bytesperline, 16) * 
>> pix->height >> 8,
>> +               vfe->base + VFE_BUS_WM_FRAME_INCR(wm));
>> +    writel_relaxed((WM_IMAGE_CFG_0_DEFAULT_WIDTH & 0xFFFF),
>> +               vfe->base + VFE_BUS_WM_IMAGE_CFG_0(wm));
>> +    writel_relaxed(WM_IMAGE_CFG_2_DEFAULT_STRIDE,
>> +               vfe->base + VFE_BUS_WM_IMAGE_CFG_2(wm));
>> +    writel_relaxed(0, vfe->base + VFE_BUS_WM_PACKER_CFG(wm));
>> +
>> +    /* no dropped frames, one irq per frame */
>> +    writel_relaxed(0, vfe->base + VFE_BUS_WM_FRAMEDROP_PERIOD(wm));
>> +    writel_relaxed(1, vfe->base + VFE_BUS_WM_FRAMEDROP_PATTERN(wm));
>> +    writel_relaxed(0, vfe->base + VFE_BUS_WM_IRQ_SUBSAMPLE_PERIOD(wm));
>> +    writel_relaxed(1, vfe->base + VFE_BUS_WM_IRQ_SUBSAMPLE_PATTERN(wm));
>> +
>> +    writel_relaxed(1, vfe->base + VFE_BUS_WM_MMU_PREFETCH_CFG(wm));
>> +    writel_relaxed(0xFFFFFFFF, vfe->base + 
>> VFE_BUS_WM_MMU_PREFETCH_MAX_OFFSET(wm));
>> +
>> +    writel_relaxed(1 << WM_CFG_EN | MODE_MIPI_RAW << WM_CFG_MODE,
>> +               vfe->base + VFE_BUS_WM_CFG(wm));
>> +}
>> +
>> +static void vfe_wm_stop(struct vfe_device *vfe, u8 wm)
>> +{
>> +    wm = RDI_WM(wm); /* map to actual WM used (from wm=RDI index) */
>> +    writel_relaxed(0, vfe->base + VFE_BUS_WM_CFG(wm));
>> +}
> 
> vfe_wm_stop() as an example can/should live in a shared file.
> 
> As proof of concept code its fine to copy/paste between files but, to 
> merge we need to get rid of any replicated code - introducing 
> indirection/offsets as necessary.
> 

Same with above, we'd better to refactor the code to not use macro 
definition for the register offset first.

>> +static void vfe_wm_update(struct vfe_device *vfe, u8 wm, u64 addr,
>> +              struct vfe_line *line)
>> +{
>> +    wm = RDI_WM(wm); /* map to actual WM used (from wm=RDI index) */
>> +    writel_relaxed((addr >> 8) & 0xFFFFFFFF, vfe->base + 
>> VFE_BUS_WM_IMAGE_ADDR(wm));
>> +
>> +    dev_dbg(vfe->camss->dev, "wm:%d, image buf addr:0x%llx\n",
>> +        wm, addr);
>> +}
>> +
>> +static void vfe_reg_update(struct vfe_device *vfe, enum vfe_line_id 
>> line_id)
>> +{
>> +    int port_id = line_id;
>> +
>> +    v4l2_subdev_notify(&vfe->line[line_id].subdev, NOTIFY_RUP, (void 
>> *)&port_id);
>> +}
>> +
>> +static inline void vfe_reg_update_clear(struct vfe_device *vfe,
>> +                    enum vfe_line_id line_id)
>> +{
>> +    int port_id = line_id;
>> +
>> +    v4l2_subdev_notify(&vfe->line[line_id].subdev, NOTIFY_RUP_CLEAR, 
>> (void *)&port_id);
>> +}
> 
> I'm not sure I quite understand why we need to use this API to clear 
> registers inside of the address space of the same driver.
> 
> Is there not a much more direct way to write our _internal_ registers ?
> 

Since the register update(RUP) is moved to CSID, so it isn't _internal_ 
registers in this hardware.

> 
>> +static void vfe_enable_irq_common(struct vfe_device *vfe, enum 
>> vfe_line_id line_id)
>> +{
>> +    int port_id = line_id;
>> +
>> +    /* enable top BUS status IRQ */
>> +    writel_relaxed(IRQ_MASK_0_BUS_TOP_IRQ,
>> +                vfe->base + VFE_IRQ_MASK(0));
>> +
>> +    writel_relaxed(IRQ_MASK_1_BUS_TOP_IRQ(port_id),
>> +                vfe->base + VFE_IRQ_MASK(1));
>> +}
>> +
>> +/*
>> + * vfe_isr - VFE module interrupt handler
>> + * @irq: Interrupt line
>> + * @dev: VFE device
>> + *
>> + * Return IRQ_HANDLED on success
>> + */
>> +static irqreturn_t vfe_isr(int irq, void *dev)
>> +{
>> +    struct vfe_device *vfe = dev;
>> +    u32 status;
>> +
>> +    status = readl_relaxed(vfe->base + VFE_IRQ_STATUS(0));
>> +    writel_relaxed(status, vfe->base + VFE_IRQ_CLEAR(0));
>> +    writel_relaxed(IRQ_CMD_GLOBAL_CLEAR, vfe->base + VFE_IRQ_CMD);
>> +
>> +    if (status)
>> +        dev_dbg(vfe->camss->dev, "Top Status_0:0x%x\n", status);
>> +
>> +    status = readl_relaxed(vfe->base + VFE_IRQ_STATUS(1));
>> +    writel_relaxed(status, vfe->base + VFE_IRQ_CLEAR(1));
>> +    writel_relaxed(IRQ_CMD_GLOBAL_CLEAR, vfe->base + VFE_IRQ_CMD);
>> +
>> +    if (status)
>> +        dev_dbg(vfe->camss->dev, "Top Status_1:0x%x\n", status);
>> +
>> +    return IRQ_HANDLED;
>> +}
> 
> Why is this ISR required ? What does it do ?
> 
> Does it actually run on your reference hardware ?
> 
> If the purpose of the ISR is just to clear the status registers, why 
> even enable it ?
> 

Yeah, we can remove it, it was added for some debug info and verify the 
hardware, but it doesn't affect the control in this hardware, so we can 
remove it.

>> +
>> +/*
>> + * vfe_halt - Trigger halt on VFE module and wait to complete
>> + * @vfe: VFE device
>> + *
>> + * Return 0 on success or a negative error code otherwise
>> + */
>> +static int vfe_halt(struct vfe_device *vfe)
>> +{
>> +    /* rely on vfe_disable_output() to stop the VFE */
>> +    return 0;
>> +}
>> +
>> +static int vfe_get_output(struct vfe_line *line)
>> +{
>> +    struct vfe_device *vfe = to_vfe(line);
>> +    struct vfe_output *output;
>> +    unsigned long flags;
>> +
>> +    spin_lock_irqsave(&vfe->output_lock, flags);
>> +
>> +    output = &line->output;
>> +    if (output->state > VFE_OUTPUT_RESERVED) {
>> +        dev_err(vfe->camss->dev, "Output is running\n");
>> +        goto error;
>> +    }
>> +
>> +    output->wm_num = 1;
>> +
>> +    /* Correspondence between VFE line number and WM number.
>> +     * line 0 -> RDI 0, line 1 -> RDI1, line 2 -> RDI2, line 3 -> 
>> PIX/RDI3
>> +     * Note this 1:1 mapping will not work for PIX streams.
>> +     */
>> +    output->wm_idx[0] = line->id;
>> +    vfe->wm_output_map[line->id] = line->id;
>> +
>> +    output->drop_update_idx = 0;
>> +
>> +    spin_unlock_irqrestore(&vfe->output_lock, flags);
>> +
>> +    return 0;
>> +
>> +error:
>> +    spin_unlock_irqrestore(&vfe->output_lock, flags);
>> +    output->state = VFE_OUTPUT_OFF;
>> +
>> +    return -EINVAL;
>> +}
>> +
>> +static int vfe_enable_output(struct vfe_line *line)
>> +{
>> +    struct vfe_device *vfe = to_vfe(line);
>> +    struct vfe_output *output = &line->output;
>> +    unsigned long flags;
>> +    unsigned int i;
>> +
>> +    spin_lock_irqsave(&vfe->output_lock, flags);
>> +
>> +    vfe_reg_update_clear(vfe, line->id);
>> +
>> +    if (output->state > VFE_OUTPUT_RESERVED) {
>> +        dev_err(vfe->camss->dev, "Output is not in reserved state %d\n",
>> +            output->state);
>> +        spin_unlock_irqrestore(&vfe->output_lock, flags);
>> +        return -EINVAL;
>> +    }
>> +
>> +    WARN_ON(output->gen2.active_num);
>> +
>> +    output->state = VFE_OUTPUT_ON;
>> +
>> +    output->sequence = 0;
>> +
>> +    vfe_wm_start(vfe, output->wm_idx[0], line);
>> +
>> +    for (i = 0; i < MAX_VFE_ACT_BUF; i++) {
>> +        output->buf[i] = vfe_buf_get_pending(output);
>> +        if (!output->buf[i])
>> +            break;
>> +        output->gen2.active_num++;
>> +        vfe_wm_update(vfe, output->wm_idx[0], 
>> output->buf[i]->addr[0], line);
>> +
>> +        vfe_reg_update(vfe, line->id);
>> +    }
>> +
>> +    spin_unlock_irqrestore(&vfe->output_lock, flags);
>> +
>> +    return 0;
>> +}
> 
> So you'll see with the WIP code for x1e80100 which is I think the same 
> VFE - no one generation less 680 - that this code is copy/pasted.
> 
> But there's again no good reason for that. Common code needs to be 
> squashed down into one place.
> 

Agree, this part can be moved to camss-vfe.c, since they don't have 
register configuration, just some common code.

> ---
> bod

Thanks,
Depeng


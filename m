Return-Path: <linux-kernel+bounces-73003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA73585BBE7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2242F1F21AC7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4183692E2;
	Tue, 20 Feb 2024 12:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dYHiVoau"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7225B1F8;
	Tue, 20 Feb 2024 12:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708431746; cv=none; b=RvZSDgJI9DgBTqjwiUWuQx8c8SyXVGDQ2ezJks27u4lV9bwgsVKEL+aSSzv5XpldNlPUJLs/C7BR/EYCqIlePVzomQ+/+PcfeXXBShP14cXV2qh3al+lqUtZ342m+v9RRF7+xB67ZQ17fDAZPcgZK2XspQM7ASKy3lSr3PZ89eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708431746; c=relaxed/simple;
	bh=InDHKtmK2AtUmds74XuVyGWa4Kq1lt972r024xFyyPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HCoSik0xeeDqnAGTmgaYjELAEUKEGLkwgwJsyypgvahmQ3UJMe4amgH8+ba+WEhlcXOnHoEs8suCygaH+KECX8Cic3/dDb+sqvjkFiSTyb4FDRmM0T9gMDM4quq2QpvIsgy89CTFP7j1bnVATbYQOYUCGdjmnwW4e9r6H5fxK80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dYHiVoau; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41KBe1qL030653;
	Tue, 20 Feb 2024 12:21:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=379Srn1tGEaDvceo1XrilJx6GCtEIxn4M0Q0q4VP4Mw=; b=dY
	HiVoauIcBhnBW8SellHUd6j95dWA+0KfkP2GeUTalqAGLbljfeFRBZQPfbdJAytO
	NFVBDM4Tsd7V2AzsMwpYsVptWiSJQCOt2ZM36hbiils+6/agZ2mwLh293R37M4bp
	DmDJUdXDZNpTSaYGpsk8vLgkZ4nbmb0cqKJKjCcmCqUnVuUh4QfuYAurDH9TFo8Y
	wXt/2fcSJ3ecnlpSxcRlzkX973QMMFQLN0ziCvdWrHMDiAxSXA3T2Lr2BFA4Glma
	cDwkz8XN5Zw+qNIJU9n0rM+wurK4M2epzmX5OOF2efb81VLdsA/Vc90dPJe1Rb1u
	qqYs0lc7Q2MDLWPOA5Aw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wct3eg7yk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 12:21:22 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41KCLLmR029113
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 12:21:21 GMT
Received: from [10.216.16.129] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 20 Feb
 2024 04:21:15 -0800
Message-ID: <439c89ec-3702-4b4a-5e02-b18cc99b8ba3@quicinc.com>
Date: Tue, 20 Feb 2024 17:51:11 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 2/5] drivers: mtd: nand: Add qpic_common API file
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, <andersson@kernel.org>,
        <broonie@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <manivannan.sadhasivam@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
References: <20240215134856.1313239-1-quic_mdalam@quicinc.com>
 <20240215134856.1313239-3-quic_mdalam@quicinc.com>
 <4cb0144c-303b-4b91-bf88-0a7d7412afe1@linaro.org>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <4cb0144c-303b-4b91-bf88-0a7d7412afe1@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5UIVdpcamgOu-7yVNLkwt275vMMlNqui
X-Proofpoint-GUID: 5UIVdpcamgOu-7yVNLkwt275vMMlNqui
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 spamscore=0 phishscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402200088



On 2/15/2024 11:25 PM, Konrad Dybcio wrote:
> On 15.02.2024 14:48, Md Sadre Alam wrote:
>> Add qpic_common.c file which hold all the common
>> qpic APIs which will be used by both qpic raw nand
>> driver and qpic spi nand driver.
>>
>> Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> Co-developed-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>> ---
> 
> IIUC this is mostly moving code around?
> 
> I do however have some suggestions..
Ok
> 
>>   drivers/mtd/nand/Makefile            |    1 +
>>   drivers/mtd/nand/qpic_common.c       |  786 +++++++++++++++++
>>   drivers/mtd/nand/raw/qcom_nandc.c    | 1226 +-------------------------
>>   include/linux/mtd/nand-qpic-common.h |  488 ++++++++++
>>   4 files changed, 1291 insertions(+), 1210 deletions(-)
>>   create mode 100644 drivers/mtd/nand/qpic_common.c
>>   create mode 100644 include/linux/mtd/nand-qpic-common.h
>>
>> diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
>> index 19e1291ac4d5..131707a41293 100644
>> --- a/drivers/mtd/nand/Makefile
>> +++ b/drivers/mtd/nand/Makefile
>> @@ -12,3 +12,4 @@ nandcore-$(CONFIG_MTD_NAND_ECC) += ecc.o
>>   nandcore-$(CONFIG_MTD_NAND_ECC_SW_HAMMING) += ecc-sw-hamming.o
>>   nandcore-$(CONFIG_MTD_NAND_ECC_SW_BCH) += ecc-sw-bch.o
>>   nandcore-$(CONFIG_MTD_NAND_ECC_MXIC) += ecc-mxic.o
>> +obj-y += qpic_common.o
>> diff --git a/drivers/mtd/nand/qpic_common.c b/drivers/mtd/nand/qpic_common.c
>> new file mode 100644
>> index 000000000000..4d74ba888028
>> --- /dev/null
>> +++ b/drivers/mtd/nand/qpic_common.c
>> @@ -0,0 +1,786 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * QPIC Controller common API file.
>> + * Copyright (C) 2023  Qualcomm Inc.
>> + * Authors:	Md sadre Alam           <quic_mdalam@quicinc.com>
>> + *		Sricharan R             <quic_srichara@quicinc.com>
>> + *		Varadarajan Narayanan	<quic_varada@quicinc.com>
>> + *
>> + */
>> +
>> +#include <linux/mtd/nand-qpic-common.h>
>> +
>> +struct qcom_nand_controller *
>> +get_qcom_nand_controller(struct nand_chip *chip)
>> +{
>> +	return container_of(chip->controller, struct qcom_nand_controller,
>> +			    controller);
>> +}
>> +EXPORT_SYMBOL(get_qcom_nand_controller);
> 
> #define to_qcom_nand_controller()?
Ok
> 
>> +
>> +/*
>> + * Helper to prepare DMA descriptors for configuring registers
>> + * before reading a NAND page.
>> + */
> 
> Can you convert these to kerneldoc instead?
Ok
> 
>> +void config_nand_page_read(struct nand_chip *chip)
>> +{
>> +	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>> +
>> +	write_reg_dma(nandc, NAND_ADDR0, 2, 0);
>> +	write_reg_dma(nandc, NAND_DEV0_CFG0, 3, 0);
>> +	if (!nandc->props->qpic_v2)
> 
> This is not going to scale going forward.. please include a version
> enum instead.
Ok
> 
> [...]
> 
>> +
>> +int prep_adm_dma_desc(struct qcom_nand_controller *nandc, bool read,
>> +		      int reg_off, const void *vaddr, int size,
>> +			     bool flow_control)
>> +{
>> +	struct desc_info *desc;
>> +	struct dma_async_tx_descriptor *dma_desc;
>> +	struct scatterlist *sgl;
>> +	struct dma_slave_config slave_conf;
>> +	struct qcom_adm_peripheral_config periph_conf = {};
>> +	enum dma_transfer_direction dir_eng;
>> +	int ret;
> 
> Revertse-christmas-tree, please
Ok
> 
>> +
>> +	desc = kzalloc(sizeof(*desc), GFP_KERNEL);
>> +	if (!desc)
>> +		return -ENOMEM;
>> +
>> +	sgl = &desc->adm_sgl;
>> +
>> +	sg_init_one(sgl, vaddr, size);
>> +
>> +	if (read) {
>> +		dir_eng = DMA_DEV_TO_MEM;
>> +		desc->dir = DMA_FROM_DEVICE;
>> +	} else {
>> +		dir_eng = DMA_MEM_TO_DEV;
>> +		desc->dir = DMA_TO_DEVICE;
>> +	}
>> +
>> +	ret = dma_map_sg(nandc->dev, sgl, 1, desc->dir);
>> +	if (ret == 0) {
> 
> if (!ret)
Ok
> 
>> +		ret = -ENOMEM;
>> +		goto err;
>> +	}
>> +
>> +	memset(&slave_conf, 0x00, sizeof(slave_conf));
> 
> Just zero-initialize it (= { 0 }) at declaration time
Ok
> 
> Konrad
> 

Thanks for reviewing , I will fix all the comments in next patch.

Regards,
Alam.


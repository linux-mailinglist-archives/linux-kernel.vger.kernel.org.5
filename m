Return-Path: <linux-kernel+bounces-107384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D032E87FBC4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 857C0283A0D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1597E11C;
	Tue, 19 Mar 2024 10:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="niuJXxvG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30AC7D3F4;
	Tue, 19 Mar 2024 10:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710843971; cv=none; b=LGfFBB2HZIEfE3NqNnH1mBl5BYJ+HTCfoH4dihNQFIqH89QonRJUy1g3+wJ/FY7kNYBv8uYCoyHWtfvfFuvV1iqJQGd0Pg2Gs2lNE2mUMX6JSld4oWFEmx9GDPeDYnWWiMRoWSjVhOK+D3RcU7Frs2Qnw3ZVZJR4NgxPzBKoqIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710843971; c=relaxed/simple;
	bh=fXWusfZ2RdxSaw3u7zW+/RF3PHX1Lhg9NrvDpH+8Bzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=E9NpO50APaOmjrzCAQgd0bWiBsxXIjwv+x8Lut3P5YMgZw0jRQRbNI0ZUUUOMCXDDQR/El1TZvYT+zufIED9DuvrQYH9J7mp0UDaUOgTEJB7mZH6ElLu6zs9+6wB0mlnhpiXLStZQx94Ie5UXgMfGzg/o2k9DXMxZzAw3cI84t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=niuJXxvG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42J316ck000451;
	Tue, 19 Mar 2024 10:25:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=vOEIqqTwlUT/p9aDWML1E91/VEaHdRROLzRVMjBzPok=; b=ni
	uJXxvG5O/M4fFnSdDNbdhfS9RbOpI/DgsdHW1gYxpv84hLeTb0bKA3jLjIaiMVf7
	L4tRMpta3ic4sBF3InDPS2FF315oPHe/9nOt1TcRo546yr5hkn7/QFpWtKu14wBx
	d9dM5TSIBkYyAVlWsp5RqsbFQhgFGCF6jvwtQvyclQGA7xvd6gaD8yVFPsd2I2yu
	xM6vqrpR1AMtwBFkRCnbovGAej+rboTFqE685USgm1S0Dw07qHILk4mSg/j0QFFS
	ZqMentrmCmwuijGy2DuNDkPRV0F8Ut2mNgje6RFKFUkNE1P5F7Z7KGzU4lCPqR86
	Nh8UKWvmKJTlhc2yg34Q==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wy2ea0vft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 10:25:31 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42JAPUGG023215
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 10:25:30 GMT
Received: from [10.216.16.222] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 19 Mar
 2024 03:25:23 -0700
Message-ID: <93b08226-3297-2161-cc7d-d33d839c32f0@quicinc.com>
Date: Tue, 19 Mar 2024 15:55:20 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v4 2/5] drivers: mtd: nand: Add qpic_common API file
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <broonie@kernel.org>,
        <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
        <manivannan.sadhasivam@linaro.org>, <neil.armstrong@linaro.org>,
        <daniel@makrotopia.org>, <arnd@arndb.de>,
        <chris.packham@alliedtelesis.co.nz>, <christophe.kerello@foss.st.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.com>
References: <20240308091752.16136-1-quic_mdalam@quicinc.com>
 <20240308091752.16136-3-quic_mdalam@quicinc.com>
 <20240315124517.4a546ce9@xps-13>
Content-Language: en-US
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <20240315124517.4a546ce9@xps-13>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 72kf9PttMRsxXf0D627Emz0JGDig-yjK
X-Proofpoint-GUID: 72kf9PttMRsxXf0D627Emz0JGDig-yjK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 spamscore=0 phishscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1011 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403190080



On 3/15/2024 5:15 PM, Miquel Raynal wrote:
> Hello,
> 
>> +/**
>> + * qcom_qpic_bam_dma_done() - Callback for DMA descriptor completion
>> + * @data: data pointer
>> + *
>> + * This function is a callback for DMA descriptor completion
>> + */
>> +void qcom_qpic_bam_dma_done(void *data)
>> +{
>> +	struct bam_transaction *bam_txn = data;
>> +
>> +	/*
>> +	 * In case of data transfer with NAND, 2 callbacks will be generated.
>> +	 * One for command channel and another one for data channel.
>> +	 * If current transaction has data descriptors
>> +	 * (i.e. wait_second_completion is true), then set this to false
>> +	 * and wait for second DMA descriptor completion.
>> +	 */
>> +	if (bam_txn->wait_second_completion)
>> +		bam_txn->wait_second_completion = false;
>> +	else
>> +		complete(&bam_txn->txn_done);
> 
> Can't you just call "wait" and "complete" twice? It's supposed to be
> handled by the API. This is totally racy.
Ok
> 
>> +}
>> +
>> +/**
>> + * qcom_nandc_read_buffer_sync() - Check for dma sync for cpu or device
>> + * @nandc: qpic nand controller
>> + * @is_cpu: cpu or Device
> 
> ? the naming is really strange dev_to_mem or something like that would
> probably be more helpful.
Ok
> 
>> + *
>> + * This function will check for dma sync for cpu or device
>> + */
>> +void qcom_nandc_read_buffer_sync(struct qcom_nand_controller *nandc,
>> +				 bool is_cpu)
>> +{
>> +	if (!nandc->props->is_bam)
>> +		return;
>> +
>> +	if (is_cpu)
>> +		dma_sync_single_for_cpu(nandc->dev, nandc->reg_read_dma,
>> +					MAX_REG_RD *
>> +					sizeof(*nandc->reg_read_buf),
>> +					DMA_FROM_DEVICE);
>> +	else
>> +		dma_sync_single_for_device(nandc->dev, nandc->reg_read_dma,
>> +					   MAX_REG_RD *
>> +					   sizeof(*nandc->reg_read_buf),
>> +					   DMA_FROM_DEVICE);
>> +}
>> +
>> +/**
>> + * qcom_offset_to_nandc_reg() - Get the actual offset
>> + * @regs: pointer to nandc_reg structure
>> + * @offset: register offset
>> + *
>> + * This function will reurn the actual offset for qpic controller register
>> + */
>> +__le32 *qcom_offset_to_nandc_reg(struct nandc_regs *regs, int offset)
>> +{
>> +	switch (offset) {
>> +	case NAND_FLASH_CMD:
>> +		return &regs->cmd;
>> +	case NAND_ADDR0:
>> +		return &regs->addr0;
>> +	case NAND_ADDR1:
>> +		return &regs->addr1;
>> +	case NAND_FLASH_CHIP_SELECT:
>> +		return &regs->chip_sel;
>> +	case NAND_EXEC_CMD:
>> +		return &regs->exec;
>> +	case NAND_FLASH_STATUS:
>> +		return &regs->clrflashstatus;
>> +	case NAND_DEV0_CFG0:
>> +		return &regs->cfg0;
>> +	case NAND_DEV0_CFG1:
>> +		return &regs->cfg1;
>> +	case NAND_DEV0_ECC_CFG:
>> +		return &regs->ecc_bch_cfg;
>> +	case NAND_READ_STATUS:
>> +		return &regs->clrreadstatus;
>> +	case NAND_DEV_CMD1:
>> +		return &regs->cmd1;
>> +	case NAND_DEV_CMD1_RESTORE:
>> +		return &regs->orig_cmd1;
>> +	case NAND_DEV_CMD_VLD:
>> +		return &regs->vld;
>> +	case NAND_DEV_CMD_VLD_RESTORE:
>> +		return &regs->orig_vld;
>> +	case NAND_EBI2_ECC_BUF_CFG:
>> +		return &regs->ecc_buf_cfg;
>> +	case NAND_READ_LOCATION_0:
>> +		return &regs->read_location0;
>> +	case NAND_READ_LOCATION_1:
>> +		return &regs->read_location1;
>> +	case NAND_READ_LOCATION_2:
>> +		return &regs->read_location2;
>> +	case NAND_READ_LOCATION_3:
>> +		return &regs->read_location3;
>> +	case NAND_READ_LOCATION_LAST_CW_0:
>> +		return &regs->read_location_last0;
>> +	case NAND_READ_LOCATION_LAST_CW_1:
>> +		return &regs->read_location_last1;
>> +	case NAND_READ_LOCATION_LAST_CW_2:
>> +		return &regs->read_location_last2;
>> +	case NAND_READ_LOCATION_LAST_CW_3:
>> +		return &regs->read_location_last3;
> 
> Why do you need this indirection?

This indirection I believe is needed by the write_reg_dma function,
wherein a bunch of registers are modified based on a starting register.
Can I change this in a separate cleanup series as a follow up to this?

> 
>> +	default:
>> +		return NULL;
>> +	}
>> +}
>> +
> 
> ...
> 
>> +/**
>> + * qcom_clear_bam_transaction() - Clears the BAM transaction
>> + * @nandc: qpic nand controller
>> + *
>> + * This function will clear the BAM transaction indexes.
>> + */
>> +void qcom_clear_bam_transaction(struct qcom_nand_controller *nandc)
>> +{
>> +	struct bam_transaction *bam_txn = nandc->bam_txn;
>> +
>> +	if (!nandc->props->is_bam)
>> +		return;
>> +
>> +	bam_txn->bam_ce_pos = 0;
>> +	bam_txn->bam_ce_start = 0;
>> +	bam_txn->cmd_sgl_pos = 0;
>> +	bam_txn->cmd_sgl_start = 0;
>> +	bam_txn->tx_sgl_pos = 0;
>> +	bam_txn->tx_sgl_start = 0;
>> +	bam_txn->rx_sgl_pos = 0;
>> +	bam_txn->rx_sgl_start = 0;
>> +	bam_txn->last_data_desc = NULL;
>> +	bam_txn->wait_second_completion = false;
> 
> What about using memset here?
Ok
> 
>> +
>> +	sg_init_table(bam_txn->cmd_sgl, nandc->max_cwperpage *
>> +		      QPIC_PER_CW_CMD_SGL);
>> +	sg_init_table(bam_txn->data_sgl, nandc->max_cwperpage *
>> +		      QPIC_PER_CW_DATA_SGL);
>> +
>> +	reinit_completion(&bam_txn->txn_done);
>> +}
> 
> ...
> 
>> diff --git a/include/linux/mtd/nand-qpic-common.h b/include/linux/mtd/nand-qpic-common.h
>> new file mode 100644
>> index 000000000000..aced15866627
>> --- /dev/null
>> +++ b/include/linux/mtd/nand-qpic-common.h
>> @@ -0,0 +1,486 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * QCOM QPIC common APIs header file
>> + *
>> + * Copyright (c) 2023 Qualcomm Inc.
>> + * Authors:     Md sadre Alam           <quic_mdalam@quicinc.com>
>> + *		Sricharan R             <quic_srichara@quicinc.com>
>> + *		Varadarajan Narayanan   <quic_varada@quicinc.com>
>> + *
>> + */
>> +#ifndef __MTD_NAND_QPIC_COMMON_H__
>> +#define __MTD_NAND_QPIC_COMMON_H__
>> +
>> +#include <linux/bitops.h>
>> +#include <linux/clk.h>
>> +#include <linux/delay.h>
>> +#include <linux/dmaengine.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/dma/qcom_adm.h>
>> +#include <linux/dma/qcom_bam_dma.h>
>> +#include <linux/module.h>
>> +#include <linux/mtd/partitions.h>
>> +#include <linux/mtd/rawnand.h>
> 
> You really need this?
Yes , since some generic structure used here.
> 
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +
>> +/* NANDc reg offsets */
>> +#define	NAND_FLASH_CMD			0x00
>> +#define	NAND_ADDR0			0x04
>> +#define	NAND_ADDR1			0x08
>> +#define	NAND_FLASH_CHIP_SELECT		0x0c
>> +#define	NAND_EXEC_CMD			0x10
>> +#define	NAND_FLASH_STATUS		0x14
>> +#define	NAND_BUFFER_STATUS		0x18
>> +#define	NAND_DEV0_CFG0			0x20
>> +#define	NAND_DEV0_CFG1			0x24
>> +#define	NAND_DEV0_ECC_CFG		0x28
>> +#define	NAND_AUTO_STATUS_EN		0x2c
>> +#define	NAND_DEV1_CFG0			0x30
>> +#define	NAND_DEV1_CFG1			0x34
>> +#define	NAND_READ_ID			0x40
>> +#define	NAND_READ_STATUS		0x44
>> +#define	NAND_DEV_CMD0			0xa0
>> +#define	NAND_DEV_CMD1			0xa4
>> +#define	NAND_DEV_CMD2			0xa8
>> +#define	NAND_DEV_CMD_VLD		0xac
>> +#define	SFLASHC_BURST_CFG		0xe0
>> +#define	NAND_ERASED_CW_DETECT_CFG	0xe8
>> +#define	NAND_ERASED_CW_DETECT_STATUS	0xec
>> +#define	NAND_EBI2_ECC_BUF_CFG		0xf0
>> +#define	FLASH_BUF_ACC			0x100
>> +
> 
> ...
> 
>> +/*
>> + * This data type corresponds to the NAND controller properties which varies
>> + * among different NAND controllers.
>> + * @ecc_modes - ecc mode for NAND
> 
> Should this member be an enum?
Ok , Will fix in next patch
> 
>> + * @dev_cmd_reg_start - NAND_DEV_CMD_* registers starting offset
>> + * @is_bam - whether NAND controller is using BAM
> 
> has_bam_support? supports_bam?
Ok
> 
>> + * @is_qpic - whether NAND CTRL is part of qpic IP
> 
> CTRL? do you mean controller?
Yes.
> 
>> + * @qpic_v2 - flag to indicate QPIC IP version 2
>> + * @use_codeword_fixup - whether NAND has different layout for boot partitions
> 
> The doc is clear but the member name is terrible. Please clarify the
> naming.
Ok
> 
>> + */
>> +struct qcom_nandc_props {
>> +	u32 ecc_modes;
>> +	u32 dev_cmd_reg_start;
>> +	bool is_bam;
>> +	bool is_qpic;
>> +	bool qpic_v2;
>> +	bool use_codeword_fixup;
>> +};
>> +
>> +void config_nand_page_read(struct nand_chip *chip);
>> +void qcom_qpic_bam_dma_done(void *data);
>> +void qcom_nandc_read_buffer_sync(struct qcom_nand_controller *nandc, bool is_cpu);
>> +__le32 *qcom_offset_to_nandc_reg(struct nandc_regs *regs, int offset);
>> +int qcom_prep_adm_dma_desc(struct qcom_nand_controller *nandc, bool read,
>> +			   int reg_off, const void *vaddr, int size,
>> +			bool flow_control);
>> +int qcom_submit_descs(struct qcom_nand_controller *nandc);
>> +int qcom_prepare_bam_async_desc(struct qcom_nand_controller *nandc,
>> +				struct dma_chan *chan, unsigned long flags);
>> +int qcom_prep_bam_dma_desc_cmd(struct qcom_nand_controller *nandc, bool read,
>> +			       int reg_off, const void *vaddr,
>> +			int size, unsigned int flags);
>> +int qcom_prep_bam_dma_desc_data(struct qcom_nand_controller *nandc, bool read,
>> +				const void *vaddr,
>> +			int size, unsigned int flags);
>> +int qcom_read_reg_dma(struct qcom_nand_controller *nandc, int first,
>> +		      int num_regs, unsigned int flags);
>> +int qcom_write_reg_dma(struct qcom_nand_controller *nandc, int first,
>> +		       int num_regs, unsigned int flags);
>> +int qcom_read_data_dma(struct qcom_nand_controller *nandc, int reg_off,
>> +		       const u8 *vaddr, int size, unsigned int flags);
>> +int qcom_write_data_dma(struct qcom_nand_controller *nandc, int reg_off,
>> +			const u8 *vaddr, int size, unsigned int flags);
>> +struct bam_transaction *qcom_alloc_bam_transaction(struct qcom_nand_controller *nandc);
>> +void qcom_clear_bam_transaction(struct qcom_nand_controller *nandc);
>> +void qcom_nandc_unalloc(struct qcom_nand_controller *nandc);
>> +int qcom_nandc_alloc(struct qcom_nand_controller *nandc);
>> +void qcom_clear_read_regs(struct qcom_nand_controller *nandc);
>> +void qcom_free_bam_transaction(struct qcom_nand_controller *nandc);
>> +#endif
> 
> I made several requests on code that already exists, please add these
> changes to your series.
ok
> 
> 
> Also, this patching being big, please split:
> 1- rename your all your symbols to start with the same prefix
> (qcom_nand_ instead of nothing or just qcom)
Ok
> 2- then perform the move, which should not require changing the names
> of all the functions everywhere.
Ok
> 
> Thanks,
> Miquèl

Thanks for reviewing. Will address all the comments in next patch series.

Reagrds,
Alam.


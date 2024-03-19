Return-Path: <linux-kernel+bounces-107387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C0187FBD2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13B60B21FED
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF5C7E570;
	Tue, 19 Mar 2024 10:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lcKezys8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA107D401;
	Tue, 19 Mar 2024 10:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710844144; cv=none; b=hr+BCQiCj8X45o8Uw63RoYxmeLb1C6tV4mDyumfibCfNfTjCQyEsWbvkjZD2vUofbI9sbUdbvG2TMCAyYwfD5SN+RycQUd/I9uAOaGgKTwdQXqd2JOsoHFq+PuYQ55GUeTKu5hqxfRCej6rhRfc8HrDeDz0wM6Q0B7RMKiLHQso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710844144; c=relaxed/simple;
	bh=99V1FAHl164WdIrjZ3xpw1sBu6SY/qVi3oEDpGU5/vk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ShgGGWMKv4YpPECJC7VdmNXfZIcV/v0IUhB6GVGzt5jgcSqkP1jXGXVWwiOnFFlW3ms15pcNp9Eg0cCmoI4Cz4k1SRcup3oiw8/UHecMJYhMBP5fLfdI0huYInNZMP2ma3WNbN7gapK7foYSnQBG68QXCQel8RtRNLmHZBIbGq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lcKezys8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42J8W2CD025187;
	Tue, 19 Mar 2024 10:28:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=wWDSpoZA+hnhCTnkt3EUh+pDbm6gtgNkMgXJ1mqyysM=; b=lc
	Kezys8S15SFsMnkdtEMP6y03e5NNn5u6AjdK4e2ijJxPqdJRZPAv+RIcEUjJKYKi
	7uU18/SxuVd18pcnNBWggsIToNYc/4QF2SULflJ0XULyhrj22xl9WCJXcAmmy98B
	ftOFClvpCE/PRlAP56a78dvGh7u6J+SUop46Nmu2H8smEvBgcAWHW/8VYpZ2LIe9
	29ub2rwRwCtIsinHmtnoL8WXrmdbYW2e9OGE2c9j2BW0iUPLX5zHhiBxgQHzz51P
	/ALM3ZpxFDrvmM5dd4lYMC1E+GaEHxGLrDtrvS0PSpdJ/P63Ykq2lUm9VjqkEObc
	RoJ5ikI00Zvs03JEoeiw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wy1jhryde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 10:28:32 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42JASVOq029423
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 10:28:31 GMT
Received: from [10.216.16.222] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 19 Mar
 2024 03:28:23 -0700
Message-ID: <e58ef982-c9f1-1496-6281-ec69078fb935@quicinc.com>
Date: Tue, 19 Mar 2024 15:58:20 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v4 3/5] spi: spi-qpic: Add qpic spi nand driver support
Content-Language: en-US
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
 <20240308091752.16136-4-quic_mdalam@quicinc.com>
 <20240315130833.610edaf6@xps-13>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <20240315130833.610edaf6@xps-13>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YN-kZFty7XtmBoDdQDdKJ5U-B_MDe_Vp
X-Proofpoint-GUID: YN-kZFty7XtmBoDdQDdKJ5U-B_MDe_Vp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403140001
 definitions=main-2403190080



On 3/15/2024 5:38 PM, Miquel Raynal wrote:
> Hi,
> 
> quic_mdalam@quicinc.com wrote on Fri,  8 Mar 2024 14:47:50 +0530:
> 
>> Add qpic spi nand driver support. The spi nand
>> driver currently supported the below commands.
>>
>> -- RESET
>> -- READ ID
>> -- SET FEATURE
>> -- GET FEATURE
>> -- READ PAGE
>> -- WRITE PAGE
>> -- ERASE PAGE
>>
>> Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> Co-developed-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> 
> I don't like the "spi nand driver" wording here. It is a spi
> controller, for spi-memories.
Ok
> 
> Plus, I'd expect some kind of check to see whether you support the
> requested operation, I don't see any in the code.
Ok, will add in next patch.
> 
> 
>> ---
>> Change in [v4]
>>
>> * No change
>>
>> Change in [v3]
>>
>> * Set SPI_QPIC_SNAND to n and added COMPILE_TEST in Kconfig
>>
>> * Made driver name sorted in Make file
>>
>> * Made comment like c++
>>
>> * Changed macro to functions, snandc_set_read_loc_last()
>>    and snandc_set_read_loc_first()
>>
>> * Added error handling in snandc_set_reg()
>>
>> * Changed into normal conditional statement for
>>    return snandc->ecc_stats.failed ? -EBADMSG :
>>    snandc->ecc_stats.bitflips;
>>
>> * Remove cast of wbuf in qpic_snand_program_execute()
>>    function
>>
>> * Made num_cw variable instead hardcoded value
>>
>> * changed if..else condition of function qpic_snand_io_op()
>>    to switch..case statement
>>
>> * Added __devm_spi_alloc_controller() api instead of
>>    devm_spi_alloc_master()
>>
>> * Disabling clock in remove path
>>
>> Change in [v2]
>>
>> * Added initial support for SPI-NAND driver
>>
>> Change in [v1]
>>
>> * Added RFC patch for design review
>>
>>   drivers/mtd/nand/qpic_common.c       |    8 +
>>   drivers/spi/Kconfig                  |    8 +
>>   drivers/spi/Makefile                 |    1 +
>>   drivers/spi/spi-qpic-snand.c         | 1041 ++++++++++++++++++++++++++
>>   include/linux/mtd/nand-qpic-common.h |   61 ++
>>   5 files changed, 1119 insertions(+)
>>   create mode 100644 drivers/spi/spi-qpic-snand.c
>>
>> diff --git a/drivers/mtd/nand/qpic_common.c b/drivers/mtd/nand/qpic_common.c
>> index 5b7c0d119d9a..67ccb3d05f20 100644
>> --- a/drivers/mtd/nand/qpic_common.c
>> +++ b/drivers/mtd/nand/qpic_common.c
>> @@ -134,6 +134,14 @@ __le32 *qcom_offset_to_nandc_reg(struct nandc_regs *regs, int offset)
>>   		return &regs->read_location_last2;
>>   	case NAND_READ_LOCATION_LAST_CW_3:
>>   		return &regs->read_location_last3;
>> +	case NAND_FLASH_SPI_CFG:
>> +		return &regs->spi_cfg;
>> +	case NAND_NUM_ADDR_CYCLES:
>> +		return &regs->num_addr_cycle;
>> +	case NAND_BUSY_CHECK_WAIT_CNT:
>> +		return &regs->busy_wait_cnt;
>> +	case NAND_FLASH_FEATURES:
>> +		return &regs->flash_feature;
> 
> I am still not convinced about these. I don't understand who you have
> this indirection.
This indirection I believe is needed by the write_reg_dma function, wherein a
bunch of registers are modified based on a starting register.Can I change this
in a separate cleanup series as a follow up to this?
> 
>>   	default:
>>   		return NULL;
>>   	}
>> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
>> index bc7021da2fe9..63764e943d82 100644
>> --- a/drivers/spi/Kconfig
>> +++ b/drivers/spi/Kconfig
>> @@ -882,6 +882,14 @@ config SPI_QCOM_QSPI
>>   	help
>>   	  QSPI(Quad SPI) driver for Qualcomm QSPI controller.
>>   
>> +config SPI_QPIC_SNAND
>> +	tristate "QPIC SNAND controller"
>> +	depends on ARCH_QCOM || COMPILE_TEST
>> +	help
>> +	  QPIC_SNAND (QPIC SPI NAND) driver for Qualcomm QPIC controller.
>> +	  QPIC controller supports both parallel nand and serial nand.
>> +	  This config will enable serial nand driver for QPIC controller.
>> +
>>   config SPI_QUP
>>   	tristate "Qualcomm SPI controller with QUP interface"
>>   	depends on ARCH_QCOM || COMPILE_TEST
>> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
>> index 4ff8d725ba5e..9015368f8c73 100644
>> --- a/drivers/spi/Makefile
>> +++ b/drivers/spi/Makefile
>> @@ -111,6 +111,7 @@ obj-$(CONFIG_SPI_PXA2XX)		+= spi-pxa2xx-platform.o
>>   obj-$(CONFIG_SPI_PXA2XX_PCI)		+= spi-pxa2xx-pci.o
>>   obj-$(CONFIG_SPI_QCOM_GENI)		+= spi-geni-qcom.o
>>   obj-$(CONFIG_SPI_QCOM_QSPI)		+= spi-qcom-qspi.o
>> +obj-$(CONFIG_SPI_QPIC_SNAND)            += spi-qpic-snand.o
>>   obj-$(CONFIG_SPI_QUP)			+= spi-qup.o
>>   obj-$(CONFIG_SPI_ROCKCHIP)		+= spi-rockchip.o
>>   obj-$(CONFIG_SPI_ROCKCHIP_SFC)		+= spi-rockchip-sfc.o
>> diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
>> new file mode 100644
>> index 000000000000..df7d5d8d4db2
>> --- /dev/null
>> +++ b/drivers/spi/spi-qpic-snand.c
>> @@ -0,0 +1,1041 @@
>> +/*
>> + * SPDX-License-Identifier: GPL-2.0
>> + *
>> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
>> + *
>> + * Authors:
>> + *	Md Sadre Alam <quic_mdalam@quicinc.com>
>> + *	Sricharan R <quic_srichara@quicinc.com>
>> + *	Varadarajan Narayanan <quic_varada@quicinc.com>
>> + */
>> +
>> +#include <linux/mtd/spinand.h>
>> +#include <linux/mtd/nand-qpic-common.h>
>> +
>> +/* QSPI NAND config reg bits */
>> +#define LOAD_CLK_CNTR_INIT_EN   BIT(28)
>> +#define CLK_CNTR_INIT_VAL_VEC   0x924
>> +#define FEA_STATUS_DEV_ADDR     0xc0
>> +#define SPI_CFG			BIT(0)
>> +#define SPI_NUM_ADDR		0xDA4DB
>> +#define SPI_WAIT_CNT		0x10
>> +#define QPIC_QSPI_NUM_CS	1
>> +#define SPI_TRANSFER_MODE_x1	BIT(29)
>> +#define SPI_TRANSFER_MODE_x4	(3 << 29)
>> +#define SPI_WP			BIT(28)
>> +#define SPI_HOLD		BIT(27)
>> +#define QPIC_SET_FEATURE	BIT(31)
>> +
>> +#define SPINAND_RESET		0xff
>> +#define SPINAND_READID		0x9f
>> +#define SPINAND_GET_FEATURE	0x0f
>> +#define SPINAND_SET_FEATURE	0x1f
>> +#define SPINAND_READ		0x13
>> +#define SPINAND_ERASE		0xd8
>> +#define SPINAND_WRITE_EN	0x06
>> +#define SPINAND_PROGRAM_EXECUTE	0x10
>> +#define SPINAND_PROGRAM_LOAD	0x84
>> +
>> +struct qpic_snand_op {
>> +	u32 cmd_reg;
>> +	u32 addr1_reg;
>> +	u32 addr2_reg;
>> +};
>> +
>> +struct snandc_read_status {
>> +	__le32 snandc_flash;
>> +	__le32 snandc_buffer;
>> +	__le32 snandc_erased_cw;
>> +};
>> +
>> +static void snandc_set_reg(struct qcom_nand_controller *snandc, int offset, u32 val)
> 
> qcom_spi_ would be a better prefix maybe?
Ok
> 
>> +{
>> +	struct nandc_regs *regs = snandc->regs;
>> +	__le32 *reg;
>> +
>> +	reg = qcom_offset_to_nandc_reg(regs, offset);
>> +
>> +	if (reg)
>> +		*reg = cpu_to_le32(val);
>> +
>> +	if (WARN_ON(!reg))
>> +		return;
> 
> This whole logic really seems suboptimal.
> 
>> +}
>> +
>> +static void snandc_set_read_loc_first(struct qcom_nand_controller *snandc,
>> +				      int reg, int cw_offset, int read_size,
>> +				      int is_last_read_loc)
>> +{
>> +	snandc_set_reg(snandc, reg, ((cw_offset) << READ_LOCATION_OFFSET) |
>> +		       ((read_size) << READ_LOCATION_SIZE) | ((is_last_read_loc)
>> +			       << READ_LOCATION_LAST));
> 
> FIELD_GET, FIELD_PREP ?
Ok
> 
>> +}
>> +
>> +static void snandc_set_read_loc_last(struct qcom_nand_controller *snandc,
>> +				     int reg, int cw_offset, int read_size,
>> +				     int is_last_read_loc)
>> +{
>> +	snandc_set_reg(snandc, reg, ((cw_offset) << READ_LOCATION_OFFSET) |
>> +		       ((read_size) << READ_LOCATION_SIZE) | ((is_last_read_loc)
>> +			       << READ_LOCATION_LAST));
>> +}
>> +
>> +static struct qcom_nand_controller *nand_to_qcom_snand(struct nand_device *nand)
>> +{
>> +	struct nand_ecc_engine *eng = nand->ecc.engine;
>> +
>> +	return container_of(eng, struct qcom_nand_controller, ecc_eng);
>> +}
>> +
>> +static int qcom_snand_init(struct qcom_nand_controller *snandc)
>> +{
>> +	u32 snand_cfg_val = 0x0;
>> +	int ret;
>> +
>> +	snand_cfg_val |= (LOAD_CLK_CNTR_INIT_EN | (CLK_CNTR_INIT_VAL_VEC << 16)
>> +			| (FEA_STATUS_DEV_ADDR << 8) | SPI_CFG);
> 
>                          ^
> the | should be on the previous line.
Ok
> 
>> +
>> +	snandc_set_reg(snandc, NAND_FLASH_SPI_CFG, 0);
>> +	snandc_set_reg(snandc, NAND_FLASH_SPI_CFG, snand_cfg_val);
>> +	snandc_set_reg(snandc, NAND_NUM_ADDR_CYCLES, SPI_NUM_ADDR);
>> +	snandc_set_reg(snandc, NAND_BUSY_CHECK_WAIT_CNT, SPI_WAIT_CNT);
>> +
>> +	qcom_write_reg_dma(snandc, NAND_FLASH_SPI_CFG, 1, 0);
>> +	qcom_write_reg_dma(snandc, NAND_FLASH_SPI_CFG, 1, 0);
>> +
>> +	snand_cfg_val &= ~LOAD_CLK_CNTR_INIT_EN;
>> +	snandc_set_reg(snandc, NAND_FLASH_SPI_CFG, snand_cfg_val);
>> +
>> +	qcom_write_reg_dma(snandc, NAND_FLASH_SPI_CFG, 1, 0);
>> +
>> +	qcom_write_reg_dma(snandc, NAND_NUM_ADDR_CYCLES, 1, 0);
>> +	qcom_write_reg_dma(snandc, NAND_BUSY_CHECK_WAIT_CNT, 1, NAND_BAM_NEXT_SGL);
>> +
>> +	ret = qcom_submit_descs(snandc);
>> +	if (ret)
>> +		dev_err(snandc->dev, "failure in sbumitting spiinit descriptor\n");
> 
> Typos...
Ok
> 
>> +
>> +	return 0;
> 
> return ret ?
Ok
> 
>> +}
>> +
>> +static int qcom_snand_ooblayout_ecc(struct mtd_info *mtd, int section,
>> +				    struct mtd_oob_region *oobregion)
>> +{
>> +	struct nand_device *nand = mtd_to_nanddev(mtd);
>> +	struct qcom_nand_controller *snandc = nand_to_qcom_snand(nand);
>> +	struct qpic_ecc *qecc = snandc->ecc;
>> +
>> +	if (section > 1)
>> +		return -ERANGE;
>> +
>> +	if (!section) {
>> +		oobregion->length = (qecc->bytes * (qecc->steps - 1)) + qecc->bbm_size;
>> +		oobregion->offset = 0;
> 
> No BBM?
Ok
> 
>> +	} else {
>> +		oobregion->length = qecc->ecc_bytes_hw + qecc->spare_bytes;
>> +		oobregion->offset = mtd->oobsize - oobregion->length;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int qcom_snand_ooblayout_free(struct mtd_info *mtd, int section,
>> +				     struct mtd_oob_region *oobregion)
>> +{
>> +	struct nand_device *nand = mtd_to_nanddev(mtd);
>> +	struct qcom_nand_controller *snandc = nand_to_qcom_snand(nand);
>> +	struct qpic_ecc *qecc = snandc->ecc;
>> +
>> +	if (section)
>> +		return -ERANGE;
>> +
>> +	oobregion->length = qecc->steps * 4;
>> +	oobregion->offset = ((qecc->steps - 1) * qecc->bytes) + qecc->bbm_size;
>> +
> 
> Using the same order would be easier to compare with the above version

Not able to understand. Could you please elaborate order of what has to be change
Will change it in the next version.

>> +	return 0;
>> +}
>> +
>> +static const struct mtd_ooblayout_ops qcom_snand_ooblayout = {
>> +	.ecc = qcom_snand_ooblayout_ecc,
>> +	.free = qcom_snand_ooblayout_free,
>> +};
>> +
>> +static int qpic_snand_ecc_init_ctx_pipelined(struct nand_device *nand)
>> +{
>> +	struct qcom_nand_controller *snandc = nand_to_qcom_snand(nand);
>> +	struct nand_ecc_props *conf = &nand->ecc.ctx.conf;
>> +	struct nand_ecc_props *reqs = &nand->ecc.requirements;
>> +	struct nand_ecc_props *user = &nand->ecc.user_conf;
>> +	struct mtd_info *mtd = nanddev_to_mtd(nand);
>> +	int step_size = 0, strength = 0, steps;
>> +	int cwperpage, bad_block_byte;
>> +	struct qpic_ecc *ecc_cfg;
>> +
>> +	cwperpage = mtd->writesize / NANDC_STEP_SIZE;
>> +	snandc->num_cw = cwperpage;
>> +
>> +	ecc_cfg = kzalloc(sizeof(*ecc_cfg), GFP_KERNEL);
>> +	if (!ecc_cfg)
>> +		return -ENOMEM;
>> +
>> +	nand->ecc.ctx.priv = ecc_cfg;
>> +
>> +	if (user->step_size && user->strength) {
>> +		step_size = user->step_size;
>> +		strength = user->strength;
>> +	} else if (reqs->step_size && reqs->strength) {
>> +		step_size = reqs->step_size;
>> +		strength = reqs->strength;
>> +	}
>> +
>> +	if (step_size && strength)
>> +		steps = mtd->writesize / step_size;
>> +
>> +	ecc_cfg->ecc_bytes_hw = 7;
>> +	ecc_cfg->spare_bytes = 4;
>> +	ecc_cfg->bbm_size = 1;
>> +	ecc_cfg->bch_enabled = true;
>> +	ecc_cfg->bytes = ecc_cfg->ecc_bytes_hw + ecc_cfg->spare_bytes + ecc_cfg->bbm_size;
>> +
>> +	ecc_cfg->steps = 4;
>> +	ecc_cfg->strength = 4;
>> +	ecc_cfg->step_size = 512;
>> +
>> +	mtd_set_ooblayout(mtd, &qcom_snand_ooblayout);
>> +
>> +	ecc_cfg->cw_data = 516;
>> +	ecc_cfg->cw_size = ecc_cfg->cw_data + ecc_cfg->bytes;
>> +	bad_block_byte = mtd->writesize - ecc_cfg->cw_size * (cwperpage - 1) + 1;
>> +
>> +	ecc_cfg->cfg0 = (cwperpage - 1) << CW_PER_PAGE
>> +				| ecc_cfg->cw_data << UD_SIZE_BYTES
>> +				| 1 << DISABLE_STATUS_AFTER_WRITE
>> +				| 3 << NUM_ADDR_CYCLES
>> +				| ecc_cfg->ecc_bytes_hw << ECC_PARITY_SIZE_BYTES_RS
>> +				| 0 << STATUS_BFR_READ
>> +				| 1 << SET_RD_MODE_AFTER_STATUS
>> +				| ecc_cfg->spare_bytes << SPARE_SIZE_BYTES;
>> +
>> +	ecc_cfg->cfg1 = 0 << NAND_RECOVERY_CYCLES
>> +				| 0 <<  CS_ACTIVE_BSY
>> +				| bad_block_byte << BAD_BLOCK_BYTE_NUM
>> +				| 0 << BAD_BLOCK_IN_SPARE_AREA
>> +				| 20 << WR_RD_BSY_GAP
>> +				| 0 << WIDE_FLASH
>> +				| ecc_cfg->bch_enabled << ENABLE_BCH_ECC;
>> +
>> +	ecc_cfg->cfg0_raw = (cwperpage - 1) << CW_PER_PAGE
>> +				| ecc_cfg->cw_size << UD_SIZE_BYTES
>> +				| 3 << NUM_ADDR_CYCLES
>> +				| 0 << SPARE_SIZE_BYTES;
>> +
>> +	ecc_cfg->cfg1_raw = 0 << NAND_RECOVERY_CYCLES
>> +				| 0 << CS_ACTIVE_BSY
>> +				| 17 << BAD_BLOCK_BYTE_NUM
>> +				| 1 << BAD_BLOCK_IN_SPARE_AREA
>> +				| 20 << WR_RD_BSY_GAP
>> +				| 0 << WIDE_FLASH
>> +				| 1 << DEV0_CFG1_ECC_DISABLE;
>> +
>> +	ecc_cfg->ecc_bch_cfg = !ecc_cfg->bch_enabled << ECC_CFG_ECC_DISABLE
>> +				| 0 << ECC_SW_RESET
>> +				| ecc_cfg->cw_data << ECC_NUM_DATA_BYTES
>> +				| 1 << ECC_FORCE_CLK_OPEN
>> +				| 0 << ECC_MODE
>> +				| ecc_cfg->ecc_bytes_hw << ECC_PARITY_SIZE_BYTES_BCH;
>> +
>> +	ecc_cfg->ecc_buf_cfg = 0x203 << NUM_STEPS;
>> +	ecc_cfg->clrflashstatus = FS_READY_BSY_N;
>> +	ecc_cfg->clrreadstatus = 0xc0;
>> +
>> +	conf->step_size = ecc_cfg->step_size;
>> +	conf->strength = ecc_cfg->strength;
>> +
>> +	if (ecc_cfg->strength < strength)
>> +		dev_warn(snandc->dev, "Unable to fulfill ECC requirements of %u bits.\n", strength);
> 
> Not needed I guess. Somewhat redundant with the core?
Ok
> 
>> +
>> +	dev_info(snandc->dev, "ECC strength: %u bits per %u bytes\n",
>> +		 ecc_cfg->strength, ecc_cfg->step_size);
> 
> Debug?
Ok
> 
>> +
>> +	return 0;
>> +}
>> +
>> +static void qpic_snand_ecc_cleanup_ctx_pipelined(struct nand_device *nand)
>> +{
>> +	struct qpic_ecc *ecc_cfg = nand_to_ecc_ctx(nand);
>> +
>> +	kfree(ecc_cfg);
>> +}
>> +
>> +static int qpic_snand_ecc_prepare_io_req_pipelined(struct nand_device *nand,
>> +						   struct nand_page_io_req *req)
>> +{
>> +	struct qcom_nand_controller *snandc = nand_to_qcom_snand(nand);
>> +	struct qpic_ecc *ecc_cfg = nand_to_ecc_ctx(nand);
>> +
>> +	snandc->ecc = ecc_cfg;
>> +	snandc->raw = false;
>> +	snandc->oob_read = false;
>> +
>> +	if (req->mode == MTD_OPS_RAW) {
>> +		if (req->ooblen)
>> +			snandc->oob_read = true;
>> +		snandc->raw = true;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int qpic_snand_ecc_finish_io_req_pipelined(struct nand_device *nand,
>> +						  struct nand_page_io_req *req)
>> +{
>> +	struct qcom_nand_controller *snandc = nand_to_qcom_snand(nand);
>> +	struct mtd_info *mtd = nanddev_to_mtd(nand);
>> +
>> +	if (req->mode == MTD_OPS_RAW || req->type != NAND_PAGE_READ)
>> +		return 0;
>> +
>> +	if (snandc->ecc_stats.failed)
>> +		mtd->ecc_stats.failed += snandc->ecc_stats.failed;
>> +	mtd->ecc_stats.corrected += snandc->ecc_stats.corrected;
>> +
>> +	if (snandc->ecc_stats.failed)
> 
> I hope you reset this counter at some point.
Yes
> 
> Did you run nandbiterrs -i ?

No. I tested with mtd write/erase and dd commands etc. Will include nandbiterrs from next version.

> 
>> +		return -EBADMSG;
>> +	else
>> +		return snandc->ecc_stats.bitflips;
>> +}
>> +
>> +static struct nand_ecc_engine_ops qcom_snand_ecc_engine_ops_pipelined = {
>> +	.init_ctx = qpic_snand_ecc_init_ctx_pipelined,
>> +	.cleanup_ctx = qpic_snand_ecc_cleanup_ctx_pipelined,
>> +	.prepare_io_req = qpic_snand_ecc_prepare_io_req_pipelined,
>> +	.finish_io_req = qpic_snand_ecc_finish_io_req_pipelined,
>> +};
>> +
>> +/* helper to configure location register values */
>> +static void snandc_set_read_loc(struct qcom_nand_controller *snandc, int cw, int reg,
>> +				int cw_offset, int read_size, int is_last_read_loc)
>> +{
>> +	int reg_base = NAND_READ_LOCATION_0;
>> +
>> +	if (cw == 3)
>> +		reg_base = NAND_READ_LOCATION_LAST_CW_0;
>> +
>> +	reg_base += reg * 4;
>> +
>> +	if (cw == 3)
>> +		return snandc_set_read_loc_last(snandc, reg_base, cw_offset,
>> +				read_size, is_last_read_loc);
> 
> Alignments are still wrong, again.
Ok
> 
>> +	else
>> +		return snandc_set_read_loc_first(snandc, reg_base, cw_offset,
>> +				read_size, is_last_read_loc);
>> +}
>> +
>> +static void
>> +snandc_config_cw_read(struct qcom_nand_controller *snandc, bool use_ecc, int cw)
>> +{
>> +	int reg = NAND_READ_LOCATION_0;
>> +
>> +	if (cw == 3)
>> +		reg = NAND_READ_LOCATION_LAST_CW_0;
>> +
>> +	if (snandc->props->is_bam)
>> +		qcom_write_reg_dma(snandc, reg, 4, NAND_BAM_NEXT_SGL);
>> +
>> +	qcom_write_reg_dma(snandc, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
>> +	qcom_write_reg_dma(snandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
>> +
>> +	qcom_read_reg_dma(snandc, NAND_FLASH_STATUS, 2, 0);
>> +	qcom_read_reg_dma(snandc, NAND_ERASED_CW_DETECT_STATUS, 1,
>> +			  NAND_BAM_NEXT_SGL);
>> +}
>> +
>> +static int qpic_snand_block_erase(struct qcom_nand_controller *snandc)
>> +{
>> +	struct qpic_ecc *ecc_cfg = snandc->ecc;
>> +	int ret;
>> +
>> +	snandc->buf_count = 0;
>> +	snandc->buf_start = 0;
>> +	qcom_clear_read_regs(snandc);
>> +	qcom_clear_bam_transaction(snandc);
>> +
>> +	snandc_set_reg(snandc, NAND_FLASH_CMD, snandc->cmd);
>> +	snandc_set_reg(snandc, NAND_ADDR0, snandc->addr1);
>> +	snandc_set_reg(snandc, NAND_ADDR1, snandc->addr2);
>> +	snandc_set_reg(snandc, NAND_DEV0_CFG0, ecc_cfg->cfg0_raw & ~(7 << CW_PER_PAGE));
>> +	snandc_set_reg(snandc, NAND_DEV0_CFG1, ecc_cfg->cfg1_raw);
>> +	snandc_set_reg(snandc, NAND_EXEC_CMD, 1);
>> +
>> +	qcom_write_reg_dma(snandc, NAND_FLASH_CMD, 3, NAND_BAM_NEXT_SGL);
>> +	qcom_write_reg_dma(snandc, NAND_DEV0_CFG0, 2, NAND_BAM_NEXT_SGL);
>> +	qcom_write_reg_dma(snandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
>> +
>> +	ret = qcom_submit_descs(snandc);
>> +	if (ret) {
>> +		dev_err(snandc->dev, "failure to erase block\n");
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void config_snand_single_cw_page_read(struct qcom_nand_controller *snandc,
>> +					     bool use_ecc, int cw)
>> +{
>> +	int reg;
>> +
>> +	qcom_write_reg_dma(snandc, NAND_ADDR0, 2, 0);
>> +	qcom_write_reg_dma(snandc, NAND_DEV0_CFG0, 3, 0);
>> +	qcom_write_reg_dma(snandc, NAND_ERASED_CW_DETECT_CFG, 1, 0);
>> +	qcom_write_reg_dma(snandc, NAND_ERASED_CW_DETECT_CFG, 1,
>> +			   NAND_ERASED_CW_SET | NAND_BAM_NEXT_SGL);
>> +
>> +	reg = NAND_READ_LOCATION_0;
>> +	if (cw == 3)
> 
> This is hardcoded everywhere, I am not a big fan.
Ok will fix in next patch.
> 
>> +		reg = NAND_READ_LOCATION_LAST_CW_0;
>> +	qcom_write_reg_dma(snandc, reg, 4, NAND_BAM_NEXT_SGL);
>> +	qcom_write_reg_dma(snandc, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
>> +	qcom_write_reg_dma(snandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
>> +
>> +	qcom_read_reg_dma(snandc, NAND_FLASH_STATUS, 2, 0);
>> +	qcom_read_reg_dma(snandc, NAND_ERASED_CW_DETECT_STATUS, 1, NAND_BAM_NEXT_SGL);
>> +}
>> +
>> +static int qpic_snand_read_oob(struct qcom_nand_controller *snandc,
>> +			       const struct spi_mem_op *op)
>> +{
>> +	struct qpic_ecc *ecc_cfg = snandc->ecc;
>> +	int size, ret;
>> +	int col,  bbpos;
>> +	u32 cfg0, cfg1, ecc_bch_cfg;
>> +	u32 num_cw = snandc->num_cw;
>> +
>> +	qcom_clear_bam_transaction(snandc);
>> +	qcom_clear_read_regs(snandc);
>> +
>> +	size = ecc_cfg->cw_size;
>> +	col = ecc_cfg->cw_size * (num_cw - 1);
>> +
>> +	/* prepare a clean read buffer */
>> +	memset(snandc->data_buffer, 0xff, size);
>> +	snandc_set_reg(snandc, NAND_ADDR0, (snandc->addr1 | col));
>> +	snandc_set_reg(snandc, NAND_ADDR1, snandc->addr2);
>> +
>> +	cfg0 = (ecc_cfg->cfg0_raw & ~(7U << CW_PER_PAGE)) |
>> +		0 << CW_PER_PAGE;
>> +	cfg1 = ecc_cfg->cfg1_raw;
>> +	ecc_bch_cfg = 1 << ECC_CFG_ECC_DISABLE;
>> +
>> +	snandc_set_reg(snandc, NAND_FLASH_CMD, snandc->cmd);
>> +	snandc_set_reg(snandc, NAND_DEV0_CFG0, cfg0);
>> +	snandc_set_reg(snandc, NAND_DEV0_CFG1, cfg1);
>> +	snandc_set_reg(snandc, NAND_DEV0_ECC_CFG, ecc_bch_cfg);
>> +	snandc_set_reg(snandc, NAND_EXEC_CMD, 1);
>> +
>> +	config_snand_single_cw_page_read(snandc, false, num_cw - 1);
>> +
>> +	qcom_read_data_dma(snandc, FLASH_BUF_ACC, snandc->data_buffer, size, 0);
>> +
>> +	ret = qcom_submit_descs(snandc);
>> +	if (ret)
>> +		dev_err(snandc->dev, "failed to read oob\n");
> 
> Why don't you return here?
Ok
> 
>> +
>> +	qcom_nandc_read_buffer_sync(snandc, true);
>> +	u32 flash = le32_to_cpu(snandc->reg_read_buf[0]);
> 
> No compiler warning here?
Ok will check and fix in next patch.
> 
>> +
>> +	if (flash & (FS_OP_ERR | FS_MPU_ERR))
>> +		return -EIO;
>> +
>> +	bbpos = 2048 - ecc_cfg->cw_size * (num_cw - 1);
> 
> Why is this size hardcoded?! That cannot work!
Ok will fix in next patch.
> 
>> +	memcpy(op->data.buf.in, snandc->data_buffer + bbpos, op->data.nbytes);
>> +
>> +	return ret;
>> +}
>> +
>> +static int snandc_check_error(struct qcom_nand_controller *snandc)
>> +{
>> +	struct snandc_read_status *buf;
>> +	int i, num_cw = snandc->num_cw;
>> +	bool serial_op_err = false, erased;
>> +
>> +	qcom_nandc_read_buffer_sync(snandc, true);
>> +	buf = (struct snandc_read_status *)snandc->reg_read_buf;
>> +
>> +	for (i = 0; i < num_cw; i++, buf++) {
>> +		u32 flash, buffer, erased_cw;
>> +
>> +		flash = le32_to_cpu(buf->snandc_flash);
>> +		buffer = le32_to_cpu(buf->snandc_buffer);
>> +		erased_cw = le32_to_cpu(buf->snandc_erased_cw);
>> +
>> +		if ((flash & FS_OP_ERR) && (buffer & BS_UNCORRECTABLE_BIT)) {
>> +			erased = (erased_cw & ERASED_CW) == ERASED_CW ?
>> +				true : false;
> 
> This ternary operation is useless
Ok
> 
>> +		} else if (flash & (FS_OP_ERR | FS_MPU_ERR)) {
>> +			serial_op_err = true;
>> +		}
>> +	}
>> +
>> +	if (serial_op_err)
>> +		return -EIO;
>> +
>> +	return 0;
>> +}
>> +
>> +static int qpic_snand_read_page_cache(struct qcom_nand_controller *snandc,
>> +				      const struct spi_mem_op *op)
>> +{
>> +	struct qpic_ecc *ecc_cfg = snandc->ecc;
>> +	u8 *data_buf;
>> +	int ret, i;
>> +	u32 cfg0, cfg1, ecc_bch_cfg, num_cw = snandc->num_cw;
>> +
>> +	data_buf = op->data.buf.in;
>> +
>> +	if (snandc->oob_read) {
>> +		return qpic_snand_read_oob(snandc, op);
>> +		snandc->oob_read = false;
>> +	}
>> +
>> +	snandc->buf_count = 0;
>> +	snandc->buf_start = 0;
>> +	qcom_clear_read_regs(snandc);
>> +
>> +	cfg0 = (ecc_cfg->cfg0 & ~(7U << CW_PER_PAGE)) |
>> +				(num_cw - 1) << CW_PER_PAGE;
>> +	cfg1 = ecc_cfg->cfg1;
>> +	ecc_bch_cfg = ecc_cfg->ecc_bch_cfg;
>> +
>> +	snandc_set_reg(snandc, NAND_ADDR0, snandc->addr1);
>> +	snandc_set_reg(snandc, NAND_ADDR1, snandc->addr2);
>> +	snandc_set_reg(snandc, NAND_FLASH_CMD, snandc->cmd);
>> +	snandc_set_reg(snandc, NAND_DEV0_CFG0, cfg0);
>> +	snandc_set_reg(snandc, NAND_DEV0_CFG1, cfg1);
>> +	snandc_set_reg(snandc, NAND_DEV0_ECC_CFG, ecc_bch_cfg);
>> +	snandc_set_reg(snandc, NAND_FLASH_STATUS, ecc_cfg->clrflashstatus);
>> +	snandc_set_reg(snandc, NAND_READ_STATUS, ecc_cfg->clrreadstatus);
>> +	snandc_set_reg(snandc, NAND_EXEC_CMD, 1);
>> +	snandc_set_read_loc(snandc, 0, 0, 0, ecc_cfg->cw_data, 1);
>> +
>> +	qcom_clear_bam_transaction(snandc);
>> +
>> +	qcom_write_reg_dma(snandc, NAND_ADDR0, 2, 0);
>> +	qcom_write_reg_dma(snandc, NAND_DEV0_CFG0, 3, 0);
>> +	qcom_write_reg_dma(snandc, NAND_ERASED_CW_DETECT_CFG, 1, 0);
>> +	qcom_write_reg_dma(snandc, NAND_ERASED_CW_DETECT_CFG, 1,
>> +			   NAND_ERASED_CW_SET | NAND_BAM_NEXT_SGL);
>> +
>> +	for (i = 0; i < num_cw; i++) {
>> +		int data_size;
>> +
>> +		if (i == (num_cw - 1))
>> +			data_size = 512 - ((num_cw - 1) << 2);
>> +		else
>> +			data_size = ecc_cfg->cw_data;
>> +
>> +		if (data_buf)
>> +			snandc_set_read_loc(snandc, i, 0, 0, data_size, 1);
>> +
>> +		snandc_config_cw_read(snandc, true, i);
>> +
>> +		if (data_buf)
>> +			qcom_read_data_dma(snandc, FLASH_BUF_ACC, data_buf,
>> +					   data_size, 0);
>> +
>> +		if (data_buf)
>> +			data_buf += data_size;
>> +	}
>> +
>> +	ret = qcom_submit_descs(snandc);
>> +	if (ret) {
>> +		dev_err(snandc->dev, "failure to read page/oob\n");
>> +		return ret;
>> +	}
>> +
>> +	return snandc_check_error(snandc);
>> +}
>> +
>> +static void config_snand_page_write(struct qcom_nand_controller *snandc)
>> +{
>> +	qcom_write_reg_dma(snandc, NAND_ADDR0, 2, 0);
>> +	qcom_write_reg_dma(snandc, NAND_DEV0_CFG0, 3, 0);
>> +	qcom_write_reg_dma(snandc, NAND_EBI2_ECC_BUF_CFG, 1, NAND_BAM_NEXT_SGL);
>> +}
>> +
>> +static void config_snand_cw_write(struct qcom_nand_controller *snandc)
>> +{
>> +	qcom_write_reg_dma(snandc, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
>> +	qcom_write_reg_dma(snandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
>> +}
>> +
>> +static int qpic_snand_program_execute(struct qcom_nand_controller *snandc,
>> +				      const struct spi_mem_op *op)
>> +{
>> +	struct qpic_ecc *ecc_cfg = snandc->ecc;
>> +	u8 *data_buf;
>> +	int i, ret;
>> +	int num_cw = snandc->num_cw;
>> +	u32 cfg0, cfg1, ecc_bch_cfg, ecc_buf_cfg;
>> +
>> +	cfg0 = (ecc_cfg->cfg0 & ~(7U << CW_PER_PAGE)) |
>> +				(num_cw - 1) << CW_PER_PAGE;
>> +	cfg1 = ecc_cfg->cfg1;
>> +	ecc_bch_cfg = ecc_cfg->ecc_bch_cfg;
>> +	ecc_buf_cfg = ecc_cfg->ecc_buf_cfg;
>> +
>> +	data_buf = snandc->wbuf;
>> +
>> +	snandc->buf_count = 0;
>> +	snandc->buf_start = 0;
>> +	qcom_clear_read_regs(snandc);
>> +	qcom_clear_bam_transaction(snandc);
>> +
>> +	snandc_set_reg(snandc, NAND_ADDR0, snandc->addr1);
>> +	snandc_set_reg(snandc, NAND_ADDR1, snandc->addr2);
>> +	snandc_set_reg(snandc, NAND_FLASH_CMD, snandc->cmd);
>> +
>> +	snandc_set_reg(snandc, NAND_DEV0_CFG0, cfg0);
>> +	snandc_set_reg(snandc, NAND_DEV0_CFG1, cfg1);
>> +	snandc_set_reg(snandc, NAND_DEV0_ECC_CFG, ecc_bch_cfg);
>> +
>> +	snandc_set_reg(snandc, NAND_EBI2_ECC_BUF_CFG, ecc_buf_cfg);
>> +
>> +	snandc_set_reg(snandc, NAND_EXEC_CMD, 1);
>> +
>> +	config_snand_page_write(snandc);
>> +
>> +	for (i = 0; i < num_cw; i++) {
>> +		int data_size;
>> +
>> +		if (i == (num_cw - 1))
>> +			data_size = NANDC_STEP_SIZE - ((num_cw - 1) << 2);
>> +		else
>> +			data_size = ecc_cfg->cw_data;
>> +
>> +		qcom_write_data_dma(snandc, FLASH_BUF_ACC, data_buf, data_size,
>> +				    i == (num_cw - 1) ? NAND_BAM_NO_EOT : 0);
>> +
>> +		config_snand_cw_write(snandc);
>> +		if (data_buf)
>> +			data_buf += data_size;
>> +	}
>> +
>> +	ret = qcom_submit_descs(snandc);
>> +	if (ret) {
>> +		dev_err(snandc->dev, "failure to write page\n");
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static u32 qpic_snand_cmd_mapping(struct qcom_nand_controller *snandc, u32 opcode)
>> +{
>> +	u32 cmd = 0x0;
>> +
>> +	switch (opcode) {
>> +	case SPINAND_RESET:
>> +		cmd = (SPI_WP | SPI_HOLD | SPI_TRANSFER_MODE_x1 | OP_RESET_DEVICE);
>> +		break;
>> +	case SPINAND_READID:
>> +		cmd = (SPI_WP | SPI_HOLD | SPI_TRANSFER_MODE_x1 | OP_FETCH_ID);
>> +		break;
>> +	case SPINAND_GET_FEATURE:
>> +		cmd = (SPI_TRANSFER_MODE_x1 | SPI_WP | SPI_HOLD | ACC_FEATURE);
>> +		break;
>> +	case SPINAND_SET_FEATURE:
>> +		cmd = (SPI_TRANSFER_MODE_x1 | SPI_WP | SPI_HOLD | ACC_FEATURE |
>> +			QPIC_SET_FEATURE);
>> +		break;
>> +	case SPINAND_READ:
>> +		if (snandc->raw)
>> +			cmd = (PAGE_ACC | LAST_PAGE | SPI_TRANSFER_MODE_x1 |
>> +					SPI_WP | SPI_HOLD | OP_PAGE_READ);
>> +		else
>> +			cmd = (PAGE_ACC | LAST_PAGE | SPI_TRANSFER_MODE_x1 |
>> +					SPI_WP | SPI_HOLD | OP_PAGE_READ_WITH_ECC);
>> +		break;
>> +	case SPINAND_ERASE:
>> +		cmd = OP_BLOCK_ERASE | PAGE_ACC | LAST_PAGE | SPI_WP |
>> +			SPI_HOLD | SPI_TRANSFER_MODE_x1;
>> +		break;
>> +	case SPINAND_WRITE_EN:
>> +		cmd = SPINAND_WRITE_EN;
>> +		break;
>> +	case SPINAND_PROGRAM_EXECUTE:
>> +		cmd = (PAGE_ACC | LAST_PAGE | SPI_TRANSFER_MODE_x1 |
>> +				SPI_WP | SPI_HOLD | OP_PROGRAM_PAGE);
>> +		break;
>> +	case SPINAND_PROGRAM_LOAD:
>> +		cmd = SPINAND_PROGRAM_LOAD;
>> +		break;
>> +	default:
>> +		break;
> 
> No, no, no and no again. You've been sending NAND contributions for
> years, and you still continue to assume all the commands are defined
> and we will never check for supported ops. Please.
Sorry, I missed that check for unsupported command. Will fix in next patch.
> 
>> +	}
>> +
>> +	return cmd;
>> +}
>> +
>> +static int qpic_snand_write_page_cache(struct qcom_nand_controller *snandc,
>> +				       const struct spi_mem_op *op)
>> +{
>> +	struct qpic_snand_op s_op = {};
>> +	u32 cmd;
>> +
>> +	cmd = qpic_snand_cmd_mapping(snandc, op->cmd.opcode);
>> +	s_op.cmd_reg = cmd;
>> +
>> +	if (op->cmd.opcode == SPINAND_PROGRAM_LOAD) {
>> +		snandc->wbuf = (u8 *)op->data.buf.out;
>> +		snandc->wlen = op->data.nbytes;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int qpic_snand_send_cmdaddr(struct qcom_nand_controller *snandc,
>> +				   const struct spi_mem_op *op)
>> +{
>> +	struct qpic_snand_op s_op = {};
>> +	u32 cmd;
>> +	int ret;
>> +
>> +	cmd = qpic_snand_cmd_mapping(snandc, op->cmd.opcode);
>> +
>> +	s_op.cmd_reg = cmd;
>> +	s_op.addr1_reg = op->addr.val;
>> +	s_op.addr2_reg = 0;
>> +
> Would a switch case be more appropriate?
Ok
> 
>> +	if (op->cmd.opcode == SPINAND_WRITE_EN)
>> +		return 0;
>> +
>> +	if (op->cmd.opcode == SPINAND_PROGRAM_EXECUTE) {
>> +		s_op.addr1_reg = op->addr.val << 16;
>> +		s_op.addr2_reg = op->addr.val >> 16 & 0xff;
>> +		snandc->addr1 = s_op.addr1_reg;
>> +		snandc->addr2 = s_op.addr2_reg;
>> +		snandc->cmd = cmd;
>> +		return qpic_snand_program_execute(snandc, op);
>> +	}
>> +
>> +	if (op->cmd.opcode == SPINAND_READ) {
>> +		s_op.addr1_reg = (op->addr.val << 16);
>> +		s_op.addr2_reg = op->addr.val >> 16 & 0xff;
>> +		snandc->addr1 = s_op.addr1_reg;
>> +		snandc->addr2 = s_op.addr2_reg;
>> +		snandc->cmd = cmd;
>> +		return 0;
>> +	}
>> +
>> +	if (op->cmd.opcode == SPINAND_ERASE) {
>> +		s_op.addr2_reg = (op->addr.val >> 16) & 0xffff;
>> +		s_op.addr1_reg = op->addr.val;
>> +		snandc->addr1 = s_op.addr1_reg;
>> +		snandc->addr1 <<= 16;
>> +		snandc->addr2 = s_op.addr2_reg;
>> +		snandc->cmd = cmd;
>> +		qpic_snand_block_erase(snandc);
>> +		return 0;
>> +	}
>> +
>> +	snandc->buf_count = 0;
>> +	snandc->buf_start = 0;
>> +	qcom_clear_read_regs(snandc);
>> +	qcom_clear_bam_transaction(snandc);
>> +
>> +	snandc_set_reg(snandc, NAND_FLASH_CMD, s_op.cmd_reg);
>> +	snandc_set_reg(snandc, NAND_EXEC_CMD, 0x1);
>> +	snandc_set_reg(snandc, NAND_ADDR0, s_op.addr1_reg);
>> +	snandc_set_reg(snandc, NAND_ADDR1, s_op.addr2_reg);
>> +
>> +	qcom_write_reg_dma(snandc, NAND_FLASH_CMD, 3, NAND_BAM_NEXT_SGL);
>> +	qcom_write_reg_dma(snandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
>> +
>> +	ret = qcom_submit_descs(snandc);
>> +	if (ret)
>> +		dev_err(snandc->dev, "failure in sbumitting cmd descriptor\n");
>> +
>> +	return ret;
>> +}
>> +
>> +static int qpic_snand_io_op(struct qcom_nand_controller *snandc, const struct spi_mem_op *op)
>> +{
>> +	int ret, val, opcode;
>> +	bool copy = false, copy_ftr = false;
>> +
>> +	ret = qpic_snand_send_cmdaddr(snandc, op);
>> +	if (ret)
>> +		return ret;
>> +
>> +	snandc->buf_count = 0;
>> +	snandc->buf_start = 0;
>> +	qcom_clear_read_regs(snandc);
>> +	qcom_clear_bam_transaction(snandc);
>> +	opcode = op->cmd.opcode;
>> +
>> +	switch (opcode) {
>> +	case SPINAND_READID:
>> +		snandc->buf_count = 4;
>> +		qcom_read_reg_dma(snandc, NAND_READ_ID, 1, NAND_BAM_NEXT_SGL);
>> +		copy = true;
>> +		break;
>> +	case SPINAND_GET_FEATURE:
>> +		snandc->buf_count = 4;
>> +		qcom_read_reg_dma(snandc, NAND_FLASH_FEATURES, 1, NAND_BAM_NEXT_SGL);
>> +		copy_ftr = true;
>> +		break;
>> +	case SPINAND_SET_FEATURE:
>> +		snandc_set_reg(snandc, NAND_FLASH_FEATURES, *(u32 *)op->data.buf.out);
>> +		qcom_write_reg_dma(snandc, NAND_FLASH_FEATURES, 1, NAND_BAM_NEXT_SGL);
>> +		break;
>> +	default:
>> +		return 0;
>> +	}
>> +
>> +	ret = qcom_submit_descs(snandc);
>> +	if (ret)
>> +		dev_err(snandc->dev, "failure in submitting descriptor for:%d\n", opcode);
>> +
>> +	if (copy) {
>> +		qcom_nandc_read_buffer_sync(snandc, true);
>> +		memcpy(op->data.buf.in, snandc->reg_read_buf, snandc->buf_count);
>> +	}
>> +
>> +	if (copy_ftr) {
>> +		qcom_nandc_read_buffer_sync(snandc, true);
>> +		val = le32_to_cpu(*(__le32 *)snandc->reg_read_buf);
>> +		val >>= 8;
>> +		memcpy(op->data.buf.in, &val, snandc->buf_count);
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static bool qpic_snand_is_page_op(const struct spi_mem_op *op)
>> +{
>> +	if (op->addr.buswidth != 1 && op->addr.buswidth != 2 && op->addr.buswidth != 4)
>> +		return false;
>> +
>> +	if (op->data.dir == SPI_MEM_DATA_IN) {
>> +		if (op->addr.buswidth == 4 && op->data.buswidth == 4)
>> +			return true;
>> +
>> +		if (op->addr.nbytes == 2 && op->addr.buswidth == 1)
>> +			return true;
>> +
>> +	} else if (op->data.dir == SPI_MEM_DATA_OUT) {
>> +		if (op->data.buswidth == 4)
>> +			return true;
>> +		if (op->addr.nbytes == 2 && op->addr.buswidth == 1)
>> +			return true;
>> +	}
>> +
>> +	return false;
>> +}
>> +
>> +static bool qpic_snand_supports_op(struct spi_mem *mem, const struct spi_mem_op *op)
>> +{
>> +	if (!spi_mem_default_supports_op(mem, op))
>> +		return false;
>> +
>> +	if (op->cmd.nbytes != 1 || op->cmd.buswidth != 1)
>> +		return false;
>> +
>> +	if (qpic_snand_is_page_op(op))
>> +		return true;
>> +
>> +	return ((op->addr.nbytes == 0 || op->addr.buswidth == 1) &&
> 
> 		!op->addr.nbytes and so on
Ok
> 
>> +		(op->dummy.nbytes == 0 || op->dummy.buswidth == 1) &&
>> +		(op->data.nbytes == 0 || op->data.buswidth == 1));
>> +}
>> +
>> +static int qpic_snand_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>> +{
>> +	struct qcom_nand_controller *snandc = spi_controller_get_devdata(mem->spi->controller);
>> +
>> +	dev_dbg(snandc->dev, "OP %02x ADDR %08llX@%d:%u DATA %d:%u", op->cmd.opcode,
>> +		op->addr.val, op->addr.buswidth, op->addr.nbytes,
>> +		op->data.buswidth, op->data.nbytes);
>> +
>> +	if (qpic_snand_is_page_op(op)) {
>> +		if (op->data.dir == SPI_MEM_DATA_IN)
>> +			return qpic_snand_read_page_cache(snandc, op);
>> +		if (op->data.dir == SPI_MEM_DATA_OUT)
>> +			return qpic_snand_write_page_cache(snandc, op);
>> +	} else {
>> +		return qpic_snand_io_op(snandc, op);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct spi_controller_mem_ops qcom_spi_mem_ops = {
>> +	.supports_op = qpic_snand_supports_op,
>> +	.exec_op = qpic_snand_exec_op,
>> +};
>> +
>> +static const struct spi_controller_mem_caps qcom_snand_mem_caps = {
>> +	.ecc = true,
>> +};
>> +
>> +static int qcom_snand_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct spi_controller *ctlr;
>> +	struct qcom_nand_controller *snandc;
>> +	struct resource *res;
>> +	const void *dev_data;
>> +	struct qpic_ecc *ecc;
>> +	int ret;
>> +
>> +	ecc = devm_kzalloc(dev, sizeof(*ecc), GFP_KERNEL);
>> +	if (!ecc)
>> +		return -ENOMEM;
>> +
>> +	ctlr = __devm_spi_alloc_controller(dev, sizeof(*snandc), false);
> 
> I don't know if that is legitimate, why using __devm?
This one I have added as per Mark's comment.
> 
>> +	if (!ctlr)
>> +		return -ENOMEM;
>> +
>> +	platform_set_drvdata(pdev, ctlr);
>> +
>> +	snandc = spi_controller_get_devdata(ctlr);
>> +
>> +	snandc->ctlr = ctlr;
>> +	snandc->dev = dev;
>> +	snandc->ecc = ecc;
>> +
>> +	dev_data = of_device_get_match_data(dev);
>> +	if (!dev_data) {
>> +		dev_err(&pdev->dev, "failed to get device data\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	snandc->props = dev_data;
>> +	snandc->dev = &pdev->dev;
>> +
>> +	snandc->core_clk = devm_clk_get(dev, "core");
>> +	if (IS_ERR(snandc->core_clk))
>> +		return PTR_ERR(snandc->core_clk);
>> +
>> +	snandc->aon_clk = devm_clk_get(dev, "aon");
>> +	if (IS_ERR(snandc->aon_clk))
>> +		return PTR_ERR(snandc->aon_clk);
>> +
>> +	snandc->iomacro_clk = devm_clk_get(dev, "iom");
>> +	if (IS_ERR(snandc->iomacro_clk))
>> +		return PTR_ERR(snandc->iomacro_clk);
>> +
>> +	snandc->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>> +	if (IS_ERR(snandc->base))
>> +		return PTR_ERR(snandc->base);
>> +
>> +	snandc->base_phys = res->start;
>> +	snandc->base_dma = dma_map_resource(dev, res->start, resource_size(res),
>> +					    DMA_BIDIRECTIONAL, 0);
>> +	if (dma_mapping_error(dev, snandc->base_dma))
>> +		return -ENXIO;
>> +
>> +	ret = clk_prepare_enable(snandc->core_clk);
>> +	if (ret)
>> +		goto err_core_clk;
>> +
>> +	ret = clk_prepare_enable(snandc->aon_clk);
>> +	if (ret)
>> +		goto err_aon_clk;
>> +
>> +	ret = clk_prepare_enable(snandc->iomacro_clk);
>> +	if (ret)
>> +		goto err_snandc_alloc;
>> +
>> +	ret = qcom_nandc_alloc(snandc);
>> +	if (ret)
>> +		goto err_snandc_alloc;
>> +
>> +	ret = qcom_snand_init(snandc);
>> +	if (ret)
>> +		goto err_init;
>> +
>> +	/* setup ECC engine */
>> +	snandc->ecc_eng.dev = &pdev->dev;
>> +	snandc->ecc_eng.integration = NAND_ECC_ENGINE_INTEGRATION_PIPELINED;
>> +	snandc->ecc_eng.ops = &qcom_snand_ecc_engine_ops_pipelined;
>> +	snandc->ecc_eng.priv = snandc;
>> +
>> +	ret = nand_ecc_register_on_host_hw_engine(&snandc->ecc_eng);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "failed to register ecc engine.\n");
>> +		goto err_init;
>> +	}
>> +
>> +	ctlr->num_chipselect = QPIC_QSPI_NUM_CS;
>> +	ctlr->mem_ops = &qcom_spi_mem_ops;
>> +	ctlr->mem_caps = &qcom_snand_mem_caps;
>> +	ctlr->dev.of_node = pdev->dev.of_node;
>> +	ctlr->mode_bits = SPI_TX_DUAL | SPI_RX_DUAL |
>> +			    SPI_TX_QUAD | SPI_RX_QUAD;
>> +
>> +	ret = spi_register_controller(ctlr);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "spi_register_controller failed.\n");
>> +		goto err_init;
>> +	}
>> +
>> +	return 0;
>> +
>> +err_init:
>> +	qcom_nandc_unalloc(snandc);
>> +err_snandc_alloc:
>> +	clk_disable_unprepare(snandc->aon_clk);
>> +err_aon_clk:
>> +	clk_disable_unprepare(snandc->core_clk);
> 
> Don't you miss one clock ?
Ok will fix in next patch
> 
>> +err_core_clk:
>> +	dma_unmap_resource(dev, res->start, resource_size(res),
>> +			   DMA_BIDIRECTIONAL, 0);
>> +	return ret;
>> +}
>> +
>> +static int qcom_snand_remove(struct platform_device *pdev)
>> +{
>> +	struct spi_controller *ctlr = platform_get_drvdata(pdev);
>> +	struct qcom_nand_controller *snandc = spi_controller_get_devdata(ctlr);
>> +	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +
>> +	spi_unregister_controller(ctlr);
>> +
>> +	clk_disable_unprepare(snandc->aon_clk);
>> +	clk_disable_unprepare(snandc->core_clk);
>> +	clk_disable_unprepare(snandc->iomacro_clk);
>> +
>> +	dma_unmap_resource(&pdev->dev, snandc->base_dma, resource_size(res),
>> +			   DMA_BIDIRECTIONAL, 0);
>> +	return 0;
>> +}
>> +
>> +static const struct qcom_nandc_props ipq9574_snandc_props = {
>> +	.dev_cmd_reg_start = 0x7000,
>> +	.is_bam = true,
> 
> Same comment about "is_bam"
Ok
> 
>> +};
>> +
>> +static const struct of_device_id qcom_snandc_of_match[] = {
>> +	{
>> +		.compatible = "qcom,spi-qpic-snand",
>> +		.data = &ipq9574_snandc_props,
>> +	},
>> +	{}
>> +}
>> +MODULE_DEVICE_TABLE(of, qcom_snandc_of_match);
>> +
>> +static struct platform_driver qcom_snand_driver = {
>> +	.driver = {
>> +		.name		= "qcom_snand",
>> +		.of_match_table = qcom_snandc_of_match,
>> +	},
>> +	.probe = qcom_snand_probe,
>> +	.remove = qcom_snand_remove,
>> +};
>> +module_platform_driver(qcom_snand_driver);
>> +
>> +MODULE_DESCRIPTION("SPI driver for QPIC QSPI cores");
>> +MODULE_AUTHOR("Md Sadre Alam <quic_mdalam@quicinc.com>");
>> +MODULE_LICENSE("GPL");
>> diff --git a/include/linux/mtd/nand-qpic-common.h b/include/linux/mtd/nand-qpic-common.h
>> index aced15866627..4673cd36ff0a 100644
>> --- a/include/linux/mtd/nand-qpic-common.h
>> +++ b/include/linux/mtd/nand-qpic-common.h
>> @@ -45,6 +45,9 @@
>>   #define	NAND_DEV_CMD1			0xa4
>>   #define	NAND_DEV_CMD2			0xa8
>>   #define	NAND_DEV_CMD_VLD		0xac
>> +#define NAND_FLASH_SPI_CFG              0xc0
>> +#define NAND_NUM_ADDR_CYCLES            0xc4
>> +#define NAND_BUSY_CHECK_WAIT_CNT        0xc8
> 
> If this is specific to the spi-nand implementation, then it's not
> common and has no reason to be shared here. Same for the other
> definitions of course.
Ok
> 
>>   #define	SFLASHC_BURST_CFG		0xe0
>>   #define	NAND_ERASED_CW_DETECT_CFG	0xe8
>>   #define	NAND_ERASED_CW_DETECT_STATUS	0xec
>> @@ -61,6 +64,7 @@
>>   #define	NAND_READ_LOCATION_LAST_CW_1	0xf44
>>   #define	NAND_READ_LOCATION_LAST_CW_2	0xf48
>>   #define	NAND_READ_LOCATION_LAST_CW_3	0xf4c
>> +#define NAND_FLASH_FEATURES             0xf64
>>   
>>   /* dummy register offsets, used by write_reg_dma */
>>   #define	NAND_DEV_CMD1_RESTORE		0xdead
>> @@ -169,6 +173,7 @@
>>   #define	OP_CHECK_STATUS			0xc
>>   #define	OP_FETCH_ID			0xb
>>   #define	OP_RESET_DEVICE			0xd
>> +#define ACC_FEATURE                     0xe
>>   
>>   /* Default Value for NAND_DEV_CMD_VLD */
>>   #define NAND_DEV_CMD_VLD_VAL		(READ_START_VLD | WRITE_START_VLD | \
>> @@ -329,11 +334,53 @@ struct nandc_regs {
>>   	__le32 read_location_last1;
>>   	__le32 read_location_last2;
>>   	__le32 read_location_last3;
>> +	__le32 spi_cfg;
>> +	__le32 num_addr_cycle;
>> +	__le32 busy_wait_cnt;
>> +	__le32 flash_feature;
>>   
>>   	__le32 erased_cw_detect_cfg_clr;
>>   	__le32 erased_cw_detect_cfg_set;
>>   };
>>   
>> +struct qcom_ecc_stats {
>> +	u32 corrected;
>> +	u32 bitflips;
>> +	u32 failed;
>> +};
>> +
>> +/*
>> + * QPIC ECC data struct
>> + *
>> + */
>> +struct qpic_ecc {
>> +	struct device *dev;
>> +	const struct qpic_ecc_caps *caps;
>> +	struct completion done;
>> +	u32 sectors;
>> +	u8 *eccdata;
>> +	bool use_ecc;
>> +	u32 ecc_modes;
>> +	int ecc_bytes_hw;
>> +	int spare_bytes;
>> +	int bbm_size;
>> +	int ecc_mode;
>> +	int bytes;
>> +	int steps;
>> +	int step_size;
>> +	int strength;
>> +	int cw_size;
>> +	int cw_data;
>> +	u32 cfg0, cfg1;
>> +	u32 cfg0_raw, cfg1_raw;
>> +	u32 ecc_buf_cfg;
>> +	u32 ecc_bch_cfg;
>> +	u32 clrflashstatus;
>> +	u32 clrreadstatus;
>> +	bool bch_enabled;
>> +};
>> +
>> +struct qpic_ecc;
>>   /*
>>    * NAND controller data struct
>>    *
>> @@ -352,6 +399,7 @@ struct nandc_regs {
>>    *				initialized via DT match data
>>    *
>>    * @controller:			base controller structure
>> + * @ctlr:			spi controller structure
>>    * @host_list:			list containing all the chips attached to the
>>    *				controller
>>    *
>> @@ -389,6 +437,7 @@ struct qcom_nand_controller {
>>   
>>   	struct clk *core_clk;
>>   	struct clk *aon_clk;
>> +	struct clk *iomacro_clk;
>>   
>>   	struct nandc_regs *regs;
>>   	struct bam_transaction *bam_txn;
>> @@ -396,6 +445,7 @@ struct qcom_nand_controller {
>>   	const struct qcom_nandc_props *props;
>>   
>>   	struct nand_controller controller;
>> +	struct spi_controller *ctlr;
>>   	struct list_head host_list;
>>   
>>   	union {
>> @@ -432,6 +482,17 @@ struct qcom_nand_controller {
>>   
>>   	u32 cmd1, vld;
>>   	bool exec_opwrite;
>> +	struct qpic_ecc *ecc;
>> +	struct qcom_ecc_stats ecc_stats;
>> +	struct nand_ecc_engine ecc_eng;
>> +	u8 *wbuf;
>> +	u32 wlen;
>> +	u32 addr1;
>> +	u32 addr2;
>> +	u32 cmd;
>> +	u32 num_cw;
>> +	bool oob_read;
>> +	bool raw;
>>   };
>>   
>>   /*
> 
> 
> Thanks,
> Miquèl

Thanks for reviewing. Will address all the comments in next patch series.

Regards,
Alam.


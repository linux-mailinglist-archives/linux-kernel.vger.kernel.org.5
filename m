Return-Path: <linux-kernel+bounces-73284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4338D85C079
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED9D1286552
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6C076414;
	Tue, 20 Feb 2024 15:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XP6JX63Y"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755CB763EC;
	Tue, 20 Feb 2024 15:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708444768; cv=none; b=Fcf6Q4l1CaP6UgC4dh4ZnNHlpcBtKAjX58Ec89qaI0vaXoNcmIuOhbQ+ggyQoqvxPohiNySIAfKWMqYn1Ebl0qSZjgRkAkIxIZhnwyv8SyepPNhS4cc+eN9cKbW/mEvJqf3BQuFMRAP5IStKckUIJrFaL0w56MhJ+83810YDucw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708444768; c=relaxed/simple;
	bh=VGRYKOSBguErc95ypfUW+9IJizPyQG1Rzc0ji5xfoOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GwPDy1F3yuyxgQN9uTjiW2tj79BOYrnVnpfz9dlWq1oPBLaC/fQg8PAXINzpv22SnCRIGZC4NUAAVElsdAX6DUOVejv6T0PaOa/wEWwlEBgAbwcrwhksn5OmlkmeLZyEuT7n0OydLWAWbhgNeakaIUoPVdO6bZb/A4qS9fAU4K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XP6JX63Y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41KDKli3028318;
	Tue, 20 Feb 2024 15:59:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=H2A5nEQv/c3Fyh0YVw/e60by9kIO90zySmN6RGdj+kc=; b=XP
	6JX63Yk1jylyJv+jlebJA1mmfV0JNGVHnhX5XdtgYYi6vD3YUjH/qAE7EfpSr97B
	p7cMQ8ph2+lh83uplFnC551xF+Gj9FmuNhJM92hd7Iao32QD1nnWp9APEcv1QdVp
	T6iRnmsJ5olvyOiYkW0Ds4VfzBRagpPIDSU3FAACijYJrhrOz9E8I12HurTIi6ev
	bakXUcDEZSGGlI8WqRG/yP4SBaAOBEqz4KwQxIgVrz54wy9pExaKxlNiZkU+Am9d
	scTCozbYkTzMvYo2GXjOimX1rITtCk9SZXo44S3gZEzxst4j/x2aFtW2/058xz+Y
	07NOMMOM0kMtR6SnEPPQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wckv9hfnm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 15:59:13 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41KFxCxo012576
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 15:59:12 GMT
Received: from [10.216.62.93] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 20 Feb
 2024 07:59:06 -0800
Message-ID: <c574c9ab-0a47-2dc8-9ddd-c08f1b770d7e@quicinc.com>
Date: Tue, 20 Feb 2024 21:29:02 +0530
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
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <broonie@kernel.org>,
        <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <manivannan.sadhasivam@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.com>
References: <20240215134856.1313239-1-quic_mdalam@quicinc.com>
 <20240215134856.1313239-3-quic_mdalam@quicinc.com>
 <CAA8EJpquDwDg+OrZKeJrTWEtokCF7uyHMyzCFK2etSsDip8_6Q@mail.gmail.com>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <CAA8EJpquDwDg+OrZKeJrTWEtokCF7uyHMyzCFK2etSsDip8_6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CLrCNi8m5_y6P4aBEsELsofA4hW3EPi0
X-Proofpoint-GUID: CLrCNi8m5_y6P4aBEsELsofA4hW3EPi0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
 mlxlogscore=999 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402200114



On 2/15/2024 8:30 PM, Dmitry Baryshkov wrote:
> On Thu, 15 Feb 2024 at 15:53, Md Sadre Alam <quic_mdalam@quicinc.com> wrote:
>>
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
>> + * Authors:    Md sadre Alam           <quic_mdalam@quicinc.com>
>> + *             Sricharan R             <quic_srichara@quicinc.com>
>> + *             Varadarajan Narayanan   <quic_varada@quicinc.com>
> 
> This is a bit of an exaggeration. You are moving code, not writing new
> code. Please retain the existing copyrights for the moved code.
Ok
> 
>> + *
>> + */
>> +
>> +#include <linux/mtd/nand-qpic-common.h>
>> +
>> +struct qcom_nand_controller *
>> +get_qcom_nand_controller(struct nand_chip *chip)
>> +{
>> +       return container_of(chip->controller, struct qcom_nand_controller,
>> +                           controller);
>> +}
>> +EXPORT_SYMBOL(get_qcom_nand_controller);
> 
> NAK for adding functions to the global export namespace without a
> proper driver-specific prefix.
Ok, will fix in next patch
> 
> Also, a bunch of the code here seems not so well thought. It was fine
> for an internal interface, but it doesn't look so good as a common
> wrapper. Please consider defining a sensible common code module
> interface instead.

  QPIC controller will support both raw NAND as well Serial nand interface.
  This common API file was the part of raw NAND driver , since for serial
  nand most of the APIs from raw nand driver will be re-used that's why i
  have created this common API file, so that QPIC serial nand driver
  drivers/spi/spi-qpic-snand.c and QPIC raw NAND driver
  drivers/mtd/nand/raw/qcom_nandc.c can used these common APIs.

  Could you please suggest how I should handle this in batter way.
> 
> At least each function that is being exported should get a kerneldoc.
Ok
> 
> Last, but not least, please use EXPORT_SYMBOL_GPL.
Ok
> 
>> +
>> +/*
>> + * Helper to prepare DMA descriptors for configuring registers
>> + * before reading a NAND page.
>> + */
>> +void config_nand_page_read(struct nand_chip *chip)
>> +{
>> +       struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>> +
>> +       write_reg_dma(nandc, NAND_ADDR0, 2, 0);
>> +       write_reg_dma(nandc, NAND_DEV0_CFG0, 3, 0);
>> +       if (!nandc->props->qpic_v2)
>> +               write_reg_dma(nandc, NAND_EBI2_ECC_BUF_CFG, 1, 0);
>> +       write_reg_dma(nandc, NAND_ERASED_CW_DETECT_CFG, 1, 0);
>> +       write_reg_dma(nandc, NAND_ERASED_CW_DETECT_CFG, 1,
>> +                     NAND_ERASED_CW_SET | NAND_BAM_NEXT_SGL);
>> +}
>> +EXPORT_SYMBOL(config_nand_page_read);
>> +
>> +/* Frees the BAM transaction memory */
>> +void free_bam_transaction(struct qcom_nand_controller *nandc)
>> +{
>> +       struct bam_transaction *bam_txn = nandc->bam_txn;
>> +
>> +       devm_kfree(nandc->dev, bam_txn);
> 
> devm_kfree is usually a bad sign. Either the devm_kfree should be
> dropped (because the memory area is allocated only during probe / init
> and doesn't need to be freed manually) or use kalloc/kfree directly
> without devres wrapping.
Ok
> 
>> +}
>> +EXPORT_SYMBOL(free_bam_transaction);
>> +
> 
> [skipped the rest]
> 
>> --
>> 2.34.1
>>
>>
> 
> 
> --
> With best wishes
> Dmitry

Thanks for reviewing, Will fix all the comments in next patch.

Regards,
Alam.


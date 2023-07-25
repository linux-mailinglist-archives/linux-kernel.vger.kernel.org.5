Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161D9760A29
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 08:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjGYGRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 02:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjGYGRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 02:17:15 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716E01BDF;
        Mon, 24 Jul 2023 23:17:03 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36P4be0J027946;
        Tue, 25 Jul 2023 06:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=n6JgH6hUhaB3z0C6eEaljtHhU3aiyhPLQf678kU94cc=;
 b=Zqcn3yH/kPfjlKBJ5HKinPyfw8+lwqfop/82xfcYUSlzkMxQtZQlZ7si1hl3n9AnXVso
 JQ/EFXr8LfM8ex9g4YaZhTQraB906HBNyN4w4bwnQ3XoMfrPej+zYSxJZPbG99kngeQs
 nFkQzD6r0GMzf9LgOdfkCWrr0JeoysDG1A6dQdctKQTW31jrW+yWw97RubCwUPKn0h6f
 SOiYwAcxzjrlpREuuiP8Lr1gqHd/huVlqs5jxCCKchBAhjFTdC1v1JOudXpYq/WsG+8Q
 ohRMZvNG9ZbQzIkhnhv7NwkVcN/Oy7SuaPQWz8fyMlHVZx5369wMbf9GjWgmf9hseMhU Hg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s1qcyt727-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 06:16:56 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36P6Gt53011846
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 06:16:55 GMT
Received: from [10.239.154.73] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 24 Jul
 2023 23:16:51 -0700
Message-ID: <053c9571-d709-2826-fced-a00dd7255b8b@quicinc.com>
Date:   Tue, 25 Jul 2023 14:16:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/3] input: pm8xxx-vib: refactor to easily support new
 SPMI vibrator
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        <linux-input@vger.kernel.org>
CC:     <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        <quic_kamalw@quicinc.com>, <jestar@qti.qualcomm.com>
References: <20230725054138.129497-1-quic_fenglinw@quicinc.com>
 <20230725054138.129497-2-quic_fenglinw@quicinc.com>
 <5dd56c31-7ca3-dd39-0623-e4fd18ac6f68@linaro.org>
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
In-Reply-To: <5dd56c31-7ca3-dd39-0623-e4fd18ac6f68@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lateENNR6DsHbhOzU7SJl_FEoXoednAk
X-Proofpoint-GUID: lateENNR6DsHbhOzU7SJl_FEoXoednAk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_02,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=913 clxscore=1015 mlxscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307250056
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/25/2023 1:52 PM, Krzysztof Kozlowski wrote:
> On 25/07/2023 07:41, Fenglin Wu wrote:
>> Currently, all vibrator control register addresses are hard coded,
>> including the base address and the offset, it's not flexible to support
>> new SPMI vibrator module which is usually included in different PMICs
>> with different base address. Refactor this by introducing the HW type
>> terminology and contain the register offsets/masks/shifts in reg_filed
>> data structures corresponding to each vibrator type, and the base address
>> value defined in 'reg' property will be added for SPMI vibrators.
>>
>> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
>> ---
>>   drivers/input/misc/pm8xxx-vibrator.c | 130 ++++++++++++++++-----------
>>   1 file changed, 77 insertions(+), 53 deletions(-)
>>
>> diff --git a/drivers/input/misc/pm8xxx-vibrator.c b/drivers/input/misc/pm8xxx-vibrator.c
>> index 04cb87efd799..77bb0018d4e1 100644
>> --- a/drivers/input/misc/pm8xxx-vibrator.c
>> +++ b/drivers/input/misc/pm8xxx-vibrator.c
>> @@ -12,36 +12,36 @@
>>   #include <linux/regmap.h>
>>   #include <linux/slab.h>
>>   
>> +#define SSBI_VIB_DRV_EN_MANUAL_MASK	0xfc
>> +#define SSBI_VIB_DRV_LEVEL_MASK		0xf8
>> +#define SSBI_VIB_DRV_SHIFT		3
>> +#define SPMI_VIB_DRV_LEVEL_MASK		0xff
>> +#define SPMI_VIB_DRV_SHIFT		0
>> +
>>   #define VIB_MAX_LEVEL_mV	(3100)
>>   #define VIB_MIN_LEVEL_mV	(1200)
>>   #define VIB_MAX_LEVELS		(VIB_MAX_LEVEL_mV - VIB_MIN_LEVEL_mV)
>>   
>>   #define MAX_FF_SPEED		0xff
>>   
>> -struct pm8xxx_regs {
>> -	unsigned int enable_addr;
>> -	unsigned int enable_mask;
>> +enum pm8xxx_vib_type {
>> +	SSBI_VIB,
>> +	SPMI_VIB_GEN1,
>> +};
>>   
>> -	unsigned int drv_addr;
>> -	unsigned int drv_mask;
>> -	unsigned int drv_shift;
>> -	unsigned int drv_en_manual_mask;
>> +enum {
>> +	VIB_DRV_REG,
>> +	VIB_EN_REG,
>> +	VIB_MAX_REG,
>>   };
>>   
>> -static const struct pm8xxx_regs pm8058_regs = {
>> -	.drv_addr = 0x4A,
>> -	.drv_mask = 0xf8,
>> -	.drv_shift = 3,
>> -	.drv_en_manual_mask = 0xfc,
>> +static struct reg_field ssbi_vib_regs[VIB_MAX_REG] = {
> 
> Change from const to non-const is wrong. How do you support multiple
> devices? No, this is way too fragile now.
> 

The register definition is no longer used as the match data, hw_type is 
used.

The last suggestion was getting the register base address from the DT 
and it has to be added into the offset of SPMI vibrator registers 
(either in the previous hard-coded format or the later the reg_filed 
data structure), so it's not appropriated to make it constant.

I don't understand this question: "How do you support multiple devices?" 
For SSBI vibrator, since all the registers are fixed, and I would assume 
that there is no chance to support multiple vibrator devices on the same 
SSBI bus. If they are not on the same bus, the regmap device will be 
different while the registers definition is the same, and we are still 
able to support multiple devices, right?
The similar story for SPMI vibrators and it can support multiple devices 
if they are located on different SPMI bus, or even if they are on the 
same SPMI bus but just having different SID or PID.

> ...
> 
>>   
>>   	/*
>>   	 * pmic vibrator supports voltage ranges from 1.2 to 3.1V, so
>> @@ -168,38 +166,65 @@ static int pm8xxx_vib_probe(struct platform_device *pdev)
>>   {
>>   	struct pm8xxx_vib *vib;
>>   	struct input_dev *input_dev;
>> -	int error;
>> +	struct device *dev = &pdev->dev;
>> +	struct regmap *regmap;
>> +	struct reg_field *regs;
>> +	int error, i;
>>   	unsigned int val;
>> -	const struct pm8xxx_regs *regs;
>> +	u32 reg_base;
>>   
>> -	vib = devm_kzalloc(&pdev->dev, sizeof(*vib), GFP_KERNEL);
>> +	vib = devm_kzalloc(dev, sizeof(*vib), GFP_KERNEL);
> 
> Not really related. Split cleanup from new features.
Okay, will keep as it is.
> 
>>   	if (!vib)
>>   		return -ENOMEM;
>>   
>> -	vib->regmap = dev_get_regmap(pdev->dev.parent, NULL);
>> -	if (!vib->regmap)
>> +	regmap = dev_get_regmap(dev->parent, NULL);
>> +	if (!regmap)
>>   		return -ENODEV;
>>   
>> -	input_dev = devm_input_allocate_device(&pdev->dev);
>> +	input_dev = devm_input_allocate_device(dev);
>>   	if (!input_dev)
>>   		return -ENOMEM;
>>   
>>   	INIT_WORK(&vib->work, pm8xxx_work_handler);
>>   	vib->vib_input_dev = input_dev;
>>   
>> -	regs = of_device_get_match_data(&pdev->dev);
>> +	vib->hw_type = (enum pm8xxx_vib_type)of_device_get_match_data(dev);
>>   
>> -	/* operate in manual mode */
>> -	error = regmap_read(vib->regmap, regs->drv_addr, &val);
>> +	regs = ssbi_vib_regs;
>> +	if (vib->hw_type != SSBI_VIB) {
>> +		error = fwnode_property_read_u32(dev->fwnode, "reg", &reg_base);
>> +		if (error < 0) {
>> +			dev_err(dev, "Failed to read reg address, rc=%d\n", error);
>> +			return error;
>> +		}
>> +
>> +		if (vib->hw_type == SPMI_VIB_GEN1)
>> +			regs = spmi_vib_gen1_regs;
>> +
>> +		for (i = 0; i < VIB_MAX_REG; i++)
>> +			if (regs[i].reg != 0)
>> +				regs[i].reg += reg_base;
>> +	}
>> +
>> +	error = devm_regmap_field_bulk_alloc(dev, regmap, vib->r_fields, regs, VIB_MAX_REG);
>>   	if (error < 0)
>> +	{
> 
> That's not a Linux coding style.
> 
> Please run scripts/checkpatch.pl and fix reported warnings. Some
> warnings can be ignored, but the code here looks like it needs a fix.
> Feel free to get in touch if the warning is not clear.
> 
>> +		dev_err(dev, "Failed to allocate regmap failed, rc=%d\n", error);
> 
> No need to print errors on allocation failures.
> 
Will fix it.
Thanks

>>   		return error;
>> +	}
>>   
>> -	val &= regs->drv_en_manual_mask;
>> -	error = regmap_write(vib->regmap, regs->drv_addr, val);
>> +	error = regmap_field_read(vib->r_fields[VIB_DRV_REG], &val);
>>   	if (error < 0)
>>   		return error;
> 
> 
> Best regards,
> Krzysztof
> 

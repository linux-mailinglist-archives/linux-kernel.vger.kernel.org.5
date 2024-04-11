Return-Path: <linux-kernel+bounces-140570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C7C8A164D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF268288683
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33AC14D711;
	Thu, 11 Apr 2024 13:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UeP0lrov"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4694214D6E0;
	Thu, 11 Apr 2024 13:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712843485; cv=none; b=JIiPqhtgb8K2qBKU6GtwFEUb0sPmhTGz/AGyORcKd/0bXsEOfzzFuTzbH633pnZR/HhSi0WxyiAGD0iMZ3fIvplEVXTyrBML+2HKPRj65gnh6gizmckZp8zQLlf2XkfzUoSgWE6RTHMFzoZWCzxlj8pFLARQ8x/YDOE6ffvNguo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712843485; c=relaxed/simple;
	bh=w3MAx7X4BvLaSfA0z3x3zJFYsikqJJHu1cquCWRQvD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ubmc27AneQMffEbpm9h0EDHAdAVBYGLRfknfgJbGCPQeQd78MeqHnQxiqiUCKRokAyF6GaXbX3HaR0ZeQfn+Y722Wf7ejWd4RllJPy1Rwfx7zdm98R6r3c5Z3YeO8qjEuJ5lLURUrC7qhO/G2AnAS2DyjnZRRe5uDDuHSEL8658=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UeP0lrov; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43BCdOeu003345;
	Thu, 11 Apr 2024 13:51:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=PJrPJzI9tZWalVF2HGIgb7pQcW9btb7ItvIvDtE5NqY=; b=Ue
	P0lrovih7tNWWmVLd7KvhrKW5uWvjjli+LJa+NCNIFkn5ejy/My6UKhxNnS9Zgl4
	vddHyGm9NGAhKCHDjo2NJr6lu07Usmljr8L2mOE75F+zeKLOhzvqZkxHmJnpGWsB
	oRhSMdPZwzbt4MAF0DiprrRnh9w8jdZAaxXbyJ5LA9EtN7syQQjvd9zXr4Va9ZUr
	JNtMjC4BK1v3KpPXMGus/MkKXdHrDWOC/OTgAmiB60c3t6D3llLmjWZQajw2g1/8
	QDBkmr7Tx7gE87PdHyWzShiWXH61r9deXuRlBmr9WEGu7phNt3afM3FwY483yQQK
	moJQF3pGTjZIvnLyedfg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xe99jt4n1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 13:51:19 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43BDpI0K019351
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 13:51:18 GMT
Received: from [10.253.34.126] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 11 Apr
 2024 06:51:12 -0700
Message-ID: <c2ee9ab0-ecb2-aba2-2cc9-653f74d27396@quicinc.com>
Date: Thu, 11 Apr 2024 21:51:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v9 4/4] input: pm8xxx-vibrator: add new SPMI vibrator
 support
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <kernel@quicinc.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Dmitry
 Torokhov" <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-input@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20240411-pm8xxx-vibrator-new-design-v9-0-7bf56cb92b28@quicinc.com>
 <20240411-pm8xxx-vibrator-new-design-v9-4-7bf56cb92b28@quicinc.com>
 <CAA8EJprJ4s-o1uPiPjRpq4nwG4cdV7K8XMhVLOQn2D=kJLiVzQ@mail.gmail.com>
From: Fenglin Wu <quic_fenglinw@quicinc.com>
In-Reply-To: <CAA8EJprJ4s-o1uPiPjRpq4nwG4cdV7K8XMhVLOQn2D=kJLiVzQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: AadPOHqKIiv8VDR3qAno4-5VC-o6Shqj
X-Proofpoint-GUID: AadPOHqKIiv8VDR3qAno4-5VC-o6Shqj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_07,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 phishscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 impostorscore=0
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404110100



On 2024/4/11 19:02, Dmitry Baryshkov wrote:
> On Thu, 11 Apr 2024 at 11:32, Fenglin Wu via B4 Relay
> <devnull+quic_fenglinw.quicinc.com@kernel.org> wrote:
>>
>> From: Fenglin Wu <quic_fenglinw@quicinc.com>
>>
>> Add support for a new SPMI vibrator module which is very similar
>> to the vibrator module inside PM8916 but has a finer drive voltage
>> step and different output voltage range, its drive level control
>> is expanded across 2 registers. The vibrator module can be found
>> in following Qualcomm PMICs: PMI632, PM7250B, PM7325B, PM7550BA.
>>
>> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
>> ---
>>   drivers/input/misc/pm8xxx-vibrator.c | 51 +++++++++++++++++++++++++++++-------
>>   1 file changed, 42 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/input/misc/pm8xxx-vibrator.c b/drivers/input/misc/pm8xxx-vibrator.c
>> index 2959edca8eb9..35bb6f450fd2 100644
>> --- a/drivers/input/misc/pm8xxx-vibrator.c
>> +++ b/drivers/input/misc/pm8xxx-vibrator.c
>> @@ -12,10 +12,10 @@
>>   #include <linux/regmap.h>
>>   #include <linux/slab.h>
>>
>> -#define VIB_MAX_LEVEL_mV       (3100)
>> -#define VIB_MIN_LEVEL_mV       (1200)
>> -#define VIB_PER_STEP_mV        (100)
>> -#define VIB_MAX_LEVELS         (VIB_MAX_LEVEL_mV - VIB_MIN_LEVEL_mV + VIB_PER_STEP_mV)
>> +#define VIB_MAX_LEVEL_mV(vib)  (vib->drv2_addr ? 3544 : 3100)
>> +#define VIB_MIN_LEVEL_mV(vib)  (vib->drv2_addr ? 1504 : 1200)
>> +#define VIB_PER_STEP_mV(vib)   (vib->drv2_addr ? 8 : 100)
>> +#define VIB_MAX_LEVELS(vib)    (VIB_MAX_LEVEL_mV(vib) - VIB_MIN_LEVEL_mV(vib) + VIB_PER_STEP_mV(vib))
>>
>>   #define MAX_FF_SPEED           0xff
>>
>> @@ -26,6 +26,9 @@ struct pm8xxx_regs {
>>          unsigned int drv_offset;
>>          unsigned int drv_mask;
>>          unsigned int drv_shift;
>> +       unsigned int drv2_offset;
>> +       unsigned int drv2_mask;
>> +       unsigned int drv2_shift;
>>          unsigned int drv_en_manual_mask;
>>   };
>>
>> @@ -45,6 +48,18 @@ static struct pm8xxx_regs pm8916_regs = {
>>          .drv_en_manual_mask = 0,
>>   };
>>
>> +static struct pm8xxx_regs pmi632_regs = {
>> +       .enable_offset = 0x46,
>> +       .enable_mask = BIT(7),
>> +       .drv_offset = 0x40,
>> +       .drv_mask = GENMASK(7, 0),
>> +       .drv_shift = 0,
>> +       .drv2_offset = 0x41,
>> +       .drv2_mask = GENMASK(3, 0),
>> +       .drv2_shift = 8,
>> +       .drv_en_manual_mask = 0,
>> +};
>> +
>>   /**
>>    * struct pm8xxx_vib - structure to hold vibrator data
>>    * @vib_input_dev: input device supporting force feedback
>> @@ -53,6 +68,7 @@ static struct pm8xxx_regs pm8916_regs = {
>>    * @regs: registers' info
>>    * @enable_addr: vibrator enable register
>>    * @drv_addr: vibrator drive strength register
>> + * @drv2_addr: vibrator drive strength upper byte register
>>    * @speed: speed of vibration set from userland
>>    * @active: state of vibrator
>>    * @level: level of vibration to set in the chip
>> @@ -65,6 +81,7 @@ struct pm8xxx_vib {
>>          const struct pm8xxx_regs *regs;
>>          unsigned int enable_addr;
>>          unsigned int drv_addr;
>> +       unsigned int drv2_addr;
>>          int speed;
>>          int level;
>>          bool active;
>> @@ -82,6 +99,10 @@ static int pm8xxx_vib_set(struct pm8xxx_vib *vib, bool on)
>>          unsigned int val = vib->reg_vib_drv;
>>          const struct pm8xxx_regs *regs = vib->regs;
>>
>> +       /* vibrator without drv2_addr needs be programmed in step increments */
> 
> How are these two items related? Are you using vib->drv2_addr as a
> marker for 'particular generation'? In such a case please use a flag
> instead.
> 
> The rest looks good to me.
> 
Are you suggesting to add a flag in pm8xxx_vib as a discriminator for 
the new generation? I actually tried to avoid that because of this comment:
https://lore.kernel.org/linux-arm-msm/ZgXSBiQcBEbwF060@google.com/#t

>> +       if (!vib->drv2_addr)
>> +               vib->level /= VIB_PER_STEP_mV(vib);
>> +
>>          if (on)
>>                  val |= (vib->level << regs->drv_shift) & regs->drv_mask;
>>          else
>> @@ -93,6 +114,17 @@ static int pm8xxx_vib_set(struct pm8xxx_vib *vib, bool on)
>>
>>          vib->reg_vib_drv = val;
>>
>> +       if (regs->drv2_mask) {
>> +               if (on)
>> +                       val = (vib->level << regs->drv2_shift) & regs->drv2_mask;
>> +               else
>> +                       val = 0;
>> +
>> +               rc = regmap_write_bits(vib->regmap, vib->drv2_addr, regs->drv2_mask, val);
>> +               if (rc < 0)
>> +                       return rc;
>> +       }
>> +
>>          if (regs->enable_mask)
>>                  rc = regmap_update_bits(vib->regmap, vib->enable_addr,
>>                                          regs->enable_mask, on ? regs->enable_mask : 0);
>> @@ -115,17 +147,16 @@ static void pm8xxx_work_handler(struct work_struct *work)
>>                  return;
>>
>>          /*
>> -        * pmic vibrator supports voltage ranges from 1.2 to 3.1V, so
>> +        * pmic vibrator supports voltage ranges from MIN_LEVEL to MAX_LEVEL, so
>>           * scale the level to fit into these ranges.
>>           */
>>          if (vib->speed) {
>>                  vib->active = true;
>> -               vib->level = ((VIB_MAX_LEVELS * vib->speed) / MAX_FF_SPEED) +
>> -                                               VIB_MIN_LEVEL_mV;
>> -               vib->level /= VIB_PER_STEP_mV;
>> +               vib->level = VIB_MIN_LEVEL_mV(vib);
>> +               vib->level += mult_frac(VIB_MAX_LEVELS(vib), vib->speed, MAX_FF_SPEED);
>>          } else {
>>                  vib->active = false;
>> -               vib->level = VIB_MIN_LEVEL_mV / VIB_PER_STEP_mV;
>> +               vib->level = VIB_MIN_LEVEL_mV(vib);
>>          }
>>
>>          pm8xxx_vib_set(vib, vib->active);
>> @@ -203,6 +234,7 @@ static int pm8xxx_vib_probe(struct platform_device *pdev)
>>
>>          vib->enable_addr = reg_base + regs->enable_offset;
>>          vib->drv_addr = reg_base + regs->drv_offset;
>> +       vib->drv2_addr = reg_base + regs->drv2_offset;
>>
>>          /* operate in manual mode */
>>          error = regmap_read(vib->regmap, vib->drv_addr, &val);
>> @@ -257,6 +289,7 @@ static const struct of_device_id pm8xxx_vib_id_table[] = {
>>          { .compatible = "qcom,pm8058-vib", .data = &pm8058_regs },
>>          { .compatible = "qcom,pm8921-vib", .data = &pm8058_regs },
>>          { .compatible = "qcom,pm8916-vib", .data = &pm8916_regs },
>> +       { .compatible = "qcom,pmi632-vib", .data = &pmi632_regs },
>>          { }
>>   };
>>   MODULE_DEVICE_TABLE(of, pm8xxx_vib_id_table);
>>
>> --
>> 2.25.1
>>
>>
> 
> 


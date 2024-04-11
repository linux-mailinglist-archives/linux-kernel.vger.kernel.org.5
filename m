Return-Path: <linux-kernel+bounces-140561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A72018A1633
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EBFD1F23A37
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F8414C594;
	Thu, 11 Apr 2024 13:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fk9dgjL/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769FB1EB26;
	Thu, 11 Apr 2024 13:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712843116; cv=none; b=IoZtqD2mXCQNpOJAdpXnXm0gl3DOqKLWzAyM9cQ6fPhzf3PnDF6Ycb5VTL+Ko12mYcn9gZQEdHHeMxr/HgIExvTfM1iSOF9RF2ZY5zI2nj//y4HcLLZLaU0LGeIpxcXUw23E96HfzDcySjUQMfrAhtddTXvvSwjLVJV+RcetO/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712843116; c=relaxed/simple;
	bh=Vef2IPFjkusUWnM9mmNBw7GsUxZyGnBJjs80zDYEVf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bsZAVDzgvqbw92zH4/RTLELDjkfFZfClUfNZ+/SxdK7nKzoEh9nXewHik+26l7zI55lRdRjNAGq+FC0+2i1/6xs4Jicv+buNdZwSqXOP6VtA0N7DJx7yLtoKlyT0qfV0rXpMrHCLgqyo+Fqp8nI6J/Cb3yWon4KemHKHddQ73jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fk9dgjL/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43BDcJ37013981;
	Thu, 11 Apr 2024 13:45:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=8vWKNp5NOyzk1nvCBVyzQsUw06V4AN1AfvxUVSvqf1M=; b=fk
	9dgjL/sycJIMj1SDfqZL9GDehjEIzHsBaoWJSHSg3Be0hYMAEwl7Fw9zI72aIctk
	SCNjuIpqbgWxqdq2Odqki9wA0PTv0f5MTK/D8cooPfmrABfRoct2tPn5B+Qkrgs8
	CDA47mKhDjDIe+TYv2p8CNaPJESNmbsg/cRqJpwQ4IZ0jCE+goQz/ifQE4ZWKHHH
	bmLXrfgbl/7dTfCD5+UzGSFOpoyEEkxgIQHee6beTqPuWpCiL1BdWeWgNJ9YMWbm
	M3o8XKeGiVNjnHftwhSaYBgAJUrs5TQGWSEYFVtI6q2VO68CFsmFRoMq5PTlVUPe
	Vl1gdyCsZb0nBulw5gMQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xe9jsa148-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 13:44:47 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43BDi7RD018671
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 13:44:07 GMT
Received: from [10.253.34.126] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 11 Apr
 2024 06:44:02 -0700
Message-ID: <fa6c8b30-11f3-bd80-67cb-713e4348eccf@quicinc.com>
Date: Thu, 11 Apr 2024 21:43:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v9 2/4] input: pm8xxx-vibrator: refactor to support new
 SPMI vibrator
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
 <20240411-pm8xxx-vibrator-new-design-v9-2-7bf56cb92b28@quicinc.com>
 <CAA8EJpoL9vCAUgWmHcoxppo_gJqaw_xqdYqcJkS6Xza-5aSh3A@mail.gmail.com>
From: Fenglin Wu <quic_fenglinw@quicinc.com>
In-Reply-To: <CAA8EJpoL9vCAUgWmHcoxppo_gJqaw_xqdYqcJkS6Xza-5aSh3A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PsVZnEuLpXAM2rwWwkWHRnxLKI3hnFcy
X-Proofpoint-GUID: PsVZnEuLpXAM2rwWwkWHRnxLKI3hnFcy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_06,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0 mlxlogscore=958
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404110099



On 2024/4/11 18:58, Dmitry Baryshkov wrote:
> On Thu, 11 Apr 2024 at 11:32, Fenglin Wu via B4 Relay
> <devnull+quic_fenglinw.quicinc.com@kernel.org> wrote:
>>
>> From: Fenglin Wu <quic_fenglinw@quicinc.com>
>>
>> Currently, vibrator control register addresses are hard coded,
>> including the base address and offsets, it's not flexible to
>> support new SPMI vibrator module which is usually included in
>> different PMICs with different base address. Refactor it by using
>> the base address defined in devicetree.
>>
>> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
>> ---
>>   drivers/input/misc/pm8xxx-vibrator.c | 42 ++++++++++++++++++++++++------------
>>   1 file changed, 28 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/input/misc/pm8xxx-vibrator.c b/drivers/input/misc/pm8xxx-vibrator.c
>> index 89f0f1c810d8..2959edca8eb9 100644
>> --- a/drivers/input/misc/pm8xxx-vibrator.c
>> +++ b/drivers/input/misc/pm8xxx-vibrator.c
>> @@ -20,26 +20,26 @@
>>   #define MAX_FF_SPEED           0xff
>>
>>   struct pm8xxx_regs {
>> -       unsigned int enable_addr;
>> +       unsigned int enable_offset;
>>          unsigned int enable_mask;
>>
>> -       unsigned int drv_addr;
>> +       unsigned int drv_offset;
>>          unsigned int drv_mask;
>>          unsigned int drv_shift;
>>          unsigned int drv_en_manual_mask;
>>   };
>>
>>   static const struct pm8xxx_regs pm8058_regs = {
>> -       .drv_addr = 0x4A,
>> +       .drv_offset = 0x4A,
> 
> If the DT already has reg = <0x4a> and you add drv_offset = 0x4a,
> which register will be used by the driver?
> 
> Also, while we are at it, please downcase all the hex numbers that you
> are touching.
> 
For SSBI vibrator, the "reg" value defined in DT is not used, see below.


>>          .drv_mask = 0xf8,
>>          .drv_shift = 3,
>>          .drv_en_manual_mask = 0xfc,
>>   };
>>
>>   static struct pm8xxx_regs pm8916_regs = {
>> -       .enable_addr = 0xc046,
>> +       .enable_offset = 0x46,

[...]

>> @@ -170,7 +173,7 @@ static int pm8xxx_vib_probe(struct platform_device *pdev)
>>          struct pm8xxx_vib *vib;
>>          struct input_dev *input_dev;
>>          int error;
>> -       unsigned int val;
>> +       unsigned int val, reg_base = 0;
>>          const struct pm8xxx_regs *regs;
>>
>>          vib = devm_kzalloc(&pdev->dev, sizeof(*vib), GFP_KERNEL);
>> @@ -190,13 +193,24 @@ static int pm8xxx_vib_probe(struct platform_device *pdev)
>>
>>          regs = of_device_get_match_data(&pdev->dev);
>>
>> +       if (regs->enable_offset != 0) {
>> +               error = fwnode_property_read_u32(pdev->dev.fwnode, "reg", &reg_base);
>> +               if (error < 0) {
>> +                       dev_err(&pdev->dev, "Failed to read reg address, rc=%d\n", error);
>> +                       return error;
>> +               }
>> +       }
>> +
>> +       vib->enable_addr = reg_base + regs->enable_offset;
>> +       vib->drv_addr = reg_base + regs->drv_offset;

The reg_base is initialized as 0 and it is assigned as the "reg" value 
defined in DT only for SPMI vibrators.

>> +
>>          /* operate in manual mode */
>> -       error = regmap_read(vib->regmap, regs->drv_addr, &val);
>> +       error = regmap_read(vib->regmap, vib->drv_addr, &val);
>>          if (error < 0)
>>                  return error;
>>
>>          val &= regs->drv_en_manual_mask;
>> -       error = regmap_write(vib->regmap, regs->drv_addr, val);
>> +       error = regmap_write(vib->regmap, vib->drv_addr, val);
>>          if (error < 0)
>>                  return error;
>>
>>
>> --
>> 2.25.1
>>
>>
> 
> 


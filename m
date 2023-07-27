Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D11764958
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbjG0Hvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbjG0HvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:51:19 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF7A7EE1;
        Thu, 27 Jul 2023 00:44:43 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36R6wa5s012197;
        Thu, 27 Jul 2023 07:44:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Xnt+gWLCxydIPZC35sjTQgVmjkbNuT8ja0kADJQto6c=;
 b=D+XCfaZJDGtyjWIik9PmcxXmIX8zDuKorEsPHitV0hu6gXO3NDI9dyva3Hz6Yk6jmUIA
 /95243mE7GZk18sntE2sGbOmowRkWDqJjSv8sfUoVlfxLZIbwdsSjMx6/v8n1ngJz+bC
 nD+E4Oe4bBmzjoVOLP/RV/01DJoPCJyzkn/6SSpQoaGMQSV1GhDibDu04UQmA4bOrphk
 QYPqkdOUXyQN5uV+IfA73lVPyg2kJYiD0l4pW2aoYLMerrsziyExFatvmrYO3r73zVJ5
 CZH20etx/31YW5fzw8/yvS3OQ7jcYZ74n0LoppTlW61wf+W2deTPfFPd//E0xK7LibLM 8w== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s3krn82vn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 07:44:25 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36R7huZi014489
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 07:43:56 GMT
Received: from [10.253.74.152] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 27 Jul
 2023 00:43:53 -0700
Message-ID: <4e416602-8dea-fa6d-d083-f93b730552c3@quicinc.com>
Date:   Thu, 27 Jul 2023 15:43:51 +0800
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
 <053c9571-d709-2826-fced-a00dd7255b8b@quicinc.com>
 <2a09e743-7423-65b0-c70d-87ae8105182a@linaro.org>
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
In-Reply-To: <2a09e743-7423-65b0-c70d-87ae8105182a@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HRHdaZi7NqJx5rq5TCcy1XXts40NqS6q
X-Proofpoint-GUID: HRHdaZi7NqJx5rq5TCcy1XXts40NqS6q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_08,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 suspectscore=0 mlxlogscore=478 priorityscore=1501 bulkscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307270067
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/27/2023 3:07 PM, Krzysztof Kozlowski wrote:
> On 25/07/2023 08:16, Fenglin Wu wrote:
>>>>    
>>>> -static const struct pm8xxx_regs pm8058_regs = {
>>>> -	.drv_addr = 0x4A,
>>>> -	.drv_mask = 0xf8,
>>>> -	.drv_shift = 3,
>>>> -	.drv_en_manual_mask = 0xfc,
>>>> +static struct reg_field ssbi_vib_regs[VIB_MAX_REG] = {
>>>
>>> Change from const to non-const is wrong. How do you support multiple
>>> devices? No, this is way too fragile now.
>>>
>>
>> The register definition is no longer used as the match data, hw_type is
>> used.
>>
>> The last suggestion was getting the register base address from the DT
>> and it has to be added into the offset of SPMI vibrator registers
>> (either in the previous hard-coded format or the later the reg_filed
>> data structure), so it's not appropriated to make it constant.
>>
>> I don't understand this question: "How do you support multiple devices?"
>> For SSBI vibrator, since all the registers are fixed, and I would assume
>> that there is no chance to support multiple vibrator devices on the same
>> SSBI bus. If they are not on the same bus, the regmap device will be
>> different while the registers definition is the same, and we are still
>> able to support multiple devices, right?
> 
> No, you have static memory. One device probes and changes static memory
> to reg+=base1. Second device probes and changes the same to reg+=base2.

Thanks, got it.  I can update it with following 2 options:

1) keep the register definition in 'reg_filed' data structure and make 
it constant, copy it to a dynamically allocated memory before adding the 
'reg_base' to the '.reg' variable.

2) Define the register offsets as constant data and add the 'reg_base' 
to the 'reg' while using 'regmap_read()'/'regmap_write()' functions.

which one is the preferred way?

> 
>> The similar story for SPMI vibrators and it can support multiple devices
>> if they are located on different SPMI bus, or even if they are on the
>> same SPMI bus but just having different SID or PID.
> 
> Sorry, such code cannot go in. These must stay const and you must write
> driver without any static allocations or singleton-like patterns.
> 
> 
> Best regards,
> Krzysztof
> 

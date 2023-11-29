Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7DF7FCEEC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 07:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346734AbjK2GPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 01:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjK2GPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 01:15:17 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD442B0;
        Tue, 28 Nov 2023 22:15:22 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT4dpr8028631;
        Wed, 29 Nov 2023 06:14:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=yrBWEX2HQ+kskdGGVrGhtux9ivj/AH3ovrf63KZChR4=;
 b=ogZ//AFpz8t8Fj6Wzz+TNkGeqICmeZcud0FsjAgfN4h3Jb0y0PnzZUdm8BK2nhjsa1Hp
 OUwOadL23R/X5jX4HF3CpLQXw0+Qw7H7RLjphwJWTeq4s4ccmixxHLIhSGw1DknjONfP
 B1x3l7y4fjXPFQsP8u29OaUxe1+l1GDkG2Ypj40S1W8xth0dXWSmpAatbAWs62+8Xpsw
 e1hf9WVqolxOMhHpIw4yfEjWipaU+DeHhN3hVlF8KMGY0FrxJV35VmJxyAVVEUjJBekW
 Dd5GogmEmtaoTN7f2bNh42NHfdPwdFXUJy4JoqRK1+PMEV6MlWZ/iwS4t+GuUp3OoIYJ SA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3unvetrf6w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 06:14:58 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AT6EvGu022001
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 06:14:57 GMT
Received: from [10.214.66.253] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 28 Nov
 2023 22:14:51 -0800
Message-ID: <7df38308-872b-4bae-9fb0-5075611290d9@quicinc.com>
Date:   Wed, 29 Nov 2023 11:44:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] iommu/arm-smmu: add ACTLR data and support for
 SC7280
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <joro@8bytes.org>,
        <dmitry.baryshkov@linaro.org>, <a39.skl@gmail.com>,
        <quic_bjorande@quicinc.com>, <mani@kernel.org>,
        <quic_eberman@quicinc.com>, <robdclark@chromium.org>,
        <u.kleine-koenig@pengutronix.de>, <robh@kernel.org>,
        <vladimir.oltean@nxp.com>, <quic_pkondeti@quicinc.com>,
        <quic_molvera@quicinc.com>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <qipl.kernel.upstream@quicinc.com>
References: <20231127145412.3981-1-quic_bibekkum@quicinc.com>
 <20231127145412.3981-4-quic_bibekkum@quicinc.com>
 <ec4b7dfa-6fcf-4ccc-8857-d99573349599@linaro.org>
From:   Bibek Kumar Patro <quic_bibekkum@quicinc.com>
In-Reply-To: <ec4b7dfa-6fcf-4ccc-8857-d99573349599@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: b20UzmWvZjZ6T6Mgl-0gOa1_D0N0XlOc
X-Proofpoint-ORIG-GUID: b20UzmWvZjZ6T6Mgl-0gOa1_D0N0XlOc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_03,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 spamscore=0 mlxscore=0 impostorscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311290043
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/27/2023 9:05 PM, Konrad Dybcio wrote:
> On 27.11.2023 15:54, Bibek Kumar Patro wrote:
>> Add ACTLR data table for SC7280 along with support for
>> same including SC7280 specific implementation operations.
>>
>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
>> ---
>>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 25 +++++++++++++++++++++-
>>   1 file changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> index 247eaa194129..f0ad09f9a974 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> @@ -27,6 +27,20 @@ struct actlr_config {
>>   #define CPRE			BIT(1)		/* Enable context caching in the prefetch buffer */
>>   #define CMTLB			BIT(0)		/* Enable context caching in the macro TLB */
>>
>> +static const struct actlr_config sc7280_apps_actlr_cfg[] = {
>> +	{ 0x0800, 0x24E1, PREFETCH_DISABLE | CMTLB },
> hex should be lowercase
Noted,thanks for pointing this out will take care of this in next
version.
> 
>> +	{ 0x2000, 0x0163, PREFETCH_DISABLE | CMTLB },
>> +	{ 0x2080, 0x0461, PREFETCH_DISABLE | CMTLB },
>> +	{ 0x2100, 0x0161, PREFETCH_DISABLE | CMTLB },
>> +	{ 0x0900, 0x0407, PREFETCH_SHALLOW | CPRE | CMTLB },
>> +	{ 0x2180, 0x0027, PREFETCH_SHALLOW | CPRE | CMTLB },
>> +	{ 0x1000, 0x07ff, PREFETCH_DEEP | CPRE | CMTLB },
>> +};
> Any reason this list is so much smaller than 8550's? Is it complete?
Yes it's complete only. This list varies targetwise actually so we just 
fill it referring the hardware settings reference document. So size of 
the list might vary as per target.
> 
> Konrad

Thanks & regards,
Bibek

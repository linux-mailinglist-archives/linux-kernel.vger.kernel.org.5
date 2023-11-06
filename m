Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0877E1A3D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 07:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbjKFG2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 01:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjKFG2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 01:28:44 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A75E1
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 22:28:41 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A65PQTA023962;
        Mon, 6 Nov 2023 06:28:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=pa6L8WKl/NMujlxvy6n10K4LTwblKERMATKYJVfB+C0=;
 b=Pyub2ur9yeN+bWaMfhgnhtRrmgkXyq4tCm828NOtCqag8Fqc3RLHnuqILKFDgJ7KJjOj
 PNX7ZYtwxhn5MjJpIJk2wi8x1MToyQgu+GAGRCzpTV42avOK0Kt7WPmRX3tJmRUFp6jd
 yiC5yN5AaA+hMHhkkcoEc3GsWZI5WMFSvXeVNHqAdx7Q4vkIRh/X3Q3IW88SUc8HW7U/
 t6TEOuaKKp5myrcnIP1dRNNL5dAA2TF3S09reATed8cZSu2zARwU9SJHOgOM6Uw7C2H4
 +0HkTNsPFdtz6JSCC/QJKO8ka4Y6Fgqpr8NchPMi64S8V6uchOI92U9jtmWL8c8YPFMZ mg== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u5ek4k848-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 06:28:29 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A66SSH4008883
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Nov 2023 06:28:28 GMT
Received: from [10.214.227.50] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Sun, 5 Nov
 2023 22:28:23 -0800
Message-ID: <482bf12a-03d1-4054-a2df-3bf82d359e4c@quicinc.com>
Date:   Mon, 6 Nov 2023 11:58:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] iommu/arm-smmu: re-enable context caching in smmu
 reset operation
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <joro@8bytes.org>,
        <dmitry.baryshkov@linaro.org>, <a39.skl@gmail.com>,
        <quic_saipraka@quicinc.com>, <quic_pkondeti@quicinc.com>,
        <quic_molvera@quicinc.com>
CC:     <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <qipl.kernel.upstream@quicinc.com>
References: <20231103215124.1095-1-quic_bibekkum@quicinc.com>
 <20231103215124.1095-4-quic_bibekkum@quicinc.com>
 <26af3ecc-8b3f-4b10-b594-eae57de501cb@linaro.org>
From:   Bibek Kumar Patro <quic_bibekkum@quicinc.com>
In-Reply-To: <26af3ecc-8b3f-4b10-b594-eae57de501cb@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4nzVZBU36K6ntLGXBe3w71Zkc6Y_FuZT
X-Proofpoint-ORIG-GUID: 4nzVZBU36K6ntLGXBe3w71Zkc6Y_FuZT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_04,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0
 clxscore=1015 spamscore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060054
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/4/2023 5:00 PM, Konrad Dybcio wrote:
> 
> 
> On 11/3/23 22:51, Bibek Kumar Patro wrote:
>> Context caching is re-enabled in the prefetch buffer for Qualcomm SoCs
>> through SoC specific reset ops, which is disabled in the default MMU-500
>> reset ops, but is expected for context banks using ACTLR register to
>> retain the prefetch value during reset and runtime suspend.
>>
>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
>> ---
>>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 26 ++++++++++++++++++----
>>   1 file changed, 22 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c 
>> b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> index 590b7c285299..f342b4778cf1 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> @@ -457,11 +457,29 @@ static int qcom_smmu_def_domain_type(struct 
>> device *dev)
>>       return match ? IOMMU_DOMAIN_IDENTITY : 0;
>>   }
>>
>> +#define ARM_MMU500_ACTLR_CPRE          BIT(1)
>> +
>> +static int qcom_smmu500_reset(struct arm_smmu_device *smmu)
>> +{
>> +    int i;
>> +    u32 reg;
>> +
>> +    arm_mmu500_reset(smmu);
>> +
>> +        for (i = 0; i < smmu->num_context_banks; ++i) {
> This loop deserves a comment above it like
> 
> /* Re-enable context caching after reset */
> 

Ack, thanks for this suggestion, this might help to explain
this addition.
I would incorporate this in next patch.

regards,
Bibek

> Konrad

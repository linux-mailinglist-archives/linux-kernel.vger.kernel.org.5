Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75137EDB70
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 07:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjKPGKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 01:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjKPGKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 01:10:34 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D0B1B8;
        Wed, 15 Nov 2023 22:10:30 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AG4k2Ch015880;
        Thu, 16 Nov 2023 06:10:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=9obdCHhOsHKQSrc5yPYTvhHbe8XgAVHrOqsoefI79hs=;
 b=hYdbF0VGbaokNyuFu6kIl/43wBlmHbT+mnaBKeEouXrVSKG3XEff4opM+kTQ3hY7hDsX
 nwfvbuah59x9yeFqJqeJ5z8f1X4fkS+0tpS9hyBLVRYc63FKkpHxmx6HpoAv6M2zpZ0j
 GbZvELaRBYP9vAWng3IzU/WcaYh5vUafven/RLZiKpZpK/WaIXN5OHEB/7QWDmxIYZQs
 J2khaTPW8QUFBlrVEW43gHTIm2tkg/lP56YtFnHWRMQW02Fq/fUh1qBtXvHfw7XnJD00
 Ofbx8XomKgn3JciTSLLyk1Y1ZCA7aYLcVhDxuzjjI2yYPZTJbCvc+9OT5Icnqd9udi8h Zg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ud6ecgsem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 06:10:05 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AG6A4lY006811
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 06:10:04 GMT
Received: from [10.214.66.253] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 15 Nov
 2023 22:09:59 -0800
Message-ID: <61d2885a-50f9-419f-8473-10308baed493@quicinc.com>
Date:   Thu, 16 Nov 2023 11:39:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] iommu/arm-smmu: add ACTLR data and support for
 SM8550
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <a39.skl@gmail.com>, <quic_pkondeti@quicinc.com>,
        <quic_molvera@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <qipl.kernel.upstream@quicinc.com>
References: <20231114135654.30475-1-quic_bibekkum@quicinc.com>
 <20231114135654.30475-3-quic_bibekkum@quicinc.com>
 <CAA8EJpr1NzqiuNVZ0YcLpJ=yeOYFbLouAFgN9VMOiKpmoGVdtQ@mail.gmail.com>
 <7edad996-f148-42d5-8e72-0334d3b9101f@quicinc.com>
 <CAA8EJpqzEvC-LEjJrOk6Ed8utFNnqgP=qkb0mq-dOfMZd5ij4Q@mail.gmail.com>
 <dba223a1-0456-40b8-b295-ea960867dcf9@quicinc.com>
 <CAA8EJpqvXb_Zdmq0O0KEA8mn5UkSriCZ02w16dts7Gd84R30oQ@mail.gmail.com>
 <aebdf7f6-48b7-43d3-95af-83859ddc593f@quicinc.com>
 <be9675a6-a01e-4cf7-95b3-174220d4a042@linaro.org>
From:   Bibek Kumar Patro <quic_bibekkum@quicinc.com>
In-Reply-To: <be9675a6-a01e-4cf7-95b3-174220d4a042@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6FGLHcVjYsQa_nW4-MOERmnWMQ5ie_py
X-Proofpoint-ORIG-GUID: 6FGLHcVjYsQa_nW4-MOERmnWMQ5ie_py
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_03,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 mlxlogscore=859 bulkscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311160046
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/15/2023 10:12 PM, Konrad Dybcio wrote:
> 
> 
> On 11/15/23 13:49, Bibek Kumar Patro wrote:
>>
>>
>> On 11/15/2023 4:15 PM, Dmitry Baryshkov wrote:
>>> On Wed, 15 Nov 2023 at 11:51, Bibek Kumar Patro
>>> <quic_bibekkum@quicinc.com> wrote:
>>>>
>>>>
>>>>
>>>> On 11/15/2023 3:08 PM, Dmitry Baryshkov wrote:
>>>>> On Wed, 15 Nov 2023 at 11:22, Bibek Kumar Patro
>>>>> <quic_bibekkum@quicinc.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 11/14/2023 7:42 PM, Dmitry Baryshkov wrote:
>>>>>>> On Tue, 14 Nov 2023 at 15:57, Bibek Kumar Patro
>>>>>>> <quic_bibekkum@quicinc.com> wrote:
>>>>>>>>
>>>>>>>> Add ACTLR data table for SM8550 along with support for
>>>>>>>> same including SM8550 specific implementation operations.
>>>>>>>>
>>>>>>>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
>>>>>>>> ---
>>>>>>>>     drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 92 
>>>>>>>> +++++++++++++++++++++-
>>>>>>>>     1 file changed, 88 insertions(+), 4 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c 
>>>>>>>> b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>>>>>> index 578c662c7c30..0eaf6f2a2e49 100644
>>>>>>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>>>>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>>>>>> @@ -25,6 +25,70 @@ struct actlr_data {
>>>>>>>>            u32 actlr;
>>>>>>>>     };
>>>>>>>>
>>>>>>>> +#define PRE_FETCH_1    0
>>>>>>>> +#define PRE_FETCH_2    BIT(8)
>>>>>>>> +#define PRE_FETCH_3    (BIT(9) | BIT(8))
>>>>>>>
>>>>>>> What is the difference between PRE_FETCH_3 and PRE_FETCH_2? And
>>>>>>> PRE_FETCH_1? Are these real numbers that refer to some amount / 
>>>>>>> count
>>>>>>> or just dummy names?
>>>>>>>
>>>>>>
>>>>>> No,these are not real numbers, but prefetch settings for a particular
>>>>>> perfect configuration.
>>>>>
>>>>> Then I'd ask for some better names or descriptions.
>>>>>
>>>>
>>>> Noted, PREFETCH_SETTING_n / PREFETCH_OPTION_n sounds like a better name
>>>> in the following case. Would it be okay to use this name instead?
>>>
>>> Not really.
>>>
>>
>> Any suggestion you have in mind, if not this nomenclature?
> Dmitry's concern seems to be that you provide:
> 
> PRE_FETCH_1 /* prefetcher with settings preset no. 1 */
> PRE_FETCH_2 /* prefetcher with settings preset no. 2 */
> PRE_FETCH_3 /* prefetcher with settings preset no. 3 */
> 
> whereas it would be both useful and interesting to see what these
> settings mean, i.e. what differences there are between all of
> these presets.
> 

Ah, okay got it now from Dimitry and yours' response.
But we exactly won't be able to reveal what each of these settings
mean, as this might risk of revealing IP as ACTLR bits are
implementation defined (except CPRE and CMTLB) which other SoC vendors
might be using it in different manner(or different purpose) in their
downstream implementation.
We can name it like (e.g PREFETCH_DISABLE, PREFETCH_SHALLOW,
PREFETCH_DEEP) to indicate the behaviour, but won't be exactly
name/describe it to explain what it does with a particular setting.

> Konrad

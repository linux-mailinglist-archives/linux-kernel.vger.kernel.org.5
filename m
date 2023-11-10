Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36CDD7E8108
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344840AbjKJSVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345698AbjKJSTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:19:04 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A306825A0F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 01:56:54 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AA7gNZu016850;
        Fri, 10 Nov 2023 09:56:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=+f81lNBssqmvCyVbghXVJmC+OBiJiM7fb6S1R7zuUjg=;
 b=e72UN57bAPhzOpbSN3y/PB5HfMR9aNCZWiFb2KWdvMILuHB9GO0no186yQnxtM/QiuDA
 r7YPoKSXH1y3c8rs6kTNjaCkCnviTeJ6QrM/ckNLRM31jQ1zdja00JyXQ963SLsRytpF
 hbxic492cYutRNUibp82th7BIeRKAQ2vprf/jlI1FY6wmUkDD1dYGqoDwMiRDtIchiC4
 NdDtTrmahvZRe79dr5wFBeKoSiC1J7f3CsQa3ZhqJ03py+cvwPPaBBMrHY7TJ7bvMoVG
 bJ+ZarEAJG7hn1Akpk3/XP1vaJ3n/Y1jqMQPsdwxjWq4V73ZnPp55XkBZEOexCRBNqq5 bw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u93rbstjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 09:56:38 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AA9ubGD005440
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 09:56:37 GMT
Received: from [10.50.63.40] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 10 Nov
 2023 01:56:31 -0800
Message-ID: <96be4011-2b0c-7d8d-d9c8-2380f37c6b22@quicinc.com>
Date:   Fri, 10 Nov 2023 15:25:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 2/3] iommu/arm-smmu: add ACTLR data and support for SM8550
Content-Language: en-US
To:     Bibek Kumar Patro <quic_bibekkum@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <a39.skl@gmail.com>, <konrad.dybcio@linaro.org>,
        <quic_saipraka@quicinc.com>, <quic_pkondeti@quicinc.com>,
        <quic_molvera@quicinc.com>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <qipl.kernel.upstream@quicinc.com>
References: <20231103215124.1095-1-quic_bibekkum@quicinc.com>
 <20231103215124.1095-3-quic_bibekkum@quicinc.com>
 <CAA8EJpqWdHwF_mZoXt8wpYeKLWQEFs3H83c-OsLVYVGYmi5mkQ@mail.gmail.com>
 <fff5184b-3bf6-4f40-b99f-e77c01342fcc@quicinc.com>
 <CAA8EJprkO=XZ=4na-JAKDsoKOxLt_AG42HQ4JTVNTZ2BSu8YdQ@mail.gmail.com>
 <e3d96ed5-af32-4087-b7df-d960eaf39797@quicinc.com>
 <CAA8EJprKc-ju50kON4aQAaXyeJy9iv5LuVgm-sMZ00Coqh1SYA@mail.gmail.com>
 <a81e505e-338a-4a31-96e9-735e1a9e8631@quicinc.com>
From:   Pratyush Brahma <quic_pbrahma@quicinc.com>
In-Reply-To: <a81e505e-338a-4a31-96e9-735e1a9e8631@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: parO0Ryr2zMA8P1mKRFPBG93tOVM6yUJ
X-Proofpoint-ORIG-GUID: parO0Ryr2zMA8P1mKRFPBG93tOVM6yUJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_06,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311100080
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06-11-2023 17:39, Bibek Kumar Patro wrote:
>
>
> On 11/6/2023 2:35 PM, Dmitry Baryshkov wrote:
>> On Mon, 6 Nov 2023 at 08:10, Bibek Kumar Patro
>> <quic_bibekkum@quicinc.com> wrote:
>>>
>>>
>>>
>>> On 11/4/2023 4:11 AM, Dmitry Baryshkov wrote:
>>>> On Sat, 4 Nov 2023 at 00:38, Bibek Kumar Patro
>>>> <quic_bibekkum@quicinc.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 11/4/2023 3:31 AM, Dmitry Baryshkov wrote:
>>>>>> On Fri, 3 Nov 2023 at 23:53, Bibek Kumar Patro
>>>>>> <quic_bibekkum@quicinc.com> wrote:
>>>>>>>
>>>>>>> Add ACTLR data table for SM8550 along with support for
>>>>>>> same including SM8550 specific implementation operations.
>>>>>>>
>>>>>>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
>>>>>>> ---
>>>>>>>     drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 85 
>>>>>>> +++++++++++++++++++++-
>>>>>>>     1 file changed, 81 insertions(+), 4 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c 
>>>>>>> b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>>>>> index 68c1f4908473..590b7c285299 100644
>>>>>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>>>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>>>>> @@ -25,6 +25,64 @@ struct actlr_data {
>>>>>>>            u32 actlr;
>>>>>>>     };
>>>>>>>
>>>>>>> +static const struct actlr_data sm8550_apps_actlr_data[] = {
>>>>>>> +       { 0x18a0, 0x0000, 0x00000103 },
>>>>>>> +       { 0x18e0, 0x0000, 0x00000103 },
>>>>>>> +       { 0x0800, 0x0020, 0x00000001 },
>>>>>>> +       { 0x1800, 0x00c0, 0x00000001 },
>>>>>>> +       { 0x1820, 0x0000, 0x00000001 },
>>>>>>> +       { 0x1860, 0x0000, 0x00000001 },
>>>>>>> +       { 0x0c01, 0x0020, 0x00000303 },
>>>>>>> +       { 0x0c02, 0x0020, 0x00000303 },
>>>>>>> +       { 0x0c03, 0x0020, 0x00000303 },
>>>>>>> +       { 0x0c04, 0x0020, 0x00000303 },
>>>>>>> +       { 0x0c05, 0x0020, 0x00000303 },
>>>>>>> +       { 0x0c06, 0x0020, 0x00000303 },
>>>>>>> +       { 0x0c07, 0x0020, 0x00000303 },
>>>>>>> +       { 0x0c08, 0x0020, 0x00000303 },
>>>>>>> +       { 0x0c09, 0x0020, 0x00000303 },
>>>>>>> +       { 0x0c0c, 0x0020, 0x00000303 },
>>>>>>> +       { 0x0c0d, 0x0020, 0x00000303 },
>>>>>>> +       { 0x0c0e, 0x0020, 0x00000303 },
>>>>>>> +       { 0x0c0f, 0x0020, 0x00000303 },
>>>>>>> +       { 0x1961, 0x0000, 0x00000303 },
>>>>>>> +       { 0x1962, 0x0000, 0x00000303 },
>>>>>>> +       { 0x1963, 0x0000, 0x00000303 },
>>>>>>> +       { 0x1964, 0x0000, 0x00000303 },
>>>>>>> +       { 0x1965, 0x0000, 0x00000303 },
>>>>>>> +       { 0x1966, 0x0000, 0x00000303 },
>>>>>>> +       { 0x1967, 0x0000, 0x00000303 },
>>>>>>> +       { 0x1968, 0x0000, 0x00000303 },
>>>>>>> +       { 0x1969, 0x0000, 0x00000303 },
>>>>>>> +       { 0x196c, 0x0000, 0x00000303 },
>>>>>>> +       { 0x196d, 0x0000, 0x00000303 },
>>>>>>> +       { 0x196e, 0x0000, 0x00000303 },
>>>>>>> +       { 0x196f, 0x0000, 0x00000303 },
>>>>>>> +       { 0x19c1, 0x0010, 0x00000303 },
>>>>>>> +       { 0x19c2, 0x0010, 0x00000303 },
>>>>>>> +       { 0x19c3, 0x0010, 0x00000303 },
>>>>>>> +       { 0x19c4, 0x0010, 0x00000303 },
>>>>>>> +       { 0x19c5, 0x0010, 0x00000303 },
>>>>>>> +       { 0x19c6, 0x0010, 0x00000303 },
>>>>>>> +       { 0x19c7, 0x0010, 0x00000303 },
>>>>>>> +       { 0x19c8, 0x0010, 0x00000303 },
>>>>>>> +       { 0x19c9, 0x0010, 0x00000303 },
>>>>>>> +       { 0x19cc, 0x0010, 0x00000303 },
>>>>>>> +       { 0x19cd, 0x0010, 0x00000303 },
>>>>>>> +       { 0x19ce, 0x0010, 0x00000303 },
>>>>>>> +       { 0x19cf, 0x0010, 0x00000303 },
>>>>>>> +       { 0x1c00, 0x0002, 0x00000103 },
>>>>>>> +       { 0x1c01, 0x0000, 0x00000001 },
>>>>>>> +       { 0x1920, 0x0000, 0x00000103 },
>>>>>>> +       { 0x1923, 0x0000, 0x00000103 },
>>>>>>> +       { 0x1924, 0x0000, 0x00000103 },
>>>>>>> +       { 0x1940, 0x0000, 0x00000103 },
>>>>>>> +       { 0x1941, 0x0004, 0x00000103 },
>>>>>>> +       { 0x1943, 0x0000, 0x00000103 },
>>>>>>> +       { 0x1944, 0x0000, 0x00000103 },
>>>>>>> +       { 0x1947, 0x0000, 0x00000103 },
>>>>>>> +};
>>>>>>
>>>>>> This is nearly impossible to handle.
>>>>>> Please add defines for 0x1, 0x103 and 0x303. Also please consider
>>>>>> adding comments for the devices.
>>>>>>
>>>>>
>>>>> Ack, Initially added the comments for devices, but since only 
>>>>> driver is
>>>>> handling this data, and clients won't refer this so removed it. Will
>>>>> consider adding it back.
>>>>
>>>> It will help developers / porters who will try matching the SID and 
>>>> the device.
>>>>
>>>
>>> Agree on the same, I'll add those comments for devices back.
TBH, I don't see much value add in adding comments for device names as 
developers
are aware of the SIDs they use and can refer to them in the table if 
they wish to.
Secondly, developers need not care about this configuration unless they 
want to modify it which
  is not the case here as these are platform specific configurations. I 
think, only adding
the defines for the actlr reg values should suffice.
>>>>>    This actlr field value might different (other
>>>>> than 0x1,0x103,0x303) in other platforms as per my anticipation,
>>>>> depending on the bit settings, so won't the defines change with
>>>>> different platforms? Hence this register setting value might be apt?
>>>>
>>>> It is simple. 0x1, 0x103 and 0x303 are pure magic values. Please
>>>> provide sensible defines so that we can understand and review them.
>>>>
>>>
>>> Understandable, In next patch I'll populate the actlr_data in
>>> following format { SID, MASK, PRE_FETCH_n | CPRE | CMTLB }.
>>> where " PRE_FETCH_n | CPRE | CMTLB " will be defines for
>>> the actlr values (0x1,0x103,0x303).
>>> This would help in understanding these values. Hope this
>>> proposed format will be okay?
>>
>> Yes, this sounds good. Please also add description for CPRE and CMTLB 
>> bits.
>>
>
> Thanks for the confirmation. Sure will add the descriptions for
> CPRE and CMTLB bits as well in v2
>
>>>
>>>
>>>> Other platforms might use new defines.
>>>>
>>>>>
>>>>>>> +
>>>>>>>     static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device 
>>>>>>> *smmu)
>>>>>>>     {
>>>>>>>            return container_of(smmu, struct qcom_smmu, smmu);
>>>>>>> @@ -444,6 +502,16 @@ static const struct arm_smmu_impl 
>>>>>>> sdm845_smmu_500_impl = {
>>>>>>>            .tlb_sync = qcom_smmu_tlb_sync,
>>>>>>>     };
>>>>>>>
>>>>>>> +
>>>>>>> +static const struct arm_smmu_impl sm8550_smmu_500_impl = {
>>>>>>> +       .init_context = qcom_smmu_init_context,
>>>>>>> +       .cfg_probe = qcom_smmu_cfg_probe,
>>>>>>> +       .def_domain_type = qcom_smmu_def_domain_type,
>>>>>>> +       .reset = arm_mmu500_reset,
>>>>>>> +       .write_s2cr = qcom_smmu_write_s2cr,
>>>>>>> +       .tlb_sync = qcom_smmu_tlb_sync,
>>>>>>> +};
>>>>>>> +
>>>>>>>     static const struct arm_smmu_impl qcom_adreno_smmu_v2_impl = {
>>>>>>>            .init_context = qcom_adreno_smmu_init_context,
>>>>>>>            .def_domain_type = qcom_smmu_def_domain_type,
>>>>>>> @@ -507,6 +575,11 @@ static const struct qcom_smmu_config 
>>>>>>> qcom_smmu_impl0_cfg = {
>>>>>>>            .reg_offset = qcom_smmu_impl0_reg_offset,
>>>>>>>     };
>>>>>>>
>>>>>>> +static const struct actlr_config sm8550_actlrcfg = {
>>>>>>> +       .adata = sm8550_apps_actlr_data,
>>>>>>> +       .size = ARRAY_SIZE(sm8550_apps_actlr_data),
>>>>>>> +};
>>>>>>> +
>>>>>>>     /*
>>>>>>>      * It is not yet possible to use MDP SMMU with the bypass 
>>>>>>> quirk on the msm8996,
>>>>>>>      * there are not enough context banks.
>>>>>>> @@ -530,16 +603,20 @@ static const struct qcom_smmu_match_data 
>>>>>>> sdm845_smmu_500_data = {
>>>>>>>            /* Also no debug configuration. */
>>>>>>>     };
>>>>>>>
>>>>>>> +
>>>>>>> +static const struct qcom_smmu_match_data 
>>>>>>> sm8550_smmu_500_impl0_data = {
>>>>>>> +       .impl = &sm8550_smmu_500_impl,
>>>>>>> +       .adreno_impl = &qcom_adreno_smmu_500_impl,
>>>>>>> +       .cfg = &qcom_smmu_impl0_cfg,
>>>>>>> +       .actlrcfg = &sm8550_actlrcfg,
>>>>>>> +};
>>>>>>
>>>>>> This structure doesn't seem to be linked. Did you test your patches?
>>>>>>
>>>>>
>>>>> Apologies Dmitry, just checked back my patches, I tested it but while
>>>>> refining the patches I somehow missed this link
>>>>> { .compatible = "qcom,sm8550-smmu-500", .data =
>>>>> &sm8550_smmu_500_impl0_data };
>>>>> in below qcom_smmu_500_impl0_data structure.
>>>>> I will take care of this in next version.
>>>>>
>>>>>>> +
>>>>>>>     static const struct qcom_smmu_match_data 
>>>>>>> qcom_smmu_500_impl0_data = {
>>>>>>>            .impl = &qcom_smmu_500_impl,
>>>>>>>            .adreno_impl = &qcom_adreno_smmu_500_impl,
>>>>>>>            .cfg = &qcom_smmu_impl0_cfg,
>>>>>>>     };
>>>>>>>
>>>>>>> -/*
>>>>>>> - * Do not add any more qcom,SOC-smmu-500 entries to this list, 
>>>>>>> unless they need
>>>>>>> - * special handling and can not be covered by the qcom,smmu-500 
>>>>>>> entry.
>>>>>>> - */
>>>>>>
>>>>>> Leave the comment in place.
>>>>>>
>>>>>
>>>>> Thanks for this comment which helped me to note the above mentioned
>>>>> mistake.
>>>>>
>>>>>>>     static const struct of_device_id __maybe_unused 
>>>>>>> qcom_smmu_impl_of_match[] = {
>>>>>>>            { .compatible = "qcom,msm8996-smmu-v2", .data = 
>>>>>>> &msm8996_smmu_data },
>>>>>>>            { .compatible = "qcom,msm8998-smmu-v2", .data = 
>>>>>>> &qcom_smmu_v2_data },
>>>>>>> -- 
>>>>>>> 2.17.1
>>>>>>>
>>>>>>
>>>>>>
>>>>
>>>>
>>>>
>>
>>
>>
Thanks,

Pratyush


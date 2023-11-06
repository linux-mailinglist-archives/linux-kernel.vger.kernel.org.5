Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9B57E2100
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 13:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjKFMKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 07:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjKFMKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 07:10:16 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649E510DF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 04:10:12 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6BblIK025959;
        Mon, 6 Nov 2023 12:09:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=YBWg+rqSe3Bkwlvki3ygcn3UCtKANQDJB+BtyVCblWU=;
 b=mxyhSTrqw3yf31qh77MlzSw01ebPZ0BV42cNoYM7fx2zzA34UByZvNrEkSvcsGch7sbS
 WjJtSBwptOsQBScySLz9Y3aFGMgHCrckL2uTLhbufd0RVnAogV7pnqBCPYRZqlghulrV
 CD0uNsEKnZlXH/Lp7K/V0wl1lVt88j2D/biRyj4lBXUqRC5eWdxxxpvDpX3+Ee+l/SFV
 Pq0J/lDs4Jk9xqDKg7CGJJhcZHALinf9BIEyOXWb7KUK5Jzoe+olQcGNJ3IcynmfvcNw
 PoCZWjDZ6h4pfcU7/5z/gEPRsPxZSaa8cxXHMyZqeCF7h3JCNfa9/faXR2EpGqfFqt48 XA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u6yehr48u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 12:09:54 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A6C9rGO006846
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Nov 2023 12:09:53 GMT
Received: from [10.214.66.253] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 6 Nov
 2023 04:09:48 -0800
Message-ID: <a81e505e-338a-4a31-96e9-735e1a9e8631@quicinc.com>
Date:   Mon, 6 Nov 2023 17:39:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] iommu/arm-smmu: add ACTLR data and support for SM8550
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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
From:   Bibek Kumar Patro <quic_bibekkum@quicinc.com>
In-Reply-To: <CAA8EJprKc-ju50kON4aQAaXyeJy9iv5LuVgm-sMZ00Coqh1SYA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0EXME2_-EkBespPJGP2C3nHQmyi_AuPZ
X-Proofpoint-ORIG-GUID: 0EXME2_-EkBespPJGP2C3nHQmyi_AuPZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_10,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 suspectscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060099
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/6/2023 2:35 PM, Dmitry Baryshkov wrote:
> On Mon, 6 Nov 2023 at 08:10, Bibek Kumar Patro
> <quic_bibekkum@quicinc.com> wrote:
>>
>>
>>
>> On 11/4/2023 4:11 AM, Dmitry Baryshkov wrote:
>>> On Sat, 4 Nov 2023 at 00:38, Bibek Kumar Patro
>>> <quic_bibekkum@quicinc.com> wrote:
>>>>
>>>>
>>>>
>>>> On 11/4/2023 3:31 AM, Dmitry Baryshkov wrote:
>>>>> On Fri, 3 Nov 2023 at 23:53, Bibek Kumar Patro
>>>>> <quic_bibekkum@quicinc.com> wrote:
>>>>>>
>>>>>> Add ACTLR data table for SM8550 along with support for
>>>>>> same including SM8550 specific implementation operations.
>>>>>>
>>>>>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
>>>>>> ---
>>>>>>     drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 85 +++++++++++++++++++++-
>>>>>>     1 file changed, 81 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>>>> index 68c1f4908473..590b7c285299 100644
>>>>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>>>> @@ -25,6 +25,64 @@ struct actlr_data {
>>>>>>            u32 actlr;
>>>>>>     };
>>>>>>
>>>>>> +static const struct actlr_data sm8550_apps_actlr_data[] = {
>>>>>> +       { 0x18a0, 0x0000, 0x00000103 },
>>>>>> +       { 0x18e0, 0x0000, 0x00000103 },
>>>>>> +       { 0x0800, 0x0020, 0x00000001 },
>>>>>> +       { 0x1800, 0x00c0, 0x00000001 },
>>>>>> +       { 0x1820, 0x0000, 0x00000001 },
>>>>>> +       { 0x1860, 0x0000, 0x00000001 },
>>>>>> +       { 0x0c01, 0x0020, 0x00000303 },
>>>>>> +       { 0x0c02, 0x0020, 0x00000303 },
>>>>>> +       { 0x0c03, 0x0020, 0x00000303 },
>>>>>> +       { 0x0c04, 0x0020, 0x00000303 },
>>>>>> +       { 0x0c05, 0x0020, 0x00000303 },
>>>>>> +       { 0x0c06, 0x0020, 0x00000303 },
>>>>>> +       { 0x0c07, 0x0020, 0x00000303 },
>>>>>> +       { 0x0c08, 0x0020, 0x00000303 },
>>>>>> +       { 0x0c09, 0x0020, 0x00000303 },
>>>>>> +       { 0x0c0c, 0x0020, 0x00000303 },
>>>>>> +       { 0x0c0d, 0x0020, 0x00000303 },
>>>>>> +       { 0x0c0e, 0x0020, 0x00000303 },
>>>>>> +       { 0x0c0f, 0x0020, 0x00000303 },
>>>>>> +       { 0x1961, 0x0000, 0x00000303 },
>>>>>> +       { 0x1962, 0x0000, 0x00000303 },
>>>>>> +       { 0x1963, 0x0000, 0x00000303 },
>>>>>> +       { 0x1964, 0x0000, 0x00000303 },
>>>>>> +       { 0x1965, 0x0000, 0x00000303 },
>>>>>> +       { 0x1966, 0x0000, 0x00000303 },
>>>>>> +       { 0x1967, 0x0000, 0x00000303 },
>>>>>> +       { 0x1968, 0x0000, 0x00000303 },
>>>>>> +       { 0x1969, 0x0000, 0x00000303 },
>>>>>> +       { 0x196c, 0x0000, 0x00000303 },
>>>>>> +       { 0x196d, 0x0000, 0x00000303 },
>>>>>> +       { 0x196e, 0x0000, 0x00000303 },
>>>>>> +       { 0x196f, 0x0000, 0x00000303 },
>>>>>> +       { 0x19c1, 0x0010, 0x00000303 },
>>>>>> +       { 0x19c2, 0x0010, 0x00000303 },
>>>>>> +       { 0x19c3, 0x0010, 0x00000303 },
>>>>>> +       { 0x19c4, 0x0010, 0x00000303 },
>>>>>> +       { 0x19c5, 0x0010, 0x00000303 },
>>>>>> +       { 0x19c6, 0x0010, 0x00000303 },
>>>>>> +       { 0x19c7, 0x0010, 0x00000303 },
>>>>>> +       { 0x19c8, 0x0010, 0x00000303 },
>>>>>> +       { 0x19c9, 0x0010, 0x00000303 },
>>>>>> +       { 0x19cc, 0x0010, 0x00000303 },
>>>>>> +       { 0x19cd, 0x0010, 0x00000303 },
>>>>>> +       { 0x19ce, 0x0010, 0x00000303 },
>>>>>> +       { 0x19cf, 0x0010, 0x00000303 },
>>>>>> +       { 0x1c00, 0x0002, 0x00000103 },
>>>>>> +       { 0x1c01, 0x0000, 0x00000001 },
>>>>>> +       { 0x1920, 0x0000, 0x00000103 },
>>>>>> +       { 0x1923, 0x0000, 0x00000103 },
>>>>>> +       { 0x1924, 0x0000, 0x00000103 },
>>>>>> +       { 0x1940, 0x0000, 0x00000103 },
>>>>>> +       { 0x1941, 0x0004, 0x00000103 },
>>>>>> +       { 0x1943, 0x0000, 0x00000103 },
>>>>>> +       { 0x1944, 0x0000, 0x00000103 },
>>>>>> +       { 0x1947, 0x0000, 0x00000103 },
>>>>>> +};
>>>>>
>>>>> This is nearly impossible to handle.
>>>>> Please add defines for 0x1, 0x103 and 0x303. Also please consider
>>>>> adding comments for the devices.
>>>>>
>>>>
>>>> Ack, Initially added the comments for devices, but since only driver is
>>>> handling this data, and clients won't refer this so removed it. Will
>>>> consider adding it back.
>>>
>>> It will help developers / porters who will try matching the SID and the device.
>>>
>>
>> Agree on the same, I'll add those comments for devices back.
>>
>>>>    This actlr field value might different (other
>>>> than 0x1,0x103,0x303) in other platforms as per my anticipation,
>>>> depending on the bit settings, so won't the defines change with
>>>> different platforms? Hence this register setting value might be apt?
>>>
>>> It is simple. 0x1, 0x103 and 0x303 are pure magic values. Please
>>> provide sensible defines so that we can understand and review them.
>>>
>>
>> Understandable, In next patch I'll populate the actlr_data in
>> following format { SID, MASK, PRE_FETCH_n | CPRE | CMTLB }.
>> where " PRE_FETCH_n | CPRE | CMTLB " will be defines for
>> the actlr values (0x1,0x103,0x303).
>> This would help in understanding these values. Hope this
>> proposed format will be okay?
> 
> Yes, this sounds good. Please also add description for CPRE and CMTLB bits.
> 

Thanks for the confirmation. Sure will add the descriptions for
CPRE and CMTLB bits as well in v2

>>
>>
>>> Other platforms might use new defines.
>>>
>>>>
>>>>>> +
>>>>>>     static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
>>>>>>     {
>>>>>>            return container_of(smmu, struct qcom_smmu, smmu);
>>>>>> @@ -444,6 +502,16 @@ static const struct arm_smmu_impl sdm845_smmu_500_impl = {
>>>>>>            .tlb_sync = qcom_smmu_tlb_sync,
>>>>>>     };
>>>>>>
>>>>>> +
>>>>>> +static const struct arm_smmu_impl sm8550_smmu_500_impl = {
>>>>>> +       .init_context = qcom_smmu_init_context,
>>>>>> +       .cfg_probe = qcom_smmu_cfg_probe,
>>>>>> +       .def_domain_type = qcom_smmu_def_domain_type,
>>>>>> +       .reset = arm_mmu500_reset,
>>>>>> +       .write_s2cr = qcom_smmu_write_s2cr,
>>>>>> +       .tlb_sync = qcom_smmu_tlb_sync,
>>>>>> +};
>>>>>> +
>>>>>>     static const struct arm_smmu_impl qcom_adreno_smmu_v2_impl = {
>>>>>>            .init_context = qcom_adreno_smmu_init_context,
>>>>>>            .def_domain_type = qcom_smmu_def_domain_type,
>>>>>> @@ -507,6 +575,11 @@ static const struct qcom_smmu_config qcom_smmu_impl0_cfg = {
>>>>>>            .reg_offset = qcom_smmu_impl0_reg_offset,
>>>>>>     };
>>>>>>
>>>>>> +static const struct actlr_config sm8550_actlrcfg = {
>>>>>> +       .adata = sm8550_apps_actlr_data,
>>>>>> +       .size = ARRAY_SIZE(sm8550_apps_actlr_data),
>>>>>> +};
>>>>>> +
>>>>>>     /*
>>>>>>      * It is not yet possible to use MDP SMMU with the bypass quirk on the msm8996,
>>>>>>      * there are not enough context banks.
>>>>>> @@ -530,16 +603,20 @@ static const struct qcom_smmu_match_data sdm845_smmu_500_data = {
>>>>>>            /* Also no debug configuration. */
>>>>>>     };
>>>>>>
>>>>>> +
>>>>>> +static const struct qcom_smmu_match_data sm8550_smmu_500_impl0_data = {
>>>>>> +       .impl = &sm8550_smmu_500_impl,
>>>>>> +       .adreno_impl = &qcom_adreno_smmu_500_impl,
>>>>>> +       .cfg = &qcom_smmu_impl0_cfg,
>>>>>> +       .actlrcfg = &sm8550_actlrcfg,
>>>>>> +};
>>>>>
>>>>> This structure doesn't seem to be linked. Did you test your patches?
>>>>>
>>>>
>>>> Apologies Dmitry, just checked back my patches, I tested it but while
>>>> refining the patches I somehow missed this link
>>>> { .compatible = "qcom,sm8550-smmu-500", .data =
>>>> &sm8550_smmu_500_impl0_data };
>>>> in below qcom_smmu_500_impl0_data structure.
>>>> I will take care of this in next version.
>>>>
>>>>>> +
>>>>>>     static const struct qcom_smmu_match_data qcom_smmu_500_impl0_data = {
>>>>>>            .impl = &qcom_smmu_500_impl,
>>>>>>            .adreno_impl = &qcom_adreno_smmu_500_impl,
>>>>>>            .cfg = &qcom_smmu_impl0_cfg,
>>>>>>     };
>>>>>>
>>>>>> -/*
>>>>>> - * Do not add any more qcom,SOC-smmu-500 entries to this list, unless they need
>>>>>> - * special handling and can not be covered by the qcom,smmu-500 entry.
>>>>>> - */
>>>>>
>>>>> Leave the comment in place.
>>>>>
>>>>
>>>> Thanks for this comment which helped me to note the above mentioned
>>>> mistake.
>>>>
>>>>>>     static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
>>>>>>            { .compatible = "qcom,msm8996-smmu-v2", .data = &msm8996_smmu_data },
>>>>>>            { .compatible = "qcom,msm8998-smmu-v2", .data = &qcom_smmu_v2_data },
>>>>>> --
>>>>>> 2.17.1
>>>>>>
>>>>>
>>>>>
>>>
>>>
>>>
> 
> 
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1317DF148
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 12:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjKBLlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 07:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjKBLlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 07:41:51 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DF7133;
        Thu,  2 Nov 2023 04:41:45 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2BY6si010226;
        Thu, 2 Nov 2023 11:41:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=HYFeSr3Ca6VgHP1HrIZZ/ANIQUbp9JhkZ49XbBpGA/o=;
 b=mpula0utnFfPgbWqGkMSzrum9qRZTo8sixlTigyICyVzYQ8myw0tSxZbnguthD0ZBjTp
 BOCqvWnQSBa5Swrc0FecCr3WGBjuxEJ589zA3JQrZF2X3lqNx018LD1Xt5Zm6lwLwo+V
 WfN/iu2iNp7G3sIyzilBanmzVvxq/6Hp+MWm7zB/jNu+vkfXB0wwmp5xToAN2L0hGovx
 ejga1e44vxxJw2VZ1+u9UVeK0DisXkEm5VHDnPRGXntUgNS9J7+UySIx+KjrE3l8Eipc
 pfL3LE8Io+gDpzIv8MHDsECIHtkrjMDRa2nQTVP5wgQhLV7SuQ0IJ3gX4p2Q2Fe3F4TS 3g== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u3y5y19yt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Nov 2023 11:41:34 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A2BfXPX013205
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Nov 2023 11:41:33 GMT
Received: from [10.216.63.119] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 2 Nov
 2023 04:41:28 -0700
Message-ID: <fe8a7217-51af-1102-80eb-db4475bb47fc@quicinc.com>
Date:   Thu, 2 Nov 2023 17:11:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/3] remoteproc: qcom: pas: make region assign more
 generic
Content-Language: en-US
To:     <neil.armstrong@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20231030-topic-sm8650-upstream-remoteproc-v2-0-609ee572e0a2@linaro.org>
 <20231030-topic-sm8650-upstream-remoteproc-v2-2-609ee572e0a2@linaro.org>
 <8e71ba02-5d6a-4c7e-4a55-f9ef79c2f928@quicinc.com>
 <65dcdd9c-a75b-4fe7-bdcf-471a5602db20@linaro.org>
 <a6bffac4-8c9c-6b85-290e-c991e8ab319a@quicinc.com>
 <c654555d-f50f-411c-b61d-190da598d5e1@linaro.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <c654555d-f50f-411c-b61d-190da598d5e1@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: z982-KoIHuI-AiHPqKhDSTk_-B8ea3o2
X-Proofpoint-ORIG-GUID: z982-KoIHuI-AiHPqKhDSTk_-B8ea3o2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_23,2023-11-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311020093
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/2/2023 3:56 PM, neil.armstrong@linaro.org wrote:
> On 01/11/2023 15:42, Mukesh Ojha wrote:
>>
>>
>> On 10/31/2023 10:36 PM, Neil Armstrong wrote:
>>> Hi,
>>>
>>> On 30/10/2023 14:10, Mukesh Ojha wrote:
>>>>
>>>>
>>>> On 10/30/2023 3:33 PM, Neil Armstrong wrote:
>>>>> The current memory region assign only supports a single
>>>>> memory region.
>>>>>
>>>>> But new platforms introduces more regions to make the
>>>>> memory requirements more flexible for various use cases.
>>>>> Those new platforms also shares the memory region between the
>>>>> DSP and HLOS.
>>>>>
>>>>> To handle this, make the region assign more generic in order
>>>>> to support more than a single memory region and also permit
>>>>> setting the regions permissions as shared.
>>>>>
>>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>>> ---
>>>>>   drivers/remoteproc/qcom_q6v5_pas.c | 102 
>>>>> ++++++++++++++++++++++++-------------
>>>>>   1 file changed, 66 insertions(+), 36 deletions(-)
>>>>>
>>>>> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c 
>>>>> b/drivers/remoteproc/qcom_q6v5_pas.c
>>>>> index 913a5d2068e8..4829fd26e17d 100644
>>>>> --- a/drivers/remoteproc/qcom_q6v5_pas.c
>>>>> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
>>>>> @@ -33,6 +33,8 @@
>>>>>   #define ADSP_DECRYPT_SHUTDOWN_DELAY_MS    100
>>>>> +#define MAX_ASSIGN_COUNT 2
>>>>> +
>>>>>   struct adsp_data {
>>>>>       int crash_reason_smem;
>>>>>       const char *firmware_name;
>>>>> @@ -51,6 +53,9 @@ struct adsp_data {
>>>>>       int ssctl_id;
>>>>>       int region_assign_idx;
>>>>> +    int region_assign_count;
>>>>> +    bool region_assign_shared;
>>>>> +    int region_assign_vmid;
>>>>>   };
>>>>>   struct qcom_adsp {
>>>>> @@ -87,15 +92,18 @@ struct qcom_adsp {
>>>>>       phys_addr_t dtb_mem_phys;
>>>>>       phys_addr_t mem_reloc;
>>>>>       phys_addr_t dtb_mem_reloc;
>>>>> -    phys_addr_t region_assign_phys;
>>>>> +    phys_addr_t region_assign_phys[MAX_ASSIGN_COUNT];
>>>>>       void *mem_region;
>>>>>       void *dtb_mem_region;
>>>>>       size_t mem_size;
>>>>>       size_t dtb_mem_size;
>>>>> -    size_t region_assign_size;
>>>>> +    size_t region_assign_size[MAX_ASSIGN_COUNT];
>>>>>       int region_assign_idx;
>>>>> -    u64 region_assign_perms;
>>>>> +    int region_assign_count;
>>>>> +    bool region_assign_shared;
>>>>> +    int region_assign_vmid;
>>>>> +    u64 region_assign_perms[MAX_ASSIGN_COUNT];
>>>>>       struct qcom_rproc_glink glink_subdev;
>>>>>       struct qcom_rproc_subdev smd_subdev;
>>>>> @@ -590,37 +598,52 @@ static int adsp_alloc_memory_region(struct 
>>>>> qcom_adsp *adsp)
>>>>>   static int adsp_assign_memory_region(struct qcom_adsp *adsp)
>>>>>   {
>>>>> -    struct reserved_mem *rmem = NULL;
>>>>> -    struct qcom_scm_vmperm perm;
>>>>> +    struct qcom_scm_vmperm perm[MAX_ASSIGN_COUNT];
>>>>> +    unsigned int perm_size = 1;
>>>>
>>>> AFAICS, not need of initialization.
>>>
>>> Indeed, removed
>>>
>>>>
>>>>>       struct device_node *node;
>>>>> -    int ret;
>>>>> +    int offset, ret;
>>>>
>>>> Nit: one variable per line.
>>>
>>> Done
>>>
>>>>
>>>>>       if (!adsp->region_assign_idx)
>>>>
>>>> Not related to this patch..
>>>> Should not this be valid only for > 1 ?
>>>
>>> I don't understand, only region_assign_idx > 1 triggers a memory_assign,
>>> and this check discards configurations with region_assign_idx == 0 as
>>> expected.
>>
>> Ah, you can ignore the comments, I got the intention after commenting
>> here ..
>>
>>>
>>>>
>>>>
>>>>>           return 0;
>>>>> -    node = of_parse_phandle(adsp->dev->of_node, "memory-region", 
>>>>> adsp->region_assign_idx);
>>>>> -    if (node)
>>>>> -        rmem = of_reserved_mem_lookup(node);
>>>>> -    of_node_put(node);
>>>>> -    if (!rmem) {
>>>>> -        dev_err(adsp->dev, "unable to resolve shareable 
>>>>> memory-region\n");
>>>>> -        return -EINVAL;
>>>>> -    }
>>>>> +    for (offset = 0; offset < adsp->region_assign_count; ++offset) {
>>>>> +        struct reserved_mem *rmem = NULL;
>>>>> +
>>>>> +        node = of_parse_phandle(adsp->dev->of_node, "memory-region",
>>>>> +                    adsp->region_assign_idx + offset);
>>>>> +        if (node)
>>>>> +            rmem = of_reserved_mem_lookup(node);
>>>>> +        of_node_put(node);
>>>>> +        if (!rmem) {
>>>>> +            dev_err(adsp->dev, "unable to resolve shareable 
>>>>> memory-region index %d\n",
>>>>> +                offset);
>>>>> +            return -EINVAL; > +        }
>>>>
>>>>
>>>>> -    perm.vmid = QCOM_SCM_VMID_MSS_MSA;
>>>>> -    perm.perm = QCOM_SCM_PERM_RW;
>>>>> +        if (adsp->region_assign_shared)  {
>>>>> +            perm[0].vmid = QCOM_SCM_VMID_HLOS;
>>>>> +            perm[0].perm = QCOM_SCM_PERM_RW;
>>>>> +            perm[1].vmid = adsp->region_assign_vmid;
>>>>> +            perm[1].perm = QCOM_SCM_PERM_RW;
>>>>> +            perm_size = 2;
>>>>> +        } else {
>>>>> +            perm[0].vmid = adsp->region_assign_vmid;
>>>>> +            perm[0].perm = QCOM_SCM_PERM_RW;
>>>>> +            perm_size = 1;
>>>>> +        }
>>>>> -    adsp->region_assign_phys = rmem->base;
>>>>> -    adsp->region_assign_size = rmem->size;
>>>>> -    adsp->region_assign_perms = BIT(QCOM_SCM_VMID_HLOS);
>>>>> +        adsp->region_assign_phys[offset] = rmem->base;
>>>>> +        adsp->region_assign_size[offset] = rmem->size;
>>>>> +        adsp->region_assign_perms[offset] = BIT(QCOM_SCM_VMID_HLOS);
>>>>
>>>> Do we need array for this, is this changing ?
>>>
>>> We need to keep region_assign_perms for unassign, but for the other 2 
>>> we would
>>> need to duplicate the code from adsp_assign_memory_region into
>>> adsp_unassign_memory_region.
>>
>> Thanks got it.
>>
>>>
>>>>
>>>>> -    ret = qcom_scm_assign_mem(adsp->region_assign_phys,
>>>>> -                  adsp->region_assign_size,
>>>>> -                  &adsp->region_assign_perms,
>>>>> -                  &perm, 1);
>>>>> -    if (ret < 0) {
>>>>> -        dev_err(adsp->dev, "assign memory failed\n");
>>>>> -        return ret;
>>>>> +        ret = qcom_scm_assign_mem(adsp->region_assign_phys[offset],
>>>>> +                      adsp->region_assign_size[offset],
>>>>> +                      &adsp->region_assign_perms[offset],
>>>>> +                      perm, perm_size);
>>>>> +        if (ret < 0) {
>>>>> +            dev_err(adsp->dev, "assign memory %d failed\n", offset);
>>>>> +            return ret;
>>>>> +        }
>>>>>       }
>>>>>       return 0;
>>>>> @@ -629,20 +652,22 @@ static int adsp_assign_memory_region(struct 
>>>>> qcom_adsp *adsp)
>>>>>   static void adsp_unassign_memory_region(struct qcom_adsp *adsp)
>>>>>   {
>>>>>       struct qcom_scm_vmperm perm;
>>>>> -    int ret;
>>>>> +    int offset, ret;
>>>>> -    if (!adsp->region_assign_idx)
>>>>> +    if (!adsp->region_assign_idx || adsp->region_assign_shared)
>>>>>           return;
>>>>> -    perm.vmid = QCOM_SCM_VMID_HLOS;
>>>>> -    perm.perm = QCOM_SCM_PERM_RW;
>>>>> +    for (offset = 0; offset < adsp->region_assign_count; ++offset) {
>>>>> +        perm.vmid = QCOM_SCM_VMID_HLOS;
>>>>> +        perm.perm = QCOM_SCM_PERM_RW;
>>>>
>>>>> -    ret = qcom_scm_assign_mem(adsp->region_assign_phys,
>>>>> -                  adsp->region_assign_size,
>>>>> -                  &adsp->region_assign_perms,
>>>>> -                  &perm, 1);
>>>>> -    if (ret < 0)
>>>>> -        dev_err(adsp->dev, "unassign memory failed\n");
>>>>> +        ret = qcom_scm_assign_mem(adsp->region_assign_phys[offset],
>>>>> +                      adsp->region_assign_size[offset],
>>>>> +                      &adsp->region_assign_perms[offset],
>>>>> +                      &perm, 1);
>>>>> +        if (ret < 0)
>>>>> +            dev_err(adsp->dev, "unassign memory failed\n");
>>>>> +    }
>>>>>   }
>>>>>   static int adsp_probe(struct platform_device *pdev)
>>>>> @@ -696,6 +721,9 @@ static int adsp_probe(struct platform_device 
>>>>> *pdev)
>>>>>       adsp->info_name = desc->sysmon_name;
>>>>>       adsp->decrypt_shutdown = desc->decrypt_shutdown;
>>>>>       adsp->region_assign_idx = desc->region_assign_idx;
>>
>> Should this also need
>> min_t(int, MAX_ASSIGN_COUNT - 1, desc->region_assign_idx);
>> as no where boundary check is being done.

I was wrong here.. MAX_ASSIGN_COUNT was relative to assign index.

> 
> region_idx is the offset in the memory-region DT property where assigned 
> memory starts,
> so for example there's 2 memory regions on SM8650 CDSP, but only a 
> single shared memory region
> so we have the following:
>   - region_assign_idx = 2
>   - region_assign_count = 1
> and in DT:
>   memory-region = <&cdsp_mem>, <&q6_cdsp_dtb_mem>, <&global_sync_mem>;
> -------------------------------------------------/\
>                                         region_assign_idx
> ------------------------------------------------[                    ]
>                                         region_assign_count
> 
> and for MPSS, there's 2 of both:
>   - region_assign_idx = 2
>   - region_assign_count = 2
> and in DT:
> memory-region = <&mpss_mem>, <&q6_mpss_dtb_mem>, <&mpss_dsm_mem>, 
> <&mpss_dsm_mem_2>;
> -------------------------------------------------/\
>                                         region_assign_idx
> 
> ------------------------------------------------[                                   ]
>                                         region_assign_count
> 
> so we cannot add a bounday check.
> 
> In any case of_parse_phandle() will do the boundary check if DT has less 
> phandles than expected.

Thanks for explaining.

-Mukesh
> 
> Neil
> 
>>
>> -Mukesh
>>>>> +    adsp->region_assign_count = min_t(int, MAX_ASSIGN_COUNT, 
>>>>> desc->region_assign_count);
>>>>> +    adsp->region_assign_vmid = desc->region_assign_vmid;
>>>>> +    adsp->region_assign_shared = desc->region_assign_shared;
>>>>>       if (dtb_fw_name) {
>>>>>           adsp->dtb_firmware_name = dtb_fw_name;
>>>>>           adsp->dtb_pas_id = desc->dtb_pas_id;
>>>>> @@ -1163,6 +1191,8 @@ static const struct adsp_data 
>>>>> sm8550_mpss_resource = {
>>>>>       .sysmon_name = "modem",
>>>>>       .ssctl_id = 0x12,
>>>>>       .region_assign_idx = 2,
>>>>> +    .region_assign_count = 1,
>>>>> +    .region_assign_vmid = QCOM_SCM_VMID_MSS_MSA,
>>>>>   };
>>>>>   static const struct of_device_id adsp_of_match[] = {
>>>>>
>>>>
>>>> -Mukesh
>>>
>>> Thanks,
>>> Neil
>>>
> 

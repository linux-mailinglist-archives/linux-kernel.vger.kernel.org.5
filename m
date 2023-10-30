Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959957DB350
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 07:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjJ3GbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 02:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbjJ3Ga4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 02:30:56 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC2F1710;
        Sun, 29 Oct 2023 23:30:25 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39U4qVpp029054;
        Mon, 30 Oct 2023 06:30:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=LoQmDt0HC3WFsyV4QHLlwmtClrcplDakQD+6QZ3lau4=;
 b=QFXFzfL+eu1mKbx/G2Aetz2ma9bb2HOTOHlUDf47I0LHDqdhSqhp+0WHnWOXdfRuESBf
 s56yX4Pb+1wEOjie3bg6Q7eDpDaFMeETz7sDsV3FKR9/6hBFSo1etwIUvqUlWQvTM9mz
 LxLwxBeDe9ShcnqLaEJyT3nASsGC5hFH9bFQJ/EbkmLby0hEvJhfpTE+QnIsmCEYPGAp
 +dkkpwHVg5VCLZvBQdh1HRNw/4VlFFNFOxOEMA0+Pke0SA8KIj0UPFfXfH/HylKO28yr
 fL61ztbEZPMwxm/XeC0rnhXSn42vp8SrwXCBFeyFRFCD8oJ+2BprjLLnc+5ad9mfBosj Aw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u0ufyjw3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 06:30:15 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39U6UEpp028914
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 06:30:14 GMT
Received: from [10.217.219.216] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Sun, 29 Oct
 2023 23:30:11 -0700
Message-ID: <3af43db0-0459-733b-ec13-76041eaf8b42@quicinc.com>
Date:   Mon, 30 Oct 2023 12:00:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] bus: mhi: host: Add alignment check for event ring read
 pointer
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>
CC:     <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_parass@quicinc.com>
References: <20231023-alignment_check-v1-1-2ca5716d5c15@quicinc.com>
 <20231027130947.GD17527@thinkpad>
 <27609135-af23-68b3-0c2c-b4f0c40963d0@quicinc.com>
 <20231029072645.GA2481@thinkpad>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20231029072645.GA2481@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qG66vgf3bK_BhWVsntaHUEfTW0AKfU0y
X-Proofpoint-ORIG-GUID: qG66vgf3bK_BhWVsntaHUEfTW0AKfU0y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_04,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 clxscore=1015 mlxlogscore=999 phishscore=0 suspectscore=0
 impostorscore=0 spamscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310300047
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/29/2023 12:56 PM, Manivannan Sadhasivam wrote:
> On Fri, Oct 27, 2023 at 08:19:44AM -0600, Jeffrey Hugo wrote:
>> On 10/27/2023 7:09 AM, Manivannan Sadhasivam wrote:
>>> On Mon, Oct 23, 2023 at 03:13:06PM +0530, Krishna chaitanya chundru wrote:
>>>> Though we do check the event ring read pointer by "is_valid_ring_ptr"
>>>> to make sure it is in the buffer range, but there is another risk the
>>>> pointer may be not aligned.  Since we are expecting event ring elements
>>>> are 128 bits(struct mhi_tre) aligned, an unaligned read pointer could lead
>>> "mhi_tre" got renamed to "mhi_ring_element"
>>>
>>>> to multiple issues like DoS or ring buffer memory corruption.
>>>>
>>>> So add a alignment check for event ring read pointer.
>>>>
>>> Since this is a potential fix, you should add the fixes tag and CC stable.
>>>
>>>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>>>> ---
>>>>    drivers/bus/mhi/host/main.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
>>>> index 499590437e9b..c907bbb67fb2 100644
>>>> --- a/drivers/bus/mhi/host/main.c
>>>> +++ b/drivers/bus/mhi/host/main.c
>>>> @@ -268,7 +268,7 @@ static void mhi_del_ring_element(struct mhi_controller *mhi_cntrl,
>>>>    static bool is_valid_ring_ptr(struct mhi_ring *ring, dma_addr_t addr)
>>>>    {
>>>> -	return addr >= ring->iommu_base && addr < ring->iommu_base + ring->len;
>>>> +	return addr >= ring->iommu_base && addr < ring->iommu_base + ring->len && addr % 16 == 0;
>>> How about,
>>>
>>> !(addr % 16)
>> We are guaranteed that the ring allocation is 16 byte aligned, right?
>>
>> I think using "struct mhi_ring_element" instead of "16" would be better.
>>
>> I'm also thinking that perhaps doing a bit-wise & with a mask would be
>> better than the % operator.  Not only is that how these alignment checks
>> seem to normally be done elsewhere, but this check is in a critical patch
>> for the MHI stack.
>>
> Yes, both of your suggestions sounds good to me.
>
> Chaitanya, please use below check:
>
> 	!(addr & (sizeof(struct mhi_ring_element) - 1))
>
> - Mani

I will update in the next patch.

- Krishna Chaitanya.

>> -Jeff
>>

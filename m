Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C20C7D9B32
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346212AbjJ0OVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346142AbjJ0OUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:20:46 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A0EFA;
        Fri, 27 Oct 2023 07:20:43 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39RDhZTu006281;
        Fri, 27 Oct 2023 14:19:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=8TMWFOquDTB7Nzhyshx8QPA/uf0DbegfaBHM3r+sydM=;
 b=io6H0N3vZXNb71ZAyMhGGjlNG4Gnb4CtnxiGZgsMd+yI2VLiZkvM8DpnffLK10hnwlyC
 TRlJTroa9XG1YuXA5In5AMrLN49Q8XjMKOYJjtKW0dtgwaaPwTRImxv8zoM8x19TTSDW
 3Haairu43v732Fe8He4XtRVljPiXG6Ydx7lWkwfNUD+Vsb/qQsMcGaNrQrLd2F+RaouM
 SGoRxkSVikVEFaFHVd83SwGNZq5SI9ThMjo83Q2DI7JTizn4GWKjeYtTkHY6Dsc29foS
 mf38xpPnzgaUxYQmsgZzpAV1flwz0B2CADaGpt6yo4HI6ZLqjpV62i4IBJQ7CxyPFvK+ Og== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tyxbx285e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 14:19:46 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39REJjEn020104
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 14:19:45 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 27 Oct
 2023 07:19:44 -0700
Message-ID: <27609135-af23-68b3-0c2c-b4f0c40963d0@quicinc.com>
Date:   Fri, 27 Oct 2023 08:19:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] bus: mhi: host: Add alignment check for event ring read
 pointer
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>
CC:     <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_parass@quicinc.com>
References: <20231023-alignment_check-v1-1-2ca5716d5c15@quicinc.com>
 <20231027130947.GD17527@thinkpad>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20231027130947.GD17527@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: n3yl8S9RzhLSpoot5aURjIZs_ltGZ152
X-Proofpoint-GUID: n3yl8S9RzhLSpoot5aURjIZs_ltGZ152
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_12,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 impostorscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310270123
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/2023 7:09 AM, Manivannan Sadhasivam wrote:
> On Mon, Oct 23, 2023 at 03:13:06PM +0530, Krishna chaitanya chundru wrote:
>> Though we do check the event ring read pointer by "is_valid_ring_ptr"
>> to make sure it is in the buffer range, but there is another risk the
>> pointer may be not aligned.  Since we are expecting event ring elements
>> are 128 bits(struct mhi_tre) aligned, an unaligned read pointer could lead
> 
> "mhi_tre" got renamed to "mhi_ring_element"
> 
>> to multiple issues like DoS or ring buffer memory corruption.
>>
>> So add a alignment check for event ring read pointer.
>>
> 
> Since this is a potential fix, you should add the fixes tag and CC stable.
> 
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   drivers/bus/mhi/host/main.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
>> index 499590437e9b..c907bbb67fb2 100644
>> --- a/drivers/bus/mhi/host/main.c
>> +++ b/drivers/bus/mhi/host/main.c
>> @@ -268,7 +268,7 @@ static void mhi_del_ring_element(struct mhi_controller *mhi_cntrl,
>>   
>>   static bool is_valid_ring_ptr(struct mhi_ring *ring, dma_addr_t addr)
>>   {
>> -	return addr >= ring->iommu_base && addr < ring->iommu_base + ring->len;
>> +	return addr >= ring->iommu_base && addr < ring->iommu_base + ring->len && addr % 16 == 0;
> 
> How about,
> 
> !(addr % 16)

We are guaranteed that the ring allocation is 16 byte aligned, right?

I think using "struct mhi_ring_element" instead of "16" would be better.

I'm also thinking that perhaps doing a bit-wise & with a mask would be 
better than the % operator.  Not only is that how these alignment checks 
seem to normally be done elsewhere, but this check is in a critical 
patch for the MHI stack.

-Jeff


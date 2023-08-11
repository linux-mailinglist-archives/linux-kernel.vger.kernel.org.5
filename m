Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A9777870D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 07:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbjHKFqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 01:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjHKFqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 01:46:22 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5572C2129;
        Thu, 10 Aug 2023 22:46:22 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37B5S5D7025313;
        Fri, 11 Aug 2023 05:46:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=nxam5uLiOS+ilAH4M3/4VI/E/PX8AR4P1eyPM/zX4X0=;
 b=moDdks376QQFP/mdj9ok0oqB4BOIOb1NhGhJ4sIc6TSqIFepatXtk/V20cd/ezMI+uq4
 GHPNj+1eRRjUBiXn22OGTduFVAH6fgo+vygMfKZ9cwbufgr8xh9tlgQV07AASAweJcGW
 aUXdfSqWnLREX4wN29UDTPwX3QvuhOKv4vuMTs6rZOl30TVIhiXugYW7qniD3+qU9SDe
 JRgqXmZRXK5NZitQSxwTVj3AP+I7feVD9YAvSxNZXTU/jVMPQ2BIJjX+yj/UlNuEV8ee
 9c5svEfqftJ4ngOlhxK41ikubae4nXIVONgA48G2RuNs1m+BUxYXgOGvL5dXVKZJNPxL Lg== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sd8yegjvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 05:46:07 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37B5k7NO005715
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 05:46:07 GMT
Received: from [10.50.43.50] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 10 Aug
 2023 22:46:03 -0700
Message-ID: <07cf0c21-9a50-122c-10f2-d6e3a660f143@quicinc.com>
Date:   Fri, 11 Aug 2023 11:16:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/4] venus: hfi: add checks to perform sanity on queue
 pointers
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        <stanimir.k.varbanov@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>, <hans.verkuil@cisco.com>,
        <tfiga@chromium.org>
CC:     <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <1691634304-2158-1-git-send-email-quic_vgarodia@quicinc.com>
 <1691634304-2158-2-git-send-email-quic_vgarodia@quicinc.com>
 <922c02e5-3081-45d4-4635-150393970bf8@linaro.org>
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
In-Reply-To: <922c02e5-3081-45d4-4635-150393970bf8@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Wa4nTJAa0sckw_0c-U2Di6d6T1RD4lR_
X-Proofpoint-GUID: Wa4nTJAa0sckw_0c-U2Di6d6T1RD4lR_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_20,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308110052
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/10/2023 4:54 PM, Bryan O'Donoghue wrote:
> On 10/08/2023 03:25, Vikash Garodia wrote:
>> Read and write pointers are used to track the packet index in the memory
>> shared between video driver and firmware. There is a possibility of OOB
>> access if the read or write pointer goes beyond the queue memory size.
>> Add checks for the read and write pointer to avoid OOB access.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: d96d3f30c0f2 ("[media] media: venus: hfi: add Venus HFI files")
>> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
>> ---
>>   drivers/media/platform/qcom/venus/hfi_venus.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c
>> b/drivers/media/platform/qcom/venus/hfi_venus.c
>> index f0b4638..4ddabb1 100644
>> --- a/drivers/media/platform/qcom/venus/hfi_venus.c
>> +++ b/drivers/media/platform/qcom/venus/hfi_venus.c
>> @@ -206,6 +206,11 @@ static int venus_write_queue(struct venus_hfi_device *hdev,
>>         new_wr_idx = wr_idx + dwords;
>>       wr_ptr = (u32 *)(queue->qmem.kva + (wr_idx << 2));
>> +
>> +    if (wr_ptr < (u32 *)queue->qmem.kva ||
>> +        wr_ptr > (u32 *)(queue->qmem.kva + queue->qmem.size - sizeof(*wr_ptr)))
>> +        return -EINVAL;
>> +
>>       if (new_wr_idx < qsize) {
>>           memcpy(wr_ptr, packet, dwords << 2);
>>       } else {
>> @@ -273,6 +278,11 @@ static int venus_read_queue(struct venus_hfi_device *hdev,
>>       }
>>         rd_ptr = (u32 *)(queue->qmem.kva + (rd_idx << 2));
>> +
>> +    if (rd_ptr < (u32 *)queue->qmem.kva ||
>> +        rd_ptr > (u32 *)(queue->qmem.kva + queue->qmem.size - sizeof(*rd_ptr)))
>> +        return -EINVAL;
>> +
>>       dwords = *rd_ptr >> 2;
>>       if (!dwords)
>>           return -EINVAL;
> 
> What is the bit-shifting for ?
If the query is related to dwords, the bit shift is to convert the size of
packet in words.

Regards,
Vikash

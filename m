Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA70577C054
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 21:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjHNTF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 15:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbjHNTFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 15:05:34 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55661719;
        Mon, 14 Aug 2023 12:05:30 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EGIRaG019148;
        Mon, 14 Aug 2023 19:05:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=zWPugzUIxA0FJkXWmxaSjeXE92VJehIFzkktKC09ZkA=;
 b=Li69T4g15XLh0tpMp0f+yb6KzwinHHW82BZEu0MGUEBcYbYSjAIiRMiZmqEKpNN4Gzc3
 j9cBXbMpKNCh+RWOkwGdIhNCN25U9FNjF7onfU+hcySCdzB0HJlQzE6NmZSwXEgjJtu6
 yxNi+Cdha/hu/lFrbA8uVI0QURCm7gwvQGFg0ywZ9Qr4SC7ETSO2CzA3M5Z0vSScuw7n
 BQoM1Mt64XcSKqlJjf9SGfPvTr1ETfxCsk0K0Sg0ZRxV9HiWpLsxMBtwTjLc5gH/QlVu
 kWuGq8Lzc14vOyipVNMwRWOL8n1IMWCxJnS7Sd90wzrsavQozrXmdXgEDAW1hKAMFqTV sA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sfqp2raxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 19:05:20 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37EJ5JTd012690
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 19:05:19 GMT
Received: from [10.50.35.106] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 14 Aug
 2023 12:05:15 -0700
Message-ID: <69f82ca9-c0b5-0ce6-147f-9a054726da4f@quicinc.com>
Date:   Tue, 15 Aug 2023 00:35:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 11/33] iris: vidc: add helpers for memory management
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>
CC:     <stanimir.k.varbanov@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>, <hans.verkuil@cisco.com>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
 <1690550624-14642-12-git-send-email-quic_vgarodia@quicinc.com>
 <20230728162817.GE1428172@hu-bjorande-lv.qualcomm.com>
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <20230728162817.GE1428172@hu-bjorande-lv.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HtZqhD0nv3gOxyIANLW8AaXtrMP1SYOB
X-Proofpoint-ORIG-GUID: HtZqhD0nv3gOxyIANLW8AaXtrMP1SYOB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_16,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 impostorscore=0 phishscore=0 adultscore=0
 mlxlogscore=953 clxscore=1015 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140177
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/2023 9:58 PM, Bjorn Andersson wrote:
> On Fri, Jul 28, 2023 at 06:53:22PM +0530, Vikash Garodia wrote:
>> diff --git a/drivers/media/platform/qcom/iris/vidc/src/msm_vidc_memory.c b/drivers/media/platform/qcom/iris/vidc/src/msm_vidc_memory.c
> [..]
>> +static const struct msm_vidc_memory_ops msm_mem_ops = {
>> +	.dma_buf_get                    = msm_vidc_dma_buf_get,
>> +	.dma_buf_put                    = msm_vidc_dma_buf_put,
>> +	.dma_buf_put_completely         = msm_vidc_dma_buf_put_completely,
>> +	.dma_buf_attach                 = msm_vidc_dma_buf_attach,
>> +	.dma_buf_detach                 = msm_vidc_dma_buf_detach,
>> +	.dma_buf_map_attachment         = msm_vidc_dma_buf_map_attachment,
>> +	.dma_buf_unmap_attachment       = msm_vidc_dma_buf_unmap_attachment,
>> +	.memory_alloc_map               = msm_vidc_memory_alloc_map,
>> +	.memory_unmap_free              = msm_vidc_memory_unmap_free,
>> +	.buffer_region                  = msm_vidc_buffer_region,
> 
> Will there ever be more than one implementation of the
> msm_vidc_memory_ops?
> 
> Unless there's a really strong reason, just call the functions directly
> without the function pointers and call_mem_op(), this will be slightly
> faster, but more importantly it allows for much faster navigation of the
> code base.
> 
That's right, implementation of these APIs won't change for different platform.
Will remove the ops and use direct function in next version.

Thanks,
Dikshita
> Regards,
> Bjorn

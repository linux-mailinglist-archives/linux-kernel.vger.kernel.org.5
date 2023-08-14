Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C63A77C058
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 21:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjHNTGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 15:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbjHNTGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 15:06:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14D310F2;
        Mon, 14 Aug 2023 12:06:20 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EDOxI0003652;
        Mon, 14 Aug 2023 19:06:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=W86c2Yjxt0ALzU6VgMoMC6VQ9YrFAA3o//Ml7nm9LLk=;
 b=Xx/iE4nMFtYOK/Xa8EHxV/p1CzI8biAzysaMFr8YMsIw86FJnHEkc72ohlwIRnfTrF8C
 iAvN8wdfwD7ttLH8HbIJU/EHFvk42Dk6CNT3LDXm5zRYhctwdXibHBPVh/d6j1WjFVZJ
 RhVCdEfybgqt8R4gEgO6UywZSNOPI4MBKkYZVJTFAnZwbGtdqD4hC8yGrWLBltavC3Kc
 sLU28mvYLRf5tCdgSITSXatAiRx2WHibpDROsOIo+KjQceYEk7qpunT6jaLXD7prL+FP
 JjAnBY1vMPFfUMCyUSkgIWttWdSauPEHRIvi3KxggE0mp8dCbhekC//kJxRzx8tiDVQD 3w== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sfn4c8s3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 19:06:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37EJ6A0P013545
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 19:06:10 GMT
Received: from [10.50.35.106] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 14 Aug
 2023 12:06:06 -0700
Message-ID: <8efb0013-970d-ebe6-aedd-7b72f3366578@quicinc.com>
Date:   Tue, 15 Aug 2023 00:36:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 11/33] iris: vidc: add helpers for memory management
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>
CC:     <stanimir.k.varbanov@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <mchehab@kernel.org>,
        <hans.verkuil@cisco.com>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
 <1690550624-14642-12-git-send-email-quic_vgarodia@quicinc.com>
 <20230728162817.GE1428172@hu-bjorande-lv.qualcomm.com>
 <9c6e098a-5d7f-4a1a-80d6-116a2c6b8867@linaro.org>
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <9c6e098a-5d7f-4a1a-80d6-116a2c6b8867@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: a_6fXepA_jHNOfrRg5fd6gVzU_wK61BV
X-Proofpoint-GUID: a_6fXepA_jHNOfrRg5fd6gVzU_wK61BV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_16,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxlogscore=985 lowpriorityscore=0 suspectscore=0
 bulkscore=0 adultscore=0 spamscore=0 mlxscore=0 phishscore=0
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308140177
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/2023 10:52 PM, Konrad Dybcio wrote:
> On 28.07.2023 18:28, Bjorn Andersson wrote:
>> On Fri, Jul 28, 2023 at 06:53:22PM +0530, Vikash Garodia wrote:
>>> diff --git a/drivers/media/platform/qcom/iris/vidc/src/msm_vidc_memory.c b/drivers/media/platform/qcom/iris/vidc/src/msm_vidc_memory.c
>> [..]
>>> +static const struct msm_vidc_memory_ops msm_mem_ops = {
>>> +	.dma_buf_get                    = msm_vidc_dma_buf_get,
>>> +	.dma_buf_put                    = msm_vidc_dma_buf_put,
>>> +	.dma_buf_put_completely         = msm_vidc_dma_buf_put_completely,
>>> +	.dma_buf_attach                 = msm_vidc_dma_buf_attach,
>>> +	.dma_buf_detach                 = msm_vidc_dma_buf_detach,
>>> +	.dma_buf_map_attachment         = msm_vidc_dma_buf_map_attachment,
>>> +	.dma_buf_unmap_attachment       = msm_vidc_dma_buf_unmap_attachment,
>>> +	.memory_alloc_map               = msm_vidc_memory_alloc_map,
>>> +	.memory_unmap_free              = msm_vidc_memory_unmap_free,
>>> +	.buffer_region                  = msm_vidc_buffer_region,
>>
>> Will there ever be more than one implementation of the
>> msm_vidc_memory_ops?
>>
>> Unless there's a really strong reason, just call the functions directly
>> without the function pointers and call_mem_op(), this will be slightly
>> faster, but more importantly it allows for much faster navigation of the
>> code base.
> Same for HFI ops
Hi Konrad,
There are no HFI ops in this driver, are you referring to anything else
here, could you please point me to it?
> 
> Konrad

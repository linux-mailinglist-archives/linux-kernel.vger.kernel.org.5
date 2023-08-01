Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9351576A663
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 03:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjHABda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 21:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjHABd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 21:33:29 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392CD1738;
        Mon, 31 Jul 2023 18:33:28 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VNrLo6031085;
        Tue, 1 Aug 2023 01:33:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=syfmUWUCwsuTNW7lMzGXQorThnzhQXES7o5909M1E3c=;
 b=HFzG0HfOxNd3/ftsEfpqXPFh/XL4WT+qMq6tE5Wff1UJbLj3ngYBVsE6v03SNbxco6Ht
 aGwd1e2qz01hm4trXLitofNQhUKcRIMvDaWBP5P+hfEHtUwByUZ5J8zImfCDJZtCEas/
 +zQ19pww5QanTFBYblZFZVly5aotn3xLWvtUGt2JIIJOE0Pw5DNtDJIS/PpqpnjPxoAU
 dAKqfWvGWmBTqUhpiU2Tg79g399b1Nseg2y3o6EnzipHZGa8ZPuuyo/D/exM7mlmMIqu
 UiwQ1F45PAPwQtsxUKwJh9bhoLFvFLPcPfBnGEZv/OnMO0QBFT/15Z4xrgBr/3kt8ye0 ug== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s6j4erpyc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Aug 2023 01:33:14 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3711XDql023647
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 1 Aug 2023 01:33:13 GMT
Received: from [10.110.76.246] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 31 Jul
 2023 18:33:12 -0700
Message-ID: <e8d9652f-3b81-319a-7ca6-9b656eac6f40@quicinc.com>
Date:   Mon, 31 Jul 2023 18:33:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V2] usb: dwc3: gadget: Let pm runtime get/put paired
Content-Language: en-US
To:     Surong Pang <surong.pang@unisoc.com>, <Thinh.Nguyen@synopsys.com>,
        <gregkh@linuxfoundation.org>, <felipe.balbi@linux.intel.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rogerq@kernel.org>
CC:     <Orson.Zhai@unisoc.com>, <Chunyan.Zhang@unisoc.com>,
        <Zhiyong.liu@unisoc.com>, <Surong.Pang@gmail.com>
References: <20230801011548.30232-1-surong.pang@unisoc.com>
From:   Elson Serrao <quic_eserrao@quicinc.com>
In-Reply-To: <20230801011548.30232-1-surong.pang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 08N4YFv6FYpv37Omr4be-X51KsV_Cqgj
X-Proofpoint-ORIG-GUID: 08N4YFv6FYpv37Omr4be-X51KsV_Cqgj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_18,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=708 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308010012
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/31/2023 6:15 PM, Surong Pang wrote:
> Pm_runtime_get is called when setting pending_events to true.
> Pm_runtime_put is needed for pairing with pm_runtime_get.
> 
> Fixes: fc8bb91bc83e ("usb: dwc3: implement runtime PM")
> Signed-off-by: Surong Pang <surong.pang@unisoc.com>
> 
> ---
> V2: add Fixes tag, fix Fixes tag
> ---
>   drivers/usb/dwc3/gadget.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 5fd067151fbf..9c835c5f9928 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -4720,5 +4720,6 @@ void dwc3_gadget_process_pending_events(struct dwc3 *dwc)
>   		dwc3_interrupt(dwc->irq_gadget, dwc->ev_buf);
>   		dwc->pending_events = false;
>   		enable_irq(dwc->irq_gadget);
> +		pm_runtime_put(dwc->dev);
>   	}
>   }

I am already handling this change as part of below series. Will be 
uploading a separate patch based on the feedback from Roger.

https://lore.kernel.org/all/be57511d-2005-a1f5-d5a5-809e71029aec@quicinc.com/

Thanks
Elson

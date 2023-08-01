Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820DC76BDFB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 21:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbjHATlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 15:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjHATlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 15:41:47 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BC32728;
        Tue,  1 Aug 2023 12:41:36 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 371JEnvf009475;
        Tue, 1 Aug 2023 19:41:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=IxJqKzdA+lN2GY16Pxzo+j0OHpij2fgQVywHiSBsxyw=;
 b=FWgP3hyZh5km+ZfGYLJFO0RV954/UmAJfeXh1zj+AvxClGit4y1UlZZGU53SemP2crYi
 yNtvyt4lCVb8UnWe4bmxodAIm3N19LigG/6smSzu1QEEbIjeYg1UewLChxi/0vSw9pPi
 SoKvrh43GOG9GPWxzAtA3ajvsibuN99MFsO4Zx2KF6kas8nuPeB3nu7u18TUJufUieui
 ixCsGjEi4MexSlRno1V7NdF+WCsHsnPIwkYP/USnv6SOwX0MaTLc6UupK9o/rs37cldh
 WYdJS+en3Xwok38AQjwuCBMwIvb5SUmZQlqSJL/ViA2ZX7+PGDecawO1jQmXm85ZYLPX rg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s6gs7k0s3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Aug 2023 19:41:24 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 371JfNDt000576
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 1 Aug 2023 19:41:23 GMT
Received: from [10.110.76.246] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 1 Aug
 2023 12:41:23 -0700
Message-ID: <590a5f4e-59a6-a449-5174-e4e7f7109ecf@quicinc.com>
Date:   Tue, 1 Aug 2023 12:41:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V2] usb: dwc3: gadget: Let pm runtime get/put paired
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Surong Pang <surong.pang@unisoc.com>, <Thinh.Nguyen@synopsys.com>,
        <felipe.balbi@linux.intel.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rogerq@kernel.org>,
        <Orson.Zhai@unisoc.com>, <Chunyan.Zhang@unisoc.com>,
        <Zhiyong.liu@unisoc.com>, <Surong.Pang@gmail.com>
References: <20230801011548.30232-1-surong.pang@unisoc.com>
 <e8d9652f-3b81-319a-7ca6-9b656eac6f40@quicinc.com>
 <2023080128-bubble-frosty-92c8@gregkh>
From:   Elson Serrao <quic_eserrao@quicinc.com>
In-Reply-To: <2023080128-bubble-frosty-92c8@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XY_fWXXy-r66omq8J5R91tUgV5tjW7ox
X-Proofpoint-ORIG-GUID: XY_fWXXy-r66omq8J5R91tUgV5tjW7ox
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_16,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 adultscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=518 spamscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308010177
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/31/2023 9:43 PM, Greg KH wrote:
> On Mon, Jul 31, 2023 at 06:33:04PM -0700, Elson Serrao wrote:
>>
>>
>> On 7/31/2023 6:15 PM, Surong Pang wrote:
>>> Pm_runtime_get is called when setting pending_events to true.
>>> Pm_runtime_put is needed for pairing with pm_runtime_get.
>>>
>>> Fixes: fc8bb91bc83e ("usb: dwc3: implement runtime PM")
>>> Signed-off-by: Surong Pang <surong.pang@unisoc.com>
>>>
>>> ---
>>> V2: add Fixes tag, fix Fixes tag
>>> ---
>>>    drivers/usb/dwc3/gadget.c | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>>> index 5fd067151fbf..9c835c5f9928 100644
>>> --- a/drivers/usb/dwc3/gadget.c
>>> +++ b/drivers/usb/dwc3/gadget.c
>>> @@ -4720,5 +4720,6 @@ void dwc3_gadget_process_pending_events(struct dwc3 *dwc)
>>>    		dwc3_interrupt(dwc->irq_gadget, dwc->ev_buf);
>>>    		dwc->pending_events = false;
>>>    		enable_irq(dwc->irq_gadget);
>>> +		pm_runtime_put(dwc->dev);
>>>    	}
>>>    }
>>
>> I am already handling this change as part of below series. Will be uploading
>> a separate patch based on the feedback from Roger.
>>
>> https://lore.kernel.org/all/be57511d-2005-a1f5-d5a5-809e71029aec@quicinc.com/
> 
> But this should be fixed now, and properly backported to stable kernels.
> There's no need to wait for a different patch series if this one is
> correct, right?
> 
Hi Greg

I have separated this change from the series and have uploaded below 
change as an independent fix. Based on the earlier feedback and 
discussion, few additional modifications are needed to properly handle 
pending events
https://lore.kernel.org/all/20230801192658.19275-1-quic_eserrao@quicinc.com/

Thanks
Elson



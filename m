Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406477F71A0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345559AbjKXKjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjKXKi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:38:58 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C631AB;
        Fri, 24 Nov 2023 02:39:04 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AO9deg0014805;
        Fri, 24 Nov 2023 10:38:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=gen0iaRdF45KbqXXZgW8c4E73Xxwme6V2+QcijwbLZ8=;
 b=LnqEMTNqgFRY3+RMRC9YjgilJmI4Ns8IO1sJIoaplRbJAokUD3LSKcqEM4FD9BQxxpcx
 z88EjN8Z+hMmwXMcz+LMyo0/g7iFo5Jo77zSDvl3MSck/ptzh80SEQDt2w3AM6e239KQ
 POcGpHk4dy3QeHaatYhz6ZIhhMxPR9/WLCwr+A6sgrIhyl09zvPGTsN0ouX+3Y+0acO4
 AeTxl7WD4s2bcjVoslAIZ4HdKR70rHnDwI7S/N8E6r6h/BbuK+Y5ekFbMTF/F4K6wU7P
 GZKDOh8iDIDySudoE7R7Jv8xQ0VaJhbTUYhFTYoV2VNJhxpLh+9Jd26COZhuAQgD6bFX 2Q== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uj6emtb2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Nov 2023 10:38:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AOAcqTC007683
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Nov 2023 10:38:52 GMT
Received: from [10.216.4.60] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 24 Nov
 2023 02:38:45 -0800
Message-ID: <b3919f6a-80ef-4743-b28b-991e93328a19@quicinc.com>
Date:   Fri, 24 Nov 2023 16:08:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 05/10] usb: dwc3: qcom: Refactor IRQ handling in QCOM
 Glue driver
To:     Johan Hovold <johan@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, <ahalaney@redhat.com>,
        <quic_shazhuss@quicinc.com>
References: <ZTZ-EvvbuA6HpycT@hovoldconsulting.com>
 <fb5e5e1d-520c-4cbc-adde-f30e853421a1@quicinc.com>
 <ZTdqnSHq_Jo8AuPW@hovoldconsulting.com>
 <04615205-e380-4719-aff1-f32c26004b14@quicinc.com>
 <ZUz4RD3MjnLlPn6V@hovoldconsulting.com>
 <6d4d959c-b155-471b-b13d-f6fda557cfe0@quicinc.com>
 <ZVYTFi3Jnnljl48L@hovoldconsulting.com>
 <e0789695-43ee-4285-95e9-4cdee24d6ffe@quicinc.com>
 <ZV9XTU-q038BaWn3@hovoldconsulting.com>
 <4fc27dbb-b0aa-437a-a48c-9deea236282d@quicinc.com>
 <ZWB3SWJWXwj0atdH@hovoldconsulting.com>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZWB3SWJWXwj0atdH@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: p5ioAbIPnL0p8pqLXzvezwkjA1m8kp5A
X-Proofpoint-GUID: p5ioAbIPnL0p8pqLXzvezwkjA1m8kp5A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_15,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=802 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311240083
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/24/2023 3:43 PM, Johan Hovold wrote:
> On Fri, Nov 24, 2023 at 02:30:56PM +0530, Krishna Kurapati PSSNV wrote:
>>>
>>>> I didn't add missing interrupts on sc8280xp because I see that current
>>>> interrupts present are working fine (I see ADB working and wakeup
>>>> working as well), but the interrupt vector numbers are off by "1"
>>>> between hs specifics and DT (both upstream and downstream). Will sort it
>>>> out and clean that target up later.
>>>
>>> Which interrupt numbers are off by one here?
> 
>> Sorry for mentioning that it is wrong. The DT entries are right and it
>> is working on upstream.
> 
> Thanks for clarifying.
> 
>>>> [1]: https://patchwork.kernel.org/project/linux-arm-msm/list/?series=803412
>>>
>>> I took a quick look at the series, and it looks like this will
>>> eventually clean things up a lot. We should probably define a generic
>>> order for the interrupts with the sometimes optional SS interrupts last.
>>>
>>> Side note: It looks like the threading in that series is broken.
>>> Consider using git-send-email for sending series as it takes care of
>>> things like that.
>>
>> Usually I do git send-email for the whole out folder where the patches
>> are present, but linux-usb list is common to all the patches in that
>> case, even the DT ones. So to avoid that and to send patches to only
>> relavant mailing lists, I did git send email individually on each patch
>> which might have caused this issue.
> 
> I'd suggest that you just send two separate series, one with binding and
> driver updates, which will eventually be merged by Greg, and one with
> the devicetree changes, which goes through Bjorn's tree.
> 
> It's good if you could add a link to the binding series in the cover
> letter of the devicetree changes as they are of course going to be quite
> closely related and need to be reviewed in parallel.
> 

Thanks for this pointer. So for Multiport, can I do it this way:

1. Core bindings and Core driver changes in one series. Now that we 
finalized we don't be adding the ctrl_irq[1] as discussed on:
https://lore.kernel.org/all/ZU33uWpStIobzyd6@hovoldconsulting.com/.

2. QC bindings and QC driver changes for Multiport to be pushed after we 
clean up the current driver and DT's (an effort which is going on 
currently).

Regards,
Krishna,

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A79A756755
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjGQPPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjGQPPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:15:44 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02C9F9;
        Mon, 17 Jul 2023 08:15:42 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36HCoKJM021976;
        Mon, 17 Jul 2023 15:15:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=iJVRwGgBDqorv/DdEpo+T+O3KpUQk35Go53H2Mg5u8E=;
 b=TEv12YQJtRqtcBcMQNYjN2fHJr5tQSNHxSPBRbeabR7qC+/GYg5bqGHdJFIeslN6vbqe
 t0r5WUxe61FcITS5uXF8c5h2f2Z1vYQxIHEZlk5OQAUm5wvs4XPjdvx3q6TJ/byYBjK/
 O4kDChun4EJkq6FEjScChAV+6aeWNLEpPVRzW9Aqz66X85l/YBaXVqOsu1Ja8/pokEcm
 9POr3DvhDDR9UHf/fMtc0KvSxC5p/nrbH+eLbIG0RVpzVy6xAohlB4wr62q6toem/W5j
 Gk31paBt7EENzORSPmP3uazlF3ansNOcGb/muMIlszDKDxHbUdRHkRmhzwowjpda4Ws2 Dg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3run1jkrc1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 15:15:24 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36HFFNXY009272
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 15:15:23 GMT
Received: from [10.216.3.135] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 17 Jul
 2023 08:15:17 -0700
Message-ID: <02428901-1941-f104-e55b-d197d589a93f@quicinc.com>
Date:   Mon, 17 Jul 2023 20:45:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v9 06/10] usb: dwc3: qcom: Add support to read IRQ's
 related to multiport
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
To:     Johan Hovold <johan@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        <quic_jackp@quicinc.com>, Wesley Cheng <quic_wcheng@quicinc.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, <ahalaney@redhat.com>,
        <quic_shazhuss@quicinc.com>
References: <20230621043628.21485-1-quic_kriskura@quicinc.com>
 <20230621043628.21485-7-quic_kriskura@quicinc.com>
 <ZK6YrLMn9r39zEeB@hovoldconsulting.com>
 <ef29e520-7b9c-f581-e70a-250df80d3821@quicinc.com>
 <ZLEP6Ekh3unSTiCL@hovoldconsulting.com>
 <7c04ebd9-4def-87d6-0640-35fd0ccd20f5@quicinc.com>
 <9a304650-0360-5509-4922-0818e8e306f5@quicinc.com>
Content-Language: en-US
In-Reply-To: <9a304650-0360-5509-4922-0818e8e306f5@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XuMn0I8BfbE4W_gx3_jejELyo-kSgIBF
X-Proofpoint-GUID: XuMn0I8BfbE4W_gx3_jejELyo-kSgIBF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_12,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 bulkscore=0 mlxlogscore=908 priorityscore=1501 mlxscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307170139
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/16/2023 12:31 AM, Krishna Kurapati PSSNV wrote:
> 
> 
> On 7/14/2023 4:10 PM, Krishna Kurapati PSSNV wrote:
>>
>>
>> On 7/14/2023 2:35 PM, Johan Hovold wrote:
>>> On Wed, Jul 12, 2023 at 11:56:33PM +0530, Krishna Kurapati PSSNV wrote:
>>>> On 7/12/2023 5:42 PM, Johan Hovold wrote:
>>>>> On Wed, Jun 21, 2023 at 10:06:24AM +0530, Krishna Kurapati wrote:
>>>>>> Add support to read Multiport IRQ's related to quad port controller
>>>>>> of SA8295 Device.
>>>>>>
>>>>>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>>>>>> ---
>>>>>>    drivers/usb/dwc3/dwc3-qcom.c | 108 
>>>>>> +++++++++++++++++++++++++++++------
>>>>>>    1 file changed, 91 insertions(+), 17 deletions(-)
>>>>>
>>>>>> +static int dwc3_qcom_setup_mp_irq(struct platform_device *pdev)
>>>>>> +{
>>>>>> +    struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
>>>>>> +    char irq_name[15];
>>>>>
>>>>> The interrupt device-name string can not be allocated on the stack or
>>>>> reused as it is stored directly in each irqaction structure.
>>>>>
>>>>> This can otherwise lead to random crashes when accessing
>>>>> /proc/interrupts:
>>>>>
>>>>>     https://lore.kernel.org/lkml/ZK6IV_jJPICX5r53@hovoldconsulting.com/
>>>
>>>>     Sure, will create a static array of names if possible in global
>>>> section of file and use it to read interrupts.
>>>
>>> Or just use devm_kasprintf(), which should allow for a cleaner
>>> implementation.
>>>
>>> I've fixed it up like this for my X13s wip branches:
>>>
>>>     https://github.com/jhovold/linux/commit/0898b54456bc2f4bd4d420480db98e6758771ace
>>>>     Are you fine with seperating out setup_irq and setup_mp_irq 
>>>> functions
>>>> ? Can you please review comments and suggestion on [1].
>>>
>>> I haven't had time to look at your latest replies yet, but as I already
>>> said when reviewing v9, it seems you should be using a common helper for
>>> non-mp and mp.
>>>
>> Hi Johan,
>>
>>   The gist of my mail was to see if I can defer qcom probe when dwc3 
>> probe fails/or doesn't happen on of_plat_pop (which is logical) so 
>> that we can move setup_irq to after dwc3_register_core so that we know 
>> whether we are MP capable or not. This would help us move all IRQ 
>> reading into one function.
>>
> Hi Johan,
> 
>   I see it is difficult to write a common helper. To do so, we need to 
> know whether the device is MP capable or not in advance. And since it is 
> not possible to know it before of_plat_pop is done, I see only few ways 
> to do it:
> 
> 1. Based on qcom node compatible string, I can read whether the device 
> is MP capable or not and get IRQ's accordingly.
> 
> 2. Read the port_info in advance but it needs me to go through some DT 
> props and try getting this info. Or read xhci regs like we are doing in 
> core (which is not good). Also since some Dt props can be missing, is it 
> difficult to get the MP capability info before of_plat_pop is done.
> 
> 3. Remove IRQ handling completely. Just because the device has IRQ's 
> present, I don't see a point in adding them to bindings, and because we 
> added them to bindings, we are making a patch to read them (and since 
> this is a little challenging, the whole of multiport series is blocked 
> although I don't need wakeup support on these interrupts right away).
> 
> Can't we let the rest of the patches go through and let interrupt 
> handling for 2nd, 3rd and 4rth ports be taken care later ? I am asking 
> this because I want the rest of the patches which are in good shape now 
> (after fixing the nits mentioned) to get merged atleast. I will make 
> sure to add interrupt handling later in a different series once this is 
> merged once I send v10.
> 
> Or if there is a simpler way to do it, I would be happy to take any 
> suggestions and complete this missing part in this series itself.
>

Hi Konrad, Bjorn,

  Can you also let me know your review on this. Can we add a compatible 
data to dwc3-qcom to identify whether we need to read MP irq's or non-NP 
irq's and also if it is better to split this series into two. (One for 
multiport and one for dwc3-qcom IRQ's)

Regards,
Krishna,

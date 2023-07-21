Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7AD375C1EE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjGUIq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjGUIqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:46:22 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F1F273A;
        Fri, 21 Jul 2023 01:46:17 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36L5mecZ023815;
        Fri, 21 Jul 2023 08:46:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Z6eykhfMHJ23fTKK19IkyeQ4FDdUwvWRSd0mnAQWKrA=;
 b=Jc4Hj81qkRylABTzG38pPgISQY8eTGWUdJqHtUijh7bpSgSOS9k9o/hSIil2XIT5rYze
 3sT2fe9e3FyVI4fMuJaltdhSBRJGd7EQRAwID4QWUNVD1BGdSRQKSjhiBIWB1kGBgem/
 GfaCraFSlyWExF6NCKywbXStiPwzvqM7wx8A1FsMtteUvvUfWsuZqD9XDZXU5NVeSZpK
 hxeEaIpkI105w0CTZ9IB605ClhIgZRPE0nI0g+AU10NVfTH052uhpjDIaTkPclWHAZMb
 gRpeoNni1rL/PKf1vBWFid24yx2ZLGv5ctJp9dM9mAnaWyaW1jUhIjxvoRqr4INWLioe wA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ryhdy8kbm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 08:46:04 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36L8k3aA026333
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 08:46:03 GMT
Received: from [10.216.63.95] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 21 Jul
 2023 01:45:57 -0700
Message-ID: <f0857b4d-c1a8-7f82-1890-521afb225e1c@quicinc.com>
Date:   Fri, 21 Jul 2023 14:15:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v9 06/10] usb: dwc3: qcom: Add support to read IRQ's
 related to multiport
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        <quic_jackp@quicinc.com>, Wesley Cheng <quic_wcheng@quicinc.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
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
 <ZLpDQ0R1BjG8fJk8@hovoldconsulting.com>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZLpDQ0R1BjG8fJk8@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uMAMYzMEYpeA7DRHvXBDOYN5JsmWIV0C
X-Proofpoint-ORIG-GUID: uMAMYzMEYpeA7DRHvXBDOYN5JsmWIV0C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_05,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 spamscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 adultscore=0
 mlxlogscore=719 impostorscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307210078
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/21/2023 2:05 PM, Johan Hovold wrote:
> On Sun, Jul 16, 2023 at 12:31:05AM +0530, Krishna Kurapati PSSNV wrote:
>> On 7/14/2023 4:10 PM, Krishna Kurapati PSSNV wrote:
>>> On 7/14/2023 2:35 PM, Johan Hovold wrote:
> 
>>>> I haven't had time to look at your latest replies yet, but as I already
>>>> said when reviewing v9, it seems you should be using a common helper for
>>>> non-mp and mp.
> 
>>>    The gist of my mail was to see if I can defer qcom probe when dwc3
>>> probe fails/or doesn't happen on of_plat_pop (which is logical) so that
>>> we can move setup_irq to after dwc3_register_core so that we know
>>> whether we are MP capable or not. This would help us move all IRQ
>>> reading into one function.
> 
>>    I see it is difficult to write a common helper. To do so, we need to
>> know whether the device is MP capable or not in advance. And since it is
>> not possible to know it before of_plat_pop is done, I see only few ways
>> to do it:
>>
>> 1. Based on qcom node compatible string, I can read whether the device
>> is MP capable or not and get IRQ's accordingly.
> 
> See, it's not impossible. You can also determine whether you have a
> multiport controller from looking at the interrupt names which are
> indexed and distinct for MP.
> 
>> 2. Read the port_info in advance but it needs me to go through some DT
>> props and try getting this info. Or read xhci regs like we are doing in
>> core (which is not good). Also since some Dt props can be missing, is it
>> difficult to get the MP capability info before of_plat_pop is done.
> 
> That seem unnecessary currently, but long term we probably need to fix
> the design of this driver and defer some setup using callbacks that are
> called when the core driver probes. Perhaps now is the time to add such
> functionality.
> 
>> 3. Remove IRQ handling completely. Just because the device has IRQ's
>> present, I don't see a point in adding them to bindings, and because we
>> added them to bindings, we are making a patch to read them (and since
>> this is a little challenging, the whole of multiport series is blocked
>> although I don't need wakeup support on these interrupts right away).
> 
> Again, no. The devicetree binding should describe the hardware
> capabilities and that has nothing to do with whether you need this for
> you current project or not.
> 
>> Can't we let the rest of the patches go through and let interrupt
>> handling for 2nd, 3rd and 4rth ports be taken care later ? I am asking
>> this because I want the rest of the patches which are in good shape now
>> (after fixing the nits mentioned) to get merged atleast. I will make
>> sure to add interrupt handling later in a different series once this is
>> merged once I send v10.
> 
> As I've explained in earlier mails, I don't think that is acceptable as
> you'd be dumping your technical debt on the community which will be left
> to clean up your mess.
> 
>> Or if there is a simpler way to do it, I would be happy to take any
>> suggestions and complete this missing part in this series itself.
> 

Hi Johan,

  Thanks for these comments.

> Using the 'compatible' or 'interrupt-names' properties seems like the
> easiest way to determine whether you have an MP controller or not.
> 

Yes, I can make a common helper to get IRQ's based on compatible. I also 
provided another implementation (which is more unambiguous and better I 
feel) on [1]. I will take one path forward based on your review of that 
patch as well.

Thanks a lot again for the reviews !

[1]: 
https://lore.kernel.org/all/f6f2456d-0067-6cd6-3282-8cae7c47a2d3@quicinc.com/

Regards,
Krishna,


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4DF75386F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 12:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236138AbjGNKlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 06:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235717AbjGNKlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 06:41:22 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A3E2D7D;
        Fri, 14 Jul 2023 03:41:21 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36E7KGh3032681;
        Fri, 14 Jul 2023 10:41:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ZMmeuoidqMwO6OJvJtXuIzl+yCguX0bVr2pvJkfGWBY=;
 b=JoQDbe4oU5n5Qd8WPMD/xgq42AydXSxN12U2UrBxqYwuBP6R56Htgamen85yRo7ItaFP
 COJWNpg++yQ1ywwFuerr5W8EZrsfJN80049PsJth1R0keEUrSLi3Jo2gYlj7z4VT4XaM
 3nIyXJjlmhF5k/tuKVuh4jSVVMGMb78rnRa/0vgLHX47ujWTq2n0SoZ+M0IXECuFqExT
 tmE2+hgJedjuiz7th0VeVcd4tIGO0wZbZU38jWhcQ5hT7kPnu924OmpSDiqTwCUsL6kZ
 /Vy/UAAnw7syTHNjTWpDMPDMnp4VwhO9uegveGvLDmyZy0r1MqP98PdokhKLH3rM1uUT Pw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rtptw1gbm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 10:41:07 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36EAf6Mg011077
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 10:41:06 GMT
Received: from [10.216.17.90] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 14 Jul
 2023 03:41:00 -0700
Message-ID: <7c04ebd9-4def-87d6-0640-35fd0ccd20f5@quicinc.com>
Date:   Fri, 14 Jul 2023 16:10:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v9 06/10] usb: dwc3: qcom: Add support to read IRQ's
 related to multiport
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, <ahalaney@redhat.com>,
        <quic_shazhuss@quicinc.com>
References: <20230621043628.21485-1-quic_kriskura@quicinc.com>
 <20230621043628.21485-7-quic_kriskura@quicinc.com>
 <ZK6YrLMn9r39zEeB@hovoldconsulting.com>
 <ef29e520-7b9c-f581-e70a-250df80d3821@quicinc.com>
 <ZLEP6Ekh3unSTiCL@hovoldconsulting.com>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZLEP6Ekh3unSTiCL@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fLGcEm4dkghEiJNpTJriALWOjls5kLyX
X-Proofpoint-GUID: fLGcEm4dkghEiJNpTJriALWOjls5kLyX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_04,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0
 spamscore=0 clxscore=1015 impostorscore=0 mlxscore=0 mlxlogscore=809
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307140097
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/14/2023 2:35 PM, Johan Hovold wrote:
> On Wed, Jul 12, 2023 at 11:56:33PM +0530, Krishna Kurapati PSSNV wrote:
>> On 7/12/2023 5:42 PM, Johan Hovold wrote:
>>> On Wed, Jun 21, 2023 at 10:06:24AM +0530, Krishna Kurapati wrote:
>>>> Add support to read Multiport IRQ's related to quad port controller
>>>> of SA8295 Device.
>>>>
>>>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>>>> ---
>>>>    drivers/usb/dwc3/dwc3-qcom.c | 108 +++++++++++++++++++++++++++++------
>>>>    1 file changed, 91 insertions(+), 17 deletions(-)
>>>
>>>> +static int dwc3_qcom_setup_mp_irq(struct platform_device *pdev)
>>>> +{
>>>> +	struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
>>>> +	char irq_name[15];
>>>
>>> The interrupt device-name string can not be allocated on the stack or
>>> reused as it is stored directly in each irqaction structure.
>>>
>>> This can otherwise lead to random crashes when accessing
>>> /proc/interrupts:
>>>
>>> 	https://lore.kernel.org/lkml/ZK6IV_jJPICX5r53@hovoldconsulting.com/
> 
>>     Sure, will create a static array of names if possible in global
>> section of file and use it to read interrupts.
> 
> Or just use devm_kasprintf(), which should allow for a cleaner
> implementation.
> 
> I've fixed it up like this for my X13s wip branches:
> 
> 	https://github.com/jhovold/linux/commit/0898b54456bc2f4bd4d420480db98e6758771ace
>   
>>     Are you fine with seperating out setup_irq and setup_mp_irq functions
>> ? Can you please review comments and suggestion on [1].
> 
> I haven't had time to look at your latest replies yet, but as I already
> said when reviewing v9, it seems you should be using a common helper for
> non-mp and mp.
> 
Hi Johan,

  The gist of my mail was to see if I can defer qcom probe when dwc3 
probe fails/or doesn't happen on of_plat_pop (which is logical) so that 
we can move setup_irq to after dwc3_register_core so that we know 
whether we are MP capable or not. This would help us move all IRQ 
reading into one function.

Regards,
Krishna,

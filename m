Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23497E8081
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235360AbjKJSMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345549AbjKJSLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:11:12 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7293A7D8B;
        Fri, 10 Nov 2023 02:01:39 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AA7gAej017261;
        Fri, 10 Nov 2023 10:01:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=vKCQmpof5NgLLxcXWN69NRzaO3733ATCxCp3ipi2n4k=;
 b=Et+LYvC1koTbfOYVW1a3T/wDxiu4Khnb9Fwh2jfkdwLFl7sqzYHuP9mHXEZiIYE6yvOv
 gTnC73SRr9iqdnaugD1f79n4B6aFcHGBmCmAOBwRAJ8W4AV7y/7r2+kkzUvv5RiVBh0Q
 YETy7/Ia0xdKPDxVfCT/k2d5LjrHxBzqd9gLCTKWomhu451HF3Yl+i53rmcYqsiQZBo6
 r291S1tzHECPMOWETvqWUSTw7uvc2IRMnkRPMPOyZddO5NafWt9BATNnKYpA+19HSePE
 hPYgtDtHfQVuUIKUZqOv1n+/pXrCbeIZ1vn8mvFodxokwXrenvxBpjko+02C4xwta0/j qw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u8u2buaq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 10:01:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AAA1Sjl008014
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 10:01:28 GMT
Received: from [10.249.28.118] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 10 Nov
 2023 02:01:20 -0800
Message-ID: <dc20ecc0-f930-49c5-9e21-5a6e4c8ce637@quicinc.com>
Date:   Fri, 10 Nov 2023 15:31:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 05/10] usb: dwc3: qcom: Refactor IRQ handling in QCOM
 Glue driver
To:     Johan Hovold <johan@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, <ahalaney@redhat.com>,
        <quic_shazhuss@quicinc.com>
References: <ZTJ_T1UL8-s2cgNz@hovoldconsulting.com>
 <14fc724c-bc99-4b5d-9893-3e5eff8895f7@quicinc.com>
 <ZTY7Lwjd3_8NlfEi@hovoldconsulting.com>
 <cabf24d0-8eea-4eb5-8205-bf7fe6017ec2@quicinc.com>
 <ZTZ-EvvbuA6HpycT@hovoldconsulting.com>
 <fb5e5e1d-520c-4cbc-adde-f30e853421a1@quicinc.com>
 <ZTdqnSHq_Jo8AuPW@hovoldconsulting.com>
 <04615205-e380-4719-aff1-f32c26004b14@quicinc.com>
 <ZUz4RD3MjnLlPn6V@hovoldconsulting.com>
 <2b19b5e2-5eb0-49e0-8c47-8aff3d48f34e@quicinc.com>
 <ZU31gx-LY5GBJGPU@hovoldconsulting.com>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZU31gx-LY5GBJGPU@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GUbyD6oZ358fERpMgh4DHH_-XU0Y2kUj
X-Proofpoint-ORIG-GUID: GUbyD6oZ358fERpMgh4DHH_-XU0Y2kUj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_06,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1 suspectscore=0
 mlxlogscore=199 impostorscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 spamscore=1 malwarescore=0 adultscore=0 mlxscore=1
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311100081
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>>> There are, I can dig through and find out. Atleast in downstream I don't
>>>>>> see any use of them.
>>>>>
>>>>> Yes, please do post how these are wired as well for completeness.
>>>
>>> Did you find these two interrupts as well?
> 
> Please answer.
> 

Yes.

Controller-1:
u_usb31_prim_mvs_wrapper_usb31_hs_phy_irq	SYS_apcsQgicSPI[806]
Controller-2:
u_usb31_prim_mvs_wrapper_usb31_hs_phy_irq	SYS_apcsQgicSPI[791]

>>>> As an experiment, I tried to test wakeup by pressing buttons on
>>>> connected keyboard when in suspend state or connecting/disconnecting
>>>> keyboard in suspended state on different ports and only see dp/dm IRQ's
>>>> getting fired although we register for hs_phy_irq as well:
>>>>
>>>> / # cat /proc/interrupts  |grep phy_
>>>> 171:   1  0   0   0  0  0  0  0       PDC 127 Edge      dp_hs_phy_1
>>>> 172:   2  0   0   0  0  0  0  0       PDC 126 Edge      dm_hs_phy_1
>>>> 173:   3  0   0   0  0  0  0  0       PDC 129 Edge      dp_hs_phy_2
>>>> 174:   4  0   0   0  0  0  0  0       PDC 128 Edge      dm_hs_phy_2
>>>> 175:   0  0   0   0  0  0  0  0       PDC 131 Edge      dp_hs_phy_3
>>>> 176:   2  0   0   0  0  0  0  0       PDC 130 Edge      dm_hs_phy_3
>>>> 177:   2  0   0   0  0  0  0  0       PDC 133 Edge      dp_hs_phy_4
>>>> 178:   5  0   0   0  0  0  0  0       PDC 132 Edge      dm_hs_phy_4
>>>> 179:   0  0   0   0  0  0  0  0       PDC  16 Level     ss_phy_1
>>>> 180:   0  0   0   0  0  0  0  0       PDC  17 Level     ss_phy_2
>>>> 181:   0  0   0   0  0  0  0  0     GICv3 163 Level     hs_phy_1
>>>> 182:   0  0   0   0  0  0  0  0     GICv3 168 Level     hs_phy_2
>>>> 183:   0  0   0   0  0  0  0  0     GICv3 892 Level     hs_phy_3
>>>> 184:   0  0   0   0  0  0  0  0     GICv3 891 Level     hs_phy_4
>>>
>>> Yes, but that doesn't really say much since you never enable the hs_phy
>>> interrupt in the PHY on suspend.
>>
>> I did register to and enabled the hs_phy_irq interrupt when I tested and
>> posted the above table.
> 
> Yes, but, again, you never enabled them in the PHY (cf. QUSB2) so it's
> hardly surprising that they do not fire.
> 
There is no register in femto phy address space of sc8280 (which I am 
currently testing) where we can configure these registers like qusb2 phy's.

> Still good to know that requesting them doesn't trigger spurious
> interrupts either since these are apparently enabled on most Qualcomm
> SoCs even though they are not used. We should fix that too.
> 
>>>> Since the hs_phy_irq is applicable only for qusb2 targets, do we still
>>>> need to add it to DT.
>>>
>>> Are you sure there's no support for hs_phy_irq also in the "femto" PHYs
>>> and that it's just that there is currently no driver support for using
>>> them?
>>>
>>> And why is it defined if there is truly no use for it?
>>
>> Femto phy's have nothing to be configured for interrupts like we do for
>> qusb2 phy's. I confirmed from hw validation team that they never used
>> hs_phy_irq for validating wakeup. They only used dp/dm IRQ's for wakeup.
> 
> Ok.
> 
> Is there some other (non-wakeup) functionality which may potentially use
> this interrupt?
> 

The only info I (and hw validation team) got from design team is:

1. Common IRQ for power and special events
2. Assert in case of remote wakeup, or resume when in Host or device 
respectively
3. Also upon disconnect while in suspend state.

Same as what we understand as remote wakeup functionality.

>>> Also, if hs_phy_irq and dp/dm_phy_irq were mutually exclusive, why does
>>> the following Qualcomm SoCs define all three?
>>>
>>
>> Similar to BAM IRQ's these might have been just ported over targets I
>> believe. I say so because HW Validation team confirmed they don't use this
>> interrupt at all on femto phy targets.
> 
> So then including the hs_phy_irq for most of these SoCs was a mistake
> and we should drop it from the bindings?
> 
> What about the QUSB2 SoCs that also define DP/DM, are both useable
> there?
> 
> And if so, is there any reason to prefer one mechanism over the other?
> 
No. I didn't ask this question to hw team whether dp/dm are used in 
qusb2 phy targets. Let me ask them.

While I do so, since there are no qusb2 targets present on femto phy's, 
do you suggest we still add them to port structure in dwc3-qcom ? I am 
inclined to add it because it would make implementation look cleaner 
w.r.t code and also spurious interrupts are not getting triggered (which 
was my primary concern as it was never tested).

I know that if hs_phy_irq is for qusb2 and dp/dm are for femto, the 
cleanup would be big.

Regards,
Krishna,

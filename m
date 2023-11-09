Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6337E6F7C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344836AbjKIQlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:41:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234720AbjKIQkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:40:17 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21B03C06;
        Thu,  9 Nov 2023 08:38:45 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A9Btrsa011736;
        Thu, 9 Nov 2023 16:38:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Y5xJO2ELmJsVcxwCnU/qdhAbrf5g1FNg/Tt1AVfUmvE=;
 b=IhuNzHHvw5y5w407svhexAMV65EWJqIP01e9v/Wn2DLEyznIbq6lIwv+XAeqQOkP8z9j
 YT2tekmLfsE0j0lim7zF/GB/YP9lZHP59x0LvLodgyhqg0ZLkZmofQ1cLnOpFZCMC2Zs
 TInr6eYBfxIXo4DWEMGMkiozbb1x4oija/tpQ89GQBALuFzsHCURnjj+HO6K18/TDRKn
 EhzWzip3PQjfWIt7AP/rsDMjkfP8Y8R0Xj1GsGoALt+jACXOwQUyYSkAVjZibijKGh+H
 h39tFfiiqp6W9uNLWdC2FAyadP/I3hOiBM5zh9T1jf4mkAaMkjHlqLBAkxRnAKtCkCv0 uA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u8tcrsmbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Nov 2023 16:38:25 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A9GcO6f013137
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Nov 2023 16:38:24 GMT
Received: from [10.249.28.118] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 9 Nov
 2023 08:38:17 -0800
Message-ID: <2b19b5e2-5eb0-49e0-8c47-8aff3d48f34e@quicinc.com>
Date:   Thu, 9 Nov 2023 22:08:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 05/10] usb: dwc3: qcom: Refactor IRQ handling in QCOM
 Glue driver
To:     Johan Hovold <johan@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Bjorn Andersson <andersson@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, <ahalaney@redhat.com>,
        <quic_shazhuss@quicinc.com>
References: <20231007154806.605-1-quic_kriskura@quicinc.com>
 <20231007154806.605-6-quic_kriskura@quicinc.com>
 <ZTJ_T1UL8-s2cgNz@hovoldconsulting.com>
 <14fc724c-bc99-4b5d-9893-3e5eff8895f7@quicinc.com>
 <ZTY7Lwjd3_8NlfEi@hovoldconsulting.com>
 <cabf24d0-8eea-4eb5-8205-bf7fe6017ec2@quicinc.com>
 <ZTZ-EvvbuA6HpycT@hovoldconsulting.com>
 <fb5e5e1d-520c-4cbc-adde-f30e853421a1@quicinc.com>
 <ZTdqnSHq_Jo8AuPW@hovoldconsulting.com>
 <04615205-e380-4719-aff1-f32c26004b14@quicinc.com>
 <ZUz4RD3MjnLlPn6V@hovoldconsulting.com>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZUz4RD3MjnLlPn6V@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rTgt5H7Aq3LkWvAni5gt6hzA3u-xMBhA
X-Proofpoint-ORIG-GUID: rTgt5H7Aq3LkWvAni5gt6hzA3u-xMBhA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_14,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 malwarescore=0 mlxscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=628 impostorscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311090126
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/9/2023 8:48 PM, Johan Hovold wrote:
> On Fri, Nov 03, 2023 at 03:34:52PM +0530, Krishna Kurapati PSSNV wrote:
>> On 10/24/2023 12:26 PM, Johan Hovold wrote:
>>> On Mon, Oct 23, 2023 at 10:42:31PM +0530, Krishna Kurapati PSSNV wrote:
>>>> On 10/23/2023 7:37 PM, Johan Hovold wrote:
>>>
>>>>> Right. And I assume there are hs_phy_irqs also for the first two USB
>>>>> controllers on sc8280xp?
>>>
>>>> There are, I can dig through and find out. Atleast in downstream I don't
>>>> see any use of them.
>>>
>>> Yes, please do post how these are wired as well for completeness.
> 
> Did you find these two interrupts as well?
> 
> 
>> Regarding the points of discussion we had last week on [1], here are
>> some clarifications:
>>
>> 1. We do have hs_phy_irq 1/2/3/4 for tertiary port of Sc8280 as
>> mentioned. Why do we need them and would we use it in multiport targets ?
>>
>> DPSE and DMSE are single ended line state of DP and DM lines. The DP
>> line and DM line stay in steady High or Low during suspend and they flip
>> when there is a RESUME or REMOTE WAKE. This is what we do/check in
>> dwc3_qcom_enable_interrupts call for dp/dm irq's based on usb2_speed.
> 
> Right, this bit is clear.
> 
>> Initially in QUSB2 targets, the interrupts were enabled and configured
>> in phy and the wakeup was interrupt was read on hs_phy_irq vector - [2].
>> In that case, we modify DP/DM interrupts in phy registers, specifically
>> QUSB2PHY_INTR_CTRL and when wakeup signal comes in, hs_phy_irq is
>> triggered. But in femto targets, this is done via DP/DM interrupts and
>> there is no use of hs_phy_irq. Even hw folks confirmed they dont use
>> hs_ph_irq in femto phy targets.
> 
> Ok, thanks for pointing to QUSB2. The same mechanism is apparently used
> in phy-qcom-usb-hs-28nm.c as well (even if the dtsi currently does not
> define the wakeup interrupts).
> 
> Furthermore, that implementation is broken and has never worked due to
> another half-arsed, incomplete Qualcomm implementation. Specifically, no
> one is changing the PHY mode based on the current speed before suspend
> as commits like
> 
> 	3b3cd24ae61b ("phy: Add USB speed related PHY modes")
> 
> and
> 
> 	891a96f65ac3 ("phy: qcom-qusb2: Add support for runtime PM")
> 
> depend on. Guess I should go revert that mess too...
> 
>> As an experiment, I tried to test wakeup by pressing buttons on
>> connected keyboard when in suspend state or connecting/disconnecting
>> keyboard in suspended state on different ports and only see dp/dm IRQ's
>> getting fired although we register for hs_phy_irq as well:
>>
>> / # cat /proc/interrupts  |grep phy_
>> 171:   1  0   0   0  0  0  0  0       PDC 127 Edge      dp_hs_phy_1
>> 172:   2  0   0   0  0  0  0  0       PDC 126 Edge      dm_hs_phy_1
>> 173:   3  0   0   0  0  0  0  0       PDC 129 Edge      dp_hs_phy_2
>> 174:   4  0   0   0  0  0  0  0       PDC 128 Edge      dm_hs_phy_2
>> 175:   0  0   0   0  0  0  0  0       PDC 131 Edge      dp_hs_phy_3
>> 176:   2  0   0   0  0  0  0  0       PDC 130 Edge      dm_hs_phy_3
>> 177:   2  0   0   0  0  0  0  0       PDC 133 Edge      dp_hs_phy_4
>> 178:   5  0   0   0  0  0  0  0       PDC 132 Edge      dm_hs_phy_4
>> 179:   0  0   0   0  0  0  0  0       PDC  16 Level     ss_phy_1
>> 180:   0  0   0   0  0  0  0  0       PDC  17 Level     ss_phy_2
>> 181:   0  0   0   0  0  0  0  0     GICv3 163 Level     hs_phy_1
>> 182:   0  0   0   0  0  0  0  0     GICv3 168 Level     hs_phy_2
>> 183:   0  0   0   0  0  0  0  0     GICv3 892 Level     hs_phy_3
>> 184:   0  0   0   0  0  0  0  0     GICv3 891 Level     hs_phy_4
> 
> Yes, but that doesn't really say much since you never enable the hs_phy
> interrupt in the PHY on suspend.

I did register to and enabled the hs_phy_irq interrupt when I tested and 
posted the above table.

>   
>> Since the hs_phy_irq is applicable only for qusb2 targets, do we still
>> need to add it to DT.
> 
> Are you sure there's no support for hs_phy_irq also in the "femto" PHYs
> and that it's just that there is currently no driver support for using
> them?
> 
> And why is it defined if there is truly no use for it?

Femto phy's have nothing to be configured for interrupts like we do for 
qusb2 phy's. I confirmed from hw validation team that they never used 
hs_phy_irq for validating wakeup. They only used dp/dm IRQ's for wakeup.

> Also, if hs_phy_irq and dp/dm_phy_irq were mutually exclusive, why does
> the following Qualcomm SoCs define all three?
> 

Similar to BAM IRQ's these might have been just ported over targets I 
believe. I say so because HW Validation team confirmed they don't use 
this interrupt at all on femto phy targets.

>                - qcom,ipq4019-dwc3
>                - qcom,ipq6018-dwc3
>                - qcom,ipq8064-dwc3
>                - qcom,ipq8074-dwc3
>                - qcom,msm8994-dwc3
>                - qcom,qcs404-dwc3
>                - qcom,sc7180-dwc3
> 	      - qcom,sc7280-dwc3
>                - qcom,sdm670-dwc3
>                - qcom,sdm845-dwc3
>                - qcom,sdx55-dwc3
>                - qcom,sdx65-dwc3
>                - qcom,sm4250-dwc3
>                - qcom,sm6125-dwc3
>                - qcom,sm6350-dwc3
>                - qcom,sm8150-dwc3
>                - qcom,sm8250-dwc3
>                - qcom,sm8350-dwc3
>                - qcom,sm8450-dwc3
>                - qcom,sm8550-dwc3
> 
> Some of those use QUSB2 PHYs and some use "femto" PHYs.
>  > And this comes from Qualcomm through commits like:
> 
> 	0b766e7fe5a2 ("arm64: dts: qcom: sc7180: Add USB related nodes")
> 	bb9efa59c665 ("arm64: dts: qcom: sc7280: Add USB related nodes")
> 
> 
>> 3. ctrl_irq[1] usage:
>>
>> This is a feature of SNPS controller, not qcom glue wrapper, and is
>> present on all targets (non-QC as well probably). As mentioned before on
>> [3], this is used for HW acceleration.
>>
>> In host mode, XHCI spec does allow for multiple interrupters when
>> multiple event rings are used. A possible usage is multiple execution
>> environments something like what we are doing on mobile with ADSP audio
>> offload [4]. Another possibility could be some of virtualization where
>> host/hyp would manage the first interrupter and could allow a guest to
>> operate only with the second (though current design does not go far
>> enough to offer true isolation for real VM type workloads). The
>> additional interrupts (ones other than ctrl_irq[0]) are either for
>> virtualization use cases, or for our various “hw offload” features. In
>> device mode, these are used for offloading tethering functionality to
>> IPA FW.
> 
> Ok, thanks for clarifying what you meant by "HW acceleration".
> 
>> Since the DeviceTree passed to the OS, should describe the hardware to
>> the OS, and should represent the hardware from the point-of-view of the
>> OS, adding one interrupt (ctrl_irq[0]) might be sufficient as Linux
>> would not use the other interrupts.
> 
> I've only skimmed the virtualisation bits in xHCI spec, but it seems
> Linux as VMM would still be involved in assigning these interrupts to
> VMs.

I didn't understand this sentence. Are you referring to cases where 
Linux needs to act as the entity using the ctrl_irq[1] ?

On QCOM SoC's, in reality (atleast in device mode) I can say that we 
create the event rings for IPA FW (which registers for ctrl_irq[1]) to 
use and read depevt's. We don't register or get this IRQ from DT and 
then provide to IPA (not even in downstream).

> 
> This may possibly be something that we can ignore for now, but perhaps
> someone more familiar with the hardware, like Thinh, can chime in.
> 
>> Furthermore AFAIK even UEFI/Windows
>> also use only ctrl_irq[0] for host mode in their execution environment
>> today. Do we still need to add this to bindings and DT ?
> 
> But the second interrupt is described in the ACPI tables, which means
> that a simple driver update could (in theory) allow for it to be used.
> 
> You need to get into the same mindset when it comes to devicetree. Even
> if Linux currently does not use an interrupt, like the pwr_event_irq,
> you should still add it so that when/if someone implements support for
> it, an older platform using the original dt may also take advantage of
> it.
>  > Sure, there are complications and we sometimes break DT backwards
> compatibility, but this is the goal that you should strive for.
> 

I agree with you. That we need to make the devicetree as flexible and 
backward compatible as possible.

I will let Thinh comment on whether this IRQ needs to be added to DT or 
not. If someone really wants to add driver support, bindings needs to be 
clear for the driver design in this case (Linux as VMM like you 
mentioned) and I have not idea on the same.

Regards,
Krishna,


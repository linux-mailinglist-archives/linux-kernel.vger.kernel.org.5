Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB0D7D3D22
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjJWRM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJWRM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:12:58 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B63B94;
        Mon, 23 Oct 2023 10:12:56 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39NDrs6u001001;
        Mon, 23 Oct 2023 17:12:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6Dydov/5+Ni6DF1P0Owc+XG9biGIMDaOkcqMYg6b4nQ=;
 b=e9Phh2nZ60FO8S0c1kpJ9+AH7nqSBI4Fn8ogxI2z0pLovbq+ioFLDooQAtsgkumMRXio
 Ig2oHAvAWekU/uX4x8a+1esMDu5rJHp5g9V9VIblbS3PTZTPeG+Xl8kaCdGrt1mqm8Va
 OBf6H3IEQi1dmCVMj2mM7OoVsbSYgB4SW62EALkktEr+ROJpaIZogW1A+m+vs1umBTh7
 HpDd/5yM1V8t/Z0aKqC264RZVsG7qdaTU+LX8C6GGjer+KSYwI6LQCpvqGhvcmwanBOu
 SxejxTRuLV0Auo0bHZLPLewdPaQtlRBf9FqrMEUOndkV+z/GcNP7AiITv586nlRHrUoK mQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tv6r2cppb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 17:12:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39NHChfD007046
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 17:12:43 GMT
Received: from [10.216.7.46] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 23 Oct
 2023 10:12:35 -0700
Message-ID: <fb5e5e1d-520c-4cbc-adde-f30e853421a1@quicinc.com>
Date:   Mon, 23 Oct 2023 22:42:31 +0530
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
References: <20231007154806.605-1-quic_kriskura@quicinc.com>
 <20231007154806.605-6-quic_kriskura@quicinc.com>
 <ZTJ_T1UL8-s2cgNz@hovoldconsulting.com>
 <14fc724c-bc99-4b5d-9893-3e5eff8895f7@quicinc.com>
 <ZTY7Lwjd3_8NlfEi@hovoldconsulting.com>
 <cabf24d0-8eea-4eb5-8205-bf7fe6017ec2@quicinc.com>
 <ZTZ-EvvbuA6HpycT@hovoldconsulting.com>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZTZ-EvvbuA6HpycT@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -aCK_aVKoeab-uVcbJGjupbG1QQpWm_K
X-Proofpoint-GUID: -aCK_aVKoeab-uVcbJGjupbG1QQpWm_K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_16,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 mlxlogscore=802 impostorscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310230150
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/23/2023 7:37 PM, Johan Hovold wrote:
> On Mon, Oct 23, 2023 at 04:54:11PM +0530, Krishna Kurapati PSSNV wrote:
>> On 10/23/2023 2:51 PM, Johan Hovold wrote:
>>> On Mon, Oct 23, 2023 at 12:11:45AM +0530, Krishna Kurapati PSSNV wrote:
>>>> On 10/20/2023 6:53 PM, Johan Hovold wrote:
> 
>>>>> I also don't like the special handling of hs_phy_irq; if this is really
>>>>> just another name for the pwr_event_irq then this should be cleaned up
>>>>> before making the code more complicated than it needs to be.
>>>>>
>>>>> Make sure to clarify this before posting a new revision.
>>>>
>>>> hs_phy_irq is different from pwr_event_irq.
>>>
>>> How is it different and how are they used?
>>>
>>>> AFAIK, there is only one of this per controller.
>>>
>>> But previous controllers were all single port so this interrupt is
>>> likely also per-port, even if your comment below seems to suggest even
>>> SC8280XP has one, which is unexpected (and not described in the updated
>>> binding):
>>>
>>> 	Yes, all targets have the same IRQ's. Just that MP one's have
>>> 	multiple IRQ's of each type. But hs-phy_irq is only one in
>>> 	SC8280 as well.
>>>
>>> 	https://lore.kernel.org/lkml/70b2495f-1305-05b1-2039-9573d171fe24@quicinc.com/
>>>
>>> Please clarify.
>>>
>>
>> For sure pwr_event_irq and hs_phy_irq are different. I assumed it was
>> per-controller and not per-phy because I took reference from software
>> code we have on downstream and hs_phy for multiport is not used
>> anywhere. I don't see any functionality implemented in downstream for
>> that IRQ. And it is only one for single port controllers.
>>
>> But I got the following info from HW page and these are all the
>> interrupts (on apss processor) for multiport (extra details removed):
>>
>> u_usb31_scnd_mvs_pipe_wrapper_usb31_power_event_irq_0	SYS_apcsQgicSPI[130]
>> u_usb31_scnd_mvs_pipe_wrapper_usb31_power_event_irq_1	SYS_apcsQgicSPI[135]
>> u_usb31_scnd_mvs_pipe_wrapper_usb31_power_event_irq_3	SYS_apcsQgicSPI[856]
>> u_usb31_scnd_mvs_pipe_wrapper_usb31_power_event_irq_2	SYS_apcsQgicSPI[857]
>>
>> u_usb31_scnd_mvs_pipe_wrapper_usb31_ctrl_irq[0]	SYS_apcsQgicSPI[133]
>> u_usb31_scnd_mvs_pipe_wrapper_usb31_ctrl_irq[1]	SYS_apcsQgicSPI[134]
> 
> This second core interrupt is also missing in the updated binding... It
> is defined in the ACPI tables so presumably it is needed for the
> multiport controller.
> 
> Do you have any more details on this one?
> 
>> u_cm_usb3_uni_wrapper_mp0_usb3phy_debug_irq	SYS_apcsQgicSPI[668]
>> u_usb31_scnd_mvs_pipe_wrapper_usb31_bam_irq[0]	SYS_apcsQgicSPI[830]
>> u_cm_usb3_uni_wrapper_mp1_usb3phy_debug_irq	SYS_apcsQgicSPI[855]
>>
>> u_usb31_scnd_mvs_pipe_wrapper_usb31_hs_phy_irq_0	SYS_apcsQgicSPI[131]
>> u_usb31_scnd_mvs_pipe_wrapper_usb31_hs_phy_irq_1	SYS_apcsQgicSPI[136]
>> u_usb31_scnd_mvs_pipe_wrapper_usb31_hs_phy_irq_3	SYS_apcsQgicSPI[859]
>> u_usb31_scnd_mvs_pipe_wrapper_usb31_hs_phy_irq_2	SYS_apcsQgicSPI[860]
> 
> Ok, so at least we know hs_phy_irq and pwr_event_irq are distinct and
> both per-port.
> 
> The ACPI tables do not seem to include these, but yeah, that doesn't say
> much more than that the Windows implementation doesn't currently use
> them either.
> 
>> u_cm_dwc_usb2_hs0_usb2_dpse	apps_pdc_irq_out[127]
>> u_cm_dwc_usb2_hs0_usb2_dmse	apps_pdc_irq_out[126]
>> u_cm_dwc_usb2_hs1_usb2_dpse	apps_pdc_irq_out[129]
>> u_cm_dwc_usb2_hs1_usb2_dmse	apps_pdc_irq_out[128]
>> u_cm_dwc_usb2_hs2_usb2_dpse	apps_pdc_irq_out[131]
>> u_cm_dwc_usb2_hs2_usb2_dmse	apps_pdc_irq_out[130]
>> u_cm_dwc_usb2_hs3_usb2_dpse	apps_pdc_irq_out[133]
>> u_cm_dwc_usb2_hs3_usb2_dmse	apps_pdc_irq_out[132]
>> u_cm_usb3_uni_wrapper_mp0_qmp_usb3_lfps_rxterm_irq	apps_pdc_irq_out[16]
>> u_cm_usb3_uni_wrapper_mp1_qmp_usb3_lfps_rxterm_irq	apps_pdc_irq_out[17]
>>
>> Seems like there are 4 IRQ's for HS.
> 
> Right. And I assume there are hs_phy_irqs also for the first two USB
> controllers on sc8280xp?

Hi Johan,

There are, I can dig through and find out. Atleast in downstream I don't 
see any use of them.

> 
> Can you find out anything more about what hs_phy_irq is used for? It
> appears to be an HS wakeup interrupt like the dp/dm ones, but there are
> not really any details on how it is supposed to be used.
> 

  This IRQ is really not used in downstream controllers. Not sure if its 
a good idea to add driver code for that. I did some digging and I got 
the reason why I first said that there is only one hs_phy_irq for 
tertiary port of controller. The hardware programming sequence doesn't 
specify usage of these 4 IRQ's but the hw specifics mention that there 
are 4 of them. Adding driver support for these IRQ's is not a good idea 
(atleast at this point because they are not used in downstream and I am 
not sure what would be the side effect). For now I suggest we can add 
them in bindings and DT and not handle the 4 hs_phy_irq's in the driver 
code (meaning not add the hs_phy_irq to port structure we plan on adding 
to dwc3_qcom).

Also I plan on splitting the patchset into 4 parts (essentially 4 diff 
series):

1. Bindings update for hs_phy_irq's
2. DT patches for MP controller and platform specific files
3. Core driver update for supporting multiport
4. QCOM driver update for supporting wakeup/suspend/resume

This is in accordance to [1] and that way qcom code won't block core 
driver changes from getting merged. Core driver changes are independent 
and are sufficient to get multiport working.

[1]: 
https://lore.kernel.org/all/d4663197-8295-4967-a4f5-6cc91638fc0d@linaro.org/

Regards,
Krishna,

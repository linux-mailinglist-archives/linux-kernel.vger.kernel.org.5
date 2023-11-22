Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF2D7F5098
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 20:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344441AbjKVTc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 14:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344342AbjKVTcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 14:32:53 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC4218E;
        Wed, 22 Nov 2023 11:32:49 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMHiFr9022795;
        Wed, 22 Nov 2023 19:32:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=JzNGPFD86fwsmcahE1+T+6e6VOPxT4djsdC33J37GHE=;
 b=hwev7xaKWkd9pLH+hxGrw1CtHOBeu8My8O2FOfdkIPt2vUafqIdPntj3FrI1Y+h868M1
 jzDsGugFC7NzHR2tnLMzXR+VqbMrYd0EMAeWjrnY86jGuBJk0+uuf+p/M89OyUAt6m1v
 02OWpTMDOyuswu9uhDlK67b88jEehl9lYLbrb1ebtuKphHTsrtpaJUYXRjUbuZc9L8n5
 uUAOBZkXuq6pDRVPv1P0pCZUmNOPYDSMpmTAAbPxxIWawKKFEyuYXn1hujf+e0y8YQiv
 Bw1zKkesQTIkyZ/4nUu7mwhT6kmsIf1I9iX0xQn9mN+qHFrqaw2MPmZqHyBi+lBF/cVv nQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uhgud93ks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 19:32:38 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AMJWbru028998
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 19:32:37 GMT
Received: from [10.216.58.33] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 22 Nov
 2023 11:32:29 -0800
Message-ID: <e0789695-43ee-4285-95e9-4cdee24d6ffe@quicinc.com>
Date:   Thu, 23 Nov 2023 01:02:24 +0530
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
References: <ZTJ_T1UL8-s2cgNz@hovoldconsulting.com>
 <14fc724c-bc99-4b5d-9893-3e5eff8895f7@quicinc.com>
 <ZTY7Lwjd3_8NlfEi@hovoldconsulting.com>
 <cabf24d0-8eea-4eb5-8205-bf7fe6017ec2@quicinc.com>
 <ZTZ-EvvbuA6HpycT@hovoldconsulting.com>
 <fb5e5e1d-520c-4cbc-adde-f30e853421a1@quicinc.com>
 <ZTdqnSHq_Jo8AuPW@hovoldconsulting.com>
 <04615205-e380-4719-aff1-f32c26004b14@quicinc.com>
 <ZUz4RD3MjnLlPn6V@hovoldconsulting.com>
 <6d4d959c-b155-471b-b13d-f6fda557cfe0@quicinc.com>
 <ZVYTFi3Jnnljl48L@hovoldconsulting.com>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZVYTFi3Jnnljl48L@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xpDsdrGASeNU_-wpA1IfUi9Is9mQdoCS
X-Proofpoint-ORIG-GUID: xpDsdrGASeNU_-wpA1IfUi9Is9mQdoCS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_14,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311220142
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/16/2023 6:33 PM, Johan Hovold wrote:
> On Wed, Nov 15, 2023 at 11:12:16PM +0530, Krishna Kurapati PSSNV wrote:
> 
>>> Are you sure there's no support for hs_phy_irq also in the "femto" PHYs
>>> and that it's just that there is currently no driver support for using
>>> them?
>>>
>>> And why is it defined if there is truly no use for it?
> 
>> We had an internal sync up with HW folks and here is some baseline
>> suggestions we received:
>>
>> If DP/DM interrupts are defined, then that is the preferred path to
>> used, irrespective if HS Phy irq is defined or not / or whether it is
>> Femto / QUSB2 target. There is no target that has femto phy but misses
>> DP/DM today.
> 
> Ok, but just knowing that it is "preferred" does not in itself mean that
> it should be removed from the binding.
> 
> We need to know that it's effectively useless (i.e. that the interrupts
> are defined but cannot be triggered) for that.
> 
> We can still use the DP/DM interrupts in favour of HS in the driver
> however.
> 
>> For cases like sdm660/msm8998/msm8953/msm8956, these targets use
>> hs_phy_irq only and don't rely on DP/DM. So we cannot remove the binding
>> in entirety.
> 
> I fixed the binding for those specific platforms last year:
> 
> 	dd566faebe9f ("dt-bindings: usb: qcom,dwc3: refine interrupt requirements")
> 
> But as I mentioned in that commit message the following platforms do not
> have any wakeup interrupts specified in mainline currently:
> 
>        - qcom,ipq4019-dwc3
>        - qcom,ipq6018-dwc3
>        - qcom,ipq8064-dwc3
>        - qcom,ipq8074-dwc3
>        - qcom,msm8994-dwc3
>        - qcom,qcs404-dwc3
> 
> It would be good to get that cleaned up too (i.e. add the missing
> interrupt definitions and update the binding to match).
> 
>>> Also, if hs_phy_irq and dp/dm_phy_irq were mutually exclusive, why does
>>> the following Qualcomm SoCs define all three?
> 
>> HS Phy Irq is redundant or functionality is mutually exclusive in this
>> case. If there are targets that define all three, then we need to update
>> those to only utilize DP/DM interrupts.
> 
> No, as I wrote above that depends on if the HS interrupt is truly
> useless. Otherwise it still belongs in the binding, even if the driver
> uses DP/DM in place of it.
> 
> Again, the binding should describe the hardware, not what a particular
> OS chooses to use.
> 

Hi Johan,

  Sorry for delayed response.

  Pushed [1] to address all the queries and comments. I was initially 
looking at only Femto phy targets, but when I looked at all targets in 
general, seems there is one irq not defined in bindings. It is qubs2_phy 
irq which is named as "hs_phy_irq" on QUSB target DT's (both downstream 
and upstream).

There is one actual "hs_phy_irq" as well but it is not used either by hs 
validation team or sw team on any target. It was put in for debug 
purpose only and doesn't have code to trigger it (even downstream never 
implemented it I suppose) Atleast 4.4 onwards I saw the code but I 
didn't see the actual hs_phy_irq being used. It was the qusb2_phy irq 
named as hs_phy_irq.

Even hw folks used it under the same name which is why they recommended 
using it on qusb2 targets and dp/dm on femto targets.

As we moved from qusb2 to femto phys, since qusb2_phy irq was not 
present, the actual hs_phy_irq was put in the interrupts although it is 
never triggered. That is why when I tried to check on sa8295-adp 
multiport, those 4 hs interrupts never got fired. Hope the explanation 
clears the confusion present around the interrupts.

On some targets the hs_phy_irq was given vector number of pwr_event irq 
also like sm8550/sm8450 etc., I tried to address those as well in the 
series.

Also, per your question as to there are some qusb2 targets having dp/dm 
interrupts defined... It is only for SDM845/SDM670/SM6350 which were 
last in line of using qusb2 phy's and they started incorporating dp/dm 
interrupts.

Also added missing interrupts for qcs404/ipq5332.
I didn't add missing interrupts on sc8280xp because I see that current 
interrupts present are working fine (I see ADB working and wakeup 
working as well), but the interrupt vector numbers are off by "1" 
between hs specifics and DT (both upstream and downstream). Will sort it 
out and clean that target up later.

[1]: https://patchwork.kernel.org/project/linux-arm-msm/list/?series=803412

Regards,
Krishna,

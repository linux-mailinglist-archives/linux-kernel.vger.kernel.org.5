Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897667D4A9F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbjJXImK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbjJXImD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:42:03 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63ECD12C;
        Tue, 24 Oct 2023 01:42:00 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39O7fNlc000679;
        Tue, 24 Oct 2023 08:41:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=gySDwgLbcFWjq9SutAIKJaVMTjlGX9BPGXsVpeNRcBk=;
 b=E3QhKZSUXzkkMHDq3Ss4/eN+D3oZtNXounjWCSBTOLqgIWW/RlWXTJcM2fL5wowPScaT
 YUSfvXTgn4GtAPGAD4GXvAJI67+F00zUw5KeAqPD91ixlfjemxlr4rrM+eTH0mk/pqXQ
 gw2iBC5DZIkGfiZvebMIam9pEWwYDzrUBNEVlN0Drv0hWt5bOVOi464VosOhWkRhkw7j
 gVf6+VOfMyotptBEd8CJkpRvsRG/3maKDYhq62jhKKGwNz90bUYnav/ZeBU0aaZHKU0m
 DuRYFxjff2CtYGA4oxcsuUE1zK7d2JRSDBL9yPZUAy17I7AuFMS1ypBPoxhw/N+NHZq1 cA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3twxa0hebr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Oct 2023 08:41:44 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39O8fhRG011642
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Oct 2023 08:41:43 GMT
Received: from [10.249.18.70] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 24 Oct
 2023 01:41:36 -0700
Message-ID: <00044364-9a6a-4138-9c17-7b0b801e9f10@quicinc.com>
Date:   Tue, 24 Oct 2023 14:11:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 06/10] usb: dwc3: qcom: Enable wakeup for applicable
 ports of multiport
Content-Language: en-US
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
 <20231007154806.605-7-quic_kriskura@quicinc.com>
 <ZTaViatsRY7LCbIX@hovoldconsulting.com>
 <7e9bdd65-35b7-43c2-810a-2cd81f736084@quicinc.com>
 <ZTdt-wyCHh3i0SlK@hovoldconsulting.com>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZTdt-wyCHh3i0SlK@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ksY2q5lXohwGC7tFx5fG0_k9SAMQS3LX
X-Proofpoint-ORIG-GUID: ksY2q5lXohwGC7tFx5fG0_k9SAMQS3LX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_07,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=964 impostorscore=0 clxscore=1015
 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310240073
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/24/2023 12:40 PM, Johan Hovold wrote:
>>>
>>> This comment no longer makes sense with your current implementation.
>>>
>> Can you help elaborate on your comment ? Do you mean that this API
>> doesn't get speed on all ports, but this has to be called in a loop to
>> get all the port speeds ? In that sense, I agree, I can change the
>> comments here.
> 
> It does not make sense to keep only half the comment after your update
> as it is a suggestion for how one could go about and generalise this for
> multiport, which is what you are now doing.
>   

Thanks for explanation. Will update the comments.

>>> But perhaps this should be done using usb_hub_for_each_child() instead
>>> as that may be more efficient. Then you use this function to read out
>>> the speed for all the ports in go (and store it in the port structures I
>>> mentioned). Please determine which alternative is best.
>>>
>> Either ways is fine. We would have qcom->num_ports to determine how many
>> speeds we can read.
> 
> That's not the point. I'm referring to which alternative is less
> computationally expensive and allows for a clean implementation.
> 
> Please do try to figure it out yourself.
> 
I don't think its much of a difference:

while (loop over num_ports) {
	read_usb2_speed()
}

read_usb2_speed() {
	while (loop over num_ports) {
		hub api to read speed.
	}
}

The second one would avoid calling read_usb2_speed multiple times. Will 
take that path.

>>>
>>> [ I realise that the confusion around hs_phy_irq may be partly to blame
>>> for this but since that one is also a per-port interrupt, that's no
>>> longer an issue. ]
>>
>> I don't want to add support for this right away [1]. I would like to
>> keep hs_phy_irq outside the loop for now.
> 
> No. Stop trying to take shortcuts. Again, this is upstream, not
> Qualcomm's vendor kernel.
> 

I don't think it is a shortcut.

The reason I said I would keep it out of loop is I know why we need 
DP/DM/SS IRQ's during wakeup. The wakeup signals come in as 
rising/falling edges in high speed on DP/DM lines and LFPS terminations 
come on SS lines.

So we need these 3 interrupts for sure in wakeup context.
hs_phy_irq is not mandatory for wakeup. Any particular reason why it is 
needed to add driver support for hs_phy_irq's of multiport now ? May be 
I am missing something. If there is any reason why we need to add it 
now, I would try to learn and see if it has any side effects (like 
generating spurious wakeup's) and if nothing, I would add it back to 
port structure.

Regards,
Krishna,

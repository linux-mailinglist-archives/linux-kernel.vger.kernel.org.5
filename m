Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5FF75385E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 12:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235925AbjGNKj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 06:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbjGNKj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 06:39:28 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181A12D7D;
        Fri, 14 Jul 2023 03:39:27 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36EAchJs006972;
        Fri, 14 Jul 2023 10:39:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ft8y8++W0gSJktzj4w4rwWHPmb7Ali0hWzn+S1ORFBg=;
 b=M2cduogny9IEsGHVgoJvIGUTSnlEbKGJcdV/Il99wrPm2HIvyA0tOfmmKCkIl3XwF2Vh
 CaAIx/8SpPnZxJlHdyIFeFeM2tHG8jSGaJlK22Ft/jEn7BZdG4nU0FhhBzvp9sQHcgoI
 Lrui8E2b/asDNxDuQ70bCLlaOGLycW/920kGbS1icKv/70KZM1TJegH8yvNi8vnq0Ez4
 GXYs66WGO5fcmulCAOYDSkJNtPOrDeg2S+yGal5aUIVtWlfFg7ACwi0mafZikiVhttHL
 ouwoYjbgV7ti28u2CyrMU4sDNAVPt/c6Y+8GBq6d8UECt+gsP6Vdepa4vEJ2Vzudy/84 /w== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rtptp9g7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 10:39:12 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36EAcsKJ026243
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 10:38:54 GMT
Received: from [10.216.17.90] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 14 Jul
 2023 03:38:48 -0700
Message-ID: <f02104c0-d177-0e4e-dcb0-ffca589c8b00@quicinc.com>
Date:   Fri, 14 Jul 2023 16:08:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v8 6/9] usb: dwc3: qcom: Add multiport controller support
 for qcom wrapper
To:     Johan Hovold <johan@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Jack Pham <quic_jackp@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, <ahalaney@redhat.com>
References: <20230514054917.21318-1-quic_kriskura@quicinc.com>
 <20230514054917.21318-7-quic_kriskura@quicinc.com>
 <ZIB1JEmLCw41v_4e@hovoldconsulting.com>
 <ZJsDpqttBYtbQ0yg@hovoldconsulting.com>
 <26ae15d1-4e13-3ab7-6844-3a7d3ed03af4@quicinc.com>
 <ZLEOk-9VImJNHYHa@hovoldconsulting.com>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZLEOk-9VImJNHYHa@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZFsK8WVLL5aJ51KGivOWNh6MsZzmpxk8
X-Proofpoint-ORIG-GUID: ZFsK8WVLL5aJ51KGivOWNh6MsZzmpxk8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_05,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=697 impostorscore=0
 mlxscore=0 clxscore=1011 bulkscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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



On 7/14/2023 2:30 PM, Johan Hovold wrote:
> On Mon, Jul 03, 2023 at 12:35:48AM +0530, Krishna Kurapati PSSNV wrote:
>> On 6/27/2023 9:13 PM, Johan Hovold wrote:
>>> On Wed, Jun 07, 2023 at 02:16:37PM +0200, Johan Hovold wrote:
>>>> On Sun, May 14, 2023 at 11:19:14AM +0530, Krishna Kurapati wrote:
> 
>>>>> -	val = readl(qcom->qscratch_base + PWR_EVNT_IRQ_STAT_REG);
>>>>> -	if (!(val & PWR_EVNT_LPM_IN_L2_MASK))
>>>>> -		dev_err(qcom->dev, "HS-PHY not in L2\n");
>>>>> +	for (i = 0; i < dwc->num_usb2_ports; i++) {
>>>>> +		val = readl(qcom->qscratch_base + pwr_evnt_irq_stat_reg_offset[i]);
>>>>> +		if (!(val & PWR_EVNT_LPM_IN_L2_MASK))
>>>>> +			dev_err(qcom->dev, "HS-PHY%d not in L2\n", i);
>>>>> +	}
>>>
>>>> When testing this on the X13s I get:
>>>>
>>>> 	dwc3-qcom a4f8800.usb: HS-PHY2 not in L2
>>>>
>>>> for the third port, whose status registers always seems to return zero
>>>> (e.g. as if we're checking the wrong register?):
>>>>
>>>> dwc3-qcom a4f8800.usb: dwc3_qcom_suspend - phy 0, pwr_event_stat = 38103c
>>>> dwc3-qcom a4f8800.usb: dwc3_qcom_suspend - phy 1, pwr_event_stat = 38103c
>>>> dwc3-qcom a4f8800.usb: dwc3_qcom_suspend - phy 2, pwr_event_stat = 00
>>>> dwc3-qcom a4f8800.usb: dwc3_qcom_suspend - phy 3, pwr_event_stat = 140030
>>>>
>>>> I verified that everything appears to work as expected on sa8295p-adp.
>>>>
>>>> Do you have any idea of what may be causing this?
>>>
>>> You never replied to this; do you have any idea why the status register
>>> for the second port seemingly always read back as 0 on the X13s?
> 
>>    Missed this mail. This never popped up on my system. So no idea what
>> is different in Lenovo X13s. Might need to check with team internally.
> 
> Did you hear anything back regarding the above?
> 
> Could it even be that the register offset it not correct for sc8280xp?
>

Hi Johan,

No. I rechecked the register offsets and they are proper. (same as what 
we are using in downstream).

Adding Jack and Wesley to help with any suggestions here.

Regards,
Krishna,

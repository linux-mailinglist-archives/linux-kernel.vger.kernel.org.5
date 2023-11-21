Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675627F2DCB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 13:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbjKUM4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 07:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbjKUMz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 07:55:59 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7925EA2;
        Tue, 21 Nov 2023 04:55:55 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALA9glV006337;
        Tue, 21 Nov 2023 12:55:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=oo/8E+Gw44yuR+d9JINVYw3emQyGUhU4h+anNeHC+3o=;
 b=jtiMS4RHnZsw/4afHOUMFex075JoXFsbz/UWxdCyRF2+u3GXU/KdWYjtlLWO5a3p3sKB
 5bYkJu3w6f9DO/fotUu0KZ5/enXRswRNQ9iheeawQIb1Znof1IQcgZJLX8QRZhykmmVh
 yIWCmi7Oav3q8eJXOFClrJ5rOEHcCW5eP51XV+z5bx+yvrTYaisXZm1r2nOFXc1taadL
 gAGGkhc3Baf6RPMRYrV0X6bYbL+MJE16GEZXZXphLjFiIintJxgX/sNllEp7v9otml78
 ILX3r5Rr3vD8IYMzcM2yFG98cgHNnnWRlSvZxfuJxrAtPtzHHG9c+hnRuGHxEl1hDE3P eg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ugge19whh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 12:55:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ALCtl7P012651
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 12:55:47 GMT
Received: from [10.216.58.75] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 21 Nov
 2023 04:55:41 -0800
Message-ID: <0b627853-78fb-4320-84e4-f88695ac6a9e@quicinc.com>
Date:   Tue, 21 Nov 2023 18:25:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] USB: dwc3: qcom: fix wakeup after probe deferral
To:     Johan Hovold <johan@kernel.org>,
        Andrew Halaney <ahalaney@redhat.com>
CC:     Johan Hovold <johan+linaro@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20231120161607.7405-1-johan+linaro@kernel.org>
 <20231120161607.7405-3-johan+linaro@kernel.org>
 <pgmtla6j3dshuq5zdxstszbkkssxcthtzelv2etcbrlstdw4nu@wixz6v5dfpum>
 <3ff65t36p6n3k7faw2z75t2vfi6rb5p64x7wqosetsksbhhwli@5xaxnm7zz4tu>
 <ZVx1wRefjNaN0byk@hovoldconsulting.com>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZVx1wRefjNaN0byk@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yw1N5N56u4D570tpMa96h-cgcZ0q_GIE
X-Proofpoint-ORIG-GUID: yw1N5N56u4D570tpMa96h-cgcZ0q_GIE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_05,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=479 phishscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311210100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
>> I get that dwc3_qcom_enable_interrupts() limits the scope of what wakes us
>> up to what we expect given the current device (or lack thereof), but it
>> doesn't seem like you're really meant to play with the IRQ triggers,
>> or at least the warning you shared makes me think it is not a great idea
>> if you plan to probe the device ever again in the future.
>>
>> I'll post the current comment in dwc3_qcom_enable_interrupts() to
>> explain the "limits the scope of what wakes us up" a bit more clearly:
>>
>> 	/*
>> 	 * Configure DP/DM line interrupts based on the USB2 device attached to
>> 	 * the root hub port. When HS/FS device is connected, configure the DP line
>> 	 * as falling edge to detect both disconnect and remote wakeup scenarios. When
>> 	 * LS device is connected, configure DM line as falling edge to detect both
>> 	 * disconnect and remote wakeup. When no device is connected, configure both
>> 	 * DP and DM lines as rising edge to detect HS/HS/LS device connect scenario.
>> 	 */
> 
> Yes, that is how it is currently implemented and I intend to change that
> shortly. I just wanted to get the fixes out first.
> 
> Specifically, I consider the current implementation to be broken in that
> it generates wakeup events on disconnect which is generally not want you
> want. Consider closing the lid of your laptop and disconnecting a USB
> mouse before putting it in your backpack. Now it's no longer suspended
> as you would expect it to be.
> 
> With the devictrees soon fixed, we could also do away with changing the
> trigger type, but since this is how it was implemented initially we now
> need to consider backward compatibility with the broken DTs. We've dealt
> with that before, but yeah, getting things right from the start would
> have been so much better.
> 

Hi Johan,

  Just one query. Even if it wakes up after closing the lid and removing 
the mouse, wouldn't pm suspend be triggered again later by the system 
once it sees that usb is also good to be suspended again ? I presume a 
laptop form factor would be having this facility of re-trigerring 
suspend. Let me know if this is not the case.

Also, the warning you are mentioning in [1] comes because this is a 
laptop form factor and we have some firmware running (I don't know much 
about ACPI and stuff) ?

[1]: 
https://lore.kernel.org/all/20231120161607.7405-3-johan+linaro@kernel.org/

Regards,
Krishna,

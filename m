Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F40F7F3050
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbjKUOIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbjKUOIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:08:45 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BA5122;
        Tue, 21 Nov 2023 06:08:41 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALE3BQd003689;
        Tue, 21 Nov 2023 14:08:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=POpR3zBeE/oq6Awlmfos35Xeq30KeghiCZoFjDFpWoc=;
 b=Qp7XNg9YBUTHvs9EeaEW6fccrXMgVNjjYNF+a3pepF2PSuGb+F6NZTwzRu8Ppxf6O4db
 pYeLMrw86Ow62TMPrh4SAs827vvv0iXO23hr5AlCUklN2KWbLHk9bzCNyT9J7ypp2o5C
 eMel6jEYBfr3xS1o4eqT4nqwFZ+J52NC7L/3jGViNpUMrRBGyuVadke8msuC3VxRrma8
 TUIDhNAaumgE/EeL/FfaDfyin3zmUMNr9Uuwp37LlpZkCxS8N3sWN70Nf7Jwm/BHN8gD
 ySaiI5jqY9tL50rYroQTVQAju+DKUkkNnf+4Zn4YG8KOEEUeFSAjn9SHpMZGi/jiEF3I Eg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ugcqs2qtr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 14:08:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ALE8R0q012819
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 14:08:27 GMT
Received: from [10.216.58.75] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 21 Nov
 2023 06:08:22 -0800
Message-ID: <ac838113-501a-4f2b-b858-c59f586a9f35@quicinc.com>
Date:   Tue, 21 Nov 2023 19:38:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] USB: dwc3: qcom: fix wakeup after probe deferral
To:     Johan Hovold <johan@kernel.org>
CC:     Andrew Halaney <ahalaney@redhat.com>,
        Johan Hovold <johan+linaro@kernel.org>,
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
 <0b627853-78fb-4320-84e4-f88695ac6a9e@quicinc.com>
 <ZVy1kAslWYOQ6n9q@hovoldconsulting.com>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZVy1kAslWYOQ6n9q@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YeSi6sONWbW_gTpRreo2ZTUy8U9Np8im
X-Proofpoint-GUID: YeSi6sONWbW_gTpRreo2ZTUy8U9Np8im
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_05,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015 mlxlogscore=420
 mlxscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311210110
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>    Just one query. Even if it wakes up after closing the lid and removing
>> the mouse, wouldn't pm suspend be triggered again later by the system
>> once it sees that usb is also good to be suspended again ? I presume a
>> laptop form factor would be having this facility of re-trigerring
>> suspend. Let me know if this is not the case.
> 
> No, we generally don't use opportunistic suspend (e.g. unlike android)
> so the laptop will not suspend again.
> 
> So this is an actual bug affecting, for example, the Lenovo ThinkPad
> X13s.
> 
Thanks for the clarification. I was thinking in android perspective 
only. But if we don't wake up the system upon disconnect, wouldn't the 
controller still be under the assumption that device is connected when 
it is actually not and only realise this when we resume later ?

>> Also, the warning you are mentioning in [1] comes because this is a
>> laptop form factor and we have some firmware running (I don't know much
>> about ACPI and stuff) ?
> 
> No, the "firmware" in this case is just the devicetree which has the
> DP/DM interrupts defined as edge-triggered while the driver requests
> them as level triggered.
> 
> (It would look similar with ACPI firmware which also has these declared
> as edge triggered.)
> 
Got it. Thanks for the clarification.

Regards,
Krishna,

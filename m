Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500427D4B29
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbjJXIzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234083AbjJXIyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:54:47 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC76610E9;
        Tue, 24 Oct 2023 01:54:19 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39O8Y6gO025163;
        Tue, 24 Oct 2023 08:54:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=W6ajn5ipoxlzEj1no8f6ESzNsQM/d79ox1pO89tPgJk=;
 b=mY75BUOxHVDp99Yn+QNle4PyXsbXIzy+EZEexKzuZSs6SLhxYGfT2KemFETwNWnnz876
 jM78JtX3s7ZefCroPmjiwTjcKn/ab5n6rd3gFuHr7i4j1Zbqm8vcYI9ObM09GC4koxlb
 otU8QlKbLE75+jusrvzF1te0j5Zo0qJyotOx9Lmrb0TB8iheZAkLvBUU8qJ5A/WpKOpL
 idTV6T79sqZbfsT0Sz/Iwvy9N4JL3Nt6a51wdJRkxNZPAII5ls73R2WtTandfiidDkub
 WgVfABgz/JD9QQuCq81cbj7DywQfJ7Acaq+5Pzpm9E5/L1yE7wsWNB7l7zAGLPb00hwS yQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tx5f58jnv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Oct 2023 08:54:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39O8s7Ej005073
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Oct 2023 08:54:07 GMT
Received: from [10.249.18.70] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 24 Oct
 2023 01:54:00 -0700
Message-ID: <196601cc-f8c6-4266-bfff-3fd69f0ab31c@quicinc.com>
Date:   Tue, 24 Oct 2023 14:23:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 05/10] usb: dwc3: qcom: Refactor IRQ handling in QCOM
 Glue driver
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
 <20231007154806.605-6-quic_kriskura@quicinc.com>
 <ZTJ_T1UL8-s2cgNz@hovoldconsulting.com>
 <14fc724c-bc99-4b5d-9893-3e5eff8895f7@quicinc.com>
 <ZTY7Lwjd3_8NlfEi@hovoldconsulting.com>
 <cabf24d0-8eea-4eb5-8205-bf7fe6017ec2@quicinc.com>
 <ZTZ-EvvbuA6HpycT@hovoldconsulting.com>
 <fb5e5e1d-520c-4cbc-adde-f30e853421a1@quicinc.com>
 <ZTdqnSHq_Jo8AuPW@hovoldconsulting.com>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZTdqnSHq_Jo8AuPW@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kbMudVGa0LNV5015FDNoHqNKOSEaamK2
X-Proofpoint-ORIG-GUID: kbMudVGa0LNV5015FDNoHqNKOSEaamK2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_07,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 bulkscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310240074
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/24/2023 12:26 PM, Johan Hovold wrote:
> 
> You need to provide this information so that we can determine what the
> binding should look like. The implementation would also be simplified if
> we don't have to add random hacks to it just because we don't know why
> the vendor driver you refer does not use it currently on this particular
> platform.
> 
>> Also I plan on splitting the patchset into 4 parts (essentially 4 diff
>> series):
>>
>> 1. Bindings update for hs_phy_irq's
>> 2. DT patches for MP controller and platform specific files
>> 3. Core driver update for supporting multiport
>> 4. QCOM driver update for supporting wakeup/suspend/resume
>>
>> This is in accordance to [1] and that way qcom code won't block core
>> driver changes from getting merged. Core driver changes are independent
>> and are sufficient to get multiport working.
> 
> No, you clearly did not understand [1] at all. And stop trying to game
> the upstreaming process. Bindings and driver patches go together. The
> devicetree changes can be sent separately in case of USB but only
> *after* the first set has been merged.
> 
> If the code had been in good shape from the start it would have been
> merged by now. Just learn from your mistakes and next time things will
> be smoother.
> 

I agree that bindings should go first. My point is core bindings are 
already approved and merged and just wanted to check if core driver 
changes can be merged without glue blocking them. Core driver changes 
have nothing to do with interrupt handling in glue. If we get the core 
changes merged separately after fixing the nits mentioned, we can take 
up this interrupt handling in glue in parallel. I am just trying to see 
if we can start merging independent portions of code. I agree that my 
glue driver changes are still not upto mark. But that has nothing to do 
with core driver changes.

Please let me know if that is appropriate because I think functionality 
intended by changes in core is independent of glue driver and glue 
bindings. If anything glue is partially dependent on core changes (like 
the MAX_PORTS macro etc., but not the other way around).

Regards,
Krishna,

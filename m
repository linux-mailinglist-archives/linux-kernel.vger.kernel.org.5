Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEB5779E42
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 10:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbjHLIoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 04:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjHLIof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 04:44:35 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E5A2684;
        Sat, 12 Aug 2023 01:44:38 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37C8cDW6028216;
        Sat, 12 Aug 2023 08:44:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=OsdxZvdl9pwXq5voNg4lOxkgVgJX1Zba/evsPQKR9NI=;
 b=WgPpEQqNGYvmZIpoSpNu3WOZwTAcg0bKtIpQTqm0eiVPnCiepziI5x5PoJOFePjoprL3
 xJXc3jVhJXk3bhjAM8kHy/9c2+Tk1TzG4iKUPvDUyubnA3WY0sijjs80R7oR5kyCX0m9
 hrOzn53aBmbubm+sFQK/++rZTknYNPNckX6HEoe5NQMTLeR2baUUodHb6x3QQoQnNcc1
 Ufusc0s4jK2v43PCuoqI0KroQeyv86xF94JCZRqQlpet7zSFawflCtKMVryC0SfaAN0z
 tH7sxWS9vMXjcei3iZ+vUlpNtXX/VTCvwIvwpGEJbeipxsPTMNLJSQN5YDeKOhqsiTmY Lw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3se3fqg6ms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Aug 2023 08:44:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37C8iLJ2028009
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Aug 2023 08:44:21 GMT
Received: from [10.216.24.170] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Sat, 12 Aug
 2023 01:44:14 -0700
Message-ID: <b29eee9b-69f6-b0e4-b114-a60a6c5876dc@quicinc.com>
Date:   Sat, 12 Aug 2023 14:14:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v10 06/11] usb: dwc3: qcom: Refactor IRQ handling in QCOM
 Glue driver
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Johan Hovold <johan@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, <ahalaney@redhat.com>,
        <quic_shazhuss@quicinc.com>
References: <20230727223307.8096-1-quic_kriskura@quicinc.com>
 <20230727223307.8096-7-quic_kriskura@quicinc.com>
 <pyxerd3lirbh2p43m74ohwocjjb7uh56xxmaxbrkay3svossik@ksd3yojw5wgr>
 <dc800b15-e35d-207b-73a8-9a3d2261f4f5@quicinc.com>
 <30b1fe67-bab5-4add-8d89-cc8e06cd8c7f@linaro.org>
 <3c8dff80-eec8-1721-8ab0-3cf12d4c1df4@quicinc.com>
 <c8d77d4f-6696-4dc9-8030-daf1d10b114b@linaro.org>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <c8d77d4f-6696-4dc9-8030-daf1d10b114b@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GYbjawIKi349kcKBB3xzsdPFD5UWw6VQ
X-Proofpoint-ORIG-GUID: GYbjawIKi349kcKBB3xzsdPFD5UWw6VQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-12_07,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=918 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308120080
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/11/2023 10:35 PM, Konrad Dybcio wrote:
>>>>>> +static int dwc3_get_port_irq(struct platform_device *pdev, u8 port_index)
>>>>>> +{
>>>>>> +    struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
>>>>>> +    bool is_mp_supported = (qcom->data->num_ports > 1) ? true : false;
>>>>>> +    const struct dwc3_acpi_pdata *pdata = qcom->acpi_pdata;
>>>>>> +    char *disp_name;
>>>>>> +    int acpi_index;
>>>>>> +    char *dt_name;
>>>>>> +    int ret;
>>>>>> +    int irq;
>>>>>> +    int i;
>>>>>> +
>>>>>> +    /*
>>>>>> +     * We need to read only DP/DM/SS IRQ's here.
>>>>>> +     * So loop over from 1->3 and accordingly modify respective phy_irq[].
>>>>>> +     */
>>>>>> +    for (i = 1; i < MAX_PHY_IRQ; i++) {
>>>>>> +
>>>>>> +        if (!is_mp_supported && (port_index == 0)) {
>>>>>> +            if (i == DP_HS_PHY_IRQ) {
>>>>>> +                dt_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
>>>>>> +                    "dp_hs_phy_irq");
>>>>>> +                disp_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
>>>>>> +                    "qcom_dwc3 DP_HS");
>>>>>> +            } else if (i == DM_HS_PHY_IRQ) {
>>>>>> +                dt_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
>>>>>> +                    "dm_hs_phy_irq");
>>>>>> +                disp_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
>>>>>> +                    "qcom_dwc3 DM_HS");
>>>>>> +            } else if (i == SS_PHY_IRQ) {
>>>>>> +                dt_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
>>>>>> +                    "ss_phy_irq");
>>>>>> +                disp_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
>>>>>> +                    "qcom_dwc3 SS");
>>>> Bjorn, Konrad,
>>>>
>>>> If we are to remove this repetitive loops, we might need to make a 2D array for all of Dp/Dm/Ss interrutps and make a global array of names to be used for irq lookup and use them to reduce the if-else-if stuff here. If that is fine, I can make those changes, else I would like to stick to this approach for now because if we don't add the global array of names, prepping them seperately for dp/dm/ss would again lead us to making if-else loops like above.
>>>>
>>>> Please let me know your thoughts on this.
>>> Can we not just reuse the associated interrupt-names from the devicetree
>>> if present?
>>>
>> Hi Konrad,
>>
>>   Thanks for the comments but one more confirmation.
>> We can read the interrupts from DT but I believe the compatible would still need to stay. We need the num_ports information not just for registering interrupts but for modifying the pwr_event_irq registers during suspend/resume. If we rely on the interrupts to find the number of ports, the user is free to remove any IRQ and we might end up in a situation where glue and core are not having same view of how many number of ports present. So I believe its best to keep the compatible and get num_ports info from there and rely on reading interrupt-names to get interrupts cleanly. Can you let me know your view on the same.
> So is "is it okay to add SoC-specific compatibles and add the port number in
> match data" what you're asking?
> 
> If so, that doesn't seem right.
> 
> The user should not "feel free to remove any IRQ", modifying the devicetree to
> depict a subset of the hardware is not something we want to support. The driver
> has to work with the "full" description in accordance with the bindings.
> 

Hi Konrad,

Thanks for the review.

While I agree with you that we must not skip any hw specifics in DT, 
there is nothing stopping the user from doing so right ?

And whatever be the case, we must be a fool-proof and fail safe system 
able to handle all such situations. While we can read interrupt IRQ 
prefixes to get port count in one way or other, adding a compatible 
would be the least ambiguous path. Is there any other concern you see in 
adding a compatible ? I might be missing something because even Bjorn's 
suggestion too was to try and avoid a new compatible addition and to add 
it only if we have no other way of reliably reading the port count 
(which I believe would be an issue if we need to rely on interrupt name 
reading).

Regards,
Krishna,

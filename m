Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C322D7926E0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349892AbjIEQWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353119AbjIEGGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 02:06:09 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7A21B6;
        Mon,  4 Sep 2023 23:06:04 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3855tPUL012448;
        Tue, 5 Sep 2023 06:05:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=RV5FWQ73XK+f8PdBSISph3znAM1t6TuzeQNdg37F70o=;
 b=HopkQ311ri7ivotqUbBziFSQNM5JwMQji+TPOcuaoMejSr7OZ44r7yASFrTiMIzIaRhj
 1WuviZ61TXj9GGVbzh18s9fJ/86EJ1ekeWaNakbWKUJczhz/05UaGCCtWxQ4MtWtkrGF
 LL+wWuGFFk+tpauIyz+Y6H3PAFjDGfMCeLS7x1nfm59faGPHnfH4Hrhb8CSDd062WPA6
 SeD65huM2WXiAYqD1MRzr/wapOGHcY7c8ep2pNp0KOomT4v1oqudEqKf1Py9asw6zp4+
 9LDJnlFElngoNsq1RQ6xV2h+/oY/mpVYb8fRoHtcTXXe+C2ec8mVbHvQ5IeL9PlxlzVC Ig== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3swtr88cv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 06:05:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38565elU005840
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 5 Sep 2023 06:05:40 GMT
Received: from [10.216.31.184] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 4 Sep
 2023 23:05:33 -0700
Message-ID: <3e547120-0139-92db-ba21-a5371dc49907@quicinc.com>
Date:   Tue, 5 Sep 2023 11:35:30 +0530
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
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XG0UrPy2WDdZZS-Vmk66dhseZHUGF2Mb
X-Proofpoint-ORIG-GUID: XG0UrPy2WDdZZS-Vmk66dhseZHUGF2Mb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_04,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 impostorscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309050054
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/11/2023 10:35 PM, Konrad Dybcio wrote:
>>>>>> +
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

Hi Konrad, Johan,

Thanks for the suggestions / review comments and taking the time out for 
reviewing them. Pushed v11 implementing the above suggestion of 
identifying port_count by reading through the interrupt-names. Please 
help let know your review on the same.

Regards,
Krishna,

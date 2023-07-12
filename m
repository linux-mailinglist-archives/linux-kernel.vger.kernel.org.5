Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E5275107E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 20:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbjGLS1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 14:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbjGLS04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 14:26:56 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38651BEC;
        Wed, 12 Jul 2023 11:26:54 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36C8e7FA025489;
        Wed, 12 Jul 2023 18:26:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=mtKhEYS2K6X6LBtwPqDWhL1CJqJw4DS1omIajDx5ciM=;
 b=kdsNgjdUBhmwZnk+aZt4Ujk/GPBTCK1JSvcGs1qbfEfG0k0C5DFS5aahFTePkp85q7XF
 eM8DdXm1z5VYNHudXdnuG1qObW5tUHywSN61sDIx3uzwlwhfaagtq6237jDS9MnvkTU5
 dNaTjeqRJoWHDi+azMc2b9hQbhcOYpp0ukEt6oK0AJoqf+DuKhsbvBhgbBtUrT84/+Jp
 RgBm1OaYv+aOmnpZrP8wH3p2KBKqBINUJ/92aL7G6rbNNgdYgP0hsR4gA8QLj9Njf1KJ
 BXkt0SAS1hLgfJRfdwbZQiH5pgLishusnE1BFn9ZtD9EUS36cId4phJusmLDc1RBb5Dz oQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rser0tce9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 18:26:44 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36CIQhJt019354
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 18:26:43 GMT
Received: from [10.216.46.65] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 12 Jul
 2023 11:26:36 -0700
Message-ID: <ef29e520-7b9c-f581-e70a-250df80d3821@quicinc.com>
Date:   Wed, 12 Jul 2023 23:56:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v9 06/10] usb: dwc3: qcom: Add support to read IRQ's
 related to multiport
To:     Johan Hovold <johan@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        "Wesley Cheng" <quic_wcheng@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, <quic_harshq@quicinc.com>,
        <ahalaney@redhat.com>, <quic_shazhuss@quicinc.com>
References: <20230621043628.21485-1-quic_kriskura@quicinc.com>
 <20230621043628.21485-7-quic_kriskura@quicinc.com>
 <ZK6YrLMn9r39zEeB@hovoldconsulting.com>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZK6YrLMn9r39zEeB@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZqQVfb4cm-Gui-6o8lMtobbyBRypXh4P
X-Proofpoint-ORIG-GUID: ZqQVfb4cm-Gui-6o8lMtobbyBRypXh4P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_13,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=618
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307120167
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/12/2023 5:42 PM, Johan Hovold wrote:
> On Wed, Jun 21, 2023 at 10:06:24AM +0530, Krishna Kurapati wrote:
>> Add support to read Multiport IRQ's related to quad port controller
>> of SA8295 Device.
>>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
>>   drivers/usb/dwc3/dwc3-qcom.c | 108 +++++++++++++++++++++++++++++------
>>   1 file changed, 91 insertions(+), 17 deletions(-)
> 
>> +static int dwc3_qcom_setup_mp_irq(struct platform_device *pdev)
>> +{
>> +	struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
>> +	char irq_name[15];
> 
> The interrupt device-name string can not be allocated on the stack or
> reused as it is stored directly in each irqaction structure.
> 
> This can otherwise lead to random crashes when accessing
> /proc/interrupts:
> 
> 	https://lore.kernel.org/lkml/ZK6IV_jJPICX5r53@hovoldconsulting.com/
> 
Hi Johan,

   Sure, will create a static array of names if possible in global 
section of file and use it to read interrupts.

   Are you fine with seperating out setup_irq and setup_mp_irq functions 
? Can you please review comments and suggestion on [1].

[1]: 
https://lore.kernel.org/all/bf62bdf4-cc9e-ba7b-2078-cfd60f5dd237@quicinc.com/

Regards,
Krishna,

>> +	int irq;
>> +	int ret;
>> +	int i;
>> +
>> +	for (i = 0; i < 4; i++) {
>> +		if (qcom->dp_hs_phy_irq[i])
>> +			continue;
>> +
>> +		sprintf(irq_name, "dp%d_hs_phy_irq", i+1);
>> +		irq = dwc3_qcom_get_irq(pdev, irq_name, -1);
>> +		if (irq > 0) {
>> +			irq_set_status_flags(irq, IRQ_NOAUTOEN);
>> +			ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
>> +					qcom_dwc3_resume_irq,
>> +					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
>> +					irq_name, qcom);
>> +			if (ret) {
>> +				dev_err(qcom->dev, "%s failed: %d\n", irq_name, ret);
>> +				return ret;
>> +			}
>> +		}
>> +
>> +		qcom->dp_hs_phy_irq[i] = irq;
>> +	}
> 
> Johan

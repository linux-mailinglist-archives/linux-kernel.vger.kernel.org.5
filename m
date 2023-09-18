Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500497A4351
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240460AbjIRHpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240510AbjIRHoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:44:39 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC35FCF8;
        Mon, 18 Sep 2023 00:43:08 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38I6ld5U014295;
        Mon, 18 Sep 2023 07:42:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=kW+M14qfpcF97hoQluC9tM98hOjjeZ40Kqhq2jXRfr8=;
 b=BGvjtnWK+Cg0TYVBbxLWhrVTI8OTU9Zs/doYmTy+ShojJHz2wvzUOTO1zwUih1hfSXE4
 X2SugyTqUUds5ABNOvMIMwO69sp383+R3XzHQHqYBi0Uga/aWVpk+7wLcDV+S0RhfCZM
 jSPNvQmEu4cOa0wVKSIKQ8ZxNjU8u3QuZBx+lJLXzh1tlUwABr0YwBz72R9BkJqI8ih6
 G5sYy5UXnlAoC/SMCLPVtEvQ8fnB7Timyza7YoFyTU/rqQwLd2pey/8aEKx8k7SxLsF8
 6jbsPAOjPACUJSaxxorbuc8L+lxyVf2UZhuVKTdKTVa3gjCTPf/1oZUt50NGVzb0+8fF EA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t53ayaqgp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 07:42:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38I7gqMm015793
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 07:42:52 GMT
Received: from [10.216.25.71] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 18 Sep
 2023 00:42:45 -0700
Message-ID: <961b0ad4-baac-4ca4-bc2a-7dae6f129e6f@quicinc.com>
Date:   Mon, 18 Sep 2023 13:12:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 10/13] usb: dwc3: qcom: Add multiport suspend/resume
 support for wrapper
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Johan Hovold <johan@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, <ahalaney@redhat.com>,
        <quic_shazhuss@quicinc.com>
References: <20230828133033.11988-1-quic_kriskura@quicinc.com>
 <20230828133033.11988-11-quic_kriskura@quicinc.com>
 <825bc60b-2067-43e2-8b43-9d38b7cebf02@linaro.org>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <825bc60b-2067-43e2-8b43-9d38b7cebf02@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CxEyHg7gQX47R1U-FyrDzTqzLzbI0dFx
X-Proofpoint-ORIG-GUID: CxEyHg7gQX47R1U-FyrDzTqzLzbI0dFx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_20,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 spamscore=0 mlxscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=411 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309180067
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/15/2023 7:18 PM, Konrad Dybcio wrote:
>>   
>> -#define PWR_EVNT_IRQ_STAT_REG			0x58
>> +#define PWR_EVNT_IRQ1_STAT_REG			0x58
>> +#define PWR_EVNT_IRQ2_STAT_REG			0x1dc
>> +#define PWR_EVNT_IRQ3_STAT_REG			0x228
>> +#define PWR_EVNT_IRQ4_STAT_REG			0x238
>> +
>>   #define PWR_EVNT_LPM_IN_L2_MASK			BIT(4)
>>   #define PWR_EVNT_LPM_OUT_L2_MASK		BIT(5)
>>   
>> @@ -107,6 +111,19 @@ struct dwc3_qcom {
>>   	int			num_ports;
>>   };
>>   
>> +/*
>> + * SA8295 has 4 power event IRQ STAT registers to be checked
>> + * during suspend resume.
>> + */
> But this driver supports much more than just SA8295?
> 
Yes. Other than SA8295, all single port controllers and SA8195(2 port 
controller), have these reigsters.

The rational behind adding this array was that depending on num_ports, 
any controller can access its required pwr_event_irq_stat register and 
loop in the suspend/resume code would take care of it. Perhaps I can 
change the comments to indicate that the array would be used by all 
controllers and not just SA8295.

>> +#define NUM_PWR_EVENT_STAT_REGS	4
>> +
>> +static u32 pwr_evnt_irq_stat_reg_offset[NUM_PWR_EVENT_STAT_REGS] = {
>> +	PWR_EVNT_IRQ1_STAT_REG,
>> +	PWR_EVNT_IRQ2_STAT_REG,
>> +	PWR_EVNT_IRQ3_STAT_REG,
>> +	PWR_EVNT_IRQ4_STAT_REG,
>> +};
>> +
>>   static inline void dwc3_qcom_setbits(void __iomem *base, u32 offset, u32 val)
>>   {
>>   	u32 reg;
>> @@ -440,15 +457,19 @@ static void dwc3_qcom_enable_interrupts(struct dwc3_qcom *qcom)
>>   
>>   static int dwc3_qcom_suspend(struct dwc3_qcom *qcom, bool wakeup)
>>   {
>> +	u8 num_ports;
> Maybe I'm picky, but I'm not sure defining a variable for
> a single use of an object with a rather short name
> (qcom->num_ports) is justified, here and below..
> 

Sure, will replace num_ports with (qcom->num_ports) and remove the extra 
variable.

Regards,
Krishna,

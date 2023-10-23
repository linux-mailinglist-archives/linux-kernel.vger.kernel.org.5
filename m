Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722577D3D6B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjJWRXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJWRXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:23:06 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E1F94;
        Mon, 23 Oct 2023 10:23:04 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39NFIHY8029974;
        Mon, 23 Oct 2023 17:22:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=YBiruN5lcd/bt3zmAyAE5AHrGYVSZocWIiviVEybvDo=;
 b=PgtnLtcveOQ70EnnMvzGrdvTQ6+iFwQovTuVz6U+yl9uOVd2hvtnuwFrG8aIhTXAX6cA
 l7vBOhKjqEZh3DMwwx9t3GXQwrPawjFAbOk38jB1fq5JOnNB7OZowq2M7Y92IbSwUbRQ
 i0YBLEnrzvLDoT94jUJguowuKz/I2YFNo6Kkxcz3bXyAF1esrBzwZuIk8An+a5LkwIx7
 DmIjz4G14VgcS6m3TdRhUZIeqlRXM4we20bDatA8qUhfZ5apNUUOkbNle+dTluVc+/2O
 J18NZ3q/ZTTr5CvuMpocY+Jm97JvLnPBzidcqaEjyhUO+gxnyPP+mlg5/BPSS2BvYT3P Og== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tv5yr4q50-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 17:22:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39NHMnl5021813
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 17:22:49 GMT
Received: from [10.216.7.46] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 23 Oct
 2023 10:22:42 -0700
Message-ID: <73168f4b-0dc2-4060-99f2-c5e9973dbf52@quicinc.com>
Date:   Mon, 23 Oct 2023 22:52:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 07/10] usb: dwc3: qcom: Add multiport suspend/resume
 support for wrapper
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
 <20231007154806.605-8-quic_kriskura@quicinc.com>
 <ZTaYNjRyT1Fn4QWX@hovoldconsulting.com>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZTaYNjRyT1Fn4QWX@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dHTELLJ75Vh9V9kQ-GtM2PP3iOuaqSiK
X-Proofpoint-GUID: dHTELLJ75Vh9V9kQ-GtM2PP3iOuaqSiK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_16,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310230151
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/23/2023 9:28 PM, Johan Hovold wrote:
> On Sat, Oct 07, 2023 at 09:18:03PM +0530, Krishna Kurapati wrote:
>> QCOM SoC SA8295P's tertiary quad port controller supports 2 HS+SS
>> ports and 2 HS only ports. Add support for configuring PWR_EVENT_IRQ's
>> for all the ports during suspend/resume.
> 
> No need to mention SA8295P as this is needed for all multiport
> controllers.
>  > Say something about adding support for multiport controllers generally
> instead and mention what the power event irqs are used for.
>

ACK.

>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
>>   drivers/usb/dwc3/dwc3-qcom.c | 35 ++++++++++++++++++++++++++++-------
>>   1 file changed, 28 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
>> index 651b9775a0c2..dbd4239e61c9 100644
>> --- a/drivers/usb/dwc3/dwc3-qcom.c
>> +++ b/drivers/usb/dwc3/dwc3-qcom.c
>> @@ -37,7 +37,11 @@
>>   #define PIPE3_PHYSTATUS_SW			BIT(3)
>>   #define PIPE_UTMI_CLK_DIS			BIT(8)
>>   
>> -#define PWR_EVNT_IRQ_STAT_REG			0x58
>> +#define PWR_EVNT_IRQ1_STAT_REG			0x58
>> +#define PWR_EVNT_IRQ2_STAT_REG			0x1dc
>> +#define PWR_EVNT_IRQ3_STAT_REG			0x228
>> +#define PWR_EVNT_IRQ4_STAT_REG			0x238
> 
> Not sure these defines makes sense on their own. You now only use them
> via the array below.
> 
> I think I already asked you whether these offsets depend on SoC and you
> said no, right?
> 
There are only 3 QC SoC's today that support multiport.
The offsets mentioned here are for SC8280 based platforms.

For Sc8180 based platforms, these are the offsets:
USB3_MP_PWR_EVNT_IRQ_STAT	0xA4F8858
USB3_MP_PWR_EVNT_IRQ_1_STAT	0xA4F89DC

These would translate to 0x58 and 0x1DC

And for SX8380 the values are as follows:

USB3_MP_PWR_EVNT_IRQ_STAT	0xA4F8858
USB3_MP_PWR_EVNT_IRQ_1_STAT	0xA4F89DC

So here also, the offsets are same. 0x58 and 0x1DC.
So these are not SoC specific (atleast looking at the controllers 
present). But there is no mathematical pattern to denote this as in the 
following form (x + (port_num) * y). So made an array like this.

>> +
>>   #define PWR_EVNT_LPM_IN_L2_MASK			BIT(4)
>>   #define PWR_EVNT_LPM_OUT_L2_MASK		BIT(5)
>>   
>> @@ -107,6 +111,19 @@ struct dwc3_qcom {
>>   	int			num_ports;
>>   };
>>   
>> +/*
>> + * Currently non-multiport controller have only one PWR_EVENT_IRQ register,
>> + * but multiport controllers like SA8295 contain upto 4 of them.
>> + */
> 
> Please try not talk about "currently" and as things are likely to
> change or, in fact, even *are* changing with your very patch series.
> 
> Again, this is not SA8295 specific.
> 
>> +#define NUM_PWR_EVENT_STAT_REGS	4
> 
> You already have MAX_PORTS, why are you defining a new define that will
> always have to be equal to MAX_PORTS?
> 

Do you recommend using the same max_ports ? If so, I can remove this 
macro altogether.

>> +
>> +static u32 pwr_evnt_irq_stat_reg_offset[NUM_PWR_EVENT_STAT_REGS] = {
> 
> missing const
> 
>> +	PWR_EVNT_IRQ1_STAT_REG,
>> +	PWR_EVNT_IRQ2_STAT_REG,
>> +	PWR_EVNT_IRQ3_STAT_REG,
>> +	PWR_EVNT_IRQ4_STAT_REG,
>> +};
>> +
>>   static inline void dwc3_qcom_setbits(void __iomem *base, u32 offset, u32 val)
>>   {
>>   	u32 reg;
>> @@ -446,9 +463,11 @@ static int dwc3_qcom_suspend(struct dwc3_qcom *qcom, bool wakeup)
>>   	if (qcom->is_suspended)
>>   		return 0;
>>   
>> -	val = readl(qcom->qscratch_base + PWR_EVNT_IRQ_STAT_REG);
>> -	if (!(val & PWR_EVNT_LPM_IN_L2_MASK))
>> -		dev_err(qcom->dev, "HS-PHY not in L2\n");
>> +	for (i = 0; i < qcom->num_ports; i++) {
>> +		val = readl(qcom->qscratch_base + pwr_evnt_irq_stat_reg_offset[i]);
>> +		if (!(val & PWR_EVNT_LPM_IN_L2_MASK))
>> +			dev_err(qcom->dev, "HS-PHY not in L2\n");
> 
> Error message should contain the port number.
> 

ACK

>> +	}
>>   
>>   	for (i = qcom->num_clocks - 1; i >= 0; i--)
>>   		clk_disable_unprepare(qcom->clks[i]);
>> @@ -494,9 +513,11 @@ static int dwc3_qcom_resume(struct dwc3_qcom *qcom, bool wakeup)
>>   		dev_warn(qcom->dev, "failed to enable interconnect: %d\n", ret);
>>   
>>   	/* Clear existing events from PHY related to L2 in/out */
>> -	dwc3_qcom_setbits(qcom->qscratch_base, PWR_EVNT_IRQ_STAT_REG,
>> -			  PWR_EVNT_LPM_IN_L2_MASK | PWR_EVNT_LPM_OUT_L2_MASK);
>> -
>> +	for (i = 0; i < qcom->num_ports; i++) {
>> +		dwc3_qcom_setbits(qcom->qscratch_base,
>> +			pwr_evnt_irq_stat_reg_offset[i],
>> +			PWR_EVNT_LPM_IN_L2_MASK | PWR_EVNT_LPM_OUT_L2_MASK);
> 
> Again, continuation lines should be indented at least two tabs further.
> 

ACK.

Thanks for the review.

Regards,
Krishna,

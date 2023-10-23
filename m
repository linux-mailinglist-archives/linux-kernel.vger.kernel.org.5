Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717E47D3D8B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbjJWR1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjJWR1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:27:34 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3AD94;
        Mon, 23 Oct 2023 10:27:31 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39NGuSrf018593;
        Mon, 23 Oct 2023 17:27:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=PnvgN3TyYfZGZOY+wZ46pZ3rPUB/sChGujlCBi1s68k=;
 b=puDiffpB7LeH/l0Zmtf2F9UcUwUan4SUcVKF/FtaDPg6QczWEUoF/0Ny/mOO2YlO9jZ0
 AkFt+4IulrzyONAiDZa+DHyCVzC46KldE1SLfEu/9TI6XIgo1gEEEozpzU9k1ZRtPDCw
 QRVjeu0sRkNCTvUD/3csf7Z4wA5xkbKZgmiL6Hal6DtqIEXuv6ZDKL1phGt9WuSTEx/8
 /19gKjvnAMGChqaX94mtHan7OIv29jfAv6NSkfYWzAUQLzfieU8eBbHtreXUZaqE6zpQ
 t8V/FlGrZMJ0EqOKidMzNdePM3F7dSnxQLFhPjGMk7ox3jpo5TeIzOi4mcpdsWguSk6b nw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3twp3vh2pm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 17:27:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39NHRHPT022180
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 17:27:17 GMT
Received: from [10.216.7.46] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 23 Oct
 2023 10:27:09 -0700
Message-ID: <7e9bdd65-35b7-43c2-810a-2cd81f736084@quicinc.com>
Date:   Mon, 23 Oct 2023 22:57:04 +0530
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
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZTaViatsRY7LCbIX@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pKcrl3s-mSFTESKC0FXI2v_ercllagg-
X-Proofpoint-ORIG-GUID: pKcrl3s-mSFTESKC0FXI2v_ercllagg-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_16,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 adultscore=0 spamscore=0 clxscore=1015 mlxlogscore=741
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310230152
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/23/2023 9:17 PM, Johan Hovold wrote:
> On Sat, Oct 07, 2023 at 09:18:02PM +0530, Krishna Kurapati wrote:
>> Currently wakeup is supported by only single port controllers. Read speed
>> of each port and accordingly enable IRQ's for those ports.
>>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
>>   drivers/usb/dwc3/dwc3-qcom.c | 65 +++++++++++++++++++-----------------
>>   1 file changed, 35 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
>> index 863892284146..651b9775a0c2 100644
>> --- a/drivers/usb/dwc3/dwc3-qcom.c
>> +++ b/drivers/usb/dwc3/dwc3-qcom.c
>> @@ -90,7 +90,7 @@ struct dwc3_qcom {
>>   	 */
>>   	int			phy_irq[NUM_PHY_IRQ - 1][DWC3_MAX_PORTS];
>>   	int			hs_phy_irq;
>> -	enum usb_device_speed	usb2_speed;
>> +	enum usb_device_speed	usb2_speed[DWC3_MAX_PORTS];
> 
> This also belongs in a new port structure.
> 
>>   	struct extcon_dev	*edev;
>>   	struct extcon_dev	*host_edev;
>> @@ -335,7 +335,8 @@ static bool dwc3_qcom_is_host(struct dwc3_qcom *qcom)
>>   	return dwc->xhci;
>>   }
>>   
>> -static enum usb_device_speed dwc3_qcom_read_usb2_speed(struct dwc3_qcom *qcom)
>> +static enum usb_device_speed dwc3_qcom_read_usb2_speed(struct dwc3_qcom *qcom,
>> +							int port_index)
> 
> No need for line break (since it's a function definition).
> 
>>   {
>>   	struct dwc3 *dwc = platform_get_drvdata(qcom->dwc3);
>>   	struct usb_device *udev;
>> @@ -348,12 +349,10 @@ static enum usb_device_speed dwc3_qcom_read_usb2_speed(struct dwc3_qcom *qcom)
>>   
>>   	/*
>>   	 * It is possible to query the speed of all children of
>> -	 * USB2.0 root hub via usb_hub_for_each_child(). DWC3 code
>> -	 * currently supports only 1 port per controller. So
>> -	 * this is sufficient.
>> +	 * USB2.0 root hub via usb_hub_for_each_child().
> 
> This comment no longer makes sense with your current implementation.
> 
Can you help elaborate on your comment ? Do you mean that this API 
doesn't get speed on all ports, but this has to be called in a loop to 
get all the port speeds ? In that sense, I agree, I can change the 
comments here.

> But perhaps this should be done using usb_hub_for_each_child() instead
> as that may be more efficient. Then you use this function to read out
> the speed for all the ports in go (and store it in the port structures I
> mentioned). Please determine which alternative is best.
> 
Either ways is fine. We would have qcom->num_ports to determine how many 
speeds we can read.

>>   	 */
>>   #ifdef CONFIG_USB
>> -	udev = usb_hub_find_child(hcd->self.root_hub, 1);
>> +	udev = usb_hub_find_child(hcd->self.root_hub, port_index + 1);
>>   #else
>>   	udev = NULL;
>>   #endif
>> @@ -386,23 +385,29 @@ static void dwc3_qcom_disable_wakeup_irq(int irq)
>>   
>>   static void dwc3_qcom_disable_interrupts(struct dwc3_qcom *qcom)
>>   {
>> +	int i;
>> +
>>   	dwc3_qcom_disable_wakeup_irq(qcom->hs_phy_irq);
>>   
>> -	if (qcom->usb2_speed == USB_SPEED_LOW) {
>> -		dwc3_qcom_disable_wakeup_irq(qcom->phy_irq[DM_HS_PHY_IRQ_INDEX][0]);
>> -	} else if ((qcom->usb2_speed == USB_SPEED_HIGH) ||
>> -			(qcom->usb2_speed == USB_SPEED_FULL)) {
>> -		dwc3_qcom_disable_wakeup_irq(qcom->phy_irq[DP_HS_PHY_IRQ_INDEX][0]);
>> -	} else {
>> -		dwc3_qcom_disable_wakeup_irq(qcom->phy_irq[DP_HS_PHY_IRQ_INDEX][0]);
>> -		dwc3_qcom_disable_wakeup_irq(qcom->phy_irq[DM_HS_PHY_IRQ_INDEX][0]);
>> -	}
>> +	for (i = 0; i < qcom->num_ports; i++) {
>> +		if (qcom->usb2_speed[i] == USB_SPEED_LOW) {
>> +			dwc3_qcom_disable_wakeup_irq(qcom->phy_irq[DM_HS_PHY_IRQ_INDEX][i]);
>> +		} else if ((qcom->usb2_speed[i] == USB_SPEED_HIGH) ||
>> +			(qcom->usb2_speed[i] == USB_SPEED_FULL)) {
>> +			dwc3_qcom_disable_wakeup_irq(qcom->phy_irq[DP_HS_PHY_IRQ_INDEX][i]);
>> +		} else {
>> +			dwc3_qcom_disable_wakeup_irq(qcom->phy_irq[DP_HS_PHY_IRQ_INDEX][i]);
>> +			dwc3_qcom_disable_wakeup_irq(qcom->phy_irq[DM_HS_PHY_IRQ_INDEX][i]);
>> +		}
>>   
>> -	dwc3_qcom_disable_wakeup_irq(qcom->phy_irq[SS_PHY_IRQ_INDEX][0]);
>> +		dwc3_qcom_disable_wakeup_irq(qcom->phy_irq[SS_PHY_IRQ_INDEX][i]);
>> +	}
>>   }
> 
> The above is hardly readable, partly because of the 2d array that I
> think you should drop, and partly because you add the port loop here
> instead of in the caller.
> 
> A lot of these functions should become port operation where you either
> pass in a port structure directly or possibly a port index as I've
> mentioned before.

With your suggestion, yes, this can be refactored to be readable.

> 
> [ I realise that the confusion around hs_phy_irq may be partly to blame
> for this but since that one is also a per-port interrupt, that's no
> longer an issue. ]

I don't want to add support for this right away [1]. I would like to 
keep hs_phy_irq outside the loop for now.

>   
>>   static int dwc3_qcom_suspend(struct dwc3_qcom *qcom, bool wakeup)
>> @@ -454,10 +461,8 @@ static int dwc3_qcom_suspend(struct dwc3_qcom *qcom, bool wakeup)
>>   	 * The role is stable during suspend as role switching is done from a
>>   	 * freezable workqueue.
>>   	 */
>> -	if (dwc3_qcom_is_host(qcom) && wakeup) {
>> -		qcom->usb2_speed = dwc3_qcom_read_usb2_speed(qcom);
> 
> So just let this function update the usb2 speed for all ports unless
> there are reasons not to.

Either way is fine by me as mentioned above. Will udapte code accordingly.

> 
>> +	if (dwc3_qcom_is_host(qcom) && wakeup)
>>   		dwc3_qcom_enable_interrupts(qcom);
> 
> And then iterate over the ports and enable the interrupts here as you
> did above for the pwr_evnt_irqs.
> 
>> -	}
>>   
>>   	qcom->is_suspended = true;
[1]: 
https://lore.kernel.org/all/fb5e5e1d-520c-4cbc-adde-f30e853421a1@quicinc.com/

Regards,
Krishna,

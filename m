Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353D57D32E6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 13:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbjJWLYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 07:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbjJWLYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 07:24:52 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9861010A;
        Mon, 23 Oct 2023 04:24:48 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39NBKK03015461;
        Mon, 23 Oct 2023 11:24:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=BFthNX+O9dgOMwJlzFJJOGfz/uKZ8unpM9GIonMsweE=;
 b=PbaaiVjZjsPDZMd0qAMT056dqb+EDRavHG5JXHXEGVMDR8nhqLWYb9TLv0CjxnvDaKtS
 s5L6hvhLkajkPbv0/2/Ng3ycmpKGR4ghkYSflt5FR2AM44iZKlEt5CAwWAli3yjY4/Mo
 OT/GUlg/F6y6okzG9jizVbfRibKEPBxYeNNxIvgh5cEOH+hA+d0tth6T3zCLoIDyTU3I
 iMhI5plCca7zvaw/u8ask+Y5gyTM3tBeogx+2efk4nOawA3jY3B7k0PkC6FRyhpB7GjB
 BaNqfZNbSAiEjHoNaodl70+Pey8t+fcyd+jiJLMgvgAHz47dgmFGn6Mh9/8/4DbngSA0 Dg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tv5nduvrf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 11:24:24 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39NBONuB031751
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 11:24:23 GMT
Received: from [10.216.55.75] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 23 Oct
 2023 04:24:15 -0700
Message-ID: <cabf24d0-8eea-4eb5-8205-bf7fe6017ec2@quicinc.com>
Date:   Mon, 23 Oct 2023 16:54:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 05/10] usb: dwc3: qcom: Refactor IRQ handling in QCOM
 Glue driver
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
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZTY7Lwjd3_8NlfEi@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JOENsTwatpA3fdB7Ys3YR81l7ARb_DW9
X-Proofpoint-ORIG-GUID: JOENsTwatpA3fdB7Ys3YR81l7ARb_DW9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_09,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=713 bulkscore=0
 adultscore=0 impostorscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310230098
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/23/2023 2:51 PM, Johan Hovold wrote:
> On Mon, Oct 23, 2023 at 12:11:45AM +0530, Krishna Kurapati PSSNV wrote:
>> On 10/20/2023 6:53 PM, Johan Hovold wrote:
>>> On Sat, Oct 07, 2023 at 09:18:01PM +0530, Krishna Kurapati wrote:
> 
>>>> +#define NUM_PHY_IRQ		4
>>>> +
>>>> +enum dwc3_qcom_ph_index {
>>>
>>> "phy_index"
>>>
>>>> +	DP_HS_PHY_IRQ_INDEX = 0,
>>>> +	DM_HS_PHY_IRQ_INDEX,
>>>> +	SS_PHY_IRQ_INDEX,
>>>> +	HS_PHY_IRQ_INDEX,
>>>> +};
>>>> +
>>>>    struct dwc3_acpi_pdata {
>>>>    	u32			qscratch_base_offset;
>>>>    	u32			qscratch_base_size;
>>>>    	u32			dwc3_core_base_size;
>>>> +	/*
>>>> +	 * The phy_irq_index corresponds to ACPI indexes of (in order) DP/DM/SS
>>>> +	 * IRQ's respectively.
>>>> +	 */
>>>> +	int			phy_irq_index[NUM_PHY_IRQ - 1];
>>>>    	int			hs_phy_irq_index;
>>>> -	int			dp_hs_phy_irq_index;
>>>> -	int			dm_hs_phy_irq_index;
>>>> -	int			ss_phy_irq_index;
>>>>    	bool			is_urs;
>>>>    };
>>>>    
>>>> @@ -73,10 +84,12 @@ struct dwc3_qcom {
>>>>    	int			num_clocks;
>>>>    	struct reset_control	*resets;
>>>>    
>>>> +	/*
>>>> +	 * The phy_irq corresponds to IRQ's registered for (in order) DP/DM/SS
>>>> +	 * respectively.
>>>> +	 */
>>>> +	int			phy_irq[NUM_PHY_IRQ - 1][DWC3_MAX_PORTS];
>>>>    	int			hs_phy_irq;
>>>> -	int			dp_hs_phy_irq;
>>>> -	int			dm_hs_phy_irq;
>>>> -	int			ss_phy_irq;
>>>
>>> I'm not sure using arrays like this is a good idea (and haven't you
>>> switched the indexes above?).
>>>
>>> Why not add a port structure instead?
>>>
>>> 	struct dwc3_qcom_port {
>>> 		int hs_phy_irq;
>>> 		int dp_hs_phy_irq;
>>> 		int dm_hs_phy_irq;
>>> 		int ss_phy_irq;
>>> 	};
>>>
>>> and then have
>>>
>>> 	struct dwc3_qcom_port ports[DWC3_MAX_PORTS];
>>>
>>> in dwc3_qcom. The port structure can the later also be amended with
>>> whatever other additional per-port data there is need for.
>>>
>>> This should make the implementation cleaner.
>>>
>>> I also don't like the special handling of hs_phy_irq; if this is really
>>> just another name for the pwr_event_irq then this should be cleaned up
>>> before making the code more complicated than it needs to be.
>>>
>>> Make sure to clarify this before posting a new revision.
>>
>> hs_phy_irq is different from pwr_event_irq.
> 
> How is it different and how are they used?
> 
>> AFAIK, there is only one of this per controller.
> 
> But previous controllers were all single port so this interrupt is
> likely also per-port, even if your comment below seems to suggest even
> SC8280XP has one, which is unexpected (and not described in the updated
> binding):
> 
> 	Yes, all targets have the same IRQ's. Just that MP one's have
> 	multiple IRQ's of each type. But hs-phy_irq is only one in
> 	SC8280 as well.
> 
> 	https://lore.kernel.org/lkml/70b2495f-1305-05b1-2039-9573d171fe24@quicinc.com/
> 
> Please clarify.
> 

For sure pwr_event_irq and hs_phy_irq are different. I assumed it was 
per-controller and not per-phy because I took reference from software 
code we have on downstream and hs_phy for multiport is not used 
anywhere. I don't see any functionality implemented in downstream for 
that IRQ. And it is only one for single port controllers.

But I got the following info from HW page and these are all the 
interrupts (on apss processor) for multiport (extra details removed):

u_usb31_scnd_mvs_pipe_wrapper_usb31_power_event_irq_0	SYS_apcsQgicSPI[130]
u_usb31_scnd_mvs_pipe_wrapper_usb31_power_event_irq_1	SYS_apcsQgicSPI[135]
u_usb31_scnd_mvs_pipe_wrapper_usb31_power_event_irq_3	SYS_apcsQgicSPI[856]
u_usb31_scnd_mvs_pipe_wrapper_usb31_power_event_irq_2	SYS_apcsQgicSPI[857]

u_usb31_scnd_mvs_pipe_wrapper_usb31_ctrl_irq[0]	SYS_apcsQgicSPI[133]
u_usb31_scnd_mvs_pipe_wrapper_usb31_ctrl_irq[1]	SYS_apcsQgicSPI[134]
u_cm_usb3_uni_wrapper_mp0_usb3phy_debug_irq	SYS_apcsQgicSPI[668]
u_usb31_scnd_mvs_pipe_wrapper_usb31_bam_irq[0]	SYS_apcsQgicSPI[830]
u_cm_usb3_uni_wrapper_mp1_usb3phy_debug_irq	SYS_apcsQgicSPI[855]

u_usb31_scnd_mvs_pipe_wrapper_usb31_hs_phy_irq_0	SYS_apcsQgicSPI[131]
u_usb31_scnd_mvs_pipe_wrapper_usb31_hs_phy_irq_1	SYS_apcsQgicSPI[136]
u_usb31_scnd_mvs_pipe_wrapper_usb31_hs_phy_irq_3	SYS_apcsQgicSPI[859]
u_usb31_scnd_mvs_pipe_wrapper_usb31_hs_phy_irq_2	SYS_apcsQgicSPI[860]

	
u_cm_dwc_usb2_hs0_usb2_dpse	apps_pdc_irq_out[127]
u_cm_dwc_usb2_hs0_usb2_dmse	apps_pdc_irq_out[126]
u_cm_dwc_usb2_hs1_usb2_dpse	apps_pdc_irq_out[129]
u_cm_dwc_usb2_hs1_usb2_dmse	apps_pdc_irq_out[128]
u_cm_dwc_usb2_hs2_usb2_dpse	apps_pdc_irq_out[131]
u_cm_dwc_usb2_hs2_usb2_dmse	apps_pdc_irq_out[130]
u_cm_dwc_usb2_hs3_usb2_dpse	apps_pdc_irq_out[133]
u_cm_dwc_usb2_hs3_usb2_dmse	apps_pdc_irq_out[132]
u_cm_usb3_uni_wrapper_mp0_qmp_usb3_lfps_rxterm_irq	apps_pdc_irq_out[16]
u_cm_usb3_uni_wrapper_mp1_qmp_usb3_lfps_rxterm_irq	apps_pdc_irq_out[17]

Seems like there are 4 IRQ's for HS.

Regards,
Krishna,

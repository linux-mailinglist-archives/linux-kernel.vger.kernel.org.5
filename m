Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A06C7C7C61
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 05:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjJMD4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 23:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjJMD4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 23:56:48 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EA8B7;
        Thu, 12 Oct 2023 20:56:47 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39D2uWDo023257;
        Fri, 13 Oct 2023 03:56:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=1wN9r/ygJa5hc10Q0L1K794PKyr7Hfnc7rIOt55zZoM=;
 b=OiTcZMR+01qfzd67dE+571bN6qiOZ502zvDM9saWdar39sRmLC8swtwW2YGqouxuawsw
 bIyxzIZmCL0+ROqOLsZVKRvhPjkLMoQXlnZM/kGc5DmJx0VMk6iWLRAUIz+Pf06ZanIG
 M70hvpUfrw2vOAyuY/lJrq8ied+DrG9wghCcW4HzTvVeE1moAUdaJESURRF+33qlzkat
 tIJSMbOIdf90HcqA1cYxBxoMKzqBOKOf8ntGaQlm4Ix+mZAkbs3Ya5880ePvzcNV/532
 g948+CO3f4PMsHQNjX7Ipq/SfGbNDrfJgCPSM/zj/ZbyqmcnAzprjcqG5wz75ydm64Xh Dw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tpt11ge2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 03:56:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39D3uegw028840
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 03:56:40 GMT
Received: from [10.216.41.155] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 12 Oct
 2023 20:56:37 -0700
Message-ID: <ff5674b3-6536-4f37-92e7-0c114645cd49@quicinc.com>
Date:   Fri, 13 Oct 2023 09:26:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] usb: dwc3: core: Fix RAM interface getting stuck during
 enumeration
To:     Wesley Cheng <quic_wcheng@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>,
        <quic_ugoswami@quicinc.com>
References: <20231011100214.25720-1-quic_kriskura@quicinc.com>
 <1e8d6d63-f5e5-3e69-ae8e-cf3cd1b90ad8@quicinc.com>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <1e8d6d63-f5e5-3e69-ae8e-cf3cd1b90ad8@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TIEZGCLijBgLjHeVO7eeOdFtMqJ0FnnY
X-Proofpoint-ORIG-GUID: TIEZGCLijBgLjHeVO7eeOdFtMqJ0FnnY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_14,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 impostorscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310130034
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/13/2023 12:55 AM, Wesley Cheng wrote:
> Hi Krishna,
> 
> On 10/11/2023 3:02 AM, Krishna Kurapati wrote:
>> This implementation is to fix RAM interface getting stuck during

>> Synopsys confirmed that the issue is present on all USB3 devices and
>> as a workaround, suggested to re-initialize device mode.
>>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
>>   drivers/usb/dwc3/core.c   | 20 ++++++++++++++++++++
>>   drivers/usb/dwc3/core.h   |  4 ++++
>>   drivers/usb/dwc3/drd.c    |  5 +++++
>>   drivers/usb/dwc3/gadget.c |  6 ++++--
>>   4 files changed, 33 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 44ee8526dc28..d18b81cccdc5 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -122,6 +122,7 @@ static void __dwc3_set_mode(struct work_struct *work)
>>       unsigned long flags;
>>       int ret;
>>       u32 reg;
>> +    u8 timeout = 100;
>>       u32 desired_dr_role;
>>       mutex_lock(&dwc->mutex);
>> @@ -137,6 +138,25 @@ static void __dwc3_set_mode(struct work_struct 
>> *work)
>>       if (!desired_dr_role)
>>           goto out;
>> +    /*
>> +     * STAR 5001544 - If cable disconnect doesn't generate
>> +     * disconnect event in device mode, then re-initialize the
>> +     * controller.
>> +     */
>> +    if ((dwc->cable_disconnected == true) &&
>> +        (dwc->current_dr_role == DWC3_GCTL_PRTCAP_DEVICE)) {
>> +        while (dwc->connected == true && timeout != 0) {
>> +            mdelay(10);
>> +            timeout--;
>> +        }
>> +
>> +        if (timeout == 0) {
>> +            dwc3_gadget_soft_disconnect(dwc);
>> +            udelay(100);
>> +            dwc3_gadget_soft_connect(dwc);
>> +        }
>> +    }
>> +
>>       if (desired_dr_role == dwc->current_dr_role)
>>           goto out;
>> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
>> index c6c87acbd376..7642330cf608 100644
>> --- a/drivers/usb/dwc3/core.h
>> +++ b/drivers/usb/dwc3/core.h
>> @@ -1355,6 +1355,7 @@ struct dwc3 {
>>       int            last_fifo_depth;
>>       int            num_ep_resized;
>>       struct dentry        *debug_root;
>> +    bool            cable_disconnected;
>>   };
>>   #define INCRX_BURST_MODE 0
>> @@ -1568,6 +1569,9 @@ void dwc3_event_buffers_cleanup(struct dwc3 *dwc);
>>   int dwc3_core_soft_reset(struct dwc3 *dwc);
>> +int dwc3_gadget_soft_disconnect(struct dwc3 *dwc);
>> +int dwc3_gadget_soft_connect(struct dwc3 *dwc);
>> +
>>   #if IS_ENABLED(CONFIG_USB_DWC3_HOST) || 
>> IS_ENABLED(CONFIG_USB_DWC3_DUAL_ROLE)
>>   int dwc3_host_init(struct dwc3 *dwc);
>>   void dwc3_host_exit(struct dwc3 *dwc);
>> diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
>> index 039bf241769a..593c023fc39a 100644
>> --- a/drivers/usb/dwc3/drd.c
>> +++ b/drivers/usb/dwc3/drd.c
>> @@ -446,6 +446,8 @@ static int dwc3_usb_role_switch_set(struct 
>> usb_role_switch *sw,
>>       struct dwc3 *dwc = usb_role_switch_get_drvdata(sw);
>>       u32 mode;
>> +    dwc->cable_disconnected = false;
>> +
>>       switch (role) {
>>       case USB_ROLE_HOST:
>>           mode = DWC3_GCTL_PRTCAP_HOST;
>> @@ -454,6 +456,9 @@ static int dwc3_usb_role_switch_set(struct 
>> usb_role_switch *sw,
>>           mode = DWC3_GCTL_PRTCAP_DEVICE;
>>           break;
>>       default:
>> +        if (role == USB_ROLE_NONE)
>> +            dwc->cable_disconnected = true;
>> +
> 
> How do we handle cases where role switch isn't used? (ie extcon or maybe 
> no cable connection notification at all)
> 

Hi Wesley,

  Since I was considering fixing it during disconnect, I made it in role 
switch. So no cable connection notification case has been ruled out in 
this patch. But yes, extcon is a valid case. Will need to account for it.

Regards,
Krishna,

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332E87AF4C6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 22:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjIZUHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 16:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235803AbjIZUHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 16:07:09 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D120DF3;
        Tue, 26 Sep 2023 13:07:02 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38QJmfiY005415;
        Tue, 26 Sep 2023 20:06:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dQqGa/jQUXLnagbza23rJeg50H6E97ND1KrC/E2Pkac=;
 b=RsAy/fq3jgAOs+F/p+D11jVbx3PIZG3rsz+jrjFffAnaNZU3vOv9QhQlBBRQGMFrr5p4
 uN/RH4V7g/pREm0VMQT96XtWS8Rbz+fP69oJtycRbqgy0PC/sWy9XuuQdely7ZbBoWIW
 gTx61B0kclSS/O9KvSPqRgomvacm7VLAFHRmxrcmwviM0lor6PnzjbvbgXgSkrvPWlhz
 hgdKGDde6uueVkyuVtwpemaUUILVHS8joxpMjp/K61mIR4ue0Gbms4GB4leW/WDUzw4Y
 5empw8TwGwQLnqoRVTPQr9b060SBFjsRWCP+kpyUPwnlC6mDB/Diu72VWtOiEy/pd8ZZ iQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tbexgk32d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 20:06:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38QK6KpN030091
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 20:06:20 GMT
Received: from [10.216.25.31] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 26 Sep
 2023 13:06:15 -0700
Message-ID: <62083b55-0b78-4ebc-ab78-1c1d99f92507@quicinc.com>
Date:   Wed, 27 Sep 2023 01:36:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] usb: gadget: udc: Handle gadget_connect failure during
 bind operation
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_wcheng@quicinc.com>,
        <quic_jackp@quicinc.com>
References: <20230926193708.22405-1-quic_kriskura@quicinc.com>
 <2178cf29-5e5c-4ed6-8d1c-916bc7036589@rowland.harvard.edu>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <2178cf29-5e5c-4ed6-8d1c-916bc7036589@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CglRK2R9h9qaR4llKlQFmZQmBKa7ehka
X-Proofpoint-GUID: CglRK2R9h9qaR4llKlQFmZQmBKa7ehka
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_14,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999
 adultscore=0 clxscore=1015 bulkscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309260172
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/27/2023 1:24 AM, Alan Stern wrote:
> On Wed, Sep 27, 2023 at 01:07:08AM +0530, Krishna Kurapati wrote:
>> In the event, gadget_connect call (which invokes pullup) fails,
> 
> s/event,/event/
> 
>> propagate the error to udc bind operation which inturn sends the
> 
> s/inturn/in turn/
> 
>> error to configfs. The userspace can then retry enumeartion if
> 
> s/enumeartion/enumeration/
> 
>> it chooses to.
>>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
>> Changes in v4: Fixed mutex locking imbalance during connect_control
>> failure
>> Link to v3: https://lore.kernel.org/all/20230510075252.31023-3-quic_kriskura@quicinc.com/
>>
>>   drivers/usb/gadget/udc/core.c | 23 +++++++++++++++++++----
>>   1 file changed, 19 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
>> index 7d49d8a0b00c..53af25a333a1 100644
>> --- a/drivers/usb/gadget/udc/core.c
>> +++ b/drivers/usb/gadget/udc/core.c
>> @@ -1125,12 +1125,16 @@ EXPORT_SYMBOL_GPL(usb_gadget_set_state);
>>   /* ------------------------------------------------------------------------- */
>>   
>>   /* Acquire connect_lock before calling this function. */
>> -static void usb_udc_connect_control_locked(struct usb_udc *udc) __must_hold(&udc->connect_lock)
>> +static int usb_udc_connect_control_locked(struct usb_udc *udc) __must_hold(&udc->connect_lock)
>>   {
>> +	int ret;
>> +
>>   	if (udc->vbus)
>> -		usb_gadget_connect_locked(udc->gadget);
>> +		ret = usb_gadget_connect_locked(udc->gadget);
>>   	else
>> -		usb_gadget_disconnect_locked(udc->gadget);
>> +		ret = usb_gadget_disconnect_locked(udc->gadget);
>> +
>> +	return ret;
> 
> You don't actually need the new variable ret.  You can just do:
> 
> 	if (udc->vbus)
> 		return usb_gadget_connect_locked(udc->gadget);
> 	else
> 		return usb_gadget_disconnect_locked(udc->gadget);
> 
>>   }
>>   
>>   static void vbus_event_work(struct work_struct *work)
>> @@ -1604,12 +1608,23 @@ static int gadget_bind_driver(struct device *dev)
>>   	}
>>   	usb_gadget_enable_async_callbacks(udc);
>>   	udc->allow_connect = true;
>> -	usb_udc_connect_control_locked(udc);
>> +	ret = usb_udc_connect_control_locked(udc);
>> +	if (ret) {
>> +		mutex_unlock(&udc->connect_lock);
>> +		goto err_connect_control;
>> +	}
>> +
>>   	mutex_unlock(&udc->connect_lock);
>>   
>>   	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
>>   	return 0;
>>   
>> + err_connect_control:
>> +	usb_gadget_disable_async_callbacks(udc);
>> +	if (gadget->irq)
>> +		synchronize_irq(gadget->irq);
>> +	usb_gadget_udc_stop_locked(udc);
> 
> Not good -- usb_gadget_udc_stop_locked() expects you to be holding
> udc->connect_lock, but you just dropped the lock!  Also, you never set
> udc->allow_connect back to false.
> 
> You should move the mutex_unlock() call from inside the "if" statement
> to down here, and add a line for udc->allow_connect.
> 

Hi Alan,

  Thanks for the review. Will push v5 addressing the changes.


Regards,
Krishna,

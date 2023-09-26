Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F717AF509
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 22:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235847AbjIZU0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 16:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235844AbjIZU0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 16:26:38 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E04C121;
        Tue, 26 Sep 2023 13:26:31 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38QJuTNp019157;
        Tue, 26 Sep 2023 20:24:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=NeZCTm8fleHhjmveVpb/txWwGib1sWk+NfoC/HiRkw0=;
 b=hEcqh0dWX1SS8p5PZoUvJMZBcj3lGYkcY5uxIrDw7n/BKmsaH5RIogo3N6k8UaOEo29K
 7wKEMqdpGSEonaflAHQCEStvwfwVKl7Hi/zk74Qe8RvUy7AepJ0A/SnJug2gZrwIRXbe
 dU2a2dkHwFDAiEZkOcK0Okck9mkYhUtQDIfcpcSXypOvbjSbG2PdOglMDIixq5ufgT+o
 6tSCXsbGXgS91W748PIWraA5h3LJnnKRNX/C4YctTCg1MxyB0PImuFZ46ma0dybVtaNU
 bpBPESWxBxOualFLaKmGpehCSddAdA2xwlTz9MAiYbQqmU5GmNi35Kl3pqxHdw0epHYu 8A== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tbexgk417-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 20:24:44 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38QKOhTu006928
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 20:24:43 GMT
Received: from [10.216.25.31] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 26 Sep
 2023 13:24:39 -0700
Message-ID: <f2bd7593-eff9-46ac-a94b-964eb4787740@quicinc.com>
Date:   Wed, 27 Sep 2023 01:54:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] usb: gadget: udc: Handle gadget_connect failure during
 bind operation
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
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
 <62083b55-0b78-4ebc-ab78-1c1d99f92507@quicinc.com>
Content-Language: en-US
In-Reply-To: <62083b55-0b78-4ebc-ab78-1c1d99f92507@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: X9VDBCtd15zBvd5hHlkyV8jIbmjBsrJY
X-Proofpoint-GUID: X9VDBCtd15zBvd5hHlkyV8jIbmjBsrJY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_14,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0 mlxlogscore=993
 adultscore=0 clxscore=1015 bulkscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309260174
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/27/2023 1:36 AM, Krishna Kurapati PSSNV wrote:
>>>   drivers/usb/gadget/udc/core.c | 23 +++++++++++++++++++----
>>>   1 file changed, 19 insertions(+), 4 deletions(-)
>>>
>>>   static void vbus_event_work(struct work_struct *work)
>>> @@ -1604,12 +1608,23 @@ static int gadget_bind_driver(struct device 
>>> *dev)
>>>       }
>>>       usb_gadget_enable_async_callbacks(udc);
>>>       udc->allow_connect = true;
>>> -    usb_udc_connect_control_locked(udc);
>>> +    ret = usb_udc_connect_control_locked(udc);
>>> +    if (ret) {
>>> +        mutex_unlock(&udc->connect_lock);
>>> +        goto err_connect_control;
>>> +    }
>>> +
>>>       mutex_unlock(&udc->connect_lock);
>>>       kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
>>>       return 0;
>>> + err_connect_control:
>>> +    usb_gadget_disable_async_callbacks(udc);
>>> +    if (gadget->irq)
>>> +        synchronize_irq(gadget->irq);
>>> +    usb_gadget_udc_stop_locked(udc);
>>
>> Not good -- usb_gadget_udc_stop_locked() expects you to be holding
>> udc->connect_lock, but you just dropped the lock!  Also, you never set
>> udc->allow_connect back to false.
>>
>> You should move the mutex_unlock() call from inside the "if" statement
>> to down here, and add a line for udc->allow_connect.
>>
> 
> Hi Alan,
> 
>   Thanks for the review. Will push v5 addressing the changes.
> 
> 
Hi Alan,

I tried out the following diff:

-       usb_udc_connect_control_locked(udc);
+       ret = usb_udc_connect_control_locked(udc);
+       if (ret)
+               goto err_connect_control;
+
         mutex_unlock(&udc->connect_lock);

         kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
         return 0;

+ err_connect_control:
+       udc->allow_connect = false;
+       usb_gadget_disable_async_callbacks(udc);
+       if (gadget->irq)
+               synchronize_irq(gadget->irq);
+       usb_gadget_udc_stop_locked(udc);
+       mutex_unlock(&udc->connect_lock);
+

If I clear UDC and fail dwc3 soft reset on purpose, I see UDC_store failing:

#echo a600000.usb > /sys/kernel/config/usb_gadget/g1/UDC
[  127.394087] dwc3 a600000.usb: request 000000003f43f907 was not queued 
to ep0out
[  127.401637] udc a600000.usb: failed to start g1: -110
[  127.406841] configfs-gadget.g1: probe of gadget.0 failed with error -110
[  127.413809] UDC core: g1: couldn't find an available UDC or it's busy

The same output came when I tested v4 as well. Every time soft_reset 
would fail when I try to write to UDC, UDC_store fails and above log 
will come up. Can you help confirm if the diff above is proper as I 
don't see any diff in the logs in v4 and about to push v5.

Regards,
Krishna,

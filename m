Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4829D7AFC18
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 09:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjI0H33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 03:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjI0H3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 03:29:08 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBDF1B0;
        Wed, 27 Sep 2023 00:29:06 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38R4kUmr024276;
        Wed, 27 Sep 2023 07:28:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=BLTmAj9c74uRGVTtwdPNUwAzx0B4vAqvHGoZje3AMhw=;
 b=hyfHnEMtJKdjXJ/zjLCLjIc1mGURp2BJHubn/wXejPhokL58kH/gmjf+FSnNwp0p4uE/
 uZ3xlyUgR2y8f7hhi2p9uaI9xOURDk3yjOqG/4frOtN3BJAWuTIJVBRS9NMgQKXUG5km
 wDFvtgb+MFfnzNdGuOydG+nCBeLjbn2fORxpbuDHT40bcoYbnV7rXGtXSwHxfdKPlZfa
 dg9snYAembWG7qY3ljdOM+d3H/G0mqC8GuwVU0w88uOW0oz7fWm96MVo8QvA9L9sMOtJ
 9BBhFZzQRXWdJuuOkueBSECcBiqIjxHodv066K81A6j/Pi5NtHf8pqVh3FdDCJaAqH2z nA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tc43ms7yn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 07:28:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38R7SulE021380
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 07:28:56 GMT
Received: from [10.216.34.233] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 27 Sep
 2023 00:28:52 -0700
Message-ID: <05201136-5c67-47e7-a3f1-a7af051a2a00@quicinc.com>
Date:   Wed, 27 Sep 2023 12:58:49 +0530
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
 <62083b55-0b78-4ebc-ab78-1c1d99f92507@quicinc.com>
 <f2bd7593-eff9-46ac-a94b-964eb4787740@quicinc.com>
 <9384ac6a-f877-4835-b1ec-0e620a5ba8ba@rowland.harvard.edu>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <9384ac6a-f877-4835-b1ec-0e620a5ba8ba@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Y-0oaYrekRWC7HjRSZcQ2K7VzQZe7P89
X-Proofpoint-GUID: Y-0oaYrekRWC7HjRSZcQ2K7VzQZe7P89
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_03,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 bulkscore=0 phishscore=0 mlxlogscore=820 malwarescore=0
 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309270060
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/27/2023 2:54 AM, Alan Stern wrote:
> On Wed, Sep 27, 2023 at 01:54:34AM +0530, Krishna Kurapati PSSNV wrote:
>>
>>
>> On 9/27/2023 1:36 AM, Krishna Kurapati PSSNV wrote:
>>>>>    drivers/usb/gadget/udc/core.c | 23 +++++++++++++++++++----
>>>>>    1 file changed, 19 insertions(+), 4 deletions(-)
>>>>>
>>>>>    static void vbus_event_work(struct work_struct *work)
>>>>> @@ -1604,12 +1608,23 @@ static int gadget_bind_driver(struct
>>>>> device *dev)
>>>>>        }
>>>>>        usb_gadget_enable_async_callbacks(udc);
>>>>>        udc->allow_connect = true;
>>>>> -    usb_udc_connect_control_locked(udc);
>>>>> +    ret = usb_udc_connect_control_locked(udc);
>>>>> +    if (ret) {
>>>>> +        mutex_unlock(&udc->connect_lock);
>>>>> +        goto err_connect_control;
>>>>> +    }
>>>>> +
>>>>>        mutex_unlock(&udc->connect_lock);
>>>>>        kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
>>>>>        return 0;
>>>>> + err_connect_control:
>>>>> +    usb_gadget_disable_async_callbacks(udc);
>>>>> +    if (gadget->irq)
>>>>> +        synchronize_irq(gadget->irq);
>>>>> +    usb_gadget_udc_stop_locked(udc);
>>>>
>>>> Not good -- usb_gadget_udc_stop_locked() expects you to be holding
>>>> udc->connect_lock, but you just dropped the lock!  Also, you never set
>>>> udc->allow_connect back to false.
>>>>
>>>> You should move the mutex_unlock() call from inside the "if" statement
>>>> to down here, and add a line for udc->allow_connect.
>>>>
>>>
>>> Hi Alan,
>>>
>>>    Thanks for the review. Will push v5 addressing the changes.
>>>
>>>
>> Hi Alan,
>>
>> I tried out the following diff:
>>
>> -       usb_udc_connect_control_locked(udc);
>> +       ret = usb_udc_connect_control_locked(udc);
>> +       if (ret)
>> +               goto err_connect_control;
>> +
>>          mutex_unlock(&udc->connect_lock);
>>
>>          kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
>>          return 0;
>>
>> + err_connect_control:
>> +       udc->allow_connect = false;
>> +       usb_gadget_disable_async_callbacks(udc);
>> +       if (gadget->irq)
>> +               synchronize_irq(gadget->irq);
>> +       usb_gadget_udc_stop_locked(udc);
>> +       mutex_unlock(&udc->connect_lock);
>> +
>>
>> If I clear UDC and fail dwc3 soft reset on purpose, I see UDC_store failing:
>>
>> #echo a600000.usb > /sys/kernel/config/usb_gadget/g1/UDC
>> [  127.394087] dwc3 a600000.usb: request 000000003f43f907 was not queued to
>> ep0out
>> [  127.401637] udc a600000.usb: failed to start g1: -110
>> [  127.406841] configfs-gadget.g1: probe of gadget.0 failed with error -110
>> [  127.413809] UDC core: g1: couldn't find an available UDC or it's busy
>>
>> The same output came when I tested v4 as well. Every time soft_reset would
>> fail when I try to write to UDC, UDC_store fails and above log will come up.
> 
> Isn't that what you want?  I thought the whole purpose of this patch was
> to make it so that configfs would realize when
> usb_udc_connect_control_locked() had failed.   So you should be happy
> that the log shows a failure occurred.
>  >> Can you help confirm if the diff above is proper as I don't see any 
diff in
>> the logs in v4 and about to push v5.
> 
> "Diff in the logs in v4"?  What does that mean?  A diff is a comparison
> between two text files (often between before-and-after versions of a
> source code file).  Why would you expect a diff to show up in the logs?
> 
> This revised patch looks okay to me.
> 
Thanks for the confirmation. Will push v5.

Regards,
Krishna,

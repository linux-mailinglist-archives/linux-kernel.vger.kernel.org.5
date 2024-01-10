Return-Path: <linux-kernel+bounces-21863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B26482955F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E90B5289544
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 08:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B143A8E0;
	Wed, 10 Jan 2024 08:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="G7KSC65h"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440EE37149;
	Wed, 10 Jan 2024 08:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40A8fNNO020732;
	Wed, 10 Jan 2024 08:48:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=TSIDIGzx91eb9galuGPWbdpthE7PmbdcJStbdBlFstk=; b=G7
	KSC65hvc465oP3e708IoRORMfBEVGVeCZv4x5JWCobpdGxRH9Ur99JSpa5UOk9H/
	f61HXmDm1cTMFnVX8Ru7Dip0fiW72Jc+qCN1Kr251NCuiwOBdt7bEwtTNzotUatl
	KbyRDtebgFl2oiGxEnF7AVrDviU6MOyUimA7YSRF9VFgrudXmTYRhJMgzfYhmE8i
	oEZ0SHcOOb+3vjAyBrDZwn2/m5KmkBGrv7xH++o7y/yVf0qj7kDZ8E0U2OgpB7WR
	0RNSUmC34GC/InsNB/LVhr8x32TKtUQHZGWq3K2zQq5zPDqpg6Kt94kX9MPxvhL6
	QsNrbifuRS+xfMaqbz0Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vhkem0hr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 08:48:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40A8m8Tk001399
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 08:48:08 GMT
Received: from [10.217.219.221] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 10 Jan
 2024 00:48:05 -0800
Message-ID: <dc2c940d-7be6-45dd-994d-2d6691bdadc2@quicinc.com>
Date: Wed, 10 Jan 2024 14:18:02 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] usb: core: Prevent null pointer dereference in
 update_port_device_state
To: Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
CC: Krishna Kurapati <quic_kriskura@quicinc.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20240109061708.26288-1-quic_ugoswami@quicinc.com>
 <3bb51617-81e1-7d19-598d-2b57164320e1@gmail.com>
 <5ef9db3d-1e60-4f42-8a5b-52a9800e4707@quicinc.com>
 <3c2b2183-b1ee-6226-be5b-f2f9fc39e247@gmail.com>
Content-Language: en-US
From: Udipto Goswami <quic_ugoswami@quicinc.com>
In-Reply-To: <3c2b2183-b1ee-6226-be5b-f2f9fc39e247@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kvLih4B66fr1EspK8GcuVM0v8HuFlS5p
X-Proofpoint-GUID: kvLih4B66fr1EspK8GcuVM0v8HuFlS5p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401100071



On 1/9/2024 8:10 PM, Sergei Shtylyov wrote:
> On 1/9/24 2:57 PM, Udipto Goswami wrote:
> [...]
> 
>>>> Currently,the function update_port_device_state gets the usb_hub from
>>>> udev->parent by calling usb_hub_to_struct_hub.
>>>> However, in case the actconfig or the maxchild is 0, the usb_hub would
>>>> be NULL and upon further accessing to get port_dev would result in null
>>>> pointer dereference.
>>>>
>>>> Fix this by introducing an if check after the usb_hub is populated.
>>>>
>>>> Fixes: 83cb2604f641 ("usb: core: add sysfs entry for usb device state")
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Udipto Goswami <quic_ugoswami@quicinc.com>
>>>> ---
>>>> v3: Re-wrote the comment for better context.
>>>> v2: Introduced comment for the if check & CC'ed stable.
>>>>
>>>>    drivers/usb/core/hub.c | 20 +++++++++++++++++---
>>>>    1 file changed, 17 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
>>>> index ffd7c99e24a3..6b514546e59b 100644
>>>> --- a/drivers/usb/core/hub.c
>>>> +++ b/drivers/usb/core/hub.c
>>>> @@ -2053,9 +2053,23 @@ static void update_port_device_state(struct usb_device *udev)
>>>>          if (udev->parent) {
>>>>            hub = usb_hub_to_struct_hub(udev->parent);
>>>> -        port_dev = hub->ports[udev->portnum - 1];
>>>> -        WRITE_ONCE(port_dev->state, udev->state);
>>>> -        sysfs_notify_dirent(port_dev->state_kn);
>>>> +
>>>> +        /*
>>>> +         * The Link Layer Validation System Driver (lvstest)
>>>> +         * has procedure of unbinding the hub before running
>>>> +         * the rest of the procedure. This triggers
>>>> +         * hub_disconnect will set the hub's maxchild to 0.
>>>
>>>      I can't parse this sentence, s/th is missing...
>> Thanks for the review.
>> Maybe this would sound better?
>>
>> "This triggers hub_disconnect which will set hub's maxchild to 0"
> 
>     That seems parsable. :-)
> 
>>>> +         * This would result usb_hub_to_struct_hub in this
>>>> +         * function to return NULL.
>>>
>>>      "This would result in usb_hub_to_struct_hub in this function
>>> returning NULL", perhaps?
>>
>> yah sound better. Will take care of it in next version.
> 
>     Probably "in this function" should be dropped altogether...

sure, i'll remove in v4.

Thanks,
-Udipto


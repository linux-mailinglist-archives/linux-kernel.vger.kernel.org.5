Return-Path: <linux-kernel+bounces-21931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B918296BE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 163E51F26F85
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8B33FB26;
	Wed, 10 Jan 2024 09:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gwSvrbps"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF42A3F8FF;
	Wed, 10 Jan 2024 09:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40A9kKas018787;
	Wed, 10 Jan 2024 09:57:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=tsVnBji+CX6UauGvaGmTOaJaiIeGC7M8aqQ1BW98I7w=; b=gw
	SvrbpsKk55/zJT4EPjitawV0cNpu4NCERuTjIABtRfrLrOzT1Y5ZqMG4xwN3Fa80
	rNWbJHH1y7B63ZE1Qz9chBijNsiU7s0qvLLtmZCeD+N6II7coGEW4IRUdXeM3tB0
	s4ylmf/oMoTRac0+8bB67vzVegEN1LEi8L5baaYusBTdawqlj7yleD6BwVKZHwhm
	cW//lAdiDm1nw54cIOdoukaY9iH9wLCEZL7Snd0h5j0O0bbc3tlO2EeqDuyfEm0T
	hpDtgqlPwwVLp+TG01HiAXpzEVy3F1OPcRv7u6lJEdvSHS6EHoAuOBgwW+q7p0iM
	aZvKrHsE5vERQd6eW01Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vhq2h086y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 09:57:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40A9voiW003332
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 09:57:50 GMT
Received: from [10.217.219.221] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 10 Jan
 2024 01:57:47 -0800
Message-ID: <556f3d87-1a38-423a-82c0-c7471b232e43@quicinc.com>
Date: Wed, 10 Jan 2024 15:27:45 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] usb: core: Prevent null pointer dereference in
 update_port_device_state
Content-Language: en-US
To: Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
CC: Krishna Kurapati <quic_kriskura@quicinc.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20240110091422.25347-1-quic_ugoswami@quicinc.com>
 <4e272d5d-ec19-7621-1346-4363b0070b1c@gmail.com>
From: Udipto Goswami <quic_ugoswami@quicinc.com>
In-Reply-To: <4e272d5d-ec19-7621-1346-4363b0070b1c@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ngUbGCKc8h2k2BZeLif8b7s_wTo8zi-5
X-Proofpoint-ORIG-GUID: ngUbGCKc8h2k2BZeLif8b7s_wTo8zi-5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 mlxlogscore=604 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401100081



On 1/10/2024 2:52 PM, Sergei Shtylyov wrote:
> On 1/10/24 12:14 PM, Udipto Goswami wrote:
> 
>> Currently,the function update_port_device_state gets the usb_hub from
> 
>     Need space between comma and "the"...
got it.
> 
>> udev->parent by calling usb_hub_to_struct_hub.
>> However, in case the actconfig or the maxchild is 0, the usb_hub would
>> be NULL and upon further accessing to get port_dev would result in null
>> pointer dereference.
>>
>> Fix this by introducing an if check after the usb_hub is populated.
>>
>> Fixes: 83cb2604f641 ("usb: core: add sysfs entry for usb device state")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Udipto Goswami <quic_ugoswami@quicinc.com>
> [...]
> 
>> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
>> index ffd7c99e24a3..5ba1875e6bf4 100644
>> --- a/drivers/usb/core/hub.c
>> +++ b/drivers/usb/core/hub.c
>> @@ -2053,9 +2053,22 @@ static void update_port_device_state(struct usb_device *udev)
>>   
>>   	if (udev->parent) {
>>   		hub = usb_hub_to_struct_hub(udev->parent);
>> -		port_dev = hub->ports[udev->portnum - 1];
>> -		WRITE_ONCE(port_dev->state, udev->state);
>> -		sysfs_notify_dirent(port_dev->state_kn);
>> +
>> +		/*
>> +		 * The Link Layer Validation System Driver (lvstest)
>> +		 * has step to unbind the hub before running the rest
>> +		 * of the procedure. This triggers hub_disconnect which
>> +		 * will set the hub's maxchild to 0, further resulting
> 
>     Resulting in.

got it.
> 
>> +		 * usb_hub_to_struct_hub returning NULL.
>> +		 *
>> +		 * Add if check to avoid running into NULL pointer
>> +		 * de-reference.
> 
>     This is obvious from the code below, I think...
ok will remove this.

Thanks,
-Udipto


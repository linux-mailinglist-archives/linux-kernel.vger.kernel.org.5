Return-Path: <linux-kernel+bounces-20817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB9382859A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 173E91F25721
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DABC374F1;
	Tue,  9 Jan 2024 11:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VlDz2CRN"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB6B38DD6;
	Tue,  9 Jan 2024 11:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 409AkWKS001428;
	Tue, 9 Jan 2024 11:57:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=HUAeeEbdoLwml3Qkib69/ikNISobITsTP6lTI8OvCmk=; b=Vl
	Dz2CRNLIP41rtQSIXpewvTH/ElYpzCAnhYLgsH2aReyQhIbPHfNJ+ePgjGr5fhuS
	BnJKGKBaawgR/41pmshPRRsa2qJ27EFZvGn4wCPnJGFd94GAq27Pu8i40559cV+P
	3iK+Qfa9xKE07w9QMF2nkM59Fo425nfVMVh0fdF3LEWgeiz3wN2MHggmm4o1R6Mm
	IR7P9+aU5cONWti8reWMxwJTl425TVZ3FMADHtQ8dUjyAu0hyQCrOrNAYSeWGU9A
	o+3Wll7mf9VI/im3gMOkXAisElkus13UIoqTRbgJk18SiqTc73p9xNjdSPdllNGw
	rqsDY1i0TpiH4siYzd8Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vgwq1rx2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 11:57:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 409BvtvV015264
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jan 2024 11:57:55 GMT
Received: from [10.217.219.221] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 9 Jan
 2024 03:57:52 -0800
Message-ID: <5ef9db3d-1e60-4f42-8a5b-52a9800e4707@quicinc.com>
Date: Tue, 9 Jan 2024 17:27:49 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] usb: core: Prevent null pointer dereference in
 update_port_device_state
Content-Language: en-US
To: Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
CC: Krishna Kurapati <quic_kriskura@quicinc.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20240109061708.26288-1-quic_ugoswami@quicinc.com>
 <3bb51617-81e1-7d19-598d-2b57164320e1@gmail.com>
From: Udipto Goswami <quic_ugoswami@quicinc.com>
In-Reply-To: <3bb51617-81e1-7d19-598d-2b57164320e1@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BtjOb8AzAwaf74a8g6BNVskhpdeZaDgv
X-Proofpoint-ORIG-GUID: BtjOb8AzAwaf74a8g6BNVskhpdeZaDgv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 lowpriorityscore=0 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 impostorscore=0 mlxlogscore=949 spamscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090097

Hi Sergei,

On 1/9/2024 3:01 PM, Sergei Shtylyov wrote:
> On 1/9/24 9:17 AM, Udipto Goswami wrote:
> 
>> Currently,the function update_port_device_state gets the usb_hub from
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
>> ---
>> v3: Re-wrote the comment for better context.
>> v2: Introduced comment for the if check & CC'ed stable.
>>
>>   drivers/usb/core/hub.c | 20 +++++++++++++++++---
>>   1 file changed, 17 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
>> index ffd7c99e24a3..6b514546e59b 100644
>> --- a/drivers/usb/core/hub.c
>> +++ b/drivers/usb/core/hub.c
>> @@ -2053,9 +2053,23 @@ static void update_port_device_state(struct usb_device *udev)
>>   
>>   	if (udev->parent) {
>>   		hub = usb_hub_to_struct_hub(udev->parent);
>> -		port_dev = hub->ports[udev->portnum - 1];
>> -		WRITE_ONCE(port_dev->state, udev->state);
>> -		sysfs_notify_dirent(port_dev->state_kn);
>> +
>> +		/*
>> +		 * The Link Layer Validation System Driver (lvstest)
>> +		 * has procedure of unbinding the hub before running
>> +		 * the rest of the procedure. This triggers
>> +		 * hub_disconnect will set the hub's maxchild to 0.
> 
>     I can't parse this sentence, s/th is missing...
Thanks for the review.
Maybe this would sound better?

"This triggers hub_disconnect which will set hub's maxchild to 0"
> 
>> +		 * This would result usb_hub_to_struct_hub in this
>> +		 * function to return NULL.
> 
>     "This would result in usb_hub_to_struct_hub in this function
> returning NULL", perhaps?

yah sound better. Will take care of it in next version.

Thanks,
-Udipto


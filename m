Return-Path: <linux-kernel+bounces-19776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2200B827381
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 352751C2228B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B2151C25;
	Mon,  8 Jan 2024 15:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QI6F3G0W"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C0451008;
	Mon,  8 Jan 2024 15:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 408F0Oso004201;
	Mon, 8 Jan 2024 15:36:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=1/yMGOYu2o111xMSjyfEKkROxqaEP9nQBApj9fCKdz4=; b=QI
	6F3G0W+JWNl5H3o8RFlY/uNGzR6Xx8L0ys3flED1TKhKCl/YCmOy/LUxzTfuR2k4
	7n/BZY49OOvD6ny29nNxXcSPBIQR/9Ej3JuP3uCTZ7rYfsyAOH2+dJUYJpWYtHg1
	c1e+Z6y7NvL7hpWekFzijyK1ZJFh1FLJFci0+ok6+jwLNPdHPsqg7qbDHkq6V9M+
	fNXap+eJ1VQc18E3k3ZijEMAqvmT19nLj+8SRPiZTUO7/1/oAN+bF0EisB07rGHE
	34vL/Tk4iWfle2QpOlk7HqTpo3CSlfUlJHR2BUfK1V73hFg9rSfvfHSNKul+FRb1
	+9MDqmiyHsemNdn6cE8A==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vg8mx9eks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 15:36:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 408FaJE2025601
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jan 2024 15:36:19 GMT
Received: from [10.216.17.83] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 8 Jan
 2024 07:36:16 -0800
Message-ID: <ee523f70-f41b-42be-967d-60691001b895@quicinc.com>
Date: Mon, 8 Jan 2024 21:06:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: core: Prevent null pointer dereference in
 update_port_device_state
Content-Language: en-US
To: Alan Stern <stern@rowland.harvard.edu>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krishna Kurapati
	<quic_kriskura@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20240108130706.15698-1-quic_ugoswami@quicinc.com>
 <2d801dd7-93de-4323-a214-1a73cc5a8451@rowland.harvard.edu>
From: Udipto Goswami <quic_ugoswami@quicinc.com>
In-Reply-To: <2d801dd7-93de-4323-a214-1a73cc5a8451@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qEuM_RaaruA5_t3wM-mvA2220RFLOhSY
X-Proofpoint-ORIG-GUID: qEuM_RaaruA5_t3wM-mvA2220RFLOhSY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 mlxlogscore=811 adultscore=0 impostorscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401080132

On 1/8/2024 8:56 PM, Alan Stern wrote:
> On Mon, Jan 08, 2024 at 06:37:06PM +0530, Udipto Goswami wrote:
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
>> v2: Introduced comment for the if check & CC'ed stable.
>>
>>   drivers/usb/core/hub.c | 15 ++++++++++++---
>>   1 file changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
>> index ffd7c99e24a3..d40b5500f95b 100644
>> --- a/drivers/usb/core/hub.c
>> +++ b/drivers/usb/core/hub.c
>> @@ -2053,9 +2053,18 @@ static void update_port_device_state(struct usb_device *udev)
>>   
>>   	if (udev->parent) {
>>   		hub = usb_hub_to_struct_hub(udev->parent);
>> -		port_dev = hub->ports[udev->portnum - 1];
>> -		WRITE_ONCE(port_dev->state, udev->state);
>> -		sysfs_notify_dirent(port_dev->state_kn);
>> +
>> +		/*
>> +		 * usb_hub_to_struct_hub() if returns NULL can
>> +		 * potentially cause NULL pointer dereference upon further
>> +		 * access.
>> +		 * Avoid this with an if check.
>> +		 */
> 
> This is not what I meant.  It's perfectly obvious that if
> usb_hub_to_struct_hub() returns NULL then there will be a NULL-pointer
> dereference.  You don't need to explain that to anybody.
> 
> Instead, you need to explain why it is _possible_ for
> usb_hub_to_struct_hub() to return NULL.  The reason is because the
> lvstest driver messes around with usbcore internals without telling the
> hub driver, so hub will be NULL in cases where udev was created by
> lvstest.

aah okay, Thanks for the clarification. I'll re-write the comment 
mentioning this.

Thanks,
-Udipto


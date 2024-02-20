Return-Path: <linux-kernel+bounces-72586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F259985B597
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30CA21C22499
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773205D73B;
	Tue, 20 Feb 2024 08:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OwpmWsAs"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2101A5A110;
	Tue, 20 Feb 2024 08:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708418459; cv=none; b=g023qv6bfK0qIAzrb9+d4yICvvHk2pL3768TuOq6JkvzktK7whxjodiGVH2sFCx0+xB8T4FD6pJKGM8q/0l0NFXoSbGtj2NDED+OCZNbyqraKrFW4VR9VYQuysXYelr4Lk2c+0lG1ffMfyPNo6EfzIdG593uTnR30d0DIetCsJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708418459; c=relaxed/simple;
	bh=oORP5o4CK3nbp/r+mkFQ/6is/SFKcd9LJTARAcq+IS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=G3PIitZSm5nwJVaCMC1PE9fRIWNNC/1V0eBqeilwq13B0Au68w4BQ9B07dMNV3gXIJ+/r1At9JA3hXsE6Ngs0GAEikyTz/12GIHDUDGC5D25Sru7BDk60Y2PxLDr2GQX039dLN/L7uCec3y35DZ+lCjGVkqR8QRB/EiIFbvhQsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OwpmWsAs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41K5JatW001282;
	Tue, 20 Feb 2024 08:40:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ZII59W2AALxIhixBEEfEcqek5xGBPnkw52tMeTrpMCs=; b=Ow
	pmWsAs1oMMc+FBY7DXw/6EJD5USiMtFejgZl+982efvYKXQxexnev9dQCBI2k4v0
	Hu78wFurzTV7DLxwW7dGqLIsjwVfrw4PbSFD5pd6/hYKp5mQNCTB/ffndpEEJQb2
	Em10bjRwy8i8Z7dPCkDSVbmSHWb6NysiVo+twa0PEKl/hyJheh5Xg8Q5bIsCbbGa
	I2MZyioR/I4KbL646nQIi/m05p0wwAHhGe8bNcZKAsyvfxkHZ9C8722/D1ks6VIG
	TcDiPuvpYgIR3qJBohmqdgSP/zzAMvReoQZinlny2tcJveJc+iqfJPHA+dMQ0Vl2
	bTC6z5D0/DIl5V3yAgsA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wc78qsv6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 08:40:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41K8elKX001507
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 08:40:47 GMT
Received: from [10.216.2.58] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 20 Feb
 2024 00:40:44 -0800
Message-ID: <4d62d4d0-3f28-486b-8132-4cc571b6f721@quicinc.com>
Date: Tue, 20 Feb 2024 14:10:32 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3: gadget: remove warning during kernel boot
To: Greg KH <gregkh@linuxfoundation.org>, Ray Chi <raychi@google.com>
CC: <Thinh.Nguyen@synopsys.com>, <quic_uaggarwa@quicinc.com>,
        <albertccwang@google.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20240220081205.135063-1-raychi@google.com>
 <2024022024-trout-kennel-6d14@gregkh>
Content-Language: en-US
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <2024022024-trout-kennel-6d14@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wpYUB7bXC3zgJPUjujnUAg0A2c3NhM1i
X-Proofpoint-ORIG-GUID: wpYUB7bXC3zgJPUjujnUAg0A2c3NhM1i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 adultscore=0 spamscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=646 phishscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402200061



On 2/20/2024 2:04 PM, Greg KH wrote:
> On Tue, Feb 20, 2024 at 04:12:04PM +0800, Ray Chi wrote:
>> The dwc3->gadget_driver is not initialized during the dwc3 probe
>> process. This leads to a warning when the runtime power management (PM)
>> attempts to suspend the gadget using dwc3_gadget_suspend().
> 
> What type of warning happens?
> 
>> This patch adds a check to prevent the warning.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 61a348857e86 ("usb: dwc3: gadget: Fix NULL pointer dereference in dwc3_gadget_suspend")
>> Signed-off-by: Ray Chi <raychi@google.com>
>> ---
>>   drivers/usb/dwc3/gadget.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index 28f49400f3e8..de987cffe1ec 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -4708,6 +4708,9 @@ int dwc3_gadget_suspend(struct dwc3 *dwc)
>>   	unsigned long flags;
>>   	int ret;
>>   
>> +	if (!dwc->gadget_driver)
>> +		return 0;
>> +
> 
> This directly reverts part of the commit you say this fixes, are you
> SURE about this?  Why?
> 

Hi Ray,

Thinh sent a patch recently addressing the issue in soft disconnect.
Can you check if it helps:

https://lore.kernel.org/all/e3be9b929934e0680a6f4b8f6eb11b18ae9c7e07.1708043922.git.Thinh.Nguyen@synopsys.com/

Regards,
Krishna,


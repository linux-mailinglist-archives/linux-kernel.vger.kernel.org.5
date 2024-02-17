Return-Path: <linux-kernel+bounces-69695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B29858D65
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 06:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BCB52834AF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 05:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F701CAA4;
	Sat, 17 Feb 2024 05:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jsGZ3Lum"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7959F23D0;
	Sat, 17 Feb 2024 05:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708149213; cv=none; b=tZljfwliuAmfQivT09ICGlB+B2i7EGYagMINZZH8Ye8wvXBnrx/hdEsskzMtbxfqkA1hclZhp5/dcYwXfmRxxc+IyTSjvFUHAakD90Fu+eCvylL925/iIg5e5GLB7V4w4hHTJZWc6z3tJcDgi0nPAbUJZTtF9WEJm68wzBQ4uG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708149213; c=relaxed/simple;
	bh=J97O+8s7zLrg4/007e5d7/fK2OrxoqmwttL4iP9Zm9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=U5HRWDzsF+5+dgGAZEr3SkLy5sLz5hPVzQ2feOBu7LB+dTy0R0pfXpJRnBaatEhkD2UP4ToktYfzo/YWRcBn8gz5zTDS2P/5GXcc5D5I9QtNIm2uC6XAqWsYs+nZdOZJURb5YuSahD+g6RTUq7xNMNK6Gvd1HIl4Hy4Z1Y9s2FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jsGZ3Lum; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41H5rSt1006585;
	Sat, 17 Feb 2024 05:53:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=XOzeWI9vZsx3HRpuXAkLJFYxgRaUp8c1O6F9yf9gJFI=; b=js
	GZ3LumrrUvDqo5kk5yi1w99j0Klt2WZx7ZzygbuSKTdbwLlyfNg8/Lqom5XauIkh
	WGlsDEeUxysPklVXJ9DTsUACcmUBogPVJX5miLT3EnSWw0Vzc3K9UUiSdUAeUt2F
	MaoiDXlvKlZymonVse+rQFGdvtj8w5SAueaWc6lzh3o418nwsyd8ge3Myku5XRD8
	mKULwU2YwAMay7adLmQ6RaefE99tCudZBDBBSNfLBExhjcHvLX4FgQywtz367Uyk
	fBmWdiotw6ocktavY1uv+Okw8LQMBw3pNRUNlSSy2fikSEUVyMGRh4jUbYAwqUgK
	47y0VenroHo2w3aaxLTQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wamd505pr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Feb 2024 05:53:27 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41H5rQmJ001810
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Feb 2024 05:53:27 GMT
Received: from [10.216.0.128] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 16 Feb
 2024 21:53:23 -0800
Message-ID: <0870fec7-e47d-40d5-a782-d2fc638c3b05@quicinc.com>
Date: Sat, 17 Feb 2024 11:23:19 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb-storage: Add US_FL_FIX_INQUIRY quirk for Intenso
 Twist Line USB 3.2
Content-Language: en-US
To: Alan Stern <stern@rowland.harvard.edu>
CC: <tern@rowland.harvard.edu>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_wcheng@quicinc.com>,
        <quic_jackp@quicinc.com>
References: <20240214111721.18346-1-quic_selvaras@quicinc.com>
 <39cd8789-7764-4904-8cb9-21f239b3c04c@rowland.harvard.edu>
From: Selvarasu Ganesan <quic_selvaras@quicinc.com>
In-Reply-To: <39cd8789-7764-4904-8cb9-21f239b3c04c@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: AmRIWnTJhhN0nEY74VTqZbAjN3BHrEnw
X-Proofpoint-GUID: AmRIWnTJhhN0nEY74VTqZbAjN3BHrEnw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-17_02,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 malwarescore=0 mlxlogscore=885 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402170042

Hi Alan,

On 2/14/2024 8:34 PM, Alan Stern wrote:
> On Wed, Feb 14, 2024 at 03:17:21AM -0800, Selvarasu Ganesan wrote:
>> The Intenso Twist Line USB 3.2 flash drive fails to respond to the
>> INQUIRY data stage request for a 36 bulk in request from the host. This
>> commit adds the US_FL_FIX_INQUIRY flag to fake the INQUIRY command for
>> this device, preventing a storage enumeration failure.
>>
>> USBMON log:
>> ffffff8a3ee06a00 3192811972 S Ci:2:009:0 s c0 33 0000 0000 0002 2 <
>> ffffff8a3ee06a00 3192862051 C Ci:2:009:0 -2 0
>> ffffff8a3ee06a00 3192862185 S Ci:2:009:0 s c0 33 0000 0000 0002 2 <
>> ffffff8a3ee06a00 3192912299 C Ci:2:009:0 -2 0
>> ffffff8a3ee06e00 3193040068 S Ci:2:003:0 s c1 04 0930 bf80 0004 4 <
>> ffffff8a3ee06e00 3193040214 C Ci:2:003:0 0 4 = 880b0700
>> ffffff8a3ee06e00 3193040279 S Ci:2:002:0 s a3 00 0000 0003 0004 4 <
>> ffffff8a3ee06e00 3193040427 C Ci:2:002:0 0 4 = 00010000
>> ffffff8a3ee06e00 3193040470 S Ci:2:002:0 s a3 00 0000 0004 0004 4 <
>> ffffff8a3ee06e00 3193040672 C Ci:2:002:0 0 4 = 03050000
>> ffffff892b309500 3193824092 S Ci:2:009:0 s a1 fe 0000 0000 0001 1 <
>> ffffff892b309500 3193824715 C Ci:2:009:0 0 1 = 00
>> ffffff892b309500 3193825060 S Bo:2:009:2 -115 31 = 55534243 01000000 24000000 80000612 00000024 00000000 00000000 000000
>> ffffff892b309500 3193825150 C Bo:2:009:2 0 31 >
>> ffffff8b8419d400 3193825737 S Bi:2:009:1 -115 36 <
>> ffffff8a3ee06400 3194040175 S Ci:2:003:0 s c1 04 0930 bf80 0004 4 <
>> ffffff8a3ee06400 3194040372 C Ci:2:003:0 0 4 = 880b0700
>> ffffff89bee5b100 3194040591 S Ci:2:002:0 s a3 00 0000 0003 0004 4 <
>> ffffff89bee5b100 3194040681 C Ci:2:002:0 0 4 = 00010000
>> ffffff89bee5b100 3194040999 S Ci:2:002:0 s a3 00 0000 0004 0004 4 <
>> ffffff89bee5b100 3194041083 C Ci:2:002:0 0 4 = 03050000
>> ffffff8a3ee06a00 3195040349 S Ci:2:003:0 s c1 04 0930 bf80 0004 4 <
> 
> This is very surprising.  A mass-storage device that doesn't respond to
> INQUIRY commands won't work with Windows or Mac OSX.  Have you tried
> testing the device with those operating systems to see what they send
> and how it responds?
> 
> Alan Stern

Thanks for your review comments.
To reconfirm, we have tested this device with Windows and its working
fine. We noticed that the INQUIRY command only fails when this device is
connected to our DUT via a USB2.0 hub.
We also tested various Intensio mass storage devices and observed the
same behavior.
We have confirmed that there are no issues with our DUT setup as we have
tested different mass storage devices (such as Kingston usb3.2, Samsung
ssd 3.2) and they are working fine. We also observed responses for the
INQUIRY command for other working mass storage devcies.
We suspect that this issue is specific to Intensio devices when used
with a USB2.0 hub on a Linux host. We are still investigating this issue
on other hosts using an external hub.

Thanks,
Selva


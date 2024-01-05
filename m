Return-Path: <linux-kernel+bounces-17470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C3B824DAA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 05:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 470ED1F22BAC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 04:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C845255;
	Fri,  5 Jan 2024 04:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LHHYLeRa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F4F5228;
	Fri,  5 Jan 2024 04:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4053qVCM019303;
	Fri, 5 Jan 2024 04:42:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=kETwECccJTubWuIkLIED8QEDY4c1UgxUEHGG4NmaelU=; b=LH
	HYLeRaJ2Y0PUEXc4HBJdI2/xbLYdjsU6+dv4JcVAxk4rA7pMbsxVXPwjZ6M1zHQd
	UdZkpwfrt5RjfnN/BimW2c24luyJqZq7CSJ3tm3Xvbz3/2WmCywOzGKuIVjOIm+B
	/22Q5xgR0j7hzR6Q6LiL5LyCqunBLlGuiA0zLF94cHmxLq7EBPRlAjatkLIVu00P
	dvOiTqW8+8ApNVVl0bZuInzEZ98x+/OeC6z23VyDj6DOqnvYfyvYFEFv3ZRTdOgh
	Sh01I2jqUrf4DdpSunpGAPf+p/ltqi0nAzTspDHnsPpghycTO1JLeuY1P9QZQRBK
	cKpkCLpkufqjgAUKwNxQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ve97r85t9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jan 2024 04:42:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4054fxpf032656
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Jan 2024 04:41:59 GMT
Received: from [10.216.5.109] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 4 Jan
 2024 20:41:56 -0800
Message-ID: <50e7cf06-dc3c-4324-9a5d-d82bec9cca89@quicinc.com>
Date: Fri, 5 Jan 2024 10:11:53 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: ncm: Avoid dropping datagrams of properly
 parsed NTBs
To: Jack Pham <quic_jackp@quicinc.com>,
        =?UTF-8?Q?Maciej_=C5=BBenczykowski?=
	<maze@google.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hardik Gajjar
	<hgajjar@de.adit-jv.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_wcheng@quicinc.com>
References: <20240102055143.3889-1-quic_kriskura@quicinc.com>
 <CANP3RGeirg+f8cBbw_3YR5AvuB1ZxJC_9-wcn+Tb-GXf1ESKCQ@mail.gmail.com>
 <ad60f399-5c6a-4f16-8c28-f4d4e0fde1ff@quicinc.com>
 <CANP3RGf5dg14DNuKOn9pqWd4oSBDsPhwwBB7AJ0c3qHbDT0sBQ@mail.gmail.com>
 <572c21f8-e642-4d30-84aa-673051be6bb4@quicinc.com>
 <20240104211858.GB4127689@hu-jackp-lv.qualcomm.com>
Content-Language: en-US
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <20240104211858.GB4127689@hu-jackp-lv.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SUZrZqIL7PQLT9VLc6PlXc0m-ULrirpF
X-Proofpoint-GUID: SUZrZqIL7PQLT9VLc6PlXc0m-ULrirpF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 impostorscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=765 suspectscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401050036



On 1/5/2024 2:48 AM, Jack Pham wrote:
> On Tue, Jan 02, 2024 at 05:04:01PM +0530, Krishna Kurapati PSSNV wrote:
>>
>>
>>>> The above might work. But just wanted to check why this 1 byte would
>>>> come actually ? Any reason for this ? ZLP must not give a 1 byte packet
>>>> of 1 byte AFAIK.
>>>
>>> I'm not a USB expert, but... my (possibly wrong) understanding is:
>>> (note I may be using bad terminology... also the 1024/16384 constants
>>> are USB3 specific, USB2 has afaik max 512 not 1024, I think USB1 is
>>> even 64, but it's likely too old to matter, etc.)
>>>
>>> USB3 payloads can be up to 16384 bytes in size,
>>> on the wire they are split up into packets of between 0 and 1024 bytes.
>>> [a Zero Length Packet is a ZLP]
>>> A usb payload is terminated with a usb packet of < 1024 bytes.
>>>
>>> So a 1524 byte payload would be sent as 2 packets 1024 + 500.
>>> While a 2048 byte payload would be sent as 3 packets 1024 + 1024 + 0 (ie. ZLP)
>>>
>>> A 16384 byte payload could be sent as 16 * 1024 + ZLP,
>>> but since 16384 is the max you might be able to get away with just 16
>>> * 1024 and skip the ZLP...
>>>
>>> I think this is why the Linux usb code base has ZLP / NO_ZLP quirks.
>>> [but do note I may be wrong, I haven't gone looking at what exactly
>>> the zlp quirks do,
>>> not even sure if they're receive or transmit side... or both]
>>>
>>> Different hardware/usb chipsets/etc have different behaviour wrt. ZLPs.
>>>
>>> In general it seems like what needs to happen is much clearer if you
>>> just avoid the need for ZLPs entirely.
>>> I think that's what windows is trying to do here: avoid ever sending a
>>> usb payload with a multiple of 1024 bytes,
>>> so it never has to send ZLPs. This seems easy enough to do...
>>> limit max to 16383 (not 16384) and add 1 byte of zero pad if the
>>> payload ends up being a multiple of 1024.
>>>
>>
>> Got it. Thanks for the explanation. Atleast this gives me an insight into
>> what might be the problem.
> 
> Hooray to MS for having open-sourced a reference version of their NCM
> driver on GitHub (under MIT license)--and I think this might explain it:
> 
> https://github.com/microsoft/NCM-Driver-for-Windows/blob/release_21H2/host/device.cpp#L902
> 
> which states in a comment (pasted line-wrapped for mail-friendliness)
> 
>          //NCM spec is not explicit if a ZLP shall be sent when
>          //wBlockLength != 0 and it happens to be
>          //multiple of wMaxPacketSize. Our interpretation is that no ZLP
>          //needed if wBlockLength is non-zero,
>          //because the non-zero wBlockLength has already told the
>          //function side the size of transfer to be expected.
>          //
>          //However, there are in-market NCM devices rely on ZLP as long
>          //as the wBlockLength is multiple of wMaxPacketSize.
>          //To deal with such devices, we pad an extra 0 at end so the
>          //transfer is no longer multiple of wMaxPacketSize
> 
> If so then would be worth calling this out in commit text and/or code
> comment.

Thanks for the inputs Jack. Will make sure to add it in commit text clearly.

Regards,
Krishna,


Return-Path: <linux-kernel+bounces-14297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FBB821B08
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C79561C21DD8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDF1EAD7;
	Tue,  2 Jan 2024 11:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Fo3EJ1db"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B132EE56E;
	Tue,  2 Jan 2024 11:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 402AUxoa023229;
	Tue, 2 Jan 2024 11:34:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Y/2fdTPEe2sPzCEy2WILmWKM60PXcxjYTVJBAsJLWI8=; b=Fo
	3EJ1dbR/5LUJi6NLMRVjg397U1GEgCPZStX3InDM+f03CbAtf4nM9YsFDhYEBvqv
	oDt3oo8j+RAjFQuqEAPi3jkekEVqp5KyYo/3rrGBOP6mKPcwkoa+jwKtaLwBFuNM
	nHwijtf9GF2KNRR3GiKgPvO7TzLTBq11qibVkiR60VAVLyBx0SrZHfy3loZKE+M6
	uB+b12YMRlJix8dJfseq2wLf9jy4Kidiw3pMbb7S1N5vxmLdhFNjmHKeQL/iKK86
	s9wwVNaSR5yt6Gz+3ni/aFob/qIU8el+CUfew6luy3tQ51Ptb4g6a718irOH2KtI
	P0ZH0O7qDc3hEIckRwHw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vcets8a60-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jan 2024 11:34:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 402BY8rv020937
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Jan 2024 11:34:08 GMT
Received: from [10.216.52.214] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 2 Jan
 2024 03:34:04 -0800
Message-ID: <572c21f8-e642-4d30-84aa-673051be6bb4@quicinc.com>
Date: Tue, 2 Jan 2024 17:04:01 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: ncm: Avoid dropping datagrams of properly
 parsed NTBs
To: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hardik Gajjar
	<hgajjar@de.adit-jv.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_wcheng@quicinc.com>, <quic_jackp@quicinc.com>
References: <20240102055143.3889-1-quic_kriskura@quicinc.com>
 <CANP3RGeirg+f8cBbw_3YR5AvuB1ZxJC_9-wcn+Tb-GXf1ESKCQ@mail.gmail.com>
 <ad60f399-5c6a-4f16-8c28-f4d4e0fde1ff@quicinc.com>
 <CANP3RGf5dg14DNuKOn9pqWd4oSBDsPhwwBB7AJ0c3qHbDT0sBQ@mail.gmail.com>
Content-Language: en-US
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <CANP3RGf5dg14DNuKOn9pqWd4oSBDsPhwwBB7AJ0c3qHbDT0sBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _32YhLGxJidW16K72xpi2hapLS1OR2Kv
X-Proofpoint-GUID: _32YhLGxJidW16K72xpi2hapLS1OR2Kv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 mlxlogscore=913
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401020088



>> The above might work. But just wanted to check why this 1 byte would
>> come actually ? Any reason for this ? ZLP must not give a 1 byte packet
>> of 1 byte AFAIK.
> 
> I'm not a USB expert, but... my (possibly wrong) understanding is:
> (note I may be using bad terminology... also the 1024/16384 constants
> are USB3 specific, USB2 has afaik max 512 not 1024, I think USB1 is
> even 64, but it's likely too old to matter, etc.)
> 
> USB3 payloads can be up to 16384 bytes in size,
> on the wire they are split up into packets of between 0 and 1024 bytes.
> [a Zero Length Packet is a ZLP]
> A usb payload is terminated with a usb packet of < 1024 bytes.
> 
> So a 1524 byte payload would be sent as 2 packets 1024 + 500.
> While a 2048 byte payload would be sent as 3 packets 1024 + 1024 + 0 (ie. ZLP)
> 
> A 16384 byte payload could be sent as 16 * 1024 + ZLP,
> but since 16384 is the max you might be able to get away with just 16
> * 1024 and skip the ZLP...
> 
> I think this is why the Linux usb code base has ZLP / NO_ZLP quirks.
> [but do note I may be wrong, I haven't gone looking at what exactly
> the zlp quirks do,
> not even sure if they're receive or transmit side... or both]
> 
> Different hardware/usb chipsets/etc have different behaviour wrt. ZLPs.
> 
> In general it seems like what needs to happen is much clearer if you
> just avoid the need for ZLPs entirely.
> I think that's what windows is trying to do here: avoid ever sending a
> usb payload with a multiple of 1024 bytes,
> so it never has to send ZLPs. This seems easy enough to do...
> limit max to 16383 (not 16384) and add 1 byte of zero pad if the
> payload ends up being a multiple of 1024.
> 

Got it. Thanks for the explanation. Atleast this gives me an insight 
into what might be the problem.

>>> It seems a little dangerous to just blindly ignore arbitrary amounts
>>> of trailing garbage...
>>
>> Yes. I agree, which is why I put a note in comment section of patch
>> stating that this doesn't cover all cases, just the ones found in the
>> testing so far. But the code suggestion you provided might actually work
>> out. So something like the following ?
>>
>> if (to_process == 1) && (block_len%1024 == 0) && (*payload == 0)
> 
> Assuming it compiles and works ;-) I wrote this without looking at the code. >

I will check and put a v2 with the proper check.

> I'm guessing this needs to be %512 for usb2...
> Do we know if we're connected via usb2 or usb3?
> [mayhaps there's some field that already stores this 1024 constant...]
> If not... should we just check for %512 instead to support both usb2 and usb3?
> 
>>       // extra 1 zero byte pad to prevent multiple of 1024 sized packet
>>       return
>> } else if (to_process > 1) {
> 
> this should likely continue to be != 0 or > 0
> 
>>       goto parse_ntb;
>> }
Ok, will make it (> 0)

BTW, Totally, off the conversation, can you also review: 
https://lore.kernel.org/all/20231221153216.18657-1-quic_kriskura@quicinc.com/

I made changes in this v2 as per comments on v1.

Regards,
Krishna,


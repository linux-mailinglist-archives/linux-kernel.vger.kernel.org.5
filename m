Return-Path: <linux-kernel+bounces-14265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 565EE821A62
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3DC42830B6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C57DDA8;
	Tue,  2 Jan 2024 10:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GZ366XxB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20223E555;
	Tue,  2 Jan 2024 10:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 402AUvbF022334;
	Tue, 2 Jan 2024 10:48:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Gve96hkmR2DwSxK1pThmoF2KGj9hMJWK3kzn1WAIBI8=; b=GZ
	366XxBquWCi9ODZLdyNLrcB9lPJ8fM+BN31x5LZyIUNULwnOVfHYw7LqfYG+Tm92
	qa5c5yBbvyTFxWBYmPgIOZ/ROVPYUmxyiQyrhiPrI3JaMxEAwg5EFGbzYp/6o082
	6GBIaMLJFdUYyKTlLzeVjDkVjRM1Zl9i7AXi6BLAkhoVvrT0Nl9nThSuz9fs6cGe
	ztgWPMsATFS899u8g3s2x33xxWgQtULCB0HIZZ6IXu5vQ/piVZKaJg2aeaSkcMU0
	JlTaC0Vc9W3Q7GaGQCrmirPX2og6srgcFgvvf2qu02dIaXYH1pjdPczbGgj+Zw+v
	gYXkSzuJg7b1Zw41mwew==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3va8wp4u1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jan 2024 10:48:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 402AmsqZ020942
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Jan 2024 10:48:54 GMT
Received: from [10.216.52.214] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 2 Jan
 2024 02:48:51 -0800
Message-ID: <ad60f399-5c6a-4f16-8c28-f4d4e0fde1ff@quicinc.com>
Date: Tue, 2 Jan 2024 16:18:47 +0530
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
Content-Language: en-US
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <CANP3RGeirg+f8cBbw_3YR5AvuB1ZxJC_9-wcn+Tb-GXf1ESKCQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yLGyZlRJ2qKo2cJtj3FKzXJqGbXM5daP
X-Proofpoint-ORIG-GUID: yLGyZlRJ2qKo2cJtj3FKzXJqGbXM5daP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401020082


>> It is observed sometimes when tethering is used over NCM with Windows 11
>> as host, at some instances, the gadget_giveback has one byte appended at
>> the end of a proper NTB. When the NTB is parsed, unwrap call looks for
>> any leftover bytes in SKB provided by u_ether and if there are any pending
>> bytes, it treats them as a separate NTB and parses it. But in case the
>> second NTB (as per unwrap call) is faulty/corrupt, all the datagrams that
>> were parsed properly in the first NTB and saved in rx_list are dropped.
> 
> I think this is likely Windows trying to avoid generating 0 length frames.
> 
> (usb max single datagram [frame?] size is 1024 bytes).
> 
> My guess is this extra byte will only ever happen at the end of a
> multiple of 1024 bytes,
> and it will always be exactly one byte, and it will likely be a '0' pad byte.
> 

You are right. This happens only with packet sizes of 1024/2048/3072 
etc., and it is 0x00 only.

> Could you check if a more specific test of this sort would make sense?
> (ie. fix the problem)
> 
> Something like
> 
> if (to_process == 1) && (current_offset & 1023 == 0) && (*payload == 0)
>    // extra 1 zero byte pad to prevent multiple of 1024 sized packet
>    return
> }
> 

The above might work. But just wanted to check why this 1 byte would 
come actually ? Any reason for this ? ZLP must not give a 1 byte packet 
of 1 byte AFAIK.

> It seems a little dangerous to just blindly ignore arbitrary amounts
> of trailing garbage...
> 

Yes. I agree, which is why I put a note in comment section of patch 
stating that this doesn't cover all cases, just the ones found in the 
testing so far. But the code suggestion you provided might actually work 
out. So something like the following ?

if (to_process == 1) && (block_len%1024 == 0) && (*payload == 0)
     // extra 1 zero byte pad to prevent multiple of 1024 sized packet
     return
} else if (to_process > 1) {
     goto parse_ntb;
}

Just modified in current_offset with block_len and checked it with 
%1024. Let me know if it is fine and I will give the change to testing 
team. The issue is easily reproducible.

Regards,
Krishna,

>>
>> Adding a few custom traces showed the following:
>>
>> [002] d..1  7828.532866: dwc3_gadget_giveback: ep1out:
>> req 000000003868811a length 1025/16384 zsI ==> 0
>> [002] d..1  7828.532867: ncm_unwrap_ntb: K: ncm_unwrap_ntb toprocess: 1025
>> [002] d..1  7828.532867: ncm_unwrap_ntb: K: ncm_unwrap_ntb nth: 1751999342
>> [002] d..1  7828.532868: ncm_unwrap_ntb: K: ncm_unwrap_ntb seq: 0xce67
>> [002] d..1  7828.532868: ncm_unwrap_ntb: K: ncm_unwrap_ntb blk_len: 0x400
>> [002] d..1  7828.532868: ncm_unwrap_ntb: K: ncm_unwrap_ntb ndp_len: 0x10
>> [002] d..1  7828.532869: ncm_unwrap_ntb: K: Parsed NTB with 1 frames
>>
>> In this case, the giveback is of 1025 bytes and block length is 1024.
>> The rest 1 byte (which is 0x00) won't be parsed resulting in drop of
>> all datagrams in rx_list.
>>
>> Same is case with packets of size 2048:
>> [002] d..1  7828.557948: dwc3_gadget_giveback: ep1out:
>> req 0000000011dfd96e length 2049/16384 zsI ==> 0
>> [002] d..1  7828.557949: ncm_unwrap_ntb: K: ncm_unwrap_ntb nth: 1751999342
>> [002] d..1  7828.557950: ncm_unwrap_ntb: K: ncm_unwrap_ntb blk_len: 0x800
>>
>> Lecroy shows one byte coming in extra confirming that the byte is coming
>> in from PC:
>>
>> Transfer 2959 - Bytes Transferred(1025)  Timestamp((18.524 843 590)
>> - Transaction 8391 - Data(1025 bytes) Timestamp(18.524 843 590)
>> --- Packet 4063861
>>        Data(1024 bytes)
>>        Duration(2.117us) Idle(14.700ns) Timestamp(18.524 843 590)
>> --- Packet 4063863
>>        Data(1 byte)
>>        Duration(66.160ns) Time(282.000ns) Timestamp(18.524 845 722)
>>
>> Fix this by checking if the leftover bytes before parsing next NTB is of
>> size more than the expected header.
>>
>> Fixes: 427694cfaafa ("usb: gadget: ncm: Handle decoding of multiple NTB's in unwrap call")
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
>> There could probably be cases where the first NTB is proper and the second
>> NTB's header is proper but the NDP is corrupt, and in those cases too, all
>> the datagrams are dropped. But I haven't seen such case practically.
>>
>>   drivers/usb/gadget/function/f_ncm.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
>> index cc0ed29a4adc..a75b6dc8b0cb 100644
>> --- a/drivers/usb/gadget/function/f_ncm.c
>> +++ b/drivers/usb/gadget/function/f_ncm.c
>> @@ -1325,7 +1325,7 @@ static int ncm_unwrap_ntb(struct gether *port,
>>               "Parsed NTB with %d frames\n", dgram_counter);
>>
>>          to_process -= block_len;
>> -       if (to_process != 0) {
>> +       if (to_process > opts->nth_size) {
> 
> shouldn't this check actually be >= not > ?
> 

Yes. But what is header is present and no data further ? Just to fix 
another harmless corner case, I added the "=".

Regards,
Krishna,


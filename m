Return-Path: <linux-kernel+bounces-82617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0F7868751
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82B1B2880D4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F861199B4;
	Tue, 27 Feb 2024 02:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RBFHKz4T"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B384A0A;
	Tue, 27 Feb 2024 02:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709001628; cv=none; b=Aspzf5nIcuMvRV+ppiTvtSxCB/JUTTKRjni2UvnheFFvBhau+1nwiBkre9tDs7lCJZnYBXBNcBIslMWuJ0NcsFI1y1ujbOx30OlGDOErjeV9AmymtJrRkLra5/tIR9H14kLGYrT89/vmqolYHyESzruig380UZl1+r7mNRBn4FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709001628; c=relaxed/simple;
	bh=+3yBtuSyoef4VRZjC+MkasTdpTyhRCBQn10mefG5vIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=F6R8Q5ThYrXSiJpzhb1x/BjdRpqdsQop2ltORgl4/dYRfKkd6xdMHhTZPvYBXX65zl6qyKk8TuUR9MZpNFWI0FkYIx7xQxjvNZ2Dc3x5X/LdAwO85qEcXKM33YnzuefapEaM5XGopsj2ZsGCfhcgQWiepSWQAW60BLcJ2UmBPL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RBFHKz4T; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41R2e57O028182;
	Tue, 27 Feb 2024 02:40:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=eTh1LUuFjMQ+78KTec6yYLCg9bDWKozpU0l3hKomSqo=; b=RB
	FHKz4TAXHItM9F++4PsVEh3BSLGW+1tNsk5i4VsmhtKllgFt7WnmVObmkwKdTN8E
	G8Xj0hDP6wNMllWeXut+em8C8nJ1vxuJiMq1k5rAgC3bTsHkEM+QOLo5aTa+Bk4P
	h10eDJ/criHEhmLXrBC4FpJdE8rD8BERGwrAamTm/Wvi7EjZr70z4vvVjBEu/21h
	+D1E9vJ1sS8RwDhVBpDPzeHcObHBTEpEBdQ4bcsWCHENmEk3osRN49+KF+dsjIjL
	fKg6NyGjfTA7mbu81ZkWInf1pvdmHIji1aZaKQVIA4XXTcU490P7l4jMQIqCHpHQ
	tEE2HUcE32J2F6FEzhvQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wh6ws8108-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 02:40:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41R2eN14028545
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 02:40:23 GMT
Received: from [10.216.0.207] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 26 Feb
 2024 18:40:19 -0800
Message-ID: <99d284b3-3ddb-4928-b4c2-817acc76c241@quicinc.com>
Date: Tue, 27 Feb 2024 08:10:15 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] usb: gadget: ncm: Fix handling of zero block length
 packets
To: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_wcheng@quicinc.com>,
        <quic_jackp@quicinc.com>
References: <20240226112816.2616719-1-quic_kriskura@quicinc.com>
 <CANP3RGf7qsuwcgVpmOoH0QNh-v4PjRh_xj7Rcz=YJ1TbGiPK0Q@mail.gmail.com>
Content-Language: en-US
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <CANP3RGf7qsuwcgVpmOoH0QNh-v4PjRh_xj7Rcz=YJ1TbGiPK0Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: j_lHkW9uJ5_o6u8QMMxtPZWlQ_w9BUiC
X-Proofpoint-GUID: j_lHkW9uJ5_o6u8QMMxtPZWlQ_w9BUiC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 suspectscore=0
 mlxlogscore=975 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2402270020



On 2/27/2024 3:26 AM, Maciej Żenczykowski wrote:
> On Mon, Feb 26, 2024 at 3:28 AM Krishna Kurapati
> <quic_kriskura@quicinc.com> wrote:
>>
>> While connecting to a Linux host with CDC_NCM_NTB_DEF_SIZE_TX
>> set to 65536, it has been observed that we receive short packets,
>> which come at interval of 5-10 seconds sometimes and have block
>> length zero but still contain 1-2 valid datagrams present.
>>
>> According to the NCM spec:
>>
>> "If wBlockLength = 0x0000, the block is terminated by a
>> short packet. In this case, the USB transfer must still
>> be shorter than dwNtbInMaxSize or dwNtbOutMaxSize. If
>> exactly dwNtbInMaxSize or dwNtbOutMaxSize bytes are sent,
>> and the size is a multiple of wMaxPacketSize for the
>> given pipe, then no ZLP shall be sent.
>>
>> wBlockLength= 0x0000 must be used with extreme care, because
>> of the possibility that the host and device may get out of
>> sync, and because of test issues.
>>
>> wBlockLength = 0x0000 allows the sender to reduce latency by
>> starting to send a very large NTB, and then shortening it when
>> the sender discovers that there’s not sufficient data to justify
>> sending a large NTB"
>>
>> However, there is a potential issue with the current implementation,
>> as it checks for the occurrence of multiple NTBs in a single
>> giveback by verifying if the leftover bytes to be processed is zero
>> or not. If the block length reads zero, we would process the same
>> NTB infintely because the leftover bytes is never zero and it leads
>> to a crash. Fix this by bailing out if block length reads zero.
>>
>> Fixes: 427694cfaafa ("usb: gadget: ncm: Handle decoding of multiple NTB's in unwrap call")
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
>>
>> PS: Although this issue was seen after CDC_NCM_NTB_DEF_SIZE_TX
>> was modified to 64K on host side, I still believe this
>> can come up at any time as per the spec. Also I assumed
>> that the giveback where block length is zero, has only
>> one NTB and not multiple ones.
>>
>>   drivers/usb/gadget/function/f_ncm.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
>> index e2a059cfda2c..355e370e5140 100644
>> --- a/drivers/usb/gadget/function/f_ncm.c
>> +++ b/drivers/usb/gadget/function/f_ncm.c
>> @@ -1337,6 +1337,9 @@ static int ncm_unwrap_ntb(struct gether *port,
>>          VDBG(port->func.config->cdev,
>>               "Parsed NTB with %d frames\n", dgram_counter);
>>
>> +       if (block_len == 0)
>> +               goto done;
>> +
>>          to_process -= block_len;
>>
>>          /*
>> @@ -1351,6 +1354,7 @@ static int ncm_unwrap_ntb(struct gether *port,
>>                  goto parse_ntb;
>>          }
>>
>> +done:
>>          dev_consume_skb_any(skb);
>>
>>          return 0;
>> --
>> 2.34.1
>>
> 
> In general this is of course fine (though see Greg's auto-complaint).
> 
> I haven't thought too much about this, but I just wonder whether the
> check for block_len == 0
> shouldn't be just after block_len is read, ie. somewhere just after:
> 
> block_len = get_ncm(&tmp, opts->block_length);
> 
> as it is kind of weird to be handling block_len == 0 at the point where
> you are already theoretically done processing the block...
> 
> I guess, as is, this assumes the block isn't actually of length 0,
> since there's a bunch of following get_ncm() calls...
> Are those guaranteed to be valid?
> 

I did get this doubt and tried it. I bailed out as soon as I found out 
block len is zero without actually processing the datagrams present and 
when I did that even ping doesn't work. Everything works only when the 
datagrams in this zero block len NTB are parsed properly.

> I guess I don't actually see the infinite loop with block_len == 0,
> since get_ncm() always moves us forward...
> 

The infinite loop occurs because we keep moving the buffer pointer 
forward and keep processing the giveback until to_process variable 
becomes zero or one. In case block length is zero, we never move the 
buffer pointer forward and never reduce to_process variable and hence 
keep infinitely processing the same NTB over and over again.

> Maybe your patch *is* correct as is, and you just need a comment
> explaining *why* block_len == 0 is terminal at the spot you're adding the check.
> 
> Also couldn't you fix this without goto, by changing
> 
>    } else if (to_process > 0) {
> to
>    } else if (to_process && block_len) {
>      // See NCM spec.  zero block_len means short packet.
> 

I will test this out once (although I know that looking at it, it would 
definitely work) and send v2 with this diff.

Thanks for the review.

Regards,
Krishna,


Return-Path: <linux-kernel+bounces-101122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FE787A2B3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 06:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 805E4282E1A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 05:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEE9134B7;
	Wed, 13 Mar 2024 05:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WzkxPoay"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363EE8495;
	Wed, 13 Mar 2024 05:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710307982; cv=none; b=BlIWRbqe9M8Zi190vUcmEOuiFW8Q9icWEWpUQKawZjKGrrUq2JaMU526uqf9/2NnGNPakRx+UrvSSuQP6m5uiSMUu/+sWO7Kc0528VoNPNwVRQ55wpPe7wxTj+sh2omhzm4pgzNTcQnBLB+En7rNd4R8yM4Hj6OgaLUFgOlQRFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710307982; c=relaxed/simple;
	bh=WpWEtgxvWQtwicuZDouwiTQ/0K6lqQ5dGDujlyQm6Vw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=dcFW7OGdSJds34g+FPhTxyusIXSGEVVrd/OFYFRmNgwtV69ugG2plfF6ar+TwZSDIRh8jHQbakjAJqqGUU61fP8G3WTZIn0lUzKIUkEz89YidHN74A2YNi8m1FrXsxGKzxy5vpra1vZUYmFcEtJFIG6WGhjHjN3LC62C2OzVdaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WzkxPoay; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42D4xZMW011563;
	Wed, 13 Mar 2024 05:32:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=CUK9aHL4Poax07Aaff/Rcqwy3Sb4I0NsaB4STP9xUWY=; b=Wz
	kxPoayQ0vvDcVDciB7NF3pHDuZ+uHUhX7bxuby2wdJ8G/o5RRK3DMTyz++ginm92
	EwSIpjmEsRyhfvJ2N1Mw7rqXZFSFEU57j77sVIiCQCcSKTfqW8dAlmlTJSCzoonV
	Se1EhrCiQq65WYrFOJ1KboAGhBFl5NwgR/K+mT3crtuGvi0sam8aFUt0aPiGRy30
	egkTH/st9sMymywSSUEaPhYgmI/1+8ttnFTtqTm+QeGWfZkE698YIDhNnY2k3gQv
	gCnPQfl6xQy33V8ZSwzw1TC3T7eyGruNWm3FoQDPJeW0vYUBPoqy7uHQW9Lrjhkt
	H5llvxRG7ML1yKutBQJg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wu2j38b8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 05:32:33 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42D5WW1q025340
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 05:32:32 GMT
Received: from [10.110.34.216] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 12 Mar
 2024 22:32:28 -0700
Message-ID: <8128f2e0-f954-4391-b3c3-f20e2e8961f6@quicinc.com>
Date: Tue, 12 Mar 2024 22:32:27 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4] net: Re-use and set mono_delivery_time bit
 for userspace tstamp packets
Content-Language: en-US
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
To: Martin KaFai Lau <martin.lau@linux.dev>,
        Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>
CC: <kernel@quicinc.com>, "David S. Miller" <davem@davemloft.net>,
        "Eric
 Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        "Martin
 KaFai Lau" <martin.lau@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel
 Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii
 Nakryiko <andrii@kernel.org>
References: <20240301201348.2815102-1-quic_abchauha@quicinc.com>
 <2a4cb416-5d95-459d-8c1c-3fb225240363@linux.dev>
 <56499130-765d-464a-810c-45b19490986b@quicinc.com>
In-Reply-To: <56499130-765d-464a-810c-45b19490986b@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tmzZCcpetsJZhzxMh99DS-959NlpZ3L7
X-Proofpoint-GUID: tmzZCcpetsJZhzxMh99DS-959NlpZ3L7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_05,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015 phishscore=0
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403130040



On 3/12/2024 9:34 PM, Abhishek Chauhan (ABC) wrote:
> 
> 
> On 3/12/2024 4:52 PM, Martin KaFai Lau wrote:
>> On 3/1/24 12:13 PM, Abhishek Chauhan wrote:
>>> Bridge driver today has no support to forward the userspace timestamp
>>> packets and ends up resetting the timestamp. ETF qdisc checks the
>>> packet coming from userspace and encounters to be 0 thereby dropping
>>> time sensitive packets. These changes will allow userspace timestamps
>>> packets to be forwarded from the bridge to NIC drivers.
>>>
>>> Setting the same bit (mono_delivery_time) to avoid dropping of
>>> userspace tstamp packets in the forwarding path.
>>>
>>> Existing functionality of mono_delivery_time remains unaltered here,
>>> instead just extended with userspace tstamp support for bridge
>>> forwarding path.
>>
>> The patch currently broke the bpf selftest test_tc_dtime: https://github.com/kernel-patches/bpf/actions/runs/8242487344/job/22541746675
>>
>> In particular, there is a uapi field __sk_buff->tstamp_type which currently has BPF_SKB_TSTAMP_DELIVERY_MONO to mean skb->tstamp has the MONO "delivery" time. BPF_SKB_TSTAMP_UNSPEC means everything else (this could be a rx timestamp at ingress or a delivery time set by user space).
>>
>> __sk_buff->tstamp_type depends on skb->mono_delivery_time which does not necessarily mean mono after this patch. I thought about fixing it on the bpf side such that reading __sk_buff->tstamp_type only returns BPF_SKB_TSTAMP_DELIVERY_MONO when the skb->mono_delivery_time is set and skb->sk is IPPROTO_TCP. However, it won't work because of bpf_skb_set_tstamp().
>>
>> There is a bpf helper, bpf_skb_set_tstamp(skb, tstamp, BPF_SKB_TSTAMP_DELIVERY_MONO). This helper changes both the skb->tstamp and the skb->mono_delivery_time. The expectation is this could change skb->tstamp in the ingress skb and redirect to egress sch_fq. It could also set a mono time to skb->tstamp where the udp sk->sk_clockid may not be necessary in mono and then bpf_redirect to egress sch_fq. When bpf_skb_set_tstamp(skb, tstamp, BPF_SKB_TSTAMP_DELIVERY_MONO) succeeds, reading __sk_buff->tstamp_type expects BPF_SKB_TSTAMP_DELIVERY_MONO also.
>>
>> I ran out of idea to solve this uapi breakage.
>>
>> I am afraid it may need to go back to v1 idea and use another bit (user_delivery_time) in the skb.
>>
> I am okay to switch back to version 1 of this patch by adding another bit called userspace_time_stamp as that was the initial intent. 
> 
> Martin what do you suggest ? 
Sorry i meant Willem. 

Willem do we want to fall back to version 1 where we add an extra bit for userspace timestamp as Martin is facing some issue in one of his test case. 




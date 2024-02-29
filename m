Return-Path: <linux-kernel+bounces-87662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C42B186D731
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65F97B21F2A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F2574BE2;
	Thu, 29 Feb 2024 23:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nfw5eBDG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7317C200CD;
	Thu, 29 Feb 2024 23:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709247628; cv=none; b=dYd9PIlQmBe0Y16K8Sw9UdXs7sBva09dydTTQZoJo5KQhUFvpxv7rW1fYrUuwSRyxs89aX3Muut/LQJbapYB0O+JOWfWh0jQFeKqOt8oOjvt+qvO/LuzyIyFGBI3FtqpZQCQqfrSq+OAJFA5rPNzghkKK3euRyrcgIW3fZzmNtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709247628; c=relaxed/simple;
	bh=PoNIxmnJHRRgEhOxi7tGjD/dtTQDBn0MUVpRUv8myvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VcpyO3EAF+Z5m2XSIHwRRSljwXRefKLw+tBXMLiJyW65GZ+2WYB6U5jxssQpL46x35Nbt5yyU+LZo4Vle8oPa3O7+gk02axYUo1zHr5+//qAOaqVfw9dvrpoebucUo7nqRrqQtSa4yUl/0bm7N5WVakpHBYY5m2Mz26pkBN+k24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nfw5eBDG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41TMOfqJ032243;
	Thu, 29 Feb 2024 23:00:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=nAX1GMyutv4zzIGKSW+39r5Aqmt8/Op+fXDeKMORlM8=; b=nf
	w5eBDGjo7E4TzprCxno+iZP8JCoLKjvTNx4x23fnIhySnHMqOw6ipFj9mdWH3T0m
	bLiQlnGZ7fat/3PVOOlj6BB6AKlBg0derFt0A+vAxBE0OdxBGXRlOL7R5u1veE0b
	bZN9QXjWTUIVMuD97+Mb7L6pbbEPJmem23n5JAdACIzuthZpapE7uOA8tm4oOBT4
	qJneZNeyxS2x4hvZlftjTN11WYijV7qdt9Jj+2olEWZhqHiK+HHqc2XMGmDlpLvf
	ua6vUh+hhIY43AqAlR8tuRK9AotIPqYkHV0bWbCys/WpHVeNMIcUY8gYqqSVAj1S
	eIOP3r3mRenY+Wfbj6fA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wjmwnasg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 23:00:10 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41TN09jx021096
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 23:00:09 GMT
Received: from [10.46.19.239] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 29 Feb
 2024 15:00:05 -0800
Message-ID: <3fc38c28-27b0-4903-9ede-a95237c7bd3c@quicinc.com>
Date: Thu, 29 Feb 2024 15:00:04 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: Modify mono_delivery_time with
 clockid_delivery_time
Content-Language: en-US
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Martin KaFai Lau
	<martin.lau@linux.dev>
CC: <kernel@quicinc.com>, "David S. Miller" <davem@davemloft.net>,
        "Eric
 Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        "Martin
 KaFai Lau" <martin.lau@kernel.org>
References: <20240228011219.1119105-1-quic_abchauha@quicinc.com>
 <65df56f6ba002_7162829435@willemb.c.googlers.com.notmuch>
 <cfd6d590-2bf0-45df-97a4-f9359b5d454b@linux.dev>
 <65e098566b4c3_d40e329486@willemb.c.googlers.com.notmuch>
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <65e098566b4c3_d40e329486@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: F546IhjVvW7JhxePm8ncU89fUsw1u22A
X-Proofpoint-ORIG-GUID: F546IhjVvW7JhxePm8ncU89fUsw1u22A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_06,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 clxscore=1015 bulkscore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402290180



On 2/29/2024 6:44 AM, Willem de Bruijn wrote:
> Martin KaFai Lau wrote:
>> On 2/28/24 7:53 AM, Willem de Bruijn wrote:
>>> Sidenote: with sk_clockid, FQ could detect when skb->tstamp is not
>>> set in monotonic (i.e., set by SO_TXTIME) and drop the packet or
>>> ignore the embedded timestamp, warn, etc.
>>
>> Thanks for cc-ing me. Sorry for the late reply. I just catch up to this thread 
>> and the v1.
>>
>> I think it is needed to detect if skb->tstamp is monotonic or not in fq. The 
>> container (with the veth setup) may use sch_etf while the host usually uses fq 
>> at the physical NIC and expects monotonic skb->tstamp.
>>
>> During forward (e.g. by bpf_redirect / ip[6]_forward from a veth to a physical 
>> NIC), skb_clear_tstamp() only forwards the monotonic skb->tstamp now. While 
>> sch_etf does check sk_clockid first before using skb->tstamp, fq does not check 
>> that now.
>> or fq_packet_beyond_horizon() is enough to catch this clock discrepancy?
> 
> Before your patch, I believe FQ had no such guard rails. An skb with
> any clockid from SO_TXTIME can arrive at FQ.
> 
> With the new clockid field, we could add guard rails in fq_enqueue.
> If the bit is set, look up sk_clockid.
> 

I agree with Willem here. Just how Sch_etf is doing in the validate_input_params 
function , it checks for qopt->clockid != CLOCK_TAI  and also in validate packet
its checking if the q->clockid and the skb->clockid are the same. Only then it 
proceeds to XMIT the packet. 
Such Guards can be added in FQ as well. 

I believe this is some optimization which can be done in future which is not in 
scope of this current problem (correct me if i am wrong). 

The main issue with bridge forwarding path which anyone using latest kernel would 
face is all ETF packets will be dropped since only monotonic tstamps are forwarded
and ETF uses TAI clocks . Hence my v3 patch would be helpful to solve the problem. 
Later we can take up the optimization part to add Guard checks in the FQ as well as
a seperate patch. 

> 
> 


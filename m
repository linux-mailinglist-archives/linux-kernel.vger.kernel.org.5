Return-Path: <linux-kernel+bounces-50204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B857E8475B9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAFE31C218CD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD5A14AD24;
	Fri,  2 Feb 2024 17:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="j43xr1XA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC704148FFE;
	Fri,  2 Feb 2024 17:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706893597; cv=none; b=sIbzLD35EZGXcxYiD9+uiMh7meOvjo8C47PL7dK5Ae4TiXmZv/G0KgYnKm+aD195YI3Wojs9c0xc4vgXG13mgnHK6qbvGhc/GWPQcUU57AcuYjIvcI/AQQmxsfsDIyxWXkEW7dxQapElgHbEMMEvRCbSNE7oV7RuHV74BB5fo/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706893597; c=relaxed/simple;
	bh=fXYcVQeS1rnoov7pNUybIB+0ltad7FRtsKISdkiMkms=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tUW2WIIJyoKNlmZuHhYkEzPK0T0LVr3gxa1n2wApKmDEmVy3q8QNpztz1YMcGWtx/NqxoEb0IVDsiyVouAgRCYEEgCdL1acqqfpZnw8FptvseHwcSnY32dt9NVUsdtw07zwNsWL0tK93wOoG4QFhvJFJ3nck4dUPFqcKlVJry90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=j43xr1XA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 412FZrFt008756;
	Fri, 2 Feb 2024 17:06:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=RCAsEbay9473oUiUhfGKQgYpSlUN+6hO6gJH1qP/hb8=; b=j4
	3xr1XAY38rAHXhQV7n9Eren5GYY+sjmR2p/l/6xLJJS5KuD0p9OYOSnT1LGlnUIy
	nblqLBVWYpWkDP5pOuZWyxoCW2PmDErB+EisG0d8fN7ct2l4AirpoCD/N0e9BFfg
	bmRnsF89ebP8JCM/9Zan/5Z/fjTj3jC2gs1zYEwcupaW96NaJfBZAfW256fRwMiM
	0usxEwDB0SGFmEf52VatwtwAYgv9JrnOKEX38fxER35x/zvbO/cHcHHpJ9Ct91W3
	/zjonCcVxKGv5qBtrrxt9GZnFzXnOBIFSZxjW9JmjiQNQXVjUn/KfpNAJbbQxwkj
	Z8QRkCtfvDPiip+m0LxA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0ptv1xxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 17:06:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 412H6Lj9015815
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 17:06:21 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 2 Feb
 2024 09:06:20 -0800
Message-ID: <66c4830d-8756-3ade-c8ec-af2b334b24e3@quicinc.com>
Date: Fri, 2 Feb 2024 10:06:20 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] Documentation: embargoed-hardware-issues.rst: Fix
 Trilok's email
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
CC: <corbet@lwn.net>, <carlos.bilbao@amd.com>, <avadhut.naik@amd.com>,
        <alexs@kernel.org>, <iyanteng@loongson.cn>,
        <2023002089@link.tyut.edu.cn>, <quic_bjorande@quicinc.com>,
        <quic_tsoni@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <workflows@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240202164119.4090703-1-quic_jhugo@quicinc.com>
 <2024020223-eskimo-armoire-a517@gregkh>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <2024020223-eskimo-armoire-a517@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pwsWqSHmhUhzy7kUdblznhzZ29PxIBSI
X-Proofpoint-GUID: pwsWqSHmhUhzy7kUdblznhzZ29PxIBSI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 clxscore=1011 spamscore=0 phishscore=0 adultscore=0
 mlxscore=0 mlxlogscore=720 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020122

On 2/2/2024 9:48 AM, Greg KH wrote:
> On Fri, Feb 02, 2024 at 09:41:19AM -0700, Jeffrey Hugo wrote:
>> The servers for the @codeaurora domain have long been retired and any
>> messages addressed to @codeaurora will bounce.
>>
>> Trilok has an entry in .mailmap, but the raw documentation files still
>> list an old @codeaurora address.  Update the address in the
>> documentation files for anyone reading them.
>>
>> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
>> ---
>>   Documentation/process/embargoed-hardware-issues.rst             | 2 +-
>>   .../translations/sp_SP/process/embargoed-hardware-issues.rst    | 2 +-
>>   .../translations/zh_CN/process/embargoed-hardware-issues.rst    | 2 +-
>>   .../translations/zh_TW/process/embargoed-hardware-issues.rst    | 2 +-
>>   4 files changed, 4 insertions(+), 4 deletions(-)
> 
> I think we need an ack from Trilok for this :)

That is fair.  I expect Trilok will see this in the next day or so, and 
respond.

-Jeff


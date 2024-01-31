Return-Path: <linux-kernel+bounces-45614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81267843308
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4FE91C24DD0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07D54C90;
	Wed, 31 Jan 2024 01:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YBai7MRf"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F57DF4F;
	Wed, 31 Jan 2024 01:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706665988; cv=none; b=IJ+5QCZ0ZgwaS1Lfe9epcOC7pXDpK8+6D+Dt18j+zUhMr3Ypprr14ZGFkaoaB8kZ4YJdbt2Si9fEa8H2WBRt9yUxnurk5Lhm0yAm4Hc3vV8BX7txD7sDi4maJj4PVqpuwmy13ANq+MXi6f53uRpBWcmg7VQkYbCaYHiMjWYXV4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706665988; c=relaxed/simple;
	bh=1p5Z7Z9TVo1PQ3bqISL9xHz1q+pUeZaefmjz13XJP8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cSYLF3NoShoJk02my2n97BHfmatQTou3v1cwgVkzUUOp0vynv6Volwlx/Rch/NhSR0NZoLCat9tcqF0IKDJ8e8ipS259MSZabUt8tUfEj2ev2RtxcCmxFxDEgfA8R05s7NeJmBdAx3aXfUrfqRJS40OKNJL/dkSMepO8QvjtqL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YBai7MRf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40V0em45019320;
	Wed, 31 Jan 2024 01:53:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=3kpgfpypCR5T+As4pLy7omFzhP8Eh3qCmLdqkM1YErI=; b=YB
	ai7MRfwbBlMqTCW6/vR50N/3F/jAQAWeJ4zT15ZHdxv+txHHvTuWdC565v69y/Dk
	/F1u8EItFfCSBxUAzi/WSO0UBuKcMcIXl3ldH58Qowbz67/MtNkUVAmkm//aalyF
	KtCAK7R6pbZtyIPrQAooDdkEVGTJTPsTpW2KPCXGQtVEHaUmhxugBbWGjtd6g3mi
	rJ+8ZZEsfvdRmGjTZ0R4CsTaQkncxZElw+dWZ1VZehxFmqDzkyz4BmbxKa1ob8nX
	82PFtpY0yGpq1Zsj4Q7O/xsHJgD29Xwdhg/SEfnfa840ZKIjYlniCoGZGGXtXp6x
	WRmebkJjs/CY6Yv1+sjQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vyb0cr65v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 01:53:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40V1r2hv022524
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 01:53:02 GMT
Received: from [10.216.5.224] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 30 Jan
 2024 17:52:57 -0800
Message-ID: <13703200-af1a-4776-98b2-b9a7261de2e6@quicinc.com>
Date: Wed, 31 Jan 2024 07:22:54 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v9] bus: mhi: host: Add tracing support
Content-Language: en-US
To: Manivannan Sadhasivam <mani@kernel.org>,
        Steven Rostedt
	<rostedt@goodmis.org>
CC: Masami Hiramatsu <mhiramat@kernel.org>, <linux-kernel@vger.kernel.org>,
        <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_parass@quicinc.com>
References: <20240105-ftrace_support-v9-1-a2dca64cc6ea@quicinc.com>
 <20240130081152.GH32821@thinkpad>
 <20240130092252.32801387@gandalf.local.home> <20240130182654.GD4218@thinkpad>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20240130182654.GD4218@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: B8HBQxFko_uoW8v6Lt28E8DMKDMqa_3S
X-Proofpoint-ORIG-GUID: B8HBQxFko_uoW8v6Lt28E8DMKDMqa_3S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_14,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxlogscore=766
 mlxscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401310014



On 1/30/2024 11:56 PM, Manivannan Sadhasivam wrote:
> On Tue, Jan 30, 2024 at 09:22:52AM -0500, Steven Rostedt wrote:
>> On Tue, 30 Jan 2024 13:41:52 +0530
>> Manivannan Sadhasivam <mani@kernel.org> wrote:
>>
>>> So same trace will get printed for both mhi_channel_command_start() and
>>> mhi_channel_command_end()?
>>
>> The trace output will also include the tracepoint name. That is, it will
>> have the same content but will be preceded with:
>>
>>    mhi_channel_command_start: ...
>>    mhi_channel_command_end: ...
>>
> 
> Yes, but the message will be the same:
> 
> mhi_channel_command_start: chan%d: Updating state to:
> mhi_channel_command_end: chan%d: Updating state to:
> 
> Either only one of the trace should be present or the second one should print,
> "mhi_channel_command_end: chan%d: Updated state to:"
> 
> - Mani
>
I will try to pass a string to updated for mhi_channel_command_end &
updating for mhi_channel_command_start in my next patch.

- Krishna Chaitanya.



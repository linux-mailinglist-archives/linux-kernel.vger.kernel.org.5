Return-Path: <linux-kernel+bounces-104465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B21F87CE4A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D461F282D5C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDEC364CB;
	Fri, 15 Mar 2024 13:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bv3kzEJ8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7741125543;
	Fri, 15 Mar 2024 13:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710510681; cv=none; b=WV1C1x0CXPj2kQsisTdSHDkh0vwDcPOT53IadHwYDS5tigdklHqScmwUAd8QI+cqvR/yFPv2ym/A0Qr/IrED7V2PQdoKhR/FuZjJ3tKbm/u3Slmk3pjL/XPhfuYfHMGFn10RNOVc1JFCUOUmO/pes3Yihnu8RtrP1mZrT5jJo8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710510681; c=relaxed/simple;
	bh=p9nfuwsmcRjGIUk/kd4Km59ic4MQQRfoqdXeV93cCjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=P54s0iV9MvlQvHG4a5nODWBU4iXuTVWhWJx88+tG4whhoExXnXzzEx8Zf9aZwEklwo6kA6RbyJ1cZY/uGRnqvyAi2Edks715bumDto+Numgq4fEe4zX2mohr59uGuhRn48QerLHITSQPFhZnCSjlm3EReclk5JvaMdhIXPfIsqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bv3kzEJ8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42FCQwtM010932;
	Fri, 15 Mar 2024 13:51:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=9XCg5qCbqvn1p4u4ZCea/hGFfPeFn7ivbL9Yrof0Yjk=; b=bv
	3kzEJ8HHe9OsxF2galQi9FVjLhj5YRJmdv7yhe2w6tYilo1XpKQ5UhET+oVmtyV/
	PsBq86c6iORH/UtW428j+7dt7B4/2/GDlERXDXeN4S2kMpXtRdeqZ4ecE+u831R8
	UcshNM5cvxsZvDLUdnRSRc/SqgJ7FBQyuTcmqPs/kaV0kzrrIuPPuvdzryGX31U9
	AIPBk+1WFI6cgibJw2ko6WPlXTL7KGmakAbEQuoDZKaR41cbySx7uSAfY0xWVnO2
	Rl6WRnVDP9oFLLomsj7PYDOyLQVXv17tBrCBxZIllrogHNxrbHbmhhdcaFeiI16q
	l6tJe4MlLlb+lmEdUKqQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wv9yq1a6j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 13:51:13 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42FDpCn1005806
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 13:51:12 GMT
Received: from [10.216.49.62] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 15 Mar
 2024 06:51:06 -0700
Message-ID: <fda6a365-5fda-503a-0c33-306deac8193d@quicinc.com>
Date: Fri, 15 Mar 2024 19:21:03 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 00/34] Qualcomm video encoder and decoder driver
Content-Language: en-US
To: Hans Verkuil <hverkuil@xs4all.nl>, Hans Verkuil <hans.verkuil@cisco.com>,
        <mchehab@kernel.org>, <stanimir.k.varbanov@gmail.com>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <bryan.odonoghue@linaro.org>, <agross@kernel.org>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <quic_abhinavk@quicinc.com>,
        "Dikshita
 Agarwal" <quic_dikshita@quicinc.com>
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
 <8bf182b1-e05f-0c90-a358-e5c8bf6bd430@quicinc.com>
 <d49012ae-4e67-47d0-8e1b-7b0c4b118f7e@xs4all.nl>
From: Vikash Garodia <quic_vgarodia@quicinc.com>
In-Reply-To: <d49012ae-4e67-47d0-8e1b-7b0c4b118f7e@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9QUSEXGPL_DcUuHKYplcpge--ZkFyvny
X-Proofpoint-ORIG-GUID: 9QUSEXGPL_DcUuHKYplcpge--ZkFyvny
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-15_01,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1011 mlxscore=0
 phishscore=0 impostorscore=0 malwarescore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403140001
 definitions=main-2403150111

Hi Hans,

On 3/12/2024 4:07 PM, Hans Verkuil wrote:
> Hi Vikash,
> 
> On 2/29/24 16:09, Vikash Garodia wrote:
>> Hello All,
>>
>> On 12/18/2023 5:01 PM, Dikshita Agarwal wrote:
>>> This patch series introduces support for Qualcomm new video acceleration
>>> hardware architecture, used for video stream decoding/encoding. This driver
>>> is based on new communication protocol between video hardware and application
>>> processor.
>>> This driver comes with below capabilities:
>>> - V4L2 complaint video driver with M2M and STREAMING capability.
>>> - Supports H264, H265, VP9 decoders.
>>> - Supports H264, H265 encoders.
>>> This driver comes with below features:
>>> - Centralized resource and memory management.
>>> - Centralized management of core and instance states.
>>> - Defines platform specific capabilities and features. As a results, it provides
>>>   a single point of control to enable/disable a given feature depending on 
>>>   specific platform capabilities.
>>> - Handles hardware interdependent configurations. For a given configuration from
>>>   client, the driver checks for hardware dependent configuration/s and updates
>>>   the same.
>>> - Handles multiple complex video scenarios involving state transitions - DRC,
>>>   Drain, Seek, back to back DRC, DRC during Drain sequence, DRC during Seek
>>>   sequence.
>>> - Introduces a flexible way for driver to subscribe for any property with
>>>   hardware. Hardware would inform driver with those subscribed property with any
>>>   change in value.
>>> - Introduces performance (clock and bus) model based on new hardware
>>>   architecture.
>>> - Introduces multi thread safe design to handle communication between client and
>>>   hardware.
>>> - Adapts encoder quality improvements available in new hardware architecture.
>>> - Implements asynchronous communication with hardware to achieve better
>>>   experience in low latency usecases.
>>> - Supports multi stage hardware architecture for encode/decode.
>>> - Output and capture planes are controlled independently. Thereby providing a
>>>   way to reconfigure individual plane.
>>> - Hardware packetization layer supports synchronization between configuration
>>>   packet and data packet.
>>> - Introduces a flexibility to receive a hardware response for a given command
>>>   packet.
>>> - Native hardware support of LAST flag which is mandatory to align with port
>>>   reconfiguration and DRAIN sequence as per V4L guidelines.
>>> - Native hardware support for drain sequence.
>>
>> 1. We considered enhancing the venus driver to support iris functionality but
>> concluded that the result would essentially be two parallel drivers implemented
>> in the same folder.
>> 2. Although the underlying hardware for venus and iris are quite similar, but
>> there are other factors which brings the need of new driver:
>>    a. the host firmware interface (HFI) changed between the two. Venus supports
>> HFI protocol 1.0 while iris supports HFI protocol 2.0.
>>    b. unlike HFI protocol 1.0, HFI protocol 2.0 is better aligned to V4L2 APIs.
>>    c. iris driver modularize platforms, hardware variants, and states to extend
>> it for any upcoming SOC. Thereby more extendable to newer SOCs in future.
>>    d. Iris also supports many advanced features.
>> 3. Based on the comments received on posted iris driver [1], we evaluated it
>> further and to better align with the upstream standard and practices, we
>> acknowledge that even though iris driver is the way forward, it would be ideal
>> to bring in the Venus hardwares enabled in this driver.
>> 4. Hence, we decided to rework iris driver to add support of HFI protocol 1.0 as
>> well.
>> 5. Initially we would start with adding support for one HFI protocol 1.0 based
>> platform which would be SM8250.
>> 6. SM8250 enablement on iris driver would be incremental, starting with basic
>> decode for H264 codec.
>> 7. In long-term, all venus supported platforms would be migrated to iris.
>> 8. Iris driver and venus driver will co-exist till remaining supported targets
>> also gets migrated to iris driver.
>> 9. We would continue to support and maintain venus driver during this phased out
>> approach.
>>
>> Please share your thoughts on the above proposal.
> 
> I think this is a reasonable approach: the venus driver is quite old and it was
> created when we were at more-or-less the same time also developing better codec
> frameworks. So it is not quite up-to-date with all the latest requirements.
> 
> Starting with a clean slate for the iris driver and then add support for venus
> platforms to the iris driver makes sense.
Appreciate your time to review the proposal.
> 
> Just one serious concern: who will do the venus platform migration? Are there resources
> available to do that work? Or is this just wishful thinking?
To initiate the venus platform migration, iris driver would be enabled with all
SOCs under HFI_V6XX which are currently supported in venus driver. In doing so,
iris driver, posted earlier [1] is being reworked to have cleaner abstraction to
invoke HFI 1.0 protocol (venus variants) and would be applicable for all venus
platforms. With this, remaining platform migration would be done with some
incremental efforts (platform specific handling).
We would like to get help from community and co-work in enabling the migration
for remaining venus platforms in a phased out approach.

Regards,
Vikash

[1]
https://patchwork.kernel.org/project/linux-media/cover/1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com/#25643473



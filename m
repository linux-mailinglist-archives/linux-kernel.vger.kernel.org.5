Return-Path: <linux-kernel+bounces-153447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D31F8ACE39
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EFA71C208EA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A4F14F9EA;
	Mon, 22 Apr 2024 13:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NW+4zOBF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2137314F9D8;
	Mon, 22 Apr 2024 13:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713792641; cv=none; b=bhdP9ug1jECsU6jC0zcEhOMalxqVQ9A9Ipo14UzkFSKr3t5UdZ/sP7Jh1jTbnMdW4xBk858KWCgSZWCggSDH3O5WcRYhwntKNFkqf3GNs7GjNpMU3yMPSPeXgAiV2F9ADY0nWc1vCv9Z0QQXMj4mks/wHMVPRFeZ4ir0rqWi9H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713792641; c=relaxed/simple;
	bh=80XyKnDG2Nf34xdov5EOK0858CPsMNShcNBV+Wl6PQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LgE4qKhbvdi45Rl7IEI4lKNml2rNiihNCdc2teCSLAmrxctMgk4rUr6nbYXuTkxB8JTpItTrT+GefIfvzbPBch/zwxDYbGtRh5BpysQCYkvWeD4xjY/AaDnxwDfCidnu22NO+Nbx9n0AP5mdFLubzNpcs8nXW5rQMWDzyKMcLq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NW+4zOBF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43MCs3G1025571;
	Mon, 22 Apr 2024 13:30:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=yQisXE2HKjlAcDyvQqLJUCZNJjwoAktg2wxvy0kAB2g=; b=NW
	+4zOBFYJf0Wc1jddIYjBQU8YueU0WKjEb/ZF778oKP9OsOsxaIngykY2Za24NaT2
	Yp09v7N/Oz98IWwxLPG6cjhvo6eOGZ8LMQdN3INAuXrgtY5lFW+RA5x5c+80E+it
	2oWFHAAFFLlf2LnheA9BbQor04kZwjaXPA8H7kKZvO2JeTdYjVk1tdVbJJzIWrgY
	H9q2V79k/RepT6gWzyMrkcI9hdlEZO9u7SCH2Yrw0A+S+C9ce6hAObENeocnw/AY
	0pk6Ihn4UCt5VkLP/CckqgZkcOO+Ei7IM5HJXNQmC604SmksJ/pVN/rTwJDvfToH
	tabDESx0wp5SuTyVC6Pw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xnn82gm0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 13:30:33 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43MDUWrH023311
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 13:30:32 GMT
Received: from [10.253.37.80] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 22 Apr
 2024 06:30:30 -0700
Message-ID: <472b9f60-d68e-47ee-9ca9-f71a9ba86a1a@quicinc.com>
Date: Mon, 22 Apr 2024 21:30:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Bluetooth: qca: fix NULL-deref on non-serdev setup
To: Johan Hovold <johan@kernel.org>
CC: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann
	<marcel@holtmann.org>,
        Zhengping Jiang <jiangzp@google.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240319154611.2492-1-johan+linaro@kernel.org>
 <ZiZdag8fw8H1haCb@hovoldconsulting.com>
 <438844e9-47e8-486e-9611-ae524d6974b3@quicinc.com>
 <ZiZkK4BAoqxNg7yG@hovoldconsulting.com>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <ZiZkK4BAoqxNg7yG@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JMnDm1WdbEwPcqYv0ANrMDHnqxVTMY32
X-Proofpoint-ORIG-GUID: JMnDm1WdbEwPcqYv0ANrMDHnqxVTMY32
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0 phishscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220059

On 4/22/2024 9:20 PM, Johan Hovold wrote:
> On Mon, Apr 22, 2024 at 09:04:58PM +0800, quic_zijuhu wrote:
>> On 4/22/2024 8:51 PM, Johan Hovold wrote:
>>> On Tue, Mar 19, 2024 at 04:46:09PM +0100, Johan Hovold wrote:
> 
>>>> Johan Hovold (2):
>>>>   Bluetooth: qca: fix NULL-deref on non-serdev suspend
>>>>   Bluetooth: qca: fix NULL-deref on non-serdev setup
>>>
>>> Could you pick these up for 6.9 or 6.10?
>>>
>>> The patches are marked for stable backport and only privileged users can
>>> set the N_HCI line discipline these days (even if I'm not sure about
>>> pre-5.14 kernels...) so it may be fine to wait for 6.10 if you prefer.
> 
>> could you share the patch links for me to review. i can
>> 't find them now
> 
> Sure, but you should bookmark lore.kernel.org in your browser as you can
> search the archives there yourself:
> 
> 	https://lore.kernel.org/lkml/20240319154611.2492-1-johan+linaro@kernel.org/
> 
> Johan
NAK for your [PATCH 1/2] since the null checking is redundant with your
[PATCH 2/2].
NAK for your [PATCH 2/2], since it is same with my earlier fix
https://lore.kernel.org/all/1704960978-5437-1-git-send-email-quic_zijuhu@quicinc.com/
my new patchset for btattach tool still has this change.




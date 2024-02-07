Return-Path: <linux-kernel+bounces-56154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 929EE84C6BF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEE0E1C2190F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B4B208D5;
	Wed,  7 Feb 2024 08:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XH0+mwju"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F2A200A8;
	Wed,  7 Feb 2024 08:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707296247; cv=none; b=kP7FFb9U9eW7qWauGzUZlUQjALTSKYwFGyrTf+gehC04aaazh5vx2vGRMVoosf7TjV72Z0FZwPZhVbqo+9y9RDHhWuIsCzM0mrGrFv+dtCP6gpw4d0rUdZzqJex2PVxpt4mbaHf8Q0qLLgUjORvV5Doud600/ezWJPmSKXwJqGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707296247; c=relaxed/simple;
	bh=dtxrc2rAMyKVPz/unNsYEeFvD+b+Jdpn1j6aMu+PtME=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CfgxptfLyyfLD+PVRKydwWUNioWOLW3MmvbUSC/vhv9SN5Uka++KBctvEPeeiJiXc1TWI9QwVx8HvkcT7nInu1L3uSE+NFutsBkZ+8m563TwDV8yzM9SyhTFtIt7lBw6hJdFEKsQvkZOtND/McOiTHPBHvYG89N4bn0w76fxJPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XH0+mwju; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4178cQao024425;
	Wed, 7 Feb 2024 08:57:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=dtxrc2rAMyKVPz/unNsYEeFvD+b+Jdpn1j6aMu+PtME=; b=XH
	0+mwju/F7nYHyG6SFbSVzgBZ/2hILnayCqo3ijqgor1AAUhndXuZqIiEMxBxvEC2
	7dLf5OGqLyaG5o2KiPeX34Uly+SOZOF93GjJt+Un/V+3fKk4t8UWL1W5jklFZpSd
	8a0QcQyiuj6bYEA0U7rltMw04Zuhz0qlO3DMAat1tLOTzQzSjr69gg8y0G/LRhHU
	0huQqGTauohbUfXzmwdGgubB5gJEii2iUQbzxnS2naA1u6HA0ItSZRqabop7VMrQ
	2OA6qKi5XpRvHPxro6Ey60wl80bIM2+h2yTUe6z8vHi5bciSA3HBk0BkscQTtCLi
	68HRgVkImDkhpgj54fwA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w42earh06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 08:57:21 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4178vLNb025439
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 7 Feb 2024 08:57:21 GMT
Received: from [10.204.67.150] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 7 Feb
 2024 00:57:19 -0800
Message-ID: <a2c5e594-f485-4510-84ba-6cd022c4c774@quicinc.com>
Date: Wed, 7 Feb 2024 14:27:16 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/16] misc: fastrpc: Add support for unsigned PD
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
CC: <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240202064039.15505-1-quic_ekangupt@quicinc.com>
 <20240202064039.15505-3-quic_ekangupt@quicinc.com>
 <2024020248-improving-algorithm-a5f0@gregkh>
From: Ekansh Gupta <quic_ekangupt@quicinc.com>
In-Reply-To: <2024020248-improving-algorithm-a5f0@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kLoix7wrTK-sjhTOHGvJ76ZeqgZgxupK
X-Proofpoint-ORIG-GUID: kLoix7wrTK-sjhTOHGvJ76ZeqgZgxupK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_02,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 mlxlogscore=503 phishscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402070066


On 2/2/2024 8:13 PM, Greg KH wrote:
> On Fri, Feb 02, 2024 at 12:10:25PM +0530, Ekansh Gupta wrote:
>> Unsigned PD requires more initial memory to spawn.
> What exactly is "Unsigned PD"?
>
> And where are all of the userspace changes for this series so we can
> verify they work properly?
>
> thanks,
>
> greg k-h

Hi Greg,
Unsigned PDs are sandboxed DSP processes used to offload computation
workloads to the DSP. Unsigned PD have less privileges in terms of
DSP resource access as compared to Signed PD.

Unsigned PD can be enabled using userspace API:
https://git.codelinaro.org/linaro/qcomlt/fastrpc/-/blob/master/src/fastrpc_apps_user.c?ref_type=heads#L1173

For multimode invoke request(other feature) also I've shared the
userspace changes with Srini which he will be pulling to userspace
project.

Please let me know if you have any other queries.

Thanks
--ekansh



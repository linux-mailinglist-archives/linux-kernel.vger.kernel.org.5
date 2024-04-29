Return-Path: <linux-kernel+bounces-162809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2937D8B60CF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE5A51F21DEC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD1F129E9E;
	Mon, 29 Apr 2024 17:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mgkhqObk"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D792128830;
	Mon, 29 Apr 2024 17:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714413309; cv=none; b=JYklWgs3LExhP7Jvr1pWhCsSNlYkZ25FC3YypOU9/i4WdPhupEIdcLFkQoj26QOC+gMjn6H6iOqJREQDzZZgqrwarRnxUs0bpCzaPoOcQUrq+q6xe7N1pST97mqfoBXXGmayA9k4vMdqRWFA8rgBhF0YxcosiGPyMF+dveAtWS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714413309; c=relaxed/simple;
	bh=vO3XR6uiSOnKDe6UToyLusq6Q1hWe4JEOoTuox8IlS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=leSf7NOIEuRvs9HRjCrX9touW41NjSxPQoeiPj6gm2jPP9BDn1EcfIJKTwwkpwKfwfrjZgKAfzh9jT2YPU7fYJEx6HabcOy69/Oz0h0ugxDA+9slRcGZgxmdTIHWxrqkdjrmXE2mjhDU9os1cvadOjOfS51Me8rHZguH1MHqGvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mgkhqObk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43TEQG9q021880;
	Mon, 29 Apr 2024 17:54:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=vO3XR6uiSOnKDe6UToyLusq6Q1hWe4JEOoTuox8IlS4=; b=mg
	khqObkAWXdQhPxUu3M53zsmmXNzhhrMi4kj2eTLYdUXlGRKPJNuDEB47xBN8xB5e
	sjqJjdPzbPQvrQwLC7BE/rrn21bUXKTOgUmlNRZr6KWhs+krv0qYr4Pss0B/8btU
	RCpOqL83E0sxkx97t7zCh+ogsTM8wLw7I4Vw9SvyODi1zLiQFworLoTcG2h/8/HV
	AQSECwibDvgDcKYaJwwVSXBl6zrSS2JZxWjdaIzykGme5PXE/S+TdXSt2gICn+FI
	F55MnjWi+rNGItgKlN75qQjHFyam3d5DbZuf6z3uOep2971lcM8gZ1shrgvDS8nn
	11QjQ91hmoMWw72QWxRw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtbv89tyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 17:54:47 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43THskcI013392
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 17:54:46 GMT
Received: from [10.71.110.192] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 29 Apr
 2024 10:54:43 -0700
Message-ID: <be14d211-cc3d-4014-a52e-64e589d93798@quicinc.com>
Date: Mon, 29 Apr 2024 10:54:43 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sh: Call paging_init() earlier in the init sequence
Content-Language: en-US
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        <ysato@users.sourceforge.jp>, <dalias@libc.org>
CC: <akpm@linux-foundation.org>, <linux-sh@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <kernel@quicinc.com>, Rob Herring <robh@kernel.org>
References: <20240423233150.74302-1-quic_obabatun@quicinc.com>
 <6ba5b226dfcbae3d9c789bb6943089621b315d65.camel@physik.fu-berlin.de>
 <b7296e60-1911-4302-b472-b0ae11cd3d87@quicinc.com>
 <9b3f9acd208842bb3c419b7f9bb40e1fe98f0c40.camel@physik.fu-berlin.de>
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
In-Reply-To: <9b3f9acd208842bb3c419b7f9bb40e1fe98f0c40.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xWU3bm_CAKwD0y2vieM2ZvpxATCYgY-X
X-Proofpoint-GUID: xWU3bm_CAKwD0y2vieM2ZvpxATCYgY-X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_15,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=659
 mlxscore=0 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404290115


On 4/29/2024 10:26 AM, John Paul Adrian Glaubitz wrote:
> Hi Oreoluwa,
>
> On Mon, 2024-04-29 at 09:28 -0700, Oreoluwa Babatunde wrote:
>> Here are links to the corresponding changes on Loongarch and Openrisc.
>>
>> - Loongarch:
>> https://lore.kernel.org/all/20240218151403.2206980-1-chenhuacai@loongson.cn/
>>
>> - Openrisc:
>> https://lore.kernel.org/all/1707524971-146908-3-git-send-email-quic_obabatun@quicinc.com/
> Great, thanks a lot! I will apply all reviewed patches to my sh-linux tree tomorrow.
>
> Thanks,
> Adrian
Thank you!


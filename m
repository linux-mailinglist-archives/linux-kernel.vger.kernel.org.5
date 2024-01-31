Return-Path: <linux-kernel+bounces-46900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 776F6844606
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15FE31F2D1E8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F9E12DDA5;
	Wed, 31 Jan 2024 17:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pXwk3K/7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BF912CDBE
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 17:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706721801; cv=none; b=LZaHjMkHcCArsevBBCyLpp0z3d7eC5NYL2ouuEkJO4QknxAfBjp4OBSmi5Y9bFbD0Ug7aSFa1gKt5BNQkdD3woYre8ow0D9fRj5CqdNE02WdTLHUNgOn2c7Xi6zcCcjNhn1IEkBDrfwcHGyObqBwKfZRl/46wBz9ToXkanwivh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706721801; c=relaxed/simple;
	bh=jg4i/dyF43h8qgH5FZhzIx6dU5C7yA20jsPgJAwXzcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dtqrrsuiwArLaeWJXfaZQ619x/YYheFGeIZOe5YYrnX6Lr9UbX/W9Wi0RcGj2mJibAAgJ60WTwaUleY8e6bpqhZ7S4kSGpQk4NunVR1iO0Y6iadC0MhcaegCCxhXElK6grjOhwXNSkUp0a/LHPJuQZ1Y9DNjgFOBfTMSaC0aF8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pXwk3K/7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40VEA2lf021787;
	Wed, 31 Jan 2024 17:23:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=OAK6AJ+Qp5umUhoDZecQwsbHlqutIZ1GzP5+lXa9h+8=; b=pX
	wk3K/7qdkxnMF0dgBx3g08nAzWAcBNcLPPckhZPQIxbJfzsN99bSgU0HeD0A4yrA
	PRpTOtEVORw1YiVy5UzcAcK1Sc5331fGpfeRYFKvgFTIkMJwCRGVITjiUO5L9PjS
	HBndsFf+wyfKgZlg9hkwpmOBUHnajEOvEVv5OwkHWJk4pGevh5n7cPge4HdzHvsZ
	csnQisNWF4OcCmhJOhtrcFLs9ifgxbW7iWKD86m7TSkPz0vN7dFDAKSng4b+/+a6
	n/9mrzGXj7PuA4+N5SM3OmOBT+srCQmI03+IqQLToJn6XMihC3LUJUc9Vlzd1Bz7
	VuhNenunQT8XyEQCgrZQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vyjas1844-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 17:23:07 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40VHN79f022329
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 17:23:07 GMT
Received: from [10.216.17.229] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 31 Jan
 2024 09:23:03 -0800
Message-ID: <f085796d-df7e-03c9-a2b5-56cd6897a347@quicinc.com>
Date: Wed, 31 Jan 2024 22:52:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] devcoredump: Remove devcoredump device if failing
 device is gone
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
        Rodrigo Vivi
	<rodrigo.vivi@intel.com>, <linux-kernel@vger.kernel.org>
CC: Jose Souza <jose.souza@intel.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
References: <20240126151121.1076079-1-rodrigo.vivi@intel.com>
 <d57dc34fa8b0e25cec014b8001dcd0527d1c1013.camel@sipsolutions.net>
From: Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <d57dc34fa8b0e25cec014b8001dcd0527d1c1013.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BjxZvj4JEA9y5WyZm35AnLFiE098fKpy
X-Proofpoint-ORIG-GUID: BjxZvj4JEA9y5WyZm35AnLFiE098fKpy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxscore=0
 mlxlogscore=464 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 clxscore=1011 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401310134



On 1/29/2024 11:18 PM, Johannes Berg wrote:
> On Fri, 2024-01-26 at 10:11 -0500, Rodrigo Vivi wrote:
>> Make dev_coredumpm a real device managed helper, that not only
>> frees the device after a scheduled delay (DEVCD_TIMEOUT), but
>> also when the failing/crashed device is gone.
>>
>> The module remove for the drivers using devcoredump are currently
>> broken if attempted between the crash and the DEVCD_TIMEOUT, since
>> the symbolic sysfs link won't be deleted.
> 
> Hmm, is it a problem to remove a whole dev when it still has some link
> here? Maybe we could just make the link be managed/auto-removed?
> 
> Probably regardless of that you should change the comment in
> devcd_dev_release() since it's no longer a concern?
> 
>> On top of that, for PCI devices, the unbind of the device will
>> call the pci .remove void function, that cannot fail. At that
>> time, our device is pretty much gone, but the read and free
>> functions are alive trough the devcoredump device and they
>                        ^ through, I guess
> 
>> can get some NULL dereferences or use after free.
> 
> Not sure I understand this part, how's this related to PCI's .remove?
> 
>> So, if the failing-device is gone let's also request for the
>> devcoredump-device removal using the same mod_delayed_work
>> as when writing anything through data. The flush cannot be
>> used since it is synchronous and the devcd would be surely
>> gone right before the mutex_unlock on the next line.
> 
> Can we just decouple it instead and remove the symlink? Which is kind of
> what the comment in devcd_dev_release() says but at the time I wasn't
> aware of all the devm mechanics etc.

Are we going to do this ?

-Mukesh

> 
> I'm thinking this might be annoying in certain recovery cases, e.g.
> iwlwifi uses this but may sometimes unbind/rebind itself to recover from
> certain errors, and that'd make the FW dumps disappear.
> 
> johannes
> 


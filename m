Return-Path: <linux-kernel+bounces-109219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D603881651
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EFC91C2329D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5E16A328;
	Wed, 20 Mar 2024 17:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XeSx6zml"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CE86A01D;
	Wed, 20 Mar 2024 17:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710954979; cv=none; b=IcwlbKcEzNudQRUzRRT1lhMdp+Mb2xbL2e00H74VSvngfKg5OfwM/qcYD6R9C4wFUmgWeA0jaGk4V6ERd+iKYQlNrejgH5QSF77ckZPZMlPTAQ7bgQmCiPb8nYyLUoJjOa63BPee7BN7oEOecXK0xvwtnhDGm50Q0XFsIu+cGAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710954979; c=relaxed/simple;
	bh=LMDT/S5VYriR03orj+KffWgjmaIzJKd3iCBDJeHdEHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NxoOyU4cs4F5lNRWVnT0dkJMRSamI9qk7x05BitCvfVZgaTVdQ2FgREt3m84JRN1hVijfZiVVLs8flrF2rj16SFhUMvxoZM5Rf3AQiOq/Y6x/z11JyiSrcBrdkHtd7Q1v5ITRW/xMdAapawkbyxuwpGpLVAptEuPELL3cQwwuH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XeSx6zml; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42KGvcGU007681;
	Wed, 20 Mar 2024 17:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ru400vBj+D3skoKY3EySOxlziOD0MUSbD8eBY1ccvPM=; b=Xe
	Sx6zmlxLBbCYqN68kFIo86ixexE07sELsKmTeinG0kY2cdi6DrqEW2mW93YM3xdy
	czXnAFPxS5GEWVnam1rTn2aKAmdvvcnSfhB6XWSo/X18R6zKmllB3Hx95Hm/kFQb
	c6n7PrWqwhHKRYko7J+UAqiVMfO7RjEi0xz6i7/pk+zQI0Ca7mTLtSFUuinIT85X
	fTh3GPgjs50SrCI5AS7SPBqCaBpJyplmRqQbTdTLVQ++9/igQ6IIuFXGWNpa+jyi
	95Anq45kb6XDDvyIZGU9nJ+dH533teCSCJSuicBRrJtjB0IwkvEP2eeWPImD7thE
	lApIgSBYbiVW7bK0w4qQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x01jqgdmd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 17:16:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42KHGCjE000513
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 17:16:12 GMT
Received: from [10.110.120.226] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Mar
 2024 10:16:12 -0700
Message-ID: <2a2d2001-f87e-49be-8f5f-fcd175c4911a@quicinc.com>
Date: Wed, 20 Mar 2024 10:16:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] wifi: nl80211: fix nl80211 UAPI kernel-doc
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240319-kdoc-nl80211-v1-0-549e09d52866@quicinc.com>
 <638df3bb659caef38480aa97277207b89c101344.camel@sipsolutions.net>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <638df3bb659caef38480aa97277207b89c101344.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qmKo9mfG43AzTc1OuSe-DSm_3ivX8aiN
X-Proofpoint-ORIG-GUID: qmKo9mfG43AzTc1OuSe-DSm_3ivX8aiN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_10,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 adultscore=0 spamscore=0 mlxlogscore=675 mlxscore=0 impostorscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403200138

On 3/20/2024 12:07 AM, Johannes Berg wrote:
> On Tue, 2024-03-19 at 11:26 -0700, Jeff Johnson wrote:
>> As part of my review of patches coming from the Qualcomm Innovation
>> Center I check to make sure that no checkpatch or kernel-doc issues
>> are introduced. An upcoming patch will propose a modification to
>> include/uapi/linux/nl80211.h. My review process flagged both
>> checkpatch and kernel-doc issues in the file, but these are
>> pre-existing issues. So this series fixes those pre-existing issues.
>>
> 
> Thanks Jeff.
> 
> Can you say what you're running for this? I've been running kernel-doc
> and builds with W=1 for a long time, and not seen issues. Is this
> perhaps checks from a newer kernel (we're currently on 6.8-rc1 for
> $reasons)?

files=$(git diff --name-only $base HEAD)
scripts/kernel-doc -Werror -none $files
scripts/checkpatch.pl --file $files



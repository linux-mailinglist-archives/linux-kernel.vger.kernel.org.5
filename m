Return-Path: <linux-kernel+bounces-30771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2374583242F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 06:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EEB11C21E60
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 05:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC344A12;
	Fri, 19 Jan 2024 05:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eo3UVTdv"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAB64691;
	Fri, 19 Jan 2024 05:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705641607; cv=none; b=L9B2X18NsA1SBO/s0CpDIvRaHBxBlZiVsstnIHXNTeBHbqhOKLBt2boG6ToA/5yxoHENr2RZcHlBM2Pllde1GprkyU41z6eWh1gfI5LDNgIodPKsymy/w4/1dDhjYgIItZjXJBZ/4LilSoNYxCCyeBGc21dze1OH2zdA0M0Y8tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705641607; c=relaxed/simple;
	bh=LTCKdtnUk4+lLsKQhuLrP0dxI8tJhkUKERYLhzyYJe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=adPTekeLxyMtYT12PTZZ7uiMTHRVP+aPYQ6EQ/uXO5YT8KQWDJWmyBz/4t3H3RhHQok/6g4Ufm3MY0aRAAqAMCmO3n1IQFZb6Cb2UiEhwqF6iI8NKukzu4JV60z7OPC09HRtLUsk9xZCxYyCFg4s/gLVNEEPTaaUH7mhYxT66rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eo3UVTdv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40J4pOvN010390;
	Fri, 19 Jan 2024 05:20:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=C7riFBU11nnzW4T8MmC9s11SawHSKgNA/p3lIimK/XM=; b=eo
	3UVTdvbCdK3WKOlc4cFwn9fzCMMKwE4ISGTK4hERSwAZitPfeakrewelFDRM54By
	HDol4hYutP2xJ+EBe8GcAXsJAVpD9bFndOm5dqPxnOvPdEyijVR/tiB5HG3RjVWi
	HXakt4q+AIQyLdCacVcIhgs3R/oX75xm41xO1zhmTS5Tg5pf+rbofzreabaRDF3a
	UxbGHPkkbtRlLtieSL+havg9fmhEyLOx4YA4dmV+KW4JSTjESrDhjJ9TR90Y7sfP
	wyeeGJKhc8xqjin8XH38Mk/WpuM7Sr/lywYpaSE+yW/tIevb11/WS2VNMiKwcptM
	2t8mrgGGx5lG1I0QMYYw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vq2d0jck3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 05:19:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40J5Jwec011031
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 05:19:58 GMT
Received: from [10.217.198.224] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 18 Jan
 2024 21:19:56 -0800
Message-ID: <7649dd92-4e73-470a-921a-2420bf521537@quicinc.com>
Date: Fri, 19 Jan 2024 10:49:53 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: rpmh-rsc: Enhance check for VREG in-flight
 request
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_eberman@quicinc.com>, <quic_collinsd@quicinc.com>,
        <quic_lsrao@quicinc.com>
References: <20240117-rpmh-rsc-fixes-v1-1-71ee4f8f72a4@quicinc.com>
 <9b177f7b-8dbf-4193-9a70-94f7b80f0a87@linaro.org>
Content-Language: en-US
From: "Maulik Shah (mkshah)" <quic_mkshah@quicinc.com>
In-Reply-To: <9b177f7b-8dbf-4193-9a70-94f7b80f0a87@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: iUAOo7-oncuFgMQKA_iJY4Sau_xUpq5c
X-Proofpoint-GUID: iUAOo7-oncuFgMQKA_iJY4Sau_xUpq5c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-19_02,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=628 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401190012

Hi,

On 1/17/2024 5:19 PM, Konrad Dybcio wrote:

>> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
>> index a021dc71807b..5371d7e3090a 100644
>> --- a/drivers/soc/qcom/rpmh-rsc.c
>> +++ b/drivers/soc/qcom/rpmh-rsc.c
>> @@ -1,6 +1,7 @@
>>   // SPDX-License-Identifier: GPL-2.0
>>   /*
>>    * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2023-2024, Qualcomm Innovation Center, Inc. All 
>> rights reserved.
>>    */
>>   #define pr_fmt(fmt) "%s " fmt, KBUILD_MODNAME
>> @@ -91,6 +92,15 @@ enum {
>>   #define CMD_STATUS_ISSUED        BIT(8)
>>   #define CMD_STATUS_COMPL        BIT(16)
>> +#define ACCL_TYPE(addr)            ((addr >> 16) & 0xF)
>> +#define VREG_ADDR(addr)            (addr & ~0xF)
> 
> It would be nice to add some #define FNAME GENMASK(x, y) accessed
> with FIELD_GET(FNAME, foobar), so that the code is a bit more
> self-explanatory
> 
> Konrad

Thanks for the review.
Updates in v2 to use GENMASK() and FIELD_GET().

Thanks,
Maulik


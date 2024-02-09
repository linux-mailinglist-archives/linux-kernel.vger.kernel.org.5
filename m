Return-Path: <linux-kernel+bounces-59685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A947D84FA65
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 451A81F21894
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B51E86AD3;
	Fri,  9 Feb 2024 16:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OST7RopP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E4276414;
	Fri,  9 Feb 2024 16:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707497796; cv=none; b=e+57wdxRRYLMJczKIsx8A9FarLMu6LhhOdQ209Kq342OxlEHripL279OTRRkgnSamgVDot/CgdcKaWBW9p+H+G8J2dJuKRRBSxDPGzTR0Y0nQyos2gg2xtK2QA3xWXds2M1XF/pLXnOPkq4k1PV6U+Ai8Rr/IBownE2PDPaBhV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707497796; c=relaxed/simple;
	bh=J/MfZTMY7vJ/FmpWNtX0rTMAuzY/Rbc8mm8OmM8h5jc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gypr9OSV2QTGzlfy2SJ3ZGLA0g2fCceCJN0TvsfyaxbY4EBCXmgN937UsOKsHcAvXd+GZ3aKhY92tqVaek9xUgISltV6Vu7c4OkuZVU0A5hdUMd55LNXnx4twoCPw5oK7dCnzgxGTfq3m3U5I9qU1IZwERVxdg3Ic3EGZQGRozs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OST7RopP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 419COmGT027518;
	Fri, 9 Feb 2024 16:09:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=c2ziwPPJ87pqspr3WW8ns7hCbOA/kOJcRJXPUxtM2LU=; b=OS
	T7RopPKnRrAnS6trbo7n7HJdy6ojZ8g46+4pMzhPWVIQIrehb7yIvH4qzUFrO9uJ
	z2HLmmpN4S/i3lo2qWPY26fAIWdoCcDRNh1DvBAIlQzLDVrO/MF6rxpFPI2LbUaB
	aVeRLKxsYHv7pdzeuZJElAwRDvMC4goElV3zAf8u+AVE78jwm+VIcZcZOXMpU0hm
	aR4ZqY1RlkuWjtC7NI9N38RZgi3QIYOasBDUh8OU8d3Aditdg77VJXNa/tVAE/P+
	ZZspIsJ3463jHwbun1t9y3DhHtHlldn3xiF2s6t67fqF7K6Iq9fLezsHskA1dNg1
	A3SZd6281Ov4q/eogC2A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w5m158f2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 16:09:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 419G9Uxn019459
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 9 Feb 2024 16:09:30 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 9 Feb
 2024 08:09:29 -0800
Message-ID: <c175684d-01e2-8603-d9c6-d9354b001143@quicinc.com>
Date: Fri, 9 Feb 2024 09:09:28 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] MAINTAINERS: Update bouncing @codeaurora addresses
Content-Language: en-US
To: Ritesh Harjani <ritesh.list@gmail.com>, <adrian.hunter@intel.com>,
        <quic_asutoshd@quicinc.com>, <quic_bjorande@quicinc.com>
CC: <linux-mmc@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <87il33mn3n.fsf@doe.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <87il33mn3n.fsf@doe.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 34i71qS6LTjMNEERIwtULtBvVG8oNTDG
X-Proofpoint-ORIG-GUID: 34i71qS6LTjMNEERIwtULtBvVG8oNTDG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_13,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=516 lowpriorityscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402090119

On 2/4/2024 11:39 PM, Ritesh Harjani wrote:
> Jeffrey Hugo <quic_jhugo@quicinc.com> writes:
> 
>> The @codeaurora email domain's servers have been decommissioned for a
>> long while now, and any emails addressed there will bounce.
>>
>> Asutosh has an entry in .mailmap pointing to a new address, but
>> MAINTAINERS still lists an old @codeaurora address.  Update MAINTAINERS
>> to match .mailmap for anyone reading the file directly.
>>
>> Ritesh appears to have changed jobs, but looks to be still active in the
>> community.  Update Ritesh's address to the one used in recient community
>> postings.
>>
> 
> Thanks Jeffrey for the cc. Since I am not really active in linux-mmc
> anymore, I would like to propose to have a Reviewer entry (R:) for
> myself which I can try to help with.
> 
> Is that ok?

I see no problem with that.  Will send a v2

-Jeff


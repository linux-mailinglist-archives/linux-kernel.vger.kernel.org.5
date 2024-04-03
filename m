Return-Path: <linux-kernel+bounces-129461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 469CA896B1E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0D9E1F28017
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935EA1350FB;
	Wed,  3 Apr 2024 09:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ACWf8snr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522DB1350CC;
	Wed,  3 Apr 2024 09:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712138101; cv=none; b=DOfSl5QZ7YFT5uCe900GWqwtj1oz7ZOBbtBs/hMqUi9krfRX3w12s9WULoXK0JWAkFgUcgPBFokYbP48y2pdJ6GjOHmljj8oFjWnFWcxOGlatso2NzY37ZCkKuRvUDdrynmdK7nIe59VQlJ95IFYH7/FeIb64vsTEu7DxIS2pa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712138101; c=relaxed/simple;
	bh=oiHWoWCvkabtwsxiv9dt0/qAEDnPmalSkxKaep9KOME=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fg0bKCYNiDQYpdzOLA1Hxz82SIxDDIjEwiJSeGdEgYzDIwOevPw/+oq1xhAptX/Jh52KDCGydSgN8VWOEnmNnqncu8U50Lq9ClVBFChITsDk2vEpDqRveP6eCjp7wzG/AeyzBGxwqCMxdrU6ilXV87lNTtagErvLCPTsoThKWjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ACWf8snr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4337xT9x002472;
	Wed, 3 Apr 2024 09:54:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=zMbhq6D8bTCb7T/M1gze5YhKFdrGxfuN5JvaonxMTbg=; b=AC
	Wf8snrHU7kMbBcl/RuK6YtfbB1ByseR15FkALVnMuj7nh9aBMxVsybipj2MehsK9
	Gk50KFWMDyKgxXPirbEC9wkLaxqHVaiSKIDjg/eTJ7Su+YT+sxOWmvsv9z1DlVmi
	ZjlEJ98prvhSonlzjbkxPl1LYdTNwDoLBbSF2tEq3UjxXyPDpZtGyx04KZ4q4w/x
	Lz/MDewqJ/P/Bgf83dwJFSFHaOwzr8SnwfnqEVFKsiSuN+WdaUK2lZxc1vVmNmdT
	NDQSwp+i3XJdB759s8NoXxArNcicNex17E9KLsKUaAdxnuwmgL8umszuaaazPswm
	6bdTNLTHv2/ZU+9G4oFQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x9377r846-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 09:54:53 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4339sqd8004722
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Apr 2024 09:54:52 GMT
Received: from [10.251.45.126] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 3 Apr 2024
 02:54:49 -0700
Message-ID: <93f9128f-dfe0-457d-8507-5866c97974ee@quicinc.com>
Date: Wed, 3 Apr 2024 12:54:47 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] Move camss version related defs in to resources
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, <rfoss@kernel.org>,
        <todor.too@gmail.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mchehab@kernel.org>
CC: <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <laurent.pinchart@ideasonboard.com>,
        <hverkuil-cisco@xs4all.nl>, <quic_hariramp@quicinc.com>
References: <20240319173935.481-1-quic_grosikop@quicinc.com>
 <60461c7b-b693-4560-ab29-8cd9d8ac4a44@linaro.org>
Content-Language: en-US
From: "Gjorgji Rosikopulos (Consultant)" <quic_grosikop@quicinc.com>
In-Reply-To: <60461c7b-b693-4560-ab29-8cd9d8ac4a44@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7SHcz20eWPAKLrJFEZpmgSLOkfmfZsOu
X-Proofpoint-ORIG-GUID: 7SHcz20eWPAKLrJFEZpmgSLOkfmfZsOu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_09,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 clxscore=1011 suspectscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404030068

Hi Bryan,

On 4/2/2024 1:35 AM, Bryan O'Donoghue wrote:
> On 19/03/2024 17:39, Gjorgji Rosikopulos wrote:
>> The different resources required for different camss soc versions are
>> split in to two groups:
> 
> General series comment =>
> 
> You need to add your Signed-off-by: Gjorgji Rosikopulos
> <quic_grosikop@quicinc.com>
> 
> for each of the patches you are submitting.

Agree that is missing i will do that for the next-patchset

> 
> Perhaps yourself or some of the other people in the series deserve to
> have Co-developed-by for some of the patches too ?

I agree as well i will double check if some people are missing.

> 
> I really like the reduction of code and the definition in one-place of
> things so definitely the right direction.
> 
> I won't do a deeper dive into the code until V3 but for reference here
> are the branches I verified db410c, rb3, rb5 and x13s with.
> 
> x13s:
> https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/sc8280xp-6.9-rc1-camss-resource-change-verification?ref_type=heads
> 
> db410c/rb3/rb5:
> https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/linux-stable-v6.7.9-camss-rb5-20240319173935.481-1-quic_grosikop@quicinc.com?ref_type=heads

Thanks, i will get your changes for x13's as commented in previous
review and submit new patch-set.

~Gjorgji

> 
> ---
> bod


Return-Path: <linux-kernel+bounces-57985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8408784DFF0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6BBB1C21478
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0599A71B2E;
	Thu,  8 Feb 2024 11:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bkwbBj4Q"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4C66F50E;
	Thu,  8 Feb 2024 11:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707392700; cv=none; b=Nwt3gcGudwn2hqc0/sPfJjBxqLD6sGRzAQdRPKQAZQtKZhgbVjuSZNjxPWFOl9zZNg6HoOCLelQWCg3V/5rOyLr/LDqPHpK+Urtaw9+4c0NlblI3Ny+2w4tMVS8W8tqVWnW0FL0uv8RBav6gcu1tySxex3iP7CIwaEHthRSM8E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707392700; c=relaxed/simple;
	bh=SV4BLe+gEou1zDSRbzWIuNvr7/UpoWLL4qZYlpo5iRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dmxd3D0ItQm0mzkj0TIjAzPQ5HsX+2VctwhC0kNv7xaPAR57Xrp1DTpy2N4pwb3jMl6g04AjzqumTGcC1T+OLBh3/RWJOGJl6M7n5GKDvGshmLsCtpFXc/LcQTnk3Fl3+VVAY0bEWMb5dt10zJfC4+BXQz+JrFx8Mt0JsAiER1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bkwbBj4Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4186bJEC018973;
	Thu, 8 Feb 2024 11:44:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=DqCkSUfxyWtun34Wph0v0lBrYC8lAMgQvT0HMRCFIMU=; b=bk
	wbBj4QLjtwiLnv50vp0407POqdN0xtpLzipYfMzUTlrYpyoLAa+LFGTy7C1JF2Xb
	f3dVshMVm0Z1JPzAvOYxND3iEZp0K1Pn84qGNJsuOhaebeVyGbDuUnidZEMyqHPq
	TFFzi5BUQFnqvxx99QeM1F67cJlW3bjgyrnS8GC00WpgVeoZRnAUEnxuswfJBHgT
	82n5yFmP2/dOvwO8kMm8huITYJ1h0qbGGIgSJC/Xm+U6lX4Z2vEThpYHTwer/fZo
	5ZcQNSnIt2waBojoCEmwsiAsGtxAPSQLszQxpZPLgdgcY+S4DhuBZsbmeVzkoyqG
	UXeGyJbDFXs7mT1FS0aQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w4sudgspn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 11:44:55 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 418BisCu026426
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 8 Feb 2024 11:44:54 GMT
Received: from [10.216.8.145] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 8 Feb
 2024 03:44:51 -0800
Message-ID: <c4a6500d-7fdd-4e62-bc96-bd2e164f3bc4@quicinc.com>
Date: Thu, 8 Feb 2024 17:14:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] soc: qcom: mdt_loader: Add Upperbounds check for
 program header access
To: Mukesh Ojha <quic_mojha@quicinc.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240202063919.23780-1-quic_audityab@quicinc.com>
 <9773d189-c896-d5c5-804c-e086c24987b4@quicinc.com>
Content-Language: en-US
From: Auditya Bhattaram <quic_audityab@quicinc.com>
In-Reply-To: <9773d189-c896-d5c5-804c-e086c24987b4@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Uo58qFgVe6qJT-gMf2LHq1myonw-kYvH
X-Proofpoint-ORIG-GUID: Uo58qFgVe6qJT-gMf2LHq1myonw-kYvH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_03,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 adultscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402080061



On 2/2/2024 1:34 PM, Mukesh Ojha wrote:
> 
> This should be v2., first time patches is always counted as v1
> 
> On 2/2/2024 12:09 PM, Auditya Bhattaram wrote:
>> hash_index is evaluated by looping phdrs till QCOM_MDT_TYPE_HASH
>> is found. Add an upperbound check to phdrs to access within elf size.
>>
>> Signed-off-by: Auditya Bhattaram <quic_audityab@quicinc.com> > ---
>> Added error prints for Invalid access.
>> Link for previous discussion 
>> https://lore.kernel.org/linux-arm-msm/5d7a3b97-d840-4863-91a0-32c1d8e7532f@linaro.org/T/#t
> 
> Would be better if you take reference from other patches,
> 
> Like above can be done as,
> 
> Changes in v2:
>    -  ...
>    -  ,,,
>> ---
>>   drivers/soc/qcom/mdt_loader.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/soc/qcom/mdt_loader.c 
>> b/drivers/soc/qcom/mdt_loader.c
>> index 6f177e46fa0f..61e2377cc5c3 100644
>> --- a/drivers/soc/qcom/mdt_loader.c
>> +++ b/drivers/soc/qcom/mdt_loader.c
>> @@ -145,6 +145,11 @@ void *qcom_mdt_read_metadata(const struct 
>> firmware *fw, size_t *data_len,
>>       if (phdrs[0].p_type == PT_LOAD)
>>           return ERR_PTR(-EINVAL);
>>
>> +    if (((size_t)(phdrs + ehdr->e_phnum)) > ((size_t)ehdr + fw->size)) {
>> +        dev_err(dev, "Invalid phdrs access: %s\n", fw_name);
>> +        return ERR_PTR(-EINVAL);
>> +    }
>> +
> 
> Should this not be marked for stable kernel ? as without this it could 
> be accessing beyond fw_size for uncertain scenario.
> 
> -Mukesh

Yes This should be marked for stable.

> 
>>       for (i = 1; i < ehdr->e_phnum; i++) {
>>           if ((phdrs[i].p_flags & QCOM_MDT_TYPE_MASK) == 
>> QCOM_MDT_TYPE_HASH) {
>>               hash_segment = i;
>> -- 
>> 2.17.1
>>
>>


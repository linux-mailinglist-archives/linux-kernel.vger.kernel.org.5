Return-Path: <linux-kernel+bounces-74374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B7885D32B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C81931C226CC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE2D3D0DF;
	Wed, 21 Feb 2024 09:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="msgzdkru"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9602E3C497;
	Wed, 21 Feb 2024 09:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708506828; cv=none; b=V+m8Ef8m45USe4ehQdHnROFruMGfb2OUwayexh4kz19J9KyTKYg6UcKs6K5ek83pQPIMp83RGU0MKOwNfxHK2ZEZZ6pqlkQbib2xLRgAzF6tbgeDnXffbhMqhLck3n9sA5l+bmYGYSDs9MB8v76otv5eawzvjir1bdc+IwSbX/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708506828; c=relaxed/simple;
	bh=qFObq/imKbrBX0uou05JQZLEdlhhLxwxtZ5KTgzKBr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IbY/nNUOERSIxOJDmUGDD2u0+A9WG6Du8EMblxJTP7MI3/5pq61uKw1Nbw2Vpm9/FQI8efvENMlbiDF5ISigH/wMOFqRU+SiBM6iW/nxAFj4+2zn+ttAu+nHki/yQ7hEFXWDGPuaOKrRz93AmoVVWnoDrGe5qBNj2Lb5Ofn5rzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=msgzdkru; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41KM7mMF023143;
	Wed, 21 Feb 2024 09:13:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=7YFnjNAZLO3w+jteC62S+W+CCoKKILLhKobc4wtrZdc=; b=ms
	gzdkruov9J8BhiNFDFptNtmjSOWkB/e/e4PyU0+pRfet/kCfdtVff7xJnokp5tmk
	naY5aUNmyKERT4Yuba/G8Y4/kITRXn3wYxlv47JRwGAySaBTZcm9SFd9RTZbZIUu
	entXIMV/n0BQKiMwJam1an3eK+2stulYB7jQpjts0y6hxZnZrJ+tMM95oEn5eHR9
	UHzXsj3dQJelFGeLis64pRfgB5fm8ajzOvFnNnFfD2dpm1kvPD9hK3rKF568OLCJ
	vx9O9j2VbLAdyACdmPOAgbfchum256+K4S3kZjcTL+fXUeGOWEI33zSFYnQ/YoT7
	2AIB43BOadwBQ3M0iacw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wd21qsgg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 09:13:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41L9DScs008018
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 09:13:28 GMT
Received: from [10.253.11.235] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 21 Feb
 2024 01:13:26 -0800
Message-ID: <c7635c10-1724-4db5-9568-d554e1c64f72@quicinc.com>
Date: Wed, 21 Feb 2024 17:13:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: ufs: core: Fix setup_xfer_req invocation
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, Rohit Ner <rohitner@google.com>,
        Bean Huo <beanhuo@micron.com>, Stanley Chu <stanley.chu@mediatek.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jaegeuk Kim
	<jaegeuk@kernel.org>
CC: Avri Altman <avri.altman@wdc.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240220090805.2886914-1-rohitner@google.com>
 <1920a2f6-e398-47af-a5d7-9dad9c70e03d@acm.org>
From: Can Guo <quic_cang@quicinc.com>
In-Reply-To: <1920a2f6-e398-47af-a5d7-9dad9c70e03d@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 99d-wUo6I_MKnG9oBQmP4xkAWK7nYloM
X-Proofpoint-ORIG-GUID: 99d-wUo6I_MKnG9oBQmP4xkAWK7nYloM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210071

Hi Bart,

On 2/21/2024 1:21 AM, Bart Van Assche wrote:
> On 2/20/24 01:08, Rohit Ner wrote:
>> Allow variant callback to setup transfers without
>> restricting the transfers to use legacy doorbell
>>
>> Signed-off-by: Rohit Ner <rohitner@google.com>
>> ---
>>   drivers/ufs/core/ufshcd.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
>> index d77b25b79ae3..91e483dd3974 100644
>> --- a/drivers/ufs/core/ufshcd.c
>> +++ b/drivers/ufs/core/ufshcd.c
>> @@ -2280,6 +2280,9 @@ void ufshcd_send_command(struct ufs_hba *hba, 
>> unsigned int task_tag,
>>           ufshcd_clk_scaling_start_busy(hba);
>>       if (unlikely(ufshcd_should_inform_monitor(hba, lrbp)))
>>           ufshcd_start_monitor(hba, lrbp);
>> +    if (hba->vops && hba->vops->setup_xfer_req)
>> +        hba->vops->setup_xfer_req(hba, lrbp->task_tag,
>> +                        !!lrbp->cmd);
>>       if (is_mcq_enabled(hba)) {
>>           int utrd_size = sizeof(struct utp_transfer_req_desc);
>> @@ -2293,9 +2296,6 @@ void ufshcd_send_command(struct ufs_hba *hba, 
>> unsigned int task_tag,
>>           spin_unlock(&hwq->sq_lock);
>>       } else {
>>           spin_lock_irqsave(&hba->outstanding_lock, flags);
>> -        if (hba->vops && hba->vops->setup_xfer_req)
>> -            hba->vops->setup_xfer_req(hba, lrbp->task_tag,
>> -                          !!lrbp->cmd);
>>           __set_bit(lrbp->task_tag, &hba->outstanding_reqs);
>>           ufshcd_writel(hba, 1 << lrbp->task_tag,
>>                     REG_UTP_TRANSFER_REQ_DOOR_BELL);
> 
> UFS controllers that are compliant with the JEDEC UFSHCI specification do
> not need the .setup_xfer_req() callback so I think a better motivation is
> needed to make this change.

I am going to push some BUG fixes for Qualcomm UFSHCI MCQ engine, one of 
which would count on a vops in ufshcd_send_command(). My original plan 
was to add a new vops.mcq_setup_xfer_req() to differentiate from the 
existing one used in legacy mode. But if Rohit moves the existing 
setup_xfer_req() up, I can use it instead of introducing the new one.

Thanks,
Can Guo.

> 
> Thanks,
> 
> Bart.


Return-Path: <linux-kernel+bounces-11764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEEB81EB56
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 02:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CC3A1C20B94
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 01:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A6928EB;
	Wed, 27 Dec 2023 01:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RoLpmPGG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2612563
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 01:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BR1S0lK026006;
	Wed, 27 Dec 2023 01:41:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=6rCjNYpmvzw+zFgIJoVmB9pAnWLGDKEmkbIEn4WF5cY=; b=Ro
	LpmPGG1jrRmfUybNsPFlUWwYb26gY4r2PQvKl8nO18Tjz82ZfDzzPBBEpprt2wP6
	Nv2CxpkZUz0u4w6kve8w5WSFKPrvbJSJ8Nt4gtEICF19HJkCCQttsMy2Zl++U0hB
	vYwscyOvC6eueP/ZJhly75P0D7mJOrqZK+th65xzJDkbOig1UX/mfrHUfpYg1pBd
	CLFyTGouwpqgpU313lv6TdH3kx2tCIRO7UJB53u4TJo8nOi3lb+raYKiM2pLWStc
	tU+fNSS3LNKUXk1z0SoWOsYfCtAHgjRaFypYEM1nCHJEN7YWE7NFoKeNDSZoim80
	8yIl0Q5+O6rhnCRK2CDQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v7gd9aqc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Dec 2023 01:41:34 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BR1fXDe006012
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Dec 2023 01:41:33 GMT
Received: from [10.239.132.150] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 26 Dec
 2023 17:41:31 -0800
Message-ID: <6e762e8e-b031-4e37-97c1-56390c9b8076@quicinc.com>
Date: Wed, 27 Dec 2023 09:41:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kernel: Introduce a write lock/unlock wrapper for
 tasklist_lock
Content-Language: en-US
To: Hillf Danton <hdanton@sina.com>, Matthew Wilcox <willy@infradead.org>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
        <linux-kernel@vger.kernel.org>
References: <20231213101745.4526-1-quic_aiquny@quicinc.com>
 <ZXnaNSrtaWbS2ivU@casper.infradead.org>
 <20231226104652.1491-1-hdanton@sina.com>
From: "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>
In-Reply-To: <20231226104652.1491-1-hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 80UPHpaJI7CGgHzwb1QAGMjS_T7xff0X
X-Proofpoint-GUID: 80UPHpaJI7CGgHzwb1QAGMjS_T7xff0X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 clxscore=1011
 bulkscore=0 phishscore=0 mlxscore=0 mlxlogscore=452 malwarescore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312270011



On 12/26/2023 6:46 PM, Hillf Danton wrote:
> On Wed, 13 Dec 2023 12:27:05 -0600 Eric W. Biederman <ebiederm@xmission.com>
>> Matthew Wilcox <willy@infradead.org> writes:
>>> On Wed, Dec 13, 2023 at 06:17:45PM +0800, Maria Yu wrote:
>>>> +static inline void write_lock_tasklist_lock(void)
>>>> +{
>>>> +	while (1) {
>>>> +		local_irq_disable();
>>>> +		if (write_trylock(&tasklist_lock))
>>>> +			break;
>>>> +		local_irq_enable();
>>>> +		cpu_relax();
>>>
>>> This is a bad implementation though.  You don't set the _QW_WAITING flag
>>> so readers don't know that there's a pending writer.  Also, I've seen
>>> cpu_relax() pessimise CPU behaviour; putting it into a low-power mode
>>> that takes a while to wake up from.
>>>
>>> I think the right way to fix this is to pass a boolean flag to
>>> queued_write_lock_slowpath() to let it know whether it can re-enable
>>> interrupts while checking whether _QW_WAITING is set.
> 
> 	lock(&lock->wait_lock)
> 	enable irq
> 	int
> 	lock(&lock->wait_lock)
> 
> You are adding chance for recursive locking.

Thx for the comments for discuss of the deadlock possibility. While I 
think deadlock can be differentiate with below 2 scenarios:
1. queued_write_lock_slowpath being triggered in interrupt context.
   tasklist_lock don't have write_lock_irq(save) in interrupt context.
   while for common rw lock, maybe write_lock_irq(save) usage in 
interrupt context is a possible.
   so may introduce a state when lock->wait_lock is released and left 
the _QW_WAITING flag.
Welcome others to suggest on designs and comments.

2.queued_read_lock_slowpath can be triggered in interrupt context. And 
it already have the handle to avoid possible deadlock.
In the queued_read_lock_slowpath, there is check whether current context 
is in interrupt or not, and get the lock directly of only write lock 
waiting.

Pls reference[1]:
	/*
	 * Readers come here when they cannot get the lock without waiting
	 */
	if (unlikely(in_interrupt())) {
		/*
		 * Readers in interrupt context will get the lock immediately
		 * if the writer is just waiting (not holding the lock yet),
		 * so spin with ACQUIRE semantics until the lock is available
		 * without waiting in the queue.
		 */
		atomic_cond_read_acquire(&lock->cnts, !(VAL & _QW_LOCKED));
		return;
	}

[1]: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/locking/qrwlock.c
>>
>> Yes.  It seems to make sense to distinguish between write_lock_irq and
>> write_lock_irqsave and fix this for all of write_lock_irq.
>>
>> Either that or someone can put in the work to start making the
>> tasklist_lock go away.
>>
>> Eric

-- 
Thx and BRs,
Aiqun(Maria) Yu


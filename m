Return-Path: <linux-kernel+bounces-83618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B710869C54
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDA901C24B97
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B43208B4;
	Tue, 27 Feb 2024 16:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NvcFz/+s"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5990C208AD
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 16:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709051882; cv=none; b=m+aS9Im+R1kxg/lWxUEWmdI/gOZp7yH70/27BW/z3XpIDoyfs4aJ2Vv9yoGRctimhN52v5b80HzSBmgfsEkJemRugkYXGDllb1C948FuPRqU0K9FYXmfryOYVA2hz7vp7vfiGhHz0nV39tvRwlG33i2V4GIN3L+itcNKAbYW9f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709051882; c=relaxed/simple;
	bh=OHiW7rbcuYzcClUQc9OK8mKAChRHcUsMHQFdnb5Tz8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=a7gMeV/dv3vqexRZpH/MDAwl8J5PUWHp1fygiZv7o8fcrmNdM88BqJmTi3vq5z81ls7CYBnELdbg1r+48ppGYNwXaAVjoWwFoe/qdRHa5C8AjGa78tLihQ1ThUAKFjHc2vHMAYCiOkQ7nA264vIDPetpQIwjBYRZVUqBQOcAUH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NvcFz/+s; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41RC8LGQ003566;
	Tue, 27 Feb 2024 16:37:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=/MGuTE0DU8CyyPYXulKWAoGMCEKdrgcReMxRuOBYI80=; b=Nv
	cFz/+sa3SZq+3WwkOWZNT6V2czM7PqeeXgumZePSPZEr7g87C3gsiEYvf4ykUUNR
	vVBoOFC1PO7stNLhq5A2f1E7PRndI0eNDqlvzahIl1+VVOh6A9jXZIGTfasxrpIZ
	W0m52NlvE0MjSO66HzE8h0rqR1c8/XD9echohlcomZCNduNjWqLZR2A8TFSGa6Nl
	xCuL5+ojUpUc104e/obC7x14929/pVT4Wac60dngnDUHguUqfYhcikSZwbWXJ7Uw
	apEo/KrMS8wBBsGCus+2MXLt7CWD9hi/8hRzBH+vnh1jj/GTOTf6m5rbkSWmh2Js
	z9HWnUIuA8EbGl7K8s5w==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wh64qhx5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 16:37:38 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41RGbEIM029254
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 16:37:14 GMT
Received: from [10.216.25.104] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 27 Feb
 2024 08:37:11 -0800
Message-ID: <2408885e-517d-dc98-e05a-b79de0c66c38@quicinc.com>
Date: Tue, 27 Feb 2024 22:07:08 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] printk: Update @console_may_schedule in
 console_trylock_spinning()
Content-Language: en-US
To: John Ogness <john.ogness@linutronix.de>, <pmladek@suse.com>,
        <rostedt@goodmis.org>, <senozhatsky@chromium.org>
CC: <linux-kernel@vger.kernel.org>
References: <20240222090538.23017-1-quic_mojha@quicinc.com>
 <87plwo5z4k.fsf@jogness.linutronix.de>
 <e5474801-53c1-6bbb-8781-e5cee42d6a90@quicinc.com>
 <875xybmo2z.fsf@jogness.linutronix.de>
 <44648e78-d117-2f6a-8ecd-f0a29327fa4f@quicinc.com>
 <8734tfml8v.fsf@jogness.linutronix.de>
From: Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <8734tfml8v.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LzOFRhNtxSBz9dOAtFyBnNLecZMYscoO
X-Proofpoint-GUID: LzOFRhNtxSBz9dOAtFyBnNLecZMYscoO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_03,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=990 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402270128



On 2/26/2024 6:32 PM, John Ogness wrote:
> On 2024-02-26, Mukesh Ojha <quic_mojha@quicinc.com> wrote:
>> what if console_trylock_spinning() gets the lock which makes
>> console_may_schedule =1 and it is still schedulable ?
> 
> I am afraid I do not understand the question.
> 
> console_trylock_spinning() is only called from the printk caller
> context. In this context, console_may_schedule is always set to 0.
> 
> Only if another context acquires the console lock per sleeping wait,
> console_lock(), can console_may_schedule be set to 1.
> 
> Note that the value of console_may_schedule is only relevant for the
> console lock owner when console_unlock() is called. That is why its
> value is set when locking the console (or, with this patch, when
> transferring console lock ownerhip).

I overlooked it, thanks.
Patch LGTM.

Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh
> 
> John


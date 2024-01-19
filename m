Return-Path: <linux-kernel+bounces-31388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E54AA832D9D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 230A91C230D9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4008555796;
	Fri, 19 Jan 2024 17:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="M1OURMWY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258D91F60B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 17:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705683665; cv=none; b=IgIUkto6riasS5hP3+eQas8EyAdkacNicwITS7iBBhMnnzmdDi+yKvVS7Q3+Lmk8JSbK1hlS9pLINTURAeZa3B35tIvSmJpIM3O2JNQvZio7q1F1974vh7RfJXVe7aY8mugUvPjZAXWSHHPyMfDw+QbYroxjZWV/M6M6VfXqxwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705683665; c=relaxed/simple;
	bh=W5sCI0PITHZFDeHBgbs+W7Bc9g68oVsuBMQjrIfHdF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tneegqq4U4D/CyC76gxoDCQ9RiZfeubj+2UTNX8p4v8VMaED7EaFCkNEPre6vB5uuwntJcE/DhDtSbbP/5qF1H56q05UoIK58ka/o3EQOuRw2Cn3o6hYRAdW3vBdWANGzOd+5V8XGYsBWnJ2XOh/VOSp+1xYYhd/iickSg0EE/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=M1OURMWY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40JCbQb8010388;
	Fri, 19 Jan 2024 17:00:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Qy1pMhP/rRJ1IzNoHsuqbIjw26g6hcRy+ObDQ8oRG60=; b=M1
	OURMWYeZjNu87Msk/DWWDq3WAcNenMOtUDr/I17mqxbp0nz5TAx7AK0pZtFDqddz
	PD3J3/LJnwaSLii5oK3gbwbWs2qAxLsinqg4SqChxiwgO+X2OnDyqiHlTSOTjtkg
	aDghS70ki9OActoy+puA49g7RNDzbo4avdQDCzrEno7NzjzBXz+W/1gyHlrUAlaY
	qmzqKveYgFpkjbwRHA1Awbz6CIMD8YYT8i+NFlQXoIv+YYwMN9zRv062d4/p4Heg
	Hkms5+W8ALH/KGuyphpsrd5hLIyDMkMZD0ohoQQgb1TVuc//LRCcit/ZeKkMj79n
	EN4vGK+6QsCRi7UQa5Rw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vqpkvguj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 17:00:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40JH0UMe027236
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 17:00:30 GMT
Received: from [10.216.49.108] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 19 Jan
 2024 09:00:26 -0800
Message-ID: <a6f9a1fd-0ce2-b6be-6efe-181c54f950a0@quicinc.com>
Date: Fri, 19 Jan 2024 22:30:22 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] mm, kmsan: fix infinite recursion due to RCU critical
 section
To: Marco Elver <elver@google.com>
CC: Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko
	<glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov
	<bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, <kasan-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <syzbot+93a9e8a3dea8d6085e12@syzkaller.appspotmail.com>
References: <20240118110022.2538350-1-elver@google.com>
 <CANpmjNPx0j-x_SDu777gaV1oOFuPmHV3xFfru56UzBXHnZhYLg@mail.gmail.com>
 <cd742d1d-70a3-586b-4bf5-fcfc94c75b4a@quicinc.com>
 <CANpmjNNZ6vV7DJ+SBGcSnV6qzkmH_J=WrofrfaAeidvSG2nHbQ@mail.gmail.com>
Content-Language: en-US
From: Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <CANpmjNNZ6vV7DJ+SBGcSnV6qzkmH_J=WrofrfaAeidvSG2nHbQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vwcSK_orfgT8C__2D3CJHzd-MY-j7Ask
X-Proofpoint-ORIG-GUID: vwcSK_orfgT8C__2D3CJHzd-MY-j7Ask
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-19_10,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=739 phishscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401190097



On 1/18/2024 5:52 PM, Marco Elver wrote:
> It would be nice to avoid duplicating functions - both options have downsides:
> 1. Shared pfn_valid(): it might break for KMSAN again in future if new
> recursion is introduced.
> 2. KMSAN-version of pfn_valid(): it might break if pfn_valid() changes
> in future.
> 
> I suspect #1 is less likely.
> 
> What is your main concern by switching to rcu_read_lock_sched()?

No concerns from my side. Just wanted to know the thought behind
changing the pfn_valid instead of kmsan version, like for some
functions. Thanks for the clarification.


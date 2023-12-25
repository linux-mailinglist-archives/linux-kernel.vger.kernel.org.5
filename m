Return-Path: <linux-kernel+bounces-10900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0A681DE8A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 07:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F68A1F213B3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 06:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CF015AF;
	Mon, 25 Dec 2023 06:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Vhqe498v"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB451846;
	Mon, 25 Dec 2023 06:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BP5xKoc008073;
	Mon, 25 Dec 2023 06:13:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=N0UEdLDAQUomhdx40Nl1VF0nJCvYxde5CcvFj+y08kQ=; b=Vh
	qe498vXsr/aOQ5X+JVPd8HqDVPgcXSr5xMvLeKOxQ1r3IZFM8F9KQBecptcIi1ka
	UGpKz9koyIz34FisDxHudcYkUgt7C5Qb8YoOVcFJ3p66z1NoQQ+9pvArUsGwuyr9
	0cjP7z++7zR2i9nNgPQMLE2GeneAF91ckRuCo2Fpp9PFvCUcBI141C7V+KeURw9E
	NXQZz4303LaQOzGA4SGH3dx/MD8Qhx0OPBM65oFHJG2WkmC4Al4/WIyWmzCVQB1C
	yVeGJfv2s0wWFBYFn4wRcLoM3ILeVjaeundGj7dF7heEidSgb0aGAe7iOr89qHDj
	PVdF28u5T+KITqPm4U4g==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v5raku13w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Dec 2023 06:13:23 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BP6DMkg003579
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Dec 2023 06:13:22 GMT
Received: from [10.239.132.150] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 24 Dec
 2023 22:13:17 -0800
Message-ID: <52ee95c2-1118-4f44-85e0-862ac5f83257@quicinc.com>
Date: Mon, 25 Dec 2023 14:13:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pinctrl: Add lock to ensure the state atomization
Content-Language: en-US
To: Linus Walleij <linus.walleij@linaro.org>
CC: <andersson@kernel.org>, <kernel@quicinc.com>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <20231212090611.950-1-quic_aiquny@quicinc.com>
 <CACRpkdb6dkw58GwkqYXTDAQtdLazOLyp1CEjnkxDX2v=TDvvMw@mail.gmail.com>
From: "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>
In-Reply-To: <CACRpkdb6dkw58GwkqYXTDAQtdLazOLyp1CEjnkxDX2v=TDvvMw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4cjNcax0jBjGDfAU6EmVVsuUhFJN9NjC
X-Proofpoint-GUID: 4cjNcax0jBjGDfAU6EmVVsuUhFJN9NjC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=674 clxscore=1011
 phishscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312250044



On 12/20/2023 7:02 PM, Linus Walleij wrote:
> Hi Maria,
> 
> On Tue, Dec 12, 2023 at 10:06 AM Maria Yu <quic_aiquny@quicinc.com> wrote:
> 
>> Currently pinctrl_select_state is an export symbol and don't have
>> effective re-entrance protect design. During async probing of devices
>> it's possible to end up in pinctrl_select_state() from multiple
>> contexts simultaneously, so make it thread safe.
>> More over, when the real racy happened, the system frequently have
>> printk message like:
>>    "not freeing pin xx (xxx) as part of deactivating group xxx - it is
>> already used for some other setting".
>> Finally the system crashed after the flood log.
>> Add per pinctrl lock to ensure the old state and new state transition
>> atomization.
>> Also move dev error print message outside the region with interrupts
>> disabled.
>>
>> Fixes: 4198a9b57106 ("pinctrl: avoid reload of p state in list iteration")
>> Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>
> 
> Overall this looks good!
> 
>> @@ -1262,9 +1263,12 @@ static void pinctrl_link_add(struct pinctrl_dev *pctldev,
>>   static int pinctrl_commit_state(struct pinctrl *p, struct pinctrl_state *state)
>>   {
>>          struct pinctrl_setting *setting, *setting2;
>> -       struct pinctrl_state *old_state = READ_ONCE(p->state);
>> +       struct pinctrl_state *old_state;
>>          int ret;
>> +       unsigned long flags;
>>
>> +       spin_lock_irqsave(&p->lock, flags);
> (...)
>> +       spin_unlock_irqrestore(&p->lock, flags);
> (...)
>> +       spin_unlock_irqrestore(&p->lock, flags);
> 
> Is it possible to use a scoped guard for pinctrl_commit_state()?
Good idea.
I will address this in next patchset.
> 
> #include <linux/cleanup.h>
> guard(spinlock_irqsave)(&p->lock);
> 
> It saves some code (and no need for flags) and avoid possible
> bugs when people add new errorpaths to the code.
> 
> Yours,
> Linus Walleij

-- 
Thx and BRs,
Aiqun(Maria) Yu


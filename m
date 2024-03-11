Return-Path: <linux-kernel+bounces-99272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5778785BB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3EA32816CF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C941482D1;
	Mon, 11 Mar 2024 16:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WJcB55+c"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1110B4594B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 16:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710175872; cv=none; b=VliVZuCrYJcyFRqM6LiCePrktb5/7jvAMliigjx9xuyM8RSruV7dx6hn2ui+vx+BE0+lp93787ZLdSr3Lex6C+H9bDJZGIPvMr+dUuF/pLG99iwTm0eFZV75n6ibuIM7f7dMJYl9MQmFdEBL7Lb9s0xfy9Cjh71JjZcr1im6h2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710175872; c=relaxed/simple;
	bh=L+hP3J9w7TVemLYSE/M0D2h13kOJTurWbr3SO4jI8Hs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=GHxhva84PApDB6by8N7Ntpd4q/mreM/TlKZHg7xFOJbsyeSdfq2j/p6RZsFcE8t54Rg1sy7HDmmEMR9pzM1H/Ysw4kSo3eOUDceKiAFxURkH5XRsNL0npA073vaaZpoy1gTAyl/bRrIt3+EtwZDN7hwIFalOY+Ansf5xsy7JyP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=WJcB55+c; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240311165107euoutp0173da651116376dcfd20eda16ca1f4bc5~7w_QPj6RK0965009650euoutp01b
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 16:51:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240311165107euoutp0173da651116376dcfd20eda16ca1f4bc5~7w_QPj6RK0965009650euoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1710175867;
	bh=Vi9mqEbEYH5UErZGlgVb79jweozgjkT+UlULfp68xt4=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=WJcB55+cmcqjGu1+a+a4X9cgGRcG6ze/0lPK84xSmS9IoD21ZvhgNEPj+oKKE2AO4
	 nvQqQi/9DtM+lULe4n4DLMm0xM3Un2sxe726A+KbEOMb4Gkj7vkLMTMEs4AZzgkaPX
	 9MgF2ug/1b/+ZaXfSXMMNl5T3/mygsZLZu+fAKKY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240311165106eucas1p22bd86ad0e3b0a2d77b77fe8d4ce0a18c~7w_PCpnL22314023140eucas1p2O;
	Mon, 11 Mar 2024 16:51:06 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id E3.07.09539.A763FE56; Mon, 11
	Mar 2024 16:51:06 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240311165105eucas1p10ffea50ffb9581c61818e66628fdafee~7w_OjQxeK0826108261eucas1p1V;
	Mon, 11 Mar 2024 16:51:05 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240311165105eusmtrp1b2d135d8a79edf681de0688224c0e22f~7w_Oihxew2079320793eusmtrp1K;
	Mon, 11 Mar 2024 16:51:05 +0000 (GMT)
X-AuditID: cbfec7f2-515ff70000002543-5a-65ef367aa56e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 09.60.10702.9763FE56; Mon, 11
	Mar 2024 16:51:05 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240311165104eusmtip2eb55a56d190fd53be45bb715c73da79d~7w_NZS4mH2032720327eusmtip2j;
	Mon, 11 Mar 2024 16:51:04 +0000 (GMT)
Message-ID: <8c8aea4d-e911-44cd-bbec-ead4e44d338a@samsung.com>
Date: Mon, 11 Mar 2024 17:51:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ARM64: Dynamically allocate cpumasks and increase
 supported CPUs to 512
Content-Language: en-US
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "Christoph Lameter (Ampere)"
	<cl@linux.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
	Will Deacon <will@kernel.org>, Jonathan.Cameron@huawei.com,
	Matteo.Carlini@arm.com, Valentin.Schneider@arm.com,
	akpm@linux-foundation.org, anshuman.khandual@arm.com, Eric Mackay
	<eric.mackay@oracle.com>, dave.kleikamp@oracle.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux@armlinux.org.uk, robin.murphy@arm.com,
	vanshikonda@os.amperecomputing.com, yang@os.amperecomputing.com, Nishanth
	Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <Ze8hmCbN7_GDRMVS@arm.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf1CTdRzH7/s8z7aHwfRxmvuede5uHXVWYJwK30vjLCmfKz3huP6pzLbx
	hJyAu21U4p0uAkpgSNTc2G1tGQEHu4gpjrQEJjk4GPHDNtwRKMySxRCcJ8zljPFk8d/r8/68
	v9/35/O9L4kLtdxNZF6hmlEWSvMlXD5x4Wp4MKk49Q7zYnmnCJlabVx0uVeO7jRUAeS9PwtQ
	1x8jOLoVbeCh5m88XGSf9nDQ6EUTF03YHnFQSNsDkFP3M0DfeYcxFGlYxNDskhtD5ns6HHXP
	+zko6mkjkMMSxtGMb5xA525c5aLS8R1IW9/H2y2ibV/bAD3qGcbp0p4gh7Y3n+LS9ru1PLrX
	ECFo/zU9Rp+rP0kv3PIRdOXoGI92jTkwOmTfnJnwNn9XDpOf9yGj3Jr+Pv+wW3cdKNrXfjwT
	OY1rwEhCBYgjIbUdTlRFOBWATwqpJgBdlr8xtrgHYFm9H2eLEICfTp/nPD7S3GRYYSHVCODZ
	gWLWtACgs6WWiDUEVDpc8NzgxpigEuFPPWYOq6+DfXX+Fc8TlBhO+gy8GK+npDDgsOIxxikR
	9PktWIw3UElwqPwrgtWvcaAvrI4xl0qBFcGKlfvjqGdh3UzJvx4xdARNODtoCR9GK2mWM2Bn
	9bcYy+thwHWex/JTsP/LKiK2AKQ+A9AamcTYogZAzZ8+wLp2wvHBB8tp5HLCFth6cSsrvwID
	1a28mAypNXAsuI6dYQ2svaDHWVkAPy8Xsu5noNH1/X+x3UMjeA2QGFe9inHV9sZV2xj/z7UC
	ohmImCJVQS6jSilkPkpWSQtURYW5yfKjBXaw/GP7o667HcAcWEh2AowETgBJXLJB8NcLQUYo
	yJEeK2aURw8pi/IZlRM8SRISkSAxR8wIqVypmjnCMApG+biLkXGbNJjiePtuXaLsdrZVHjr4
	WnRRHgCGRzf79v7gii94o2tAs0fX7yudT6rN3Lj55eore5iDqX0yeZyl9xdyYC6QPqTGta9O
	vScCYlHqvitZHdtCVtupbUsHpt7NipfRRNfJqswjHbf384fND4Z+vWR6+v5gW1rGhFsG88UP
	pz6oiJ/0nFG2zaYl7c+KvBM+rR4Lpb25b69MZ25frNHWCb9Q1b++XfMj/hJX34IuT4ct2pzw
	3HXv/G8l4hPHGyvLbL5pzBY5cWxuaYf3oallYIs7u1uRQMOytOzWnYfkvN8duRuD+jzDW5eK
	8TMZ7qZOfan3rKJxaW7XTX/XJy6T7cDzayWE6rA05TlcqZL+A6Bj2IggBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsVy+t/xe7qVZu9TDS6fNbKYs34Nm8W+E8kW
	75f1MFpc//aG0eLAs0vMFk//LWO3WLXwGpvFpsfXWC0u75rDZnFvzX9Wi8+9RxgtDk3dy2ix
	9PpFJovfy74zWbz5cZbJYu6XqcwWBz88YbX4d20ji8X2+T+ZLV7eusNisfnBMTaLljumFr1L
	TrI7iHusmbeG0ePytYvMHi1H3rJ6bFrVyeax6dMkdo8TM36zeDy5Mp3JY/OSeo+PT2+xeHRf
	vsHucfzGdiaPz5vkAnii9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxS
	UnMyy1KL9O0S9DLOTr3JWLCVv+Ll737mBsZLPF2MnBwSAiYSq1bMYO1i5OIQEljKKPHtK4gD
	kpCRODmtAcoWlvhzrYsNoug9o8T515/ZQRK8AnYSH689YAOxWQRUJfYcmcsKEReUODnzCQuI
	LSogL3H/1gywemGBRIlX2xcwg9jMAuISt57MZwKxRQR0JS60TWEBWcAscI1V4tSPo1DbdjNL
	NJ3/CVbFJmAo0fW2C2wbp4C6xMyXTSwQk8wkurZ2MULY8hLb385hnsAoNAvJIbOQLJyFpGUW
	kpYFjCyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAhPLtmM/t+xgXPnqo94hRiYOxkOMEhzM
	SiK8r3XepgrxpiRWVqUW5ccXleakFh9iNAWGxkRmKdHkfGBqyyuJNzQzMDU0MbM0MLU0M1YS
	5/Us6EgUEkhPLEnNTk0tSC2C6WPi4JRqYMrmOppQM5enJGbOT87DUzfrrV4f+VK0LLJ/0df6
	mN8J213WPtRoe3/w3M8IoxqZSTaZtr/DtC5Jqd4s2u+QvuHYVtPkI/c+Z7HflRALlpbV0nht
	OPn9VgWps7umlzf0Ldka/VpKdof6/d3hwbe9jiRy/ZW9dpDr6ZWat0/LdB43OsZ1TZSzl6vn
	ln3xJHFWom+t6navgDM/g1JvsU+0NjP6cZN7Sq3XlCMPzi8S89vG/XJu8/LVjyu6nrt6rw37
	tHA33xS3Bl8JnTSp77FVRf1RzyebH5gSXPMq/Ob9bMGo66e0JoqvsOj44161gqGz/61N0t6O
	uuMZSZ0T3Z90lM/ye/TY5Kd7kc2ziD1yK5VYijMSDbWYi4oTAdOnA2S1AwAA
X-CMS-MailID: 20240311165105eucas1p10ffea50ffb9581c61818e66628fdafee
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240308140130eucas1p1259c805a0b6491ce2f69c6fca0264b1f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240308140130eucas1p1259c805a0b6491ce2f69c6fca0264b1f
References: <37099a57-b655-3b3a-56d0-5f7fbd49d7db@gentwo.org>
	<CGME20240308140130eucas1p1259c805a0b6491ce2f69c6fca0264b1f@eucas1p1.samsung.com>
	<c1f2902d-cefc-4122-9b86-d1d32911f590@samsung.com>
	<ZesmAO1jJfEjTwxd@arm.com>
	<f160a532-1d31-41a7-b8ae-de8575c395e9@samsung.com>
	<e3952dc0-ec28-e7c7-e858-c47f146c93de@linux.com>
	<Ze71H4AdY786nSvn@FVFF77S0Q05N>
	<8abb1a69-6cbd-4a36-ab1d-d269cdafa391@samsung.com>
	<Ze8hmCbN7_GDRMVS@arm.com>

Hi Catalin,

On 11.03.2024 16:22, Catalin Marinas wrote:
> On Mon, Mar 11, 2024 at 03:56:37PM +0100, Marek Szyprowski wrote:
>> On 11.03.2024 13:12, Mark Rutland wrote:
>>> On Fri, Mar 08, 2024 at 09:08:59AM -0800, Christoph Lameter (Ampere) wrote:
>>>> On Fri, 8 Mar 2024, Marek Szyprowski wrote:
>>>>>>> It looks that cpufreq-dt and/or opp drivers needs some adjustments
>>>>>>> related with this change.
>>>>>> That's strange. Is this with defconfig? I wonder whether NR_CPUS being
>>>>>> larger caused the issue with this specific code. Otherwise
>>>>>> CPUMASK_OFFSTACK may not work that well on arm64.
>>>> cpumask handling must use the accessor functions provided in
>>>> include/linux/cpumask.h for declaring and accessing cpumasks. It is likely
>>>> related to the driver opencoding one of the accessors.
>>> I took a look at both the OPP code and the cpufreq-dt code and it looks like
>>> those are doign the right thing w.r.t. cpumask manipulation (i.e. they only use
>>> the cpumask accessors, and use the cpumask_var_*() functions to dynamically
>>> allocate/free cpumasks). Maybe I've missed something, but superficially those
>>> look right.
>>>
>>> Marek, can you try reverting this commit and trying defconfig + NR_CPUS=512?
>> Yes, with $subject reverted and CONFIG_NR_CPUS=512 everything works
>> fine, so it must be something else broken.
> Thanks for confirming. Would you mind testing the problematic commit
> with CONFIG_DEBUG_PER_CPU_MAPS enabled? If it doesn't show anything
> obvious that can be fixed quickly, I'll revert the commit and queue it
> again after -rc1 for 6.10 (I haven't sent 6.9 the pull request yet).

I've enabled this option, but unfortunately it didn't reveal anything 
more besides the warning and error I've posted in my initial report. I 
will try to analyze this issue further, but I won't manage to do this today.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland



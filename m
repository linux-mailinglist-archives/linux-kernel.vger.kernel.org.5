Return-Path: <linux-kernel+bounces-132868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED448899B72
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CC211C21EDC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2BD16ABEC;
	Fri,  5 Apr 2024 10:59:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F89416ABE0
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 10:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712314748; cv=none; b=gSQeHlyOYYjYfiy1kFRkisBYYkY1+/kQeCDAD/Mcmq5JUmzzjBabeb0TBtnOmzIkfWPXBAyLVRvlrcgYTDhoY4NVfMx9KtNOSd9tcyOlNmH4GRxXHSMIhfPEvJDZM5H1zB0KXDfbOsR61dtJzKPnRVQtpEX7nWo4wlhQ8tY1zZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712314748; c=relaxed/simple;
	bh=1079wHou7MlgPZHBmpYDnM+oXgcgUBU2LPo1/2MD9ho=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JCBt/ONFCLOKqk9jpsoMdcKmbXFxOnvYv4WiMSKjiPsETqUZxlsZYyANrLBd5e37HDZBA42KY9121lPxMvth2dh+9dWprH4bQ1qyBX8nBKDUXD4o7MYBdSH455QqZ3L5PxbBdg9r7M2nagSRbT6wZ0Xs5436MR1En8u+Fy2uOao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9D3DFEC;
	Fri,  5 Apr 2024 03:59:35 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 644B73F7B4;
	Fri,  5 Apr 2024 03:59:03 -0700 (PDT)
Message-ID: <3e2558cf-6b25-4e1b-92ab-a248cdf7b271@arm.com>
Date: Fri, 5 Apr 2024 12:59:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] sched/fair: allow disabling sched_balance_newidle
 with sched_relax_domain_level
Content-Language: en-US
To: Vitalii Bursov <vitaly@bursov.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org, Shrikanth Hegde <sshegde@linux.ibm.com>
References: <cover.1712147341.git.vitaly@bursov.com>
 <3bf726af-e519-4cc2-a692-19a0cf99fca7@arm.com>
 <87543226-1edd-4692-84b5-31bac9cb0c5d@bursov.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <87543226-1edd-4692-84b5-31bac9cb0c5d@bursov.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/04/2024 12:25, Vitalii Bursov wrote:
> 
> 
> On 05.04.24 12:17, Dietmar Eggemann wrote:
>> On 03/04/2024 15:28, Vitalii Bursov wrote:

[...]

>>>> ====== ===========================================================
>>>>   -1   no request. use system default or follow request of others.
>>>>    0   no search.
>>>>    1   search siblings (hyperthreads in a core).
>>>>    2   search cores in a package.
>>>>    3   search cpus in a node [= system wide on non-NUMA system]
>>>>    4   search nodes in a chunk of node [on NUMA system]
>>>>    5   search system wide [on NUMA system]
>>>> ====== ===========================================================
>>
>> IMHO, this list misses: 
>>
>>       2   search cores in a cluster.
>>
>> Related to CONFIG_SCHED_CLUSTER.
>> Like you mentioned, if CONFIG_SCHED_CLUSTER is not configured MC becomes
>> level=1.
> 
> Previous discussion in v2 on this topic:
> https://lore.kernel.org/linux-kernel/78c60269-5aee-45d7-8014-2c0188f972da@bursov.com/T/#maf4ad0ef3b8c18c8bb3e3524c683b6459c6f7f64

Sorry, I missed this discussion.

I thought that SCHED_CLUSTER is based on shared L3 tags (Arm64
kunpeng920) or L2 cache (X86 Jacobsville) so it's similar to SCHED_MC
just one level down?

> The table certainly depends on the kernel configuraion and describing this
> dependency in detail probably isn't worth it, so how the table should look
> like in the documentation is debatable...

[...]


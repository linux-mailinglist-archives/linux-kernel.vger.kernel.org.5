Return-Path: <linux-kernel+bounces-106897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 541A887F529
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 02:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8B341F21AE0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 01:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E860D64CD1;
	Tue, 19 Mar 2024 01:48:56 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.124.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20CE64CE8
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 01:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.124.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710812936; cv=none; b=JF12yTVYQOemOpEJGgnIXg/A/PDG4PJZJjx4C/ufhlGo92DxeXcpkvh+LWeKlNAUNVplG1tK1Y9T3hmaJ6wuJUNDkxhcp8Vp91jFtSVFZTtyDt9edWzQeQ5vkfOWSU3Tdo0aCkwMYHknpzTgQQD+TTJVYhKlTVvkv2nIsRkDHT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710812936; c=relaxed/simple;
	bh=vIuX7v/1lkLgY2fOi60Jxyk4Xs4mf3t/50VIOV3Ewqc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=txtC2N/a3665oF4k6Pvj2y7LXIOoKl22GNE0BeDCpzl8ApU1xvwKQ74j1TCSqhUq8Gsnq08TcwUfMTYF9t4v/LOnhrk91Mv2sBiEHHUp8r/y1R+s/jnqDUCd7toADGPLuXTHgQemvUFgZ1iAiD8GWJ5/gk2Jl4BPFAr3GT7YHyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=114.132.124.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtp87t1710812787txn79iic
X-QQ-Originating-IP: nn20Uw5fBjQGjECP/p7Tcj6Nc3iToFw+wfLTiBd77ls=
Received: from [10.7.13.112] ( [125.76.217.162])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 19 Mar 2024 09:46:25 +0800 (CST)
X-QQ-SSF: 01400000000000D0I000000A0000000
X-QQ-FEAT: eSZ1CZgv+JDqNoDswHbdN6UkMSJdNx7bqXAFK4WPcUlEHxtEbTEJnQFMwJTO5
	RTO+LnPR5Krhjq5ZGeDmTEYJ8MNnDG6gjOBpp9Ax11jUQqgCj2F4oEcGb2jEJtbqQboOKms
	ncYHQS/5cqIojItGaDrHSmLMScUoHqClPii5bL1Xm2MXXU03qfCIAE2F1kGxSaDdocKhoaS
	NF80/FJERbewbsukgZ/bMN8yz4utTxXn3QmDOBX0qaSRbzT7y4T6EM4O7dI/MHJp0E7Q2aj
	0FB4UXI0uh8mqiOZflL/TJio1G+NwKxlQzWQ0r0zo77Ovh0OicFEWtVNLRucq6d8HPWYsyo
	5+1h6kABdrNxjUxYgC4IVyqDbCTyamY/Vnx8TkOvOrscPHC6Ow=
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15793990951295875605
Subject: Re: [PATCH v2] locking/osq_lock: Optimize osq_lock performance using
 per-NUMA
To: David Laight <David.Laight@ACULAB.COM>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "mingo@redhat.com" <mingo@redhat.com>, "will@kernel.org" <will@kernel.org>,
 "longman@redhat.com" <longman@redhat.com>,
 "boqun.feng@gmail.com" <boqun.feng@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240318055023.25546-1-guohui@uniontech.com>
 <e8e933ab37f84ac68ac70f4b1ed8d524@AcuMS.aculab.com>
From: Guo Hui <guohui@uniontech.com>
Message-ID: <660FFEAB399D5815+aa201e41-b902-3fa3-fb4a-333a166b9cd4@uniontech.com>
Date: Tue, 19 Mar 2024 09:46:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <e8e933ab37f84ac68ac70f4b1ed8d524@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4a-0


On 3/18/24 5:47 PM, David Laight wrote:
> From: Guo Hui
>> Sent: 18 March 2024 05:50
>>
>> Changes in version v1:
>> The queue is divided according to NUMA nodes,
>> but the tail of each NUMA node is still stored
>> in the structure optimistic_spin_queue.
> The description should be before any 'changes'.
> The changes between versions don't go into the commit message.
>
> Does this change affect a real workload, or just some benchmark?
>
> In reality you don't want a lot of threads waiting on a single
> lock (of any kind).
> So if a real workload is getting a long queue of waiters on
> an OSQ lock then the underlying code really needs fixing to
> 'not do that' (either by changing the way the lock is held
> or acquired).
>
> The whole osq lock is actually quite strange.
> (I worked out how it all worked a while ago.)
> It is an ordered queue of threads waiting for the thread
> spinning on a mutex/rwlock to either obtain the mutex or
> to give up spinning and sleep.
> I suspect that the main benefit over spinning on the mutex
> itself is the fact that it is ordered.
> It also remove the 'herd of wildebeest' doing a cmpxchg - but
> one will win and the others do back to a non-locked poll.
>
> Are the gains you are seeing from the osq-lock code itself,
> or because the thread that ultimately holds the mutex is running
> on the same NUMA node as the previous thread than held the mutex?

This is because the thread that ultimately holds the mutex is running on 
the same NUMA node as the previous thread than held the mutex.



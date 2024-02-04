Return-Path: <linux-kernel+bounces-51335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B62148489EA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 02:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0036B23C6B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 01:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD99CEBE;
	Sun,  4 Feb 2024 01:16:49 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C7B10F1;
	Sun,  4 Feb 2024 01:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707009409; cv=none; b=ngTch6DKx//eJQcwFGVeNUKQ+tcmrqMlmREJ4C5SIOenOHt4CZUgGp185oB5T9ZrJbUx4G8rfarAIyesRYLCnrvXR184udkFLLIweDRI32x2ZZQffr+ja3aDc0ZACKk2fgbp8fj+1RQjZ3rEStGVXeVr6RhP/5cn/JY6nxKB0zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707009409; c=relaxed/simple;
	bh=kXAxuf/NRu62ybdEKHkf0EJhPGPJTi5CpcwG4gK4aNs=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PsGZRdX9x9etZDKVdJ9R+wsMXeVqMU1/4w3dGo8j2cpNuxruIayCztBJDA/EMYRTMUCjGqgZ8wQ4vNc3APMDR+2FRjo9z8aCgy5E07E+obs8O20+qmGZfoynXfpl/IiT0wijVqpYN/LUEmert8aJN0/bfCYcVEBuRX0visDP4iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TSBPp0JJlzvRdm;
	Sun,  4 Feb 2024 09:14:54 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (unknown [7.193.23.202])
	by mail.maildlp.com (Postfix) with ESMTPS id A934B140258;
	Sun,  4 Feb 2024 09:16:37 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 4 Feb 2024 09:16:36 +0800
Subject: Re: [RFC PATCH] kprobes: Use synchronize_rcu_tasks_rude in
 kprobe_optimizer
To: <paulmck@kernel.org>
CC: Chen Zhongjin <chenzhongjin@huawei.com>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <naveen.n.rao@linux.ibm.com>,
	<anil.s.keshavamurthy@intel.com>, <davem@davemloft.net>,
	<mhiramat@kernel.org>, <akpm@linux-foundation.org>, <tglx@linutronix.de>,
	<peterz@infradead.org>, <pmladek@suse.com>, <dianders@chromium.org>,
	<npiggin@gmail.com>, <mpe@ellerman.id.au>, <jkl820.git@gmail.com>,
	<juerg.haefliger@canonical.com>, <rick.p.edgecombe@intel.com>,
	<eric.devolder@oracle.com>, <mic@digikod.net>
References: <20240102034024.256326-1-chenzhongjin@huawei.com>
 <29eaed4d-c4e5-cf9b-113b-da146b719820@huawei.com>
 <d7cb96d8-86e1-423d-a135-46b4e472fe9e@paulmck-laptop>
 <d7dfe177-6bfb-63c2-9be5-6ad25c8c243e@huawei.com>
 <d970cda7-bf17-49c5-85b9-7596beb3690b@paulmck-laptop>
From: Yang Jihong <yangjihong1@huawei.com>
Message-ID: <bbeebd04-f8c2-866b-0016-79778c64cab8@huawei.com>
Date: Sun, 4 Feb 2024 09:16:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <d970cda7-bf17-49c5-85b9-7596beb3690b@paulmck-laptop>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600003.china.huawei.com (7.193.23.202)

Hello,

On 2024/2/4 6:00, Paul E. McKenney wrote:
> On Mon, Jan 29, 2024 at 08:58:10AM +0800, Yang Jihong wrote:
>> Hello,
>>
>> On 2024/1/28 3:22, Paul E. McKenney wrote:
>>> On Tue, Jan 09, 2024 at 07:28:29PM +0800, Yang Jihong wrote:
>>>> Hello,
>>>>
>>>> PING.
>>>>
>>>> I had a similar problem. Is this solution feasible?
>>>
>>> Sadly, no.
>>>
>>> It fails on CONFIG_PREEMPT=y kernels because synchronize_rcu_tasks_rude()
>>> will not wait on tasks that have been preempted while executing in
>>> a trampoline.
>>>
>>> But could you please try out the patch shown at the end of this email?
>>
>> Thanks for the patch, yes, I've tested and it solves the problem.
> 
> Very good, and thank you for testing it!
> 
> May I apply your Tested-by to the commit to record your efforts for
> posterity?
> 
Sure absolutely.

Tested-by: Yang Jihong <yangjihong1@huawei.com>

Thanks,
Yang


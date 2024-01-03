Return-Path: <linux-kernel+bounces-15088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 588EA822721
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 03:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E752B284AE6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 02:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F091E1798F;
	Wed,  3 Jan 2024 02:47:41 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B5717984
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 02:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4T4Yxm0MQ9z1Q7Sd;
	Wed,  3 Jan 2024 10:46:04 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id E5ECD140444;
	Wed,  3 Jan 2024 10:47:14 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 10:47:14 +0800
Subject: Re: [PATCH v2 2/2] mm: memory-failure: Re-split hw-poisoned huge page
 on -EAGAIN
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, Andrew Morton
	<akpm@linux-foundation.org>
CC: "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>, "Luck, Tony"
	<tony.luck@intel.com>, "Huang, Ying" <ying.huang@intel.com>, "Yin, Fengwei"
	<fengwei.yin@intel.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20231215081204.8802-1-qiuxu.zhuo@intel.com>
 <20231222062706.5221-1-qiuxu.zhuo@intel.com>
 <20231222062706.5221-2-qiuxu.zhuo@intel.com>
 <20231222114233.68a4fcf2428ae50da6b249f4@linux-foundation.org>
 <CY8PR11MB7134D3ADA0BCDAB938E6E2A58961A@CY8PR11MB7134.namprd11.prod.outlook.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <bb76102e-bfe7-ea96-3e26-be68752d1664@huawei.com>
Date: Wed, 3 Jan 2024 10:47:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CY8PR11MB7134D3ADA0BCDAB938E6E2A58961A@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/1/2 10:41, Zhuo, Qiuxu wrote:
>> From: Andrew Morton <akpm@linux-foundation.org>
> 
> Hi Andrew, 
> 
> Happy New Year. 
> Thanks for reviewing the patch.
> Please see the comments inline.
> 
>> ...
>>
>> So we're hoping that when the worker runs to split the page, the process and
>> its threads have exited.  What guarantees this timing?
> 
> Case 1: If the threads of the victim process do not access the new mapping to 
> the h/w-poisoned huge page(no refcnt increase), the h/w-poisoned huge page
> should be successfully split in the process context. No need for the worker to
> split this h/w-poisoned page.
> 
> Case 2: If the threads of the victim process access the new mapping to the
> hardware-poisoned huge page (refcnt increase), causing the failure of splitting
> the hardware-poisoned huge page, a new MCE will be re-triggered immediately.
> Consequently, the process will be promptly terminated upon re-entering the
> code below:
> 
> MCE occurs:
>   memory_failure()
>   {
>     { 
>       ...
>       if (TestSetPageHWPoison(p)) {
>       ...
>       kill_accessing_process(current, pfn, flags); 
>       ...
> 	}
>       ...
>   }
> 
> The worker splits the h/w-poisoned background with retry delays of 1ms, 2ms,
> 4ms, 8ms, ..., 512ms. Before reaching the max 512ms timeout, the process and
> its threads should already exit. So, the retry delays can guarantee the timing.
> 
>> And we're hoping that the worker has split the page before userspace
>> attempts to restart the process.  What guarantees this timing?
> 
> Our experiments showed that an immediate restart of the victim process was
> consistently successful. This success could be attributed to the duration between
> the process being killed and its subsequent restart being sufficiently long,
> allowing the worker enough time to split the hardware-poisoned page.
> However, in theory, this timing indeed isn't guaranteed.
> 
>> All this reliance upon fortunate timing sounds rather unreliable, doesn't it?
> 
> The timing of the victim process exit can be guaranteed.
> The timing of the new restart of the process cannot be guaranteed in theory.
> 
> The patch is not perfect, but it still provides the victim process with the
> opportunity to be restarted successfully.

Will it be better if affected process could try re-splitting the hw-poisoned huge page itself before
returning to userspace? Each affected process (including possible later restarted process) will try
re-splitting huge page in that case and the last one without any competitor will get the work done.
So the delayed work is not needed. Will this provide more reliance?

Thanks.

> 
> Thanks!
> -Qiuxu
> 



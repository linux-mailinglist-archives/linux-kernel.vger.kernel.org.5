Return-Path: <linux-kernel+bounces-126430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 708FA8937DB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 05:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2249C1F214B0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 03:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBBF53A6;
	Mon,  1 Apr 2024 03:42:09 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654B61C2D;
	Mon,  1 Apr 2024 03:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711942929; cv=none; b=mkEEPWcHUzikOXzYJQLX6tmD+DA4NWANTUui2jzEys595PffYp5M6ZrGehN59ERlQEbk9BvTwLV96xIhInL0MZqocaFLTidR7WkEjKtsWixnvFCCkFSWComQc+cdNajzY2efD3yBtUmi0zv/j3aSzudjm/WI3lFB7n7z9kt+bgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711942929; c=relaxed/simple;
	bh=a+JpqQxOqGrevfZ2IfFKr9WZ5JQPbhyEgjhI9+DlzHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qOxomNB4FOrjuqgnhNNuoocSI/cDMafDPLNvnUKD3vGJJeqLJ7/UKoUMo88vVVmG6/0nSLiGquL+E6MNXY6AMbTYlU9Wz3FOHy9wBbOqWwEsR1z0gcfCb3bZIOH21y7DOJKFqc5v7peOPSN9FEEntJ3EVoQbNJ7drdDkhcgRNXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4V7GyV6Y8Mz1GFF5;
	Mon,  1 Apr 2024 11:41:22 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (unknown [7.193.23.234])
	by mail.maildlp.com (Postfix) with ESMTPS id DACAF1402D0;
	Mon,  1 Apr 2024 11:41:58 +0800 (CST)
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 1 Apr 2024 11:41:57 +0800
Message-ID: <8d6f9dd6-0171-4bcb-d611-1f522a1e8c8c@huawei.com>
Date: Mon, 1 Apr 2024 11:41:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH -next v5 2/3] x86/mce: set MCE_IN_KERNEL_COPYIN for
 DEFAULT_MCE_SAFE exception
To: Borislav Petkov <bp@alien8.de>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	<wangkefeng.wang@huawei.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Tony Luck
	<tony.luck@intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Naoya
 Horiguchi <naoya.horiguchi@nec.com>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <linux-mm@kvack.org>, Guohanjun
	<guohanjun@huawei.com>
References: <20240204082627.3892816-1-tongtiangen@huawei.com>
 <20240204082627.3892816-3-tongtiangen@huawei.com>
 <20240207122942.GRZcN3tqWkV-WE-pak@fat_crate.local>
 <100198dd-320f-68e6-9c09-210620940a74@huawei.com>
 <20240327220511.GCZgSYF6lJ3U1CaKV0@fat_crate.local>
From: Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <20240327220511.GCZgSYF6lJ3U1CaKV0@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600017.china.huawei.com (7.193.23.234)



在 2024/3/28 6:05, Borislav Petkov 写道:
> On Sun, Feb 18, 2024 at 06:08:14PM +0800, Tong Tiangen wrote:
>> 1. The copy_mc_to_kernel() is used in the coredump, KSM, and COW
>> scenarios, in these scenarios, the src mem stores the user data and the
>> kernel use kernel address to access the src mem(using kmap()).
>>
>> 2. the src mem of copy_mc_to_user() is currently only used by the DAX:
> 
> You mean just because it currently is used somewhere which probably is
> ok - no clue what DAX does - and even if the source address is still
> *kernel* memory and even at the danger that someone else might use it in
> the future and think the handling on a potential #MC is ok, you're still
> arguing that this is the right thing to do perhaps because it fits your
> use case?!
> 
> Sorry Tiangen, not gonna happen.
> 

I left the office last week and felt sorry for the lateness of the
reply.

You are right. Our current processing is based on "experience" rather
than interface constraints.

is_copy_from_user() determines whether a user is a "copy user" based on
fault_in_kernel_space(). Therefore, it returns false for
copy_mc_to_kernel()/copy_mc_to_user(). As a result, MCE_IN_KERNEL_COPYIN
cannot be set in error_context().

Comprehensive consideration of all factors, it is better to manually
call memory_failure_queue() to handle this problem case by case.

Finally, do we consider accepting only the patch 1/3 ?

Thanks,
Tong.


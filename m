Return-Path: <linux-kernel+bounces-39484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E7A83D1EA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 02:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC6BC1C236E4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E35DEBE;
	Fri, 26 Jan 2024 01:13:57 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC32387
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 01:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706231637; cv=none; b=GlK9t1Jh0q9DrlSh0moy8yO2k9URX1kamh09gAqz/KTq122zTPXbDaY4nKlm0yXzbkkpASJqvxqyPI9HpMltIxZJsuuXGFv3duVxOR7/t38heXv6KsOnnsa9WifcZLz0zzEDapV02fRJkSJiabUc8hA4MvUqCxcwoXRUz0gL6Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706231637; c=relaxed/simple;
	bh=kmX3SsIXx+Kjg1bu6KkGogcgnTNWWkTnm48itEw9niU=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Z7tjFTjeXx3v6yKeoedS5ufpQulpOKy3A/hjxoeeLZa8JIBjyIBX0l05v7WvouOGYHfowoYTMC0L80d4pd5ElrNji8du7ihmmoLXWcTBOFg0Iax/ow8oo1/buI/JuO+zXpFwRivNhaV3CogFxdO6oRs1qrCY0aT+KWTcSFT2MRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TLfnW06SWzsWZs;
	Fri, 26 Jan 2024 09:12:47 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id EEA4818007A;
	Fri, 26 Jan 2024 09:13:51 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 09:13:51 +0800
Subject: Re: [PATCH v2] mm/memory-failure: fix crash in
 split_huge_page_to_list from soft_offline_page
To: Matthew Wilcox <willy@infradead.org>
CC: <naoya.horiguchi@nec.com>, <akpm@linux-foundation.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20240124084014.1772906-1-linmiaohe@huawei.com>
 <ZbENgT-2dZHQQ90h@casper.infradead.org>
 <6d3f4822-8bc1-1551-b088-0a6d4c13f049@huawei.com>
 <ZbJursWt9Hp9kXac@casper.infradead.org>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <f548c1d5-5bd5-a7cd-ae59-ba7a59540a19@huawei.com>
Date: Fri, 26 Jan 2024 09:13:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZbJursWt9Hp9kXac@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/1/25 22:22, Matthew Wilcox wrote:
> On Thu, Jan 25, 2024 at 07:53:25PM +0800, Miaohe Lin wrote:
>> On 2024/1/24 21:15, Matthew Wilcox wrote:
>>>>   Call Trace:
>>>>    <TASK>
>>>>    ? die+0x32/0x90
>>>>    ? do_trap+0xde/0x110
>>>>    ? folio_memcg+0xaf/0xd0
>>>>    ? do_error_trap+0x60/0x80
>>>>    ? folio_memcg+0xaf/0xd0
>>>>    ? exc_invalid_op+0x53/0x70
>>>>    ? folio_memcg+0xaf/0xd0
>>>>    ? asm_exc_invalid_op+0x1a/0x20
>>>>    ? folio_memcg+0xaf/0xd0
>>>>    ? folio_memcg+0xae/0xd0
>>>
>>> I might trim these ? lines out of the backtrace ...
>>
>> Do you mean make backtrace looks like something below?
>>
>> Call Trace:
>>  <TASK>
>>  split_huge_page_to_list+0x4d/0x1380
>>  ? sysvec_apic_timer_interrupt+0xf/0x80
>>  try_to_split_thp_page+0x3a/0xf0
>>  soft_offline_page+0x1ea/0x8a0
>>  soft_offline_page_store+0x52/0x90
>>  kernfs_fop_write_iter+0x118/0x1b0
>>  vfs_write+0x30b/0x430
>>  ksys_write+0x5e/0xe0
>>  do_syscall_64+0xb0/0x1b0
>>  entry_SYSCALL_64_after_hwframe+0x6d/0x75
>> RIP: 0033:0x7f6c60d14697
> 
> Yes.  I'd trim the sysvec_apic_timer_interrupt+0xf/0x80 line too.
> These lines aren't actually part of the call trace.  They're addresses
> that the unwinder found on the stack but don't actually fit the call
> trace.  It puts them in in case they're helpful, but marks them with a ?
> to indicate that they're probably not part of the call trace.

I see. Many thanks for your explanation. Will update backtrace in next version.

Thanks.



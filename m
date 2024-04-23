Return-Path: <linux-kernel+bounces-154481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC218ADC7B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 05:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E99282165
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 03:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F19B1CA89;
	Tue, 23 Apr 2024 03:56:42 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5261B299
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 03:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713844602; cv=none; b=b7Rp2rkxOG4bFu8AbVXEkQcD0MsREhb/drdznkzv2fMA4biaPbG3VgAJXxLilHHWZC6QUHB82xZXk1jj3Bao9Q3Xl6rv20n+zr8L1EeuleKaNp6+p6bCkhS2wBXTsKAA4iZW13jHwd/LjLe962I+xU3yfMIaUJ76Ni/L+9puYfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713844602; c=relaxed/simple;
	bh=xqepy4509TkjFpK1FWOXAueRGcHmO2VDGfv+4TweNA4=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JOAnfioxsUBJ3UM9mgpmB2G0qqBsVumsbnSdNWlFWoomIHEkj7Lc9PYNOOs9jYGgtOWmua6Sf0IQ4ml9rW+Oc0F/9qnT4yus5Xh1TklyrzRxUiOD3J//u0/FjdUrEaLjCl/7RcxAjcRUGxObgEgaKZylp/5nvjvu8QSKquK0mDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VNpBR3m9zzvQ4Q;
	Tue, 23 Apr 2024 11:53:35 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 891CD1800C2;
	Tue, 23 Apr 2024 11:56:35 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 11:56:35 +0800
Subject: Re: [PATCH v2] mm/hugetlb: fix DEBUG_LOCKS_WARN_ON(1) when
 dissolve_free_hugetlb_folio()
To: Andrew Morton <akpm@linux-foundation.org>
CC: <muchun.song@linux.dev>, <mike.kravetz@oracle.com>, <osalvador@suse.de>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20240419085819.1901645-1-linmiaohe@huawei.com>
 <20240419141134.464ea3a1ef3d0e93c6711c93@linux-foundation.org>
 <000d75f3-6e16-6b91-7657-afb954773381@huawei.com>
 <20240422142115.25582386f7f02df817eab8ae@linux-foundation.org>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <7364e90a-1a55-21da-b579-52e7396fe266@huawei.com>
Date: Tue, 23 Apr 2024 11:56:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240422142115.25582386f7f02df817eab8ae@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/4/23 5:21, Andrew Morton wrote:
> On Sat, 20 Apr 2024 10:13:06 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
>> On 2024/4/20 5:11, Andrew Morton wrote:
>>> On Fri, 19 Apr 2024 16:58:19 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
>>>
>>>> When I did memory failure tests recently, below warning occurs:
>>>>
>>>> DEBUG_LOCKS_WARN_ON(1)
>>>> WARNING: CPU: 8 PID: 1011 at kernel/locking/lockdep.c:232 __lock_acquire+0xccb/0x1ca0
>>>> Modules linked in: mce_inject hwpoison_inject
>>>> CPU: 8 PID: 1011 Comm: bash Kdump: loaded Not tainted 6.9.0-rc3-next-20240410-00012-gdb69f219f4be #3
>>>>
>>>> ...
>>>>
>>>> --- a/mm/hugetlb.c
>>>> +++ b/mm/hugetlb.c
>>>> @@ -1773,7 +1773,7 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
>>>>  	 * If vmemmap pages were allocated above, then we need to clear the
>>>>  	 * hugetlb flag under the hugetlb lock.
>>>>  	 */
>>>> -	if (clear_flag) {
>>>> +	if (folio_test_hugetlb(folio)) {
>>>>  		spin_lock_irq(&hugetlb_lock);
>>>>  		__folio_clear_hugetlb(folio);
>>>>  		spin_unlock_irq(&hugetlb_lock);
>>>
>>> Please let's prepare backportable fixes against current mainline, not
>>> mm-unstable.  Because fixes against current -rcX and earlier will be
>>> upstreamed ahead of the mm-unstable and mm-stable material.
>>
>> Do you mean I need to send one fixup patch against mm-unstable and another
>> one against current mainline?
> 
> Against mainline should suffice.  I normally fix up the subsequent
> merge/build fallout.  If that gets too risky I'll ask for help or I'll
> outright drop mm-unstable patches and shall ask for a redo of those. 
> This is rare.

I see. Many thanks for your explanation. :)
Thanks.
.

> 
> .
> 



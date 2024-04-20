Return-Path: <linux-kernel+bounces-152088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8178AB8AC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 04:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 150D61C20CEB
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 02:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4905382;
	Sat, 20 Apr 2024 02:13:13 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB94010F7
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 02:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713579193; cv=none; b=ruoAbjHADZDhwMjSIeDXi36bbDccuQxiUngnZ/il9Pj9oO5bJJ2QiIUY7NNXtq1LRsyCdfv9vU580LuhpqWtgM1OauBZ1HOUzFGwRE0kxpHXfRB0GIKh0fTniWMeROC6kuPRbIOzVv5JIoPy4/WLbFsalzwVYaJexlaMpS56PWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713579193; c=relaxed/simple;
	bh=lYH2n/lx6u+DJGYnSMvCJ68VmUMqlZKofZzhtjsPZeM=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=GzxV1QFp4I+NzI4KEW+b9JYeyNnENKGHO6JOGCUru07r5zlVvonIj7SHxpp/RmbQ+SAfZmRHU0pNA62Otqa1qgZrCLOYMSB/pjVAgx3ezbDO5NAFUXCXVYLp0pKrCn0M7fiWEMNmeS+cbVgReBNIi8LW/z3hmFgibHRgr71cSMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VLw2K3Zttzcdln;
	Sat, 20 Apr 2024 10:10:01 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 7FD5618006C;
	Sat, 20 Apr 2024 10:13:07 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 20 Apr 2024 10:13:07 +0800
Subject: Re: [PATCH v2] mm/hugetlb: fix DEBUG_LOCKS_WARN_ON(1) when
 dissolve_free_hugetlb_folio()
To: Andrew Morton <akpm@linux-foundation.org>
CC: <muchun.song@linux.dev>, <mike.kravetz@oracle.com>, <osalvador@suse.de>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20240419085819.1901645-1-linmiaohe@huawei.com>
 <20240419141134.464ea3a1ef3d0e93c6711c93@linux-foundation.org>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <000d75f3-6e16-6b91-7657-afb954773381@huawei.com>
Date: Sat, 20 Apr 2024 10:13:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240419141134.464ea3a1ef3d0e93c6711c93@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/4/20 5:11, Andrew Morton wrote:
> On Fri, 19 Apr 2024 16:58:19 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
>> When I did memory failure tests recently, below warning occurs:
>>
>> DEBUG_LOCKS_WARN_ON(1)
>> WARNING: CPU: 8 PID: 1011 at kernel/locking/lockdep.c:232 __lock_acquire+0xccb/0x1ca0
>> Modules linked in: mce_inject hwpoison_inject
>> CPU: 8 PID: 1011 Comm: bash Kdump: loaded Not tainted 6.9.0-rc3-next-20240410-00012-gdb69f219f4be #3
>>
>> ...
>>
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -1773,7 +1773,7 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
>>  	 * If vmemmap pages were allocated above, then we need to clear the
>>  	 * hugetlb flag under the hugetlb lock.
>>  	 */
>> -	if (clear_flag) {
>> +	if (folio_test_hugetlb(folio)) {
>>  		spin_lock_irq(&hugetlb_lock);
>>  		__folio_clear_hugetlb(folio);
>>  		spin_unlock_irq(&hugetlb_lock);
> 
> Please let's prepare backportable fixes against current mainline, not
> mm-unstable.  Because fixes against current -rcX and earlier will be
> upstreamed ahead of the mm-unstable and mm-stable material.

Do you mean I need to send one fixup patch against mm-unstable and another
one against current mainline?

> 
> 
> I did this:
> 
> --- a/mm/hugetlb.c~mm-hugetlb-fix-debug_locks_warn_on1-when-dissolve_free_hugetlb_folio
> +++ a/mm/hugetlb.c
> @@ -1781,7 +1781,7 @@ static void __update_and_free_hugetlb_fo
>  	 * If vmemmap pages were allocated above, then we need to clear the
>  	 * hugetlb destructor under the hugetlb lock.
>  	 */
> -	if (clear_dtor) {
> +	if (folio_test_hugetlb(folio)) {

This looks good to me. Thanks for doing this. :)
Thanks.
.

>  		spin_lock_irq(&hugetlb_lock);
>  		__clear_hugetlb_destructor(h, folio);
>  		spin_unlock_irq(&hugetlb_lock);
> _
> 
> .
> 



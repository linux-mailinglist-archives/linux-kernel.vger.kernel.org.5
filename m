Return-Path: <linux-kernel+bounces-73947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB2E85CDE4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90CEC283460
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCE8101E2;
	Wed, 21 Feb 2024 02:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="GRJOmKG+"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E224F9CC
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 02:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708482070; cv=none; b=j649zVrOl7/+DjkADOCsFFXHNKNd/Vys80z8Q5AEhjNrZWF3zAHihyn/kJCu4q26OfY/u8H57O0hLFKAzXhmm9vFP/fBnb1im/WDvHnhQZYNheirpIyfIicXIOLgOiP//qzvo50n9KQIEaWOnO7DqnQZb1gpcpKsWCYh7MmUcro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708482070; c=relaxed/simple;
	bh=Y+0FnZUf2IjxkyMaZORz2P4JzBZ3C5j9BQT3XkwWWxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BAcwJy2cMZSxHQIHhfqtW3Svew15r4gx2iPd/hKPM+6K7IjB1Ysq8v1pjpvz6kJDnK4q1+YpAuDPw/b3ZhTKS5K6wm1jDmqby/VhxB0GhMggKHCzhTBn+GHh3n0FKB9OuB24chcsJRQLv9b3AMJdL4PMUEMV3H7w8fZHJRRX2cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=GRJOmKG+; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso73718a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 18:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1708482066; x=1709086866; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1R6afuU9qtN5hIRvEmeA6FfNqFs/docJ+nZZc128Tk=;
        b=GRJOmKG+tsgrhmKquEEH+nwbW190jvayWmLDIGe7jwm3jvXzZ3xEo2jjk/+IIPNWom
         PhVyZNT6w4wVP6dt6EOjUTbppY6qzf/h0R+3vEzY5G8Bbp0NdurxATQqc+E1nuJPsooc
         vLgP0H78aU4Hjf+Kl+3RQMumduUbUl41FB0Ik7iwUoL9BplQHq2lL0W9Fsi8YEDNwMRn
         m+2RAvGISobICHoIHFKLU1ZH0cxCpbkYTMI0b0XT4Ay2ZMDAaDpx3gl+xqzLkpdFZVB4
         45wf2PIyHTLn5sj3VNc2/6IpytVTM2P8bunF/bb2Z8wr+8DPubK2G9XP6ggT7sUM7MHH
         AnNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708482066; x=1709086866;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l1R6afuU9qtN5hIRvEmeA6FfNqFs/docJ+nZZc128Tk=;
        b=TSwR2PuBbOjYRYTMefCcigvQsyvz557IYOEIsCaEDK3hYfzDnFI53SgQpw2I1aSiHF
         pwCCDv5YoIp0JShzOFxOioHl63lTtSUXtpePTO4Gc85M5cuLSZJH1Z1nwvjc8ZEOyk1n
         6scPiDsuX7eVnp468gYUs9rmcno3zFCE7caj5smOcoVSrFNw5+E9qUAAmbuhdW9p5DX2
         gHxMxNxsB/5P7w8HFWbJ9WcodwlyRzIE9lFF5xlm9uEB9RkGYMd+zFU0vjM/eaymjqxB
         5E2dhQAWW3t/79+McbNoZfzv9iUonw2mpLRxG1t5O1kxrl7xMykFf+o7w6AMQk8q/8Un
         f5IA==
X-Forwarded-Encrypted: i=1; AJvYcCVV/j6FQwIZKZzb+kd/mHZN0FS2UYhAefpkF0FxUIQ/qMLVzKGs+ippbvYV2XoUAKmo2B3FYrtVzsrSghlJYvkYv0yfJpSaejUN+wMQ
X-Gm-Message-State: AOJu0YyNZVQG7PmFIs8JL9CeqtIcwLkNlsc6Qn3tRUQO9nINPE5+g6Ee
	BKJto9HN3/eZlUDRRpr4E65++Lf2NAjFhA2T3Y2Xpcv/1VSsp7lcyQKqqqQcjAs=
X-Google-Smtp-Source: AGHT+IEO5o3QuZQacGlqYRaf8RZYwatPw3qTBMwsPeyn8POJuDm6UYyWHFwJTW83lpUYBJt3hHx5Bw==
X-Received: by 2002:a05:6a21:3482:b0:1a0:c3e6:314f with SMTP id yo2-20020a056a21348200b001a0c3e6314fmr64380pzb.18.1708482066592;
        Tue, 20 Feb 2024 18:21:06 -0800 (PST)
Received: from [10.84.145.15] ([203.208.167.152])
        by smtp.gmail.com with ESMTPSA id jd20-20020a170903261400b001d94a3f3987sm6907230plb.184.2024.02.20.18.21.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 18:21:06 -0800 (PST)
Message-ID: <aa266a51-678d-45b7-a23f-ac18549b383c@bytedance.com>
Date: Wed, 21 Feb 2024 10:20:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/10] fork: Use __mt_dup() to duplicate maple tree in
 dup_mmap()
To: David Hildenbrand <david@redhat.com>
Cc: maple-tree@lists.infradead.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, brauner@kernel.org,
 michael.christie@oracle.com, npiggin@gmail.com,
 Peng Zhang <zhangpeng.00@bytedance.com>, corbet@lwn.net,
 Liam.Howlett@oracle.com, willy@infradead.org, surenb@google.com,
 mjguzik@gmail.com, mathieu.desnoyers@efficios.com, peterz@infradead.org,
 oliver.sang@intel.com, akpm@linux-foundation.org, mst@redhat.com
References: <20231027033845.90608-1-zhangpeng.00@bytedance.com>
 <20231027033845.90608-11-zhangpeng.00@bytedance.com>
 <6058742c-26e5-4600-85ad-0a21d8fd2e42@redhat.com>
 <bc7d1702-315f-4e10-899d-491a0cee8cee@redhat.com>
From: Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <bc7d1702-315f-4e10-899d-491a0cee8cee@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/2/21 01:31, David Hildenbrand 写道:
> On 20.02.24 18:24, David Hildenbrand wrote:
>> On 27.10.23 05:38, Peng Zhang wrote:
>>> In dup_mmap(), using __mt_dup() to duplicate the old maple tree and then
>>> directly replacing the entries of VMAs in the new maple tree can result
>>> in better performance. __mt_dup() uses DFS pre-order to duplicate the
>>> maple tree, so it is efficient.
>>>
>>> The average time complexity of __mt_dup() is O(n), where n is the number
>>> of VMAs. The proof of the time complexity is provided in the commit log
>>> that introduces __mt_dup(). After duplicating the maple tree, each element
>>> is traversed and replaced (ignoring the cases of deletion, which are rare).
>>> Since it is only a replacement operation for each element, this process is
>>> also O(n).
>>>
>>> Analyzing the exact time complexity of the previous algorithm is
>>> challenging because each insertion can involve appending to a node, pushing
>>> data to adjacent nodes, or even splitting nodes. The frequency of each
>>> action is difficult to calculate. The worst-case scenario for a single
>>> insertion is when the tree undergoes splitting at every level. If we
>>> consider each insertion as the worst-case scenario, we can determine that
>>> the upper bound of the time complexity is O(n*log(n)), although this is a
>>> loose upper bound. However, based on the test data, it appears that the
>>> actual time complexity is likely to be O(n).
>>>
>>> As the entire maple tree is duplicated using __mt_dup(), if dup_mmap()
>>> fails, there will be a portion of VMAs that have not been duplicated in
>>> the maple tree. To handle this, we mark the failure point with
>>> XA_ZERO_ENTRY. In exit_mmap(), if this marker is encountered, stop
>>> releasing VMAs that have not been duplicated after this point.
>>>
>>> There is a "spawn" in byte-unixbench[1], which can be used to test the
>>> performance of fork(). I modified it slightly to make it work with
>>> different number of VMAs.
>>>
>>> Below are the test results. The first row shows the number of VMAs.
>>> The second and third rows show the number of fork() calls per ten seconds,
>>> corresponding to next-20231006 and the this patchset, respectively. The
>>> test results were obtained with CPU binding to avoid scheduler load
>>> balancing that could cause unstable results. There are still some
>>> fluctuations in the test results, but at least they are better than the
>>> original performance.
>>>
>>> 21     121   221    421    821    1621   3221   6421   12821  25621  51221
>>> 112100 76261 54227  34035  20195  11112  6017   3161   1606   802    393
>>> 114558 83067 65008  45824  28751  16072  8922   4747   2436   1233   599
>>> 2.19%  8.92% 19.88% 34.64% 42.37% 44.64% 48.28% 50.17% 51.68% 53.74% 52.42%
>>>
>>> [1] https://github.com/kdlucas/byte-unixbench/tree/master
>>>
>>> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
>>> Suggested-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>>> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>>> ---
>>>    include/linux/mm.h | 11 +++++++++++
>>>    kernel/fork.c      | 40 +++++++++++++++++++++++++++++-----------
>>>    mm/internal.h      | 11 -----------
>>>    mm/memory.c        |  7 ++++++-
>>>    mm/mmap.c          |  9 ++++++---
>>>    5 files changed, 52 insertions(+), 26 deletions(-)
>>>
>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>> index 14d5aaff96d0..e9111ec5808c 100644
>>> --- a/include/linux/mm.h
>>> +++ b/include/linux/mm.h
>>> @@ -996,6 +996,17 @@ static inline int vma_iter_bulk_alloc(struct vma_iterator *vmi,
>>>        return mas_expected_entries(&vmi->mas, count);
>>>    }
>>> +static inline int vma_iter_clear_gfp(struct vma_iterator *vmi,
>>> +            unsigned long start, unsigned long end, gfp_t gfp)
>>> +{
>>> +    __mas_set_range(&vmi->mas, start, end - 1);
>>> +    mas_store_gfp(&vmi->mas, NULL, gfp);
>>> +    if (unlikely(mas_is_err(&vmi->mas)))
>>> +        return -ENOMEM;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>    /* Free any unused preallocations */
>>>    static inline void vma_iter_free(struct vma_iterator *vmi)
>>>    {
>>> diff --git a/kernel/fork.c b/kernel/fork.c
>>> index 1e6c656e0857..1552ee66517b 100644
>>> --- a/kernel/fork.c
>>> +++ b/kernel/fork.c
>>> @@ -650,7 +650,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>>>        int retval;
>>>        unsigned long charge = 0;
>>>        LIST_HEAD(uf);
>>> -    VMA_ITERATOR(old_vmi, oldmm, 0);
>>>        VMA_ITERATOR(vmi, mm, 0);
>>>        uprobe_start_dup_mmap();
>>> @@ -678,16 +677,22 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>>>            goto out;
>>>        khugepaged_fork(mm, oldmm);
>>> -    retval = vma_iter_bulk_alloc(&vmi, oldmm->map_count);
>>> -    if (retval)
>>> +    /* Use __mt_dup() to efficiently build an identical maple tree. */
>>> +    retval = __mt_dup(&oldmm->mm_mt, &mm->mm_mt, GFP_KERNEL);
>>> +    if (unlikely(retval))
>>>            goto out;
>>>        mt_clear_in_rcu(vmi.mas.tree);
>>> -    for_each_vma(old_vmi, mpnt) {
>>> +    for_each_vma(vmi, mpnt) {
>>>            struct file *file;
>>>            vma_start_write(mpnt);
>>
>> We used to call vma_start_write() on the *old* VMA, to prevent any kind of page faults in
>> the old MM while we are duplicating PTEs (and COW-share pages).
>>
>> See
>>
>> commit fb49c455323ff8319a123dd312be9082c49a23a5
>> Author: Suren Baghdasaryan <surenb@google.com>
>> Date:   Sat Jul 8 12:12:12 2023 -0700
>>
>>       fork: lock VMAs of the parent process when forking
>>       When forking a child process, the parent write-protects anonymous pages
>>       and COW-shares them with the child being forked using copy_present_pte().
>>       We must not take any concurrent page faults on the source vma's as they
>>       are being processed, as we expect both the vma and the pte's behind it
>>       to be stable.  For example, the anon_vma_fork() expects the parents
>>       vma->anon_vma to not change during the vma copy.
>>
>>
>> Unless I am missing something, we now call vma_start_write() on the *new* VMA?
>>
>> If that is the case, this is broken and needs fixing; likely, going over all
>> VMAs in the old_mm and calling vma_start_write().
>>
>> But maybe there is some magic going on that I am missing :)
> 
> ... likely the magic is that the new tree links the same VMAs (we are not duplicating the VMAs before vm_area_dup()), so we are indeed locking the MM in the old_mm (that is temporarily linked into the new MM).
Thanks for reminding. Yes, the VMAs in the tree built via __mt_dup() are the
same as those in the old tree, so there won't be a problem here.
> 
> If that's the case, all good :)
> 


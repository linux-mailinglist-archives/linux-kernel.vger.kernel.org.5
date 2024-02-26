Return-Path: <linux-kernel+bounces-80551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 990BD866961
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 05:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC1321C216A8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F1D1B7F6;
	Mon, 26 Feb 2024 04:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pwhGE8rU"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34749440
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 04:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708921820; cv=none; b=ZyokTic5FlCbUB1/yuzHBiNJaY/D7QQG0tMLmD77k/0ZwYnVah4vwXg8iJPcT6A9vDo6wvkclV5LEj1sBzxJHmovmQVsBE+tusd3FttDyanV+xWJdKGUWlcRWqCfCvFgOxO+x71CPmiVV1Ls7rem5kgkVTgrMj05tzyePVXjltI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708921820; c=relaxed/simple;
	bh=q8N4ZcUXLQWjQ9n2yT19kgIHaSLe4XIYihAb9YnZAWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kIhzoHoRMrvPxVBlcJdeA/VY/Gn2SNZ68A5bJjea+pqaeijJMcNH/a5rWDDCP9NeFjni4PE0l9oJUnqhfZYvn+lOKVqUmq1G803mxXOKs1X+tD+hq9sKRzuNRzEQe0wdSzjtiDK3c92WoU1nGEZuEz7Uo7kW3tiOub41bX2ea+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pwhGE8rU; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <82c2553f-822e-40c2-9bf8-433689b3669d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708921815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RgfeyY+29BFgB7d+7DJ1UYGNHFedjbusiVsI4MvBh/g=;
	b=pwhGE8rUZfqrhbBaHVTdxP6R0+Qbotfl/KmyO6S9f2kLDLjp97gOJagXfppJ2vf0gvzt1m
	nfQjI5hqwaISbFLPsJzciGTNHQ/Jycs/iM33wT2vH4KNGBCuvNx1cbETqqjFDlv+aFQuR6
	YjkJu18a/oY5TOrE7qcr/lc2Sdn2K+4=
Date: Mon, 26 Feb 2024 12:30:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] ceph: remove SLAB_MEM_SPREAD flag usage
Content-Language: en-US
To: Xiubo Li <xiubli@redhat.com>, idryomov@gmail.com, jlayton@kernel.org
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, vbabka@suse.cz, roman.gushchin@linux.dev,
 Xiongwei.Song@windriver.com, Chengming Zhou <zhouchengming@bytedance.com>
References: <20240224134715.829225-1-chengming.zhou@linux.dev>
 <b6083c49-5240-40e3-a028-bb1ba63ccdd7@redhat.com>
 <d91e3235-395a-4e63-8ace-c14dfaf0a4fd@linux.dev>
 <35df81f5-feac-4373-87a3-d3a27ba9c9d4@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <35df81f5-feac-4373-87a3-d3a27ba9c9d4@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/26 12:23, Xiubo Li wrote:
> 
> On 2/26/24 10:42, Chengming Zhou wrote:
>> On 2024/2/26 09:43, Xiubo Li wrote:
>>> Hi Chengming,
>>>
>>> Thanks for your patch.
>>>
>>> BTW, could you share the link of the relevant patches to mark this a no-op ?
>> Update changelog to make it clearer:
>>
>> The SLAB_MEM_SPREAD flag used to be implemented in SLAB, which was
>> removed as of v6.8-rc1, so it became a dead flag. And the series[1]
>> went on to mark it obsolete to avoid confusion for users. Here we
>> can just remove all its users, which has no functional change.
>>
>> [1] https://lore.kernel.org/all/20240223-slab-cleanup-flags-v2-1-02f1753e8303@suse.cz/
> 
> Thanks for your quick feedback.
> 
> BTW, I couldn't find this change in Linus' tree in the master and even the v6.8-rc1 tag, please see https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/include/linux/slab.h?h=master.
> 
> Did I miss something ? Or has this patch been merged ?

You're right, this patch hasn't been merged. But it's already a dead flag as of v6.8-rc1.

Update changelog to make it clearer:

The SLAB_MEM_SPREAD flag used to be implemented in SLAB, which was
removed as of v6.8-rc1, so it became a dead flag since the commit
16a1d968358a ("mm/slab: remove mm/slab.c and slab_def.h"). And the
series[1] went on to mark it obsolete to avoid confusion for users.
Here we can just remove all its users, which has no functional change.

[1] https://lore.kernel.org/all/20240223-slab-cleanup-flags-v2-1-02f1753e8303@suse.cz/

Does this look clearer to you? I can improve it if there is still confusion.

Thanks!

> 
> - Xiubo
> 
>> Thanks!
>>
>>> Thanks
>>>
>>> - Xiubo
>>>
>>> On 2/24/24 21:47, chengming.zhou@linux.dev wrote:
>>>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>>>
>>>> The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
>>>> its usage so we can delete it from slab. No functional change.
>>>>
>>>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>>>> ---
>>>>    fs/ceph/super.c | 18 +++++++++---------
>>>>    1 file changed, 9 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
>>>> index 5ec102f6b1ac..4dcbbaa297f6 100644
>>>> --- a/fs/ceph/super.c
>>>> +++ b/fs/ceph/super.c
>>>> @@ -928,36 +928,36 @@ static int __init init_caches(void)
>>>>        ceph_inode_cachep = kmem_cache_create("ceph_inode_info",
>>>>                          sizeof(struct ceph_inode_info),
>>>>                          __alignof__(struct ceph_inode_info),
>>>> -                      SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD|
>>>> -                      SLAB_ACCOUNT, ceph_inode_init_once);
>>>> +                      SLAB_RECLAIM_ACCOUNT|SLAB_ACCOUNT,
>>>> +                      ceph_inode_init_once);
>>>>        if (!ceph_inode_cachep)
>>>>            return -ENOMEM;
>>>>    -    ceph_cap_cachep = KMEM_CACHE(ceph_cap, SLAB_MEM_SPREAD);
>>>> +    ceph_cap_cachep = KMEM_CACHE(ceph_cap, 0);
>>>>        if (!ceph_cap_cachep)
>>>>            goto bad_cap;
>>>> -    ceph_cap_snap_cachep = KMEM_CACHE(ceph_cap_snap, SLAB_MEM_SPREAD);
>>>> +    ceph_cap_snap_cachep = KMEM_CACHE(ceph_cap_snap, 0);
>>>>        if (!ceph_cap_snap_cachep)
>>>>            goto bad_cap_snap;
>>>>        ceph_cap_flush_cachep = KMEM_CACHE(ceph_cap_flush,
>>>> -                       SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD);
>>>> +                       SLAB_RECLAIM_ACCOUNT);
>>>>        if (!ceph_cap_flush_cachep)
>>>>            goto bad_cap_flush;
>>>>          ceph_dentry_cachep = KMEM_CACHE(ceph_dentry_info,
>>>> -                    SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD);
>>>> +                    SLAB_RECLAIM_ACCOUNT);
>>>>        if (!ceph_dentry_cachep)
>>>>            goto bad_dentry;
>>>>    -    ceph_file_cachep = KMEM_CACHE(ceph_file_info, SLAB_MEM_SPREAD);
>>>> +    ceph_file_cachep = KMEM_CACHE(ceph_file_info, 0);
>>>>        if (!ceph_file_cachep)
>>>>            goto bad_file;
>>>>    -    ceph_dir_file_cachep = KMEM_CACHE(ceph_dir_file_info, SLAB_MEM_SPREAD);
>>>> +    ceph_dir_file_cachep = KMEM_CACHE(ceph_dir_file_info, 0);
>>>>        if (!ceph_dir_file_cachep)
>>>>            goto bad_dir_file;
>>>>    -    ceph_mds_request_cachep = KMEM_CACHE(ceph_mds_request, SLAB_MEM_SPREAD);
>>>> +    ceph_mds_request_cachep = KMEM_CACHE(ceph_mds_request, 0);
>>>>        if (!ceph_mds_request_cachep)
>>>>            goto bad_mds_req;
>>>>    
> 


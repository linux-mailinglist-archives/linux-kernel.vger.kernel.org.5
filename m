Return-Path: <linux-kernel+bounces-80418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE3186684B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E1472818B9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 02:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC82FC01;
	Mon, 26 Feb 2024 02:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bFjm+vRc"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C06EEDE;
	Mon, 26 Feb 2024 02:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708915382; cv=none; b=lnyPRqJStt3v3Rw+vN9AbtVFGmFGGItYT2NDbDtA0NNYiaHvrpE6S37wSNsOjZZnqgX0w7w32hryXu7PmtVuAjPo0wZNqxfqwhepfwUsaZ4fzIaFsgNYrzyvTeElQZQEdO17QfwljUuzqQ+jfqP2unpXiAPVxXnwjOIoi6dhTQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708915382; c=relaxed/simple;
	bh=2lrCQXoWic/lvZYvaJPQ+wPoytEO7esJOR/f8mwfX7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o0I91Bis8j12DbraWrU6F3zmZyy0Ie82m1TPKwkmoDajLj0wiwF94Nxk6tLb83Kch3N05tsTmUnwWe5OptI82rQ3wbn4mqcVeYJSHRX3YJ7hA6EUY14irSAZDUrrzQ9pyijHviM6YIhBZe0C11ix8rBUIgEvlivoz9BzoECBjxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bFjm+vRc; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d91e3235-395a-4e63-8ace-c14dfaf0a4fd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708915377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C2IqjWh/yWi1m79mN9dV+v0YZlblGMbjVM2Q3IOYH54=;
	b=bFjm+vRcwNAtPWIpm6XptVUfBkkdjZv+25Ep9G6sX9r6KFFQB87NTpRlbyYXzkys+APTEZ
	wby50uKxS+kra1tcTtwwYRz+2+rj34wrnn6dvN6+dDALXzGoob2NpGB7GMqgjbKNnRkwWP
	G12RenC4deP0/e9e9BlKywLPj5jXa/Y=
Date: Mon, 26 Feb 2024 10:42:27 +0800
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <b6083c49-5240-40e3-a028-bb1ba63ccdd7@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/26 09:43, Xiubo Li wrote:
> Hi Chengming,
> 
> Thanks for your patch.
> 
> BTW, could you share the link of the relevant patches to mark this a no-op ?
Update changelog to make it clearer:

The SLAB_MEM_SPREAD flag used to be implemented in SLAB, which was
removed as of v6.8-rc1, so it became a dead flag. And the series[1]
went on to mark it obsolete to avoid confusion for users. Here we
can just remove all its users, which has no functional change.

[1] https://lore.kernel.org/all/20240223-slab-cleanup-flags-v2-1-02f1753e8303@suse.cz/

Thanks!

> 
> Thanks
> 
> - Xiubo
> 
> On 2/24/24 21:47, chengming.zhou@linux.dev wrote:
>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>
>> The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
>> its usage so we can delete it from slab. No functional change.
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> ---
>>   fs/ceph/super.c | 18 +++++++++---------
>>   1 file changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
>> index 5ec102f6b1ac..4dcbbaa297f6 100644
>> --- a/fs/ceph/super.c
>> +++ b/fs/ceph/super.c
>> @@ -928,36 +928,36 @@ static int __init init_caches(void)
>>       ceph_inode_cachep = kmem_cache_create("ceph_inode_info",
>>                         sizeof(struct ceph_inode_info),
>>                         __alignof__(struct ceph_inode_info),
>> -                      SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD|
>> -                      SLAB_ACCOUNT, ceph_inode_init_once);
>> +                      SLAB_RECLAIM_ACCOUNT|SLAB_ACCOUNT,
>> +                      ceph_inode_init_once);
>>       if (!ceph_inode_cachep)
>>           return -ENOMEM;
>>   -    ceph_cap_cachep = KMEM_CACHE(ceph_cap, SLAB_MEM_SPREAD);
>> +    ceph_cap_cachep = KMEM_CACHE(ceph_cap, 0);
>>       if (!ceph_cap_cachep)
>>           goto bad_cap;
>> -    ceph_cap_snap_cachep = KMEM_CACHE(ceph_cap_snap, SLAB_MEM_SPREAD);
>> +    ceph_cap_snap_cachep = KMEM_CACHE(ceph_cap_snap, 0);
>>       if (!ceph_cap_snap_cachep)
>>           goto bad_cap_snap;
>>       ceph_cap_flush_cachep = KMEM_CACHE(ceph_cap_flush,
>> -                       SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD);
>> +                       SLAB_RECLAIM_ACCOUNT);
>>       if (!ceph_cap_flush_cachep)
>>           goto bad_cap_flush;
>>         ceph_dentry_cachep = KMEM_CACHE(ceph_dentry_info,
>> -                    SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD);
>> +                    SLAB_RECLAIM_ACCOUNT);
>>       if (!ceph_dentry_cachep)
>>           goto bad_dentry;
>>   -    ceph_file_cachep = KMEM_CACHE(ceph_file_info, SLAB_MEM_SPREAD);
>> +    ceph_file_cachep = KMEM_CACHE(ceph_file_info, 0);
>>       if (!ceph_file_cachep)
>>           goto bad_file;
>>   -    ceph_dir_file_cachep = KMEM_CACHE(ceph_dir_file_info, SLAB_MEM_SPREAD);
>> +    ceph_dir_file_cachep = KMEM_CACHE(ceph_dir_file_info, 0);
>>       if (!ceph_dir_file_cachep)
>>           goto bad_dir_file;
>>   -    ceph_mds_request_cachep = KMEM_CACHE(ceph_mds_request, SLAB_MEM_SPREAD);
>> +    ceph_mds_request_cachep = KMEM_CACHE(ceph_mds_request, 0);
>>       if (!ceph_mds_request_cachep)
>>           goto bad_mds_req;
>>   
> 


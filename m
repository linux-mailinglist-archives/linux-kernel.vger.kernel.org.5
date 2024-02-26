Return-Path: <linux-kernel+bounces-80545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 914F5866951
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 05:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4852F281E05
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198FC1B810;
	Mon, 26 Feb 2024 04:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z3pBoBAb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6DC1B7E1
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 04:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708921427; cv=none; b=OP013/yhtpsr7YUpB5tz8+yjvcSoXs9qe2jWLr3KSU3pvv2Mnkp/0XQyqauihaYiu8m17DgVyw9EVx+zqOMDE7EsSb29NyKLztERXYVKPl6NTGIzNWOguL8M4J2txUTp6LMzOKXBkaiLv/FpEysm9XiAK+gsTRr7am0/6CyhNfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708921427; c=relaxed/simple;
	bh=8bLpLUto35nkP3LvdQtCuRSBt+MwnuqsblV+3YIQcEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bnXzmwp0b8PYyTLpH1unTZf1wfnXbQduvM26GvTceYKiVpPASB3jYb8Z66wziSdpdRILe6Nr2EvLGeyZ2Rvv8QJrMV0aBlXxy3R71KRg/QZH8J9ZrYytadfbeOCi/W89/Q2ZoYfF4+Rys/nr2E81Q323Y22dMGsNE/scvT2kSZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z3pBoBAb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708921424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vZ8LkK657qDlNnzdVPB+undXtR8IvGKGbjYwCsGXQrg=;
	b=Z3pBoBAbIXd7Us5uJFvR9A11/h9aXuIJYKL7hoGPBAJsIhESzmz8WlVvSc/3oKKcfvbDn3
	Jn3zIzQAQ2ZiJPWtboxiMJ3+D2eywkgcJg73BOPD9OJ1KCFArXHbCq/ns+H4vOJQcqqoUM
	te38thJDTLwvTNRZje0NOAR2SO75wy4=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-2NXovT71PJuy6aJhOl7RnQ-1; Sun, 25 Feb 2024 23:23:42 -0500
X-MC-Unique: 2NXovT71PJuy6aJhOl7RnQ-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6e37ae3fa64so1709287b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 20:23:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708921422; x=1709526222;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vZ8LkK657qDlNnzdVPB+undXtR8IvGKGbjYwCsGXQrg=;
        b=p9S4ZhcqQ0RdY3AAo0MRWHG0M4HvNt++1l59FvCIQsk6XPwAPAfyd/Kg/cu1Zz7Lk2
         2k2c60puuTFg9mtjrY41cflRZxswDidwcPyXwdlaB1AeGuZWedui6cGI6XF6zaU/c92O
         7iq3hRv+CYorqxfM3UKCbzLL4b2wD+BMALY6adup7I48gkwkolN8/IggCBX7g3mffGBJ
         vYNCcXxacKWIW2yRRnDyzeCAhN6/r90kEbqN+dybVBP7wNfraQZy3nIAuIGBe5B72AQA
         1qb3TMkwCCoM2rJQaM6PapQKjDCFU7sbmC75Qkih3LrItmtjnZA8cQVqXz1XNIcgmDAz
         w+rA==
X-Forwarded-Encrypted: i=1; AJvYcCWXs92i0Z1dASPcyUci6F4mw+1k3fkmr69A0GbtPm8IxojTg1GfjhSAOo/HZH6qkpxYiYfBqUGeWmLhgaXZ2ImfYSNPWk/pWh5792Pv
X-Gm-Message-State: AOJu0YzZBd7VEcNTDMqmxa3ukJFSIyT5NXduXXvp9LaDnxawb/n4B7OH
	3Zm8PdF+gBfrL87KCJyu9AoCAAigbwzpZqqpmldRMvBV89LxXlkDr3eDM2k9updBmb+hBOswI2r
	cH+LwKQN07iCW00t76y4Oni0pVfAt+wYQmLeTwD39TNK/dT6vwm9zMmULvxnb5Q==
X-Received: by 2002:a62:cd4c:0:b0:6e5:32ee:216b with SMTP id o73-20020a62cd4c000000b006e532ee216bmr686946pfg.27.1708921421659;
        Sun, 25 Feb 2024 20:23:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUgQ4pUFoJVW/Zojwd70Fsl2xZVEuB2n+UyD866yIWg58GZastMHqqDfVMBV4VGopFxyzW+g==
X-Received: by 2002:a62:cd4c:0:b0:6e5:32ee:216b with SMTP id o73-20020a62cd4c000000b006e532ee216bmr686936pfg.27.1708921421340;
        Sun, 25 Feb 2024 20:23:41 -0800 (PST)
Received: from [10.72.112.214] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id c4-20020aa78804000000b006e2f9f007b0sm3091995pfo.92.2024.02.25.20.23.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Feb 2024 20:23:41 -0800 (PST)
Message-ID: <35df81f5-feac-4373-87a3-d3a27ba9c9d4@redhat.com>
Date: Mon, 26 Feb 2024 12:23:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ceph: remove SLAB_MEM_SPREAD flag usage
Content-Language: en-US
To: Chengming Zhou <chengming.zhou@linux.dev>, idryomov@gmail.com,
 jlayton@kernel.org
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, vbabka@suse.cz, roman.gushchin@linux.dev,
 Xiongwei.Song@windriver.com, Chengming Zhou <zhouchengming@bytedance.com>
References: <20240224134715.829225-1-chengming.zhou@linux.dev>
 <b6083c49-5240-40e3-a028-bb1ba63ccdd7@redhat.com>
 <d91e3235-395a-4e63-8ace-c14dfaf0a4fd@linux.dev>
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <d91e3235-395a-4e63-8ace-c14dfaf0a4fd@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2/26/24 10:42, Chengming Zhou wrote:
> On 2024/2/26 09:43, Xiubo Li wrote:
>> Hi Chengming,
>>
>> Thanks for your patch.
>>
>> BTW, could you share the link of the relevant patches to mark this a no-op ?
> Update changelog to make it clearer:
>
> The SLAB_MEM_SPREAD flag used to be implemented in SLAB, which was
> removed as of v6.8-rc1, so it became a dead flag. And the series[1]
> went on to mark it obsolete to avoid confusion for users. Here we
> can just remove all its users, which has no functional change.
>
> [1] https://lore.kernel.org/all/20240223-slab-cleanup-flags-v2-1-02f1753e8303@suse.cz/

Thanks for your quick feedback.

BTW, I couldn't find this change in Linus' tree in the master and even 
the v6.8-rc1 tag, please see 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/include/linux/slab.h?h=master.

Did I miss something ? Or has this patch been merged ?

- Xiubo

> Thanks!
>
>> Thanks
>>
>> - Xiubo
>>
>> On 2/24/24 21:47, chengming.zhou@linux.dev wrote:
>>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>>
>>> The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
>>> its usage so we can delete it from slab. No functional change.
>>>
>>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>>> ---
>>>    fs/ceph/super.c | 18 +++++++++---------
>>>    1 file changed, 9 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
>>> index 5ec102f6b1ac..4dcbbaa297f6 100644
>>> --- a/fs/ceph/super.c
>>> +++ b/fs/ceph/super.c
>>> @@ -928,36 +928,36 @@ static int __init init_caches(void)
>>>        ceph_inode_cachep = kmem_cache_create("ceph_inode_info",
>>>                          sizeof(struct ceph_inode_info),
>>>                          __alignof__(struct ceph_inode_info),
>>> -                      SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD|
>>> -                      SLAB_ACCOUNT, ceph_inode_init_once);
>>> +                      SLAB_RECLAIM_ACCOUNT|SLAB_ACCOUNT,
>>> +                      ceph_inode_init_once);
>>>        if (!ceph_inode_cachep)
>>>            return -ENOMEM;
>>>    -    ceph_cap_cachep = KMEM_CACHE(ceph_cap, SLAB_MEM_SPREAD);
>>> +    ceph_cap_cachep = KMEM_CACHE(ceph_cap, 0);
>>>        if (!ceph_cap_cachep)
>>>            goto bad_cap;
>>> -    ceph_cap_snap_cachep = KMEM_CACHE(ceph_cap_snap, SLAB_MEM_SPREAD);
>>> +    ceph_cap_snap_cachep = KMEM_CACHE(ceph_cap_snap, 0);
>>>        if (!ceph_cap_snap_cachep)
>>>            goto bad_cap_snap;
>>>        ceph_cap_flush_cachep = KMEM_CACHE(ceph_cap_flush,
>>> -                       SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD);
>>> +                       SLAB_RECLAIM_ACCOUNT);
>>>        if (!ceph_cap_flush_cachep)
>>>            goto bad_cap_flush;
>>>          ceph_dentry_cachep = KMEM_CACHE(ceph_dentry_info,
>>> -                    SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD);
>>> +                    SLAB_RECLAIM_ACCOUNT);
>>>        if (!ceph_dentry_cachep)
>>>            goto bad_dentry;
>>>    -    ceph_file_cachep = KMEM_CACHE(ceph_file_info, SLAB_MEM_SPREAD);
>>> +    ceph_file_cachep = KMEM_CACHE(ceph_file_info, 0);
>>>        if (!ceph_file_cachep)
>>>            goto bad_file;
>>>    -    ceph_dir_file_cachep = KMEM_CACHE(ceph_dir_file_info, SLAB_MEM_SPREAD);
>>> +    ceph_dir_file_cachep = KMEM_CACHE(ceph_dir_file_info, 0);
>>>        if (!ceph_dir_file_cachep)
>>>            goto bad_dir_file;
>>>    -    ceph_mds_request_cachep = KMEM_CACHE(ceph_mds_request, SLAB_MEM_SPREAD);
>>> +    ceph_mds_request_cachep = KMEM_CACHE(ceph_mds_request, 0);
>>>        if (!ceph_mds_request_cachep)
>>>            goto bad_mds_req;
>>>    



Return-Path: <linux-kernel+bounces-80556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EF7866972
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 05:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3227B20C0F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B2C1B80A;
	Mon, 26 Feb 2024 04:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e069fjQu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32A3EEDE
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 04:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708923262; cv=none; b=i87u+M9ODjQ31lL8vWaV9eiSaOsC0DT8+NKHBKVk5rabXVKhRCZoBqt9BYjlK6bjKpYP5FYOvKGPIiiC4V2TWIbdi9oxVIOVxtMLrYUe//BOAsn2SSwt0pKSy6ENYpm1v3WBk5XHUlP3pLeQDSJXmygU6C1WQgpJKeXjzFVWkZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708923262; c=relaxed/simple;
	bh=bKHy5tJO1ClP/m/okR1ZP4F8zGLl+fd471TqzhcHOlI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KEwuDYYuAAewBxrz0xKbcVLKK0acNPAJMK8xOLoQU/N1pPgfhK9GV0g5u6Dan3ef5hIErChEahDwhFF1ZmFN6uMlRfUJd6G0TQR0PMEg+l6hdUPUMlWOsGTmC7ScV6dhVhd7L3+ioS2zR/2W8KDWlSJNTm4EffRhEwV0FSaQPfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e069fjQu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708923258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LrACz5Anp3j5np9PgzWbTRqtplHvhtHaAYkW+Lelxj8=;
	b=e069fjQurNP/ZWf4ImaHHJhtYF3RcceIM+mj4HK012ZDtuiHO7XB8PoMMNVu0ut/lxuWLZ
	cFDgerzP8Z+3K444bmkH7XkP6CXNn3VeuGWbVSVH6Opu52sBBNC/xfzeFW09h0cA2/OXeZ
	IdmLuzA3NmOFnYmhQ8aYKeJMKYxtM4g=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-0N_TBXE3MCmZA9Tun3VACA-1; Sun, 25 Feb 2024 23:54:17 -0500
X-MC-Unique: 0N_TBXE3MCmZA9Tun3VACA-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1d542680c9cso30657055ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 20:54:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708923256; x=1709528056;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LrACz5Anp3j5np9PgzWbTRqtplHvhtHaAYkW+Lelxj8=;
        b=tXLmBxs/ZWpmydlacNmdgMNm3811bwABDQ2oTeUwYJvea0kzlNAtClRC0PRH9yWSnQ
         HsxGz+wQZ8i2pdk9Gi0zcvaOTtvUi+xW9caE0L7oBvEqAqa50Yjh71M7kEztGIsAl1pB
         mJU5gc+Vo0iiWpPQzhaEaO1+AbCL+wa64gTeuvBgJVTO4GNLRlI5vdScXTfylzAcqFm/
         uTIBXjMxYSXoa7T1ZYknFKT09XkPNBsmv/+iCJsbW5pNYsCZZ7xv0ZHnxrvVhXvzVJJB
         ZzC2gcnuVCT2CREgKIYQTEAyl1vSuVVwJWNEhikAOP3SUFEiCBtbjYigtAbbbP9Z83C8
         n/qg==
X-Forwarded-Encrypted: i=1; AJvYcCXFM8nTh+pdXHN8hr9j1RrcERmz941GK/MlM6s9YdvR+XhGUJGbIRvDf+4XHbjgY17slZYZmbfvGmPd4E3xM5+aO6l3rPIEhdL9GTew
X-Gm-Message-State: AOJu0YwzlBcwuweBDC6V9lXac+g2iTLmlZrMcuZ5y0LtwLHOWsSIkhch
	qppgsJcnPp6eQFBmQbfwSNO1aXvimb8wW0AfVUxFwl4zpk6ByYrnrBnc5wt9EoB7yIK2dpqcvB+
	D1makn1sugoQbY200zn8lfkqgKE84AGcZNUJcvxm/SS9RVisWydv45JUk6xW7Pg==
X-Received: by 2002:a17:902:e94f:b0:1db:fad5:26ad with SMTP id b15-20020a170902e94f00b001dbfad526admr106870pll.51.1708923256456;
        Sun, 25 Feb 2024 20:54:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyKSYx40AByF4zUBPndjhdof7ntq9QRkH11f6LHVqj7dhRZ4H2OOxvIvoeVBF5e07hTyRZTQ==
X-Received: by 2002:a17:902:e94f:b0:1db:fad5:26ad with SMTP id b15-20020a170902e94f00b001dbfad526admr106860pll.51.1708923256169;
        Sun, 25 Feb 2024 20:54:16 -0800 (PST)
Received: from [10.72.112.214] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ks16-20020a170903085000b001dc6528d49asm2993994plb.250.2024.02.25.20.54.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Feb 2024 20:54:15 -0800 (PST)
Message-ID: <69589d2f-978d-4d14-9e5f-6bd6b3a43062@redhat.com>
Date: Mon, 26 Feb 2024 12:54:10 +0800
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
 <35df81f5-feac-4373-87a3-d3a27ba9c9d4@redhat.com>
 <82c2553f-822e-40c2-9bf8-433689b3669d@linux.dev>
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <82c2553f-822e-40c2-9bf8-433689b3669d@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2/26/24 12:30, Chengming Zhou wrote:
> On 2024/2/26 12:23, Xiubo Li wrote:
>> On 2/26/24 10:42, Chengming Zhou wrote:
>>> On 2024/2/26 09:43, Xiubo Li wrote:
>>>> Hi Chengming,
>>>>
>>>> Thanks for your patch.
>>>>
>>>> BTW, could you share the link of the relevant patches to mark this a no-op ?
>>> Update changelog to make it clearer:
>>>
>>> The SLAB_MEM_SPREAD flag used to be implemented in SLAB, which was
>>> removed as of v6.8-rc1, so it became a dead flag. And the series[1]
>>> went on to mark it obsolete to avoid confusion for users. Here we
>>> can just remove all its users, which has no functional change.
>>>
>>> [1] https://lore.kernel.org/all/20240223-slab-cleanup-flags-v2-1-02f1753e8303@suse.cz/
>> Thanks for your quick feedback.
>>
>> BTW, I couldn't find this change in Linus' tree in the master and even the v6.8-rc1 tag, please see https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/include/linux/slab.h?h=master.
>>
>> Did I miss something ? Or has this patch been merged ?
> You're right, this patch hasn't been merged. But it's already a dead flag as of v6.8-rc1.
>
> Update changelog to make it clearer:
>
> The SLAB_MEM_SPREAD flag used to be implemented in SLAB, which was
> removed as of v6.8-rc1, so it became a dead flag since the commit
> 16a1d968358a ("mm/slab: remove mm/slab.c and slab_def.h"). And the
> series[1] went on to mark it obsolete to avoid confusion for users.
> Here we can just remove all its users, which has no functional change.
>
> [1] https://lore.kernel.org/all/20240223-slab-cleanup-flags-v2-1-02f1753e8303@suse.cz/
>
> Does this look clearer to you? I can improve it if there is still confusion.

Yeah, much clearer, thanks!

Maybe we should just wait for the [1] to get merged first ?

Ilya, what do you think ?

Thanks

- Xiubo


> Thanks!
>
>> - Xiubo
>>
>>> Thanks!
>>>
>>>> Thanks
>>>>
>>>> - Xiubo
>>>>
>>>> On 2/24/24 21:47, chengming.zhou@linux.dev wrote:
>>>>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>>>>
>>>>> The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
>>>>> its usage so we can delete it from slab. No functional change.
>>>>>
>>>>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>>>>> ---
>>>>>     fs/ceph/super.c | 18 +++++++++---------
>>>>>     1 file changed, 9 insertions(+), 9 deletions(-)
>>>>>
>>>>> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
>>>>> index 5ec102f6b1ac..4dcbbaa297f6 100644
>>>>> --- a/fs/ceph/super.c
>>>>> +++ b/fs/ceph/super.c
>>>>> @@ -928,36 +928,36 @@ static int __init init_caches(void)
>>>>>         ceph_inode_cachep = kmem_cache_create("ceph_inode_info",
>>>>>                           sizeof(struct ceph_inode_info),
>>>>>                           __alignof__(struct ceph_inode_info),
>>>>> -                      SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD|
>>>>> -                      SLAB_ACCOUNT, ceph_inode_init_once);
>>>>> +                      SLAB_RECLAIM_ACCOUNT|SLAB_ACCOUNT,
>>>>> +                      ceph_inode_init_once);
>>>>>         if (!ceph_inode_cachep)
>>>>>             return -ENOMEM;
>>>>>     -    ceph_cap_cachep = KMEM_CACHE(ceph_cap, SLAB_MEM_SPREAD);
>>>>> +    ceph_cap_cachep = KMEM_CACHE(ceph_cap, 0);
>>>>>         if (!ceph_cap_cachep)
>>>>>             goto bad_cap;
>>>>> -    ceph_cap_snap_cachep = KMEM_CACHE(ceph_cap_snap, SLAB_MEM_SPREAD);
>>>>> +    ceph_cap_snap_cachep = KMEM_CACHE(ceph_cap_snap, 0);
>>>>>         if (!ceph_cap_snap_cachep)
>>>>>             goto bad_cap_snap;
>>>>>         ceph_cap_flush_cachep = KMEM_CACHE(ceph_cap_flush,
>>>>> -                       SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD);
>>>>> +                       SLAB_RECLAIM_ACCOUNT);
>>>>>         if (!ceph_cap_flush_cachep)
>>>>>             goto bad_cap_flush;
>>>>>           ceph_dentry_cachep = KMEM_CACHE(ceph_dentry_info,
>>>>> -                    SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD);
>>>>> +                    SLAB_RECLAIM_ACCOUNT);
>>>>>         if (!ceph_dentry_cachep)
>>>>>             goto bad_dentry;
>>>>>     -    ceph_file_cachep = KMEM_CACHE(ceph_file_info, SLAB_MEM_SPREAD);
>>>>> +    ceph_file_cachep = KMEM_CACHE(ceph_file_info, 0);
>>>>>         if (!ceph_file_cachep)
>>>>>             goto bad_file;
>>>>>     -    ceph_dir_file_cachep = KMEM_CACHE(ceph_dir_file_info, SLAB_MEM_SPREAD);
>>>>> +    ceph_dir_file_cachep = KMEM_CACHE(ceph_dir_file_info, 0);
>>>>>         if (!ceph_dir_file_cachep)
>>>>>             goto bad_dir_file;
>>>>>     -    ceph_mds_request_cachep = KMEM_CACHE(ceph_mds_request, SLAB_MEM_SPREAD);
>>>>> +    ceph_mds_request_cachep = KMEM_CACHE(ceph_mds_request, 0);
>>>>>         if (!ceph_mds_request_cachep)
>>>>>             goto bad_mds_req;
>>>>>     



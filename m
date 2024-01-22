Return-Path: <linux-kernel+bounces-32531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE0B835CC2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94B75B265D7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDD222092;
	Mon, 22 Jan 2024 08:37:31 +0000 (UTC)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771EE17C80
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 08:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705912650; cv=none; b=pFZX6+Yn5VEvJo8BNPRsLuPBEj6r+E5vrD2ziyQSbhB0w4JVNzZqr0O4Y5hhujXzCWRGZP/n8HsiPNGrciv+5w2Ka54mbn3k0lwYextAG2Wnra2Not6EFOI2IZYIM9Y/HPRtmgrBhKmetRIlppt2Fv5DtOUYdAmYsoQH5tZzXko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705912650; c=relaxed/simple;
	bh=GoV0jX5OP7TlSbxGOU/2lArwPKWg3tqVoToqOIxHjvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CxnTFdSuYywcVuEYoJiRK88wnLvdChTok7OYH2+ZwXBvR0vf6m6RRe5+1JQNJut3JpKJhXGGhUW8MpwiHTg0BwQUcdORIK47TxqQiCJOOyMeTg03/jV567MboUadTUEPySXtcp9zbD/VfddmPvXCbgcmgypmEnJEZKcX21CsfEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W.5LQ0x_1705912643;
Received: from 30.221.145.129(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W.5LQ0x_1705912643)
          by smtp.aliyun-inc.com;
          Mon, 22 Jan 2024 16:37:24 +0800
Message-ID: <99302340-731d-435f-ab9e-7a31fe86c95e@linux.alibaba.com>
Date: Mon, 22 Jan 2024 16:37:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: make iov_iter describe target buffer when read
 from fscache
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc: huyue2@coolpad.com, linux-kernel@vger.kernel.org
References: <20240122071253.119004-1-jefflexu@linux.alibaba.com>
 <d99929c8-9bf2-4a99-8507-617eb3419b98@linux.alibaba.com>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <d99929c8-9bf2-4a99-8507-617eb3419b98@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Xiang,

On 1/22/24 3:42 PM, Gao Xiang wrote:
> Hi Jingbo,
> 
> On 2024/1/22 15:12, Jingbo Xu wrote:
>> So far the fscache mode supports uncompressed data only, and the data
>> read from fscache is put directly into the target page cache.  As the
>> support for compressed data in fscache mode is going to be introduced,
>> refactor the interface of reading fscache so that the following
>> compressed part could make the raw data read from fscache be directed to
>> the target buffer it wants, decompress the raw data, and finally fill
>> the page cache with the decompressed data.
>>
>> As the first step, a new structure, i.e. erofs_fscache_io (cio), is
> 
> I'd suggest just using io instead of cio here.
> 
> .. i.e. erofs_fscache_io (io) ...


Thanks for the review, I will update the patch regarding all these comments.


> 
>> introduced to describe a generic read request from the fscache, while
>> the caller can specify the target buffer it wants in the iov_iter
>> structure (cio->iter).  Besides, the caller can also specify its
> 
> .. structure (io->iter) ...
> 
>> completion callback and private data through cio, which will be called
>> to make further handling, e.g. unlocking the page cache for uncompressed
>> data or decompressing the read raw data, when the read request from the
>> fscache completes.  Now erofs_fscache_read_io_async() serves as a
>> generic interface for reading raw data from fscache for both compressed
>> and uncompressed data.
>>
>> The erofs_fscache_request structure is kept to describe a request to
>> fill the page cache in the specified range.
>>
>> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
>> ---
>>   fs/erofs/fscache.c | 219 ++++++++++++++++++++++++---------------------
>>   1 file changed, 118 insertions(+), 101 deletions(-)
>>
>> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
>> index bc12030393b2..10709f20bef5 100644
>> --- a/fs/erofs/fscache.c
>> +++ b/fs/erofs/fscache.c
>> @@ -13,8 +13,6 @@ static LIST_HEAD(erofs_domain_cookies_list);
>>   static struct vfsmount *erofs_pseudo_mnt;
>>     struct erofs_fscache_request {
>> -    struct erofs_fscache_request *primary;
>> -    struct netfs_cache_resources cache_resources;
>>       struct address_space    *mapping;    /* The mapping being
>> accessed */
>>       loff_t            start;        /* Start position */
>>       size_t            len;        /* Length of the request */
>> @@ -23,42 +21,13 @@ struct erofs_fscache_request {
>>       refcount_t        ref;
>>   };
>>   -static struct erofs_fscache_request *erofs_fscache_req_alloc(struct
>> address_space *mapping,
>> -                         loff_t start, size_t len)
>> -{
>> -    struct erofs_fscache_request *req;
>> -
>> -    req = kzalloc(sizeof(struct erofs_fscache_request), GFP_KERNEL);
>> -    if (!req)
>> -        return ERR_PTR(-ENOMEM);
>> -
>> -    req->mapping = mapping;
>> -    req->start   = start;
>> -    req->len     = len;
>> -    refcount_set(&req->ref, 1);
>> -
>> -    return req;
>> -}
>> -
>> -static struct erofs_fscache_request *erofs_fscache_req_chain(struct
>> erofs_fscache_request *primary,
>> -                         size_t len)
>> -{
>> -    struct erofs_fscache_request *req;
>> -
>> -    /* use primary request for the first submission */
>> -    if (!primary->submitted) {
>> -        refcount_inc(&primary->ref);
>> -        return primary;
>> -    }
>> -
>> -    req = erofs_fscache_req_alloc(primary->mapping,
>> -            primary->start + primary->submitted, len);
>> -    if (!IS_ERR(req)) {
>> -        req->primary = primary;
>> -        refcount_inc(&primary->ref);
>> -    }
>> -    return req;
>> -}
>> +struct erofs_fscache_io {
>> +    struct netfs_cache_resources cache_resources;
> 
>     struct netfs_cache_resources cres;
> 
>> +    struct iov_iter        iter;
>> +    netfs_io_terminated_t    end_io;
>> +    void            *private;
>> +    refcount_t        ref;
>> +};
>>     static void erofs_fscache_req_complete(struct
>> erofs_fscache_request *req)
>>   {
>> @@ -83,82 +52,116 @@ static void erofs_fscache_req_complete(struct
>> erofs_fscache_request *req)
>>   static void erofs_fscache_req_put(struct erofs_fscache_request *req)
>>   {
>>       if (refcount_dec_and_test(&req->ref)) {
>> -        if (req->cache_resources.ops)
>> -           
>> req->cache_resources.ops->end_operation(&req->cache_resources);
>> -        if (!req->primary)
>> -            erofs_fscache_req_complete(req);
>> -        else
>> -            erofs_fscache_req_put(req->primary);
>> +        erofs_fscache_req_complete(req);
>>           kfree(req);
>>       }
>>   }
>>   -static void erofs_fscache_subreq_complete(void *priv,
>> +static struct erofs_fscache_request *erofs_fscache_req_alloc(struct
>> address_space *mapping,
>> +                        loff_t start, size_t len)
>> +{
>> +    struct erofs_fscache_request *req;
>> +
>> +    req = kzalloc(sizeof(*req), GFP_KERNEL);
>> +    if (req) {
>> +        req->mapping = mapping;
>> +        req->start = start;
>> +        req->len = len;
>> +        refcount_set(&req->ref, 1);
>> +    }
>> +    return req;
> 
> The following part may be better? to save an indentation:
> 
>     req = kzalloc(sizeof(*req), GFP_KERNEL);
>     if (!req)
>         return NULL;
>     req->mapping = mapping;
>     req->start = start;
>     req->len = len;
>     refcount_set(&req->ref, 1);
>     return req;
> 
>> +}
>> +
>> +static bool erofs_fscache_io_put(struct erofs_fscache_io *cio)
>> +{
>> +    if (refcount_dec_and_test(&cio->ref)) {
>> +        if (cio->cache_resources.ops)
>> +           
>> cio->cache_resources.ops->end_operation(&cio->cache_resources);
>> +        kfree(cio);
>> +        return true;
>> +    }
>> +    return false;
> 
> 
>     if (!refcount_dec_and_test(&io->ref))
>         return false;
>     if (io->cres.ops)
>         io->cres.ops->end_operation(&io->cres);
>     kfree(io);
>     return true;
> 
>> +}
>> +
>> +static void erofs_fscache_req_io_put(struct erofs_fscache_io *cio)
> 
> cio -> io
> 
>> +{
>> +    struct erofs_fscache_request *req = cio->private;
>> +
>> +    if (erofs_fscache_io_put(cio))
>> +        erofs_fscache_req_put(req);
>> +}
>> +
>> +static void erofs_fscache_req_end_io(void *priv,
>>           ssize_t transferred_or_error, bool was_async)
>>   {
>> -    struct erofs_fscache_request *req = priv;
>> +    struct erofs_fscache_io *cio = priv;
>> +    struct erofs_fscache_request *req = cio->private;
>> +
>> +    if (IS_ERR(transferred_or_error))
>> +        req->error = transferred_or_error;
>> +    erofs_fscache_req_io_put(cio);
>> +}
>> +
>> +static struct erofs_fscache_io *erofs_fscache_req_io_alloc(struct
>> erofs_fscache_request *req)
>> +{
>> +    struct erofs_fscache_io *cio;
>>   -    if (IS_ERR_VALUE(transferred_or_error)) {
>> -        if (req->primary)
>> -            req->primary->error = transferred_or_error;
>> -        else
>> -            req->error = transferred_or_error;
>> +    cio = kzalloc(sizeof(*cio), GFP_KERNEL);
>> +    if (cio) {
>> +        cio->end_io = erofs_fscache_req_end_io;
>> +        cio->private = req;
>> +        refcount_inc(&req->ref);
>> +        refcount_set(&cio->ref, 1);
>>       }
>> -    erofs_fscache_req_put(req);
>> +    return cio;
> 
> 
>     io = kzalloc(sizeof(*io), GFP_KERNEL);
>     if (!io)
>         return NULL;
>     io->end_io = erofs_fscache_req_end_io;
>     io->private = req;
>     refcount_inc(&req->ref);
>     refcount_set(&io->ref, 1);
>     return io;
> 
> Thanks,
> Gao Xiang

-- 
Thanks,
Jingbo


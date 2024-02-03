Return-Path: <linux-kernel+bounces-50916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B1D8483BE
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 05:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 937EF281BE8
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 04:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7177CFBEE;
	Sat,  3 Feb 2024 04:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PsTZWgsd"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792A12CA5
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 04:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706934566; cv=none; b=oRJDyyRUaupkYzgYcMiuc2XOa4eeNP4oi7SUIN+FnCXcFr/y0+ejErADoRKWiGdXdIB8E+BEBNyU2jgh4kQFvlqz4KgCkZVql6/cKs0ALqbg26FNp6+aD9pBTSfgGbg5FMs5+FKzKzli7yVKyKxMiRoVUCXCF01EB2ftxlJbpxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706934566; c=relaxed/simple;
	bh=4qqSaaEUaBxS/Ftpx5ut5gMjSpAATXUG2v3pxLtTKv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sfbze19L3l07eXEtkma4lADuxbf9WZtig91HDAr1pJvB3RPJID38ZEHl817fxLXAg+2d7hztSP9oLtutCrXBk3DwcDDZVqClTVBJ2U5rBsvLcoOU4KktBkos/2JXvRS3jqdqJmnGbS68bGpdfaqMVznOUAMbiRmidoQNItCAmhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PsTZWgsd; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5d7005ea1d0so1061977a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 20:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1706934564; x=1707539364; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1OOpEywyK6PX3KS+rQWL+L2zrjo4/gGzpSvMxyFSqgc=;
        b=PsTZWgsdvj8z4doAvoejMFffuidiYXRo19Hv4RUjevLEbsn64+MrDYWTgCbGTvI9w0
         zLU/OsOTMf/Qyt/CsRkLiOpM8Bhl0FiWnuzOZYbaCTXwg5uTZzPGfw7YMluj4eUlOckc
         vznsBnsrEgSg/xE2RsRu3C6yiXP3WC4LK9LiMNWTi9Ht7YXsnLbE3VBXkcErH9O36T38
         mLRj5Yrw17FFcycrsG2joUwjwpB7VpjNJM33wYmjp92XMCBR+h6i57qZVRokl4vvOif/
         ZRYNaYPlsKf495Kf2YHM4Z7ZCqX0ONXoDPc5Rm3GEu7piGP25GZBMM9YUvbxS0nYQlMb
         /fcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706934564; x=1707539364;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1OOpEywyK6PX3KS+rQWL+L2zrjo4/gGzpSvMxyFSqgc=;
        b=TgJC3KBWzvUNBu7LLDPhWwVKDvvSl+55mJS2mTZupXP78RKgR+gf3G8OnQRtxa+2LN
         NV2/auvnMGrii2r9gTjP8EKetUUdMkchuV939v6K8SizFj37UcLTbIvOIaLMgBZqz0zC
         mF6MGz8Ck/Zyele7SVeRXsmWXW4n9wcQqsULdiyE54BLT97GR1umCOzRXwgXaoHW7PRO
         CJLDFno4P+rI583btAxspnB6h1popqvpDZ4FGi+PwcLLcSpfSY9DA5Z5vx6/uRzdc0sm
         WSYAQJgic2tkk2yTXBOK4EVC8j/jw4Fxk+7m5r/1tAQZ2LQUOBuRuIK8re+FkzXoZ4F9
         7urw==
X-Gm-Message-State: AOJu0YzhE2R/PFdfbxglFwpnK7zNmW7brLz4jTgY6yiNAzn8sl42D4Fa
	EcqHc/u6TyygaqubQv2PVG8JxQdWJpYUUmy8FL1ef8KQpfHdEL0yk4gReysESQ+p9B5Y6DuNnxP
	e
X-Google-Smtp-Source: AGHT+IGn4oPkO71WxukoX1CXReQti9d0soaDxuC8RLqOG10MY5XTB2tF6jUoHIozJFeEIXLwehIMOw==
X-Received: by 2002:a05:6a21:328e:b0:19e:3839:4fc2 with SMTP id yt14-20020a056a21328e00b0019e38394fc2mr903713pzb.26.1706934563683;
        Fri, 02 Feb 2024 20:29:23 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWsy5iHsgi0/7lWONXylSavwzjl3LXlbzwKWLoT4phVm66hn6dRJIu0Zsk73Zn+KR5t3KlfTlJJT9dwl8sNedyLikih3mUjodRzQQYkUzgJnGHEjfAzt5Ne5WfzEtQKW09m6YORcudd2qMHpjyd42WTZ2JkdhIWOrA48gSWhqmCAEFR/zu0Lu06oVMuGLHGAtPtaw==
Received: from [10.4.12.121] ([139.177.225.224])
        by smtp.gmail.com with ESMTPSA id u27-20020a63471b000000b005c259cef481sm2601789pga.59.2024.02.02.20.29.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 20:29:23 -0800 (PST)
Message-ID: <80460fe5-baec-4e56-9e10-a233e5a3c8d3@bytedance.com>
Date: Sat, 3 Feb 2024 12:29:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] mm/zswap: remove duplicate_entry debug value
Content-Language: en-US
To: Nhat Pham <nphamcs@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Yosry Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240201-b4-zswap-invalidate-entry-v1-0-56ed496b6e55@bytedance.com>
 <20240201-b4-zswap-invalidate-entry-v1-4-56ed496b6e55@bytedance.com>
 <CAKEwX=Pj9ms56zPaFznXrY0mF7E_q1hMXUkV-Fhnx5V17OY6og@mail.gmail.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAKEwX=Pj9ms56zPaFznXrY0mF7E_q1hMXUkV-Fhnx5V17OY6og@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/2/3 06:28, Nhat Pham wrote:
> On Thu, Feb 1, 2024 at 7:50 AM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
>>
>> cat /sys/kernel/debug/zswap/duplicate_entry
>> 2086447
>>
>> When testing, the duplicate_entry value is very high, but no warning
>> message in the kernel log. From the comment of duplicate_entry
>> "Duplicate store was encountered (rare)", it seems something goes wrong.
>>
>> Actually it's incremented in the beginning of zswap_store(), which found
>> its zswap entry has already on the tree. And this is a normal case,
>> since the folio could leave zswap entry on the tree after swapin,
>> later it's dirtied and swapout/zswap_store again, found its original
>> zswap entry. (Maybe we can reuse it instead of invalidating it?)
> 
> Interesting. So if we make invalidate load the only mode, this oddity
> is gone as well?

Good point!
This oddity is why we need to invalidate it first at the beginning.

But there is another oddity that a stored folio maybe dirtied again,
so that folio needs to be writeback/stored for the second time, in
which case, we still need to invalidate it first to avoid WARN_ON later.

Thanks.

>>
>> So duplicate_entry should be only incremented in the real bug case,
>> which already have "WARN_ON(1)", it looks redundant to count bug case,
>> so this patch just remove it.
> 
> But yeah, I have literally never checked this value (maybe I should
> ha). I'm fine with removing it, unless someone has a strong case for
> this counter?
> 
> For now:
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> 
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> ---
>>  mm/zswap.c | 9 +--------
>>  1 file changed, 1 insertion(+), 8 deletions(-)
>>
>> diff --git a/mm/zswap.c b/mm/zswap.c
>> index 4381b7a2d4d6..3fbb7e2c8b8d 100644
>> --- a/mm/zswap.c
>> +++ b/mm/zswap.c
>> @@ -71,8 +71,6 @@ static u64 zswap_reject_compress_poor;
>>  static u64 zswap_reject_alloc_fail;
>>  /* Store failed because the entry metadata could not be allocated (rare) */
>>  static u64 zswap_reject_kmemcache_fail;
>> -/* Duplicate store was encountered (rare) */
>> -static u64 zswap_duplicate_entry;
>>
>>  /* Shrinker work queue */
>>  static struct workqueue_struct *shrink_wq;
>> @@ -1571,10 +1569,8 @@ bool zswap_store(struct folio *folio)
>>          */
>>         spin_lock(&tree->lock);
>>         entry = zswap_rb_search(&tree->rbroot, offset);
>> -       if (entry) {
>> +       if (entry)
>>                 zswap_invalidate_entry(tree, entry);
>> -               zswap_duplicate_entry++;
>> -       }
>>         spin_unlock(&tree->lock);
>>         objcg = get_obj_cgroup_from_folio(folio);
>>         if (objcg && !obj_cgroup_may_zswap(objcg)) {
>> @@ -1661,7 +1657,6 @@ bool zswap_store(struct folio *folio)
>>          */
>>         while (zswap_rb_insert(&tree->rbroot, entry, &dupentry) == -EEXIST) {
>>                 WARN_ON(1);
>> -               zswap_duplicate_entry++;
>>                 zswap_invalidate_entry(tree, dupentry);
>>         }
>>         if (entry->length) {
>> @@ -1822,8 +1817,6 @@ static int zswap_debugfs_init(void)
>>                            zswap_debugfs_root, &zswap_reject_compress_poor);
>>         debugfs_create_u64("written_back_pages", 0444,
>>                            zswap_debugfs_root, &zswap_written_back_pages);
>> -       debugfs_create_u64("duplicate_entry", 0444,
>> -                          zswap_debugfs_root, &zswap_duplicate_entry);
>>         debugfs_create_u64("pool_total_size", 0444,
>>                            zswap_debugfs_root, &zswap_pool_total_size);
>>         debugfs_create_atomic_t("stored_pages", 0444,
>>
>> --
>> b4 0.10.1


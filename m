Return-Path: <linux-kernel+bounces-42508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A00384025E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0346428334B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C654355E71;
	Mon, 29 Jan 2024 10:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XqWo8xSZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C57555E50
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 10:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706522824; cv=none; b=u+3l3LVcYGtiGaIdIlfSBUGPVhyzW/c8pToigldIB/6G0lp2sIQCP4wna9f3A03q0NeufEpt3vJmMsxHoEifAt+5o2kcwVt4Sn44iGBkw1Om0JCymvQVgIYsDOsQSbdDLsGyQqXvH9avij7esUedNIQwVoFRiYi4GGeRC8HfEq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706522824; c=relaxed/simple;
	bh=4CXMVwWXnc4I6ck1HFy4YdbM3B5NfAW+ukFCId2lGmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TBTaiswN8ujcbErV2nH6MBrWHCx3/sSJfb1OmsAnoZcMNZadvPKKCVKoB632MxTriMsX3+g671UZ+7oPCeR2+toz863nLrCxLVdg1/OgDn/doNwv/YoPi69Lg7/l9eZXoqh79z631txfTi1sseS9eUvpDE4en04biY3jSsAW4Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XqWo8xSZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706522822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TJ+kpLO8S2nJ/FNOmYT0qOoCSDg7N4DFgt/5cBfrEsI=;
	b=XqWo8xSZ/4L5OoYUy3KJqXoXOz9+iUSPUBlsCV5pAk+U5OmYUIdN+xdZ6GELb4qnCf/7M0
	QaChV61R+PSvq2IDpPOlZFb5D7sBa2yxubSj2E/EIvAw+n9pm1aehqPuRA7gS2gJFUreCF
	sIb6LHPuvVUR0ev997iqThK3bd6hESM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-UQ_B8U3QOk6SY83w13AnPw-1; Mon, 29 Jan 2024 05:06:59 -0500
X-MC-Unique: UQ_B8U3QOk6SY83w13AnPw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40d62d3ae0cso22283445e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 02:06:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706522818; x=1707127618;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJ+kpLO8S2nJ/FNOmYT0qOoCSDg7N4DFgt/5cBfrEsI=;
        b=LvRJa6PcYW1EoPd2Nuh1auCYgmOcULFOk6eMMFfezN/+7p4h5uGdrXnNlLkW7iOTq4
         6FPNdGS1vPW73NhZY5qqv4dF1t7ZuJwUa3lp0yVbZkxxvmeCsI2Sn05/WnrynU2WrkpD
         bpjbGxHYlGEnKVDYHYhU/L4XTEjl4Zfo9dlzVEYZTGKYxiLs7kpR9RK3XKxr6cU6lTvv
         oOcthmrFOrH4+bFN9r869YDZt9vxKkPaiPFy3vGOWJc9bv6k4xABZHljo+kyJTzAkyYQ
         SOVCQVgoXeDuqdnG8Ekc1SU3Q1FTC7di3roV6o9+Pok9KRGwIF5nmOdfdFWe3kvc9FGK
         e55g==
X-Gm-Message-State: AOJu0YySCh04oeCOnR8wt8SgoF/QwA/RnTXPOEpAg6pFTpvwLwkiv8Zj
	LLz8sgEutAT7Wyp7ftM6W0trFvZ1uUMvUqJd66FApNg8jX2ruE5gSeBIT89j9geCMIYfRj3dKhL
	JdpJ3unqVe1zZVdarlRyzyu17slxI4SQfTFwKPxc3W2Tf+sENySR106Ryi6/wJg==
X-Received: by 2002:a05:600c:3b28:b0:40d:92c4:c2da with SMTP id m40-20020a05600c3b2800b0040d92c4c2damr4130085wms.31.1706522818646;
        Mon, 29 Jan 2024 02:06:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+1pe4fgzt0UKvDoFCiJ1bx3S/bnNig5L+BMeoboh/4aautE6eZ1WeKq1IVcZ790bv9NoWbA==
X-Received: by 2002:a05:600c:3b28:b0:40d:92c4:c2da with SMTP id m40-20020a05600c3b2800b0040d92c4c2damr4130056wms.31.1706522818269;
        Mon, 29 Jan 2024 02:06:58 -0800 (PST)
Received: from ?IPV6:2003:cb:c721:aa00:3221:f685:1200:6d03? (p200300cbc721aa003221f68512006d03.dip0.t-ipconnect.de. [2003:cb:c721:aa00:3221:f685:1200:6d03])
        by smtp.gmail.com with ESMTPSA id je16-20020a05600c1f9000b0040ec66021a7sm9738537wmb.1.2024.01.29.02.06.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 02:06:57 -0800 (PST)
Message-ID: <c11d73d5-105e-4ae1-837a-b9da392d2dad@redhat.com>
Date: Mon, 29 Jan 2024 11:06:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 5/6] mm: rmap: weaken the WARN_ON in
 __folio_add_anon_rmap()
Content-Language: en-US
To: Chris Li <chrisl@kernel.org>, Barry Song <21cnbao@gmail.com>
Cc: ryan.roberts@arm.com, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, mhocko@suse.com, shy828301@gmail.com,
 wangkefeng.wang@huawei.com, willy@infradead.org, xiang@kernel.org,
 ying.huang@intel.com, yuzhao@google.com, surenb@google.com,
 steven.price@arm.com, Barry Song <v-songbaohua@oppo.com>,
 Chuanhua Han <hanchuanhua@oppo.com>
References: <20231025144546.577640-1-ryan.roberts@arm.com>
 <20240118111036.72641-1-21cnbao@gmail.com>
 <20240118111036.72641-6-21cnbao@gmail.com>
 <58efd8d4-28aa-45d6-b384-7463568b24bb@redhat.com>
 <CAGsJ_4zwUpL7LihRBOefg-cmY2mgNjMm-MPkq9VFBdXS_4b=uQ@mail.gmail.com>
 <CAF8kJuNHrM+ZQSnTAOt6rrmGr1P=YS8eU+RSqhAc1CjQ7qdEwQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAF8kJuNHrM+ZQSnTAOt6rrmGr1P=YS8eU+RSqhAc1CjQ7qdEwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29.01.24 04:25, Chris Li wrote:
> Hi David and Barry,
> 
> On Mon, Jan 22, 2024 at 10:49 PM Barry Song <21cnbao@gmail.com> wrote:
>>
>>>
>>>
>>> I have on my todo list to move all that !anon handling out of
>>> folio_add_anon_rmap_ptes(), and instead make swapin code call add
>>> folio_add_new_anon_rmap(), where we'll have to pass an exclusive flag
>>> then (-> whole new folio exclusive).
>>>
>>> That's the cleaner approach.
>>>
>>
>> one tricky thing is that sometimes it is hard to know who is the first
>> one to add rmap and thus should
>> call folio_add_new_anon_rmap.
>> especially when we want to support swapin_readahead(), the one who
>> allocated large filio might not
>> be that one who firstly does rmap.
> 
> I think Barry has a point. Two tasks might race to swap in the folio
> then race to perform the rmap.
> folio_add_new_anon_rmap() should only call a folio that is absolutely
> "new", not shared. The sharing in swap cache disqualifies that
> condition.

We have to hold the folio lock. So only one task at a time might do the
folio_add_anon_rmap_ptes() right now, and the 
folio_add_new_shared_anon_rmap() in the future [below].

Also observe how folio_add_anon_rmap_ptes() states that one must hold 
the page lock, because otherwise this would all be completely racy.

 From the pte swp exclusive flags, we know for sure whether we are 
dealing with exclusive vs. shared. I think patch #6 does not properly 
check that all entries are actually the same in that regard (all 
exclusive vs all shared). That likely needs fixing.

[I have converting per-page PageAnonExclusive flags to a single 
per-folio flag on my todo list. I suspect that we'll keep the 
per-swp-pte exlusive bits, but the question is rather what we can 
actually make work, because swap and migration just make it much more 
complicated. Anyhow, future work]

> 
>> is it an acceptable way to do the below in do_swap_page?
>> if (!folio_test_anon(folio))
>>        folio_add_new_anon_rmap()
>> else
>>        folio_add_anon_rmap_ptes()
> 
> I am curious to know the answer as well.


Yes, the end code should likely be something like:

/* ksm created a completely new copy */
if (unlikely(folio != swapcache && swapcache)) {
	folio_add_new_anon_rmap(folio, vma, vmf->address);
	folio_add_lru_vma(folio, vma);
} else if (folio_test_anon(folio)) {
	folio_add_anon_rmap_ptes(rmap_flags)
} else {
	folio_add_new_anon_rmap(rmap_flags)
}

Maybe we want to avoid teaching all existing folio_add_new_anon_rmap() 
callers about a new flag, and just have a new 
folio_add_new_shared_anon_rmap() instead. TBD.

> 
> BTW, that test might have a race as well. By the time the task got
> !anon result, this result might get changed by another task. We need
> to make sure in the caller context this race can't happen. Otherwise
> we can't do the above safely.
Again, folio lock. Observe the folio_lock_or_retry() call that covers 
our existing folio_add_new_anon_rmap/folio_add_anon_rmap_pte calls.

-- 
Cheers,

David / dhildenb



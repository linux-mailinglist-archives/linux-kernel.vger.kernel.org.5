Return-Path: <linux-kernel+bounces-63197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B23D9852C32
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3670D1F227C2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44782232A;
	Tue, 13 Feb 2024 09:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EuML/sPg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A44A210FE
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 09:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707816333; cv=none; b=rsX86XiD1/I56nYkNrfvOKMtCyu0elj3icg3g3CPnN9ZYoewfRDNOabnpz05bqdnA4y3GE7KAjnNGYjXJkcvtQ/KUHFIS8zP2OzDdyKUT6FSSn+wbuQgLRatYV/OFz2xQwu9KXJl0sOwihcGTYnmwHraU8OzwjaZczGestbs0ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707816333; c=relaxed/simple;
	bh=sujtu4NMxU2gZVPbuuJEqTD1dbdhb+S8T8DifR8NKDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VVJEmMzyDfM/VTyNx4/2Z1WDCgduR2heI7TXTmQVEPACMdS/2yVF7358Bk1vRLUcK6TmHmnm7gw6wngm5UOtbq1A+3CT7MmdnnBmWKhPx332aZ79MvUaYhUG/Wygoq+YQ16ObXYwjLAA/AO8CScgms3v3fFmiDpEiqnrSUi1/IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EuML/sPg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707816327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=X4kmwrh4gzNF5CpDnNaGSP3k+zfl5ZApFZSnmdKbDz4=;
	b=EuML/sPgzolh8DaGhZ6pUSoHZhcuOVwccdZXhndk5bky/xFn3wKM9MYbfjGdcvaM6WRlRJ
	v77wvFekiFyUmSjDwKxna1yQ7VviiW5iK90vnMHU5C4vwtdjLNVrYGQ2uIF8/jCfafjOvE
	QbhJWBTqN3RCHiPrl6etJDTIIxiqNkc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-EShaoF27M4mT36C9gX1WUQ-1; Tue, 13 Feb 2024 04:25:25 -0500
X-MC-Unique: EShaoF27M4mT36C9gX1WUQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-337a9795c5cso462304f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 01:25:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707816324; x=1708421124;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4kmwrh4gzNF5CpDnNaGSP3k+zfl5ZApFZSnmdKbDz4=;
        b=B/V9r82NvvqxNOOJqPX2awry6VhqR0SrXi4I42RZ6vLAtkfwZzOhisD6gSPOO/UcG5
         KpKfPnKC0pZHkF52QYic49FgBC7yZxZfHdsDHYQkY8nMohuATX8xb+AiVt88ZFkqD8IV
         fXlYXEhMWfJ1UberntCR0fWtq7K5xhaJUSMKr4iSApEIIw5e0J/UxOa/IxGF6HY7IYH5
         FVbeqNlXYXdg5cTkLQkKiCeRJzS9UbrAOGPXM/rMMbVJxaMJogbsoase3gciE7QvgtxW
         Ma9oy7MgEY7+uemVGMk4xgPCXNbUXoEiT8CVeVncLEvp2x9Vs7oXA7WFVb1MPnPIASK7
         OIpw==
X-Gm-Message-State: AOJu0YxTilP+R9YPLJTH1t/rZLv7Kt45j9PALAnsaDYoB6JLIP7K9lF+
	6T1S/sylGzERMNaOeqBm7dowsWz7bIjJVKuqtQP/VSkQ/5VCpclPdfGwPWKmMSwu089z5etkIDw
	lgalmpLv3rU696LE5iGXjOCW9750Xa4JR9hxjlrSGR1BCZpsaHxyT3plBgtMDgA==
X-Received: by 2002:adf:f591:0:b0:33c:d595:cc3f with SMTP id f17-20020adff591000000b0033cd595cc3fmr914219wro.71.1707816324085;
        Tue, 13 Feb 2024 01:25:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEd9dEvtt3w1MkGlqf68DU/PwjIE8HXOR1QNpcK+9SqYYxbt0usxkLd9wMX4Rj16mCABXtKGA==
X-Received: by 2002:adf:f591:0:b0:33c:d595:cc3f with SMTP id f17-20020adff591000000b0033cd595cc3fmr914206wro.71.1707816323690;
        Tue, 13 Feb 2024 01:25:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWuyDj+XtS4VCd0lKswGAOQpYuC6x4P+P3/A3pTFiaZfqonxDzkeWER4NdZtDW/V51bo8ES1CNNAor2e9c99KGa1DdY6ciKKeejAh/TsFWj3X//xGR8ZVvR9i1cGbEwv44+1gWTBq1tTL5GMbVUqkgcnCUyRr9UOFja2Cj6IFhyGw8K76i53WvD5JG4YMLV8DNKx8K0oFnwCSnalaeeuPpl9rXWqjwSwps6O/d18q1JfNAqFyA8nIvJfRhUUpcXzn/xbVG3H5U3pGzO+Leirq+mfTA3aB3uBnxgCPxWBsnktMIsLS2FYpX6
Received: from ?IPV6:2003:cb:c70a:4d00:b968:9e7a:af8b:adf7? (p200300cbc70a4d00b9689e7aaf8badf7.dip0.t-ipconnect.de. [2003:cb:c70a:4d00:b968:9e7a:af8b:adf7])
        by smtp.gmail.com with ESMTPSA id bt9-20020a056000080900b0033b75d0993esm7810202wrb.74.2024.02.13.01.25.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 01:25:23 -0800 (PST)
Message-ID: <a683e199-ce8a-4534-a21e-65f2528415a6@redhat.com>
Date: Tue, 13 Feb 2024 10:25:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: fix swap entry values of tail pages of
 THP
To: Charan Teja Kalla <quic_charante@quicinc.com>,
 gregkh@linuxfoundation.org, akpm@linux-foundation.org, willy@infradead.org,
 vbabka@suse.cz, dhowells@redhat.com, surenb@google.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 # see patch description <stable@vger.kernel.org>
References: <1707814102-22682-1-git-send-email-quic_charante@quicinc.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <1707814102-22682-1-git-send-email-quic_charante@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.02.24 09:48, Charan Teja Kalla wrote:
> An anon THP page is first added to swap cache before reclaiming it.
> Initially, each tail page contains the proper swap entry value(stored in
> ->private field) which is filled from add_to_swap_cache(). After

This is a stable-only fix? In that case, it make sense to indicate that 
in the patch subject [PATCH STABLE vX.Y].

But it's always odd to have stable-only fixes, the docs [1] don't cover 
that (maybe they should? or I missed it).

[1] https://www.kernel.org/doc/Documentation/process/stable-kernel-rules.rst


So we are migrating a THP that was added to the swapcache. Do you have a 
reproducer?

> migrating the THP page sitting on the swap cache, only the swap entry of
> the head page is filled(see folio_migrate_mapping()).
> 
> Now when this page is tried to split(one case is when this page is again
> migrated, see migrate_pages()->try_split_thp()), the tail pages
> ->private is not stored with proper swap entry values.  When this tail
> page is now try to be freed, as part of it delete_from_swap_cache() is
> called which operates on the wrong swap cache index and eventually
> replaces the wrong swap cache index with shadow/NULL value, frees the
> page.

But what if we don't split the THP after migration. Is there anything 
else that can go wrong?

It's sufficient to look where upstream calls page_swap_entry():

For example, do_swap_page() will never be able to make progress, because 
the swap entry of the page does not correspond to the swap entry in the 
PTE? It can easily fault on a swap PTE that refers a THP subpage in the 
swapcache.

So unless I am missing something, only fixing this up during the split 
is insufficient. You have to fix it up during migration.

> 
> This leads to the state with a swap cache containing the freed page.
> This issue can manifest in many forms and the most common thing observed
> is the rcu stall during the swapin (see mapping_get_entry()).
> 
> On the recent kernels, this issues is indirectly getting fixed with the
> series[1], to be specific[2].
> 
> When tried to back port this series, it is observed many merge
> conflicts and also seems dependent on many other changes. As backporting
> to LTS branches is not a trivial one, the similar change from [2] is
> picked as a fix.

The fix is in

commit cfeed8ffe55b37fa10286aaaa1369da00cb88440
Author: David Hildenbrand <david@redhat.com>
Date:   Mon Aug 21 18:08:46 2023 +0200

     mm/swap: stop using page->private on tail pages for THP_SWAP

> 
> [1] https://lore.kernel.org/all/20230821160849.531668-1-david@redhat.com/
> [2] https://lore.kernel.org/all/20230821160849.531668-5-david@redhat.com/
> 
> Closes: https://lore.kernel.org/linux-mm/69cb784f-578d-ded1-cd9f-c6db04696336@quicinc.com/
> Fixes: 3417013e0d18 ("mm/migrate: Add folio_migrate_mapping()")
> Cc: <stable@vger.kernel.org> # see patch description, applicable to <=6.1
> Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>

3417013e0d18 went into 5.16.

cfeed8ffe55b3 went into 6.6.

So only 6.1 is affected.


Isn't there a way to bite the bullet and backport that series to 6.1 
instead?

-- 
Cheers,

David / dhildenb



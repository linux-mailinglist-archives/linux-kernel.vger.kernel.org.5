Return-Path: <linux-kernel+bounces-104273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8364B87CB87
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6CBC1C220D4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8243618EAF;
	Fri, 15 Mar 2024 10:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eFUB45hz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D2118E1A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 10:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710498912; cv=none; b=sgaxblmngJktKcWEQAnels+w5bdiZ78ixc5k91kBrezWvoPMXG46gtzEO8tzJIzNwcnhj/7uZQJYM8vMyqS4M0eG/z1XHBZ8lkHeud9eG0n6WLWhkCN7tyRZduc5UIZdZX+/b+dupwGhWMcqQky7soJL5ankEM+gSNzem4sexzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710498912; c=relaxed/simple;
	bh=nnoGklqKmBzJPK6I7WEy7vCB5wiVPy4IjRQKT3LPdq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jnOZY0TuxRnS0FYWMWYKXi//Yecnu08hUJowjfBj4CNpnZNA75aZVm3cmWEhSY0lRbSSWgzg6Q7SmC4wXauuDgd9ZOkN6R9cRrXH1b06BYa77hzoN+casagZBlouOvBFBS1q98tTHqSzJ2oFkkcZZRV7Z2EezQRub1nfz52JHMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eFUB45hz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710498910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sU9/6AoCx2nLXtIV7kaN3fZw43BRFG5cs4xOhA4WV68=;
	b=eFUB45hzlntDf64CpWC/n3Qf3T6HxxDtdWpnkbJ2U+e5IEcQESceJFtfjhlgvno1UMhppM
	IhYXatQZdmvKdMC3eDCdPS5Wep+gsGLcK52R/Wa8vhzz47qvEY38V6oaz5S3faW1q3wIor
	tsIyBKv8xQ/YIY6BxBgjwgkUwg9609Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-3CiyhiDzNBe6RzGC0M6n5w-1; Fri, 15 Mar 2024 06:35:08 -0400
X-MC-Unique: 3CiyhiDzNBe6RzGC0M6n5w-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-41330261f8cso9033675e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 03:35:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710498907; x=1711103707;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sU9/6AoCx2nLXtIV7kaN3fZw43BRFG5cs4xOhA4WV68=;
        b=rR+v+QCxr2gDPWluTt4kI2PBHWm/lLmEAlGIKFDT8IXdPBAb0Wymx52UiWWbIXmz4S
         9FJWYmj1+rTUnLd/jQclUJDNiiB16bEQeHNEBGgaTfYI+6rh2NCoT+hP/l2jAvFN5wfI
         WLu2YufK9NMGCigtDB23R/W6sbmPYogtj/FLGuBYm3cuahEj9xFRqtfqJjxbMHKm637H
         CTgeowYWzPGNcqBCqjXbf2cKM5gofA9vJfdshgOR7hg5RBsAgIq5yatZYX7wlTv9qXrQ
         jDED+rdIG8fxYE3gOrGkPbpXkJCxL0nNaBE+cpzucdWUxfOsiEO0jrNVW5dGePb2Lx/Q
         sXZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfezidb0eR7UROG/qkioT6Pg03NBIo0KZeMbpSYhr10ceKJrLzhyni027LHpeL0Om/O9tGWOBAbTImL8ItWt1/2Qj2GVYTtlVqBRQv
X-Gm-Message-State: AOJu0Yzvme4HccGiY68jf1rt7JGG+958Cz4gdcvheLbn/4HiPSdRyT3g
	QroGeL4ZgXdZyg46d/O0jT5GMEA/238b6c1HtBCn+DxiXzJp8uNg+2VF1wp9x5RV2jUy7KXKa7T
	1jKlMfPUrgx62tgJrwwW/T/+iQPQLP7LpmOJSgCiL6AQtA3kYIv+aw2qBGZNI8A==
X-Received: by 2002:a05:600c:45c9:b0:413:ef04:d342 with SMTP id s9-20020a05600c45c900b00413ef04d342mr3733906wmo.9.1710498907453;
        Fri, 15 Mar 2024 03:35:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiQCXS9610p0jGS9o5jQ6osackI+sK8HhGN2gc3IT4swvv3a4cM6Vt6UCbw2MShqT3QKeJ9A==
X-Received: by 2002:a05:600c:45c9:b0:413:ef04:d342 with SMTP id s9-20020a05600c45c900b00413ef04d342mr3733886wmo.9.1710498907033;
        Fri, 15 Mar 2024 03:35:07 -0700 (PDT)
Received: from ?IPV6:2003:cb:c719:7700:ef08:112b:278d:7d90? (p200300cbc7197700ef08112b278d7d90.dip0.t-ipconnect.de. [2003:cb:c719:7700:ef08:112b:278d:7d90])
        by smtp.gmail.com with ESMTPSA id iv9-20020a05600c548900b00413eedd36a4sm6242356wmb.39.2024.03.15.03.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 03:35:06 -0700 (PDT)
Message-ID: <ffeee7da-e625-40dc-8da8-b70e4e6ef935@redhat.com>
Date: Fri, 15 Mar 2024 11:35:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] mm: madvise: Avoid split during MADV_PAGEOUT and
 MADV_COLD
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Huang Ying <ying.huang@intel.com>,
 Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
 Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Barry Song <21cnbao@gmail.com>,
 Chris Li <chrisl@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240311150058.1122862-1-ryan.roberts@arm.com>
 <20240311150058.1122862-7-ryan.roberts@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240311150058.1122862-7-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> -		if (!pageout && pte_young(ptent)) {
> -			ptent = ptep_get_and_clear_full(mm, addr, pte,
> -							tlb->fullmm);
> -			ptent = pte_mkold(ptent);
> -			set_pte_at(mm, addr, pte, ptent);
> -			tlb_remove_tlb_entry(tlb, pte, addr);
> +		if (!pageout) {
> +			for (; nr != 0; nr--, pte++, addr += PAGE_SIZE) {
> +				if (ptep_test_and_clear_young(vma, addr, pte))
> +					tlb_remove_tlb_entry(tlb, pte, addr);
> +			}
>   		}


The following might turn out a bit nicer: Make folio_pte_batch() collect 
"any_young", then doing something like we do with "any_writable" in the 
fork() case:

..
	nr = folio_pte_batch(folio, addr, pte, ptent, max_nr,
			     fpb_flags, NULL, any_young);
	if (any_young)
		pte_mkyoung(ptent)
..

if (!pageout && pte_young(ptent)) {
	mkold_full_ptes(mm, addr, pte, nr, tlb->fullmm);
	tlb_remove_tlb_entries(tlb, pte, nr, addr);
}

-- 
Cheers,

David / dhildenb



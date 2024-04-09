Return-Path: <linux-kernel+bounces-136392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC4189D390
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F05061C214A4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 07:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E4D7D09D;
	Tue,  9 Apr 2024 07:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZklrHAO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD7776413
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 07:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712649119; cv=none; b=jsVjJOQfofFqnhV7HZKjIfsFpWpIEK0nxKVlfHnaH8N7NkU60EWhoQjKMPp4K1lzZsHoDbYP37Sm+UTbYnSr3OtggY/iDOW0J/ugE3xV/rG7xtCYawYl8H20OpSuZT7xuQ9DasyNvBcerQ/zh4sxwcPPaPsgAJ+Woa1J+8Hn52I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712649119; c=relaxed/simple;
	bh=zySbObiRMM7hJ+Oh3BGfN7uQ9qPzzKksM+PgFeKI3oM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ndl6QWgnbOAu/QIz9mQDlZ9oIiA4Ng4gj8qsxCoHTumaXfVuZFBJ4kaPY/lNcpFgz0NiGqQB8zZrUHY2gwUf5GdyK0UfPIQkI4H3gSyGgKczh2ZIfmmrdwNHwSwv1TSI3l5YotSRuSxJ6hwGvlajlLk5gSXEtYOzO3Woz35WHwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IZklrHAO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712649116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qsltBol8wPhnvMoX1X9d8kAUKHBIQf1YhHptThfDMWg=;
	b=IZklrHAOFWk3PUjSz/wqkPZeLlKHYmTNoq0ATzR5BwPUq26wL2Yj+blAF1Gn+nZheiQxOL
	HRu+QXeTTjtwc3vQ+6kGr1/0aWtUmYhOw0sf/9E1NNihdYHz1f66R0uEvQ293u0UMNFpMm
	aotFBGczXJyrKZcsJylbmIQAFEP3mQ8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-7GIs84h3PWOf9SJmBdf6gQ-1; Tue, 09 Apr 2024 03:51:55 -0400
X-MC-Unique: 7GIs84h3PWOf9SJmBdf6gQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-343f8b51910so1787563f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 00:51:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712649114; x=1713253914;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qsltBol8wPhnvMoX1X9d8kAUKHBIQf1YhHptThfDMWg=;
        b=pKzsvonyhZe629yr9PBRh2si9l59k2Vf27VkqPKk5snx6c7sUCcbTaizqmVuUSr1xw
         n+lZvTFILSZFpcclherVohLP9M4Pr4SasnIEm6VXYZqbJZtPU79GGgXZxjbwHWBVTopX
         dGFxaQkbe/ovL6m9RuRZarWgyMAyVlHJ5URMOGSBzPnp+Dv0AR9SVu032EPeKUDxXGeR
         CFce+E9Ao6kffWGhxPr7zXGF8MxNtIQylkXHnGIcGQZI5LozcIV10pLOYAlvO426ZLmZ
         VHAXSyAQi2LsRuAfDHOFwi7jg46R5ZOuwOMpurib8mDaKl9dyHvvYG8hoJDV27CyPceH
         96uQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqn/li01k5ytsXE9ER36jHArKdItOLOiqu+K+6A6nNfO+9ZmTlcJidndu8w7+FUqu4iwZ/C49i+IftHAG9yOaB9SHEzQdOqG0yvm79
X-Gm-Message-State: AOJu0YxKNgoihLoqrF3EIbxuh1LgIQFjywsm6IuAMzmq8oTUseY976YI
	rTPfohmV0bz7dtxa2grfox+UUPljhV2IW3nvnsc69D6ixE4pv245H2GeLZI6hkVM+JiBeMPGj/N
	IMhRdghc2qhJo1sa/kn83+hirK/RC2BjgiY8l3NjWE68BOMIf277vBYN39R2hdw==
X-Received: by 2002:adf:f449:0:b0:343:6cf9:9e38 with SMTP id f9-20020adff449000000b003436cf99e38mr7137163wrp.20.1712649114257;
        Tue, 09 Apr 2024 00:51:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEORzAWYIROBn2U67wRyGx89hEvpktMcGhARWILcAzbYV6vndb41sCxpcrtbk9WBqyJPV2viQ==
X-Received: by 2002:adf:f449:0:b0:343:6cf9:9e38 with SMTP id f9-20020adff449000000b003436cf99e38mr7137151wrp.20.1712649113853;
        Tue, 09 Apr 2024 00:51:53 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:be00:a285:bc76:307d:4eaa? (p200300cbc70abe00a285bc76307d4eaa.dip0.t-ipconnect.de. [2003:cb:c70a:be00:a285:bc76:307d:4eaa])
        by smtp.gmail.com with ESMTPSA id a3-20020adffb83000000b0034635bd6ba5sm393297wrr.92.2024.04.09.00.51.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 00:51:53 -0700 (PDT)
Message-ID: <0517bea9-dab0-42c4-96db-52dab89e7e1c@redhat.com>
Date: Tue, 9 Apr 2024 09:51:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 7/7] mm: madvise: Avoid split during MADV_PAGEOUT and
 MADV_COLD
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Huang Ying <ying.huang@intel.com>,
 Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
 Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Barry Song <21cnbao@gmail.com>,
 Chris Li <chrisl@kernel.org>, Lance Yang <ioworker0@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Barry Song <v-songbaohua@oppo.com>
References: <20240408183946.2991168-1-ryan.roberts@arm.com>
 <20240408183946.2991168-8-ryan.roberts@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240408183946.2991168-8-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.04.24 20:39, Ryan Roberts wrote:
> Rework madvise_cold_or_pageout_pte_range() to avoid splitting any large
> folio that is fully and contiguously mapped in the pageout/cold vm
> range. This change means that large folios will be maintained all the
> way to swap storage. This both improves performance during swap-out, by
> eliding the cost of splitting the folio, and sets us up nicely for
> maintaining the large folio when it is swapped back in (to be covered in
> a separate series).
> 
> Folios that are not fully mapped in the target range are still split,
> but note that behavior is changed so that if the split fails for any
> reason (folio locked, shared, etc) we now leave it as is and move to the
> next pte in the range and continue work on the proceeding folios.
> Previously any failure of this sort would cause the entire operation to
> give up and no folios mapped at higher addresses were paged out or made
> cold. Given large folios are becoming more common, this old behavior
> would have likely lead to wasted opportunities.
> 
> While we are at it, change the code that clears young from the ptes to
> use ptep_test_and_clear_young(), via the new mkold_ptes() batch helper
> function. This is more efficent than get_and_clear/modify/set,
> especially for contpte mappings on arm64, where the old approach would
> require unfolding/refolding and the new approach can be done in place.
> 
> Reviewed-by: Barry Song <v-songbaohua@oppo.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb



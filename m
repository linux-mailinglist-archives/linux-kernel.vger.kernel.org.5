Return-Path: <linux-kernel+bounces-76957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C5185FF07
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF0BBB240E9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD62D1552F3;
	Thu, 22 Feb 2024 17:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h+CwFrSa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336B2155306
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 17:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708622199; cv=none; b=eLqkwT8ob/ZSeX93jnfonJYV/pUByWI6+1D/J9jx1KgA8ABrLl+PHkpk9feoGJPVXlex8OO4hpQ8MJ7qs/Nxe9inHn2HIMlVprASlTgFjql+ORG4uuPWJ2+qs4wmCnXSXiqwdC/CbKSpqAHLu39B/es3nkVUdpvnE1ysublLs6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708622199; c=relaxed/simple;
	bh=CtXqJF1+n4e29y+LnaAaRjqtRkbaAMcxMgt9FkIYAoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M4nDbwNgjYPLBQRuc10xQkzwN+yHymyIKUtghX1RO1TheshpZ3HsV5xYZTJFLJqik5iUlXtsa6lrhj/q9wK1rDmYoImwSFMtelCp8SaNWmDz4ZFW9miAI2qhQjfWK+w0lZpWf2QWIjPoU0Bt2JYcGmJW8m9+Az4s7jMUJJ4ozyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h+CwFrSa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708622196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JTuukiLVYlOX3UUypO2eojhSEfBKmRllMc0/Rxzibrs=;
	b=h+CwFrSa4TQJEDLe62/QJexn5fXG3pqFeOmZYX19ScM/mQF7WkiNsGTpd+ejjo6IYBw1XL
	ykGO4GTC3QXvSxSzr+6CC7IdVXY4tctn6zpgwtuH1/ToHUlAXsNLf95dPtthOTpXvisNDQ
	/MnD0/22wwwlRqwdJ9wLObQVvkbgCcM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-0BTWqtrHOOmAPNan64BNSg-1; Thu, 22 Feb 2024 12:16:33 -0500
X-MC-Unique: 0BTWqtrHOOmAPNan64BNSg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4125edd9c6bso25161565e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:16:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708622188; x=1709226988;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTuukiLVYlOX3UUypO2eojhSEfBKmRllMc0/Rxzibrs=;
        b=GaxVEWIc4LFViA+8sZjJrrwx8JlfzNtUzffbFScj41Z1KATTnHT+TcsH6OikL9c0xF
         Q3dy+g5HRUw6DuhywSAU0zIs0ak44hoCEwSKpLxMg3ipdG/oe5swO3zjGg93NkkmWflI
         H6uXi1fPYuz752pba4yR94lDLA6zFHfpvnbdjlpbiLoxP5Pl3693R6J8s8/Myg/dBAmy
         W/W+5PmIDhW+71wY3ob3sWi2+9UBX85KaT0NJuW5EF3FLJoKHIaV7VDAUs9L7o6iFRbo
         BrdXT2uvfblA1Ln1cskK6ZNE5RvQbYMbHMrDqau/Qd3Y4K8LTYMJ82iHEk/9Q2v9Wr6H
         oAaw==
X-Gm-Message-State: AOJu0YyyiFRK6gGpaNu+zLcGd5tXgvFhx7FaKxWcwradizMhtLINEnIN
	+AxAGp1Ab81RPtd/UyRBfQKlvBn9HmVPB4+lfij8m2q8U5lcciRrzUie2kBNhPOmizqN8XXcELr
	IbF9Ot0azas1T2ByBhyaYMEefJxeFa8xuLecsmu+v2SkLPAdgwYeHqs9hJFkelg==
X-Received: by 2002:a05:600c:1392:b0:412:7eaf:c48f with SMTP id u18-20020a05600c139200b004127eafc48fmr2071399wmf.7.1708622188373;
        Thu, 22 Feb 2024 09:16:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQaBwe+yNbxOCf0kJIBDsT4UhayW64Euz2VeANOqZMjJsbMmb9l2jfM+kGXZb2yrcgTYnz+w==
X-Received: by 2002:a05:600c:1392:b0:412:7eaf:c48f with SMTP id u18-20020a05600c139200b004127eafc48fmr2071384wmf.7.1708622188053;
        Thu, 22 Feb 2024 09:16:28 -0800 (PST)
Received: from ?IPV6:2003:cb:c70f:8b00:ed48:6d18:2152:1cda? (p200300cbc70f8b00ed486d1821521cda.dip0.t-ipconnect.de. [2003:cb:c70f:8b00:ed48:6d18:2152:1cda])
        by smtp.gmail.com with ESMTPSA id b11-20020a05600c4e0b00b004129013aa45sm229577wmq.7.2024.02.22.09.16.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 09:16:27 -0800 (PST)
Message-ID: <d11304b9-4e95-4f04-b652-43eb15aaa9d5@redhat.com>
Date: Thu, 22 Feb 2024 18:16:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm: remove total_mapcount()
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>
References: <20240222160943.622386-1-david@redhat.com>
 <ZdeAys9D98RBaPL1@casper.infradead.org>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZdeAys9D98RBaPL1@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.02.24 18:13, Matthew Wilcox wrote:
> On Thu, Feb 22, 2024 at 05:09:43PM +0100, David Hildenbrand wrote:
>> We always get a head page, so we can just naturally interpret is as a folio
>> (similar to other code).
> 
> memfd seems rather confused about how to iterate over the page cache.
> Perhaps we could sort that out and then delete total_mapcount as a
> second patch?
> 
> I haven't tested this at all, but ...
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> diff --git a/mm/memfd.c b/mm/memfd.c
> index d3a1ba4208c9..45e55b0e3cbe 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -29,28 +29,29 @@
>   #define MEMFD_TAG_PINNED        PAGECACHE_TAG_TOWRITE
>   #define LAST_SCAN               4       /* about 150ms max */
>   
> +static bool memfd_extra_refs(struct folio *folio)
> +{
> +	return folio_ref_count(folio) - folio_mapcount(folio) !=
> +		folio_nr_pages(folio);
> +}

That is an obvious improvement I should have realized myself.

Let me play with that.

Thanks!

-- 
Cheers,

David / dhildenb



Return-Path: <linux-kernel+bounces-33828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDEE836F13
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71EA71C2605D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E941B57315;
	Mon, 22 Jan 2024 17:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GQSFaHq6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4E756B7C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705944864; cv=none; b=NMym0ChqLx4THBKeOkCRU1+7A8KEhvptmthbFimcjLbaxIqbpHbMd4vWh0ugLnJiij169gj1bJyO0rhHW1BBm/AKTkqvGn3R3ji+UratNvpksycRe7vYhWwVIT2Sl7vlFftTOxLhA0J9E3y9+RgmfqUocFkOij+ClyFhaQ79CWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705944864; c=relaxed/simple;
	bh=psjgzvn4ilGV8uyPsvTtI0yJRj4k6PfZVvdnfDis09E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O5jPu5q9F5qBFQKA2kv6QKNBitaROft/rtMYoFTHk/rSZ0Z2scNnMgVbwmsdF46HD8BUampaJ4yIYk+L6y11yH4ufKZ9vpYhRtOVuboP/egfcrOIDwdb1MnfiQ24FF5JpHrpfOfZ5+h4PZvP/lSxGQzoM28+KayTBi6bMBOzyP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GQSFaHq6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705944861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JVhXCj+zVb64z4rJlyu7FmGbPuVGc4Yu55zzJnDneDw=;
	b=GQSFaHq6kxSzRIhwM1gfJI39cDkKg9PSGsrBKNGnBdonP59h+ijJILobqh163PjN8szl4d
	xQtubQduwshYRD3cz9u0B31vIA71x6KHbEVXRY3zSPPflG1oVAfaAzzhbZHFPvqnSEDDuV
	e2dH7NClMx1Hu/LFRKzGXSsXBANG6Eo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-KanY31ynMgio5CAinLuPnw-1; Mon, 22 Jan 2024 12:34:18 -0500
X-MC-Unique: KanY31ynMgio5CAinLuPnw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40e89a9a763so33930245e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 09:34:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705944857; x=1706549657;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVhXCj+zVb64z4rJlyu7FmGbPuVGc4Yu55zzJnDneDw=;
        b=gH6rMOeaKzEqX5W3urSAmxcQ4kUcyagbGxvBXz0GinmhO2HH39LyO7A+AYX1dD6562
         Bh18Epk8FkYXE6OqvoL7/yQbMfLj8dw5AvBQD0Xwp7lPfGYnxzeXLFoljc35i9lKnAY7
         cumrD8wp1p81oozCXd0M2ELb4vk6pi7quEnrkkpyGtJgUCvqLeC0EwKBsHQIMaUNGIqz
         xcm/E2s5yGGJHXj9ZNS9B07CDfQR0/qRlUrZpJ3fdAJcThrfAEn6jbzhryIJkHjUpsa3
         HPHi+fHy1wtDNhpamS30loAu17j4ikV8VKud7fIKLXsTqWlYPLXOyQ7riEyyLi1RNVn6
         RDwA==
X-Gm-Message-State: AOJu0YzZ7Xk2bEzw3fOyI/eLfuwjtje7G9jGGEC8ahntuvfS1fKZoJHv
	x0UOxAuCc3tXRRWh8G3klGYJbvrgEhrT+fT4Qhyp94ryZxyCCWX/MgPwmhoOlU7iQtai77gz0pk
	TUkbU5xQsJSnoycCXHExIwmlyY0fQH3armT8vtYKcXuHp06fNMsqm87BM4OfOGQ==
X-Received: by 2002:a05:600c:154b:b0:40e:a370:35d4 with SMTP id f11-20020a05600c154b00b0040ea37035d4mr1232147wmg.95.1705944857418;
        Mon, 22 Jan 2024 09:34:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2wvwTL5POCQU0i8HTDG1ylDcpgV+uQsddAbZ9gg5iMLxqyNNwE/AR7TQjFzCEmJ8juNrQOQ==
X-Received: by 2002:a05:600c:154b:b0:40e:a370:35d4 with SMTP id f11-20020a05600c154b00b0040ea37035d4mr1232139wmg.95.1705944856977;
        Mon, 22 Jan 2024 09:34:16 -0800 (PST)
Received: from ?IPV6:2003:cb:c737:f400:b194:1841:c4a5:75f5? (p200300cbc737f400b1941841c4a575f5.dip0.t-ipconnect.de. [2003:cb:c737:f400:b194:1841:c4a5:75f5])
        by smtp.gmail.com with ESMTPSA id x7-20020a5d6507000000b003392940f749sm6716219wru.77.2024.01.22.09.34.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 09:34:16 -0800 (PST)
Message-ID: <7214a9f5-367c-492c-b1bd-80bdc9b7ba4c@redhat.com>
Date: Mon, 22 Jan 2024 18:34:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 28/40] mm/memory: page_remove_rmap() ->
 folio_remove_rmap_pte()
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Hugh Dickins <hughd@google.com>, Yin Fengwei <fengwei.yin@intel.com>,
 Mike Kravetz <mike.kravetz@oracle.com>, Muchun Song <muchun.song@linux.dev>,
 Peter Xu <peterx@redhat.com>
References: <20231220224504.646757-1-david@redhat.com>
 <20231220224504.646757-29-david@redhat.com>
 <2445cedb-61fb-422c-8bfb-caf0a2beed62@arm.com>
 <007e83fa-16c7-4700-b326-ee8cb7809f9f@redhat.com>
 <Za6jxXIFjnCnyvPE@casper.infradead.org>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Za6jxXIFjnCnyvPE@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.01.24 18:20, Matthew Wilcox wrote:
> On Mon, Jan 22, 2024 at 06:01:58PM +0100, David Hildenbrand wrote:
>>> And folio_mark_dirty() is doing more than just setting teh PG_dirty bit. In my
>>> equivalent change, as part of the contpte series, I've swapped set_page_dirty()
>>> for folio_mark_dirty().
>>
>> Good catch, that should be folio_mark_dirty(). Let me send a fixup.
>>
>> (the difference in naming for both functions really is bad)
> 
> It really is, and I don't know what to do about it.
> 
> We need a function that literally just sets the flag.  For every other
> flag, that's folio_set_FLAG.  We can't use __folio_set_flag because that
> means "set the flag non-atomically".
> 
> We need a function that does all of the work involved with tracking
> dirty folios.  I chose folio_mark_dirty() to align with
> folio_mark_uptodate() (ie mark is not just 'set" but also "do some extra
> work").
> 
> But because we're converting from set_page_dirty(), the OBVIOUS rename
> is to folio_set_dirty(), which is WRONG.

And I made the same mistake at least also in "mm/huge_memory: 
page_remove_rmap() -> folio_remove_rmap_pmd()".

I better double check all these so-simple-looking conversions that just 
went upstream.

Interestingly, __split_huge_pmd_locked() used SetPageReferenced() 
instead of

> 
> So we're in the part of the design space where the consistent naming and
> the-obvious-thing-to-do-is-wrong are in collision, and I do not have a
> good answer.
> 
> Maybe we can call the first function _folio_set_dirty(), and we don't
> have a folio_set_dirty() at all?  We don't have a folio_set_uptodate(),
> so there's some precedent there.

Good question. This mark vs. set is confusing. We want some way to 
highlight that folio_set_dirty() is the one that we usually do not want 
to use.

-- 
Cheers,

David / dhildenb



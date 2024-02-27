Return-Path: <linux-kernel+bounces-82802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1CB8689DB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C52A4B2109A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122A754BCB;
	Tue, 27 Feb 2024 07:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MdDDaeS8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682545465C
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 07:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709019047; cv=none; b=bGiKn4MXreOEWbR5zBPzMB9ditvj2+w8GFOdGhhVXNFOpg1qXuPK0ybUfv1DCKdsSoDi4jKQUMk1p3cvrbtShC8hUFx9WnfyzLnL62kAZ/Z/aoDdhskzKbYdcoLAw12FgM46zi397Epo45YFn/xZz3+thETkxhAPX1mDySsbHEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709019047; c=relaxed/simple;
	bh=UG0pDruJUwk7q3K1OBN3R/tIp99LwGpGbKRlgqO+O+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QNRZEvv9wpGC+m9ykrWm7+ssiXTN7TeIN+UaEFlaXAr5f30x8ywoMxmMhdeOpoOCUeWaocHgn2uZE8XqD1l0A+PNFKywQ1xrtuLKbhEtpYFvL3wsko53p4dWxsxBHKciACVz6Ot84zU4OeRHfMgTo/ulfHbIfvX9NkkERo638AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MdDDaeS8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709019044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0FLHhXl/pe218+lrlBh72jWb7X2XaeyQjRpFsnQ2nO0=;
	b=MdDDaeS8BT6yMFc8VVocUAZiheM0c9oVAoyhUKoDv/mDIAkvURDZ7RBXbhVzfP5dZnlBIk
	0OPnZy2AdYFHJPUxRCxbEeHgaua0aB3J/iiRGNwKOgKzk7oGWiLEy5CiU3++U+Le/Sc3bM
	e/mXqRapjTfoJ6X88FZcHSuVNtoSITY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-ABiFt-haOLCtyX7Vi4Bp7A-1; Tue, 27 Feb 2024 02:30:42 -0500
X-MC-Unique: ABiFt-haOLCtyX7Vi4Bp7A-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33d9f425eaaso1626837f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 23:30:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709019041; x=1709623841;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FLHhXl/pe218+lrlBh72jWb7X2XaeyQjRpFsnQ2nO0=;
        b=Keikkogu9agORyvfQkzbY2HQ4O2Rc79aBwsYipWE5GB+jO+nxuhMpSA6MLVSzCh+0c
         h0AY+sImqg5p7OsYw5bnzt/u2PbJgt1nQWJd/SbKOg/l2AFKn67Venp5xDKOrkPi6CnM
         W8OcppbecZRD8HlnH9dx/zXY8cBSqtC9NqaA88zVl/KGw7OdCjqlXv8JF5MtdSUv1vBg
         XHu4LoCgWtDA0uOMWcZx2jAjF6lE23RES9/KtkH4T4ekZgt9ek5fmzh41NsmSDOG7LlV
         wi2byJfm3psKrclLDGryDKW0MWpp30Pzu4P6vsn/lUjEL0L7lx0aYUB9XC3LAeV/IIKY
         cvIw==
X-Forwarded-Encrypted: i=1; AJvYcCWF8SMlSC7rGj0nQtn2bNoKYSMWDfhBR0GzZt66XZ93Affv3HptgFSkhfRvtSc/4nN8rGR5IHXB6s4GMG4cxuVehe8xmKT52oDVdsUm
X-Gm-Message-State: AOJu0YxWumiUYEjGjLYFMyjI06qLd9f/i1XjmA5Bgtcs//8MiLgs9a53
	ubbxbdgxWD/EMIcYSoWZj5TRRUAEiAhYuMHd7cTbYlzfCX2lqChn9kOCCdyBRCq4FH8eHGhNWik
	xBiL0Y7G3v3T25mYVsccDNYWw7nbsTIUhMzzaXrE+tYkGHjWAGlaXpWhkzLKKGA==
X-Received: by 2002:adf:dd81:0:b0:33d:22f4:179b with SMTP id x1-20020adfdd81000000b0033d22f4179bmr5676941wrl.21.1709019041691;
        Mon, 26 Feb 2024 23:30:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0O3nedFb5GrNQy3wL4qTLCkE0b/Wzl7VKOb7cAX/eHbtx92laQAKSmhi0CPRZdMMvyy4X8w==
X-Received: by 2002:adf:dd81:0:b0:33d:22f4:179b with SMTP id x1-20020adfdd81000000b0033d22f4179bmr5676919wrl.21.1709019041245;
        Mon, 26 Feb 2024 23:30:41 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:7600:5c18:5a7d:c5b7:e7a9? (p200300cbc70776005c185a7dc5b7e7a9.dip0.t-ipconnect.de. [2003:cb:c707:7600:5c18:5a7d:c5b7:e7a9])
        by smtp.gmail.com with ESMTPSA id t9-20020adfeb89000000b0033dbeb2eb4dsm10297686wrn.110.2024.02.26.23.30.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 23:30:40 -0800 (PST)
Message-ID: <90471b2f-826e-4275-a9a3-ec673c3e6af8@redhat.com>
Date: Tue, 27 Feb 2024 08:30:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/memory: Fix boundary check for next PFN in
 folio_pte_batch()
Content-Language: en-US
To: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org
Cc: ryan.roberts@arm.com, 21cnbao@gmail.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240227070418.62292-1-ioworker0@gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240227070418.62292-1-ioworker0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.02.24 08:04, Lance Yang wrote:
> Previously, in folio_pte_batch(), only the upper boundary of the
> folio was checked using '>=' for comparison. This led to
> incorrect behavior when the next PFN exceeded the lower boundary
> of the folio, especially in corner cases where the next PFN might
> fall into a different folio.

Which commit does this fix?

The introducing commit (f8d937761d65c87e9987b88ea7beb7bddc333a0e) is 
already in mm-stable, so we would need a Fixes: tag. Unless, Ryan's 
changes introduced a problem.

BUT

I don't see what is broken. :)

Can you please give an example/reproducer?

We know that the first PTE maps the folio. By incrementing the PFN using 
pte_next_pfn/pte_advance_pfn, we cannot suddenly get a lower PFN.

So how would pte_advance_pfn(folio_start_pfn + X) suddenly give us a PFN 
lower than folio_start_pfn?

Note that we are not really concerned about any kind of 
pte_advance_pfn() overflow that could generate PFN=0. I convinces myself 
that that that is something we don't have to worry about.


[I also thought about getting rid of the pte_pfn(pte) >= folio_end_pfn 
and instead limiting end_ptep. But that requires more work before the 
loop and feels more like a micro-optimization.]

> 
> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> ---
>   mm/memory.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 642b4f2be523..e5291d1e8c37 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -986,12 +986,15 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
>   		pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags,
>   		bool *any_writable)
>   {
> -	unsigned long folio_end_pfn = folio_pfn(folio) + folio_nr_pages(folio);
> +	unsigned long folio_start_pfn, folio_end_pfn;
>   	const pte_t *end_ptep = start_ptep + max_nr;
>   	pte_t expected_pte, *ptep;
>   	bool writable;
>   	int nr;
>   
> +	folio_start_pfn = folio_pfn(folio);
> +	folio_end_pfn = folio_start_pfn + folio_nr_pages(folio);
> +
>   	if (any_writable)
>   		*any_writable = false;
>   
> @@ -1015,7 +1018,7 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
>   		 * corner cases the next PFN might fall into a different
>   		 * folio.
>   		 */
> -		if (pte_pfn(pte) >= folio_end_pfn)
> +		if (pte_pfn(pte) >= folio_end_pfn || pte_pfn(pte) < folio_start_pfn)
>   			break;
>   
>   		if (any_writable)

-- 
Cheers,

David / dhildenb



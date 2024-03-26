Return-Path: <linux-kernel+bounces-119438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA0B88C8D4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 334851F66110
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B4413C9C5;
	Tue, 26 Mar 2024 16:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I1R/AV8u"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BA413C9C0
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711469869; cv=none; b=NWZ/xFBJxPA1Sdc4gIQhvejUk0bh9JeZJBmmkwCXD9d1KxcOR5wK6RmxZWy6pUDj9Z9tDGNON9b2wAoSzFmpBUBu9SFe1Rnw1qG5B6cLKG8gsqeigohJ7wkP7zfGcW/nc7xId+jqFdVD484gkrzmUIwkwkjKhddG7qMrZZW+BBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711469869; c=relaxed/simple;
	bh=4+X1CcBdokn1vSJKWvE2HLHS9YCyY+U9Ai1XrUUZDh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qL7RHAwyDcVtHKTdbmms2ZJb0ul++wgSsR0gCMp7KEOJcoKsUUw9SVgvSmc8nRSGk3UA5p4SVPKZlLLE6I1rP6iapfhJU74HQpYB2q5ZBUbW3oKcE4cE7ACbpvW2zTXD0zi1lbqjTBhEphPhvzNqqaAaLVJwLTGc7gkOSxadZXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I1R/AV8u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711469867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uXRyq8C4EQ6JJ5ezV/evB9I5sHavrxcZ5HAiqvY49/M=;
	b=I1R/AV8u00+igfxodOYcosyLdPRpZVF4nv268Xn02/r1QrkvX7kQP/1RBDepjPXmZUsj8c
	FW/7RROcqnqY8ocT4lPqotkBPKI8Fj4B/YjcZeYI3QOgrz4xmMym8SSLoeLTDqg+suKvlC
	2n+bjJgWLjMkGW72mm62FHJGFDiazlY=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-4GbamI4yMI2T_tyASbhKdw-1; Tue, 26 Mar 2024 12:17:43 -0400
X-MC-Unique: 4GbamI4yMI2T_tyASbhKdw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2d6ef704b35so5894671fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 09:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711469861; x=1712074661;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXRyq8C4EQ6JJ5ezV/evB9I5sHavrxcZ5HAiqvY49/M=;
        b=w5voeWdQKtemCrktOC//ZAES9xEmizfleQwxUJi1eRmNY8j2cDHZMjE2Me5YNvBLH/
         zS4zthoIKlHxK+HObpdBodMwxmOnQw8cOk7ha4OLHVk8cIh0/b/scsopeD2ncVxx5ZC1
         2S0kVSPmkbIzxrzmnFrAn+VtGTnyGhcTUhXiIXLsS3XLLGIJidtAFuWrhgKxspm8Zbh3
         H0hBzxMVLrbeUb/gAGmkg7AvlhKbgBS6dHUeTTR+mE9dZD1Mr143zuF55dX29JWK9faN
         3kAk/81KeGJ45O0gCIEexmQbREXSRLsr1y4ktGpBIZRJF7HY2d7ciV3nI6HdDNZdAAqv
         lcsg==
X-Forwarded-Encrypted: i=1; AJvYcCXwHgheOMjip6z8EUMbr1ahMWKikdvTrp8v+Y+ShqhJUt70L52cuejay0m0aYH8xqhjKH2S7p29iMdZ1czSsVX47lpWXAMtY+RrxVV8
X-Gm-Message-State: AOJu0YxQ2GHJTsFI0Nk9AM0PNeCdZazbhT31uSWAUoMNjP/3MVBcJ33L
	fxaRiPe4hC2TEl/gKAF/muXK8IirVbRqhBFF+nOPL470g7nZ7eR6nl9twzoKMWPk18rh5firlyJ
	ViCP2h4kSKM5lztMlGuGG9RmUgT/cUvZIJuOUfs/tN0M2LLtIrjSqAn33x0HrEQ==
X-Received: by 2002:a2e:87d1:0:b0:2d4:b061:da01 with SMTP id v17-20020a2e87d1000000b002d4b061da01mr1182056ljj.19.1711469860908;
        Tue, 26 Mar 2024 09:17:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhkCavUng6j8LGyuO/qZm5YFp9WJrfmQIMh2sCCrLav9aT+p7p01g9568UJvscf/SNUs++QQ==
X-Received: by 2002:a2e:87d1:0:b0:2d4:b061:da01 with SMTP id v17-20020a2e87d1000000b002d4b061da01mr1182024ljj.19.1711469860364;
        Tue, 26 Mar 2024 09:17:40 -0700 (PDT)
Received: from ?IPV6:2003:cb:c741:c700:3db9:94c9:28b0:34f2? (p200300cbc741c7003db994c928b034f2.dip0.t-ipconnect.de. [2003:cb:c741:c700:3db9:94c9:28b0:34f2])
        by smtp.gmail.com with ESMTPSA id u16-20020a05600c19d000b0041408e16e6bsm12099314wmq.25.2024.03.26.09.17.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 09:17:39 -0700 (PDT)
Message-ID: <0ae22147-e1a1-4bcb-8a4c-f900f3f8c39e@redhat.com>
Date: Tue, 26 Mar 2024 17:17:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/4] Reduce cost of ptep_get_lockless on arm64
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240215121756.2734131-1-ryan.roberts@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240215121756.2734131-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.02.24 13:17, Ryan Roberts wrote:
> This is an RFC for a series that aims to reduce the cost and complexity of
> ptep_get_lockless() for arm64 when supporting transparent contpte mappings [1].
> The approach came from discussion with Mark and David [2].
> 
> It introduces a new helper, ptep_get_lockless_norecency(), which allows the
> access and dirty bits in the returned pte to be incorrect. This relaxation
> permits arm64's implementation to just read the single target pte, and avoids
> having to iterate over the full contpte block to gather the access and dirty
> bits, for the contpte case.
> 
> It turns out that none of the call sites using ptep_get_lockless() require
> accurate access and dirty bit information, so we can also convert those sites.
> Although a couple of places need care (see patches 2 and 3).
> 
> Arguably patch 3 is a bit fragile, given the wide accessibility of
> vmf->orig_pte. So it might make sense to drop this patch and stick to using
> ptep_get_lockless() in the page fault path. I'm keen to hear opinions.

Yes. Especially as we have these pte_same() checks that might just fail 
now because of wrong accessed/dirty bits?

Likely, we just want to read "the real deal" on both sides of the 
pte_same() handling.

> 
> I've chosen the name "recency" because it's shortish and somewhat descriptive,
> and is alredy used in a couple of places to mean similar things (see mglru and
> damon). I'm open to other names if anyone has better ideas.

Not a native speaker; works for me.

> 
> If concensus is that this approach is generally acceptable, I intend to create a
> series in future to do a similar thing with ptep_get() -> ptep_get_norecency().

Yes, sounds good to me.

-- 
Cheers,

David / dhildenb



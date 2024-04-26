Return-Path: <linux-kernel+bounces-159591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 592228B30AD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04C572823A6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 06:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0ADE13A884;
	Fri, 26 Apr 2024 06:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eVPHqPpC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9604013A41D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 06:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714113764; cv=none; b=V9OLODx5I4ef6o7hqPdlMd8xrUF7mimlQI4GpdIMlfOUMW5qXlRzKRPOICWKjozf8bmGtF5l3Rv5bcjCEzGmCCxsaG/SvKWBXTyZLQ9HoeMAfivOk7llnJ6C4662L0BRjf5qcyFNYv0OZgCcI7g8wYp8tHQtNfuI9auLmR8ZWJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714113764; c=relaxed/simple;
	bh=6sKsWGX0DscQ/3gW0RqbN1uBIZ2Fc4T9143v9V0bwO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Fprw23H6eMGWlzNzXIXhMLxkEIZfpueUej4DAC7pxEqtqQvIbohQC+Il7JmnT4YOcLVCF+dsZqIEeb6LGD48xas9KyL7rSsLztz21zqSUxg15f20JjDpj0m5VjRwEXnq9/5Xu3hGdARwTzGRJJYK1GG2O+grjfuyDI7jJMdeuHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eVPHqPpC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714113761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=E+tYTfs9NKoPLMvY9tId1EcOzjkm6tejW0kCdDKiH8Q=;
	b=eVPHqPpCI2P/WNxh+MGT8LaU0annf3W314A1nOH2rzcEm+RDktcxHtBDCseWJ7wBrXI3zq
	ZLKxMoc3+X+rA3FBilYSCjzPdIS/9zpPqmAjQHwMusRZta37GmX4f8h8bK260sRzJ+ZMc8
	Zbk2YE0dscxZpPt3SpyqjwE88tCQz/8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-78h6HOD0NPeoqIg_7J3ivw-1; Fri, 26 Apr 2024 02:42:37 -0400
X-MC-Unique: 78h6HOD0NPeoqIg_7J3ivw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-416ac21981dso9235205e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 23:42:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714113756; x=1714718556;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E+tYTfs9NKoPLMvY9tId1EcOzjkm6tejW0kCdDKiH8Q=;
        b=Qr5cSikYM7bJXfu/VV3o3kmMw0+uH2WVzLO8bPe16oTsydl0CBPtm55gxb9W4GEcFo
         HNOdJjMhfkjR81bbAZ1QSZeOVdRate4qn2DBTaJUwV7kiGDbi2IG7a2NjfTWyx5Poh7F
         nAtneRGWSfxYukaOcW03oNA7REZopkq/kpn3PWXgPyZoIgTiPdX8Hg+UU86lVbB2Q8QM
         46W5Fj51McCdSLCmmwAaNSFOodix6k0+kA0OaU+XQHv57CehcSfCyp7ScqhuXgVcZUf/
         yWtcHYoDZMDn03zAj7yu4gHNSItZaIowD8tQfBCwOEfwixz5Vswq4NZoH0IkIIWr9qCP
         GSig==
X-Forwarded-Encrypted: i=1; AJvYcCWW/hd9hjeNralBNINBBpj3XwiULZQ2pEF4Al1QTwhePdLqfGUGOUNqhAI3RT/+/MzYzLBzX+VhSNnE0owWqtUhV8flVHE1lcGFt9j5
X-Gm-Message-State: AOJu0YwtR+epEzn5NIpSpCLpuQNdSSzHyT2q0cu50RO5Ppg9uAZbpCaL
	9WIjXvImUQpmS8rKtbZ68p1v23fnoIpw0Qd2hSa1xHB8FviV+efGoZ2g6X/sF3JQw8+tlRe5sH2
	Ra23JeeUo0wz50CbxAl/EZ0hmPGI30Ly6guypoBaYOuA0B5G697/cX4anoFa2GA==
X-Received: by 2002:a05:600c:3109:b0:418:bdcd:e59b with SMTP id g9-20020a05600c310900b00418bdcde59bmr4103857wmo.7.1714113756595;
        Thu, 25 Apr 2024 23:42:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrd76xJZYJPj7b60Y+BNNqXduLXOSbR2oK+w7wzpVZK5jpIt4kYMhfTK7H6XrExGSe1O36JA==
X-Received: by 2002:a05:600c:3109:b0:418:bdcd:e59b with SMTP id g9-20020a05600c310900b00418bdcde59bmr4103838wmo.7.1714113756149;
        Thu, 25 Apr 2024 23:42:36 -0700 (PDT)
Received: from ?IPV6:2003:cb:c726:6100:20f2:6848:5b74:ca82? (p200300cbc726610020f268485b74ca82.dip0.t-ipconnect.de. [2003:cb:c726:6100:20f2:6848:5b74:ca82])
        by smtp.gmail.com with ESMTPSA id y18-20020a5d4ad2000000b0034a0d3c0715sm21244523wrs.50.2024.04.25.23.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 23:42:35 -0700 (PDT)
Message-ID: <2daf168e-e2b2-4b19-9b39-d58b358c8cd9@redhat.com>
Date: Fri, 26 Apr 2024 08:42:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 0/3] iommu/intel: Free empty page tables on unmaps
To: Pasha Tatashin <pasha.tatashin@soleen.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, rientjes@google.com,
 dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev,
 Matthew Wilcox <willy@infradead.org>
References: <20240426034323.417219-1-pasha.tatashin@soleen.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240426034323.417219-1-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.04.24 05:43, Pasha Tatashin wrote:
> Changelog
> ================================================================
> v2: Use mapcount instead of refcount
>      Synchronized with IOMMU Observability changes.
> ================================================================
> 
> This series frees empty page tables on unmaps. It intends to be a
> low overhead feature.
> 
> The read-writer lock is used to synchronize page table, but most of
> time the lock is held is reader. It is held as a writer for short
> period of time when unmapping a page that is bigger than the current
> iova request. For all other cases this lock is read-only.
> 
> page->mapcount is used in order to track number of entries at each page
> table.

I'm wondering if this will conflict with page_type at some point? We're 
already converting other page table users to ptdesc. CCing Willy.

-- 
Cheers,

David / dhildenb



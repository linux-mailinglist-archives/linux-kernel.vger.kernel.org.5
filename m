Return-Path: <linux-kernel+bounces-155896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECB98AF8A8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4281D1C24142
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209DB26288;
	Tue, 23 Apr 2024 20:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q1yUhRhS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E5020B3E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 20:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713905809; cv=none; b=srSBEhsh/8O3ggU7i7dLAdiag/bWZe8S56DkBS6vJSb+EaHlez7Lekj9kXaAPt0BgGkNriS9seOZAV9mkrCbSFJng7p60kEMDoNYDpbAIJFGcDDYeaAYpnzWBUYyFyCImSVtqsmuCDmayImbwdX82WgJa+LA9wcl/R+TC5Gbx38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713905809; c=relaxed/simple;
	bh=uR87EmySOCarCFtM1CgNk819VRY0fWJIAWPsF8SGnH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NUXunTvzqdcSQOAcyOBS5JUcUIdcXAfFhrKbghg1ZMegJSBR9yXBaIPOMn2fgDl5ngTQmhjve3pKgSsPZiCqDTt/E3apYhku015hYKgSDsu3PFKj4WoL2+uUc9JovbsE/BQFWNyFizq4GeuqCbrNL6JnBMiDJZU98VpnxVafito=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q1yUhRhS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713905806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Ksuahojp/qsmKDrgqEjKz9PHKXyorgrQxu+0BWiM4Dk=;
	b=Q1yUhRhSGVLhdNM6M3eotYVEC5W1klQlA3v7/JyXp8OgdMPznqpygBdulrpo2/eJHbuMWS
	VfSezYKmDoLf2Yglj1EKz7ixdoq9gXjwLZJ5KOHDavzmLcBsabG1m/YbvX2L+eOUUYo7dC
	fK0+CLXU+B5hFTOHNTajnU9nP1M53Ks=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-ZSZbZRntMy67SbEA4XV9tQ-1; Tue, 23 Apr 2024 16:56:44 -0400
X-MC-Unique: ZSZbZRntMy67SbEA4XV9tQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-346b8ef7e10so3833289f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 13:56:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713905803; x=1714510603;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ksuahojp/qsmKDrgqEjKz9PHKXyorgrQxu+0BWiM4Dk=;
        b=c4enX36A4C1czUQZcoCpUEq5N3d5Jdiyklj7FakrFDabQjV64LrAvz6h57K7doHGbf
         ICOqZtPbXWDLWa1s1dYNI4zzl0yYpYham/1yU48ricTQMSXyYFutD8NXZkJtk3dKla78
         2DbJ89Nw2g49RymEleQKfNiVp2ItE63WaB2ls0+zHLXrjO6expLYdz89sAPgFEhdFgG2
         KukFZAIxWIAO8LkP/8JsmXLtc2raWWm5SfS9THe08fPrHuh58TjjdMKphu5EGiY/ux6L
         dXOJzbNB5kaUw9uTrWh3beTPRWftGfk4dTTPP1mgwy7oOqKrqEpzlnkWbwb7/7MY1+cG
         /hLA==
X-Forwarded-Encrypted: i=1; AJvYcCWGU67l4+Is4vFQrWHkHr5PwkwwJ+bvo3WAvawo80iAj3Tk+mndLTR7Q9yZM/kGS5UBtTQ5wFnumlsWMD7An+K75tLWqsE668+b77k9
X-Gm-Message-State: AOJu0YzLwQvESH19tR3LRLIe3FE812a+U59ECU6Sd2LxcheWn+CF2rTj
	A/wtf2KaPG7k5WBK+qCArD1wIBc4E2JZZUWg+hx0nByV4IICJQHvm1mvVE2qf9aPvZM/jXI9X4P
	EQG7kl8ei9AKfwzINmXDw403Ffl/v83N0Ny9egnNo5kMvKZfFUAYtVYDK3+XKsGIZaSyWmA==
X-Received: by 2002:a05:600c:3c9e:b0:41a:28e6:b4c1 with SMTP id bg30-20020a05600c3c9e00b0041a28e6b4c1mr298797wmb.12.1713905803520;
        Tue, 23 Apr 2024 13:56:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEysl1Gis+y0GmCe/kljdiLX4sR+hi+bh3iy19hL6MKl5z2mOObaUaf2wYm+z0KW7eFvhCZXw==
X-Received: by 2002:a05:600c:3c9e:b0:41a:28e6:b4c1 with SMTP id bg30-20020a05600c3c9e00b0041a28e6b4c1mr298773wmb.12.1713905803011;
        Tue, 23 Apr 2024 13:56:43 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:fd00:fb07:92f8:8f0c:6a08? (p200300cbc706fd00fb0792f88f0c6a08.dip0.t-ipconnect.de. [2003:cb:c706:fd00:fb07:92f8:8f0c:6a08])
        by smtp.gmail.com with ESMTPSA id n2-20020a05600c4f8200b0041884b79b81sm21436982wmq.1.2024.04.23.13.56.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 13:56:42 -0700 (PDT)
Message-ID: <8dec06c3-62d6-47c8-aafb-61c7f01f92b4@redhat.com>
Date: Tue, 23 Apr 2024 22:56:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/5] arm64/mm: uffd write-protect and soft-dirty
 tracking
To: Ryan Roberts <ryan.roberts@arm.com>, Mike Rapoport <rppt@linux.ibm.com>
Cc: Shivansh Vij <shivanshvij@outlook.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Joey Gouly <joey.gouly@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
References: <20240419074344.2643212-1-ryan.roberts@arm.com>
 <24999e38-e4f7-4616-8eae-dfdeba327558@arm.com>
 <MW4PR12MB6875618342F088BE6F4ECBB2B90D2@MW4PR12MB6875.namprd12.prod.outlook.com>
 <c936083b-68b7-4d8f-a8fc-d188e646f390@redhat.com>
 <ZiKcNJ0Qw2awRwaa@linux.ibm.com>
 <ac4ffd88-2d13-4764-bb4e-18d0c4b9948d@redhat.com>
 <9e73ad2f-198c-4ab5-a462-2e238edd9b34@arm.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <9e73ad2f-198c-4ab5-a462-2e238edd9b34@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>>>>
>>>> We further recently added a new UFFD_FEATURE_WP_ASYNC feature as part of
>>>> [2], because getting soft-dirty return reliable results in some cases turned
>>>> out rather hard to fix.
> 
> But it sounds like the current soft-dirty semantic is sufficient for CRIU on
> other arches? If I understood correctly from my brief scan of the linked post,
> the problem is that soft-dirty can sometimes provide false-positives? So could
> result in uneccessary copy, but never lost data?

Yes, it seems to be good enough for them in that regard I think.

[...]

>>>
>>>> But I'll throw in another idea: do we really need soft-dirty and uffd-wp to
>>>> exist at the same time in the same process (or the VMA?). In theory, we
> 
> My instinct is that MUXing a PTE bit like this will lead to some subtle problems
> that won't appear on arches that support either one or both of the features
> independently and unconditionally. Surely better to limit ourselves to either
> "arm64 will only support uffd-wp" or "arm64 will support both uffd-wp and
> soft-dirty". That way, we could move ahead with reviewing/merging the uffd-wp
> support asynchronously to deciding whether we want to support soft-dirty.

Yes. MUXing would require some work, but likely better than wasting 1/64 
PTE space on a corner case feature with one famous user that might be 
able to port to an alternative with other active users (growing ;) ).

Anyhow, I don't maintain arm64 code and we have to carry that baggage in 
the core either way for the time being ...

-- 
Cheers,

David / dhildenb



Return-Path: <linux-kernel+bounces-76490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CF685F7D5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D5681F2301D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599ED60B8F;
	Thu, 22 Feb 2024 12:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iQJu5d34"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AD15FBA5
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 12:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708604106; cv=none; b=l4e8pL1MA4+EVI3IEbphz6wg3xWveZVepHTal2gBZ+GSUPrlrWrJO7zGiIgf07JOvVEeco3S8wOYKwqvm5wr3a9NzGI1oXNAzi29BG86JirBSbUovGCbE52LGsgyoDp3PjhSR7Jn89iaTO+0KOpBaVFyZpLOeutcR9J84IZo42M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708604106; c=relaxed/simple;
	bh=uCYkH84b3nMXXHSxRX9x800Ixf97kREp8tNVUxZwIBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NDoFwU7KXJq7/1+Vu7/8qCxmzxI/wcln//vmATlAK07nvM/ykBxVkUFcy9t8Q1cH6Pdaj9fbSaKintzQFrQiA4xsMY4s02DSZT1v1lzNx0Ml0WkC2JszrbMQWjwmuSQ+5BLia1ts+crc0Q7272k/bkw+jRb8Rwknbq5LFv7ISyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iQJu5d34; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708604103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Ms6xEIb2jDGpCHrso8jLzDaD7R/RPnC3mdi3yCtznwA=;
	b=iQJu5d349lmB8GNS0EzI9ScDRgvPO/N/GizA03zdBq9BdDRS8ATICHKRWWQKFnaQx7sLW+
	2KKlcWKze/FPisRBixEqNJC0OHf+oJFD1unsZsvj0cHt2NBJKOPW2o3OGLbkiBfOTMxW56
	QjpW2pf84omBru3UfB+QbyFl4/q8i0E=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-avd3E7I-OoCQHi4lRW1msg-1; Thu, 22 Feb 2024 07:15:01 -0500
X-MC-Unique: avd3E7I-OoCQHi4lRW1msg-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2d24452f743so29182371fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 04:15:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708604100; x=1709208900;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ms6xEIb2jDGpCHrso8jLzDaD7R/RPnC3mdi3yCtznwA=;
        b=wlAlRnDyO5xGdRl3atH8EXIk1n6pFmHn1s8skOHcYUZHDm6Zewr5AhuVxtNb/JctPc
         F9+jE9+MyDTRSU6leKmQnz7JQrH4Or/Uxto8Zswky7vKviSND/bIeMVwRULNdYRRuXGK
         7VR3V+JFLort4kFVSRlceoL2+9+ezBliN0eoI3Dz8DgBdDr5ehv/32dbnAinlCqi2Nh1
         LWYRm9ZTtTHJ+T7tPmSWAWGIePCluYENBzsu+fBh2Wf4eU0GBAApfqvd6H/1mkBrixVS
         XQn0oqfXiimit0L5c9Wg4+mVMEp8PJQG5aIJVEy25aGiLRVt2n3Cc36kCe+dJ/CjuB4p
         B/Cg==
X-Forwarded-Encrypted: i=1; AJvYcCWtx2TiCLUR9QT7KxasRXwpMpCAmGXVUz9fiaNgsTzIa3Ke8Om8hlR4C/95vra6sK3SJ4oBzrriAmYPi2MAqW/SkBBa+R7O9a2DIcmr
X-Gm-Message-State: AOJu0YzbMCSdMvr/iJoAq7QYStCLe2qaAEZwbK46ZTvuBRma1Q9i/zLV
	eWyj4vUca9zN9oCBd8BlCJDE+l8Q9IElqSSsWXUf6uyQJFPP1Al5ltqz6XSUgIdqnY2pHYi0JWy
	8nwiqVHwLxIcK5xs/0RnmmTlC36PZZvYaRHlks+c6JkTwMfKWNS1sYe/svgudRA==
X-Received: by 2002:a2e:8290:0:b0:2d2:1fed:8029 with SMTP id y16-20020a2e8290000000b002d21fed8029mr10988819ljg.28.1708604100094;
        Thu, 22 Feb 2024 04:15:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9ni3MK5l8fE7rGvAsklL/mmBAZXmPn/QkRgvTr8hO5nhtZpmXSjAbfeYC1+0RruyRPPWx1A==
X-Received: by 2002:a2e:8290:0:b0:2d2:1fed:8029 with SMTP id y16-20020a2e8290000000b002d21fed8029mr10988802ljg.28.1708604099694;
        Thu, 22 Feb 2024 04:14:59 -0800 (PST)
Received: from ?IPV6:2003:cb:c70f:8b00:ed48:6d18:2152:1cda? (p200300cbc70f8b00ed486d1821521cda.dip0.t-ipconnect.de. [2003:cb:c70f:8b00:ed48:6d18:2152:1cda])
        by smtp.gmail.com with ESMTPSA id z23-20020a05600c221700b004128815c374sm1663051wml.5.2024.02.22.04.14.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 04:14:59 -0800 (PST)
Message-ID: <ec6f2c48-3010-4a02-8f42-fc6b912039cf@redhat.com>
Date: Thu, 22 Feb 2024 13:14:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm, thp: display [never] for defrag when THP is set to
 never
Content-Language: en-US
To: Yuanhe Shu <xiangzao@linux.alibaba.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 liusong@linux.alibaba.com
References: <20240222115323.4925-1-xiangzao@linux.alibaba.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240222115323.4925-1-xiangzao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.02.24 12:53, Yuanhe Shu wrote:
> When transparent_hugepage is set to never by cmdline or echo, defrag
> still show what it used to be and can be modified which makes user
> confusing whether defrag would take effect.
> 
> Actually if transparent_hugepage is set to never, defrag will not take
> effect. Just Display never and remain unchangeable to for defrag when
> transparent_hugepage is set to never.
> 
> Suggested-by: Liu Song <liusong@linux.alibaba.com>
> Signed-off-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
> ---

No, I don't think we want such a dependency between both options.

You might just end up breaking existing scripts (enable defrag before 
enabling THP) for no good reason.

-- 
Cheers,

David / dhildenb



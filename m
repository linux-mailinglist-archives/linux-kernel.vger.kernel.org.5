Return-Path: <linux-kernel+bounces-49874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C85758470C3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8468B289D30
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE183D8F;
	Fri,  2 Feb 2024 13:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="daY6KNGu"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F7A1FAE
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 13:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706878855; cv=none; b=mwlmaPBHF96IawVGGQqvj1cP7laxRPyDkSTC8DFBVcVaS0urw5HIhJRF7//Yr8eflekEx7eDgUm3AIwzJaqqszgE5bF+zTsNGzTdtdluLXMJ1UGAU8x18Mt+wnmJOk+w4fSpL2pGN0qL3sqf1qoH8FxysLpAJf2NrCtII+i3HBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706878855; c=relaxed/simple;
	bh=Aq+wlET4B4qpqujfc2Oa2FfWuD8TqO2VxciLRWvXYIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IFdA6Uox9wzqAMfBE/+ln71HjaUJOc2+TIfnwiL4FlDmCFELZA3nawQbapNfU/nqYvn5aymnUVxdW6S2T2662L1pHIxWNWSK0LMqLRhGrQeDB16QWnkpPP+/H0fnfCNc46Lon+BnGaYLa9DLsR8hXwEGgyAdavQZoUg08dM7Xas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=daY6KNGu; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d746ce7d13so16997815ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 05:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1706878853; x=1707483653; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G2bY4vYtweXh8leJIICu6NBbyGqLWwvL3EkmAcH4Epw=;
        b=daY6KNGuaLh7BzRfXpa4eZ8HzSekPiPie/3HoiQFWyX+DnaDKHiP8vZJ+Z4PFLN8Vt
         aS9fcDJwJgng4HjIMQ0MDcW9nSN3AewbztMnqZnI/2s37+VBHpmJSUE0dN90X4QMVXqe
         vPmPUkoxvH78VqQ1+IoGvsW55PSghv9UrldRZvUwFI5CDa4H2EwtqEx8iDEx99rpbrsh
         X5e142HiPbr2yCw92202/mpnMBdiFTM8zb9QpER9YaPFOVv2AFVOVFBngONRAPZisCtB
         QDK4MNOb3c9nACtTvg6hot6UMLsQpEBldgN67eRAdZM7WUYXAHAlA14cgshS7EYM5DyQ
         incw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706878853; x=1707483653;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G2bY4vYtweXh8leJIICu6NBbyGqLWwvL3EkmAcH4Epw=;
        b=ebljHZEgIsCbE1Vh6uFPpXo7hcIwcO/GAnPMrJHc7FLa9P/YeANlqFHVkdaBKyUfvj
         iy1dU2Wnun4TmLrFS9u8XqlYW/XRtmLWE4WoPO2Puzp8ZPZFuw1Dnp70yYi8MRzsY0lG
         HANpJUPoKx/6VV/Jch2ySCSvbaVgmQ0y73Onkc1uQ3dUYXpYhScKkGOik1JXMxyuYmM1
         kiGWzwCFCnCZIppKgwkcWeHRi5kdejfWcxGOQyOZHeRR0J5HGAU6touQ8Zoff8qRfMVj
         tdg7SauI8IcYjem2TZcsmHKZFdQyWwhG6hDowpbZQzkyWMAVZMJMk5Edw1zs5LwyxKeb
         UEvw==
X-Gm-Message-State: AOJu0Yxwe68m53Tu07gHbkRf88ozHfqJ8uCAkZH309seoHwu40luOZS0
	vjPI3Gcgey3O0afeCBNGwbymfgo5Y5CclmLmMLNq312RkhclG9vidvYDZRCqne4=
X-Google-Smtp-Source: AGHT+IH6qu/ikgZszTBTu6hyUMxDM3HZaGJQQLqAdta57+0lOVP89oelOwELMxcPFjTdnXBV7I5dzw==
X-Received: by 2002:a17:902:e54e:b0:1d9:55b:6a2f with SMTP id n14-20020a170902e54e00b001d9055b6a2fmr6469415plf.48.1706878852785;
        Fri, 02 Feb 2024 05:00:52 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWj0I7Q3oG9lnP3Jthb1RGY+JzyyyC3B8DgwwQ1UmoAcVKTX29lKV5lAd2N1KGMWw+aHnhd/kOi4chN/v+bqpqjm1Y4UsXkCfix7LbaczNk5LsTSP4zhw4qbVY4l2jbsRuaw6OQrz0g+iXusaxYrLwMlU8rWlAbVZpzf3pMcJhXfsWeuwyClrLJf2csgSEOSQ==
Received: from [10.255.208.99] ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id mn16-20020a1709030a5000b001d9033b9d8csm1567243plb.59.2024.02.02.05.00.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 05:00:52 -0800 (PST)
Message-ID: <ce81ab97-985b-49b8-9c84-5a3f59701f0c@bytedance.com>
Date: Fri, 2 Feb 2024 21:00:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] mm/zswap: zswap entry doesn't need refcount anymore
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240201-b4-zswap-invalidate-entry-v1-0-56ed496b6e55@bytedance.com>
 <20240201-b4-zswap-invalidate-entry-v1-6-56ed496b6e55@bytedance.com>
 <ZbxBT98Ctjvd0XPG@google.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <ZbxBT98Ctjvd0XPG@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/2/2 09:11, Yosry Ahmed wrote:
> On Thu, Feb 01, 2024 at 03:49:06PM +0000, Chengming Zhou wrote:
>> Since we don't need to leave zswap entry on the zswap tree anymore,
>> we should remove it from tree once we find it from the tree.
>>
>> Then after using it, we can directly free it, no concurrent path
>> can find it from tree. Only the shrinker can see it from lru list,
>> which will also double check under tree lock, so no race problem.
>>
>> So we don't need refcount in zswap entry anymore and don't need to
>> take the spinlock for the second time to invalidate it.
>>
>> The side effect is that zswap_entry_free() maybe not happen in tree
>> spinlock, but it's ok since nothing need to be protected by the lock.
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> 
> This looks like a great simplification, and a good motivation to only
> support exclusive loads. Everything is more straightforward because
> every tree lookup implies a removal and exclusive ownership.

Right, much simpler!

> 
> Let's see if removing support for non-exclusive loads is agreeable first
> though :)

Ok, I have just posted some testing data for discussion.

Thanks.


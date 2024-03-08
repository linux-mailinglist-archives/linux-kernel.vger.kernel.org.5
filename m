Return-Path: <linux-kernel+bounces-97103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCF1876592
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0F5D1C21829
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6413FB8C;
	Fri,  8 Mar 2024 13:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JABl8yBJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4566240849
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 13:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709905600; cv=none; b=bNt9HsTGrg8fsnUZTOhpvXEdmuB/z1g2K26mTMNq24szS/Zv8tyPXe+S4lN8lx8z9DvoM2E3g/TPaM8H2omCNv3cynNOWPWZsgDmpFmcEZLpMR4s533NZXOaNKZmTzkSYMIU77ETZeGwXFTgWGVwoBsxfM5aBnlsg+oEzgQ2voE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709905600; c=relaxed/simple;
	bh=9ToP+XB7jwsKfUSXiOlYXuw0t/iX1kAOHS98K5tYWiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g/BTOatDeGPm5lMgLrPO3qplayWKAp0lNXNvDH6eTcun62ud8UKAwsxYrDdE46VMlYScENkyCJ5d18YpijQr709+HR3TTcGRGji1xFVuxgVngDYQp/v9LptCO2KsPpfGFWsh+OXyDemyIr/0L84SVjfXjJZ7ftJ2MiUwEU0BTHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JABl8yBJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709905598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jCsgBkOPvGYOzUcWOIcEMHgJC7KI6Ff1hmh/N+7ZuLo=;
	b=JABl8yBJ5x1ts/WFkwqiYPh0rUra0hygogk+TZij6t8Yh8rSwnLFvHDVPZUvztTspsbCqB
	x018tzn3lvGd1hkFKVyo5bxzeZa8rhH0nPtX273zes4yc8JfKr1cLmTxwdX36NYwRntZN0
	pKF6rg7Dvwb5uBCHccfPX6FzcPn0Bys=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-JEDUgzUaMUWQ6HBt6UpYUw-1; Fri, 08 Mar 2024 08:46:36 -0500
X-MC-Unique: JEDUgzUaMUWQ6HBt6UpYUw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33dbbe709ffso860133f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 05:46:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709905595; x=1710510395;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCsgBkOPvGYOzUcWOIcEMHgJC7KI6Ff1hmh/N+7ZuLo=;
        b=UPd6pE7LmdfwMBDpxa8o3OqvVjs8mcUTOZfRsbUOF+o/A3H7wRfMb9LnXylDQi0Gvl
         liTxgKpiKYp2hjKS3oG1y6elXDHwPwU0Kzov7IyVVb1RcvettMcDzazilWFwCgMn8pEF
         FQOek7D09YSg3GNeLt2BMWMgaiXwSmgc7bbkhNM/yYXVa8u42eultDh00VdRLqYjvbFj
         952LKxtIsXhPrex5/N5FoxdmtP8UMlCXWIvdxdf/FeTXGjamrbX/mBk92nz/ypMQZJ/E
         GUa5Ffd70yQim0HRSCv0pMQxCTnLbowy6sS3OYrILKda9g1/tigejJfrlMkJ6P2PU8jQ
         aJpw==
X-Forwarded-Encrypted: i=1; AJvYcCXVjB8pO+kzxZoAUJJ0OjD0O9aa7jEDnl38UU57HIjjZtCUPy1PNxX19jgdrnudDsGpsV+1ahLkLaEdp4zz7MdB52hXH2Cxl2RjOjFv
X-Gm-Message-State: AOJu0Yy5aTO8K7q9HCH6b6Y8KQkHrbHjNlfZcav/cXOXSbD5NNVY8dwE
	zWLG1xAsAJlTC9ZDNeX4kAQOn5izBEUS8Zi3lc061bp52xppbMqD5jS0TCUken0L2XDmQFeqL/y
	BlQxb/3sC1/IcQBm+aP8YrPB+cr4Me26sK8VpEexlC5tUsunM1H72Nc3U62JbaA==
X-Received: by 2002:a05:6000:1745:b0:33e:7718:f90 with SMTP id m5-20020a056000174500b0033e77180f90mr1350985wrf.41.1709905595603;
        Fri, 08 Mar 2024 05:46:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7sQEyg1mvc5Dm+qbQbdxrrDymqfNI9KfSydSANhq/IqGfwRe2jKZETh46gvTjWethTwbvuw==
X-Received: by 2002:a05:6000:1745:b0:33e:7718:f90 with SMTP id m5-20020a056000174500b0033e77180f90mr1350962wrf.41.1709905595160;
        Fri, 08 Mar 2024 05:46:35 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:3500:5cd0:78d9:ca49:21f3? (p200300cbc70735005cd078d9ca4921f3.dip0.t-ipconnect.de. [2003:cb:c707:3500:5cd0:78d9:ca49:21f3])
        by smtp.gmail.com with ESMTPSA id g5-20020a5d6985000000b0033e7b433498sm100936wru.111.2024.03.08.05.46.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 05:46:34 -0800 (PST)
Message-ID: <4e0891dd-f5ba-4cff-932b-604288540e59@redhat.com>
Date: Fri, 8 Mar 2024 14:46:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: prohibit the last subpage from reusing the entire
 large folio
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>, Barry Song <21cnbao@gmail.com>,
 akpm@linux-foundation.org, linux-mm@kvack.org
Cc: minchan@kernel.org, fengwei.yin@intel.com, linux-kernel@vger.kernel.org,
 mhocko@suse.com, peterx@redhat.com, shy828301@gmail.com,
 songmuchun@bytedance.com, wangkefeng.wang@huawei.com, xiehuan09@gmail.com,
 zokeefe@google.com, chrisl@kernel.org, yuzhao@google.com,
 Barry Song <v-songbaohua@oppo.com>, Lance Yang <ioworker0@gmail.com>
References: <20240308092721.144735-1-21cnbao@gmail.com>
 <519fd6a7-072e-43a2-a9a8-2467ee783524@redhat.com>
 <cfe7d2b5-eb41-4df0-bf6b-4ed4044e20ea@arm.com>
 <8e994734-1d3a-4c51-9c0b-4e2ce945f198@redhat.com>
 <252bac83-bf5e-4c40-a696-ac093da41fa3@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <252bac83-bf5e-4c40-a696-ac093da41fa3@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.03.24 14:45, Ryan Roberts wrote:
> On 08/03/2024 13:24, David Hildenbrand wrote:
>>>>> This patch migrates the last subpage to a small folio and immediately
>>>>> returns the large folio to the system. It benefits both memory availability
>>>>> and anti-fragmentation.
>>>>
>>>> It might be controversial optimization, and as Ryan said, there, are likely
>>>> other cases where we'd want to migrate off-of a thp if possible earlier.
>>>
>>> Personally, I think there might also be cases where you want to copy/reuse the
>>> entire large folio. If you're application is using 16K THPs perhaps it's a
>>> bigger win to just treat it like a base page? I expect the cost/benefit will
>>> change as the THP size increases?
>>
>> Yes, I think for small folios (i.e., 16KiB) it will be rather easy to make a
>> decision. The larger the folio, the larger the page fault latency due to
>> scanning, copying, modifying, which can easily turn undesirable.
>>
>> At least when it comes to page reuse, I have some simple backup plans for small
>> folios if I won't be able to make progress with my other approach.
> 
> Do you mean "small large folios" here? i.e. order >= 1? If so, great!

*smaller*, yes :)

-- 
Cheers,

David / dhildenb



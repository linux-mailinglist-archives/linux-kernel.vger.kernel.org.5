Return-Path: <linux-kernel+bounces-140565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B266E8A1642
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3D981C22AB0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB87A14EC71;
	Thu, 11 Apr 2024 13:48:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAA614EC4D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 13:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712843338; cv=none; b=dC/zdte+3FlVQFdoDA9IlCuhrNTHBW3XrfOCTXf7s87PLZRMJqM2mePhfNAuZFd/M1p5v/Vtawdz8UMAo+ymtTqUz0qKeuv3hNCqF1SFgJmVQZ4esJ6SMXJjpv/EVTS1VObV4yZHqqrgSS+rUcDtd4hzmB9Z1KH3vyGA0jsoJ3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712843338; c=relaxed/simple;
	bh=u17hrof1UMfL/LrYC6HkU+xFZtX4qN2Q6BUksHZyoYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b5AwZFCVTOTafx7203jibGW62OhGofz5GDcyPws6jtakoVj8SvISMFhJjrNi5cEMFDFfNXvkJCp7tlZkDFzwbJRxqK8aYPlSKi7o4YH0celfQRSvUMZVhlM+8EKZuidw8KKAkkpoKVHQtoaGlbm4JSvdkWhWvXESHOsFlsE6okc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA5C9339;
	Thu, 11 Apr 2024 06:49:25 -0700 (PDT)
Received: from [10.1.38.151] (XHFQ2J9959.cambridge.arm.com [10.1.38.151])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D76F83F64C;
	Thu, 11 Apr 2024 06:48:53 -0700 (PDT)
Message-ID: <3cda8e87-7095-4aad-beb1-6a420912df34@arm.com>
Date: Thu, 11 Apr 2024 14:48:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] mm/madvise: optimize lazyfreeing with mTHP in
 madvise_free
Content-Language: en-GB
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, 21cnbao@gmail.com,
 mhocko@suse.com, fengwei.yin@intel.com, zokeefe@google.com,
 shy828301@gmail.com, xiehuan09@gmail.com, wangkefeng.wang@huawei.com,
 songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240408042437.10951-1-ioworker0@gmail.com>
 <20240408042437.10951-2-ioworker0@gmail.com>
 <38c4add8-53a2-49ca-9f1b-f62c2ee3e764@arm.com>
 <CAK1f24kh-vN3_6ZLUZWXu_g1UOPBuoVXq2jsnx_GBbGFXyXRFQ@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAK1f24kh-vN3_6ZLUZWXu_g1UOPBuoVXq2jsnx_GBbGFXyXRFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[...]

>>> +
>>> +             if (!folio_trylock(folio))
>>> +                     continue;
>>
>> This is still wrong. This should all be protected by the "if
>> (folio_test_swapcache(folio) || folio_test_dirty(folio))" as it was previously
>> so that you only call folio_trylock() if that condition is true. You are
>> unconditionally locking here, then unlocking, then relocking below if the
>> condition is met. Just put everything inside the condition and lock once.
> 
> I'm not sure if it's safe to call folio_mapcount() without holding the
> folio lock.
> 
> As mentioned earlier by David in the v2[1]
>> What could work for large folios is making sure that #ptes that map the
>> folio here correspond to the folio_mapcount(). And folio_mapcount()
>> should be called under folio lock, to avoid racing with swapout/migration.
> 
> [1] https://lore.kernel.org/all/5cc05529-eb80-410e-bc26-233b0ba0b21f@redhat.com/

But I'm not suggesting that you should call folio_mapcount() without the lock.
I'm proposing this:

                if (folio_test_swapcache(folio) || folio_test_dirty(folio)) {
                        if (!folio_trylock(folio))
                                continue;
                        /*
-                        * If folio is shared with others, we mustn't clear
-                        * the folio's dirty flag.
+                        * If we have a large folio at this point, we know it is
+                        * fully mapped so if its mapcount is the same as its
+                        * number of pages, it must be exclusive.
                         */
-                       if (folio_mapcount(folio) != 1) {
+                       if (folio_mapcount(folio) != folio_nr_pages(folio)) {
                                folio_unlock(folio);
                                continue;
                        }

What am I missing?



Return-Path: <linux-kernel+bounces-158295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6233D8B1DF7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 852941C21090
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512B184D3C;
	Thu, 25 Apr 2024 09:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E8cfjBVc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0461E839E0
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 09:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714037119; cv=none; b=bfbVs/aB/zGr+3E/6As1voyHyoCskFkAeb2VIBd12rt7YWJOBdn0af5fXZAj2eepz+Gypnk55OzyKaSWGD36gQjSYkJZw37Jp6FjLM3OTSUTSvF9/wMf+wh+C3VbwFce88wEkZLUlYlknPprLzZfX4Qztjm4JkQ/m56jxo6WPQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714037119; c=relaxed/simple;
	bh=XMxIwQpYcLKMrTDTI64cRl7jEOapyAkT/FdxJr5TNwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PGsvPRHmRh50sUIBTeQL9VUxBnYi86qaLNxbOdp/KNN8tvVZrg22V8gxIvQ/koXW2ApVLJV1C5IVOwAfMSnp0nzJltq/AKEp63wAW9mMevE4fzn6ZcOXqlHwNr0MddTe1m1+Ykg9pvDTNpCLxRux+ZaBHUDjTBrzfznPrBpR1TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E8cfjBVc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714037116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RY6IGC3qhyTxxzOlnrjSkz8t73FAXs6MiRZyy7uqd1g=;
	b=E8cfjBVcq9gwB+JjC5qWZz+3cQJ7uZc/u8w4JWY8nez989PTqQE0KSZlegS2hiTp9FIQ80
	1GHPAtJNehQjJdyrA9SCr9p9yvmxFjOaW4W4CsIfHsChxRBSw3YLJinyusLOMC3iLX5a4M
	lgYdGAEa5yy71PNaNCBtg7PvYUcBiXw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-ECb3yE_KOfKHXfWkMJQb-A-1; Thu, 25 Apr 2024 05:25:15 -0400
X-MC-Unique: ECb3yE_KOfKHXfWkMJQb-A-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-34a49f5a6baso648015f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 02:25:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714037114; x=1714641914;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RY6IGC3qhyTxxzOlnrjSkz8t73FAXs6MiRZyy7uqd1g=;
        b=ArNHElFwLH5nqOHpTwkqgW8vWx9OH/3D5/5MT1ydSlOmBF827bkDGGwEEQuKUUo0f/
         EUxiW0T4b5rS9+iaOG78AtnQEq6N944EcUBznSqqFzbIYRRxCRf9tQRg0C+ocLUzdxoX
         mMxFpc+9BzRPyK1/FLYOCYC/PIJKvr6Od2dx7DFgPZ56NSRI38naF0vVm8eVTx9xs6VD
         T3hjcm7OasH2F+0GA4IYn8oFSoemV0F6YQDR36xRfEjiSj7uvGOfgRuLBrD/uDsdoV3p
         v8Z4CW8uFJC9E7fwfOUrBpJl0z1jHOblpP6KIg5qM1ADUWXRdMUIc+6SmxsCymKaooas
         ZZ9w==
X-Forwarded-Encrypted: i=1; AJvYcCWe108U2nUhfOioRJjKE7WDt8jW9dWUCIsoapdWz7kpzX52ECYWpmymVuRkhHO/wrbNp7OSwB1jBcha1vuofGnRxd42HZUfSXchYNc0
X-Gm-Message-State: AOJu0YzhEpSedbMuqpHzSvtv8/IVCbasPEufjLc4zHDbo8iScuSL4vUq
	TJ5zRJf7o94MRMY/SOOdRVBYfmDU6ttSZbJx0PoU8dtvSjqkvc5vt2EzfTQUOpHkRqaOjRejVqu
	XAhb1zfhG7wVX6h21BJfpRAZhRiHs6fAzjHpB6Dj7mi9BC9D5gdv9kMxyHIeytw==
X-Received: by 2002:adf:f202:0:b0:34a:f3eb:d88e with SMTP id p2-20020adff202000000b0034af3ebd88emr4440481wro.49.1714037113824;
        Thu, 25 Apr 2024 02:25:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFs4Qz1ErlmZRZFXBDoVT6TwJ0w+Y5Nun+UdHOLHCvzxWyW052yXALfu0UT6HWf9uTmuN0ilA==
X-Received: by 2002:adf:f202:0:b0:34a:f3eb:d88e with SMTP id p2-20020adff202000000b0034af3ebd88emr4440453wro.49.1714037113410;
        Thu, 25 Apr 2024 02:25:13 -0700 (PDT)
Received: from ?IPV6:2003:cb:c719:8200:487a:3426:a17e:d7b7? (p200300cbc7198200487a3426a17ed7b7.dip0.t-ipconnect.de. [2003:cb:c719:8200:487a:3426:a17e:d7b7])
        by smtp.gmail.com with ESMTPSA id m18-20020adff392000000b00345920fcb45sm19455108wro.13.2024.04.25.02.25.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 02:25:12 -0700 (PDT)
Message-ID: <e75b509a-bf4f-418c-a921-cf3383fc5929@redhat.com>
Date: Thu, 25 Apr 2024 11:25:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] mm/vmscan: avoid split PMD-mapped THP during
 shrink_folio_list()
To: Lance Yang <ioworker0@gmail.com>
Cc: ziy@nvidia.com, 21cnbao@gmail.com, akpm@linux-foundation.org,
 fengwei.yin@intel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 maskray@google.com, mhocko@suse.com, minchan@kernel.org, peterx@redhat.com,
 ryan.roberts@arm.com, shy828301@gmail.com, songmuchun@bytedance.com,
 wangkefeng.wang@huawei.com, willy@infradead.org, xiehuan09@gmail.com,
 zokeefe@google.com
References: <CAK1f24nb6FkipH3OZa0uwbBWkefS3f2BrJ_GTxkS2j6+6bgODQ@mail.gmail.com>
 <20240425085051.74889-1-ioworker0@gmail.com>
 <49394660-8455-48ec-8ae1-fbd2d590d27a@redhat.com>
 <CAK1f24kaphS9Gz4Nxe-+=iHs_+CpA1Qk7q=pdzUJKc5u-0_qXw@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAK1f24kaphS9Gz4Nxe-+=iHs_+CpA1Qk7q=pdzUJKc5u-0_qXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> I was wondering if we can better integrate that into the pagewalk below.
>>
>> That is, don't do the TTU_SPLIT_HUGE_PMD immediately. Start the pagewalk
>> first. If we walk a PMD, try to unmap it. Only if that fails, split it.
> 
> Nice. Thanks for the suggestion!
> I'll work on integrating it into the pagewalk as you suggested.
> 
>>
>> Less working on "vma + address" and instead directly on PMDs.
> 
> Yes, some of the work on "vma + address" can be avoided :)

Doing the conditional split while in the pagewalk will be the 
interesting bit to sort out (we temporarily have to drop the PTL and 
start once again from that now-PTE-mapped page table). But it should be 
a reasonable thing to have.

Please let us know if you run into bigger issues with that!

See walk_pmd_range() as an inspiration where we call split_huge_pmd().

-- 
Cheers,

David / dhildenb



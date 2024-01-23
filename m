Return-Path: <linux-kernel+bounces-34844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF910838838
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97B8D28A44C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A04F52F7E;
	Tue, 23 Jan 2024 07:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZPs6vU17"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EC22AE91
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 07:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705995993; cv=none; b=P80VsOOwrzkTz44z53Nj72EreQ8CsdELBq5texmj3hrf1cxxyI+yZlDVmfwP6uoHieFrhmfL/zQ/zkWjfet3LgWRaIJThaWFa53oGYkLcyGucnbOn8a7/WXTxqKD02JkZoab0uAZn45TlJ1c3wiuZfS7v2isuHrSCm3nuRkJcLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705995993; c=relaxed/simple;
	bh=hoPao9tbGJ9KjiTRhQfBNtRT2yMUls7NC9FEvroT+Rc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jFbpGwu2ob70LstnWT1oQS7PjL6yZVrX3ICRboAehPskN0bDIFqqyoc1mDa8Qn2c8bp/R6hsVQkWOXpKWBc8Y1BokLpLkNODs9iyLtqyrQhfX6IbOIUUoH/gUjJ1N7y+0QYhHtSjn94xw7xMVSMMe9vr6lT6zkEehAbZ9b4duGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZPs6vU17; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6ddf1e88e51so3109490a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 23:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1705995990; x=1706600790; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jicH4Sl95+680VziAGp6RFmScRJlie55hSPce6vSEjk=;
        b=ZPs6vU17sXmArMIb7vx6PrKPwmAxjoIghVpjvZPd2nD10KYeycw/gyIrcZeddMpi6O
         rwhZnZSiGd3qPwogS/OT71mJDbdTTzBNreR3LvjXlltLaldKh5iX4Ats7Df7ABKT6a37
         qLhO4ryAowlzzTkGF/JDJczUPK3z+IXm1TZ2GvL0npRKptNbz6eSKrGmKwfinHxf/4gZ
         Oefd9zWxgfYRduCZ7SC/gmP8h3yzJa3E2qr63xMbOYMd5rT/OTnu6t99ut6kG7Wg/jKH
         Id4nleOJ1/+0PUKeEVcDj0o5eo1faUXx+Fo//atTke/KJo6oQ+njAPUvlS6FkS+mpktP
         v7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705995990; x=1706600790;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jicH4Sl95+680VziAGp6RFmScRJlie55hSPce6vSEjk=;
        b=P9pNVT0q4Ag+LsMs5aO4j4Ha8DoOiQyT/367rHaYMSJt6YRkPe3nAXtJOFarw/xRNi
         b81t4UKSoPnZL5pSQUshWzFtHljrrxcZUXSsgY1P4tkc77ZAh4Pp6K+kUcjD54dtotDN
         ioc4maRcz1n9nSLAV8RQ2OwI8udQhZjnQaNvu7Hinldwzj9SGVnD5XxJpMVw+APA25zW
         1rm3DVpS3AYar57BSMia8jLdltIHRJU5DO0LWWcl67SsS5znLF3DXnQ7pRC2ERBSyLu4
         m1RGTlJTvIVppzM6zDjYvRlIJlJRWD/QC7DXCx4MwXd0KH+M9PuiuMahorqd/ILgxBDi
         ZhFg==
X-Gm-Message-State: AOJu0Yxo7AdSGUGRJA70qmZ+VjjBtbHwKu+63B+Ibp2lrLtgiLiQh6oJ
	ZmR/eZ885k17u0XDegq8HutyOvWZDs9X3fvKXsOAhhPKKZzIppf3WsqOfqTPKnA=
X-Google-Smtp-Source: AGHT+IEyLatL3kiKb/pIE8x0tVAWeU3x117UaL4efqa2LhFOIFOXEQGR6LS/dXAEI0BIpr01OrVCCQ==
X-Received: by 2002:a05:6358:281a:b0:176:5e4:cb8d with SMTP id k26-20020a056358281a00b0017605e4cb8dmr4210665rwb.51.1705995990275;
        Mon, 22 Jan 2024 23:46:30 -0800 (PST)
Received: from [10.254.236.83] ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id h20-20020a62b414000000b006d9a9727a8esm11199033pfn.178.2024.01.22.23.46.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 23:46:29 -0800 (PST)
Message-ID: <572bfa89-83c3-45ed-abc6-d71b9519813c@bytedance.com>
Date: Tue, 23 Jan 2024 15:46:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mm/zswap: split zswap rb-tree
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>,
 Chris Li <chriscli@google.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>
References: <20240117-b4-zswap-lock-optimize-v2-0-b5cc55479090@bytedance.com>
 <20240117-b4-zswap-lock-optimize-v2-2-b5cc55479090@bytedance.com>
 <CAJD7tkbYv_TfEZ3Dj1JE=NXA323MdxGR9ib34PUoCmbfFaSCRQ@mail.gmail.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAJD7tkbYv_TfEZ3Dj1JE=NXA323MdxGR9ib34PUoCmbfFaSCRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/1/23 03:49, Yosry Ahmed wrote:
> On Fri, Jan 19, 2024 at 3:22 AM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
>>
>> Each swapfile has one rb-tree to search the mapping of swp_entry_t to
>> zswap_entry, that use a spinlock to protect, which can cause heavy lock
>> contention if multiple tasks zswap_store/load concurrently.
>>
>> Optimize the scalability problem by splitting the zswap rb-tree into
>> multiple rb-trees, each corresponds to SWAP_ADDRESS_SPACE_PAGES (64M),
>> just like we did in the swap cache address_space splitting.
>>
>> Although this method can't solve the spinlock contention completely, it
>> can mitigate much of that contention. Below is the results of kernel build
>> in tmpfs with zswap shrinker enabled:
>>
>>      linux-next  zswap-lock-optimize
>> real 1m9.181s    1m3.820s
>> user 17m44.036s  17m40.100s
>> sys  7m37.297s   4m54.622s
>>
>> So there are clearly improvements.
> 
> If/when you respin this, can you mention that testing was done with a
> single swapfile? I assume the improvements will be less with multiple
> swapfiles as lock contention should be better.
> 

Ok. Not sure how much improvement, may do some tests later.

>>
>> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>> Acked-by: Nhat Pham <nphamcs@gmail.com>
> 
> I think the diff in zswap_swapoff() should be much simpler with the
> tree(s) cleanup removed. Otherwise LGTM.
> 
> Acked-by: Yosry Ahmed <yosryahmed@google.com>

Right, thanks!


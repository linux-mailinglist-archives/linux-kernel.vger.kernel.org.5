Return-Path: <linux-kernel+bounces-49445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8AE846A65
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00EE61F2C109
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5323C6AB;
	Fri,  2 Feb 2024 08:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="CiBNpJwK"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A09718B09
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 08:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706861460; cv=none; b=BPMTx3C443F9tJPuFz0AaYo/jBewFRxmxXBE6y6bznfyNCdel6pV/ijsIVup5ZP6bJQ/PUhwXe3tDM79uWRPxvI9lU5nAvUHHZYsgix8HTskwyZkwmmcm2dfpuwdwzGk/nnhj9MFlkqUBl+xHZyuI/yurtEiwFvn0arCEj6oFGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706861460; c=relaxed/simple;
	bh=mcPscaYvDbydUDu+j6jRetlX1oMzPiFHYlvTS3YFoJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nQSOdnRI7Ne6gVPH4/R9vaCVlLjG3XsrbLJvvabJFkB/j38pUTHZ9wuio41NWKG1m/xF+N/As4oxzvpGjlTl+XnyASiEjteC/XwW8cjhehsk4Nn5fRsGhqd0AVSbeUFBN8mudjQf5Pn2hiTnVArs+GVLS6flqyJB9LpHPSAdXko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=CiBNpJwK; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d93ddd76adso14117205ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 00:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1706861457; x=1707466257; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sZZU4FMipo/OE/fTPsyTBnGWJR2EdwEX0q5lQaRxsaQ=;
        b=CiBNpJwKgWaDkrfNTU6v2/Gc0eYpTkWA5BmQ7410SxNF+IVRZws0g8KUOoqBoB9yLK
         txVO17AEZnFPxUrOQB8BWhr9qaaMRtgeETMen0vjVCvpB+N9nXhhYGcyutML7GPqBoBQ
         bUsmLE383bWJc2O5fVk6+pu3eAgInvKzLXs1ldSjq2jkyQOXaNrZpdLBV0A+Ysqw6p3C
         vXpFqEO6EksWRM0H1bDicFuLlTRDn0SvPRLD1GkQY/euTG38S294GxKeSSG6XyIkM9CM
         ACeLxwRqq8fBWw2SFHlIgvvs2uhbAgJ9d4lsEfndOlPUn9CI9aegTXg1ITnGfJxjUvTC
         1DmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706861457; x=1707466257;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sZZU4FMipo/OE/fTPsyTBnGWJR2EdwEX0q5lQaRxsaQ=;
        b=ifqqZCcEMfWCXxOoKL/zysHwGrbrnE4oJogmWNj4tyg8b1hxJgWutxxIpcyvxsMHMI
         YnsW1MtHE1nFuJX9AY46x8GRBiCrWTj3fxOc4T7NqinKeFs4S4WMDtQoAzvYBFn4VpKn
         tD+/uMFNsFgZhqykdlt2kCgz9XctFpM2EPJIO/7LQ4XSREn/2VbcIFXgvo///xi+KTnW
         NiAH3vzYrk+gXHGb7OWFqybTYOR/bWs6msuLRgtUxqseYu0XW2aFIOwSth3DXWqBoved
         TzObLXYrzC9DHHvAOHc5ZKDyrBuxLPhzxGlShcSn/9MLNO8vN0a+S+PIJsLF0V2nkWvK
         frXw==
X-Gm-Message-State: AOJu0Yyjetp5BZ/l8+yMfOPtYz48yMz8wezzB6AYyWsCxlvnWTdYjZ5E
	PGCIyn5q6whwleLD7zNDuxIhRg5TdToHMTeyT5XHm4FsAnICi1taqpg1UVZ52VY=
X-Google-Smtp-Source: AGHT+IG8qiRct5M56j14zQWbT+GZNjWLZGju7MSHlxolFfwtoZ4LQUGW98/Urag61+I6wQZaO6TXPA==
X-Received: by 2002:a17:903:2b08:b0:1d9:63db:2bd7 with SMTP id mc8-20020a1709032b0800b001d963db2bd7mr3031170plb.61.1706861457589;
        Fri, 02 Feb 2024 00:10:57 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCURMLp+4Sjpbz79qAWFsT/X7NC6O+bV3Or2umNADQrhiybs7RoV3SCVTRRZEzdZ3zZSkF5B7nWXE1iDhjrvl7wAvGlJXGe2vBzRu/pwgzUH63dHMAO6PZTqjyQXxXa919QR+Xp0afGZ/SwyFzYevlXCtK76irTqsZJ2/YFB1v8ef2kMFjX4EFNB4h1814OlLg==
Received: from [10.84.152.222] ([203.208.167.154])
        by smtp.gmail.com with ESMTPSA id j12-20020a170902c3cc00b001d90bacc8acsm1015264plj.124.2024.02.02.00.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 00:10:57 -0800 (PST)
Message-ID: <ca007122-7129-4bdb-8f08-fd8ccdc2a193@bytedance.com>
Date: Fri, 2 Feb 2024 16:10:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] mm/zswap: invalidate zswap entry when swap entry free
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240201-b4-zswap-invalidate-entry-v1-0-56ed496b6e55@bytedance.com>
 <20240201-b4-zswap-invalidate-entry-v1-2-56ed496b6e55@bytedance.com>
 <ZbwzQmWHE_FSp3L8@google.com>
Content-Language: en-US
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <ZbwzQmWHE_FSp3L8@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/2/2 08:11, Yosry Ahmed wrote:
> On Thu, Feb 01, 2024 at 03:49:02PM +0000, Chengming Zhou wrote:
>> During testing I found there are some times the zswap_writeback_entry()
>> return -ENOMEM, which is not we expected:
>>
>> bpftrace -e 'kr:zswap_writeback_entry {@[(int32)retval]=count()}'
>> @[-12]: 1563
>> @[0]: 277221
>>
>> The reason is that __read_swap_cache_async() return NULL because
>> swapcache_prepare() failed. The reason is that we won't invalidate
>> zswap entry when swap entry freed to the per-cpu pool, these zswap
>> entries are still on the zswap tree and lru list.
>>
>> This patch moves the invalidation ahead to when swap entry freed
>> to the per-cpu pool, since there is no any benefit to leave trashy
>> zswap entry on the tree and lru list.
>>
>> With this patch:
>> bpftrace -e 'kr:zswap_writeback_entry {@[(int32)retval]=count()}'
>> @[0]: 259744
>>
>> Note: large folio can't have zswap entry for now, so don't bother
>> to add zswap entry invalidation in the large folio swap free path.
> 
> This makes me slightly nervous. Should we add a comment somewhere just
> in case this is missed if someone adds large folio support?

Ok, will add this comment:

+       /* Large folio swap slot is not covered. */
	zswap_invalidate(entry);

> 
> Otherwise the patch itself LGTM.

Thanks!


Return-Path: <linux-kernel+bounces-33077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B236A836426
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 687B4292865
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464EC3CF50;
	Mon, 22 Jan 2024 13:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="YZlmCEQC"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DD23C6AB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 13:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705929238; cv=none; b=AkNU8QqrlrpbIgQP5oOkueXN1CFqiuCPOmC3EccYLlA20VOqoRs8BpALoz8WBWjZvZips9YVWVixbjpJZTR/f+p8Y9YHJPbvDM2dXHE+qbfKkp6l8qu6wWkbN5OKs+YakCJ/lg/7+TpxYnA+joTfDCY2qaZ4yZhf7z3VopF1bso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705929238; c=relaxed/simple;
	bh=hU5CNotTJU/uvRLdwjZo0czn7scddniW8EAN5gt5mi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PqhDlSmMDgfzkLlRKvjVgZNNiTNw7C+jluy8u23mCVQo7mpmV3ibQb8WzUlVH5T5Dqz0mmjKzACf5Og3PZlnyPSfMHR6eoU/rzEq5085HIxBmkGPj3EldMTWd0UOpTQ/PY3OU/lpovlobMQUUWfdf20td6A38M9XvW4Jg4pG52g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=YZlmCEQC; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6dbb003be79so2769483b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 05:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1705929236; x=1706534036; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S9m5xL1UcAIW5Th4J3nWvbXTBdcQrCpR+emEwkfnp8k=;
        b=YZlmCEQCowlR3rOi3HvvfFKtIRvSUnrA9kEbyJFoKf9mcHJfiKiKBK6uGPpquOFzQk
         QumyAdjKilg1FGkV/V+KF9AgCrNhEDX3xNuJ5dAS6EdYlnZFt4/79727E1H2k3+F4Z/7
         Uqk5cSHIAsuWCsKYH5Bkdk6FsNMPwR/+3vSXRC50cq/eNhDrQM4kFyXeutaEGwQ0tLt4
         TV7ap31jWHEKD500/gUbrwRgwUUK4SK7/DmTeP9xRvGYzYLGMKtl4bF0i0fdgprZijyU
         AKgAtpHsGqrGVMweUJY1+x9HakvpyYMTPgKJ41Kgqq6pDEEP6R7UPtHMOg+6iycVyuu+
         q2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705929236; x=1706534036;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S9m5xL1UcAIW5Th4J3nWvbXTBdcQrCpR+emEwkfnp8k=;
        b=PtLZc1qdDyZrgI2ylUKcUdc4jdLP1PwH13G6EE+39xyGrHxxVvuKbDlkj6vP1svHi6
         BKZDqIt31JDe1j2byFJXshclhonOCp5yDR78Dm67FhlwIw+eL8e5TrA01TqDact6YhC4
         z31JQSh8PK8gGjFM6Fpbf2IvpW/pLwsWAItsN+6fY19KNqTokRX1QH2WfZLogV7/2kFE
         7lVCtMfb4bJyAndESbKlAppO9MqE5SQjCOARcSKZM+0a7J6LIrPP2GEOQHUzPMF17SCt
         kHEEthc88nEpm2EOGNjqtUn8l+Z5oCT6qsIKTsnyRTHHoIeSS7jnf6NqUboiMoQqAohE
         TZyQ==
X-Gm-Message-State: AOJu0Yx0pYW2CA+0gWOUs1SaR6cd3PAkLvo2+Q5FwoZMvSOrHpr8fbD+
	tjGuE9bu4bP6bfOqkYVpiYmka7ngyT0TD+cwRKtwtR/Rye+qFvjc7s+q67DeE8s=
X-Google-Smtp-Source: AGHT+IFputq7UFFL827FFoI/oAfRWz79uIU4OBZSmCcoJo+oNBqN99aJWqv0U1ox8jhqLMyo/PvaTg==
X-Received: by 2002:a05:6a20:9599:b0:199:84a8:9358 with SMTP id iu25-20020a056a20959900b0019984a89358mr4277279pzb.45.1705929236011;
        Mon, 22 Jan 2024 05:13:56 -0800 (PST)
Received: from [10.4.246.34] ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id lc9-20020a056a004f4900b006db105027basm9507610pfb.50.2024.01.22.05.13.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 05:13:55 -0800 (PST)
Message-ID: <5fa2bf99-3c80-4196-94e7-af8c1591acdd@bytedance.com>
Date: Mon, 22 Jan 2024 21:13:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm: zswap: remove unnecessary tree cleanups in
 zswap_swapoff()
To: Yosry Ahmed <yosryahmed@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
 Chris Li <chrisl@kernel.org>, Huang Ying <ying.huang@intel.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240120024007.2850671-1-yosryahmed@google.com>
 <20240120024007.2850671-3-yosryahmed@google.com>
Content-Language: en-US
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20240120024007.2850671-3-yosryahmed@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/1/20 10:40, Yosry Ahmed wrote:
> During swapoff, try_to_unuse() makes sure that zswap_invalidate() is
> called for all swap entries before zswap_swapoff() is called. This means
> that all zswap entries should already be removed from the tree. Simplify
> zswap_swapoff() by removing the tree cleanup loop, and leaving an
> assertion in its place.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
> Chengming, Chris, I think this should make the tree split and the xarray
> conversion patches simpler (especially the former). If others agree,
> both changes can be rebased on top of this.

Ok.

Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>

Thanks.

> ---
>  mm/zswap.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index f8bc9e0892687..9675c3c27f9d1 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1790,17 +1790,12 @@ void zswap_swapon(int type)
>  void zswap_swapoff(int type)
>  {
>  	struct zswap_tree *tree = zswap_trees[type];
> -	struct zswap_entry *entry, *n;
>  
>  	if (!tree)
>  		return;
>  
> -	/* walk the tree and free everything */
> -	spin_lock(&tree->lock);
> -	rbtree_postorder_for_each_entry_safe(entry, n, &tree->rbroot, rbnode)
> -		zswap_free_entry(entry);
> -	tree->rbroot = RB_ROOT;
> -	spin_unlock(&tree->lock);
> +	/* try_to_unuse() invalidated all entries already */
> +	WARN_ON_ONCE(!RB_EMPTY_ROOT(&tree->rbroot));
>  	kfree(tree);
>  	zswap_trees[type] = NULL;
>  }


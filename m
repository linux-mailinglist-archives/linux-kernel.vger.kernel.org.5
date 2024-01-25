Return-Path: <linux-kernel+bounces-38198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0ABA83BC5F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77C7D1F2AC4C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219DE1B968;
	Thu, 25 Jan 2024 08:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Xg3fzsET"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E58A10976
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 08:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706172882; cv=none; b=mHUfDJQ4iFqPsbM3QLEr1NGzXUD+foEM89lMJfFfJQXaL6+CftzrmyZsBSiTyLL1acG8FRqOM7dHuDW+Dq/0hHVF1koCZ/dgGHhsrHl+UbmoU5r0ZDyHIS5bEUD6EkxQ5iDjPz5uHApInnw59yCUWRVmZ17kpNR+7p5RDEq6X/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706172882; c=relaxed/simple;
	bh=IGBiPs1WuJSFqvW9MzDUHcqs1Dhqm/XYrWTO9agZg+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XLgIC0/x7zPkgowEHeL9qmGyqWwVBQ+Svn/kXxLruMLgbVNgIPhayrZVXESbLS1WUYAFPaHGyU4pjLVxGArdxKy7gerJ0zHP/ViWMHPAUhVwoHrSDOA01fysuAnKdO+ekUhpKYnx6Xvzf4woxlbJXQtRFmcj+h+RXoR03OWzQ/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Xg3fzsET; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d51ba18e1bso59091555ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 00:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1706172879; x=1706777679; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xnkZERa8Q5xoGtJvJZat5iyOg0P3QANDIW4NDNOE4l0=;
        b=Xg3fzsETyfzvGfHgHaA/ojohGMRS4lZkqYInln01Q/k2TF5l97uy8sne0GTQgELCL1
         mnyegRW4N6dot/hJlHRU7Iko2CXZflm9xlz/118PpqRs1PIn2oRaAWo5WMeyil1UXgrQ
         n39gkDURwM+EQk7G6A8gn6Icab7m6K9fvph1mmszTms3ilKkRq1d2YKFKPmO+f9aThMO
         i9v0Mjcyc4ok2OUOxOCMB1dMJwZWogwQ9w/w+oy2niD9+oawxuMAiGlXa5mpCTn4p+TU
         mv3wZuHP7OTmTtDv/3Y+9EXrwgqYGrobka008UgCBEg/yVMc4DXqiAPqBy9Xqme0jtFa
         dQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706172879; x=1706777679;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xnkZERa8Q5xoGtJvJZat5iyOg0P3QANDIW4NDNOE4l0=;
        b=LsCy7DLK8A4aCCEj+Z7FVHFLtjSfyaPFbRcHhVO6Z/wPR7YH6/is7IrGKBY+BiY8Jv
         F8Gk4phzOJO+zWBNnLqZPZcXtRuD952mWoG1/n6pRq0eaA6ICXcx1vijilae69Zxc3ba
         TMHzqxMyn4xcjEfE6EeOlzdzdIcb4nZSojlBKIyqBgNZqcfZBvViSNfDk4mtXni8Hn9K
         5cmjQRmHtHulNKFlA2q3xbhepPP9wjpamqYIyGJCfLvVkriJ+rU0AvQY9Rs1LOJXf+Ai
         BmqLYxpYRiC9GZh/CKpY+ujhjor4uPwmHd092siJy6kl6Rxem34VwEKvtjopqgegZWOI
         p11A==
X-Gm-Message-State: AOJu0Yzg60LL2xzRnzDQvK7JvaPeFO0LAevr67E1acopTAKVgylW1bXD
	Ln0jVzrbXa9QheS9Ju06lFw39yzVtW4UMzEmJEe8Q8Q0zE0mWjICdc6dTI4VLbE=
X-Google-Smtp-Source: AGHT+IHn4Y+4c7MEgANSirnXzcKFSWT7Z0qo6rSzruiuCcQx6zt1x0dPL/M9TCo9yaJ2tGgQaivEAg==
X-Received: by 2002:a17:902:ed44:b0:1d7:199:cfb7 with SMTP id y4-20020a170902ed4400b001d70199cfb7mr715381plb.138.1706172879543;
        Thu, 25 Jan 2024 00:54:39 -0800 (PST)
Received: from [10.4.195.141] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id y2-20020a1709027c8200b001d7726c4a40sm3615519pll.277.2024.01.25.00.54.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 00:54:39 -0800 (PST)
Message-ID: <6f81161c-0280-48b6-a7af-038c676a02b3@bytedance.com>
Date: Thu, 25 Jan 2024 16:54:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: zswap: fix missing folio cleanup in writeback race
 path
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
 Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240125085127.1327013-1-yosryahmed@google.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20240125085127.1327013-1-yosryahmed@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/1/25 16:51, Yosry Ahmed wrote:
> In zswap_writeback_entry(), after we get a folio from
> __read_swap_cache_async(), we grab the tree lock again to check that the
> swap entry was not invalidated and recycled. If it was, we delete the
> folio we just added to the swap cache and exit.
> 
> However, __read_swap_cache_async() returns the folio locked when it is
> newly allocated, which is always true for this path, and the folio is
> ref'd. Make sure to unlock and put the folio before returning.
> 
> This was discovered by code inspection, probably because this path
> handles a race condition that should not happen often, and the bug would
> not crash the system, it will only strand the folio indefinitely.
> 
> Fixes: 04fc7816089c ("mm: fix zswap writeback race condition")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

LGTM, thanks!

Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>

> ---
>  mm/zswap.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 8f4a7efc2bdae..00e90b9b5417d 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1448,6 +1448,8 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
>  	if (zswap_rb_search(&tree->rbroot, swp_offset(entry->swpentry)) != entry) {
>  		spin_unlock(&tree->lock);
>  		delete_from_swap_cache(folio);
> +		folio_unlock(folio);
> +		folio_put(folio);
>  		return -ENOMEM;
>  	}
>  	spin_unlock(&tree->lock);


Return-Path: <linux-kernel+bounces-43842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE9884196F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 269851F2A515
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44AD364DC;
	Tue, 30 Jan 2024 02:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="M5oAsqaB"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C344C2E62A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 02:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706582497; cv=none; b=WE69QUeY0RbB2KkUOhCvmYbmOCqCmgUo9UaNW+oDkn2wksEXCbzLtVps21AUnqK6JOMRFDnBGebVG1TuRGuLup+X54y1QQQ41PKoqVqLyg6wRPRlXoZLuzK8fvdCglCn/7oQ14yG80biUBL3nZkcL2DMWMDOJeaQPcZxEZeoFG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706582497; c=relaxed/simple;
	bh=aVwVdNf3Mfp8Z8muKC48fjZnYIf3JuIc7nHYzLezxWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FI7k31QBRXSGrROPViFCSMIVplglfQHudbAdPui6UKQohA7FhIvU/uSBJ3r9mc/NDjgkffmITQr/WfeTnFQTazZID4TMjwSyhY779RCpelCfm7/dWu3MDXqIOKalg+inJCMBvxGrzj1M1Z0Ft+5Qw3lKwSqOja1ZPqQTzA8dkfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=M5oAsqaB; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-290da27f597so1589023a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 18:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1706582495; x=1707187295; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SNJWPiDT9XCn+XhD734CW8fJDtPz3dLIEFDP1H5QFL0=;
        b=M5oAsqaBL2fJlEfqMb5X2kgPfpMYI33MjVMFiADaflxU9BLuLXqMq0A25EAjjL5iii
         plPbGdGlDWA5DpQf4eVRUgAjs4W7Eg2+tfrLP06KIu85+hJUbtV6NJaCw+4gXv1Dzsa4
         oZjaLntr1bx8kY7K//XwgrW5Bfw5jediIWUvM4xtH8qzd3kdnW6JEJ/zAe9y0xtZE0+v
         yAH8OAK1rpP0+vR17aRQ/B9zKg6Y/0Avq0qcio0ZMuT9Tw+hcTnY8dFXsaV1NuBN1Edq
         tK/Mip35Kvx0gbNfEEETKcwgpHXgWkwSQAsh7UrRmCSnSd4UlqC45JR8kW0fW8/J3WbY
         gJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706582495; x=1707187295;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SNJWPiDT9XCn+XhD734CW8fJDtPz3dLIEFDP1H5QFL0=;
        b=uGZLoBdS9JxYvKbqSlH19je1jbWdl9Uab+YVEb0akPeF55y+F/YRwaWSDTSOJBBm9/
         njaQw5E21nUTrm1/uvpqpMbJjGw9DZZUDHh/PVqCUVSKv5je3A5a8cILsN9DUCiWODQP
         HF/WHgDGEqPKBT+B3bSU/cwZ24gp/S8lKKn9tkzvkvSezHx0Yl4HgBBaDoIpdEPbQ5gs
         vw6gWYedJX1NLEbC1c2S25jM9cmCyRwHv+IrVh4XH/Bg2z2ejQBbgszcSzathC1GFNad
         Rxk/N6m7++//Rs54g9lIedRtOBtrs1bt9ThGitfPGwXcvNwsDSF1wOUUmhHFgXVtxcy1
         M27Q==
X-Gm-Message-State: AOJu0Yyh8gA0iI3uFGGthdihAOs0GBUgKRXYN463xEUhYgV6g7qkV2zN
	NXwo9Kj4ppVMK+TZwfgh19BT/D16Niddsd8RCCd0bKD38cmwDen8iQrJghuNXEM6NS/z+/q9U6y
	O
X-Google-Smtp-Source: AGHT+IGLmVFtPuKxEvknXyOUbPHBKk+x+DHrG1IpQdw0ANYURWfQ1ZfjL2/uduYOZDH6p7PC92WIpg==
X-Received: by 2002:a17:90a:db91:b0:295:aaa5:7dcb with SMTP id h17-20020a17090adb9100b00295aaa57dcbmr568314pjv.35.1706582495099;
        Mon, 29 Jan 2024 18:41:35 -0800 (PST)
Received: from [10.4.207.234] ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id j11-20020a17090a318b00b00293d173ccbasm7839409pjb.52.2024.01.29.18.41.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 18:41:34 -0800 (PST)
Message-ID: <ffc74759-e3e3-499f-85fb-abe52bac2464@bytedance.com>
Date: Tue, 30 Jan 2024 10:41:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: zswap: fix objcg use-after-free in entry destruction
Content-Language: en-US
To: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240130013438.565167-1-hannes@cmpxchg.org>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20240130013438.565167-1-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/1/30 09:34, Johannes Weiner wrote:
> In the per-memcg LRU universe, LRU removal uses entry->objcg to
> determine which list count needs to be decreased. Drop the objcg
> reference after updating the LRU, to fix a possible use-after-free.
> 
> Fixes: a65b0e7607cc ("zswap: make shrinking memcg-aware")
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

LGTM, thanks!

Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>

> ---
>  mm/zswap.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index de68a5928527..7f88b3a77e4a 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -522,10 +522,6 @@ static struct zpool *zswap_find_zpool(struct zswap_entry *entry)
>   */
>  static void zswap_free_entry(struct zswap_entry *entry)
>  {
> -	if (entry->objcg) {
> -		obj_cgroup_uncharge_zswap(entry->objcg, entry->length);
> -		obj_cgroup_put(entry->objcg);
> -	}
>  	if (!entry->length)
>  		atomic_dec(&zswap_same_filled_pages);
>  	else {
> @@ -534,6 +530,10 @@ static void zswap_free_entry(struct zswap_entry *entry)
>  		atomic_dec(&entry->pool->nr_stored);
>  		zswap_pool_put(entry->pool);
>  	}
> +	if (entry->objcg) {
> +		obj_cgroup_uncharge_zswap(entry->objcg, entry->length);
> +		obj_cgroup_put(entry->objcg);
> +	}
>  	zswap_entry_cache_free(entry);
>  	atomic_dec(&zswap_stored_pages);
>  	zswap_update_total_size();


Return-Path: <linux-kernel+bounces-43902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 925DD841A98
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 04:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A73E287695
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF764374F6;
	Tue, 30 Jan 2024 03:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Q8Alec8l"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA6637157
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 03:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706585759; cv=none; b=dshhoL5YQ3g5SlTmJBz1cyjOIpVuB5URut5b795ekWzmm/ZUg2vYl3XUjEszif3ftBqsdTrVdd9t8irGhE+7+oR68k9T3ZKEGplfcTS0+3ehNTlI/XfF7OSWctZI/M/imjJTEFTImITel+2I43sWbwVS0jZHJecMCJCU66VZAnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706585759; c=relaxed/simple;
	bh=R9LgKpZGX6WblhdaVv/nKy5lnC9vfA3FsZFaB7L92/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bEMpnmfRDTVR/XG3N8cRcv876eWvFBvwrS7RIOIj63PCCi6D6iuV1jc7tQsxz9ae2sDTnrT9bL1v1B42ttWaSvV7+tfhRnOkjC+DpEn0AW/H1i13tIu04LKsMlLiq7YqojybafLopZFItYdqGv3u8opRf6JOPeYMY2neCJvrWcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Q8Alec8l; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-599f5e71d85so2262574eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 19:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1706585756; x=1707190556; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x7BuWgI+mp186y57geXkcn9mJHnm2lscomTQc6ban4c=;
        b=Q8Alec8lTdyZ2xLgerWjAPzwR8dTf0dYFrsq6TSfi3hRCquouCcsapuJLdUJ74pFZ7
         mmQq1SnpGnaNTLXPcdfmz9BNEluDv10gSWaWsPhF0OQmv6VImA75JdYzinz/Vh61M0Ew
         Pe/ijGBUmuxl/1yzFhykqiJxjZ8hFf/xgDXqy5v6uTK6nsF/0RQoM48ZoZJyXCO0Nahq
         73mi54zFgAQSVNnRsdsnuCs7S2O/zssvWUHQy11arY518Tp9iz7ZQ9vBMWcwccPB2zl4
         lcOjIUjw2zVHLxrbkG400AbUhMCULJixNxHPpCeKZZAkx5pHdYueamOBacKz2xB5yD5o
         LNMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706585756; x=1707190556;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x7BuWgI+mp186y57geXkcn9mJHnm2lscomTQc6ban4c=;
        b=CtpHWc5vMCBAeodyZrI1pd208FSOCL/lfSGcF9MNWSx6I494/09i/p640C9WHvYzyz
         18LyPhaxWZnz3VtFNAO3C2DB8sRe17M3CBiBVRLp3XUlT02vwFf6hmaAmMScpXga63Ra
         /ZLkvANJ9pDhy9Pmeby8oxHHQtI33s4pt0AYU9SbXCB7mNMOEauAFJaoq0oy5h0XHT1F
         0WkD/7FwnuEtuD4qQ1xRwCj6jhFsnJ1Und0/jDX7EDHVY5z2LB5BxGcd9KMy6RX0Z5Wu
         VUmoc00oXsKp7gUSJf6U1o7zgzfsIqC6x+Qek3cXlWPjPPBu/PSOZnIfP1f5q/uDvJUC
         wQJw==
X-Gm-Message-State: AOJu0YzgLJnJE8LZ6Cl/fEaov7+VDvFvem5QWZ2yYBckHniJgdu/ixKS
	XgPsIV7AVXarhCoLqBrepBKU4rndT4IUmjcgyr2+vpIB+LkKUrxAHKV+UtzPudQ=
X-Google-Smtp-Source: AGHT+IGnPIBVF6ja++runoCXGH04FT8UVXeV3rpgK/3tYSNdq5/QQ6M8NEjXFzfxpt/M6L3zzxMylw==
X-Received: by 2002:a05:6358:5913:b0:178:77cc:a0f1 with SMTP id g19-20020a056358591300b0017877cca0f1mr2520937rwf.48.1706585756464;
        Mon, 29 Jan 2024 19:35:56 -0800 (PST)
Received: from [10.4.207.234] ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id y17-20020a63b511000000b005d8b481c4d3sm5561909pge.87.2024.01.29.19.35.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 19:35:56 -0800 (PST)
Message-ID: <5b977675-592a-46ec-8bbc-d6c70dd5371c@bytedance.com>
Date: Tue, 30 Jan 2024 11:35:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/20] mm: zswap: simplify zswap_invalidate()
Content-Language: en-US
To: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240130014208.565554-1-hannes@cmpxchg.org>
 <20240130014208.565554-10-hannes@cmpxchg.org>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20240130014208.565554-10-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/1/30 09:36, Johannes Weiner wrote:
> The branching is awkward and duplicates code. The comment about
> writeback is also misleading: yes, the entry might have been written
> back. Or it might have never been stored in zswap to begin with due to
> a rejection - zswap_invalidate() is called on all exiting swap entries.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>

> ---
>  mm/zswap.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index cde309c539b3..082d076a758d 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1739,15 +1739,10 @@ void zswap_invalidate(int type, pgoff_t offset)
>  	struct zswap_tree *tree = swap_zswap_tree(swp_entry(type, offset));
>  	struct zswap_entry *entry;
>  
> -	/* find */
>  	spin_lock(&tree->lock);
>  	entry = zswap_rb_search(&tree->rbroot, offset);
> -	if (!entry) {
> -		/* entry was written back */
> -		spin_unlock(&tree->lock);
> -		return;
> -	}
> -	zswap_invalidate_entry(tree, entry);
> +	if (entry)
> +		zswap_invalidate_entry(tree, entry);
>  	spin_unlock(&tree->lock);
>  }
>  


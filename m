Return-Path: <linux-kernel+bounces-97696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 874D1876DF6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 00:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9A211C21DCA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 23:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FD73FB85;
	Fri,  8 Mar 2024 23:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="mPotTeRv"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A6D11707
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 23:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709941802; cv=none; b=A5+uD3d7PV4BYBO1IQx7WT5x4MGLQO2trEOap1lJ5Ct93Z23owRX/sl8gWJweMTeqdYAPL+6TgmEghLZ+KF5p41YbS65KCZe48cNKzNx8o2TwA6FH0UyzyI6J/0pkAaDS0vsOeF4exHQJxNWv6cir5N73x5+JTubwSbyEePxXaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709941802; c=relaxed/simple;
	bh=VwVDweM7A7hBcYergFPFJeBgGs3atd09plR0EB3F2zQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mztLPexj+fpl8rOvoCwToaUImi8LJxzKyad+1fttMJ3971wosL00EeXwOfobDLSbZJhJy01MTx4CXOIJgVLPUTKd85xRpkwhzfzUfZqLMykX/LJ92Bn6ri3ykReyyNU7DLVGrgevS4mhokfB9ve3DqP0VxeCWH8b32wv0KBvXvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=mPotTeRv; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dc0d11d1b7so22262635ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 15:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1709941800; x=1710546600; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bvvVxFJORKVGOnQydvxT4JtEYCtE1bHbtR+qPjK456A=;
        b=mPotTeRvQwqY6EHIe3q2V6h1UY+84lzJjRtlCPyDJEZe9KpKLa0HZ4HTqbLCFaZa/S
         qYREF8qbVbHU212nLPexx/76nVA/nW7BWFzGSd2miGv2VTJ6oKRF4mGRooYxWtuOxXB4
         ZVS7UOfGhge2fTJYrjWI21lxUtR5+uD9vTmIapbXkPeX7wvFZUTDMOfc80AqNAzPN1rq
         x2LCplBdBaRcvNBepfYT8Zw5PXEtH3DRcCSAzZbTNHK8iqOrq0MzkvaXMxhXk8qJGmkb
         08deXPimO+EpCMZegfM+ddekFJPMPf7Txp4tl4mMN736AdpkZy5nJ6YYcTdd2n2/omo7
         3yEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709941800; x=1710546600;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bvvVxFJORKVGOnQydvxT4JtEYCtE1bHbtR+qPjK456A=;
        b=O6urvLu7taHjVB7WAHWf5AUy8uvMdT3mZ5gJQG1vliyYMyxafm59gIq11ZW4MjVFcm
         2iv55AIkZwWfm+0c6KUIqBk/SfpHqlWI6pPVmYNkc7oV3gM/HoXGnaRDnbZJUP5C+KFM
         UUlCGzA6+PHHdIR4qsu10J9D0qK8ruAGEx1ysUYtZynuN1/l+cNNNdDiIFnDdTClSSaD
         hPec0rXekxc1SqQNsY7pbPXIGoMnsG6Y5Nwo+VnOBHngXuFbdbpPTwnuUeVzqfFC9czu
         BsYiC07LAoniYOEn6aMsZw5Rmhd1HDmJQYdBPJVMG4YeLW5h0gvpEzUuXtGwayCRuQb1
         lKIA==
X-Forwarded-Encrypted: i=1; AJvYcCUvtopGMzhOKIzOleeBGyTNbVyesR+1M0MkVrVUs6OHHAvDcS3Y0698qOMFPJLrf40I77hkDq7bRZAhVDTMgi7v7ln412aNFq1C15C/
X-Gm-Message-State: AOJu0YzahWTgwzKtOFYxrf+vF2Hyi8QsllsK39mm3zScYu/e6MI1x3sP
	4mUaoLiiOfYrTxYMj96lLWjyJH5QskInJ0pMkpWkinDf+scbnsePKKLDXbx8jqs=
X-Google-Smtp-Source: AGHT+IELbp+iVaux9dMAj3AwSjMmEB91AkVFjRihINKGUpZLZJOnpRotYIK+RS+5A3yxMzoBQZHlSw==
X-Received: by 2002:a17:902:d4c5:b0:1dc:7845:537c with SMTP id o5-20020a170902d4c500b001dc7845537cmr232003plg.1.1709941800017;
        Fri, 08 Mar 2024 15:50:00 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1156:1:1cbd:da2b:a9f2:881? ([2620:10d:c090:500::5:2342])
        by smtp.gmail.com with ESMTPSA id x4-20020a170902a38400b001dd63e22484sm199196pla.135.2024.03.08.15.49.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 15:49:59 -0800 (PST)
Message-ID: <8adb69f3-b0c0-42bf-b386-51b2be76cbb4@davidwei.uk>
Date: Fri, 8 Mar 2024 15:49:58 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] net: page_pool: factor out page_pool recycle
 check
Content-Language: en-GB
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Yunsheng Lin <linyunsheng@huawei.com>
References: <20240308204500.1112858-1-almasrymina@google.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240308204500.1112858-1-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-03-08 12:44, Mina Almasry wrote:
> The check is duplicated in 2 places, factor it out into a common helper.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  net/core/page_pool.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index d706fe5548df..dd364d738c00 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -657,6 +657,11 @@ static bool page_pool_recycle_in_cache(struct page *page,
>  	return true;
>  }
>  
> +static bool __page_pool_page_can_be_recycled(const struct page *page)

Could this be made inline?

> +{
> +	return page_ref_count(page) == 1 && !page_is_pfmemalloc(page);
> +}
> +
>  /* If the page refcnt == 1, this will try to recycle the page.
>   * if PP_FLAG_DMA_SYNC_DEV is set, we'll try to sync the DMA area for
>   * the configured size min(dma_sync_size, pool->max_len).
> @@ -678,7 +683,7 @@ __page_pool_put_page(struct page_pool *pool, struct page *page,
>  	 * page is NOT reusable when allocated when system is under
>  	 * some pressure. (page_is_pfmemalloc)
>  	 */
> -	if (likely(page_ref_count(page) == 1 && !page_is_pfmemalloc(page))) {
> +	if (likely(__page_pool_page_can_be_recycled(page))) {
>  		/* Read barrier done in page_ref_count / READ_ONCE */
>  
>  		if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
> @@ -793,7 +798,7 @@ static struct page *page_pool_drain_frag(struct page_pool *pool,
>  	if (likely(page_pool_unref_page(page, drain_count)))
>  		return NULL;
>  
> -	if (page_ref_count(page) == 1 && !page_is_pfmemalloc(page)) {
> +	if (__page_pool_page_can_be_recycled(page)) {
>  		if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
>  			page_pool_dma_sync_for_device(pool, page, -1);
>  


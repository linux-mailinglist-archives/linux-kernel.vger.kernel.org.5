Return-Path: <linux-kernel+bounces-138713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FD689F9A6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C63E2B31A34
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF81178CF4;
	Wed, 10 Apr 2024 14:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BGd3q1gL"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E544416E878
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 14:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757727; cv=none; b=VsxU3K4feL3iEVgyskOtRV5ncaFi+pk/H1Hft6q9qvzJdMXOIgy6xBM0p6Eenm5AJygyLohKnsNkObONto54HW6SBB6WZdq53xRjE/1sAZbZH1ayQ1WKCUHoWRb2JuuJAw302mITDAYmonQi7pCxQxNQCeDfUNOEI68eKsY8Bf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757727; c=relaxed/simple;
	bh=KvnLaO2vh9JKCCC44F3x8MRuznqiG8mlc5GYk8UjGJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WPmgF7nAQA87E6PRWRR5bPUvU2pPQH4eP4W2Ra+B7phaDjJP/8ynk7d++sTpiVEyBIN8XY4oZOBXP39J0Ee+H+A1aEFGKvuKgGBJIrs4Y3zVtTSZqMMeeGY8jjMsJiOG19yqq57dp5AckOVLawKuk2LuotaZwOSEOvIN3+8GSn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BGd3q1gL; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d895138d0eso28892881fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 07:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712757724; x=1713362524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U2BLuV2TaoJubB+i1BbXKPJs9YF+spnADheAPSMmIQo=;
        b=BGd3q1gL58C1Sgbyp8sRkLt5rnoS1GJiDbAQ2zMUHqTxTl5gzvv8gDGrVGCCLR/fz4
         NxwjQ0FELDcbIkCpyACsY3afM3J5vkHccw9k4Ja3j9Gp7fni4yPrHMXwrw13Yyk4UzyB
         VhpS5zW8flhsDRzV0CO12pkHBb+YUyBocd+VHS5TsvScmv17M2ms5spW0zLH+jFf4BOS
         o7iy+JRUDv6DuUBfUSYr8cP/R8UzOKoBnkREoUQipVpbFOmSfMwzcoAUgPiVcGCZKwLQ
         ZBSo001KQFaoWGYBvvkTO2FgAVE3Iu++k+wsZ6CqMtaYLiMY2/o8BhomTHFWnBPfb3rO
         duhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712757724; x=1713362524;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U2BLuV2TaoJubB+i1BbXKPJs9YF+spnADheAPSMmIQo=;
        b=l8ZWEJWe1mcE5T3aDVME/dr/RpKtAtRnrpG2B4GIZRJAgFAGdcSNF9TzeSnHyyI3Sg
         aTnBj2nU9+RwitnX9sciSF8J52cO53k1c/whlw+Zti6ADn+sktHnO/20AYjk7r56Z2XN
         2hbCIa/SBWGt0RcrwvqenzrOJ2Dzb2Ci9myT2ZYHpKFqS2R8qvQnO4t2db83bb+Lm326
         C9YorusN1joXjlOruiVpJ9hIWlpxg8xxWkf0oCtzrIg8maDHZFmXbifENPdO+HRcwDw6
         uBhEugelGDJcqzuWc+piYOgDvl4kT2sjuZHZSzOCNU7LkutvNN4j79qUZeWdNNkzpFMv
         qmQg==
X-Forwarded-Encrypted: i=1; AJvYcCV1NH5LVG194y8YfoYo8+hp3wSckwe5Ceo0OxbZ/z7wNu0TNGLfuF1v6jIaviN31uQINlyeL7lvllgSZ+Nsc/q1iU8IP/W9b7gcLS90
X-Gm-Message-State: AOJu0YyNV9PNDYUNYFXaDqkOaWuYabGT1A1pV3sjdK6wI9TTk+RIziUR
	uI8yInY/i4sNhYWwei84IMNekZQOcq4L7t5OWGLSklKi7hcrzlVnLSRthG5tbno=
X-Google-Smtp-Source: AGHT+IHDued1BgxOQepma0f2LhqTqT7GeyNGendravbhe/f3zWxtfonddLPg0YjH5l/Vd7JY0K220Q==
X-Received: by 2002:a05:651c:19a9:b0:2d8:3fc1:3b20 with SMTP id bx41-20020a05651c19a900b002d83fc13b20mr2155380ljb.31.1712757723799;
        Wed, 10 Apr 2024 07:02:03 -0700 (PDT)
Received: from [192.168.1.70] ([84.102.31.74])
        by smtp.gmail.com with ESMTPSA id g8-20020a05600c310800b00416a6340025sm2350977wmo.6.2024.04.10.07.02.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 07:02:03 -0700 (PDT)
Message-ID: <9cb903df-3e83-409a-aa4b-218742804cc6@baylibre.com>
Date: Wed, 10 Apr 2024 16:02:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 3/3] net: ethernet: ti: am65-cpsw: Add minimal
 XDP support
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Ratheesh Kannoth <rkannoth@marvell.com>,
 Naveen Mamindlapalli <naveenm@marvell.com>, danishanwar@ti.com,
 yuehaibing@huawei.com, rogerq@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
References: <20240223-am65-cpsw-xdp-basic-v8-0-f3421b58da09@baylibre.com>
 <20240223-am65-cpsw-xdp-basic-v8-3-f3421b58da09@baylibre.com>
 <20240409174928.58a7c3f0@kernel.org>
Content-Language: en-US
From: Julien Panis <jpanis@baylibre.com>
In-Reply-To: <20240409174928.58a7c3f0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/10/24 02:49, Jakub Kicinski wrote:
> On Mon, 08 Apr 2024 11:38:04 +0200 Julien Panis wrote:
>> +static struct sk_buff *am65_cpsw_alloc_skb(struct am65_cpsw_rx_chn *rx_chn,
>> +					   struct net_device *ndev,
>> +					   unsigned int len,
>> +					   int desc_idx,
>> +					   bool allow_direct)
>> +{
>> +	struct sk_buff *skb;
>> +	struct page *page;
>> +
>> +	page = page_pool_dev_alloc_pages(rx_chn->page_pool);
>> +	if (unlikely(!page))
>> +		return NULL;
>> +
>> +	len += AM65_CPSW_HEADROOM;
>> +
>> +	skb = build_skb(page_address(page), len);
> You shouldn't build the skb upfront any more. Give the page to the HW,
> once HW sends you a completion - build the skbs. If build fails
> (allocation failure) just give the page back to HW. If it succeeds,
> however, you'll get a skb which is far more likely to be cache hot.

Not sure I get this point.

"Give the page to the HW" = Do you mean that I should dma_map_single()
a full page (|PAGE_SIZE|) in am65_cpsw_nuss_rx_push() ?


>
>> +	if (unlikely(!skb)) {
>> +		page_pool_put_full_page(rx_chn->page_pool, page, allow_direct);
>> +		rx_chn->pages[desc_idx] = NULL;
>> +		return NULL;
>> +	}



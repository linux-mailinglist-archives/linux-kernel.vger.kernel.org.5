Return-Path: <linux-kernel+bounces-142777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7474D8A2FFE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14AD11F22D1B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2850A8613B;
	Fri, 12 Apr 2024 13:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Jye/Sqvd"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFF48564A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 13:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712930206; cv=none; b=F3iO9yRXlWgsX4gDqM+8gfH72wiCct6Q5fqiakUIy+AjhRwsX9aMWGCeODvXfZ/a8eaqAStERaI8YWGqtCc4ZQX78SZTkKn5sf2PTS8b9KpZmHShX7XfVFnZcr4WPLEiUdp02/1/eDkx+HiuVqHPETQXxSJOyqinM9RcwU7Tl1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712930206; c=relaxed/simple;
	bh=zrjbXKaxgzuudx1KFjcy8ipDh+5BgoB+83OYFc6KOZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VmzM07M94Cjl+IxUdK9EY3T2Emp3BgZwIgUR7acFS3KpLoo+fIcWqX506CyTpdfMIrsZrpC5z8SKZqmjCCzFOgTSiSlMuis9URoZm3R3yvSHx1A8inNdoJDjeg1z0QNItqKDC5+eI/tPApDOrKpCS0zIjGgyabcUoZlSGklOEvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Jye/Sqvd; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-417d0194705so6575035e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 06:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712930203; x=1713535003; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zrjbXKaxgzuudx1KFjcy8ipDh+5BgoB+83OYFc6KOZE=;
        b=Jye/SqvdAti8lJ8hWIPIoz2IREEZww2n7o2Z3kp6pRt4krKrewvtwvkpmELg7xGel8
         z+uZIHVPgjVoanuC67ajSp7XNB1MOh2HCZiP5d2sg3FUvP+k0aaSU5/Fi/u29SRY98sY
         1nskMf/4VM97FDThILM0VIAsJ6xGhptwgu/ZHkmXv9W6domv9XfNNULpHe2gGkfrhU9T
         A3pJfOM+Awb87wNDVB0Q37OYe30/Orxrnf+0uYrgfP6QMKyFYH3tWzWlXTq0ASyQLq1i
         oV+eYYK+bzmux97Co4a5Lucc1Qh/TMfENF23ma9yiI08AChUd2vs1KM9mnD7MG8yxH/0
         sLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712930203; x=1713535003;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zrjbXKaxgzuudx1KFjcy8ipDh+5BgoB+83OYFc6KOZE=;
        b=oB9NsGOXHP5K9OdaCThTc7sR91p0+33eJeJ4KoJ52ra/ZAJ7TjXi5HfNTmVRBPNq/v
         F7EegDsVaL9oWpjXr6n40PpA1doFx6aHQTjZBd6P+enqESIaR6E/axlzUnh+kL7bphtV
         JGckyG3JaGn9CIcbY1N0781g7RrCY5G0tJFgI4NQbKeLzwhSPdVkqTotCkb0ExcGas3C
         Li0yveQMyh1hnF1tFevv2tucX1Ixf4fBOmhu5KCvyl/dhNgjS75TBCTfbm+p5uFsbT3v
         epakU3rVwLZ7MvE415iBs3KZ0HxVH2T8sGEHiH4roVSSkDrgoAqZerFaSUdPXXnMFwwo
         j0sw==
X-Forwarded-Encrypted: i=1; AJvYcCWa0J7egAaATeucpBTogMLA4l7eYb8fIXLySfSWaf4rKzfQH4xjg1UVpEUK/VEZDhc1Ns2XXEsEn/lvtwjFOD1twvLjPeuqxi51JGYS
X-Gm-Message-State: AOJu0YzLtKQJo7ewOiVM9T6aWOGuuRJes0KpENxhNBDbXOXbRW3iKEWf
	JEchR5ZdQstwcOhQTccMW0GjTTfLWExABqrISZKNn97Q+O1OK+PPjpcoSEFvz6Y=
X-Google-Smtp-Source: AGHT+IE1aY0YK7X0UJIUMl5mWoMpDtrMWQ0+qMn5m3POIXuadH+CZf6hfbFKu6ceJnAKhtbnKRpYGQ==
X-Received: by 2002:a05:600c:3d0f:b0:417:e6e6:a314 with SMTP id bh15-20020a05600c3d0f00b00417e6e6a314mr2197591wmb.14.1712930202832;
        Fri, 12 Apr 2024 06:56:42 -0700 (PDT)
Received: from [192.168.1.70] ([84.102.31.74])
        by smtp.gmail.com with ESMTPSA id p19-20020a05600c1d9300b00417fd9c2d01sm2183249wms.3.2024.04.12.06.56.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 06:56:42 -0700 (PDT)
Message-ID: <16790d82-e134-4a3b-b67e-d56c041362c0@baylibre.com>
Date: Fri, 12 Apr 2024 15:56:39 +0200
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
 <9cb903df-3e83-409a-aa4b-218742804cc6@baylibre.com>
 <20240410080225.2e024f7c@kernel.org>
Content-Language: en-US
From: Julien Panis <jpanis@baylibre.com>
In-Reply-To: <20240410080225.2e024f7c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/10/24 17:02, Jakub Kicinski wrote:
> On Wed, 10 Apr 2024 16:02:00 +0200 Julien Panis wrote:
>>> You shouldn't build the skb upfront any more. Give the page to the HW,
>>> once HW sends you a completion - build the skbs. If build fails
>>> (allocation failure) just give the page back to HW. If it succeeds,
>>> however, you'll get a skb which is far more likely to be cache hot.
>> Not sure I get this point.
>>
>> "Give the page to the HW" = Do you mean that I should dma_map_single()
>> a full page (|PAGE_SIZE|) in am65_cpsw_nuss_rx_push() ?
> Yes, I think so. I think that's what you effectively do now anyway,
> you just limit the len and wrap it in an skb. But
> am65_cpsw_nuss_rx_push() will effectively get that page back from
> skb->data and map it.

That's much better indeed, with the implementation you suggest: 600 Mbits/sec
instead of 500. I did not expect such improvement.
I'll send a new version when I finish retesting.



Return-Path: <linux-kernel+bounces-92176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F6A871C51
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 792D81F255CB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4B457326;
	Tue,  5 Mar 2024 10:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1TKr1Kug"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD74D11198
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 10:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709635567; cv=none; b=AquPlPmLcCNrR1QRP/ZcfYALR84lsKFlxm7OkrWCWJZa5I/6LdXlEN/SKWSiNR3AU2+TcFlAosa+dpvMEF5a/DoulwpQpOE8w+QcFnY4EnnUm0RYuxDiLemLrxLkJXpnEkD9NbalHW0Zo2AkRg7Fwb/8glMsjgkyDsFnU4pFBHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709635567; c=relaxed/simple;
	bh=XklbFoUwOSii+y74bxc36aiADpTAj4ZlGh81v8WRHIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZTs9ITIABZthauu1BY5kE+xgQ92i0up9hk+iZcWEBRagTZqOJ8Ziq5w9KZPQvITcvjo5qExBomsbpBPSIN4m59hq6014Jj3E8ov15lcbmpVNHi5j7dbZqkXrF43PavtEJVmCrbNsE80eX0veCEViHKYIr7sVlUdN7JEjA6i+dzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1TKr1Kug; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33d146737e6so4233312f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 02:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709635563; x=1710240363; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JVA1JqDTMPvckuRaTHq5sqq6pnFxGrbQ8TF6seYnelo=;
        b=1TKr1KugBceesEMwMGGzcf/55Y5czeuKgOSW8hUF2A4z7TvXPZbUOYgeR1XgC1W/Xg
         fKqN5vLnGGhZQyCuRQJSNo5wDVwWgzN+wl/3+IgVxcE/a9NgkVomCTb26LqDu5keSi2p
         ADFNs7kMiKQom8xrncsefJ69WNlttJumkg5B3ok8fALTscJr7sHXGdRQIWawG8CKkn8v
         8NBwMQPflifIgKMGDtNLbRnndmhwfDKlJ5sP7q99z8un65B8i2ph7TBDP4NDHH1zoqVO
         hew7XKZ4Y74A56I0i3IaOqyfe6sQq/8lYaTAN1cPZ9s5xelmmU2PJgnuMZtXFOwWpdM3
         gOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709635563; x=1710240363;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JVA1JqDTMPvckuRaTHq5sqq6pnFxGrbQ8TF6seYnelo=;
        b=BGjQ2VTTHJiY8+uh5CMgMjKk0wNrXbLcyS6Q+iqKu92o0AJoD/YC0uwMyiYFmzXOlE
         LM8eN9YkYqpJ82TmpUTVuzaUE5v6tqnmloRmhAvIMPK0rvKmhsTiwCgytlsOhtnGwsLS
         jrnlBjlhEQxMn/oexLBU5nBI/pszj0fINsV04TymWI0EbxEEjsyePXJ3PcFmAez9/96O
         F10vgw0L92ZL8VW1DZJs3caTZ6w9BRAZJhlG0bD5JCyz19whFVeOEUuy0qwEDfvPT/+3
         iXYr4OTOwa43nDVexqpN7515OI7v23WoVilQ1WXzzVcAmcXLKB49i5knMPERuH9epnMi
         V2PA==
X-Forwarded-Encrypted: i=1; AJvYcCUVqFrVtmzCmJuf2EKNhQyTcWrs7i7BLfTyrbWqZ2RemfKgZ+KdboqIAI7y1pLn+klSiA4J27KAArrFSTvuNJYbN/FhFSJfvYFG6MiB
X-Gm-Message-State: AOJu0Yy0zt3vdtBSr56ZQNxO+q7fPFUfg0sJB9ZbmZxo71PtqzNhEyEL
	3uaZ2K70t+vnnYt84xcvr+q6gj9BKDUR0KPo8ex6AOCaZ8UizEwMMTox9Zvyi0M=
X-Google-Smtp-Source: AGHT+IE/L4A6bnauZ4LpcW6naeeYuRNA8WEWJrlnt645s9ZaWVjgn/tE11DGJ0F5XhXa7k+kx2lEzw==
X-Received: by 2002:a05:6000:1249:b0:33d:2226:a28b with SMTP id j9-20020a056000124900b0033d2226a28bmr7827513wrx.37.1709635563236;
        Tue, 05 Mar 2024 02:46:03 -0800 (PST)
Received: from [192.168.1.70] ([84.102.31.43])
        by smtp.gmail.com with ESMTPSA id d15-20020a5d644f000000b0033e052be14fsm14577187wrw.98.2024.03.05.02.46.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 02:46:02 -0800 (PST)
Message-ID: <3a5f3950-e47f-409a-b881-0c8545778b91@baylibre.com>
Date: Tue, 5 Mar 2024 11:46:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] net: ethernet: ti: am65-cpsw: Add minimal XDP
 support
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
References: <20240223-am65-cpsw-xdp-basic-v2-0-01c6caacabb6@baylibre.com>
 <20240223-am65-cpsw-xdp-basic-v2-2-01c6caacabb6@baylibre.com>
 <356f4dd4-eb0e-49fa-a9eb-4dffbe5c7e7c@lunn.ch>
From: Julien Panis <jpanis@baylibre.com>
In-Reply-To: <356f4dd4-eb0e-49fa-a9eb-4dffbe5c7e7c@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/1/24 17:38, Andrew Lunn wrote:
> On Fri, Mar 01, 2024 at 04:02:53PM +0100, Julien Panis wrote:
>> This patch adds XDP (eXpress Data Path) support to TI AM65 CPSW
>> Ethernet driver. The following features are implemented:
>> - NETDEV_XDP_ACT_BASIC (XDP_PASS, XDP_TX, XDP_DROP, XDP_ABORTED)
>> - NETDEV_XDP_ACT_REDIRECT (XDP_REDIRECT)
>> - NETDEV_XDP_ACT_NDO_XMIT (ndo_xdp_xmit callback)
>>
>> The page pool memory model is used to get better performance.
> Do you have any benchmark numbers? It should help with none XDP
> traffic as well. So maybe iperf numbers before and after?
>
> 	Andrew

Argh...Houston, we have a problem. I checked my v3, which is ready for
submission, with iperf3:
1) Before = without page pool -> 500 MBits/sec
2) After = with page pool -> 442 MBits/sec
-> ~ 10% worse with page pool here.

Unless the difference is not due to page pool. Maybe there's something else
which is not good in my patch. I'm going to send the v3 which uses page pool,
hopefully someone will find out something suspicious. Meanwhile, I'll carry on
investigating: I'll check the results with my patch, by removing only the using of
page pool.

Julien





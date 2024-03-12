Return-Path: <linux-kernel+bounces-100121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0CD879206
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE8371F23561
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F6478B7B;
	Tue, 12 Mar 2024 10:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="C8t6XGs3"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBF433994
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 10:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710239345; cv=none; b=ap6F0GbRu1AjoqzZ+34VuAJX4iZFe7Ja08PRIHG2YUXJ0h+OAxrmJus19SM0iOk9f1+r6MvQCNdlGYyI7cPAAf5vNxmOiczWwO2aY9pkWUm+z4j+AvJJYHfYZYH4QCwGrCNpJvWgH8EZwQ0w8JsoUP0plYMYzDZQm1/laDL3F30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710239345; c=relaxed/simple;
	bh=JLDcBgW+3vtGMYoTcRPuT4brcDBaHRWE2L0AAL86eQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iqq1wkXiAdEk/lbL7KU2L2iNflOk6Tc1elEPzrWXXxKNwWouM7iMVkNJ15qaPAxTmznP9WDotnjKfQGCacjRVHIbi7wI6kACIPQPGJtx1IK+TcCIPLtvefntaM+sJ5L/HQSpNix4rR4vS40nK2DLa9tWS30factkgJUVxIrG/U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=C8t6XGs3; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41333bb74f2so2815825e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 03:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710239342; x=1710844142; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5d4B/pAoZQB5tS1BWWn28qe/xI29Jo7qr/wZ2JnyTFg=;
        b=C8t6XGs3CoziosSQAiUwj0PiG6auvS5pl2sHBvguqIx7BvfhSiXEkr5iGwblD1+IHd
         sueCvPQFHklTGp7t+V6MbMQrv/XMaBhmXa0+lpZrr8Yri/yyrhgWN+B2lIuc5PxYoKnI
         QktorKAQXEAclLo4ITnG0tIvbwzsQeisSF02kPnKGbLphmWTtbhDQZh/EeWbfRzs7Wlv
         eJaS3pyXWeOIb++WEp9JS0MECQfIYSQggHZ50kgG9KtA5PTMQ9Xuiybam2jZ6QLyvH4n
         9us7luNsZ58t0s057CHyIM+dOHbR7kov5mjNT9j7zSasF8SvtUAEsa/FVw0mgOiKezKC
         Ut8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710239342; x=1710844142;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5d4B/pAoZQB5tS1BWWn28qe/xI29Jo7qr/wZ2JnyTFg=;
        b=v4JHHVCCSeWBybjNCRseF/Dh9od5teEAZ0p/gUTd9EYckLzWnKJgUqg00TSHbaAaD/
         h2YwYd1nPDrSjkANhXh2xxag3w5BGkqOLknaVZIHULOxvJ/7Rg9On9RxdvulJVzznJbf
         JTCHzchrCLGSPITvszhP4WK2OuHY1MU+yL2pHfRZhayUpk9Vl0odCgP5vnrQ2bqyRpHO
         yrgdcNH/WGxcTZqm/PkPny34PgA2rJ4iBqh/B0819TcCbzJwclZmOpDRZMaxlxcC/8jk
         vTC9Mg8KGuoT+q2W/EpoBTqG3AHfTMp/ewIXnhotd+5U5qoigSroQfI2hUdf4QTKqb9D
         RZgA==
X-Forwarded-Encrypted: i=1; AJvYcCUE2HTnyCQBLdeDauGOXDihvaRlFbO8M34ttOd3mGeQkeDivQnVNvulC3z+to5R9SEWxyifD/hgMlHoNl5retjPm5CvZfaPZwnlq9zE
X-Gm-Message-State: AOJu0YyuVslY60GXJFdOm38bSsTYiFE6ZMqVRf2t8QLUjj0sYTlIqy+i
	UVAIiSEPJUlxLvpH4JsskF9qEIvqbCPD7UT8DVRu33qzb26v/iK8KEWvlOTyvgQ=
X-Google-Smtp-Source: AGHT+IEtUTnilAGbJcn+GRXMX4RNIS078U7C8s6e6rzHKdm5WSpVA53oIuu5hDIUApB8xtk4QdMhSg==
X-Received: by 2002:a05:600c:5101:b0:413:2966:4bfb with SMTP id o1-20020a05600c510100b0041329664bfbmr4277240wms.1.1710239341697;
        Tue, 12 Mar 2024 03:29:01 -0700 (PDT)
Received: from [10.3.5.130] (laubervilliers-657-1-248-155.w90-24.abo.wanadoo.fr. [90.24.137.155])
        by smtp.gmail.com with ESMTPSA id z11-20020a05600c0a0b00b00412f428aedasm18656971wmp.46.2024.03.12.03.29.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 03:29:01 -0700 (PDT)
Message-ID: <88856abb-f5f8-4dbf-9b26-30915bfaee7a@baylibre.com>
Date: Tue, 12 Mar 2024 11:28:59 +0100
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
 <3a5f3950-e47f-409a-b881-0c8545778b91@baylibre.com>
 <be16d069-062e-489d-b8e9-19ef3ef90029@lunn.ch>
 <f0a9524a-08cd-4ec2-89f8-4dff9dd3e09e@baylibre.com>
 <ff4ba8c9-8a34-41c3-92ed-910e46e1ca99@lunn.ch>
From: Julien Panis <jpanis@baylibre.com>
In-Reply-To: <ff4ba8c9-8a34-41c3-92ed-910e46e1ca99@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/5/24 17:43, Andrew Lunn wrote:
>> 3) From 2), am65_cpsw_alloc_skb() function removed and replaced by
>> netdev_alloc_skb_ip_align(), as used by the driver before -> res = 506
>> Conclusion: Here is where the loss comes from.
>> IOW, My am65_cpsw_alloc_skb() function is not good.
>>
>> Initially, I mainly created this 'custom' am65_cpsw_alloc_skb() function
>> because I thought that none of XDP memory models could be used along
>> with netdev_alloc_skb_ip_align() function. Was I wrong ?
>> By creating this custom am65_cpsw_alloc_skb(), I also wanted to handle
>> the way headroom is reserved differently.
> What is special about your device? Why would
> netdev_alloc_skb_ip_align() not work?
>
> 	Andrew

Nothing special about my device, I just misunderstood.

Regarding page pool, I now have better performance.
Two things were missing:
- I did not call skb_mark_for_recycle(), so pages were freed instead of
being recycled !
- In page_pool_params, that's better when I specify the "napi" parameter.

Performance improvement is not that impressive, but it's better:
505 Mbits/sec (with page pool) instead of 495 Mbits/sec (without).
There is a ~ 5 Mbits/sec loss due to additional processing in the path, for XDP stuffs.
So, the difference in favor of page pool using is ~ 15 Mbits/sec.

I'll send a v4 soon.

Julien



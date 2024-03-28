Return-Path: <linux-kernel+bounces-122892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B96388FF14
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B28881C244F5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BA57EF1D;
	Thu, 28 Mar 2024 12:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NSyWSFj6"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECF143ABE
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 12:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711629265; cv=none; b=DCIzaRnLsfCRC4gYfuutCDS/l0GeeQ0eRG/PDXR9t6oRR8arfayg3bsesu8ys8mqMcsp0NL8SlHCw4jG3SbbimrbC/VOjOFmw821cY+yt6C3j0yu4Ibn9qJ+MfolxzY4GX100uFdmF8mlGqdoGI19umIH5HK8uyH8gCf/ZolxpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711629265; c=relaxed/simple;
	bh=zX2GWYXPtC7qjhq9kFDCMg3asCTHBNFGRevEEyfJ4pU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hcxs8Lx9D+qO7JMtb8LkBxva100kEIiDBIEJIeZZryvy7XRYMN+PndetThFP5gMdCmx1fr+x69pMVEI3xLfcMlB5g9uNYPV1A/3aDOwbidgUs8EMi7VC/vLdbMQEEuc4jdAI7wiCb5UXRes0IQVstr+D8OGeHl14xvuSOlgGW/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NSyWSFj6; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41493e0fbf2so6229535e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 05:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711629262; x=1712234062; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qWn4vKf6jmo6u/KAkidvDYA7hMTdnPHRFemGgPWSlIk=;
        b=NSyWSFj68eR8wToM0XskqZHMJ29ZmkRU/fJ+NFfAUHhG0HmaKu0bBTvq4QkfzMGjmH
         jUAEtrsdZFPxsSvlIAdvu4Dw2VNqcrSAaVGTmQf7otdSslwPlTAOxxHk4+wM/q7R5jYd
         KSY+/dmahb4erl5kG39qfc7NCHptH8BslDFoGHXL7NCC9zHoBtIB11axS9h9RaBGx97k
         X5oms86dove+9KITXsvdyYjeGMDys13gA0NLPZC1fuxEtRywv1WlTYQ9f1OtasQZgD7w
         X4XnDgNPOs93OKplHCkWKCufTJoFx/W5yj33Q4qbIkk5yI24Ti8upUn+0ni+haAdNNHu
         PtDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711629262; x=1712234062;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qWn4vKf6jmo6u/KAkidvDYA7hMTdnPHRFemGgPWSlIk=;
        b=cH/8kydoQyTPdvx+TI6NijnntrR5cFYiREIWlYIJpfbWxXJtXBFAcwSewIUsvLBv3z
         sqpBkjCKlzr8d5iaTBl8sBIAP5HU9640oYth+x1VZWTRXYyh8Q9nEO7m7MfOpWwfpRCM
         u80FlDYgQdfITmF2IdXd+NvRQBG2i2ahgimS/T+L6NpqiUhHR7OMjto1SsyfeIC4mGct
         3KYnrM/0V6x4lxoFtLZVaHFxvAlTQUGCkI1MIWsE0139nrGz4Z7cZKeHfX5rkfPAD9yE
         pgi+fWqgJJ2+wUJJsvcyRxIb6DbABdILrSmIWqb1vVfhlnNX5+8EqD/b0/nL7yIYi9uT
         FWlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDTWBN6woVsl8HKaVWERHIh3I+DrRTtlD03OSc2aF5R+ENz1vPj4HJ9P+Y3FUKTh+AGtbPZH7+10qmgYMVxJYua3dvymDVXXjOKMZv
X-Gm-Message-State: AOJu0YzYYerGkiRMLWEOdiRcqVRc7cXtep615S8ccPSg2ScWFwMOzmER
	y1EOGehR5U2Apsr8okRrlrOxQkYdKe06arDgv8pE2Yyt1Sb3VdP0i090MCScQp4=
X-Google-Smtp-Source: AGHT+IFLB/cUHJWkbnWrK10eduOa8rRtXuIj5s2I8YXRQ+IvMFyMnMJuaj5WaCt6J4TWoyPiuBZHlA==
X-Received: by 2002:a05:600c:45ca:b0:414:8948:621c with SMTP id s10-20020a05600c45ca00b004148948621cmr2473201wmo.8.1711629262250;
        Thu, 28 Mar 2024 05:34:22 -0700 (PDT)
Received: from [10.1.5.112] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id fc9-20020a05600c524900b004154399fbd9sm2287689wmb.45.2024.03.28.05.34.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 05:34:22 -0700 (PDT)
Message-ID: <34f9a771-08dd-4db6-9790-cc5f70f707c7@baylibre.com>
Date: Thu, 28 Mar 2024 13:34:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 3/3] net: ethernet: ti: am65-cpsw: Add minimal
 XDP support
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
References: <20240223-am65-cpsw-xdp-basic-v5-0-bc1739170bc6@baylibre.com>
 <20240223-am65-cpsw-xdp-basic-v5-3-bc1739170bc6@baylibre.com>
 <20240328114245.GA1560669@maili.marvell.com>
Content-Language: en-US
From: Julien Panis <jpanis@baylibre.com>
In-Reply-To: <20240328114245.GA1560669@maili.marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/28/24 12:42, Ratheesh Kannoth wrote:
> On 2024-03-28 at 14:56:42, Julien Panis (jpanis@baylibre.com) wrote:
>> This patch adds XDP (eXpress Data Path) support to TI AM65 CPSW
>> Ethernet driver. The following features are implemented:
>> - NETDEV_XDP_ACT_BASIC (XDP_PASS, XDP_TX, XDP_DROP, XDP_ABORTED)
>> - NETDEV_XDP_ACT_REDIRECT (XDP_REDIRECT)
>> - NETDEV_XDP_ACT_NDO_XMIT (ndo_xdp_xmit callback)
>>
>> The page pool memory model is used to get better performance.
>> Below are benchmark results obtained for the receiver with iperf3 default
>> parameters:
>> - Without page pool: 495 Mbits/sec
>> - With page pool: 505 Mbits/sec (actually 510 Mbits/sec, with a 5 Mbits/sec
>> loss due to extra processing in the hot path to handle XDP).
>>
>> Signed-off-by: Julien Panis <jpanis@baylibre.com>
>> ---

[...]

>> +static struct sk_buff *am65_cpsw_alloc_skb(struct am65_cpsw_rx_chn *rx_chn,
>> +					   struct net_device *ndev,
>> +					   unsigned int len,
>> +					   int desc_idx)
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
>> +	if (unlikely(!skb)) {
>> +		page_pool_put_full_page(rx_chn->page_pool, page, ndev);
> Is it compiling ? third argument should be a bool.

Thank you for the time you spent on this patch.

Yes, it is compiling.
This was intentional but it may be unclear indeed.
I'll make the bool using more explicit in next version.



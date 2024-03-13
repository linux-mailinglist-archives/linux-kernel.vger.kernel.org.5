Return-Path: <linux-kernel+bounces-101581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C0887A8FB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69A6EB238A0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CD54642A;
	Wed, 13 Mar 2024 14:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gG4CCw8F"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931B64502B
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 14:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710338623; cv=none; b=qiV/UgM5zXYatX9WEc7PluznS7LA8ma8kietxRwwBq9VLwqQmp0cN0Jgc/4Y53iBXlp9hhbEi7f5JNX3unWZLGkmyGN/ffXfxqisXbd/koPeuVxkhX1OailQpOzCAlTll/NtKPizvk/GBQAQrtBy8jOwYN03UbVIHX6rs5DC6qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710338623; c=relaxed/simple;
	bh=ubMufnhLcTOoAqfT9+1T3xyWYqQSUC7Sbpi7BUH1NZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eACK+BRES1CGIWMm0GjoyLgvgfAPt01ipJ4b75nCZ95yqoHtSKsbNVHPy1aL8XzxyCbhpKIyZKr+sls328RoF8oHvnbGy0YX/KvlxTy+rn4baOxlj7rNXhbG0U70K2RDr6yjqzO4Ga98ok/AxjH6oDfkfkIlfEPhLIlZOAXMe1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gG4CCw8F; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2218b571776so3690856fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 07:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710338619; x=1710943419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ubMufnhLcTOoAqfT9+1T3xyWYqQSUC7Sbpi7BUH1NZE=;
        b=gG4CCw8FT6odWTF1V1UnSDEfLAkd4DJvW+mUE/GvHWwAypkHsnKCh65BAHFp3BS6o4
         RRCrRMpsEkw/VFnaOmj+jNUxMdpve6rzgLD3ATRquJC5h0qs2kEkkBNF7N4I2yrGeYCk
         CotSByWO4bCWjJk3B5QljyPx0N9sLnJQmwIxSN1ub0BePNerVrwrSh5So5sbBcwgc3LC
         qvFg14zMd3hE0+F9vT3q6MoKQVZnUw1SRd/bMHgknMdw/H+vkIAIVL2WHQyK2bxrnd+h
         aiSYTNKVckV+HydotpSrlsCkpqg0gttkF1rR3knFlMY/TihuOSOE5Ybl0VqihhlBksDX
         daAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710338619; x=1710943419;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ubMufnhLcTOoAqfT9+1T3xyWYqQSUC7Sbpi7BUH1NZE=;
        b=jSykPfoh9mLiAaewxC6TonUFcOOFGoxs0s+ecFNihMMEf404vYWWrGAnyNW/Dezjgw
         XxccJzHba/lT5qHAbnCVQO+d+1WYLpgCJ+w6svnIeDrLt0zRZo7h+8QJiwrEVSg5Q3J9
         sXi8RCpNL+RWcZKQnfKeWEecqIrGiPtKcGiAqlLFx3eZnjzVXaQkiwilVgeFVm1S8MP8
         9dmZXKOTzJlhYjsmnS13VnPyDBLCZoHuivvFady5xBDFNp7yMI7n+hrfnh50aD1j6y/f
         3ssR1FQzIAMzJnxDyUCVkRAP3Tv12+51tEIFULN+W8b24j70+M1IXzKLhMrLH4ZJ4oyT
         UCJg==
X-Forwarded-Encrypted: i=1; AJvYcCV8WRnCffIrxbvd8jOMTYiBSmf+TKxMrjrNL26O8/OkpMqCckCB6n6kT8RcOyGVtORiFquWRBze3gqG8EBxBYbLwkr+PnEOLbCxXtnl
X-Gm-Message-State: AOJu0YwXdHxctCB6jMXb36r7Q0k1MPWgu5+XwfU4iJFf/BmbHEVC5vBx
	kIfYzRJbTq5LW4PwOR3mzIsbTephDW1cQlgowwnincPsOqAfwNx0/xTGYcMWmw0=
X-Google-Smtp-Source: AGHT+IEKcPIJIxJN3LZm3uy5vBq1aiBgTaIu0YfiiPG9DOTPOxQSlz/QEM8ItgImfrBXmN837WZOiw==
X-Received: by 2002:a05:6871:b0c:b0:221:1f78:566f with SMTP id fq12-20020a0568710b0c00b002211f78566fmr13760475oab.7.1710338619646;
        Wed, 13 Mar 2024 07:03:39 -0700 (PDT)
Received: from [192.168.1.70] ([84.102.31.243])
        by smtp.gmail.com with ESMTPSA id a16-20020a9d4710000000b006e540a9026fsm478137otf.48.2024.03.13.07.03.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 07:03:39 -0700 (PDT)
Message-ID: <9016930f-d90b-4a7a-b6fb-80cf56a94bd8@baylibre.com>
Date: Wed, 13 Mar 2024 15:03:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] Add minimal XDP support to TI AM65 CPSW Ethernet
 driver
Content-Language: en-US
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
References: <20240223-am65-cpsw-xdp-basic-v4-0-38361a63a48b@baylibre.com>
 <20240313134441.GA1263398@maili.marvell.com>
From: Julien Panis <jpanis@baylibre.com>
In-Reply-To: <20240313134441.GA1263398@maili.marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/13/24 14:44, Ratheesh Kannoth wrote:
> On 2024-03-12 at 18:52:39, Julien Panis (jpanis@baylibre.com) wrote:
>> This patch adds XDP support to TI AM65 CPSW Ethernet driver.
> is this a net-next item ?

Initially I worked on top of mainline kernel v6.8-rc1. Then, I also ensured that
the series could be applied on top of net-next/main.

>> The following features are implemented: NETDEV_XDP_ACT_BASIC,
>> NETDEV_XDP_ACT_REDIRECT, and NETDEV_XDP_ACT_NDO_XMIT.
>>
>> Zero-copy and non-linear XDP buffer supports are NOT implemented.
>>
>> Besides, the page pool memory model is used to get better performance.
>>
>> Signed-off-by: Julien Panis <jpanis@baylibre.com>




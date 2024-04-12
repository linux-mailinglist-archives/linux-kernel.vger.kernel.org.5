Return-Path: <linux-kernel+bounces-142784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD3C8A300D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 510D51C23919
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2B883CC8;
	Fri, 12 Apr 2024 14:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KjvAgDC/"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F244A83CDD
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 14:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712930500; cv=none; b=M/UNZt3l1Vb5MFQ4oSQHgv7Zlyo6Dhb6zePYlcwoZi5UIjP5fCIeBXUGaG3dHfEc9AFd/1uDyAqH+CaoS1HB4qW6OR0aj+vqq34ziYsBP8OfuDy95ACFRt4iFh2Nmv3WcSJDzm97OAIHcUwLTUDFxnO0zn0fv03vEIBNRlD6KWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712930500; c=relaxed/simple;
	bh=wM/qLHmObCPp0A36qPqz30NvxHM7nS4FGirrfQUSiU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=amrPRZfGRjLPmdPnbf7OCYuYbM9G0iYXKMT3Z4aNTeThNkU2yvbUkpD4U1FpoPgpRPn/dog7C0ZpP/wuLymamDvgM5xJjLbFhw1j54FNq6BMcNUVOeoriYe6i98v1qPAK9kwBKeDynyyu93FLqqEBv85V0+QkS1eosCox4yxBjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KjvAgDC/; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-516cbf3fe68so1157969e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 07:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712930494; x=1713535294; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wM/qLHmObCPp0A36qPqz30NvxHM7nS4FGirrfQUSiU8=;
        b=KjvAgDC/Vs14VfzWr/+5EXa+gZ1XehbDgAxVoHuDimFLCGf3QYzdDUx1GutjUqfN02
         nIGw6IibMrqmFZ3Jl8k1hal0h+b/Pykeo0ZEGzGXsj9HLdPX2jHUqa/QaNUUwyhTQ87k
         AgdY4AgA/oy1gLok9pK20N5abY4hjTsPd00BsaVFWemu3PuEzduqXOqbe/jZ5roIct0i
         IxzUh+inxq+M/hO8USWwafe0jS9/VBNXyn/bH9Dvqfxtynbx9U/KI2stXjBVwUUKkBTs
         xJH5mzL3nIHW6qL+fJ+cPldFlovgOmDX6PoBzjUDn+dAlwA9XBMhG03wZLdpXfKgXTyM
         MDFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712930494; x=1713535294;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wM/qLHmObCPp0A36qPqz30NvxHM7nS4FGirrfQUSiU8=;
        b=R5yQDjMfjL+XuqqJTVJ6h17uG/8xfS6v5J9A3wIKJU9BO2hq3MDniVWQUu4RoTuCwl
         22pPWm4/RDopW1VLQuNELk4FuCA16uGVNXAKMSnAzAGrpM9Bb3oAw3cYC7tFvwJo0/KR
         Cc70w5zPCOBxU9tjLk8gI4VSqOWYUC49i7DvAfZPiUx6OQJaCJgWbNq7WI7pL0R86Xv7
         BbEu3JJPMbtBY8uD7ot316ZjFlJ7IOK7nWzAgBGFjGMMBUBfDsBDjYCN0+qatEDPH3oj
         sKinbObTGU+SGJNnXUicz9jWPSl6uwtLeZ+EvQ0uepBV8qqOa9wCWacggl8b5Y9XnTUq
         WyKA==
X-Forwarded-Encrypted: i=1; AJvYcCXXNzrEqQLkxQzpRdURXbxZJ+Bb1RSO6DZCH8jG0EfXWDHNCbvTO9rW+/KLO6+USzQ0jnEXp/Xyi/6TakrighehQcH/ak5QnpS1R/00
X-Gm-Message-State: AOJu0YyT2NtSvcRdRCn2+mCZYqxBKSX3W8lehs/44XyCk0m4BkYib6jZ
	ZcdCetOOkDC9rS6MWv3TFJsJiQD1+mYNyT7t4kEmHaycERBC/itSF92Oymed/BE=
X-Google-Smtp-Source: AGHT+IEYkdfZvzjzQTuqNwyv3/1I2wTibAdy/3l+Tqdqfg9DbDMvxlxElX4Ty3O747WwsNgGkO2d6A==
X-Received: by 2002:ac2:44c7:0:b0:516:cc9f:f8a with SMTP id d7-20020ac244c7000000b00516cc9f0f8amr1646189lfm.66.1712930494023;
        Fri, 12 Apr 2024 07:01:34 -0700 (PDT)
Received: from [192.168.1.70] ([84.102.31.74])
        by smtp.gmail.com with ESMTPSA id u7-20020adfeb47000000b0033ec9ddc638sm4339471wrn.31.2024.04.12.07.01.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 07:01:33 -0700 (PDT)
Message-ID: <568a7740-ff47-49f0-978d-14cfe14f2b80@baylibre.com>
Date: Fri, 12 Apr 2024 16:01:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 0/3] Add minimal XDP support to TI AM65 CPSW
 Ethernet driver
To: Jacob Keller <jacob.e.keller@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Ratheesh Kannoth <rkannoth@marvell.com>,
 Naveen Mamindlapalli <naveenm@marvell.com>
Cc: danishanwar@ti.com, yuehaibing@huawei.com, rogerq@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
References: <20240223-am65-cpsw-xdp-basic-v8-0-f3421b58da09@baylibre.com>
 <e60c4a55-09bb-4bd7-a22c-9ab38bea174c@intel.com>
Content-Language: en-US
From: Julien Panis <jpanis@baylibre.com>
In-Reply-To: <e60c4a55-09bb-4bd7-a22c-9ab38bea174c@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/10/24 01:51, Jacob Keller wrote:
>
> On 4/8/2024 2:38 AM, Julien Panis wrote:
>> This patch adds XDP support to TI AM65 CPSW Ethernet driver.
>>
>> The following features are implemented: NETDEV_XDP_ACT_BASIC,
>> NETDEV_XDP_ACT_REDIRECT, and NETDEV_XDP_ACT_NDO_XMIT.
>>
>> Zero-copy and non-linear XDP buffer supports are NOT implemented.
>>
>> Besides, the page pool memory model is used to get better performance.
>>
>> Signed-off-by: Julien Panis <jpanis@baylibre.com>
>> ---
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Thank you for your review Jacob.
I'll add your 'Reviewed-by' tag for PATCH 1/3 in next version. Unfortunately,
I will not for PATCH 2/3 and 3/3 because there will be too many changes,
following Jakub's comments.



Return-Path: <linux-kernel+bounces-112312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F2D887837
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 12:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EFE42827A7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 11:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25AE171BF;
	Sat, 23 Mar 2024 11:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pv0E5G3G"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AE210A09;
	Sat, 23 Mar 2024 11:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711192552; cv=none; b=qUoKb4yf6BGgEpTEPeBPocdSi5Mm6is544fxJTIaay4/WPNDjG4SEvamcB3rez2bm6hy6yLCeF7IPh1FepzIIkcMzmQUdNwzrCYbW/jVHT+ceVcT7yVH9Ai2Y+0X0BjMO3qBUMhVT1IcT4ZIHdkcC2/SrRhyRZAZlAGO0gqeTv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711192552; c=relaxed/simple;
	bh=SlfV5cjWVUljAWJeGNtrtZpskLDnOC9WVz4+emkRHbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Td0y8p8N/5V6msWrACkajZmCXaTjjFNAnejNNe5Nw1wYWMRBV5ZDLYl+aCmE9DTgKQb12DU5Bmh9j5IUKiivX8X+hViVHbLVe3EPrdX84Lq4yxMFoguLVCtkbfxGvML++h4ZO7WQ51N+xybkfBRi+4I60Ejcdidi5jaxUCaCCxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pv0E5G3G; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-513cf9bacf1so3991748e87.0;
        Sat, 23 Mar 2024 04:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711192549; x=1711797349; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tGt+1+8Qbh/ugUeIyE1gvLzQWC5suhsgLzpxGXFTGCg=;
        b=Pv0E5G3G+oepuUFh4zIIfVEBukImzB6jb0id25yKcTfwxT+QEO8qbZcO48gX4xRpgY
         agF+Os+X7CAIdIZNBQ1henxt8KlsqcbAP8TtHpE6FQcCCgruTQCPZRAJeO9TSMVOW8gV
         sC715mxvst2yNNQXjA2EYLXrnspXNUJhpOQgkvBDazT0Mom+7P2HogBebBLg332Rtbwz
         yqKcSyQxnU4As2SBv2iXQJseOOIEMRxWPB3DPjXRlwAh613B8aBIdbX/PY4z1NTAY56N
         qasUQbYOBaLzwRISKpa8xYnK5l4oB4xtfh0KDuFBYj6H3//ZVyjibOrjOcgys8NntK/Q
         U/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711192549; x=1711797349;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tGt+1+8Qbh/ugUeIyE1gvLzQWC5suhsgLzpxGXFTGCg=;
        b=AEOi/y5Muftu6uXaytnhOgOIqbYBMpkL7uFY1XGkGRUP9lU192QiqJt+X6ukXyoP0O
         ElTg0hoe6LM3PgjNFP7Fw3sPWAtNgfBrIg7+/NL5rzrdzQnfIqEG+zyWU5JmNy2WIVDK
         d1IBkVXathOEOIZoINgUv1hY2mdOMvo+Hi2TxBWnL7ReWLmkM/u3y7ys+iJhUNMFApQy
         x61Vv2pTOHtOflAJsHqbmAJ44zEVqhdu9dUerumDErAi25RqDaooJniLHXuq44vwmjZB
         3YebOfN3gwZwoi3+6MxbKd4jYn7x3GLVFzUn4+E4hX/H+deudGT3fVuICuxxf+2gYRny
         UbxA==
X-Forwarded-Encrypted: i=1; AJvYcCXZemPVZJRA04stZu57NtbGyGa8h3RxyrjLXaZGJsFGyJtU6LIwKBEg2HMTa1To7pqsN7UK1aeKJqm6qbTZWKovrBTg6TLcSoBwvYCmBvhImt87Idum4kw+/kGgLNzwifcj5JEAmv9MRfKaVPnuaebi+rPTWijBKcUffuI51eVtUkMDo3M=
X-Gm-Message-State: AOJu0YzhxoBSLSPthbRrcRvX2HX9U7stQdM2e1oGs2Ez97JyccmkFWVT
	6Y4OEaHuvzZwlfYcN1pxsxU5jfv6AUrmjUfhiKqnFWftwlSleLs=
X-Google-Smtp-Source: AGHT+IGjVr55U4jHXGz6ZpweB8ZoYcMpl2oUuYMLI43fUq46mUuU2xCwzJ3sMXFuDeF2mrP7xizlAQ==
X-Received: by 2002:a19:8c19:0:b0:515:a25f:396f with SMTP id o25-20020a198c19000000b00515a25f396fmr883821lfd.36.1711192548444;
        Sat, 23 Mar 2024 04:15:48 -0700 (PDT)
Received: from ?IPV6:2a02:810b:f40:4600:fbb8:7547:139d:a40f? ([2a02:810b:f40:4600:fbb8:7547:139d:a40f])
        by smtp.gmail.com with ESMTPSA id cw10-20020a056000090a00b0033e7a102cfesm4222385wrb.64.2024.03.23.04.15.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Mar 2024 04:15:48 -0700 (PDT)
Message-ID: <63c6caac-536e-49e9-aad2-a0c1f8b783d8@gmail.com>
Date: Sat, 23 Mar 2024 12:15:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] dt-bindings: mfd: Add rk816 binding
Content-Language: en-US, de-DE
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Chris Zhong <zyw@rock-chips.com>,
 Zhang Qing <zhangqing@rock-chips.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Linus Walleij <linus.walleij@linaro.org>,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
References: <20240323085852.116756-1-knaerzche@gmail.com>
 <20240323085852.116756-2-knaerzche@gmail.com>
 <bfe79f3d-1615-45a4-81f7-7e30740308d7@linaro.org>
 <3c0d5aa2-55fb-4827-bcd4-256e6ae55ee9@gmail.com>
 <f892767c-7e01-4099-b674-0eca6edf7bba@linaro.org>
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <f892767c-7e01-4099-b674-0eca6edf7bba@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Am 23.03.24 um 12:02 schrieb Krzysztof Kozlowski:
> On 23/03/2024 11:56, Alex Bee wrote:
>> Hi Krzysztof,
>>
>> Am 23.03.24 um 11:32 schrieb Krzysztof Kozlowski:
>>> On 23/03/2024 09:58, Alex Bee wrote:
>>>> Add DT binding document for Rockchip's RK816 PMIC
>>>>
>>>> Signed-off-by: Alex Bee <knaerzche@gmail.com>
>>>> ---
>>>> changes since v1:
>>>>     - lowercase/hyphens for regulator node names
>>>>     - rename "-reg" to "-regulator" to make node names generic
>>> I don't understand why did you do it. I did not ask for it. If you want
>>> to rename, drop redundant regulator or reg suffix from node names.
>> You didn't ask for that, thats true.
>>
>> I did it regardless, since node names should be generic and the "-reg"
> device node names, here you do not have devices.
OK. I wasn't aware there's a difference between device nodes and 
devices. I'll drop the suffix from the regulators.
> You did not respond to rest of my comments, so I assume you agree 100%
> with them.

I do.

Alex.

>


Return-Path: <linux-kernel+bounces-156827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0988B08D3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1E5E283F55
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BCA15AD92;
	Wed, 24 Apr 2024 11:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="gvKW3VJF"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A7A15A49E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 11:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713959982; cv=none; b=ouGj6tBw5TVbwu7vU4AvgRQbHVYLvuzgf9C78UlkVCYZ9c8Bq7iSsm8NrkcLhqf85scNes2fEs4xjDtBiWMqPar6eJO3qWUEfjbDntq8v1WrhQ8z6a4bjc5ME8W3LrvLmOBHnLgZ2/5r5iGXpI8JV9+VVsXRkJQkCNp6xszOUbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713959982; c=relaxed/simple;
	bh=/97R6QIg34AwQeVF34CbTFga/OXPyR0JSnF2W1DuNMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B6aX58bD4enRu2sR17tLzo0sZb13iX61dpeOEaz6YDysEoYWgjTqT03GVYMxba0QyEl0PklNitpq4yHzYRCtcI5qGaIP6pOoU++JivsfTeWNAOTJZ35vJ1ZsTeyUK/spnofYt5bGGHoeBRwGXPJ4XbncXLlfnvzKA+/qBJBeLHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=gvKW3VJF; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e8bbcbc2b7so51968235ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 04:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1713959980; x=1714564780; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A5052Z6jLpMWL6uEOrZWPgMF67wALF8EuBjYHXYfOto=;
        b=gvKW3VJFBlAZj6IcaE3Uo2Pc9P7Wqx/V1Kxg89VMD7mzVnjjWtYf3E7oZGWYc8FU3e
         F/NZs2orjfgLQY2GWFSY7ODrAccAfTJBVhJYrXXGmlk9Zc5uccJ9IPdLYJwrRN79Im/U
         sPxFcPCywDA9gxSEy9hWfjhHHmL5ReQ4Voa4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713959980; x=1714564780;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A5052Z6jLpMWL6uEOrZWPgMF67wALF8EuBjYHXYfOto=;
        b=jualsOXsZcMyLdkICQDHtwhKE6/4jP/b7kPizxZprDayp3psaRveb11oBh59FZajF9
         dHcfR6VZNb3X9ijXZoll55wReHmEBva/hi5JaHazQFE1xbTIGaruKUoW5xIWCpE8OjWc
         AZeFyuTLqOdwed0hsTxVIIq6xl2iDLZmqfsSnJCbtiKDKXrEiVuYoDM94x715xUEvzwf
         9Hs69FMU1JYLKF0hEbZEgAEDxCx4jYEYjzHodmHB6Mc3Zy+xmey3SHK/3/rjdinKTiTJ
         R/T/SOUTabDs1VJGFJHl2BMMtPnDvmp5SoO0g/VTV9EFQ9K4xd/uARa9ThgjIoZpwksh
         CmBA==
X-Forwarded-Encrypted: i=1; AJvYcCUSK810cmCG77XiFIgsn9VU/973PrZRAmMR2cvatx+c1MEWA17vOTxNNQJsaxChYKatuZ7e7B0yoZezqks3tJYcqPDf62cNv+EdCItm
X-Gm-Message-State: AOJu0Yyh0Hm50KLvtSiQItKvmRN7yht273hwQrz3TVpUKGnEKWB93aPn
	5nKZuNGcBZ6bfiUN9tuNIKK6ZKRhD71hblOWxtU5EwFItleFW8FeDO29fQaq3g==
X-Google-Smtp-Source: AGHT+IFmdf+Gc+hmnEBImZPnmw5Z2cSjZpUVIvaJI84mAtrF1e03mwiYI7pASnI90qBpVQDshtHJuw==
X-Received: by 2002:a17:902:cf09:b0:1e4:a667:5528 with SMTP id i9-20020a170902cf0900b001e4a6675528mr3243172plg.3.1713959979732;
        Wed, 24 Apr 2024 04:59:39 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id o24-20020a170902779800b001e5119c0f9asm11756768pll.66.2024.04.24.04.59.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 04:59:39 -0700 (PDT)
Message-ID: <6433c145-a448-45dd-a982-8b5df0ca5c16@penguintechs.org>
Date: Wed, 24 Apr 2024 04:59:37 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: qca: set power_ctrl_enabled on NULL returned
 by gpiod_get_optional()
Content-Language: en-US
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Zijun Hu <quic_zijuhu@quicinc.com>, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240422130036.31856-1-brgl@bgdev.pl>
 <99242a7c-53bf-4227-9623-7bc092f564b3@penguintechs.org>
 <CAMRc=MepDwUbAKrWgm0CXKObqy8=igtug0QDgo-CgwxjZCAC2Q@mail.gmail.com>
 <06217256-8a13-4ebf-a282-9782a91793e4@penguintechs.org>
 <CAMRc=Mfwa2WSOLaUMaEM1czTcx31jynGqgxzLdCh7ROktQ_Vag@mail.gmail.com>
From: Wren Turkal <wt@penguintechs.org>
In-Reply-To: <CAMRc=Mfwa2WSOLaUMaEM1czTcx31jynGqgxzLdCh7ROktQ_Vag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/24/24 4:53 AM, Bartosz Golaszewski wrote:
> This must be your email client wrapping lines over a certain limit.
> Try and get the diff from lore[1], it should be fine.
> 
> Bart
> 
> [1]https://lore.kernel.org/lkml/CAMRc=MepDwUbAKrWgm0CXKObqy8=igtug0QDgo-CgwxjZCAC2Q@mail.gmail.com/

I don't think it's my client. The extra newlines are right there in the 
lore link.

Look at the line that starts with "@@". That line is wrapped. The 
following line ("serdev_device *serdev)") should be at the end of the 
previous line. The same thing happened on the second "@@" line as well.

wt
-- 
You're more amazing than you think!


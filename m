Return-Path: <linux-kernel+bounces-156790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A838B0833
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F63D287FDA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C7B15A4A2;
	Wed, 24 Apr 2024 11:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="Xi44prbF"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F6D15A480
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 11:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713957375; cv=none; b=nYcN7QjPEBluiEKpP5X0YNEH2KE7lDje57S/ieb3uWHx4J08Xmmgo7g+Pm/dQVlVsIKwD+HUoI48cqcW+eDmDCEHagdccfipJw3QWZ0Rcip8nCuuiNspvOIdHfrWRkV6Vtk2t0FD5wABnN8tHMOtAGmbi/VFtyzPsnIl0Z/0+rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713957375; c=relaxed/simple;
	bh=9XHCMO60oCNxGiy+aJY/UaGzplEcfyIlLZJ/a6H4YN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cwr4OnTLA2fjqTaS+pJODZt0tLEveNiOe6MuV69uBe09zGO7P8j47KHjSc+Kx0lUsBXaJLw19B0LIONlOteu1fJBs9lC/5EN9ij/uZb8oFBgB6C08JhbP4uuLabqZPX5gCyLwZDw46p4YzEyQQKZS93gy4R815jGrENH14pXDuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=Xi44prbF; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ecee1f325bso5505200b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 04:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1713957373; x=1714562173; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jZqKceRFYOcv5tkimj0+X+feVM7EViq3jSO9S9mspto=;
        b=Xi44prbFHKy+GTEHgCVbfuGU3E/PbxuMcpB57V/PcoSR+oMTEY366Q84BG2HGM+J07
         gIuZO02CGbQB6fqEJ7N0cNmf7FpYZDbk5O9peB/WIEstaX9n+fEa8wZNPu5q4b0xnAQF
         A0L84rbUAWT74gpTqLHF9MMn/JwsrzSGwPj98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713957373; x=1714562173;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jZqKceRFYOcv5tkimj0+X+feVM7EViq3jSO9S9mspto=;
        b=PmuZq3Q9gL/b0gyB9Rm8vgiLXLGTpYghllUfBicG7mO3glYHdqtI7nf2KEW0yj2VlF
         X3fsSRvBf9Vxtwhvuno1OZXht0mux+IJ370GC6G9+PctSWyW8BLLsmam1vwEr9WPAc7y
         1JwR9ugTXO2bG23sAXhwat+8Pn96RbvqxmrCcIOaaTXQn1n6nfffseIWdStkCCjJcWXz
         QlNAjloW8W4plweyeARlr/f/KSsSkglSx3q6fYWhkICB1I7cLYh1rlU4vRfeGTxmooeT
         Ye8CjUr1J8f3ZXfDkkVG/XJYbeiWLVjRfepuXulfBuZPUjDoXMK1oindQR/QtL8dRmeh
         S9WQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsn4kCGuykEk0w41aLay5QP9KjRkVM4RXqkKua+wjPLbQulNNekBR91wzs3DH1FmjvJqm3dM3mwG3oO8cVecFuM2+yFwGRcw3/hnLu
X-Gm-Message-State: AOJu0YzUj/cJ567eQJ84BQhh4LMs1kSp2gYR1MQYbQ84YZ9rZzHngLVD
	hR2T5iyypWwNkPIo51WakNOCC8bWh0P8QH2WYVLNtPQX993AX74nPh2QJzo+1g==
X-Google-Smtp-Source: AGHT+IGrEd3S6crIeK6r7Gp9adxGZnS0C7zjoRAQn5SAuUYk5YRuc5UPhbyXdjw5UaDq1xnx7S60+A==
X-Received: by 2002:a05:6a20:9756:b0:1a7:bc31:933b with SMTP id hs22-20020a056a20975600b001a7bc31933bmr2178455pzc.47.1713957372652;
        Wed, 24 Apr 2024 04:16:12 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id j22-20020a056a00235600b006ea7d877191sm11216997pfj.2.2024.04.24.04.16.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 04:16:11 -0700 (PDT)
Message-ID: <b982b73d-0540-409c-a6e2-0e03ecb11715@penguintechs.org>
Date: Wed, 24 Apr 2024 04:16:09 -0700
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
From: Wren Turkal <wt@penguintechs.org>
In-Reply-To: <CAMRc=MepDwUbAKrWgm0CXKObqy8=igtug0QDgo-CgwxjZCAC2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/24/24 2:04 AM, Bartosz Golaszewski wrote:
> On Wed, 24 Apr 2024 07:07:05 +0200, Wren Turkal<wt@penguintechs.org>  said:
>> On 4/22/24 6:00 AM, Bartosz Golaszewski wrote:
>>> From: Bartosz Golaszewski<bartosz.golaszewski@linaro.org>
>>>
>>> Any return value from gpiod_get_optional() other than a pointer to a
>>> GPIO descriptor or a NULL-pointer is an error and the driver should
>>> abort probing. That being said: commit 56d074d26c58 ("Bluetooth: hci_qca:
>>> don't use IS_ERR_OR_NULL() with gpiod_get_optional()") no longer sets
>>> power_ctrl_enabled on NULL-pointer returned by
>>> devm_gpiod_get_optional(). Restore this behavior but bail-out on errors.
>> Nack. This patch does fixes neither the disable/re-enable problem nor
>> the warm boot problem.
>>
>> Zijun replied to this patch also with what I think is the proper
>> reasoning for why it doesn't fix my setup.
>>
> Indeed, I only addressed a single issue here and not the code under the
> default: label of the switch case. Sorry.
> 
> Could you give the following diff a try?

I had a feeling that was what was going on. I'll give the patch a shot.

wt
-- 
You're more amazing than you think!


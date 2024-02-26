Return-Path: <linux-kernel+bounces-81349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F66867494
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B261A28632E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E443604BA;
	Mon, 26 Feb 2024 12:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NKfEe9PE"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1E1604BB
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 12:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708949858; cv=none; b=eNf+wxFBtbQ3L/xtp1nALU86sYjfaHFxQz3F5DLstgwfAj38QfmbdTiEJktrTKviwEv7CPQ8Uz/f8wh975PK+EDIP+yjkEOMQqMizkvipCaz6MNOe5KJYt/SUlw2WX5R7W/omFIe0oweGu4TNPPzTZs+RrmI+yFn655u0sqxAgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708949858; c=relaxed/simple;
	bh=OGa8p8GgC/sb7ZVi2Q9MDNE+Wiv/ZCXz/jfCrGqA2yI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pubA/4wYMFSfgxwvzMZEFPSMYv++SJnm1aKPv++PSDKMrJm701pdTVymn+Y0J+TZvu/Gb3u9GPAmdge3artJhVdZZXxckfsbtJfoC0Fm5GvhJjnT1+cxcJQy+fyg3pAufMBEpzxjo9zeKLgzWJUvbidxMaXIJYMOnc1uw+EStIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NKfEe9PE; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-412a5de8a06so4129775e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 04:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1708949851; x=1709554651; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cjYNEFjj+8Br1K/kWVmcw1ELzUHGJ7r8kZWsJb6hqRI=;
        b=NKfEe9PE+8DLfYH962wdrzgAynjfJzZR4bZvzvomOX1I0vEMXYYcGVHM3ZnYIvyyxF
         E7olb6ccQFbnKJ0g+C076g/FTjD7GjsgGexR0k0DSvD5VFbGPcdx9wyV3LQhtRx369CP
         DOwYAzgpGZ80gJLj6mmvJVkiQQFaBDCc8QVltCCh9vGwizwl5Vji3IXUF7eU2sXPCgv6
         hPswyDGHxWctKfargV7OX6j8PgjE7MA0nOUKuOjwLlZpiWk523PA/Rg67xUcsvKPsE7j
         8scMRJJ18R1c4qSX71mSfYIVprMOPVzycYEHCowU14AMOe4j04Ve1W9SfY8xZnm0VMvI
         F5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708949851; x=1709554651;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cjYNEFjj+8Br1K/kWVmcw1ELzUHGJ7r8kZWsJb6hqRI=;
        b=kRtqjscH0QHA7qBx/N3CebFcdkHOxXPyM0lI/2LzqGlr1PNelzgIPIGZo0xw0b3nwa
         k98z2wqtexsyK79Dl0DDdKicuC/E4YDGkaf1w4xDIdbUfgaxLFbfOZjtiYOyN+eRiVIM
         j3RrR/5Qu8pvLgXLY1bCTV39oJ1XcnBN+TJEOOFmVW7a/jAuF9rFv5h/z9fesg7Y3YKE
         VLWOMmQlwVMkv4gM6SMigCYePefDV4ciTfP4YBJSzyMRUwcGk3i3FNJka+OG2kW3fi9J
         aDVbx9jS/lnGjVkDpOZnBvEbnbryjXWcrovbRny8uTEGXRa5s56fkoSrhbSs6Xz5ZJgY
         mPLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxiKnmmqAsnHKD17/vbDyMXQNFIlr4yGgL+VQfFIPfq8lkbL30L9qYKBgQa880GGEcuowBcMWusXXPTDymLoPB7/SC0t287hi1vhc6
X-Gm-Message-State: AOJu0YzEoKiWw3Mexp7tJ9mEvkggNtVy5TDa+HFeRyeMXHPeyntYWGM7
	hnnNGJCospU8uSn7FTKxc6izOKvi+2e+7wUJdkEzcP/qG4hM5MYu0pSYgDo36fY=
X-Google-Smtp-Source: AGHT+IHk1FfpA2y4Z9oTsQIg5vqYkF8R+cidEV/qNA4rtoBDqquyDCAvUHa8PCJ/+wEXXwmQMEcg1A==
X-Received: by 2002:a05:6000:1841:b0:33d:2180:30da with SMTP id c1-20020a056000184100b0033d218030damr7107865wri.58.1708949851400;
        Mon, 26 Feb 2024 04:17:31 -0800 (PST)
Received: from [192.168.1.70] ([84.102.31.43])
        by smtp.gmail.com with ESMTPSA id bj20-20020a0560001e1400b0033db0c866f7sm8245904wrb.11.2024.02.26.04.17.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 04:17:31 -0800 (PST)
Message-ID: <45c31edd-45ea-4101-ae1d-5e0f95c88d20@baylibre.com>
Date: Mon, 26 Feb 2024 13:17:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/14] mfd: tps6594-core: Add TI TPS65224 PMIC core
Content-Language: en-US
To: Bhargav Raviprakash <bhargav.r@ltts.com>, linux-kernel@vger.kernel.org
Cc: m.nirmaladevi@ltts.com, lee@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
 lgirdwood@gmail.com, broonie@kernel.org, linus.walleij@linaro.org,
 linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com,
 vigneshr@ti.com, kristo@kernel.org
References: <20240223093701.66034-1-bhargav.r@ltts.com>
 <20240223093701.66034-8-bhargav.r@ltts.com>
From: Julien Panis <jpanis@baylibre.com>
In-Reply-To: <20240223093701.66034-8-bhargav.r@ltts.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/23/24 10:36, Bhargav Raviprakash wrote:
> Add functionality of the TPS65224 PMIC to the TPS6594 core driver. This
> includes adding IRQ resource, MFD cells, and device initialization for
> TPS65224.
>
> Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
> ---
>   drivers/mfd/tps6594-core.c | 250 ++++++++++++++++++++++++++++++++++---
>   1 file changed, 232 insertions(+), 18 deletions(-)

Acked-by: Julien Panis <jpanis@baylibre.com>



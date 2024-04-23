Return-Path: <linux-kernel+bounces-155475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C458AEB1B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D50711F23B54
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D160513776F;
	Tue, 23 Apr 2024 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a9/52vg7"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774A75FDA6
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 15:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713886207; cv=none; b=TeLhO1z7lfSGd+kF8IM6gjxMXlPhq1g+2dN084b58Bg/dnUZQ9HtysaYZLYeVihIktS3uBNk1k5hkJZEoaPB0NxoMg/6Rk9qzrUuAsjch0a2IsmEzJ0hxgceHHLiQ9C7ui7bKhtGI3uvRDssJPcmjIb3Dr3nKWBuiZYbdENnA18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713886207; c=relaxed/simple;
	bh=6wQb8Lm0iaW1qOd8q08vM5RM9VD40bdaYxfxnSxZ+I4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XIBKlQzDyOH8Cg6Op4wnKlDK0rP29Ts3GtLmGqkEnt3HzCSayx6tt1yu8l8VRi/eOzT5SMs6FaHUYlpCnwL+bWe7D4qF/JeFNBkoYaofwKLudXBi8SMYAHLYZ6r5Ex8dJRqTeh+L/gnoeg4K8c/KwuYpn6INnCMxOukWxh5ET5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a9/52vg7; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41a72f3a1edso17277315e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 08:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713886204; x=1714491004; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gjusxxvkAbTfFJRalIreNCh2igO3bb+hGjiTtEHGc3Y=;
        b=a9/52vg7h/qLp92YLuOlJInxJrdUp+27ijjR1Hc46qX4rlKD+XheRrHUpnYGUWFJJZ
         VaJs1G4o6QMfYad9tsDY+drtr++mOHNELgC5OkXfuW+djR6hkl7xWAHIYNVLCEzp7BqD
         QHyx6dYCMwYfpkXmm5InmVO8c29aebGm3BY6m3/qzrR/SeZIACnbBD/lvqXlWg+TMBJC
         VLkqc02O3QKJ0CpsdNZmruU0jfCJlSafiY2WezIUddTVVvRaEiulu4zwTPNaaOkbpWvM
         uU99bJOoVpKxSD5YBRz/KRbrzKR+WgY7gDWbNWn30c4safVl+xc4yknhrDM1H1/eZJUt
         pYng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713886204; x=1714491004;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gjusxxvkAbTfFJRalIreNCh2igO3bb+hGjiTtEHGc3Y=;
        b=Yk9u8rya/xFl+zMesgPxpqqsGIUXd1NJgT2l6wCStkb/tW5XK+Hri+0vSaRewqvwb3
         Ii5Shpp3inA3cYHQNsvuG19EcaS5r5MwcX77JMS+ZkUsQqI3kEakZ2FrDKvgwXb30aQt
         0IYag3aj+Gow6FhUv+6oYd5tnNnhiHaWqCB0olJXpjKhCGZRQQsThjX/K8OmmSD6k+ks
         3vMs55itZPB/qdr71Uo/fuNV9FnYsW39iWxiOo74DM7TnPJazfwGrjNeouSNeuTmLUor
         q1lzm8NLuzpaDtzrhXml5wboH0xV11VlWpEXvZtEPw0GN4LZawXbXhutTarkVCBKoeFS
         EZIw==
X-Gm-Message-State: AOJu0YzmwjRJqj2Tf1IqL6fHJ8FVyDHDhn8XlqTGwftrE6Pn3XEVQveY
	7BFYjgjau1YfaZQURImDuxGk0yJI9+xVPUPNYgfs5sj+OV1inunDuKDR90oNthw=
X-Google-Smtp-Source: AGHT+IEc4kD2aFJWF2PXWU6MtqBvtbkE18gSaYnf7BMPfWTqili/RNVyjqST2nX0BBHmxQw1iTWdjw==
X-Received: by 2002:a05:600c:4691:b0:418:427e:21f0 with SMTP id p17-20020a05600c469100b00418427e21f0mr9345749wmo.8.1713886203838;
        Tue, 23 Apr 2024 08:30:03 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id w17-20020a05600c475100b004162d06768bsm24418293wmo.21.2024.04.23.08.30.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 08:30:03 -0700 (PDT)
Message-ID: <727c7f9b-537d-433b-ba58-1250279f5399@linaro.org>
Date: Tue, 23 Apr 2024 17:30:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] thermal/debugfs: Clean up
 thermal_debug_update_temp()
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <4918025.31r3eYUQgx@kreacher> <2185763.irdbgypaU6@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2185763.irdbgypaU6@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/04/2024 15:10, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Notice that it is not necessary to compute tze in every iteration of the
> for () loop in thermal_debug_update_temp() because it is the same for all
> trips, so compute it once before the loop starts.
> 
> Also use a trip_stats local variable to make the code in that loop easier
> to follow and move the trip_id variable definition into that loop because
> it is not used elsewhere in the function.
> 
> While at it, change to order of local variable definitions in the function
> to follow the reverse-xmas-tree pattern.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog



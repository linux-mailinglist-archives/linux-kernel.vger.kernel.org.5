Return-Path: <linux-kernel+bounces-40108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3D383DA64
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 13:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF2061C24624
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D3E1B592;
	Fri, 26 Jan 2024 12:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oLv31TpF"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086701B598
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 12:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706273812; cv=none; b=O4TXvxfHC4xiwuLKUYboa/0MTVG+DeOFnRJ8L9MTjM4uDQFtp5mqdD+itrjdj7N+7hU3sXILVN2RvrF/MsFTblYJwmG/qm5P7+Zb0KR3vO38l2pBHzNv+irZC92N1nj+vdgPOz+XPJx5PpGQlGgJQvl6GZ1ZE6NEf4kWYKvvL9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706273812; c=relaxed/simple;
	bh=vEWPH3mWZOGa0t8ehdq7T5rSGfySqlrXSFtyqHnPu7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xe9paWSjsvvQUJjHbhv92GIxrMiaL71pO4Q6CylwsQRJX8R7Fmr07AlvelA8Cuj2Msll/Wqz8OryQ8fSSPMxS+Hp1B4fA6+x6KtxBS9zBZGMZTJcCZQB+SeJGOMid/3ZoLmNZAOtvvlahdN+vcieID6u/jtN6ZBtpuIPxuD8TCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oLv31TpF; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-337d32cd9c1so404263f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 04:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706273809; x=1706878609; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HNRJ344EIVqzGA3DHVgA976QKie0aE4RlEaXg0aggBQ=;
        b=oLv31TpFgBZL2XklHjzm/7WQAzCPASK+2yulRjoMhy2Etl3OSvZq3bcR0udnaaosgn
         L+EYcWN8p/XT/oQjzVvUHdfNJrpe1M3ohY+VhaOqHSOokv/hJ7APxOFvuQrwNxEaz2Ny
         CVo29n68gcy6gozKBZyCgaH/FcLZUyLeOXNL70uS1cKzQb8pTpsTEWoD+5/yuEVwPrnQ
         xrYpwSBN8FsE85koeKGTHRuA9nbB+7JEZESSLfX/uNDWC4rZXhh38Wq0Kp1gPCuxUEdP
         8uN40QOox+hQQZXVBbU3PLMhX/vAtGPI9pgjeKGvMzhecTi9qs+l498wJ9Af8eM5TOLO
         ScyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706273809; x=1706878609;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HNRJ344EIVqzGA3DHVgA976QKie0aE4RlEaXg0aggBQ=;
        b=k7ycolqg8BMusFFRNHCpS6Jp726OJ1tLlaxEo82s7/3KYjinDm/YiS3NAgar0xw1j3
         N2LwZetn1sFN13UTPDROZbcDPcgBCreCke8cKHEwg7WZomTcYJ7p2NLUyKVYeBW7PGhy
         LzcDvuDfK+MCVt6b3YnpDhRYZVy9AsClKvRJ49vT3KaN3Eh3iphaTxwfZO+DSjdxSczf
         T27BWBAvRupYkU2GbSX0UswVK5OR3J2D3I4gKo2lG7ZbU8VRJbNrhdgfAJ6cOCeXyy47
         9XvnkKsrGwat/w/EfnboPaIU578gq7LjPlY5m1nPriG3FthCC0AxCQifvd/jSVZSYvZ6
         p7cA==
X-Gm-Message-State: AOJu0YzUSycQ56NTfCaL5OJCNuE+wO8MyUMlQnti3a7bOH4+5kBnbqif
	DBchi+9iWY2Jux3uvkAkD07FKMtca+YkrG6expV6bcDBxVhfTv1l2KXQkxgziVCYgn/Aes9IVTo
	X
X-Google-Smtp-Source: AGHT+IFW1on1e3KPvwtZV1QrTNsKMJ6DsqWgEG8INQGsIAXHxAYQSTtJKIOhhIjLHDupP5fMDN8aRQ==
X-Received: by 2002:a05:600c:1e1d:b0:40e:d310:1cac with SMTP id ay29-20020a05600c1e1d00b0040ed3101cacmr882705wmb.133.1706273809134;
        Fri, 26 Jan 2024 04:56:49 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id bg24-20020a05600c3c9800b0040d91fa270fsm1826870wmb.36.2024.01.26.04.56.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 04:56:48 -0800 (PST)
Message-ID: <9b72b688-be63-464e-a5dc-cf6051ccee12@linaro.org>
Date: Fri, 26 Jan 2024 13:56:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: dts: rockchip: Add OPP data for CPU cores on
 RK3588
Content-Language: en-US
To: Dragan Simic <dsimic@manjaro.org>, Alexey Charkov <alchark@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Viresh Kumar <viresh.kumar@linaro.org>
References: <20240125-rk-dts-additions-v1-0-5879275db36f@gmail.com>
 <20240125-rk-dts-additions-v1-4-5879275db36f@gmail.com>
 <731aac66-f698-4a1e-b9ee-46a7f24ecae5@linaro.org>
 <ccc004cfae513195351ce0a79e12f6af@manjaro.org>
 <CABjd4YxSTLZjrnSCn0fh81US682-uhZ16-cgydzz97shhCpq4w@mail.gmail.com>
 <1f0608831cfb95c80edf16cd751eee76@manjaro.org>
 <CABjd4Yx06igrZQvHA4q-mcr2oSEf7eQyUS+KEATUGbw6qLc2sg@mail.gmail.com>
 <528a37d84cdd871e717b4ebf648bb8a7@manjaro.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <528a37d84cdd871e717b4ebf648bb8a7@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/01/2024 08:49, Dragan Simic wrote:
> On 2024-01-26 08:30, Alexey Charkov wrote:
>> On Fri, Jan 26, 2024 at 11:05 AM Dragan Simic <dsimic@manjaro.org> wrote:
>>> On 2024-01-26 07:44, Alexey Charkov wrote:
>>> > On Fri, Jan 26, 2024 at 10:32 AM Dragan Simic <dsimic@manjaro.org>
>>> > wrote:
>>> >> On 2024-01-25 10:30, Daniel Lezcano wrote:
>>> >> > On 24/01/2024 21:30, Alexey Charkov wrote:
>>> >> >> By default the CPUs on RK3588 start up in a conservative 
>>> performance
>>> >> >> mode. Add frequency and voltage mappings to the device tree to 
>>> enable

[ ... ]

>> Throttling would also lower the voltage at some point, which cools it
>> down much faster!
> 
> Of course, but the key is not to cool (and slow down) the CPU cores too
> much, but just enough to stay within the available thermal envelope,
> which is where the same-voltage, lower-frequency OPPs should shine.

That implies the resulting power is sustainable which I doubt it is the 
case.

The voltage scaling makes the cooling effect efficient not the frequency.

For example:
	opp5 = opp(2GHz, 1V) => 2 BogoWatt
	opp4 = opp(1.9GHz, 1V) => 1.9 BogoWatt
	opp3 = opp(1.8GHz, 0.9V) => 1.458 BogoWatt
	[ other states but we focus on these 3 ]

opp5->opp4 => -5% compute capacity, -5% power, ratio=1
opp4->opp3 => -5% compute capacity, -23.1% power, ratio=21,6

opp5->opp3 => -10% compute capacity, -27.1% power, ratio=36.9

In burst operation (no thermal throttling), opp4 is pointless we agree 
on that.

IMO the following will happen: in burst operation with thermal 
throttling we hit the trip point and then the step wise governor reduces 
opp5 -> opp4. We have slight power reduction but the temperature does 
not decrease, so at the next iteration, it is throttle at opp3. And at 
the end we have opp4 <-> opp3 back and forth instead of opp5 <-> opp3.

It is probable we end up with an equivalent frequency average (or 
compute capacity avg).

opp4 <-> opp3 (longer duration in states, less transitions)
opp5 <-> opp3 (shorter duration in states, more transitions)

Some platforms had their higher OPPs with the same voltage and they 
failed to cool down the CPU in the long run.

Anyway, there is only one way to check it out :)

Alexey, is it possible to compare the compute duration for 'dhrystone' 
with these voltage OPP and without ? (with a period of cool down between 
the test in order to start at the same thermal condition) ?



> When the CPU load isn't bursty but steady and high, we don't race to
> idle, but run a marathon instead, so to speak. :)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog



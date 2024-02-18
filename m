Return-Path: <linux-kernel+bounces-70430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AB18597A4
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 16:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E80972814DD
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 15:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3766D1AA;
	Sun, 18 Feb 2024 15:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="gyh2ad55"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA4D10A0D
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 15:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708270404; cv=none; b=qsFTJPTFXUUVN5AoIVxUZLcEJMKdeQVor3Egie97QKiA02nWM6aES5WbKMXeCiFKI9nP6tb8D8+3CMKSRSZhbYao6BBBRoHGRSSIOwaIojRdCQd1mVaKXutpIf2V4SRAfpSu5ou6ki3VD4sxv0HNOUeKrtvUBEbp1ZmFnhbcygM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708270404; c=relaxed/simple;
	bh=syDAiHk94O4JKIo1purC9KNq7m5mjo47yfL5tdr8N04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JDMrkKKvH2GYq83JIfUixR99BofrqueFEh4DNMBSiB6g00mIKlaCQz9BGSt9wM8Dz49R1PpefbIqUsTkRUaW7yE8AOj9ulztJRkFAGouIW0rsSypi7EEH0T7/9dGRMCB+i2xfPXpV53y6yzM84o4P4702XO+OramKKzZDEr3lSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=gyh2ad55; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c031a077d5so1941447b6e.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 07:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1708270402; x=1708875202; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a/+WFb/6IHGO7DuuRGtC1ezHX/DnsS05J/35SHyK2KA=;
        b=gyh2ad55ofvEiaolmxlP42cEAd2tP0hd5xdVjF3gF6bd+CdaWf+KY7NFXY1hd7klvU
         3+nB1tVbJnqOspRVtOG1hLQlehtnGgk/G//naH5Y5UjfYmJar6UK1EvmrLCBByYuIEwd
         JvPSv6jnMgVuLo7C+T+3n8fLcJvqVF3U+SWdeUdAfUtSb7v8QpXtHlGq3icHowyTPVlw
         A0TBsqQhCm6NIH9taVb6P9VVd7ccLbGCzTW5s+7pWSkqXyVhtjA1U9EFlH6R/+cEhOiw
         pbv1b7wGAOlsX32ayxzWqbXvfYgYLihaC9kMhOW7+f7Ojh/zK/Q8aVJzwBBuHqXfSV7s
         Xyxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708270402; x=1708875202;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a/+WFb/6IHGO7DuuRGtC1ezHX/DnsS05J/35SHyK2KA=;
        b=bj1NW45QYYXvKnwvpmXptMpRikR9idDH5nFNTh2cKtLlGjh0zLej88TUc1/t4PbEu9
         vyGe+zoIofjbSrwTcgxhtXNoGsnRlDj1tKwq0CYdRnYa/8wkXP4rBorzHUMel6JX09N+
         nmBMf/gSY+DN3fe5g0KURHTi2gOwxz2iXzDCN52fDtnTtVFG96+hOuNiyPd50kf808XS
         yrhIzgaMk8uG19g8Fzh00iZ8EvLyv+0aMoa492YSzNZmGxzt7zB1TW8sVkHCoUhhvsPE
         feYsBlmYu8TA3WwjHDN1yxUwf9RJQqDlrPBqLSL6MQVBclxzBne68kWpySGG41dZyaxn
         wYaw==
X-Forwarded-Encrypted: i=1; AJvYcCWd1hrJszwvw+SoWVdq6FvsoycXuKFYV+ex/rMdbsDH9WxJ/xahcDILykP2jXtA34CA0+CQyie9ZpU9zwSGnInG/hutE0mYyegCtR41
X-Gm-Message-State: AOJu0YzjDeBBta5x84gtihm20jWABMbGgEVOZTBbv5fPpzSmp3gIhcgV
	ytlVj+fEOqszxeeWp64MKraD+TNlSSWMJwse7SQEvqs4AdH3vvVCu3R7cSxITvY=
X-Google-Smtp-Source: AGHT+IH1iDyN2tzMwmReFoBP6SQJJq7Vr+GdTMJIqYq1jnekXccdpbNnTxJEdOIrHFh2U6cMKFP2kA==
X-Received: by 2002:a05:6358:7f0e:b0:176:92d1:568f with SMTP id p14-20020a0563587f0e00b0017692d1568fmr9886249rwn.18.1708270401977;
        Sun, 18 Feb 2024 07:33:21 -0800 (PST)
Received: from [100.64.0.1] ([170.85.8.176])
        by smtp.gmail.com with ESMTPSA id x19-20020ac87a93000000b0042de2e2195fsm1719582qtr.26.2024.02.18.07.33.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Feb 2024 07:33:21 -0800 (PST)
Message-ID: <a3139d86-f2d3-45c4-9eda-23afbeb3f3c2@sifive.com>
Date: Sun, 18 Feb 2024 09:33:20 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/6] dt-bindings: cache: Add SiFive Private L2 Cache
 controller
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Eric Lin <eric.lin@sifive.com>, Conor Dooley <conor@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
 linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-arm-kernel@lists.infradead.org
References: <20240216000837.1868917-1-samuel.holland@sifive.com>
 <20240216000837.1868917-6-samuel.holland@sifive.com>
 <7d7fc53f-1b5d-4f1f-a53f-f0863a79a79c@linaro.org>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <7d7fc53f-1b5d-4f1f-a53f-f0863a79a79c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

On 2024-02-17 3:12 AM, Krzysztof Kozlowski wrote:
> On 16/02/2024 01:08, Samuel Holland wrote:
>> From: Eric Lin <eric.lin@sifive.com>
>>
>> Add YAML DT binding documentation for the SiFive Private L2 Cache
>> controller. Some functionality and the corresponding register bits were
>> removed in the sifive,pl2cache1 version of the hardware, which creates
>> the unusual situation where the newer hardware's compatible string is
>> the fallback for the older one.
>>
>> Signed-off-by: Eric Lin <eric.lin@sifive.com>
>> Co-developed-by: Samuel Holland <samuel.holland@sifive.com>
>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>> ---
>>
>> Changes in v1:
>>  - Add back select: clause to binding
>>  - Make sifive,pl2cache1 the fallback for sifive,pl2cache0
>>  - Fix the order of the reg property declaration
>>  - Document the sifive,perfmon-counters property
> 
> This is no v1. Please implement entire feedback from previous v2, v3 or
> whatever it was and reference old posting or continue the numbering.

The old posting is referenced in the cover letter:

This series is a follow-up to Eric Lin's series "[PATCH v2 0/3] Add
SiFive Private L2 cache and PMU driver":
https://lore.kernel.org/linux-riscv/20230720135125.21240-1-eric.lin@sifive.com/

So these changes include implementation of the feedback from that v2.

Regards,
Samuel



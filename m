Return-Path: <linux-kernel+bounces-118136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2226C88B46B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31D7A1C3FE19
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B837F7CB;
	Mon, 25 Mar 2024 22:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IuBftl8O"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5446D6CDD6
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 22:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711406772; cv=none; b=KzCNwfqV4uHnF7AbDmUDoAoWaWs8yK33UOc4t0MR0gIqGsaFaCHe6hWlqJEmkw6BU+i45yvVQjW4jSAqBUU1R2mV9//zGJb7j0oK+PGry9eTU1iMS00Y0dpZ4ktJLxDIeTbeBIOXN2pOMbjjgTvHM8qogZNpLGdANWD9iYaaDbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711406772; c=relaxed/simple;
	bh=+gqSdgfG6OZ5jN7sbuCKYrxocXikvnfjnj2qKtRv7xY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=k1iSoc4PyehzWdtB+AibqcUseUThc+nQoWmWypvR4YlzWYzmzMcRZ1kzULQp6NMBzBfPyPNyH/RLx5VmGHyuSPpHX+YtA173zOIeBqPPvbbDJYoV9aJTSgpFEpeXBVkOSQkMX/UpxZZaEa/LRWqkWa7ecbbePj36s2nR8j3rZmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IuBftl8O; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e6b5432439so3736304b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 15:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711406770; x=1712011570; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5wHcOa7VYU3+suJaQm6vgBj/tOS8swPDZAFkLwg/UUY=;
        b=IuBftl8OWB3cvFhriGSb7E4Yhv+/RvFy6X5DgFks41SHx1N9c2t1WHrTAAYxYrRMJU
         s+J2Js/q+B1G5nLXfIn6pV42LR8rPgoLrUwxvIZN97IfcDRn5coHuGJJh5x25ThPxFcl
         Q5wihq4qt6k3bIBsTB6MTABV9tkZuENcBQDdSUkzwn9sXZ4DFdpjvgAISMA0Ihts2H3Z
         4/Q10s9cNyueWmW8g3yXCH9dTcon+gBu90D+9HCClL68NxNoNYQN4RCJBfJDp+5Tx6ke
         HG2tWLyeG8sap2BNPjqAPrs+pHeBW9e6G7LU+VFDJZDmwjbasZfrr/7hgZLqtuVEz+UH
         ifmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711406770; x=1712011570;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5wHcOa7VYU3+suJaQm6vgBj/tOS8swPDZAFkLwg/UUY=;
        b=OOCGq+bb4zcxCG6fT3hUkS14ldoqgd8hAEUbKWa+xz1HY54ucGTVuXu3SVc6OSwN/Q
         SGyzYqBiZ7NJOSATvvBJh72j8EikNnO4xGtqH7ZaJfus1slpkxvfvkKCrE0Yy6L3FHxS
         f4fYkX4Fu+pZuIpnxv9J9vfVOA5Gns0i0fIYTH55uBKZVGvHm+QFVWxn51cwZUmq1RZz
         qaLy9my66wjS191sv5Yix6omQtuXgTF7bQ1YqTudQu5tc+3hM0Z+Q4oRk9CphcOdrQwG
         Yaj+3U70odCLp69Tc+tOJSUdK6nrHx9A7Asw6iP1NGT44EUHSTst+ud5qYF4r8CSMr/L
         xCvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWi8AVAhWM4YtvkYnzCBZkZtBEzT4Gr2kvuHTN7s7/QX9i07cYAqRVAdO7V8U9P52rovrgAwcpWr0Jtqq9NRa9e6ZVAd08BKlylnT35
X-Gm-Message-State: AOJu0YwUFPuuauOxh8ezlGt3xl6QA4YexZY/H8TXPk0FlFzTFbbDV37s
	UUPvF2SOWaweTlf9oI16m6mRRJAOgn9RAcOdplubLfR1XRO0kjv6
X-Google-Smtp-Source: AGHT+IGsskBw05ruPmf0/EP+uCFDCRvZkLRAuCl9THgmZS3UDX8PlyDXcfvB5JSjLJnN1c5wVEmY+A==
X-Received: by 2002:a05:6a00:3d4e:b0:6ea:b228:912 with SMTP id lp14-20020a056a003d4e00b006eab2280912mr2556893pfb.0.1711406770502;
        Mon, 25 Mar 2024 15:46:10 -0700 (PDT)
Received: from [192.168.0.13] ([172.92.174.232])
        by smtp.gmail.com with ESMTPSA id n2-20020aa79842000000b006e6c3753786sm4707302pfq.41.2024.03.25.15.46.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 15:46:10 -0700 (PDT)
Subject: Re: [PATCH 1/5] riscv: nommu: remove PAGE_OFFSET hardcoding
To: Jisheng Zhang <jszhang@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Samuel Holland <samuel.holland@sifive.com>
References: <20240325164021.3229-1-jszhang@kernel.org>
 <20240325164021.3229-2-jszhang@kernel.org>
From: Bo Gan <ganboing@gmail.com>
Message-ID: <37d456c1-f0bd-1a78-2d0c-350ca25c6b8d@gmail.com>
Date: Mon, 25 Mar 2024 15:46:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240325164021.3229-2-jszhang@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 3/25/24 9:40 AM, Jisheng Zhang wrote:
> Currently, PAGE_OFFSET is hardcoded as 0x8000_0000, it works fine since
> there's only one nommu platform in the mainline. However, there are
> many cases where the (S)DRAM base address isn't 0x8000_0000, so remove
> the hardcoding value, and introduce DRAM_BASE which will be set by
> users during configuring. DRAM_BASE is 0x8000_0000 by default.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>   arch/riscv/Kconfig | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 7895c77545f1..afd51dbdc253 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -247,10 +247,16 @@ config MMU
>   	  Select if you want MMU-based virtualised addressing space
>   	  support by paged memory management. If unsure, say 'Y'.
>   
> +if !MMU
> +config DRAM_BASE
> +	hex '(S)DRAM Base Address'
> +	default 0x80000000
> +endif
> +
>   config PAGE_OFFSET
>   	hex
>   	default 0xC0000000 if 32BIT && MMU
> -	default 0x80000000 if !MMU
> +	default DRAM_BASE if !MMU
>   	default 0xff60000000000000 if 64BIT
>   
>   config KASAN_SHADOW_OFFSET
> 

Thanks for this patch. I did something similar in my local nommu
linux-6.8 tree in order to run it on the S7 hart of JH7110. I have
another suggestion for you. Perhaps we should also make TASK_SIZE
configurable, and let it default to `0xffffffff if 32BIT && !MMU`
and `DRAM_BASE + DRAM_SIZE if 64BIT && !MMU`. Currently TASK_SIZE
is effectively `0xffffffff if !MMU`, which doesn't work if I run
rv64 linux-nommu with DDR that spans across 4G boundary.

I see there's another patchset that tries to define TASK_SIZE_MAX
for __access_ok(). Looks like that only affects the MMU case, and
NOMMU is not touched. My aforementioned change won't conflict with
it should it get merged.

Bo


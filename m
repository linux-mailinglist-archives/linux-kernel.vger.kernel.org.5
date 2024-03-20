Return-Path: <linux-kernel+bounces-108537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A46DA880BF6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED946B228A3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3EC1EB51;
	Wed, 20 Mar 2024 07:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OJleVZIZ"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244C31EEF8
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 07:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710919427; cv=none; b=C/so+w9lLI4ocfyy4QCTgJdZjZh4R1NYMHrExMp2fyBJ9czlyAmL/+Yr5LBEYNJ9JO2y3+NpPxFI6bwrGyFUY+WBgtrZopiU6vgUpP//CP7hIdBoZQGwVJmdwJ0QiZev1x1AWbMtvvRrHJAzN7Dsb03GI8A1GHPqgFO+3Mq2OEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710919427; c=relaxed/simple;
	bh=EkqWs0W3q04YVqE2gPo5awQuY3J0Lng3bMWEGITru1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CgxRC5x2YR8N73BzPL5xLlQaK7LCA70xsu7YejwY1uT7J1LGiproxr43Sn2W4rchX9TvR/cDHIGOU3pkWrqOD2rH97nfIjgaN2ymnHj/qFZMbgXZVpOhFHDPSjJmqJrV8R6GJRO92x1bAi+K7PQEnIbFO5ZiHsPH7SoAyQ2fwhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OJleVZIZ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56b0af675deso3217991a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 00:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710919423; x=1711524223; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=i3jlY94/eeyZ6RcBk4RP2SNOK962GMXwjEvU51sOt6s=;
        b=OJleVZIZCLEsZQWLXTg7B/L2QFjEJEuzof2ZZCL9xntszCLEPYL4XrfYLo61na3r9h
         +9y/Q/gsmQlkQO/H7AKtCpQ2MEruK1jP/OZuMoFqrdcWtBDqA2J7t3MZbK3yzqxee5tD
         /Zxf6n9g2oClipaY2/mNIv4VHT9mQrmarCrpM/gDj34vzDWQ6TVf6pJFmrOun/lJ9uoy
         4+XksrDnI+m0IyBHx+M+RvOP2ZC01xD6xN7dqQ3hso3MNNnluBS5gAdYOyildx9Pqcqn
         JrCcmHpklDqcoTOLnUqS+rwlu8EZgAMX7KD37d1fY24cHYufswoWZ+qxy3kI+feu/u1F
         cKWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710919423; x=1711524223;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3jlY94/eeyZ6RcBk4RP2SNOK962GMXwjEvU51sOt6s=;
        b=tvsbN7rnmRYl3HOE4GCJnXMieyUTtz73SqdxhWtzs6bdFdjD6rWVV50j26oGFSUdUb
         pb3Ew37uzicCjmnRoO7zwGhogmQKbtwDRe6TTmagyeRNXobnVxkroKJb80VRtkc8nOq6
         n3Y9lxDy/PWPN21G6O6JvOGbFO3RKO14AgfuyKOXj2B/Z8BTPQqzurg775ijnE6mE7Kh
         CzJnMCFBVVr6BgPniusXFbcMuXoAs9+zaK6i3KDsv4WGcauyRR9nod3jPmUiBa7x1hw+
         yZ0BT+ePgY2j76Nz9sbk42Yqx+MY5EEoM7qCt9NK20TeZ5bDkBSPZTD1lAivlgSi0ImI
         feXw==
X-Forwarded-Encrypted: i=1; AJvYcCXhXBljRFTROc8PZIvl6OKUusyMm3l6+iAISnC6JxScIeNedMt4f5J2lWR/reRenHtZrkVopT+7L9F6vuYyn+u3PkD+iQwwDcp0cxwb
X-Gm-Message-State: AOJu0Yz87b/Yh5GcChwdlDf9LMUZcJfevZOBkpelJSKK/w9fLzhALl3Z
	4urZYrftWXqCy/Jrx7UsCiSER+hekiKt7xcEif+JlHkj8SY3OTGMqhmkMUv017I=
X-Google-Smtp-Source: AGHT+IHfT2z0OxThuuxSUr06aWZGYCKZSymdnckDGx+Y83LSi19WiCYtHnyAy4GauWep8eYh4xrfgw==
X-Received: by 2002:a17:906:c80a:b0:a45:c027:372 with SMTP id cx10-20020a170906c80a00b00a45c0270372mr676128ejb.68.1710919423329;
        Wed, 20 Mar 2024 00:23:43 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id s10-20020a1709060c0a00b00a44899a44ddsm7038094ejf.11.2024.03.20.00.23.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 00:23:42 -0700 (PDT)
Message-ID: <0ad9a94a-0fb6-4ff4-84bf-56ce0ff682f1@linaro.org>
Date: Wed, 20 Mar 2024 08:23:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] clk: samsung: Implement manual PLL control for
 ARM64 SoCs
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>,
 linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240301015118.30072-1-semen.protsenko@linaro.org>
 <CAPLW+4=_yD3ShU5DvLWFyEzVrVHNVCsB+4bVkP+x_boRmC-vEw@mail.gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAPLW+4=_yD3ShU5DvLWFyEzVrVHNVCsB+4bVkP+x_boRmC-vEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/03/2024 19:47, Sam Protsenko wrote:
> On Thu, Feb 29, 2024 at 7:51 PM Sam Protsenko
> <semen.protsenko@linaro.org> wrote:
>>
>> Some ARM64 Exynos chips are capable to control PLL clocks automatically.
>> For those chips, whether the PLL is controlled automatically or manually
>> is chosen in PLL_CON1 register with next bits:
>>
>>     [28]  ENABLE_AUTOMATIC_CLKGATING
>>     [1]   MANUAL_PLL_CTRL
>>     [0]   AUTO_PLL_CTRL
>>
>> The bl2 bootloader sets 0x10000001 value for some PLL_CON1 registers,
>> which means any attempt to control those PLLs manually (e.g.
>> disabling/enabling those PLLs or changing MUX parent clocks) would lead
>> to PLL lock timeout with error message like this:
>>
>>     Could not lock PLL ...
>>
>> At the moment, all Samsung clock drivers implement manual clock control.
>> So in order to make it possible to control PLLs, corresponding PLL_CON1
>> registers should be set to 0x2 first.
>>
>> Some older ARM64 chips don't implement the automatic clock control
>> though. It also might be desirable to configure some PLLs for manual
>> control, while keeping the default configuration for the rest. So it'd
>> convenient to choose this PLL mode for each CMU separately. Introduce
>> .manual_plls field to CMU structure to choose the PLL control mode.
>> Because it'll be initialized with "false" in all existing CMU
>> structures by default, it won't affect any existing clock drivers,
>> allowing for this feature to be enabled gradually when it's needed with
>> no change for the rest of users. In case .manual_plls is set, set
>> PLL_CON1 registers to manual control, akin to what's already done for
>> gate clocks in exynos_arm64_init_clocks(). Of course, PLL_CON1 registers
>> should be added to corresponding struct samsung_cmu_info::clk_regs array
>> to make sure they get initialized.
>>
>> No functional change. This patch adds a feature, but doesn't enable it
>> for any users.
>>
>> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
>> ---
> 
> Hi Krzysztof,
> 
> If it looks ok to you, can you please apply this series?
> 
>     [PATCH 1/3] clk: samsung: Implement manual PLL control for ARM64 SoCs
>     [PATCH 2/3] clk: samsung: exynos850: Add CMU_CPUCL0 and CMU_CPUCL1
>     [PATCH 3/3] arm64: dts: exynos: Add CPU clocks for Exynos850
> 
> That concludes my efforts on CPU clock enablement in Exynos850.

Please do not ping during merge window, for anything else than fixes
(and me only for fixes being serious regressions or serious issues, not
for fixing something which never worked thus will not get to fixes
branch). Not only me, but don't ping that way any of the maintainers.

Best regards,
Krzysztof



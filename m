Return-Path: <linux-kernel+bounces-63556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61278853139
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 942131C26C4E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA65482EE;
	Tue, 13 Feb 2024 13:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KFt+kmr9"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFC0482DA
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 13:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707829424; cv=none; b=EGWP8Ok4ZyVVWMyRQcZmzPs6nxF+sI+Yy9g4owmZXpPStsYla0OBDHjaXFiB3kBRAO8l6Pd6kIcvA5/NW6EX+mJBtWZnGEHD9rVsCB66Bm/PESI1a/hFrQvFGhgi1nb/FnXVnrK08F6EykAi7PT4O+5uoQxGXKsGcdsGJ/A36Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707829424; c=relaxed/simple;
	bh=6/8cJXoSjzIifXMl8cdj9SqNamhz3R4iwV033H5CW7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AxO7V4zV4GW8qmXe38df8nk6MXiVrf9MBVcO6oWv9pdLxwT7JT4PqJSEHf4AYuk5INf6+66RA/dDh7lz86xQu4qV1FBRYlEsBlZBvLicZaR5uQ3TNMG6iH1IR9rgpp7ZOGMAX7YVpXwegOGJcqaZJpdDsh4oQpEZm7bWPtGsYGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KFt+kmr9; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-411d2836b20so613595e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 05:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707829421; x=1708434221; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C5NrW5FTTwB3Xw2yt6Nvx3f3s8HF+s3K3TJHJX5IeCg=;
        b=KFt+kmr9/hABtqx72UHB+4CnzcdDUudvj3QPMqKq6sRBzJtEmlIPmS64kUPbl3GVyT
         MYl+VFVBH8FuLP+Nm3I31ZKoFDO+FK9st0aj3rjZTVklcRMafgGFoX1LbFRgosK8fQqa
         Lqj+AHSi7XRtj+2Bh7DzuM6AunaQfL2Ms0wwGLmKEh4M3WDoRTOjZSw9BVkYY3aVs/rX
         sTpmUk9dyNxzlAhrm5s3L5jzJA4Sb5+67brzjkDaTh1eI606As2+50wTVKaJfOVwUj19
         e1yLVg8rZJ68LJ3JzC9cdhKs69ZbwfRmj/kg1DO9lKhpBryZozsB7Dty/t399ZPmBYY2
         VL2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707829421; x=1708434221;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C5NrW5FTTwB3Xw2yt6Nvx3f3s8HF+s3K3TJHJX5IeCg=;
        b=oLUwucOqlEUwchUWbWiWzY4Yq8YDOSBnU88u61Et8vD8dqhJa/eiKQVkv8coQbfw+r
         HdU/YRR3hkQnIKKmUswTBFWRxDfX+agjlazZK42qFEUbn+xLSYc87TDnh4rNzUYS4qN0
         Xw9NCq1tVjXgOzna0CaBmE0XVq8ziAMX6duBWxoED7uMXb7bM/cJAGTHq48BZNmFDG5L
         VrLgUTl0Or1rTQZnDT/5r9r0Q+CCgjBo7YjsHdFuX+LRaRLmkQVQLxMB6vWth4r+CiwA
         pOkQCFFXJOVRFuOSHad3476MeFB6WajnYXXeWf47X1rmkWKpiS2fIE7bT1mCvhPrfNbN
         V37g==
X-Forwarded-Encrypted: i=1; AJvYcCWyytYF/z8O5Qwn3/BYRx9ZpIBg15Nl4CcMwDP3QVcX7DDpLy+UrtXpvazgbtixCqeIGCDH3L+GvGxgVeuqSJgJIwFwfxi8js+rrvo5
X-Gm-Message-State: AOJu0Yyb17JtW0DkAn3IKQb2JSdw7V+RRySmoNXSY8uFppvu/B1jOmoY
	j9IGNbgTBpn11nT9pP+TKRnKyF5mcufLrJ3ovMe0Ueg7FHUkkBesm7XH3A52/L8=
X-Google-Smtp-Source: AGHT+IGff4Ny4f1WeJGCs+3nuZxbToyUFx8GempT/EH0khCzbnM4pZaGfiEmTfd7EjnRLIAX3EhG9A==
X-Received: by 2002:a05:600c:3b86:b0:40f:fe1a:6baf with SMTP id n6-20020a05600c3b8600b0040ffe1a6bafmr6994110wms.1.1707829421015;
        Tue, 13 Feb 2024 05:03:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW7CtLuect2QEqcymxQGaUVmVCPIyY1NdHNUpoLLZHXRt9+n/gP+2I6mH9ctZZlAnwNCbloiXyQRv9bQh+MF5UWYu1yRjChSKHqVrHw8wnHuac0mRrY1Gj7p9X/s2YJDdaZ5mSMdtRpTNTm6GaISrpY1EQpQ+b6t1VrU+0xsYEm8bwBlZmUtkBNxcN5vVx20fwpOp6xICEzXAypqtVuaZoL/C7RzpDGn+aRrdZJieEGE/btmHIpyWNcL8dPDbdkE8zLdibnJa5m/CcTl5lC/oHHy7v52s8tA4V/zcBwIUUbmI6eks6zokE63AeiPVHcU/UGEAIWk/7/kuIk0ephB0BuEVIm1+vtMFWk90ZljITNTf6YVyg8QHCbvqwL32VOUlerYK0QGoRBeACZD4ijWSgdiWGABW9JkLNzK2MF7xv8iD1PQ7UAJbJm7BmmVaQNK2/vhxQEhb2tnJPR3PkbKensFAb7wKFZMGtBXV+dO9zdpn45vC/xXjXkxs3ARiFVNyjydEOvQ/kTHjVgNzVLqhb+6wlM10wrJpW05sV9e6HW7jIbKVqZEhMyh2DAWiDqr1yk/Vz2S1lDfjL7K1XkIc4+OPQqqWfxcskmUJmbbFBkWgqVQP/AGwqU50T0L4psZXPemJdpkXwoyOU=
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id v1-20020a05600c214100b00410395dc7d1sm11615850wml.7.2024.02.13.05.03.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 05:03:40 -0800 (PST)
Message-ID: <6092ee3a-4a28-488b-97fe-538e619f8983@linaro.org>
Date: Tue, 13 Feb 2024 14:03:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: timer: renesas: ostm: Document RZ/Five SoC
Content-Language: en-US
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Chris Brandt <chris.brandt@renesas.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Magnus Damm <magnus.damm@gmail.com>,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20231115212908.33131-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CA+V-a8tN-qn8zuimte=-riahJBWGgGi8i5botNfWqdWwJ7w-4g@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CA+V-a8tN-qn8zuimte=-riahJBWGgGi8i5botNfWqdWwJ7w-4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13/02/2024 11:22, Lad, Prabhakar wrote:
> Hi Daniel,
> 
> On Wed, Nov 15, 2023 at 9:29 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
>>
>> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>>
>> The OSTM block on the RZ/Five SoC is identical to one found on the RZ/G2UL
>> SoC. "renesas,r9a07g043-ostm" compatible string will be used on the RZ/Five
>> SoC so to make this clear and to keep this file consistent, update the
>> comment to include RZ/Five SoC.
>>
>> No driver changes are required as generic compatible string "renesas,ostm"
>> will be used as a fallback on RZ/Five SoC.
>>
>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>> ---
>>   Documentation/devicetree/bindings/timer/renesas,ostm.yaml | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
> Gentle ping!

Applied, thanks for the head up

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog



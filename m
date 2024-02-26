Return-Path: <linux-kernel+bounces-81729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D01867975
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D14D299BB6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1BD13174A;
	Mon, 26 Feb 2024 14:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oqqs7shT"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE42B12BF29
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 14:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708958687; cv=none; b=lLKvkb10Gf2x9ZpvzBhrVGHXAfyefz4sptP38LUXuk1oo6pKTzkWwDNUJduGyXxt1NhEPjYg8UKUnzGtq/D0ibONA44wZ4XalZGkj+SJTfRB7yjO3IQ95Xz9EMx4c/AY85GWlVLXHQBeLhQSWaKf9Z9GPIl+papxRM2wOJLt9UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708958687; c=relaxed/simple;
	bh=+7EGPxI8njojWIFtKK0niBxOgiA/ror8Zq84fmjVI+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kxTicjA7QnTghOeWGSu4ENmf0AzjY6G/rviaYKu6D/zvAFVKTNA8R4PUGjwFr9mKs/qFT2IJENQq6eD7SVnFCkVc6o0eknDxeh3eLKsmZa7JaS8MgxCCncmdcB3DfCHQm1WiKzbA/0vzveTLKGFkO9oacu/VfP3cBmQhVT+za1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oqqs7shT; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41241f64c6bso24698905e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 06:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708958683; x=1709563483; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xebCF9Rlp7+lnTRinKmQM1qUIifmCWo6oOreD/07nk0=;
        b=oqqs7shTGESEKQNn6q9EY0l+JAG9rPGh9KneyUKyY1Gb/QVjOzpdbXgc9gc7TdXgKW
         yzIWcNlbH0QNXTfH55/oeUkSA1Tx2roq1KL9bb/smfdYRgPWuJF8PZ6MDMP/uuKJAMHA
         lL9g43jLJKeyD0Ktc9YGjAfYUKYb5iq0jcA4DMRU3JtaiU9D1IcP6OwsMqApQtRx+y6Y
         CMZpIne3ANYaKB5apSijLkgSG5F/hbVOAHoqcC01KkFhcdM4jp9S18Ezj4fYVac1DTB5
         HAmUafG5tWnWHduUJf9Yfa2J3nnR2v+bOez0FE4dCY2m0t5bLf3dAegtdkwsVSsAy6Li
         0vVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708958683; x=1709563483;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xebCF9Rlp7+lnTRinKmQM1qUIifmCWo6oOreD/07nk0=;
        b=PxPV1Y2oL7qICSaKdB40kz+U5f+bMGgrdX88bCB5viCXZT547Hre8DV10bWr3LPxSx
         voDPhk4+9N24oBAD1cZ+BqUXSy9l4mUggCV9VNBhxFVQhpZSLmMCZ7UzV2UKCN2yt5Nv
         B7UngCpSJuE3xpHGnLb+Dak/lOwkglC2EmY44VYKp8NMkXYIhptCYZi/+8RyM2vP9N9X
         bR6Ppe+t/93ZJ+DkA8cTHt6XDkglm6Y7EzoIUubD5vScvyz8Kieah9aMicC3vU8PCSZb
         aKBEs8FCkGLCe8alxvqUdHcTeXwD9Q8wIhninFlQlOb6ofhtXPBG81buEhelxnahkEPK
         N8rw==
X-Forwarded-Encrypted: i=1; AJvYcCV36UTE9sLR8a1xLLxYEbnxSBuZuZrSU2wHLaqmeSnXd9qD4EVmfOIEVP+8B6T3m+wskutdLi2wkKkJZuvkItldaUDiWIaQtOBPXe/f
X-Gm-Message-State: AOJu0YycLGqG2RyJ9z/Hl+Rw/Dqprq0WmmVENNjvij0CT8uw0dkmh+jU
	eVDM9AkTvKbJlQZ+Cr8jYe4deD6WPNiAsBayzLJNPAcAemaVwHteOvxZFl0kTBU=
X-Google-Smtp-Source: AGHT+IG9SpqrImlSczgJxnpgDOf0lff+zMPddH3C9S1iodwRZL/rSMYdzPAPbQ3AXMmt1pT+Z1JJIw==
X-Received: by 2002:a05:600c:35d1:b0:412:a927:a646 with SMTP id r17-20020a05600c35d100b00412a927a646mr582114wmq.24.1708958683167;
        Mon, 26 Feb 2024 06:44:43 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id n1-20020a05600c4f8100b004127ead18aasm8586036wmq.22.2024.02.26.06.44.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 06:44:42 -0800 (PST)
Message-ID: <46630fa5-381a-4006-ade4-2c18e76331ff@linaro.org>
Date: Mon, 26 Feb 2024 15:44:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dt-bindings: timer: Add support for cadence TTC PWM
Content-Language: en-US
To: Mubin Sayyed <mubin.sayyed@amd.com>, krzysztof.kozlowski+dt@linaro.org,
 robh+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
Cc: tglx@linutronix.de, michal.simek@amd.com, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240226093333.2581092-1-mubin.sayyed@amd.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240226093333.2581092-1-mubin.sayyed@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/02/2024 10:33, Mubin Sayyed wrote:
> Cadence TTC can act as PWM device, it will be supported through
> separate PWM framework based driver. Decision to configure
> specific TTC device as PWM or clocksource/clockevent would
> be done based on presence of "#pwm-cells" property.
> 
> Also, interrupt property is not required for TTC PWM driver.
> Update bindings to support TTC PWM configuration.
> 
> Signed-off-by: Mubin Sayyed <mubin.sayyed@amd.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> Changes for v3:
>    Add Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>    tag
>    Remove bindings from subject
>    1/3 and 3/3 are dropped as of now (WIP).
> 
> Changes for v2:
>    Update subject
>    Modify #pwm-cells to constant 3
>    Update example to use generic name
> 
> link for v2:
>    https://lore.kernel.org/linux-arm-kernel/20231114124748.581850-2-mubin.sayyed@amd.com/T/
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog



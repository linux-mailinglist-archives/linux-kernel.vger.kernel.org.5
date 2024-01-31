Return-Path: <linux-kernel+bounces-46964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 022D7844706
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1BA2288CB0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F78130E35;
	Wed, 31 Jan 2024 18:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gRQp8upK"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48B012CDB8
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 18:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706725360; cv=none; b=hePOvgBm03+0eAwK4HxUjC/wYIkO0GFdYF6gptttKMTj2ezPoHT95uYvzpDMbs28GCSVpNfdJZ/5qzz6Wgg/RXKMXYPI+C70VgBiH6lmAj5/M1feZ431DhuwMHcbag61/CN07ElnHeJk9SqQ81bWvp9ZnmnrdukgRWvX/xAoGqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706725360; c=relaxed/simple;
	bh=z16ACY49/1e7bOj0OReF7J/eAVkgaJxbfAVjTzxIMlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fjf3yXDIVGj4XpibtBEQNAU5yXEY3y+8QxCHh1Wu9DSWtKS8Ja9DAf1T56tExkm5c8ZaItTuW2qgZcqp4njTqrv3rrF9GviDnE/KPtcUMmpHpERCtxJ+HWsyEnDHS0DWBSlYhgPfGEtzvXgXL2r8f7d3LKx0VNH26f/LUYHWnhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gRQp8upK; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e800461baso1026615e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 10:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706725357; x=1707330157; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gHKzDZd1mqTqqV0mGTc0u8ONZh6m7/ntJ7FejoiVhh0=;
        b=gRQp8upKrzdbHPzFknA2xC4HI9oTtNLKbM/lKq4jht0nc5h7S0hGRzZkQzkg9YYDzJ
         mifkC1vfwvAraF3+07bXaLreNqablDAvQb0eR9VDBUpH+9eOebcD69dW9Qm2J9l09tZk
         q1It7ij8l8w67bxmzP8UL85Sk+V+pmMX59x0e0qxb7VWlfRN5CnkqKHmn8lCeFS9UCB5
         GY3W4ZKzKdhVthVNowO1M8ezKQWuDLgda+dI5CeLrQI/23bWUq5ow6M4b7vANiVWeQWC
         Jo1mXXCz1krUvdThzNREB0/QrjYQOrQ2qSbX74UZ8erSgtjVuiPpa/eDpv77y6VgZYF6
         HIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706725357; x=1707330157;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gHKzDZd1mqTqqV0mGTc0u8ONZh6m7/ntJ7FejoiVhh0=;
        b=kwAbhdGx4skCRpMLGbBQfXJEeeDYUG0voiq/WQIAb8/jO7COTtHFZwO+GrfgmEFBml
         uuhiDA5rMf/e0uydUKX7pVc8RHeELAbzl3q13eBrrUZiHL3FmmvORwv5Gxi/JTCD89Sw
         98oyyYHyr4FZ0UBDzdRbYfNq4NrZPelD/n+vWXt4ztw6FB4pU3v6KX52Z6Jv2CUeVh92
         0OT6lT46csdhJ8S0tO8o7/9iCg+BALV1Yc5PuHJhRz+7wqtD9aHBcy50APsbf5Q8Ybky
         Eh8sN4wmcAwT3PsxbIrOWSddRZ0gZmLNVCA1JzHms7WxOKZD3ziEgFubigLVkiGWha4G
         HOqQ==
X-Gm-Message-State: AOJu0Ywe6FQ1Zn6yVxVKK+AVAON/+qR7Jbmid8JLXnUG65JxNNeZ5rKJ
	Jw+2bhvWw64T+hA5/GYNn64Jca+e+m9/F/lRLbIg9oq0RBinDZUf2Xb3pJNz6x4=
X-Google-Smtp-Source: AGHT+IHlqZn5apC0OcSNN2Acf7t6Aaryh00SY4kbBmWqx0XsIPRgDEaqwCciuHNYKlmHRmoA8cxoSQ==
X-Received: by 2002:a05:600c:138e:b0:40e:fbdd:238a with SMTP id u14-20020a05600c138e00b0040efbdd238amr2123576wmf.37.1706725356765;
        Wed, 31 Jan 2024 10:22:36 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id n36-20020a05600c3ba400b0040ed1d6ce7csm2265786wms.46.2024.01.31.10.22.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 10:22:36 -0800 (PST)
Message-ID: <4e8c1025-fcea-45fc-bec4-5b377b7064ac@linaro.org>
Date: Wed, 31 Jan 2024 19:22:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: timer: renesas,tmu: Document input
 capture interrupt
Content-Language: en-US
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, devicetree@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <8cb38b5236213a467c6c0073f97ccc4bfd5a39ff.1706717378.git.geert+renesas@glider.be>
 <20240131180013.GE2544372@ragnatech.se>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240131180013.GE2544372@ragnatech.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 31/01/2024 19:00, Niklas Söderlund wrote:
> Hi Geert,
> 
> Thanks for your work.
> 
> On 2024-01-31 17:11:45 +0100, Geert Uytterhoeven wrote:
>> Some Timer Unit (TMU) instances with 3 channels support a fourth
>> interrupt: an input capture interrupt for the third channel.
>>
>> While at it, document the meaning of the four interrupts, and add
>> "interrupt-names" for clarity.
>>
>> Update the example to match reality.
>>
>> Inspired by a patch by Yoshinori Sato for SH.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> 

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog



Return-Path: <linux-kernel+bounces-79260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF735861FC1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0CD71C23B48
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BC814CAC3;
	Fri, 23 Feb 2024 22:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ncM61nZw"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3246C14CACC
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 22:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708727266; cv=none; b=CGfh1amq/b8Iguek8Z2mkT9OKT5OrhprDsaEIeBlhICZx31eimNndLnw984UxeLd/K5X/1RJtGwq1pzHmSsVi4gJuA79UcnwPK05J+q2UVCn1X/IIFAEOqNlDhyQgLBbTds9HoBu88PqP/HesdpWOv4WMsn7G6+rEtHVn7fCnr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708727266; c=relaxed/simple;
	bh=C09P/fYLTlcYhPEKEzo0c+Q8OizrnciIo0/Ml29193w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iLsZXMkYVsgu7TMk4l53cPPsQKTVogsNj9ioHowYdW3iUf19kLHwBKGad4NY1vYJNSLDKKGmFt5qzMJrwm5wjrN5yugsSXhnH3+eN/8BxEUsgWrewmgZeromQj99gcAlSGy7GZzwrhm/I32IU7vjmagve9KZC1TiYMYAwg5hPqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ncM61nZw; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41296e2c2faso5693925e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 14:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708727262; x=1709332062; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HppqBtas3L0GcMMoGYXdcb8iGGz9VbwRhKoehMa5r/A=;
        b=ncM61nZwUBE0kw04qfJek0hqnl0zi1YNSQKEw81OX4N2Q5Jpd+NW9Sym1YaLbDjcjW
         J7l0Ft9LU2sTMO2lk+Ydl9vbSKnmhd0MV1RRQoe1lk6R2FlX/qtRNlOvANOxw6sFSY8T
         6dvnOjQRLk1Qs0EEo8Ijs9RbOx9Wd3+Uyjjfbqzo6LZ6EmyBEf2WeJdyBQ5P0FrxrXK/
         AN/ZTN7EAdA+m30AKG+xNJVE4tWgSLIkNApBFeTDdOGgOkqMpmmOMIQh73ALTlCuXI0Z
         YfJBc6JgPJZ4/PcX+u1PNsPilkrMuUkTDNH/1vqxv0LP5oXP1S5asCigfr/UcqUEnmQ+
         KyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708727262; x=1709332062;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HppqBtas3L0GcMMoGYXdcb8iGGz9VbwRhKoehMa5r/A=;
        b=fW1CRj0npPwl/+1f/MKWMl81FhG2OTsrikScgTVJOuIneHczkOIFQcJ3pM8fpjQIPI
         FAYdNRki1eCFY/+kwpO8IB92ni3rg3B1eYhy2200qExsfVX8/d8Jr8To9rAsvpnz9SiZ
         xYsMw5P4Rv5c5KLDc1jlg/wdlt0x8n80Qnva2zQK2v52OBfei8N76E+g0RiJPNiiEn0p
         zOHD0KtbH5W4qSub/w9ztPCy5ngnHSWh9pZXc/b7q3eJzmgMjyVfgkowMA7YqAo92FWr
         TV1NIHVhms4+L3Mb1qxqBBI7r7R/StRwqQkk1clEADE7ZxKxyQ8EEjP3Xdbk3buSUGIS
         SlCg==
X-Forwarded-Encrypted: i=1; AJvYcCXD8nBhRgiMIZpBWsN61wcCT/6RR4R7mY7DsKQPPQ0rZEKPr3weoDAhcPCHt+636PHvsWLDxvje/5KEr8EvnDofhVlUPUNJQAe/gKKr
X-Gm-Message-State: AOJu0Yxhpq3Z8FNVSwO87gDZs7ATDrVnOZifFe7mbjxkEDiIIOMRjr3W
	ymoH/Ddumy1XP4GqoOQdPlddI4rLM9b87laRzoXUrVopVZ+0wfE9C2M6nMYWvSA=
X-Google-Smtp-Source: AGHT+IGMPQ9dJIjGP5P9kCYlzJvqtkW8nMIE5M35DaKFRXMNDeLKnqDZqpvxZpfruPGst+gPon/EuA==
X-Received: by 2002:a05:600c:4e8c:b0:410:8d28:800f with SMTP id f12-20020a05600c4e8c00b004108d28800fmr782327wmq.9.1708727262323;
        Fri, 23 Feb 2024 14:27:42 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id bp4-20020a5d5a84000000b0033d47c6073esm4959045wrb.12.2024.02.23.14.27.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 14:27:41 -0800 (PST)
Message-ID: <c93b9ec4-2447-4be1-b316-3395d35eb8f5@linaro.org>
Date: Fri, 23 Feb 2024 23:27:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] thermal/drivers/sun8i: Don't fail probe due to zone
 registration failure
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>, Vasily Khoruzhick <anarsoul@gmail.com>,
 Yangtao Li <tiny.windzz@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>
Cc: Hugh Dickins <hughd@google.com>, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240123-thermal-sun8i-registration-v3-1-3e5771b1bbdd@kernel.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240123-thermal-sun8i-registration-v3-1-3e5771b1bbdd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/01/2024 00:33, Mark Brown wrote:
> Currently the sun8i thermal driver will fail to probe if any of the
> thermal zones it is registering fails to register with the thermal core.
> Since we currently do not define any trip points for the GPU thermal
> zones on at least A64 or H5 this means that we have no thermal support
> on these platforms:
> 
> [    1.698703] thermal_sys: Failed to find 'trips' node
> [    1.698707] thermal_sys: Failed to find trip points for thermal-sensor id=1
> 
> even though the main CPU thermal zone on both SoCs is fully configured.
> This does not seem ideal, while we may not be able to use all the zones
> it seems better to have those zones which are usable be operational.
> Instead just carry on registering zones if we get any non-deferral
> error, allowing use of those zones which are usable.
> 
> This means that we also need to update the interrupt handler to not
> attempt to notify the core for events on zones which we have not
> registered, I didn't see an ability to mask individual interrupts and
> I would expect that interrupts would still be indicated in the ISR even
> if they were masked.
> 
> Reviewed-by: Vasily Khoruzhick <anarsoul@gmail.com>
> Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog



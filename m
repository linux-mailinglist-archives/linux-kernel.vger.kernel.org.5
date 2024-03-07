Return-Path: <linux-kernel+bounces-95233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 578C7874B02
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14499281E2B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05C083CBB;
	Thu,  7 Mar 2024 09:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h551t8T5"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8276083CD4
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 09:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709804205; cv=none; b=KVwjtf8d814ZcYxxjSM0nivJ29TVhpoCZuJvht0t0qSj7DOczasRQMgF04ggugasXHXA6mQFtZhI4un9yuGbj4ZgJfsMlAbAZod1TYDVcTG8qvUExQxQl1FaQjToHd3tu1soeybK7T2N8+UhVXPCDcUwxukOZ3yh1W74kumujeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709804205; c=relaxed/simple;
	bh=YGXQZyA43MxFpMSkBG9HcAKzDDQ/XEwm+g2G+GfvRko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UjTE5Zd/GLB1jRVlLaotJ0FTogvcdBDNI+f3J2VP1gvRz/q1TX87cb+elcYcO76Ytj2SUWPcrAv2Su5cwo9KN9Dm3XCCM9tcqSmodjcqFR6uFJicCQ/ZBJmM1rz56l076gP91udkWgV953DQhE5hoWrbr38xRxqndp/O1OLL4YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h551t8T5; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41312c3ab40so1049825e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 01:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709804202; x=1710409002; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=blXg0re3pMK1y8kknPqEyLHNcG5hpzcC6xBwN7/JFrI=;
        b=h551t8T5Z1idT1pd+Lgnb9Wh/V+kloiBt4wToeOw8T2SzZE2GPlWohXOUiULFphzP8
         Bzlwj67drKqNDKmxelctQZ7NcIkD4o8txo54bGBKacm/FZlXWmyfg8B3PmVws39/2brO
         OD+227GGyc4FTef7Py54aJuEJMDTsDiiZUdVowS3aBWJieEwJgU/aXjNXqi1xNTSgzR0
         zFAcvNEJELxNq9MBFnXr/BxEa3nYNVLWelFdRPTAab3CZUdBeeqdHi+ruYvn5OII/1AX
         psYzFXr4x4yUmPdhpm6sJPWRDu33EWndzpL1THVZM0OMfjcyT/oP2bLdGpdkcwo7fjC6
         yW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709804202; x=1710409002;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=blXg0re3pMK1y8kknPqEyLHNcG5hpzcC6xBwN7/JFrI=;
        b=hjxLnwsgS5Wtj/LqL7oiThQe5i/lXt6tbbtZp5GCiWsgw9fAPI0k9n30bBE2+AzmnA
         FKURyaGOaR5v526B+LWXIOZL5mxn6Ay0xCwTg+Z23u2bj4usyn7Ze4mNh/Idpd9GHscK
         zsDHN9B/BW0x7TFCLuspl3lbofzTWCFedu/+gVoH9HrN7+jc1Pezjb9HpKT3faA9Sipo
         l8drEac+L0RBDG7Mu6xmMlCu13q48C0ZpI9n4AYAgDpXvMNr15bel0JE+BgFjA/r2AvM
         /mLjaDuAHcYP8hdS7CMaNCX/W/0Z3/A97g4FDT7PJqlxgfw1EbLookEhePiPJ2At5BJz
         3D/g==
X-Forwarded-Encrypted: i=1; AJvYcCXcd8rsE/TxawlRwYpDNzUhD7icd9GftdoGHvgYSyISoDFxz3CEg2TjqTk5qvguoJGEkF0mSwSVdGFUvRPpPvK+SOtzSQ+CYcI+qrl9
X-Gm-Message-State: AOJu0YxHR+bErUwfg318u8MjMhYwO9yQ5sguV70GybbN3kZiYxFWPGfY
	BtedWIG5ffuxCXVx2RF5JaSYFFWFs0tFgHZIfSkGja+gYiYZv3t8jx22FCYmUefcZonowV1O/Dd
	d
X-Google-Smtp-Source: AGHT+IGJmUMGpzUunWLnUHl5R/CJ6c5Zf2CifilxJkYujlGC4l1Mt2ucbrRAbMbOWZupIS2ODMQklw==
X-Received: by 2002:a5d:550f:0:b0:33d:f883:4fae with SMTP id b15-20020a5d550f000000b0033df8834faemr12135601wrv.64.1709804201831;
        Thu, 07 Mar 2024 01:36:41 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id bj1-20020a0560001e0100b0033e48db23bdsm7107211wrb.100.2024.03.07.01.36.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 01:36:41 -0800 (PST)
Message-ID: <1accaae2-b034-4afe-bb80-98209b42c348@linaro.org>
Date: Thu, 7 Mar 2024 10:36:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Assume polling-delay(-passive) = 0 when absent
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240125-topic-thermal-v1-0-3c9d4dced138@linaro.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240125-topic-thermal-v1-0-3c9d4dced138@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25/01/2024 13:11, Konrad Dybcio wrote:
> As it stands, setting 0 explicitly feels like spam inside the DTs.
> This series simplifies it.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog



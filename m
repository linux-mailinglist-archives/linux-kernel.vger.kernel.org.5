Return-Path: <linux-kernel+bounces-56344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9A884C8F8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49667284B62
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA08417559;
	Wed,  7 Feb 2024 10:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/lnjGSJ"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802F314A9F;
	Wed,  7 Feb 2024 10:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707303059; cv=none; b=ReBdTo1Tp7O/CfzMKKX00O7iRTlobt9sNG1gNHcdrWfnaXFF3dpgYWwXQcjba6PKfnJBv/k0+/WwteyhtDT3Yl1pkvH0xNUhQRtavPHIQvFlx0sVdmUlfAs9DgoEyyYsT7NxV9+R4qTVfxLyguRvwg0cmexeqxq4eBu1xzQfhV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707303059; c=relaxed/simple;
	bh=NRKAhvvx7ipTSFAI46idp0Ld9WXXVjH+rnutwv8ffzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=degKTG1aLlGlmEQnUqldcB540jW9ng1Rul1ZPSPXgwj1ptPQ26fFXqUEZRTQIDRxyrphOAlTGJAoEQMBBiSY0CXGUtp1h6gLoTPCGKEW14T36lg0cSaDvI783yizu+pHsP1EoXg2i2UQqNntZeg+4QUKWZPCyXOvHzoOexsrBQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/lnjGSJ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a383016f428so51324966b.2;
        Wed, 07 Feb 2024 02:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707303056; x=1707907856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v3RmONeN1aWOfGtsR0Ww5qsPyB7Fzz/W0DvQ1KxYknQ=;
        b=E/lnjGSJt76C+QEQbxmm+xwxYat3K1vKSZBh3rxrmE2FNLa3Po1eXpbc4fWwE30mqF
         jgn0yEY4NUikP4g4ywKjnC5WEyqo/A+Y+4B5KueOlKHpNfnkkMyagN5mV9eGjKLjd0uO
         UgXdmT92FrKGyjtknHzLmyLhFd3FrD4/5CIRDD8IMZX4/OcpTdR34SdmLq+GTuZ6ZbX2
         2AloLvapVRDeofi9RPnQhz+b2pOzNox19VYXAUURm1+NVgqIqGQNVPJZzJFlD0a3BM7p
         GOtL3I979/PeL5l6pTZ/Q74Nt54xjBXXBjH/uQj3eus3IAmV70sm4m0LCvugOmaPxjkQ
         N4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707303056; x=1707907856;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v3RmONeN1aWOfGtsR0Ww5qsPyB7Fzz/W0DvQ1KxYknQ=;
        b=tk7w7Ioh+WoTy75LPpa2961aiq/QeQE12020gkgEDsNXzzoxwcL4sU8m5ITzD3YnGR
         G/8WhDSNwkGPH8GPqycr6vEsy2xah24DsIBWfHir62nBq8qdCccKJ9ARj17x5QBBlzdm
         C+w5WXuUngQakiWEeYgWegvWVJuw1/zYhG8omxkJXh/ss993igzPkwWDMSoWtU5X67lq
         R/aGFbQHtnDRmbghxOLfwUU+MIeqAFj5XTKGOpBi1Czl7JDOxCGWY6G5NA6hkuwF3D+p
         ud3VSbyAO4oPdOxZz+8z0NOQf5S4SFVkIT7KFuWgKqhx+zxVqwvEGLysbNo/Dwt6d2qD
         euUg==
X-Forwarded-Encrypted: i=1; AJvYcCUctbnQnC79CqRuPxaQT90gS2iQLV8GjGoUwDPmje3yTuvSDqptK2rbZujIiYOysTfEeeEuUkYvZUJ3EyUXcKJs4DxQ0Lg0GW+kN3WA0ykgVjTaubC06DFR3iqPGpcM3gcpb6njfjk/CQ==
X-Gm-Message-State: AOJu0Yz3gVbGqEYnTyvBdRpaQBk257cua1EOFG//hJONG+6uB3GVmYDm
	j0mK8rqZ66BsQY74wH1i4XMsoadYE2DyFVbagly9QWR0o31jqFRFkyCcz/sF344=
X-Google-Smtp-Source: AGHT+IGrHQ4Ui8Xm/HTFLN9s8F76B1TcVewU0Ndl0+KkjzPxt4GxduUdssKCe6aiw7H7DO4tXx2V6w==
X-Received: by 2002:a17:907:9197:b0:a38:c07:7d51 with SMTP id bp23-20020a170907919700b00a380c077d51mr3820777ejb.59.1707303055484;
        Wed, 07 Feb 2024 02:50:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXAN0HywYSFmAn9SSnww0M967qD9WTRDtEZgy+zMjMvlextyFsTop1Mao9C9tu21Mde/XAs/JbotcCQ1IOdMW+agjnk9tCPB2J6HM6eV6c+ZPs35CkS74EhshaBMyAmRwF97DdyJjitj3pclSF015DFIZzTwZMv4pN+P5QYRoi7El+iIeoAd4Nqk9ZgZpgGf6+sHm8rAv4LqRTTHYFksB6wVb9cdVLxjOPEFLK4SLZX4VlYhSdG+rAwm8IiTqPDGcZv2M9l0ziE2O1cbpc6YQUEoBV8LRYuN8k+odthVuuKPEJkXUVoUqUrYac8CvcV0Fb3BYMxS7YaaQ8lAroNmapR4OemXpyGfxgQ6QdzlDRu
Received: from [192.168.3.110] ([86.38.52.161])
        by smtp.gmail.com with ESMTPSA id h9-20020a17090619c900b00a35ed4fd4cesm619443ejd.115.2024.02.07.02.50.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 02:50:54 -0800 (PST)
Message-ID: <0dab8d77-ea4e-4cea-99dd-2ffe7c9051d5@gmail.com>
Date: Wed, 7 Feb 2024 12:50:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pinctrl: mcp23s08: Check only GPIOs which have
 interrupts enabled
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
 akaessens@gmail.com, thomas.preston@codethink.co.uk,
 preid@electromag.com.au, u.kleine-koenig@pengutronix.de,
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 arturas.moskvinas@gmail.com
References: <ZcDpDaclAXEa5ETN@smile.fi.intel.com>
From: Arturas Moskvinas <arturas.moskvinas@gmail.com>
In-Reply-To: <ZcDpDaclAXEa5ETN@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/5/24 15:56, Andy Shevchenko wrote:
>> Do you want that information to be added as part of commit message or
>> information in the mailing thread will be enough?
> Up to maintainers. I'm fine with this email. If Linus uses b4 to generate
> a Link tag to this discussion it will be enough (in my opinion).

Is there anything left for me to update/change? Or we're waiting for 
other reviewers and/or Linus to chime in?

Arturas Moskvinas


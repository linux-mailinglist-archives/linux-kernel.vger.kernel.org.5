Return-Path: <linux-kernel+bounces-49466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DAA846AAF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8074D1F26C05
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABC718AF9;
	Fri,  2 Feb 2024 08:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UQFYLklI"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00767199A7
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 08:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706862227; cv=none; b=qoIB2h9+zomL7gJ/mAsL8kuGRfPrjvrAW0Pq5SYyy9UMIPPpL5c66MOMK2sIlfPA/5vZ14k8YPWWkEoXKLpI8NwILHzsDvr1vYTkbimYzcqW2mLN/dGw2TfIivsioObsJOtBWALG1bfOYRJpPLsSNNxJKleTaNRf9atK7gWCZCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706862227; c=relaxed/simple;
	bh=Db8Srec2DP/U7ml0e4GE9L2z+58R0B70UoeQGUaihyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UWIpPWsN7GfWQ5skAbHYsCa6ePuZZIvtxdvXJa4Z5gS1Se5B2NNcYbNM5DGx3qhjIq7UnYvjZUOf2y0cjVXLR/f6Gva21wtesypi6l4idzj/oVfpf9OrB9E7RW6Evq716LhxsUSOF6c1ijG0HdW8vLZayr+RQUEvDWr16p8kpX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UQFYLklI; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3bec3e5358aso222022b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 00:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706862225; x=1707467025; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ER65IywYIvJHyQc+F+Ka9tigNEb329nFaYD/j937Uu0=;
        b=UQFYLklIkbfkrVxiVIaSBSNEe8Ah+Aa+gURuA+39b/sTgy5dh4b13fNU7bWO1n39In
         8jSmNTWcGg7KfM/PWUWRYLkUuyIy8u1rTTMcGmH6OZKXF35OVKovhRmGhlY3fZ+5PwS0
         Z44ftY16wobpsFD9hkMdJOiIznWLuMeM2DUNMOwpIYDAaaQkZ0QpwBGhDJLSBsXVF8qe
         267Vdt8xJrar2eP9pV7pzpV7l7nStrofceV0VwKJHx8w0QeRrVBl/Fzatlk/IzNuF/e+
         WpjSkj1yf9TMpQ4QFEWyz8sui8u+/7PmMwi1wdG50rNOfog2Hdiv6ZgXDxaXyyBPu50z
         AkXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706862225; x=1707467025;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ER65IywYIvJHyQc+F+Ka9tigNEb329nFaYD/j937Uu0=;
        b=u4Rj2DhNG+Jv0W1vHZcP08jX6iNwW67/LXbbLG5VCiNQGRuCAcTD6o6fKvpNO+yoKg
         coWlIiP2lwaH2U+jCwUZHITweQkVO8R5UohGAKfHq1+fFx7NRWe39EBVC85I0cpm3muU
         p/o5887lE1e2MGxeIKiXD3eS2zwQlv4hGAt78z8WQkzmqyB/olDw1GLoO46kKbXz1jUb
         +t2y26Jjy8cHGJclRZR2YNQMOlgpKxfJK+wZ3p92spvER3/avkicnGJLorEwFxVivI5U
         pnI2iAVjZ9TrG6Eifk8kTkL8/IBSoKUD9J0Z7VYqhfWi6FDlMqO6SoNgHzhO1a0gIKxz
         WEYg==
X-Gm-Message-State: AOJu0YyXddGs2NM3IpW0+zxA0fsQdX7tKybV2CDf5ffAA/uXfZ4DDJ+J
	nUlYrI15kQtuL2KjHLBSnb8/Hel6EQyZ6hyCvY3dclOclUO47sgV8SXZXxZ2o7g=
X-Google-Smtp-Source: AGHT+IFJGxTg6JrHTx3B7BDK4GcZtd9mnvOvvoh8akd5QM7tPUvJi7pZXd8QSRYnBmeHqvBqooTYEA==
X-Received: by 2002:a05:6808:189b:b0:3bc:d58:cb2e with SMTP id bi27-20020a056808189b00b003bc0d58cb2emr716422oib.18.1706862224997;
        Fri, 02 Feb 2024 00:23:44 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWWmD4J6+lyuEkj0J6GL4c64ioWbrU/BNvlYbfr8y8ogiy+WUxWyUXn03wxWRL+NqD3wq4iHLa/RVp4fjj/ZlgJ1uN2//++fem8qr1L28IWgCSVDkZzdUS/hdsReB3lEB4JYcS/unqU/HENkY2bR3oP+M5hgxSV4YM+y4KI7nRkWLJyHuS5ZloGBMBVOM3gjq9uzdXSlfxVkHePDC7PcNLIjQ5iVLZFNYmYaTxs31kKnEovdl+sVbOj4gkI8RbuTfDS6Jew1vLe4CxkAiu5Ghkc2HgUq2CxtAMv94hjjv5cW1uCjKe3DAkwRhi+khtMaBDNVzIXFUQtPsTHC/LpyGIYkAejmluen5y2ZlUmgy5GMYBvO4OvEcUo+nWopv/yRp4bUTybJG3+2hpZG6Ec+JcFYfzb37v0rkMmzAmwZhaaqGjTDGPCPa1pfEMRqWoxa2ACAKOmY6bAj6oLG/dAycvLwt6SvTcR7X8le4rO6pwqONGqH1GGDBokUDT78eKfDyEQwOovuC1upPgj91Xt0VN6p6g8AjHSM+ooWeIH/8NBRfcn15JTEoiU3ZYGjIrnFBuocJIiETpHbhgDhmuswib0s2/8LT4SsoIEUW1ztXUqKp4W2H/idL/XyMYCPHQ0eog9AqXC2dTxThg2hlOvL8YideS459JpNxU2e91RNs/KNRNmP8yZrYEsVm1/z1RRiYhiVWWvh7eu
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id f13-20020a4ace8d000000b0059c844e9045sm297997oos.36.2024.02.02.00.23.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 00:23:44 -0800 (PST)
Message-ID: <49dbd0a2-a4b9-4c05-bb10-44f267672374@linaro.org>
Date: Fri, 2 Feb 2024 09:23:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] dt-bindings: net: fec: add iommus property
Content-Language: en-US
To: Frank Li <Frank.Li@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
 Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, imx@lists.linux.dev
References: <20240201-8qm_smmu-v2-0-3d12a80201a3@nxp.com>
 <20240201-8qm_smmu-v2-2-3d12a80201a3@nxp.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240201-8qm_smmu-v2-2-3d12a80201a3@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/02/2024 21:22, Frank Li wrote:
> iMX8QM have iommu. Add proerty 'iommus'.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



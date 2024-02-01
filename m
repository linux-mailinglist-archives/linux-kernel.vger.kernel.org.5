Return-Path: <linux-kernel+bounces-47972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0BE845584
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 105501F23D63
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACA515CD4A;
	Thu,  1 Feb 2024 10:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j54zVivX"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887565A0E5
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 10:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706783775; cv=none; b=TqnijOljI0bp2F/wL6WfyLNVEChp5dBhXBIOmKLtdpyMRADM+4v5XXReAdDCtV3bnXNnztrv4VyLTUJubiNZjShLDLZoMND2tJfTNWJ3FfeXh81+spDWtCLfPMzgE4AMFFw8J9EOe4ZIXGsQxIMEIygEd4M8iRMQs/fadGZXF5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706783775; c=relaxed/simple;
	bh=+MmDCb/Sbf4GabyMFR8FHde3CAa9BScDlXR7nEcoyoE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rWjJvo19Uw/dwXiEKqLPdcanLEzyeIclgK/Ti6uyLDhtMfK23ap8X6vxI42PIWpwlQu7o2pXqWBltfIqwjxpWneTtBEI6hafKr1P/vrLYqfWPJZQHpicwKZvT3Q8z2wGZTmN7nk+zczZ4zsKHbBlR1+O9p3AzXwuHwS9q7jFjw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j54zVivX; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a2a17f3217aso97867966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 02:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706783772; x=1707388572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RagYhx++3QaD9dF7UnANawI+12jdrYUj4uYmQvcCf2M=;
        b=j54zVivX5FkfvPIOzYntLeTBp9LdMo6BKPzdlNna4dXLaYOlhhdJAVd8eRVrQ1/sGf
         2aYlG8LrZ4nCr/42ldjfkJXjqf2RPi0fufMMekvpTY6BmynVeyalC1mwrVla2g3F5oOU
         rIrqKrH+0E/YSwjfXiqO6xwD3lWrbMHqGISFzE8p9r12QJxMFo0kE8H2xNlt0lCubETS
         uR3KAaZAe4DwPHUtJMQAM5K130waEJJhmqkpFy/0cgltoFL+O2YU1LzuZw8EcMwb0rnq
         o/mMwLio/XoSAy/ouUu4/s2EO8+qmBrV0sgw358KwRv8C4T3LOlfwNVYctNtclKdNOiN
         OuHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706783772; x=1707388572;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RagYhx++3QaD9dF7UnANawI+12jdrYUj4uYmQvcCf2M=;
        b=jiSilTKIb4aeUoqj00h/6IRaTPc0zIInY2vrajBZTxdElx4RUTkE//bhhfYzypobnJ
         vNuYXymt7en1p+H4sli4i1pD2HxnXVyIdexejtLh8jNXJi/nY9XMLu53FHhg0GX9Zz72
         UZfonTLA0i0J4spIM6Ooorjb1VH51ZCogHuBdprJmLPobssvURD8lW32IrKRpDW7B74e
         nYJg18urmvIMGMD511oAfIi1cBs+WsCWQXly7vXvlrUU2hQEbXBcUjn79peJzCZn+1oW
         16Im5sj5HEmUQkhgeC8P2toTFwMk+rtHDl24B4yqFvFfiplbGAYuvwQbc6lySOxnUzhY
         ZDYg==
X-Gm-Message-State: AOJu0YzyFbYX2h/SUrmlcKZCmCdBHJoS+LZ4CU1EeT+WBHDLrxyHgVQj
	YPOBA1LaMXUGjpcJuY/MYTs402hCSJ99oWyvLx05sABFBLoTeDxQkIEdhPlrCzY=
X-Google-Smtp-Source: AGHT+IFJE6WAEbpObKJQDTnuajIpQDDpUxJx5Upy+bpKoU7oIE9aCThr2XYOS+WHLJssZKs7dIQnDw==
X-Received: by 2002:a17:906:3953:b0:a36:bc20:9a40 with SMTP id g19-20020a170906395300b00a36bc209a40mr1014373eje.48.1706783771803;
        Thu, 01 Feb 2024 02:36:11 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXyzvgNxKFOQ2Ku1g1o+gPYMzBp+xEyQXjCDcKWFfVbitX7bbJesOg3hNepPTvI71GFKx+GIy/Eh+Mbhx/Dy0SC7SDh7yGSJmtlZs+sxBgAcaZk+NKgXQ99f32ewTYSWan84XXGXgprr2E4vEnMjVaGc0FZ3A81gHr1BDlk2TVCBN1ISAcK9VKfcX/t8Sch2YWJ5k4cS3AYfJWYgn1uhTLRGzu1d31DA9d30x/yfOJAdnAdM5MW3/ifP4nbHgPUAxRrYs44gD2UoeWWyDBLw1Sk23D023RLcqB7f8e9BKB1VhzCErjoEhdfmVmp/sO29p/8UAKZHEUSOI/iScNoUE9usfIJ6MtSsWcFvZE/Q+w9RjBd7RCMWMvaB9XR9W2ae4LT5GmeYzAEru6GDV9s84+H98sOQhqmPrKx+W2yZp9umi6qqntu9jmsDumayEu3ur1S0iniIQveh7qjZ4LBeHa3troZ1JVI6Y4strntZxozM1JcOLqKoaBQi/7JuXWwt7G9t7to4Ah8s9Cb5kSTZED5ym5agBW+30TlHyv7l4XVWDNai4h9QQe8ElVOmXhDUv89rSa9Z0K+ZvZn7PKMDuil0f02oT7C+t2uYJHFcMiGNxb1vMj0crtUxoJ6P0IL/tBSj7eAcvdUsFxaXufSgJnty/ea5nP1zp9A9HFBHc61pSotW4PeNQ==
Received: from [127.0.1.1] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id hu17-20020a170907a09100b00a3603b49889sm3041749ejc.21.2024.02.01.02.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 02:36:11 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: peter.griffin@linaro.org, mturquette@baylibre.com, sboyd@kernel.org, 
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
 tudor.ambarus@linaro.org, willmcvicker@google.com, 
 semen.protsenko@linaro.org, alim.akhtar@samsung.com, s.nawrocki@samsung.com, 
 tomasz.figa@gmail.com, cw00.choi@samsung.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20240130093812.1746512-5-andre.draszik@linaro.org>
References: <20240130093812.1746512-1-andre.draszik@linaro.org>
 <20240130093812.1746512-5-andre.draszik@linaro.org>
Subject: Re: (subset) [PATCH v2 4/6] arm64: dts: exynos: gs101: use correct
 clocks for usi_uart
Message-Id: <170678376968.179918.16892357043934653425.b4-ty@linaro.org>
Date: Thu, 01 Feb 2024 11:36:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4


On Tue, 30 Jan 2024 09:36:43 +0000, André Draszik wrote:
> Wrong pclk clocks have been used in this usi_uart instance here. For
> USI and UART, we need the ipclk and pclk, where pclk is the bus clock.
> Without it, nothing can work.
> 
> It is unclear what exactly is using USI0_UART_CLK, but it is not
> required for the IP to be operational at this stage, while pclk is.
> This also brings the DT in line with the clock names expected by the
> usi and uart drivers.
> 
> [...]

Applied, thanks!

[4/6] arm64: dts: exynos: gs101: use correct clocks for usi_uart
      https://git.kernel.org/krzk/linux/c/21e4e8807bfc7acc0fc9fe3ab69e1dc0662e7ce4

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>



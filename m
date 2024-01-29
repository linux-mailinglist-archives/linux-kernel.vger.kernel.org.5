Return-Path: <linux-kernel+bounces-42698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5190584053D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6A761F22A2C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7167B61679;
	Mon, 29 Jan 2024 12:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B9MVX1j8"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD14612CB
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 12:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706532266; cv=none; b=C9rgZwR4JrkaFofJTc2Yqpym8Sd7VzKKjd3Kuvd6P7WHIouth0O2a1XgN56nj6LOMTGQYVLWiSwh80ZaF2DO2LOHJ3QeQFdd5EXc/YloTHHL4ufzx7jMwTvJIQiHyMVRMeTrH+slsGOuZbW0nxJa7TBq3zifIaUJuNG71dniBrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706532266; c=relaxed/simple;
	bh=iwVv+KpgojzTz7UiwmCrNbljMrBZg86uVe4TR/XlwHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JaOXmCrSavqw9yTMYNB8hb8JsZAIhgYqe7FWQqEpdI2fBST2f5i1VdaetpPkwQMlyDjkZnzoAIdrUQ6q+btHxqo8oQRK2dMvvLNjFxFfyEs65Ds1CKQzduVlbvitr+lO8n6q0AIXHvmeEtgr0XDlPtatUlHuUwuI7DGS4iAPVgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B9MVX1j8; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so293592366b.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 04:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706532263; x=1707137063; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jyyVmj8UXdIVbn7EeSCjlw1l1jJogntZyHkx/8C4+fY=;
        b=B9MVX1j8iOKwvmWD3QAPD+AbWRZ3sdZW4ptzry3V9r/WnHBzNsfRNxqw395ABkCunE
         5TFBshl/6mPfoEEUV+8ZxwR6pZWsjbbrtjKUXPgGLDsZd2CwqjIkUY+X6huKb003gtqh
         shmfIqh8Lt4IYxhCilQHTPFP05yH7IcpNRu24pDUCX4/r5mvsF6HEGFtwhBHg/rq4aR3
         9nsUpLWIJ+zy7Hb2WOS2DDyPPylYwPBM4Ebt7dv/EWMd4RmCVsoZLuKWKwSisGhwdHxU
         we1HxbdAbv6nd44xuhnIwcsvP3YhB7XfttdsCIdiLBu8Y9WduzuzZARSbVYEGrMEK4GY
         6t9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706532263; x=1707137063;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jyyVmj8UXdIVbn7EeSCjlw1l1jJogntZyHkx/8C4+fY=;
        b=jYqxrm8hYsrXu1QKx4ozyK++FOwwK23PkFMdgFPV0cclV43HGjKQ+yDQxwI/Iyuz4w
         DABEvXhANb5d05FplUctcoX1FJrGjz5ZncVibutArWYl/2uVdVxRa7A5UdvscZZh8Hnx
         YhC7RufcEEfkKihMwFE10UCHXArfbuKCgYcDCaJLfeMgweLG2DeRvTiLUssKmiiaepbI
         po5kX6rUio56KXIs17tfpPFhFvH5L4n3OL/fvU/Ln0bKpBPgoGDQutW3nx4gBFtRtHx2
         TgdkWunuMStBSopjUBacBSVIBbgGDVcCKdkW2hPWOGdqV3Eq3g0Ml8L346dSKuJMUGP3
         DHlw==
X-Gm-Message-State: AOJu0YyIAeLjJUYdwdq1/+sc6YypYXbVbI7oImYNXYWcNK5qGPvXgaqa
	e4ODdhw5FT5BA13KvwEvCUt1zBJ9o1g4jhhSyWDfIz7WIF1YT1onUyAfa8F3/zA=
X-Google-Smtp-Source: AGHT+IHcXpDWBglEaMrnhlcTL7JB54poYiZiJo/8VdZd2NLCsiYyXGakojUQHAMn/oc6HZ1dQxwfnA==
X-Received: by 2002:a17:906:a219:b0:a35:6601:e401 with SMTP id r25-20020a170906a21900b00a356601e401mr3389607ejy.5.1706532263374;
        Mon, 29 Jan 2024 04:44:23 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id vg14-20020a170907d30e00b00a30f3e8838bsm3864736ejc.127.2024.01.29.04.44.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 04:44:22 -0800 (PST)
Message-ID: <93443d6e-50ac-4352-b579-71d5ee12e448@linaro.org>
Date: Mon, 29 Jan 2024 12:44:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] clk: samsung: gs-101: drop extra empty line
Content-Language: en-US
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 peter.griffin@linaro.org, mturquette@baylibre.com, sboyd@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
 willmcvicker@google.com, semen.protsenko@linaro.org,
 alim.akhtar@samsung.com, s.nawrocki@samsung.com, tomasz.figa@gmail.com,
 cw00.choi@samsung.com, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240127001926.495769-1-andre.draszik@linaro.org>
 <20240127001926.495769-2-andre.draszik@linaro.org>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240127001926.495769-2-andre.draszik@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/27/24 00:19, André Draszik wrote:
> There is an extra empty line here which doesn't exist in any of the
> other cmu code blocks in this file.
> 
> Drop it to align cmu_top with the rest of the file.
> 
> Signed-off-by: André Draszik <andre.draszik@linaro.org>

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

> ---
>  drivers/clk/samsung/clk-gs101.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/clk/samsung/clk-gs101.c b/drivers/clk/samsung/clk-gs101.c
> index 4a0520e825b6..27debbafdce4 100644
> --- a/drivers/clk/samsung/clk-gs101.c
> +++ b/drivers/clk/samsung/clk-gs101.c
> @@ -25,7 +25,6 @@
>  /* ---- CMU_TOP ------------------------------------------------------------- */
>  
>  /* Register Offset definitions for CMU_TOP (0x1e080000) */
> -
>  #define PLL_LOCKTIME_PLL_SHARED0			0x0000
>  #define PLL_LOCKTIME_PLL_SHARED1			0x0004
>  #define PLL_LOCKTIME_PLL_SHARED2			0x0008


Return-Path: <linux-kernel+bounces-117817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD88388AFEA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 823433469AC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40E917BAB;
	Mon, 25 Mar 2024 19:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L/7cYmFu"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BCB14AB8
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 19:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711394754; cv=none; b=rzqt1hpxHoKNRfB5USKNbPtMKRUskZI1XT86MGCcv6xgdGvYwOf8Nv5yWk7BXqSqtdLLQrgCe9LQfjoQsd/DBtEzP3el85HUJhRUNzHn4AeEmrHiNy6T8492zy0WazbHhQ5mMoeEC9RWJTzc+DiNgIs4kK22LHifvGFgnzStA3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711394754; c=relaxed/simple;
	bh=5DbOdJAImQwBDGYJfLIXIMetxlpVfavR4QpR0eimEmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kjUJaHGqpZq+2SOsXEOiwWq7ytQhueZqJNbuPsYOtWHpgCtCrqh4q3Pik7js6xXDFc/Qxw/nN1uzYMBXmrydyjtkgm9yye82PYnwjWAzPvd//WNE6ertuuNkSlZThX12T8tpnEr7IdF3z3WlGa+6rzUV4rqo1XOpaQxPWsZL/No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L/7cYmFu; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56c0d1bddc1so1735724a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711394751; x=1711999551; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zhzd9oDRoCpoYTYiG4L0KvJM6D9VmTbt9+sBGbPl95g=;
        b=L/7cYmFuNINQ6/Ux4o+Pqz4tw36r2MyyDArPIJXu8uGDWUIzcTr6PX/dYVaMawjO/6
         qMorpZL0P5+FXjDYmqeH5jFKeLFl1RPJ4RIPflMeuIbASZc/4YwlktHbxm5MJVJoMOvO
         lN0IlfN9+twmx/yAYJjb3arfBdmRGS5pjHSo1LVPwxh6fIihbMW3RYTLKiQRxGsjdS+Y
         3+rhX+3Bw7+joZLWIfBYFKWRva3RkDDr/wWgtjqaYuqg/Uku0RvdHMAqJWTYbXHc9QQO
         u+4h9b6azfBgDuf/X+jQqzo1guZqqnl575oReDp9F0jIX36QYw26Yd261BWqynh8y1+W
         z92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711394751; x=1711999551;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhzd9oDRoCpoYTYiG4L0KvJM6D9VmTbt9+sBGbPl95g=;
        b=MSfERSb2xh2PySrTH9fcESo1emRU23s/Y91egvCjxRU9SuNQBGUtRvp9LwclIncUMV
         y+iiZvOp3Rtj17gvJIywjFkFhIxXGfTK0h6lCBLGrdMllGGmvekfjmY7P1y1SpPN+a0c
         +ACuVVmJ2lG9bx7l2zLf8tXs0ARGqc4sgcMe2A1OPGvJMro2l0KK6KCR1Sf5qf0mJ1wc
         /GBsPo/wMO0ci4AXdCzuejzNV6EHEEXAIyQSOUwQZNclmv4S/RAkYRn/PkF4OJPHshC6
         kXrYseGWHaluMF4inPdVbbzmnUaTz9AEzkcvqJNP4Z4c+7O5kyJ8YumAg8Isf1js2BTn
         OZAg==
X-Forwarded-Encrypted: i=1; AJvYcCUs+LOGm6Uauek8GzHyBD3v5MPkwSclJaFuwEOMB/Z7VfsLzTPkGQeRHcnT9BVEZxFM95v3cVnaLORv02xuZ3KmrAK6UsjqvKnGc5oU
X-Gm-Message-State: AOJu0YyfMqnbIl8LGfdf5vGhvLen6UhPmOZgf1kqiw2mBdB7fNLuUreZ
	MlMZ9B1ciOhvjgS9poh440uaaIftOLtVQbhQnm5N/hmBhhroxbt1lb/6iTHZ1Dc=
X-Google-Smtp-Source: AGHT+IGaqEwapwXOwuuWbSZJHdyAehHC7lud1KUaHHtdE9INmIa0bsatP/OKlSb+Xk/tqkfY5PNvpQ==
X-Received: by 2002:a50:99d8:0:b0:568:3378:8fd4 with SMTP id n24-20020a5099d8000000b0056833788fd4mr6233029edb.11.1711394750684;
        Mon, 25 Mar 2024 12:25:50 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id p24-20020a05640210d800b0056baacff45csm3250222edu.69.2024.03.25.12.25.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 12:25:50 -0700 (PDT)
Message-ID: <d3770f5e-f3cc-40fd-a211-b229be46d974@linaro.org>
Date: Mon, 25 Mar 2024 20:25:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] clk: imx: add i.MX95 BLK CTL clk driver
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
References: <20240324-imx95-blk-ctl-v5-0-7a706174078a@nxp.com>
 <20240324-imx95-blk-ctl-v5-4-7a706174078a@nxp.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240324-imx95-blk-ctl-v5-4-7a706174078a@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/03/2024 08:52, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 

..

> +
> +static const struct of_device_id imx95_bc_of_match[] = {
> +	{ .compatible = "nxp,imx95-camera-csr", .data = &camblk_dev_data },
> +	{ .compatible = "nxp,imx95-display-master-csr", },
> +	{ .compatible = "nxp,imx95-lvds-csr", .data = &lvds_csr_dev_data },
> +	{ .compatible = "nxp,imx95-display-csr", .data = &dispmix_csr_dev_data },
> +	{ .compatible = "nxp,imx95-vpu-csr", .data = &vpublk_dev_data },
> +	{ /* Sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, imx95_bc_of_match);
> +
> +static struct platform_driver imx95_bc_driver = {
> +	.probe = imx95_bc_probe,
> +	.driver = {
> +		.name = "imx95-blk-ctl",
> +		.of_match_table = of_match_ptr(imx95_bc_of_match),

Drop of_match_ptr(), causes warnings. From where did you copy such code?
Which mainline driver has such pattern?

Best regards,
Krzysztof



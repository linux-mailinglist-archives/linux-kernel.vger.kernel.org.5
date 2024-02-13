Return-Path: <linux-kernel+bounces-63562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB05853157
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76BD91F237C3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C292B524B4;
	Tue, 13 Feb 2024 13:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EHKNkOjF"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436F25102A
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 13:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707829646; cv=none; b=exQuX4WQxzOfug0RMYDx6d8fdrYXSJd4zeE7ORkzFh/j6tzCGO5M/dDg4biUpsifeYChgKEZ4aE0jTbQvTGfgRX/hFz8vKcoJkBoAuTromTD3rlnq0jxBOuiNk1NGOR1t+88KEZHWmJEJHX8Nv6qyuL3ln5L/pGEjOl8hB16y+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707829646; c=relaxed/simple;
	bh=awm2ow9PGujkmVUcrrLZ5SQm8snQbXW+kssy9wgToVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j3o1j6lZNPDcTWZ6ggYOIwdvLGJac4/8oUrhby2IyHf9mx3n7Cz6ymEfiHJaH1i9+wy/686OBdCXqquNNumUmk4RSpSZZakAljPhpPufGp5dkCBs67gxrWb5iYfwUV4Bq4EI5gKLggOr63S5uPF89nkqjZBstv8KSGTj9RuILh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EHKNkOjF; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a30e445602cso1036923366b.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 05:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707829642; x=1708434442; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gVxaJna0CX31UM9puZRZMf8QLphdGcrpZmzcpVwpquM=;
        b=EHKNkOjFwhQthc+ygvyJRiGCyF16kMMtoDgHpSXBoXs1bc2E4CFvWps8NO43W3/tKQ
         cBt+ejfDVUg3JC/B3wb6t7sqmVFbLBId4wayjp9B9bPmK/zB7K+aEZ8cSSsHA9qkx9PM
         Jt2K3uQ+JOLuLNtQACok0Sw3AffMJB7v51iZwbYsCr8Xki1uDfIniJwMRqDc45b6MA1G
         xNNwTSixog+qzEbkZrlBRZz8WQ7BxADMfRlaqjrWu1em3d0QrntoUAydXnRfPhNN0uWW
         wEq5fdoIQsIgpkEeK4fts9W/H6jQ8CRrC4pINHnwkj3LDe2YDVNvMRY5epsF1FNN14TW
         fsZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707829642; x=1708434442;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gVxaJna0CX31UM9puZRZMf8QLphdGcrpZmzcpVwpquM=;
        b=pfUhA1YxnOTaPm7ydHb2R3b5kTUXOb8cF2d1/u6aILoq9A5/ug8jYVYj8sbkn2ucsh
         rBlRmavWc+vJ1KaLh2EXnp2d145Z8xt7eqb8EEYmRcQ5pZ+LHV3HE3R+FKtNnXd2GUgw
         1pvoCLtOxwmjDhW2TjJtIiTUpy9AfX0Qpqz9HCGzP9kOKPWIisKnNHw1rwhPcrPwU9Fq
         xl84L2ZcWzae47ZTI0859JCPoELHWQDhi8p4jCtZrIfrjZw9opmUkuc6gacrN4L02TRp
         cvBAtnk8BwzdcnotqHy2zTx0JmMsVy+I8co6clsQL5oMpr1nFiFoeD6W6NZPCNXw17RM
         emBQ==
X-Gm-Message-State: AOJu0YzDQh9VpGxLv9dW9+t1EwDCt6IcP59A/8jaIAlGY5JKPdOr7gsc
	lAXuGWLwMcMZM1ofTVi6FMZFf1IGUMaSLa7IZceb1v/WokQEFkE95vEDZKbaFck=
X-Google-Smtp-Source: AGHT+IFh1NVRDFsAmAeBfdnNCSRt5exaQnTNYHe6n1Mgo2czviZlZUmZ8bQ3e1yieENQ7rbKHkE7fg==
X-Received: by 2002:a17:906:4acf:b0:a3c:9cc4:99a0 with SMTP id u15-20020a1709064acf00b00a3c9cc499a0mr2225129ejt.16.1707829642511;
        Tue, 13 Feb 2024 05:07:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX0Q3w5wC18ljb0qoHP4W0gjT5C9FMsg90LWcTcV3wkk7aNk2qADp+B3bmyfkFvwFeGmIUkwzJRGNdqvXKl0flkEHCueTi8o19epb5RlyDZdiUYDrNGQKAnWFhV19gto/smjWB6cdoMlPfDVfjm8Dj4D8djOjlfM2BeR3YAceEVjffs2f6R0cA/T1mrFgASwXsUp0q7cQAFTqrmZxdXR6g88hRCQVBmWunUsrH32lEZfqrM4xMlTGP3Hb+7+irz3MRkXzgs51V5foQ6DHVYRg225aLUGdw0
Received: from [192.168.86.110] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id vi13-20020a170907d40d00b00a3ce1bef210sm1130409ejc.28.2024.02.13.05.07.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 05:07:22 -0800 (PST)
Message-ID: <92d4d421-54a8-4a41-8b47-61ae39b55ebb@linaro.org>
Date: Tue, 13 Feb 2024 13:07:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvmem: mtk-efuse: Drop NVMEM device name
Content-Language: en-US
To: Chen-Yu Tsai <wenst@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 William-tw Lin <william-tw.lin@mediatek.com>
References: <20240130095656.3712469-1-wenst@chromium.org>
 <20240130095656.3712469-4-wenst@chromium.org>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20240130095656.3712469-4-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 30/01/2024 09:56, Chen-Yu Tsai wrote:
> The MT8183 has not one but two efuse devices. The static name and ID
> causes the second efuse device to fail to probe, due to duplicate sysfs
> entries.

have you considered using NVMEM_DEVID_AUTO?

--srini
> 
> With the rework of the mtk-socinfo driver, lookup by name is no longer
> necessary. The custom name can simply be dropped.
> 
> Fixes: 4e6102d60d88 ("nvmem: mtk-efuse: Register MediaTek socinfo driver from efuse")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>   drivers/nvmem/mtk-efuse.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/nvmem/mtk-efuse.c b/drivers/nvmem/mtk-efuse.c
> index f5bebcecf9bd..9caf04667341 100644
> --- a/drivers/nvmem/mtk-efuse.c
> +++ b/drivers/nvmem/mtk-efuse.c
> @@ -86,7 +86,6 @@ static int mtk_efuse_probe(struct platform_device *pdev)
>   	econfig.size = resource_size(res);
>   	econfig.priv = priv;
>   	econfig.dev = dev;
> -	econfig.name = "mtk-efuse";
>   	if (pdata->uses_post_processing)
>   		econfig.fixup_dt_cell_info = &mtk_efuse_fixup_dt_cell_info;
>   	nvmem = devm_nvmem_register(dev, &econfig);


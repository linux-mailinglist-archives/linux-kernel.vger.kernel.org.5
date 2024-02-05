Return-Path: <linux-kernel+bounces-53189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6B884A1DC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA5B2285187
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5812547F72;
	Mon,  5 Feb 2024 18:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUcpHxGF"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E3047F65
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 18:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707156854; cv=none; b=EN8Fh+4RoFCpvUl8AVUxmi/EgUMSnt91sPPDGhqNKdREgGQzKkaaysyuKkmka8xTjbD6OMKHOZQnNNzeCBL72+p+cV1S6UB73RldSqflMUfYlRaazNZuYQ917G+Wn5IUh3PbxtxBbpI9IaWe7LwKoXWddARppWV8rKyb+p4tYVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707156854; c=relaxed/simple;
	bh=EY4hs20oX0mr1gYQJEJz+1Hmu7pWTI0ZEk8DKNCayfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rM3FKm3PDpLAubEYh9iorznpRChQp0zmvk7Lb5XpegWqax6vDz/pUPfSq2OvfjqQHwleZ9+pVjEyHdRyduXFnFY4OAa4mfItGlkeOoNgBD3xvvar/F4qWwkUuNY+tIqqG7XLPgPdfjlVxO6VzucsxPUgssXPHuhErZaT7RCrN/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUcpHxGF; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40fdd5bbe65so7602575e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 10:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707156851; x=1707761651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qr+Vq/S1r4X6aZjVDF0PrU45ogtRloS0UmBuISXNtMI=;
        b=UUcpHxGF9Y9+gICHErkFPGakpKZz1Q+KQuTlFz9dxxeDrzeqXKaLYRiK0Aa2UdnC6K
         4FxxdCklRiLFXbzjF2MoNBXUDS3pHzjMoQMaI+sHGvts+xRBY6ySjZtOSKhCGXDs5b4l
         /NqGDD5NXyxox7wq4VbXhrkpk/VvV9rLT5LlpOj9FEnsQZr9RzWBpr2fCZfiLdxBgG7j
         6+Dgc+Lf7Xd7uHMs/KHMg0SxkYddAk1UWVs3pljXl3GhAXoAQ70E+Ex9LTCT9tIaL6sc
         XMNP3oJ3N15wnnOyafGE4R7ohTohCcV+FUiMKDp52EnfcwD0ZsP54NCLkVENbbj3hEoD
         w0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707156851; x=1707761651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qr+Vq/S1r4X6aZjVDF0PrU45ogtRloS0UmBuISXNtMI=;
        b=bqvcm7TJkatU2MXKHO/BVAC6Zzvy0A4BIq7mBsDoED6NIUJpoaaCW8kcckR1mgib5x
         Lbrvtw6Gz2jIkhmGIiD+FHwaVtNoYiBeV1BwAC1Uw9cLQO59Vdw4L5yeNqp15wBRi3AF
         nfEdNCX4BKaemjt4IxEIc77L7FLdoWMrAd4LDYwd4P1LgQYYRS4v18Qzl08xMRt1W9Wx
         E32DHdhGt0UJb0geoEsJAhYMw2rHswJmWhTYjSQZRLbRVGwihOJg9DM8v2ysjJDUjxiL
         hMoTNoveKVFiQvrR/BnevhqJ70cZupKzDuU7eaEysdYqZZs4imQibN8e7dyb/NFDpEO7
         iMiA==
X-Gm-Message-State: AOJu0Ywc6Gk9YCOfAaSkkqZPThROiiSyV6E9/9YmPNydgJEfuhyHttr9
	BQdp2kRt/Dp8yqhW9bThF+LDbEIkG3JKmuW8B4Zi+nLmtHdKw4US
X-Google-Smtp-Source: AGHT+IF0wujzR+3gQ56QlL+FI5opt3CJKtvlwe+T2+Vdq05+o2wxVVN/hC3axtbK0Rj9lxWUjg/8kw==
X-Received: by 2002:a05:600c:19c8:b0:40e:f557:738d with SMTP id u8-20020a05600c19c800b0040ef557738dmr383821wmq.26.1707156851150;
        Mon, 05 Feb 2024 10:14:11 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVqIDzbypmAayHCkhdRi5vwvjHNh2aKNp3koseOzKUJx1C6WLjwtBw10a38BZZ+ME81zmG6yoeqO0QH49yXF17+q1Bq5DNFVhKbPGNn+IiGir6kyWCt7r/7J7kFe1Mjg6BO16OkPkrP6J825lsMBh+jENEbf9ivCWqsdAQyHqICoXSgD7/9+0Li1xtkjkJ98iqJNMdNW89e8zsWGohMesN2YeKkXI+fuEoYjr4VGLQd/g==
Received: from jernej-laptop.localnet (82-149-13-182.dynamic.telemach.net. [82.149.13.182])
        by smtp.gmail.com with ESMTPSA id h2-20020a05600c350200b0040fd24653d4sm558504wmq.36.2024.02.05.10.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 10:14:10 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
 "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Ricardo B. Marliere" <ricardo@marliere.net>
Subject: Re: [PATCH] bus: sunxi-rsb: make sunxi_rsb_bus const
Date: Mon, 05 Feb 2024 19:14:09 +0100
Message-ID: <10412979.nUPlyArG6x@jernej-laptop>
In-Reply-To: <20240204-bus_cleanup-bus-v1-1-bda309c4b829@marliere.net>
References: <20240204-bus_cleanup-bus-v1-1-bda309c4b829@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne nedelja, 04. februar 2024 ob 16:56:44 CET je Ricardo B. Marliere napisal(a):
> Now that the driver core can properly handle constant struct bus_type,
> move the sunxi_rsb_bus variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/bus/sunxi-rsb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
> index fd3e9d82340a..1e29ba76615d 100644
> --- a/drivers/bus/sunxi-rsb.c
> +++ b/drivers/bus/sunxi-rsb.c
> @@ -128,7 +128,7 @@ struct sunxi_rsb {
>  };
>  
>  /* bus / slave device related functions */
> -static struct bus_type sunxi_rsb_bus;
> +static const struct bus_type sunxi_rsb_bus;
>  
>  static int sunxi_rsb_device_match(struct device *dev, struct device_driver *drv)
>  {
> @@ -177,7 +177,7 @@ static int sunxi_rsb_device_modalias(const struct device *dev, struct kobj_ueven
>  	return of_device_uevent_modalias(dev, env);
>  }
>  
> -static struct bus_type sunxi_rsb_bus = {
> +static const struct bus_type sunxi_rsb_bus = {
>  	.name		= RSB_CTRL_NAME,
>  	.match		= sunxi_rsb_device_match,
>  	.probe		= sunxi_rsb_device_probe,
> 
> ---
> base-commit: 38ed19495066966979ba821b9e0f549ad5ea620d
> change-id: 20240204-bus_cleanup-bus-de90b25d7ce6
> 
> Best regards,
> 






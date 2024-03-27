Return-Path: <linux-kernel+bounces-121446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BC588E7FC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79E1C1C2D2EF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CB4139CE9;
	Wed, 27 Mar 2024 14:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="a+rWgVjc"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CCC12A160
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 14:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711550210; cv=none; b=C/uEZrK6FZ7FxcTVAcLgxhr2RNaNH2Lkk2RdyyDya5DU/xNdhlJtWdC8q02aDwWygohVANH43ckOYfW7tcS4loqdmd0vE+IF1l0EFboir+Q4XgrDZE/yXEq6SapFa2OUdT5r5D9QLiaOW9ctv8p+D5QFCtTmu0b+U7rA1mf8I60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711550210; c=relaxed/simple;
	bh=Q/KH5De986+YQDYY63jQ1XxrYWt+9OXlph80pGoXLDE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HQbUu8poFZguPKuq7ajgRuxFkfayc8oBlyvqsRKYvMIkCU762xIlm8hwmFT4CLyFwPibvY4oh0mpifqcDcOLoCkDv3SCEBH8uVL9os0sUG4x9ehi6/A/d4DlHaBVhk/GsXghPC6XNDxtHqH+wbKoptAgIZfcxjhI0ONngW7noOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=a+rWgVjc; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7d07e8c5e04so24082439f.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 07:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711550208; x=1712155008; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tEYkR/Nfi8jTSq/VguaKTC9/VkGJ3raSs5Lkj4EEZLI=;
        b=a+rWgVjcLF5tpRRfOw6YVPgvxrstvKgNSyoan1o4ezw5uSVtiy78UqBoa8gB8pSYtY
         +Xue8m84/Wnjb0I4MZqqFfEiSHp2mRWrvrCBuoA8FMzZAnL+vzWGqjUuGtm+a/O+bTWm
         CVe5fV/yaZY+kz42Int1TaMTrkC1OnxfKIZ85/lRZHfAHDsWqJ3QNrA6ScwBT34Dws9x
         R4XOdeG+/ip+Us27mEM8HK/4hJfMatRLAy5EK2zmFN7v9caiNiClYl2mgSWTTgXHHsXm
         cslMqWxCstbi+TLj4ZiaotGdcatWsivY0QH9s+WZM1bfTQeUOwI/7aClC1rp7L9zOb8N
         CsIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711550208; x=1712155008;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tEYkR/Nfi8jTSq/VguaKTC9/VkGJ3raSs5Lkj4EEZLI=;
        b=rW8P692vbHed/ZEi7Yd/uLSrig4DPzoov6NU+RiUWMW7Xw6GRkUcfNJjn8CFAmFDhx
         L0GUFxpk7D4hJhmsiPj6fryybTnfUBB34I1hJbayGYtE4mFZXRn4B5FmBzAbT/CCEEKO
         7Nk5y6IxRsoiVv3AnVqoEIGkT7+ueAV0NXoWp4CfQUxuUv/Y7DnGGRkRZxBpKFDYQ4Lz
         Ezt9+6wnZNbxWYqFVG+XGkN7nG8hl0D9fxEd+Af3eTpjjg6Wl/01Z9GQ0T5UARboKowx
         X1PF1eqaYK6f4FaqCjBGofunaPMhhV8uM1lxR1GSzY42FTV0RrDqxyI/0fPnfAKkuyaP
         G+kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUL6+gGg+/vDmWyLz3Ubg2FjudqNaRibYRnc1lolZvrZ9R5KPBsYUKzvVAdFXtpmQf68OYcf/D/zyBzwp9Fy7U/T7+LXrES/Yof1tde
X-Gm-Message-State: AOJu0YwqEZ/ngE0+R08O0u7E3quiBm6n0s3c62KRHcSFr3KRb27YsLuY
	EoDbdjuo6R6jdmbYeEaSYAQpcaq9TpQPs4yTrbt1g2qjgosBOCfG0SPRQ7AHTXo=
X-Google-Smtp-Source: AGHT+IFeRODL8yMZ5WcnGLYjMBIAWH+NYfb77qScWDQqH0p/ehxbo5d+yAOPmfmccrv8puX74fVzFA==
X-Received: by 2002:a05:6602:3355:b0:7d0:2b19:ddc5 with SMTP id c21-20020a056602335500b007d02b19ddc5mr277874ioz.6.1711550208285;
        Wed, 27 Mar 2024 07:36:48 -0700 (PDT)
Received: from localhost (c-98-32-39-159.hsd1.nm.comcast.net. [98.32.39.159])
        by smtp.gmail.com with ESMTPSA id eh10-20020a056638298a00b00476d7a99f34sm3232629jab.99.2024.03.27.07.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 07:36:47 -0700 (PDT)
Date: Wed, 27 Mar 2024 07:36:45 -0700 (PDT)
From: Paul Walmsley <paul.walmsley@sifive.com>
To: Song Shuai <songshuaishuai@tinylab.org>
cc: palmer@dabbelt.com, aou@eecs.berkeley.edu, guoren@kernel.org, 
    xianting.tian@linux.alibaba.com, takahiro.akashi@linaro.org, 
    linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -fixes] riscv: kexec: Avoid deadlock in kexec crash
 path
In-Reply-To: <20231208111015.173237-1-songshuaishuai@tinylab.org>
Message-ID: <0e34cd12-66d8-4432-780a-f08d03a2c95e@sifive.com>
References: <20231208111015.173237-1-songshuaishuai@tinylab.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi Song Shuai, 

On Fri, 8 Dec 2023, Song Shuai wrote:

> If the kexec crash code is called in the interrupt context, the
> machine_kexec_mask_interrupts() function will trigger a deadlock while
> trying to acquire the irqdesc spinlock and then deacitive irqchip.
> 
> To avoid the deadlock, this patch directly EOI the irq regardless of
> the active status of irqchip.

Taking a quick look at the other architectures, looks like no one else is 
doing this.  Is this addressing a RISC-V-only problem?

> diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
> index f6c7135b00d7..d7ddf4d2b243 100644
> --- a/arch/riscv/kernel/machine_kexec.c
> +++ b/arch/riscv/kernel/machine_kexec.c
> @@ -149,20 +149,12 @@ static void machine_kexec_mask_interrupts(void)
>  
>  	for_each_irq_desc(i, desc) {
>  		struct irq_chip *chip;
> -		int ret;
>  
>  		chip = irq_desc_get_chip(desc);
>  		if (!chip)
>  			continue;
>  
> -		/*
> -		 * First try to remove the active state. If this
> -		 * fails, try to EOI the interrupt.
> -		 */
> -		ret = irq_set_irqchip_state(i, IRQCHIP_STATE_ACTIVE, false);
> -
> -		if (ret && irqd_irq_inprogress(&desc->irq_data) &&
> -		    chip->irq_eoi)
> +		if (chip->irq_eoi && irqd_irq_inprogress(&desc->irq_data))
>  			chip->irq_eoi(&desc->irq_data);


- Paul



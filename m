Return-Path: <linux-kernel+bounces-77018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A586086001F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C06B4B242DA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CA515698C;
	Thu, 22 Feb 2024 17:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1TYOqFT"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2466B3FE2C;
	Thu, 22 Feb 2024 17:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708624390; cv=none; b=IyvUElrCg9mzhLYR0UEIy2fKYbgvKSjpPLzosRdKeRpe4fjJPKzfcj5TAHtDZhUIS3vCbMpPPU2AJ5N5AeOvN21Wm/iZ2uoGRr23fkX9njAbq3QJmIrEdRTJpZNZFSh6Iqi1dEyzxNh2olvS+NLuu1AfNXECuSQuHo3AaB6PjpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708624390; c=relaxed/simple;
	bh=cDqWqadbN50Zl4mZEaqlzp/ooKAkJAaVs2CpHDBNz68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cVrz/TPUlEDXapgtwabpT5S0l4jEbAiHpISHMAU71dLiVMqUnKK6i2dBpR9pRA4mR+uotSSh/8MulcgxbBCCNVBG1Cjy92OrHG3VNjHEiFsoopWRabpi2Tgs4ySgQO1I3IO19b/LnDQAqQj4H4HifDAHhvZ5vGK/uTQabTnfTyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1TYOqFT; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3f3d0d2787so305998166b.3;
        Thu, 22 Feb 2024 09:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708624387; x=1709229187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDSOZZzKwjBntfuVietadJvq9uZco80DUUsd+KMIQFA=;
        b=h1TYOqFTWIsIav+9kjUqbhxasvdUj+qgNa1gApfRqKZLMMrWQ/7OQ9aADaD1UmWEJv
         DXTJu66WS9+LZ6j0GJsnmL4RNQfH3hglMJIf0QADOsQpoQdSRUEDjlrKxH89IUVO0MSb
         Y9TTFOeK6wjNOD0ilXqUf3R0iqAX9/hBQ/AgEtuZhYKKXH4FIU+YN8tUsA5/5BEqVS/h
         CTIvhf+sjeooVqHuBb07sab2rC4g+bbIxzFRDdLaTlw67+jCsbo8GjNEIdwar3P/2B7K
         IV20j4TBIsSNv0SeCPFyZWYf/Pv2BY1wGF0UKpfaUdvmf/OQucuWqGuYcIChXr4Q6o8R
         sh8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708624387; x=1709229187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDSOZZzKwjBntfuVietadJvq9uZco80DUUsd+KMIQFA=;
        b=QdMOE3NVyFya6U8QqIxquhGECBdgGh3Ddi0YIRL4CWvLs0Ecm5KvAHgjp/GqPL5GdQ
         +i7HrTMLJP3VtkPn8s4fusPz5SovpYPGtXQUR+D30uR7+78kX9LKKrVTmEVC0XZvW4Dg
         pxGjLoOsRdqSGcbSQQmi7KfVG6RNnR0CqnCZJyzomcVPX+Na5/JUsyz0+P6OEl4Qc4fr
         /esGXoeGCho18+2hs9zOqST42sfIa63joHODfk7u+31gNP6sp8+wy7Ohxh66wtouue3q
         hfiWkDMwI8z8HbX+LnXhrl+SQ0p0ce/Gub+IyHTqdEdRGBhkNW/XbRkbqKV48ZLvq1aM
         c5PA==
X-Forwarded-Encrypted: i=1; AJvYcCUZFIjpRqEW8SpfzvIQ0XEouOwiwoODi52/sd54lTL5k9Y8Y5P3US1N7BN/nZICAo/xbVVy/GiFpj25xL55rrH6yPRqK+IUFxfLoRU6NWI6IhCP3546aMGOH8AQMgjqlDGBrCEgzfVb
X-Gm-Message-State: AOJu0Yz6zVeE6puWy2whjcIdjkf/tX0cXquVpYOxIhSS2WK7QsUrBewE
	6/KDIsCIbNG5Le93XrBfMAtFLMTNswMlsmUnYy3T8CHBIUZe+rDG5CqpJhQOM/AUS8p6fvFrazk
	QcdQT4zuuo8sXIT7RD25k0/hBYh8=
X-Google-Smtp-Source: AGHT+IGRJoFm0SECUPXdNZ/eyyHAsA4s3nex/hUFijbPM65k9/KNMYbvWx9otT1PRGkEhFVWZEqnWEMmXbMkU1kbZ3Q=
X-Received: by 2002:a17:906:6dc1:b0:a3f:81e1:2dad with SMTP id
 j1-20020a1709066dc100b00a3f81e12dadmr1806185ejt.21.1708624387159; Thu, 22 Feb
 2024 09:53:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222172853.25082-1-fancer.lancer@gmail.com>
In-Reply-To: <20240222172853.25082-1-fancer.lancer@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 22 Feb 2024 19:52:30 +0200
Message-ID: <CAHp75VdgVaqyCRW=Dx0FmfrJe5FcaoXpZJ2Mb7hd0FvyhxeOWQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] spi: dw: Auto-detect number of native CS
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, 
	Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Shevchenko <andy@kernel.org>, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 7:28=E2=80=AFPM Serge Semin <fancer.lancer@gmail.co=
m> wrote:
>
> The main goal of the short series is to provide a procedure implementing
> the auto-detection of the number of native Chip-Select signals supported
> by the controller. The suggested algorithm is straightforward. It relies
> on the fact that the SER register writable flags reflects the actual
> number of available native chip-select signals. So the DW APB/AHB SSI
> driver now tests the SER register for having the writable bits,
> calculates the number of CS signals based on the number of set flags and
> then initializes the num_cs private data field based on that, which then
> will be passed to the SPI-core subsystem indicating the number of
> supported hardware chip-selects. The implemented procedure will be useful
> for the DW SSI device nodes not having the explicitly set "num-cs"
> property. In case if the property is specified it will be utilized instea=
d
> of the auto-detection procedure.
>
> Besides of that a small cleanup patch is introduced in the head of the
> series. It converts the driver to using the BITS_TO_BYTES() macro instead
> of the hard-coded DIV_ROUND_UP()-based calculation of the number of
> bytes-per-transfer-word.
>
> Link: https://lore.kernel.org/linux-spi/20240215180102.13887-1-fancer.lan=
cer@gmail.com
> Changelog v2:
> - Add a new patch:
>   [PATCH v2 3/4] spi: dw: Convert dw_spi::num_cs to u32
> - Fix some spelling notes (@Andy).

For all untagged,
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Thank you!

--=20
With Best Regards,
Andy Shevchenko


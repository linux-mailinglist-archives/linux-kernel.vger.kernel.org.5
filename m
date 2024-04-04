Return-Path: <linux-kernel+bounces-131196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 505B3898454
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E47A11F21E84
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC74B76033;
	Thu,  4 Apr 2024 09:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="KkMfr0dj"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670AB7175A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 09:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712223380; cv=none; b=hV6uQ4Y1zBT6h2a3hhiL6o7BZmJhnKb4duHSykSOprAhy47+oUZB/aGp9HqDq79QQQSASeWguJQ2NFnD8v92yh1xw59OEQfqg8xpRIBNeaQD/zODcNYniM4Ipkkk12Bj5NL2LWbZOUFlLjn+0GmoSvB3PNimP107qio1vxJXx54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712223380; c=relaxed/simple;
	bh=o0u6Hrdo3yjilxzf27+PrAemJHdRikqTOYkOWtLZWHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=REX59B0LCgY+jHaXuwrrlNkvSBY/QXyzoHL8MNc4ymNPSaAQRVkxYSRybDyXDOsOKJidUVL1BubmKPqR+R3bjuOQHlApCx3arotYW7m1ggHW+eZWq/YYaDmAgPkDx0AH57o7nC7aLTdKie2QHxYWHQiZ9BlZcTKjaxlLGkhyYsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=KkMfr0dj; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-515ac73c516so1743982e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 02:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1712223376; x=1712828176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0u6Hrdo3yjilxzf27+PrAemJHdRikqTOYkOWtLZWHo=;
        b=KkMfr0djFuwVIMod3gpq4g+EX8yiVouB0rSwJjofKS54DWFMJbWJgo3uzbY6mDewI2
         Km+n2zSOc3chJE5zn6FbXKQ1RujUyk3Ie4aXMmetdj/w11hZ6KLKdldo+EQf8GYu7N4r
         N3Nr0mY8FIziO+C+1iSIOeBxf1Uuzn/2Hhn9hBJAZGdIV3jDtdz+lYrztWaICiX4qXs+
         qj8+Y9IaXCUjSNoTJNY7f2atVJka757rvqsPIATWPUJxkgG0rN4SNSJeuDdtYIpvLFZk
         VLv2l4TtAYjbRz3lh8Ch9PsijuAwG8fcBwpFl9GVY4vy+2hXsBPZ5KgVAgL/gOLanlO4
         cwAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712223376; x=1712828176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0u6Hrdo3yjilxzf27+PrAemJHdRikqTOYkOWtLZWHo=;
        b=cjEyvsqOExAYz7wc1Qoon1mNYBGyZZfVwBAvgc4+piTOl0n12dji8LE3/QDfStkOpH
         Twnk/euGiXKEvAMlJeY2C0Sjp9SISDoGbR2lQ72rfeRgh+ifQ9sXj7NQJykT5oUtt777
         L1h6G+8vNNmEc/5Mi76Z9XuE1tcrLCagOkxNbuyaDPxr2XM19ADcc6Kes9j85s7TFyFO
         x1d59qvMs2cDdH8wrdHmYWCOkZBW5eCks8oxBxU9USNT6vtEvtNpFGWWDQne71AgkWfY
         +ikR6lYYFrQU+RbX1blwmeOwyI228zeRNyLyiDvjGjTTvO4MncmK9WbRei9AM+CTwYjS
         DNyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXU6HDHuKNN//leSdkKyFsXHNvXuVr3Ynjjkz4u26Kx9bYFHnS1omuFfBXi/glkKfGq2bqcU258dBCLcjo2+4335f5UaU5qC+gLrXGQ
X-Gm-Message-State: AOJu0Yzv24NZwtIddwfDu34yb8zOqXBQ7L/Ia9y6EDj8eRCmlDICPBAe
	e+kf9DMRHpL3eEJOt2vhfaZ8slappvYq3HDrvXlAxJs5Fp1nXgcctt4UUG2UDFwEAyid59fSjff
	yzUELcL4hLABP8JzfHmeDah65Pksa6vY1QdgFxw==
X-Google-Smtp-Source: AGHT+IHYegzG44G7C3aHvq2picZ77QE4YXJ/haZqskfmLMY5asLrS5438QmeNIW4yd0tV0NZbfwrMLblTHcWcyIRXTE=
X-Received: by 2002:a19:ca1d:0:b0:516:ccb7:df0c with SMTP id
 a29-20020a19ca1d000000b00516ccb7df0cmr353671lfg.11.1712223376566; Thu, 04 Apr
 2024 02:36:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404093328.21604-1-brgl@bgdev.pl> <20240404093328.21604-2-brgl@bgdev.pl>
In-Reply-To: <20240404093328.21604-2-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 4 Apr 2024 11:36:05 +0200
Message-ID: <CAMRc=MfNanTC5kY88Nvic2z9MPdiyFOO5YPUwAgDnRs4=C6K2g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] gpio: cdev: check for NULL labels when sanitizing
 them for irqs
To: Kent Gibson <warthog618@gmail.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexey Dobriyan <adobriyan@gmail.com>, stable@vger.kernel.org, 
	Stefan Wahren <wahrenst@gmx.net>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Linux Kernel Functional Testing <lkft@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 11:33=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> We need to take into account that a line's consumer label may be NULL
> and not try to kstrdup() it in that case but rather pass the NULL
> pointer up the stack to the interrupt request function.
>
> To that end: let make_irq_label() return NULL as a valid return value
> and use ERR_PTR() instead to signal an allocation failure to callers.
>
> Cc: stable@vger.kernel.org
> Fixes: b34490879baa ("gpio: cdev: sanitize the label before requesting th=
e interrupt")
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/lkml/20240402093534.212283-1-naresh.kambo=
ju@linaro.org/
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

Tested-by: Anders Roxell <anders.roxell@linaro.org>


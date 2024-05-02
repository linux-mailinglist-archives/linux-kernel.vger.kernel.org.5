Return-Path: <linux-kernel+bounces-166098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B978B962E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5099F28215E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C4D2D61B;
	Thu,  2 May 2024 08:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xkGiVaBK"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A000286BD
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 08:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714637494; cv=none; b=BnUgzQVxL8GnOXM9d7mnxHsGePjkXTKGluquVHALQ8ey0PjUfTpGidVOK73yH3Ki4OG6uqNKwF7EwuZVBpKkdB9TX+X/RyL5yjmYwrhrWNSK2eQwZytW/SNRuKJQqk3UF/0LN/CSrut/b4HO+l4pjR0QsGN0hD2cpKaShOnDjSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714637494; c=relaxed/simple;
	bh=LjOeatHXKMKJgpcc6m/ycg9syrS0e2IivHidp1e5BOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ip3aYd5QIUcj67nWeO9zOSUzMKATJIwE4gqgnXxcpEl9LI32MVinAwsO9LkaxH2KOS/aFNxYqJx8vOZnyoyETUiZA5gKZw+WOLiH8LyVa3d43S391KPCrxP4p2M0Qu2XwCjCaBBQQq3upPR0VZVfLjUhKLoDEP+7j6A/ZEoOsKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xkGiVaBK; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-61b2218ab6fso60583117b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 01:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714637492; x=1715242292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LjOeatHXKMKJgpcc6m/ycg9syrS0e2IivHidp1e5BOA=;
        b=xkGiVaBKDK5u7G580ARNDNS1EM6b7ZspYJ/e+HhjwFQmOzqeGfQZyuqB8NxaXqfSCM
         ornvYRHORBKv/3IbdUz+dT0uOR/jRzcSgFwmXhjS0LpUAx97TAItsCOdBWzytX25moxE
         ehP95XT5aLJ76OUBPJTXBX53XtxNqrIpflrR0z3+EJasFu2Ae8sQt5p6bVLzJVeJVZwZ
         3ePw0doOtQFQ5yopqddxWtbvbbmbTSnDIjGQYqvqPlltW+DJPjDxL8E9K865zROIesec
         sBXQPn5ItZEaAtysx/7yMuKL8vntOAOtIX/Zo0wnN3+oq0efdDxnAaZ/ZJlvM9nIWDmo
         Dz2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714637492; x=1715242292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LjOeatHXKMKJgpcc6m/ycg9syrS0e2IivHidp1e5BOA=;
        b=fnbhYF4n/P0E/ti5kIykI/JR0e/5KYuMUoBIPYj4SBv7/3fQRRA8bFQ7UA/yndb8Xl
         vS5RPTETdg5c8NZQzf3ndtZhrcIktD2NsekYCoLHvkof9hn8c+Katx32I3CIMvXw1/Zh
         Nk4CGDLvCOHJp1XOdWKt8KfVGyleoZcCb+4y0GNlQPcyn9qcdNaE2wONT6smn8WOfmhG
         nkH7FdYu6qCbVq4yIxDiCyZPXBTcw+ld6oynGz3bAzhHE2vzh/rsDccRygpJVAPG84X2
         ZgD35m6HoFSyIl4oBbYPqQzIzVnSAnLvSy2AeGWXU17BTnVL/TtpG99a+fY0nDfixS3D
         wLyg==
X-Forwarded-Encrypted: i=1; AJvYcCWUkQ6dGEgoCf4wbv1epi111YKcthjyQSQduoNmfn4Q7uWyaIfSwPLDQPYEppCrhU5sCSponLUAzBEjCusrRU1G5hKQ4gBfVns1cja+
X-Gm-Message-State: AOJu0YwxunMkUuIFTshIF7rOO3KA7mvWgp06QVpzElpdoZtoZ+XswDCM
	jQ0Vsxw9+HVL1KpNSROWz/bFwx9ysdZw3FmyxQyfqCzTvH0D+63RAFYxHg2mS3umFYmGoPqXGZg
	AwufOz6AARdqM9lUAmgbybTG5ywCx10WIAadK60EkF9FMUo/g3dI=
X-Google-Smtp-Source: AGHT+IGJEzfIms6U83mdPxNB0s5B5gCFDCfp/MgRqjTkJukEUjEtA/OkOokFTrnWEWA6mQH0+cqMlQNnK3DN2nD+cxc=
X-Received: by 2002:a05:690c:6c0f:b0:61b:d8:c5de with SMTP id
 ir15-20020a05690c6c0f00b0061b00d8c5demr5292651ywb.19.1714637492101; Thu, 02
 May 2024 01:11:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417110334.2671228-1-andriy.shevchenko@linux.intel.com> <20240417110334.2671228-8-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240417110334.2671228-8-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 2 May 2024 10:11:21 +0200
Message-ID: <CACRpkdbacr96P4jBjJ5BSYCJkA=0cDp=MJwsoNtLgy7n0Vk8Rg@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] spi: pxa2xx: Remove DMA parameters from struct chip_data
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
	Robert Jarzmik <robert.jarzmik@free.fr>, Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 1:05=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> The DMA related fields are set once and never modified. It effectively
> repeats the content of the same fields in struct pxa2xx_spi_controller.
> With that, remove DMA parameters from struct chip_data.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij


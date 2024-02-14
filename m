Return-Path: <linux-kernel+bounces-65500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED24D854DDF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A94FB28621A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238D9604A8;
	Wed, 14 Feb 2024 16:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jQ+iCbuM"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA065FDD9
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 16:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707927402; cv=none; b=n6T7KeBABzwb3lgb2DFI94Sgk85KY8NH8LNQ3OanXllUNQMvzj308ZImVLTz0NcjQ2iWbeBEuDW6EKh0k79oJFbuoGg+CuOPOiUwq2IffNEsnRpoocesKF/OL3/kqcOhn1Wi+SOSFIy2DhjQpdpchTihSaQlR+kdBFlutu+l+2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707927402; c=relaxed/simple;
	bh=3Lb+cs6MZyEbSuIsnGR/lDtPPDEXeFotj9ffl8+8h2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eexFkTm4ZyZRRK8UmnvRaiy+T/bk/n6CMfDliuY8LtTHJX64b9hI93CQV9bP4PBOwCC9RIvqdh3EVi9UTCm+AjGzQeseWnsWIa4+Z7ti+WYIkC8tZa/Ad52Pmqc72sxG/nnnn2CDDtuPsjNw21pI0dwjJdxW90rc/GTloI8dGAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jQ+iCbuM; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so1293559276.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 08:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707927400; x=1708532200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Lb+cs6MZyEbSuIsnGR/lDtPPDEXeFotj9ffl8+8h2E=;
        b=jQ+iCbuMrZAiwtm9/t4D470IdQTpks8keGFfflbIGkU9FErMW2vjqmEqL9kLW5jxVF
         wllvm4+7fk9N5DbKP6cIt0sdiofAjlWZ8cGe0gG1FAOEoXZz43yCP7OtR12UfDr6QWs3
         K6tGr9uY8F4xpyBmbA8Et1RYuEYHNrcu6w7yZzUQcuqUCm/WcrNMapomB06GfFuceSSk
         D71aeisgGFSDhLEgQmAIHpz21BMLVKcQ5uKXKnlm33aE47tq5tiMIxDVPTqQAq3FyDpC
         j1IUBak0n8IzhUHLk4b0xexYl+Z/eSC4InzelJu2/WdA4DcXVPEGJDHv74zb3aoFnr+l
         nqQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707927400; x=1708532200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Lb+cs6MZyEbSuIsnGR/lDtPPDEXeFotj9ffl8+8h2E=;
        b=ZCcNuFSWHZnZCeqJ4TeUu+XOXNWeei/vwG9I+DViOrlKDY4f7fNx5f5A0iHFsGSsNl
         5pf75qdmp4FFCpgryn+i7shvGGLBN/rcE4Yxl/blr3+I+il8+AJWErb2ChGup9cAsj4P
         CecR+q2kp0i3I4Gdqo9SFudxaY+9zz7tJVQQCaoQLBy5mPpng4m6C/t/B2WTP+jS93pt
         aKzSh7kdgY9UvI1ggMUfhXXx0/JxlKFdN8NnT4kIXsl1/F/fFtczjpBJlJzz458TAIA+
         n8sPLyHO1tgl/h1lT+ycfqI1zgSXJZbBdPv9XLCkKJQlRTRf5F7aNxlIiZqHB+AJSCKG
         6bNA==
X-Forwarded-Encrypted: i=1; AJvYcCW+WLLWv3lBwOk061XC0nMi+xgVr7g1K9GnicYXX+ELubmAspcEiiWqUUWLoNGBLpfVeYHUMV5Cn0obEr4b+LCo3QN6wav9L+hBOLK5
X-Gm-Message-State: AOJu0YwIM8pe7lPsExEv31fscKzn2WR/14MolDG9zsF78sqZvViaevbN
	LJ4OjByRh5Ml5gmgb9PvJOLEsKS3GA8DWDpGE57MHOo9JoOPLmvqfOivQ+2qDmvGHCfztwlOwyE
	i4qpocLeks6OHusgzsFNj6qR16yYh76dAyGgsDA==
X-Google-Smtp-Source: AGHT+IGn8WJgL4pwbaWyNz9ITyW0zrOMdOl935ZSB7EE4cCvDmWqKp+zf3U3pgJx+qr14OZqt1gsE/zbikNXg1FdfO4=
X-Received: by 2002:a25:9c82:0:b0:dcd:1d44:f6c1 with SMTP id
 y2-20020a259c82000000b00dcd1d44f6c1mr2763883ybo.16.1707927399794; Wed, 14 Feb
 2024 08:16:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214092438.10785-1-brgl@bgdev.pl>
In-Reply-To: <20240214092438.10785-1-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 14 Feb 2024 17:16:28 +0100
Message-ID: <CACRpkdbULXPDDtXcBDrme54yYxKOSaAzwZPyT_H+gfyUPNXRMw@mail.gmail.com>
Subject: Re: [PATCH] serial: st-asc: don't get/put GPIOs in atomic context
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 10:24=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Since commit 1f2bcb8c8ccd ("gpio: protect the descriptor label with
> SRCU") gpiod_set_consumer_name() calls synchronize_srcu() which led to
> a "sleeping in atomic context" smatch warning.
>
> This function (along with gpiod_get/put() and all other GPIO APIs apart
> from gpiod_get/set_value() and gpiod_direction_input/output()) should
> have never been called with a spinlock taken. We're only fixing this now
> as GPIOLIB has been rebuilt to use SRCU for access serialization which
> uncovered this problem.
>
> Move the calls to gpiod_get/put() outside the spinlock critical section.
>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/linux-gpio/deee1438-efc1-47c4-8d80-0ab2cf=
01d60a@moroto.mountain/
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Good find!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij


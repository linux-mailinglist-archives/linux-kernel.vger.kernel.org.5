Return-Path: <linux-kernel+bounces-76474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D0385F7A7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAF0C1F25EF2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D2146448;
	Thu, 22 Feb 2024 12:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gW41vm9a"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895B641212
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 12:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708603516; cv=none; b=QznJsRcAGJXTV5K1lQOfAQt4KiVXHRJ85W3AEkK8/RCfHOvb9ok/issY+F2o95AiYkRh/UEqbqrDsrAiK6Mb4/8blReQLBGip00W75bWULlLBzjPx8zBlpbWP6n5bph269DVuiLUbO/zLyau+sK4J47FCkD7235pS0S84/eyyp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708603516; c=relaxed/simple;
	bh=dGWD6NHH548xIqityNEoCsAmU5e6mGLq00J6IaYPuV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XnLxO9NqNYG/FU1nhXhrUzXQqmvo2pev8ihts1mN+nzLLriUg3peB97Go2lgR/bs0d5GeHkqcX57UJjeHxzL873Q2Sg8SO7/cZkHIsDxXzbYIknSx2OqWO82MAtUd/JmYkUWLpzAzeUA/FYXf+9asRZY4NX6UiFn5oy2K7WfQok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gW41vm9a; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-60821136c5aso34525797b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 04:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708603513; x=1709208313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGWD6NHH548xIqityNEoCsAmU5e6mGLq00J6IaYPuV4=;
        b=gW41vm9akcQB7AxMmihe453r38x+A2sdYdZTOW7UPg8KwkJXjdRYBYjGcWnJjUhdKw
         ayoIStKi1pSfF2uU2qH+YFUY7+Q0qA549T0mm8s/vjcxbp+KIM0ArRorrGFA0P795nao
         v1AoOI/6IDpWSW5DHX2EmSUfcKC0x7f+cRgzawlmFI8l11zQ6ROrwAkG1yMORZ+oeix3
         H69TJBjoI6mXOA/4kTX3WzAFQ0yK0pVHggzBzDGVqGJLZK2kswVuiUyMHFwFS7KLKotu
         6wIdx8t+Z5b8td8NoGJX+AgCcBGIzjO8TdSh9lXUEVzGMAsDAa7/I3PmAyR42bbAnrJA
         9z9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708603513; x=1709208313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dGWD6NHH548xIqityNEoCsAmU5e6mGLq00J6IaYPuV4=;
        b=G5vXTuGL1F8iKvr0LawCfHdgPln/ZSGnxyoYJd8vepkzsgspD6lcLQXo8MVLy8riP3
         zdd8uqJTRV5UEnKyRS+Yw9lbLysHXKjtJNBjGyD2L9rhgS1kOLM0iIO5PtihoHK37LFq
         d+YnNsgCh5LuRlKFFyad6bkag4tgbiBnX+72K5zYNjODwWQEtFDj1cr/I80UPalkNPA7
         fceUmpePTL20x11j2cdXeRIGNKgL0L1M5QMVWFhxu6PZ3uv+EB6JETXQ/qlFxVcsT3PB
         e3zvyBczoSiD0kCUWOwZL1Tij7BuquvdYMCT9knvFDiYzf/0hNKwaX0fzGi5JGUM0NEd
         J+Ng==
X-Forwarded-Encrypted: i=1; AJvYcCW9CpxMr2cNQMSji83hhDp+T9mLzMJGD3jIyD+9COvogU7ynOFroDUmDEq4SxLpxXsnki+cZCgePsjWJlQP4600hxAKdJDcb0NXZgpL
X-Gm-Message-State: AOJu0YxZnGxq7KD7AdEjvfRDu1Vt5sCd2tgRQ3JB/CSuQSQcuz2BI1KR
	zaTYquBxI5cN4pRW8KBjz1o2vr+/oOOc1PdV2VF0h30PWSHyTq3n6v1NTFy8onlcXZxE8sTFApi
	+EVXbq3/4Jd1nONspVuVJ8aXhB9BsXi0vnoLByXnADYUAht1c1FI=
X-Google-Smtp-Source: AGHT+IHkJyZ6/z/AqebANcuFmHUqMm2MbLgG0od5FktAoz/uxsuEctz7zm8Hhx2ixPA1QZA9dedCP3fZYTdMDh5FHEk=
X-Received: by 2002:a81:bc4b:0:b0:608:74b6:49af with SMTP id
 b11-20020a81bc4b000000b0060874b649afmr5838471ywl.13.1708603513654; Thu, 22
 Feb 2024 04:05:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222102513.16975-1-brgl@bgdev.pl> <20240222102513.16975-2-brgl@bgdev.pl>
In-Reply-To: <20240222102513.16975-2-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 22 Feb 2024 13:05:01 +0100
Message-ID: <CACRpkdazuHcnXMSffa=hfHAT5nfZ0uHeDqStOBTOOsTZdmx3cw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] gpio: sim: use for_each_hwgpio()
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 11:25=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Display debugfs information about all simulated GPIOs, not only the
> requested ones.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij


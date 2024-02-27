Return-Path: <linux-kernel+bounces-83289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC87869154
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DB151C224CF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4CD13AA47;
	Tue, 27 Feb 2024 13:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="RsBLqD3D"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA4C135A43
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 13:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709039181; cv=none; b=pRiESYMqZs3D3rR2GFwj52LfR/nrtAkodo6ndgXfa8ybwt+W2L2kZhypRUwJkKJ6uz0zNtMlrk8YSXtUxL66QLY9BWOhIqBVOOIrPVG88MhdBTgZQc8/03loWGfoXfo3ZKTEfuIz/aDTrj8hpftD8mUZew4W669WR3U/UxSC2Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709039181; c=relaxed/simple;
	bh=/uDylJuigd4d8kEq+ujZnBuzh0BMwt6INRnFR5uTzPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ea7JE+J0u5FXZQOU1eZnM4mtQ6LZJ+ejAazisAjPO7Zk7nwqHyZPu7nKpqjyp7wvvBXErNu69T0zoZS+KarLh+GfjsqX1N1yJrHy9lFzrfkhz6LVapf8FP0ttDfB4KkiPJW+kUerrdzo8krV0c/hreEDmR6oCtsu6745yVG8xvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=RsBLqD3D; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e4a803c72aso623211a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 05:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1709039179; x=1709643979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/uDylJuigd4d8kEq+ujZnBuzh0BMwt6INRnFR5uTzPE=;
        b=RsBLqD3DF92BVLra4FErhxL0dMdS3NUuTswwG0RxZSyFI+eJUPu3PnXulJdqwvoLTa
         iHycV1tHGEF13jJ7POhZZwedG58nHzNt6qiDKpTNA4JvCsJRQ/EbN8rnsa6TSDMmuIGs
         Zs5TAnfCgXTAwL9xP0Hhplng03ALHNRHxbr1qK1ad7t/CK/UD/g62JmRwD0/96kS5tdw
         vhR5k+S1ZvNdEMmPv2mbU+c+wQgnlpSXEhq3lLmVtZx7YIXmh8mJHalLMuclFmpHSSsz
         k6LWEBjGJpOOCSEriC19u88++aw2Wd1o3raftA2e0vXu1/t3hcZDlJEVp+srRPgB+Ecf
         POAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709039179; x=1709643979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/uDylJuigd4d8kEq+ujZnBuzh0BMwt6INRnFR5uTzPE=;
        b=DgRCavNv1nrfOo+vp5Mfx5C+Ce7C1mEt7fIj42JhwMLS0wmQV9aL52DGFLtgPpktvA
         VMDe6nOMEa7fPa9xtk57oRvdsQhMN7nRN+vYFf2uEInQni7cjPemugz/0T12A8TBgwAQ
         EuAkWdgbQ238Vs5nTQ3ueMh+W/GFyE0ZUf30IOQ1OdXkHR8N09zQE+jWkEUuucoFrp0Q
         nJOJY0fxvfUz12ANoRHTlaRp9gH2cx2u6vWsUpoYQUzqg8+udw7b021HnD/W0Uvxpcoq
         2RM6fDvxulqWhE01hW5OIJV7znEfygaaslZkl+gfvq+eHevsYFHJMA3kRnCw0SEoWB0E
         6mKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuTDRiv1XXyUQtEhhI5adSdAEsxEpGVXSUlVmn20pB1xGE2z1ryILuy0eSOoJ6dO1R+3SOH98JH4wKN+Q5tg/HsgF/8MlmabjNdzEf
X-Gm-Message-State: AOJu0YzHjNGRjrkxjJfyWkjQC22snQSB1U0Z3jeiPzRAt2ui2Yrse0F2
	0jHE8Fy8lE1BoeKFL0cnUFfTq1ioH692ssDfdUvqekmZ18WQ34t59HSgqGOer4KaIgvEdmp4QQm
	iOerzfz0H98Ycgg80dfSIun/nvWEK7qQOXIjQEw==
X-Google-Smtp-Source: AGHT+IHymsnTIzpxxyFaUH2TMYMIhZIuV1ZmmTokIhLJSPK8tB568uQzASfJBzQQOq6hn71h2+9vuxHhF3pkwDw32HM=
X-Received: by 2002:a05:6808:10cf:b0:3c1:8039:c6a5 with SMTP id
 s15-20020a05680810cf00b003c18039c6a5mr2062657ois.35.1709039178020; Tue, 27
 Feb 2024 05:06:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221213208.17914-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240221213208.17914-1-andriy.shevchenko@linux.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 27 Feb 2024 14:06:05 +0100
Message-ID: <CAMRc=Mfh-ojboNUELXfszKUbZRfeZn9vsN-HMTdMQv6my6ZrdQ@mail.gmail.com>
Subject: Re: [rfc, PATCH v1 1/1] gpiolib: Get rid of never false
 gpio_is_valid() calls
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 10:32=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> In the cases when gpio_is_valid() is called with unsigned parameter
> the result is always true in the GPIO library code, hence the check
> for false won't ever be true. Get rid of such calls.
>
> While at it, move GPIO device base to be unsigned to clearly show
> it won't ever be negative. This requires a new definition for the
> maximum GPIO number in the system.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

It looks like a risky change that late in the release cycle. I want to
avoid some CI problems at rc6. Please resend it once v6.9-rc1 is
tagged.

Bart


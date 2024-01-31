Return-Path: <linux-kernel+bounces-47039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D668D84485A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C1FA1F25C1A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E903EA9E;
	Wed, 31 Jan 2024 20:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q1qglu0H"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC643EA9B
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 20:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706731300; cv=none; b=HX1IhcDNxb+E7NYB5OfCLv3u4YdsgzDlxXVDsAOcp9n7dLh4ffPU0InuyDgyxLIZyMFPImqNNhJK8pm6gxyF/TmmjVFMsD+0sW5g1VCfXJ1GQjIZJpOJB8WB0Q1aovuR3HGJsqkFaFPdhYhsd5gwF2rZ00Bd4lAJmenelhn5izw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706731300; c=relaxed/simple;
	bh=/R8kRs2qiNcStWcrwCYAg0we1hus4HfYrb2LRT0M+Ls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WYEl9P8l2OUqnm32OcGocgE/A8T1NpW+ji5gIzyn5WwqdscKs7CIn2LxZVz5a1uWSdpfgLySplhYDzqxX6k924IJcFZmz9ZBlfGqx4K2Dkiz1YOSi1BpUVYAw4Iu41a73VU+B2P8EK7wJ4/nxm+4U72NKhhOa3UWZrFTKCjn02U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q1qglu0H; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-604055e48a3so1669727b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 12:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706731297; x=1707336097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5V9bfTwLL9jNSv6vg88NwIpMVBmUkBIVa/DKkkcbPJs=;
        b=Q1qglu0HGyJmwKzaoAW2YmF8Scd9zThGUoKzPFvDLCHg/UvmbTeMGHKIzBu0TzvcFI
         RbKWwf9dldxEr9CUfiZhdp9uaeo/owPKPJAY6sqIzC3Qs3pGWo6ZtzKVwJj/LOOq+r4i
         DhvDh+wdEmZb3dBVto5yIOkiYl2uGkv9FSy5DBmhe5FrK9QezaD1M437CUMNCdMWEZKi
         rXuQHDc0VPXUwhewUJJMNWxWsm55NSS7PEKabO4llIFH8qcNAq4kSiX7tU3vhtMpNnW9
         ej6QkpXVP8hBC4yO2B3hTElX8IuVXEFCL2DERif6zQJpRiD/Ejys9joIWzHF1et7FhQ4
         InVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706731297; x=1707336097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5V9bfTwLL9jNSv6vg88NwIpMVBmUkBIVa/DKkkcbPJs=;
        b=LLdkcg2a3q+k+Ni8VivnLiCH7Eq1aYuXFpyly4B64JA7r+kwvCYo3MeVjSYGRzUBux
         InHGTA+o6F7tL1DBbiaFDPZOQVhIGM/aQtuCxAKJ3pyKzNeYKmCgmpCmUjQXtfGyW4+E
         QOSbQKP2l3fKqnFomLbSXtl2GBIaTe5exzFsj59qKdaM21I5UKM7IdumlmOBP3LApDyr
         SRIUExwmtDDBDm8Ijk8NYRdxsnY053EWWKjMwuJ5kPLZFB22tUIhrnRI/SVuThovgiDJ
         pQVMfJfqSDDXtddK0tl5Hw7So8Y1Qsncz9eZ0SZAvM5+AEkXAs/7rumGiW+g4QAiJbGu
         n70A==
X-Gm-Message-State: AOJu0Yw1Nfb8z/ZD/z3gWs+ayDGFptdjozu/gv8WdtcG79kRj5bMR7hS
	WpQsORMglbEW6pjJjG1y6nRxu4N5qPU8oj5mHXlb44mx91K+NSeXn/kxfeiGYBx6DCNIPwTwfQd
	/rIaXvYjc6Uqh7W3AgZYQPF3sMfmsrb7jTukcQw==
X-Google-Smtp-Source: AGHT+IG4vNiu5MK6XabdRnK0icsrcLF9T9xmQMFMBM/Sh4h7TAa+xTBMwPghDW0XbTZS3sWViFpO7WLlsGXRLt30L8I=
X-Received: by 2002:a81:4302:0:b0:604:f32:df75 with SMTP id
 q2-20020a814302000000b006040f32df75mr2404365ywa.7.1706731297634; Wed, 31 Jan
 2024 12:01:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130124828.14678-1-brgl@bgdev.pl> <20240130124828.14678-11-brgl@bgdev.pl>
In-Reply-To: <20240130124828.14678-11-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 31 Jan 2024 21:01:25 +0100
Message-ID: <CACRpkdZyaqwbxvsLtXPHSX=6jyFPYSxA9n+qWakdhGKmo+L9fw@mail.gmail.com>
Subject: Re: [PATCH 10/22] gpio: reinforce desc->flags handling
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kent Gibson <warthog618@gmail.com>, Alex Elder <elder@linaro.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 1:48=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> We now removed the gpio_lock spinlock and modified the places
> previously protected by it to handle desc->flags access in a consistent
> way. Let's improve other places that were previously unprotected by
> reading the flags field of gpio_desc once and using the stored value for
> logic consistency. If we need to modify the field, let's also write it
> back once with a consistent value resulting from the function's logic.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
(...)

I have a trouble with this one:

gpiochip_find_base_unlocked()
> +       unsigned long flags;
(...)
> +       flags =3D READ_ONCE(desc->flags);
(...)
> +       if (test_bit(FLAG_OPEN_DRAIN, &flags) &&
> +           test_bit(FLAG_IS_OUT, &flags))
>                 return 0;
(...)
> +       assign_bit(FLAG_IS_OUT, &flags, !ret);
> +       WRITE_ONCE(desc->flags, flags);

I unerstand the atomicity of each operation here, but ... if what you want
to protect is modifications from other CPUs, how do we know that another
CPU isn't coming in and reading and modifying and assigning
another flag inbetween these operations while the value is only
stored in the CPU-local flags variable?

Same with gpiod_direction_output().

To me it seems like maybe you need to actually protect the desc->flags
with the SRCU struct in these cases? (and not only use it for the
label protection then).

An alternative is maybe to rewrite the code with test_and_set().

But as you say it is currently unprotected, I just wonder if this really
adds any protection.

Yours,
Linus Walleij


Return-Path: <linux-kernel+bounces-58322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A130B84E4A9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58953285C64
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62177D40D;
	Thu,  8 Feb 2024 16:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="clI2cV2n"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525CC7C0A9
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 16:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707408255; cv=none; b=REpdJ5HA8UIVQVxDjzlkunvKe+CbXCH/c5ekNmLHQ5yS2Q8jRxFxQdu8C5qTF3AdDFhhxS4LjqAhX6MIVCR1g/WgnkBreiku0WNqFN+Lwf2D1s03QvWzOhUhQR8s14tRs7vPDUtHbPBSPd3zg7HJAH2C6xGok45mkoX2/X0Ezbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707408255; c=relaxed/simple;
	bh=ec9vgCjnphOMwqPOtVOD6CQurL27TdE5UtijPSgsN98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X6bf87cjlz4wNQnlFSrhREDwnjawyAjc5Z0n3uhSjrq/Vgs+VWuWm0C0nv7gCdnGTYU0XJJLT6tBspFNFkkcLn/YM6PGYlczd9OaV/jimOmi6irgQYugksp+sOC2h+xJQzf7eSZ6G3l50Oz4aCTOo+AySuVnIvKjXgGs3dgHPWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=clI2cV2n; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so47059a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 08:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707408250; x=1708013050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bPI/2z5p+xLE4jz0aL9qGWfoPwcUrKRlL6jrflyLfY=;
        b=clI2cV2nFYEC3dgdcwFMkI4ZrjI6j+ppDAFZdMZuxNtGGkhtbMviaSFUGzm++sXMit
         1WvH780IV3PjX8LW98n1XjAptxsxj8WLiZAuag0RL4fDsNN5mqIGmkfN+R3kBQ/g3yOj
         S6dWVF0G567REO2/GGU2oaK3ZQh/0u7AfYaPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707408250; x=1708013050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7bPI/2z5p+xLE4jz0aL9qGWfoPwcUrKRlL6jrflyLfY=;
        b=eyra2b3wadp/h449vfdf9r5taWj3Cb7p41luLLmLnVFWc7rUPDKrR9pwT9BeUP6co6
         fhAobEkigm9NRNNhjhOWmW/slF0NI8DYntcapA0CBlv/0nOm1Clmmh4AM7ku4A5KCh6n
         tT/QeMv+HMcKIgk1Am950mLP2Mia4mHT1Y+gLk9KtjU5mH6Vdo7XEvaESH553HYepvy+
         JjBDqcVL8N4pAyU7R8AUrOzIWfx+p7JzlI0uQiDNkgN1T66wm4ULwC3rEK664BQzUeYM
         OmFHoHvMS4SYBNZ8yV6uvZAQtoojkxtDwAQXSPwa9Jm4LEni9G19KWsZTOLIJu2iEiMn
         2oew==
X-Forwarded-Encrypted: i=1; AJvYcCWW26DJWF7CXtMkkg2K3YpbBcsKCNKtBvfOFX0oicsuCYbmCcoc3bGoeiZrz3Hu1+sYTxBQdgcF5afG8tPq6ebVeDrRkHAvULKRoRRN
X-Gm-Message-State: AOJu0YypPDAyaKyGb/stbCfH81nhcOLlJ/LpbArYaU9ORxc/kAjxXF/3
	PWYmEF5ovKPHfCWhyfv0qzidRHaSmxUHTLK1t6yxYCYVkh1P/62E3WdO5n7ircV6+Z2MU6Q7Ntj
	SXg==
X-Google-Smtp-Source: AGHT+IES8iJhgVa0uUWkQ4Q0AVf71+fsai6EogDueC1k2jCZ9Ky/iFXbmfCmRvSrfJ/uxe7Bo5LwjA==
X-Received: by 2002:a17:906:480f:b0:a31:1c94:3431 with SMTP id w15-20020a170906480f00b00a311c943431mr6833070ejq.46.1707408249809;
        Thu, 08 Feb 2024 08:04:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUeTpiGcVNXVRUbqQVW3PSR4I4Hn4/94uwfWRoxJafVe9+CMXhZznUVby5dAMEjAvEZOyfHrj8crGe1KBZMxgPlnGwh+tCwTX+eNMZh
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id lr6-20020a170906fb8600b00a3846e325e1sm189636ejb.56.2024.02.08.08.04.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 08:04:09 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40fd15fe6a8so76095e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 08:04:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXIzL1vIZwqj0HAgmhpOP+gVASJxPGbhXSzNJTLhmiBEMas7co30ccFbIv2lvGUFJdaQdjUBS+bQy5XKbV410b8m/lnaPMeVrobhTOT
X-Received: by 2002:a05:600c:3d0f:b0:410:896:6894 with SMTP id
 bh15-20020a05600c3d0f00b0041008966894mr407589wmb.2.1707408248334; Thu, 08 Feb
 2024 08:04:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208125426.70511-1-yaoma@linux.alibaba.com> <20240208125426.70511-3-yaoma@linux.alibaba.com>
In-Reply-To: <20240208125426.70511-3-yaoma@linux.alibaba.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 8 Feb 2024 08:03:50 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UP_G3Rswi_HePkgmcniADKhkoP51=H=PxGKbdegEfUgg@mail.gmail.com>
Message-ID: <CAD=FV=UP_G3Rswi_HePkgmcniADKhkoP51=H=PxGKbdegEfUgg@mail.gmail.com>
Subject: Re: [PATCHv6 2/2] watchdog/softlockup: report the most frequent interrupts
To: Bitao Hu <yaoma@linux.alibaba.com>
Cc: akpm@linux-foundation.org, pmladek@suse.com, kernelfans@gmail.com, 
	liusong@linux.alibaba.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 8, 2024 at 4:54=E2=80=AFAM Bitao Hu <yaoma@linux.alibaba.com> w=
rote:
>
> +static void start_counting_irqs(void)
> +{
> +       int i;
> +       int local_nr_irqs;
> +       struct irq_desc *desc;
> +       u32 *counts =3D __this_cpu_read(hardirq_counts);
> +
> +       if (!counts) {
> +               /*
> +                * nr_irqs has the potential to grow at runtime. We shoul=
d read
> +                * it and store locally to avoid array out-of-bounds acce=
ss.
> +                */
> +               local_nr_irqs =3D READ_ONCE(nr_irqs);

nit: I don't think the READ_ONCE() is actually needed above. All that
matters is that you're consistently using the same local variable
("local_nr_irqs") for allocating the array, looping, and then storing.
No matter what optimizations might be happening and what else might be
happening on other CPUs, once you put it in a local variable the
compiler _must_ keep it consistent.

That being said, I don't think it really matters, so I'm not sure it's
worth spinning your series just for that.

In any case, this patch looks good to me now. Thanks!

Reviewed-by: Douglas Anderson <dianders@chromium.org>


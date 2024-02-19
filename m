Return-Path: <linux-kernel+bounces-71394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F79D85A481
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C8B2281984
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991B936129;
	Mon, 19 Feb 2024 13:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ws6dC0Tu"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7C836114
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 13:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708348721; cv=none; b=PYJE5OV9bs9ZS72cTvEn1mV5itcoF+egUWdDH+TuQnboRsc5le/7uyZgsKxyYxLP3DR38hO1B1sGyE9M3SY1MDVwGNaJQHPsD9JN/7P9Sjvr0nl+k62HKGr5wKJsJQk19vb4R1sLKhRZj9gbLNNs76Hw4BKflPzNstiF0XVhKik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708348721; c=relaxed/simple;
	bh=uCnhdlm60R21bhTAfsSxirlqxQnaziMtd1+fmxuiXkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IQtM3TgO/JixeAKhJ2soIq6FfInafxh9vsr1rf/Z7I3VT1UqKfJjjidfh9ZJ1FVSAoEsEQhwOHZt80FKkJdpLM8GkM6t62XskrGp25P4IWgJPTW9UMhevDSoiu0Cs3u5N8BATkauRTQqBfQ3e6disdWAeQIm3xowjHqZKz29dPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ws6dC0Tu; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7d5bfdd2366so2011747241.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 05:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708348719; x=1708953519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IlTEsH/l5PlOJ28yA7JjTHvi731W92lkicff9wtDqzg=;
        b=ws6dC0TuVLALNW1SUypbxKAjwJPD/4eufJyKIA7W2BjOy0MWm5pOuqI0ovMCjqu4R/
         q5oHcP0rihHKJsXQAPErBJLw2jFoc8Se3xWyzuDK4xfCA+ktVMHmsSUaC9eEFFluNi4E
         GTLukYbmPac5Qnn1dp7u0W6uf1+f95oZQJtrH8G+zS18FTM4URad7Hqhg2wurstKblWs
         +FYfeTBQJXRgoIqQEWXd+eih670iy5wOeYyataHGo/USx1SJEGU56FeHXqrhJgaC0G4a
         xZJXwcMptMOxAu0Ntz+bsESzI26X1pcC2rsHIuWuOpFn9Ms/nYQGZDM0pLG8+BZpScqV
         6wjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708348719; x=1708953519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IlTEsH/l5PlOJ28yA7JjTHvi731W92lkicff9wtDqzg=;
        b=ap0RItRD2ljDyo9WPuWnLvX8i5eZu3rrt+6YKaYH+jfCA+G93wTwfRz+wujVrdl6zC
         WHfNZLyiQIzMwD01Fj9HhOuuDB+78FHrnB/NlJMyqIVgMmeftQGfA4mW6084uuZuEMbd
         S/ofTj5HIHHKwXhMyp84VA/E/ORg8eHqvnCn0f6xkHJqnyg1BGe9uRLY7noYBBhpEMtI
         HPUGgSGZYrWzwDaHB8E//Ngumh/igct48vgRuZih7/Pw3CeBrk5/s6T/YOwLIwUzBucW
         tVGDnpWnPWq4lUJyIGwD3IRqUNc0qL8PibeyUs5DLOtgxxFisF0+qqYXKFVEl4diRfPh
         nYeA==
X-Forwarded-Encrypted: i=1; AJvYcCXZ5MeP6fsf5faFKCASD9gSzthuJt2h729J9DVTMrhozhjVZ0bINbLtwqh7i3yx+gBNt1dxsB4OBHdUpTUIcpVRPflzT+Z3bfnmThN0
X-Gm-Message-State: AOJu0YxzxzTmFGjwlVxel5DwoBqRah2VceGZUhOVnn3l5NL72iJFZ1pq
	fWE4GZgTTDKBONDo62uAndP43oyEb1DsqDq2nR0BfHiFDZn8IK6LrUIeFIpd35hV1zHjjnRYqmP
	ZeJ+ZLgjg5JfuyAXc6UP21beC3aBFOgTUz1nqVg==
X-Google-Smtp-Source: AGHT+IHgf8BA1ob8hWMW8dPJlcq7EvfmOhMFoTNTc7aIdOAsQg6TrF1PuiKCYzF3S1H9EoWk6cErlF/PJZMINmGnBUs=
X-Received: by 2002:a1f:d685:0:b0:4c0:6406:ee62 with SMTP id
 n127-20020a1fd685000000b004c06406ee62mr9192204vkg.13.1708348718047; Mon, 19
 Feb 2024 05:18:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205182810.58382-1-brgl@bgdev.pl> <20240205182810.58382-2-brgl@bgdev.pl>
 <5ppezcfez6tb3xmeevznwefvjjwjefwyzb5r6co4zlo53ht2c2@tdbwgbnxaalt>
In-Reply-To: <5ppezcfez6tb3xmeevznwefvjjwjefwyzb5r6co4zlo53ht2c2@tdbwgbnxaalt>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 19 Feb 2024 14:18:27 +0100
Message-ID: <CAMRc=MdioAp=LoHmp3imRtFe73zQz2k-CuAFioKJ_MzB4YcM0Q@mail.gmail.com>
Subject: Re: [PATCH v7 01/12] firmware: qcom: add a dedicated TrustZone buffer allocator
To: Bjorn Andersson <andersson@kernel.org>
Cc: Andy Gross <agross@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Elliot Berman <quic_eberman@quicinc.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Guru Das Srinagesh <quic_gurus@quicinc.com>, Andrew Halaney <ahalaney@redhat.com>, 
	Maximilian Luz <luzmaximilian@gmail.com>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@quicinc.com, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Deepti Jaggi <quic_djaggi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 18, 2024 at 4:22=E2=80=AFAM Bjorn Andersson <andersson@kernel.o=
rg> wrote:
>
> On Mon, Feb 05, 2024 at 07:27:59PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> [..]
> > diff --git a/drivers/firmware/qcom/qcom_tzmem.c b/drivers/firmware/qcom=
/qcom_tzmem.c
> > new file mode 100644
> > index 000000000000..44a062f2abd4
> > --- /dev/null
> > +++ b/drivers/firmware/qcom/qcom_tzmem.c
> > @@ -0,0 +1,302 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
>
> Could you please confirm that "-or-later" is intended?
>

No, it's not, should have been GPL-2.0-only.

> > +/*
> > + * Memory allocator for buffers shared with the TrustZone.
> > + *
> > + * Copyright (C) 2023 Linaro Ltd.
> > + */
> [..]
> > +/**
> > + * qcom_tzmem_pool_new() - Create a new TZ memory pool.
> > + * @size: Size of the new pool in bytes.
> > + *
> > + * Create a new pool of memory suitable for sharing with the TrustZone=
.
> > + *
> > + * Must not be used in atomic context.
>
>  * Context: Describes whether the function can sleep, what locks it takes=
,
>  *          releases, or expects to be held. It can extend over multiple
>  *          lines.
>
> > + *
> > + * Returns:
> > + * New memory pool address or ERR_PTR() on error.
>
>  * Return: Describe the return value of function_name.
>
> both from:
> https://docs.kernel.org/doc-guide/kernel-doc.html#function-documentation
>

I can change it but "Returns:" works too.

Bart

> Regards,
> Bjorn


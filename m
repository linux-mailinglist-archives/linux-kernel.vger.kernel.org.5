Return-Path: <linux-kernel+bounces-156493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 594748B0345
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B3171C233E9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D341581E2;
	Wed, 24 Apr 2024 07:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOir8rRj"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FB7154BF4;
	Wed, 24 Apr 2024 07:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713944171; cv=none; b=aiX+ekNIb2vQd9PB6a4hL7wyniMQ1j4ProUq6uNjFr1Wv15Vq/jb8i7GCeMu6ArKcwyJn/anYejoVQH9IZ4qwLWqexmRgMmVAeJD7fqW/LhxPS4JWRaBu0UP1Yc5jq4MeBGm39Pr3alXXDWcDAvhITIuoCkQFNhmgcixHq+tWkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713944171; c=relaxed/simple;
	bh=c/z07zNFy6l9O4ym8awrACppZadOXaOZ6v3/h1Fkyng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s0HJgsj9jMAySh1k2jl1VH+VE9k6W8feETxvQshJVw75s3Bt5jzSza8DdKTN3LXVhhdQ43HNIU3MXbUqaDqU8HROOupOWddsftBeLwVHchqz+j4zXz7q8hEMrO/72fcMw0O2Cynop8FgZsqxun6mGWKU1i/7U3Eg6dObD08CJUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOir8rRj; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5af3035825eso276945eaf.0;
        Wed, 24 Apr 2024 00:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713944168; x=1714548968; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d5dN4385UM8t68mi8BSqnB4iLyD9REN5+SY7+ouxH44=;
        b=QOir8rRjRvnUlIZ6hTAliGL7cQSniqBswXLdE4j0gnVT50l9a16OG6Vkdw0YE6DlPD
         HSzJZ1X/kGl9f3b/M/jfrXz7mVYEN0cFhm0uiVigRg2Q+jWpVnlFeGZ34KkKo2vrFWae
         95fHQ9p95oMa8r4eLw3xCguW4J0kNfTNKm8RhprGsBXMInFGyHJXliLN4FvSc2DgtZHQ
         aDpuEKfkRsRksk90WxdQ+/Apbe3oWJt4lU9ZE09bHhJNPHHUZaNnfVwwc1UTBUiKMW7E
         B8iYXuBUb0toISAzZCEA3rX2GstgCLEvFSB2Ep3GITFJTP8DMbw7BUyh9qGOQt4DH2Jt
         5dGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713944168; x=1714548968;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d5dN4385UM8t68mi8BSqnB4iLyD9REN5+SY7+ouxH44=;
        b=e/a+z5KynMU/tEybEyqzaLHMBKPXJP/z5WcM/fD88YQNwGN39Pv4Xupe76As6nO+4l
         QLiqstjmFdN/Pjrzo2+C91MeDS/Ai4SR5oO+q4LrejQtG/W+BMXFihCDtAgEO4y//EPr
         N6BdrlbZXfmsnpgAr3SVJcqO6l0GzvOMSVUm3wzNMrlQQlQVKf0EcYzqmzUBZsjuQIwm
         tQICGX+t+FHZRxpfnxYva+XFyMHAE+x8HwZSNnF2+IKyCkGNAdDdc9a6a53EU8p4LGZR
         5B2yWbJHVMCb/yO4Hvie0BUvH4SWmYLYaSQBqxwG0IVl2SXGh9lU03vQTR5fDqWV600m
         HuxA==
X-Forwarded-Encrypted: i=1; AJvYcCUAeEogpkv1qnxO16dPxX+oif0io6gIT3zmzXpJa5F73zSbTSq50er570ECvLVskXUwnAOfzVWDe3CeLOpI1vJdtvdNtZxKbgvhMWnn+aFL/cJuDMv/qTL7gNfaU+a6IGipJ7Oo6t0OUu6cdHFiH9xKTPCjuH0K5mtbK1ECsxKCELB+LQ==
X-Gm-Message-State: AOJu0YxLw6VMu82fF0r7G7Jc50Oy27TuO6sQRZke3pwM9giM63wjhxYV
	qKiUyNfXorcAXx+ZxTbhjyxoQbJoOsmPAjVJ5GPVT2ciTQVJqDxwW1QO9ACnPCuJLVBYVKXwnNd
	UJ7r/LF14ThJqHgH6IIj6bQZfR9E=
X-Google-Smtp-Source: AGHT+IH8pQbWlnm86dUfyzLUDG+dIloZwFnWYhwofqcI+AzW8x1xs/F4YtCqrgpl7S6KlC4rUUM+cjf4cTYA+FGUU/A=
X-Received: by 2002:a05:6870:9d96:b0:22e:b331:b564 with SMTP id
 pv22-20020a0568709d9600b0022eb331b564mr754227oab.5.1713944168226; Wed, 24 Apr
 2024 00:36:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204044143.415915-1-qiujingbao.dlmu@gmail.com>
 <20240204044143.415915-3-qiujingbao.dlmu@gmail.com> <202404172121325952016a@mail.local>
In-Reply-To: <202404172121325952016a@mail.local>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Wed, 24 Apr 2024 15:35:57 +0800
Message-ID: <CAJRtX8Ttwfj4+TcXu34ecNZjkdsrcb6rjovGMwpiwJhzcneB6Q@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] rtc: sophgo: add rtc support for Sophgo CV1800 SoC
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dlan@gentoo.org, inochiama@outlook.com
Content-Type: text/plain; charset="UTF-8"

Hi, Alexandre

I'm glad to receive your reply.

> I don't feel like these two macros make your code clearer, you should
> probably simply use 0 and 1 in the proper locations.
>

I will use 0/1 replace this macros.

> > +static irqreturn_t cv1800_rtc_irq_handler(int irq, void *dev_id)
> > +{
> > +     struct rtc_device *rtc = dev_id;
> > +
> > +     rtc_update_irq(rtc, 1, RTC_IRQF | RTC_AF);
>
> I'm pretty sure this would result in a crash...

Yes, it did happen. Because I inserted an incorrect pointer.

>
> > +
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +     ret = devm_request_irq(&pdev->dev, rtc->irq, cv1800_rtc_irq_handler,
> > +                            IRQF_TRIGGER_HIGH, "alarm", &pdev->dev);
>
> ... you probably want to use rtc->rtc_dev here to fix this.
>
> This also means that you have to request the irq late, else you are open
> t a race condition anyway.

I am very sorry about this bug.
I will use rtc->rtc_dev to fix it and request irq after
devm_rtc_allocate_device.

Best regards
Jingbao Qiu


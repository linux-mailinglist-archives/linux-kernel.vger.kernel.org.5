Return-Path: <linux-kernel+bounces-101447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B643B87A73E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA5011C21AD8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D70F3F9E0;
	Wed, 13 Mar 2024 11:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="is1MNn0M"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E353F8F4
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 11:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710330493; cv=none; b=U9QsoiyEjHTK5LPN8ws4A5alrjfY1g2fmnELNafkfbnuyUrjt+mQ1xqALsIdIArKj3bXUD5RWefLrGYHaTq2/l972ppW6eJg4eRK/pKQX/4tUlbIQozWJ85fheU5iZJauVMXCuCCjgDHZKvp4xYQOtZ6aRp740F6DcBNosLkh3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710330493; c=relaxed/simple;
	bh=DNFni+XUTW3FICrmk/m7hXGzpOYHOb0w8uarqKy8hAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dHB3HwMVx0n83j05sFOyOLZeqStexbvfCHES3q3U+D2a5PZ+ueqZcD0VaxpykRqmPhaPVbT5j93v8q9afM6VZBFYsiZalgCwtBt38m5ocQ3sqcdbdGbUhxoDP5G47gbE5IGoXYZUDzQNNxhveV2yDGo/gbg1EBHSFaYazIUW/JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=is1MNn0M; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7d130979108so3589916241.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 04:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1710330489; x=1710935289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNFni+XUTW3FICrmk/m7hXGzpOYHOb0w8uarqKy8hAQ=;
        b=is1MNn0MzDh2bNxd/Mu5MUtXha5AO9+HWfGhIwfIZQEiAlvyH+p2N5hq6MG1aVtn1G
         wjWs+GLQ3MAKVmHnmFI35vIpBINl6pFOKcxI6y/6CXNpnTqUbC9cwNYt0rNWyC/qcrjs
         MsQkCqn8GvYtf5+PIYTSLM6H7J2R9fyq+d9se5je5HiD5BpGYsRW7Z46GZQnWenOMceD
         RdYq6Dw+i1iDq6gb3Fgc6YB8CyApeJs7X1u0WtdmDUCk372RLxhrhhiNZcwNPWqjtyIx
         4g/Zm2pkeK9gpNzUNFoqTujAsWjho9ieUkMkoo4DQawydOThl01CRRJPgYDzhtmTe2uz
         iKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710330489; x=1710935289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNFni+XUTW3FICrmk/m7hXGzpOYHOb0w8uarqKy8hAQ=;
        b=o3crZj5+FN6fWw9zEk9Xk7KoU8ttqpFIJeBftbUqXyzIHYRYqHU29mAoAazIIlctoX
         vjyBARuTs7YVuKe4/x317ketTqhT9OZoyqEzsd+/OXujrIGX/oPr/a3tXYusICusPmOh
         j8oZ9PYiZogwzPvUfygQqadVzJ4R8Pcqcgg6qnaB2rkuQ1zPzAbAIuzzvdX6sA59Rx3z
         XI+31OUy4r+ejl4woxuwt9v2oAPCReFm+Bf83AkPnGDEGFTYD3voriX0Vd9HtswAODRk
         0bhB+B4PGxHpSsOwfntVq5fWtglKFlZTfOzPn4PSPny7YW0pFuyqxE8U06sFAveVulo3
         OLoA==
X-Forwarded-Encrypted: i=1; AJvYcCVbSOqAwMX5ES7TkBvbdXcXG5Yc/qA56kCcqtMZhWq/1jQK4OmSLO0utBW/2E63GfKH0UwQhsI+W9shxrpc7y6NRmRaAVOauiCdQvam
X-Gm-Message-State: AOJu0Yy8AzF762PEcWqVY/hFUdjy7v9UX21Dl/V8KXqTYC4dEM9VZSB0
	uZCMW4LPqXNMndlB+HORUmanHYkTGBRtN5DGsvltHkCpLXfLeKTAsLLJH8NDjFk7JRu7shTFaXs
	P3N/Rdgzb1DPFQf7Ae8kNLm0NHH3KbrlEkg2lIQ==
X-Google-Smtp-Source: AGHT+IGluT9xzhiFMWC0Cc9+B6tkk59Ep9zHKSImJGtOuPJFypPJghuHNvH8l+0pIM+ELjCSmDlX3v320pWMu4ltdjU=
X-Received: by 2002:a67:af02:0:b0:473:2066:6df0 with SMTP id
 v2-20020a67af02000000b0047320666df0mr9214696vsl.33.1710330489649; Wed, 13 Mar
 2024 04:48:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307135109.3778316-1-andriy.shevchenko@linux.intel.com>
 <CACRpkda6bykOFY6gcZqRKLAnprUooZooQ_g7Rj_63da2akbwtA@mail.gmail.com> <ZfGKkjxIT9AEd8dy@smile.fi.intel.com>
In-Reply-To: <ZfGKkjxIT9AEd8dy@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 13 Mar 2024 12:47:58 +0100
Message-ID: <CAMRc=McjYKCLGKk42SWdCy3Lc=B4B21WpS1kvx_d66itHKsQzQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] gpiolib: Get rid of gpio_free_array()/gpio_request_array()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>, 
	Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	Hu Haowen <2023002089@link.tyut.edu.cn>, Daniel Mack <daniel@zonque.org>, 
	Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 12:14=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Mar 07, 2024 at 03:36:18PM +0100, Linus Walleij wrote:
> > On Thu, Mar 7, 2024 at 2:51=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> >
> > > There are only two users left of the gpio_free_array()/gpio_request_a=
rray().
> > > Convert them to very basic legacy APIs (it requires much less work fo=
r
> > > now) and drop no more used gpio_free_array()/gpio_request_array().
> >
> > That's reasonable and makes the kernel a better place.
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Thank you!
>
> Bart, do you want me to take it via my tree or you want to take directly?
>

We don't have Acks from the relevant arch maintainers yet. I can pick
it up but I won't do it before the end of the merge window anyway.

Bart


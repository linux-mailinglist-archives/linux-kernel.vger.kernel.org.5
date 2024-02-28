Return-Path: <linux-kernel+bounces-85737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0267E86BA1F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DC021C25B59
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC94F70050;
	Wed, 28 Feb 2024 21:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mG9qMT+9"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC49670038
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 21:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709156338; cv=none; b=LRvNdsNz6FBmC0SurBRrI9zZdZz3/+1qGTHcmL6ZteX2Jkq45JS1TOqPc2if4GD5ohRMwtIY6UX4TsSRORkLvTrnbkMOsNDLV4t4Po1NALYuFQbEbqYMdMLJ3ZZWUYij0J0MfO7mX6ejXdXjrhLtEgadSjjN6zfBfQNT/GUiSx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709156338; c=relaxed/simple;
	bh=ZZYMMkvnT8rMcTzALb9auQy9jBxDCGxw/nkLNgFjKsA=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oEKxlGt7VFO/miZTEYTHM4YtzwPPMeKzORKoKtAXJSLuffUUtI07fHInMM8EnT6BcVPym/VPewhSaC6ywZlWsYaJfc5+G+mTwIcLm04MOdBSs8p9EZEvxbOa7qjfd9tmgL/CZMQlzxth5qWriz2vvtaQ0aVAoVxZJmN6OU4NrvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mG9qMT+9; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-513173e8191so159676e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 13:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709156335; x=1709761135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZYMMkvnT8rMcTzALb9auQy9jBxDCGxw/nkLNgFjKsA=;
        b=mG9qMT+9r/6FHrmIe8H+2YBd4V46U9J5uhVNcczMLRlG/OAnDpJ3YBiR+mIE5VzU93
         ofw7bVG0gdVH3dwZePnfrtU7mKYso+K46Pmun+aJNQJFYuWnGn3tR7oVXtUnOBhxjRbu
         npmpkxiM5erCstOsuDWSxubddRbHWiWHUUw8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709156335; x=1709761135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZZYMMkvnT8rMcTzALb9auQy9jBxDCGxw/nkLNgFjKsA=;
        b=oi9lkI3fh5P5LqWxDeaL2g/X+w28wPX5wv36sYRhWqkf/7N+AHrErYOSO+xUFipyIl
         8eWr8ztSSewe62BuojkNQmaOXJhA5tQc3Lmf0+hCf/N5Lr2wayFW6Ax/xin4Rzi2E55m
         /4LRQvV2o87ygPyIvqPCeyubIv9Mur2WeF5ErK7mglcBLNE30nEFqOKQpop8ZTSnslGZ
         qo6iJL0uRQ8sAS17+kjQvVsgITEQdFD8ZRAqADhvUIm4LPg3JxQ5tGImpt6V8rwul9oc
         05ZLfEClt+SUasEYflmivTZS6PG5PuYPE87PHQeNvRlk/TOXAJPfBC2JtDEC66Ww++/n
         1Znw==
X-Forwarded-Encrypted: i=1; AJvYcCXwFqWlRLT69/jlQvB5EDPo0SlCq58WHnKTCIDHGWNQedyWLVlSnTbX/GMwsOrCbAaFz1TFDnz1iUrK0hp8yB/K7s4h9+yIHTkLOgym
X-Gm-Message-State: AOJu0YwsqMjitqnWCWeHEqEf+GII+JUJH2jbRjR9t1sT5z5j+p92jsj6
	SytfV2v7U7koK5ESRz4Gwp/7hzEcE1J98k7f4kSKDJLAkx8J8gK6ZS7kkHctzBkInxhewTEJfaW
	TUTdVYAez0Rr1wE9fCnrNQsbuFbsJbUUDHC6I
X-Google-Smtp-Source: AGHT+IETIffCFIqYQK+u9ZTlRcZaGK6oBiJ82QRaqg2mZdkQFQuCEw+hnjwQN/Y1e0VJoJC6rZCYqp34iNcxXmVtIdg=
X-Received: by 2002:ac2:5976:0:b0:513:1a38:2406 with SMTP id
 h22-20020ac25976000000b005131a382406mr159441lfp.13.1709156334984; Wed, 28 Feb
 2024 13:38:54 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Feb 2024 13:38:54 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zd-nI9XoYW3hrPXx@smile.fi.intel.com>
References: <20240223065254.3795204-1-swboyd@chromium.org> <Zd-CJHkCHpuIEnWh@smile.fi.intel.com>
 <CAMRc=Mdapd2jTACGqm-ujZrAunRmNeJ8_3+bpsN4ieCre52yrg@mail.gmail.com> <Zd-nI9XoYW3hrPXx@smile.fi.intel.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Wed, 28 Feb 2024 13:38:54 -0800
Message-ID: <CAE-0n52cgFvaHPDLBd-cn0WMisxX41-fPJHkroTucxHNk39SZQ@mail.gmail.com>
Subject: Re: [PATCH v2] gpiolib: Pass consumer device through to core in devm_fwnode_gpiod_get_index()
To: Andy Shevchenko <andriy.shevchenko@intel.com>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, linux-gpio@vger.kernel.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Quoting Andy Shevchenko (2024-02-28 13:35:31)
> On Wed, Feb 28, 2024 at 10:28:07PM +0100, Bartosz Golaszewski wrote:
> > On Wed, Feb 28, 2024 at 7:57=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > >
> > > Have you seen this?
> > > https://lore.kernel.org/r/20231019173457.2445119-1-andriy.shevchenko@=
linux.intel.com
> >
> > Clearly yes as I queued the first one in that series. The rest did not
> > make its way upstream for whatever reason. What is your point? You
> > want to respin it?
>
> It was a reply to Stephen. :-)
>

I saw it but it hadn't gone anywhere for many months so I fixed the
problem I saw. Will you resend it?


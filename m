Return-Path: <linux-kernel+bounces-65243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B96828549F3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 763E028D6F0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1A853373;
	Wed, 14 Feb 2024 13:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="T3LIOYRE"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FC252F9F
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 13:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707915733; cv=none; b=gYuAGdZHhjAjDpBOyJVazfsULnzMYb/oPU5ikQIqFdYjZufXNpo47nE3P2jr1YR+qjK9AUaTEP+bXIJ9ApjE8KFCjTHuExVBCgyZjUveP2uPgQjWUF0T8LE83ScVU5yvPlR011AkThQd+GwZdeocsyU4k3/KrMIRE+K9gfLFhzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707915733; c=relaxed/simple;
	bh=VD7zYtGMmHeVlAM2fz9royx2rl1vyec+KkY4i/Lv32M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bgcvVKfCSG6XzZlBUS7VHEjoWDpCy9rG577amNyH1xWuGL4HapaKkqQJT/TAQQuZ6v3fi+gvJV6eM9ETEIEsUe45+lRNYTcZ7PaXdcIP6/r8/RVLasKVPNzShp22yNvRaEE6BNNUfgsy4YqnDQMENAXRCRQ690Xm4Cobq8/vmiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=T3LIOYRE; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c03d6e5e56so2596015b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 05:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707915731; x=1708520531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VD7zYtGMmHeVlAM2fz9royx2rl1vyec+KkY4i/Lv32M=;
        b=T3LIOYREjjNZSkhudnUc5Cr4UyY+hLGHLjAPM9mrvs3CFwxeayXomb8FVFfjZEFrVt
         Na+cHElgMJ02oY299tfhzSt9SnjmZdAIg5Dk1c3uy2WDJOXemFg4QMeDPuqujD+T4zkj
         r5ZN8hIOAAfePnS6dM1Vy9W8LP6o6qhtKjrZViAFX1tsQn/HrGi+fYDFCqISRVU17DYs
         lfp5UpoMuDUqXsd1a3k6CUa/G/ifp00UU24x9Ce+vR+8t5y7V9SRd7eTVLTflYuFonmA
         JScHAQl+iq11/hWIrzr5j7kuZ3CLlFwVky7tXRF+eubpUP/Pfo1pB/qticJoYLXoHv+K
         Eapg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707915731; x=1708520531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VD7zYtGMmHeVlAM2fz9royx2rl1vyec+KkY4i/Lv32M=;
        b=Ck/vnKOIxklA2geUh6PwdWCmkze/pDUEmTwSgbiLQBlyUIvh5da7DraBSOJFeGiPYB
         edG+B/5Zy4WXoI22I2z3e55QK/yHjXgujBB+pggHNTVJA+YtFaHwJVeXvZ4RrrAxCM4G
         hOUKeyEOQL1jAichvjyARW84ss0u5oZRQVnsE13eVn5DaKGRZTJdM0zGKmjU6eTwHMVg
         Cn8kAgZPr9wmgihHdwANQnoS8Y0syGR4/o8ilnz6gYB1dZ8eLTzlEtqOF/1Ipl4Tgg8F
         gVzDgXp4TMhh8HODDy+PrVtowwHm5SSURyoqzOJlEC9mz4MA2sKm4BJ5McEUiXTu5dhl
         ecyA==
X-Forwarded-Encrypted: i=1; AJvYcCXHKHW+O4/1VMs3ESIWZiIRSnG1EsZbxVHt1q3V2W2xNq2+W7G1RwEgMkmpHgbbYUJ6xDNXu4Zpy0LQT+irgsw+QjJO16VuR3IkqQTh
X-Gm-Message-State: AOJu0Yys4A5kKeBxliwZOvh37t1UmwR1rc7aMnljXAJyePMOaYBZOy86
	c9ptKAf+YaO1huH/3ReMQUAuda+KBVUIvmUofoa69fs8Q4H/ZZTrkmJlXj2iq/qfNzcnvMydg2z
	S4avv6ynN2O+wWkVqvMVMQuBn3Cn1MvUocuRaRg==
X-Google-Smtp-Source: AGHT+IEPS0V7YxUt0NBYw5QwuJGgE84saTNGAvFGJmdlkhRRd7Wdt4ChLS0y0QPWhBAUYffuH/+tg+hgttliVf3NB1A=
X-Received: by 2002:a05:6808:1a2a:b0:3c0:4838:a490 with SMTP id
 bk42-20020a0568081a2a00b003c04838a490mr2808794oib.30.1707915730831; Wed, 14
 Feb 2024 05:02:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214084419.6194-1-brgl@bgdev.pl> <Zcy3voO1yTPHo88T@smile.fi.intel.com>
In-Reply-To: <Zcy3voO1yTPHo88T@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 14 Feb 2024 14:02:00 +0100
Message-ID: <CAMRc=Mcbsz6DbxV2uO+wf73g364eoqDKetxNNDHFJ94AMvUr+A@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] gpio: fix SRCU bugs
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Kent Gibson <warthog618@gmail.com>, 
	Alex Elder <elder@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Mark Brown <broonie@kernel.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 1:53=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Feb 14, 2024 at 09:44:15AM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Here are four fixes to some bugs in recent SRCU changes. The first one =
fixes
> > an actual race condition. The other three just make lockdep happy.
>
> Same comment here, can we simply redo this work so we won't have tons of =
fixes
> on top of the nice RCU rework?
>

The rework is clearly a new development - not meant for backporting. I
don't see any benefit from rebasing. These are normal fixes for a big
rework.

Bart


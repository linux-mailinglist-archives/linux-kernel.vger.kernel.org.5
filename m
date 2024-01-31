Return-Path: <linux-kernel+bounces-47047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 945C1844871
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41680288BF4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE9D3F8EA;
	Wed, 31 Jan 2024 20:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bK1cfyt6"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532FE3F8C0
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 20:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706731777; cv=none; b=JlUzYY0CMcgcmw2+DH9W/fX4ZKT3yt8LVBwPMcgu8gsXfP86kqegT+MpqxaaBRWmAqV8EpWAmtHGisM+gwWUb7nTC5DuUjZBmtvSkIIEj5H7t1OuPOkZLOIKvxX9A94Z2lDlEIthGrLSxqVD1BvwBVKAAiGV9P4nPhA4h6rF9Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706731777; c=relaxed/simple;
	bh=JLs3ujfSuCNHk+r9kdTZgZWtpODoYZr4k8z7pON1yvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EebbpQZ9w3VoBB+Pq+zgX8bYPidehuGU4aAlbQyWP0ZbhLO3Tn1oUwu4ASpYxhHWWzrU5taAI4IUzaEsf2BlKVioDR2MXfDWBQpifQ9flIIuigJrKdY/pqzCQt3WaWnVqOQr3mR9MKewHZdN7Eu2HkAV95kZ349Ne6yq7l9tXuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bK1cfyt6; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-604055e48a3so1748637b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 12:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706731775; x=1707336575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLs3ujfSuCNHk+r9kdTZgZWtpODoYZr4k8z7pON1yvs=;
        b=bK1cfyt6tYlf+j0o+Y7hyr2YFD+Hh5ghGyUg/DFZVQNalDf45++avXVLDg1MvaFLwZ
         xYNuJfEF3uaI6TypnVMudQREDL565kIgHR030mem2aXkNAMYVi+6nOPMKL0cd4WV+Yxn
         X7hOjjdqmz5ISGznMdOlcKrobnQQkPv8ca4MCK8OkbzHOMaQX2pzkzb9A2z1AX3hcW37
         0QbOrpW230E8IUFSIDjsUaLjly3eNNvdXem6bFuuX34IMtRZ2sJo+zVP0jk6d0rkMhZD
         0LZdel/bJMwLTmYL2OyKYH5Ol0YDxJshYLTivMUklEueI7HLiH2se51yWzRNpRrWEjpX
         yM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706731775; x=1707336575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JLs3ujfSuCNHk+r9kdTZgZWtpODoYZr4k8z7pON1yvs=;
        b=oPhtINa7+qFIUU0yY04G3jPOLYn4idQwMUsfDluGX5btN0PQR9xQfd/Qe2eOK6ejCJ
         5tvgSITB06MQbhhISvzPnqAy6mHyrqajXRxwl5dRpFd8ftitP73VbTdUUS+yLpVo6vGY
         QbV1agOWPu7bxpxF0/8zg0/ENc3+stxbfGvHXp6SawvKQI4jcsmEiBfqRm6JQVGVqkxD
         ZxkIKvD+QIXiFkAg1ABfWXrNpb6PupjF9iFucDe37ub/LnJxasWSAO48Tv2XQt4V/sDl
         dRfy/deoIPP5F/7quIF3In60OB1TbEanA36GDuCV7cnKr/h1nE4pJld/9C0eetR+3Kby
         syug==
X-Gm-Message-State: AOJu0Yx8gj9mFLP5xldh2obCYHI14n6Xs17QeugiBVdvUR9HCITqUm20
	JiRXR7gDN2fG123fxhTvNxWwvZ/aF8mFpR5cckKutQ7qL6ELhuO/IPUPFGNI5xIdYyecVspRZYX
	37dWr+mR5jR09E4OpG6bOe8kfaC7Ip881oUAIyg==
X-Google-Smtp-Source: AGHT+IHWnRWPZWUvckvTX2Kui2FJv6wnHuN+ojzYWuMk02uVMcMflWeT2nzXAw/o466JxX0lyAaCJOmenvbPvIVF1/0=
X-Received: by 2002:a0d:c286:0:b0:5f7:5054:19da with SMTP id
 e128-20020a0dc286000000b005f7505419damr2622544ywd.46.1706731775231; Wed, 31
 Jan 2024 12:09:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130124828.14678-1-brgl@bgdev.pl> <20240130124828.14678-14-brgl@bgdev.pl>
In-Reply-To: <20240130124828.14678-14-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 31 Jan 2024 21:09:24 +0100
Message-ID: <CACRpkdas5k-MEdfOOuq3g-wACO=U1YKm4b3Qab6-QAHPG408BA@mail.gmail.com>
Subject: Re: [PATCH 13/22] gpio: sysfs: pass the GPIO device - not chip - to
 sysfs callbacks
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
> We're working towards protecting the chip pointer in struct gpio_device
> with SRCU. In order to use it in sysfs callbacks we must pass the pointer
> to the GPIO device that wraps the chip instead of the address of the
> chip itself as the user data.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij


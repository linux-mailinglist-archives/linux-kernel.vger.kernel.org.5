Return-Path: <linux-kernel+bounces-58048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D18284E09B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C06741F2A987
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBAD7603E;
	Thu,  8 Feb 2024 12:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nmr8nhgL"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E9C7604D
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 12:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707394890; cv=none; b=gH1pNJjJ+5/P34iR6rwF3Enc7/n3Lg+nUvFhKEiE8XWUE1Wn1Qmr1R5izBSdDRVXpWEgZY9mbKLBVaJUPAe34sCCJ/HNAwezOhkBa9djT+AbYvjyW8riUuF3TbwlVMDJLROxIlNucwtFNw/EkV11HIwZgKUMH5xvB5uzmyIMQ9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707394890; c=relaxed/simple;
	bh=c7XAvXW3JqDQu3a1gMUnXDEqNL5QzKj2+D77O+/2mAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZptWK3si7HnrWYpe8m1ZEYhs8APz2vZcnZsOLMsmo8wrg3EcDkwURZ1em82jzEpV21QsocWZz7VR2wDAwlQnhGih68HgDtMQPJYwLvXodqnTI/dwMAOMR0KJjCvPQWVfSwXOGwZQSxXDanBliuv7R0DkACRTK38h2psjIMtAzj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nmr8nhgL; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-604ab54bb83so3845027b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 04:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707394887; x=1707999687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7XAvXW3JqDQu3a1gMUnXDEqNL5QzKj2+D77O+/2mAI=;
        b=nmr8nhgLZPJ++N2Jp7Q0EweSK3WAkfvn7DK8N5vw5hOeM/cAIIuS8/C5xfpTrOZkPX
         5pxp3Swlj4UBdLR9M8AEkePwJhNQcKsx7sv0sG+OBEGep5QNu5BJGOhs8QXCXwtS/6qX
         pSYfN3nD14pZZZX8x8IR6WkfKl0FG6THUQmaYeqB1InNUqIO2KnXMimEt+DU+r98iF8i
         k+kRCewlC87n6N/5iTkAfnwlXxfDhe8rhipFvm+joU9cYWhMR9J88KhJKCv2RfTVAlTy
         1NbvsW7p5Wvq//ASOwdC1haSjfkM3HOj7S3XB4N1haDkq4vL4n/7E/1hviTs2HKQ+AI0
         uO/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707394887; x=1707999687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7XAvXW3JqDQu3a1gMUnXDEqNL5QzKj2+D77O+/2mAI=;
        b=vt/nJDJjrZuMqjOJQ6MSVsm5ya7Xk5uOU+ofEfU+sbWLsvlA1sBJB2ZdaL1JFbdlcp
         xUPp4hy3Qz1WJ7PDfCfceYHpIBgXLFIXN1KY80hK1j5wf6mf5Atw/a+wag5kGFNheRUy
         OcL6dk6XzPqqLlCChFED7Tr2TTDMJXjn6NkiNEpmB7abWDNQHwe7aW5BDhqenhIsxIZH
         l6fG396KgF3Lnb6RxVyOly9m4dlDgSARg+xrASZfpBwsodASzvkjdKNxYzyfICoFu7JW
         z1C7MAR3sfDj7o3wJJmN/y+sFvCDmgon0XhPXzpmHflnlnKBEc31UQnP+8+MtcG89k3X
         jp2Q==
X-Gm-Message-State: AOJu0Yw8V85VlKPz7YRQoG/aXMs31XfgKDDjFRcJ27MQd5IMwwlIW5Ot
	b+HNeqrk1HabEl3rcdRm9tDuBx+/ov3macvu4HuAe0cUmo8ZtyyqpVhMTqA1qvF1UApPdqwS9+i
	O2xlRpu6PBYhYexeR/Nx/Q8DFc/Mz+VUDhAJGeQ==
X-Google-Smtp-Source: AGHT+IH+rdYwt1V9v42o57rZ+obkKonh/gd6tgsKYiHOCD7690dxOjHGrL+EaoIIsJbBelNWioDPFHCf8ZENSVttMvw=
X-Received: by 2002:a81:e443:0:b0:5ff:9676:3658 with SMTP id
 t3-20020a81e443000000b005ff96763658mr7587421ywl.48.1707394887647; Thu, 08 Feb
 2024 04:21:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208095920.8035-1-brgl@bgdev.pl> <20240208095920.8035-18-brgl@bgdev.pl>
In-Reply-To: <20240208095920.8035-18-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 8 Feb 2024 13:21:16 +0100
Message-ID: <CACRpkdZOzekCQ44Mx8ruQsx70Z6ZZtAOxxr6hy0PSQGqB2T=0w@mail.gmail.com>
Subject: Re: [PATCH v3 17/24] gpio: don't dereference gdev->chip in gpiochip_setup_dev()
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kent Gibson <warthog618@gmail.com>, Alex Elder <elder@linaro.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 10:59=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> We don't need to dereference gdev->chip in gpiochip_setup_dev() as at
> the time it's called, the label in the associated struct gpio_device is
> already set.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij


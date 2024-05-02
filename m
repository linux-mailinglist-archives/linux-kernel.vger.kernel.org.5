Return-Path: <linux-kernel+bounces-166104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C6C8B9640
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D13691C21609
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793B628E11;
	Thu,  2 May 2024 08:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fZUWeJI7"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576652D04E
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 08:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714637783; cv=none; b=lTkrQqFZU2qAm0ggevC5ICAXKHLTSs78nqmfalkGTY9tKVWN10fHx90qRA/KWHIom+/+1WXgoxqSQaypwJ3VVp7J7jUPHZttVyNkL05J2zby2rCzrb3z32E2AUbjNqI+5oS9ulutfao2+AKAp5w0NHnwdCx8n9I4pozNMtmq7zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714637783; c=relaxed/simple;
	bh=sw3n3mAExpJtGyzHD90cvwAbCXAEOmh9mL/3EWKffGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hh1HlQScVs4yYC071vscUKfX7kH4uZqWsyxS46PH62BCLkA7t9VI0m3pOwFXbqTrlaH1DxZcr7HDl5e2fqvdwUWWAt1L5EgPbrfN0Y2veWvBYPCGNlppu3yMiOtg3yC5w2adtfxjtRqzfdckZGNXtIAHTaS1ZXo+ljZNzKQQm2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fZUWeJI7; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so8363811276.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 01:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714637781; x=1715242581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmFyvlIHda9NU2gXF06k2ZQ7jALqIM9zqt9BFQX5Bik=;
        b=fZUWeJI79qjWtFa/NC433F+7iM7wEsFnK1ykA2zU+fOs9KSFPire4UbH6Hvncw8MDc
         YpB+WFyHnaWLmajXmQhsBJMXIceQjrfy7pk3xpXMTgiE3QLx87fMhShDZOZssUMUAWHx
         rxx3X6nkwnXICQgWN/bWvusaxGV7EC+ep2sDahAfC7zx4i87SZ4zqd8n/H7pgX2KuU6P
         vtgBdL6GClXs8ABXJ/Gx+h2q6NsFgdhbSA9DGAeF5tdFjte/c9bDTjkguEBakmpNkf5B
         q3s5QgmIoKlpG3/c1OZmEj8ZYSLCehmRr6s/Ut4SqzAcDOs/MGg6oolas48xBZfh/Eao
         VWLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714637781; x=1715242581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YmFyvlIHda9NU2gXF06k2ZQ7jALqIM9zqt9BFQX5Bik=;
        b=DDtwr0AI4W14kw222nXJD6dJsZNzSE44Gy5PhLuWgeqhapg+NTJI5kMOkEd9OeKLg8
         fFxVX8AHxqY27rRDkWTAghjkeqBM8h/qiIGS7iU04DkcIUuHe0A4myJGKj5qLy7JK6x/
         x4GOO8gPYsDxk/vsMU7TdZD/jhQVIByZnPlPXZpBU3ChVP5GaCOTHKK7d9WT6Jfxz/z7
         ZaxTfJkKjeMGsJYweCqOQHUYlKxz9xLSMDOhKghF0XwUbwdoowSMR+5rYRklVQue2PTI
         zUNiStHter2geL4x1gr9ZwLVpWBkecbcQ2/aqDiTgMjE1caEYmY+UGWmjQQ64grYnCuo
         cO2A==
X-Forwarded-Encrypted: i=1; AJvYcCW14bjw/0z1sTvlLLOWsZgF7ZzOoSbXZOxrpi4XGxIzVjByf2yOU6lnrgnwhMGO/Bdk5eKBwWzc+NJqlqwMjvm4lg85lQwmxh5/BAXi
X-Gm-Message-State: AOJu0YzSq52Zc21xrhDkqwjugpA77IXUvPXX5Gk50zcSP13pK86/3qny
	Rf1K0PEmdM07rFgQrCjqY0LK7xe/u7u07uxMq8ZuMomPf4KmNXJtPrz2k4QyqKG6z3kOqQD8UYq
	brldTAgSWtkHQ0y4cNHc9cTvz/0EZXO9LchcYUg==
X-Google-Smtp-Source: AGHT+IGWpSFsiUp0ZxMBi1ohvTy1MitUsB7eEmtKa3lo9//fq1VBpFee4oo8p3YyoVLxMY7HtddoXw4j89bpKkdUQ5Y=
X-Received: by 2002:a5b:b4a:0:b0:de5:4b71:2d1d with SMTP id
 b10-20020a5b0b4a000000b00de54b712d1dmr1475592ybr.29.1714637781422; Thu, 02
 May 2024 01:16:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501154251.3302887-1-dianders@chromium.org> <20240501084109.v3.3.I9982cd5d8014de7a4513f5619f66f88da49ce4ec@changeid>
In-Reply-To: <20240501084109.v3.3.I9982cd5d8014de7a4513f5619f66f88da49ce4ec@changeid>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 2 May 2024 10:16:10 +0200
Message-ID: <CACRpkdZ89p29JtcrKKZ9L4Sea-TddTnpBrS4tzth0f5nhQtrEQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] drm/mipi-dsi: mipi_dsi_*_write functions don't
 need to ratelimit prints
To: Douglas Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>, Hsin-Yi Wang <hsinyi@google.com>, 
	Brian Norris <briannorris@chromium.org>, Sam Ravnborg <sam@ravnborg.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Javier Martinez Canillas <javierm@redhat.com>, 
	Joel Selvaraj <jo@jsfamily.in>, lvzhaoxiong@huaqin.corp-partner.google.com, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 1, 2024 at 5:43=E2=80=AFPM Douglas Anderson <dianders@chromium.=
org> wrote:

> We really don't expect these errors to be printed over and over
> again. When a driver hits the error it should bail out. Just use a
> normal error print.
>
> This gives a nice space savings for users of these functions:
>
> $ scripts/bloat-o-meter \
>   .../before/panel-novatek-nt36672e.ko \
>   .../after/panel-novatek-nt36672e.ko
> add/remove: 0/1 grow/shrink: 0/1 up/down: 0/-16760 (-16760)
> Function                                     old     new   delta
> nt36672e_1080x2408_60hz_init               17080   10640   -6440
> nt36672e_1080x2408_60hz_init._rs           10320       -  -10320
> Total: Before=3D31815, After=3D15055, chg -52.68%
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

OK then!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij


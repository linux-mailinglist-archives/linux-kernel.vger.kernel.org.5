Return-Path: <linux-kernel+bounces-166103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 653FF8B963E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CF271C21550
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8BC2E85E;
	Thu,  2 May 2024 08:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kYFkiLwQ"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C4328E11
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 08:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714637746; cv=none; b=GXKx06THt6ytggeQHnG5X/fN9YCL0IEsWAffEYemOz5wbsZWjUMFiCwyGRVBujxoBsY/xuoCTBkLfV/HyFTC7NiMgeY7bF0NhmBhoiacwZit4tSIUA8Qdc1YP8nnXjJ+v0ldMJlSgU/UiNhLpRVXMGQcB5nr8PNU6sXyrLWzbOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714637746; c=relaxed/simple;
	bh=JPD7b2tlPsaevXdhHvcPK215ZvD2x+kRPAKiVuy+R50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KGf7Dp1l0daQkMNYk8bvgagrydvkW3pJ+9PK7Nxfye8QMKyBesUSzMDdRvgzjOWiqRUPGwSHzuM2dGm4xofuQ6AjEbnn4VBm48Lcyq/xlQZw0nFtHTLnzvG2lG7AUF/MX0fkcjpyBHS1RzfEmsAIT1FrPtu+IZ/1jPyPSTU0sH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kYFkiLwQ; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-61816fc256dso78233157b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 01:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714637744; x=1715242544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5S/Vn0g70fC06g8jlyeQvB4ZGZRV9mVbLHjIiCg/NGs=;
        b=kYFkiLwQWpbVjSWfW/1TF6iWH11LjZhyyLjAQkUNdg20nkKkuqxEKSZUD1AmVQJY0F
         u0GjCfosz35+OptJAQ4eilQ8rJuPImEMBcYoBA9QEZG5u51NoJWlRo6/Sg6T1cAUw1j9
         YoreVaoJY2o1XL0Cb6kCgfxq/7r9M/MFettS8ii8hCd+ZZW6f20LOHusY4K/s4IARhXk
         IMEsNfeIQPZxpoRHr5vDL1HTK1oEWcgh6l/MsQAL0SxuvRChhp5K3mOBQ9P55RZIV/Ff
         PlKnAcGcmDg3qkq8Z/nwH6c4wWQWpoLLzAGeYHSLPuFdDncjVo0TYvezJi+qWcSxzQIQ
         UwBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714637744; x=1715242544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5S/Vn0g70fC06g8jlyeQvB4ZGZRV9mVbLHjIiCg/NGs=;
        b=a8IswEEzb1rui1pKWXgyZYVpQvtKGyLBPBLlL9rHJtpFZ6y7gLCrV0k9/kwhY7DvT1
         q1lRrVhqBMFfPIk1QUP/qTCKKIQF3paBkwWwY7xw8ZBVIjSDzIrdGDCFxMUOzCOBuFRV
         wUHMrFfJ+lJJB1QDNQkdGWwX8J7rBPtvHIKRUNYtcRHL8A1Xi2+fvNY0cRhSQyfylIvH
         KWGwU1w+I8JCQ3gtQ4ADmnP0SgK6ETMyPLyVzRwcV4OHcQpGbHm7lB/0wyRXlt7agfyI
         BbDVdtpJ9aoE3fLU2Icdrqg26lF7lfr5ewSpa72Yjbf9ErMLs+kq25hE8TGNJk/EWkJq
         eF6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXmSqWPTcMrM9qqJcQ8W0K9p8D90JSB2YDq3l1Od7HO6OzV9xGyAycPBokFvs6WT1nO9yzaNXs3fyPKc+RFgCedO0WIS5D4ew/f8Wxz
X-Gm-Message-State: AOJu0YwiTaGjLWLb9HAKrg4ylsJbmS6znzE9dnW7Wy5IBxfK/ni51g/R
	c9c/GX93fb9W/tstKcye3dGyCNhV+wS54Aw0cY5fsp5A6YST+xqGomwXJUn3XU8Qn+isXU8Xakb
	1UGAHT+1DhEEviMSXn6CjSbMFEgaEVqR2PDY1ig==
X-Google-Smtp-Source: AGHT+IFQN6e2CW2O0jj9xW0UNZm+IJASAgpOckxhGFhd1ISoRtklWjM+E52dQkZBjtkD9HAP/Js4ltIQqZxLBYRiO5Y=
X-Received: by 2002:a05:690c:b82:b0:61b:91e3:f954 with SMTP id
 ck2-20020a05690c0b8200b0061b91e3f954mr5648431ywb.8.1714637744077; Thu, 02 May
 2024 01:15:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501154251.3302887-1-dianders@chromium.org> <20240501084109.v3.2.Iadb65b8add19ed3ae3ed6425011beb97e380a912@changeid>
In-Reply-To: <20240501084109.v3.2.Iadb65b8add19ed3ae3ed6425011beb97e380a912@changeid>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 2 May 2024 10:15:33 +0200
Message-ID: <CACRpkdZQ5SHatac4uPUKd-ABu6Xd5PDYeKoFGvFQMssYOZW_mw@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] drm/mipi-dsi: Fix theoretical int overflow in mipi_dsi_generic_write_seq()
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

> The mipi_dsi_generic_write_seq() macro makes a call to
> mipi_dsi_generic_write() which returns a type ssize_t. The macro then
> stores it in an int and checks to see if it's negative. This could
> theoretically be a problem if "ssize_t" is larger than "int".
>
> To see the issue, imagine that "ssize_t" is 32-bits and "int" is
> 16-bits, you could see a problem if there was some code out there that
> looked like:
>
>   mipi_dsi_generic_write_seq(dsi, <32768 bytes as arguments>);
>
> ...since we'd get back that 32768 bytes were transferred and 32768
> stored in a 16-bit int would look negative.
>
> Though there are no callsites where we'd actually hit this (even if
> "int" was only 16-bit), it's cleaner to make the types match so let's
> fix it.
>
> Fixes: a9015ce59320 ("drm/mipi-dsi: Add a mipi_dsi_dcs_write_seq() macro"=
)
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij


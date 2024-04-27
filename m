Return-Path: <linux-kernel+bounces-160866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5F98B43BC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 04:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB8DA1C220AB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 02:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0107738DE0;
	Sat, 27 Apr 2024 02:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g0LbVI2n"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86990383B1
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 02:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714183528; cv=none; b=FhKyVNbJS9fINCUbMd5QOSPJi+JUa9eFbsOBZWzUeQruavxH6pspIPcvUjjCL0FcV22njlfxxllMrnN3Er/fMz9rPDBXBFePmVuDiqtNpGbQQkzO5ADWbAm+tVwv8pjP17FYa+fBYQ1ce7eqbnVmu9E1RledWLaDSlMeGcD5EiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714183528; c=relaxed/simple;
	bh=mZZ4c0mnRqBfsEIMbKcc3YoUl1QsqahrEbnyLoOeDVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fwvEMxDyTAYi35Ha3f3HBgc/9yqdF8Vlg8ke+kaLNEoOxB3b3PlCemvvPP8vbgChOMsbPXEyb93imuZ8oEKgZ6uiRCzOKhCwsrdwi9cwdepF21+QG4KaOgs+Uub0ewcCbp45oeJ4HN/TVSbFtD9CkVVLlLhD8+LYD3//tIasBN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g0LbVI2n; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-617f8a59a24so25758607b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 19:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714183525; x=1714788325; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bWxST7R5ZxzrDscEPj1WVcSCVkPOXWKQJTTlykb8isE=;
        b=g0LbVI2nd2GJIR3ZKt3hqMJvbblXtO5t1MblKcVlf2RHEkqAF/6vRPrGzyurb/TyZ8
         UA9km9MffWbipRNsYD03noy01O9m5WOKq5bVRUAaOEjuw6KI3cclFQxf+ClNw1lQ3VBd
         Vt7mzLs3tkq4sD/DIaN37Vsgkh5v8f6emNIuSpb2liJvuETFpAx9gCxsNW8zs5/IKAkm
         ACwq9mOSjpVJhlbH994+itg7VTT0nwGIIT4tpFneYTQiM7DpCbGvwenKsHaUu7lAeiHm
         DYcWIYtL0Gg4AValZKgDBGqWzTdRFFb8nr+ZsU0b07NgMBxmVGoN+Q4V2Rd5O6/2Ensa
         DLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714183525; x=1714788325;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bWxST7R5ZxzrDscEPj1WVcSCVkPOXWKQJTTlykb8isE=;
        b=UIxs6AsN+pqizcMoazZceY5k0fw09xKbq9rqa758zvmgHZ9PbFnwYufwI80GryAAAy
         H3Mxq2hOIPAe7EsltANpEQpd4DuULGu3HFSHNeDQBGp9XJvHte75vfUqsKLw26O+I6N6
         bhUdZvPwok3ANv746wV+WAd8FBmIl9VDf8srVaWE4nLyocclJDKNfrKAxYzGbTsUGqnQ
         0oUWUZl03CF6DAfKMuqFfm/PdHEdlQ0tVE393Qsb/+pu9l2x6O9N3ZFZownxVcFSxrbf
         47MgxmCKPhCV1Y44PYRudlHTkawCS0XRpBmdGffKY6wE9PQUJtSykTRfJcQndHo/wKwg
         If0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXxyPyV5mtiCB7AvYktKBkx4429qA1JTWhqRGLcdYziVPDe4en20a8OFWMdmBEkbvSLZImHEnRlR1ZTn0COFghwKUDJJKD7r6q6oeNF
X-Gm-Message-State: AOJu0YygwLzyyEilQ89MGJXxHja/doiQ2kXi+Df2YckI0QPU4HXMwAc1
	59NUVhjfKUhczC9BrR1SkOB9h+sgRbYoz5qELw+kjD+wU9ymBoePtn6S1/ENItNOwx+WC1diehW
	eo7C9f7O6LZcwIB+HzcFS8Lcvsn6bkcTKBS2zSQ==
X-Google-Smtp-Source: AGHT+IGnRShRp9PeR2/ALAStb8yu6otKEbYsvFyI+r1QREL275VyB3Nulrh8Ejld+RH/JqoCG6Z8hiJolHCvPun1Koc=
X-Received: by 2002:a05:690c:4483:b0:615:6d2c:2cf6 with SMTP id
 gr3-20020a05690c448300b006156d2c2cf6mr4974839ywb.47.1714183525401; Fri, 26
 Apr 2024 19:05:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426235857.3870424-1-dianders@chromium.org> <20240426165839.v2.3.Id15fae80582bc74a0d4f1338987fa375738f45b9@changeid>
In-Reply-To: <20240426165839.v2.3.Id15fae80582bc74a0d4f1338987fa375738f45b9@changeid>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 27 Apr 2024 05:05:14 +0300
Message-ID: <CAA8EJpon4wAT8=U5t2pyzdDWDjY6651QyDSp0hJGn9WGks6-ug@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] drm/mipi-dsi: Reduce driver bloat of mipi_dsi_*_write_seq()
To: Douglas Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, Linus Walleij <linus.walleij@linaro.org>, 
	lvzhaoxiong@huaqin.corp-partner.google.com, 
	Jani Nikula <jani.nikula@linux.intel.com>, Hsin-Yi Wang <hsinyi@google.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Joel Selvaraj <jo@jsfamily.in>, Cong Yang <yangcong5@huaqin.corp-partner.google.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 27 Apr 2024 at 02:59, Douglas Anderson <dianders@chromium.org> wrote:
>
> Through a cooperative effort between Hsin-Yi Wang and Dmitry
> Baryshkov, we have realized the dev_err_ratelimited() in the
> mipi_dsi_*_write_seq() macros was causing quite a bit of bloat to the
> kernel. Let's hoist this call into drm_mipi_dsi.c by adding a "chatty"
> version of the functions that includes the print. While doing this,
> add a bit more comments to these macros making it clear that they
> print errors and also that they return out of _the caller's_ function.
>
> Without any changes to clients this gives a dramatic savings. Building
> with my build system shows one example:
>
> $ scripts/bloat-o-meter \
>   .../before/panel-novatek-nt36672e.ko \
>   .../after/panel-novatek-nt36672e.ko
>
> add/remove: 0/1 grow/shrink: 0/1 up/down: 0/-21496 (-21496)
> Function                                     old     new   delta
> nt36672e_1080x2408_60hz_init._rs           10320       -  -10320
> nt36672e_1080x2408_60hz_init               17412    6236  -11176
> Total: Before=32147, After=10651, chg -66.87%
>
> Note that given the change in location of the print it's harder to
> include the "cmd" in the printout for mipi_dsi_dcs_write_seq() since,
> theoretically, someone could call the new chatty function with a
> zero-size array and it would be illegal to dereference data[0].
> There's a printk format to print the whole buffer and this is probably
> more useful for debugging anyway. Given that we're doing this for
> mipi_dsi_dcs_write_seq(), let's also print the buffer for
> mipi_dsi_generic_write_seq() in the error case.
>
> It should be noted that the current consensus of DRM folks is that the
> mipi_dsi_*_write_seq() should be deprecated due to the non-intuitive
> return behavior. A future patch will formally mark them as deprecated
> and provide an alternative.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> Changes in v2:
> - Add some comments to the macros about printing and returning.
> - Modify commit message now that this is part of a series.
> - Change the way err value is handled in prep for next patch.
> - Rebased upon patches to avoid theoretical int overflow.
>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry


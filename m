Return-Path: <linux-kernel+bounces-166114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9663D8B9665
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57FC32876D9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022C5381DA;
	Thu,  2 May 2024 08:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EElmt4gW"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54BE33CFC
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 08:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714638202; cv=none; b=kRcKuIkb7OlscM5E6QoclDT+bnlYj2N0nMnbdNjkayqS9Y7xs/arNC9Q0sK4UAObPdhnA/McKASjDLDE6xXi/4t5u+eJfjT/i29V8wc3h5T36PPgHZ6rWG1/meIV3E8OIaLHGgQYguLDqmEak/17KIGpYcvVEsrPtZaf1Q+QGlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714638202; c=relaxed/simple;
	bh=24YyTRYR6RGICTEPRKVLXQM7MeeLdxtmJnjzlihyxds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SuEqbEsjPpOlDWxTbagdFIUHd9UIEsQhUEvjXUTL+oW5oTmTJESU++kodEqadl5axMDiJwG7gicVnkk9oQZIZ+rDSSJNR2T/LwRQH4q1CneZdR4NWzsbHsfIhj+WawoXxykXGeh34dcuhssOlkoF3Mn7wQgw49QPjNGK0hc6Ruc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EElmt4gW; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-de59daab3f3so7167131276.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 01:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714638200; x=1715243000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24YyTRYR6RGICTEPRKVLXQM7MeeLdxtmJnjzlihyxds=;
        b=EElmt4gWUzf2LkC1r3k54+Tdvda62KYBoiZ5I024uGIqmrIbhosHhpOcZQJAl9f270
         7IdeJYcGB38Rt5DXblpV8GTgzV1aBvIz4N2F54DTCGLobq/MRCH/6edlVWyGk1L8A7zF
         /SNnzpYO/pOquJR1ug+9dBi3Hcre5/UiBrlmNMgpDF5ejXPESgma62eCbHS8zJNuB842
         yqTD4guEaMjQvWd5o1fC3zUI5toizeD8BN7XKr7X+WwW6EeMffhlpU6xyQNrburgOHq3
         TaFB1Wl1lSw1o2/tclKPVCRoSIg7Wkuh+i9c+M6777ykZiXDaDP4+iZrDSU4BMtRCkjY
         4Itg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714638200; x=1715243000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=24YyTRYR6RGICTEPRKVLXQM7MeeLdxtmJnjzlihyxds=;
        b=WKaqQszGSRbp/KQrvfuDBatlxKSKV08pS+K0KQtHnb2uKAsTS8ZrqwN8LrmLv2FZZv
         HwgQfFtQwPSGIH8R1oLClttFz+YCmyXmVF6JvcxEeUkJ6PeFEePhUXHahBczOWR2iYfZ
         vu2LJv8TiRLmqaydvSnOo2+ENIptgqcx6zHa8+N2qUEssv4UtR3ZnUBFOC7dqQy30N/g
         chhVB7KSHSbVp+yZg6JfLhydFgz9Sej7VkpFHU5XMtS3Nh+AjWjHP6wg05gdEmGwPByy
         LidIJpdZYxifAEjqqqK8Y0fKSsu9VCqjpbX/o3wFlW9UX1mzloUmIVm2jRLkOFqvhLss
         lMtw==
X-Forwarded-Encrypted: i=1; AJvYcCV6JgqtTVZ9qXIfzFKSqkUyPnjPbR6yujnu3L1Ct7zlKI7nhaxpN9KBSpmnpUiChMQl3saelV5FhWH4O0paX+Xa71brJyGp2ph/dWw+
X-Gm-Message-State: AOJu0YyBHKP08ibAFkpe23eyLmaa5EEC30TDNO2AHAsNpMS5//W1t/y6
	tkFLn+bVdA2JTjFaIsg2IFeRAgO90YofQf9f8ReMTYO65f9jL2Hvl2r5vQg+8GwStwoqlNB4W8v
	kkn48s7a35Z1xKD4FA0ysfoPbHL6A7lgwmwQSwA==
X-Google-Smtp-Source: AGHT+IHJf8nsf+hQ0oYySY8kc9eXFs7bLgTHLiT7HAY38ioGQLECM9C1dGV4rTXrwZjUZET6iMLonxw6UYxZADDvgl4=
X-Received: by 2002:a25:2b81:0:b0:de4:7603:e888 with SMTP id
 r123-20020a252b81000000b00de47603e888mr5029716ybr.29.1714638199758; Thu, 02
 May 2024 01:23:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501154251.3302887-1-dianders@chromium.org> <20240501084109.v3.4.Id15fae80582bc74a0d4f1338987fa375738f45b9@changeid>
In-Reply-To: <20240501084109.v3.4.Id15fae80582bc74a0d4f1338987fa375738f45b9@changeid>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 2 May 2024 10:23:08 +0200
Message-ID: <CACRpkdb2eJWVYREhpCUoJnYeutBybBY8mic2SAUuU67MW5Hjbg@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] drm/mipi-dsi: Reduce driver bloat of mipi_dsi_*_write_seq()
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

> Through a cooperative effort between Hsin-Yi Wang and Dmitry
> Baryshkov, we have realized the dev_err() in the
> mipi_dsi_*_write_seq() macros was causing quite a bit of bloat to the
> kernel. Let's hoist this call into drm_mipi_dsi.c by adding a "chatty"
> version of the functions that includes the print. While doing this,
> add a bit more comments to these macros making it clear that they
> print errors and also that they return out of _the caller's_ function.

This doesn't really explain why this takes so much less space.

Please add some explanation like that "the macro gets inlined
and thus the error report string gets inlined into every call to
mipi_dsi_dcs_write_seq() and mipi_dsi_generic_write_seq(),
by using a call to a "chatty" function, the usage is reduced to one
string in the chatty function and a function call at the invoking
site".

With some explanation like that +/- added in:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij


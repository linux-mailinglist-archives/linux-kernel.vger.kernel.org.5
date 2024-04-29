Return-Path: <linux-kernel+bounces-162438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A5D8B5B34
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CB11B248F1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AED57BAE3;
	Mon, 29 Apr 2024 14:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ggf1VbJd"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24417441F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 14:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714400816; cv=none; b=dt/jJh5MObuf+AfAo9dw9nTYkoK6ravV8OMFsXyhXDBU2PpDzYQGzABrUFvUGHe84PWpkuvcM77LTC2IG+KrbDbmD+/NSnYsSg+VcGkp10OzWaE4iwjhB2gBNubxwuU6QmUKvsOZfMN4mOk917gnqOqk9gSOdQs5d8Wmks99Ibs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714400816; c=relaxed/simple;
	bh=HTekq4v1g9PJYx89IdggT2vGh+svrZvAdMEVJmZM0R8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mzcptp0cgUKbfStk1c/laIbt44PUvDY2Q+QshXjj1hNTeLsYlOFo7zxEIArz4KKFrI+rpzkQtG4nalIj2uK2wPp6evfjrQ5Rl7BJqRpo4CiJbhWkJ69DtWEfhWImG/2OA8rnQf0XV9uRQ9oGQy9OaWYAFatOORpF0bge86TjQJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ggf1VbJd; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-43a5715f71eso22974871cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 07:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714400813; x=1715005613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqDQQoT9vxUaIMkwbyFExGHs1F5iC7Nw1z6NMheJx1s=;
        b=ggf1VbJdq5S/vNO5w2QDy4SWyJitdi6Jcm+UBR2XxZ2tgVzw0nWSTyjapEXcc0wWKm
         7uH9bLVBMRhQtk7sZxCPUa+5uJK57mmlSSgZ6Oi7mPSElb6QEoPAEn9vBMR6nQcmWRSa
         W7sxJkjhPyD4KoL1ZitqYzOYGqXJjDrfVmtOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714400813; x=1715005613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NqDQQoT9vxUaIMkwbyFExGHs1F5iC7Nw1z6NMheJx1s=;
        b=BglqgPHGEZr8odrR3ykDe72v4wE5FaN7zxzuu4hxBEVTSKIXVFWdjfXEwKv1DE/7VB
         sKVmgypPsVe9lmdCdVetKU9DLloowamJAjRsavP6xGp8Hyuo7aHxWoSwv6+mcEqr55AV
         +qwZ7ancm8qxX2zPteXJZf+jhR+vzA+lZBci3emrWKsrcZq7KgsU2Ml4jV4UHVdPepAK
         r03UKstEVtti48ZhC1I7kBseqUnNFFl8XmN3b03dfEH3gqPM+kv7is/N8OVmxNk0KuL+
         qA7Sa4Sx7PMIpN0UUaUiOz6/DJ4NdA+vfykFgzPmfw566BixZ6wcP79/oaq9su9C2ktB
         P0pQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvcE1qadg+qJ9X7Nto77mEOppkVisQ2ARFVu8QjBcoAO9PPuwOBDekolgOvuoHyrZM3hRc2p4weuF/tUpwn9rCmxe9tZJplpJNGjxe
X-Gm-Message-State: AOJu0Yyykr9Jk6scQ9AHw8Fp+1gdMBA81O5jC5+SIiAhyHbWxEuXw7o2
	CriXMRUHeByp/HBiB+uL4WCrMhNG9n6nrGxqfaSYzgU6uB4JfDOy7Ck9uqaOs6BXHSUKC24x/g4
	=
X-Google-Smtp-Source: AGHT+IE37flgVjYV/E0D/HhfYmogBng8JhYD59jh3Z5166MCGSWzG6o82LWlrcK8a6VnJM647AzbpA==
X-Received: by 2002:a05:622a:6107:b0:437:ba0e:68f5 with SMTP id hg7-20020a05622a610700b00437ba0e68f5mr10568217qtb.25.1714400813652;
        Mon, 29 Apr 2024 07:26:53 -0700 (PDT)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id kg25-20020a05622a761900b00436eacea78fsm10417169qtb.65.2024.04.29.07.26.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 07:26:53 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-436ed871225so511281cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 07:26:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUaNRdl3F+Syt9c3n2smEO1Wo0sJgDkCZGPdrLY+6YSZlXdLYWwuCzNmG1obxCEqB+/qre8R3kdUtK3b23n2N11HiE6AehDyUNwghUi
X-Received: by 2002:a05:622a:14d:b0:439:a979:ccb2 with SMTP id
 v13-20020a05622a014d00b00439a979ccb2mr546226qtw.16.1714400812823; Mon, 29 Apr
 2024 07:26:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426235857.3870424-1-dianders@chromium.org>
 <20240426165839.v2.4.Ie94246c30fe95101e0e26dd5f96e976dbeb8f242@changeid> <2af446d3-7834-4a6b-897b-b14c6bccff65@linaro.org>
In-Reply-To: <2af446d3-7834-4a6b-897b-b14c6bccff65@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 29 Apr 2024 07:26:41 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V=EvEGp4tGDd-UQ1R=XkAwDn04ftd8oWU=UE=3Gi7SLQ@mail.gmail.com>
Message-ID: <CAD=FV=V=EvEGp4tGDd-UQ1R=XkAwDn04ftd8oWU=UE=3Gi7SLQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] drm/mipi-dsi: Introduce mipi_dsi_*_write_seq_multi()
To: neil.armstrong@linaro.org
Cc: dri-devel@lists.freedesktop.org, Linus Walleij <linus.walleij@linaro.org>, 
	lvzhaoxiong@huaqin.corp-partner.google.com, 
	Jani Nikula <jani.nikula@linux.intel.com>, Hsin-Yi Wang <hsinyi@google.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, Joel Selvaraj <jo@jsfamily.in>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 29, 2024 at 2:38=E2=80=AFAM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> > +/**
> > + * struct mipi_dsi_multi_context - Context to call multiple MIPI DSI f=
uncs in a row
> > + * @dsi: Pointer to the MIPI DSI device
> > + * @accum_err: Storage for the accumulated error over the multiple cal=
ls. Init
> > + *   to 0. If a function encounters an error then the error code will =
be
> > + *   stored here. If you call a function and this points to a non-zero
> > + *   value then the function will be a noop. This allows calling a fun=
ction
> > + *   many times in a row and just checking the error at the end to see=
 if
> > + *   any of them failed.
> > + */
> > +
> > +struct mipi_dsi_multi_context {
> > +     struct mipi_dsi_device *dsi;
> > +     int accum_err;
> > +};
>
> I like the design, but having a context struct seems over-engineered whil=
e we could pass
> a single int over without encapsulating it with mipi_dsi_multi_context.
>
> void mipi_dsi_dcs_write_buffer_multi(struct mipi_dsi_multi_context *ctx,
>                                      const void *data, size_t len);
> vs
> void mipi_dsi_dcs_write_buffer_multi(struct mipi_dsi_device *dsi, int *ac=
cum_err,
>                                      const void *data, size_t len);
>
> is the same, and it avoids having to declare a mipi_dsi_multi_context and=
 set ctx->dsi,
> and I'll find it much easier to migrate, just add a &ret and make sure re=
t is initialized to 0.

Yeah, I had the same reaction when Jani suggested the context style
[1] and I actually coded it up exactly as you suggest above. I then
changed my mind and went with the context. My motivation was that when
I tested it I found that using the context produced smaller code.
Specifically, from the description of this patch we see we end up
with:

Total: Before=3D10651, After=3D9663, chg -9.28%

..when I didn't have the context and I had the accum_err then instead
of getting ~9% smaller I believe it actually got ~0.5% bigger. This
makes some sense as the caller has to pass 4 parameters to each call
instead of 3.

It's not a giant size difference but it was at least some motivation
that helped push me in this direction. I'd also say that when I looked
at the code in the end the style grew on me. It's really not too
terrible to have one line in your functions that looks like:

struct mipi_dsi_multi_context ctx =3D { .dsi =3D boe->dsi };

..and if that becomes the canonical way to do it then it's really
hard to accidentally forget to initialize the error value. With the
other API it's _very_ easy to forget to initialize the error value and
the compiler won't yell at you. It also makes it very obvious to the
caller that this function is doing something a little different than
most Linux APIs with that error return.

So I guess I'd say that I ended up being pretty happy with the
"context" even if it does feel a little over engineered and I'd argue
to keep it that way. That being said, if you feel strongly about it
then we can perhaps get others to chime in to see which style they
prefer? Let me know what you think.


[1] https://lore.kernel.org/r/8734r85tcf.fsf@intel.com


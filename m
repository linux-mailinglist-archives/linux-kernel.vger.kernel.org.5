Return-Path: <linux-kernel+bounces-162427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 954E18B5B0A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20B33283864
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E60679B7E;
	Mon, 29 Apr 2024 14:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SCdtiYsy"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBED1768EA
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 14:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714400011; cv=none; b=pxsFI4l/GjVhr77dMqInnuEbWXnMfeTAMFPD7QNumOntMWz9GXFb64UNp8p0oMHhxHLMQ1MC6hMirsCmIL5baH1ebyhaZP8nqUcMglorFvA+AnOm3Z6YprEFs8Ys1opamIbSx15E/y+3OFQEFGK2jcWPSk0V36ItJRvgCJHSTTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714400011; c=relaxed/simple;
	bh=C9/BTBAjs4wYnosLHUhTNU6Oc1nB30MxAvT+9gJ7Mng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=msnl9jCt2RG+AgdE5DkDb+Vbmmtz8InQHtgYPU4wO/Ljzhj4TDavUNObOO34YvyhKkanL1oDgrFm4PAxclo+HfN2CTESpRjftdm/rBaVuMjqbWx2WYAUrQLIxIZlaOes/quAAKkgiaYPa+6BCWiwBk3wwDqBKDFhHtVl1BgrS/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SCdtiYsy; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4365c1451d4so30900901cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 07:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714400007; x=1715004807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXaUKKpFujkWymSRJKlgkreifFUpxgXsPFgEoLgrUDA=;
        b=SCdtiYsyEtrTuU+044rUF97R64m4yTpFi+Eu4VXN2JWrb+QDpb44yTXJ6gdVR8ci4G
         MbP4giwWVgzUAzKBl44DMyE+Ohj5M0CgaiASY9LnxupWjIEaG22RVqlv5/L0GW5BvcSA
         VN46Zuw4Tw+DZ/qtlq7Di2mtU75Hu1G/iYZ9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714400007; x=1715004807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IXaUKKpFujkWymSRJKlgkreifFUpxgXsPFgEoLgrUDA=;
        b=XsKLwxwDMiH1FMN2suJcQNUuJzzhqhR0OyBNgogjw8Qd25+mimJnmcKmN76pnIP3ES
         +XkUCn/BfUSk9GTTtd4z8NZGOwFx9noXJtPewwIUy0CoEmLKYjFDD3Cq7PtojTfC9M+P
         lRdGl09n6Gs8WNuKWo0aCMPJnDy3ozI1F2IAjlmOORMLvtY53fJpNTFij+f8/Io9BOa0
         JSvemEUiqWRUWQK9RVpdN8Tz/grDWxNhgYV6VhoqHZIzR0VyyWI2WDVLDR8REyOQpSIC
         JzSRAdkPHZluTHgdftn3Lv9fWICeSYneACvwTQmDnspwyBpEKHBTEyVVUEU2epVoG0eS
         CKhg==
X-Forwarded-Encrypted: i=1; AJvYcCU05+scSNLvk7SXD4Wp6q75rjcMyoURpBpU+Iyx5MLCk1IWLzcyxNIwqKIkZFeXyX61cTFr6WvDGwIIUwQMXAes0wGqRpitLOVLn7QE
X-Gm-Message-State: AOJu0YyAKPiaT013zWJFuNzXwdvL3NBJvvIRXJnb6sCbwmpn0qeT0LeY
	2co0PSPm5c3NGxuw3cIR5NcxXhFACwLlCjmzd/TxfwDFdgZq3mOR9WzpCbEd9KEENCroRnV5mYk
	=
X-Google-Smtp-Source: AGHT+IFvps1JjXT1PkgbZt/upN2FNAhZTQw4aBw9IBKqW8DcP1Lm09jUYMMZ9wSFNkg8pknSCz+fvw==
X-Received: by 2002:a05:622a:2a16:b0:434:7c49:a94e with SMTP id hc22-20020a05622a2a1600b004347c49a94emr13941430qtb.27.1714400007539;
        Mon, 29 Apr 2024 07:13:27 -0700 (PDT)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com. [209.85.160.172])
        by smtp.gmail.com with ESMTPSA id d12-20020ac851cc000000b00438527a4eb5sm9145142qtn.10.2024.04.29.07.13.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 07:13:26 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-439b1c72676so699111cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 07:13:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXD0YhucKHTEkswrVL999vu+p7SSjYIOF3LeAq0HMXpms6HwEeLlJ5nV3R4KvHOI/21b2dJBpKqt3lake9GBFUV5gwrjwO8I4ZdfSKB
X-Received: by 2002:ac8:7d49:0:b0:43a:c278:83f9 with SMTP id
 h9-20020ac87d49000000b0043ac27883f9mr320794qtb.3.1714400005486; Mon, 29 Apr
 2024 07:13:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426235857.3870424-1-dianders@chromium.org>
 <20240426165839.v2.4.Ie94246c30fe95101e0e26dd5f96e976dbeb8f242@changeid> <20240427063250.GB1137299@ravnborg.org>
In-Reply-To: <20240427063250.GB1137299@ravnborg.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 29 Apr 2024 07:13:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UN5tWqQvnLRGtk+EVqjEqO6vqtEfaYONkCsze2+539Xw@mail.gmail.com>
Message-ID: <CAD=FV=UN5tWqQvnLRGtk+EVqjEqO6vqtEfaYONkCsze2+539Xw@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] drm/mipi-dsi: Introduce mipi_dsi_*_write_seq_multi()
To: Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, Linus Walleij <linus.walleij@linaro.org>, 
	lvzhaoxiong@huaqin.corp-partner.google.com, 
	Jani Nikula <jani.nikula@linux.intel.com>, Hsin-Yi Wang <hsinyi@google.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Joel Selvaraj <jo@jsfamily.in>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 26, 2024 at 11:33=E2=80=AFPM Sam Ravnborg <sam@ravnborg.org> wr=
ote:
>
> > ---
> > Right now this patch introduces two new functions in
> > drm_mipi_dsi.c. Alternatively we could have changed the prototype of
> > the "chatty" functions and made the deprecated macros adapt to the new
> > prototype. While this sounds nice, it bloated callers of the
> > deprecated functioin a bit because it caused the compiler to emit less
> > optimal code. It doesn't seem terrible to add two more functions, so I
> > went that way.
> The concern here is when it will be cleaned up. As a minimum please
> consider adding an item to todo.rst that details what should be done
> to get rid of the now obsolete chatty functions so someone can pick it
> up.

Sure, I can add something to do TODO. Do folks agree that's the
preferred way to do things? A few thoughts I had:

1. In theory it could be useful to keep _both_ the "chatty" and
"multi" variants of the functions. In at least a few places the
"multi" variant was awkward. The resulting auo_kd101n80_45na_init()
[1] looked awkward. If I was writing just this function I would have
chosen an API more like the "chatty" one, but since I was trying to
make all the init functions similar I kept them all using the "multi"
API. Does it make sense to keep both long term?

[1] https://lore.kernel.org/all/20240426165839.v2.7.Ib5030ab5cd41b4e08b1958=
bd7e51571725723008@changeid/

2. Going completely the opposite direction, we could also not bother
saving as much space today and _force_ everyone to move to the new
"multi" API to get the full space savings.


So I guess three options: a) leave my patches the way they are and add
a TODO, b) Keep the "chatty" variants long term and remove my
"after-the-cut", or c) Don't get as much space savings today but don't
introduce a new exported function. Opinions?


> > @@ -792,6 +792,34 @@ int mipi_dsi_generic_write_chatty(struct mipi_dsi_=
device *dsi,
> >  }
> >  EXPORT_SYMBOL(mipi_dsi_generic_write_chatty);
> >
> > +/**
> > + * mipi_dsi_generic_write_multi() - mipi_dsi_generic_write_chatty() w/=
 accum_err
> > + * @ctx: Context for multiple DSI transactions
> > + * @payload: buffer containing the payload
> > + * @size: size of payload buffer
> > + *
> > + * Like mipi_dsi_generic_write_chatty() but deals with errors in a way=
 that
> > + * makes it convenient to make several calls in a row.
> > + */
> > +void mipi_dsi_generic_write_multi(struct mipi_dsi_multi_context *ctx,
> > +                               const void *payload, size_t size)
> > +{
> > +     struct mipi_dsi_device *dsi =3D ctx->dsi;
> > +     struct device *dev =3D &dsi->dev;
> > +     ssize_t ret;
> > +
> > +     if (ctx->accum_err)
> > +             return;
> > +
> > +     ret =3D mipi_dsi_generic_write(dsi, payload, size);
> > +     if (ret < 0) {
> > +             ctx->accum_err =3D ret;
> > +             dev_err_ratelimited(dev, "sending generic data %*ph faile=
d: %d\n",
> > +                                 (int)size, payload, ctx->accum_err);
> > +     }
> I see no point in using ratelimited and then change it in the next
> patch.

Sure, I'll re-order patches.


> > @@ -197,6 +197,22 @@ struct mipi_dsi_device {
> >       struct drm_dsc_config *dsc;
> >  };
> >
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
> Inline comments is - I think - preferred.

Sure, I'll update in the next version.


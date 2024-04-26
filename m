Return-Path: <linux-kernel+bounces-160321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7F38B3BF0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0260928671B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B3E157460;
	Fri, 26 Apr 2024 15:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZBPzz7X6"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4FD14D447
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714146159; cv=none; b=sROL4O9PuwPxvoW4v6b4J22TzBxVDRaSDJmzJ/4fZY+hmKQN6C+FycBCmQiJi3xsmoMNQanhqDBKBNsDphpXUdI+bctSjZMeSdX7vcofAivfBZqh+o05g93G1ZaJcIuqjR0NZgyMu0zMlRKe2WQ/QUUa5NvUy/ywgfGZWQXWr8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714146159; c=relaxed/simple;
	bh=jDAoK3tQd/jCsQTNWO5hZlLZh39SD7GChIw21CQaSsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WgRK3h0zWUF0KtIvhXZ9u4WRN1BhhcqxxiY9g2ZjXVvQKnJG+tqziYm44k2DRIcboG8usfv/pdvfTtMrX+z6Ll9WBmGaZ7Ob6suapMLddXhswBpS42ckODEvPax/tZE0Jte/nMYNbQa/WFDBlst6mHqMXcJsAraqyORhFOE7Fso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZBPzz7X6; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-de54c2a4145so2673322276.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 08:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714146157; x=1714750957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1r/qRH9kPvAGgkQEMeuJ0NKJrHsmyltgKmm0PUhotBc=;
        b=ZBPzz7X6nBg0db1tlindiw+miYKLn27adT9NhYVuOremCzfGZVLr9ZeAdEo3ux/QRk
         c4/hPZBJb+y+xt2tT0Eko4AAGxbl0itQjDNnzYNEgcju1mN+yj1uH5EbtpUxMUsZK2fO
         n0mZJFpbxhdF9KnoyEeHOYZF6u5OftPNihNnd0HJCHISSUKD3NNpGBNmRf1ge4uUS+b4
         9NNNzFmT98K/IJEUQTxTcDrSRlj1wOPBaWS+Tj7v68vN5YdxcfBv/vn962eNepqw8MZc
         V7ecq34JF+4nNJ+w8rJVYlCo2IwMiCQIaMyd7VoP1Zx14Liiyzz0gJDtw12uOMF8TAz2
         cGRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714146157; x=1714750957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1r/qRH9kPvAGgkQEMeuJ0NKJrHsmyltgKmm0PUhotBc=;
        b=lKZ4Cr9zplckHKpe3TmbiH8//o+wJ6Qrr5k2P1ademWPYmwaHB6F0OKBZIMZjhrg7r
         uZi3e5HzNDY2yp86fXVzVRCDF+mPNKMmNtG/xxQNeVAA3TQdPtHW3Ieg5CeOAnmmTSyA
         X3gp2KQJJmmUufRjgaHsmdMvXhWwEGMLZKCP64hnOAyN6qxGP3cBuHgqRdHATZN7RSbd
         MA5GlzVLcahMH+tzVpyDYzplhrA9BAvyNjYJasWKPjnYCO2pik/v0nmhkQztO1AKWMMI
         UwYQPz4yzi2gbYznn4Fy28aF/7/4FCqLQTaTp0mLxnhiwL3C1sKvVOMHILgxQTfApmyu
         nhwA==
X-Forwarded-Encrypted: i=1; AJvYcCV5OqdorE/1tj///W1jTniRzSU0FqnxMqEujtWIOpHkxX5Ybnz/0CWQX8W5G0nVQK8Ud1y1+cAglcmS6PM5u/qkeZAqYXaMwYTsxoEz
X-Gm-Message-State: AOJu0YyuKTUgeYNzP8sbedhxezbBphOUaIHKixHjJBGpI0QjAXG1hKVc
	M6toooLGVD2cm05MKx4IcdJ/qm86tHewAWyTBMcNoBAuUkkp5h81QBz6Yy2svRqnZFdN4y99Jq0
	HBotlkn2t19L00fZkgqy2Ao1uxa2z2oD4nvo4xQ==
X-Google-Smtp-Source: AGHT+IHXqiLVi5dGGByxbmqNOLy8Bm6k1zPc3+mbxHwesdXyWEV5jekoYy/P2rzj/Dz7Gdb0KBXe5GlRkEgu/X9acRQ=
X-Received: by 2002:a05:6902:1b84:b0:dd1:2f58:6a2e with SMTP id
 ei4-20020a0569021b8400b00dd12f586a2emr3667726ybb.9.1714146156805; Fri, 26 Apr
 2024 08:42:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424172017.1.Id15fae80582bc74a0d4f1338987fa375738f45b9@changeid>
 <87pludq2g0.fsf@intel.com> <CAD=FV=W+Pcr+voBkcfeE_UC+ukN_hLXgoqMk0watROWRXe_2dg@mail.gmail.com>
 <beqsovvdkvn63prt3c6b3epb6tachff35vpaf62dfkwof7kwht@u3p7bkv7owro> <CAD=FV=WxYoFYefdZ4PQ=QF5aHpeWoC3qM1b5d2vf_qBH90ZMQw@mail.gmail.com>
In-Reply-To: <CAD=FV=WxYoFYefdZ4PQ=QF5aHpeWoC3qM1b5d2vf_qBH90ZMQw@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 26 Apr 2024 18:42:25 +0300
Message-ID: <CAA8EJpodW+VjUzBh1VLC2OeUaMhoX7FgNrsNStq5rPbOnyp95g@mail.gmail.com>
Subject: Re: [PATCH] drm/mipi-dsi: Reduce driver bloat of mipi_dsi_*_write_seq()
To: Doug Anderson <dianders@chromium.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, dri-devel@lists.freedesktop.org, 
	Javier Martinez Canillas <javierm@redhat.com>, Neil Armstrong <neil.armstrong@linaro.org>, linus.walleij@linaro.org, 
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>, 
	lvzhaoxiong@huaqin.corp-partner.google.com, Hsin-Yi Wang <hsinyi@google.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 26 Apr 2024 at 18:41, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Apr 25, 2024 at 8:03=E2=80=AFPM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Thu, Apr 25, 2024 at 10:04:49AM -0700, Doug Anderson wrote:
> > > Hi,
> > >
> > > On Thu, Apr 25, 2024 at 1:19=E2=80=AFAM Jani Nikula <jani.nikula@linu=
x.intel.com> wrote:
> > > >
> > > > > @@ -279,6 +281,8 @@ enum mipi_dsi_dcs_tear_mode {
> > > > >
> > > > >  ssize_t mipi_dsi_dcs_write_buffer(struct mipi_dsi_device *dsi,
> > > > >                                 const void *data, size_t len);
> > > > > +ssize_t mipi_dsi_dcs_write_buffer_chatty(struct mipi_dsi_device =
*dsi,
> > > > > +                                      const void *data, size_t l=
en);
> > > > >  ssize_t mipi_dsi_dcs_write(struct mipi_dsi_device *dsi, u8 cmd,
> > > > >                          const void *data, size_t len);
> > > > >  ssize_t mipi_dsi_dcs_read(struct mipi_dsi_device *dsi, u8 cmd, v=
oid *data,
> > > > > @@ -317,14 +321,10 @@ int mipi_dsi_dcs_get_display_brightness_lar=
ge(struct mipi_dsi_device *dsi,
> > > > >  #define mipi_dsi_generic_write_seq(dsi, seq...)                 =
               \
> > > > >       do {                                                       =
            \
> > > > >               static const u8 d[] =3D { seq };                   =
              \
> > > > > -             struct device *dev =3D &dsi->dev;                  =
              \
> > > > >               int ret;                                           =
            \
> > > > > -             ret =3D mipi_dsi_generic_write(dsi, d, ARRAY_SIZE(d=
));           \
> > > > > -             if (ret < 0) {                                     =
            \
> > > > > -                     dev_err_ratelimited(dev, "transmit data fai=
led: %d\n", \
> > > > > -                                         ret);                  =
            \
> > > > > +             ret =3D mipi_dsi_generic_write_chatty(dsi, d, ARRAY=
_SIZE(d));    \
> > > > > +             if (ret < 0)                                       =
            \
> > > > >                       return ret;                                =
            \
> > > > > -             }                                                  =
            \
> > > > >       } while (0)
> >
> >
> > Reading the thread makes me wonder whether we should be going into
> > slightly other direction:
> >
> > Add __must_check() to mipi_dsi_ writing functions,
> >
> > #define mipi_dsi_dcs_whatever_write(dsi, cmd, seq...)   \
> >         ({                                              \
> >                 static const u8 d[] =3D { cmd, seq };     \
> >                 mipi_dsi_dcs_write_buffer(dsi, d, ARRAY_SIZE(d));    \
> >         })
> >
> > Then in panel drivers we actually have to explicitly handle the return
> > code (either by dropping to the error label or by just returning an
> > error).
>
> Given the sheer number of init commands needed by some panels (see
> j606f_boe_init_sequence() for instance) I'm still convinced that we
> want something that allows people to write their init code in a way
> that's not quite so verbose. It sounds as if Jani is OK w/ the
> proposal of using the "accumulated return value" (proposal #2 I had).
> I'm hoping you're OK w/ that too...

Yes, I'm fine with that.

--=20
With best wishes
Dmitry


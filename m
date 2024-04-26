Return-Path: <linux-kernel+bounces-160308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 129A68B3BB9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F203AB2501B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D08B14AD3D;
	Fri, 26 Apr 2024 15:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ee0X/xRL"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001EB14A60A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714145751; cv=none; b=CWUDGWVOkgY8A74VvGFHgPr8LDEmsY+oF1NO9G/48xoVVi1y0zaqB1oNBocKWc66rtPaVuopw2/VhayDmpP5cumUWz+Lcb9qB+l0yWzY+XsXr8kRAVc9lrrKb86EsN/h3XlUoC900s3S3c6khBt3dDWCuBlhq38Q5UT45cAenoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714145751; c=relaxed/simple;
	bh=7DxziED0ZQhl0kzXbnS5g+C5iVifnnI6Wue7exIjip4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IkNjZI6LNDUe6ixupOpuCdPcsbkDntkE/ORtPPtGASgGBw8in6LmY1NXA2NfTbPTmuFpcvZNaemNGElj3RQwN3Yro/MwyQDnIXmyNyv0NaxP75YJxhBNDls20ASVSdl+5OtsxFQlFxXRFXYRzMStgmjPsQpA4nngOB3gicbq+Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ee0X/xRL; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-439884be4efso13368991cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 08:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714145744; x=1714750544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y3tPCtKmB8e7QI9Lq/uJ6hWU4RympZM66D1lrj8aR8o=;
        b=ee0X/xRLHvhcmuO7v5BobSbzJb7MJBMg1XRIzmLQ2+ud/QEqD+O3Bn+gzA1bynb2hs
         5AOIbW4lrZh4yJmFiaY5Hqxr3OgyXBmQlF9/uW5vYTyT3vlrFZXISh8Gij0SLVZ3mbPu
         QxQKjf4AFsNsJBq6I4/IC4DVCzKXWtSg6bGj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714145744; x=1714750544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y3tPCtKmB8e7QI9Lq/uJ6hWU4RympZM66D1lrj8aR8o=;
        b=ZsK8kFQ2Kqze6Hf7XyOY8GK/ALkMGqMpnnHHmYbnjoGMpUZf3TeXsPnjCILMhsQqFs
         vFVx09gaeYgyLeUoP4GYNlNeKZr4i5gQSJz2RX4DDGsO2qTvTEYSAUz01qXUma/mG8vc
         498dtqfjBkgJ48xB97HkVHyz953jw9gxYYn+9sJjWZe1qKCbRghWPNo8EoBzuYi3IoKY
         Dyw2dbD4tVN/AY0UQ4UIWRrs8wfLB5NnK1vSoAOLWh+PZjBrPBek2CkKl/wN+PHv5kzc
         mc5nrEp2D6Mm7EpIX3KZCqnprXrOlYpVtYaqakIl/twETX5DrrI91DOQn0spLDPpux8+
         LwTw==
X-Forwarded-Encrypted: i=1; AJvYcCXylyFruDW+2gjTszCbZ6bU+H+atKdQfqh1BjPvKa/xKMBRcbabUBXuKQjFfYj9UHDXxtyX6iJztaGQ9hMQFwDhLEofX9DZz/kMx97c
X-Gm-Message-State: AOJu0YyCPYAhKzWRHBVSySMvaC4Vj5Vh0saHklfIBYLbLcqI2DjPDvml
	Dh137FmTGk0DhRHZ0qM1Y4nXVCDpwf6jw//r/i0sdfeiqF3LYgJXQ2mvDF8COi7Uu23f1ZA4TxA
	=
X-Google-Smtp-Source: AGHT+IHLmb4uI/lkW6z4EZzUcSly7hblCWu2Uefyy2IXJzEzrn9unFD8V57AiHIG9kvRnnz8HSTRpA==
X-Received: by 2002:a05:622a:30b:b0:437:bec6:733c with SMTP id q11-20020a05622a030b00b00437bec6733cmr3509858qtw.33.1714145743685;
        Fri, 26 Apr 2024 08:35:43 -0700 (PDT)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com. [209.85.160.180])
        by smtp.gmail.com with ESMTPSA id he28-20020a05622a601c00b00437543e5307sm8020763qtb.40.2024.04.26.08.35.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 08:35:43 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-439b1c72676so451851cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 08:35:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV4A0AokU0WbXgIHmAiQKW8YpqQtb7nDsd/SAMfIG5OJ2oG9fTiMnzxQmc36ABiEYymh/cf2pmsXo5r1CtoQabuN3Cnz6/S7DqHZ7jr
X-Received: by 2002:ac8:6895:0:b0:437:7a02:d66c with SMTP id
 m21-20020ac86895000000b004377a02d66cmr225822qtq.25.1714145739600; Fri, 26 Apr
 2024 08:35:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424172017.1.Id15fae80582bc74a0d4f1338987fa375738f45b9@changeid>
 <87pludq2g0.fsf@intel.com> <CAD=FV=W+Pcr+voBkcfeE_UC+ukN_hLXgoqMk0watROWRXe_2dg@mail.gmail.com>
 <beqsovvdkvn63prt3c6b3epb6tachff35vpaf62dfkwof7kwht@u3p7bkv7owro>
In-Reply-To: <beqsovvdkvn63prt3c6b3epb6tachff35vpaf62dfkwof7kwht@u3p7bkv7owro>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 26 Apr 2024 08:35:24 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WxYoFYefdZ4PQ=QF5aHpeWoC3qM1b5d2vf_qBH90ZMQw@mail.gmail.com>
Message-ID: <CAD=FV=WxYoFYefdZ4PQ=QF5aHpeWoC3qM1b5d2vf_qBH90ZMQw@mail.gmail.com>
Subject: Re: [PATCH] drm/mipi-dsi: Reduce driver bloat of mipi_dsi_*_write_seq()
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, dri-devel@lists.freedesktop.org, 
	Javier Martinez Canillas <javierm@redhat.com>, Neil Armstrong <neil.armstrong@linaro.org>, linus.walleij@linaro.org, 
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>, 
	lvzhaoxiong@huaqin.corp-partner.google.com, Hsin-Yi Wang <hsinyi@google.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 25, 2024 at 8:03=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Thu, Apr 25, 2024 at 10:04:49AM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Thu, Apr 25, 2024 at 1:19=E2=80=AFAM Jani Nikula <jani.nikula@linux.=
intel.com> wrote:
> > >
> > > > @@ -279,6 +281,8 @@ enum mipi_dsi_dcs_tear_mode {
> > > >
> > > >  ssize_t mipi_dsi_dcs_write_buffer(struct mipi_dsi_device *dsi,
> > > >                                 const void *data, size_t len);
> > > > +ssize_t mipi_dsi_dcs_write_buffer_chatty(struct mipi_dsi_device *d=
si,
> > > > +                                      const void *data, size_t len=
);
> > > >  ssize_t mipi_dsi_dcs_write(struct mipi_dsi_device *dsi, u8 cmd,
> > > >                          const void *data, size_t len);
> > > >  ssize_t mipi_dsi_dcs_read(struct mipi_dsi_device *dsi, u8 cmd, voi=
d *data,
> > > > @@ -317,14 +321,10 @@ int mipi_dsi_dcs_get_display_brightness_large=
(struct mipi_dsi_device *dsi,
> > > >  #define mipi_dsi_generic_write_seq(dsi, seq...)                   =
             \
> > > >       do {                                                         =
          \
> > > >               static const u8 d[] =3D { seq };                     =
            \
> > > > -             struct device *dev =3D &dsi->dev;                    =
            \
> > > >               int ret;                                             =
          \
> > > > -             ret =3D mipi_dsi_generic_write(dsi, d, ARRAY_SIZE(d))=
;           \
> > > > -             if (ret < 0) {                                       =
          \
> > > > -                     dev_err_ratelimited(dev, "transmit data faile=
d: %d\n", \
> > > > -                                         ret);                    =
          \
> > > > +             ret =3D mipi_dsi_generic_write_chatty(dsi, d, ARRAY_S=
IZE(d));    \
> > > > +             if (ret < 0)                                         =
          \
> > > >                       return ret;                                  =
          \
> > > > -             }                                                    =
          \
> > > >       } while (0)
>
>
> Reading the thread makes me wonder whether we should be going into
> slightly other direction:
>
> Add __must_check() to mipi_dsi_ writing functions,
>
> #define mipi_dsi_dcs_whatever_write(dsi, cmd, seq...)   \
>         ({                                              \
>                 static const u8 d[] =3D { cmd, seq };     \
>                 mipi_dsi_dcs_write_buffer(dsi, d, ARRAY_SIZE(d));    \
>         })
>
> Then in panel drivers we actually have to explicitly handle the return
> code (either by dropping to the error label or by just returning an
> error).

Given the sheer number of init commands needed by some panels (see
j606f_boe_init_sequence() for instance) I'm still convinced that we
want something that allows people to write their init code in a way
that's not quite so verbose. It sounds as if Jani is OK w/ the
proposal of using the "accumulated return value" (proposal #2 I had).
I'm hoping you're OK w/ that too...

-Doug


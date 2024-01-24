Return-Path: <linux-kernel+bounces-37589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7CA83B23D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9955B2E69A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CCB1339B9;
	Wed, 24 Jan 2024 19:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XtXzOK/v"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6951339AA
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 19:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706123932; cv=none; b=DVa1/QzlkY4+0ExsshfjXpgXvr4mWtGKcYdKQydaubeSdFuqGJRF025oTDg1CtjNVI/FlLAD71jicP96XYfKMnIEVOxTm1gwMnbFWNbS6Sr/Tl9j5ZD8jW+XHZRD9VGnsuZydsErIwthSKF2zstvHvF2/BsfZhJyYxAxqUoNeQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706123932; c=relaxed/simple;
	bh=Kkxze+OHG8vVSjBJo2EbnIrie86i6OnbPjB0P6moSbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oplxpm6wNI5Z1TVMtAX/CqlaDbeC03wLPXL5ExCbakCzL0Qz2uo8B5/NKScs/xOjVFBc4fijRCNmMLnSc+kcnDdrsA1+BY4morJerxVoUmNdvVFA5+PrJZVnixfuOZmlK1Cn2GDzHaQD8zdlW63gqO1lCAu+baIKf/joYZXtAHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XtXzOK/v; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc223463ee4so5261467276.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 11:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706123929; x=1706728729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZihvGpOcawyRovSQi/D7nIlqL4G312PpvkN2EuN+3I=;
        b=XtXzOK/v9jDb3PlsceMzqI1tK7avYg7ojmf7dSutSOZvCXg8vYpdj5i3rv2RVXRgJ5
         kbr4HfrKkO5obfe0pxOX4AeJ9KOxqJln95fkEB2pKcImuA3DW5XMugKlVFSv29nEvaup
         vlI4U4Ya8KA/wFPXs/+iHhw7Zzy6GlTu27V3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706123929; x=1706728729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kZihvGpOcawyRovSQi/D7nIlqL4G312PpvkN2EuN+3I=;
        b=OKTUv1OY1NQ0eWMWv7kPCy9binFzwRe9RoeripffZlt0ceQNDFKRZX4AzXbybozcpZ
         7gTpm60zkUJeCqpSWhl5513qx5UtUVFSmkW/nCWAalu7SqNcJynv/+12V3CJKg38otEr
         sVGHt/4zVFCBiNn1pjvMwK4CtPNjRWX2RiluAB/q693tlXxIbMdncgM4awmr5dqMV/lG
         bcatrgEA8hBhjYBKfyqysCy4B648nI7TrboOMvqOHycOZ8mxr8cF5SYBhYWusBfBzsJi
         wrq5kXZQAFMgW8CFvO5PHZw+WQlDtevPrbmYs5P0sLGsUHkT6chnfYQv71bqRnyQEcjR
         DV7w==
X-Gm-Message-State: AOJu0YyuMYTm6hSx4Rvew0HV+PRDdShXD21SQXPxXCaBYEKopMpBFoup
	46f90H646igBjB7j7kKV4x9UUvITsP41gnzWTYwSo34PWKX/9MhUO+OUAdSRZ3/4cnkTkc+p3W7
	KdP4dhB8HwZGmmjP/W1nW8223p+UinPSkr86w
X-Google-Smtp-Source: AGHT+IEibMEUVjPbM4b9HrbvGiFjg4c/oD0Brje47RUensOcAJVBQPFnVJT823NrigmWf4R2BOq1SzWgGilLglweUkU=
X-Received: by 2002:a05:6902:48:b0:dc2:404c:7e93 with SMTP id
 m8-20020a056902004800b00dc2404c7e93mr961119ybh.25.1706123929099; Wed, 24 Jan
 2024 11:18:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123223039.1471557-1-abhishekpandit@google.com>
 <20240123143026.v1.3.Idf7d373c3cbb54058403cb951d644f1f09973d15@changeid> <CACeCKafTBwSgRXLFA3HC7cBe8hD=PSgSmR=TWy1oF3Rkn+hK4g@mail.gmail.com>
In-Reply-To: <CACeCKafTBwSgRXLFA3HC7cBe8hD=PSgSmR=TWy1oF3Rkn+hK4g@mail.gmail.com>
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date: Wed, 24 Jan 2024 11:18:37 -0800
Message-ID: <CANFp7mUFvRnb1BF=vzNE+BxMcjZi_o0wwJVw=Ty+zEG+JTzA1w@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] usb: typec: ucsi: Get PD revision for partner
To: Prashant Malani <pmalani@chromium.org>
Cc: Abhishek Pandit-Subedi <abhishekpandit@google.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-usb@vger.kernel.org, 
	jthies@google.com, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bjorn Andersson <andersson@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hdegoede@redhat.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Saranya Gopal <saranya.gopal@intel.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 10:49=E2=80=AFAM Prashant Malani <pmalani@chromium.=
org> wrote:
>
> Hi Abhishek,
>
> On Tue, Jan 23, 2024 at 2:30=E2=80=AFPM Abhishek Pandit-Subedi
> <abhishekpandit@google.com> wrote:
> >
> > From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> >
> > PD major revision for the port partner is described in
> > GET_CONNECTOR_CAPABILITY and is only valid on UCSI 2.0 and newer. Updat=
e
> > the pd_revision on the partner if the UCSI version is 2.0 or newer.
> >
> > Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > ---
> > $ cat /sys/class/typec/port2-partner/usb_power_delivery_revision
> > 3.0
> >
> >  drivers/usb/typec/ucsi/ucsi.c | 25 +++++++++++++++++++++++++
> >  drivers/usb/typec/ucsi/ucsi.h |  3 +++
> >  2 files changed, 28 insertions(+)
> >
> > diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucs=
i.c
> > index 4edf785d203b..8e0a512853ba 100644
> > --- a/drivers/usb/typec/ucsi/ucsi.c
> > +++ b/drivers/usb/typec/ucsi/ucsi.c
> > @@ -782,6 +782,8 @@ static int ucsi_register_partner(struct ucsi_connec=
tor *con)
> >         }
> >
> >         desc.usb_pd =3D pwr_opmode =3D=3D UCSI_CONSTAT_PWR_OPMODE_PD;
> > +       desc.pd_revision =3D
> > +               UCSI_CONCAP_FLAG_PARTNER_PD_MAJOR_REV_AS_BCD(con->cap.f=
lags);
> >
> >         partner =3D typec_register_partner(con->port, &desc);
> >         if (IS_ERR(partner)) {
> > @@ -856,6 +858,28 @@ static void ucsi_partner_change(struct ucsi_connec=
tor *con)
> >                         con->num, u_role);
> >  }
> >
> > +static int ucsi_check_connector_capability(struct ucsi_connector *con)
> > +{
> > +       u64 command;
> > +       int ret;
> > +
> > +       if (!con->partner && !IS_MIN_VERSION_2_0(con->ucsi))
>
> (Mentioned side-band but reproducing here for consistency)
> This macro is unnecessary. It's just doing a comparison, which can be inl=
ined
> without any perceptible change in readability (actually, I'd argue adding=
 the !
> to an english idiom makes things *less* readable):

I prefer the macro because it makes it easier to search where version
checks are being done and it keeps the `<` vs `<=3D` consistent. UCSI
only has a few published revisions: 1.2, 2.0, 2.1 and 3.0 and major
changes seem to have happened in 2.0 and 3.0 so there should be very
few of these macros created/used.

>
>         if (!con->partner && con->ucsi->version < UCSI_VERSION_2_0)
>                return 0;
>
> Besides that, I think you want an || operator instead of the && operator,=
 right?

Good catch on that. It should be OR.
i.e. if (!con->partner || !IS_MIN_VERSION_2_0(con->ucsi))

>
> > +               return 0;
> > +
> > +       command =3D UCSI_GET_CONNECTOR_CAPABILITY | UCSI_CONNECTOR_NUMB=
ER(con->num);
> > +       ret =3D ucsi_send_command(con->ucsi, command, &con->cap, sizeof=
(con->cap));
> > +       if (ret < 0) {
> > +               dev_err(con->ucsi->dev, "GET_CONNECTOR_CAPABILITY faile=
d (%d)\n", ret);
> > +               return ret;
> > +       }
> > +
> > +       typec_partner_set_pd_revision(
> > +               con->partner,
> > +               UCSI_CONCAP_FLAG_PARTNER_PD_MAJOR_REV_AS_BCD(con->cap.f=
lags));
> > +
> > +       return ret;
> > +}
> > +
> >  static int ucsi_check_connection(struct ucsi_connector *con)
> >  {
> >         u8 prev_flags =3D con->status.flags;
>
> Thanks,


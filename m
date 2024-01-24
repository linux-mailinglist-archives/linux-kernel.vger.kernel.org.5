Return-Path: <linux-kernel+bounces-37598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F3083B255
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EEE51F2462D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51012132C3A;
	Wed, 24 Jan 2024 19:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cKXLWlWN"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E8A132C0D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 19:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706124879; cv=none; b=JllWRGp0wwmMCAOBHoxJGT6DTR3V6yHEW4OTHfRUEahXruMeINE+rRa8MOfwmNP7bC2XYvdaBUl3zaxDyrlHoYIvMNeBxS9XELlFF9/hvLpjQ6j5io+4fJIQH9dncJRYMfcC7wU9joIThFkCvTGJIYDHrx824MEaCQ68fy/K6QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706124879; c=relaxed/simple;
	bh=WgifWUz3Gr+kTQxM0rtP5N6Jm9nsIzie+HFNuWed/bE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aGq3qP6fi0v1QM0fPzd7PhhzExFQY73vowzsIgAnn5lEVnkQWCbeQIIlE20/OHqFp2UXSckdL6shTy/HQIcBa8IHiTdjzYHxrae4zH40qEMD9HRkaHci/TEQQT4AWjrWixjeXM7Kl5QJ8uLgDw5tj8bsZ5nbjhic9yEDQLBxukk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cKXLWlWN; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-68196a09e2eso34602136d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 11:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706124868; x=1706729668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZUvX5R1ypOP3ZoaGMkONSc/GtN51J4XYq4lgSnIUNL0=;
        b=cKXLWlWNYJ6CaVfwjFa5sfCsmyvcxocg7dpyhaOv2kbAcp1UjHzUKsifZQblG4usN1
         hSrQ1rWOY0IDK8RhTpeaYrGSvG9uy5W/B95Twu2PkqZQuQEhN82dHuhAYjwsX5hGVvDa
         /kew3MzFfk2UzLFNIY2Gjl+JFn/WF451rM9hg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706124868; x=1706729668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZUvX5R1ypOP3ZoaGMkONSc/GtN51J4XYq4lgSnIUNL0=;
        b=c4YHnX7ncVsjgEwpcMKPl4mlZtmHW6k1VG6FzHLrZoopt8IvWVZgCG53f6QOIlOtMg
         hBFfGAEiNXzCqLSd/n/YdRTqSa8WyOHLfR1haxAR+swbY8BzrWxDI4j74bJbNm5z+VT0
         F2/xKcab7ZELa+dZC0Ffd4UL8GPOCUWHORVGuCDKzm7iYX8J9uHnqW4ULYPwc1/OBqxN
         68o2LJY94zF4BtJjbZ2ZZ609Zmmsafl7FMd9k46dhh8TQfZrgGvZWcvNXG5nb0Qk7vVK
         K8jZsAg2zCoXdPGpMLPCCwXmGMze9y3/09PCceiC9+YYJZNRnmdL1KfPg4U2WAJnUCZs
         mCqQ==
X-Gm-Message-State: AOJu0YyMzWbAqNr9YfI4Bq6z0G/jCYS19Om//qRVfYK3pd8rfEAKD9Lf
	FA1J9W8nxruXD4JsdzEn+wZ0gD3WD2dr/Pkf1LBdxMnmuiBxWq0/0KuQk25/VOJ3ILNkYOW0Saw
	LVE5lJxjPraNHvJeg2/NrfNVa9OIoKctDUHhY
X-Google-Smtp-Source: AGHT+IFdSmmiGj4lOSeztl0/DABo6LGJl5/xHBHcQKP5jidw8APbKW7N7SyQQKidCuNpKRPC/KcBdwWzm04vsoPPRu4=
X-Received: by 2002:a05:6214:622:b0:680:8373:4932 with SMTP id
 a2-20020a056214062200b0068083734932mr3380504qvx.69.1706124868109; Wed, 24 Jan
 2024 11:34:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123223039.1471557-1-abhishekpandit@google.com>
 <20240123143026.v1.3.Idf7d373c3cbb54058403cb951d644f1f09973d15@changeid>
 <CACeCKafTBwSgRXLFA3HC7cBe8hD=PSgSmR=TWy1oF3Rkn+hK4g@mail.gmail.com> <CANFp7mUFvRnb1BF=vzNE+BxMcjZi_o0wwJVw=Ty+zEG+JTzA1w@mail.gmail.com>
In-Reply-To: <CANFp7mUFvRnb1BF=vzNE+BxMcjZi_o0wwJVw=Ty+zEG+JTzA1w@mail.gmail.com>
From: Prashant Malani <pmalani@chromium.org>
Date: Wed, 24 Jan 2024 11:34:17 -0800
Message-ID: <CACeCKacH4zJGNqFKjLoaHzM59nSGdaWkNXec2GM=0kfafPBgqA@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] usb: typec: ucsi: Get PD revision for partner
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
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

On Wed, Jan 24, 2024 at 11:18=E2=80=AFAM Abhishek Pandit-Subedi
<abhishekpandit@chromium.org> wrote:
>
> On Wed, Jan 24, 2024 at 10:49=E2=80=AFAM Prashant Malani <pmalani@chromiu=
m.org> wrote:
> >
> > Hi Abhishek,
> >
> > On Tue, Jan 23, 2024 at 2:30=E2=80=AFPM Abhishek Pandit-Subedi
> > <abhishekpandit@google.com> wrote:
> > >
> > > From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > >
> > > PD major revision for the port partner is described in
> > > GET_CONNECTOR_CAPABILITY and is only valid on UCSI 2.0 and newer. Upd=
ate
> > > the pd_revision on the partner if the UCSI version is 2.0 or newer.
> > >
> > > Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > > ---
> > > $ cat /sys/class/typec/port2-partner/usb_power_delivery_revision
> > > 3.0
> > >
> > >  drivers/usb/typec/ucsi/ucsi.c | 25 +++++++++++++++++++++++++
> > >  drivers/usb/typec/ucsi/ucsi.h |  3 +++
> > >  2 files changed, 28 insertions(+)
> > >
> > > diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/u=
csi.c
> > > index 4edf785d203b..8e0a512853ba 100644
> > > --- a/drivers/usb/typec/ucsi/ucsi.c
> > > +++ b/drivers/usb/typec/ucsi/ucsi.c
> > > @@ -782,6 +782,8 @@ static int ucsi_register_partner(struct ucsi_conn=
ector *con)
> > >         }
> > >
> > >         desc.usb_pd =3D pwr_opmode =3D=3D UCSI_CONSTAT_PWR_OPMODE_PD;
> > > +       desc.pd_revision =3D
> > > +               UCSI_CONCAP_FLAG_PARTNER_PD_MAJOR_REV_AS_BCD(con->cap=
flags);
> > >
> > >         partner =3D typec_register_partner(con->port, &desc);
> > >         if (IS_ERR(partner)) {
> > > @@ -856,6 +858,28 @@ static void ucsi_partner_change(struct ucsi_conn=
ector *con)
> > >                         con->num, u_role);
> > >  }
> > >
> > > +static int ucsi_check_connector_capability(struct ucsi_connector *co=
n)
> > > +{
> > > +       u64 command;
> > > +       int ret;
> > > +
> > > +       if (!con->partner && !IS_MIN_VERSION_2_0(con->ucsi))
> >
> > (Mentioned side-band but reproducing here for consistency)
> > This macro is unnecessary. It's just doing a comparison, which can be i=
nlined
> > without any perceptible change in readability (actually, I'd argue addi=
ng the !
> > to an english idiom makes things *less* readable):
>
> I prefer the macro because it makes it easier to search where version
> checks are being done.

I don't see how searching for "IS_MIN_VERSION_2_0" is easier
than just searching for "UCSI_VERSION_2_0".

I didn't quite understand what you meant by

>  it keeps the `<` vs `<=3D` consistent.

Perhaps I'm missing something... (are these comparisons being
used elsewhere/in some other fashion?).

In any case, I don't want to bike-shed so I'll defer to the
maintainer's call on this.

BR,

-Prashant


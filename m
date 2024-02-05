Return-Path: <linux-kernel+bounces-53999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC74884A8FF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05F5C1C26FB7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA0348786;
	Mon,  5 Feb 2024 22:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qf8DHVmu"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD42A2C1B9
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 22:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707170752; cv=none; b=f0oFcFZPTp0qtQSPrIkHdCQfYpy9vmKMWGWu2DHkRrtS4k6yyrvjEp2/v1EzjHRAUAoApZg1NI51P8CMGeAuhreN4u8sORzETKtPeYSyEknb/G6hFOTOsTwohgn3GGbfAf8PRq83BbcecBXO5/IsXBIb6JiWApR727rWLnMkySU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707170752; c=relaxed/simple;
	bh=/yC6ukCR6M9OWDOAQofhpPWkpb0+7yFSlv5kx0Xd2yY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EdtJO+7V29ZEXZqxkduGpuE90jgudJovXq+HH1OWTbeKszMOEH9Sg4GbEU1I4sSm68VCivYJ0ndNRhyV3NctM53fdGlYJw2VS4fUXCctuV+KlDkQP5vWbbpcYix/dZO2zFHrbrAwfY8ODiP27Itkcw0W4ZdoiYMul01xwjL/Yus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Qf8DHVmu; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc6db13f1abso4215800276.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 14:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707170750; x=1707775550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+uyM7Qy9ebYgtc0T1FfcjgiWLInu4H67aNLCBp8izTI=;
        b=Qf8DHVmufNeX4fR9YPGoVxlpcuXXutYOFLjXGtJze/yMGBmlAhiNw1fPPtwioEp1Ib
         msJPhNHGIzoVfcXNtI43JyTVOfkLRTXZsby/qN1C5Rh84evuFOpa/OzBKe4brYB90wxZ
         CJX8DSbRxVc1iWzjyw+0GrZN+OEBtq1nWRBoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707170750; x=1707775550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+uyM7Qy9ebYgtc0T1FfcjgiWLInu4H67aNLCBp8izTI=;
        b=cnkrhu2IuxBJz+dmJwuD7qgEewFAqmweMpfiOWxGLuT0DgqNGV8zqvNJioeCbTRH8W
         hs/2FFBrTOp2fysSBeNuCdT5DTH+csOniQ2o74BSZEib3deHEgvhch8Y8enldut81IEi
         dW3OiwdeimNF44BwV8Xb8je5ZYgZz5dzFsBwQugEJv8/V0rmtpnIPspyCVUJ69aGNbO2
         Qn2nnKHsdABHua2han39qsUKXrA9W6HLsfx7/e9Ca0K+5fV0wlGWYANlloPxG3mmt3D6
         F7yQ/Y28KMO0Ys4b9lQJauDUq6WeuA1BhNkMa/au+apzj7tU15NbsiC33GI0/M+v+aCr
         fo8Q==
X-Gm-Message-State: AOJu0YywRrBIl0V0KY975NGDPD7V6gJGsj6ckrfFo23K2DQ0bHyYMIJM
	5hH14AZFi/06N1MnX6vwYDJxjTH0AuVqB918Ap2gbNkdmSwUpPcnabJq5cO49JOkyfx4oc7+8aD
	GeJ698KoctwQAqGLJzdw8gm7Nw1wpo5QhEvXI
X-Google-Smtp-Source: AGHT+IE1dY0Dgu+RNNAwM80SRYg80MTyc6l94UjLiuC8rBB3isPt7AhJZ2B2k3REppaMwM/8wOjM5t6SUG0eRFTfdY4=
X-Received: by 2002:a25:ace1:0:b0:dc2:28b1:2e8b with SMTP id
 x33-20020a25ace1000000b00dc228b12e8bmr713829ybd.15.1707170749681; Mon, 05 Feb
 2024 14:05:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126183930.1170845-1-abhishekpandit@chromium.org>
 <20240126103859.v3.3.Idf7d373c3cbb54058403cb951d644f1f09973d15@changeid> <CACeCKaeVtU3ckmGU932d-pPn=eOnt6KjAavNY3rSOUgrJNriDg@mail.gmail.com>
In-Reply-To: <CACeCKaeVtU3ckmGU932d-pPn=eOnt6KjAavNY3rSOUgrJNriDg@mail.gmail.com>
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date: Mon, 5 Feb 2024 14:05:38 -0800
Message-ID: <CANFp7mXOXc6TzLJ+EJ9VYxqGHcjW099oBhDctarUdM5eJGz5bg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] usb: typec: ucsi: Get PD revision for partner
To: Prashant Malani <pmalani@chromium.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-usb@vger.kernel.org, 
	jthies@google.com, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bjorn Andersson <andersson@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hdegoede@redhat.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rajaram Regupathy <rajaram.regupathy@intel.com>, 
	Saranya Gopal <saranya.gopal@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Heikki,

Friendly ping to review this patch (I see you added Reviewed-by to the
other two in this series).

Thanks,
Abhishek

On Fri, Jan 26, 2024 at 12:25=E2=80=AFPM Prashant Malani <pmalani@chromium.=
org> wrote:
>
> Hi Abhishek,
>
> On Fri, Jan 26, 2024 at 10:39=E2=80=AFAM Abhishek Pandit-Subedi
> <abhishekpandit@chromium.org> wrote:
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
> > (no changes since v2)
> >
> > Changes in v2:
> >   - Formatting changes and update macro to use brackets.
> >   - Fix incorrect guard condition when checking connector capability.
> >
> >  drivers/usb/typec/ucsi/ucsi.c | 23 +++++++++++++++++++++++
> >  drivers/usb/typec/ucsi/ucsi.h |  3 +++
> >  2 files changed, 26 insertions(+)
> >
> > diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucs=
i.c
> > index a35056ee3e96..2b7983d2fdae 100644
> > --- a/drivers/usb/typec/ucsi/ucsi.c
> > +++ b/drivers/usb/typec/ucsi/ucsi.c
> > @@ -782,6 +782,7 @@ static int ucsi_register_partner(struct ucsi_connec=
tor *con)
> >         }
> >
> >         desc.usb_pd =3D pwr_opmode =3D=3D UCSI_CONSTAT_PWR_OPMODE_PD;
> > +       desc.pd_revision =3D UCSI_CONCAP_FLAG_PARTNER_PD_MAJOR_REV_AS_B=
CD(con->cap.flags);
> >
> >         partner =3D typec_register_partner(con->port, &desc);
> >         if (IS_ERR(partner)) {
> > @@ -856,6 +857,27 @@ static void ucsi_partner_change(struct ucsi_connec=
tor *con)
> >                         con->num, u_role);
> >  }
> >
> > +static int ucsi_check_connector_capability(struct ucsi_connector *con)
> > +{
> > +       u64 command;
> > +       int ret;
> > +
> > +       if (!con->partner || !IS_MIN_VERSION_2_0(con->ucsi))
>
> I'll reiterate my comment from a previous version, since this series
> has been revv-ed a few
> times since and it may have gotten lost; no need to respond to it if
> you don't want to,
> since I believe we left it to the maintainer(s) to decide [1]:
>
> This macro is unnecessary. Since the version is in BCD format and we
> already have the
> macros for versions, just a simple comparison is enough:
>          if (!con-partner || con->ucsi->version < UCSI_VERSION_2_0)
>                  return 0;
>
> I'll add that Patch 1 of this series [2] is also using the same style
> for comparing version numbers.
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
>
> nit: I know this is being done elsewhere in this file, but we should
> avoid putting error
> numbers in parentheses [3]. Perhaps something for a separate cleanup patc=
h.
>
> [1] https://lore.kernel.org/linux-usb/CANFp7mXP=3DaN8bQi4akKKcoMZE8RaCBuF=
nwTa5hbp0MZvZe0hYQ@mail.gmail.com/
> [2] https://lore.kernel.org/linux-usb/20240126103859.v3.1.Iacf5570a66b82b=
73ef03daa6557e2fc0db10266a@changeid/
> [3] https://www.kernel.org/doc/html/latest/process/coding-style.html#prin=
ting-kernel-messages


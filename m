Return-Path: <linux-kernel+bounces-37547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A84B83B176
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE90C1F2363D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA40131E26;
	Wed, 24 Jan 2024 18:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XnYlf28n"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6BE131759
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 18:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706122151; cv=none; b=kSE5tV5P/Kp6dwtV6oy0fXcbhWKs/Zw8BFXDbMb2Rfvis0VK/v/CCWizXhtSvnGUFtyrs3hWNxPgSCq7uzFKPQOJKmKp+ccy/3WKmWWmcnD2eBQXB1E55x8sOL5xKHEOFj5qhF+JTKdcs3r+epfQOxgFO6P+KB1oxPXl/mGGGYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706122151; c=relaxed/simple;
	bh=aC6u8HH8pc+zXbtM+BeGVCoecIERgUFSGE/YVc04gDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=czUn8fCfcU+VzpunvFN3nJJhBw5x0usHsu2VtiyXsNpiCvADyuqLHRNmzeIkGpx8y6far3uwgdwKRLdzts/MiOCldummZSrRgExpULExRguQEEyussx6WypfCAjrgC17Gl7L/Pg0zPtdBTS+EPaSGXFw85O4Ne5f0umv5fZx1ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XnYlf28n; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5989d8decbfso3600034eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 10:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706122149; x=1706726949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3+5jjo6LA2k8g/ORH9MGNYqsuKvMZq0F986QSVFKMA=;
        b=XnYlf28ngdMfAIueAVPI7NYMUSM/QI2onLxBymEPDG1NK9bKmdejHG38059UeMyCSL
         hwNveKmlxWAPlTT6mW36IpTkc6PLkVdJ8JYhklsBC0DJdt3GQD90brrawk4AfnjD0AED
         duhKPEa62gvsE2cIsRXTqxZ+Y2czVh5UxmqJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706122149; x=1706726949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3+5jjo6LA2k8g/ORH9MGNYqsuKvMZq0F986QSVFKMA=;
        b=ux0ucdBjnP79bI6MuPMx2IRYLq/dRnmGDMxxU6//sgQXrcHQ19L1ScdHFo5zsLdwMS
         Z+8PPx5dFaAasdP4DzC48/EZVMezdsTVSxlpsNJvr/Z6FmZSqqOvkcsYNb59gBOlnHet
         tquCkVuxGI5ECIKUgqzlq3U3sEhmHJJakmGRewkVjKnNdkAa3FudMw+rmEZq85bLXAs0
         5dxBBG+uShG3PDLzE40dSbvjlVuSvoQIPIyrOehNROin1pvPN0m3O1N0sMz1dM7DDej3
         IGe5HBk6J+rn+8p2DaYIxHBzYPPlUqWP/1cVe/nED7Ab84EUNI6sHmdQp07IPV3CQNWP
         FVJQ==
X-Gm-Message-State: AOJu0Ywj8X30XSBKFZu1lwoqYqulxQEIK/UwdWDVZYj7b0pWZ7ZJW0Xg
	xc/fLzvBVyDZB+bFnxh/Dr3amzM+hJwOltK+2H3/GQ04bMsg+7uAEeTc6cv93lrZoTQNgbV+lIb
	Zy6wcQ1WWbxEkZLgvlYS5DEyZI3ii/+VnZVNo
X-Google-Smtp-Source: AGHT+IFXWm2doNxu8/97xKCYO4J7QGVhDelb9pjMfd5vHg9zlL+8b283RogRfG2fi7ZufvCTxws1vXU7CwM/rLflYP0=
X-Received: by 2002:a05:6358:ed19:b0:176:f81:fccf with SMTP id
 hy25-20020a056358ed1900b001760f81fccfmr7803266rwb.32.1706122149296; Wed, 24
 Jan 2024 10:49:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123223039.1471557-1-abhishekpandit@google.com> <20240123143026.v1.3.Idf7d373c3cbb54058403cb951d644f1f09973d15@changeid>
In-Reply-To: <20240123143026.v1.3.Idf7d373c3cbb54058403cb951d644f1f09973d15@changeid>
From: Prashant Malani <pmalani@chromium.org>
Date: Wed, 24 Jan 2024 10:48:57 -0800
Message-ID: <CACeCKafTBwSgRXLFA3HC7cBe8hD=PSgSmR=TWy1oF3Rkn+hK4g@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] usb: typec: ucsi: Get PD revision for partner
To: Abhishek Pandit-Subedi <abhishekpandit@google.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-usb@vger.kernel.org, 
	jthies@google.com, Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bjorn Andersson <andersson@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hdegoede@redhat.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Saranya Gopal <saranya.gopal@intel.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Abhishek,

On Tue, Jan 23, 2024 at 2:30=E2=80=AFPM Abhishek Pandit-Subedi
<abhishekpandit@google.com> wrote:
>
> From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
>
> PD major revision for the port partner is described in
> GET_CONNECTOR_CAPABILITY and is only valid on UCSI 2.0 and newer. Update
> the pd_revision on the partner if the UCSI version is 2.0 or newer.
>
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
> $ cat /sys/class/typec/port2-partner/usb_power_delivery_revision
> 3.0
>
>  drivers/usb/typec/ucsi/ucsi.c | 25 +++++++++++++++++++++++++
>  drivers/usb/typec/ucsi/ucsi.h |  3 +++
>  2 files changed, 28 insertions(+)
>
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.=
c
> index 4edf785d203b..8e0a512853ba 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -782,6 +782,8 @@ static int ucsi_register_partner(struct ucsi_connecto=
r *con)
>         }
>
>         desc.usb_pd =3D pwr_opmode =3D=3D UCSI_CONSTAT_PWR_OPMODE_PD;
> +       desc.pd_revision =3D
> +               UCSI_CONCAP_FLAG_PARTNER_PD_MAJOR_REV_AS_BCD(con->cap.fla=
gs);
>
>         partner =3D typec_register_partner(con->port, &desc);
>         if (IS_ERR(partner)) {
> @@ -856,6 +858,28 @@ static void ucsi_partner_change(struct ucsi_connecto=
r *con)
>                         con->num, u_role);
>  }
>
> +static int ucsi_check_connector_capability(struct ucsi_connector *con)
> +{
> +       u64 command;
> +       int ret;
> +
> +       if (!con->partner && !IS_MIN_VERSION_2_0(con->ucsi))

(Mentioned side-band but reproducing here for consistency)
This macro is unnecessary. It's just doing a comparison, which can be inlin=
ed
without any perceptible change in readability (actually, I'd argue adding t=
he !
to an english idiom makes things *less* readable):

        if (!con->partner && con->ucsi->version < UCSI_VERSION_2_0)
               return 0;

Besides that, I think you want an || operator instead of the && operator, r=
ight?

> +               return 0;
> +
> +       command =3D UCSI_GET_CONNECTOR_CAPABILITY | UCSI_CONNECTOR_NUMBER=
(con->num);
> +       ret =3D ucsi_send_command(con->ucsi, command, &con->cap, sizeof(c=
on->cap));
> +       if (ret < 0) {
> +               dev_err(con->ucsi->dev, "GET_CONNECTOR_CAPABILITY failed =
(%d)\n", ret);
> +               return ret;
> +       }
> +
> +       typec_partner_set_pd_revision(
> +               con->partner,
> +               UCSI_CONCAP_FLAG_PARTNER_PD_MAJOR_REV_AS_BCD(con->cap.fla=
gs));
> +
> +       return ret;
> +}
> +
>  static int ucsi_check_connection(struct ucsi_connector *con)
>  {
>         u8 prev_flags =3D con->status.flags;

Thanks,


Return-Path: <linux-kernel+bounces-40626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9CE83E35C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A7BAB25A3E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0C12374A;
	Fri, 26 Jan 2024 20:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JPaYXbD3"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B6E249EB
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 20:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706300756; cv=none; b=rt3P+heER66wZtzEgJN147C95nrVNUTge8MRssHnvTEfIlTnVNb74w2mcOxKasqdb9bJSX7Sm1w49b9jUj541++C4/HKPs6Yco9tC5nvZltNqyVzwSQpfcs/Iv7aLZiuTpej66Sg+YkYfXlK+xfbeEAEQC8id6LSm6Bq3q6k0/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706300756; c=relaxed/simple;
	bh=Gyr1CXh6GRM0r1jg1fNGMC5h8eXbeh04xtGAcUqaV+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OCzc7+t7+oDlE0Ef383XQF+t1JqGbtpYLbjJqBbm6ERT78zkZ8EcPRwUjws2MKwegNY2zt3A8CN7ap4p2jCAF7IFiDXhUSlstkmHdapV6EdYI5IYf7yKJtCldv7unsAFvt35cIrOBAeDinMUKAyAd2JBbSy6IgjRQ6TQMjFis4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JPaYXbD3; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6818a9fe380so4613686d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 12:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706300753; x=1706905553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXJ3r7063rd8jWwrzpmzNpGbTjtYsTY5IZ/kY+74Um0=;
        b=JPaYXbD3qsO7Sk2cBn5GFbJo7kzuMBqxQ9rk+0IoYQ+qgEX8jimXN+o+SCv1/xHYyD
         u9wwqG6p+2W/AT4l9LyiztJmpk5UMgRJtYyn0I37Wbd2kLM0VrpN31SifKbaHdmJCNMr
         9gyVFXA0LcxSd4fGVSKotDYh8Kq6uuzxZUeiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706300753; x=1706905553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BXJ3r7063rd8jWwrzpmzNpGbTjtYsTY5IZ/kY+74Um0=;
        b=XdMlQc/5SGd4HM8t5W/bteYLh8vc1H87RmwrDpG88Fpqwpk3iccRoAbjMB+rAuA+UW
         39QI+BwFditEm306kzbfJ0VgH2H2pe0sMBaMwFlJFErzZcXQYBnJ5p4LoE34zbWzFo2W
         RtPypKTaQsbxnoPFTNZNiqzJ4rJLE3u2MpbBUf+Ufj89rr8+AaH9Ki9ZmDK6UR8h9DZ9
         HDJ4eszlEFhDjsCEar8uFBZr8DzTyR14NOLoGbK10cRPekJUiOEvmwBf3hwp8I18zI39
         fleK4u2nZ1LvSIsMbhMjunAOlUChEXSDurJUtNEWLWGbGWKTkCCcxRD1R7Y3YkeZxkNY
         H2+w==
X-Gm-Message-State: AOJu0YyXPp9rHHu+rl7MgfVOdsu7YUEPlFaH2Rri6ZPZBPxsLWU1f7dp
	SJykmG/wzYCfFRN3GCWRO5QMZNsGFhcsncI+XWCJRbCljC7TCwaWzBH9t72hTRyRVjXiGALSJom
	9nI7FD7deDCRu44fccXdDLbqApL2BGNu5On5i
X-Google-Smtp-Source: AGHT+IFppUkWXAnANHG9WctbKX5UqqzMwcsvbga5+t3wv5vs4SabgC+VN64roLDZ9c1F8LOVbijElWcl37FyGTHybmk=
X-Received: by 2002:a05:6214:2127:b0:686:ac1d:eefa with SMTP id
 r7-20020a056214212700b00686ac1deefamr550461qvc.70.1706300752839; Fri, 26 Jan
 2024 12:25:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126183930.1170845-1-abhishekpandit@chromium.org> <20240126103859.v3.3.Idf7d373c3cbb54058403cb951d644f1f09973d15@changeid>
In-Reply-To: <20240126103859.v3.3.Idf7d373c3cbb54058403cb951d644f1f09973d15@changeid>
From: Prashant Malani <pmalani@chromium.org>
Date: Fri, 26 Jan 2024 12:25:41 -0800
Message-ID: <CACeCKaeVtU3ckmGU932d-pPn=eOnt6KjAavNY3rSOUgrJNriDg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] usb: typec: ucsi: Get PD revision for partner
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-usb@vger.kernel.org, 
	jthies@google.com, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bjorn Andersson <andersson@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hdegoede@redhat.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rajaram Regupathy <rajaram.regupathy@intel.com>, 
	Saranya Gopal <saranya.gopal@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Abhishek,

On Fri, Jan 26, 2024 at 10:39=E2=80=AFAM Abhishek Pandit-Subedi
<abhishekpandit@chromium.org> wrote:
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
> (no changes since v2)
>
> Changes in v2:
>   - Formatting changes and update macro to use brackets.
>   - Fix incorrect guard condition when checking connector capability.
>
>  drivers/usb/typec/ucsi/ucsi.c | 23 +++++++++++++++++++++++
>  drivers/usb/typec/ucsi/ucsi.h |  3 +++
>  2 files changed, 26 insertions(+)
>
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.=
c
> index a35056ee3e96..2b7983d2fdae 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -782,6 +782,7 @@ static int ucsi_register_partner(struct ucsi_connecto=
r *con)
>         }
>
>         desc.usb_pd =3D pwr_opmode =3D=3D UCSI_CONSTAT_PWR_OPMODE_PD;
> +       desc.pd_revision =3D UCSI_CONCAP_FLAG_PARTNER_PD_MAJOR_REV_AS_BCD=
(con->cap.flags);
>
>         partner =3D typec_register_partner(con->port, &desc);
>         if (IS_ERR(partner)) {
> @@ -856,6 +857,27 @@ static void ucsi_partner_change(struct ucsi_connecto=
r *con)
>                         con->num, u_role);
>  }
>
> +static int ucsi_check_connector_capability(struct ucsi_connector *con)
> +{
> +       u64 command;
> +       int ret;
> +
> +       if (!con->partner || !IS_MIN_VERSION_2_0(con->ucsi))

I'll reiterate my comment from a previous version, since this series
has been revv-ed a few
times since and it may have gotten lost; no need to respond to it if
you don't want to,
since I believe we left it to the maintainer(s) to decide [1]:

This macro is unnecessary. Since the version is in BCD format and we
already have the
macros for versions, just a simple comparison is enough:
         if (!con-partner || con->ucsi->version < UCSI_VERSION_2_0)
                 return 0;

I'll add that Patch 1 of this series [2] is also using the same style
for comparing version numbers.

> +               return 0;
> +
> +       command =3D UCSI_GET_CONNECTOR_CAPABILITY | UCSI_CONNECTOR_NUMBER=
(con->num);
> +       ret =3D ucsi_send_command(con->ucsi, command, &con->cap, sizeof(c=
on->cap));
> +       if (ret < 0) {
> +               dev_err(con->ucsi->dev, "GET_CONNECTOR_CAPABILITY failed =
(%d)\n", ret);

nit: I know this is being done elsewhere in this file, but we should
avoid putting error
numbers in parentheses [3]. Perhaps something for a separate cleanup patch.

[1] https://lore.kernel.org/linux-usb/CANFp7mXP=3DaN8bQi4akKKcoMZE8RaCBuFnw=
Ta5hbp0MZvZe0hYQ@mail.gmail.com/
[2] https://lore.kernel.org/linux-usb/20240126103859.v3.1.Iacf5570a66b82b73=
ef03daa6557e2fc0db10266a@changeid/
[3] https://www.kernel.org/doc/html/latest/process/coding-style.html#printi=
ng-kernel-messages


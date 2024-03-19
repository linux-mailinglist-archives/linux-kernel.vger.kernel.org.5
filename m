Return-Path: <linux-kernel+bounces-107476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED02287FD08
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 184681C21DD0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210BD7F467;
	Tue, 19 Mar 2024 11:39:35 +0000 (UTC)
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330D11CD13;
	Tue, 19 Mar 2024 11:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710848374; cv=none; b=gbktZ1Cq7o582/w/6e3sGFUS/KMBhXcr4Fwm9QjI6DNgSbeI3hag5xRvPtFTftQCwagqNwQ0TFJC4NQLLWyy869/dzLEDSrzNOLKZTG9pcGph0RAruDxfT43pTmNPLsOTHGajf1RQJj0wzW97foWiJSySW0qF5lbPftWzCXnAD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710848374; c=relaxed/simple;
	bh=vojRu5Rt8UyQxGZBpl02LUieDOrevQoQb1W9TGD1xVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=llcabuvunPE4K25xl88rL7LauSQ3h7EVBRgEtZnbHoEyeAbYKqPGF3lIM3bFPJJSi46BJc+sZ5/rhVHhAMfo4IHaoHSCYmt6T8pWr/7m/nRTYHjGRFoD5hh3Fupw2S1Q7S7th/N9oqOV3/Pl/ufyNUXePAtvC2cYIfDASYqXC9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5a46ad0d981so1201508eaf.1;
        Tue, 19 Mar 2024 04:39:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710848372; x=1711453172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fGDMdE/ubpMSGXQdDQ2jOzVWvsK6WIp+rG4bdzH3AV8=;
        b=TMzdexX1XYjzjQ/30A5VK5ToZ4+tsT6c4GLnFe/ScTDy2VKKMkuXT0VuvS/UH1sONC
         uYFfmZzjNh1OGdy1yTBYQJy5A0wJ7fJUnRRPlOweTP0S67eaqUqDAiMIKjhC80C6vijX
         y41LvQwvss5wkVuWpw2tz8MxhdDEKSS5o9GbfNCnDJ2deno/xeHUIUf47aQRxk8xPWnE
         ST7PWHSpn3zreP0d9km1H/21NH5oLEE91m6VEp61HWBB/h+DaMd32LY9ItKyc4hxAkmi
         ezE+hZU6pYmOqJfCLbY+E7GZHj1EzHKHpDVpuf9w677EM1JHjwuO040EKJwUelJEpjDC
         iy8w==
X-Forwarded-Encrypted: i=1; AJvYcCUh/qnDbNThdUe+55KxkoETcBGGT4sKZHy8c5zd+A+2G6o6ApgA9gkIl49387H53WNEJsWjqYexUmfsvy7OklNPpuEGPZDsbAL60RJlXpVMxEwelbnxVgkx832grIqjtIR3p2t9zScMSsUYCkZ1gBLkFpabo/U6FkS61cyfNVZpN3w3gfR21rM=
X-Gm-Message-State: AOJu0Yw3AmnDFPERLdbreZQZ1L9hJxedN/9ztWhhBQTqC7KPB3tpq2K2
	fy3pR50l9s885jkYMvNmwV6s8MCbhgHGuls4rjuGAGZ1fPnXrqfEWrEFTqLjqrfw5rC+Rum4M6K
	8HQ3Oi+NCrlXmi/FBVSvrlyMJWWs=
X-Google-Smtp-Source: AGHT+IGHZCsOkNMXpc8xdHuAUf+zixo9CgVbeU12ShhxJpSf+PUXcFlR5MZ54F+q9rYGC8+OAMRFvhgllN6VNMvyUtI=
X-Received: by 2002:a05:6870:8a08:b0:229:848e:b7ea with SMTP id
 p8-20020a0568708a0800b00229848eb7eamr1177280oaq.4.1710848372151; Tue, 19 Mar
 2024 04:39:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318-strncpy-drivers-thermal-intel-int340x_thermal-acpi_thermal_rel-c-v1-1-08839fbf737a@google.com>
In-Reply-To: <20240318-strncpy-drivers-thermal-intel-int340x_thermal-acpi_thermal_rel-c-v1-1-08839fbf737a@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 19 Mar 2024 12:39:20 +0100
Message-ID: <CAJZ5v0j=cYbqyfi6y45hnu+Y_tvMGYb9p6d=kpsOA0AsxBoy3g@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel: int340x_thermal: replace deprecated
 strncpy with strscpy
To: Justin Stitt <justinstitt@google.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 11:36=E2=80=AFPM Justin Stitt <justinstitt@google.c=
om> wrote:
>
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
>
> psvt->limit.string can only be 8 bytes so let's use the appropriate size
> macro ACPI_LIMIT_STR_MAX_LEN.
>
> Neither psvt->limit.string or psvt_user[i].limit.string requires the
> NUL-padding behavior that strncpy() provides as they have both been
> filled with NUL-bytes prior to the string operation.
> |       memset(&psvt->limit, 0, sizeof(u64));
> and
> |       psvt_user =3D kzalloc(psvt_len, GFP_KERNEL);
>
> Let's use `strscpy` [2] due to the fact that it guarantees
> NUL-termination on the destination buffer without unnecessarily
> NUL-padding.
>
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strn=
cpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.h=
tml [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Srinivas, any objections?

> ---
> Note: build-tested only.
>
> Found with: $ rg "strncpy\("
> ---
>  drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c b/d=
rivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c
> index dc519a665c18..4b4a4d63e61f 100644
> --- a/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c
> +++ b/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c
> @@ -309,7 +309,7 @@ static int acpi_parse_psvt(acpi_handle handle, int *p=
svt_count, struct psvt **ps
>
>                 if (knob->type =3D=3D ACPI_TYPE_STRING) {
>                         memset(&psvt->limit, 0, sizeof(u64));
> -                       strncpy(psvt->limit.string, psvt_ptr->limit.str_p=
tr, knob->string.length);
> +                       strscpy(psvt->limit.string, psvt_ptr->limit.str_p=
tr, ACPI_LIMIT_STR_MAX_LEN);
>                 } else {
>                         psvt->limit.integer =3D psvt_ptr->limit.integer;
>                 }
> @@ -468,7 +468,7 @@ static int fill_psvt(char __user *ubuf)
>                 psvt_user[i].unlimit_coeff =3D psvts[i].unlimit_coeff;
>                 psvt_user[i].control_knob_type =3D psvts[i].control_knob_=
type;
>                 if (psvt_user[i].control_knob_type =3D=3D ACPI_TYPE_STRIN=
G)
> -                       strncpy(psvt_user[i].limit.string, psvts[i].limit=
string,
> +                       strscpy(psvt_user[i].limit.string, psvts[i].limit=
string,
>                                 ACPI_LIMIT_STR_MAX_LEN);
>                 else
>                         psvt_user[i].limit.integer =3D psvts[i].limit.int=
eger;
>
> ---
> base-commit: bf3a69c6861ff4dc7892d895c87074af7bc1c400
> change-id: 20240318-strncpy-drivers-thermal-intel-int340x_thermal-acpi_th=
ermal_rel-c-17070c1e42f3
>
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
>


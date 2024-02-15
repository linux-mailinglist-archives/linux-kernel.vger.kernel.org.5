Return-Path: <linux-kernel+bounces-67471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A88856C0A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 724AF28F5B1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B611386B9;
	Thu, 15 Feb 2024 18:04:30 +0000 (UTC)
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A28B135A40;
	Thu, 15 Feb 2024 18:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708020269; cv=none; b=BpiYtl1CwAv1uBR+rQvye2YYcbn89TiSkPeUIyMYpa81dLZODF2w14XZGJ/+ICarTSuEAylIJ8U6LPpcri8hA4qys95KNAD136ntWrpNUq0fGHz+IGa6PZ2NPSqnw8VgcUrEun1ibO7BHpvzG9LJ3S1zUK1dpQZFlPHNxIPfEo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708020269; c=relaxed/simple;
	bh=OOdq3VXO7hmheUjpDNjJV2uW/HQVgnjzp9qxVRAt1Q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t3JHiYjptI1O+TOVaA1Gq4Ni7YB2lKibv4+UNYEzJG+SmHbhW5TIaXv5ycDkME9Xu0C0NyEnh3stgmaMDZr2d/KNR46jTKArhaKvheuiGvdUC+M1NLgUvV8r4zo8KZ3Ksgoy307Tswbe914TRRjvZ/DznN1PYgNyjWHw0zfhqiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-59cbf204d52so125954eaf.1;
        Thu, 15 Feb 2024 10:04:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708020267; x=1708625067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lb5qWV79xfsy1nob2raR3IdkShVhRb4uV1Pha2M3jlQ=;
        b=dipl/1mVYsc0eLzzSW95xt0CHidvf9jEry0PnvBB2GhqnlhbjJKYauiZZqzdQrmApz
         LgPsNuf2ucrPbFE98zTAsUexY9MQzlppJJC4fdp0zRijeKTY8nQJiPvPTUZCbr3LlWyd
         fZe9wzfdO+uFxINL2lZSxDURiKf08/shYxqp2q+4lPivD7dJKHX5lCvsEKedIxhL89ss
         eIUyZ6DhQ5aaoLo/MPoXqd0IqIUW+CcNASwtezO68U5RPgwNrKggQOgWPn0X0KMF30D7
         PJ6mZ5OmASKtdjNioLVdhKln4IRS1pmb+9V7+EFW97gmw1t1K+Nap/vgTZ11UOgvQLku
         U75Q==
X-Forwarded-Encrypted: i=1; AJvYcCUcf0cA/ftJkfCfsMx+Go1cbbOZ4e8ybMnTrA7mYhhE1wi7RfE1jSWwAnMKu0aaBOi4tkic12qsK5uAMwzelKG3TnJ8oGaMEtQ3OZMIxkqHGmzlKP8nuy4zhugDB3qSVsRTe9Wvm0HS8sr1/khsVfDu5uJpmfve9lo95CyLSYT7xC4qRzI=
X-Gm-Message-State: AOJu0Yw/XMnWVyoFJ6zLMCMRSpFIuhQf5X4XqW8etlzh2RNLFNk9x3Gp
	WU68kNO0GuOAgLQWheLncAgDX9z3b1u2Ww6sPrNG8iV4i1w1794L2VAVxSakXQGn9DCQwUAk1yg
	eQ4TyhdLa3+MIw8ATP5QIk9usWTZIu4nd
X-Google-Smtp-Source: AGHT+IFtgxPxCy0j7Fv+BWzHYBZiXW3bHFmfrbcpc91leSPMJZqEpf3xxW9UF1Qig/NKYHxMcHLKEG4GC2jON4Ds9O0=
X-Received: by 2002:a4a:d5d8:0:b0:59c:d8cd:ecee with SMTP id
 a24-20020a4ad5d8000000b0059cd8cdeceemr2219735oot.1.1708020266819; Thu, 15 Feb
 2024 10:04:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6017196.lOV4Wx5bFT@kreacher> <22182690.EfDdHjke4D@kreacher>
In-Reply-To: <22182690.EfDdHjke4D@kreacher>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 15 Feb 2024 19:04:15 +0100
Message-ID: <CAJZ5v0i4i=OAj142eV3Vton5o25YzMF6x0ZSNFBOZgjWb1ccpg@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] wifi: iwlwifi: mvm: Set THERMAL_TRIP_FLAG_RW_TEMP directly
To: Linux PM <linux-pm@vger.kernel.org>, 
	Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>, LKML <linux-kernel@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	netdev@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, linux-wireless@vger.kernel.org, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>, Kalle Valo <kvalo@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 7:42=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.ne=
t> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> It is now possible to flag trip points with THERMAL_TRIP_FLAG_RW_TEMP
> to allow their temperature to be set from user space via sysfs instead
> of using a nonzero writable trips mask during thermal zone registration,
> so make the iwlwifi code do that.
>
> No intentional functional impact.
>
> Note that this change is requisite for dropping the mask argument from
> thermal_zone_device_register_with_trips() going forward.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> v1 -> v2:
>    * Rename trip flag (Stanislaw).
>    * Fix coding mistake in iwl_mvm_thermal_zone_register().
>    * Add "wifi:" prefix to the subject (Kalle).

I think that all of the feedback on the v1 of this patch has been
addressed, so are there any more concerns regarding it?

If not, it would be nice to get an ACK for it, so it can be routed
through the PM tree.

> ---
>  drivers/net/wireless/intel/iwlwifi/mvm/tt.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> Index: linux-pm/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> +++ linux-pm/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> @@ -667,9 +667,6 @@ static  struct thermal_zone_device_ops t
>         .set_trip_temp =3D iwl_mvm_tzone_set_trip_temp,
>  };
>
> -/* make all trips writable */
> -#define IWL_WRITABLE_TRIPS_MSK (BIT(IWL_MAX_DTS_TRIPS) - 1)
> -
>  static void iwl_mvm_thermal_zone_register(struct iwl_mvm *mvm)
>  {
>         int i, ret;
> @@ -692,11 +689,12 @@ static void iwl_mvm_thermal_zone_registe
>         for (i =3D 0 ; i < IWL_MAX_DTS_TRIPS; i++) {
>                 mvm->tz_device.trips[i].temperature =3D THERMAL_TEMP_INVA=
LID;
>                 mvm->tz_device.trips[i].type =3D THERMAL_TRIP_PASSIVE;
> +               mvm->tz_device.trips[i].flags =3D THERMAL_TRIP_FLAG_RW_TE=
MP;
>         }
>         mvm->tz_device.tzone =3D thermal_zone_device_register_with_trips(=
name,
>                                                         mvm->tz_device.tr=
ips,
>                                                         IWL_MAX_DTS_TRIPS=
,
> -                                                       IWL_WRITABLE_TRIP=
S_MSK,
> +                                                       0,
>                                                         mvm, &tzone_ops,
>                                                         NULL, 0, 0);
>         if (IS_ERR(mvm->tz_device.tzone)) {
>
>
>
>


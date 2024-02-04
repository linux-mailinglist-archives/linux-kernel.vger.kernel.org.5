Return-Path: <linux-kernel+bounces-51385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C815D848AB8
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 03:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04BBA1C20FDE
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 02:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DCB6AA2;
	Sun,  4 Feb 2024 02:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBFY6joU"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBB310E9;
	Sun,  4 Feb 2024 02:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707015350; cv=none; b=NtJ8wgZec7RQ6W5OkIaoxuD08S9/oCUlqztYLRmIFnGa/IxOHxGHtnhRoztD7iz3Z+oPEyfk3QN5mZ/9je2nH4g1YNV3wX/mij28Eg+lurctQvvWXqXCcPsb0EBMbAxWMfB6497Lx4kKcojR/v7YHx3deurGwkwlPIq2YZIcgds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707015350; c=relaxed/simple;
	bh=z4AeRLalu/p2zl7plydO8dKI7qzgLGHQB2OZ8UgDREo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rCsxzSh88S40EYJulpzJiym5bUliwswIF5PxNY0KEATT+xDusAOYlJDPLvFoM4Btdbfq7UXXh2rCHztoI7tO1d7eOuUgLWQ89q6vV58BCn+QOQvNJKFrNn6n57IMYUMlsikq5NrSmMNfvK1pv08FkkAZwODd5IxkkmD2e78CQR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBFY6joU; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-68c4673eff5so21827726d6.1;
        Sat, 03 Feb 2024 18:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707015348; x=1707620148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpeQ8KEZ+KN3pf3YBIeHbynD5W0si4Kjs9xM+hK2pPU=;
        b=gBFY6joUSQHwpHjZC0e1s0Acgk2XkFORx4f1l/hMXrd3JKixdLloG21ObpzguEe6U/
         Li9a6uU2ISbN9bUqEG556qbahBi/YMXm1p75KWrWSxNXOYepz6+B4oLLYRvn2fVOR3J+
         0dcK+/BXeTFjg9Yse6dhVoWyPAFDYYJ1xy1zKG0ewTBt1YnFDMgtU4811b1cR9rBAw4S
         OpK+cVG6hg0t7g7DJfKS27LYCPjKIe3mIKAl736xPvRoOyI3plVGhIXmO15uB/tF/6bR
         fjkL79Sy3pR4Jo52hnieilQhDiQ7nmzPvo3IVHXsp0+waR1hHZmg8tA52QqSihgwJjon
         URpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707015348; x=1707620148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wpeQ8KEZ+KN3pf3YBIeHbynD5W0si4Kjs9xM+hK2pPU=;
        b=Ezrs8s3HosXLZUIQD3Df4DMkYuWfdzay2gnud4WA+dog0RfwFapwhJR6OMB9PEFNQL
         knrK3sER3kVkKepMI57aHXBMROpzUlzW9ihHyhJB1Fif/U2Xx5Y3ZejADerYQGsr5Rur
         m0ZYSBbG9kUF0M127BkNQKNQ3WFSWRrT/R0VJNdlbSBuNVmeL2mCazfpPp4kWrufSgtd
         xqaA8dpQj1Wn7sSj8b/C8G1NzPn2XYnhZFfdKO9iTW/P39KOcJw06cD7AeXw2PXIOwt8
         ZdEXOh2LoJ2GPpcwUzF783lR/K8jiHdFjhIvZMpTngzLXNmVNgTYI1ieNKZqIIPU1R/+
         lx5A==
X-Gm-Message-State: AOJu0Ywcf4jCrbLbqCKGqeVUrDNu1ZgPKYC8w5u8VV2JBxig3i4HuPll
	kbqlfBeibBfq+Dq/KoHIsMNGbtmt+gzmGdvJUliGNyiT8uqRBvvM+kuwlPm1MHYsbsDsRG1gE7z
	Xgqk0QpT8zqndwHmmAGFa5iPDpOw=
X-Google-Smtp-Source: AGHT+IGKP3dKuw3hZGHqDFNl19Cy4lY92TrsuE57UasS+PMIg7vd8ZFgFZkSMRLF8ujMc5oTu2XFOpSL8/NikepXyMA=
X-Received: by 2002:a05:6214:d8a:b0:68c:9731:49b5 with SMTP id
 e10-20020a0562140d8a00b0068c973149b5mr2908898qve.28.1707015347786; Sat, 03
 Feb 2024 18:55:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1f8914cb-fc66-4068-8f7c-4d13b2454f7d@arm.com> <20240125062331.28943-1-di.shen@unisoc.com>
In-Reply-To: <20240125062331.28943-1-di.shen@unisoc.com>
From: Di Shen <cindygm567@gmail.com>
Date: Sun, 4 Feb 2024 10:55:36 +0800
Message-ID: <CAHYJL4oBPJ=pL2GT+-j398-TsmRG9D3rwFZyo7KaHvewQk4n0w@mail.gmail.com>
Subject: Re: [PATCH V2] thermal: power_allocator: Avoid overwriting PID
 coefficients from setup time
To: Di Shen <di.shen@unisoc.com>
Cc: lukasz.luba@arm.com, rafael@kernel.org, daniel.lezcano@linaro.org, 
	rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xuewen.yan@unisoc.com, zhanglyra@gmail.com, orsonzhai@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

On Thu, Jan 25, 2024 at 2:24=E2=80=AFPM Di Shen <di.shen@unisoc.com> wrote:
>
> When the PID coefficients k_* are set via sysfs before the IPA
> algorithm is triggered then the coefficients would be overwritten after
> IPA throttle() is called. The old configuration values might be
> different than the new values estimated by the IPA internal algorithm.
>
> There might be a time delay when this overwriting happens. It
> depends on the thermal zone temperature value. The temperature value
> needs to cross the first trip point value then IPA algorithms start
> operating. Although, the PID coefficients setup time should not be
> affected or linked to any later operating phase and values must not be
> overwritten.
>
> This patch initializes params->sustainable_power when the governor
> binds to thermal zone to avoid overwriting k_*. The basic function won't
> be affected, as the k_* still can be estimated if the sustainable_power
> is modified.
>
> Signed-off-by: Di Shen <di.shen@unisoc.com>
> ---
>  drivers/thermal/gov_power_allocator.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_=
power_allocator.c
> index 81e061f183ad..1b17dc4c219c 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -711,6 +711,8 @@ static int power_allocator_bind(struct thermal_zone_d=
evice *tz)
>
>         if (!tz->tzp->sustainable_power)
>                 dev_warn(&tz->device, "power_allocator: sustainable_power=
 will be estimated\n");
> +       else
> +               params->sustainable_power =3D tz->tzp->sustainable_power;
>
>         estimate_pid_constants(tz, tz->tzp->sustainable_power,
>                                params->trip_switch_on,
> --
> 2.17.1
>

Any comments on patchv2?
Looking forward to hearing from you. Thanks!

Best regards,
Di


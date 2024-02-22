Return-Path: <linux-kernel+bounces-77268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29272860361
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 366FCB35BEF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5134254916;
	Thu, 22 Feb 2024 19:37:58 +0000 (UTC)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAC914B804;
	Thu, 22 Feb 2024 19:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708630677; cv=none; b=QNWtSDC6CWxK87rtD9QxmmLBYvp8aRLNV4NQ6y/nqrR6x9O7rUCfdRqV4wtN6LAMVUfD6nXlQRcHYQwe64SoR6wi1Ir/qUVlYiI6q09M3nXUgQ4ebizeJZQNlkb8352q8ON7cNG3DmSBke2W1IzJ8gaal1Mi2OBM368rnhAK8Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708630677; c=relaxed/simple;
	bh=4JFm9swK0Kp+Y6jdMpsTtmgtxGmlE3FVVzMA0Dy5MeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CGPn5seYNvjAbthS6NTefFhkD8txSxOSb2rj5gok1zSUlsRTC13IDgku9HBJSzYaOAz3HYRKTz5HbDb1sJYPOMYEIXCB4TzubnZQV3+d/y/ZuPXINiOPeAny+t/orpJzeNENZETqL0FMQ1bnV2Wo5Y59DxXPIvP+NKYR6p6ikK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6e478633898so1651a34.0;
        Thu, 22 Feb 2024 11:37:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708630675; x=1709235475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YtLL7LMrvNx10Wec9PTcEO6oGF+McJRBbtmHJiJ1Hbc=;
        b=LJ3ZRu4cv6e8U8b5CGhWRyANMeBjTui2jJ1Rs/fhN94RSCYtNZtcJjM2c/VvIm/gnf
         AGi47CFTSWRpxirO1CeEN7keZCVUNEfca4Mi/xKPxp0lws1szL1vHCQOKjg3GRpJGpOL
         zcRI5Y+rCt3/uagFy0ZR7nn/Vc8ExDYc+4qbJBfnL9S1ChrrFD9j8oN3W3UFM2q+COLX
         ZkJ1Bhdc144xeBVicA8CjAiNgEAMFIcfEgRKxYCnc8sdcZV3Rn8k0UVJnHnJljBC1+da
         f7/mOmMUK4zBISa56J0uV1d/eeihJgej7iofN/gP/p+CewS5ZYCIj8dMyxO33lT9wGfy
         Tj+A==
X-Forwarded-Encrypted: i=1; AJvYcCUw9w29srCeSjnv6bG4hJ5Wjuh74S050+tYKwV6GpeozRauAF10y1ow6qU/bQ2/pWKE06JSng1EmEoLlLXauDjhsRb+AyWoi6/NOx/jrBoWlQarZ3VFYX7Z1OGsl3oG5uDp15rQ7y/Zkjm6DY/qJNImskwgNUUOi0KCVBR6xF4h3NKZp40UFJlv6w==
X-Gm-Message-State: AOJu0YyWtps9NSwodqwIsFKJLS8fCN7ZIAvaZtpe8wDIEKjwNIk7KS9N
	/kLYAxL/qCWwO0RE6jP4/LduLerxnhvlpHnwDCfpvp7CekkZImBh9DbO6wcH/bBEJJBrKq7Qf02
	1YcRqj6+BClW5zx/rPkqz+C5ooqc=
X-Google-Smtp-Source: AGHT+IGo9DqY4ELoLECSTdsNGuvPaRGD9qYDu0LEYn6qpSykDcaHrrTojdp9YkBDDdpq1XmmOVrH5P2Imnkix64rZoI=
X-Received: by 2002:a4a:c3cb:0:b0:5a0:3d13:a45a with SMTP id
 e11-20020a4ac3cb000000b005a03d13a45amr714811ooq.0.1708630675573; Thu, 22 Feb
 2024 11:37:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222105723.3810303-1-colin.i.king@gmail.com>
In-Reply-To: <20240222105723.3810303-1-colin.i.king@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 22 Feb 2024 20:37:44 +0100
Message-ID: <CAJZ5v0gPg4XwLNC2fEb8j9iDgCrZXQ8cFbru581467BYgX4jXw@mail.gmail.com>
Subject: Re: [PATCH][next][V2] ACPI: thermal_lib: Initialize temp_decik to zero
To: Colin Ian King <colin.i.king@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, 
	linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 11:57=E2=80=AFAM Colin Ian King <colin.i.king@gmail=
com> wrote:
>
> Static analysis with clang scan build is warning that uninitialized
> data is being passed into various functions. Stop these warnings by
> initializing temp_decik to zero.
>
> Cleans up clang scan warnings in lines 106, 125, 146 and 164 such as:
> drivers/acpi/thermal_lib.c:106:9: warning: 2nd function call argument
> is an uninitialized value [core.CallAndMessage]
>
> Kudos to Dan Carpenter for the deeper analysis of this issue.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>
> V2: just set temp_decik to 0
>
> ---
>  drivers/acpi/thermal_lib.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/thermal_lib.c b/drivers/acpi/thermal_lib.c
> index 4e0519ca9739..6214d6ebe1fa 100644
> --- a/drivers/acpi/thermal_lib.c
> +++ b/drivers/acpi/thermal_lib.c
> @@ -100,7 +100,7 @@ static int thermal_temp(int error, int temp_decik, in=
t *ret_temp)
>   */
>  int thermal_acpi_active_trip_temp(struct acpi_device *adev, int id, int =
*ret_temp)
>  {
> -       int temp_decik;
> +       int temp_decik =3D 0;
>         int ret =3D acpi_active_trip_temp(adev, id, &temp_decik);
>
>         return thermal_temp(ret, temp_decik, ret_temp);
> @@ -119,7 +119,7 @@ EXPORT_SYMBOL_GPL(thermal_acpi_active_trip_temp);
>   */
>  int thermal_acpi_passive_trip_temp(struct acpi_device *adev, int *ret_te=
mp)
>  {
> -       int temp_decik;
> +       int temp_decik =3D 0;
>         int ret =3D acpi_passive_trip_temp(adev, &temp_decik);
>
>         return thermal_temp(ret, temp_decik, ret_temp);
> @@ -139,7 +139,7 @@ EXPORT_SYMBOL_GPL(thermal_acpi_passive_trip_temp);
>   */
>  int thermal_acpi_hot_trip_temp(struct acpi_device *adev, int *ret_temp)
>  {
> -       int temp_decik;
> +       int temp_decik =3D 0;
>         int ret =3D acpi_hot_trip_temp(adev, &temp_decik);
>
>         return thermal_temp(ret, temp_decik, ret_temp);
> @@ -158,7 +158,7 @@ EXPORT_SYMBOL_GPL(thermal_acpi_hot_trip_temp);
>   */
>  int thermal_acpi_critical_trip_temp(struct acpi_device *adev, int *ret_t=
emp)
>  {
> -       int temp_decik;
> +       int temp_decik =3D 0;
>         int ret =3D acpi_critical_trip_temp(adev, &temp_decik);
>
>         return thermal_temp(ret, temp_decik, ret_temp);
> --

Applied as 6.9 material, thanks!


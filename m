Return-Path: <linux-kernel+bounces-68728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26260857F17
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B3D2B23201
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF75E12C804;
	Fri, 16 Feb 2024 14:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GKEEbkK9"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9466959B5F
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 14:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708093032; cv=none; b=XnTTl8cmXIh36oKc/nZI6DBo/KIfSkFwBwU3Lc4YCRFkReBN4iVju7KNSKAJKad9bGUFK1YapV6dDp9+9mjTnJJXDqTGT8hemN71fs4HpxvVve7MZKUHMLC1w0UVBqIZyLsshmgws4c4iTRmXLy+36M48hYfZCkOuob5XBmigko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708093032; c=relaxed/simple;
	bh=bJjqYOrayUg7LNhDqnmCX5b3NZMQbmqnheL2GePnQVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UMXQFqM7wD5hEKMwzg/sMqbNqeJxge1h4FL0fgTDUvrwuFdpZJSquSVfciBwKIOo0VYuH4mLDfliCm7DyqzHiDQOgGmIfXlf8+LZ5gZCCiaf6Mwf7pU71hYbmoDMJGZLcAhyJ8bQHL1N0sHuoJrH19FnwPcB6vwxPr4m9UnbdWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GKEEbkK9; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-59a1a03d09aso668171eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 06:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708093029; x=1708697829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=djeJQZRTsyJDHei5/nJ3LWgazT5GXbZBqY715lqq+eA=;
        b=GKEEbkK9VwWv4Cw04ld3yLtojVgPxGp3ufhSeSnuDu5/MOI/QTe+X2A2j6yjtEqqIO
         rumrHYVPxRbgWaKzXDom06RflNgd0PkwWKupb+e19TZnF+ceCdb/Cd1VbV7P/3jKZWO6
         KNP5Z2YJWPlCXIx5c+6baatBwspml1drdRYlT7dnzTFftVKdIM9pSNyiI4011fHlCEyf
         rR93fNwd9iyLU6xSGZM+0rZrnbc3GTSGSpnY+qn2l1aD8agE6CCUq/3Pp0YxU9MwgdBY
         aEK4pBXu3YGzqjL8HuCaH1qkA8F8DBgimsG9dsdjziH/u/Z+0f6aqzps20W55WTF7hru
         TTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708093029; x=1708697829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=djeJQZRTsyJDHei5/nJ3LWgazT5GXbZBqY715lqq+eA=;
        b=O4Px7Q4xo51BizQzzJ6J5Wg5yux5RjRk/EkTqlIFjr9kMy3beQL+zbdDtnQ/xgHSlT
         fKelGwh/peyxzxnP5SRLpgNkvKaYMohrJIl+FfvrjEP6nKWSth2+J6gj32J2XL/N1gZI
         KThFDA3NAuc7ubzRbF0DzAkMO4tvfOAkseeag4r80bfZT34s7Z5BeiUxAR2aHvW0+2cF
         GH24BaFKuyWveubrBpzwHQc7AWs4GO1fWwHDyUWRmijnYgpU0qrU2+5HbytIq4fp6935
         MyEW0r8YgccTHX99ea4UYW/Wq6HlO+91h3p7qReHyBAMIX9URf1Y28M91+mbI9gkyYTA
         fBoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjzsChH4bVZeKIohiTThnkjsw6E8ijKy/wJ/7ZMaa+2Kng8ScSAxSLgJQCm8p8ymUo09wIOrXPAZdaoC0cRWKf17iZxPhxRf8yWMVo
X-Gm-Message-State: AOJu0YwAlgxJoEd7aHA3oX0XJ2Yys+NXy1pnNTzFxmvYb+2ikL+pnQlt
	MRe19yDzsoLyMOw5Vf/ijpyQOZ0rLKrNslH3NVgKKpMP/oSQrO31KkiBWRPOxXzsksU9c+wthKR
	X8OGAdnfd61KPGUbbufhew3ekpdRtTq57NArJIECnkhby19Ee
X-Google-Smtp-Source: AGHT+IG5rb+LvzU0RvTj89Jq3rz4xnJ8fRrqfTnrTzCdcn76AuQt0Vyy4ut1QmKC50qc87StmUUWbgGuMAgaavlltoo=
X-Received: by 2002:a4a:2b52:0:b0:59c:e5c8:bdc5 with SMTP id
 y18-20020a4a2b52000000b0059ce5c8bdc5mr4819721ooe.3.1708093029592; Fri, 16 Feb
 2024 06:17:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213-bus_cleanup-tee-v1-1-77945ae1a172@marliere.net>
In-Reply-To: <20240213-bus_cleanup-tee-v1-1-77945ae1a172@marliere.net>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Fri, 16 Feb 2024 15:16:58 +0100
Message-ID: <CAHUa44H++H2GitFCqEEv6xmYrHyhFDrM-GFogO1VZjs3LGRN+A@mail.gmail.com>
Subject: Re: [PATCH] tee: make tee_bus_type const
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Sumit Garg <sumit.garg@linaro.org>, op-tee@lists.trustedfirmware.org, 
	linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 3:45=E2=80=AFPM Ricardo B. Marliere
<ricardo@marliere.net> wrote:
>
> Since commit d492cc2573a0 ("driver core: device.h: make struct
> bus_type a const *"), the driver core can properly handle constant
> struct bus_type, move the tee_bus_type variable to be a constant
> structure as well, placing it into read-only memory which can not be
> modified at runtime.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---
>  drivers/tee/tee_core.c  | 2 +-
>  include/linux/tee_drv.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

I'm picking up this.

Thanks,
Jens

>
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index 792d6fae4354..e59c20d74b36 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -1226,7 +1226,7 @@ static int tee_client_device_uevent(const struct de=
vice *dev,
>         return add_uevent_var(env, "MODALIAS=3Dtee:%pUb", dev_id);
>  }
>
> -struct bus_type tee_bus_type =3D {
> +const struct bus_type tee_bus_type =3D {
>         .name           =3D "tee",
>         .match          =3D tee_client_device_match,
>         .uevent         =3D tee_client_device_uevent,
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index 911ddf92dcee..71632e3c5f18 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -482,7 +482,7 @@ static inline bool tee_param_is_memref(struct tee_par=
am *param)
>         }
>  }
>
> -extern struct bus_type tee_bus_type;
> +extern const struct bus_type tee_bus_type;
>
>  /**
>   * struct tee_client_device - tee based device
>
> ---
> base-commit: 716f4aaa7b48a55c73d632d0657b35342b1fefd7
> change-id: 20240213-bus_cleanup-tee-c25729bbcd7f
>
> Best regards,
> --
> Ricardo B. Marliere <ricardo@marliere.net>
>


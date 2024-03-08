Return-Path: <linux-kernel+bounces-96749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FE98760FB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6F351C21C7E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC568535A3;
	Fri,  8 Mar 2024 09:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="DvJMlbwW"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C9952F89
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 09:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709890390; cv=none; b=mib5JnX2HdzjbnCQsx/kLQWzL583MSlHuwzABbRVXYIN6qRow0tukSgg/f2Lz2r16zBefnzm7DjxRuzONMdawzNGBl8myIiX/cIWoBKU8BupczNltRpT25+5Mnun+bCAzRKRFXNfgHU3bV1keG7CcbIt/FAcn55k6dlS6Pe1J/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709890390; c=relaxed/simple;
	bh=G5c+9IWvn6ieMhvBUbYIVPZPnNSgCyJnNf7/vpLBkgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gFcYAutUthD4R6pggnK2JKHoo26FBrrhE8tqJYIZhmUf4Ck1D04ZTkTn/IaTRLQ3z4kupSBLOtL7zuvGMipWJ11658IuWTxQDysG+vT/LxpzLOP2/4nGIVxv9CU1oWjR8GDtGr040BOrFUrw0HJXGeZpKcMZPjazfckZO0j27lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=DvJMlbwW; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4d367dadd14so430112e0c.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 01:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1709890386; x=1710495186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uSPL9R4NEdEb5t9F1k6HdAHD+VzckhslVdvrEVAW9tM=;
        b=DvJMlbwWcoCxcE5wlsunzqOQ0UG23+cOrtow8JR1rNug5SpaI1OJvkMy30DUxvDc+w
         1FmU++KsWw614yvYwD5Uof8NG0jm+MhvD/i3M9T2BqJMIj4IDRc8RLo9HAKf4gwvCw34
         StBZmh4WfMUXF87/oZDrXPL3QjzcpmYsmea0hs6ssGo6s9z1aZtV5MCjIMpTgaPhEIFa
         BmZScbL93bA5opMhUeu4HJCHNyvYu4SKrX5vZJ4zQFpKU2v0nvcSMM1S+nnmPVQrNBOd
         ybTkUfGS2P8QtpHJU3sTxEcgHgj2FfzL6khJ4dQfulLgr3uoJi9rj/SMWap/dHV7o36M
         TDUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709890386; x=1710495186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uSPL9R4NEdEb5t9F1k6HdAHD+VzckhslVdvrEVAW9tM=;
        b=Ma6ISBR91ehpSG+lJ02pQlWr3ZqYI5aRAL8R/tTZ9CprnAFTw3Ux+R6CaEQ2w0iGbA
         qX1fIsrfyrN90ycUhnATKK+jijKNsefCBWiM+h7bFYIoymKQP2+XGeQJiG90/RlkDCg+
         ZoaNlCyxOrEsnHNtuQ1jounJerWriTy2Yt72sH58a4aZWM3ozlbzq6od41Z8454J6u51
         owJnOFw2sR25Wb+g4uWzZQH8u89cbocerXo3HwTFMdHVF9vJhgLrwBSLsy586eu1aVM2
         wM8Jt8sexrrmhJSiO/8dfid+DRLH0kzDAs7lYBBKQ65XOKYAjvPIJW53duy6qI/1ppWm
         v6cA==
X-Forwarded-Encrypted: i=1; AJvYcCXld/gS5Eq1ZPh86rdsxPqM/rzfyHq41XRv+ZTwsDcMoQIg8KHnpp9TFiPedEPznGsdfrEJx+1aw/SlzLYywjjGZSHI8AWHV5KlNaG8
X-Gm-Message-State: AOJu0YzyBlGEjdEBv9+UMItAgLyLoot7Hp2LADoUl1VMpQ4x6JFz2lHG
	UMTk31nQpuEEd/vnxBMe/D+Dg286HVkB7pYYmQ+u++yuvVyAiAVyA0uH21ye4blBC+uFjFdJbTo
	eWlpjQ4sieiq5sfS1MTCVrW2qPpgAi8oTvGNrClpgp/wCqvc8F2Y=
X-Google-Smtp-Source: AGHT+IG+yjLhhIesv+RIZF76RV01Z9AqyXG3WzamQmnvFMO5iJ0EoNbH/PSfpWD7+rmgh9gTocQJiEzC3Ty++qgckBM=
X-Received: by 2002:a1f:1402:0:b0:4d3:3974:657a with SMTP id
 2-20020a1f1402000000b004d33974657amr9398254vku.14.1709890385847; Fri, 08 Mar
 2024 01:33:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307214317.2914835-1-alexander.sverdlin@gmail.com>
In-Reply-To: <20240307214317.2914835-1-alexander.sverdlin@gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 8 Mar 2024 10:32:54 +0100
Message-ID: <CAMRc=Me8J0fd066QaSmDhhc+g54A8m-dWTDmtx14HOPc+d0TYA@mail.gmail.com>
Subject: Re: [PATCH] gpio: sysfs: repair export returning -EPERM on 1st attempt
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: linux-gpio@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 10:43=E2=80=AFPM Alexander Sverdlin
<alexander.sverdlin@gmail.com> wrote:
>
> It would make sense to return -EPERM if the bit was already set (already
> used), not if it was cleared. Before this fix pins can only be exported o=
n
> the 2nd attempt:
>
> $ echo 522 > /sys/class/gpio/export
> sh: write error: Operation not permitted
> $ echo 522 > /sys/class/gpio/export
>
> Fixes: 35b545332b80 ("gpio: remove gpio_lock")
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> ---
>  drivers/gpio/gpiolib-sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
> index 67fc09a57f26..6853ecd98bcb 100644
> --- a/drivers/gpio/gpiolib-sysfs.c
> +++ b/drivers/gpio/gpiolib-sysfs.c
> @@ -593,7 +593,7 @@ int gpiod_export(struct gpio_desc *desc, bool directi=
on_may_change)
>         if (!guard.gc)
>                 return -ENODEV;
>
> -       if (!test_and_set_bit(FLAG_EXPORT, &desc->flags))
> +       if (test_and_set_bit(FLAG_EXPORT, &desc->flags))
>                 return -EPERM;
>
>         gdev =3D desc->gdev;
> --
> 2.43.2
>

That's of course correct. Applied.

Bart


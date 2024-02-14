Return-Path: <linux-kernel+bounces-64966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E46285453D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59D5828F933
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05611643A;
	Wed, 14 Feb 2024 09:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="T0EctImZ"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6802912E6C
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 09:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707902979; cv=none; b=fF0ECYA5j2V/zBryESdNCsMUgclTEKmIhRy+MfAOJLTgfPSaq8UGG9dwl26SmExhrcf3fXNCeGJSxTI1gvwi2LpO5zI8hzE0WRQ/76PKnavnD1GqcUVR+5IDz/csau1ZWJ8m6LV9H+xZRfmMvkxr8EBKpuKgzqQgb9uUik1ZwTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707902979; c=relaxed/simple;
	bh=QGJGbBcSxuCx9Avf+9BT92M2uOkRt65tIyJgEDued6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WVcudLcHSCRAeWj4vnKGQnYOTrVLi94DZPLAmFcO7tNd87yd7xaBaaUgwKPy4h7D03Go5S7hvT8J1osUqTV51DylVD6f1CLc9g86Go4W6mB6vfNmIhAHrTrFacoIA58NGd5uREzXnjWi2aaEPpXY0GWg9LWgXRO3smann4b/d6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=T0EctImZ; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4c03beb85f4so1474816e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 01:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707902975; x=1708507775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4NTlOSe5fjimviBpJdsalrhomrdPQE7oNI7Qj6Alw1M=;
        b=T0EctImZYwp0q3bNcDuI/KHQXguCPWhQPhBEeNS/Y9BGb6Gp+aQCIMaE6Pj/JADY50
         v4xxAiydJaGS20EQkjXt4c6NYdOEVMDMY+0AACTnbSgiCke7pbhmVz74oHowlMaqWVIq
         2T+CWhG9nTDTQhw59tB7YBTOGSv0pGmw52NgVWVWzyA6TP4mERn5OUeo20krThvmmo1h
         cP0/iN4SR+6a4b99EC7SDvsPE1eE/tE/oL/EcFpF/eIDbY6U3GhIt9+5EVO5X8B2cHLp
         Y4WEH67iirem+BIucQ7fru3vIkEQ51Ghm1I1n/odNCJvWAfopng72fJyXMUnauxhJ4ro
         zTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707902975; x=1708507775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4NTlOSe5fjimviBpJdsalrhomrdPQE7oNI7Qj6Alw1M=;
        b=CbS7FHd8ll1kyyV6UMCn1rAbX7jK/HU1oo82C/YVxklXC8tnZeh7xmryCuss92jdCt
         UorkREABzs5dACzizmK3ajA4rMbjHw/BOiJe60cr4Z71k1T91SUGfpbyNC+z/hPWiPWj
         FTAIish77KR/GzFG/PU864XM2JU93Zrz0Q7ur0H1sG5spD29fOD1fKbgCXDBYMoAwZre
         kqW7Fd5i3fOP3EBujmotRKSuW7H8cYjMAKHj/dpsMLeAcKJYsp7AYHqEIjhM4FYC28rB
         dZcZIObPdMBYRBDdF0mlzlvSyHW1eXaIwYAMgTfeUVTbokM0QyEsoHeuNQUwLqtqCimo
         0sVw==
X-Gm-Message-State: AOJu0YzWIE1dsUtgJ+YGSlpKhWzlPdwCFxa/uA4PZHsuWUlIBsOLj1eb
	16csnRKK3raniSY1svGpLvQq4Md3H7xoXw0nvbTnSCN/57fogt5zVSrYznETpl8QjsiQcWU8w/i
	p92glzlqoUbb6ieV//Ye9/Bxq6rdIvh8MzBx9vA==
X-Google-Smtp-Source: AGHT+IH2j8d++4e+u1mW346Mzu8bIt7wE9r3caRvalw9/NdZqNB/8dU8pyZv7IJ5KcYwAbcnPABW8sixlqBXfX1Jc1I=
X-Received: by 2002:a1f:c787:0:b0:4c0:292d:193d with SMTP id
 x129-20020a1fc787000000b004c0292d193dmr2079166vkf.12.1707902975308; Wed, 14
 Feb 2024 01:29:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212093420.381575-1-warthog618@gmail.com>
In-Reply-To: <20240212093420.381575-1-warthog618@gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 14 Feb 2024 10:29:24 +0100
Message-ID: <CAMRc=MfwCQYuouRfU7i2C-YKi64_pTCRCs7jj6evBefj7=Pbog@mail.gmail.com>
Subject: Re: [PATCH] Documentation: gpio: clarify sysfs line values are logical
To: Kent Gibson <warthog618@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-doc@vger.kernel.org, linus.walleij@linaro.org, andy@kernel.org, 
	corbet@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 10:34=E2=80=AFAM Kent Gibson <warthog618@gmail.com>=
 wrote:
>
> Clarify that line values are logical, not physical, by replacing high/low
> terminology with active/inactive.
>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
> ---
>  Documentation/userspace-api/gpio/sysfs.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/userspace-api/gpio/sysfs.rst b/Documentation/u=
serspace-api/gpio/sysfs.rst
> index e12037a0f2b4..116921048b18 100644
> --- a/Documentation/userspace-api/gpio/sysfs.rst
> +++ b/Documentation/userspace-api/gpio/sysfs.rst
> @@ -87,9 +87,9 @@ and have the following read/write attributes:
>                 allow userspace to reconfigure this GPIO's direction.
>
>         "value" ...
> -               reads as either 0 (low) or 1 (high). If the GPIO
> +               reads as either 0 (inactive) or 1 (active). If the GPIO
>                 is configured as an output, this value may be written;
> -               any nonzero value is treated as high.
> +               any nonzero value is treated as active.
>
>                 If the pin can be configured as interrupt-generating inte=
rrupt
>                 and if it has been configured to generate interrupts (see=
 the
> --
> 2.39.2
>

Applied, thanks!

Bart


Return-Path: <linux-kernel+bounces-72927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 591FC85BACF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D9491C22333
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED4367735;
	Tue, 20 Feb 2024 11:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="zqE1ULDu"
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE8667C56
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 11:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708429336; cv=none; b=oy8DL1mLsAI5/zF2Z+XUjH920ummMS1IoNlILHPyOGbMP5khFSSTSfdkCz1Og2XcKfzTNs+Hk61PFvro7CEvnChK2LKfTITa8r08/z7Qyila+ETYw35MJcfkdW5zp1/noELVRiJVNv+R9gSyJVE4LKvdCadGZ2EBJU3IVkIhfCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708429336; c=relaxed/simple;
	bh=ouR2+vSQw/fSXVao+thlbu3IjNZ33JoflBcFWY3O8Jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DhwXZAjwmsyZNyyk+PLkx0JMO0SFLsEmnYNwJjSbKt3rpf6dlO13M8eC271OkJrtbObUEUphKaXLN8IOTpskYxdfCB5njyMj+owr1BvQNA1Qf5VCZYZj730PP4kColzNURuY1fjrt8iwvqvMSF0ImG0lpXOqUBaMIyGDNk5PKiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=zqE1ULDu; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4c857f1c18cso491237e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 03:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708429333; x=1709034133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AsA1IuJ1QgZr3RxDT4dHm54eEdxgfhuTT8X+jj/Chbk=;
        b=zqE1ULDuEYEjsylSbBQU4zhm/yArJK978TWf3jKkxUIiwW5XiToMdRgkqF5hQseidX
         X3CR8GsFEQ0TGEjFOcy8zD+YZiCuWlMueyKy+fSwE+bewsc1p3J6GFl3HbOgxtaOP873
         gXZqAp31rH8PhkH3STA+0P4iXoV4VTXjxzYmC+K02khLFBWjxqqIJX9rL7hYB7ly4TE9
         hrdFwL016oeDPcfNTSr162fURpO7aevF6oQCcLhfGy6K308RegpC1lEDxoVLdCnKbjUc
         C4HJnNTTFouXjmOBbp13A7XO4aTETwMbgGooBruF+9+TNDE3AfLLcroXBSEUHuPntSiL
         rIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708429333; x=1709034133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AsA1IuJ1QgZr3RxDT4dHm54eEdxgfhuTT8X+jj/Chbk=;
        b=qbwWCyh68/arRJoPmq78Q4gWLayLeHT4RUd0S7t9Tvz36G3xcAUPWK6mMe0PRgzeyD
         /odzA4dsoTkCeOi+wa594TFMfIf3U6dohVYGVkdQ98aQx3vdpqF/sBlxE35TON32dkxW
         ZJGEF0kgEhK5V2zzeuGQ5qNxPYy0+2pCKxJ16wePMNEZF6BkivN5SvRQeROLwVi/zP9s
         sOmWuOdxqFn+I72SlDrKf8fec1aE9RQjoXXkKvO8G/BoePL6CuU0A6eDYzrA7LZC0U9N
         /bweVe1CxFY/iVGJICMCcp/COl/kNmOLYenR97l2Bc1lfk+NirxST2G0duKyvAHqp9VE
         QoeA==
X-Gm-Message-State: AOJu0YwUwx+F05ak3QxAniWH9OC2NqOYA7D0HzgW8B6ctg8aAG+aKSTa
	F376nzFOObFJfp5GU8fD2X1GIMSOedLoEfXKX1mkZSaxG6q/wWH8AWevtb8JYvMqet9YKT3+Ivf
	m9NSWOYzrCd5D9hUZRrBlbk4vzEbJSOM/2+qNyQ==
X-Google-Smtp-Source: AGHT+IHcllRQy0QvMPlfXyC0j4mq7HZDSa6oNk423QQzmnQONpsBgUoG4iBcidN29kecafPXzp6gdVs8vJxKCKzoCyQ=
X-Received: by 2002:a1f:4b07:0:b0:4c0:2182:3cdc with SMTP id
 y7-20020a1f4b07000000b004c021823cdcmr11701946vka.1.1708429333138; Tue, 20 Feb
 2024 03:42:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213160522.37940-1-lincoln.wallace@canonical.com>
In-Reply-To: <20240213160522.37940-1-lincoln.wallace@canonical.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 20 Feb 2024 12:42:02 +0100
Message-ID: <CAMRc=MdoUuOLTYHu99+c_AVhnDZ5LkKHkYJ0D681fcJV_aW2Ng@mail.gmail.com>
Subject: Re: [PATCH] Documentation: gpio: Add a note on the deprecated GPIO
 Testing Driver
To: lincoln.wallace@canonical.com
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, corbet@lwn.net, linus.walleij@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 5:05=E2=80=AFPM <lincoln.wallace@canonical.com> wro=
te:
>
> From: Lincoln Wallace <lincoln.wallace@canonical.com>
>
> A deprecation note was added on gpio-mockup Kconfig since v6.7,
> update the documentation to inform users.
>
> Signed-off-by: Lincoln Wallace <lincoln.wallace@canonical.com>
> ---
>  Documentation/admin-guide/gpio/gpio-mockup.rst | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/admin-guide/gpio/gpio-mockup.rst b/Documentati=
on/admin-guide/gpio/gpio-mockup.rst
> index 493071da1738..a6424de925da 100644
> --- a/Documentation/admin-guide/gpio/gpio-mockup.rst
> +++ b/Documentation/admin-guide/gpio/gpio-mockup.rst
> @@ -3,6 +3,11 @@
>  GPIO Testing Driver
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> +.. note::
> +    Since kernel version 6.7, this method is being deprecated. Prefer us=
ing
> +    Documentation/admin-guide/gpio/gpio-sim.rst instead for kernel versi=
ons
> +    newer than 5.17, which is when gpio-sim was added.
> +
>  The GPIO Testing Driver (gpio-mockup) provides a way to create simulated=
 GPIO
>  chips for testing purposes. The lines exposed by these chips can be acce=
ssed
>  using the standard GPIO character device interface as well as manipulate=
d
> --
> 2.40.1
>

We already have a note on that, thanks.

Bart


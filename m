Return-Path: <linux-kernel+bounces-76234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBA185F493
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB084B23A43
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BB138DE2;
	Thu, 22 Feb 2024 09:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="VPR+A+6Q"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD9517F3
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708594640; cv=none; b=HKiRCBYiXRXD3GTQ47p+S4CIN2bTy3g+7ELh9P4e9IPDBumqVuvYcTHGSLYIUnDym/qYSuuLDYysmtp/tdvbEEGsE7nbVjCVPjbwDcybWocXWUsfLQz72WAR5iGorUjoLQUZZi0XPdQHzwBx2fpp691rxnHyQzXt+6dUD/jJYPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708594640; c=relaxed/simple;
	bh=kzSzu/RcSexzlVeRs9J1KS6OrrTPEYBXbGM3xY/sRN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L3+0bwHK97js4H1sz2ncszxrFDsv2L3aa9H+1BmN0WFbl/MaYXlWSpDui90EZCRGCN+z/gvLQo/gedfpGIVFn9WHGDq9JnhAlz9ZnZ/U7dkA9zNKzlodNeY1o8Bp7o7gvcvp0Uapu8jf7eeLfXPWFI5FzdQWxSBBxdJd3b/AHWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=VPR+A+6Q; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7ce3c7566e0so3589243241.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 01:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708594637; x=1709199437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQfr6FY177uNwgDSiTCgNs2MWrRFTOh2RoQ+acf/7BA=;
        b=VPR+A+6QcK5EX37kjiNy7zw7vACzxQIlXTO6AbymjbDvIPB7zxh6sMPWdB+Zl1/z/V
         tD8XDMPCl4xHeyTPI9XsCgG2KKwq6zsUpli4ENz0ZQVfYhbXStvIIvDmdiwz737TUU/+
         YQ0tNWUZLjLodaf4FLv/2YN9zTuUr/gjJKq0XOL9XCZapg7G/rm8+ekfpmTcp84qK8MG
         v+MZ1eLhDtiR472UeCaDuopqkRn6q1di4uS2jaCw8dYgzMH04iraQwyg7DW6jgEozzst
         N/o35cNMRGr3jLG1qw2H+PkqGkARM9yNSm+NjARM/bJ9SaRfeW4hepW6SHJr+fku8Ks2
         RcMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708594637; x=1709199437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQfr6FY177uNwgDSiTCgNs2MWrRFTOh2RoQ+acf/7BA=;
        b=cV12N+Z7WZDYwUx8PY8ByrPJjlrrZST4uZLzdGoM6ZvhBPE2ctANVcJ618uDA/UUX8
         3P3Q4KFrKMV0qwioHquxPEZdDZ9ITl8Uj3eI1u2rVKIPUUz8xGVL2a7NHWIAf7cEKpRK
         BP4FQ+ogZfjEW9inYHkMXrGt959FdRqQwXYdpHtcLpHcLe/+GyAgpxZKprjPuF2lfOzE
         F8DshcWvZgnyXdKXJ/RKNvjmTYU4MjAn7QCJhVo5vtlvL6q90cL8LBADJARO7RlYiuAD
         BuplH9qoBjD4a15GjktJ1ESCG/pIFqN1UAUcXMVaTuqsQ2H8i/hK5HtGKliy2n6eRFb8
         PIWg==
X-Forwarded-Encrypted: i=1; AJvYcCVJcyQVF9bV18TA1jfobTAOkoRZV1ZK0hswSz8ZEKIa/hXTUEEgPMq/oTDlCANQV+XSxNauFKllXJizHARROfsYlcp+moXc9XBxJ5VD
X-Gm-Message-State: AOJu0YwMTMQd9oN7MW2WJBAprbyVHOouz/MQiFVIzU1KYCBosuOaB0Bx
	zvehNxmbIZO3tjeZVesoB7iqmBKX8La6eAz2WcZyY4Ib0gRjmwpkcQ5pHwBXtIbT/ZAgSe+h67M
	sqe2J8tYVjB6vJUgsSJGmloa0Lf9Nq0j/Kj90GSgZphdJVYWJzBQ=
X-Google-Smtp-Source: AGHT+IHYn2KTIqkRKbqjMlh4zgoi2O9q+wG5HiPZ00t5Nm8D4lCnwl5JADbF+QrEiKd+DIbXsmzlmjJJtpIroYTmJn8=
X-Received: by 2002:a05:6102:418f:b0:470:712a:c289 with SMTP id
 cd15-20020a056102418f00b00470712ac289mr8379533vsb.24.1708594637488; Thu, 22
 Feb 2024 01:37:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221192846.4156888-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240221192846.4156888-1-andriy.shevchenko@linux.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 22 Feb 2024 10:37:06 +0100
Message-ID: <CAMRc=MdvYdx6x=gSiOZ3SXAdJORnqhsNW79G2c7wABofWARwFw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: Fix the error path order in gpiochip_add_data_with_key()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 8:28=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> After shuffling the code, error path wasn't updated correctly.
> Fix it here.
>
> Fixes: ba5c5effe02c ("gpio: initialize descriptor SRCU structure before a=
dding OF-based chips")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpiolib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 4b4812bbcafd..1706edb3ee3f 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -1056,6 +1056,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc=
, void *data,
>         gpiochip_irqchip_free_valid_mask(gc);
>  err_remove_acpi_chip:
>         acpi_gpiochip_remove(gc);
> +       gpiochip_remove_pin_ranges(gc);
>  err_remove_of_chip:
>         gpiochip_free_hogs(gc);

This undoes machine_gpiochip_add() and I think it also needs to be
moved before acpi_gpiochip_remove().

Bart

>         of_gpiochip_remove(gc);
> @@ -1063,7 +1064,6 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc=
, void *data,
>         for (i =3D 0; i < gdev->ngpio; i++)
>                 cleanup_srcu_struct(&gdev->descs[i].srcu);
>  err_free_gpiochip_mask:
> -       gpiochip_remove_pin_ranges(gc);
>         gpiochip_free_valid_mask(gc);
>  err_cleanup_gdev_srcu:
>         cleanup_srcu_struct(&gdev->srcu);
> --
> 2.43.0.rc1.1.gbec44491f096
>


Return-Path: <linux-kernel+bounces-131660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A135898A82
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A42F0B262AD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CDC1D539;
	Thu,  4 Apr 2024 14:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="EZWFKZz9"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D02D1C290
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 14:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712242623; cv=none; b=hcCy3ZnD61DDwLMU9L/iF8vzBDo1T7zXEbiJ+hhZgEUS9QA7TivhaaOzkmuGhE5zPMS6WPUz2odn7Sz4xqd9C2AFWlG8bE1XOMeq/Fj4AyWHVY3O5R5RboNKg1WwOOcqQfWLqjehtvmZfs//y/qBABtkX0nTxUDPB/Hd9K5rSJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712242623; c=relaxed/simple;
	bh=IaFoOl62tcCF59UV0efY1h+CjVTA1CJAzdIeBir6ok4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sUuE0QE3cxPIGWWenm3BJggh7P8oGvA8Ro6WZd+sV2CYGwpQq1J005Ojqi91iSKPS0nCrTdVAZYtXSIvlndi/S3JtTXnIaU7NKnO+1KL9nvMnvwp/2nUXMV2dMXOIjpY3UCVc+scJEJLmgKSmy9l9A0Lp17Mx1uGK9KWFaFfFCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=EZWFKZz9; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-516d0c004b1so588701e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 07:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1712242619; x=1712847419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JubjZrC2lioP3RyL0Ciyw/lhrZMZfq1yICuaTDklK7g=;
        b=EZWFKZz9RaX+148XZhWYsTgLQGwdwBNK2VrEsmAVYD0ariqC6TUDJt/5DVda2RuLQV
         TTLscQ5C6nbhsjhYJNyyxYQg37yETs8EERx40byG+/y94TqxKEJfEKcjhMyMaT7hC1uU
         vs+wO91bVAGGkf7PgCUrdsg8ShpLTY4ij/+pX2sKIi3KsJCbmS6rmMPOiS3s8rmWboRT
         9mVrcvq8+O+k9nDWPgHOdDEHDvam9u8xxBTqtWirvSQMEnQ9rphkvggpG9alFDcjysy5
         4f8OQY02+oCziX2X+NtJ4599YAlj2rzjSSOoZFI39Oh4um+rWwpHPMQ91H7c8z3pH/qF
         tCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712242619; x=1712847419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JubjZrC2lioP3RyL0Ciyw/lhrZMZfq1yICuaTDklK7g=;
        b=qOrXAg6/MJ0uiB5H4zwKks4kVgReb/D/v+82NbC0ltADnCx+nq7ovA94eTN0zgq5yz
         J1q47kVaMC8Ja6oo3OGsd7lRaFYAttS0z/E72B17X7gKF12f7k7uW6v4zKbwQz5IpDdj
         3RXL4Sp+mHvL/TrWX13opvWADL4NYOsphyl91PZtBQGfwTQ5FIg2ubYk0cMikNhs0I2D
         TPkwcm/plb+tA0OrLD5ZT/YoBpecIY8u3z2hx+5ZOtJW3PtKQKZQ0mLf5k56fY1leYcL
         9rfAyUYOgDUPNnRWCPC4A1qoDLLg5xYznhYwK7JXxcs6vEy4u1gj2BFXTM/hgEG4vyWb
         HXMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLjwfpSL9hMa2nzGpJb3finBHwgeljoFyIhBCBbIPETGk3WpQ3G++AaW9oXa1ZQpTk20wdHsPfOnXYLHt0vIA2o/3F0JLKh+V/frCv
X-Gm-Message-State: AOJu0YyLV705tOigNKr0KE1/qdEa1i78DGYzdkk9FBlcFsk5xvOiOFV3
	aSUGv8d6A/24jhkpBeF6FGBcQxXr7XwgB0Wp52MkKBvesuEVSRLLtXN+yKN9J8PazNvDuTRZX1J
	e2QhQtCm8oBH7MhoWblNjMJgq2qWM3eN4xJaauQ==
X-Google-Smtp-Source: AGHT+IHH4OT8Ur7GKEjdrBzx/LNXQv1C7wzvGwVZ3h903XGh0LKvc2+hvzRaH2rKu19cXIt3tkuK71uJt+nF7XhwY1A=
X-Received: by 2002:a05:6512:358a:b0:513:db34:7caf with SMTP id
 m10-20020a056512358a00b00513db347cafmr2178763lfr.17.1712242619402; Thu, 04
 Apr 2024 07:56:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404093328.21604-1-brgl@bgdev.pl>
In-Reply-To: <20240404093328.21604-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 4 Apr 2024 16:56:48 +0200
Message-ID: <CAMRc=MexL-XKiaCdPCs1uw5YoSMdwHSg6gV9fonsVCdb6R63UQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] gpio: cdev: label sanitization fixes
To: Kent Gibson <warthog618@gmail.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexey Dobriyan <adobriyan@gmail.com>, stable@vger.kernel.org, 
	Stefan Wahren <wahrenst@gmx.net>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 11:33=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> This series fixes a couple of bugs in the sanitization of labels
> being passed to irq.
>
> Patch 1 fixes the case where userspace provides empty labels.
>
> Patch 2 fixes a missed path in the sanitization changes that can result
> in memory corruption.
>
> v1 -> v2:
> - switched the order of the patches in order to avoid introducing buggy
>   code in one just to fix it in the second
>
> Bartosz Golaszewski (1):
>   gpio: cdev: check for NULL labels when sanitizing them for irqs
>
> Kent Gibson (1):
>   gpio: cdev: fix missed label sanitizing in debounce_setup()
>
>  drivers/gpio/gpiolib-cdev.c | 46 +++++++++++++++++++++++++------------
>  1 file changed, 31 insertions(+), 15 deletions(-)
>
> --
> 2.40.1
>

I'll go ahead and apply it as the culprit already got upstream and
into stable branches, so let's fix it ASAP. Tomorrow once autobuilders
confirm it's fine, I'll send it to Linus.

Bart


Return-Path: <linux-kernel+bounces-65240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF018549EA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90D6D1C26FE2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F9853373;
	Wed, 14 Feb 2024 13:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="k5S3FZMy"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FA4524CF
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 13:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707915686; cv=none; b=hovGfyMrJi+uvovUfpU7HSUYMV4KUvnF8iUIVmPFFj5OZhHeA8/11eAXeWvIXSOocg5z9oaXewKE0vCu/MSz2WMArBqC5JAIFWObOdHiCldTgL3ie+x3c1X+MGTb9LbfaHATThFGYmmQGFL7UyCQE+KXXxNhAd+dEjgoqshxbZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707915686; c=relaxed/simple;
	bh=fLVy1f7K0Kn0pdSgvUnQvwzHJ/wGtz6uPSJtJFm0hlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yfa/NmoaEHqWB+YfnIXECh9zkBrq9NuJxfK2ihcNe+yhbNmrSkjQyB7Grqn+fJF1VCSd/JBWfvbSGs/MeDbvMGeDrcRu11YqCgHVHl5i73wadpW/zEbn8xLUNJ5ydKJqOKM3Rw4ClVpWxqFyL3pSEkURmPzDZInuOS0MaS5ssxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=k5S3FZMy; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6818aa08a33so6979936d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 05:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707915684; x=1708520484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLVy1f7K0Kn0pdSgvUnQvwzHJ/wGtz6uPSJtJFm0hlI=;
        b=k5S3FZMyODaPutCg7kBDw56NG4IHWQrwX0Ic/stdpWuH6msMkSMRv82EhJoyTmQRIe
         kQAtITTWr0yH8Ib4h3kETB50s6OBqMmrwBTpJ0oTA2GqYo5ub6USpx2m2DQ5kvARNpyu
         sEjTasqW9FJhBBr9MfsltlIeTjkMGyn4Lf691MHqmEXYcM04gBVUBCr+Z4C1gfkgARlG
         UViJ+DXZ4RsAZG0yOaAbmaHutDEN58onAIxsmZOcw8MpBrTIfuHSPC0Pgh/f1jXDfV/e
         PotsuXMOZBSL6PVioVT5ZcjoiyvtrBqwU3WHAZZAODRcT1BVfNrryyOj7HJjbd+RqULQ
         Zqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707915684; x=1708520484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fLVy1f7K0Kn0pdSgvUnQvwzHJ/wGtz6uPSJtJFm0hlI=;
        b=lSqpp7op67hFLhb9IkugK0lkJzd53m95dAKq8d+kHY2G/VIJ+i4al2aoZU6kSSBTi7
         Z6pG3rOZ2l3F7/phOdJnyZ4HcwM1ZoY887A2vscU/bI8MF2ur8dYwvE20qP8VMFOBUAp
         Mj0mpnkUrkGN99l6ZCIv2NwzgSJJLgOeiP6PIN6weUB23Z4Oe4b5zK7yWAEqDpPgmkhE
         gq/HlAGSFg7mCgLc92hO1sqGt8YEP11uE57Pd136bbJI+wE4doBtjwJ/lKm2VJ7NIgcH
         y8L9tJ974nhTt0otwU7sE4TkvL72CMM90hUr64G9/VstpIIsNDqBHdEi8M0ayP1p3gig
         /IqA==
X-Forwarded-Encrypted: i=1; AJvYcCVlZzkgBLjsKDd6laRmFh4xA7RZX8uyXSc+G8JG5LjTjSpbChUcb2jyikrOB7bg8JMctgnvANOmIkZzYulXHQut0FdInRThhHQAk7eF
X-Gm-Message-State: AOJu0Yx/EVIVXtVHqi3BTSYMbb5/eEfAjVpvUWJ/rJjJ6Y0EAYlU4LzX
	DSuDlt7nycP1nsdxzxegN8fJ2qlvhgca4XvV8bnguIDfnCR0ywzHYZi7ukOOtGJXh/5AwH0QQbJ
	kIxnhy3uZTifgi8le3+z3i1sylzcDc0BfzhOJlQ==
X-Google-Smtp-Source: AGHT+IGonhKXoPvsozKTZHzXlucbcYX9bg8Gg73rytHzYubU8rxNgnY/C6AFVJ/TQKBRXQr1jGNt+PCgi0Votzl81JM=
X-Received: by 2002:a05:6214:4186:b0:68c:7cbb:272e with SMTP id
 ld6-20020a056214418600b0068c7cbb272emr2843572qvb.19.1707915682117; Wed, 14
 Feb 2024 05:01:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214085248.6534-1-brgl@bgdev.pl> <Zcy3fwAZXwJZpqqu@smile.fi.intel.com>
In-Reply-To: <Zcy3fwAZXwJZpqqu@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 14 Feb 2024 14:01:11 +0100
Message-ID: <CAMRc=MeiYe_QZexnYci_uHguChK-=a2+iUC5jtR_OharqwZS=w@mail.gmail.com>
Subject: Re: [PATCH] gpio: sysfs: fix inverted pointer logic
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 1:52=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Feb 14, 2024 at 09:52:48AM +0100, Bartosz Golaszewski wrote:
>
> ...
>
> > Fixes: d83cee3d2bb1 ("gpio: protect the pointer to gpio_chip in gpio_de=
vice with SRCU")
>
> I'm wondering if instead tons of fixes you can just fold the patches and =
rebase your tree.
>
> Yes, we still have time to let it soak in Linux Next, so Torvalds won't c=
omplain.
> It will be much less burden to anybody who wants to backport this nice wo=
rk.
>

No, I don't think so. Rebasing is reserved for really special cases
when nothing else can be done. Fixes like that should be expected for
a big rework like this. This is honestly a strange idea.

And I don't think anyone should backport this work. It's simply way
too big and touches too many places.

Bart


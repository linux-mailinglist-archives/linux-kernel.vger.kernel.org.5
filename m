Return-Path: <linux-kernel+bounces-83296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A7386917F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFDE51C265EF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5C913B29B;
	Tue, 27 Feb 2024 13:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="qple0pkx"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110281EB25
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 13:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709039695; cv=none; b=Ev4kcqWCSfaMQFJa2HvGB1nDBdRa1UsS2YiKK8VDCGL+tXygRWpM0eC8XRgakP8wzWhSuqV/mVOA0MoqSFTUJHFe1k3EQZLVrGKXE7VHsI2VHJ2u1yjx7Iqdqg1xqusr7ZGoipsymFS9gbhQCMYCcl5l2ooL11TDOHlhvnh6kQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709039695; c=relaxed/simple;
	bh=2AMRMbVhNM06Hgp1X0TeGKqLaPQRtt3bhZ1iElXox58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RuEjmWU26JM8l1m1WNkxHshXbu7LLhCZQQGQGX+zNo49oECkO5bbXjx9z7n8UYmR452/X7uLGOhDPwD5acd21BU+PkWnJnpfbYNFIBWHTqV5fr7euDuU1tLwXorlFIGSJrOsTqSDr/JOnN+w0T4XXVmwolN07VOaLGPJL9a8mq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=qple0pkx; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7d6024b181bso2072903241.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 05:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1709039693; x=1709644493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2AMRMbVhNM06Hgp1X0TeGKqLaPQRtt3bhZ1iElXox58=;
        b=qple0pkxnzJDd9Yn+9eMXeEhbx85nGc++HkFBgEW6ANDwHzduvps37G+TjRJCmE45U
         cx1QxYQkn2HKg0nq9fT0Q2D70AMlUVHqrpapR/rqBYdAvmOJ+cx0Gch9hwTc9YmvhtgC
         0UkIwgCq11oGB1PT3uMrKzPdEcF6eZJNjee4qaIJyaEuNdxoxD1so99pjcPJNqgmrMLU
         fkxcxvW8ZWPxn6OZvkEKeHCSRmj8Sh3u5wmMO38xR/jy8Lx7a/MSXfWcMCti/2Fs984g
         rVAEi4mmnhwt1YY+hGfFXRPeUnhDFUUXbljisVrsLBI4e2h/hS8e9qmQNUoq9NlbSr/6
         X3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709039693; x=1709644493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2AMRMbVhNM06Hgp1X0TeGKqLaPQRtt3bhZ1iElXox58=;
        b=jpjGqxQbDB7k7Re1YwrEoceubcKbEayfBZfb1QQeK03FHB3JrNY8kJZCki/PKGqxvc
         +fdtv7pxOCkUDvFbhyOEDUvs8mGCnowwtyk0sdOHbbUFLsgkNFCbSraCrIs8asumBnb9
         8kmpGZMs3CMwaND0zdSQiEKOtgZtamBvm+ZzXREkFVZ+024Ia/YyYzpJL/ztMNP1pjbZ
         uJjbkuBPwk1hTkyh658URSwAn7JfxGU+UU9Zh62eeB/8kvNzPo/BbRU+As2HNdHfyLsC
         T+bwS5H2RsUwsEPjO3VizpC7MdXCaoeNUXUoa1SSeEugA6e11kTnE7+l9rLY8k9P0ayf
         ukNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMK7bnISETdPaNTMd72HahL7j79mo4LBikCrnYDvd8+XiTq3gWpIlzGA8IvRYjNK5yYD0cQWtXaHjNYAubpCRhlmB5K3TvDNde0l51
X-Gm-Message-State: AOJu0YzOVrZ3YY49l7PF+Qau4hS66GYRN3TQ7i65+asq09qsUJ0wQXCI
	Ip7Q0Q6U1r5inO7VgmuTo233c53ykfVsps2xEWWFkmOaCw6lmJ5o08yz1AGtPhBR7pv/55GXGEV
	QfzGiMDW7Iq0J/sT/hoDMYmjo47rAb5wnJDCxbQ==
X-Google-Smtp-Source: AGHT+IE+aoCuhINdmznTFe9JFtFLE74wM7BihxWVkNpvCU4rsgQWVYCbCscm8d1Rm4xX6DxB9G4niXzVUMF+EjPXSSU=
X-Received: by 2002:a1f:ccc1:0:b0:4cd:b718:4b08 with SMTP id
 c184-20020a1fccc1000000b004cdb7184b08mr6123482vkg.11.1709039691592; Tue, 27
 Feb 2024 05:14:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226134656.608559-1-arturas.moskvinas@gmail.com>
 <ZdyZnqS_jKelbs6G@smile.fi.intel.com> <3f629079-6809-4cae-bd4d-8b0ee4860196@gmail.com>
In-Reply-To: <3f629079-6809-4cae-bd4d-8b0ee4860196@gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 27 Feb 2024 14:14:40 +0100
Message-ID: <CAMRc=McUsv9ic5aU7oAaJ06zWtpna0CkkxPWr2nqPhEig5vPOg@mail.gmail.com>
Subject: Re: [PATCH] gpio: 74x164: Enable output pins after registers are reset
To: Arturas Moskvinas <arturas.moskvinas@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linus.walleij@linaro.org, 
	u.kleine-koenig@pengutronix.de, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 7:58=E2=80=AFAM Arturas Moskvinas
<arturas.moskvinas@gmail.com> wrote:
>
> Hello,
>
> On 2/26/24 16:01, Andy Shevchenko wrote:
> > On Mon, Feb 26, 2024 at 03:46:56PM +0200, Arturas Moskvinas wrote:
> >> Move output enabling after chip registers are cleared.
> > Does this fix anything? If so, maybe elaborate a bit the potential beha=
vioural
> > changes on the real lines.
>
> Chip outputs are enabled[1] before actual reset is performed[2] which
> might cause pin output value to flip flop if previous pin value was set
> to 1 in chip. Change fixes that behavior by making sure chip is fully
> reset before all outputs are enabled.
>
> Flip-flop can be noticed when module is removed and inserted again and
> one of the pins was changed to 1 before removal. 100 microsecond
> flipping is noticeable on oscilloscope (100khz SPI bus).
>
> For a properly reset chip - output is enabled around 100 microseconds
> (on 100khz SPI bus) later during probing process hence should be
> irrelevant behavioral change.
>
> [1] -
> https://elixir.bootlin.com/linux/v6.7.4/source/drivers/gpio/gpio-74x164.c=
#L130
> [2] -
> https://elixir.bootlin.com/linux/v6.7.4/source/drivers/gpio/gpio-74x164.c=
#L150
>
> Arturas Moskvinas

And this is precisely the kind of information that needs to go into
commit messages. I can tell *what* you're doing by looking at the
code. What I can't tell is *why*.

Bartosz


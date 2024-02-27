Return-Path: <linux-kernel+bounces-83901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56640869FEE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06A9D29118A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9D251C33;
	Tue, 27 Feb 2024 19:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cW83lc43"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95074EB49;
	Tue, 27 Feb 2024 19:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709061114; cv=none; b=Uj5vE1XJ5kQB364a+IAaSYhWeDNuaQKjfkK6CceuB1I11vEl+tIcJiyQFleBoWiamrQnhmEUPBLWhtulBw6oFAUQ4mmKnMduk6qCZY9MoJp+HK/zvphkFTPgMffqiiOtU1bDWXXCI8QdVY+7uM39ZzhEEitWMClPz54KKXY8XTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709061114; c=relaxed/simple;
	bh=eodD27oovdZR2lffspXR1dcJkughyOXYXBmqB3nCKbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m7GWGhVrQ+Gnhb4PDiIWliGlD4OhS0ZN+Yuy4vjiZM0JJT6wz7L0kacAChPpwR9KZ1sN+OhD3Fmkr/acB0fB0vxkQzI8RZ947LN0P+pSR3Ox2NTlEtR057XICnrc3zvcMn78BhqT8gOdt+c7Fpy003FpzU9ku4WqdZxgSv75dtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cW83lc43; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5131316693cso1105431e87.0;
        Tue, 27 Feb 2024 11:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709061111; x=1709665911; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eodD27oovdZR2lffspXR1dcJkughyOXYXBmqB3nCKbw=;
        b=cW83lc43KDp6GeclUrIYKq+NGu9mlCLiLfB9CBryXTCvPtvu+3E9RYCwJXTWTZiM4l
         vhGnGMBQu+jDIhKv4j7YKWln9aQ9ahPd+On+tXsbUW5YMBLXF3SPbvFx8QocN70Y224z
         xjztP0CHE3qtJNGxiifzgiX2PemMsfIZ/phse1M5I3TswfmVpYZgW7go4rhwvQ+z02Vr
         PZjZkAefQSIN1ea8FVz7zEPHys5HKBNkJ682xJ6wbxsyrVzOOGaw1Tb71yEKsxXu/K/8
         stWomPHr1uoNSd9X6zqIFUx3UtWYOEdanAneJGVVWqTOEOA33n+7FY57SYwYtM0Ehg7C
         9Thw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709061111; x=1709665911;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eodD27oovdZR2lffspXR1dcJkughyOXYXBmqB3nCKbw=;
        b=U0er1dl8cz/uiesgtsXso6XWtj4D11OAKqDvlSAbMOqGINDMC5ncVk1uQsLrZ/hhD+
         +LjoQVOHIhMgxW0B9YzxwowEQ0I52KJDaa6x5qANPAepT2FRaQN2OsnGSsEQyCSzNuU8
         Zg37yiG4tHBKSfiAYZSlHZe7hpXAuPtIwMTwqjbMIY9W/26ENxt6JrQ8pBKaWvIPgOJn
         YFnvCeSNPDftZ6qAkZo5D75TiCvtgXMfYH+/gQ16kiZrEu07IkSwiakMkbo1Db7LsByI
         vIg0dP1m+DHW3fQSSoDFloCD0WrRoHc86KR86JtQ+U1q1MjJmkXaQoWww0VlyD1pa6Dc
         rygQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfv+DNfelx/Kz9XlLCx9EQwNfHiTwTqGanPTI7SfujhCr/4iE2jogYZOHviaWK+CiFziPQlaIKMwN3RKLgOx3i+2nXLDsp0qPT8X96GO2Mw6c5gc3LUYcYRMIF0NwouXaSoFVyg3otig==
X-Gm-Message-State: AOJu0Yzlt/VdzVI1WztGE/4o80NY38D7z35f7bZLuDUOsIl7GBX66P1c
	Wydu0TXqA0V2kLviFCevUBoJDHx99VcMDy8R7vpeH5VOC6oU/IIQOpUzPYxtjDK9lbyyH/e9lh3
	rB5Cf6UA848I9/BICtvlCCjvDqDE=
X-Google-Smtp-Source: AGHT+IEt4bwVV2XZ/d/78mgXG69FOjkGsAdZtu1hNQBS0i06GIZc4F2R6hbW9U4GTC5hYueueAl26OIxfvsQ/UPO63E=
X-Received: by 2002:a05:6512:4015:b0:513:270:d5fc with SMTP id
 br21-20020a056512401500b005130270d5fcmr3781032lfb.57.1709061110601; Tue, 27
 Feb 2024 11:11:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226134656.608559-1-arturas.moskvinas@gmail.com>
 <ZdyZnqS_jKelbs6G@smile.fi.intel.com> <3f629079-6809-4cae-bd4d-8b0ee4860196@gmail.com>
 <CAMRc=McUsv9ic5aU7oAaJ06zWtpna0CkkxPWr2nqPhEig5vPOg@mail.gmail.com> <Zd33a69X9Ej4llbk@smile.fi.intel.com>
In-Reply-To: <Zd33a69X9Ej4llbk@smile.fi.intel.com>
From: Arturas Moskvinas <arturas.moskvinas@gmail.com>
Date: Tue, 27 Feb 2024 21:11:38 +0200
Message-ID: <CAPo8RJY2pVqRs3pvtMtOEEoMY3e8XPcub9d6LNwT6Ly0uOshbg@mail.gmail.com>
Subject: Re: [PATCH] gpio: 74x164: Enable output pins after registers are reset
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, linus.walleij@linaro.org, u.kleine-koenig@pengutronix.de, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

..
> > And this is precisely the kind of information that needs to go into
> > commit messages. I can tell *what* you're doing by looking at the
> > code. What I can't tell is *why*.
>
> +1. Please, add this to the commit message of v2, also try to find the commit
> that you can mark to be fixed with help of Fixes tag.

Thanks for suggestion regarding Fixes!

I thought maybe I should as well move whole GPIO initialization[0]
down to the same place I move "gpiod_set_value_cansleep(
chip->gpiod_oe, 1)" in patch v2? I think knowledge that a pin is
brought up later during probing process might be forgotten later, it
will slightly complicate code due to need to clean mutex though.

[0] https://elixir.bootlin.com/linux/v6.7.6/source/drivers/gpio/gpio-74x164.c#L125

Arturas Moskvinas


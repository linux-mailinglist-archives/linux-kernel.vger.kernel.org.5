Return-Path: <linux-kernel+bounces-46134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91899843B11
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D50728A04E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8880C67E86;
	Wed, 31 Jan 2024 09:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uycmpNzn"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4006B67A1A
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 09:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706693248; cv=none; b=AzC2aowqiKSpREjecIhJtcaTZkhYI9nbmgqQoKZgKBHRI7ofVNyIn5057wTC0FwkmOVxYrdNlbtTwkPra7mpWCQHkQDxmARxETEQVIL90+79IB9o3Y438DnNDvBIC12VXm2arRH1FH7yUfH+odH4OYGHpQUlbAox4j7Ae97BU4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706693248; c=relaxed/simple;
	bh=APPt4cZOWHp9Y5aLfOX9xR+zR3jzLxc+ja46scvsMIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MkFWuH9rERZ9pTLfOl1vAfD+sRlg7oIFKfAYXEXxDfGfxzpS4Wlk+BsGq4pNmNBtiO2S6P3sOs8pQOfl8/RlZZbUCejdUj5vvTtjVM1Q58EXCtslcsrAp5wgc5wmnMSmagzutOz47tVqmXwNvrPoboUk7HYGMJVyrpEmAb/kPQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uycmpNzn; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-60412866c36so1018367b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 01:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706693246; x=1707298046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APPt4cZOWHp9Y5aLfOX9xR+zR3jzLxc+ja46scvsMIA=;
        b=uycmpNznwNANfNR7j+Jluv0aWbpp+HyPj6OxDUGOqLA485zik22yREAY3eqPcuv+/g
         KT2X+JI+MneGBnbV36oF9n/wHyAtwx3W9rBisB08YGc2vaN5h0vTCjlHJbduYym5rYCv
         wEhCgpK1q2aaYCyD9S6uDk8tx3YDhOX7mh9klj1X2LUn8E8WuxYqXqDJ+ascM4/wQ9yN
         zmtiXccyNKV6O8beCSYDdPhf8XHeAaSHsfcD/Hh3dqZZJ8noDObbR6/P1M3pNw0tAmxw
         70OSQNO8NZAeZS6vCfJfntj7gja6hrir1rXG8sR/Q20EdUr17IHIH0CsiaCcI8ddky8F
         yljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706693246; x=1707298046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=APPt4cZOWHp9Y5aLfOX9xR+zR3jzLxc+ja46scvsMIA=;
        b=hXOm/gosHwPsXVTjpfAVxDbW7qmSPhfaR7+WPJmaIxKSbx/TBBG2Nx+ed7P/5WksOu
         rUPHGe0AzcRqv1oMpFjFbfZSl31Dk1Eh3v/3AyXthW9tFbhd4gTOraiksWIjNvHMiGAF
         M5N5dsaCGUJuk2qrClu7wcZ3uuwAcIRjRLWm2pEXV1OdcHI9li9yM3ei5LO/YvMd46to
         N5/kaPFIX2G/yQJVrV/CkyjfIyS29+JgN+SYWx+rFjZCmvP+IOD1VlFTQXyFEk99w54s
         bmnl6Dm4Ty+vScs13gqsp6HlJGlYnpwxmJ5i73FYcPw0QYoPM6AaFJI6y7rvGM2nyrGp
         +seA==
X-Gm-Message-State: AOJu0Yw9YwV/Vuwj6R+wDtzAN/lnhePUpOpByJczHAFbT3vRdqNuJUgB
	glVqXrt9aWFIYKzzi47xiELqzBOIP5N40mLo8X80mcrtkeWj8ZA9cUjAnVmu7YooUih8K7/NPi7
	nASI3bdpa2KjzsVkgtp8u7xJqpYbeTK262mS22A==
X-Google-Smtp-Source: AGHT+IFwfB+XrMm9vx8s1WntuQFjb6GV4ib5qrAhefKc2Um6vqKn5XC9kjvOepHk5CusYf5ABhGj8I6RUX+zGhFG4zg=
X-Received: by 2002:a0d:e60a:0:b0:5ef:f83d:ab23 with SMTP id
 p10-20020a0de60a000000b005eff83dab23mr967120ywe.5.1706693246182; Wed, 31 Jan
 2024 01:27:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130073710.10110-1-arturas.moskvinas@gmail.com>
In-Reply-To: <20240130073710.10110-1-arturas.moskvinas@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 31 Jan 2024 10:27:15 +0100
Message-ID: <CACRpkdaxn6d2BuvKpBF3+9PWxZ2Ur-sdFoxvYRx7cwk-dJeKLA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mcp23s08: Check only GPIOs which have interrupts enabled
To: Arturas Moskvinas <arturas.moskvinas@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Andreas Kaessens <akaessens@gmail.com>, Thomas Preston <thomas.preston@codethink.co.uk>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Phil Reid <preid@electromag.com.au>
Cc: u.kleine-koenig@pengutronix.de, radim.pavlik@tbs-biometrics.com, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 8:37=E2=80=AFAM Arturas Moskvinas
<arturas.moskvinas@gmail.com> wrote:

> GPINTEN register contains information about GPIOs with enabled
> interrupts no need to check other GPIOs for changes.
>
> Signed-off-by: Arturas Moskvinas <arturas.moskvinas@gmail.com>

This driver has a lot of users, so adding some reviewers.
https://lore.kernel.org/linux-gpio/20240130073710.10110-1-arturas.moskvinas=
@gmail.com/

Yours,
Linus Walleij


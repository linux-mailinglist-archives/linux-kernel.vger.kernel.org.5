Return-Path: <linux-kernel+bounces-123909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4687F890FA2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9B291F25EAB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF46711CA0;
	Fri, 29 Mar 2024 00:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Fwz1Ps1x"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7021E8825
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 00:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711672051; cv=none; b=GvarlzRBHZieLVa46mpwsCK8IUpRZUIylgONWicv9GLs8Jh8OuZIKCVnseT+vB5tOMJsNiGaL2nsrvc4R6I9rDVUE1jz62GIfpHHg1ODIAq+Q9Vhgc+odVS+9mpITiCzoeumZMblblzvYZXk/P89Nv06IAW3e6cBCGzKVP/Spi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711672051; c=relaxed/simple;
	bh=4uZoi6R4tYJ16WJEHODsDr2Z0XIv07t8qsQd9IHe/QI=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ha9b7qaHjpdvSEB+V9dhSThFcwduMW1TrH+Dq5fAxhRdLazgmAnJqUgXqDIkHi121neSc3NifsLn58AMXT6zYcX604p6Dg+s7ymVbWY1ERCPnzUQPK++MyPa29IeUgdIGzZ0nL8zxq4+ZzxXnYYvjaJgt/rwKKJLRo9H+8I+joM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Fwz1Ps1x; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d52e65d4a8so20679021fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 17:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711672047; x=1712276847; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TT5IF46LbV2sp7MvkMpydbH4CV7mnACWRZmlPJNbqIU=;
        b=Fwz1Ps1x+zpWHF3q1L1WP/GPTbtTFbicvpgr9fwzJGXo7ZCvpXYlAQrkeBp92P/mPZ
         dPhTUDh8bx5Ppb1pQeMg3PfSbBLS4ApkJZ+J5HCHa3aE6CKfy7FTzp8EF/6rKaReMwR+
         u64rH+0wbaA8ylAVgbjjO9yVUvXCPH/i56a48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711672047; x=1712276847;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TT5IF46LbV2sp7MvkMpydbH4CV7mnACWRZmlPJNbqIU=;
        b=Y18rmCShB2ZBTlYJ5rsKe07C0yQ4BY7D7O0JdJWjL2S4V/W9i7wBrJgR62Tn0DwQwS
         EGHpUgOsyApxkIf9exm2bJ1wG/oSoE0UcV6FoVSksi89Apw4vuoAJUJuR/RC0EwCqgoF
         dYCbCNbz86y6A4gm4cuSFNk5K75fyLPTaP8rQQ3TbO1o/nRP2VPpuKiEvAcQzyINHRY2
         D1gGa0fr8sEmXANc83L8+9soUNBxEh6lDiBQatVXj79xR2DjF4+z5+cIOuDRciJfGWKa
         neHNwbUZsr5vXCA1yyRIJtC+wNCnnDlOW7OcQSSpn0b4qrScFV5g7ubHx9FqmkHcpMIO
         WnrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLuMtPxJ/lTvTBxadG+MOFLJXceCEwUggXX1nJctcocKUN9pc+1by7zyzaWX1KOsToKyC6DskxksEmbRU0/MmJE8g2RtaXWIYVosxN
X-Gm-Message-State: AOJu0YxloqIJ9tzIFjnoTi2YmgZwwY+4xJvzJCjShR6Zi1FttBgksIlY
	ibgaoZZNR1gxGLSvQed4JN5TT4MIbbIgMI2dxTiKkKxBG1Y5zEh0oaL28jVgYrqlnlbcAA8i+uA
	uGgkUMpebZhXCEdXZExKuQBTbzg5m1Fwik+H9801DY8UjQwU=
X-Google-Smtp-Source: AGHT+IE8xq+rgjw4+GNlACAGsCekxMZImgqTNVGCyfejaNVABL8zRPZQ0ygAvGXw3IdOWjjc/7UeoW8BbOztxvb6/cc=
X-Received: by 2002:a19:a408:0:b0:515:ad80:566e with SMTP id
 q8-20020a19a408000000b00515ad80566emr579597lfc.27.1711672047665; Thu, 28 Mar
 2024 17:27:27 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 28 Mar 2024 19:27:27 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240320165930.1182653-1-andriy.shevchenko@linux.intel.com>
References: <20240320165930.1182653-1-andriy.shevchenko@linux.intel.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Thu, 28 Mar 2024 19:27:27 -0500
Message-ID: <CAE-0n510RRchFH44Up=Dv2C+oKCwyyjkz_YZvc1fNiq_v0uoQw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] gpiolib: Fix debug messaging in gpiod_find_and_request()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Ferry Toth <ftoth@exalondelft.nl>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Quoting Andy Shevchenko (2024-03-20 09:58:47)
> When consolidating GPIO lookups in ACPI code, the debug messaging
> had been reworked that the user may see
>
>   [   13.401147] (NULL device *): using ACPI '\_SB.LEDS.led-0' for '(null)' GPIO lookup
>   [   13.401378] gpio gpiochip0: Persistence not supported for GPIO 40
>   [   13.401402] gpio-40 (?): no flags found for (null)
>
> instead of
>
>   [   14.182962] gpio gpiochip0: Persistence not supported for GPIO 40
>   [   14.182994] gpio-40 (?): no flags found for gpios
>
> The '(null)' parts are less informative and likely scare the users.
> Replace them by '(default)' which can point out to the default connection
> IDs, such as 'gpios'.
>
> While at it, amend other places where con_id is used in the messages.
>
> Reported-by: Ferry Toth <ftoth@exalondelft.nl>
> Fixes: 8eb1f71e7acc ("gpiolib: consolidate GPIO lookups")
> Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>


Return-Path: <linux-kernel+bounces-100196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB552879361
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C8DE1F21D29
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5B079DBF;
	Tue, 12 Mar 2024 11:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mPjj+hWl"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C754179B84
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 11:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710244482; cv=none; b=MHgvM5ayVfr9ZoN5h5JDa59Oxm+3/CsUBXs7m2ggeirRliWZdoQyoeQVqCLWHA0fv+Eh1V1RI9eAgOs4UY7mgJR/FqbHQI+fQrj3K67jnjwyOAsXrH/uZpqX6Xdx/3eBt9W9vE9KF48NWVySOurhGU3NqPNphpB5+mn2wLIUyrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710244482; c=relaxed/simple;
	bh=eMwYwf+PTcyKjP2X2O2hHD0nhv74Ka6ysivHG8C+zE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mUbF+om2a+pTdYg5HXjicU7H5k372yXWswYUuKxqtWqw2wqouB8suLdWBJv0oirULhDDDSYqan4x+YKPIrOmTzhTJuNzSL6f6kpDcYhPtjsFZG0QXPnbrQQH5VeRGeGN6c6jJaV54RqcV06/Uqi6yj1oBMc1fEbrLwE4EuLKIwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mPjj+hWl; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-60a15449303so27331907b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 04:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710244480; x=1710849280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMwYwf+PTcyKjP2X2O2hHD0nhv74Ka6ysivHG8C+zE0=;
        b=mPjj+hWlYuhKR+4vteF9Elv034cB57JLdGwADmCiCSeyN3ECW9RaGxlBRtPAswzQRR
         o/xEOoXLNHrGq/ZoJWfSsoDAcufjOy/R5w6TNDeT5rrgbMMTIAp39PNjWkUCZegjoIa4
         3Lvg3ZQ2Dr9uU/iAQO6YiJFONjFrUYm3EHK69NUJaniKE571QwzlEQwHspwbF8SUjAwK
         SxZnRA4L99WUrzxbYCa9ImftOh4f0Uct6NQ9RedrBhSUFaj/o+wRLrwQikhicA2NnINR
         WK3Lce39LuMR5RNrO4pW5r/5JwhlsE6WwhQqsRKGfpVMOrCZmHz+lo3OyWE4txQxud2I
         K8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710244480; x=1710849280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eMwYwf+PTcyKjP2X2O2hHD0nhv74Ka6ysivHG8C+zE0=;
        b=lqYk8Ujm5y/rtEhkpTHqf1YQQEksACLIsZnEMFmLRyz1V3JdFbYUXXmZaUvnbNt2IX
         XxghOup+bB+gjghhFYTRoq4uh+JPnyefsic27Nm0NDQvcLwnngvvnGJFlVwpL+L8Ymaj
         p73qN0xqYCtnl4f/lyRLyvdPpWtBmqgDCD9HtTr9wrKhKr1nPPNPP/x2sDLq7oZ+gnhZ
         6RMINJ8OSS9rsqEsmWeLSAjwDeCsvRaulcb6vPB/J9J2e6keNpTMVHXFVg83l2+/UsPC
         PhI+RGwMjm1pvTi1Khd5JHdswx6f7cCBWggaVEaYDpLJmpEcGmbitYwOnXmKJ4aAsPUG
         OUlg==
X-Forwarded-Encrypted: i=1; AJvYcCXITTJ/7KpYtHfTox9pP5SBdLg4+4oelr2knV3l6x/Cuyibp6UY31SNiIu93sfR5b8VNOBldLs0+VzozBmEcSRqVNcnoJzx57fZYoJ2
X-Gm-Message-State: AOJu0YypT0NiKVSTLJz6e6vZdfacyr0UAYp5IBcJSgsBUhw0Qetu77rn
	I+p3XMbYAqm8Swx7NERxBRtmfYAkgCuA1hCjcZFgrp24UxiL70wCAZgNZAh2T9y0CPFZ25nPu/g
	j7XkxZkG7rWoOs5FGmxQtANwiiw9vbawrbGlGQw==
X-Google-Smtp-Source: AGHT+IG+/lC0gIWZWBycYM8boFQ4tYaReyNK6kx+QgOzkbr5oHDyk/2R2xJTlYTku8sBL2kMKResvmLwPs6PMTIRPOg=
X-Received: by 2002:a25:ef12:0:b0:dc7:2401:df4e with SMTP id
 g18-20020a25ef12000000b00dc72401df4emr5307ybd.39.1710244479820; Tue, 12 Mar
 2024 04:54:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311133223.3429428-1-max.kellermann@ionos.com>
In-Reply-To: <20240311133223.3429428-1-max.kellermann@ionos.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 12 Mar 2024 12:54:28 +0100
Message-ID: <CACRpkdYwHyDt9xdLxY5J4jPnX1G0X9DzKr_1jW9CJFNG5HzNwA@mail.gmail.com>
Subject: Re: [PATCH] drivers/gpio/nomadik: move dummy nmk_gpio_dbg_show_one()
 to header
To: Max Kellermann <max.kellermann@ionos.com>
Cc: brgl@bgdev.pl, linux-arm-kernel@lists.infradead.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 2:32=E2=80=AFPM Max Kellermann <max.kellermann@iono=
s.com> wrote:

> When `CONFIG_DEBUG_FS` is disabled, nmk_gpio_dbg_show_one() is an
> empty dummy function; this however triggers a `-Wmissing-prototypes`
> warning and later a linker error because the function is also used by
> drivers/pinctrl/nomadik/pinctrl-nomadik.c, therefore it needs to be
> non-static.
>
> To allow both sources to access this dummy function, this patch moves
> it to the header, adding the `#ifdef CONFIG_DEBUG_FS` there as well.
>
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

I made a patch myself yesterday and applied, but I like your patch more
so I took out my patch and put in yours instead.

Thanks!

Yours,
Linus Walleij


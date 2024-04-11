Return-Path: <linux-kernel+bounces-140042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCDB8A0AAD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45B761F22F76
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A3313F435;
	Thu, 11 Apr 2024 07:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofl8sOom"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BCE13E88A;
	Thu, 11 Apr 2024 07:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712822217; cv=none; b=eY97hySy6LkROfBpz7n2u8h+LJ63IqmeoZIjI7zJUB2G6mrQBGaVft19XsvgwsMM+DF2bcEOCP1nWZMdZhKYmi9BNwAqw51i/pKs7VPU0vLU/GiEBzP3yEjxJ4OmEGfICghjW/N02OZy06xd6a7nVQ2fTpM6JDHUEi7AZve3sZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712822217; c=relaxed/simple;
	bh=r82yVd6RGSCubhydxrcg4A9/P/oMhvzUKISskBjsB1M=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=Qt+777W9oce5BSFfl5rA5k9QKGdRmjrnig6C/Kh09bETCRIyxp/ajf7/t8HmIY2apOudUo+BiLrhkfJo9O5Y5Dc9DxrRsv9BzyNuJmDnXPMyEaRa+n1QY0gYsF+8KcOaNCopOrKwITx4FF0n9RUbIftWTq/qmeIbTevWrBub+m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofl8sOom; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDDF3C43394;
	Thu, 11 Apr 2024 07:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712822216;
	bh=r82yVd6RGSCubhydxrcg4A9/P/oMhvzUKISskBjsB1M=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=ofl8sOomwMpWVFOnh5zoHRVILDniytHECrRA2JVpnG7JZjD3Enamxs0ZFb+PqnKa2
	 WpqmwtqNtDq+cSsUqUCX36vBt3Z5jT5wb1Xb/uDrzv6Na62jOWRySCDwYVeGcxfqiO
	 slVhlm+SAVlwAoX+2Dj30TaNqPUyI3Jzo99W2422SSmH6a/b7IZNxnv/ZGYSGNKB/b
	 qHrPkdFyOGjtH7U+q2SpRlRSjdHOHqM259sHLHAUpta3V20jEwz7qz2V0YaiqHg6I/
	 Yc3tfuZXbTcVukHnC9Q5XjWBvDpNK1GXQ9vBAFDQ/G8Ic4wQkYQAsooS8Ysn1qXgwX
	 uuydngVahj46Q==
Message-ID: <a6e75820e5b6a96d3b1161c9dbf5a8d8.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240402-pxa1908-lkml-v9-1-25a003e83c6f@skole.hr>
References: <20240402-pxa1908-lkml-v9-0-25a003e83c6f@skole.hr> <20240402-pxa1908-lkml-v9-1-25a003e83c6f@skole.hr>
Subject: Re: [PATCH v9 1/9] clk: mmp: Switch to use struct u32_fract instead of custom one
From: Stephen Boyd <sboyd@kernel.org>
Cc: phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, Karel Balej <balejk@matfyz.cz>, David Wronek <david@mainlining.org>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley <conor+dt@kernel.org>, Duje =?utf-8?q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, Guilherme G. Piccoli <gpiccoli@igalia.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Kees Cook <keescook@chromium.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Lubomir Rintel <lkundrak@v3.sk>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>, Tony Lindgren <tony@atomide.com>, Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Date: Thu, 11 Apr 2024 00:56:54 -0700
User-Agent: alot/0.10

Quoting Duje Mihanovi=C4=87 (2024-04-02 13:55:37)
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> The struct mmp_clk_factor_tbl repeats the generic struct u32_fract.
> Kill the custom one and use the generic one instead.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Tested-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

>=20
> diff --git a/drivers/clk/mmp/clk.h b/drivers/clk/mmp/clk.h
> index 55ac05379781..c83cec169ddc 100644
> --- a/drivers/clk/mmp/clk.h
> +++ b/drivers/clk/mmp/clk.h
> @@ -3,6 +3,7 @@
>  #define __MACH_MMP_CLK_H
> =20
>  #include <linux/clk-provider.h>
> +#include <linux/math.h>
>  #include <linux/pm_domain.h>
>  #include <linux/clkdev.h>
>=20

This clkdev include should be dropped in another patch.


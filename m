Return-Path: <linux-kernel+bounces-134730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8961689B615
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 04:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B952F1C21016
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 02:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B981917F7;
	Mon,  8 Apr 2024 02:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ix8iBs74"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C9437B;
	Mon,  8 Apr 2024 02:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712544304; cv=none; b=vGGIPI4L2ELs9xWezPcV/GfYMiWU3LkqVieAnpCr75hCiiAk5UC+/w9OqXFuHbtlZDP4rikZd8PXTuJunKRZ76kQELmXFPMrPwnwSDjeM5s0alZbv5EwkAsJp1GvVq1bQ8snGy7dMbXdiKSaHtc6lMApt/C1KVImvXkRzVAVi0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712544304; c=relaxed/simple;
	bh=zOcI/UJNgVpdplBO9a8CzD53CIl24xf01xvaj26Ddzs=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=KOS1U4BvmHG6lsZg/rVNyKzy+TVtZbqEjIliOy8vYi3huPkqTiLHTuinwpm+/svdIqJZqYBDWpkN0RipHDpBqq57Qhm8/UejnPZsHJoK5WpbdIWpnHcXNIDCFBleLOKdCq72796056yBYc/gGpMhrxQXgI1xbRho36lNgOFoDmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ix8iBs74; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 697CFC433C7;
	Mon,  8 Apr 2024 02:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712544303;
	bh=zOcI/UJNgVpdplBO9a8CzD53CIl24xf01xvaj26Ddzs=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Ix8iBs74GbMER3N197bHAgFr8QMr2bjO9qYtsebIIs7N4xcJDTMuFX6oRZSbx6oB8
	 T9hzT0kXSRgAM/Dl4crrID9/Xr3/05wtfH7EzbDY6wsmewdjW367zUgS3N3A4thA/x
	 S1cLxM9Gu/UYiaWiVSjY1UXzuFFJRb6q/wjSHaU5WmYc4FVvkKHF3vkDC8XkwFeV0r
	 AqcceuQsuuGIiaz3Xmj2fic3APmlHfsWpZa4UBkzGBqMPFxegJqlMBiVDLI60x/JrE
	 JS9DOvGw7NvoMLWkcNMvAvF0UVvYgqRGJ3isoN6NxKcHlki6GNwx8EqQFM2ZnM8Kb1
	 AsHoDkBEMaXgA==
Message-ID: <a755bf7d32d2482a6318fab614f669f3.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2082b46ab08755b1b66e0630a61619acac9d883f.1711714613.git.geert@linux-m68k.org>
References: <2082b46ab08755b1b66e0630a61619acac9d883f.1711714613.git.geert@linux-m68k.org>
Subject: Re: [PATCH v3] clk: starfive: jh7100: Use clk_hw for external input clocks
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Samuel Holland <samuel.holland@sifive.com>
To: Albert Ou <aou@eecs.berkeley.edu>, Andy Shevchenko <andy.shevchenko@gmail.com>, Conor Dooley <conor.dooley@microchip.com>, Emil Renner Berthing <kernel@esmil.dk>, Geert Uytterhoeven <geert@linux-m68k.org>, Hal Feng <hal.feng@starfivetech.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>
Date: Sun, 07 Apr 2024 19:45:01 -0700
User-Agent: alot/0.10

Quoting Geert Uytterhoeven (2024-03-29 05:16:58)
> The Starfive JH7100 clock driver does not use the DT "clocks" property
> to find the external main input clock, but instead relies on the name of
> the actual clock provider ("osc_sys").  This is fragile, and caused
> breakage when sanitizing clock node names in DTS.
>=20
> Fix this by obtaining the external main input clock using
> devm_clk_get(), and passing the returned clk_hw object to
> devm_clk_hw_register_fixed_factor_parent_hw().
>=20
> While name-based look-up of the other external input clocks works as-is,
> convert them to a similar clk_hw-based scheme to increase uniformity,
> and to decrease the number of (multiple identical) name-based look-ups.

Why can't we use index based lookups and clk_parent_data? We don't want
clk providers to call clk consumer APIs.

>=20
> Fixes: f03606470886 ("riscv: dts: starfive: replace underscores in node n=
ames")
> Fixes: 4210be668a09ee20 ("clk: starfive: Add JH7100 clock generator drive=
r")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
> ---
> After this is applied, the workaround in commit 7921e231f85a349d
> ("riscv: dts: starfive: jh7100: fix root clock names") can be reverted.
>


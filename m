Return-Path: <linux-kernel+bounces-139728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D25668A06EA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 727271F23365
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E3513BAF2;
	Thu, 11 Apr 2024 03:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uOTLsMD/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C2C13B58D;
	Thu, 11 Apr 2024 03:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712807327; cv=none; b=Un8k4maHzSZ2/1fjJapXZIAIa2ihABjg6GIoifqr0kGbPPVDlbWYCAK0J5FkA8HZBS4/CcmZwjpwI6SptI3Vb5e5Aklncnvrg4XcbCOnltYz0MbF67w58Wrrs2yShRABA4d3zqvGQ3YwmWTOqzq7q0sg9szWdBt96dXjIxwakCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712807327; c=relaxed/simple;
	bh=aBDw+HokdUlrHR8iGqI7UsQz0OKWOH0/+fH0gryYk1I=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=TLIBMDFfw1kWBhF7Ji86T3JD0vkif3v9eWdxlh1b+jzsTt8K+YHzm/DhBLrMKx4yk29uFBjPGBnBXm/f+rugn6RBIy4zPVzb1HzERoICv3/T1drxjNdtu8TvcV2PRdAHOSj/N37UBIbsroS8F2D9CTZGM0Hf+3DmgMqCeRNrmi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uOTLsMD/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48261C433F1;
	Thu, 11 Apr 2024 03:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712807327;
	bh=aBDw+HokdUlrHR8iGqI7UsQz0OKWOH0/+fH0gryYk1I=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=uOTLsMD/6bGWI/YDWW53/mkGXyoqEyZPUIZWJzgXI85IhfbANNCLeT0p0viTZKNmz
	 2lA+J+UyWa45KGRkMCUWvR81YMujOBDxRCl92Zbdicxl5nGHoKltAOQKhrB1VboLLL
	 AyL+Rthux0akdTmaKCVrhRdmATzALrOuNEwrOqJpW4oppbLQYdqClRhuaextB5RZpw
	 0cbuzEt6NK8bTEYP2CXFoz9JjBat0PnVPIXeGYtkAhkX0po97wQcmKA+oUdJDjIRpf
	 FU6R9DDls2jVrFaEFwx1bo/HWL5nMJfM7wQZZLD+5qpxfw4nPSvA86Pg3s5SgbsH03
	 bUwYLLQwbv0Qg==
Message-ID: <0e92e72d610bd97963b686366c5334d2.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240312115249.3341654-1-treapking@chromium.org>
References: <20240312115249.3341654-1-treapking@chromium.org>
Subject: Re: [PATCH v4] clk: mediatek: Do a runtime PM get on controllers during probe
From: Stephen Boyd <sboyd@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Pin-yen Lin <treapking@chromium.org>, Weiyi Lu <weiyi.lu@mediatek.com>, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, Bosi Zhang <u201911157@hust.edu.cn>, Nicolas Boichat <drinkcat@chromium.org>, Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Matthias Brugger <matthias.bgg@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Pin-yen Lin <treapking@chromium.org>
Date: Wed, 10 Apr 2024 20:48:45 -0700
User-Agent: alot/0.10

Quoting Pin-yen Lin (2024-03-12 04:51:55)
> mt8183-mfgcfg has a mutual dependency with genpd during the probing
> stage, which leads to a deadlock in the following call stack:
>=20
> CPU0:  genpd_lock --> clk_prepare_lock
> genpd_power_off_work_fn()
>  genpd_lock()
>  generic_pm_domain::power_off()
>     clk_unprepare()
>       clk_prepare_lock()
>=20
> CPU1: clk_prepare_lock --> genpd_lock
> clk_register()
>   __clk_core_init()
>     clk_prepare_lock()
>     clk_pm_runtime_get()
>       genpd_lock()
>=20
> Do a runtime PM get at the probe function to make sure clk_register()
> won't acquire the genpd lock. Instead of only modifying mt8183-mfgcfg,
> do this on all mediatek clock controller probings because we don't
> believe this would cause any regression.
>=20
> Verified on MT8183 and MT8192 Chromebooks.
>=20
> Fixes: acddfc2c261b ("clk: mediatek: Add MT8183 clock support")
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
>=20
> ---

Applied to clk-fixes


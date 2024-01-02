Return-Path: <linux-kernel+bounces-14981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9960A8225A1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 00:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34C091F23563
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 23:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191AC1798E;
	Tue,  2 Jan 2024 23:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t19M/dx2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A1C17981;
	Tue,  2 Jan 2024 23:42:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB434C433C8;
	Tue,  2 Jan 2024 23:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704238967;
	bh=YfSWBKVajWDhWg1Sr7vlQP066tr0a5p80GHvnjAdI9s=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=t19M/dx2bZFP0Gz1V9oTm8f434RnWH6i4JxgQvHlZ6snSX06ZfxN1LrLgr6xTZFn2
	 IM4REYp/g7Rs8qmTRshvRLkkcklTVBNjjahvR44eIireFqUSvx5+i1UjNXu6Gm0h3M
	 9qBgMC1Pv981+/tA45ssTJCypQj/B1HgLSgGNnT9AAAfPRRtgHAUHRpfiMIYqjSfd1
	 OvgnzLvYqeWUUVWGANka1d0uxst0xBJ4A427xy8fEbvwMWTtQlwzRMuDZsrev7CoOn
	 AA/r1MWTTEDRINB+kHDIHc3ZhNqNC3RRswROAHMQKm8VlwbpENf4N2RI2+do/rTexM
	 Ik3/BuCnKuXLw==
Message-ID: <fa32e6fae168e10d42051b89197855e9.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CXUTPV1ZOSID.323RSEP4BL2AT@bootlin.com>
References: <20231218-mbly-clk-v1-0-44ce54108f06@bootlin.com> <20231218-mbly-clk-v1-3-44ce54108f06@bootlin.com> <a8f740c7a8c1222d4a42bad588c75e87.sboyd@kernel.org> <CXUTPV1ZOSID.323RSEP4BL2AT@bootlin.com>
Subject: Re: [PATCH 3/5] clk: eyeq5: add controller
From: Stephen Boyd <sboyd@kernel.org>
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, linux-mips@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>
To: Conor Dooley <conor+dt@kernel.org>, Gregory CLEMENT <gregory.clement@bootlin.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, =?utf-8?q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>
Date: Tue, 02 Jan 2024 15:42:45 -0800
User-Agent: alot/0.10

Quoting Th=C3=A9o Lebrun (2023-12-22 03:25:12)
> On Wed Dec 20, 2023 at 12:09 AM CET, Stephen Boyd wrote:
> > Quoting Th=C3=A9o Lebrun (2023-12-18 09:14:18)
>=20
> > > +       of_clk_add_hw_provider(np, of_clk_hw_onecell_get, data);
> > > +}
> > > +
> > > +CLK_OF_DECLARE_DRIVER(eq5c, "mobileye,eyeq5-clk", eq5c_init);
> >
> > Please use a platform driver.
>=20
> I've been trying to do that but I had a stall at boot. I initially
> associated it with the UART driver acquiring a clock too early but
> instead it is the CPU timer clocksource driver that consumes one of our
> clock way earlier than any platform driver initialisation.
>=20
> The clocksource driver we are talking about is this one for reference:
> https://elixir.bootlin.com/linux/v6.6.8/source/drivers/clocksource/mips-g=
ic-timer.c
>=20
> Its usage of TIMER_OF_DECLARE means it gets probed by timer_probe ->
> plat_time_init -> time_init -> start_kernel. This is way before any
> initcalls. Our prior use of CLK_OF_DECLARE_DRIVER meant that we got
> probed by of_clk_init -> plat_time_init.
>=20
> I'm guessing we are not the first one in this situation; any advice on
> how to deal with it?
>=20

You guessed correctly. In that case, use CLK_OF_DECLARE_DRIVER() and
register the clk(s) needed for the timer in that function. Other clks
shall be registered with a platform driver.


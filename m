Return-Path: <linux-kernel+bounces-142036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 391738A2698
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E80262832F8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967B3405C7;
	Fri, 12 Apr 2024 06:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcD9oVlH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAE8405F2;
	Fri, 12 Apr 2024 06:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712903289; cv=none; b=ALacIFCSuDnAae8hVxjtNartRMGTSwGzDVqG+TjcduiWcbEUmprvGAVlS2uhHBWetXDYXiU0JYG0vubKOgXYGVmJ/g6q/aVGvx3gr0RZNOTMe3HM+oOfMWGP7w0aGVKxoIM39axkBjm1/Yk8uaqdL1A1Su+KrOXiyKWWwJ5HeHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712903289; c=relaxed/simple;
	bh=zgUjpYLth8c3Bov77A49CZpA8m7933+tVeBvXp/8wOY=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=qRLv4v2Mqphvx24tivS3eYfLbfmorPkMi/NiwBRdedcrV9dBcZLx433lyLaBFq1s/IkxJXBY7g8BcKWuNs5rU2rekG5DAPBnwWS49uy/7q+MLq5qkZf6XrpH9720D1wC0LbkZ2FfxUcmvQh1MyuNbnm3Ra6mNNFJuv6L1VEE7xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcD9oVlH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 405FDC2BBFC;
	Fri, 12 Apr 2024 06:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712903289;
	bh=zgUjpYLth8c3Bov77A49CZpA8m7933+tVeBvXp/8wOY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=mcD9oVlH4scQ0n8FoGrPsd+Wh/j9+FrlK3kD+wBSEvJRwiB2l3BmDvsbJfmQ8YsCg
	 bgUu5iA9baeH3R3QfZh9bYBuBVqPG9rsn2EOGxf+97lT+G0H9mnbQ9FhBpqzdW2oXh
	 0d3j7/KzvaMREQOA8mkfLJRlpWVgFjvV/IgeKTv86yArvOytXcFl0n1QKUoQ2Vimo4
	 Li9mZ/OQHPNMRB8mCmQW3Z84qs+wcf8MHRO9/YmmlkHqJFhW3ELj+diPpTsmzDFW/R
	 ADRW15Nbxqr78VwBKSXFS1A3kUUgWZam+5Jt4yAOV5fJtg0nTh4P4w8QQyUXtqUl+n
	 RhFDBtVGuR2Wg==
Message-ID: <3d6d34c5075559f3df506d14e38a9c0c.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZaG2ZDCLP34jcI6Y@dell-precision-5540>
References: <20231002180854.1603452-1-ben.wolsieffer@hefring.com> <20231002180854.1603452-2-ben.wolsieffer@hefring.com> <883a61872f94c972cc410da84eaf7b97.sboyd@kernel.org> <ZaG2ZDCLP34jcI6Y@dell-precision-5540>
Subject: Re: [PATCH 1/2] clk: stm32: initialize syscon after clocks are registered
From: Stephen Boyd <sboyd@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, Michael Turquette <mturquette@baylibre.com>
To: Ben Wolsieffer <ben.wolsieffer@hefring.com>
Date: Thu, 11 Apr 2024 23:28:07 -0700
User-Agent: alot/0.10

Quoting Ben Wolsieffer (2024-01-12 14:00:04)
> On Sun, Dec 17, 2023 at 03:05:01PM -0800, Stephen Boyd wrote:
> > Quoting Ben Wolsieffer (2023-10-02 11:08:53)
> > > The stm32-power-config syscon (PWR peripheral) is used in this driver
> > > and the STM32 RTC driver to enable write access to backup domain
> > > registers. The syscon's clock has a gate controlled by this clock
> > > driver, but this clock is currently not registered in the device tree.
> > > This only happens to work currently because all relevant clock setup =
and
> > > RTC initialization happens before clk_disabled_unused(). After this
> > > point, all syscon register writes are ignored.
> >=20
> > Seems like we should mark those clks as CLK_IGNORE_UNUSED and add a
> > comment to that fact.
>=20
> That seems like a worse solution than specifying the clock dependency in
> the device tree.
>=20
> >=20
> > >=20
> > > If we simply add the syscon clock in the device tree, we end up with a
> > > circular dependency because the clock has not been registered at the
> > > point this driver requests the syscon.
> > >=20
> > > This patch avoids this circular dependency by moving the syscon lookup
> > > after the clocks are registered. This does appear to create a possible
> > > race condition where someone could attempt to perform an operation on=
 a
> > > backup domain clock before the syscon has been initialized. This would
> > > result in the operation having no effect because backup domain writes
> > > could not be enabled. I'm not sure if this is a problem or if there is
> > > a way to avoid it.
> >=20
> > There's no comment in the code that says the regmap must be set there
> > instead of earlier. What's to stop someone from tripping over this
> > problem later? At the least, please add a comment.
>=20
> Yeah, I'll fix that. Do you have any thoughts on the race condition I
> described? Should I add some kind of locking to block
> enable/disable_power_domain_write_protection() until stm32f4_rcc_init()
> attempts to initialize the syscon?

Maybe. I don't really know and it's probably because I don't really
understand the problem. Maybe you can solve it by turning on the backup
domain clock manually when the driver probes via direct register writes
and then only publish the syscon once the backup domain clock is
registered?


Return-Path: <linux-kernel+bounces-2861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4832816342
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 00:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 230611C2139B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 23:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9B049F9D;
	Sun, 17 Dec 2023 23:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="caqjKKMZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6901E49D;
	Sun, 17 Dec 2023 23:05:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A8FC433C7;
	Sun, 17 Dec 2023 23:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702854303;
	bh=C31/vdIwlOG4/RQpDKhURj/OwqcINur5NKr6OP5ZcBY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=caqjKKMZzNHtUE0k7JGP35K97SrxPimgNRsRVIJWxbjG1a00XoKn/0+6ZnN89afve
	 PIBAxXW8bxMrKeUs+DTNEf5gXZnCr4QZvlvWU+9uYUhn8hDW3nyYmQlTQJ1YpG36zn
	 CUYH4ZjWdNwIOt9h2GICr9xgmZVbfoG1VW+kPLf96DYm3hE9cwBJ+pU/5Dn4tJjUN+
	 9y0OpSVS4eBouTH5fVXb7cBzIiM2xBIa/GQq2jsqRrdhewFJG6oU5Zz/opuLCgtrt0
	 lr0ISwKr0/aUkOPgwzNWluAXdwOsnl/IBG7obL957qQpuvRPCK76VaMuKUJU2BFe0b
	 vEooQ6HNn55/w==
Message-ID: <883a61872f94c972cc410da84eaf7b97.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231002180854.1603452-2-ben.wolsieffer@hefring.com>
References: <20231002180854.1603452-1-ben.wolsieffer@hefring.com> <20231002180854.1603452-2-ben.wolsieffer@hefring.com>
Subject: Re: [PATCH 1/2] clk: stm32: initialize syscon after clocks are registered
From: Stephen Boyd <sboyd@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, Michael Turquette <mturquette@baylibre.com>, Ben Wolsieffer <ben.wolsieffer@hefring.com>
To: Ben Wolsieffer <ben.wolsieffer@hefring.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Date: Sun, 17 Dec 2023 15:05:01 -0800
User-Agent: alot/0.10

Quoting Ben Wolsieffer (2023-10-02 11:08:53)
> The stm32-power-config syscon (PWR peripheral) is used in this driver
> and the STM32 RTC driver to enable write access to backup domain
> registers. The syscon's clock has a gate controlled by this clock
> driver, but this clock is currently not registered in the device tree.
> This only happens to work currently because all relevant clock setup and
> RTC initialization happens before clk_disabled_unused(). After this
> point, all syscon register writes are ignored.

Seems like we should mark those clks as CLK_IGNORE_UNUSED and add a
comment to that fact.

>=20
> If we simply add the syscon clock in the device tree, we end up with a
> circular dependency because the clock has not been registered at the
> point this driver requests the syscon.
>=20
> This patch avoids this circular dependency by moving the syscon lookup
> after the clocks are registered. This does appear to create a possible
> race condition where someone could attempt to perform an operation on a
> backup domain clock before the syscon has been initialized. This would
> result in the operation having no effect because backup domain writes
> could not be enabled. I'm not sure if this is a problem or if there is
> a way to avoid it.

There's no comment in the code that says the regmap must be set there
instead of earlier. What's to stop someone from tripping over this
problem later? At the least, please add a comment.


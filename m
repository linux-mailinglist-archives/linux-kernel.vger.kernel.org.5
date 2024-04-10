Return-Path: <linux-kernel+bounces-137802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A09C89E7DA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 03:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 929C41F22E83
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFB146B5;
	Wed, 10 Apr 2024 01:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGaVed5+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB7064A;
	Wed, 10 Apr 2024 01:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712712848; cv=none; b=fzEqpqNP1N00DvpplO6091f5N6JuoPH8QODL+gPAAYLQtNd9diZk6G7NS6jldrQ1jdjLXdmK7uXh+UD1SbsL/SfLZ74Hv8veo4QxrR5i40/2e8d0Y/CiMCiGs4fmxhy+Sh+IeU1hLUfIIebImP1CZDW7kqpVTsa3pRNYu1U2Kjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712712848; c=relaxed/simple;
	bh=DqEyzDB6gA9tY2cLBHY0HaJ2TcbP4Rj1/3pQs/AVjDY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gVqx98oCzTf4VKpXoEscwvilUEko8VvxbFX9t3MSPFmhoY9MHRsWsjjySyULpVEJ0j/krIOGOa/B+2nm/jzxuNWJIrxg7NN9v2t+KFYhVoBTKAKnLBYlJorXptzo3I0Z2cjjcIfXa9KN24WBb9/Zkc7iF/etoI3MZhrd1pzuKq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGaVed5+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03DCFC433F1;
	Wed, 10 Apr 2024 01:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712712847;
	bh=DqEyzDB6gA9tY2cLBHY0HaJ2TcbP4Rj1/3pQs/AVjDY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cGaVed5+yN7xmkmbHJVfElRpnFUDSFbABfqVWya2USmjMjKEmBJh5A+s0Sm5J5PVE
	 7uuAeJ6v9qqvRo5Ac43XM2HQqpk7FaeJFsC3W4scazZHmI2OEfZBWeNoem+I5nWSNF
	 9Pobqaw9ShSFnL2Bb7GbaXUjvJ9xbqJtjlls3NdHfj0PaqmoYu9ovNHemu8W4q8ICw
	 zKymKoS8f5WjJphpOZFTZmqDgugBL9r4ggGRd17rn787M6se9cNEd3PW/NBzksRI5p
	 IOWp3Sh3SvTViEXjsqiKPFiKe9XJBvC7CPm1anTc7uiC9Xva5F/ZPkT4wW+DSQuUiT
	 k853Gh/qEOTAA==
Date: Tue, 9 Apr 2024 18:34:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Russell King
 <linux@armlinux.org.uk>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?=
 <clement.leger@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, "Russell King (Oracle)"
 <rmk+kernel@armlinux.org.uk>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v2 3/5] net: stmmac: dwmac-socfpga: use
 pcs_init/pcs_exit
Message-ID: <20240409183404.7d3eb04f@kernel.org>
In-Reply-To: <20240409-rzn1-gmac1-v2-3-79ca45f2fc79@bootlin.com>
References: <20240409-rzn1-gmac1-v2-0-79ca45f2fc79@bootlin.com>
	<20240409-rzn1-gmac1-v2-3-79ca45f2fc79@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 09 Apr 2024 11:21:46 +0200 Romain Gantois wrote:
> +	struct regmap_config pcs_regmap_cfg = {
> +		.reg_bits = 16,
> +		.val_bits = 16,
> +		.reg_shift = regmap_upshift(1),

This appears to displease the compiler:

drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c:389:16: error: call to undeclared function 'regmap_upshift'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  389 |                 .reg_shift = regmap_upshift(1),
      |                              ^
-- 
pw-bot: cr


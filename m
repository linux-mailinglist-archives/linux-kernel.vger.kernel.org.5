Return-Path: <linux-kernel+bounces-20317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3002827D42
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 04:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 820B1285174
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 03:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8A44436;
	Tue,  9 Jan 2024 03:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWF/8z7g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C2C28F5;
	Tue,  9 Jan 2024 03:08:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5EC1C43390;
	Tue,  9 Jan 2024 03:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704769722;
	bh=X7kLVVcgvRdRs5HuITPBpohSYBsG52ZbQ+d0igx0eEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cWF/8z7gvhelK5fSDl6ViLjJPYNYtDbFAc8ELim8A8FX7vyieyQNDAnNCvQG89/wX
	 kX8dhcDPob67N9nBWsmfXToLZ6UZYrblaARW/qxu3cAaTe13iPiiD2BQ4M3EefPCCj
	 X4mEFCRxdpGg67nJc7Oe8jRLaF2a4JGv9zjOBv7kVCMiHWaF2L19/nSvqqw79IJf+2
	 KOQ4ff9CejwvUR85cmPF+m+lZH1ywGaNBOjAl1yLPGDBlslWTyEtac5CwAVNMLVvrB
	 qNv31l+35GFN0t0yfNaVk9tGZYi37irlAC9d9goP8himHObfAf0o+LDuWKfHWvMCmH
	 NeyatUY26gaiA==
Received: (nullmailer pid 2468474 invoked by uid 1000);
	Tue, 09 Jan 2024 03:08:40 -0000
Date: Mon, 8 Jan 2024 20:08:40 -0700
From: Rob Herring <robh@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Emil Renner Berthing <kernel@esmil.dk>, devicetree@vger.kernel.org, Alexandre Torgue <alexandre.torgue@foss.st.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, linux-stm32@st-md-mailman.stormreply.com, Jose Abreu <joabreu@synopsys.com>, Conor Dooley <conor+dt@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Samin Guo <samin.guo@starfivetech.com>, linux-arm-kernel@lists.infradead.org, Jacob Keller <jacob.e.keller@intel.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, kernel@collabora.com
Subject: Re: [PATCH v3 1/2] dt-bindings: net: starfive,jh7110-dwmac: Add
 JH7100 SoC compatible
Message-ID: <170476971804.2467890.1994452217560064962.robh@kernel.org>
References: <20231222101001.2541758-1-cristian.ciocaltea@collabora.com>
 <20231222101001.2541758-2-cristian.ciocaltea@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222101001.2541758-2-cristian.ciocaltea@collabora.com>


On Fri, 22 Dec 2023 12:09:59 +0200, Cristian Ciocaltea wrote:
> The Synopsys DesignWare MAC found on StarFive JH7100 SoC is mostly
> similar to the newer JH7110, but it requires only two interrupts and a
> single reset line, which is 'ahb' instead of the commonly used
> 'stmmaceth'.
> 
> Since the common binding 'snps,dwmac' allows selecting 'ahb' only in
> conjunction with 'stmmaceth', extend the logic to also permit exclusive
> usage of the 'ahb' reset name.  This ensures the following use cases are
> supported:
> 
>   JH7110: reset-names = "stmmaceth", "ahb";
>   JH7100: reset-names = "ahb";
>   other:  reset-names = "stmmaceth";
> 
> Also note the need to use a different dwmac fallback, as v5.20 applies
> to JH7110 only, while JH7100 relies on v3.7x.
> 
> Additionally, drop the reset description items from top-level binding as
> they are already provided by the included snps,dwmac schema.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  .../devicetree/bindings/net/snps,dwmac.yaml   | 11 +--
>  .../bindings/net/starfive,jh7110-dwmac.yaml   | 72 +++++++++++++------
>  2 files changed, 57 insertions(+), 26 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>



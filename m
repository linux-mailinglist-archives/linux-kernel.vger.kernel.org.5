Return-Path: <linux-kernel+bounces-130267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 421A089761D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72DE51C2858E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE50153835;
	Wed,  3 Apr 2024 17:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Crn2Bypv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6DC152DE8;
	Wed,  3 Apr 2024 17:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164525; cv=none; b=JKRKpD/vpxjQKCQ9tnfxsKu0da8ZkibS/423UFAae3iQvZPUpsXUMhfHSU6tD8tXWcbcujWhlzNWfqu8IH+pSj+jltbFsqdMCLVEvGyC00ey99n+hP+J/73X5AyLLOW8PYQ3SohTnQJGbmtSS10kC0n1OD/MIbynvNvLeXrG1hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164525; c=relaxed/simple;
	bh=LU4Fr44tzUgk3hAyzANG0d2RG8nR6qdxsxdjqxB5zO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIRnyQP0duexhbvY8OvijZjC64hjLsUoY1ILFIEzEHQgtpKN+8MTjIRhoc6Cm/yl5SwY34H642N66VqdI4idUoOHZQpDsvLiOTJKsMaBkLkvk+8H/YUqL0v3eSKjsQ4gqfL2ocxfPSv98FdfqZ93T/zm3zeZD1wWLOmOedMVgts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Crn2Bypv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E04CC43399;
	Wed,  3 Apr 2024 17:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164525;
	bh=LU4Fr44tzUgk3hAyzANG0d2RG8nR6qdxsxdjqxB5zO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Crn2Bypvo3Kv0F/G3kczzQFESKl58l7QIP+KlF5HW2ukxnJddUqfeWcVj2sibhi6r
	 Wd4pAC48+U3CzabQU/ScGSwvstLaVOAenqS+JANq9rVVusFqiX8CZsZz9Yu7IQE06P
	 dN61bJcHFau91VNy3QNbrlcU5t2RpnRl22f2UaWjMoMqKUuTPMNOxL8vgYtFaj4Qah
	 mD+UlGcjt9JtvGnhOe6FDnxJK10I1bP/zZQOPKLhLrIaWjD8/L1yWpxm7e33T26IV5
	 /FPvSBI+GIFCJPeP6n2EDA5WlPj8vgjmsy0twk/tcWyBo6Vr6TY9o1opeuGt+O40yd
	 SRup2Djue5aSg==
Date: Wed, 3 Apr 2024 12:15:23 -0500
From: Rob Herring <robh@kernel.org>
To: Tan Chun Hau <chunhau.tan@starfivetech.com>
Cc: Andrew Halaney <ahalaney@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Jisheng Zhang <jszhang@kernel.org>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh+dt@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Jee Heng Sia <jeeheng.sia@starfivetech.com>,
	Paolo Abeni <pabeni@redhat.com>, linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Eric Dumazet <edumazet@google.com>, devicetree@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v6 1/1] dt-bindings: net: starfive,jh7110-dwmac: Add
 StarFive JH8100 support
Message-ID: <171216452060.4016592.7318363130745016894.robh@kernel.org>
References: <20240403100549.78719-1-chunhau.tan@starfivetech.com>
 <20240403100549.78719-2-chunhau.tan@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403100549.78719-2-chunhau.tan@starfivetech.com>


On Wed, 03 Apr 2024 03:05:49 -0700, Tan Chun Hau wrote:
> Add StarFive JH8100 dwmac support.
> The JH8100 dwmac shares the same driver code as the JH7110 dwmac
> and has only one reset signal.
> 
> Please refer to below:
> 
>   JH8100: reset-names = "stmmaceth";
>   JH7110: reset-names = "stmmaceth", "ahb";
>   JH7100: reset-names = "ahb";
> 
> Example usage of JH8100 in the device tree:
> 
> gmac0: ethernet@16030000 {
>         compatible = "starfive,jh8100-dwmac",
>                      "starfive,jh7110-dwmac",
>                      "snps,dwmac-5.20";
>         ...
> };
> 
> Signed-off-by: Tan Chun Hau <chunhau.tan@starfivetech.com>
> ---
>  .../bindings/net/starfive,jh7110-dwmac.yaml   | 28 +++++++++++++++----
>  1 file changed, 23 insertions(+), 5 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>



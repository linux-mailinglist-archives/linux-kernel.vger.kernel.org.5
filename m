Return-Path: <linux-kernel+bounces-120014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD4C88D024
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 512301F8157A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FBD13D881;
	Tue, 26 Mar 2024 21:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uVWgwjD4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D7B13D617;
	Tue, 26 Mar 2024 21:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711488869; cv=none; b=T381LPqvt9p52GdLUtZ8qaYqvW82ro9uclLkx+1lMCO0ObMdAfxnn0nuywrF7QOGGyI6+tRZXI0uoS6wmSSp1qkw9BVZroFpyDyLOFposD9zsrHM1r/sMlaKiLjhcf9qwiowCgE4giVGKOGqRFh7cHsrbEhNiXv1IHSAcO+8kBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711488869; c=relaxed/simple;
	bh=Vp6QKMZSyuFN03oJX7Gy9S9p6P3Gg6AmCMANf0QxqRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEab04GCe6qZf4qKJRRlE/zJ7PPtV2s01Vxak59MyWhvaL7plYZh16aTe1ilxdYny2fDRxgMkuswBgXaz/5SOUv9/Tn9S+31lsuif9muUSCQLxjmepMrllCWSL6NF3Mew2PkBgKLsys975ryI2b+BnXXpz6W3scyG8Xbp/NiSJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uVWgwjD4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA317C433F1;
	Tue, 26 Mar 2024 21:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711488869;
	bh=Vp6QKMZSyuFN03oJX7Gy9S9p6P3Gg6AmCMANf0QxqRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uVWgwjD4ab3E4sy34QBQEECtoSaxU0lDFKM+AuYxrGjQDLJ7ob7m8hnlZuZNzlOol
	 IifXx+FbxLTbKOe7YjxDiXCmf9ZBJxPrQGdDoCeLjNclIMptnMvss13kozTFYBq9Pg
	 UDm9WJ/YA0Gr3J/h/+iLa2KcEJyTlyDn2hzrmXJM9wwXpi71SdFpP65ol8fLwYVQKU
	 FCWo5bRsnhzupCoRb3IaRJtY0rSxTqwnlU90H3lcdjgEAbTIc9Ml4q9L2wO4ku9Phq
	 xnGJB++507iw0UbYvg01+73b5wfIGwtjGGp28UwCJLYmrtwNIqqVmYYovJncsPRZ0p
	 n2L9EFIFukgKQ==
Date: Tue, 26 Mar 2024 16:34:26 -0500
From: Rob Herring <robh@kernel.org>
To: Tan Chun Hau <chunhau.tan@starfivetech.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Simon Horman <horms@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Andrew Halaney <ahalaney@redhat.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	Jee Heng Sia <jeeheng.sia@starfivetech.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 1/1] dt-bindings: net: starfive,jh7110-dwmac: Add
 StarFive JH8100 support
Message-ID: <20240326213426.GA3667606-robh@kernel.org>
References: <20240326052505.197408-1-chunhau.tan@starfivetech.com>
 <20240326052505.197408-2-chunhau.tan@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326052505.197408-2-chunhau.tan@starfivetech.com>

On Mon, Mar 25, 2024 at 10:25:05PM -0700, Tan Chun Hau wrote:
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
>  .../devicetree/bindings/net/snps,dwmac.yaml   |  1 +
>  .../bindings/net/starfive,jh7110-dwmac.yaml   | 54 ++++++++++++++-----
>  2 files changed, 41 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> index 6b0341a8e0ea..a6d596b7dcf4 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -97,6 +97,7 @@ properties:
>          - snps,dwxgmac-2.10
>          - starfive,jh7100-dwmac
>          - starfive,jh7110-dwmac
> +        - starfive,jh8100-dwmac
>  
>    reg:
>      minItems: 1
> diff --git a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
> index 0d1962980f57..ce018e9768d2 100644
> --- a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
> @@ -18,6 +18,7 @@ select:
>          enum:
>            - starfive,jh7100-dwmac
>            - starfive,jh7110-dwmac
> +          - starfive,jh8100-dwmac
>    required:
>      - compatible
>  
> @@ -30,6 +31,10 @@ properties:
>        - items:
>            - const: starfive,jh7110-dwmac
>            - const: snps,dwmac-5.20
> +      - items:
> +          - const: starfive,jh8100-dwmac
> +          - const: starfive,jh7110-dwmac
> +          - const: snps,dwmac-5.20
>  
>    reg:
>      maxItems: 1
> @@ -107,20 +112,41 @@ allOf:
>            contains:
>              const: starfive,jh7110-dwmac
>      then:
> -      properties:
> -        interrupts:
> -          minItems: 3
> -          maxItems: 3
> -
> -        interrupt-names:
> -          minItems: 3
> -          maxItems: 3

interrupts and interrupt-names are the same, so you can leave them here 
instead of duplicating them as you have.

> -
> -        resets:
> -          minItems: 2
> -
> -        reset-names:
> -          minItems: 2
> +      if:
> +        properties:
> +          compatible:
> +            contains:
> +              const: starfive,jh8100-dwmac
> +      then:
> +        properties:
> +          interrupts:
> +            minItems: 3
> +            maxItems: 3
> +
> +          interrupt-names:
> +            minItems: 3
> +            maxItems: 3
> +
> +          resets:
> +            maxItems: 1
> +
> +          reset-names:
> +            const: stmmaceth
> +      else:
> +        properties:
> +          interrupts:
> +            minItems: 3
> +            maxItems: 3
> +
> +          interrupt-names:
> +            minItems: 3
> +            maxItems: 3
> +
> +          resets:
> +            minItems: 2
> +
> +          reset-names:
> +            minItems: 2
>  
>  unevaluatedProperties: false
>  
> -- 
> 2.25.1
> 


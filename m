Return-Path: <linux-kernel+bounces-117460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B86FB88ABA2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E01029D584
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68D512F597;
	Mon, 25 Mar 2024 16:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M64/jWNf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA24912E1D9;
	Mon, 25 Mar 2024 16:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711383768; cv=none; b=VmOI9qnqBo5KulweJ6HeA9r0qIHRGmU5eVR0Nl3AxzJdjuZ5Jlgs8IVnnZR1sIV7w1pb6qiW/gpMEsG+kPCCKDlb6odOLcbOJ4NcVqA5Jj3AT4P6cUtlTrOIJGGa0+7PRnLke3XYl40raINpYMPZQXcrqgQuM9kzEgNSQY7mbfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711383768; c=relaxed/simple;
	bh=xE6KNpCOn2OEaSo250Fbx8HQD0Ki6bF5GBxHx8kHNfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oAhrRFxinyvyiVGwWX8Lzp88nise/4gr6HLDv+qZUXNicxD7midLiBG+vhvHq1c0G7+tuSOOnu2HfIP2buAPoxtnmQKs7rryhg9gjlRpvnvlHNXpfA5rM9Orm94n7U9d0aD/jsva43hthYXSlOgG7ZAa3k2yHHKLIJ9SnKINbGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M64/jWNf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E0D8C433C7;
	Mon, 25 Mar 2024 16:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711383767;
	bh=xE6KNpCOn2OEaSo250Fbx8HQD0Ki6bF5GBxHx8kHNfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M64/jWNfngnT3K2O0pepQWlnUxOW6YNPcpROJY1+gM/c8i3VywFpfoLk0JTo00PKW
	 iXf9f7G6lCML6+X9GtBSPg18JyUpmFZB/PMdRYUq1+iS4ioyDjuBjjSI4Mir22hRpF
	 1XPxZQjSvs0lak8qEx48f2iE8MCI35aAn3A3zr9SwvtBOEsbWUqJFSUneSB+yWu4hx
	 fS4pjsv6BfTmJPYkUo9LeFkuFdLoq42jOWyHOO3oU3J8O3BLHOKL3YintLT7xUkhxk
	 VyaH2lzmc8VzwK61/yHWMmumaF3jOWkFlb9vO9atzVOh8RPRImz5vS1PFa6i/ybMYl
	 AX0z34uS1hFuA==
Date: Mon, 25 Mar 2024 11:22:45 -0500
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
Subject: Re: [PATCH v3 1/1] dt-bindings: net: starfive,jh7110-dwmac: Add
 StarFive JH8100 support
Message-ID: <20240325162245.GA4167001-robh@kernel.org>
References: <20240325085131.182657-1-chunhau.tan@starfivetech.com>
 <20240325085131.182657-2-chunhau.tan@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325085131.182657-2-chunhau.tan@starfivetech.com>

On Mon, Mar 25, 2024 at 01:51:31AM -0700, Tan Chun Hau wrote:
> Add StarFive JH8100 dwmac support.
> The JH8100 dwmac shares the same driver code as the JH7110 dwmac
> and has only one reset signal.
> 
> Please refer to below:
> 
>   JH8100: reset-names = "stmmaceth";
>   JH7110: reset-names = "stmmaceth", "ahb";

It's debatable whether JH8100 is compatible with JH7110 if the 2nd reset 
was not optional. I guess if the Linux driver treated it that way, we 
can get away with it. It would simplify the conditionals in the schema 
if the schema also treated the 2nd entry as optional on JH7110 as well.


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
>  .../bindings/net/starfive,jh7110-dwmac.yaml   | 82 +++++++++++++------
>  2 files changed, 58 insertions(+), 25 deletions(-)
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
> index 0d1962980f57..da3cc984fec9 100644
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
> @@ -83,29 +88,13 @@ allOf:
>    - if:
>        properties:
>          compatible:
> -          contains:
> -            const: starfive,jh7100-dwmac
> -    then:
> -      properties:
> -        interrupts:
> -          minItems: 2
> -          maxItems: 2
> -
> -        interrupt-names:
> -          minItems: 2
> -          maxItems: 2
> -
> -        resets:
> -          maxItems: 1
> -
> -        reset-names:
> -          const: ahb
> -
> -  - if:
> -      properties:
> -        compatible:
> -          contains:
> -            const: starfive,jh7110-dwmac
> +          allOf:
> +            - contains:
> +                enum:
> +                  - starfive,jh8100-dwmac
> +            - contains:
> +                enum:
> +                  - starfive,jh7110-dwmac

There's no need for the 2nd entry. You just need to check

I would something like this structure:

  - if:
      properties:
        compatible:
          contains:
            const: starfive,jh7100-dwmac

    then:

      if:
        properties:
          compatible:
            contains:
              const: starfive,jh8100-dwmac
      then:
        ...
      else:
        ...


>      then:
>        properties:
>          interrupts:
> @@ -117,10 +106,53 @@ allOf:
>            maxItems: 3
>  
>          resets:
> -          minItems: 2
> +          maxItems: 1
>  
>          reset-names:
> -          minItems: 2
> +          const: stmmaceth
> +
> +    else:

I don't think you need the else. Just do another 'if' entry.

> +      if:
> +        properties:
> +          compatible:
> +            contains:
> +              const: starfive,jh7100-dwmac
> +      then:
> +        properties:
> +          interrupts:
> +            minItems: 2
> +            maxItems: 2
> +
> +          interrupt-names:
> +            minItems: 2
> +            maxItems: 2
> +
> +          resets:
> +            maxItems: 1
> +
> +          reset-names:
> +            const: ahb
> +
> +        if:
> +          properties:
> +            compatible:
> +              contains:
> +                const: starfive,jh7110-dwmac
> +        then:
> +          properties:
> +            interrupts:
> +              minItems: 3
> +              maxItems: 3
> +
> +            interrupt-names:
> +              minItems: 3
> +              maxItems: 3
> +
> +            resets:
> +              minItems: 2
> +
> +            reset-names:
> +              minItems: 2
>  
>  unevaluatedProperties: false
>  
> -- 
> 2.25.1
> 


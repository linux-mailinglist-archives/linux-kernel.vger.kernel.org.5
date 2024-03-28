Return-Path: <linux-kernel+bounces-123611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67ED3890BB8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DC5B1F28619
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AB213B2BF;
	Thu, 28 Mar 2024 20:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCKfMmIy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BE913AA38;
	Thu, 28 Mar 2024 20:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711658525; cv=none; b=tzgn/7uYHDxeee5lcq26Oz1M2kMY/JN9VZT4zNsbxnftmg8z75hK5kyNajJqYITc1j8hmCu24IsYcysHijEEkLQ44mGCI/Iv0tGwtppqcJqIeZWx/87wnwzf/llmACzpJBjUEQzax4CIXOapgWV+BMlBMxeruGUYAJNhQzbFOvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711658525; c=relaxed/simple;
	bh=rM8n3YOTnCn+b3NkFrXziIWASxMBnWFMCbr5eWXy4fQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lEX3L3ueLH/uCgtTzeYXtieO+AUFu9u3V5lzPewScz9XRFN6xZeA/+lsRqXtit851NdF2SavdP3CbGsvrB246uBCoRJDCuEu6AXqhDwHryLN52sN+Zv+0sL+3JugrUgp46BSdx6PnG33BqQxf5ExKHg4sPMxWuHaGM0KK2KqdfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCKfMmIy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 529E7C433F1;
	Thu, 28 Mar 2024 20:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711658524;
	bh=rM8n3YOTnCn+b3NkFrXziIWASxMBnWFMCbr5eWXy4fQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eCKfMmIyqhMxnN9hRe0xLCa/LyjUmNY2MvusUKazaWaaOAtQttZ2yJQppDwWNeWSY
	 8/9Ls0Cj8Vifsj0NXSNo3xnwcOutw9Hagr8f/fc5U7nulSiBYAIe/NQBWgbyaA95oW
	 HKVIQYpFXkB2emfilRKSPMLl5o+83DX8oI+Mtc1L1gglh25Q54dQDWr1tn6wB9YOoc
	 6EKhNwVL49ZanIg67nYxH/hPGKlRctXBAr81YlKk03TsOQyzSNJvRFTRCBkP5zsxox
	 w0WwuqDPSrXGdp1SYh1Oe4wYrRl7IsrX/R/x8N0IjC5ewjbCh7WHMAIJ8d5W8PB9uY
	 bhjFQ8EACrNwA==
Date: Thu, 28 Mar 2024 15:42:02 -0500
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Tan Chun Hau <chunhau.tan@starfivetech.com>,
	"David S . Miller" <davem@davemloft.net>,
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
Subject: Re: [PATCH v5 1/1] dt-bindings: net: starfive,jh7110-dwmac: Add
 StarFive JH8100 support
Message-ID: <20240328204202.GA308290-robh@kernel.org>
References: <20240327015750.226349-1-chunhau.tan@starfivetech.com>
 <20240327015750.226349-2-chunhau.tan@starfivetech.com>
 <31ac366d-bfa6-4c99-a04d-ab9fb029da7e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31ac366d-bfa6-4c99-a04d-ab9fb029da7e@linaro.org>

On Wed, Mar 27, 2024 at 08:54:30AM +0100, Krzysztof Kozlowski wrote:
> On 27/03/2024 02:57, Tan Chun Hau wrote:
> > Add StarFive JH8100 dwmac support.
> > The JH8100 dwmac shares the same driver code as the JH7110 dwmac
> > and has only one reset signal.
> > 
> > Please refer to below:
> > 
> >   JH8100: reset-names = "stmmaceth";
> >   JH7110: reset-names = "stmmaceth", "ahb";
> >   JH7100: reset-names = "ahb";
> > 
> > Example usage of JH8100 in the device tree:
> > 
> > gmac0: ethernet@16030000 {
> >         compatible = "starfive,jh8100-dwmac",
> >                      "starfive,jh7110-dwmac",
> >                      "snps,dwmac-5.20";
> >         ...
> > };
> > 
> > Signed-off-by: Tan Chun Hau <chunhau.tan@starfivetech.com>
> > ---
> >  .../devicetree/bindings/net/snps,dwmac.yaml   |  1 +
> >  .../bindings/net/starfive,jh7110-dwmac.yaml   | 29 +++++++++++++++----
> >  2 files changed, 25 insertions(+), 5 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > index 6b0341a8e0ea..a6d596b7dcf4 100644
> > --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > @@ -97,6 +97,7 @@ properties:
> >          - snps,dwxgmac-2.10
> >          - starfive,jh7100-dwmac
> >          - starfive,jh7110-dwmac
> > +        - starfive,jh8100-dwmac
> 
> I think that's not needed. You have there already your fallback.
> 
> >  
> >    reg:
> >      minItems: 1
> > diff --git a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
> > index 0d1962980f57..5805a58c55d1 100644
> > --- a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
> > +++ b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
> > @@ -18,6 +18,7 @@ select:
> >          enum:
> >            - starfive,jh7100-dwmac
> >            - starfive,jh7110-dwmac
> > +          - starfive,jh8100-dwmac
> 
> Same here, even more obvious.

Agreed.

> 
> >    required:
> >      - compatible
> >  
> > @@ -30,6 +31,10 @@ properties:
> >        - items:
> >            - const: starfive,jh7110-dwmac
> >            - const: snps,dwmac-5.20
> > +      - items:
> > +          - const: starfive,jh8100-dwmac
> > +          - const: starfive,jh7110-dwmac
> > +          - const: snps,dwmac-5.20
> >  
> >    reg:
> >      maxItems: 1
> > @@ -116,11 +121,25 @@ allOf:
> >            minItems: 3
> >            maxItems: 3
> >  
> > -        resets:
> > -          minItems: 2
> > -
> > -        reset-names:
> > -          minItems: 2
> > +      if:
> 
> I would personally avoid nesting if within if. It gets unreadable.
> Although Rob did not comment on this one, so I guess it is fine.

I normally agree, but here I suggested it as it looked to be the 
simplest option.

With the 2 other comments addressed,

Reviewed-by: Rob Herring <robh@kernel.org>


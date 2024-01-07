Return-Path: <linux-kernel+bounces-18976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B08E48265E5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 21:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DA8F281A4F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 20:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7166911709;
	Sun,  7 Jan 2024 20:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXTDcXzC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3722011703;
	Sun,  7 Jan 2024 20:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50e7c6e3c63so960731e87.3;
        Sun, 07 Jan 2024 12:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704658240; x=1705263040; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qaJWomBUGOWZwKBbr+CxKGUdDqR+QRKmIC9Sup/5TvM=;
        b=ZXTDcXzCM2+6XcE1UwNNpnoxU9G+73yEMgMxcdYOnkra7HaGgVYp4UODcWup113F/b
         jab1vTMLrZEZrg9n4zcd9nKC5k+OD71NA0emCEZsZ5Yb89MSXlLUdB3yEi8Ma0ODPwGA
         AHEBXQUa88okX6hTEkWDZ5vmts6jpYkpTkUGIhWDNWSt/f3vngjiulh7fglYHUa5AvJm
         FzMfjR3M0TOHU0SPsXWGIwyF4+ZxLyIBHDjHcKSFAl0AZx9wcaw7duMgakvbzocutI60
         gyq2FPlloo+0Gfnp6bAl0JnCO/IBEWDAbZi+rd1Keme286HGFGzpTwyzmt7qYNeyBq8k
         hy5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704658240; x=1705263040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qaJWomBUGOWZwKBbr+CxKGUdDqR+QRKmIC9Sup/5TvM=;
        b=XcTBKAfeRlKYpLUaUvv32Vg6V3PYDaEWRYb4kBUXTXoAQ4WxPxpdXsdPLvLFljw7BD
         PVM8YmBPHc8xpmrL05oT42DN38JW4ntn+RrpRi38IGsD8o7tdrxORmNXSE+DagZjgL8X
         OO7kIzzd/vGjvjL11b6wi7jcqSqPcLtOPWTJ4bmZADsYaV9z2xCX13l6cKfolfiRtED3
         xS2yJFHXN2AMRMGYClnOPYF5LdW26WXoZpkSiC8+uXRRRZpj10NvSPbp5dtST+0JxJFd
         E8OL4GH7H7CGHadA7FvEpM5jTZgnWhz1taqVB8341sRJkvjq4Gi+igpdBxG3uk1WwGOp
         RQag==
X-Gm-Message-State: AOJu0YwaDmFFeZ/63Q8D+uQqLQPAcdBYYMt8fGT2DXiS/XBPVSkWgu/Z
	GHMtpREgQ5c1ZcC2QlFpZHc=
X-Google-Smtp-Source: AGHT+IHEMxvk5VzwBbMSWTolLmXZcJe6Lp63iVd4NJJuLqphj6cRpR5nB+giIsXfwHs1cD7VFOpheQ==
X-Received: by 2002:ac2:4dac:0:b0:50e:305c:25fb with SMTP id h12-20020ac24dac000000b0050e305c25fbmr406141lfe.216.1704658240025;
        Sun, 07 Jan 2024 12:10:40 -0800 (PST)
Received: from mobilestation ([95.79.203.166])
        by smtp.gmail.com with ESMTPSA id w3-20020ac254a3000000b0050e7e8644c3sm914216lfk.289.2024.01.07.12.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jan 2024 12:10:39 -0800 (PST)
Date: Sun, 7 Jan 2024 23:10:37 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Leong Ching Swee <leong.ching.swee@intel.com>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, Rohan G Thomas <rohan.g.thomas@intel.com>
Subject: Re: [PATCH net-next v2 1/4] dt-bindings: net: snps,dwmac: per
 channel irq
Message-ID: <ffiewfybqvh66nmri4im4veupwytvlxk5jfgdy3nbj6wldxjl2@2vwvnnu37pt7>
References: <20240105070925.2948871-1-leong.ching.swee@intel.com>
 <20240105070925.2948871-2-leong.ching.swee@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105070925.2948871-2-leong.ching.swee@intel.com>

On Fri, Jan 05, 2024 at 03:09:22PM +0800, Leong Ching Swee wrote:
> From: Swee Leong Ching <leong.ching.swee@intel.com>
> 
> Add dt-bindings for per channel irq.
> 
> Signed-off-by: Rohan G Thomas <rohan.g.thomas@intel.com>
> Signed-off-by: Swee Leong Ching <leong.ching.swee@intel.com>
> ---
>  .../devicetree/bindings/net/snps,dwmac.yaml   | 24 +++++++++++++------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> index 5c2769dc689a..e72dded824f4 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -103,17 +103,27 @@ properties:
>  
>    interrupts:
>      minItems: 1
> -    items:
> -      - description: Combined signal for various interrupt events
> -      - description: The interrupt to manage the remote wake-up packet detection
> -      - description: The interrupt that occurs when Rx exits the LPI state
> +    maxItems: 19
>  
>    interrupt-names:
>      minItems: 1
> +    maxItems: 19
>      items:
> -      - const: macirq
> -      - enum: [eth_wake_irq, eth_lpi]
> -      - const: eth_lpi
> +      oneOf:
> +        - description: Combined signal for various interrupt events
> +          const: macirq
> +        - description: The interrupt to manage the remote wake-up packet detection
> +          const: eth_wake_irq
> +        - description: The interrupt that occurs when Rx exits the LPI state
> +          const: eth_lpi
> +        - description: DMA Tx per-channel interrupt
> +          pattern: '^dma_tx[0-7]?$'
> +        - description: DMA Rx per-channel interrupt
> +          pattern: '^dma_rx[0-7]?$'
> +
> +    allOf:
> +      - contains:
> +          const: macirq

In order to restore the v1 discussion around this change, here is my
comment copied from there:

> As Rob correctly noted it's also better to make sure that 'macirq' is placed first
> in the array. So instead of the constraint above I guess the next one would
> make sure both the array has 'macirq' name and it's the first item:
>
> allOf:
>   - maxItems: 34
>     items:
>       - const: macirq

Leong said it didn't work:
https://lore.kernel.org/netdev/CH0PR11MB54904615B45E521DE6B1A7B3CF61A@CH0PR11MB5490.namprd11.prod.outlook.com/

Rob, Krzysztof, Conor could you please clarify whether this change is ok the
way it is or it would be better to preserve the stricter constraint
and fix the DT-schema validation tool somehow?

-Serge(y)

>  
>    clocks:
>      minItems: 1
> -- 
> 2.34.1
> 
> 


Return-Path: <linux-kernel+bounces-157631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE418B13D6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 804161C2284F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A58B13C68C;
	Wed, 24 Apr 2024 19:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTTcczTr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6F513AA3C;
	Wed, 24 Apr 2024 19:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713988401; cv=none; b=QiAoFxonruzAzcbNeQA2P7UzZdv5ondbKLuIvBqbE6aqx+Mm/hGUTadFEY434x90HoHky9NWmf4zkj3XnUN1Eyl6IyG3db+qtac5x+duVOfI9EqB3y/F+bl7ARgKJSYm1C4v5X86SczzOTzqdQwIDUDPmBLS3aQtqQhQdzCqofk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713988401; c=relaxed/simple;
	bh=HZkky1K43bSZGSblXrPp3EAM8NlSsdMp1ndHmpJJXwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9sre4X63L8JWcpCzYErGtvkide1MuY7ZO0gxpgJW5AIE37SdYatd9t7WNx6meKxNoGogjTMYoM4hIsV0dvmMLcK27AtpTfj0bTFlDszFldAwLb8SWtgFTbbYuSsZhkDWDy8CQ2+vKZ1Rwhc1lgu0y37BbjgTk4/0hYp7bo8nLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTTcczTr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C2DC113CD;
	Wed, 24 Apr 2024 19:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713988401;
	bh=HZkky1K43bSZGSblXrPp3EAM8NlSsdMp1ndHmpJJXwQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NTTcczTrGnFaxAa1kcfspxMTN3/ePhg12mnST33XA49fFlgQuXuSnkLe26jrPzCQC
	 J1oxZAICxWCxa0bAApRRhf6JBaQ298OaMehmKj74FeKFuCnfBNpYeswE9haIIg+jmz
	 Q/QZUKJAI7MbPzLLi+8YOH+Xfv/R053F0CiIy/BzGEVmHB91IganAP727lrF/IA+R6
	 bm6D3XwKX35MsHWKr/tUh/MtpWNiq3t9KVNMlP07PO0lnGKkPp7XTeEu+B8yu+Hzin
	 AiV94wDgJFifjC7MInUtd5m20iQLLKrdS+4QKpuas+p82FqLW4tgeDwJsB8Tm5FSZ3
	 3Ak4vINNx/EJw==
Date: Wed, 24 Apr 2024 14:53:18 -0500
From: Rob Herring <robh@kernel.org>
To: Peter Griffin <peter.griffin@linaro.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, vkoul@kernel.org, kishon@kernel.org,
	alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
	s.nawrocki@samsung.com, cw00.choi@samsung.com, jejb@linux.ibm.com,
	martin.petersen@oracle.com, James.Bottomley@hansenpartnership.com,
	ebiggers@kernel.org, linux-scsi@vger.kernel.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	tudor.ambarus@linaro.org, andre.draszik@linaro.org,
	saravanak@google.com, willmcvicker@google.com
Subject: Re: [PATCH v2 03/14] dt-bindings: ufs: exynos-ufs: Add gs101
 compatible
Message-ID: <20240424195318.GA367166-robh@kernel.org>
References: <20240423205006.1785138-1-peter.griffin@linaro.org>
 <20240423205006.1785138-4-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423205006.1785138-4-peter.griffin@linaro.org>

On Tue, Apr 23, 2024 at 09:49:55PM +0100, Peter Griffin wrote:
> Add dedicated google,gs101-ufs compatible for Google Tensor gs101
> SoC.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  .../bindings/ufs/samsung,exynos-ufs.yaml      | 38 +++++++++++++++++--
>  1 file changed, 35 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml b/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml
> index b2b509b3944d..1179527d29d1 100644
> --- a/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml
> +++ b/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml
> @@ -12,12 +12,10 @@ maintainers:
>  description: |
>    Each Samsung UFS host controller instance should have its own node.
>  
> -allOf:
> -  - $ref: ufs-common.yaml
> -
>  properties:
>    compatible:
>      enum:
> +      - google,gs101-ufs
>        - samsung,exynos7-ufs
>        - samsung,exynosautov9-ufs
>        - samsung,exynosautov9-ufs-vh
> @@ -38,14 +36,24 @@ properties:
>        - const: ufsp
>  
>    clocks:
> +    minItems: 2
>      items:
>        - description: ufs link core clock
>        - description: unipro main clock
> +      - description: fmp clock
> +      - description: ufs aclk clock
> +      - description: ufs pclk clock
> +      - description: sysreg clock
>  
>    clock-names:
> +    minItems: 2
>      items:
>        - const: core_clk
>        - const: sclk_unipro_main
> +      - const: fmp
> +      - const: ufs_aclk
> +      - const: ufs_pclk

'ufs_' is redundant.

> +      - const: sysreg
>  
>    phys:
>      maxItems: 1
> @@ -72,6 +80,30 @@ required:
>    - clocks
>    - clock-names
>  
> +allOf:
> +  - $ref: ufs-common.yaml
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: google,gs101-ufs
> +
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 6
> +
> +        clock-names:
> +          minItems: 6
> +
> +    else:
> +      properties:
> +        clocks:
> +          maxItems: 2
> +
> +        clock-names:
> +          maxItems: 2
> +
>  unevaluatedProperties: false
>  
>  examples:
> -- 
> 2.44.0.769.g3c40516874-goog
> 


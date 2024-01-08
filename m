Return-Path: <linux-kernel+bounces-20058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B048278D2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 052761C22EC4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D7C54FB5;
	Mon,  8 Jan 2024 19:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byx30lTj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B467F55C10;
	Mon,  8 Jan 2024 19:59:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E9DC433C8;
	Mon,  8 Jan 2024 19:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704743940;
	bh=f29NR9MAWVjCDyn/MbeDD98XbHXmd6KpipbtrQODkYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=byx30lTjWW7I2tbCrnCBwOs8/77H/g7oT+9KwXCn64R7j3LxUbDHirurOo0CWv06k
	 SdeSgHz2spp26eS006ixX052ZjXOYDCVvbIg4VhU0Ts2bi2YKsILGxnocmRDMzR/dO
	 fV9lJug4nmflknc9DDlatdGQ8WhRm5yrU6pqIhfi0f7MFElIXxyZ4LIBHlUZM2r8JH
	 EyIHmIXnHgHImocleXUEhRVN8dmqa7G9SKiQq1dLhAb3EBGgpw32rtAq6Ccwse6W1n
	 iOPt826kcZg5Nvo37TuMbcujTvSD6AI0j0MIgRQDEzYsJ4L3FkyVknRY+VGulGgxgF
	 5t0llNtVvIKGA==
Received: (nullmailer pid 2013297 invoked by uid 1000);
	Mon, 08 Jan 2024 19:58:57 -0000
Date: Mon, 8 Jan 2024 12:58:57 -0700
From: Rob Herring <robh@kernel.org>
To: Petlozu Pravareshwar <petlozup@nvidia.com>
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, p.zabel@pengutronix.de, dmitry.osipenko@collabora.com, ulf.hansson@linaro.org, kkartik@nvidia.com, cai.huoqing@linux.dev, spatra@nvidia.com, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: tegra: pmc: Update scratch as an
 optional aperture
Message-ID: <20240108195857.GA1959040-robh@kernel.org>
References: <20240106075134.3933491-1-petlozup@nvidia.com>
 <20240106075134.3933491-2-petlozup@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240106075134.3933491-2-petlozup@nvidia.com>

On Sat, Jan 06, 2024 at 07:51:33AM +0000, Petlozu Pravareshwar wrote:
> Scratch address space register is used to store reboot reason. For
> some Tegra234 systems, the scratch space is not available to store
> the reboot reason. This is because scratch region on these systems
> is not accessible by the kernel as restricted by the Hypervisor.
> Such systems would delist scratch aperture from PMC DT node.
> 
> Accordingly, this change makes "scratch" as an optional aperture for
> Tegra234 in PMC dt-binding document.
> 
> Signed-off-by: Petlozu Pravareshwar <petlozup@nvidia.com>
> ---
>  .../arm/tegra/nvidia,tegra186-pmc.yaml        | 83 +++++++++++++------
>  1 file changed, 58 insertions(+), 25 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.yaml
> index 0faa403f68c8..2716610a1a02 100644
> --- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.yaml
> +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.yaml
> @@ -23,12 +23,7 @@ properties:
>  
>    reg-names:
>      minItems: 4
> -    items:
> -      - const: pmc
> -      - const: wake
> -      - const: aotag
> -      - const: scratch
> -      - const: misc
> +    maxItems: 5

You can just make the 4th entry: enum: [ scratch, misc ]

>  
>    interrupt-controller: true
>  
> @@ -41,25 +36,63 @@ properties:
>      description: If present, inverts the PMU interrupt signal.
>      $ref: /schemas/types.yaml#/definitions/flag
>  
> -if:
> -  properties:
> -    compatible:
> -      contains:
> -        const: nvidia,tegra186-pmc
> -then:
> -  properties:
> -    reg:
> -      maxItems: 4
> -
> -    reg-names:
> -      maxItems: 4
> -else:
> -  properties:
> -    reg:
> -      minItems: 5
> -
> -    reg-names:
> -      minItems: 5
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: nvidia,tegra186-pmc
> +    then:
> +      properties:
> +        reg:
> +          maxItems: 4
> +        reg-names:
> +          items:
> +            - const: pmc
> +            - const: wake
> +            - const: aotag
> +            - const: scratch
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: nvidia,tegra194-pmc
> +    then:
> +      properties:
> +        reg:
> +          minItems: 5
> +        reg-names:
> +          items:
> +            - const: pmc
> +            - const: wake
> +            - const: aotag
> +            - const: scratch
> +            - const: misc
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: nvidia,tegra234-pmc
> +    then:
> +      properties:
> +        reg:
> +          minItems: 4
> +          maxItems: 5
> +        reg-names:
> +          anyOf:
> +           - items:
> +               - const: pmc
> +               - const: wake
> +               - const: aotag
> +               - const: misc
> +           - items:
> +               - const: pmc
> +               - const: wake
> +               - const: aotag
> +               - const: scratch
> +               - const: misc
>  
>  patternProperties:
>    "^[a-z0-9]+-[a-z0-9]+$":
> -- 
> 2.17.1
> 


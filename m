Return-Path: <linux-kernel+bounces-66481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8CE855D50
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B87028358E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7FE179BD;
	Thu, 15 Feb 2024 09:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EjriM654"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5972C17735;
	Thu, 15 Feb 2024 08:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707987600; cv=none; b=I9xbPIZuwIsr2i9vdlpm+c6avmp3YBKZZ9ZXElTLZ031EPI8hn0tcXOfdpYnyhtShTWo2jqKZzLDCLAxe360Q3gOR+Scrri5BUE1OH3jOpN6Jlv38JNaopcRXCiwqkSugVGtJpsQbQG/8qwQwRQnA3LhhxbV2VFYWKL+VTi6/Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707987600; c=relaxed/simple;
	bh=8sH34bcCAfPZ6BcBe3vhl8Ve/pfsgVLRkkldwF3b2SQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0vfBwd4iMzGgw4N/cQ7ZupgADBJXOv0vNmom/t9EotcaP9PjyeHTWb6d7+LMdwBBU7hd9vhpFwIMI/e3sdUHp1I73j92wB1FRdQp3Yw8Fy7otCAb1KUNIq5jXV7nKbajaWE59VCpsmb6t3KKPoI2xwfbfBifXwZ0wETSa/saJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EjriM654; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41F8xqmf069807;
	Thu, 15 Feb 2024 02:59:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707987592;
	bh=E4nYCjg/IPqoS28GVxV+kUtpflsdAduZL2xQjVyGLGI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=EjriM654oGVCvwWDwLs5Z1tIlb6D0RRJY+o1JzSTc1iHFTBUWvfi31bZDwy1tT4gI
	 s2FqZ0cue4phw+i9eNCpDOrk+LN+TFLzhfBMIQPd9PrDHnJki8ULnL2fHOr06BfF8B
	 SKMRy/6TXegaAaTpzKcZokUzwNhUbaWFdL18Z30A=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41F8xqor009209
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 Feb 2024 02:59:52 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Feb 2024 02:59:52 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Feb 2024 02:59:52 -0600
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41F8xpJk013744;
	Thu, 15 Feb 2024 02:59:52 -0600
Date: Thu, 15 Feb 2024 14:29:51 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
CC: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen
 Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo
	<kristo@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>, Andrew Davis
	<afd@ti.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/3] dt-bindings: cpufreq: Add nvmem-cells for chip
 information
Message-ID: <20240215085951.xrcitu2so5gqcewn@dhruva>
References: <20240206145721.2418893-1-msp@baylibre.com>
 <20240206145721.2418893-2-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240206145721.2418893-2-msp@baylibre.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi,

On Feb 06, 2024 at 15:57:19 +0100, Markus Schneider-Pargmann wrote:
> Add nvmem-cells to describe chip information like chipvariant and
> chipspeed. If nvmem-cells are used, the syscon property is not necessary
> anymore.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Acked-by: Andrew Davis <afd@ti.com>
> ---
>  .../bindings/opp/operating-points-v2-ti-cpu.yaml | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml b/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml
> index 02d1d2c17129..b1881a0834fe 100644
> --- a/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml
> +++ b/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml
> @@ -34,6 +34,14 @@ properties:
>        points to syscon node representing the control module
>        register space of the SoC.
>  
> +  nvmem-cells:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +
> +  nvmem-cell-names:
> +    items:
> +      - const: chipvariant
> +      - const: chipspeed
> +
>    opp-shared: true
>  
>  patternProperties:
> @@ -55,7 +63,13 @@ patternProperties:
>  
>  required:
>    - compatible
> -  - syscon
> +
> +oneOf:
> +  - required:
> +      - syscon
> +  - required:
> +      - nvmem-cells
> +      - nvmem-cell-names

Reviewed-by: Dhruva Gole <d-gole@ti.com>


-- 
Best regards,
Dhruva Gole <d-gole@ti.com>


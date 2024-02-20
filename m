Return-Path: <linux-kernel+bounces-72848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F89C85B973
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05D45283AEC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA85657B2;
	Tue, 20 Feb 2024 10:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NNlB6rSJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA00860EE5;
	Tue, 20 Feb 2024 10:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708425992; cv=none; b=UFxYaO84ZQmLIJqhIDu75TaO0cDOAEJB1hYZFk8G7bZ3Oj1jMFG8whpY1CJLSN5BHEYr4Xe95hqMejsk5shnXFEFlNOgIJuXxhvtLlp4GtYNyfC/jBc9OKgbxpYN39McnoAUJoN/uYCYILmGZjJDEI3eid9ATR1wRVBcKl/475c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708425992; c=relaxed/simple;
	bh=0BaN5b0acVSXjoKH/PRX1OeiSJgeM2rOSR57jqkTsVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uF/KpdMrD/TLZCTbPbXC3ceXHopKRNwCnqTY+4iSN8c2aq/ldslGeHWiUrd0LfZCgHa85ZZ26FrqbSKjRK+glfypSB4mZbGNUQ+qtdfAsr21sFEQipEQxX+p4U5UY7T1Kty8xqg8UIBldSQscWoMg8udg5mfSJUyLuJc8q/DnzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NNlB6rSJ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708425991; x=1739961991;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0BaN5b0acVSXjoKH/PRX1OeiSJgeM2rOSR57jqkTsVM=;
  b=NNlB6rSJRKEh1gmrp7B5V6h6S0AM+jRriwaIMIwVkeZKbJHphly6ybXD
   0mhz9jjMeE2Kl84RfIE4vVG/ESX3YyYwUFJsFQtZFnlBs/CRS6f04EavY
   4fOn1u/K+6ankqUyQu/QtKvyFqxAlOmOdz3sgaA+NqxSCJCX+UD+5d7eL
   CplcfkUu9mhSV52fq3T3fotzFo7zNh5CyiaAXOUprHR6jlAmoqh+ypB+b
   sEh/P55a6LMOte1oGUWxSAPahFzIInoAS5yi6sS67ByCOMCXAVMctLGV2
   upRUdzJCWS+FijwfA9d0NhUiotKDUzmhC8WIWdvmdLFHtNsnbPG68KaMp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="6339045"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="6339045"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 02:46:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="35505682"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 02:46:27 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id CC1C011F7E1;
	Tue, 20 Feb 2024 12:46:23 +0200 (EET)
Date: Tue, 20 Feb 2024 10:46:23 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Alain Volmat <alain.volmat@foss.st.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-media@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
	Pavel Machek <pavel@ucw.cz>,
	Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: Re: [PATCH 1/2] dt-bindings: media: i2c: add galaxycore,gc2145 DVP
 bus support
Message-ID: <ZdSC_xulFQ84TtLT@kekkonen.localdomain>
References: <20240217220308.594883-1-andrej.skvortzov@gmail.com>
 <20240217220308.594883-2-andrej.skvortzov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240217220308.594883-2-andrej.skvortzov@gmail.com>

Hi Andrey,

Thanks for the patchset.

On Sun, Feb 18, 2024 at 01:03:07AM +0300, Andrey Skvortsov wrote:
> Don't require link-frequencies like it's done for ov5640, that
> supports both CSI-2 and DVP. And v4l2_fwnode_endpoint_alloc_parse
> ignores link-frequencies property for DVP endpoint. It's used only for
> CSI-2 endpoints
> 
> Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> ---
>  .../bindings/media/i2c/galaxycore,gc2145.yaml | 33 +++++++++++++++++--
>  1 file changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml b/Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml
> index 1726ecca4c77..fb376b9d0f2a 100644
> --- a/Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml
> +++ b/Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml
> @@ -61,9 +61,6 @@ properties:
>          properties:
>            link-frequencies: true
>  
> -        required:
> -          - link-frequencies

That seems like a bad idea to me.

While for parallel interface it may not be often important, for CSI-2 it
should stay.

> -
>      required:
>        - endpoint
>  
> @@ -110,4 +107,34 @@ examples:
>          };
>      };
>  
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        camera@3c {
> +            compatible = "galaxycore,gc2145";
> +            reg = <0x3c>;
> +            clocks = <&clk_ext_camera>;
> +            iovdd-supply = <&scmi_v3v3_sw>;
> +            avdd-supply = <&scmi_v3v3_sw>;
> +            dvdd-supply = <&scmi_v3v3_sw>;
> +            powerdown-gpios = <&mcp23017 3 (GPIO_ACTIVE_LOW | GPIO_PUSH_PULL)>;
> +            reset-gpios = <&mcp23017 4 (GPIO_ACTIVE_LOW | GPIO_PUSH_PULL)>;
> +
> +            port {
> +                endpoint {
> +                    remote-endpoint = <&parallel_from_gc2145>;
> +                    bus-width = <8>;
> +                    hsync-active = <1>;
> +                    vsync-active = <1>;
> +                    data-active = <1>;
> +                    pclk-sample = <1>;

Are there defaults for these if there are no such properties?

> +                };
> +            };
> +        };
> +    };
> +
>  ...

-- 
Regards,

Sakari Ailus


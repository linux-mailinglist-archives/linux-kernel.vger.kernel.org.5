Return-Path: <linux-kernel+bounces-142737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7B38A2F80
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19A931C216D1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F67083CC8;
	Fri, 12 Apr 2024 13:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1F7xpqb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BB483CA6;
	Fri, 12 Apr 2024 13:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712928843; cv=none; b=YpD8JPru9WzdWCmDmFELdw/Tu9yKodXs3tMv5UeTZjYd16ogiOqEfhQRqVnNNH9bfWZO/PVU3s/EgKgDPbMz0gtqTLCU378dJgt5PJr+/umFN6Hi9/e3qmBZASSvzjzvXYVmoi9B1lDAwkZUDZ2EQfEeDrgipHR7GU4zW2dqY6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712928843; c=relaxed/simple;
	bh=H/5Y4943nz8CB9370bqXYhLtnrWjvViTVIaYI0FXTBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fYhy+rsKtAnQj+uYriEWfjS5g3Xe1FTYkAE6lki93JMPo/LJYrgPUIfqqCYsCZmeapLnNbFtq4KavkMA3w6LjG0zzyzlu9cEa2ggsg6wuaIW66Hin7qIErTV50I7hyfT0yKLhOu30T0v7ddr/u1KVpEA+nd7caaIBxJ54eYzaoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1F7xpqb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 782A1C113CC;
	Fri, 12 Apr 2024 13:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712928842;
	bh=H/5Y4943nz8CB9370bqXYhLtnrWjvViTVIaYI0FXTBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B1F7xpqbXMlsIlbhQv7f04ytdIJi1BFBq1mId+1PLQCCrBozo1jQcO9gVDvi0Wamx
	 KxXnTzXS/J4MiXbHcUEfJr67duV5rU+gMk51fR3uDKUg61QEAQCa0xRkbmzuHMbnX+
	 FAIgd/g7qFdkcV5Rlc6w95Ox2msXM53kgDrPX1QXLi4uTN2gQxv0iDwEUFdPYml+VH
	 hV5M4IiQy5iPlhy3ludusTZSeGDufHKT6GUgvSsSe8Ym+AWJPU/yQfTq5A53T60ALQ
	 t4uARCqvgIa9VztJ2iOCTqF/dsvkA+tm9ktM+y1rn98+MDhePmdQD+XZQV1phGnHIe
	 LMaZrzYb4KgTg==
Date: Fri, 12 Apr 2024 08:34:00 -0500
From: Rob Herring <robh@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Peng Fan <peng.fan@nxp.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/6] dt-bindings: firmware: add i.MX95 SCMI Extension
 protocol
Message-ID: <20240412133400.GA2282201-robh@kernel.org>
References: <20240412-imx95-bbm-misc-v2-v3-0-4380a4070980@nxp.com>
 <20240412-imx95-bbm-misc-v2-v3-2-4380a4070980@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412-imx95-bbm-misc-v2-v3-2-4380a4070980@nxp.com>

On Fri, Apr 12, 2024 at 06:47:08PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add i.MX SCMI Extension protocols bindings for:
>  - Battery Backed Module(BBM) Protocol
>    This contains persistent storage (GPR), an RTC, and the ON/OFF button.
>    The protocol can also provide access to similar functions implemented via
>    external board components.
>  - MISC Protocol.
>    This includes controls that are misc settings/actions that must be exposed
>    from the SM to agents. They are device specific and are usually define to
>    access bit fields in various mix block control modules, IOMUX_GPR, and other
>    GPR/CSR owned by the SM.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/firmware/arm,scmi.yaml     | 21 +++++++++++++
>  .../bindings/firmware/nxp,imx95-scmi.yaml          | 36 ++++++++++++++++++++++
>  2 files changed, 57 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> index 93fb7d05f849..fa2cc910c485 100644
> --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> @@ -247,6 +247,27 @@ properties:
>        reg:
>          const: 0x18
>  
> +  protocol@81:
> +    $ref: '#/$defs/protocol-node'
> +    unevaluatedProperties: false
> +
> +    properties:
> +      reg:
> +        const: 0x81
> +
> +  protocol@84:
> +    type: object
> +    anyOf:
> +      - allOf:
> +          - $ref: /schemas/firmware/nxp,imx95-scmi.yaml
> +          - $ref: '#/$defs/protocol-node'

If you put the ref under the protocol node, then it's 1 schema file per 
protocol per vendor. Also, we then have to list every possible protocol 
node here, and every one listed here will be valid for every vendor.  
What we discussed is putting the list of vendor protocol schemas at the 
top-level here and then the vendor schemas can list out all the protocol 
nodes.

Also, move "$ref: '#/$defs/protocol-node'" to nxp,imx95-scmi.yaml.

> +
> +    unevaluatedProperties: false
> +
> +    properties:
> +      reg:
> +        const: 0x84
> +
>  additionalProperties: false
>  
>  $defs:
> diff --git a/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi.yaml b/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi.yaml
> new file mode 100644
> index 000000000000..b84c4a53b78a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi.yaml
> @@ -0,0 +1,36 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2024 NXP
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/firmware/nxp,imx95-scmi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: i.MX95 System Control and Management Interface(SCMI) Vendor Protocols Extension
> +
> +maintainers:
> +  - Peng Fan <peng.fan@nxp.com>
> +
> +properties:
> +  nxp,wakeup-sources:
> +    description:
> +      Each entry consists of 2 integers, represents the source and electric signal edge
> +    items:
> +      items:
> +        - description: the wakeup source
> +        - description: the wakeup electric signal edge
> +    minItems: 1
> +    maxItems: 32
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +
> +if:
> +  properties:
> +    reg:
> +      const: 0x84

This schema is only included from protocol@84 node, so how can this be 
false?

> +then:
> +  properties:
> +    nxp,wakeup-sources: true
> +else:
> +  properties:
> +    nxp,wakeup-sources: false
> +
> +additionalProperties: true
> 
> -- 
> 2.37.1
> 


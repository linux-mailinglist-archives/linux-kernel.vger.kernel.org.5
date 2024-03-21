Return-Path: <linux-kernel+bounces-110167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0AF885B08
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3131BB254E5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BBE86269;
	Thu, 21 Mar 2024 14:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2KAZ0D3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB6684FBE;
	Thu, 21 Mar 2024 14:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711032149; cv=none; b=erpnzKoKp5x8H3tTNmdTDobXcG7vW8X7sINgTh78mHmtdNKZjXJRK4M+9qMCogGHaJVneN6N1+S8Jm12X1UkZphZ4j+CwAovseb8MqYJ2ZdMONS2DjquzJvMFM3u88njHi9CatKj6M9dlK3KTgYnLJpws9PIikZl1axgo2rqVFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711032149; c=relaxed/simple;
	bh=eCmOsrWn0vFoPh2l6bOYyx1AWFAxo0BkYpUu5K+u20o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mor0FCcO7rGhlV4ggF32008TvS6zsaNtKz3017alokPoEXzGHYNirHeSEqMnVos6ePnoKIObq2pOA/f+3JDma1FsmVNoTDNR5Nmhv4vnP9324KhHgCCZDPFAXR9BizkdBS3Bs5zWu/JsTktS98DOsLlbeE8B3Zfzw8Q7sWJIdVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2KAZ0D3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08D5C43330;
	Thu, 21 Mar 2024 14:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711032148;
	bh=eCmOsrWn0vFoPh2l6bOYyx1AWFAxo0BkYpUu5K+u20o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X2KAZ0D3Xtxnv8OsYsVu202OprZWKYS6nVtp75NTuw2qtG5JG7OdKdlb+mvYvOpYJ
	 2MKgxqYMC8QT1D+DnlVkvA/BnK26R6JFhtlknlsKgRtO9W3DgyGk1pUFCF1VyRPApE
	 ugFxgtieTtv7vJFX8tmzOBTBmKO/r+PuWT3atzqg6rXtzoixTbJIzPlDPj7XSgRDuw
	 gVHsTreKozoPmoROAQSD4Vz1XZzR1Nybo6yTLD2gT14qDB5b7MSwVUh9yA4k+pGuRQ
	 TEoFYmySo5HXc6pzc2sfQYV74BK6XXCJ4+mlEEvoT828OKhxAYjQGF/s+p01Agagwm
	 Kyb3v+2RKO4zg==
Date: Thu, 21 Mar 2024 09:42:26 -0500
From: Rob Herring <robh@kernel.org>
To: Tao Zhang <quic_taozha@quicinc.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Konrad Dybcio <konradybcio@gmail.com>,
	Mike Leach <mike.leach@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Jinlong Mao <quic_jinlmao@quicinc.com>,
	Leo Yan <leo.yan@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Tingwei Zhang <quic_tingweiz@quicinc.com>,
	Yuanfang Zhang <quic_yuanfang@quicinc.com>,
	Trilok Soni <quic_tsoni@quicinc.com>,
	Song Chai <quic_songchai@quicinc.com>,
	linux-arm-msm@vger.kernel.org, andersson@kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: arm: qcom,coresight-funnel: Add label
 for multi-ouput
Message-ID: <20240321144226.GA1689544-robh@kernel.org>
References: <1711009927-17873-1-git-send-email-quic_taozha@quicinc.com>
 <1711009927-17873-2-git-send-email-quic_taozha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1711009927-17873-2-git-send-email-quic_taozha@quicinc.com>

On Thu, Mar 21, 2024 at 04:32:04PM +0800, Tao Zhang wrote:
> Add new property "label" to label the source corresponding to the
> output connection. When the funnel supports multi-output, this
> property needs to be introduced to mark which source component a
> certain output connection corresponds to.
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> ---
>  .../arm/arm,coresight-dynamic-funnel.yaml     | 34 ++++++++++++++++---
>  1 file changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml
> index 44a1041cb0fc..cde62c286d29 100644
> --- a/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml
> +++ b/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml
> @@ -66,13 +66,39 @@ properties:
>          $ref: /schemas/graph.yaml#/properties/port
>  
>    out-ports:
> -    $ref: /schemas/graph.yaml#/properties/ports
> -    additionalProperties: false
> -
> +    type: object
>      properties:
> +      "#address-cells":
> +        const: 1
> +
> +      "#size-cells":
> +        const: 0
> +
>        port:
> +        type: object
> +
> +    patternProperties:
> +      '^port(@[0-7])?$':
> +        type: object
>          description: Output connection to CoreSight Trace bus
> -        $ref: /schemas/graph.yaml#/properties/port

Nope, now you have no constraints on port node properties. Please look 
at how other bindings are done to add properties on endpoint node.

> +
> +        patternProperties:
> +          "^endpoint(@[0-9a-f]+)?$":
> +            type: object
> +            properties:
> +              remote-endpoint:
> +                description: |
> +                  phandle to an 'endpoint' subnode of a remote device node.
> +                  $ref: /schemas/types.yaml#/definitions/phandle

Don't need this.

> +              label:
> +                description: Label the source corresponding to the output connection
> +                $ref: /schemas/types.yaml#/definitions/string

label already has a type.

As this node is an output, aren't you labeling what the destination is, 
not the "source"?

Why can't you look at the remote connection to identify what it is?


> +    oneOf:
> +      - required:
> +          - port
> +      - required:
> +          - "#address-cells"
> +          - "#size-cells"

The common schema that you removed handles this.

Rob


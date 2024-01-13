Return-Path: <linux-kernel+bounces-25170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 641EE82C8FD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 02:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAF3228448A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 01:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3461918EBD;
	Sat, 13 Jan 2024 01:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqvQYNpC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702381097D;
	Sat, 13 Jan 2024 01:55:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C371EC433F1;
	Sat, 13 Jan 2024 01:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705110959;
	bh=tD8IG8K67wmGBd7W0V7EQk7phCaD6jkAx+XmJvURp+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HqvQYNpC/lV84vyyd0xN0jSWmbHYqGKRe8KYTT81o6nVm0v90wwES24ZOMfXDvJxD
	 vkspXPaPXWEDj7cA/P/uQCcZKBd66x+v6Fv1+khUA4YIeIhusKJlFBt70ezSZ/RF4d
	 oRCKn7KQvW1PaInf2G7H//eqUUqNkP7OZL/SJf7JM+Lzti0Q4bJWwne3Do/HSMv72A
	 SUyo/k8ULEU426n3z5JLXv4T6wLyZ4o0rh21/McYvNaf+u8sFbZclreKx6VPlLpukt
	 p4X1kwWb7KDf6jyFMIjbB2oqW+605siQJR7BdJNHsxsvNzCncNUyES63zxFpsq8o9L
	 kiBbRRsuXIiJQ==
Date: Fri, 12 Jan 2024 19:55:56 -0600
From: Rob Herring <robh@kernel.org>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: jdelvare@suse.com, linux@roeck-us.net,
	krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
	corbet@lwn.net, thierry.reding@gmail.com,
	u.kleine-koenig@pengutronix.de, p.zabel@pengutronix.de,
	naresh.solanki@9elements.com, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org,
	BMC-SW@aspeedtech.com, patrick@stwcx.xyz
Subject: Re: [PATCH v12 2/3] dt-bindings: hwmon: Support Aspeed g6 PWM TACH
 Control
Message-ID: <20240113015556.GA3829553-robh@kernel.org>
References: <20240108074348.735014-1-billy_tsai@aspeedtech.com>
 <20240108074348.735014-3-billy_tsai@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108074348.735014-3-billy_tsai@aspeedtech.com>

On Mon, Jan 08, 2024 at 03:43:47PM +0800, Billy Tsai wrote:
> Document the compatible for aspeed,ast2600-pwm-tach device, which can
> support up to 16 PWM outputs and 16 fan tach input.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  .../bindings/hwmon/aspeed,g6-pwm-tach.yaml    | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml b/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
> new file mode 100644
> index 000000000000..c615fb10705c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2023 Aspeed, Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/aspeed,g6-pwm-tach.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ASPEED G6 PWM and Fan Tach controller
> +
> +maintainers:
> +  - Billy Tsai <billy_tsai@aspeedtech.com>
> +
> +description: |
> +  The ASPEED PWM controller can support up to 16 PWM outputs.
> +  The ASPEED Fan Tacho controller can support up to 16 fan tach input.
> +  They are independent hardware blocks, which are different from the
> +  previous version of the ASPEED chip.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2600-pwm-tach
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  "#pwm-cells":
> +    const: 3
> +
> +patternProperties:
> +  "^fan-[0-9]+$":
> +    $ref: fan-common.yaml#
> +    unevaluatedProperties: false
> +    required:
> +      - tach-ch
> +
> +required:
> +  - reg
> +  - clocks
> +  - resets
> +  - "#pwm-cells"
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/aspeed-clock.h>
> +    pwm_tach: pwm-tach-controller@1e610000 {
> +      compatible = "aspeed,ast2600-pwm-tach";
> +      reg = <0x1e610000 0x100>;
> +      clocks = <&syscon ASPEED_CLK_AHB>;
> +      resets = <&syscon ASPEED_RESET_PWM>;
> +      #pwm-cells = <3>;
> +
> +      fan-0 {
> +        tach-ch = /bits/ 8 <0x0>;
> +      };
> +
> +      fan-1 {
> +        tach-ch = /bits/ 8 <0x1 0x2>;
> +      };

NAK on this based on how you are using pwm-fan in v10 discussion. See my 
comments there.

Rob


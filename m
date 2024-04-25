Return-Path: <linux-kernel+bounces-158872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A868B260F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 195A2B2325B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37CC14C59C;
	Thu, 25 Apr 2024 16:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9jx071Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2448614C5BF;
	Thu, 25 Apr 2024 16:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714061497; cv=none; b=aCI8nm5GJipqYJ3XEljGM229NfaLB0p3IMHTUZDPrH0WEmWf/CvyCELgGdlMqVCIK43dFrv580H2Q7mnrKiXaCyK6A5oKypebfphW9uWW6xJmnwzwuMo103WbYfbhE0H3lQPsy5LQuLUoeCOuKR9YwuTXWpsfSeYllTv+IkCKVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714061497; c=relaxed/simple;
	bh=ho12mLf87MAZYvf64xJHQvB9LOeFouGnTfDbUPjBnlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVny7zPyM2an7MNRL3VaNXx6M8asck4H+t1yG2DvJrXJ1qEWxyyLetDyNnr8lv0N4pUCQXx5FZYhuvU47RDjiIQjRJ3K8JbEfrm2iEaFUdEgfqbPBjfplzauclRwu6JxaLEmMA1L5UoDFmQpwbnEfMKCl6IRj5Pnt2qkYMr929s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9jx071Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ABE8C113CC;
	Thu, 25 Apr 2024 16:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714061496;
	bh=ho12mLf87MAZYvf64xJHQvB9LOeFouGnTfDbUPjBnlc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j9jx071QsFWrW3XHntMLgzQJpPLY6JtJxBxjwcMn3XrjyxGciv8cAY3zY7azsgZF8
	 OZAubVoWj+tHQxw7TilPa1OGCxI4t+STVuEOVn4QYOYfEfszslIkEcGSzj81xGCbhY
	 g1RFk1oqlxhXZBtYDu68IODgvXXTc21m0MgRk3rReFOxi/ptErGI8XnNfIXRiVUY04
	 kcKRBSHkVfjNcgnC2fcjpSkOCycEIt1JGGxd38cIluYciDBAdztxnhSpl0BPuXd3GO
	 lsdAPpgXvvCZEV03auyx5q+1dL3mKJtCCDsTsomA7nkWnat1g+z6bdfd6lhbpJjWuA
	 vr3IbtzSMPUJQ==
Date: Thu, 25 Apr 2024 11:11:34 -0500
From: Rob Herring <robh@kernel.org>
To: Xilin Wu <wuxilin123@gmail.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Junhao Xie <bigfoot@classfun.cn>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Tengfei Fan <quic_tengfan@quicinc.com>,
	Molly Sophia <mollysophia379@gmail.com>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 03/10] dt-bindings: display: panel: Add Synaptics TD4328
Message-ID: <20240425161134.GA2695912-robh@kernel.org>
References: <20240424-ayn-odin2-initial-v1-0-e0aa05c991fd@gmail.com>
 <20240424-ayn-odin2-initial-v1-3-e0aa05c991fd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424-ayn-odin2-initial-v1-3-e0aa05c991fd@gmail.com>

On Wed, Apr 24, 2024 at 11:29:08PM +0800, Xilin Wu wrote:
> Synaptics TD4328 is a display driver IC used to drive LCD DSI panels.
> 
> Signed-off-by: Xilin Wu <wuxilin123@gmail.com>
> ---
>  .../bindings/display/panel/synaptics,td4328.yaml   | 69 ++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/synaptics,td4328.yaml b/Documentation/devicetree/bindings/display/panel/synaptics,td4328.yaml
> new file mode 100644
> index 000000000000..216f2fb22b88
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/synaptics,td4328.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/synaptics,td4328.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Synaptics TD4328-based DSI display panels
> +
> +maintainers:
> +  - Xilin Wu <wuxilin123@gmail.com>
> +
> +description:
> +  The Synaptics TD4328 is a generic DSI Panel IC used to control
> +  LCD panels.
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    contains:
> +      const: syna,td4328

You need a compatible specific to a panel. This can be a fallback 
though.

> +
> +  vdd-supply:
> +    description: Digital voltage rail
> +
> +  vddio-supply:
> +    description: Digital I/O voltage rail
> +
> +  reg: true
> +  port: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - reset-gpios
> +  - vdd-supply
> +  - vddio-supply
> +  - port
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    dsi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        panel@0 {
> +            compatible = "syna,td4328";
> +            reg = <0>;
> +
> +            backlight = <&backlight>;
> +            reset-gpios = <&tlmm 133 GPIO_ACTIVE_LOW>;
> +
> +            vdd-supply = <&vdd_lcm_2p8>;
> +            vddio-supply = <&vreg_l12b_1p8>;
> +
> +            port {
> +                panel_in_0: endpoint {
> +                    remote-endpoint = <&dsi0_out>;
> +                };
> +            };
> +        };
> +    };
> +
> +...
> 
> -- 
> 2.44.0
> 


Return-Path: <linux-kernel+bounces-90745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9BF87045E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7228D28272C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815A747A6A;
	Mon,  4 Mar 2024 14:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vGZN+aUG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5A03FE58;
	Mon,  4 Mar 2024 14:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709563159; cv=none; b=PwoBjaO0o4c2gZlT4tdO/0iCbiNitDqK/dbMCBL3PoC+JtoSRnu/VQeicDtq8oEMZLTJxLQzKEXDq8FfH5zGw7BYvtLDOftlc8MqabqH2b93m3YM9mB2uARdq+yI5C6F8YWjCFH1JbGjJv2YQZM/z5+6LG9GzQen/TOtLVDpDsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709563159; c=relaxed/simple;
	bh=jMLHce6fSNV1ibpvqXecN80o6gKL25oVTs9fW+eNgJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+hKH7pQLLklaoi+4B9wve6MO8KUA47/6GMVZu90mRqT03ELUAEZdJD6zLA8fPFIw5Z7yt4tR5x8hGzcVM+If4qv2/DB4cVoK9DMysyf/PAWk5B3GNdY1UqP3KntWGjGV9al92q8y34Ee0c93YeE3JQGXI6Y1KuuNOGMD2Lv1jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vGZN+aUG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0AFCC43394;
	Mon,  4 Mar 2024 14:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709563159;
	bh=jMLHce6fSNV1ibpvqXecN80o6gKL25oVTs9fW+eNgJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vGZN+aUGRCHUXtaClyfB0lW2zx8oz2EnMN+dEfj6++ZyYSSPq+FTcQGe47oCabaHn
	 hygA37nDu5yUChLQS9ebQxaY9xeRyhxwKzTewrv7ZIR2lHPrJLQZohTwDPi7lZot4D
	 LitPMpmhwwPXWmLEsDuhowiAnSHHcTmkT3gviCMR5NFWBKnrdHVMRFmpnc7zmZBPLD
	 +GfgdyJa6DQltRPUVE6O0V0p8Y4Cp6UoF4dXx89qS8OuIHn5/uCHo6yTci+iBzcrpM
	 P+HtDaM2cLgfXTu/82Bbm7HMPGBl+43c1PadJmvN73yy0z16/sulhotTpO4BMongqE
	 oVCTYKNNJftgQ==
Date: Mon, 4 Mar 2024 08:39:16 -0600
From: Rob Herring <robh@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Abel Vesa <abelvesa@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-clk@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v3 1/2] dt-bindindgs: clock: support NXP i.MX95 BLK CTL
 module
Message-ID: <20240304143916.GA181628-robh@kernel.org>
References: <20240228-imx95-blk-ctl-v3-0-40ceba01a211@nxp.com>
 <20240228-imx95-blk-ctl-v3-1-40ceba01a211@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228-imx95-blk-ctl-v3-1-40ceba01a211@nxp.com>

On Wed, Feb 28, 2024 at 03:48:22PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX95 includes BLK CTL module in several MIXes, such as VPU_CSR in
> VPUMIX, BLK_CTRL_NETCMIX in NETCMIX, CAMERA_CSR in CAMERAMIX and etc.
> 
> The BLK CTL module is used for various settings of a specific MIX, such
> as clock, QoS and etc.
> 
> This patch is to add some BLK CTL modules that has clock features.

This sentence doesn't add anything you haven't already said.

> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/clock/imx95-blk-ctl.yaml   | 61 ++++++++++++++++++++++
>  include/dt-bindings/clock/nxp,imx95-clock.h        | 32 ++++++++++++
>  2 files changed, 93 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/imx95-blk-ctl.yaml b/Documentation/devicetree/bindings/clock/imx95-blk-ctl.yaml
> new file mode 100644
> index 000000000000..c8974b927bee
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/imx95-blk-ctl.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/imx95-blk-ctl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX95 Block Control
> +
> +maintainers:
> +  - Peng Fan <peng.fan@nxp.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - nxp,imx95-cameramix-csr
> +          - nxp,imx95-display-master-csr
> +          - nxp,imx95-dispmix-lvds-csr
> +          - nxp,imx95-dispmix-csr
> +          - nxp,imx95-netcmix-blk-ctrl
> +          - nxp,imx95-vpumix-csr
> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    const: 1
> +    description:
> +      The clock consumer should specify the desired clock by having the clock
> +      ID in its "clocks" phandle cell. See
> +      include/dt-bindings/clock/nxp,imx95-clock.h
> +
> +  mux-controller:
> +    type: object
> +    $ref: /schemas/mux/reg-mux.yaml
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#clock-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  # Clock Control Module node:
> +  - |
> +    #include <dt-bindings/clock/nxp,imx95-clock.h>
> +
> +    syscon@4c410000 {

clock-controller@...

As that is the main feature/function.

> +      compatible = "nxp,imx95-vpumix-csr", "syscon";
> +      reg = <0x4c410000 0x10000>;
> +      #clock-cells = <1>;

Please make the example as full as possible. For example, add 
mux-controller node. Do some of the blocks not have mux ctrl?


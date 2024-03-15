Return-Path: <linux-kernel+bounces-104724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8BD87D2C9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 823C41F26A2D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529014AEE3;
	Fri, 15 Mar 2024 17:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xbgyxnis"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E65D487AE;
	Fri, 15 Mar 2024 17:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710523675; cv=none; b=eNrW4C1on1l16UdKjGg6l+1tpFP0lvtuORmGZomGuGfCM9ez8pHfXzCM0nFrxTMvclXc4bqnkei/AwAMXrZlVcTw5CopyO4M0mH5FsXD6JX2qkDIgyzQQTLfws/WgZM4FTLN4B47xpO5eGJJzb7u23JUE/UEuo4uPkQUGTeVGbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710523675; c=relaxed/simple;
	bh=Kw+zYeSkcmJLO8XJO567cqAcyu+nQoYVc+rZOQHtzl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YimVdj2bWAaAnT0EgbO3Hi1kuMjqAfvpjZNHN8DcIX6UMfyt+jWOG/W4KBLq0oAoL2rJzKdclBEhe2Wy4DhAZykJrL1fn1UDolZ/u4iqcpqt6L+sQDHa3QJXjs1hCCyz7lfnTkcYrkT95XK8f/BdWvC094EoqX7e5WVkFek8yug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xbgyxnis; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C110C433C7;
	Fri, 15 Mar 2024 17:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710523675;
	bh=Kw+zYeSkcmJLO8XJO567cqAcyu+nQoYVc+rZOQHtzl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XbgyxnisTGyE7pcHm4B33tk0Y2Tr90fMPcHltV1rX/2+bquaVLZ0IJtaUscTacGy/
	 ah32JkrIxFTSLUJtypaccV+ewm5NyLtUh+oc/4CHGR1rbV6QnVC8CB4HeW9IjZBIKy
	 NMJtYyYnO0XmKREbqPMIFqKbvr9XOKB3oG0y2/Is3TxF/jTcNctS7tlPybS7pX0/7e
	 fsqEdG8IU4fDBCwTEnkKeHAhUvjmE9y6biJWXhp54rLKMen2ogO0fq2wxLf++B5EBP
	 Y7W9XCI+c8nxsrRxYgeQQdzkOAiQ+VMx0FjpYFNpPeetHXLG2pyN1IaSSQTQae8J0B
	 daDpG1sW6u1XQ==
Date: Fri, 15 Mar 2024 11:27:52 -0600
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
Subject: Re: [PATCH v4 4/6] dt-bindindgs: clock: nxp: support i.MX95 LVDS CSR
 module
Message-ID: <20240315172752.GC1506658-robh@kernel.org>
References: <20240314-imx95-blk-ctl-v4-0-d23de23b6ff2@nxp.com>
 <20240314-imx95-blk-ctl-v4-4-d23de23b6ff2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314-imx95-blk-ctl-v4-4-d23de23b6ff2@nxp.com>

On Thu, Mar 14, 2024 at 09:25:13PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The i.MX95 LVDS_CSR provides clock gate controls for the LVDS units, LVDS
> PHY and Pixel Mapper blocks. Add dt-binding for it.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../bindings/clock/nxp,imx95-lvds-csr.yaml         | 50 ++++++++++++++++++++++
>  include/dt-bindings/clock/nxp,imx95-clock.h        |  7 +++
>  2 files changed, 57 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/nxp,imx95-lvds-csr.yaml b/Documentation/devicetree/bindings/clock/nxp,imx95-lvds-csr.yaml
> new file mode 100644
> index 000000000000..e04f0ca4f588
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/nxp,imx95-lvds-csr.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/nxp,imx95-lvds-csr.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX95 Display LVDS Block Control
> +
> +maintainers:
> +  - Peng Fan <peng.fan@nxp.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: nxp,imx95-lvds-csr
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
> +required:
> +  - compatible
> +  - reg
> +  - '#clock-cells'

How are clocks and power-domains optional?

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    syscon@4c410000 {
> +      compatible = "nxp,imx95-lvds-csr", "syscon";
> +      reg = <0x4c410000 0x10000>;
> +      #clock-cells = <1>;
> +      clocks = <&scmi_clk 75>;
> +      power-domains = <&scmi_devpd 13>;
> +    };
> +...
> diff --git a/include/dt-bindings/clock/nxp,imx95-clock.h b/include/dt-bindings/clock/nxp,imx95-clock.h
> index c671c4dbb4d5..e642a54c81a0 100644
> --- a/include/dt-bindings/clock/nxp,imx95-clock.h
> +++ b/include/dt-bindings/clock/nxp,imx95-clock.h
> @@ -18,4 +18,11 @@
>  #define IMX95_CLK_CAMBLK_ISP			4
>  #define IMX95_CLK_CAMBLK_END			5
>  
> +#define IMX95_CLK_DISPMIX_LVDS_PHY_DIV		0
> +#define IMX95_CLK_DISPMIX_LVDS_CH0_GATE		1
> +#define IMX95_CLK_DISPMIX_LVDS_CH1_GATE		2
> +#define IMX95_CLK_DISPMIX_PIX_DI0_GATE		3
> +#define IMX95_CLK_DISPMIX_PIX_DI1_GATE		4
> +#define IMX95_CLK_DISPMIX_LVDS_CSR_END		5

Same issue here.


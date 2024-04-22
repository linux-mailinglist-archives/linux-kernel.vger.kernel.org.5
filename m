Return-Path: <linux-kernel+bounces-153671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D48B8AD174
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F2E81C215FD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FABA153593;
	Mon, 22 Apr 2024 16:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="222tnBrQ"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AE1153572;
	Mon, 22 Apr 2024 16:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713801788; cv=none; b=Q8IUhzpSCM1TRnvPNCgnb4yM8oZJchHD4X8cDhVsviKmMY8heqYbwLRbWuCfpH8jtB96liefDLlOMChD5v/eIB0gqF9JsS+ztaUl7/EfIYI5rnMV07w9FMhxBXTPcuDVHRT7i2HgKWwUHxEsYGDcv9XDC/niMNOS+U2NyulEZ6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713801788; c=relaxed/simple;
	bh=z6xykXSbOqn7cIGy1HJCH5EuceJlzbwO6qft+dmLyLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJ9kAmlr05PPOi9obht8airIsWIboq0sXRLOwyttk+XlQfjQx6EVh87W1woyp8lXQCbvPv+T23xp1ZlMLiP+2XMmXoCOKFQUmAIttJmYDt1o6fN79BNJluV+mZta1o1ltF819mfVWg7APQLH0I4/z0xgX5u87F2WjGRrxJOiIGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=222tnBrQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nrWXsKM4GcLwFBIZrYvh14P/NRPtdrs1fUJfL6jXu2M=; b=222tnBrQxmPiTVFF5iurH3o4Ms
	jz0+OyhvcCMg1AKkQYQdWPsQJmy0WBpcYOdwK0b6dNfthA3JYwsjsw3eEbZM61aaOJhbzKqgUHVVR
	ySoKu+nGVjb5gjPaGgvGYFGT/MDyLCVgqpk5Nd5TAInaSWOsucpk1U0eZ54CPbRghaww=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ryw80-00DdF8-R4; Mon, 22 Apr 2024 18:02:48 +0200
Date: Mon, 22 Apr 2024 18:02:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Clark Wang <xiaoning.wang@nxp.com>, Linux Team <linux-imx@nxp.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 1/3] dt-bindings: net: mx93: add enet_clk_sel binding
Message-ID: <972f323b-2c90-4088-b245-d5a8077d77e8@lunn.ch>
References: <20240422-v6-9-topic-imx93-eqos-rmii-v1-0-30151fca43d2@pengutronix.de>
 <20240422-v6-9-topic-imx93-eqos-rmii-v1-1-30151fca43d2@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422-v6-9-topic-imx93-eqos-rmii-v1-1-30151fca43d2@pengutronix.de>

> +  enet_clk_sel:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: phandle to the GPR syscon
> +          - description: the offset of the GPR register
> +    description:
> +      Should be phandle/offset pair. The phandle to the syscon node which
> +      encompases the GPR register, and the offset of the GPR register.
> +

net/nxp,dwmac-imx.yaml

  intf_mode:
    $ref: /schemas/types.yaml#/definitions/phandle-array
    items:
      - items:
          - description: phandle to the GPR syscon
          - description: the offset of the GPR register
    description:
      Should be phandle/offset pair. The phandle to the syscon node which
      encompases the GPR register, and the offset of the GPR register.

dma/fsl,imx-sdma.yaml

  gpr:
    $ref: /schemas/types.yaml#/definitions/phandle
    description: The phandle to the General Purpose Register (GPR) node

memory-controllers/fsl/fsl,imx-weim.yaml

 fsl,weim-cs-gpr:
    $ref: /schemas/types.yaml#/definitions/phandle
    description: |
      Phandle to the system General Purpose Register controller that contains
      WEIM CS GPR register, e.g. IOMUXC_GPR1 on i.MX6Q. IOMUXC_GPR1[11:0]
      should be set up as one of the following 4 possible values depending on
      the CS space configuration.

      IOMUXC_GPR1[11:0]    CS0    CS1    CS2    CS3
      ---------------------------------------------
              05          128M     0M     0M     0M
              033          64M    64M     0M     0M
              0113         64M    32M    32M     0M
              01111        32M    32M    32M    32M

      In case that the property is absent, the reset value or what bootloader
      sets up in IOMUXC_GPR1[11:0] will be used.

How about defining that the General Purpose Registers property is
once, rather than per device which needs access to it?

      Andrew


Return-Path: <linux-kernel+bounces-2586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1A3815F22
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8611B21E2C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 13:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A4B44360;
	Sun, 17 Dec 2023 13:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIP8vS81"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A233C43147;
	Sun, 17 Dec 2023 13:02:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A4DC433C7;
	Sun, 17 Dec 2023 13:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702818147;
	bh=totc3bhdIJhST4jH5HrKG/pFIPp32//1T4FxcfKMPPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hIP8vS81QN8xQGOQeCV0N/GyEHaBWKyERYOmoJe64KTzsjv1E+PpSRvJPJ4/8mrNt
	 qime86vnW6dQyV6RtIgscW3NhC6hgpEeUiriJxWnBy9zj9SoPso9BNuoLdcCWSSp9C
	 VzqKYs29YIuknddmfyTfKVIfnvbNLAFdanhnD4Q9Rg8nfvy3D5enzAwBg3PXKixndO
	 omRCnEfR1cbXWLcxLC+JMvYzD+I1YAq6rtQooiiOSRXgSJf4nerbTpZu2d+dqV53bH
	 tRdFi+O127uMshEDgLW5hMAXgq9wk1EWVCltY4M5tYNtrAoUm3oKssGpdWqgEOxWWk
	 2lqQcCTlwC3NQ==
Date: Sun, 17 Dec 2023 13:02:21 +0000
From: Simon Horman <horms@kernel.org>
To: Luo Jie <quic_luoj@quicinc.com>
Cc: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	hkallweit1@gmail.com, linux@armlinux.org.uk, corbet@lwn.net,
	p.zabel@pengutronix.de, f.fainelli@gmail.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 13/14] net: phy: at803x: configure qca8084 work mode
Message-ID: <20231217130221.GZ6288@kernel.org>
References: <20231215074005.26976-1-quic_luoj@quicinc.com>
 <20231215074005.26976-14-quic_luoj@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215074005.26976-14-quic_luoj@quicinc.com>

On Fri, Dec 15, 2023 at 03:40:03PM +0800, Luo Jie wrote:

...

> @@ -1038,6 +1045,46 @@ static int qca8084_common_clock_init(struct phy_device *phydev)
>  	return clk_prepare_enable(priv->clk[MDIO_MASTER_AHB_CLK]);
>  }
>  
> +static int qca8084_parse_and_set_work_mode(struct phy_device *phydev)
> +{
> +	struct device_node *node;
> +	struct at803x_priv *priv;
> +	u32 value, work_mode;
> +	int ret;
> +
> +	node = phydev->mdio.dev.of_node;
> +	priv = phydev->priv;

Hi Luo Jie,

a minor nit from my side: priv is set but otherwise unused in this function.

> +
> +	/* The property "qcom,phy-work-mode" is only defined in one
> +	 * PHY device tree node.
> +	 */
> +	ret = of_property_read_u32(node, "qcom,phy-work-mode", &value);
> +	if (ret)
> +		return ret == -EINVAL ? 0 : ret;
> +
> +	switch (value) {
> +	case 0:
> +		work_mode = QCA8084_WORK_MODE_QXGMII;
> +		break;
> +	case 1:
> +		work_mode = QCA8084_WORK_MODE_QXGMII_PORT4_SGMII;
> +		break;
> +	case 2:
> +		work_mode = QCA8084_WORK_MODE_SWITCH;
> +		break;
> +	case 3:
> +		work_mode = QCA8084_WORK_MODE_SWITCH_PORT4_SGMII;
> +		break;
> +	default:
> +		phydev_err(phydev, "invalid qcom,phy-work-mode %d\n", value);
> +		return -EINVAL;
> +	}
> +
> +	return qca8084_mii_modify(phydev, QCA8084_WORK_MODE_CFG,
> +				  QCA8084_WORK_MODE_MASK,
> +				  FIELD_PREP(QCA8084_WORK_MODE_MASK, work_mode));
> +}

...


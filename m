Return-Path: <linux-kernel+bounces-20045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0BC82789E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ACF4284BB9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F226253811;
	Mon,  8 Jan 2024 19:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5lEDdSOX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E9D53801;
	Mon,  8 Jan 2024 19:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=F/NA599aFhBFXwECvVMGWs2VaVppQqKK8L8EV5T6GHU=; b=5lEDdSOXuYx9BWxsWLtwGZ2ZkR
	sMpqgGbg0f2RkMO95B/OlW7pvDQus8ALxQzTRpVIWzBr0rW8Tds9r6tUNnWDU8oiEKumF8Mtyr18x
	VJInXXN4ZXU0UEPV5wDmLPg1TwyZ/WIhGqamUtmQ+lYL3C8xP0hv3HqKNfRRjn4TXm40=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rMvKW-004g2X-Ez; Mon, 08 Jan 2024 20:30:36 +0100
Date: Mon, 8 Jan 2024 20:30:36 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sneh Shah <quic_snehshah@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@quicinc.com, Andrew Halaney <ahalaney@redhat.com>
Subject: Re: [PATCH v2] net: stmmac: dwmac-qcom-ethqos: Add support for 2.5G
 SGMII
Message-ID: <4216bcbb-730d-4c51-a9ce-d3f0a0846e31@lunn.ch>
References: <20240108121128.30071-1-quic_snehshah@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108121128.30071-1-quic_snehshah@quicinc.com>

On Mon, Jan 08, 2024 at 05:41:28PM +0530, Sneh Shah wrote:
> Serdes phy needs to operate at 2500 mode for 2.5G speed and 1000
> mode for 1G/100M/10M speed.
> Added changes to configure serdes phy and mac based on link speed.

Please take a look at:

https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

The Subject is missing which tree this is for. Also, net-next is
closed at the moment.

>  	switch (ethqos->speed) {
> +	case SPEED_2500:
> +		val &= ~ETHQOS_MAC_CTRL_PORT_SEL;
> +		rgmii_updatel(ethqos, RGMII_CONFIG2_RGMII_CLK_SEL_CFG,
> +			      RGMII_CONFIG2_RGMII_CLK_SEL_CFG,
> +			      RGMII_IO_MACRO_CONFIG2);
> +		if (ethqos->serdes_speed != SPEED_2500)
> +			phy_set_speed(ethqos->serdes_phy, SPEED_2500);

Is calling phy_set_speed() expensive? Why not just unconditionally
call it?

     Andrew


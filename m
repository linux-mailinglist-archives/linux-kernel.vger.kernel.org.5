Return-Path: <linux-kernel+bounces-4930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 880308183FB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40CDC282241
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1A812B80;
	Tue, 19 Dec 2023 08:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kZwHzqjK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DA7125B5;
	Tue, 19 Dec 2023 08:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mApDO3T9Xz1helbAZSFet16out2mW7MWySk8mjZ5wDE=; b=kZwHzqjKiWEgoZn1veK4cqHCKR
	SerS327V6zs7qE4E6zPYWmsCCljxHbsbPRP8PnWbjTURrTEHbkjZ8o2iz5NzhD8JA+Ff7VkMuDU7y
	IuyEa1zVHU6FlNhAMzyxTvwbEkuOczsw1MpSllM/sbokb9AG9DcNbi1v0/8T47H9dxsI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rFVvb-003JjA-OP; Tue, 19 Dec 2023 09:58:15 +0100
Date: Tue, 19 Dec 2023 09:58:15 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Samin Guo <samin.guo@starfivetech.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Hal Feng <hal.feng@starfivetech.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Subject: Re: [PATCH v4 6/9] riscv: dts: starfive: visionfive-v1: Setup
 ethernet phy
Message-ID: <962691a4-993d-44c0-861f-d0fd5bbc2da9@lunn.ch>
References: <20231218214451.2345691-1-cristian.ciocaltea@collabora.com>
 <20231218214451.2345691-7-cristian.ciocaltea@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218214451.2345691-7-cristian.ciocaltea@collabora.com>

On Mon, Dec 18, 2023 at 11:44:46PM +0200, Cristian Ciocaltea wrote:
> The StarFive VisionFive V1 SBC uses a Motorcomm YT8521 PHY supporting
> RGMII-ID, but requires manual adjustment of the RX internal delay to
> work properly.
> 
> The default RX delay provided by the driver is 1.95 ns, which proves to
> be too high. Applying a 50% reduction seems to mitigate the issue.
> 
> Also note this adjustment is not necessary on BeagleV Starlight SBC,
> which uses a Microchip PHY.  Hence, there is no indication of a
> misbehaviour on the GMAC side, but most likely the issue stems from
> the Motorcomm PHY.
> 
> While at it, drop the redundant gpio include, which is already provided
> by jh7100-common.dtsi.
> 
> Co-developed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


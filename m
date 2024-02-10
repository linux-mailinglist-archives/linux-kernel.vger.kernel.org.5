Return-Path: <linux-kernel+bounces-60212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E73FF85017D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 02:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A868A28A041
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 01:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2E13FFE;
	Sat, 10 Feb 2024 01:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KltL2qzH"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACA71FB5;
	Sat, 10 Feb 2024 01:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707527883; cv=none; b=BF86QIFjfCn2QkhRH68Uf4Ez3mJhxaP24FE39EdyaosFoYEN5DyMp50v5hdEOu6+xcflWn6tVgwZPyIv9CHu+b1xtNDRCyEQ7bIWYf9KidhxXRaJJ3ffelvp4gG7ZKmxcUbo0/gU+RaBdrHHotY7Honmm0IkVo3rXxvB69Ey8RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707527883; c=relaxed/simple;
	bh=722mtAfkEpvZBuy7Xfc4E88QMXpjqaGfvRDCUn4uIe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jKMswnos3VrmNyl+kap28nkSDUjfEptSc3WXkrHOdIyv5sLTdQDEtiYn9aCE2d+wkr6tRcvFfY+aneA5Sgs4Wd8h4Yk02Msv+q7EogbJippEQmyDZvDi3K+dzf4ogTmwa9j0YiZ4QX7XKumJZ0d8abcGcVIYbA9BXeux60r6GZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KltL2qzH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zKZdt/8G3k78mhaP+G1gSjq1dpGWlCzfFW6IRY7O1d4=; b=KltL2qzHCtRfERU6iAOhacpaIj
	sSiBQSbGur8Y2zKUTDTwpR52i68tsgLN0BBp2CFZClKNwSuEBrsAXheCFK0YVTj1h2SpF+HCdAVhv
	IeZJzn6GxEq/GRLpLUnhmc7oNdl+i+fXb+kkfUpO/9VynMVtPHxaUto7h91fDDrms7Kw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rYc04-007Qow-GA; Sat, 10 Feb 2024 02:17:48 +0100
Date: Sat, 10 Feb 2024 02:17:48 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [net-next PATCH v7 02/10] net: phy: add support for scanning PHY
 in PHY packages nodes
Message-ID: <5531e16b-4bd3-4ffd-82b5-0dda7942bb5b@lunn.ch>
References: <20240206173115.7654-1-ansuelsmth@gmail.com>
 <20240206173115.7654-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206173115.7654-3-ansuelsmth@gmail.com>

On Tue, Feb 06, 2024 at 06:31:05PM +0100, Christian Marangi wrote:
> Add support for scanning PHY in PHY package nodes. PHY packages nodes
> are just container for actual PHY on the MDIO bus.
> 
> Their PHY address defined in the PHY package node are absolute and
> reflect the address on the MDIO bus.
> 
> mdio_bus.c and of_mdio.c is updated to now support and parse also
> PHY package subnode by checking if the node name match
> "ethernet-phy-package".
> 
> As PHY package reg is mandatory and each PHY in the PHY package must
> have a reg, every invalid PHY Package node is ignored and will be
> skipped by the autoscan fallback.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


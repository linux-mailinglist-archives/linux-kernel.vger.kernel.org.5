Return-Path: <linux-kernel+bounces-60214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA89850184
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 02:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88959B250EC
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 01:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC88A4417;
	Sat, 10 Feb 2024 01:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qmlD7rnc"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573121FD7;
	Sat, 10 Feb 2024 01:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707528037; cv=none; b=gnZgVsTkH6O7RiXVnBqC4AsQeBcSexd7+kdRH2NY0OnezxXZB21OfDkDPr6IgKSQweyOC1gHQXYKYtmLbOeESRtAgwz1sSKiKwBQsZvNqIaPaq2lPinISoKejAGSIivKtZn2bS6LknUWriJ2q4t8BLVigqh7m/mV8p66HfSBdX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707528037; c=relaxed/simple;
	bh=UKdOgTJS3khtpazw1OpYocuod3sMdQ1N4G70EeNn+5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lno0cC2pIx35x2qBuIcaFPTG1evGlIRqhwe8WrkWi8saZoKqHBIXSnU8QldN2MpqCdQOcIv++9qa4SuANArPy6gmlprVMcG8TL6p1QisCB8k34UzJ/Uz8IP5Bc1932RWdYGwEB6g8g09t8Y6cYNn4fqQqPXxN7f95PQQALspGcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qmlD7rnc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kQUhYTxFugDn5/h0NeviHtOes30s2gaxQ9TVCrFash0=; b=qmlD7rnc/jz5FlypoXXSVvLyJQ
	cJGjxVa+TxDBmRqp1hEkyDYDpXNTJys8l0ZDx59eT9enwgLzF3pofJJS7mVQewFuy6wL+aNl5QNLg
	kLeITLcQ7J0rgIv5th81H5mDznq52rml8XVv1ITH3+RMBCrIXbx2IG1PKEdBjgnIlKoM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rYc2f-007Qq6-0X; Sat, 10 Feb 2024 02:20:29 +0100
Date: Sat, 10 Feb 2024 02:20:29 +0100
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
Subject: Re: [net-next PATCH v7 03/10] net: phy: add devm/of_phy_package_join
 helper
Message-ID: <1787d720-1890-4ee4-82ab-5eb973c279d6@lunn.ch>
References: <20240206173115.7654-1-ansuelsmth@gmail.com>
 <20240206173115.7654-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206173115.7654-4-ansuelsmth@gmail.com>

On Tue, Feb 06, 2024 at 06:31:06PM +0100, Christian Marangi wrote:
> Add devm/of_phy_package_join helper to join PHYs in a PHY package. These
> are variant of the manual phy_package_join with the difference that
> these will use DT nodes to derive the base_addr instead of manually
> passing an hardcoded value.
> 
> An additional value is added in phy_package_shared, "np" to reference
> the PHY package node pointer in specific PHY driver probe_once and
> config_init_once functions to make use of additional specific properties
> defined in the PHY package node in DT.
> 
> The np value is filled only with of_phy_package_join if a valid PHY
> package node is found. A valid PHY package node must have the node name
> set to "ethernet-phy-package".
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


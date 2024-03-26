Return-Path: <linux-kernel+bounces-119185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DE288C535
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24A61B24C9E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D120813C3FA;
	Tue, 26 Mar 2024 14:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Fc7Rcv1V"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC4813C3E0;
	Tue, 26 Mar 2024 14:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711463584; cv=none; b=udkX89V58h9BdG4whP/Tvskqh0HtnWtw0qV4eH+7fwQr/2B6dLvhQghlKS4Zg42+zyCziSuR57CNXMI4xi1mc+wY35CX3VhkiOZ8BNbwl/YtQ6RVayvtjPxUTymb12XOx1/Qcf2rZJVroqEpg6y8rRB4rQXjjfb20nTw0vmNb1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711463584; c=relaxed/simple;
	bh=xbAMRHKr+ODmrMxlSYDlIGrfR3rXNVzQ2E4TjS4KDz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k88RSG12BroHNducxbTQYJDo4PDmAopMWtJvi7PuMoFPPc3mARtmrmBFm5/44kHEFfqOKCBl6bRjzZqadFJKP3eg8PPFaa0jkOgqZkIg+BGWHzpsMEPphggSl3yokk/8FaUi6m/5mgoP6BYe83fdbNpNFUNj84YGuBDrJtJbHgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Fc7Rcv1V; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ANjLUAUtamVXM2Bz6Z7r9VVYDd7Y/1RlyFr5ZQF7feM=; b=Fc7Rcv1VFZbxCbc3tJ5NlkRZba
	+f+0ed/cAG/YRvPahOl9OLZZQWEy2vrV2eGvldeai5xnH8a6MR76LHaR/Fh7oogN7ZwksjDQXywzW
	GhAgsCuO2lJfRrllkAgRntvm9G+49r6jtBQSTY5U53t5vMwpkQbGnXxADR6h8NIrnt7w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rp7r8-00BHtF-KU; Tue, 26 Mar 2024 15:32:50 +0100
Date: Tue, 26 Mar 2024 15:32:50 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: phy: marvell: implement cable-test for
 88E308X/88E609X family
Message-ID: <88dc994b-a3da-4760-b7e0-c6da593b15d6@lunn.ch>
References: <20240326141238.2315974-1-paweldembicki@gmail.com>
 <20240326141238.2315974-2-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326141238.2315974-2-paweldembicki@gmail.com>

> +		ret = phy_write(phydev, MII_BMCR, 0xa100);

BMCR_RESET | BMCR_ANENABLE | BMCR_FULLDPLX

You should check i have that correct, but no need for magic values
with this register.

> +static int m88e3082_vct_cable_test_report_trans(int result, u8 distance)
> +{
> +	switch (result) {
> +	case MII_VCT_TXRXPINS_VCTTST_OK:
> +		if (distance == MII_VCT_TXRXPINS_DISTRFLN_MAX)
> +			return ETHTOOL_A_CABLE_RESULT_CODE_OK;
> +		/* Impedance mismatch */
> +		return ETHTOOL_A_CABLE_RESULT_CODE_UNSPEC;

It is possible to add more results code, if you think Impedance
mismatch is useful.

> +	ret = phy_write(phydev, MII_BMCR, priv->m88e3082_vct_reg_backup);
> +	if (ret < 0)
> +		return ret;

I'm not sure this is required. When the cable test is finished, the
PHY state machine is moved to PHY_UP. That will cause
phy_config_aneg() to be called which should set BMCR back to the
correct value.

	Andrew


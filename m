Return-Path: <linux-kernel+bounces-94816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7771587458E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0824AB22563
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DD14C98;
	Thu,  7 Mar 2024 01:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3EgwL5aR"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8E9441F;
	Thu,  7 Mar 2024 01:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709773992; cv=none; b=RBiOLc9LzT2RGOHUCqNwl3/mEwMf+2ueSV0T9XI3MQXSJ+ZzPklAscwYuYkw2JLdSlsE3NfZ+CSGHa0V6DPX+r2khwqaRbn82/3bT1ugHdf9oVG9M7lFNYN44wA3NO44hsjKOtOf6I5HHQEwf1Ep6NNLyruWQUhQSwiIuGBn1ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709773992; c=relaxed/simple;
	bh=de5ZxAMOpyhXT1T1JXFC47CP0MDYZQKgsWVDcCrzfKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ea+PzW0nKyy86QCjwLbrnW4NepvgFseE1cDBHiHcQRc2IBrV+mmsFU2sCqEHc7I6Cv752j6VnNXJL43m1LRszcuzksSdthf1cCuvUJ9IGxU3dvgfKC8EgXudsLfYR0xIA00uzKwyWjtv95/Q7fGUiJVbX5JND2kJmpyb8SaWH9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3EgwL5aR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5sGcklaR+Uln4FMN2IExD3g52cHOSe/gl+dclElMBzY=; b=3EgwL5aRkD3ZspkODCgvMOs2F0
	CnMNXkVS2G1a/Xb0vAnpC/2Qv86zbsN8r4VMq4C0xXqdvfiM4bgc0dteoTwl2pNPJSjDGybNI7jyo
	worW4tIwuPDd3rMAwuLmmoZixnIlKbDq+DNbYoBQ5hdLjiQNtHVZrGMkrSchiQ6GU9O8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ri2K4-009XtG-NZ; Thu, 07 Mar 2024 02:13:24 +0100
Date: Thu, 7 Mar 2024 02:13:24 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, horatiu.vultur@microchip.com,
	ruanjinjie@huawei.com, steen.hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Pier.Beruto@onsemi.com,
	Selvamani.Rajagopal@onsemi.com, Nicolas.Ferre@microchip.com,
	benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v3 06/12] net: ethernet: oa_tc6: implement
 internal PHY initialization
Message-ID: <8c2b95f4-75a7-4d6d-ab9c-9c3498c040d8@lunn.ch>
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
 <20240306085017.21731-7-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306085017.21731-7-Parthiban.Veerasooran@microchip.com>

> +/* PHY Clause 22 and 29 registers base address and mask */
> +#define OA_TC6_PHY_STD_REG_ADDR_BASE		0xFF00
> +#define OA_TC6_PHY_STD_REG_ADDR_MASK		0x3F

[Goes and looks a 802.3]

Clause 29 is "System considerations for multisegment 100BASE-T networks"

I don't see any mention of registers in there.

TC6 says:

"Clause 22 standard registers and Clause 22 extended registers (Clause
29) are directly mapped into MMS 0 as shown in Table 7."

Going back to 802.3, we have 22.2.4:

The MII basic register set consists of two registers referred to as
the Control register (Register 0) and the Status register (Register
1). All PHYs that provide an MII Management Interface shall
incorporate the basic register set. All PHYs that provide a GMII shall
incorporate an extended basic register set consisting of the Control
register (Register 0), Status register (Register 1), and Extended
Status register (Register 15). The status and control functions
defined here are considered basic and fundamental to 100 Mb/s and 1000
Mb/s PHYs. Registers 2 through 14 are part of the extended register
set. The format of Registers 4 through 10 are defined for the specific
Auto-Negotiation protocol used (Clause 28 or Clause 37). The format of
these registers is selected by the bit settings of Registers 1 and 15.

So clause 29 is not making much sense here. Can anybody explain it?

> +static int oa_tc6_mdiobus_register(struct oa_tc6 *tc6)
> +{
> +	int ret;
> +
> +	tc6->mdiobus = mdiobus_alloc();
> +	if (!tc6->mdiobus) {
> +		netdev_err(tc6->netdev, "MDIO bus alloc failed\n");
> +		return -ENODEV;
> +	}
> +
> +	tc6->mdiobus->priv = tc6;
> +	tc6->mdiobus->read = oa_tc6_mdiobus_direct_read;
> +	tc6->mdiobus->write = oa_tc6_mdiobus_direct_write;

This might get answered in later patches. PLCA registers are in C45
address space, VEND1 if i remember correctly. You don't provide any
C45 access methods here. Does TC6 specify that C45 over C22 must be
implemented?

The standard does say:

Vendor specific registers may be mapped into MMS 10 though MMS
15. When directly mapped, PHY vendor specific registers in MMD 30 or
MMD 31 would be mapped into the vendor specific MMS 10 through MMS 15.

So i'm thinking you might need to provide C45 access, at least MMD 30,
via MMS 10-15?

    Andrew


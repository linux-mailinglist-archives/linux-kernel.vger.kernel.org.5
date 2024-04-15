Return-Path: <linux-kernel+bounces-145280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 611A68A51FB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17F241F23CD9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8495E7AE43;
	Mon, 15 Apr 2024 13:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="e6xAOPHX"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FD76FE0D;
	Mon, 15 Apr 2024 13:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713188498; cv=none; b=LdRQnuDsizP16QwEobStigf0q0Jcy9r5jqLqT3VVh8VGwvMpDkdqqS7BrssVvCRJy87UpX+YjON25q8UcxPF2SYQiXNdeG/4wqh8e8+bNw+JgugThOWk+OfGtVmJq3HIf8ZcWPlvUIb+48Zy8FxfO0h68T8twXFVfU3y6dgRBw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713188498; c=relaxed/simple;
	bh=Ze7Bw+QK8PxSu4QALmqRImY4KEW9tq6PtmBvMgUWpAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ui4Z0LojJSJFNZZ81TU8lHJmmO78EjLMGmZN/gqOul0uBmHjiJ+KM9HDKYsvs+bWXQjDOU5aSYS7ySGC5ZT7ok4iCe/3Ag0fHouCtxeb1T9ait9lc0b15sz4RTzH2imxbbojuf7sHFBcyyOJJ/Uh2t74Nk8zphxHoQB/18JTIZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=e6xAOPHX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EHzIPIlvEMFa/Xeg/4PiXPGWOFI3w89WOsdke+JuLoI=; b=e6xAOPHX2IGsvTthzItSh79fgk
	IJL48VLuZcrMVW7NCuwIzhnjHb2u6oUgRCJDknwJK62XHlZ6f+TYKF6Njrh7imY0UxeMTay8LKXYf
	FsqUJkDdDRjIhzSW57wjyOs0+5FHNTCiwji0lNzMWNy+zDdblUMs14ymf9SnLF9xk9WI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rwMBH-00D2Vj-NX; Mon, 15 Apr 2024 15:15:31 +0200
Date: Mon, 15 Apr 2024 15:15:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban.Veerasooran@microchip.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, Horatiu.Vultur@microchip.com,
	ruanjinjie@huawei.com, Steen.Hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Pier.Beruto@onsemi.com,
	Selvamani.Rajagopal@onsemi.com, Nicolas.Ferre@microchip.com,
	benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v3 06/12] net: ethernet: oa_tc6: implement
 internal PHY initialization
Message-ID: <3fc3b5c3-0750-4aff-ab26-240f4bc55236@lunn.ch>
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
 <20240306085017.21731-7-Parthiban.Veerasooran@microchip.com>
 <8c2b95f4-75a7-4d6d-ab9c-9c3498c040d8@lunn.ch>
 <eeb57938-e21e-406d-a835-93c6fb19b161@microchip.com>
 <7ddbe599-187e-401f-b508-4dc62bca8374@lunn.ch>
 <e9bc573e-61f0-484a-b1fb-b5100eb9ee0a@microchip.com>
 <8de7a4bb-a127-4771-97dd-038f08fcce9d@lunn.ch>
 <372a45c3-1372-4956-8d42-8e989f86d131@microchip.com>
 <ee5dcd07-7c44-4317-9d62-0fc68565988a@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee5dcd07-7c44-4317-9d62-0fc68565988a@microchip.com>

On Fri, Apr 12, 2024 at 10:43:15AM +0000, Parthiban.Veerasooran@microchip.com wrote:
> Hi Andrew,
> 
> After implementing the new APIs oa_tc6_mdiobus_read_c45() and 
> oa_tc6_mdiobus_write_c45(), I tried testing. But, for some reason these 
> APIs are never get called by phy_read_mmd() or phy_write_mmd() as those 
> APIs are checking for phydev->is_c45 flag for calling this new c45 APIs 
> which is not set in this case.
> 
> If the phydev is found via c22, phylib does not set phydev->is_c45, and 
> everything ends up going indirect.

We don't have a clean separation between C22/C45 register space and
C22/C45 MDIO bus protocols. As you said, if the PHY is discovered via
C22 bus protocol it assumes it uses C22 protocol.

Those PHYs which do support C45, and in particular, features which
need C45, all call genphy_c45_pma_read_abilities() in there
get_features function to add in C45 features. However, it will
continue using C45 over C22 because genphy_c45_pma_read_abilities()
only really says the device has C45 registers, not C45 protocol.

I can see two different things you can try.

1) set .read_mmd and .write_mmd in the PHY driver to phy_read_mmd()
   and phy_write_mmd(). That is not great however, since each vendor
   is likely to have their own PHY driver.

2) Add a helper to set is_c45. This however has side effects you might
   not want. e.g. auto-neg will be performed via C45, not C22. This
   might not matter for a T1 PHY where is think auto-neg is not
   actually used. But i don't see anything in TC6 which limits it to
   T1, i could well imagine a T2 or T4 PHY being used with full
   auto-neg.

We really do need to separate C45 registers from C45 protocol in the
phylib core to cleanly solve this.

       Andrew



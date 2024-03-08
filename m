Return-Path: <linux-kernel+bounces-97092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CB887655F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A6A1B24297
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC523BBEC;
	Fri,  8 Mar 2024 13:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2PV1xcV7"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EC936132;
	Fri,  8 Mar 2024 13:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709904781; cv=none; b=PZGsISfSOBWUyvaqiy0I+Fej3v4idHF8hAK7G7g/IoX4t8me+fE3rys0wmoUJezwta6E6UTmj6u3i8S21n0SoqvwBTX7e8yD+S+YghbAR70AV1E0tq5fffLfI+8NzYqdEuiYWAU/n/1KSzADMtmSnwSUQf5/bp1Gk8RFqoe0qS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709904781; c=relaxed/simple;
	bh=Vv/Jufa5OVNBfy5C9TR6DMNWeexhQbgcJrBdXPQc34M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxjZ5Ep/ztX2rrIZ5hnauYLkHBNnsvCYd1u/T7VxTi3Gk3iCNxujbpCum2UYZH3Fx4wx/4rpttqPoxwArF32HT9WlFMxOIYcbtgXMg8QV/gg0FQE8tRENUjIDmi18YXfUO4zz0C7S5sBV0ImKG1pnYrVG7EgH8khlS+9kpz6Axs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2PV1xcV7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=XLhNZiOAtOVRkJtnzxKeO+RebX+VweC9Qi0gKqLYSug=; b=2P
	V1xcV7e67+qNS5SLuC5sqbbw9rDlaK2j5FirbwEh1W6qRIWu1x6badEuka4IXZdSywzw2SKUs9+2P
	DsBNlPo/f9QfW7v7AkNLkJ7q81VaZdsoviLrpbgxojk3QieSoy+8/gUI+xPrG1FPEEuVGClV3wi6r
	EBff0q/VkXEAGmU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1riaLY-009lXx-Kv; Fri, 08 Mar 2024 14:33:12 +0100
Date: Fri, 8 Mar 2024 14:33:12 +0100
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
Message-ID: <8de7a4bb-a127-4771-97dd-038f08fcce9d@lunn.ch>
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
 <20240306085017.21731-7-Parthiban.Veerasooran@microchip.com>
 <8c2b95f4-75a7-4d6d-ab9c-9c3498c040d8@lunn.ch>
 <eeb57938-e21e-406d-a835-93c6fb19b161@microchip.com>
 <7ddbe599-187e-401f-b508-4dc62bca8374@lunn.ch>
 <e9bc573e-61f0-484a-b1fb-b5100eb9ee0a@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e9bc573e-61f0-484a-b1fb-b5100eb9ee0a@microchip.com>

> Ok, as per the table 6 in the spec, PHY C45 registers are mapped in the 
> MMS like below,
> 
> PHY – PCS Registers (MMD 3)  --->  MMS 2
> PHY – PMA/PMD Registers (MMD 1)  --->   MMS 3
> PHY – Vendor Specific and PLCA Registers (MMD 31)  --->  MMS 4
> PHY – Auto-Negotiation Registers (MMD 7)  --->  MMS 5
> PHY – Power Unit (MMD 13)  --->  MMS 6
> 
> MMD 13 for PHY - Power Unit is not defined in the mdio.h. So in the 
> below code I have defined it locally (MDIO_MMD_POWER_UNIT). May be 
> needed to do this in the mdio.h file when coming to this patch.

Yes, please add it to mdio.h

> /* PHY – Clause 45 registers memory map selector (MMS) as per table 6 in 
> the OPEN Alliance specification.
>   */
> #define OA_TC6_PHY_PCS_MMS2                     2       /* MMD 3 */
> #define OA_TC6_PHY_PMA_PMD_MMS3                 3       /* MMD 1 */
> #define OA_TC6_PHY_VS_PLCA_MMS4                 4       /* MMD 31 */
> #define OA_TC6_PHY_AUTO_NEG_MMS5                5       /* MMD 7 */
> #define OA_TC6_PHY_POWER_UNIT_MMS6              6       /* MMD 13 */
> 
> /* MDIO Manageable Device (MMD) for PHY Power Unit */
> #define MDIO_MMD_POWER_UNIT                     13      /* PHY Power Unit */
> 
> static int oa_tc6_mdiobus_read_c45(struct mii_bus *bus, int addr, int 
> devnum, int regnum)
> { 
> 
>          struct oa_tc6 *tc6 = bus->priv; 
> 
>          u32 regval; 
> 
>          bool ret; 
> 
>          u32 mms; 
> 
>  
> 
>          if (devnum == MDIO_MMD_PCS) 
> 
>                  mms = OA_TC6_PHY_PCS_MMS2; 
> 
>          else if (devnum == MDIO_MMD_PMAPMD) 
> 
>                  mms = OA_TC6_PHY_PMA_PMD_MMS3; 
> 
>          else if (devnum == MDIO_MMD_VEND2) 
> 
>                  mms = OA_TC6_PHY_VS_PLCA_MMS4; 
> 
>          else if (devnum == MDIO_MMD_AN) 
> 
>                  mms = OA_TC6_PHY_AUTO_NEG_MMS5; 
> 
>          else if (devnum == MDIO_MMD_POWER_UNIT) 
> 
>                  mms = OA_TC6_PHY_POWER_UNIT_MMS6; 

I would probably use a switch statement.

> 
>          else 
> 
>                  return -ENOTSUPP; 

802.3 says:

  If a device supports the MDIO interface it shall respond to all
  possible register addresses for the device and return a value of
  zero for undefined and unsupported registers. Writes to undefined
  registers and read-only registers shall have no effect. The
  operation of an MMD shall not be affected by writes to reserved and
  unsupported register bits, and such register bits shall return a
  value of zero when read.

So maybe return 0. ENOTSUPP is wrong, that is an NFS only error
code. The generic one is EOPNOTSUPP. I would say -EOPNOTSUPP is also
O.K.

>          ret = oa_tc6_read_register(tc6, (mms << 16) | regnum, &regval); 
> 
>          if (ret) 
> 
>                  return -ENODEV; 

oa_tc6_read_register() should return an error code, so return whatever
is returns. Don't overwrite error codes. It makes it harder to track
errors through the call stack.

       Andrew



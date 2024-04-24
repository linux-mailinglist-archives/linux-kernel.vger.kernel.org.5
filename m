Return-Path: <linux-kernel+bounces-156345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 623F08B0193
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F4BDB21C52
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E6D156C66;
	Wed, 24 Apr 2024 06:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Npfz5vBv"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B0A15687B;
	Wed, 24 Apr 2024 06:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713939071; cv=none; b=uQHgbbx324oaXQqBU4zcL/MgTeVR7B/51N7KHUGEWUMP4CdKkQ0sZrg9xqHtbEaUJ18OCSWO8O5g/UN5trxA9YuvWvPh9lMtvp/44tDAv4X57fh1+90Hgw7qNDnblYEpQEUPp5ni3i5CiZXc73/V8RvkLStngJP6cbZRTM0jJc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713939071; c=relaxed/simple;
	bh=gzkkQlE9RolOyVL22PsPDDxDNzwDNG3gpNefrqO6PLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ofi3PfD6p/+tVRY2HXBlEnnrN/J7OJwWw3rJh8FFgClB4TUqpefW2ecm666MJTdl+bdey4dIqZxYntsUoEn+wwcnYgKOmq68XH4+A/+uyvyL5BXyv4hoRpaHtJqKVrlotRva28hlVrqC+a4on9/e0o7mFESecncxub+E+1Oo/2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Npfz5vBv; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43O6AhG7045210;
	Wed, 24 Apr 2024 01:10:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713939043;
	bh=fpGSrtQzUsza+SVKZ8gQXj1v2j7Bd88adZDyqcxXnZE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Npfz5vBvlWTUd+PYGdZCkx9q+SXRhiQKOWMVyY1YVLhaa2aV2gvzOs+LpxadRE1Zw
	 wpbWXaICBfIXsjL7D/ONKAwiPHOGRHwytZd96rqa3Xp3tddAvuylpRNJ/4gv2BzaTi
	 mzKD8BgkkmCDTEDk6msPG9TDhHRKd050awt7bzpc=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43O6Ah4t053683
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 24 Apr 2024 01:10:43 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Apr 2024 01:10:43 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Apr 2024 01:10:43 -0500
Received: from [10.250.149.192] ([10.250.149.192])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43O6Abcx100128;
	Wed, 24 Apr 2024 01:10:38 -0500
Message-ID: <e91719e5-2de3-4c52-88e1-d85257484977@ti.com>
Date: Wed, 24 Apr 2024 11:40:36 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: phy: dp83869: Fix MII mode failure
To: MD Danish Anwar <danishanwar@ti.com>,
        Siddharth Vadapalli
	<s-vadapalli@ti.com>,
        Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Russell King <linux@armlinux.org.uk>,
        Heiner Kallweit
	<hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <srk@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        Ravi Gunasekaran <r-gunasekaran@ti.com>
References: <20240423084828.1309294-1-danishanwar@ti.com>
Content-Language: en-US
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <20240423084828.1309294-1-danishanwar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 4/23/2024 2:18 PM, MD Danish Anwar wrote:
> The DP83869 driver sets the MII bit (needed for PHY to work in MII mode)
> only if the op-mode is either DP83869_100M_MEDIA_CONVERT or
> DP83869_RGMII_100_BASE.
>
> Some drivers i.e. ICSSG support MII mode with op-mode as
> DP83869_RGMII_COPPER_ETHERNET for which the MII bit is not set in dp83869
> driver. As a result MII mode on ICSSG doesn't work and below log is seen.
>
> TI DP83869 300b2400.mdio:0f: selected op-mode is not valid with MII mode
> icssg-prueth icssg1-eth: couldn't connect to phy ethernet-phy@0
> icssg-prueth icssg1-eth: can't phy connect port MII0
>
> Fix this by setting MII bit for DP83869_RGMII_COPPER_ETHERNET op-mode as
> well.
>
> Fixes: 94e86ef1b801 ("net: phy: dp83869: support mii mode when rgmii strap cfg is used")
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
> NOTE: This patch is needed for MII mode to work for ICSSG Ethernet driver.
> I will post the device tree patch for MII mode and mark that as dependent
> on this patch.
>
>  drivers/net/phy/dp83869.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
> index fa8c6fdcf301..d7aaefb5226b 100644
> --- a/drivers/net/phy/dp83869.c
> +++ b/drivers/net/phy/dp83869.c
> @@ -695,7 +695,8 @@ static int dp83869_configure_mode(struct phy_device *phydev,
>  	phy_ctrl_val = dp83869->mode;
>  	if (phydev->interface == PHY_INTERFACE_MODE_MII) {
>  		if (dp83869->mode == DP83869_100M_MEDIA_CONVERT ||
> -		    dp83869->mode == DP83869_RGMII_100_BASE) {
> +		    dp83869->mode == DP83869_RGMII_100_BASE ||
> +		    dp83869->mode == DP83869_RGMII_COPPER_ETHERNET) {
>  			phy_ctrl_val |= DP83869_OP_MODE_MII;
>  		} else {
>  			phydev_err(phydev, "selected op-mode is not valid with MII mode\n");
>
> base-commit: 6bea4f03c6a4e973ef369e15aac88f37981db49e

Reviewed-by: Ravi Gunasekaran <r-gunasekaran@ti.com>

Regards,
Ravi


Return-Path: <linux-kernel+bounces-52221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC42849596
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1C511F239AB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8397E1173D;
	Mon,  5 Feb 2024 08:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iZx2xTHj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521BC11705;
	Mon,  5 Feb 2024 08:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707122669; cv=none; b=PJeom14mH1f6pZKtUlzH16gNNAprFuXAc8mciqZsL8QyciM2Jxmcsr3XHh9bRdl2kh5QVAY+QFGpElSDaCZQJC1EAAznFfSB6GXf51PyXF4WN0qls4wmOZpIwTGun6LV65Ao0VJOX9g4nPe7r0P8L/wrIxT317tlKmSOP8ohZwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707122669; c=relaxed/simple;
	bh=GUgIX7042RtSBJu7+ePH48NnTwLvSOMarn6Vwpzc2Wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oveUBUrSsSWrdX5ExDXspsbxQL9di2ZYF44M/dG2dMgvpCGGpNTCVoOlUwH+m/m3Ou8crzDi94oShs1tzDRzH65i1vqn6tuUDDQv31x9oJwUEnNfqszPwhtNA0hFHS7mR4zaEuxoYn/BvETofaScDujqGUdbud6WS/CAZL1w7Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iZx2xTHj; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707122668; x=1738658668;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GUgIX7042RtSBJu7+ePH48NnTwLvSOMarn6Vwpzc2Wo=;
  b=iZx2xTHjS0T2FwOHw/6KDWBJjSPnEeQLDoy2CM7etanZIbF9Blsag/CI
   p2vGpLXt9AijWjMu41tHFfAh7h8yrnZMquv489sBIiMKTeXeWQJcqbKFE
   wfCfEK1GyqRuFkAi225Fm3z9FpRduIn+6TsFq55zOImu40Liqh2Vq6tdR
   i8eCVILdmo4LFaSMnHntFGpTD0NPY2CoHXLWHAEmlLa9UzQctbDkSDjUK
   HSDFtyKlyUVnNBakZHur4ETdlwdA2PFMSjjVTtQTnfIBym+F7zUWmYpBN
   vZzw32JQtR3xz+cFzU4zdIevCXKrDoZQzp74OmFUJ0cwen4hultrFNrwc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="11833702"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="11833702"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 00:44:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="823808641"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="823808641"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 00:44:24 -0800
Date: Mon, 5 Feb 2024 09:44:16 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] lan966x: Fix crash when adding interface under a lag
Message-ID: <ZcCf4IGJHhY8uQQd@mev-dev>
References: <20240205080756.2134143-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205080756.2134143-1-horatiu.vultur@microchip.com>

On Mon, Feb 05, 2024 at 09:07:56AM +0100, Horatiu Vultur wrote:
> There is a crash when adding one of the lan966x interfaces under a lag
> interface. The issue can be reproduced like this:
> ip link add name bond0 type bond miimon 100 mode balance-xor
> ip link set dev eth0 master bond0
> 
> The reason is because when adding a interface under the lag it would go
> through all the ports and try to figure out which other ports are under
> that lag interface. And the issue is that lan966x can have ports that are
> NULL pointer as they are not probed. So then iterating over these ports
> it would just crash as they are NULL pointers.
> The fix consists in actually checking for NULL pointers before accessing
> something from the ports. Like we do in other places.
> 
> Fixes: cabc9d49333d ("net: lan966x: Add lag support for lan966x")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  drivers/net/ethernet/microchip/lan966x/lan966x_lag.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_lag.c b/drivers/net/ethernet/microchip/lan966x/lan966x_lag.c
> index 41fa2523d91d3..89a2c3176f1da 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_lag.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_lag.c
> @@ -37,19 +37,24 @@ static void lan966x_lag_set_aggr_pgids(struct lan966x *lan966x)
>  
>  	/* Now, set PGIDs for each active LAG */
>  	for (lag = 0; lag < lan966x->num_phys_ports; ++lag) {
> -		struct net_device *bond = lan966x->ports[lag]->bond;
> +		struct lan966x_port *port = lan966x->ports[lag];
>  		int num_active_ports = 0;
> +		struct net_device *bond;
>  		unsigned long bond_mask;
>  		u8 aggr_idx[16];
>  
> -		if (!bond || (visited & BIT(lag)))
> +		if (!port || !port->bond || (visited & BIT(lag)))
>  			continue;
>  
> +		bond = lan966x->ports[lag]->bond;
Why not bond = port->bond?

>  		bond_mask = lan966x_lag_get_mask(lan966x, bond);
>  
>  		for_each_set_bit(p, &bond_mask, lan966x->num_phys_ports) {
>  			struct lan966x_port *port = lan966x->ports[p];
>  
> +			if (!port)
> +				continue;
> +
>  			lan_wr(ANA_PGID_PGID_SET(bond_mask),
>  			       lan966x, ANA_PGID(p));
>  			if (port->lag_tx_active)
> -- 
> 2.34.1
> 
Only nit, otherwise:
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Thanks,
Michal


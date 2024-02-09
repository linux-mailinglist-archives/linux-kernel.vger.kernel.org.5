Return-Path: <linux-kernel+bounces-60053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3338484FF43
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE77C1F2869B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB40921344;
	Fri,  9 Feb 2024 21:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqpRvUPS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCDF182D2;
	Fri,  9 Feb 2024 21:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707515542; cv=none; b=iGjq4vFuEk12zCLAavldGzOG0g/NPjgBncUAdF+ZhXnZQPzENWePyYFmik9Lc4xiyL8xZp1Cf0fQUCau6YiDEjGmHvOnzY6Us9yOj0OYpRLektsQFWMvpOrxvrocempg2OfDznVMBi/RwH8DvWXXAltFWaMhnuSKKWDZ8baHq1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707515542; c=relaxed/simple;
	bh=ITlZfXA0AQDxLvjmHxyPVr13LSlyEa2q3DAmsysPnNE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qvu9UdL54o7DVqGn3ATTKZ4oqLkSieYb4uWNMgooXaJ7oNBXMg7gR9wg+nS+VCwUh6sGrnAY0+KyUVRgp7yLTcc/8HmGbuSfH5EsuefkwHV5d8mcheROWneFgm/WJoACrdtDIYNK+e9jVAJljx8jS9znwZrmjXq8/Iwa7680zbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqpRvUPS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A71C433C7;
	Fri,  9 Feb 2024 21:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707515541;
	bh=ITlZfXA0AQDxLvjmHxyPVr13LSlyEa2q3DAmsysPnNE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZqpRvUPSm7UKviJ2lZRxr99hZmWqGrg8qIe7U+dYYT257cPk6QwduDFwjsRapE2Rr
	 MgMxlpNDH3Jr7zWPYLsHK8DaN8u5ZXkrNk8mL8zWcBDg7UXk/To4KiegyPiM59FbEh
	 5dzjocxFZf4TlMrRKFMog9wdStzrgxe2E+BukbtPg1+YUDwG1g/3NMAgERZ7WGKFFQ
	 yVISjh2edR8gRHg6hf3JAig/pw0j2cU+MhLeTimZitnmRyqwFAt4OXeNTXNQcNKZmr
	 p/rKs2nIbS/fKJmi+lBFu+gAcIdFTgY2EfW4BUo4nooCDEANIFQwbK+LztGl7AEyV9
	 /cm/WicNJIUoQ==
Date: Fri, 9 Feb 2024 13:52:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Michal Swiatkowski
 <michal.swiatkowski@linux.intel.com>
Subject: Re: [PATCH net v2] lan966x: Fix crash when adding interface under a
 lag
Message-ID: <20240209135220.42e670d4@kernel.org>
In-Reply-To: <20240206123054.3052966-1-horatiu.vultur@microchip.com>
References: <20240206123054.3052966-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 Feb 2024 13:30:54 +0100 Horatiu Vultur wrote:
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
> +		bond = port->bond;
>  		bond_mask = lan966x_lag_get_mask(lan966x, bond);
>  
>  		for_each_set_bit(p, &bond_mask, lan966x->num_phys_ports) {
>  			struct lan966x_port *port = lan966x->ports[p];
>  
> +			if (!port)
> +				continue;

Why would lan966x_lag_get_mask() set a bit for a port that doesn't
exist? Earlier check makes sense. This one seems too defensive.
-- 
pw-bot: cr


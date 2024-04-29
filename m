Return-Path: <linux-kernel+bounces-162985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B978B630D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82B7DB21F40
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F805140E5B;
	Mon, 29 Apr 2024 20:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RACQStYK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B26013DBBF;
	Mon, 29 Apr 2024 20:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714420934; cv=none; b=KJkCIW6u7fQ/8vy3scK12U9GO3SCVrtoeIDXB6EfTIE/x3+JiK1qP0wPn5Fk/L3nt/oZEU/9Ppm5msicafNGG215q06WuRxkeOw7wJixkivzU7GMxnm1W/gmdf8wEoRqt9BE5QlDEzx3vmYCj8evV+ahKMlHF+DJNxA4xGACED8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714420934; c=relaxed/simple;
	bh=vHS/ptla2mwP6XYt6Xcx0zxc8F6JczcDTaQZFsC9CTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hapvLgZFy5kubKJZ46UT+9Ubqg+M6kMcZwlkWCorp+/YLKHdB8T1lYO74/IaDsysVsLHtJfAoau6ng02d2dXuIcvqmHlTMyxs0/VrOeHcAPBstTD+CseEtsXduIFkaV37JrCNq/lN2floWMnzg4BSHVEdJp+stERv0LeJ/+fgCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RACQStYK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5137C113CD;
	Mon, 29 Apr 2024 20:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714420934;
	bh=vHS/ptla2mwP6XYt6Xcx0zxc8F6JczcDTaQZFsC9CTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RACQStYKfNgky/pH6fJjctmTggrmtCY6pXdPArKgQc5jef1EmUYyc5tb4bhJ3poAB
	 6la/44JKo2+fkGm+p8SvPJdo/QCE83wGIzEqFrGmk6byNUighgERJuj/zKf9sFksBP
	 0R6ZDsoI35+PAeUJojTt1Q+PEoieNkB6G85kvCwMJQggR0eeZvv63unTNCE3c4ZzrS
	 ZAri7x/Mx/2ii1SV0GQTz03DvyXGxGxdzy18tZyPNdihPIY2ydeycYW8NPktzX/HGu
	 sCB18Maf5MiJw+CE6AEbqo8a6ldQkkHTAKVnz/ZmhZVHTOlDDYGl8OieArjFl4IqH8
	 cTTHEWjh6qgUg==
Date: Mon, 29 Apr 2024 21:00:39 +0100
From: Simon Horman <horms@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 2/2] net: dsa: Remove adjust_link paths
Message-ID: <20240429200039.GH516117@kernel.org>
References: <20240429165405.2298962-1-florian.fainelli@broadcom.com>
 <20240429165405.2298962-3-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429165405.2298962-3-florian.fainelli@broadcom.com>

On Mon, Apr 29, 2024 at 09:54:05AM -0700, Florian Fainelli wrote:
> Now that we no longer any drivers using PHYLIB's adjust_link callback,
> remove all paths that made use of adjust_link as well as the associated
> functions.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

..

> @@ -1616,17 +1597,13 @@ static void dsa_port_phylink_mac_link_down(struct phylink_config *config,
>  					   phy_interface_t interface)
>  {
>  	struct dsa_port *dp = dsa_phylink_to_port(config);
> -	struct phy_device *phydev = NULL;

Hi Florian,

I'm wondering if some changes got lost somewhere.

phydev is removed here...

>  	struct dsa_switch *ds = dp->ds;
>  
>  	if (dsa_port_is_user(dp))
>  		phydev = dp->user->phydev;

.. assigned here, but not used.

Perhaps the three lines above should be removed?

>  
> -	if (!ds->ops->phylink_mac_link_down) {
> -		if (ds->ops->adjust_link && phydev)
> -			ds->ops->adjust_link(ds, dp->index, phydev);
> +	if (!ds->ops->phylink_mac_link_down)
>  		return;
> -	}
>  
>  	ds->ops->phylink_mac_link_down(ds, dp->index, mode, interface);
>  }

..

-- 
pw-client: changes-requested


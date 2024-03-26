Return-Path: <linux-kernel+bounces-118682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B3188BDFC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 922CC1F3153F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A5070CDC;
	Tue, 26 Mar 2024 09:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZs53TSZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D547454BF0;
	Tue, 26 Mar 2024 09:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711445106; cv=none; b=KXoPuyJm0WP4f4LrYQURtzuua1QFvtxBe2Vee6Pi7BG8+0G1Fx4kwBPViK1tI3lkaQCeKppVWnJ/iQTfdqzxnDpPaFAq0mEF5u9x/ZKgUwbhMAeWHiUfqmtWN+WZqhuaI4IGCIUd6RtWJRVRU86ZYsrgEKp8TCBQvP9z0Y25C0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711445106; c=relaxed/simple;
	bh=ljvUxtK/9jOt8kIDbODRBzu12bdgGAnl4c7NLEPO/4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGtECuVcFuVfcmmAeylpD1TjtgpitfMWrAwO84kxkFcZqJmHYptN03Nki1iU8FcgMHutL+KZRrZPdjwK+FgyO47IRcyHrGEBjeA8Pl4KR88cFEbH1Bi9dxPRBwSOdPbKbX0O+CfTjVUnyNxPpuel6aiKvLuuU7Jx5vqjlpH4g9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZs53TSZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 298F7C433C7;
	Tue, 26 Mar 2024 09:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711445106;
	bh=ljvUxtK/9jOt8kIDbODRBzu12bdgGAnl4c7NLEPO/4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TZs53TSZOugXXT8bwTOrikFQZb0aY2cYhS4a1hN7NQDQy90LeZ6+kpGLt5zm9IeJ/
	 zDJpQg+TadxLf0+vCuJWPDCXy3erj3Ubacg1npWKgX0Sg4OKAMxVSvXEqSqAqvHM+W
	 0Pv/eL2R8yfjq76aI0eZcd1dVv20/CtkXUGdhVv19PEgjGygk10ongdHKVfmB4HkTH
	 qnEu/TRiXnVKsI5Q3fO5F1LS+B8q0lc5HIesQwgmFqGkksdD1sW9uM93CAJiOUKv7i
	 4nNVTmQ07wWQ9ALtMyX1adzeR2KokJ5CmkvXvZpa3+SDGZDt5TCXJxyqYim586G0kw
	 BKKGjoWLTCXLg==
Date: Tue, 26 Mar 2024 09:24:59 +0000
From: Simon Horman <horms@kernel.org>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH] net: usb: ax88179_178a: avoid the interface always
 configured as random address
Message-ID: <20240326092459.GG403975@kernel.org>
References: <20240325173155.671807-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325173155.671807-1-jtornosm@redhat.com>

On Mon, Mar 25, 2024 at 06:31:50PM +0100, Jose Ignacio Tornos Martinez wrote:
> After the commit d2689b6a86b9 ("net: usb: ax88179_178a: avoid two
> consecutive device resets"), reset is not executed from bind operation and
> mac address is not read from the device registers or the devicetree at that
> moment. Since the check to configure if the assigned mac address is random
> or not for the interface, happens after the bind operation from
> usbnet_probe, the interface keeps configured as random address, although the
> address is correctly read and set during open operation (the only reset
> now).
> 
> In order to keep only one reset for the device and to avoid the interface
> always configured as random address, after reset, configure correctly the
> suitable field from the driver, if the mac address is read successfully from
> the device registers or the devicetree.

Thanks Jose,

The above makes sense to me and I agree with your fix and
corresponding Fixes tag.

> In addition, if mac address can not be read from the driver, a random
> address is configured again, so it is not necessary to call
> eth_hw_addr_random from here. Indeed, in this situtatuon, when reset was
> also executed from bind, this was invalidating the check to configure if the
> assigned mac address for the interface was random or not.

I also agree with your analysis here. However it does seem to be a separate
problem. And perhaps warrants a separate patch. I am also wondering
if this is more of a clean-up than a fix: does it cause a bug
that is observable by users?

> cc: stable@vger.kernel.org # 6.6+
> Fixes: d2689b6a86b9 ("net: usb: ax88179_178a: avoid two consecutive device resets")
> Reported-by: Dave Stevenson  <dave.stevenson@raspberrypi.com>
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> ---
>  drivers/net/usb/ax88179_178a.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
> index 88e084534853..d2324cc02461 100644
> --- a/drivers/net/usb/ax88179_178a.c
> +++ b/drivers/net/usb/ax88179_178a.c
> @@ -1273,10 +1273,9 @@ static void ax88179_get_mac_addr(struct usbnet *dev)
>  
>  	if (is_valid_ether_addr(mac)) {
>  		eth_hw_addr_set(dev->net, mac);
> -	} else {
> +		dev->net->addr_assign_type = NET_ADDR_PERM;
> +	} else
>  		netdev_info(dev->net, "invalid MAC address, using random\n");
> -		eth_hw_addr_random(dev->net);
> -	}

nit: AFAIK, if one arm of a conditional has curly-brackets, then all should.
     So there is no need to drop them here.

>  
>  	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_NODE_ID, ETH_ALEN, ETH_ALEN,
>  			  dev->net->dev_addr);
> -- 
> 2.44.0
> 
> 


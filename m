Return-Path: <linux-kernel+bounces-117989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BEF88B674
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4C04B3A7A8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2CF5BAC1;
	Mon, 25 Mar 2024 20:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/jnsN4s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC3A2C87C;
	Mon, 25 Mar 2024 20:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711400045; cv=none; b=mEZ7HfF0m0x23EtKyJQeYOd0lAsUvmhzX4BKxaYlz8ThTIue/XfeEP1gTDV8JBZfRiJI0Fr0P7ep68L5TUQlNJjF+60oXzXd3B57/OLibeTD/rADTPM4JVhPfOYPppHbhc/djtmWVQAVTce6LzMl6WQGTyLg06NZDFmIb8K6Dd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711400045; c=relaxed/simple;
	bh=K/UWqJ3RELUjwbbwbY+jm8V/OvOciYNRSFf5gpvWG/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWEWMout4aJsQCQAuihEa9T5oSMF7YKcQAdmIbycBcpXo5//b6aLQTvEmtJyYCzWbn7TtT8ICKITeS4xcB5AQp4+LsBV6swm1IN/8Ku3IvDZgW5LF08aURwc1UJsSu/ylFW0kb6wCWAgHQPkmmSOPiPJH8L6WzEcdWDCw/5FHyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/jnsN4s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B526C433C7;
	Mon, 25 Mar 2024 20:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711400045;
	bh=K/UWqJ3RELUjwbbwbY+jm8V/OvOciYNRSFf5gpvWG/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B/jnsN4smTnxj4WLDKV7xQOHnLZhwOs1v20W5LLbc1G6BS1dsjo2tlu58/+IO9cVo
	 zWlEbJtp63AsozGP1BMpuQEaAxiXefNlBTSHtnhKvTWNmPDsDO7CwiJJ74c7yqY9/r
	 4I2Po7xse2RPq0ZW+GqsYs0QsmkBKdwaU1o8VLslNCD3/xr3xmN13LM+lzTKApWDe8
	 n2lwPYegNWWNuT0oGEFXq1rnp9ViAt6nKw00wBAHmpXiu5pV+GDnflRJKOm6c5Ct1N
	 jIb96JgdIlCm2nykfI4Xa0ZBNPUcUKKMdJLK5eU5nTbbpRhQwcGZ9PBgOeVQUZhNjf
	 F3sDjOq8DQgmA==
Date: Mon, 25 Mar 2024 20:54:01 +0000
From: Simon Horman <horms@kernel.org>
To: thomas.perrot@bootlin.com
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: macb: allow MTU change when the interface
 is up
Message-ID: <20240325205401.GF403975@kernel.org>
References: <20240325152735.1708636-1-thomas.perrot@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325152735.1708636-1-thomas.perrot@bootlin.com>

On Mon, Mar 25, 2024 at 04:27:35PM +0100, thomas.perrot@bootlin.com wrote:
> From: Thomas Perrot <thomas.perrot@bootlin.com>
> 
> The macb_change_mtu callback doesn't allow MTU changes when the
> interface is up because the MTU is used to set the buffer size on
> GEM.
> 
> So, to be able to change the MTU from userspace it is necessary to
> explicitly down then to up the interface, which is problematic in
> some cases.
> 
> Then we suggest to reset the interface when the interface is already
> up to allow to change the MTU, regardless of if the interface is up
> or not.
> 
> Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>

Hi Thomas,

I'm not sure that it is expected behaviour for an interface
to reset like this when a change of MTU is requested.
While conversely I think it is common (if not entirely desirable)
to prohibit changing the MTU when an interface is up.
What is the problem being addressed here?

> ---
>  drivers/net/ethernet/cadence/macb_main.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 898debfd4db3..5c20b162c5da 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -3019,11 +3019,19 @@ static int macb_close(struct net_device *dev)
>  
>  static int macb_change_mtu(struct net_device *dev, int new_mtu)
>  {
> -	if (netif_running(dev))
> -		return -EBUSY;
> +	int reset = 0;

nit: reset could be bool and set to true and false.

> +
> +	/* On GEM the buffer size is based on the MTU */
> +	if (netif_running(dev)) {
> +		macb_close(dev);
> +		reset = 1;
> +	}
>  
>  	dev->mtu = new_mtu;
>  
> +	if (reset)
> +		macb_open(dev);
> +
>  	return 0;
>  }
>  
> -- 
> 2.44.0
> 
> 


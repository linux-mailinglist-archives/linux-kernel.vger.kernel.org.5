Return-Path: <linux-kernel+bounces-21529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3BA8290D0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2320D1C24C52
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEA03E484;
	Tue,  9 Jan 2024 23:28:54 +0000 (UTC)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2485912E41;
	Tue,  9 Jan 2024 23:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 758F92028F;
	Wed, 10 Jan 2024 00:28:42 +0100 (CET)
Date: Wed, 10 Jan 2024 00:28:38 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] net: phy: micrel: reset KSZ9x31 when resuming
Message-ID: <20240109232838.GA3626@francesco-nb>
References: <20240109205223.40219-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109205223.40219-1-wsa+renesas@sang-engineering.com>

- Philippe, email address is no longer valid.

On Tue, Jan 09, 2024 at 09:52:22PM +0100, Wolfram Sang wrote:
> On a Renesas Ebisu board, the KSZ9031 PHY is stalled after resuming if
> the interface has not been brought up before suspending. If it had been
> brought up before, phylib ensures that reset is asserted before
> suspending. But if it had never been brought up, there is no instance
> which could ensure that reset is asserted. And upon resume, the PHY is
> in an unknown state without reset being asserted. To bring it back to a
> known state, simply reset it when it is about to be resumed.
> 
> This likely also helps another issue [1] where a KSZ9131 can be powered
> using regulators. After switching power on again in resume, a reset is
> also needed.
> 
> [1] https://patchwork.kernel.org/project/netdevbpf/patch/20211214121638.138784-4-philippe.schenker@toradex.com/
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> This is a different solution to a problem I already tried to solve
> here[2]. Back then, I added code to the MAC, but I now believe it should
> be solved on PHY level. We never saw the problem with other PHYs.
> Looking at [1], it seems that KSZ9x31 is also sensitive to being
> powered down without reset being asserted. I know it is not a perfect
> proof, but I guess these assumptions are all we have.
> 
> Philippe, Francesco: do you still have access to machines with this
> issue? Could you kindly test if so?

I have access, however
 - Philippe is long gone from Toradex and he was the one looking into
   this topic
 - we did solve the issue in a different way, e.g. we no longer
   power-off the phy in suspend

Therefore is not straightforward to provide valuable feedback to you
now.


> 
> Patch is based on 6.7. Looking forward for comments if this is the
> correct layer to tackle the problem. Thanks!
> 
> 
> [2] https://lore.kernel.org/all/20230321103357.18940-1-wsa+renesas@sang-engineering.com/
> 
>  drivers/net/phy/micrel.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> index 08e3915001c3..c38d7982c06c 100644
> --- a/drivers/net/phy/micrel.c
> +++ b/drivers/net/phy/micrel.c
> @@ -1984,6 +1984,14 @@ static int kszphy_resume(struct phy_device *phydev)
>  	return 0;
>  }
>  
> +static int ksz9x31_resume(struct phy_device *phydev)
> +{
> +	phy_device_reset(phydev, 1);
> +	phy_device_reset(phydev, 0);

Is something like that fine?
Don't we need to reconfigure the ethernet phy completely on resume
if we do reset it? kszphy_config_reset() is taking care of something,
but I think that the phy being reset on resume is not handled
correctly.

Francesco



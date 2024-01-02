Return-Path: <linux-kernel+bounces-14274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABF6821AA8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A19E7B2188D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33440DDD3;
	Tue,  2 Jan 2024 11:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="X2oJaFli"
X-Original-To: linux-kernel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AC0F9D6;
	Tue,  2 Jan 2024 11:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0Yb2fFIkP5cLQYlgzU6mnGKCMR4M7mU1jTH8FqXU1eI=; b=X2oJaFlirDNr/sH98eJhnHCDTW
	6pwYF4rYVeMco1pZTMkBhgN1ELovdOENTdp966Y3FsTi8E4eGIBsOieeqIuzrPyEUMHXdckz/dCaV
	931BAgM/Ez9e7cZFO8PS2U/u4d6k8kU5g7B+/x/RyFJNqawdEHw30KiOZznW/7gIhbvfDmkBN0cJr
	4j/crFUXw3nPyLJeRvLiseTGZhrCN1i7XqmZv3hNJ+NgDMmKEAUSDAjxzRWHb5PuDVyD4LNH7FtbC
	weNd5SdszZz/LKyyh3ZPJXn5T3B4a61a+Cshsn9Yw74FfXMOQDIkPxKuQhP46iZ3oQDpuIpnzmx/U
	4DROCJLg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49826)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rKcXe-0006Qb-1g;
	Tue, 02 Jan 2024 11:02:38 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rKcXg-0005Ct-T2; Tue, 02 Jan 2024 11:02:40 +0000
Date: Tue, 2 Jan 2024 11:02:40 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: mdio: get/put device node during
 (un)registration
Message-ID: <ZZPtUIRerqTI2/yh@shell.armlinux.org.uk>
References: <20231220045228.27079-2-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220045228.27079-2-luizluca@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Dec 20, 2023 at 01:52:29AM -0300, Luiz Angelo Daros de Luca wrote:
> The __of_mdiobus_register() function was storing the device node in
> dev.of_node without increasing its reference count. It implicitly relied
> on the caller to maintain the allocated node until the mdiobus was
> unregistered.
> 
> Now, __of_mdiobus_register() will acquire the node before assigning it,
> and of_mdiobus_unregister_callback() will be called at the end of
> mdio_unregister().
> 
> Drivers can now release the node immediately after MDIO registration.
> Some of them are already doing that even before this patch.
> 
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

I don't like this, certainly not the use of a method prefixed by a
double-underscore, and neither the conditional nature of "putting"
this. That alone seems to point to there being more issues.

I also notice that netdev have applied this without *any* review from
phylib maintainers. Grr.

Indeed there are more issues with the refcounting here. If one looks at
drivers/net/phy/mdio_bus.c::of_mdiobus_link_mdiodev(), we find this:

                if (addr == mdiodev->addr) {
                        device_set_node(dev, of_fwnode_handle(child));
                        /* The refcount on "child" is passed to the mdio
                         * device. Do _not_ use of_node_put(child) here.
                         */
                        return;

but there is nowhere that this refcount is dropped. 

Really, the patch should be addressing the problem rather than putting
a sticky-plaster over just one instance of it.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


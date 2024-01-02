Return-Path: <linux-kernel+bounces-14663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CAE822076
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D93B7281D30
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 17:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9481156C9;
	Tue,  2 Jan 2024 17:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="lX8vRVOl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87478156C8;
	Tue,  2 Jan 2024 17:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=88r7GWZg9xFdEciPBDZ+JiD1krfoRUPpwddSStVgxfI=; b=lX8vRVOlpuM7hDdD6K2fvkbOZd
	VPP1QhUFJ4aS6XuiyBU0+LaB5nF8+uXuDtdGI6avGTcWrZ/BL8p7az1o7FPvyNdZipjGK2ah5ynfz
	TG2AteKgS+BoCTpBZmmMTQhzrrZ9b8WMT3dpxn+sl2zLSyjzteRW/mgRNvCOCwBK8WZ2SgB0XUEkm
	DSPk6qJSzoeTwUKbcGMN1b2pv7lC1HKOqCx5vtRrmjZagAwnDWZXQZCQ9MvJynlJcC9C0lTjOQ0YW
	llhPsiBz3W6zNEhp9vCe6BDndWXdRk+ey1c1ieFBY8koLAz80NK8Aql1GaYPRKFlcNgOzTIxKjdEo
	3JHPgw8g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58516)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rKiey-0006lm-0p;
	Tue, 02 Jan 2024 17:34:36 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rKif0-0005VF-Bu; Tue, 02 Jan 2024 17:34:38 +0000
Date: Tue, 2 Jan 2024 17:34:38 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew@lunn.ch, olteanv@gmail.com,
	hkallweit1@gmail.com, kabel@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH net-next] net: phy: Cleanup struct mdio_driver_common
Message-ID: <ZZRJLg6U0G5CNRQ0@shell.armlinux.org.uk>
References: <20231228072350.1294425-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231228072350.1294425-1-yajun.deng@linux.dev>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Dec 28, 2023 at 03:23:50PM +0800, Yajun Deng wrote:
> The struct mdio_driver_common is a wrapper for driver-model structure,
> it contains device_driver and flags. There are only struct phy_driver
> and mdio_driver that use it. The flags is used to distinguish between
> struct phy_driver and mdio_driver.
> 
> We can test that if probe of device_driver is equal to phy_probe. This
> way, the struct mdio_driver_common is no longer needed, and struct
> phy_driver and usb_mdio_driver will be consistent with other driver
> structs.

usb_mdio_driver?

I'm not sure why this consistency is even desired, the commit message
doesn't properly say _why_ this change is being proposed.

> +bool is_phy_driver(struct device_driver *driver)
> +{
> +	return driver->probe == phy_probe;
> +}
> +EXPORT_SYMBOL_GPL(is_phy_driver);

Do we really need this exported? It doesn't seem like something anything
other than core MDIO/phylib code should know about, and all that becomes
a single module when building it in a modular way - phylib can't be a
separate module from mdio stuff.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


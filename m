Return-Path: <linux-kernel+bounces-25922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C2782D850
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 12:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23A761F2234D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D512C6A9;
	Mon, 15 Jan 2024 11:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="YSYyAuxi"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FDB2C6A2;
	Mon, 15 Jan 2024 11:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Mg9rkN4qdp0wGiNpTxlcLmFAeg1D4VoqNkVDYwsxzS0=; b=YSYyAuxiM5XGO/kFZsBnmz6ISy
	MNBM6C7m9vMs0Ew/BT/iDEzyoEduc+TmkSI5OXXQM1pS3n6jyhrZZVYBkYwkViEqyhe0v3xYfCiAK
	HVUm4TlQ7ZUWQOpQCDK1NO0D6qYaTagGg8/QGJL4qr4F/LZrlGFEOZSr4o1dvlnbv4c8g5wRnmc/s
	6FAb/Ut+nOPb8u/EyjCjfMXKy9zToRwTcQPy+4Inuetqsop9JWrWrqQMC2r35NOOaTLMju2zOtI5B
	G0nnJ4k58XWLX9RwsouWvflgK5lRIvBhU5pi5tExSYYpugQT8rUvMa76ryT7vfenmqrmgxAeqOP9N
	3fPDjk/Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36022)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rPL8b-0002Lx-0h;
	Mon, 15 Jan 2024 11:28:18 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rPL8Y-0002ud-8c; Mon, 15 Jan 2024 11:28:14 +0000
Date: Mon, 15 Jan 2024 11:28:14 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	f.fainelli@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: phy: Fix possible NULL pointer dereference
 issues caused by phy_attached_info_irq
Message-ID: <ZaUWztbMPhbApPIH@shell.armlinux.org.uk>
References: <20240115085018.30300-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115085018.30300-1-chentao@kylinos.cn>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 15, 2024 at 04:50:18PM +0800, Kunwu Chan wrote:
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index ed0b4ccaa6a6..819574a06036 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -1886,7 +1886,7 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
>  	irq_str = phy_attached_info_irq(phy);
>  	phylink_info(pl,
>  		     "PHY [%s] driver [%s] (irq=%s)\n",
> -		     dev_name(&phy->mdio.dev), phy->drv->name, irq_str);
> +		     dev_name(&phy->mdio.dev), phy->drv->name, irq_str ? irq_str : "");


		     dev_name(&phy->mdio.dev), phy->drv->name,
		     irq_str ? irq_str : "");

please.

Also, please hold off posting v3 until at least 24 hours have passed.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


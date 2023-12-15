Return-Path: <linux-kernel+bounces-1469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B33C814F3A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F87E287B70
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE353FE4F;
	Fri, 15 Dec 2023 17:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ao5vRLe7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E97A41864;
	Fri, 15 Dec 2023 17:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=6doYMLm7Bax3yqK0joGshFZ7OI7/1Sir/DmkIlByeKY=; b=ao5vRLe79QhpcwBxgopft/HAge
	KzIWxjDoA+XrNGKYjtfUaFJBcDImKQnVnKt60JE3FinQosQCII3wJ6g4+qmW3keci7+Q+njUzGawJ
	MELFBtZ1kRfwNerHZWzocXQ48kJ5u0a/aHw7fbNqdqCm42m+7pj9pqLIoYgij23xqDdZU+UX+pDK+
	heHl9uYhdf1uvAMNX5bVFo27kKquTWm2MZDSRdS1D3gB9X+79vJ71FV4upSGGigBcs0z+dak58f7k
	ISMWy/hUsBSYBVJ/U61C+SV4AXv1/izjrNVrYf6G0qxHutvpIqzCJi4aXKlHjtQWgH8OvwqTjuUOo
	w/MfAFmw==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rECJh-0049Rm-1H;
	Fri, 15 Dec 2023 17:49:41 +0000
Message-ID: <2bde540c-b637-49f6-a8fd-03b5b95f752c@infradead.org>
Date: Fri, 15 Dec 2023 09:49:40 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v3 2/3] net: phy: add simple helper to return
 count of supported speeds
Content-Language: en-US
To: Christian Marangi <ansuelsmth@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231215132921.16808-1-ansuelsmth@gmail.com>
 <20231215132921.16808-3-ansuelsmth@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231215132921.16808-3-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/15/23 05:29, Christian Marangi wrote:
> Add simple helper to return count of supported speeds for the passed PHY
> device.
> 
> This can be useful to know the number of speed modes to dynamically
> allocate a speed array for it.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/net/phy/phy.c | 12 ++++++++++++
>  include/linux/phy.h   |  2 ++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index a5fa077650e8..311560e72126 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -229,6 +229,18 @@ phy_find_valid(int speed, int duplex, unsigned long *supported)
>  	return phy_lookup_setting(speed, duplex, supported, false);
>  }
>  
> +/**
> + * phy_supported_speeds_num - return the number of all speeds currently
> + *			      supported by a phy device
> + * @phy: The phy device to return supported speeds of.
> + *
> + * Description: Returns the number of supported speeds.

For kernel-doc, better to have that line as:

 * Returns: the number of supported speeds.



> + */
> +unsigned int phy_supported_speeds_num(struct phy_device *phy)
> +{
> +	return phy_speeds(NULL, 0, phy->supported);
> +}
> +
>  /**
>   * phy_supported_speeds - return all speeds currently supported by a phy device
>   * @phy: The phy device to return supported speeds of.
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index 3cc52826f18e..52aa415fab0f 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -202,6 +202,8 @@ static inline void phy_interface_set_rgmii(unsigned long *intf)
>  	__set_bit(PHY_INTERFACE_MODE_RGMII_TXID, intf);
>  }
>  
> +unsigned int phy_supported_speeds_num(struct phy_device *phy);
> +
>  /*
>   * phy_supported_speeds - return all speeds currently supported by a PHY device
>   */

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html


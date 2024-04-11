Return-Path: <linux-kernel+bounces-141499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AB68A1F0E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0F13283E68
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6D413AE2;
	Thu, 11 Apr 2024 19:04:20 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A312A12E5D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 19:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712862259; cv=none; b=e4P+JuVsONqLMrl9jsT6lcd59UEqm54ooF8QoUMI0QLsv6X+jR9A/HA9TwNNzPQTUy2pNiRc9x/kdzdZYxxavmnle174OejfzMdobKJ8tJpz42F3FEOG63sjOHY1nwjwo03SiyQxf6zGTZIB2u16qSRlhp1musDxFm9aj2dn42Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712862259; c=relaxed/simple;
	bh=MjvEpvhSAMQerqqsTV4xv/8womw6S1H48fLXNk2fiEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XkGGzt5gvZ7q1FBqevSW86vnItHVrHtYamA2MINyO7KpnGfDSZDaA1CZP5LcsSuodowzIcdzureh8wIxaO5RvxrV0kpTPbA+95BJh2cx+NPV2t8FV+Sw0y8yn9u9k00z5njjYNAd5vQmmu4uzDkYGek02ODHa9ngVe7bohVtfIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from ip-185-104-138-67.ptr.icomera.net ([185.104.138.67] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1ruziS-0002HW-BR; Thu, 11 Apr 2024 21:04:08 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Algea Cao <algea.cao@rock-chips.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] phy: phy-rockchip-samsung-hdptx: Select CONFIG_RATIONAL
Date: Thu, 11 Apr 2024 21:03:44 +0200
Message-ID: <114516975.nniJfEyVGO@phil>
In-Reply-To: <20240408222926.32708-1-cristian.ciocaltea@collabora.com>
References: <20240408222926.32708-1-cristian.ciocaltea@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Dienstag, 9. April 2024, 00:29:25 CEST schrieb Cristian Ciocaltea:
> Ensure CONFIG_RATIONAL is selected in order to fix the following link
> error with some kernel configurations:
> 
> drivers/phy/rockchip/phy-rockchip-samsung-hdptx.o: in function `rk_hdptx_ropll_tmds_cmn_config':
> phy-rockchip-samsung-hdptx.c:(.text+0x950): undefined reference to `rational_best_approximation'
> 
> Fixes: 553be2830c5f ("phy: rockchip: Add Samsung HDMI/eDP Combo PHY driver")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202404090540.2l1TEkDF-lkp@intel.com/
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  drivers/phy/rockchip/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/phy/rockchip/Kconfig b/drivers/phy/rockchip/Kconfig
> index a34f67bb7e61..b60a4b60451e 100644
> --- a/drivers/phy/rockchip/Kconfig
> +++ b/drivers/phy/rockchip/Kconfig
> @@ -87,6 +87,7 @@ config PHY_ROCKCHIP_SAMSUNG_HDPTX
>  	tristate "Rockchip Samsung HDMI/eDP Combo PHY driver"
>  	depends on (ARCH_ROCKCHIP || COMPILE_TEST) && OF
>  	select GENERIC_PHY
> +	select RATIONAL
>  	help
>  	  Enable this to support the Rockchip HDMI/eDP Combo PHY
>  	  with Samsung IP block.
> 






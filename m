Return-Path: <linux-kernel+bounces-146345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C538A63BB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7F31B231A2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C073D0AF;
	Tue, 16 Apr 2024 06:27:25 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C773BBF6
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 06:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713248844; cv=none; b=BXPMfsdL3o6A4rFL/EeM013tjV3ZdYQZVvEqSf33nfhWyu06BI8zUcO282BQgrNxBjhr9rkT/Djqi7xViUfshOZpwgB7NHXTfyDtkBQYiw6qZNmJhNdbYHMW8VcAB8PTZyR7IdC2xKnPlFqMc/owSvBvk169qdHv3BqrlWsqumc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713248844; c=relaxed/simple;
	bh=e6iWpFbdrqkdIbyGKXOFxiHA//NrN4bR2L8KZ1GpDy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VmNj9VYqS2B433DliIIz73FsxG1JmZT8kbv+sQW+zSA5hg4qq7igKP+zctmElo14hVc79P/9QvPRTAsy9moqJw9SPKrb+tGHm6NjIa2qsbW9HnoGhUzLeOVRVuBtqwbPDEK7wf6EDtjx1hKwLozeJ9DgaVDCz8QjVkwvp4AuVmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e8616c3.versanet.de ([94.134.22.195] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rwcHS-0005DQ-PJ; Tue, 16 Apr 2024 08:26:58 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Zhang Yubing <yubing.zhang@rock-chips.com>,
 Frank Wang <frank.wang@rock-chips.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: rockchip: fix CONFIG_TYPEC dependency
Date: Tue, 16 Apr 2024 08:26:57 +0200
Message-ID: <2727344.mvXUDI8C0e@diego>
In-Reply-To: <20240415174241.77982-1-arnd@kernel.org>
References: <20240415174241.77982-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Montag, 15. April 2024, 19:42:25 CEST schrieb Arnd Bergmann:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The newly added driver causes a warning about missing dependencies
> by selecting CONFIG_TYPEC unconditionally:
> 
> WARNING: unmet direct dependencies detected for TYPEC
>   Depends on [n]: USB_SUPPORT [=n]
>   Selected by [y]:
>   - PHY_ROCKCHIP_USBDP [=y] && ARCH_ROCKCHIP [=y] && OF [=y]
> 
> WARNING: unmet direct dependencies detected for USB_COMMON
>   Depends on [n]: USB_SUPPORT [=n]
>   Selected by [y]:
>   - EXTCON_RTK_TYPE_C [=y] && EXTCON [=y] && (ARCH_REALTEK [=y] || COMPILE_TEST [=y]) && TYPEC [=y]
> 
> Since that is a user-visible option, it should not really be selected
> in the first place. Replace the 'select' with a 'depends on' as
> we have for similar drivers.
> 
> Fixes: 2f70bbddeb45 ("phy: rockchip: add usbdp combo phy driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  drivers/phy/rockchip/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/rockchip/Kconfig b/drivers/phy/rockchip/Kconfig
> index a752ccdddb86..08b0f4345760 100644
> --- a/drivers/phy/rockchip/Kconfig
> +++ b/drivers/phy/rockchip/Kconfig
> @@ -120,8 +120,8 @@ config PHY_ROCKCHIP_USB
>  config PHY_ROCKCHIP_USBDP
>  	tristate "Rockchip USBDP COMBO PHY Driver"
>  	depends on ARCH_ROCKCHIP && OF
> +	depends on TYPEC
>  	select GENERIC_PHY
> -	select TYPEC
>  	help
>  	  Enable this to support the Rockchip USB3.0/DP combo PHY with
>  	  Samsung IP block. This is required for USB3 support on RK3588.
> 






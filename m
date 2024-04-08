Return-Path: <linux-kernel+bounces-135377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0FF89BFB4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BBD7285DE4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5974271727;
	Mon,  8 Apr 2024 12:59:47 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB906CDA8
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 12:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581186; cv=none; b=UUtmImJEKGY2HrWOKqQgZ3W0z1nDBrdST2N3BUwkPihyUo4DSmyiud8YLU+h8FhM0UFvovChDCcyWSGepruN3Mhcdtaq7IcYDt+w5Zxssc6sMX08nseFqNU+SMhWebqwAa0XSTvoZTb2Ad+E6+ZECALBXFPtd+FWEL1glxPwqig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581186; c=relaxed/simple;
	bh=HvDCqVEIoJK9fnXjivKaPmavqQ/maelTiQzEJDIQVcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMRxN7tUOrUoUYPcVOrz4/fD5+SA7bbn+Mer7kKTkcEXCrWlxusO0cEhXzvqBp07Vwr1i6SMO7WjLcOOip97F5XdwfvSyck3FZNzGDYutfyz5SF/x+rqoCscpr6g0iu7Jot+Ot9ITadz1Pr83D+H3kTSB7bCIPlePIZX8pUnxKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rtoas-0004Ly-2b;
	Mon, 08 Apr 2024 12:59:26 +0000
Date: Mon, 8 Apr 2024 13:59:24 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	William-tw Lin <william-tw.lin@mediatek.com>,
	Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] soc: mediatek: mtk-socinfo: select CONFIG_SOC_BUS
Message-ID: <ZhPqLGYxK3NRCSXl@makrotopia.org>
References: <20240408125506.1594257-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408125506.1594257-1-arnd@kernel.org>

Hi,

On Mon, Apr 08, 2024 at 02:55:00PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This is needed to avoid a link failure:
> 
> ERROR: modpost: "soc_device_register" [drivers/soc/mediatek/mtk-socinfo.ko] undefined!
> ERROR: modpost: "soc_device_unregister" [drivers/soc/mediatek/mtk-socinfo.ko] undefined!
> 

I've tried to take care of this in the exact same way a long time
ago. Don't ask me why it didn't find it's way into stable yet

https://patchwork.kernel.org/project/linux-mediatek/patch/cc8f7f7da5bdccce514a320e0ae7468659cf7346.1707327680.git.daniel@makrotopia.org/


Cheers


Daniel

> Fixes: 423a54da3c7e ("soc: mediatek: mtk-socinfo: Add driver for getting chip information")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/soc/mediatek/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
> index 50c664b65f4d..1b7afb19ccd6 100644
> --- a/drivers/soc/mediatek/Kconfig
> +++ b/drivers/soc/mediatek/Kconfig
> @@ -72,6 +72,7 @@ config MTK_SOCINFO
>  	tristate "MediaTek SoC Information"
>  	default y
>  	depends on NVMEM_MTK_EFUSE
> +	select SOC_BUS
>  	help
>  	  The MediaTek SoC Information (mtk-socinfo) driver provides
>  	  information about the SoC to the userspace including the
> -- 
> 2.39.2
> 
> 


Return-Path: <linux-kernel+bounces-143955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CE28A4007
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 05:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86C13B2106B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 03:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A912F17740;
	Sun, 14 Apr 2024 03:41:34 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5D428E8;
	Sun, 14 Apr 2024 03:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713066094; cv=none; b=oAQDTLw5Fn7uKwHIdtisZCt5t8UG+zxGpbWoCMWyq+KlRn/UwmWjzh/zrDm2JVGw3T1PbETSqDcKPO4GLBgZ6YJGBc3MGFkjOjezh+UKByR8wbuq+WlMd3rwzkIxcMjHTExBWe569D98lyR2au9D1NJDrMGmg4SBtr1OEoKuQ7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713066094; c=relaxed/simple;
	bh=XcqDE9wDOopQ32UWvS4Gc8ZFheu9sU8EeMdFHOPHjDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itUl8MqqRrCchIimVs9KzZfZSoZ5nb+cqa1AuR76dz5//sPPTXQiqwum3SFcgYc4NxiqO0yKobBP7UXqcg02sEdQQmGA9NuFrToEyxPcbGNFwrWFunNjK6XU/s/qUg22BbzQQSxpfbIy7rznhcuhhudwUTKjeV1RbvVZ6kx+/UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rvqk3-0001Ep-2T;
	Sun, 14 Apr 2024 03:41:19 +0000
Date: Sun, 14 Apr 2024 04:41:16 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: arinc.unal@arinc9.com
Cc: DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Holger Stadali <hs@giax.de>,
	Bartel Eerdekens <bartel.eerdekens@constell8.be>,
	mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net 2/2] net: dsa: mt7530: fix port mirroring for MT7988
 SoC switch
Message-ID: <ZhtQXFsqS_y6_LHC@makrotopia.org>
References: <20240413-b4-for-net-mt7530-fix-mirroring-to-local-port-and-mt7988-v1-0-476deff8cc06@arinc9.com>
 <20240413-b4-for-net-mt7530-fix-mirroring-to-local-port-and-mt7988-v1-2-476deff8cc06@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240413-b4-for-net-mt7530-fix-mirroring-to-local-port-and-mt7988-v1-2-476deff8cc06@arinc9.com>

On Sat, Apr 13, 2024 at 04:01:40PM +0300, Arınç ÜNAL via B4 Relay wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> The "MT7988A Wi-Fi 7 Generation Router Platform: Datasheet (Open Version)
> v0.1" document shows bits 16 to 18 as the MIRROR_PORT field of the CPU
> forward control register. Currently, the MT7530 DSA subdriver configures
> bits 0 to 2 of the CPU forward control register which breaks the port
> mirroring feature for the MT7988 SoC switch.
> 
> Fix this by using the MT7531_MIRROR_PORT_GET() and MT7531_MIRROR_PORT_SET()
> macros which utilise the correct bits.
> 
> Fixes: 110c18bfed41 ("net: dsa: mt7530: introduce driver for MT7988 built-in switch")
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Acked-by: Daniel Golle <daniel@makrotopia.org>

> ---
>  drivers/net/dsa/mt7530.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index b84e1845fa02..8090390edaf9 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -1883,14 +1883,16 @@ mt7530_port_vlan_del(struct dsa_switch *ds, int port,
>  
>  static int mt753x_mirror_port_get(unsigned int id, u32 val)
>  {
> -	return (id == ID_MT7531) ? MT7531_MIRROR_PORT_GET(val) :
> -				   MIRROR_PORT(val);
> +	return (id == ID_MT7531 || id == ID_MT7988) ?
> +		       MT7531_MIRROR_PORT_GET(val) :
> +		       MIRROR_PORT(val);
>  }
>  
>  static int mt753x_mirror_port_set(unsigned int id, u32 val)
>  {
> -	return (id == ID_MT7531) ? MT7531_MIRROR_PORT_SET(val) :
> -				   MIRROR_PORT(val);
> +	return (id == ID_MT7531 || id == ID_MT7988) ?
> +		       MT7531_MIRROR_PORT_SET(val) :
> +		       MIRROR_PORT(val);
>  }
>  
>  static int mt753x_port_mirror_add(struct dsa_switch *ds, int port,
> 
> -- 
> 2.40.1
> 
> 


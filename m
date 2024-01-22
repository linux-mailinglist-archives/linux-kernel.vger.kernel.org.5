Return-Path: <linux-kernel+bounces-34056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4BB8372A4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 142A31F26FD8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D81E3F8E1;
	Mon, 22 Jan 2024 19:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jO/DHwQ3"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F953B790;
	Mon, 22 Jan 2024 19:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705952038; cv=none; b=D8qdVgEe9wBpr47FcfDFLzjyJBlvjf21o6Mlg9pRn9HEew3nA8tlcw/KL0B/E3WnpCxQT9StlXtkzxRS/Xc+hix7jynjBhxZ6vn0xfu2Je/z999ZdLPA3Wd9QkznlhC6LC6eCVIE13lG30sw7Wsi5E9oAk+oCXw3QpmTPvlbdaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705952038; c=relaxed/simple;
	bh=p0GdHpTNMv7Dcw3S5KC6jiYf/8HQU0tAijW9BrNacbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVlqK0aCBITsmhTchzJaT9HfaBnbP5LabLnWyxFIzVfiSYdNxx8HcPQWOvOzIvqAZAJD3D0hl3/ttY/EzGwXXHV4D6VZCfa6lOe4LrITtl8BpgN/KG7eFuTkENb/s4FYT9QQgQmbS99J3sZUQkrE7ejl0jTyca7fCRwEwrKHPRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jO/DHwQ3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/Z6SXTn8YhiWrcZlgd1ZQ8j3V9FW9S8AEHmuF/IWI4A=; b=jO/DHwQ3UDrqPgaEKtXlb4KHhO
	uOoDeXsV8PaWWb+8cBpTjQXStv6T5GVS/7ybW/ZtdJ1r8nBWbNzCHUtWA3OmkVQyxNdroow63o24l
	u3pH6TnbNKF6aXOkIrgkVw8Ia0qjLYomaVI/PL7XdWk4S9HhXx5mLLyoTnsBu5ggpgO0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rS031-005lA4-Eo; Mon, 22 Jan 2024 20:33:31 +0100
Date: Mon, 22 Jan 2024 20:33:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, abeni@redhat.com,
	edumazet@google.com, Ioana Ciornei <ioana.ciornei@nxp.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>, Alexander Couzens <lynxis@fe80.eu>,
	Daniel Golle <daniel@makrotopia.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>, dsahern@kernel.org,
	weiwan@google.com,
	"open list:LYNX PCS MODULE" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH net-next 03/22] net: fill in MODULE_DESCRIPTION()s for
 PCS Layer
Message-ID: <52e39a1b-c551-4eea-9606-62be0cbad39f@lunn.ch>
References: <20240122184543.2501493-1-leitao@debian.org>
 <20240122184543.2501493-4-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122184543.2501493-4-leitao@debian.org>

On Mon, Jan 22, 2024 at 10:45:24AM -0800, Breno Leitao wrote:
> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to the LynxI PCS MediaTek's SoC.

That patch now does more than that.

> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/net/pcs/pcs-lynx.c      | 1 +
>  drivers/net/pcs/pcs-mtk-lynxi.c | 1 +
>  drivers/net/pcs/pcs-xpcs.c      | 1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/drivers/net/pcs/pcs-lynx.c b/drivers/net/pcs/pcs-lynx.c
> index dc3962b2aa6b..d51d09beaab3 100644
> --- a/drivers/net/pcs/pcs-lynx.c
> +++ b/drivers/net/pcs/pcs-lynx.c
> @@ -398,4 +398,5 @@ void lynx_pcs_destroy(struct phylink_pcs *pcs)
>  }
>  EXPORT_SYMBOL(lynx_pcs_destroy);
>  
> +MODULE_DESCRIPTION("MediaTek SGMII library for Lynx PCS");

pcs-lynx is for NXP hardware, not MediaTek.

    Andrew

---
pw-bot: cr


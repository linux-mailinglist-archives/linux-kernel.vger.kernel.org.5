Return-Path: <linux-kernel+bounces-39490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BFB83D200
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 02:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 328631F25EC4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5910610F7;
	Fri, 26 Jan 2024 01:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbX2GfKh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBD710E9;
	Fri, 26 Jan 2024 01:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706232175; cv=none; b=oZ4ko+f8TSRk3fkHzZ9fiZ4Lqin18mOe6Ip0ASLfHsqTb6mtzGvex1vdsDm69v+WOtR8U+V4pvjja6YKggBiqtq2GVTsZXZ/vPz0dnfLR+OQyAxplCD6IRjS8nkmMn1la+XI5qpKA6TiHOWtvWqPoWsgoKc4k5CakR2BdzQp75E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706232175; c=relaxed/simple;
	bh=Hk9/gpwL/FH2xmnit/2UJvfVqasuwOB//G3xIDeSRXY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PVoQmIGTHsm3tJcBnrVgYPpQCXIRktMxIGRIsgxonkwP4gmhp9OjUQNEboJdLNSffxpFMs5Hg+yWFEgG9CUXtoxAfyQoP9HfzDjV2HiRplSdhWmZ79qBMxGsAqFLNpjqpX1fPFhm18PKjeJ+Lc22BmKke98yv7cysKUB2REOD8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbX2GfKh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3997C433C7;
	Fri, 26 Jan 2024 01:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706232175;
	bh=Hk9/gpwL/FH2xmnit/2UJvfVqasuwOB//G3xIDeSRXY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QbX2GfKhc5hZC6h46CHXmhCNSbMB8gJ/J4nLe6qNyA1qja9Bx/1+7GMkkTu7Vrkqo
	 2B1vx1tOGSpm3V8/KYFG+mBy621FwOkM5v5A6zENUMsqvkzEJLgMfZ/HNq664U8tkP
	 Nr4prtIK2SqWcBWyaxLsUhZlvjwcVKkki/Q4vBkuCUsOgMMy4HqX5xPpxEECJly+aA
	 D3N2ZmkRivt4zCmOGAHEVuKM27BJGqiVonKPbSuqcpcf3eztESC17H/FzAlpdGT4wL
	 8qEN1M9Os2zV8uf7+5rAddkolgppNsYnFmpbp2TJIesGiMlXOl4MCg/9td0zCyC+UL
	 ZL8+JdfmnpD4g==
Date: Thu, 25 Jan 2024 17:22:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Esben Haabendal <esben@geanix.com>
Cc: netdev@vger.kernel.org, Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team
 <linux-imx@nxp.com>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net: stmmac: dwmac-imx: set TSO/TBS TX queues
 default settings
Message-ID: <20240125172253.3fe50cfc@kernel.org>
In-Reply-To: <5606bb5f0b7566a20bb136b268dae89d22a48898.1706184304.git.esben@geanix.com>
References: <cover.1706184304.git.esben@geanix.com>
	<5606bb5f0b7566a20bb136b268dae89d22a48898.1706184304.git.esben@geanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jan 2024 13:34:34 +0100 Esben Haabendal wrote:
> +        for (int i = 0; i < plat_dat->tx_queues_to_use; i++) {
> +                /* Default TX Q0 to use TSO and rest TXQ for TBS */
> +                if (i > 0)
> +                        plat_dat->tx_queues_cfg[i].tbs_en = 1;
> +        }

checkpatch points out this code is indented with spaces.
Please use tabs.


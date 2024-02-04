Return-Path: <linux-kernel+bounces-51694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DDF848E52
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 210751F21C2F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EB7225CE;
	Sun,  4 Feb 2024 14:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vBcdYC6o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9F4224EE;
	Sun,  4 Feb 2024 14:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707056147; cv=none; b=W28efLuj++b0wykB0ZleBkG9ZdevogspGgYuGvEuAFvjuILmShPaOzhpLs8T5Oa6ojidvlt8qQuXXFuUyq0sRmB36ge8NhlquAhYXBp7J/UALXz3vg0HLKvHCcu3yN5ya+1/aGUM1AL6Fi3k6J79Px36PwTyRCY+EBiqqotiuGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707056147; c=relaxed/simple;
	bh=JmTkGp8i+vw27c+X20EOYx2e0BmRC9rlkGs/pm+GBV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pojn8QHsBXKRdef8UJlSmJjG9O+o19dQ+2GMFsbNKOP/6eQpXP9bWEk+0I5GuIfzB3q5TGeHkVDZiPLHoiOQzDGAI58Sbox5ql3DRZN9vzarKFUQKf1uL4tMXhMQ4K9UnLP2I1F3iLwbplc/NqnabtjknINde3ac1DdoL61laCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vBcdYC6o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59333C433C7;
	Sun,  4 Feb 2024 14:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707056146;
	bh=JmTkGp8i+vw27c+X20EOYx2e0BmRC9rlkGs/pm+GBV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vBcdYC6oZ4MQ6fjYbAD2N4VpqR5hsL7ErqO3yCInP/aH16QftZKyMD+JtyzDVere7
	 RDMY0koAcQpC1VRDCdbrOUbumH2fulXE6j2ICTgi7u9rLqvpmAZ4JIG5+Nc4JdhSlo
	 PfMIZAe6kinODgWG7CxE2r4zI9qPaTxrHkpuuTuZfQ9U1tbKm/+yOk66Ulya5gnFgM
	 IJ7gFkIDbgybjayLEhhpmX1wVgbaqcpvVJbKv8/X4BZJQGcCanN4dhWuYAZ5RezB+1
	 9ElwnGuyPcxKdo0bLJORQeVZa4i442Bk8vkhDZsN/Sg/9Mcox0E4VgdoBcY08/h9xN
	 NvrdpGSbGb6xA==
Date: Sun, 4 Feb 2024 14:15:41 +0000
From: Simon Horman <horms@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/3] net: stmmac: Allow drivers to provide a
 default AXI configuration
Message-ID: <20240204141541.GA927333@kernel.org>
References: <20240202-stmmac-axi-config-v2-0-64eab2bab17b@nvidia.com>
 <20240202-stmmac-axi-config-v2-2-64eab2bab17b@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202-stmmac-axi-config-v2-2-64eab2bab17b@nvidia.com>

On Fri, Feb 02, 2024 at 12:53:34PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> In many cases the AXI configuration can be derived from the compatible
> string, so there's no need to add the configuration to DT. Allow drivers
> to pass in the default AXI configuration so they can be properly set up
> without extra data in DT.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>

..

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> index 650ec8d2f5d7..0d5f2cebd6fc 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> @@ -91,34 +91,49 @@ static int dwmac1000_validate_ucast_entries(struct device *dev,
>   * if required, from device-tree the AXI internal register can be tuned
>   * by using platform parameters.
>   */
> -static struct stmmac_axi *stmmac_axi_setup(struct platform_device *pdev)
> +static struct stmmac_axi *stmmac_axi_setup(struct platform_device *pdev,
> +					   struct stmmac_resources *res)

Hi Thierry,

Please consider adding @res to the kernel doc for stmmac_axi_setup,
just a few lines above this hunk.

..


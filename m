Return-Path: <linux-kernel+bounces-144766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9C08A4A73
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79C342845E9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B1B3A1C4;
	Mon, 15 Apr 2024 08:36:03 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7682868D;
	Mon, 15 Apr 2024 08:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713170162; cv=none; b=UOrxwggZnxMhr23Sm41RyHaZPFEfjIzwbt5+ykCgJRDnGw5BbxxSbryw2AMi2AyxePVYxVRL6FOBVAN6HtE65hO2sdhbOKgnTeGr42FPwCfDDcHhSsP89PVLeWuK75DiTU8CIumuKjY6dj7ESqOOSjl12sGAu5EY+9/rtqGk9/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713170162; c=relaxed/simple;
	bh=I0ov0M45VZjgvYYqhyn0aZOdOUazf6x4v6erec5mCa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMUaALKKGguaiilBwPdDqFzf1yHt4dbhLqNUkigUpYqGkEUfgCSCht2uUVxnJGSkUTlmO4H9FhIu7OYrTSwjnppXKMQWxN82dpHaS+/XM2huv1lvHB+5CoS7f41sPFq62Fv+DsJkV6UqT9HRdjb4pABIcjXZLx4qv3D/1e86Rns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rwHob-0004hn-00; Mon, 15 Apr 2024 10:35:49 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
	id B9E3CC04B7; Mon, 15 Apr 2024 10:34:26 +0200 (CEST)
Date: Mon, 15 Apr 2024 10:34:26 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Songyang Li <leesongyang@outlook.com>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Octeon: Add PCIe link status check
Message-ID: <ZhzmkuYJOTIVNVL9@alpha.franken.de>
References: <TY3P286MB27542582C36379EB4A128DEFB4332@TY3P286MB2754.JPNP286.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY3P286MB27542582C36379EB4A128DEFB4332@TY3P286MB2754.JPNP286.PROD.OUTLOOK.COM>

On Wed, Mar 20, 2024 at 11:22:00PM +0800, Songyang Li wrote:
> The standard PCIe configuration read-write interface is used to
> access the configuration space of the peripheral PCIe devices
> of the mips processor after the PCIe link surprise down, it can
> generate kernel panic caused by "Data bus error". So it is
> necessary to add PCIe link status check for system protection.
> When the PCIe link is down or in training, assigning a value
> of 0 to the configuration address can prevent read-write behavior
> to the configuration space of peripheral PCIe devices, thereby
> preventing kernel panic.
> 
> Signed-off-by: Songyang Li <leesongyang@outlook.com>
> ---
>  arch/mips/pci/pcie-octeon.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>  mode change 100644 => 100755 arch/mips/pci/pcie-octeon.c
> 
> diff --git a/arch/mips/pci/pcie-octeon.c b/arch/mips/pci/pcie-octeon.c
> old mode 100644
> new mode 100755
> index 2583e318e8c6..b080c7c6cc46
> --- a/arch/mips/pci/pcie-octeon.c
> +++ b/arch/mips/pci/pcie-octeon.c
> @@ -230,12 +230,18 @@ static inline uint64_t __cvmx_pcie_build_config_addr(int pcie_port, int bus,
>  {
>  	union cvmx_pcie_address pcie_addr;
>  	union cvmx_pciercx_cfg006 pciercx_cfg006;
> +	union cvmx_pciercx_cfg032 pciercx_cfg032;
>  
>  	pciercx_cfg006.u32 =
>  	    cvmx_pcie_cfgx_read(pcie_port, CVMX_PCIERCX_CFG006(pcie_port));
>  	if ((bus <= pciercx_cfg006.s.pbnum) && (dev != 0))
>  		return 0;
>  
> +	pciercx_cfg032.u32 =
> +		cvmx_pcie_cfgx_read(pcie_port, CVMX_PCIERCX_CFG032(pcie_port));
> +	if ((pciercx_cfg032.s.dlla == 0) || (pciercx_cfg032.s.lt == 1))
> +		return 0;
> +
>  	pcie_addr.u64 = 0;
>  	pcie_addr.config.upper = 2;
>  	pcie_addr.config.io = 1;
> -- 
> 2.34.1

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]


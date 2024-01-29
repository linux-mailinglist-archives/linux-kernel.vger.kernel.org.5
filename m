Return-Path: <linux-kernel+bounces-42576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B040D840356
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 674B91F22781
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5DD5A7B3;
	Mon, 29 Jan 2024 10:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9NmIx0h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF3A5A791;
	Mon, 29 Jan 2024 10:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706525966; cv=none; b=sjW5MH4Nwt5ifhLLwUXdAeTnYe3fhKW4e0mQxH6THgzsd1/WhVPzjocmGk/OAssCFXEVEk8eq+fGvrocfE9P5TdQBcSYicx4GkV80rH+H1i3Vz1JYUDEpesfAu5khAtYjV5REDuTsodexn7QRGRb27e4MK63biIsq/N2kZG2t1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706525966; c=relaxed/simple;
	bh=2168ndFnkTOwy1W7Dx7tqWHb2Pb29S7aUYNrNolsgZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EgwkikpSRHZSJHGZ4wUI4s5xuUH3FqNSS9N7YaEjusILsvV1FwUcARQ2Wm4DTPPJrDtiDohSOPSeXNG+j5MsPZwPhEEPCa4QYU5cYZplHFi8RKDNJX7TqC94OG1CYvrGnFxPL56kaxm07RY/MUopQtTXuEKsO8mztponrYoPDHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9NmIx0h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A13C433C7;
	Mon, 29 Jan 2024 10:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706525965;
	bh=2168ndFnkTOwy1W7Dx7tqWHb2Pb29S7aUYNrNolsgZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B9NmIx0hCKcLFWUkZX6pTSPgdsLxvMqWu3TX4fznAwdFCzXRIJZZWDzVBPT/Q3st1
	 67HpuCje5vvNd8AfzKK+1o31PbuBjGFmMcZHz1vkhbB8anF9bLMJvO76vDxMQngFgE
	 3ujoKHgAnYdk0CUopuPkXXrfbNJAUwXDX/gwH6+6JK5bwUY1hv8utfQgwC0CCE5XhX
	 8juxdJKClDgcVpoUgyuRRbu8cDj02IPwqrjrgo+87tNlu5b6Gk43+WcZ17Yi7N4/YE
	 lpHseaMZR7VhtKj2zpBqOsgNARM9tHV9LgVWzCqDaFWQTYM0O57BYPhsSPTo3r+6fF
	 Jah3zb4SpzWtw==
Date: Mon, 29 Jan 2024 10:59:21 +0000
From: Simon Horman <horms@kernel.org>
To: Sai Krishna <saikrishnag@marvell.com>
Cc: richardcochran@gmail.com, davem@davemloft.net, kuba@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	sgoutham@marvell.com, gakula@marvell.com, lcherian@marvell.com,
	hkelam@marvell.com, sbhatta@marvell.com,
	Naveen Mamindlapalli <naveenm@marvell.com>
Subject: Re: [net-next PATCH] octeontx2: Add PTP clock driver for Octeon PTM
 clock.
Message-ID: <20240129105921.GJ401354@kernel.org>
References: <20240124064156.2577119-1-saikrishnag@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124064156.2577119-1-saikrishnag@marvell.com>

On Wed, Jan 24, 2024 at 12:11:56PM +0530, Sai Krishna wrote:
> The PCIe PTM(Precision time measurement) protocol provides precise
> coordination of events across multiple components like PCIe host
> clock, PCIe EP PHC local clocks of PCIe devices. This patch adds
> support for ptp clock based PTM clock. We can use this PTP device
> to sync the PTM time with CLOCK_REALTIME or other PTP PHC
> devices using phc2sys.
> 
> Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
> Signed-off-by: Naveen Mamindlapalli <naveenm@marvell.com>
> Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>

Hi Sai,

some minor review items from my side.

> diff --git a/drivers/ptp/ptp_octeon_ptm.c b/drivers/ptp/ptp_octeon_ptm.c

..

> +static u32 read_pcie_config32(int ep_pem, int cfg_addr)
> +{
> +	void __iomem *addr;
> +	u64 val;
> +
> +	if (oct_ptp_clock.cn10k_variant) {
> +		addr  = ioremap(PEMX_PFX_CSX_PFCFGX(ep_pem, 0, cfg_addr), 8);
> +		if (!addr) {
> +			pr_err("PTM_EP: Failed to ioremap Octeon CSR space\n");
> +			return -1U;
> +		}
> +		val = readl(addr);
> +		iounmap(addr);
> +	} else {
> +		addr  = ioremap(PEMX_CFG_RD(ep_pem), 8);
> +		if (!addr) {
> +			pr_err("PTM_EP: Failed to ioremap Octeon CSR space\n");
> +			return -1U;
> +		}
> +		val = ((1 << 15) | (cfg_addr & 0xfff));
> +		writeq(val, addr);

This causes a build failure on x86_32 because writeq() is undefined.

> +		val = readq(addr) >> 32;
> +		iounmap(addr);
> +	}
> +	return (val & 0xffffffff);
> +}
> +
> +static uint64_t octeon_csr_read(u64 csr_addr)
> +{
> +	u64 val;
> +	void __iomem *addr;

nit: In Networking code, please consider arranging local variables
     in reverse xmas tree order - longest line to shortest.

> +
> +	addr = ioremap(csr_addr, 8);
> +	if (!addr) {
> +		pr_err("PTM_EP: Failed to ioremap CSR space\n");
> +		return -1UL;
> +	}
> +	val = (u64)READ_ONCE(*(u64 __iomem *)addr);

Sparse seems unhappy about this cast.
So if this is really what you want to do then probably a
__force is needed in the cast.

But I do wonder if there is an endian consideration
that needs to be taken care of here. And, moreover,
if a standard routine, such as ioread64(), could be
used instead of this function.

N.B. as per the note on writeq, possibly this only works on 64bit systems.

Likewise elsewhere in this patch.

> +	iounmap(addr);
> +	return val;
> +}

..

> +static int __init ptp_oct_ptm_init(void)
> +{
> +	struct pci_dev *pdev = NULL;
> +
> +	pdev = pci_get_device(PCI_VENDOR_ID_CAVIUM,
> +			      PCI_DEVID_OCTEONTX2_PTP, pdev);
> +	if (!pdev)
> +		return 0;
> +
> +	if (octeon_csr_read(PEMX_CFG) & 0x1ULL) {
> +		pr_err("PEM0 is configured as RC\n");
> +		return 0;
> +	}
> +
> +	if (is_otx2_support_ptm(pdev)) {
> +		oct_ptp_clock.cn10k_variant = 0;
> +	} else if (is_cn10k_support_ptm(pdev)) {
> +		oct_ptp_clock.cn10k_variant = 1;
> +	} else {
> +		/* PTM_EP: unsupported processor */
> +		return 0;
> +	}
> +
> +	ptm_ctl_addr = ioremap(PEMX_PTM_CTL, 8);
> +	if (!ptm_ctl_addr) {
> +		pr_err("PTM_EP: Failed to ioremap CSR space\n");
> +		return 0;
> +	}
> +
> +	ptm_lcl_addr = ioremap(PEMX_PTM_LCL_TIME, 8);
> +	if (!ptm_lcl_addr) {
> +		pr_err("PTM_EP: Failed to ioremap CSR space\n");
> +		return 0;
> +	}
> +
> +	oct_ptp_clock.caps = ptp_oct_caps;
> +
> +	oct_ptp_clock.ptp_clock = ptp_clock_register(&oct_ptp_clock.caps, NULL);
> +
> +	pr_info("PTP device index for PTM clock:%d\n", oct_ptp_clock.ptp_clock->index);

It seems that the pr_info() call above assumes that oct_ptp_clock.ptp_clock
is not an error, but it may be.

Perhaps something like this is more appropriate:

	oct_ptp_clock.ptp_clock = ...
	if (IS_ERR(oct_ptp_clock.ptp_clock))
		ERR_PTR(oct_ptp_clock.ptp_clock);

	pr_info(...)
	...

	return 0;

Flagged by Smatch.

> +	pr_info("cn10k_variant %d\n", oct_ptp_clock.cn10k_variant);
> +
> +	return PTR_ERR_OR_ZERO(oct_ptp_clock.ptp_clock);
> +}
> +
> +module_init(ptp_oct_ptm_init);
> +module_exit(ptp_oct_ptm_exit);
> +
> +MODULE_AUTHOR("Marvell Inc.");
> +MODULE_DESCRIPTION("PTP PHC clock using PTM");
> +MODULE_LICENSE("GPL");
> -- 
> 2.25.1


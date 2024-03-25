Return-Path: <linux-kernel+bounces-118025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2582188B285
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF91D1F24C38
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802516CDBD;
	Mon, 25 Mar 2024 21:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCUvS7dy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88BF2F2D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 21:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711401557; cv=none; b=g3jxpGpCWOv4y3nNdEGK7qk2l1zViL7CVyjItsqU21NFbI4axR/584K1MHo3eJVAp1r6RtOAya1Ga2J86qt4aqZKTROVXlYAnqLkVvY6YElzwCIqVxaD3awPd6DVO2FtcNP2aEOXmMrbQRVoBHJYf9XB3q80atTdZed5+aTS7LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711401557; c=relaxed/simple;
	bh=OWs//vTe4wS6p+a5aX6Eb0sMmS8LssMRYRNf/R2WufQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=C5qQNfHk6KcKp4eBu0Q8HsI2pDPNmZE9MAPII5amYKcJsJbeY68sDUdw4YpkJbcr09rJgbkRFmje8pTE1vIkqYyHL3hOO21tKOCslddkdelg1qe1OhVDA7D47+T4vuXu0DXefRlEP/MrlKyNJR7o6KW9TcOG6jfuFtDkbQN9B2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCUvS7dy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227D5C433F1;
	Mon, 25 Mar 2024 21:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711401557;
	bh=OWs//vTe4wS6p+a5aX6Eb0sMmS8LssMRYRNf/R2WufQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=PCUvS7dyW/2AeNdrdsyijtGhpyFpUA7YtLIeWO8dp2TYi0i3meAJ51w77eQJKlrHc
	 b2X8yNfOm3vt+/ANP49wEdMjxcQivsIM+mDdkv2NihWh6f+ndSVR1Tzyx6VZNRrFAJ
	 aOBD34qaFwbyjlaYe4mxSTiS+Sj6cE8XOfeOxDDW/37VoNEc6geI0MaW/hTp2Cm3ov
	 Efw2APjuODvMEoAIJRbxApM11vxQBeFptLgRJTSpETgl8wol6GlR/JlcQ5BExDgYtT
	 2tJA9/RVoOHbUZ0q+huo4Vg6K+O+4p8xSAaxNyOpGA5HmRjcy6kKtbCyLCwVhwvufQ
	 /niBZGccCeDqA==
Date: Mon, 25 Mar 2024 16:19:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mfd: intel-lpss: Switch over to MSI interrupts
Message-ID: <20240325211915.GA1449994@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312165905.1764507-1-andriy.shevchenko@linux.intel.com>

[+bcc Mateusz]

On Tue, Mar 12, 2024 at 06:59:05PM +0200, Andy Shevchenko wrote:
> Some devices support MSI interrupts. Let's at least try to use them in
> platforms that provide MSI capability.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel-lpss-pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
> index 8c00e0c695c5..c36a101df7be 100644
> --- a/drivers/mfd/intel-lpss-pci.c
> +++ b/drivers/mfd/intel-lpss-pci.c
> @@ -54,7 +54,7 @@ static int intel_lpss_pci_probe(struct pci_dev *pdev,
>  	if (ret)
>  		return ret;
>  
> -	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_LEGACY);
> +	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
>  	if (ret < 0)
>  		return ret;

I guess at least some of these devices do support INTx, since we
always used INTx previously, right?

There are a bunch of bug reports complaining about a lack of _PRT
entries for them, e.g., these from
https://bugzilla.kernel.org/show_bug.cgi?id=212261#c24:

  intel-lpss 0000:00:15.0: enabling device (0004 -> 0006)
  intel-lpss 0000:00:15.0: can't derive routing for PCI INT A
  intel-lpss 0000:00:15.0: PCI INT A: not connected
  intel-lpss: probe of 0000:00:15.0 failed with error -22
  intel-lpss 0000:00:15.2: enabling device (0004 -> 0006)
  intel-lpss 0000:00:15.2: can't derive routing for PCI INT C
  intel-lpss 0000:00:15.2: PCI INT C: not connected
  intel-lpss: probe of 0000:00:15.2 failed with error -22
  intel-lpss 0000:00:19.0: enabling device (0004 -> 0006)
  intel-lpss 0000:00:19.0: can't derive routing for PCI INT A
  intel-lpss 0000:00:19.0: PCI INT A: not connected
  intel-lpss: probe of 0000:00:19.0 failed with error -22
  intel-lpss 0000:00:19.1: enabling device (0004 -> 0006)
  intel-lpss 0000:00:19.1: can't derive routing for PCI INT B
  intel-lpss 0000:00:19.1: PCI INT B: not connected
  intel-lpss: probe of 0000:00:19.1 failed with error -22
  intel-lpss 0000:00:1e.0: enabling device (0004 -> 0006)
  intel-lpss 0000:00:1e.0: can't derive routing for PCI INT A
  intel-lpss 0000:00:1e.0: PCI INT A: not connected
  intel-lpss: probe of 0000:00:1e.0 failed with error -22
  intel-lpss 0000:00:1e.3: enabling device (0004 -> 0006)
  intel-lpss 0000:00:1e.3: can't derive routing for PCI INT D
  intel-lpss 0000:00:1e.3: PCI INT D: not connected
  intel-lpss: probe of 0000:00:1e.3 failed with error -22

I don't know if these are a _PRT bug (I think if a device advertises a
non-zero Interrupt Pin, the _PRT should tell us how it is routed), or
possibly a device bug (advertises Interrupt Pin == INTA when it should
advertise "no INTx used"), or something else.

Bjorn


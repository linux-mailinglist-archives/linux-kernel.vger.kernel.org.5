Return-Path: <linux-kernel+bounces-153750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 350718AD2B3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C73181F21B9C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA07153831;
	Mon, 22 Apr 2024 16:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppG1k03i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC6415358B;
	Mon, 22 Apr 2024 16:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713804565; cv=none; b=Xz3bx3IV33JvEfUpdPzB27U2i++CHXQ6c20erigRtVUBEfwAHgG3sxEjALVrSY+HEqC8SRmUyZTxiVSfryNjCSLdZLmYm23hWDS+xsfHGGpgAXP2Yp7DmA8hJHBtEXb5khvDSSp5JXi/FOtPBBZtpGIDb7Cd82PEH9dn1sEwAHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713804565; c=relaxed/simple;
	bh=bE7FnNf0IfF6MoCHb9dCmSncIpBLHSLJiBoyZV9ggi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbg/amPVkLU+Azq2gbOY9wsQ4FXDkfbxqf4/jFCYBZ1L7oYK3jstq9N7HQ1bWX9M9aj1cqZYoKmJA8N86iNVJg0n5BpoDe8vXHW0kiCbfLcbxRJgSGJgQkmL9ifiqHr4LY8FhEQpihOMlSFxRGZT+DcRVhtS45S7Ofm96p2fuoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ppG1k03i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D288C113CC;
	Mon, 22 Apr 2024 16:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713804564;
	bh=bE7FnNf0IfF6MoCHb9dCmSncIpBLHSLJiBoyZV9ggi4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ppG1k03i2NISyJrq0pt0EK2X7yPyJCIHkbhBuDL6UEkj8sTffH7g7HZDyMtHthVaP
	 vkHXwN2hNBJNBRe+K6mUxEL1kz7Nt2SbwVx1EoZfWaejolEsw+Adq2S9oee35kriz2
	 dsU+aET/4u3jOI0ZzXzdoJDRD+9GBBSKWV5LcCaKZVyXEHx7tCUe17JXTZftW/UP2v
	 HN9lWXtsexyH2jUQftjtPF/rSkvJh7X3Qujva6UQvsW793Rya+NN7FSLReZ+xvnhly
	 D8buqfFb1Ic7QI32HJeU0kW2EYLm2Sat4TWA0m3ZNozke/Th3C/W4ofG6WqWD0vN/7
	 gbSu/9F6cKdpw==
Date: Mon, 22 Apr 2024 10:49:21 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Add quirk for broken MSIs
Message-ID: <ZiaVEfdUXO97eWzV@kbusch-mbp.dhcp.thefacebook.com>
References: <20240422162822.3539156-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422162822.3539156-1-sean.anderson@linux.dev>

On Mon, Apr 22, 2024 at 12:28:23PM -0400, Sean Anderson wrote:
> Sandisk SN530 NVMe drives have broken MSIs. On systems without MSI-X
> support, all commands time out resulting in the following message:
> 
> nvme nvme0: I/O tag 12 (100c) QID 0 timeout, completion polled
> 
> These timeouts cause the boot to take an excessively-long time (over 20
> minutes) while the initial command queue is flushed.
> 
> Address this by adding a quirk for drives with buggy MSIs. The lspci
> output for this device (recorded on a system with MSI-X support) is:

Based on your description, the patch looks good. This will fallback to
legacy emulated pin interrupts, and that's better than timeout polling,
but will still appear sluggish compared to MSI's. Is there an errata
from the vendor on this? I'm just curious if the bug is at the Device ID
level, and not something we could constrain to a particular model or
firmware revision. 
 
> 02:00.0 Non-Volatile memory controller: Sandisk Corp Device 5008 (rev 01) (prog-if 02 [NVM Express])
> 	Subsystem: Sandisk Corp Device 5008
> 	Flags: bus master, fast devsel, latency 0, IRQ 16, NUMA node 0
> 	Memory at f7e00000 (64-bit, non-prefetchable) [size=16K]
> 	Memory at f7e04000 (64-bit, non-prefetchable) [size=256]
> 	Capabilities: [80] Power Management version 3
> 	Capabilities: [90] MSI: Enable- Count=1/32 Maskable- 64bit+
> 	Capabilities: [b0] MSI-X: Enable+ Count=17 Masked-

Interesting, the MSI capability does look weird here. I've never seen
MSI-x count smaller than the MSI's. As long as both work, though, I
think nvme would actually prefer whichever is bigger!


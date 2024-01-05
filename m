Return-Path: <linux-kernel+bounces-18295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE524825B0F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 20:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52F05285A56
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 19:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1A035F11;
	Fri,  5 Jan 2024 19:21:50 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D626A35291
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 19:21:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A6F9C433C7;
	Fri,  5 Jan 2024 19:21:47 +0000 (UTC)
Date: Fri, 5 Jan 2024 19:21:45 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Elad Nachman <enachman@marvell.com>
Cc: will@kernel.org, thunder.leizhen@huawei.com, bhe@redhat.com,
	akpm@linux-foundation.org, yajun.deng@linux.dev,
	chris.zjh@huawei.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: mm: Fix SOCs with DDR starting above zero
Message-ID: <ZZhWya4EK45lLbds@arm.com>
References: <20240103170002.1793197-1-enachman@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103170002.1793197-1-enachman@marvell.com>

On Wed, Jan 03, 2024 at 07:00:02PM +0200, Elad Nachman wrote:
> From: Elad Nachman <enachman@marvell.com>
> 
> Some SOCs, like the Marvell AC5/X/IM, have a combination
> of DDR starting at 0x2_0000_0000 coupled with DMA controllers
> limited to 31 and 32 bit of addressing.
> This requires to properly arrange ZONE_DMA and ZONE_DMA32 for
> these SOCs, so swiotlb and coherent DMA allocation would work
> properly.
> Change initialization so device tree dma zone bits are taken as
> function of offset from DRAM start, and when calculating the
> maximal zone physical RAM address for physical DDR starting above
> 32-bit, combine the physical address start plus the zone mask
> passed as parameter.
> This creates the proper zone splitting for these SOCs:
> 0..2GB for ZONE_DMA
> 2GB..4GB for ZONE_DMA32
> 4GB..8GB for ZONE_NORMAL

Please see this discussion:

https://lore.kernel.org/all/ZU0QEL9ByWNYVki1@arm.com/

and follow-up patches from Baruch, though I haven't reviewed them yet:

https://lore.kernel.org/all/fae5b1180161a7d8cd626a96f5df80b0a0796b8b.1703683642.git.baruch@tkos.co.il/

The problem is that the core code pretty much assumes that DRAM starts
from 0. No matter how you massage the zones in the arm64 kernel for your
case, memblock_start_of_DRAM() + (2 << zone_dma_bits) won't be a power
of two and therefore zone_dma_bits in the core code cannot describe what
you need.

I can see Baruch added a zone_dma_off assuming it's the same for all
DMA-capable devices on that SoC (well, those with a coherent mask
smaller than 64-bit). I need to think a bit more about this.

Anyway, we first need to address the mask/bits comparisons in the core
code, maybe changing bits to a physical limit instead and take the
device DMA offset into account. After that we can look at how to
correctly set up the DMA zones on arm64.

-- 
Catalin


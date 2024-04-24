Return-Path: <linux-kernel+bounces-156723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8F98B074C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFD8B282E6F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A3A15957D;
	Wed, 24 Apr 2024 10:26:38 +0000 (UTC)
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B934F15956F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 10:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713954398; cv=none; b=hr/xQggj0Ojz783yC1yUo6RiQeqcKWBkGqsCAB8N68XpqGarUW2NeLalbge2RZiWbf8XqMB6Bqtk77U1p5NhCNibBQByrrcP/VjQY+DJ8M2LYABk2u2GGoGC0bz4hgztF7m2AELdODYGb29X01jJU6wy3y0ejY3m8BbIBRaf65Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713954398; c=relaxed/simple;
	bh=dG+revxQzK/A7VOH2CsUT2VQD1d/Iq8wWNut+VMBstc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ifq5rXuOpd6Y47EP3r177fRbAS3RyO18v6YxK5G068LVjLvNA8a/lV/Idtvzv5hsO6qseOMQVMsIeIiCp7+rxx26u6n1jfrkGkmqDRaNGUR/+0lSo0svGUwv7V9YCNhL5VP2/l33YsZM4By79R8v9FVELiF7MUEeo8iXjJCbE/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:76d0:2bff:fec8:549])
	by albert.telenet-ops.be with bizsmtp
	id EyST2C0070SSLxL06ySTPi; Wed, 24 Apr 2024 12:26:28 +0200
Received: from geert (helo=localhost)
	by ramsan.of.borg with local-esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rzZpa-0066TE-WE;
	Wed, 24 Apr 2024 12:26:27 +0200
Date: Wed, 24 Apr 2024 12:26:26 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ming Lei <ming.lei@redhat.com>
cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
    janpieter.sollie@edpnet.be, Christoph Hellwig <hch@lst.de>, 
    Mike Snitzer <snitzer@kernel.org>, dm-devel@lists.linux.dev, 
    Song Liu <song@kernel.org>, linux-raid@vger.kernel.org, 
    linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: allow device to have both virt_boundary_mask and
 max segment size
In-Reply-To: <20240407131931.4055231-1-ming.lei@redhat.com>
Message-ID: <7e38b67c-9372-a42d-41eb-abdce33d3372@linux-m68k.org>
References: <20240407131931.4055231-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

 	Hi Ming,

On Sun, 7 Apr 2024, Ming Lei wrote:
> When one stacking device is over one device with virt_boundary_mask and
> another one with max segment size, the stacking device have both limits
> set. This way is allowed before d690cb8ae14b ("block: add an API to
> atomically update queue limits").
>
> Relax the limit so that we won't break such kind of stacking setting.
>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218687
> Reported-by: janpieter.sollie@edpnet.be
> Fixes: d690cb8ae14b ("block: add an API to atomically update queue limits")
> Link: https://lore.kernel.org/linux-block/ZfGl8HzUpiOxCLm3@fedora/
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Mike Snitzer <snitzer@kernel.org>
> Cc: dm-devel@lists.linux.dev
> Cc: Song Liu <song@kernel.org>
> Cc: linux-raid@vger.kernel.org
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Thanks for your patch, which is now commit b561ea56a26415bf ("block:
allow device to have both virt_boundary_mask and max segment size") in
v6.9-rc4.

With CONFIG_DMA_API_DEBUG_SG=y and IOMMU support enabled, this causes a
warning on R-Car Gen3/Gen4 platforms:

     DMA-API: renesas_sdhi_internal_dmac ee160000.mmc: mapping sg segment longer than device claims to support [len=86016] [max=65536]
     WARNING: CPU: 1 PID: 281 at kernel/dma/debug.c:1178 debug_dma_map_sg+0x2ac/0x330
     Modules linked in:
     CPU: 1 PID: 281 Comm: systemd-udevd Tainted: G        W          6.9.0-rc2-ebisu-00012-gb561ea56a264 #596
     Hardware name: Renesas Ebisu board based on r8a77990 (DT)
     pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
     pc : debug_dma_map_sg+0x2ac/0x330
     lr : debug_dma_map_sg+0x2ac/0x330
     sp : ffffffc083643470
     x29: ffffffc083643470 x28: 0000000000000080 x27: 0000000000010000
     x26: 0000000000000000 x25: 0000000000000001 x24: ffffffc0810afc30
     x23: ffffffffffffffff x22: ffffffc080c8366f x21: ffffff8008849f80
     x20: ffffff800cd24000 x19: ffffff80099a2810 x18: 0000000000000000
     x17: ffffff800801a000 x16: ffffffc080453f00 x15: ffffffc0836430f0
     x14: ffffffc08099fb50 x13: 0000000000000007 x12: 0000000000000000
     x11: 0000000000000202 x10: ffffffc0810d99d0 x9 : ffffffc081189bb0
     x8 : ffffffc083643178 x7 : ffffffc083643180 x6 : 00000000ffffdfff
     x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
     x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffffff800ebad280
     Call trace:
      debug_dma_map_sg+0x2ac/0x330
      __dma_map_sg_attrs+0xcc/0xd0
      dma_map_sg_attrs+0xc/0x1c
      renesas_sdhi_internal_dmac_map+0x64/0x94
      renesas_sdhi_internal_dmac_pre_req+0x20/0x2c
      mmc_blk_mq_issue_rq+0x62c/0x6c8
      mmc_mq_queue_rq+0x194/0x218
      blk_mq_dispatch_rq_list+0x36c/0x4d4
      __blk_mq_sched_dispatch_requests+0x344/0x4e0
      blk_mq_sched_dispatch_requests+0x28/0x5c
      blk_mq_run_hw_queue+0x1a4/0x218
      blk_mq_flush_plug_list+0x2fc/0x4a0
      __blk_flush_plug+0x70/0x134
      blk_finish_plug+0x24/0x34
      read_pages+0x60/0x158
      page_cache_ra_unbounded+0x98/0x184
      do_page_cache_ra+0x44/0x50
      force_page_cache_ra+0x98/0x9c
      page_cache_sync_ra+0x30/0x54
      filemap_get_pages+0xfc/0x4f8
      filemap_read+0xe8/0x2b8
      blkdev_read_iter+0x12c/0x144
      vfs_read+0x104/0x150
      ksys_read+0x6c/0xd4
      __arm64_sys_read+0x14/0x1c
      invoke_syscall+0x70/0xf4
      el0_svc_common.constprop.0+0xb0/0xcc
      do_el0_svc+0x1c/0x24
      el0_svc+0x34/0x8c
      el0t_64_sync_handler+0x88/0x124
      el0t_64_sync+0x150/0x154
     irq event stamp: 0
     hardirqs last  enabled at (0): [<0000000000000000>] 0x0
     hardirqs last disabled at (0): [<ffffffc08007efa4>] copy_process+0x6ac/0x18d4
     softirqs last  enabled at (0): [<ffffffc08007efa4>] copy_process+0x6ac/0x18d4
     softirqs last disabled at (0): [<0000000000000000>] 0x0

Reverting this commit, or disabling IOMMU support fixes the issue.

> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -182,17 +182,13 @@ static int blk_validate_limits(struct queue_limits *lim)
> 		return -EINVAL;
>
> 	/*
> -	 * Devices that require a virtual boundary do not support scatter/gather
> -	 * I/O natively, but instead require a descriptor list entry for each
> -	 * page (which might not be identical to the Linux PAGE_SIZE).  Because
> -	 * of that they are not limited by our notion of "segment size".
> +	 * Stacking device may have both virtual boundary and max segment
> +	 * size limit, so allow this setting now, and long-term the two
> +	 * might need to move out of stacking limits since we have immutable
> +	 * bvec and lower layer bio splitting is supposed to handle the two
> +	 * correctly.
> 	 */
> -	if (lim->virt_boundary_mask) {
> -		if (WARN_ON_ONCE(lim->max_segment_size &&
> -				 lim->max_segment_size != UINT_MAX))
> -			return -EINVAL;
> -		lim->max_segment_size = UINT_MAX;
> -	} else {
> +	if (!lim->virt_boundary_mask) {
> 		/*
> 		 * The maximum segment size has an odd historic 64k default that
> 		 * drivers probably should override.  Just like the I/O size we

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds


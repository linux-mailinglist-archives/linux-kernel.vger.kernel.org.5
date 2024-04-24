Return-Path: <linux-kernel+bounces-156883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 564BE8B09DB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9A1E1F22ED3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238C9142E70;
	Wed, 24 Apr 2024 12:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U4MbaAHb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D4F1422AF
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 12:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713962495; cv=none; b=quCgeLd9WE34qXPYJrz0TZMmpRg/b/cG/+386IOUjvkfm0+4474u1kwrNYN0nNSQD0BYMpS4mzP/BIIcfGtrHQ2COc87E9AIJ27TUGiO4Ju+LdiHccAhTgeZv0kW/ZbaKn3NL/MKKk6SOADz1dr9NPmA/AjxZ/TZudde4FSiQ2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713962495; c=relaxed/simple;
	bh=vW3HKCzfem5PRz621B6w/DeHZlglovfQUent/6SXw98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nUDDS5/eG45MLEM+aECRKbvAPOsp7gvRw4d0vQw6SjeuEJrB99HDpdN+jdqpP/0si+/RsCy0F3xSVy0L7zCEgx/Gk6jQAM8kUfSIYWOZ0LsnMJwHx+LMbPskcp7y512d1LcWbnjvFMAN/bM6skVdBlV9KC+4Wlsgra1dHJ5o5kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U4MbaAHb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713962492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1YHjVG+EVGdfDIS20vnS7z4XvX8/hFzl/H31PAuwms4=;
	b=U4MbaAHbNWAauZcp733Dnz6fy+BVv65moQWAA6DlVa34dWV8X1bBW/FulLKveTEmTWfJaA
	TsG5h4vFkZYIAae6KXtW2nKz6jn3c6VLk2KSvYDrwahTxA2PNSq1iXiOtmo7FB7cNsreMg
	Ov+vA9B3mHtV92q99ox7XZ5rpxW9TvE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-pzRwAQ9bORGDKV9q23gL7Q-1; Wed, 24 Apr 2024 08:41:28 -0400
X-MC-Unique: pzRwAQ9bORGDKV9q23gL7Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3C322810BDC;
	Wed, 24 Apr 2024 12:41:28 +0000 (UTC)
Received: from fedora (unknown [10.72.116.70])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 397A9EC685;
	Wed, 24 Apr 2024 12:41:21 +0000 (UTC)
Date: Wed, 24 Apr 2024 20:41:18 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	janpieter.sollie@edpnet.be, Christoph Hellwig <hch@lst.de>,
	Mike Snitzer <snitzer@kernel.org>, dm-devel@lists.linux.dev,
	Song Liu <song@kernel.org>, linux-raid@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: allow device to have both virt_boundary_mask and
 max segment size
Message-ID: <Zij97qGQY1MRrEb8@fedora>
References: <20240407131931.4055231-1-ming.lei@redhat.com>
 <7e38b67c-9372-a42d-41eb-abdce33d3372@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e38b67c-9372-a42d-41eb-abdce33d3372@linux-m68k.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On Wed, Apr 24, 2024 at 12:26:26PM +0200, Geert Uytterhoeven wrote:
> 	Hi Ming,
> 
> On Sun, 7 Apr 2024, Ming Lei wrote:
> > When one stacking device is over one device with virt_boundary_mask and
> > another one with max segment size, the stacking device have both limits
> > set. This way is allowed before d690cb8ae14b ("block: add an API to
> > atomically update queue limits").
> > 
> > Relax the limit so that we won't break such kind of stacking setting.
> > 
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218687
> > Reported-by: janpieter.sollie@edpnet.be
> > Fixes: d690cb8ae14b ("block: add an API to atomically update queue limits")
> > Link: https://lore.kernel.org/linux-block/ZfGl8HzUpiOxCLm3@fedora/
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Mike Snitzer <snitzer@kernel.org>
> > Cc: dm-devel@lists.linux.dev
> > Cc: Song Liu <song@kernel.org>
> > Cc: linux-raid@vger.kernel.org
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> 
> Thanks for your patch, which is now commit b561ea56a26415bf ("block:
> allow device to have both virt_boundary_mask and max segment size") in
> v6.9-rc4.
> 
> With CONFIG_DMA_API_DEBUG_SG=y and IOMMU support enabled, this causes a
> warning on R-Car Gen3/Gen4 platforms:
> 
>     DMA-API: renesas_sdhi_internal_dmac ee160000.mmc: mapping sg segment longer than device claims to support [len=86016] [max=65536]
>     WARNING: CPU: 1 PID: 281 at kernel/dma/debug.c:1178 debug_dma_map_sg+0x2ac/0x330
>     Modules linked in:
>     CPU: 1 PID: 281 Comm: systemd-udevd Tainted: G        W          6.9.0-rc2-ebisu-00012-gb561ea56a264 #596
>     Hardware name: Renesas Ebisu board based on r8a77990 (DT)
>     pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>     pc : debug_dma_map_sg+0x2ac/0x330
>     lr : debug_dma_map_sg+0x2ac/0x330
>     sp : ffffffc083643470
>     x29: ffffffc083643470 x28: 0000000000000080 x27: 0000000000010000
>     x26: 0000000000000000 x25: 0000000000000001 x24: ffffffc0810afc30
>     x23: ffffffffffffffff x22: ffffffc080c8366f x21: ffffff8008849f80
>     x20: ffffff800cd24000 x19: ffffff80099a2810 x18: 0000000000000000
>     x17: ffffff800801a000 x16: ffffffc080453f00 x15: ffffffc0836430f0
>     x14: ffffffc08099fb50 x13: 0000000000000007 x12: 0000000000000000
>     x11: 0000000000000202 x10: ffffffc0810d99d0 x9 : ffffffc081189bb0
>     x8 : ffffffc083643178 x7 : ffffffc083643180 x6 : 00000000ffffdfff
>     x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
>     x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffffff800ebad280
>     Call trace:
>      debug_dma_map_sg+0x2ac/0x330
>      __dma_map_sg_attrs+0xcc/0xd0
>      dma_map_sg_attrs+0xc/0x1c
>      renesas_sdhi_internal_dmac_map+0x64/0x94
>      renesas_sdhi_internal_dmac_pre_req+0x20/0x2c
>      mmc_blk_mq_issue_rq+0x62c/0x6c8
>      mmc_mq_queue_rq+0x194/0x218
>      blk_mq_dispatch_rq_list+0x36c/0x4d4
>      __blk_mq_sched_dispatch_requests+0x344/0x4e0
>      blk_mq_sched_dispatch_requests+0x28/0x5c
>      blk_mq_run_hw_queue+0x1a4/0x218
>      blk_mq_flush_plug_list+0x2fc/0x4a0
>      __blk_flush_plug+0x70/0x134
>      blk_finish_plug+0x24/0x34
>      read_pages+0x60/0x158
>      page_cache_ra_unbounded+0x98/0x184
>      do_page_cache_ra+0x44/0x50
>      force_page_cache_ra+0x98/0x9c
>      page_cache_sync_ra+0x30/0x54
>      filemap_get_pages+0xfc/0x4f8
>      filemap_read+0xe8/0x2b8
>      blkdev_read_iter+0x12c/0x144
>      vfs_read+0x104/0x150
>      ksys_read+0x6c/0xd4
>      __arm64_sys_read+0x14/0x1c
>      invoke_syscall+0x70/0xf4
>      el0_svc_common.constprop.0+0xb0/0xcc
>      do_el0_svc+0x1c/0x24
>      el0_svc+0x34/0x8c
>      el0t_64_sync_handler+0x88/0x124
>      el0t_64_sync+0x150/0x154
>     irq event stamp: 0
>     hardirqs last  enabled at (0): [<0000000000000000>] 0x0
>     hardirqs last disabled at (0): [<ffffffc08007efa4>] copy_process+0x6ac/0x18d4
>     softirqs last  enabled at (0): [<ffffffc08007efa4>] copy_process+0x6ac/0x18d4
>     softirqs last disabled at (0): [<0000000000000000>] 0x0
> 
> Reverting this commit, or disabling IOMMU support fixes the issue.

Hello Geert,

Can you test the following patch?


diff --git a/block/blk-settings.c b/block/blk-settings.c
index 8e1d7ed52fef..ebba05a2bc7f 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -188,7 +188,10 @@ static int blk_validate_limits(struct queue_limits *lim)
 	 * bvec and lower layer bio splitting is supposed to handle the two
 	 * correctly.
 	 */
-	if (!lim->virt_boundary_mask) {
+	if (lim->virt_boundary_mask) {
+		if (!lim->max_segment_size)
+			lim->max_segment_size = UINT_MAX;
+	} else {
 		/*
 		 * The maximum segment size has an odd historic 64k default that
 		 * drivers probably should override.  Just like the I/O size we

thanks
Ming



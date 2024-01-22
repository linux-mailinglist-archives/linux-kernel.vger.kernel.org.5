Return-Path: <linux-kernel+bounces-34289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5078377A1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 00:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C912428A3A7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 23:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD354C3C8;
	Mon, 22 Jan 2024 23:17:33 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C834C3A6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 23:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705965453; cv=none; b=RTT3izSq8avM26rLFaNeF3tyXqqZvJnvVfqipgJ/kl7TyEXFUzsaYXK+T0EJ5K8PpL1rFyhh7VAKvykAWrrCvub2O7D+eearyGcswB6mmI1sngLGM3Hc7yQumrI8F3vyZdmFhWdn4BrS9za/fHGLL5SPXpJWytZyB9SbGrSOVTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705965453; c=relaxed/simple;
	bh=De1JCInzc77IC7IuGuzOyL8MaDikf7sYnOhtt0ucdbg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U8GlQ5s+dtKWahoJClmQvOJ98zbsZNGfR/WUdYO0ebzSGVWKwEsYYySOdh3owjx8CCattQQ3jUdzOqp7HVWiEVnBRdH9nzk0a/oFA5VpCpWOrVADGGMva4r90yEVdpoMQ9yniYlxn5dClBCRjDmEbecXvfALcQc5gYiYAweNgXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF60C43390;
	Mon, 22 Jan 2024 23:17:32 +0000 (UTC)
Date: Mon, 22 Jan 2024 18:19:01 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Rajneesh Bhardwaj
 <rajneesh.bhardwaj@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org
Subject: Re: [BUG]  BUG: kernel NULL pointer dereference at
 ttm_device_init+0xb4
Message-ID: <20240122181901.05a3b9ab@gandalf.local.home>
In-Reply-To: <20240122181547.16b029d6@gandalf.local.home>
References: <20240122180605.28daf23a@gandalf.local.home>
	<20240122181547.16b029d6@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jan 2024 18:15:47 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> > 	ttm_pool_init(&bdev->pool, dev, dev_to_node(dev), use_dma_alloc, use_dma32); <<<------- BUG!
> > 
> > Specifically, it appears that dev is NULL and dev_to_node() doesn't like
> > having a NULL pointer passed to it.
> >   
> 
> Yeah, that qxl_ttm_init() has:
> 
> 	/* No others user of address space so set it to 0 */
> 	r = ttm_device_init(&qdev->mman.bdev, &qxl_bo_driver, NULL,
> 			    qdev->ddev.anon_inode->i_mapping,
> 			    qdev->ddev.vma_offset_manager,
> 			    false, false);
> 
> Where that NULL is "dev"!
> 
> Thus that will never work here.

Perhaps this is the real fix?

-- Steve

diff --git a/drivers/gpu/drm/ttm/ttm_device.c b/drivers/gpu/drm/ttm/ttm_device.c
index f5187b384ae9..bc217b4d6b04 100644
--- a/drivers/gpu/drm/ttm/ttm_device.c
+++ b/drivers/gpu/drm/ttm/ttm_device.c
@@ -215,7 +215,8 @@ int ttm_device_init(struct ttm_device *bdev, const struct ttm_device_funcs *func
 
 	ttm_sys_man_init(bdev);
 
-	ttm_pool_init(&bdev->pool, dev, dev_to_node(dev), use_dma_alloc, use_dma32);
+	ttm_pool_init(&bdev->pool, dev, dev ? dev_to_node(dev) : NUMA_NO_NODE,
+		      use_dma_alloc, use_dma32);
 
 	bdev->vma_manager = vma_manager;
 	spin_lock_init(&bdev->lru_lock);


Return-Path: <linux-kernel+bounces-34285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDA9837793
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 00:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6FDF1F24F31
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 23:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5ABD4BA85;
	Mon, 22 Jan 2024 23:14:19 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7974B5BB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 23:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705965259; cv=none; b=lOI1DLmtmv3uYvbu6AHT2JTgkLS80y3F5iAedZhbDm8CWo6oV99n/WZU6bTT7cYbdipFAGYq/GnE2itmzuJzpg3MQxEnfekxTcnJ0kAHPM53uTsiv+6gI4poDrlg/yCBtbAIBJuwu0xotUQBSE+JzOnd/zLKjkK7O0ep4c1v+S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705965259; c=relaxed/simple;
	bh=Gt7IpBQtgYGlll651FSrMEEkXLxU29P+q3mE7TRqaMo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pDvsYdAC8YlnmFHkFhMDzlgJYAhA70wqxPCyzcxftN2hEEkNvkRRmJL4KspAXQPd7kOFl2gogCx50GhEi4AYaUGrWTcJHORR6f90pifWKcQRa3dANDKGjHyBBRumt4zVywrWNx8Z0o0JvY9YyZXymoNaozX8r8tc3D4kOLzImPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17219C43394;
	Mon, 22 Jan 2024 23:14:17 +0000 (UTC)
Date: Mon, 22 Jan 2024 18:15:47 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Rajneesh Bhardwaj
 <rajneesh.bhardwaj@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org
Subject: Re: [BUG]  BUG: kernel NULL pointer dereference at
 ttm_device_init+0xb4
Message-ID: <20240122181547.16b029d6@gandalf.local.home>
In-Reply-To: <20240122180605.28daf23a@gandalf.local.home>
References: <20240122180605.28daf23a@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jan 2024 18:06:05 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:


>   qxl_ttm_init+0x34/0x130


> 
> int ttm_device_init(struct ttm_device *bdev, const struct ttm_device_funcs *funcs,
> 		    struct device *dev, struct address_space *mapping,
> 		    struct drm_vma_offset_manager *vma_manager,
> 		    bool use_dma_alloc, bool use_dma32)
> {
> 	struct ttm_global *glob = &ttm_glob;
> 	int ret;
> 
> 	if (WARN_ON(vma_manager == NULL))
> 		return -EINVAL;
> 
> 	ret = ttm_global_init();
> 	if (ret)
> 		return ret;
> 
> 	bdev->wq = alloc_workqueue("ttm",
> 				   WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_UNBOUND, 16);
> 	if (!bdev->wq) {
> 		ttm_global_release();
> 		return -ENOMEM;
> 	}
> 
> 	bdev->funcs = funcs;
> 
> 	ttm_sys_man_init(bdev);
> 
> 	ttm_pool_init(&bdev->pool, dev, dev_to_node(dev), use_dma_alloc, use_dma32); <<<------- BUG!
> 
> Specifically, it appears that dev is NULL and dev_to_node() doesn't like
> having a NULL pointer passed to it.
> 

Yeah, that qxl_ttm_init() has:

	/* No others user of address space so set it to 0 */
	r = ttm_device_init(&qdev->mman.bdev, &qxl_bo_driver, NULL,
			    qdev->ddev.anon_inode->i_mapping,
			    qdev->ddev.vma_offset_manager,
			    false, false);

Where that NULL is "dev"!

Thus that will never work here.

-- Steve



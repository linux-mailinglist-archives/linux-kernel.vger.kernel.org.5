Return-Path: <linux-kernel+bounces-34500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A56837D87
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C674C1C2488B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F23D5C90D;
	Tue, 23 Jan 2024 00:33:25 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD004E1D8
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970005; cv=none; b=cTvLzDS47Ymk1d0unNw4Exv8OuJMSJCha3aS/rbkpFWjgvBMmZ/9dzOPii6whc9zajZqBSaMsUXAnwbWvyhIchXJkXFZE9o4ni/3taSM19MtIeap5FTgq1+ALp7C8rCj3rsxK+IUFr7crdAvzj9IPPFJILz9HzTERRyhUkx5Vsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970005; c=relaxed/simple;
	bh=8YEhmUBBqKXx9e+eKyA5GVKGvoNPGbbleY8pX1/XJeY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TAn3bq1b9SjKYw8wwAxanNUiryU0jiDP5pg1r1mMbpSc37gjFmxJb9iDXzWY+LC146TLGjUMI0RDllV2kaPkgjGyHQb3QvYxzniDRUakpDLsQYYprNRrSqfpr+/hH56VVbGfDSQ0bSle/v171Ojbm4fpBaM0jc2vvU0+jhVsgqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21345C433F1;
	Tue, 23 Jan 2024 00:33:24 +0000 (UTC)
Date: Mon, 22 Jan 2024 19:34:53 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Felix Kuehling <Felix.Kuehling@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org
Subject: Re: [BUG] BUG: kernel NULL pointer dereference at
 ttm_device_init+0xb4
Message-ID: <20240122193453.6096d45f@gandalf.local.home>
In-Reply-To: <918ddc13-1cf8-4199-b5be-5719a023de42@amd.com>
References: <20240122180605.28daf23a@gandalf.local.home>
	<918ddc13-1cf8-4199-b5be-5719a023de42@amd.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jan 2024 19:29:41 -0500
"Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com> wrote:

> 
> In one of my previous revisions of this patch when I was experimenting, 
> I used something like below. Wonder if that could work in your case 
> and/or in general.
> 
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_device.c 
> b/drivers/gpu/drm/ttm/ttm_device.c
> 
> index 43e27ab77f95..4c3902b94be4 100644
> 
> --- a/drivers/gpu/drm/ttm/ttm_device.c
> 
> +++ b/drivers/gpu/drm/ttm/ttm_device.c
> 
> @@ -195,6 +195,7 @@ int ttm_device_init(struct ttm_device *bdev, struct 
> ttm_device_funcs *funcs,
> 
> bool use_dma_alloc, bool use_dma32){
> 
> struct ttm_global *glob = &ttm_glob;
> 
> +bool node_has_cpu = false;
> 
> int ret;
> 
> if (WARN_ON(vma_manager == NULL))
> 
> @@ -213,7 +214,12 @@ int ttm_device_init(struct ttm_device *bdev, struct 
> ttm_device_funcs *funcs,
> 
> bdev->funcs = funcs;
> 
> ttm_sys_man_init(bdev);
> 
> -ttm_pool_init(&bdev->pool, dev, NUMA_NO_NODE, use_dma_alloc, use_dma32);
> 
> +
> 
> +node_has_cpu = node_state(dev->numa_node, N_CPU);

Considering that qxl_ttm_init() passes in dev = NULL, the above would blow
up just the same.

-- Steve


> 
> +if (node_has_cpu)
> 
> +ttm_pool_init(&bdev->pool, dev, dev->numa_node, use_dma_alloc, use_dma32);
> 
> +else
> 
> +ttm_pool_init(&bdev->pool, dev, NUMA_NO_NODE, use_dma_alloc,
> 
> +use_dma32);
> 
> bdev->vma_manager = vma_manager;
> 
> spin_lock_init(&bdev->lru_lock);
> 
> 
> >
> > -- Steve


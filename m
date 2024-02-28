Return-Path: <linux-kernel+bounces-85257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8599C86B30A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E116628B83D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230BC15B993;
	Wed, 28 Feb 2024 15:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ez68DcuL"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA3D612FC
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 15:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709133852; cv=none; b=RtLAURbfKKsesU9cnc4Z9NSGwxyK/7e7x92/ZFWryBUu65ceLBA0NvJoh/qIiRhUtrzKn79i+mPLVTZJsqBsOWbH9QnVdtOkbdttlDwrFEdE+tkJ6Ej7t97K4B6TvbAv2c9X8vLYshM85KOy3iGi1+9WbFo6nVNwaaFj8A8SAc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709133852; c=relaxed/simple;
	bh=5GeP2XG7v7dx7ZFOk1hq4cxp31+uOLrX3m4TokH17kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKj3JVY7mjdTesY67iMD9hFlGP+hBGxCi95qfqc4wSMLlFLIh3z+EHBDE1HofQ0hg56R7xjBpnHvLtYa4cQPCLsAQEURDJPE+Yr8A2GcLVSi/qRSL7+sXphViXT+mIIkorjRYofi75Cm7Fhw+sdaGUcCpBOLVfGLlDkMYWCMCDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ez68DcuL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3ehB3JpwRymg1TYF5t3hxiEfGc+bqJjBOoTcqkFo59Q=; b=ez68DcuLmefJzuWkWivyBEJAlG
	T+NXerCLYSu7LaLTVCkpWeSllzPcbel7rYe07ifv6MR8eEWkLinnLZz0SoK2TekcY4ceGRq3cXYsF
	Eth1QTsN8GV1t5UOQWbl+9n6RJPRjaosfbKS6R6zv3sVQSYqsNPxM/1e1ulYXlhS3mIia+kqX5iqc
	+vETEsjdhYmjGC/EIV4WkH6UUSkzPMAooz210L+XSl8Dl09O3G7FgQuD34fdsru7C8cvVXUOuDoU2
	BP0VE0BnLB5wHjVXh1fMD942xmZPXU4gF53uGilQFTJKJFLVtJuykOnPX0lPYirrDM5LpIA6kpfRI
	47lKUfZA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfLmw-00000005WZ4-3nu3;
	Wed, 28 Feb 2024 15:24:06 +0000
Date: Wed, 28 Feb 2024 15:24:06 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, yosryahmed@google.com,
	nphamcs@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-unstable hotfix] mm/zswap: fix zswap_pools_lock usages
 after changing to percpu_ref
Message-ID: <Zd9QFkE2nr5FyYDq@casper.infradead.org>
References: <20240210-zswap-global-lru-v3-2-200495333595@bytedance.com>
 <20240228151832.2431993-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228151832.2431993-1-chengming.zhou@linux.dev>

On Wed, Feb 28, 2024 at 03:18:32PM +0000, Chengming Zhou wrote:
> Now the release of zswap pool is controlled by percpu_ref, its release
> callback (__zswap_pool_empty()) will be called when percpu_ref hit 0.
> But this release callback may potentially be called from RCU callback
> context by percpu_ref_kill(), which maybe in the interrupt context.
> 
> So we need to use spin_lock_irqsave() and spin_unlock_irqrestore()
> in the release callback: __zswap_pool_empty(). In other task context
> places, spin_lock_irq() and spin_unlock_irq() are enough to avoid
> potential deadlock.

RCU callback context is BH, not IRQ, so it's enough to use
spin_lock_bh(), no?


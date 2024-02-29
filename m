Return-Path: <linux-kernel+bounces-86921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C1086CCDA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 652711F2512E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824B51468E6;
	Thu, 29 Feb 2024 15:25:23 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E14613EFF6
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709220323; cv=none; b=bSXDfYyQQHNzt04I0YWWS/LfFkwNXuo9aF6uHjXDLB3mP20DGGCMwXqEUlY5rOS0SKzHcyaxKPZTL5pgybZtf6YRJsjFklOdDWK0y0XcokXBwUtgEwmjuQ3zOla3DaI0NPPi6V0uaNC0JznCPwsNHyGc5LB9Hpaart4cJaXVXIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709220323; c=relaxed/simple;
	bh=sHkcD/snZ9V2Xv3mBv4VaxRarjPZsfN4VaX4NZfL+Mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cK26tGXIdTyoUGlvodVMWgWUIFM56qplCIr4GpQF6nAsiTMOHgUFdIqIZ7euZiNFHtndxolM560ifpxYQ+xC5B+f5Vhrw+vV3es2HzMRGNjkG8LxA2ZonRjEskPkyx8Rqr8hf5uu0+NNrrOu9W6EYHssAilphpgBs2liYjse8uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C302FC43399;
	Thu, 29 Feb 2024 15:25:21 +0000 (UTC)
Date: Thu, 29 Feb 2024 15:25:19 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Waiman Long <longman@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Audra Mitchell <aubaker@redhat.com>
Subject: Re: [PATCH] mm/kmemleak: Don't hold kmemleak_lock when calling
 printk()
Message-ID: <ZeCh30o8i-wJVT7N@arm.com>
References: <20240228191444.481048-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228191444.481048-1-longman@redhat.com>

On Wed, Feb 28, 2024 at 02:14:44PM -0500, Waiman Long wrote:
> When some error conditions happen (like OOM), some kmemleak functions
> call printk() to dump out some useful debugging information while holding
> the kmemleak_lock. This may cause deadlock as the printk() function
> may need to allocate additional memory leading to a create_object()
> call acquiring kmemleak_lock again.
> 
> Fix this deadlock issue by making sure that printk() is only called
> after releasing the kmemleak_lock.

I can't say I'm familiar with the printk() code but I always thought it
uses some ring buffers as it can be called from all kind of contexts and
allocation is not guaranteed.

If printk() ends up taking kmemleak_lock through the slab allocator, I
wonder whether we have bigger problems. The lock order is always
kmemleak_lock -> object->lock but if printk() triggers a callback into
kmemleak, we can also get object->lock -> kmemleak_lock ordering, so
another potential deadlock.

-- 
Catalin


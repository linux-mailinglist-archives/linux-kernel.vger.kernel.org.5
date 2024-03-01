Return-Path: <linux-kernel+bounces-88583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7A186E3BB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1167C1F24FC4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4201139AC4;
	Fri,  1 Mar 2024 14:49:52 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EAE257A
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 14:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709304591; cv=none; b=n8GEZbExCnBFyfdfNMBHu++NouXSFZJMd62hbqZGmH+3RxYuk9IlK+RwwzzuWRwX72hitm4/HQom2kMCrON901hRgqmhb7Ojkf44ldix6XUl9g2/KZCMWWqDVtWY6yUj+u41b38TytKzx+BETFCv/yRAGwF/rL5k1mwsSL0dXio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709304591; c=relaxed/simple;
	bh=Dl3AlUfjo/I+0JM0QbC8JfNyVl7VSlKqagBWJbQ+S4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3SCRXFh4S7PJuWS/m9ic7s02eGUVkzePMizinonnVk3oWh2pVdnIXeI0rkQmya1JxPFCpZKM7pscR+O0kbZz6UAqhXO/7vr99GyPu+HgIYNmmtH2vfwrKmTdPjJA7AVqN9QyT16AZOGm8U9GAOW4MNymCjmFz3ExStS+d+0fAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12348C433F1;
	Fri,  1 Mar 2024 14:49:49 +0000 (UTC)
Date: Fri, 1 Mar 2024 14:49:47 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Waiman Long <longman@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Audra Mitchell <aubaker@redhat.com>
Subject: Re: [PATCH] mm/kmemleak: Don't hold kmemleak_lock when calling
 printk()
Message-ID: <ZeHrC56llcicOjLP@arm.com>
References: <20240228191444.481048-1-longman@redhat.com>
 <ZeCh30o8i-wJVT7N@arm.com>
 <c5b07970-0523-420b-97ad-c08b50c69db2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5b07970-0523-420b-97ad-c08b50c69db2@redhat.com>

On Thu, Feb 29, 2024 at 10:55:38AM -0500, Waiman Long wrote:
> On 2/29/24 10:25, Catalin Marinas wrote:
> > On Wed, Feb 28, 2024 at 02:14:44PM -0500, Waiman Long wrote:
> > > When some error conditions happen (like OOM), some kmemleak functions
> > > call printk() to dump out some useful debugging information while holding
> > > the kmemleak_lock. This may cause deadlock as the printk() function
> > > may need to allocate additional memory leading to a create_object()
> > > call acquiring kmemleak_lock again.
> > > 
> > > Fix this deadlock issue by making sure that printk() is only called
> > > after releasing the kmemleak_lock.
> > I can't say I'm familiar with the printk() code but I always thought it
> > uses some ring buffers as it can be called from all kind of contexts and
> > allocation is not guaranteed.
> > 
> > If printk() ends up taking kmemleak_lock through the slab allocator, I
> > wonder whether we have bigger problems. The lock order is always
> > kmemleak_lock -> object->lock but if printk() triggers a callback into
> > kmemleak, we can also get object->lock -> kmemleak_lock ordering, so
> > another potential deadlock.
> 
> object->lock is per object whereas kmemleak_lock is global. When taking
> object->lock and doing a data dump leading to a call that takes the
> kmemlock, it is highly unlikely the it will need to take that particular
> object->lock again. I do agree that lockdep may still warn about it if that
> happens as all the object->lock's are likely to be treated to be in the same
> class.

Yeah, it's unlikely. I think it can only happen if there's a bug in
kmemleak (or slab) and the insertion fails because of the same object we
try to dump. But I suspect lockdep will complain either way.

> I should probably clarify in the change log that the lockdep splat is
> actually,
> 
> [ 3991.452558] Chain exists of: [ 3991.452559] console_owner -> &port->lock
> --> kmemleak_lock
> 
> So if kmemleak calls printk() acquiring either console_owner or port->lock.
> It may cause deadlock.

Could you please share the whole lockdep warning? IIUC, it's not the
printk() code allocating memory but somewhere down the line in the tty
layer.

Anyway, I had a look again at the kmemleak locking (I've been meaning to
simplify it for some time, drop the object->lock altogether). The only
time we nest object->lock within kmemleak_lock is during scan_block().
If we are unlucky to get some error on another CPU and dump that exact
object with printk(), it could lead to deadlock.

There's the dump_str_object_info() case as well triggered by a sysfs
write but luckily this takes the scan_mutex (same as during
scan_block()), so it solves the nesting problem.

I think in those error cases we can even ignore the object->lock when
dumping the info. Yeah, it can race, maybe not showing exactly the
precise data in some rare cases, but in those OOM scenarios it's
probably the least of our problem.

-- 
Catalin


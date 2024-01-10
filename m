Return-Path: <linux-kernel+bounces-22457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E72829DF9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C19721C2619D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C8A4CDE7;
	Wed, 10 Jan 2024 15:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CXj99WHU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1965A4CB5E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 15:52:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E99B7C43390;
	Wed, 10 Jan 2024 15:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704901925;
	bh=XlltqPfa8Akiky7w8TdLIafVMR4SvWgI44ZmWOSsDio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CXj99WHU/eYfD584OTSaFWnR04ME0zWX+oeIjgO67pzMAljFt3LQSs7xHQ7JBuUxi
	 FYdMOHLvl1R8SpsPgPeoUAFHRaQNPyl00DbEwVdsga9zDhyh25f1i86Ja6Sbo5ZOmw
	 lhWUyyCjw09dwPspC92tyffkjxp/vMhKm5R36Rwc=
Date: Wed, 10 Jan 2024 16:52:02 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Tejun Heo <tj@kernel.org>
Cc: andrea.righi@canonical.com, ast@kernel.org,
	linux-kernel@vger.kernel.org, geert@linux-m68k.org
Subject: Re: [PATCHSET driver-core-next] kernfs: Protect
 kernfs_find_and_get_node_by_id() with RCU
Message-ID: <2024011038-drainer-goofiness-9745@gregkh>
References: <20240109214828.252092-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109214828.252092-1-tj@kernel.org>

On Tue, Jan 09, 2024 at 11:48:01AM -1000, Tejun Heo wrote:
> The BPF helper bpf_cgroup_from_id() calls kernfs_find_and_get_node_by_id()
> which acquires kernfs_idr_lock, which is an non-raw non-IRQ-safe lock.
> kernfs_idr_lock used to be a non-irq-safe lock which could lead to deadlocks
> as bpf_cgroup_from_id() can be called from any BPF programs including e.g.
> the ones that attach to functions which are holding the scheduler rq lock.
> 
> To resolve the situation dad3fb67ca1c ("kernfs: convert kernfs_idr_lock to
> an irq safe raw spinlock") converted kernfs_idr_lock to an irq-safe raw
> spinlock. However, this was also broken as we call idr_alloc*() while
> holding the lock and idr itself uses an non-irq-safe lock and also calls
> into memory allocator.
> 
> Let's instead RCU protect kernfs_node and kernfs_root so that
> kernfs_find_and_get_node_by_id() can use rcu_read_lock() instead of
> kernfs_idr_lock. While this unfortunately increases the size of kernfs_node,
> it's the most straightforward thing to do and there likely are other places
> that can take advantage of RCU protection and improve scalability too.
> 
> Please see the patch descriptions for more details.
> 
> This patchset is on top of the current driver-core-next - dad3fb67ca1c
> ("kernfs: convert kernfs_idr_lock to an irq safe raw spinlock"), and also
> available in the following git branch.
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/tj/misc.git kernfs-use-rcu

Thanks, I'll take the first patch now, for -rc1, and then the other 2
after that to give some testing time.

greg k-h


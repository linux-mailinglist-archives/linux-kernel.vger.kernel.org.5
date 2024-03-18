Return-Path: <linux-kernel+bounces-106638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B94687F157
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 271E9284B3A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CC32747F;
	Mon, 18 Mar 2024 20:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NNy5AYxq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FF72561D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 20:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710794456; cv=none; b=cBwsZOjCXBmIG9ttjH3TNIkBiqDAAkMMd/8aksFxIMme+JxKQ/7ZZMIjmjqot1JHkjvkRIpmw2CDMPCThBtyk6bx2uj1nQbC/049xwLobDghhxikuLFEMnGT8FaHjVRiQ4NnchzWASflrzZBOgqOtUyL6zyrveEFKyWnM6r4WO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710794456; c=relaxed/simple;
	bh=ASewAmN/H3/b9cAvyrgmlDE+vLv+687YtUvC+KDcgsM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=toN5285I5JU9w4bu366HJzL1yV+6iiZ36r6ZoYjoak6qC4Ezq4VseGWzGdPqvfuFgisL/zkJLyvX9FY0jNkQqj9LgvazD6IULsIFwEEb8jYGR0mYB8VDSJM/fRUTdqJ75mBXYaWk9y6cbXbwMAOb7pl+nP+j8WjvsKH5w2/38GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NNy5AYxq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D26EC433C7;
	Mon, 18 Mar 2024 20:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1710794456;
	bh=ASewAmN/H3/b9cAvyrgmlDE+vLv+687YtUvC+KDcgsM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NNy5AYxq/SzYhGRPZyu0aqo8MrkgSqSKjawZ7u1Y9b8P22xkCOwm8RZkp5uIypwYu
	 VLInFOpKPrGufAMPzfM1EbHECYq0dA5bmLQIvf29FGr0XEJC5xN7rykybzwRNEDswR
	 B/2EqWIyLAXsRCaJIZkywTzpvjVcDYRdgqjZey8I=
Date: Mon, 18 Mar 2024 13:40:55 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: jpoimboe@kernel.org, kent.overstreet@linux.dev, peterz@infradead.org,
 nphamcs@gmail.com, cerasuolodomenico@gmail.com, surenb@google.com,
 lizhijian@fujitsu.com, willy@infradead.org, shakeel.butt@linux.dev,
 vbabka@suse.cz, ziy@nvidia.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH v2] vmstat: Keep count of the maximum page reached by
 the kernel stack
Message-Id: <20240318134055.c2f6b29bb6eb73ec93bf7079@linux-foundation.org>
In-Reply-To: <20240314145457.1106299-1-pasha.tatashin@soleen.com>
References: <20240314145457.1106299-1-pasha.tatashin@soleen.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Mar 2024 14:54:57 +0000 Pasha Tatashin <pasha.tatashin@soleen.com> wrote:

> CONFIG_DEBUG_STACK_USAGE provides a mechanism to determine the minimum
> amount of memory left in a stack. Every time a new low-memory record is
> reached, a message is printed to the console.
> 
> However, this doesn't reveal how many pages within each stack were
> actually used. Introduce a mechanism that keeps count the number of
> times each of the stack's pages were reached:
> 
> 	$ grep kstack /proc/vmstat
> 	kstack_page_1 19974
> 	kstack_page_2 94
> 	kstack_page_3 0
> 	kstack_page_4 0
> 
> In the above example, out of 20,068 threads that exited on this
> machine, only 94 reached the second page of their stack, and none
> touched pages three or four.
> 
> In fleet environments with millions of machines, this data can help
> optimize kernel stack sizes.

We really should have somewhere to document vmstat things.

> --- a/include/linux/vm_event_item.h
> +++ b/include/linux/vm_event_item.h
> @@ -153,10 +153,39 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
>  		VMA_LOCK_ABORT,
>  		VMA_LOCK_RETRY,
>  		VMA_LOCK_MISS,
> +#endif
> +#ifdef CONFIG_DEBUG_STACK_USAGE
> +		KSTACK_PAGE_1,
> +		KSTACK_PAGE_2,
> +#if THREAD_SIZE >= (4 * PAGE_SIZE)
> +		KSTACK_PAGE_3,
> +		KSTACK_PAGE_4,
> +#endif
> +#if THREAD_SIZE > (4 * PAGE_SIZE)
> +		KSTACK_PAGE_REST,
> +#endif
>  #endif
>  		NR_VM_EVENT_ITEMS
>  };

This seems a rather cumbersome way to produce a kind of histogram.  I
wonder if there should be a separate pseudo file for this.

And there may be a call for extending this.  For example I can forsee
people wanting to know "hey, which process did that", in which case
we'll want to record additional info.  



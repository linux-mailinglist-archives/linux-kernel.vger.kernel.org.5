Return-Path: <linux-kernel+bounces-58903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E860284EE5E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 01:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A4E728BE53
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E7F37B;
	Fri,  9 Feb 2024 00:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FWJXAuSJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC484364
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 00:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707438499; cv=none; b=Me6cnjUamdwIaMh0PIfl7y2roKoJswBU72TQPPCYGBh2/fmhJmznTzMsd8RI6ESwhWKvxyRnj79zLlt8X9WYA3hdcCeIBXNcGPHwyCXpPJabLCE8+ILJnMiqV7czK5fpCdXBjOK+LmseQx62mLw1JivjIndH/tgUZKq4AbnrJsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707438499; c=relaxed/simple;
	bh=11T3RfqVBk/00J32ASxKzhqAcS03aS5TfH8i2dHZWXg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GMMt7PGzKTlwd3yI8f2Tjc/OxuAs3XLPf/yWlHsHsqutZ+KQqC4qFo1DqfWiQUpR80TfPEXTgcYFBhEr6rw4qhcC8ghnZhG/4jiOrXndixfV/VjQAVSosp3KLBM6Rc0xB23WHToEy6wIseO2CT1uggg4kOjvHQZLvDhUE3k3ubU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FWJXAuSJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CBB8C433C7;
	Fri,  9 Feb 2024 00:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1707438499;
	bh=11T3RfqVBk/00J32ASxKzhqAcS03aS5TfH8i2dHZWXg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FWJXAuSJWVE93DhOHvg+/cLaQAIitptg/4rNbc99uElVG5kHmZlZbuPuwENF7F+CO
	 VvvzASS76WReP2nLQA1TE/1yLKePgkiUteXzC9sxCl4YjO26j7cDKUfcl41IOuxX0R
	 CfYlvU6fLhBQKc7ag499ReV+f+m8VJzbSA8cViQc=
Date: Thu, 8 Feb 2024 16:28:18 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Oscar Salvador <osalvador@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Michal Hocko
 <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>, Marco Elver
 <elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Alexander
 Potapenko <glider@google.com>
Subject: Re: [PATCH v7 0/4] page_owner: print stacks and their outstanding
 allocations
Message-Id: <20240208162818.369c7abc3ecb06d49adaeebb@linux-foundation.org>
In-Reply-To: <20240208234539.19113-1-osalvador@suse.de>
References: <20240208234539.19113-1-osalvador@suse.de>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  9 Feb 2024 00:45:35 +0100 Oscar Salvador <osalvador@suse.de> wrote:

> page_owner is a great debug functionality tool that lets us know
> about all pages that have been allocated/freed and their specific
> stacktrace.
> This comes very handy when debugging memory leaks, since with
> some scripting we can see the outstanding allocations, which might point
> to a memory leak.
> 
> In my experience, that is one of the most useful cases, but it can get
> really tedious to screen through all pages and try to reconstruct the
> stack <-> allocated/freed relationship, becoming most of the time a
> daunting and slow process when we have tons of allocation/free operations. 
> 
> This patchset aims to ease that by adding a new functionality into
> page_owner.
> This functionality creates a new read-only file called "page_owner_stacks",

The full path would be appreciated.

> which prints out all the stacks followed by their outstanding number
> of allocations (being that the times the stacktrace has allocated
> but not freed yet).
> This gives us a clear and a quick overview of stacks <-> allocated/free.
> 
> We take advantage of the new refcount_f field that stack_record struct
> gained, and increment/decrement the stack refcount on every
> __set_page_owner() (alloc operation) and __reset_page_owner (free operation)
> call.
> 
> Unfortunately, we cannot use the new stackdepot api
> STACK_DEPOT_FLAG_{GET,PUT} because it does not fulfill page_owner needs,
> meaning we would have to special case things, at which point
> makes more sense for page_owner to do its own {dec,inc}rementing
> of the stacks.
> E.g: Using STACK_DEPOT_FLAG_PUT, once the refcount reaches 0,
> such stack gets evicted, so page_owner would lose information.
> 
> This patch also creates a new file called 'page_owner_threshold'.
> By writing a value to it, the stacks which refcount is below such
> value will be filtered out.
> 
> In order to better exercise the path in stack_depot_get_next_stack(),
> I artificially filled the buckets with more than one stack, making sure
> I was getting all of then when reading from it.
> 
> On a side note, stack_depot_get_next_stack() could be somehow reconstructed
> to be in page_owner code, but we would have to move stack_table
> into the header, so page_owner can access it.
> I can do that if that's preferred, so stackdepot.c would not get "poluted".
> 
> A PoC can be found below:
> 
>  # cat /sys/kernel/debug/page_owner_stacks > page_owner_full_stacks.txt

Oh, there it is.  I wonder why we didn't use /sys/kernel/mm/

Would a new /sys/kernel/debug/page_owner_something/ be a good idea?  We
might add more things later.  Then it can be
/sys/kernel/debug/page_owner_something/full_stacks. 
/sys/kernel/debug/page_owner/ would be nice, but it's too late for
that.

> Oscar Salvador (4):
>   lib/stackdepot: Move stack_record struct definition into the header
>   mm,page_owner: Implement the tracking of the stacks count
>   mm,page_owner: Display all stacks and their count
>   mm,page_owner: Filter out stacks by a threshold
> 
>  include/linux/stackdepot.h |  72 ++++++++++++++++++++
>  lib/stackdepot.c           |  97 ++++++++++++++------------
>  mm/page_owner.c            | 136 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 262 insertions(+), 43 deletions(-)

Documentation/mm/page_owner.rst?


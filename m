Return-Path: <linux-kernel+bounces-116430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE824889D13
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D97201C34E44
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AA5172776;
	Mon, 25 Mar 2024 06:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b02pmxDK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E712662A2;
	Mon, 25 Mar 2024 03:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711335810; cv=none; b=LtaO7I7ruvtUZdxrBdOHnwBAYPL+ASuK3W/qGzQ3tr+ZTUYN0bEZeTYMrr2+l+oOfqaWEhM5sKd7qcYROFyV+HCFwXF85vQ3NBvJmVcu6rrGFUDCRXZ2LtgnkfETGSALeTevOeFsik7Or9HwDDR4ejTVQe/TIRDr0oHZGD1yU1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711335810; c=relaxed/simple;
	bh=zAKhiSdcqivjXcEs7RdADkipim2MVBTbYablrmDKivA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=diHTCUg1OoRPgsDAS6tgtWlBgbVWfPrYPBXnyJ2fBi4Gk7EdbBN8xCtDFY414JVusGA9UGUGUMAbvkC9P/h1j4kcgg/hQgnlNxqw2dj+dG2L2FsSGFj7kAGuno47NJyHj1PdNLLpqjSFskKMMf/KVrbcuzhvXZ4zNii9mVLyalk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b02pmxDK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF66C43390;
	Mon, 25 Mar 2024 03:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711335809;
	bh=zAKhiSdcqivjXcEs7RdADkipim2MVBTbYablrmDKivA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b02pmxDKbv7Jb0Zu5jo594WBbOYkDyxWAQMz1bFBHsPkXVKSsiXfRwNm0JbQ+eqz/
	 gRixYl6VzkSOIXry4LdMTyTTIFMyatrSvlTAWA5EzUdEXhH5/NKbrH6oc7XRNGhoiS
	 PuUI6b8up8MY2mlSTPBMe8FGcDu36h483wqB09J2mGgKMe+RgKrMeb79PVHGik4pZ6
	 7H4Bazz4TQaUVraPQtwg18lWJSBwPJrH5ZO4Yk+jEqHZPNrsWVYIR4H8pUTbXg0lBR
	 B4pBTAraUllkkVza7KLBLcShIlwbmgWIj0ZKKAL5mv2OpmpsXk6BJgIp62tMYHX00E
	 I4erOuDSPnlWA==
Date: Mon, 25 Mar 2024 12:03:23 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jonathan Haslam <jonathan.haslam@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org, andrii@kernel.org,
 bpf@vger.kernel.org, rostedt@goodmis.org, mhiramat@kernel.org, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uprobes: reduce contention on uprobes_tree access
Message-Id: <20240325120323.ec3248d330b2755e73a6571e@kernel.org>
In-Reply-To: <20240321145736.2373846-1-jonathan.haslam@gmail.com>
References: <20240321145736.2373846-1-jonathan.haslam@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Mar 2024 07:57:35 -0700
Jonathan Haslam <jonathan.haslam@gmail.com> wrote:

> Active uprobes are stored in an RB tree and accesses to this tree are
> dominated by read operations. Currently these accesses are serialized by
> a spinlock but this leads to enormous contention when large numbers of
> threads are executing active probes.
> 
> This patch converts the spinlock used to serialize access to the
> uprobes_tree RB tree into a reader-writer spinlock. This lock type
> aligns naturally with the overwhelmingly read-only nature of the tree
> usage here. Although the addition of reader-writer spinlocks are
> discouraged [0], this fix is proposed as an interim solution while an
> RCU based approach is implemented (that work is in a nascent form). This
> fix also has the benefit of being trivial, self contained and therefore
> simple to backport.
> 
> This change has been tested against production workloads that exhibit
> significant contention on the spinlock and an almost order of magnitude
> reduction for mean uprobe execution time is observed (28 -> 3.5 microsecs).

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

BTW, how did you measure the overhead? I think spinlock overhead
will depend on how much lock contention happens.

Thank you,

> 
> [0] https://docs.kernel.org/locking/spinlocks.html
> 
> Signed-off-by: Jonathan Haslam <jonathan.haslam@gmail.com>
> ---
>  kernel/events/uprobes.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 929e98c62965..42bf9b6e8bc0 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -39,7 +39,7 @@ static struct rb_root uprobes_tree = RB_ROOT;
>   */
>  #define no_uprobe_events()	RB_EMPTY_ROOT(&uprobes_tree)
>  
> -static DEFINE_SPINLOCK(uprobes_treelock);	/* serialize rbtree access */
> +static DEFINE_RWLOCK(uprobes_treelock);	/* serialize rbtree access */
>  
>  #define UPROBES_HASH_SZ	13
>  /* serialize uprobe->pending_list */
> @@ -669,9 +669,9 @@ static struct uprobe *find_uprobe(struct inode *inode, loff_t offset)
>  {
>  	struct uprobe *uprobe;
>  
> -	spin_lock(&uprobes_treelock);
> +	read_lock(&uprobes_treelock);
>  	uprobe = __find_uprobe(inode, offset);
> -	spin_unlock(&uprobes_treelock);
> +	read_unlock(&uprobes_treelock);
>  
>  	return uprobe;
>  }
> @@ -701,9 +701,9 @@ static struct uprobe *insert_uprobe(struct uprobe *uprobe)
>  {
>  	struct uprobe *u;
>  
> -	spin_lock(&uprobes_treelock);
> +	write_lock(&uprobes_treelock);
>  	u = __insert_uprobe(uprobe);
> -	spin_unlock(&uprobes_treelock);
> +	write_unlock(&uprobes_treelock);
>  
>  	return u;
>  }
> @@ -935,9 +935,9 @@ static void delete_uprobe(struct uprobe *uprobe)
>  	if (WARN_ON(!uprobe_is_active(uprobe)))
>  		return;
>  
> -	spin_lock(&uprobes_treelock);
> +	write_lock(&uprobes_treelock);
>  	rb_erase(&uprobe->rb_node, &uprobes_tree);
> -	spin_unlock(&uprobes_treelock);
> +	write_unlock(&uprobes_treelock);
>  	RB_CLEAR_NODE(&uprobe->rb_node); /* for uprobe_is_active() */
>  	put_uprobe(uprobe);
>  }
> @@ -1298,7 +1298,7 @@ static void build_probe_list(struct inode *inode,
>  	min = vaddr_to_offset(vma, start);
>  	max = min + (end - start) - 1;
>  
> -	spin_lock(&uprobes_treelock);
> +	read_lock(&uprobes_treelock);
>  	n = find_node_in_range(inode, min, max);
>  	if (n) {
>  		for (t = n; t; t = rb_prev(t)) {
> @@ -1316,7 +1316,7 @@ static void build_probe_list(struct inode *inode,
>  			get_uprobe(u);
>  		}
>  	}
> -	spin_unlock(&uprobes_treelock);
> +	read_unlock(&uprobes_treelock);
>  }
>  
>  /* @vma contains reference counter, not the probed instruction. */
> @@ -1407,9 +1407,9 @@ vma_has_uprobes(struct vm_area_struct *vma, unsigned long start, unsigned long e
>  	min = vaddr_to_offset(vma, start);
>  	max = min + (end - start) - 1;
>  
> -	spin_lock(&uprobes_treelock);
> +	read_lock(&uprobes_treelock);
>  	n = find_node_in_range(inode, min, max);
> -	spin_unlock(&uprobes_treelock);
> +	read_unlock(&uprobes_treelock);
>  
>  	return !!n;
>  }
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


Return-Path: <linux-kernel+bounces-45758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 486458435E2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC3A728544C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 05:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B6B3E494;
	Wed, 31 Jan 2024 05:09:45 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8D93FB0D;
	Wed, 31 Jan 2024 05:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706677784; cv=none; b=fCmRDgSwdmXoRVT4/CT54SJwwo21kbZXVT8s7twqsXMyscnAui0cWE3tENgGICdmsShBQ5ww4d1KDT0JBX9eLCaMuBlzov9sGjUPMVCRG+kasazKq9fc/vjUDyOY2LwVZPOB/UqxghevQeNon1jXobunGGX22oy3QRBfzjtlMUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706677784; c=relaxed/simple;
	bh=QvjKDYSLV2yuH9+Dn5eSLY9XpB6/Ol/LAIJt1dzRKXc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AXaSx72DMXBB63wZFBEFvqaSyDUhjWr/7Rl/m1q5R58eVxnwPhOrFmV1j7vOZhzFNYmxWHIkJLc8TryNxGzJ6hNBEpPu6Y8kaEa8THXQZaKYENq+CFSMQbGOMC3ekDgt5bLawCBrGBUTJ6gFwRVdrUktUlpV9v9UrrYwWneJMoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2F9C433C7;
	Wed, 31 Jan 2024 05:09:43 +0000 (UTC)
Date: Wed, 31 Jan 2024 00:09:56 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] eventfs: get rid of dentry pointers without
 refcounts
Message-ID: <20240131000956.3dbc0fc0@gandalf.local.home>
In-Reply-To: <20240130190355.11486-5-torvalds@linux-foundation.org>
References: <20240130190355.11486-1-torvalds@linux-foundation.org>
	<20240130190355.11486-5-torvalds@linux-foundation.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jan 2024 11:03:54 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> +/*
> + * eventfs_inode reference count management.
> + *
> + * NOTE! We count only references from dentries, in the
> + * form 'dentry->d_fsdata'. There are also references from
> + * directory inodes ('ti->private'), but the dentry reference
> + * count is always a superset of the inode reference count.
> + */
> +static void release_ei(struct kref *ref)
> +{
> +	struct eventfs_inode *ei = container_of(ref, struct eventfs_inode, kref);
> +	kfree(ei->entry_attrs);

I did modify this to add back the kfree_const(ei->name);

I would also like to add a:

	WARN_ON_ONCE(!ei->is_freed);

The kref_put() logic should add the protection that this is guaranteed to
be true as the logic in the removal does:

	ei->is_freed = 1;
  [..]
	kref_put(ei);

I would think that the last "put" would always have the "is_freed" set. The
WARN_ON is to catch things doing too many put_ei().


> +	kfree(ei);
> +}
> +


> @@ -951,5 +857,6 @@ void eventfs_remove_events_dir(struct eventfs_inode *ei)
>  	 * sticks around while the other ei->dentry are created
>  	 * and destroyed dynamically.
>  	 */
> +	simple_recursive_removal(dentry, NULL);

Actually, this doesn't work. It expects all the dentries in the list to
have positive ref counts, as it does dput() on them. If there's any cached,
it will bug with a dput() on a dentry of zero.

The only dentries that should have non zero ref counts are ones that are
currently being accessed and wont go away until finished. I think all we
need to do is invalidate the top dentry. Is that true?

Does this work:

	d_invalidate(dentry);

to make the directory no longer accessible. And all dentries within it
should be zero, and hopefully go away on memory reclaim. The last patch
removes it, but if you want to test the deletion, you can do this:

 # cd /sys/kernel/tracing
 # mkdir instances/foo
 # ls instances/foo/events
 # rmdir instances/foo


But also note that this patch fails with the "ghost" files with the kprobe
test again. When I apply patch 6, that goes away. I'm guessing that's
because this needs the d_revalidate() call. To not break bisection, I think
we need to merge this and patch 6 together.

Also patch 6 removes the simple_recursive_removal() which without at least
the d_invalidate() causes a dput splat. That's because the rmdir calls
tracefs_remove() which calls simple_recursive_removal() that will walk to
the events directory and I'm assuming if it hasn't been invalidated, it
walks into it causing the same issue as a simple_recursive_removal() would
have here.

Try the above mkdir and rmdir to see.

-- Steve


>  	dput(dentry);
>  }


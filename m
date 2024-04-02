Return-Path: <linux-kernel+bounces-128425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A49895AAC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 169A42896C8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B61115A4A3;
	Tue,  2 Apr 2024 17:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="soY+nlW7"
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA33014AD3D;
	Tue,  2 Apr 2024 17:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079046; cv=pass; b=rCIKuX7oHQXEot2I6ULmMUnsgdThiyrlRhwFXnKllvtsZ8Ixdsa/OBJLGWpBg3Ma+KfawEw9sBOzeTkI3wlETBdyYaeeeNz56TynfoE3N37/5Eicz8fUzlF5gX5tcVw19vxD7wmUCR55AGjeRSn1ecqevRAgiboCDa1tArmZnss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079046; c=relaxed/simple;
	bh=gC2pA2vWQ6LUhjc0hRn0YhksA3GM4Z3DfGgguX9e8C8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3wdl4LdeP/zEA9wkAvLuNSmXXm8nsZqmVY1zvWRQxGVPna1CULsxPLLQyITUanmYhcnI/W4+KQkhpxlTuIc5BroYcvzwI7O4+mbSdJTNnDcezjHnbNc81f+2r/4TNrKleXIvx2jNuUiy3Ah7Kmz1cH3wjjy0yECmlkPAtWy5tU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=soY+nlW7; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from darkstar.musicnaut.iki.fi (85-76-140-31-nat.elisa-mobile.fi [85.76.140.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: aaro.koskinen)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4V8FJp17psz101C;
	Tue,  2 Apr 2024 20:30:34 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1712079037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZZoAGDk83WlTFJh5LgmwBGfnksQY7qdEgy6pI2WrPHw=;
	b=soY+nlW7HENa3hDAwHLxlV0Pf9t4ASlDCMm51FIBNSKq2/JXoHhWfyQ6VsdPvH1hyG4HdS
	smHcCTVSIgBdpqwRoIjT8L8aCP5Kfu8LIOwCBIXyQqOhXce1x5g/yUbecZkhYePTp5vLj3
	zk/djvn8UJEOthVjCnj4Vub8mkQMQWI=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1712079037; a=rsa-sha256; cv=none;
	b=eLwKpyw2TdfpoYptWQ7/fi8hYu5Gdtf2gKXcozU+0x8J07M/LvMtN4IxcT0vJxXlaIz8jP
	vxjAyAr58c66b+x6T8pC0aNt9BN7CMYB8QLOTqxvVJAzaXIIW8XfOsB1ri5OmtHajt/QdX
	Wd0gx4yRiAhTlZKVSaAQQM8TNceIuYE=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1712079036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZZoAGDk83WlTFJh5LgmwBGfnksQY7qdEgy6pI2WrPHw=;
	b=BQ+8UxObZ/ckvU0VrFjlCszlQ2bvDwX2zmEly4x+xji5FYczvx4DJYBiWosJmU55DlnIyn
	P35+eXloQBV7FdOYk2ws3W6WzVNDYa6iWiM8PiHIRw2/Mk9QMqxUAGuAMVcMUsR4plexER
	mAaOmCT64NPzCRz648QxnGqZD1dvia8=
Date: Tue, 2 Apr 2024 20:30:32 +0300
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Cc: Waiman Long <longman@redhat.com>, Mukesh Ojha <quic_mojha@quicinc.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg KH <gregkh@linuxfoundation.org>, mingo@redhat.com,
	will@kernel.org, boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
	Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] locking/rwsem: Disable preemption while trying for
 rwsem lock
Message-ID: <20240402173032.GC91663@darkstar.musicnaut.iki.fi>
References: <1662661467-24203-1-git-send-email-quic_mojha@quicinc.com>
 <20240305110402.GA72649@darkstar.musicnaut.iki.fi>
 <b92644e5-529b-4403-aba7-d316262cc8ac@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b92644e5-529b-4403-aba7-d316262cc8ac@redhat.com>

Stable team,

Please cherry-pick this patch into v5.15 stable:

	locking/rwsem: Disable preemption while trying for rwsem lock

	commit 48dfb5d2560d36fb16c7d430c229d1604ea7d185

It fixes the following bug present in v5.15:

> > > From: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
> > > We observe RT task is hogging CPU when trying to acquire rwsem lock
> > > which was acquired by a kworker task but before the rwsem owner was set.
> > > 
> > > Here is the scenario:
> > > 1. CFS task (affined to a particular CPU) takes rwsem lock.
> > > 
> > > 2. CFS task gets preempted by a RT task before setting owner.
> > > 
> > > 3. RT task (FIFO) is trying to acquire the lock, but spinning until
> > > RT throttling happens for the lock as the lock was taken by CFS task.

If the RT throttling is disabled, the RT task will remain looping forever
in the kernel. If the system is UP, it will lock up completely.

The issue can be easily reproduced by running RT task and normal task which
are affined to the same CPU core.

A.

On Tue, Mar 05, 2024 at 09:55:47AM -0500, Waiman Long wrote:
> On 3/5/24 06:04, Aaro Koskinen wrote:
> > Hi,
> > 
> > It seems this patch (commit 48dfb5d2560d) is missing from
> > at least 5.15 stable tree.
> > 
> > Based on quick test, it seems to fix an issue where system locks up
> > easily when RT throttling is disabled, and also it applies cleanly, so
> > I think it should be good to have it 5.15?
> 
> You need to cc stable as the locking maintainers are not responsible for
> merging patches to stable trees.
> 
> Cheers,
> Longman
> 
> > 
> > A.
> > 
> > On Thu, Sep 08, 2022 at 11:54:27PM +0530, Mukesh Ojha wrote:
> > > From: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
> > > 
> > > Make the region inside the rwsem_write_trylock non preemptible.
> > > 
> > > We observe RT task is hogging CPU when trying to acquire rwsem lock
> > > which was acquired by a kworker task but before the rwsem owner was set.
> > > 
> > > Here is the scenario:
> > > 1. CFS task (affined to a particular CPU) takes rwsem lock.
> > > 
> > > 2. CFS task gets preempted by a RT task before setting owner.
> > > 
> > > 3. RT task (FIFO) is trying to acquire the lock, but spinning until
> > > RT throttling happens for the lock as the lock was taken by CFS task.
> > > 
> > > This patch attempts to fix the above issue by disabling preemption
> > > until owner is set for the lock. While at it also fix the issues
> > > at the places where rwsem_{set,clear}_owner() are called.
> > > 
> > > This also adds lockdep annotation of preemption disable in
> > > rwsem_{set,clear}_owner() on Peter Z. suggestion.
> > > 
> > > Signed-off-by: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
> > > Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> > > ---
> > > Changes in v2:
> > >   - Remove preempt disable code in rwsem_try_write_lock_unqueued()
> > >   - Addressed suggestion from Peter Z.
> > >   - Modified commit text
> > >   kernel/locking/rwsem.c | 14 ++++++++++++--
> > >   1 file changed, 12 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> > > index 65f0262..4487359 100644
> > > --- a/kernel/locking/rwsem.c
> > > +++ b/kernel/locking/rwsem.c
> > > @@ -133,14 +133,19 @@
> > >    * the owner value concurrently without lock. Read from owner, however,
> > >    * may not need READ_ONCE() as long as the pointer value is only used
> > >    * for comparison and isn't being dereferenced.
> > > + *
> > > + * Both rwsem_{set,clear}_owner() functions should be in the same
> > > + * preempt disable section as the atomic op that changes sem->count.
> > >    */
> > >   static inline void rwsem_set_owner(struct rw_semaphore *sem)
> > >   {
> > > +	lockdep_assert_preemption_disabled();
> > >   	atomic_long_set(&sem->owner, (long)current);
> > >   }
> > >   static inline void rwsem_clear_owner(struct rw_semaphore *sem)
> > >   {
> > > +	lockdep_assert_preemption_disabled();
> > >   	atomic_long_set(&sem->owner, 0);
> > >   }
> > > @@ -251,13 +256,16 @@ static inline bool rwsem_read_trylock(struct rw_semaphore *sem, long *cntp)
> > >   static inline bool rwsem_write_trylock(struct rw_semaphore *sem)
> > >   {
> > >   	long tmp = RWSEM_UNLOCKED_VALUE;
> > > +	bool ret = false;
> > > +	preempt_disable();
> > >   	if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp, RWSEM_WRITER_LOCKED)) {
> > >   		rwsem_set_owner(sem);
> > > -		return true;
> > > +		ret = true;
> > >   	}
> > > -	return false;
> > > +	preempt_enable();
> > > +	return ret;
> > >   }
> > >   /*
> > > @@ -1352,8 +1360,10 @@ static inline void __up_write(struct rw_semaphore *sem)
> > >   	DEBUG_RWSEMS_WARN_ON((rwsem_owner(sem) != current) &&
> > >   			    !rwsem_test_oflags(sem, RWSEM_NONSPINNABLE), sem);
> > > +	preempt_disable();
> > >   	rwsem_clear_owner(sem);
> > >   	tmp = atomic_long_fetch_add_release(-RWSEM_WRITER_LOCKED, &sem->count);
> > > +	preempt_enable();
> > >   	if (unlikely(tmp & RWSEM_FLAG_WAITERS))
> > >   		rwsem_wake(sem);
> > >   }
> > > -- 
> > > 2.7.4
> > > 
> > > 
> 
> 


Return-Path: <linux-kernel+bounces-155180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD15F8AE65B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 671471F21F4A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191761350CD;
	Tue, 23 Apr 2024 12:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ulc+2dcp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68E3134CCA
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 12:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713875816; cv=none; b=c/wV89V24ptRRcZB2hOdb4tP5ezZBOWixG9wh1q0ecEFm3cdLOMevrOjBtxrgQCwiawza+rWivB6+VEBAirUcxfY7onC6MINiupnXysAgyahTKP4OnTMLRm0C2UxY/bnXElCgTV183zMSju9aRQXLVSkEIIUQb4tKHYfkwDvk1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713875816; c=relaxed/simple;
	bh=VvAME1LWxRbvx9VDh/G7d7/s1knb+JtsY3BVP7m4ZaU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=n+fmD4qF1AoP5CUuxAZNjmuzMOhJevhkQwvsABao1BDlSWka4KbVYQwHzpA8Ho57TRFCx7BBjxv4rSIBcYLrBZiY0NyHhu20pxduraLXdDtYb4LH4jHATqPQFT10GZ9z7EzJQwtBWaELYQXVgq0XV0pEs3N/bA9QUpQxzz7mDCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ulc+2dcp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713875814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m5hTS5Su8xeK74rUb4KJF+eI0XGddiqGV3X2wh7pCMQ=;
	b=Ulc+2dcphrdXBrNnW0/NfJCudDcAdWREZc4FyZibcVw4aZ0VGL0dVwksT83pWTjdojxIn6
	km/HvG/fkF8FrOtrQobsACR6NFAqojUigjcP3/gxvGIrW/6KiHXgyEA7kcAs/cBqVXuRTC
	hf2ZPZ1/uNQYDavyRoNlMBOeE5JI2J8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-Xj5FVClHMBeSnhEOFqUCew-1; Tue, 23 Apr 2024 08:36:47 -0400
X-MC-Unique: Xj5FVClHMBeSnhEOFqUCew-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8096981F317;
	Tue, 23 Apr 2024 12:36:46 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D93FC0E7C2;
	Tue, 23 Apr 2024 12:36:45 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id 883ED30BE3F7; Tue, 23 Apr 2024 12:36:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 841A83FA97;
	Tue, 23 Apr 2024 14:36:45 +0200 (CEST)
Date: Tue, 23 Apr 2024 14:36:45 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
cc: Christoph Hellwig <hch@infradead.org>, Mike Snitzer <msnitzer@redhat.com>, 
    Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>, 
    Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
    Waiman Long <longman@redhat.com>, Guangwu Zhang <guazhang@redhat.com>, 
    dm-devel@lists.linux.dev, linux-block@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] completion: move blk_wait_io to
 kernel/sched/completion.c
In-Reply-To: <20240422105956.GN30852@noisy.programming.kicks-ass.net>
Message-ID: <8ab5c16e-154-c66-d167-5ce9eb6ea331@redhat.com>
References: <31b118f3-bc8d-b18b-c4b9-e57d74a73f@redhat.com> <20240417175538.GP40213@noisy.programming.kicks-ass.net> <546473fd-ca4b-3c64-349d-cc739088b748@redhat.com> <ZiCoIHFLAzCva2lU@infradead.org> <20240422105956.GN30852@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8



On Mon, 22 Apr 2024, Peter Zijlstra wrote:

> On Wed, Apr 17, 2024 at 09:57:04PM -0700, Christoph Hellwig wrote:
> > On Wed, Apr 17, 2024 at 08:00:22PM +0200, Mikulas Patocka wrote:
> > > > > +EXPORT_SYMBOL(wait_for_completion_long_io);
> > > > 
> > > > Urgh, why is it a sane thing to circumvent the hang check timer? 
> > > 
> > > The block layer already does it - the bios can have arbitrary size, so 
> > > waiting for them takes arbitrary time.
> > 
> > And as mentioned the last few times around, I think we want a task
> > state to say that task can sleep long or even forever and not propagate
> > this hack even further.
> 
> A bit like TASK_NOLOAD (which is used to make TASK_IDLE work), but
> different I suppose.
> 
> TASK_NOHUNG would be trivial to add ofc. But is it worth it?
> 
> Anyway, as per the other email, anything like this needs to come with a
> big fat warning. You get to keep the pieces etc..

This seems better than the blk_wait_io hack.

Reviewed-by: Mikulas Patocka <mpatocka@redhat.com>

> ---
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 3c2abbc587b4..83b25327c233 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -112,7 +112,8 @@ struct user_event_mm;
>  #define TASK_FREEZABLE			0x00002000
>  #define __TASK_FREEZABLE_UNSAFE	       (0x00004000 * IS_ENABLED(CONFIG_LOCKDEP))
>  #define TASK_FROZEN			0x00008000
> -#define TASK_STATE_MAX			0x00010000
> +#define TASK_NOHUNG			0x00010000
> +#define TASK_STATE_MAX			0x00020000
>  
>  #define TASK_ANY			(TASK_STATE_MAX-1)
>  
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index b2fc2727d654..126fac835e5e 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -210,7 +210,8 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
>  		state = READ_ONCE(t->__state);
>  		if ((state & TASK_UNINTERRUPTIBLE) &&
>  		    !(state & TASK_WAKEKILL) &&
> -		    !(state & TASK_NOLOAD))
> +		    !(state & TASK_NOLOAD) &&
> +		    !(state & TASK_NOHUNG))
>  			check_hung_task(t, timeout);
>  	}
>   unlock:
> 



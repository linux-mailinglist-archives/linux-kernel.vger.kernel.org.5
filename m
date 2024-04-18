Return-Path: <linux-kernel+bounces-150621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D67D28AA1EF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13F561C21D60
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62A817A92F;
	Thu, 18 Apr 2024 18:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gmqkB/lc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A739C17556A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 18:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713464400; cv=none; b=F2v+25zdO9y3PryDHTlUHSYRX/7qWJzebNgzRMXfF9B+P0a49zc/6/Yqmzz0y7fQpgmaLgxJ+6ovoDuo2c+/xxa1ZeBZvu9ZpvvlEAnPsURwMzj5UNkj3/ZvPEePMdnrB62p5HwpS7fSP/gZENNFG/go+shXBdFlCopl53TdBxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713464400; c=relaxed/simple;
	bh=uDiGBD3b/ptTslN9zzs0o9YP2Jarg3jFbnz2Zkfg5lI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ao6UZUunOqmTqsLAr7/+tzyWmn7SXkFHTxfdStpOlwcwFdKCM2mzjtVUTQzg2a1W46kXQLDtVe3YEdOpEUOork8kf+5+J4s7+O6/k8L85GWMpHGTDhs+KHMYUJt2Qm8yvVVaHoCFSfttQ7PmMBatYcQESh9A/BIZIFGlPGgHXuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gmqkB/lc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713464397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7bGpszhjUBX0UUgReJHKY9vE6tbU/VdskiELgRAjXdU=;
	b=gmqkB/lccK8MP/gmhh/4F3FX+aC9zovmqmae7YGpE7+g6/04/XiLjHGKMif14UBJCppGaz
	KOVfbr+Pa+ADFDB1P0wR5dn9VnEDGe6BrNS9o3Y0DhE9olG+E9w3Aa+pdvDVhL2EGnJwdY
	ZvTNkotYPm6hu7P5yxGbXoCvQ806XO0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-YrT2-4BQNOSnkf2j2ku4Ew-1; Thu,
 18 Apr 2024 14:19:52 -0400
X-MC-Unique: YrT2-4BQNOSnkf2j2ku4Ew-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CF0781C0512A;
	Thu, 18 Apr 2024 18:19:51 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.182])
	by smtp.corp.redhat.com (Postfix) with SMTP id 162021C060D0;
	Thu, 18 Apr 2024 18:19:47 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 18 Apr 2024 20:18:26 +0200 (CEST)
Date: Thu, 18 Apr 2024 20:18:21 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [patch V2 26/50] signal: Get rid of resched_timer logic
Message-ID: <20240418181821.GA26239@redhat.com>
References: <20240410164558.316665885@linutronix.de>
 <20240410165552.572304080@linutronix.de>
 <20240418163811.GA23440@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418163811.GA23440@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 04/18, Oleg Nesterov wrote:
>
> On 04/11, Thomas Gleixner wrote:
> >
> > There is no reason for handing the *resched pointer argument through
> > several functions just to check whether the signal is related to a self
> > rearming posix timer.
>
> Agreed, these changes looks good to me.

I meant the intent.

But this is not simple, collect_signal() checks SIGQUEUE_PREALLOC exactly
because (iiuc) we need to ensure that SI_TIMER didn't come from userspace.

perhaps we should disallow SI_TIMER with _sys_private != 0 from userspace,
I dunno...

And I don't really understand the "not to be passed to user" comment in
include/uapi/asm-generic/siginfo.h. copy_siginfo_to_user() just copies
the whole kernel_siginfo.

Confused.

> But,
> 
> > SI_TIMER is only used by the posix timer code and cannot be queued from
> > user space.
> 
> Why? I think sigqueueinfo() can certainly use si_code = SI_TIMER, so
> 
> > @@ -1011,6 +1001,9 @@ static int __send_signal_locked(int sig,
> >  
> >  	lockdep_assert_held(&t->sighand->siglock);
> >  
> > +	if (WARN_ON_ONCE(!is_si_special(info) && info->si_code == SI_TIMER))
> > +		return 0;
> 
> this can be easily triggered by userspace and thus looks wrong.
> 
> Oleg.



Return-Path: <linux-kernel+bounces-151352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDE48AAD51
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AFDB1C210E3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EE18005E;
	Fri, 19 Apr 2024 11:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P26DPXzM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718C6537FC
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 11:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713524887; cv=none; b=SKFzlgYDlnEyX/nbYcz863hnR/X6QGgUy+VMNtTvwN3LPfuxmOuhwsxKuyUX6b5EbzIxq/Dvy6+W7tz96afRNXAkCxOqUn6k75ZKfVJqjcIuwHjDtHIhvaE7lEQGkWAmnSOKUabi/rXrZz/VRNZHzK+oC1cKtKy1/4HMi04Hurs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713524887; c=relaxed/simple;
	bh=MnqdrpaGNSd52dE5XqkCFGUmfpXHMoqJ9jyRmyjAfdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9nzA5e48oV15jhl+jWIWilpEfyp0K2bv5AC9h8T+zJg73njy+1KUPpiJzU0YDOdLyoFFTY3yy04Fj1b2KydDSDWK278qJv5Trzh23P9raUtHA6sL4oQrFQFq1AQ/FU2zA3LqUwDdkKHcuatZEaEhWcWaxP3kWJ/cv94s1T6uQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P26DPXzM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713524884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AqgUdncdJ6Ey3LItq0FX5Kgv1YEnpg3rmJdx0umscNk=;
	b=P26DPXzMFPMPrXr3FfQBJGqRzvULWmismidIe88Gabg/yT3YG22CCnWceuEpnsVVdBm1vM
	rBHXXKPFDyQxAIZci3EBZB67X4fwj7SHDp8py34KcnyueUmXAZNTdFQQwPY96Llb4NiSfb
	TJxWXuUuD3YyQ/QVKT/BVTtD8I3H93A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-f2pDIKJSNUmhatKUsHYYCQ-1; Fri, 19 Apr 2024 07:08:00 -0400
X-MC-Unique: f2pDIKJSNUmhatKUsHYYCQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 540FD80021A;
	Fri, 19 Apr 2024 11:08:00 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.44])
	by smtp.corp.redhat.com (Postfix) with SMTP id 126AA1C060D1;
	Fri, 19 Apr 2024 11:07:57 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 19 Apr 2024 13:06:35 +0200 (CEST)
Date: Fri, 19 Apr 2024 13:06:32 +0200
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
Message-ID: <20240419110632.GA3198@redhat.com>
References: <20240410164558.316665885@linutronix.de>
 <20240410165552.572304080@linutronix.de>
 <20240418163811.GA23440@redhat.com>
 <20240418181821.GA26239@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418181821.GA26239@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 04/18, Oleg Nesterov wrote:
>
> On 04/18, Oleg Nesterov wrote:
> >
> > On 04/11, Thomas Gleixner wrote:
> > >
> > > There is no reason for handing the *resched pointer argument through
> > > several functions just to check whether the signal is related to a self
> > > rearming posix timer.
> >
> > Agreed, these changes looks good to me.
>
> I meant the intent.
>
> But this is not simple, collect_signal() checks SIGQUEUE_PREALLOC exactly
> because (iiuc) we need to ensure that SI_TIMER didn't come from userspace.
>
> perhaps we should disallow SI_TIMER with _sys_private != 0 from userspace,
> I dunno...
>
> And I don't really understand the "not to be passed to user" comment in
> include/uapi/asm-generic/siginfo.h. copy_siginfo_to_user() just copies
> the whole kernel_siginfo.

OK, si_sys_private is cleared in dequeue_signal() (or in posixtimer_rearm()
with this series).

In the past SI_TIMER was defined as __SI_CODE(__SI_TIMER,-2), it was > 0,
so it could not come from userspace (see the info->si_code >= 0 check in
do_rt_sigqueueinfo).

Today SI_TIMER < 0. We could introduce SI_TIMER_KERNEL > 0 with the minimal
changes, but this can't help because the commit 66dd34ad31e59 allows to send
any siginfo to itself.

Otoh, I have no idea how CRIU restores the posix timers. If a process has
a pending blocked SI_TIMER signal, then I guess it actually needs to enqueue
this signal at restore time, but resched_timer will be never true?

I got lost... Sorry for the noise.

> Confused.
>
> > But,
> >
> > > SI_TIMER is only used by the posix timer code and cannot be queued from
> > > user space.
> >
> > Why? I think sigqueueinfo() can certainly use si_code = SI_TIMER, so
> >
> > > @@ -1011,6 +1001,9 @@ static int __send_signal_locked(int sig,
> > >
> > >  	lockdep_assert_held(&t->sighand->siglock);
> > >
> > > +	if (WARN_ON_ONCE(!is_si_special(info) && info->si_code == SI_TIMER))
> > > +		return 0;
> >
> > this can be easily triggered by userspace and thus looks wrong.
> >
> > Oleg.



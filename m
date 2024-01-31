Return-Path: <linux-kernel+bounces-46539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 037B6844116
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 970041F2DAA4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABCD82860;
	Wed, 31 Jan 2024 13:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IQ/r2fAj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1945581ADE
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 13:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706709235; cv=none; b=DOngc6gdQrIJQB/Pug+TS/1nVECG886onGOzcYUDeZTUrGflEzIr3k8D7Vm4uWQc806samBeQ8P3kl5YkxLXK+hFFrKZKrTvn9F63Rdx8ogmnx0mIH9hq8Z5uMqhUXzH8XEDHO1NvOzC3X5AOahuMmA3u0fxdDVgmMPYkGKrXbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706709235; c=relaxed/simple;
	bh=uakhvgKxjPNFgke93mN0JdxLjWrSFUxLbgu+RZRmEiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFBxgyxDt0MLdVIb1i27WCVslzKU0ad8f5VV7JMqw+axI2f/sxkMfo0kjItdXpJ//e7m2LXTbmbYYEFaL4Wac5/+PaOqnTpH+KVfbCVE6EafAmBLoaBA+5GE9nrGF2VNdVLe1SYhQ5NgDY71VxMsYm8eUkLvN7p4RBUDHqV8nuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IQ/r2fAj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706709233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E4i0Tk4JbtiIv1UU4oy6keRyKO0PtP4NeohxR4ZpA+c=;
	b=IQ/r2fAjl+P61E93C3G/3QGAtPH1pznmy6HydfOvkCoCwmGrzPT2S+L/wQsL3fjgG6N8/L
	TNfV4uk8mbVsq57fDqQ+lfjDw0L0zng7JX6r/tgWrcYmTJbViVjB5D8Wxif3yQfrMKqaif
	oHU1Ri4wplmiYNObmacCAUMOWH8rfsA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-_-stHLIRM3mmrNXR4w-Rug-1; Wed, 31 Jan 2024 08:53:49 -0500
X-MC-Unique: _-stHLIRM3mmrNXR4w-Rug-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 23E71848A69;
	Wed, 31 Jan 2024 13:53:49 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.249])
	by smtp.corp.redhat.com (Postfix) with SMTP id DF2FA2166B31;
	Wed, 31 Jan 2024 13:53:47 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 31 Jan 2024 14:52:34 +0100 (CET)
Date: Wed, 31 Jan 2024 14:52:32 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Christian Brauner <brauner@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pidfd: implement PIDFD_THREAD flag for pidfd_open()
Message-ID: <20240131135232.GA2609@redhat.com>
References: <20240130112638.GA29773@redhat.com>
 <20240130113409.GA29849@redhat.com>
 <ZbmwJiIS4ei64u6R@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbmwJiIS4ei64u6R@tycho.pizza>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On 01/30, Tycho Andersen wrote:
>
> On Tue, Jan 30, 2024 at 12:34:09PM +0100, Oleg Nesterov wrote:
> > Damn. Self-NACK.
> >
> > I forgot (we all ;) about mt-exec, and there are 2 problems.
> >
> > 1. The "if (!thread_group_leader(tsk))" block in de_thread() needs
> >    do_notify_pidfd() too, the execing non-leader thread looses its
> >    old pid, pidfd_poll(PIDFD_THREAD, pid-of-execing-sub-thread)
> >    should succeed. Must be fixed, I think.
>
> I think the `test_non_tgl_exec` from my tests exercises the scenario
> you're describing, and it works.

This means your test is racy, I guess.

Look. We have a leader L, its sub-thtread T with the pid TPID, and
another process X which sleeps in pidfd_poll(PIDFD_THREAD, TPID).

T starts de_thread and kills the leader L. The leader exits and wakes
X up.

Then T does de_thread() -> exchange_tids() so we have

	// BEFORE:
	// pid_task(TPID, PIDTYPE_PID) == T
	exchange_tids(tsk, leader);
	// AFTER:
	// pid_task(TPID, PIDTYPE_PID) == L

Now. If X calls pidfd_task_exited(TPID, true) "AFTER" then we are
fine, pidfd_task_exited() will return true. OK, this is not exactly
true, leader->exit_state == 0 right after exchange_tids(), but lets
ignore.

However. If X calls pidfd_task_exited(TPID, true) "BEFORE" it will
return false: pid_task(TPID) == T and T is not going to die. So
pidfd_poll() will block again forever, TPID is going to die.

See?

Fixed in v3.

> > 2. pidfd_poll(PIDFD_THREAD, pid-of-group-leader) should not succeed
> >    when its sub-thread execs, the execing thread inherits the leader's
> >    pid. Perhaps pidfd_task_exited() can check sig->group_exec_task,
>
> I didn't have an explicit test for this, but I hacked one up, and
> pidfd_poll(PIDFD_THREAD, pid-of-group-leader) doesn't return after
> exec.

See above, this depends on timing.

See also v3 I've sent, I tried to document the problems with mt-exec.

Oleg.



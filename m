Return-Path: <linux-kernel+bounces-102202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F43287AF62
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDAEB286753
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D57283BA2;
	Wed, 13 Mar 2024 17:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eoa/I07o"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4585C1509E7
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 17:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349496; cv=none; b=WU+NzdN7C74XyMPE5qW9twndgi4Xp81ru3HTaK4HnlvOhPW0FU21ETo6XQHtQs5BVeCDnwDKFprWHCwqpTnJzIH1BPXV2+YCLaqDuk1wzHa1Rj4EzQupQepEkrA+j1bnnhzfyqHnITGcvDXUPOlGP0j2Ek/cAbNCuUIn7p5pXZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349496; c=relaxed/simple;
	bh=NVVCPsRTH9aJFP5INYUA1mg6ri8jiYYeK/20kRzivhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJD1i2f3dOywnh/FHjyEcbzL3sPitWXbaLtgMQ2QADooLPy6OZvtorDajCvNEyHWI4YMamG3qyQhc2VobJaw1IbTKLYh0dWHKEWBbjNZk6Our0q5xw8fuooqJtRBAgMS/NTKfW1228MI7c9GYj2AyxDfjQqbpTHyCMO/4d7YyTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eoa/I07o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710349492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Xbn72BYWl9q5M69bjzFR6tOEN9CO/5oxYSGxU1c8D8=;
	b=eoa/I07ouZIHn+PEuEjZ9w3yw9tvuNHo63pze0T1mocf7QGixRihYt61EO1or/obE3n6WN
	woLh8xUXuHQTi7O4Gm3M1EeiwlONbrICxA4wF5NhXRS5qFe/Cuo3rVUofeRBjbp99EN6s+
	jDAl1rSfbPTzeRYiO5KoTY4X0Qdbv78=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-Vgj_NRLtPQiJww3MCVkOQQ-1; Wed,
 13 Mar 2024 13:04:49 -0400
X-MC-Unique: Vgj_NRLtPQiJww3MCVkOQQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7D8111C07F3A;
	Wed, 13 Mar 2024 17:04:48 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.233])
	by smtp.corp.redhat.com (Postfix) with SMTP id CF26F3C21;
	Wed, 13 Mar 2024 17:04:46 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 13 Mar 2024 18:03:27 +0100 (CET)
Date: Wed, 13 Mar 2024 18:03:24 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Dylan Hatch <dylanbhatch@google.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 5.10 65/73] exit: wait_task_zombie: kill the no longer
 necessary spin_lock_irq(siglock)
Message-ID: <20240313170324.GC25452@redhat.com>
References: <20240313164640.616049-1-sashal@kernel.org>
 <20240313164640.616049-66-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313164640.616049-66-sashal@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

I do not know what does 5.10 mean. Does this tree has all the changes
this patch depends on? Say, 1df4bd83cdfdbd0720dd ("do_io_accounting:
use sig->stats_lock") ?

In any case please remove this patch from all your queues, it got the
"stable" tag by mistake.

Oleg.

On 03/13, Sasha Levin wrote:
>
> From: Oleg Nesterov <oleg@redhat.com>
> 
> [ Upstream commit c1be35a16b2f1fe21f4f26f9de030ad6eaaf6a25 ]
> 
> After the recent changes nobody use siglock to read the values protected
> by stats_lock, we can kill spin_lock_irq(&current->sighand->siglock) and
> update the comment.
> 
> With this patch only __exit_signal() and thread_group_start_cputime() take
> stats_lock under siglock.
> 
> Link: https://lkml.kernel.org/r/20240123153359.GA21866@redhat.com
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Dylan Hatch <dylanbhatch@google.com>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  kernel/exit.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/exit.c b/kernel/exit.c
> index c41bdc0a7f06b..8f25abdd5fa7d 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -1106,17 +1106,14 @@ static int wait_task_zombie(struct wait_opts *wo, struct task_struct *p)
>  		 * and nobody can change them.
>  		 *
>  		 * psig->stats_lock also protects us from our sub-threads
> -		 * which can reap other children at the same time. Until
> -		 * we change k_getrusage()-like users to rely on this lock
> -		 * we have to take ->siglock as well.
> +		 * which can reap other children at the same time.
>  		 *
>  		 * We use thread_group_cputime_adjusted() to get times for
>  		 * the thread group, which consolidates times for all threads
>  		 * in the group including the group leader.
>  		 */
>  		thread_group_cputime_adjusted(p, &tgutime, &tgstime);
> -		spin_lock_irq(&current->sighand->siglock);
> -		write_seqlock(&psig->stats_lock);
> +		write_seqlock_irq(&psig->stats_lock);
>  		psig->cutime += tgutime + sig->cutime;
>  		psig->cstime += tgstime + sig->cstime;
>  		psig->cgtime += task_gtime(p) + sig->gtime + sig->cgtime;
> @@ -1139,8 +1136,7 @@ static int wait_task_zombie(struct wait_opts *wo, struct task_struct *p)
>  			psig->cmaxrss = maxrss;
>  		task_io_accounting_add(&psig->ioac, &p->ioac);
>  		task_io_accounting_add(&psig->ioac, &sig->ioac);
> -		write_sequnlock(&psig->stats_lock);
> -		spin_unlock_irq(&current->sighand->siglock);
> +		write_sequnlock_irq(&psig->stats_lock);
>  	}
>  
>  	if (wo->wo_rusage)
> -- 
> 2.43.0
> 



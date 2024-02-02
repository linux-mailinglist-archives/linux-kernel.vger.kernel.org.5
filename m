Return-Path: <linux-kernel+bounces-50463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED5F847944
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 659411C28A70
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF6183A00;
	Fri,  2 Feb 2024 19:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bUHA2sRB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EE5839E2
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 19:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706900820; cv=none; b=Ta293O3BBYK4SP1B10axPGTKLqrjN/yzaNbcxTcksoJoItGAtAAUwLu/qr+0dBi000OmrZjdjOYPnneWuRSLPOBmt+vuIWfP7aTAKRWDLWTnIzUbNSZzpVerv41JaMnIRI6P4R4M/Vm0ALbJ53YDHDuwnZ3F0ZM2zn6tcVcSK1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706900820; c=relaxed/simple;
	bh=dwvDik9e8en0dQjzXY4W2z8vsp3fk80/NMt6Sj0VM9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPokr0ynMKB2/e4RZ9WvA6mu7S8+YbhbMP0zXppOkLeDuNOTZ7pgQTOTe9c/R1wX2NHGUdqRVffqMAWuJMwcHni1ZCFxDs82arNclg6aCOC0yuFUO+L/ShHkWb8YIBmd0bxBlCQOjAm5ZgLEIWeBnIZkR0rwwcHdwzXcpHJTYx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bUHA2sRB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706900816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9RvkmEU5gtVAa6D4MSMfcWS5vVfixTS9eCiHPt3AK1c=;
	b=bUHA2sRBDqJw6N2ztlTF9VbtkRNiRThmobuchfkSOaNBGlJWe9JRrbisBm4XdZdeetG9ES
	F8OyC2RiAi36X9yK+Gf97IR3OM3hToHkLdwbj9xcVmwDxRloFUcSKGe11JVPvpuU1JyHFp
	MQLIwZ2uq6IXioP+ilWh/uGG/HV79fc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-KU3gxnRRN8aZHQDimBDisQ-1; Fri, 02 Feb 2024 14:06:52 -0500
X-MC-Unique: KU3gxnRRN8aZHQDimBDisQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 76A0585A58A;
	Fri,  2 Feb 2024 19:06:51 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.76])
	by smtp.corp.redhat.com (Postfix) with SMTP id 98102C154AB;
	Fri,  2 Feb 2024 19:06:49 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  2 Feb 2024 20:05:36 +0100 (CET)
Date: Fri, 2 Feb 2024 20:05:29 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] pidfd_poll: report POLLHUP when pid_task() == NULL
Message-ID: <20240202190529.GA28818@redhat.com>
References: <20240202131147.GA25988@redhat.com>
 <20240202131226.GA26018@redhat.com>
 <20240202-arbeit-fruchtig-26880564a21a@brauner>
 <20240202160704.GA5850@redhat.com>
 <20240202-lackmantel-vervielfachen-4c0f0374219b@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202-lackmantel-vervielfachen-4c0f0374219b@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On 02/02, Christian Brauner wrote:
>
> > I think we need a simpler patch. I was going to send it as 4/4, but I'd
> > like to think more, _perhaps_ we can also discriminate the PIDFD_THREAD
> > and non-PIDFD_THREAD waiters. I'll try to make the patch(es) tomorrow or
>
> Right, I didn't go that far.
>
> > at least provided more info.
> >
> > 3 notes for now:
> >
> > 	1. we can't use wake_up_poll(), it passes nr_exclusive => 1
>
> Bah. So we need the same stuff we did for io_uring and use
> __wake_up() directly. Or we add wake_up_all_poll() and convert the other
> three callsites:

..

> +#define wake_up_all_poll(x, m)                                                 \
> +       __wake_up(x, TASK_NORMAL, 0, poll_to_key(m))

Agreed, but I think this + s/wake_up/wake_up_all_poll/ conversions
need a separate patch.


> -void do_notify_pidfd(struct task_struct *task)
> +void pidfd_wake_up_poll(struct task_struct *task, bool dead)
>  {
> -	struct pid *pid;
> -
>  	WARN_ON(task->exit_state == 0);
> -	pid = task_pid(task);
> -	wake_up_all(&pid->wait_pidfd);
> +	WARN_ON(mask == 0);
> +	wake_up_all_poll(&task_pid(task)->wait_pidfd,
> +			 EPOLLIN | EPOLLRDNORM | dead ? EPOLLHUP : 0);

No...

This is still overcomplicated and is not right.

Christian, I'll write another email tomorrow.

Oleg.



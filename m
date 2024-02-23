Return-Path: <linux-kernel+bounces-78474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7848613E0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2533228587E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39559823BC;
	Fri, 23 Feb 2024 14:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RYdYDfGa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EC77FBC5
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 14:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708698056; cv=none; b=MxGxaDnOeSQg/wgdcQHTRQU11aeXPldMjvnWWjslwxKw1iDQc+DnxIbAt9ALStcp8sExwVo7JVZjFFVm5BF/PPFuZmbm845SwzghnggkHbIyyB+OvjGTzBC+o8xPWuQu0m6whRe7ILdroTTqVpVz0v0tj6/fVvqxYpEP1UKa+C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708698056; c=relaxed/simple;
	bh=+6blh3ObSk8BzEikRhDsLFdk6ABGGUYdecjw26QmFUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WqiFvWwcdm8LwDyQ0X8tFdYEn0i2g0SD5Mypeee1En4JIqrK5mZ8MUTAMj8E4Eit/w/aSj+J0bG0yCVdAYpNR78BFfaCuqH4+1/YNvBfG+Lyn+gjS3X0g648CGt32K0RhyHnvSLK8tdIvpq2nfuwSd2SulhpyykF/GMKbM1RKNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RYdYDfGa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708698053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ydf+iTJAXdXXlA+IiHEHl6RCvHrcIFVq74RkfxuTk8c=;
	b=RYdYDfGa/QDE6SsL0Y7oU17WlTqg16sB0bCXbX/7pkin1sq5BmLedmcU/+Q6A6PtZb07+4
	dYMGTaQNGrxhDqj48TsZIZzPWkRjI6cwruRzjvY7fiQEs1yI+UmRs2lzzGJ8vfd/sJD87C
	g07nnJnT2vEXb5Pzu7jQ7FGoSrWBeRk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-GqsIheNqPgaDGIRgik4bQg-1; Fri, 23 Feb 2024 09:20:50 -0500
X-MC-Unique: GqsIheNqPgaDGIRgik4bQg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6AA13845DC3;
	Fri, 23 Feb 2024 14:20:49 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.151])
	by smtp.corp.redhat.com (Postfix) with SMTP id 263CA200B251;
	Fri, 23 Feb 2024 14:20:47 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 23 Feb 2024 15:19:30 +0100 (CET)
Date: Fri, 23 Feb 2024 15:19:29 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Wen Yang <wenyang.linux@foxmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] get_signal: simplify/cleanup the the usage of ksig->info
Message-ID: <20240223141928.GB8267@redhat.com>
References: <20240223105025.GA4542@redhat.com>
 <tencent_7C50F304C14CB2A5133317F8A13D1F544D0A@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_7C50F304C14CB2A5133317F8A13D1F544D0A@qq.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On 02/23, Wen Yang wrote:
>
>
> On 2024/2/23 18:50, Oleg Nesterov wrote:
> >get_signal() uses signr or ksig->info.si_signo in a chaotic way, this
> >looks confusing. Change it to always use signr.
> >
> >This allows us to simplify the SIGNAL_GROUP_EXIT/group_exec_task branch,
> >it no longer needs to touch ksig at all.
> >
> >Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> >---
> >  kernel/signal.c | 15 +++++++++------
> >  1 file changed, 9 insertions(+), 6 deletions(-)
> >
> >diff --git a/kernel/signal.c b/kernel/signal.c
> >index c9c57d053ce4..690982e6595e 100644
> >--- a/kernel/signal.c
> >+++ b/kernel/signal.c
> >@@ -2727,12 +2727,15 @@ bool get_signal(struct ksignal *ksig)
> >  		/* Has this task already been marked for death? */
> >  		if ((signal->flags & SIGNAL_GROUP_EXIT) ||
> >  		     signal->group_exec_task) {
> >-			clear_siginfo(&ksig->info);
> >-			ksig->info.si_signo = signr = SIGKILL;
> >+			signr = SIGKILL;
> >  			sigdelset(&current->pending.signal, SIGKILL);
> >  			trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO,
> >-				&sighand->action[SIGKILL - 1]);
> >+					     &sighand->action[SIGKILL - 1]);
> >  			recalc_sigpending();
> >+			/*
> >+			 * implies do_group_exit(), no need to initialize
> >+			 * ksig->info
> >+			 */
> >  			goto fatal;
>
> There is little question:
> If the this conditions is met:
>    current->flags & PF_USER_WORKER
> It may execute “goto out“ instead of do_group_exit().

Yes, but vhost/io workers do not use ksig at all.

Oleg.



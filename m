Return-Path: <linux-kernel+bounces-78073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE85860E9B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93FDE1F232D4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB5E5CDF4;
	Fri, 23 Feb 2024 09:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VhY3Pvtk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC89B5C912
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708681669; cv=none; b=o2n8IezWORaqc/t0kGybih8+4aPDL44qbFen4YzDxQKyRTFNkBKb3qvGNqaph7juu73uGuj2Pc4Gk9UC8K8vMCj6zdAnhUCwFwG1KnYpzf6/o+GEAhSobXzbTa9liErigqnqkixcB12WbIh6ANYUolAazOkYyC4aSPuv5jydehk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708681669; c=relaxed/simple;
	bh=Lp1mhiHVT598EFwhxi9naZDlUAJ7pCCeTz8RW/4n82o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNutJzOXc4mDS/nop/66of45EQ4xZAFf2w1945nSCI63yxGKf0K7jHqGOkkWggS3JVLkHdAKMa+jvJOtPNgsmyInnHswwgQdLeiOQZiDyKRKI1DW9NineA5ZNAsOEDpTZMDukguAtQOysWJm1NivpNIK5i9p3WSot9RHqwbZBMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VhY3Pvtk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708681666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mZ+T6hgohzDKZmregENWnrw75IZiMmG3BeEJe4k3v1A=;
	b=VhY3PvtkPIwCYeIqXhxqJ2w8ixLastfVM/sRGV3JSpaaD7M1WtHpFJIbXsDoT4RxjP8F0C
	2QM8v4ZAqZQNB96BHvZOFwiQhVGghf/rLNez6WhoCx0ObmfjHdQGRAfKkAXDPDYP/38wbm
	XTb9JX/7IJYDWes/lgD/56X3ed5TOW8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-pmmFTt19MPWTk7Lcd7TNVg-1; Fri,
 23 Feb 2024 04:47:43 -0500
X-MC-Unique: pmmFTt19MPWTk7Lcd7TNVg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CC19B29AA39C;
	Fri, 23 Feb 2024 09:47:42 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.151])
	by smtp.corp.redhat.com (Postfix) with SMTP id 424D724E4;
	Fri, 23 Feb 2024 09:47:39 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 23 Feb 2024 10:46:24 +0100 (CET)
Date: Fri, 23 Feb 2024 10:46:20 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Wen Yang <wenyang.linux@foxmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mike Christie <michael.christie@oracle.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] kernel/signal.c: explicitly initialize si_code and
 use ksig->info uniformly
Message-ID: <20240223094620.GA8267@redhat.com>
References: <tencent_195B55A5521705954D5EA4873327F8E53D0A@qq.com>
 <20240222190546.GA5993@redhat.com>
 <tencent_3867DFAA296AACA094C9E8F413E6493FF407@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_3867DFAA296AACA094C9E8F413E6493FF407@qq.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 02/23, Wen Yang wrote:
>
> On 2024/2/23 03:05, Oleg Nesterov wrote:
> >On 02/23, wenyang.linux@foxmail.com wrote:
> >>
> >>From: Wen Yang <wenyang.linux@foxmail.com>
> >>
> >>By explicitly initializing ksig->info.si_code and uniformly using ksig->info,
> >>get_signal() function could be slightly optimized, as folowes:
> >
> >I don't understand. Why do you think it will be optimized? in what sense?
> >
> >>	clear_siginfo(&ksig->info);
> >>	ksig->info.si_signo = signr = SIGKILL;          --> missed si_code
> >
> >because we do not need to set .si_code in this case?
> >
> >>	sigdelset(&current->pending.signal, SIGKILL);
> >>	trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO,  --> unnecessary SEND_SIG_NOINFO
> >
> >Why do you think the usage of SEND_SIG_NOINFO is "unnecessary" or bad?
> >To me this looks good.
> >
>
> Since it is called "SEND_SIG_NOINFO", but here it is neither SEND_SIG
> nor NOINFO.

I don't really understand what does this mean. But I can say that
SEND_SIG_NOINFO is exactly what we should use, this signal has no
info.

In fact, SIGKILL can never have the info, see the sig == SIGKILL
check in __send_signal_locked() but this is offtopic.

> It is get_signal() here, and ksig->info has also been partially
> initialized before calling trace_signal_deliver(). Below "goto fatal",
> do_coredump() also use the initialized ksig->info.

IIRC, do_coredump() paths use only siginfo->si_signo, but this doesn't
matter.

do_coredump() can't be called, sig_kernel_coredump(SIGKILL) is false.

> >and it seems that we can simply kill clear_siginfo(), but this is
> >another story.
>
> This is not right.
>
> ksig->info will be passed to user space through do_coredump(), and the
> clear_siginfo() cannot be killed.

See above.

Oleg.


